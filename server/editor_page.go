package main

const editorHTML = `<!doctype html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>超合金战记3 存档修改器</title>
<style>
:root{color-scheme:dark;--bg:#07111d;--panel:#0d1b2a;--line:#20364b;--text:#e9f3ff;--muted:#8da5bc;--cyan:#21d4fd;--green:#49e59d;--red:#ff647c;--gold:#ffc857}
*{box-sizing:border-box}body{margin:0;background:radial-gradient(circle at 20% 0,#123452 0,transparent 35%),var(--bg);color:var(--text);font:14px/1.5 system-ui,"Microsoft YaHei",sans-serif}
header{position:sticky;top:0;z-index:5;background:#07111dee;border-bottom:1px solid var(--line);backdrop-filter:blur(10px)}
.bar{max-width:1200px;margin:auto;padding:14px 20px;display:flex;gap:12px;align-items:center;flex-wrap:wrap}
h1{font-size:20px;margin:0 auto 0 0}.status{color:var(--muted)}button{border:1px solid #2c5877;background:#12334a;color:white;border-radius:7px;padding:8px 14px;cursor:pointer}
button:hover{border-color:var(--cyan)}button.primary{background:#087f8c;border-color:#22d3ee}button.danger{background:#672235;border-color:#c84b68}button:disabled{opacity:.5;cursor:not-allowed}
main{max-width:1200px;margin:22px auto;padding:0 20px 40px}.notice{padding:11px 14px;border:1px solid var(--line);background:#0c1a28;border-radius:8px;margin-bottom:16px;color:var(--muted)}
.notice.error{border-color:#8d3348;color:#ffafbd}.tabs{display:flex;gap:8px;margin-bottom:14px;flex-wrap:wrap}.tabs button.active{border-color:var(--cyan);color:var(--cyan)}
.panel{display:none}.panel.active{display:block}.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(230px,1fr));gap:12px}
.card{background:linear-gradient(145deg,#102337,#0a1724);border:1px solid var(--line);border-radius:10px;padding:15px}.card h2{font-size:15px;margin:0 0 12px;color:var(--cyan)}
label{display:block;color:var(--muted);margin:8px 0 4px}input,textarea,select{width:100%;border:1px solid #29435a;background:#07131f;color:var(--text);border-radius:6px;padding:8px}
input:focus,textarea:focus{outline:none;border-color:var(--cyan)}textarea{min-height:520px;font:12px/1.45 Consolas,monospace;tab-size:2;resize:vertical}
.table-wrap{overflow:auto;border:1px solid var(--line);border-radius:9px}table{width:100%;border-collapse:collapse;background:#0a1724}th,td{padding:9px 10px;border-bottom:1px solid #193047;text-align:left;white-space:nowrap}
th{color:var(--cyan);background:#102337;position:sticky;top:0}.path{font:12px Consolas,monospace;color:#a8c7e0}.value-input{min-width:170px}
.toolbar{display:flex;gap:9px;margin:0 0 12px;align-items:center;flex-wrap:wrap}.toolbar input{max-width:420px}.badge{display:inline-block;padding:2px 7px;border-radius:10px;background:#19344b;color:#a9d8f5;font-size:12px}
.toast{position:fixed;right:20px;bottom:20px;max-width:420px;padding:12px 16px;background:#102c3e;border:1px solid var(--cyan);border-radius:8px;box-shadow:0 8px 30px #0008;display:none;z-index:10}
.toast.error{border-color:var(--red);color:#ffd1d8}.backup-row{display:flex;gap:10px;align-items:center;border-bottom:1px solid var(--line);padding:10px 0}.backup-row span:first-child{flex:1;font-family:Consolas,monospace}
@media(max-width:600px){.bar{padding:12px}.bar h1{width:100%}main{padding:0 12px}.status{display:none}}
</style>
</head>
<body>
<header><div class="bar">
  <h1>超合金战记3 · 存档修改器</h1>
  <span id="saveMeta" class="status">正在读取……</span>
  <button id="reloadBtn">重新读取</button>
  <button id="saveBtn" class="primary">保存修改</button>
</div></header>
<main>
  <div id="notice" class="notice">修改前请退出游戏，防止游戏自动保存覆盖修改结果。每次保存都会自动备份。</div>
  <div class="tabs">
    <button class="active" data-tab="common">常用</button>
    <button data-tab="items">材料与芯片</button>
    <button data-tab="search">全部字段</button>
    <button data-tab="json">原始 JSON</button>
    <button data-tab="backups">备份恢复</button>
  </div>
  <section id="common" class="panel active"><div id="commonGrid" class="grid"></div></section>
  <section id="items" class="panel">
    <div class="toolbar"><input id="itemFilter" placeholder="搜索名称、中文名或类型"></div>
    <div class="table-wrap"><table><thead><tr><th>中文名</th><th>内部名称</th><th>类型</th><th>数量</th><th>等级/词缀</th></tr></thead><tbody id="itemsBody"></tbody></table></div>
  </section>
  <section id="search" class="panel">
    <div class="toolbar"><input id="fieldFilter" placeholder="搜索路径或值，例如 MCoin、level、green_chip"><span id="fieldCount" class="badge"></span></div>
    <div class="table-wrap" style="max-height:680px"><table><thead><tr><th>字段路径</th><th>类型</th><th>值</th></tr></thead><tbody id="fieldsBody"></tbody></table></div>
  </section>
  <section id="json" class="panel"><div class="toolbar"><button id="formatBtn">格式化 JSON</button><span class="status">高级功能：可修改任意字段，保存前会做类型与数值检查。</span></div><textarea id="jsonText" spellcheck="false"></textarea></section>
  <section id="backups" class="panel"><div class="card"><h2>最近 20 份自动备份</h2><div id="backupList">正在读取……</div></div></section>
</main>
<div id="toast" class="toast"></div>
<script>
"use strict";
let data=null, dirty=false;
const $=id=>document.getElementById(id);
const quickGroups=[
 {title:"玩家",fields:[
  ["玩家名称","playerName","text"],["人物等级","level","number"],["当前经验","nowExp","number"],["成就","achieve","number"]
 ]},
 {title:"货币",fields:[
  ["G 币","GCoin","number"],["M 币","MCoin","number"],["备用 G 币","GCoin2","number"],["备用 M 币","MCoin2","number"]
 ]},
 {title:"基础属性",fields:[
  ["基础耐久","baseLife","number"],["车身耐久","carLife","number"],["永久耐久","foreverLife","number"],["当前耐久","nowLife","number"]
 ]},
 {title:"训练等级",fields:[
  ["全能训练","playerData.allAdd.level","number"],["射击训练","playerData.attackAdd.level","number"],["控制训练","playerData.subAdd.level","number"],["体能训练","playerData.lifeAdd.level","number"],["防御训练","playerData.defenceAdd.level","number"]
 ]},
 {title:"进度",fields:[
  ["当前难度","nowDifficult","number"],["当前关卡","nowGameLevel","number"],["教程状态","tutorial","number"],["存档版本","saveDataVersion","text"]
 ]}
];
function pathParts(path){return path.replace(/\[(\d+)\]/g,".$1").split(".").filter(Boolean)}
function getPath(path){let v=data;for(const p of pathParts(path)){if(v==null)return undefined;v=v[p]}return v}
function setPath(path,value){const ps=pathParts(path);let v=data;for(let i=0;i<ps.length-1;i++){if(v[ps[i]]==null)v[ps[i]]={};v=v[ps[i]]}v[ps[ps.length-1]]=value;changed()}
function parseInput(raw,old,type){if(type==="boolean")return raw==="true";if(type==="number"||typeof old==="number"){const n=Number(raw);if(!Number.isFinite(n))throw new Error("请输入有效数字");return n}return raw}
function changed(){dirty=true;$("saveMeta").textContent="有未保存修改";syncJSON()}
function syncJSON(){if(data)$("jsonText").value=JSON.stringify(data,null,2)}
function toast(message,error=false){const el=$("toast");el.textContent=message;el.className="toast"+(error?" error":"");el.style.display="block";clearTimeout(el.timer);el.timer=setTimeout(()=>el.style.display="none",4500)}
function showError(message){$("notice").textContent=message;$("notice").className="notice error";toast(message,true)}
async function api(path,options={}){const response=await fetch(path,{...options,headers:{"Content-Type":"application/json",...(options.headers||{})}});let body;try{body=await response.json()}catch{body={error:await response.text()}}if(!response.ok)throw new Error(body.error||("HTTP "+response.status));return body}
async function loadData(){
 try{
  const result=await api("/api/editor/data");data=result.game_data;dirty=false;
  $("notice").textContent="修改前请退出游戏，防止游戏自动保存覆盖修改结果。每次保存都会自动备份。";$("notice").className="notice";
  $("saveMeta").textContent=result.size+" 字节 · "+new Date(result.updated_at).toLocaleString();
  renderAll();await loadBackups();
 }catch(error){data=null;$("saveMeta").textContent="没有可编辑存档";showError(error.message);renderAll()}
}
function renderAll(){renderCommon();renderItems();renderFields();syncJSON()}
function renderCommon(){
 const root=$("commonGrid");root.innerHTML="";
 for(const group of quickGroups){const card=document.createElement("div");card.className="card";card.innerHTML="<h2>"+group.title+"</h2>";
  for(const [label,path,type] of group.fields){const l=document.createElement("label");l.textContent=label;const input=document.createElement("input");input.type=type==="number"?"number":"text";input.step="any";const value=getPath(path);input.value=value??"";input.disabled=!data;input.onchange=()=>{try{setPath(path,parseInput(input.value,value,type));renderFields()}catch(e){toast(e.message,true)}};card.append(l,input)}
  root.append(card)
 }
}
function itemRows(){const groups=["materialsItems","propsItems"];const out=[];for(const group of groups){const arr=getPath(group+".arr");if(Array.isArray(arr))for(let i=0;i<arr.length;i++)out.push({group,index:i,item:arr[i]})}return out}
function renderItems(){
 const body=$("itemsBody");body.innerHTML="";const query=$("itemFilter").value.toLowerCase();
 for(const row of itemRows()){const item=row.item||{};const text=[item.cnName,item.name,item.type].join(" ").toLowerCase();if(query&&!text.includes(query))continue;
  const tr=document.createElement("tr");for(const value of [item.cnName||"",item.name||"",item.type||""]){const td=document.createElement("td");td.textContent=value;tr.append(td)}
  const qty=document.createElement("input");qty.type="number";qty.step="1";qty.value=item.nowNum??0;qty.className="value-input";qty.onchange=()=>{setPath(row.group+".arr["+row.index+"].nowNum",Number(qty.value));renderFields()};const qtd=document.createElement("td");qtd.append(qty);tr.append(qtd);
  const level=document.createElement("td");level.textContent=item.affixLevel??"";tr.append(level);body.append(tr)
 }
}
function flatten(value,path="",out=[]){
 if(value===null||typeof value!=="object"){out.push({path,type:value===null?"null":typeof value,value});return out}
 if(Array.isArray(value)){value.forEach((v,i)=>flatten(v,path+"["+i+"]",out));return out}
 for(const key of Object.keys(value).sort())flatten(value[key],path?path+"."+key:key,out);return out
}
function renderFields(){
 const body=$("fieldsBody");body.innerHTML="";if(!data){$("fieldCount").textContent="0";return}
 const query=$("fieldFilter").value.toLowerCase();const rows=flatten(data).filter(row=>!query||row.path.toLowerCase().includes(query)||String(row.value).toLowerCase().includes(query)).slice(0,2000);$("fieldCount").textContent=rows.length+(rows.length===2000?"+":"");
 for(const row of rows){const tr=document.createElement("tr");const p=document.createElement("td");p.className="path";p.textContent=row.path;const t=document.createElement("td");t.textContent=row.type;const td=document.createElement("td");let input=document.createElement("input");input.className="value-input";input.value=row.value??"";if(row.type==="boolean"){input=document.createElement("select");for(const v of ["true","false"]){const o=document.createElement("option");o.value=v;o.textContent=v;input.append(o)}input.value=String(row.value)}input.onchange=()=>{try{setPath(row.path,parseInput(input.value,row.value,row.type));renderCommon();renderItems()}catch(e){toast(e.message,true)}};td.append(input);tr.append(p,t,td);body.append(tr)}
}
async function save(){
 if(!data)return showError("没有存档可保存");
 try{data=JSON.parse($("jsonText").value);$("saveBtn").disabled=true;const result=await api("/api/editor/save",{method:"POST",body:JSON.stringify({game_data:data})});data=result.game_data;dirty=false;toast("保存成功，备份："+result.backup);await loadData()}catch(error){showError(error.message)}finally{$("saveBtn").disabled=false}
}
async function loadBackups(){
 try{const result=await api("/api/editor/backups");const root=$("backupList");root.innerHTML=result.backups.length?"":"暂无备份";
  for(const backup of result.backups){const row=document.createElement("div");row.className="backup-row";const name=document.createElement("span");name.textContent=backup.name;const meta=document.createElement("span");meta.className="status";meta.textContent=backup.size+" 字节";const button=document.createElement("button");button.textContent="恢复";button.className="danger";button.onclick=async()=>{if(!confirm("确定恢复这份备份？当前存档也会先备份。"))return;try{await api("/api/editor/restore",{method:"POST",body:JSON.stringify({name:backup.name})});toast("备份已恢复");await loadData()}catch(e){showError(e.message)}};row.append(name,meta,button);root.append(row)}
 }catch(error){$("backupList").textContent=error.message}
}
document.querySelectorAll(".tabs button").forEach(button=>button.onclick=()=>{document.querySelectorAll(".tabs button").forEach(b=>b.classList.toggle("active",b===button));document.querySelectorAll(".panel").forEach(p=>p.classList.toggle("active",p.id===button.dataset.tab));if(button.dataset.tab==="backups")loadBackups()});
$("reloadBtn").onclick=()=>{if(!dirty||confirm("放弃未保存修改并重新读取？"))loadData()};$("saveBtn").onclick=save;
$("formatBtn").onclick=()=>{try{data=JSON.parse($("jsonText").value);changed();renderCommon();renderItems();renderFields()}catch(e){toast("JSON 格式错误："+e.message,true)}};
$("itemFilter").oninput=renderItems;$("fieldFilter").oninput=renderFields;
window.addEventListener("beforeunload",e=>{if(dirty){e.preventDefault();e.returnValue=""}});
loadData();
</script>
</body>
</html>`
