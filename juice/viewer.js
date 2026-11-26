// One indexed mesh, exported in world space from Blender. The last three
// ranges contain the evaluated grate and inlet geometry at each legal station.
export async function openViewport(canvas, onView) {
  const gl = canvas.getContext('webgl', {antialias: true, alpha: false});
  if (!gl) throw new Error('WebGL is unavailable.');
  const [description, bytes] = await Promise.all([
    fetch('./assets/scene.json').then(r => { if (!r.ok) throw Error('Scene metadata failed to load.'); return r.json(); }),
    fetch('./assets/tideway.mesh').then(r => { if (!r.ok) throw Error('Geometry failed to load.'); return r.arrayBuffer(); })
  ]);
  if (description.format !== 1 || description.stride !== 12 ||
      (description.indexBytes === 4 && !gl.getExtension('OES_element_index_uint'))) {
    throw Error('This device cannot draw the exported mesh.');
  }
  const vertex = `attribute vec3 pos, normal, color;
    uniform vec3 eye, right, up, back; uniform float aspect, scale;
    varying vec3 tint; varying float dist;
    void main() {
      vec3 p=pos/scale; vec3 d=p-eye;
      float z=-dot(d,back); dist=z;
      gl_Position=vec4(dot(d,right)*2.65/aspect,dot(d,up)*2.65,z*1.0004-0.04001,z);
      float sky=0.66+0.18*normal.z;
      float sun=0.34*max(0.0,dot(normal,normalize(vec3(-0.50,-0.62,0.75))));
      tint=color*(sky+sun)+vec3(0.016,0.020,0.020);
    }`;
  const fragment = `precision mediump float; varying vec3 tint; varying float dist;
    void main(){float haze=smoothstep(15.0,85.0,dist)*0.62;
      gl_FragColor=vec4(mix(tint,vec3(0.76,0.83,0.83),haze),1.0);}`;
  const program = gl.createProgram();
  for (const [type, source] of [[gl.VERTEX_SHADER,vertex],[gl.FRAGMENT_SHADER,fragment]]) {
    const s=gl.createShader(type); gl.shaderSource(s,source); gl.compileShader(s);
    if (!gl.getShaderParameter(s,gl.COMPILE_STATUS)) throw Error('The viewport shader could not start.');
    gl.attachShader(program,s);
  }
  gl.linkProgram(program);
  if (!gl.getProgramParameter(program,gl.LINK_STATUS)) throw Error('The viewport could not start.');
  gl.useProgram(program);
  function buffer(target, data) {
    const b=gl.createBuffer(); gl.bindBuffer(target,b); gl.bufferData(target,data,gl.STATIC_DRAW);
  }
  buffer(gl.ARRAY_BUFFER,new Uint8Array(bytes,0,description.vertexBytes));
  buffer(gl.ELEMENT_ARRAY_BUFFER,new Uint8Array(bytes,description.vertexBytes));
  for (const [name,type,normalized,offset] of [['pos',gl.SHORT,false,0],['normal',gl.BYTE,true,6],['color',gl.UNSIGNED_BYTE,true,9]]) {
    const loc=gl.getAttribLocation(program,name); gl.enableVertexAttribArray(loc);
    gl.vertexAttribPointer(loc,3,type,normalized,12,offset);
  }
  const u=Object.fromEntries(['eye','right','up','back','aspect','scale'].map(n=>[n,gl.getUniformLocation(program,n)]));
  gl.uniform1f(u.scale,description.scale);
  gl.enable(gl.DEPTH_TEST);
  gl.clearColor(.76,.83,.83,1);
  let focus, yaw, pitch, radius, target, station=50, drag=null;
  function render() {
    const w=Math.max(1,Math.round(canvas.clientWidth*Math.min(devicePixelRatio,2)));
    const h=Math.max(1,Math.round(canvas.clientHeight*Math.min(devicePixelRatio,2)));
    if (canvas.width!==w || canvas.height!==h) { canvas.width=w; canvas.height=h; }
    gl.viewport(0,0,w,h); gl.clear(gl.COLOR_BUFFER_BIT|gl.DEPTH_BUFFER_BIT);
    const cx=Math.cos(yaw),sy=Math.sin(yaw),cp=Math.cos(pitch),sp=Math.sin(pitch);
    const back=[cx*cp,sy*cp,sp];
    gl.uniform3fv(u.back,back); gl.uniform3fv(u.right,[-sy,cx,0]); gl.uniform3fv(u.up,[-cx*sp,-sy*sp,cp]);
    gl.uniform3fv(u.eye,target.map((t,i)=>t+radius*back[i])); gl.uniform1f(u.aspect,w/h);
    for(const [start,length] of [description.draws.street,description.draws[String(station)]]) {
      gl.drawElements(gl.TRIANGLES,length,description.indexBytes===2?gl.UNSIGNED_SHORT:gl.UNSIGNED_INT,start*description.indexBytes);
    }
  }
  function preset(view) {
    focus=view;
    if (view==='street') { yaw=-.99; pitch=.30; radius=20; target=[-.55,2.3,1.95]; }
    else { yaw=-1.81; pitch=.72; radius=3.7; target=[.62,.12,.12]; }
    onView(view);render();
  }
  function zoom(factor){ radius=Math.max(1.1,Math.min(50,radius*factor));render(); }
  canvas.addEventListener('pointerdown',e=>{if(e.button!==0)return;drag=[e.clientX,e.clientY];canvas.setPointerCapture(e.pointerId);});
  canvas.addEventListener('pointermove',e=>{if(!drag)return;yaw-=(e.clientX-drag[0])*.007;pitch=Math.max(.08,Math.min(1.4,pitch+(e.clientY-drag[1])*.006));drag=[e.clientX,e.clientY];render();});
  for(const name of ['pointerup','pointercancel','lostpointercapture'])canvas.addEventListener(name,()=>drag=null);
  canvas.addEventListener('wheel',e=>{e.preventDefault();zoom(Math.exp(Math.sign(e.deltaY)*.12));},{passive:false});
  canvas.addEventListener('keydown',e=>{
    const keys={'ArrowLeft':[-.12,0],'ArrowRight':[.12,0],'ArrowUp':[0,.10],'ArrowDown':[0,-.10]};
    if(keys[e.key]){e.preventDefault();yaw+=keys[e.key][0];pitch=Math.max(.08,Math.min(1.4,pitch+keys[e.key][1]));render();}
    else if(e.key==='+'||e.key==='=')zoom(.85);else if(e.key==='-')zoom(1.18);
  });
  new ResizeObserver(render).observe(canvas);preset('street');
  return {preset,zoom,render,description,setStation(cm){station=cm; if(focus!=='grate')preset('grate');else render();}};
}
