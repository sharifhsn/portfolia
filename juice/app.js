import {openViewport} from './viewer.js';

const el = id => document.getElementById(id);
const stations = [...document.querySelectorAll('[data-cm]')];
const orders = [...document.querySelectorAll('[data-order]')];
let scene, view, editorAvailable=false, mode='edit', activeOrder=null, mediaURL=null, downloadJob=null;
const film=el('film');

function status(message){ el('status').textContent=message; }
function updateInspector(){
  const cm=scene.station_cm();
  el('station').textContent=cm;
  el('revision').textContent=scene.revision();
  for(const b of stations){
    const selected=Number(b.dataset.cm)===cm;
    b.setAttribute('aria-pressed',selected);
    b.disabled=selected;
  }
  el('undo').disabled=scene.undo_depth()===0;
}
function edit(cm){
  const before=scene.station_cm();
  if(!scene.move_grate(scene.revision(),cm))return;
  view.setStation(cm);updateInspector();status(`Moved the grate from ${before} to ${cm} cm.`);
}
function undo(){
  if(!editorAvailable || !scene.undo(scene.revision()))return;
  view.setStation(scene.station_cm());updateInspector();status(`Undid the move. Grate restored to ${scene.station_cm()} cm.`);
}
async function loadFilm(order){
  if(activeOrder===order && (downloadJob || mediaURL))return;
  downloadJob?.abort();
  const controller=new AbortController();downloadJob=controller;activeOrder=order;
  film.pause();film.removeAttribute('src');film.load();
  if(mediaURL){URL.revokeObjectURL(mediaURL);mediaURL=null;}
  film.poster='./assets/tideway.png';
  const url=`./assets/${order}.mp4`;
  el('download').href=url;
  el('captions').src=`./assets/${order}.vtt`;
  for(const b of orders)b.setAttribute('aria-pressed',b.dataset.order===order);
  status('Loading the native recording…');
  try{
    const response=await fetch(url,{signal:controller.signal});
    if(!response.ok)throw Error('Recording unavailable.');
    const bytes=await response.arrayBuffer();
    if(controller.signal.aborted)return;
    // A complete local Blob also supports accurate seeking on hosts that ignore HTTP ranges.
    mediaURL=URL.createObjectURL(new Blob([bytes],{type:'video/mp4'}));
    film.src=mediaURL;film.load();if(mode==='replay')status('Recording loaded. Play or scrub to a phase.');
  }catch(e){
    if(!controller.signal.aborted && mode==='replay')status('The recording could not load. Select the order to retry, or download the file.');
  }finally{
    if(downloadJob===controller)downloadJob=null;
  }
}
function selectMode(next){
  mode=next;
  const replay=next==='replay';
  el('editor').hidden=replay;el('inspector').hidden=replay;
  el('replay').hidden=!replay;el('replayPanel').hidden=!replay;
  el('editTab').setAttribute('aria-pressed',!replay);el('replayTab').setAttribute('aria-pressed',replay);
  el('mode').textContent=replay?'Recorded Blender session':'Browser simulation';
  if(replay){
    if(!activeOrder || (!mediaURL&&!downloadJob))loadFilm(activeOrder||'83-to-72');
    else status(mediaURL?'Recording loaded. Play or scrub to a phase.':'Loading the native recording…');
  }else{
    film.pause();view?.render();status('Drag to orbit · Scroll to zoom');
  }
}
stations.forEach(b=>b.addEventListener('click',()=>edit(Number(b.dataset.cm))));
orders.forEach(b=>b.addEventListener('click',()=>loadFilm(b.dataset.order)));
el('undo').addEventListener('click',undo);
el('editTab').addEventListener('click',()=>selectMode('edit'));
el('replayTab').addEventListener('click',()=>selectMode('replay'));
for(const id of ['street','grate'])el(id).addEventListener('click',()=>view?.preset(id));
el('zoomIn').addEventListener('click',()=>view?.zoom(.8));el('zoomOut').addEventListener('click',()=>view?.zoom(1.25));
document.addEventListener('keydown',e=>{
  if(mode==='edit' && (e.ctrlKey||e.metaKey) && !e.shiftKey && e.key.toLowerCase()==='z'){
    e.preventDefault();undo();
  }
});
film.addEventListener('error',()=>{if(mode==='replay' && mediaURL)status('This browser could not decode the recording. The MP4 download is available.');});
window.addEventListener('pagehide',e=>{if(!e.persisted){downloadJob?.abort();if(mediaURL)URL.revokeObjectURL(mediaURL);}});
try{
  const res=await fetch('./assets/scene.wasm');if(!res.ok)throw Error('Wasm failed to load.');
  const {instance}=await WebAssembly.instantiate(await res.arrayBuffer(),{});
  scene=instance.exports;
  view=await openViewport(el('view'),id=>{
    for(const v of ['street','grate'])el(v).setAttribute('aria-pressed',id===v);
  });
  editorAvailable=true;updateInspector();
  if(mode==='edit')status('Drag to orbit · Scroll to zoom');
  performance.mark('juice-editor-ready');
}catch(error){
  el('editTab').disabled=true;el('editTab').title=error.message;
  selectMode('replay');el('mode').textContent='Recorded fallback';
  const note=document.createElement('p');note.className='note';note.textContent='The interactive 3D view is unavailable in this browser. These are recorded native sessions.';el('replayPanel').prepend(note);
  performance.mark('juice-replay-fallback');
}
