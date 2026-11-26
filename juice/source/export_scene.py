"""Run in Blender on the native initial Tideway file to export a compact, material-colored mesh."""
import array
import hashlib
import json
from pathlib import Path
import struct
import sys

import bpy

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "blender"))
from steering_view import StreetView

destination = Path(sys.argv[sys.argv.index("--") + 1])
destination.mkdir(parents=True, exist_ok=True)
view = StreetView(bpy.context.scene)
scene = bpy.context.scene
geometry = [o for o in scene.objects if o.type in {"MESH", "FONT", "CURVE", "SURFACE"} and not o.hide_render]
moving = {view.drain, view.pavement, *view.drain.children_recursive}
vertices = bytearray()
lookup = {}
indices = []
draws = {}
scale = 512
record = struct.Struct("<3h3b3B")

def color(material):
    linear = material.diffuse_color[:3] if material else (0.5, 0.5, 0.5)
    return tuple(round(255 * (12.92 * c if c <= 0.0031308 else 1.055 * c ** (1 / 2.4) - 0.055)) for c in (max(0,min(1,x)) for x in linear))

def export(name, objects):
    start = len(indices)
    graph = bpy.context.evaluated_depsgraph_get()
    for obj in sorted(objects, key=lambda o:o.name):
        evaluated = obj.evaluated_get(graph)
        mesh = evaluated.to_mesh()
        try:
            mesh.calc_loop_triangles()
            matrix = evaluated.matrix_world
            normal_matrix = matrix.to_3x3().inverted_safe().transposed()
            positions = [tuple(round(c * scale) for c in matrix @ v.co) for v in mesh.vertices]
            colors = [color(s.material) for s in evaluated.material_slots]
            for tri in mesh.loop_triangles:
                rgb = colors[tri.material_index] if colors else color(None)
                for i in tri.vertices:
                    n = mesh.vertices[i].normal if tri.use_smooth else tri.normal
                    normal = (normal_matrix @ n).normalized()
                    key = record.pack(*positions[i], *(round(max(-1,min(1,c))*127) for c in normal), *rgb)
                    if key not in lookup:
                        lookup[key] = len(lookup)
                        vertices.extend(key)
                    indices.append(lookup[key])
        finally:
            evaluated.to_mesh_clear()
    draws[name] = [start, len(indices) - start]

export("street", [o for o in geometry if o not in moving])
for cm in (50, 72, 83):
    view.drain.location.x = cm / 100
    for i, edge in view.inlet:
        view.pavement.data.vertices[i].co.x = cm / 100 + edge
    view.pavement.data.update()
    bpy.context.view_layer.update()
    export(str(cm), moving)

small = len(lookup) <= 65536
ix = array.array("H" if small else "I", indices)
if sys.byteorder != "little":
    ix.byteswap()
raw = bytes(vertices) + ix.tobytes()
(destination / "tideway.mesh").write_bytes(raw)
manifest = dict(format=1, scale=scale, stride=record.size, vertexBytes=len(vertices), indexBytes=ix.itemsize,
                draws=draws, objects=len(scene.objects), displayObjects=len(geometry), vertices=len(lookup),
                triangles=(draws["street"][1]+draws["50"][1])//3, meshSha256=hashlib.sha256(raw).hexdigest(),
                movingObjects=sorted(obj.name for obj in moving),
                seedSha256=hashlib.sha256(Path(bpy.data.filepath).read_bytes()).hexdigest())
(destination / "scene.json").write_text(json.dumps(manifest,separators=(",",":"))+"\n")
print(json.dumps(manifest))
