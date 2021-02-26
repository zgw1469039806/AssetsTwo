///<jscompress sourcefile="DefaultForm.js" />
/**
 * 业务操作父类
 */
function DefaultForm() {
};
/**
 * 流程操作对象
 */
DefaultForm.prototype.flowEditor = null;

/**
 * 提交和退回前是否自动保存
 */
DefaultForm.prototype.isAutoSave = true;

/**
 * 表单主键
 * 
 * @param id
 */
DefaultForm.prototype.id = null;
DefaultForm.prototype.setId = function(id) {
	this.id = id;
};
/**
 * 初始化业务数据
 */
DefaultForm.prototype.initFormData = function() {
};
/**
 * 启动流程
 * 
 * @param defineId
 * @param callback
 */
DefaultForm.prototype.start = function(defineId, callback) {
};
/**
 * 更新数据
 * 
 * @param callback
 */
DefaultForm.prototype.save = function(callback) {
};
/**
 * 刷新权限按钮后事件
 */
DefaultForm.prototype.afterCreateButtons = function() {
};
/**
 * 刷新表单元素权限成功后事件
 */
DefaultForm.prototype.afterControlFormInput = function() {
};
/**
 * 密级下拉框再过滤事件
 */
DefaultForm.prototype.filterSecretLevel = function(secretLevelList) {
	return secretLevelList;
};
/**
 * 引用文档上传前校验密级
 */
DefaultForm.prototype.validSecretLevel = function(secretLevelArr){
	return true;
};
/**
 * 设置附件是否可增删
 */
DefaultForm.prototype.setAttachMagic = function(magic){
};

/**
 * 设置多附件是否可增删
 */
DefaultForm.prototype.setAttachCanAddOrDel = function(tagId,operability,obj){
};

/**
 * 设置多附件是否必填
 */
DefaultForm.prototype.setAttachRequired = function(tagId,required,obj){
};

/**
 * 设置多附件密级是否可修改
 */
DefaultForm.prototype.setAttachSecretLevelModify = function(tagId,modify,obj){
};

/**
 * 自定义元素的权限控制，自定义元素定义通过".bpm_self_class"来实现
 * @param tagId 元素id
 * @param operability 是否可编辑
 */
DefaultForm.prototype.controlSelfElement = function(tagId, operability, obj){
};
/**
 * 自定义元素的权限控制，自定义元素定义通过".bpm_self_class"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlSelfElementForAccess = function(tagId, accessibility, obj){
};
/**
 * 自定义元素的必填控制，自定义元素定义通过".bpm_self_class"来实现
 * @param tagId 元素id
 * @param required 是否必填
 */
DefaultForm.prototype.controlSelfElementForRequired = function(tagId, accessibility, obj){
};

/**
 * 子表按钮元素的权限控制，子表按钮元素定义通过".eform_subtable_bpm_button_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlSubTableButtonForAccess = function(tagId, accessibility, obj){
};

/**
 * 非电子表单子表字段的显隐控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlCustomSubTableForAccess = function(tagId, accessibility, obj){
};
/**
 * 非电子表单子表字段的可编辑控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlCustomSubTableForOperability = function(tagId, operability, obj){
};
/**
 * 非电子表单子表字段的必填控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlCustomSubTableForRequired = function(tagId, required, obj){
};
/**
 * 重新组织意见
 * @param idea
 * @param users
 * @returns {*}
 */
DefaultForm.prototype.reGetidea = function(idea, users){
    return idea;
};
/**
 * 流程页面初始化事件，在按钮第一次加载后被执行
 */
DefaultForm.prototype.afterInit = function(){
};
/** 前后置事件 */
/**
 * 提交前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeSubmit = function(data) {
	return true;
};
/**
 * 提交后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterSubmit = function(data) {
};

/**
 * 退回前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeRetreat = function(data) {
	return true;
};
/**
 * 退回后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterRetreat = function(data) {
};

/**
 * 拿回前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeWithdraw = function(data) {
	return true;
};
/**
 * 拿回后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterWithdraw = function(data) {
};

/**
 * 补发前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeSupplement = function(data) {
	return true;
};
/**
 * 补发后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterSupplement = function(data) {
};

/**
 * 加签前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeAdduser = function(data) {
	return true;
};
/**
 * 加签后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterAdduser = function(data) {
};

/**
 * 转办前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeSupersede = function(data) {
	return true;
};
/**
 * 转办后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterSupersede = function(data) {
};

/**
 * 转发前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeTransmit = function(data) {
	return true;
};
/**
 * 转发后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterTransmit = function(data) {
};

/**
 * 增加读者前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeTaskreader = function(data) {
	return true;
};
/**
 * 增加读者后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterTaskreader = function(data) {
};

/**
 * 减签前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeWithdrawassignee = function(data) {
	return true;
};
/**
 * 减签后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterWithdrawassignee = function(data) {
};

/**
 * 流程结束前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeGlobalend = function(data) {
	return true;
};
/**
 * 流程结束后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterGlobalend = function(data) {
};

/**
 * 流程跳转前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeGlobaljump = function(data) {
	return true;
};
/**
 * 流程跳转后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterGlobaljump = function(data) {
};

/**
 * 流程恢复前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeGlobalresume = function(data) {
	return true;
};
/**
 * 流程恢复后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterGlobalresume = function(data) {
};

/**
 * 流程暂停前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeGlobalsuspend = function(data) {
	return true;
};
/**
 * 流程暂停后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterGlobalsuspend = function(data) {
};

/**
 * 自定义选人前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeStepuserdefined = function(data) {
	return true;
};
/**
 * 自定义选人后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterStepuserdefined = function(data) {
};
/**
 * 催办前事件
 * 
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforePresstodo = function(data) {
	return true;
};
/**
 * 催办后事件
 * 
 * @param data
 */
DefaultForm.prototype.afterPresstodo = function(data) {
};
/**
 * 引导按钮code
 */
DefaultForm.prototype.getLeadButCodeList = function() {
	var result = new Array();
	result.push("dosubmit");
	result.push("dosubmit_mesh");
	result.push("dostart");
	result.push("dotransmitsubmit");
	return result;
};;
///<jscompress sourcefile="FlowModel.js" />
/**
 * 数据模板
 */
function FlowModel(defineId, deploymentId, entryId, executionId, taskId) {
	this.defineId = defineId;
	this.deploymentId = deploymentId;
    _fileupload_entryId = entryId;
	this.entryId = entryId;
	this.executionId = executionId;
	this.taskId = taskId;
};
/**
 * 流程定义文件主键
 *
 * @param defineId
 */
FlowModel.prototype.defineId = null;
FlowModel.prototype.setDefineId = function(defineId) {
	this.defineId = defineId;
};
/**
 * 流程部署文件主键
 *
 * @param deploymentId
 */
FlowModel.prototype.deploymentId = null;
FlowModel.prototype.setDeploymentId = function(deploymentId) {
	this.deploymentId = deploymentId;
};

/**
 * 流程实例主键
 *
 * @param entryId
 */
FlowModel.prototype.entryId = null;
FlowModel.prototype.setEntryId = function(entryId) {
    _fileupload_entryId = entryId;
	this.entryId = entryId;
};
/**
 * 流程指针ID
 *
 * @param executionId
 */
FlowModel.prototype.executionId = null;
FlowModel.prototype.setExecutionId = function(executionId) {
	this.executionId = executionId;
};
/**
 * 流程任务ID
 *
 * @param taskId
 */
FlowModel.prototype.taskId = null;
FlowModel.prototype.setTaskId = function(taskId) {
	this.taskId = taskId;
};
/**
 * 当前节点名称
 *
 * @param activityname
 */
FlowModel.prototype.activityname = null;
FlowModel.prototype.setActivityname = function(activityname) {
    _fileupload_taskName = activityname;
	this.activityname = activityname;
};
/**
 * 当前节点显示名
 *
 * @param activityname
 */
FlowModel.prototype.activitylabel = null;
FlowModel.prototype.setActivitylabel = function(activitylabel) {
	this.activitylabel = activitylabel;
};
/**
 * 当前身份
 * 用户身份 1待办人2 已办人 3待阅人 4已阅人 5读者，6拟稿人，7管理员，0未知
 *
 * @param activityname
 */
FlowModel.prototype.userIdentityKey = null;
FlowModel.prototype.setUserIdentityKey = function(userIdentityKey) {
	this.userIdentityKey = userIdentityKey;
};
/**
 * 当前身份
 * 用户身份 待办人 已办人 待阅人 已阅人 读者，拟稿人，管理员
 *
 * @param activityname
 */
FlowModel.prototype.userIdentity = null;
FlowModel.prototype.setUserIdentity = function(userIdentity) {
	this.userIdentity = userIdentity;
};
/**
 * 自定义强制表态意见
 * @type {null}
 */
FlowModel.prototype.ideasBySelf = null;
FlowModel.prototype.setIdeasBySelf = function(ideasBySelf) {
	this.ideasBySelf = ideasBySelf;
};
//暴漏的全局变量，下载附件是像后台传递
var _fileupload_entryId = "";
var _fileupload_taskName = "";
;
///<jscompress sourcefile="FlowUploader.js" />
var swfobject=function(){var b="undefined",Q="object",n="Shockwave Flash",p="ShockwaveFlash.ShockwaveFlash",P="application/x-shockwave-flash",m="SWFObjectExprInst",j=window,K=document,T=navigator,o=[],N=[],i=[],d=[],J,Z=null,M=null,l=null,e=false,A=false;var h=function(){var v=typeof K.getElementById!=b&&typeof K.getElementsByTagName!=b&&typeof K.createElement!=b,AC=[0,0,0],x=null;if(typeof T.plugins!=b&&typeof T.plugins[n]==Q){x=T.plugins[n].description;if(x&&!(typeof T.mimeTypes!=b&&T.mimeTypes[P]&&!T.mimeTypes[P].enabledPlugin)){x=x.replace(/^.*\s+(\S+\s+\S+$)/,"$1");AC[0]=parseInt(x.replace(/^(.*)\..*$/,"$1"),10);AC[1]=parseInt(x.replace(/^.*\.(.*)\s.*$/,"$1"),10);AC[2]=/r/.test(x)?parseInt(x.replace(/^.*r(.*)$/,"$1"),10):0}}else{if(typeof j.ActiveXObject!=b){var y=null,AB=false;try{y=new ActiveXObject(p+".7")}catch(t){try{y=new ActiveXObject(p+".6");AC=[6,0,21];y.AllowScriptAccess="always"}catch(t){if(AC[0]==6){AB=true}}if(!AB){try{y=new ActiveXObject(p)}catch(t){}}}if(!AB&&y){try{x=y.GetVariable("$version");if(x){x=x.split(" ")[1].split(",");AC=[parseInt(x[0],10),parseInt(x[1],10),parseInt(x[2],10)]}}catch(t){}}}}var AD=T.userAgent.toLowerCase(),r=T.platform.toLowerCase(),AA=/webkit/.test(AD)?parseFloat(AD.replace(/^.*webkit\/(\d+(\.\d+)?).*$/,"$1")):false,q=false,z=r?/win/.test(r):/win/.test(AD),w=r?/mac/.test(r):/mac/.test(AD);/*@cc_on q=true;@if(@_win32)z=true;@elif(@_mac)w=true;@end@*/return{w3cdom:v,pv:AC,webkit:AA,ie:q,win:z,mac:w}}();var L=function(){if(!h.w3cdom){return }f(H);if(h.ie&&h.win){try{K.write("<script id=__ie_ondomload defer=true src=//:><\/script>");J=C("__ie_ondomload");if(J){I(J,"onreadystatechange",S)}}catch(q){}}if(h.webkit&&typeof K.readyState!=b){Z=setInterval(function(){if(/loaded|complete/.test(K.readyState)){E()}},10)}if(typeof K.addEventListener!=b){K.addEventListener("DOMContentLoaded",E,null)}R(E)}();function S(){if(J.readyState=="complete"){J.parentNode.removeChild(J);E()}}function E(){if(e){return }if(h.ie&&h.win){var v=a("span");try{var u=K.getElementsByTagName("body")[0].appendChild(v);u.parentNode.removeChild(u)}catch(w){return }}e=true;if(Z){clearInterval(Z);Z=null}var q=o.length;for(var r=0;r<q;r++){o[r]()}}function f(q){if(e){q()}else{o[o.length]=q}}function R(r){if(typeof j.addEventListener!=b){j.addEventListener("load",r,false)}else{if(typeof K.addEventListener!=b){K.addEventListener("load",r,false)}else{if(typeof j.attachEvent!=b){I(j,"onload",r)}else{if(typeof j.onload=="function"){var q=j.onload;j.onload=function(){q();r()}}else{j.onload=r}}}}}function H(){var t=N.length;for(var q=0;q<t;q++){var u=N[q].id;if(h.pv[0]>0){var r=C(u);if(r){N[q].width=r.getAttribute("width")?r.getAttribute("width"):"0";N[q].height=r.getAttribute("height")?r.getAttribute("height"):"0";if(c(N[q].swfVersion)){if(h.webkit&&h.webkit<312){Y(r)}W(u,true)}else{if(N[q].expressInstall&&!A&&c("6.0.65")&&(h.win||h.mac)){k(N[q])}else{O(r)}}}}else{W(u,true)}}}function Y(t){var q=t.getElementsByTagName(Q)[0];if(q){var w=a("embed"),y=q.attributes;if(y){var v=y.length;for(var u=0;u<v;u++){if(y[u].nodeName=="DATA"){w.setAttribute("src",y[u].nodeValue)}else{w.setAttribute(y[u].nodeName,y[u].nodeValue)}}}var x=q.childNodes;if(x){var z=x.length;for(var r=0;r<z;r++){if(x[r].nodeType==1&&x[r].nodeName=="PARAM"){w.setAttribute(x[r].getAttribute("name"),x[r].getAttribute("value"))}}}t.parentNode.replaceChild(w,t)}}function k(w){A=true;var u=C(w.id);if(u){if(w.altContentId){var y=C(w.altContentId);if(y){M=y;l=w.altContentId}}else{M=G(u)}if(!(/%$/.test(w.width))&&parseInt(w.width,10)<310){w.width="310"}if(!(/%$/.test(w.height))&&parseInt(w.height,10)<137){w.height="137"}K.title=K.title.slice(0,47)+" - Flash Player Installation";var z=h.ie&&h.win?"ActiveX":"PlugIn",q=K.title,r="MMredirectURL="+j.location+"&MMplayerType="+z+"&MMdoctitle="+q,x=w.id;if(h.ie&&h.win&&u.readyState!=4){var t=a("div");x+="SWFObjectNew";t.setAttribute("id",x);u.parentNode.insertBefore(t,u);u.style.display="none";var v=function(){u.parentNode.removeChild(u)};I(j,"onload",v)}U({data:w.expressInstall,id:m,width:w.width,height:w.height},{flashvars:r},x)}}function O(t){if(h.ie&&h.win&&t.readyState!=4){var r=a("div");t.parentNode.insertBefore(r,t);r.parentNode.replaceChild(G(t),r);t.style.display="none";var q=function(){t.parentNode.removeChild(t)};I(j,"onload",q)}else{t.parentNode.replaceChild(G(t),t)}}function G(v){var u=a("div");if(h.win&&h.ie){u.innerHTML=v.innerHTML}else{var r=v.getElementsByTagName(Q)[0];if(r){var w=r.childNodes;if(w){var q=w.length;for(var t=0;t<q;t++){if(!(w[t].nodeType==1&&w[t].nodeName=="PARAM")&&!(w[t].nodeType==8)){u.appendChild(w[t].cloneNode(true))}}}}}return u}function U(AG,AE,t){var q,v=C(t);if(v){if(typeof AG.id==b){AG.id=t}if(h.ie&&h.win){var AF="";for(var AB in AG){if(AG[AB]!=Object.prototype[AB]){if(AB.toLowerCase()=="data"){AE.movie=AG[AB]}else{if(AB.toLowerCase()=="styleclass"){AF+=' class="'+AG[AB]+'"'}else{if(AB.toLowerCase()!="classid"){AF+=" "+AB+'="'+AG[AB]+'"'}}}}}var AD="";for(var AA in AE){if(AE[AA]!=Object.prototype[AA]){AD+='<param name="'+AA+'" value="'+AE[AA]+'" />'}}v.outerHTML='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"'+AF+">"+AD+"</object>";i[i.length]=AG.id;q=C(AG.id)}else{if(h.webkit&&h.webkit<312){var AC=a("embed");AC.setAttribute("type",P);for(var z in AG){if(AG[z]!=Object.prototype[z]){if(z.toLowerCase()=="data"){AC.setAttribute("src",AG[z])}else{if(z.toLowerCase()=="styleclass"){AC.setAttribute("class",AG[z])}else{if(z.toLowerCase()!="classid"){AC.setAttribute(z,AG[z])}}}}}for(var y in AE){if(AE[y]!=Object.prototype[y]){if(y.toLowerCase()!="movie"){AC.setAttribute(y,AE[y])}}}v.parentNode.replaceChild(AC,v);q=AC}else{var u=a(Q);u.setAttribute("type",P);for(var x in AG){if(AG[x]!=Object.prototype[x]){if(x.toLowerCase()=="styleclass"){u.setAttribute("class",AG[x])}else{if(x.toLowerCase()!="classid"){u.setAttribute(x,AG[x])}}}}for(var w in AE){if(AE[w]!=Object.prototype[w]&&w.toLowerCase()!="movie"){F(u,w,AE[w])}}v.parentNode.replaceChild(u,v);q=u}}}return q}function F(t,q,r){var u=a("param");u.setAttribute("name",q);u.setAttribute("value",r);t.appendChild(u)}function X(r){var q=C(r);if(q&&(q.nodeName=="OBJECT"||q.nodeName=="EMBED")){if(h.ie&&h.win){if(q.readyState==4){B(r)}else{j.attachEvent("onload",function(){B(r)})}}else{q.parentNode.removeChild(q)}}}function B(t){var r=C(t);if(r){for(var q in r){if(typeof r[q]=="function"){r[q]=null}}r.parentNode.removeChild(r)}}function C(t){var q=null;try{q=K.getElementById(t)}catch(r){}return q}function a(q){return K.createElement(q)}function I(t,q,r){t.attachEvent(q,r);d[d.length]=[t,q,r]}function c(t){var r=h.pv,q=t.split(".");q[0]=parseInt(q[0],10);q[1]=parseInt(q[1],10)||0;q[2]=parseInt(q[2],10)||0;return(r[0]>q[0]||(r[0]==q[0]&&r[1]>q[1])||(r[0]==q[0]&&r[1]==q[1]&&r[2]>=q[2]))?true:false}function V(v,r){if(h.ie&&h.mac){return }var u=K.getElementsByTagName("head")[0],t=a("style");t.setAttribute("type","text/css");t.setAttribute("media","screen");if(!(h.ie&&h.win)&&typeof K.createTextNode!=b){t.appendChild(K.createTextNode(v+" {"+r+"}"))}u.appendChild(t);if(h.ie&&h.win&&typeof K.styleSheets!=b&&K.styleSheets.length>0){var q=K.styleSheets[K.styleSheets.length-1];if(typeof q.addRule==Q){q.addRule(v,r)}}}function W(t,q){var r=q?"visible":"hidden";if(e&&C(t)){C(t).style.visibility=r}else{V("#"+t,"visibility:"+r)}}function g(s){var r=/[\\\"<>\.;]/;var q=r.exec(s)!=null;return q?encodeURIComponent(s):s}var D=function(){if(h.ie&&h.win){window.attachEvent("onunload",function(){var w=d.length;for(var v=0;v<w;v++){d[v][0].detachEvent(d[v][1],d[v][2])}var t=i.length;for(var u=0;u<t;u++){X(i[u])}for(var r in h){h[r]=null}h=null;for(var q in swfobject){swfobject[q]=null}swfobject=null})}}();return{registerObject:function(u,q,t){if(!h.w3cdom||!u||!q){return }var r={};r.id=u;r.swfVersion=q;r.expressInstall=t?t:false;N[N.length]=r;W(u,false)},getObjectById:function(v){var q=null;if(h.w3cdom){var t=C(v);if(t){var u=t.getElementsByTagName(Q)[0];if(!u||(u&&typeof t.SetVariable!=b)){q=t}else{if(typeof u.SetVariable!=b){q=u}}}}return q},embedSWF:function(x,AE,AB,AD,q,w,r,z,AC){if(!h.w3cdom||!x||!AE||!AB||!AD||!q){return }AB+="";AD+="";if(c(q)){W(AE,false);var AA={};if(AC&&typeof AC===Q){for(var v in AC){if(AC[v]!=Object.prototype[v]){AA[v]=AC[v]}}}AA.data=x;AA.width=AB;AA.height=AD;var y={};if(z&&typeof z===Q){for(var u in z){if(z[u]!=Object.prototype[u]){y[u]=z[u]}}}if(r&&typeof r===Q){for(var t in r){if(r[t]!=Object.prototype[t]){if(typeof y.flashvars!=b){y.flashvars+="&"+t+"="+r[t]}else{y.flashvars=t+"="+r[t]}}}}f(function(){U(AA,y,AE);if(AA.id==AE){W(AE,true)}})}else{if(w&&!A&&c("6.0.65")&&(h.win||h.mac)){A=true;W(AE,false);f(function(){var AF={};AF.id=AF.altContentId=AE;AF.width=AB;AF.height=AD;AF.expressInstall=w;k(AF)})}}},getFlashPlayerVersion:function(){return{major:h.pv[0],minor:h.pv[1],release:h.pv[2]}},hasFlashPlayerVersion:c,createSWF:function(t,r,q){if(h.w3cdom){return U(t,r,q)}else{return undefined}},removeSWF:function(q){if(h.w3cdom){X(q)}},createCSS:function(r,q){if(h.w3cdom){V(r,q)}},addDomLoadEvent:f,addLoadEvent:R,getQueryParamValue:function(v){var u=K.location.search||K.location.hash;if(v==null){return g(u)}if(u){var t=u.substring(1).split("&");for(var r=0;r<t.length;r++){if(t[r].substring(0,t[r].indexOf("="))==v){return g(t[r].substring((t[r].indexOf("=")+1)))}}}return""},expressInstallCallback:function(){if(A&&M){var q=C(m);if(q){q.parentNode.replaceChild(M,q);if(l){W(l,true);if(h.ie&&h.win){M.style.display="block"}}M=null;l=null;A=false}}}}}();
/**
 * 引用文档
 */
function FlowUploader(flowEditor) {
	this.flowEditor = flowEditor;
};
/**
 * 流程操作对象
 */
FlowUploader.prototype.flowEditor = null;
/**
 * 上传控件
 */
FlowUploader.prototype.uploader = null;
/**
 * 引用文档的tbody的id
 */
FlowUploader.prototype.filesdiv = "bpm_files_div";
/**
 * 引用文档添加的id
 */
FlowUploader.prototype.filesaddId = "bpm_files_add";
/**
 * 引用文档上传的id
 */
FlowUploader.prototype.filesUploadId = "bpm_files_upload";

FlowUploader.prototype.hasFlash = false;
FlowUploader.prototype.hasFlashWarning = false;
FlowUploader.prototype.saveType = "DataBase"; //Fastfds
/**
 * 密级
 */
FlowUploader.prototype.secretLevelList = [];

/**
 * 初始化
 */
FlowUploader.prototype.init = function() {
	var _self = this;
	$.ajax({
		type : "POST",
		data : {
			entryId : this.flowEditor.flowModel.entryId
		},
		url : "platform/bpm/business/getSecretLevelList",
		dataType : "JSON",
		success : function(data) {
			if (flowUtils.notNull(data.error)) {
				flowUtils.error(data.error);
			} else {
				_self.secretLevelList = data.result;
			}
		}
	});
	this.hasFlash = swfobject.hasFlashPlayerVersion("9.0.28");
	if(!this.hasFlash){
		return;
	}
	this.uploader = WebUploader.create({
		// swf文件路径
		swf : 'static/h5/webuploader-0.1.5/dist/Uploader.swf',
		// 文件接收服务端。
		server : 'platform/bpm/business/upload.json',
		// 选择文件的按钮。可选。
		// 内部根据当前运行是创建，可能是input元素，也可能是flash.
		pick : '#' + this.filesaddId,
		// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		resize : false,
		fileSingleSizeLimit: 10*1024*1024
	});
	// 暴漏为全局属性
	_flowUploader_uploader = this.uploader;
	this.uploader.on('ready', function() {
	});
	// 当有文件被添加进队列前执行。判断是否符合条件，否则返回false阻止
	this.uploader.on('beforeFileQueued', function(file) {
		if (flowUtils.notNull(_self.flowEditor.flowModel.entryId)) {
			return true;
		} else {
			flowUtils.warning("请保存表单后再添加文档");
			return false;
		}
	});
	this.uploader.on('fileQueued', function(file) {
		_self.addFile(file);
	});
	// 文件上传之前，传入自定义参数
	this.uploader.on('uploadBeforeSend', function(block, data) {
		// file为分块对应的file对象。
		var file = block.file;
		var fileDIV = $('#' + file.id);
		var secretLevel = fileDIV.find('select[name="secretLevel"]');
		// / 修改data可以控制发送哪些携带数据。
		data.secretLevel = secretLevel.val();
		data.entryId = _self.flowEditor.flowModel.entryId;
		data.saveType = _self.saveType;
	});
	// 文件上传过程中创建进度条实时显示。
	this.uploader.on('uploadProgress', function(file, percentage) {
		var $tr = $('#' + file.id);
		$tr.children().last().html('正在上传');
	});

	// 文件上传成功
	this.uploader.on('uploadSuccess', function(file, response) {
		if (flowUtils.notNull(response.error)) {
			flowUtils.error(response.error)
		} else {
			var $tr = $('#' + file.id);
			$tr.children().last().html('上传成功');
			_self.uploader.removeFile(file);
			setTimeout(function() {
				var $newTr = _self.getTr(response.bpmFiles);
				$tr.replaceWith($newTr);
			}, 500);
		}
	});
	// 文件上传失败
	this.uploader.on('uploadError', function(file, reason) {
		flowUtils.error("上传失败了");
	});
	// 错误
	this.uploader.on('error', function(handler, infos) {
		if(handler == 'F_EXCEED_SIZE'){
			flowUtils.warning("超过附件大小限制");
		}else if(handler == 'Q_TYPE_DENIED'){
			flowUtils.warning("不能上传空文件");
		}else{
			flowUtils.warning("附件不能上传");
		}
	});
	// 文件上传完毕(成功或失败后都会执行)
	this.uploader.on('uploadComplete', function(file) {
	});
	$("#" + this.filesUploadId).on("click", function() {
		var secretLevelArr = [];
		var secretLevelDoms = $("#"+_self.filesdiv).find('select[name="secretLevel"]');
		$.each(secretLevelDoms, function(i, n){
			secretLevelArr.push(n.value);
		});
		var validate = _self.flowEditor.defaultForm.validSecretLevel(secretLevelArr);
		if(validate){
			_self.uploader.upload();
		}
	});
};
FlowUploader.prototype.refresh = function() {
	var _self = this;
	if(!this.flowEditor.isStart && this.flowEditor.flowModel.userIdentityKey == "6"){
		if(this.hasFlash){
			$("#" + this.filesaddId).show();
			$("#" + this.filesUploadId).show();
		}else{
			$("#" + this.filesaddId).hide();
			$("#" + this.filesUploadId).hide();
			/*if(!this.hasFlashWarning){
				flowUtils.warning("没有安装flash插件，将无法使用流程文档及附件的上传功能！");
				this.hasFlashWarning = true;
			}*/
		}
	}else{
		$("#" + this.filesaddId).hide();
		$("#" + this.filesUploadId).hide();
	}
	$.ajax({
		type : "POST",
		data : {
			entryId : this.flowEditor.flowModel.entryId,
			defineId : this.flowEditor.flowModel.defineId,
			activityName : this.flowEditor.flowModel.activityname
		},
		url : "platform/bpm/business/getBpmFiles",
		dataType : "JSON",
		success : function(data) {
			if (flowUtils.notNull(data.error)) {
				flowUtils.error(data.error);
			} else {
				$("#" + _self.filesdiv).empty();
				$.each(data.result, function(i, n) {
					var $tr = _self.getTr(n);
					$("#" + _self.filesdiv).append($tr);
				});
			}
		}
	});
};
FlowUploader.prototype.addFile = function(file) {
	var tr = $("<tr></tr>");
	tr.attr("id", file.id);
	tr.append(this.getTd(file.name));
	tr.append(this.getTdSecretLevel());
	tr.append(this.getTd(''));
	tr.append(this.getTd(''));
	tr.append(this.getOperateTd(true, file.name, file.id));
	tr.append(this.getTd('等待上传'));
	$("#" + this.filesdiv).append(tr);
};
FlowUploader.prototype.getTr = function(bpmFile) {
	var tr = $("<tr></tr>");
	tr.attr("id", bpmFile.id);
	tr.append(this.getTd(bpmFile.attachName));
	tr.append(this.getTd(bpmFile.secretLevelString));
	tr.append(this.getTd(bpmFile.createdByString));
	tr.append(this.getTd(bpmFile.creationDateString));
	tr.append(this.getOperateTd(false, bpmFile.attachName, bpmFile.id, bpmFile.processDefineid));
	tr.append(this.getTd('已上传'));
	return tr;
};
FlowUploader.prototype.getOperateTd = function(isNew, attachName, id, processDefineid) {
	var td = $("<td></td>");
	var downloadA = $("<a href='javascript:void(0);'>下载</a>");
	var deleteA = $("<a href='javascript:void(0);'>删除</a>");
	if (isNew) {
		deleteA.on("click", function(){
			_flowUploader_removeFile(true, id);
		});
		td.append(deleteA);
	} else {
		if(flowUtils.notNull(processDefineid) || this.flowEditor.flowModel.userIdentityKey != "6"){
			downloadA.on("click", function(){
				_flowUploader_downloadFile(id);
			});
			td.append(downloadA);
		}else{
			downloadA.on("click", function(){
				_flowUploader_downloadFile(id);
			});
			td.append(downloadA);
			td.append("&nbsp;&nbsp;");
			deleteA.on("click", function(){
				_flowUploader_removeFile(false, id);
			});
			td.append(deleteA);
		}
	}
	return td;
};
FlowUploader.prototype.getTdSecretLevel = function() {
	var tempSecretLevelList = this.flowEditor.defaultForm.filterSecretLevel(flowUtils.clone(this.secretLevelList));
	var td = $("<td></td>");
	var select = $("<select></select>")
	select.attr("name", "secretLevel");
	$.each(tempSecretLevelList, function(i, secretLevel) {
		var option = $("<option></option>");
		option.attr("value", secretLevel.lookupCode);
		option.html(secretLevel.lookupName);
		select.append(option);
	});
	td.append(select);
	return td;
};
FlowUploader.prototype.getTd = function(s) {
	var td = $("<td></td>");
	td.html(s);
	return td;
};
// 暴漏为全局属性
var _flowUploader_uploader = null;
function _flowUploader_removeFile(isNew, id) {
	if (isNew) {
		_flowUploader_uploader.removeFile(_flowUploader_uploader.getFile(id));
		$("#" + id).remove();
	} else {
		flowUtils.confirm("确定删除？", function(){
			avicAjax.ajax({
				type : "POST",
				data : {
					id : id
				},
				url : "platform/bpm/business/deleteBpmFiles",
				dataType : "JSON",
				success : function(data) {
					if (flowUtils.notNull(data.error)) {
						flowUtils.error(data.error);
					} else {
						$("#" + id).remove();
					}
				}
			});
		});
	}
};
function _flowUploader_downloadFile(id) {
	var url = "platform/bpm/business/doDownload?id=" + id;
	var t = new FlowDownLoad4URL('iframe', 'form', null, url);
	t.downLoad();
};;
///<jscompress sourcefile="BpmButton.js" />
/**
 * 按钮基类
 */
function BpmButton(flowEditor, defaultForm, data, isEvent) {
	this.flowEditor = flowEditor;
	this.defaultForm = defaultForm;
	this.data = data;
	if (flowUtils.notNull(this.data)) {
		this.enable = true;
	}
	this.domeId = "";
	this.isEvent = isEvent;
};
BpmButton.prototype.enable = false;
BpmButton.prototype.isEnable = function() {
	return this.enable;
};
/**
 * 执行
 */
BpmButton.prototype.execute = function() {
	flowUtils.success("该方法开发中");
};
BpmButton.prototype.getHtml = function() {
	if(this.isEvent){
		return;
	}
	if (this.isEnable()) {
		var _self = this;
		$("#" + this.domeId).html(this.data.lable);
		$("#" + this.domeId).off("click");
		$("#" + this.domeId).on("click", function() {
			_self.execute()
		});
		$("#" + this.domeId).show();
		$("#" + this.domeId).parent().show();
		$("#" + this.domeId).parent().prev().show();
		$("#bpm_buttons_more").show();
	} else {
		// 隐藏并清空事件
		$("#" + this.domeId).hide();
		$("#" + this.domeId).off("click");
	}
};
BpmButton.prototype.getIdeaText = function() {
	if(this.isEvent){
		return "";
	}
	return this.flowEditor.flowIdea.getIdea(this.ideaElementIdBySelf);
};
BpmButton.prototype.focusIdeaText = function() {
	this.flowEditor.flowIdea.focusIdeaText(this.ideaElementIdBySelf);
};
BpmButton.prototype.hasIdeaElementBySelf = function() {
    if(this.isEvent){
        return false;
    }
    return this.flowEditor.flowIdea.hasIdeaElementBySelf(this.ideaElementIdBySelf);
};
BpmButton.prototype.submit = function(data, users) {
	flowUtils.warning("未实现的方法");
};
BpmButton.prototype.validIdeasBySelf = function(valid_value, callback){
	var self = this;
	if(this.flowEditor.flowModel.ideasBySelf != null && this.flowEditor.flowModel.ideasBySelf.length > 0){
		var content = "<form class='container-fluid'>\n";
		var flg = false;
		for(var i = 0; i < this.flowEditor.flowModel.ideasBySelf.length; i++){
			var ideas = this.flowEditor.flowModel.ideasBySelf[i];
			if(ideas.outcome == "0" || ideas.outcome == valid_value){
				flg = true;
				content += "  <div class=\"form-group\">\n" +
					"    <label><input type='radio' name='ideas_radio'/> " + ideas.content + "</label>\n" +
					"  </div>\n";
			}
		}
		content += "</form>";
		if(!flg){
			callback();
			return;
		}
		layer.open({
			type : 1,
			title : "强制表态",
			area : [ "300px", "400px" ],
			content : content,
			btn: ['确定', '取消'],
			yes: function(index, layero){
				var ideas_radio = $("input[name='ideas_radio']:checked");
				if(ideas_radio.length == 0){
					flowUtils.warning("请先表态");
					return;
				}
				self.ideas_text = ideas_radio.parent().text().trim();
				callback();
				layer.close(index);//查询框关闭
			}
		});
	}else {
		callback();
	}
};
/**
 * 判断路由
 * 
 * @param dataJson
 * @returns {___anonymous1215_5418}
 */
BpmButton.prototype.getConditions = function(dataJson) {
	return {
		// 分支
		isBranch : function() {
			if (dataJson.nextTask != null && dataJson.nextTask.length > 1) {// 分支
				return true;
			} else {// 非分支
				return false;
			}
		},
		// 选人方式
		isUserSelectTypeAuto : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.userSelectType) {
				if (dataJson.nextTask[branchNo].currentActivityAttr.userSelectType == 'auto') {
					return true;// 自动选人方式
				} else {
					return false;
				}
			} else {
				return false;// 手动选人方式
			}
		},
		// 是否启用工作移交
		isWorkHandUser : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isWorkHandUser) {
				if (dataJson.nextTask[branchNo].currentActivityAttr.isWorkHandUser == 'no') {
					return false;// 启用
				} else {
					return true;// 不启用
				}
			} else {// 默认
				return true;// 不启用
			}
		},
		// 处理方式
		getDealType : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.dealType) {
				return dataJson.nextTask[branchNo].currentActivityAttr.dealType;
			}
			return "2";
		},
		// 处理方式
		getSingle : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.single) {
				return dataJson.nextTask[branchNo].currentActivityAttr.single;
			}
			return "no";
		},
		// 是否必须选人
		isMustUser : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isMustUser) {
				if (dataJson.nextTask[branchNo].currentActivityAttr.isMustUser == 'no') {// 必须选人
					return false;
				} else {
					return true;// 必须选人
				}
			} else {
				return true;// 默认值
			}
		},
		// 是否启用密级
		isSecret : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isSecret) {
				if (dataJson.nextTask[branchNo].currentActivityAttr.isMustUser == 'yes') {// 启用
					return true;
				} else {
					return false;// 不启用
				}
			} else {
				return false;// 不启用
			}
		},
		// 意见添写方式
		getIdeaType : function() {
			if (dataJson.currentActivityAttr.ideaType) {
				return dataJson.currentActivityAttr.ideaType;
			}
			return "";
		},
		// 是否强制表态
		isIdeaCompelManner : function() {
			if (dataJson.currentActivityAttr.ideaCompelManner) {
				if (dataJson.currentActivityAttr.ideaCompelManner == 'yes') {// 强制
					return true;
				} else {
					return false;// 不强制
				}
			} else {
				return false;// 不强制
			}
		},
		// 退回意见是否必填
		isNeedIdea : function() {
			if (dataJson.currentActivityAttr.isNeedIdea) {
				if (dataJson.currentActivityAttr.isNeedIdea == 'no') {// 强制
					return false;
				} else {
					return true;// 不强制
				}
			} else {
				return true;// 不强制
			}
		},
		// 是否显示选人框
		isSelectUser : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isSelectUser) {
				if (dataJson.nextTask[branchNo].currentActivityAttr.isSelectUser == 'no') {// 不显示
					return false;
				} else {
					return true;// 显示
				}
			} else {
				return true;// 显示
			}
		},
		/**
		 * 是否自动获取用户
		 */
		isAutoGetUser : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isAutoGetUser) {
				if (dataJson.nextTask[branchNo].currentActivityAttr.isAutoGetUser == 'no') {// 不显示
					return false;
				} else {
					return true;// 是
				}
			} else {
				return false;
			}
		},
		// 获取下节点类型
		getNextActivityType : function() {
			return dataJson.activityType;
		},
		//是否是自由流程
		isUflow : function(){
			return dataJson.isUflow == "2";
		}
		
	}
};;
///<jscompress sourcefile="BpmAdduser.js" />
/**
 * 流程增发
 */
function BpmAdduser(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doadduser, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_adduser";
	this.getHtml();
};
BpmAdduser.prototype = new BpmButton();
/**
 * 执行
 */
BpmAdduser.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeAdduser(this.data)){
		return;
	}
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : _self.data.procinstDbid,
			executionId : _self.data.executionId,
			taskId : _self.data.taskId,
			outcome : _self.data.name,
			targetActivityName : _self.data.targetActivityName,
			type : 'doadduser'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				new BpmActor(_self.data, result.taskUserSelect, _self).open();
			}
		}
	});
};
/**
 * 
 * @param data
 * @param users
 */
BpmAdduser.prototype.submit = function(data, users) {
	if(!flowUtils.notNull(users) || users.length == 0){
		flowUtils.warning("选人错误");
		return;
	}
	var _self = this;
	var userJson = {
		users : users,
		idea : _self.getIdeaText(),
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/dosupplementassignee",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson),
			opType : 'doadduser'
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				flowUtils.success("加签成功");
				if(_self.isEvent){
					flowUtils.refreshCurrentBack();
				}
				try{
					_self.flowEditor.defaultForm.afterAdduser(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
//				flowUtils.refreshBack();
			}
		}
	});
};;
///<jscompress sourcefile="BpmFocus.js" />
/**
 * 关注工作
 */
function BpmFocus(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dofocus, isEvent);
	this.domeId = "bpm_focus";
	this.getHtml();
};
BpmFocus.prototype = new BpmButton();
/**
 * 执行
 */
BpmFocus.prototype.execute = function() {
	avicAjax.ajax({
		url : "platform/bpm/business/setFocusedTask",
		data : {
			processInstanceId : this.flowEditor.flowModel.entryId,
			dbid : this.flowEditor.flowModel.taskId
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				if (msg.mes == false) {
					flowUtils.success("该任务此前已被关注");
				} else {
					flowUtils.success("已成功关注该任务");
				}
			}
		}
	});
};
BpmFocus.prototype.getHtml = function() {
	if (this.isEnable()) {
		var _self = this;
		$("#" + this.domeId).off("click");
		$("#" + this.domeId).on("click", function() {
			_self.execute()
		});
		$("#" + this.domeId).show();
	} else {
		$("#" + this.domeId).hide();
		$("#" + this.domeId).off("click");
	}
};;
///<jscompress sourcefile="BpmGlobalend.js" />
/**
 * 流程结束
 */
function BpmGlobalend(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalend, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_globalend";
	this.getHtml();
};
BpmGlobalend.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobalend.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeGlobalend(this.data)){
		return;
	}
	var _self = this;
	flowUtils.confirm("流程一旦结束将无法恢复，您确定结束该流程吗？", function() {
		avicAjax.ajax({
			url : "platform/bpm/business/doend",
			data : {
				executionId : _self.data.executionId,
				message : _self.getIdeaText()
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					flowUtils.success("操作成功！表单将自动关闭", function() {
						flowUtils.refreshBack();
						flowUtils.closeWindowOnDialog();
                        setTimeout(function(){
                            _self.flowEditor.createButtons();
                        },500);
					}, true);
					try{
						_self.flowEditor.defaultForm.afterGlobalend(_self.data);
					}catch(e){
						
					}
				}
			}
		});
	});
};
;
///<jscompress sourcefile="BpmGlobaljump.js" />
/**
 * 流程跳转
 */
function BpmGlobaljump(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobaljump, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_globaljump";
	this.getHtml();
};
BpmGlobaljump.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobaljump.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeGlobaljump(this.data)){
		return;
	}
	var _self = this;
	this.jumpTaskDialog = layer.open({
		type : 2,
		title : "跳转节点选择",
		area : [ "800px", "450px" ],
		content : flowUtils.graphPath + "?entryId=" + _self.data.procinstDbid + "&type=doglobaljump"
	});
	if(this.isEvent){
		//如果不是审批页面， 最大化
		layer.full(this.jumpTaskDialog);
	}
	window.bpmGlobaljump = this;
};
/**
 * 执行
 */
BpmGlobaljump.prototype.callback = function(executionId, targetActivityName) {
	layer.close(this.jumpTaskDialog);
	var data = flowUtils.clone(this.data);
	if(flowUtils.notNull(executionId)){
		data.executionId = executionId;
	}
	data.targetActivityName = targetActivityName;
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			taskId : data.taskId,
			outcome : data.name,
			targetActivityName : data.targetActivityName,
			type : 'doglobaljump'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				new BpmActor(data, result.taskUserSelect, _self).open();
			}
		}
	});
};
/**
 * 
 * @param data
 * @param users
 */
BpmGlobaljump.prototype.submit = function(data, users) {
	if(!flowUtils.notNull(users) || users.length == 0){
		flowUtils.warning("选人错误");
		return;
	}
	var _self = this;
	var userJson = {
		users : users,
		idea : _self.getIdeaText(),
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/dojump",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson),
			activityName : data.targetActivityName
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				if(_self.isEvent){
					flowUtils.success("跳转成功");
					flowUtils.refreshCurrentBack();
				}else{
					flowUtils.success("跳转成功！表单将自动关闭", function() {
						flowUtils.refreshBack();
						flowUtils.closeWindowOnDialog();
                        setTimeout(function(){
                            _self.flowEditor.createButtons();
                        },500);
					}, true);
				}
				try{
					_self.flowEditor.defaultForm.afterGlobaljump(data);
				}catch(e){
					
				}
			}
		}
	});
};;
///<jscompress sourcefile="BpmGlobalidea.js" />
/**
 * 流程意见修改
 */
function BpmGlobalidea(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalidea, isEvent);
	this.domeId = "bpm_globalidea";
	this.getHtml();
	this.lastIndex = -1;
};
BpmGlobalidea.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobalidea.prototype.execute = function() {
	var _self = this;
	layer.open({
		type : 1,
		title : "修改意见",
		area : [ "800px", "450px" ],
		content : "<table id='ideaTable'></table>",
		btn : [ '确定', '关闭' ],
		success : function(layero, index) {
			$("#ideaTable").datagrid({
				url : "platform/bpm/business/doGettracksByPage?entryId=" + _self.data.procinstDbid,
				method : "POST",
				idField : "dbid",
				columns : [[ {
					field : 'dbid',
					hidden : true
				}, {
					title : '节点',
					field : 'currentActiveLabel',
					align : 'center',
					width : 100
				}, {
					title : '处理人',
					field : 'assigneeName',
					align : 'center',
					width : 80
				}, {
					title : '接收时间',
					field : 'iTime',
					align : 'center',
					width : 110
				}, {
					title : '处理时间',
					field : 'eTime',
					align : 'center',
					width : 110
				}, {
					title : '操作类型',
					field : 'opType',
					align : 'center',
					width : 80
				}, {
					title : '处理意见',
					field : 'message',
					editor : "text",
					width : 200
				} ]],
				rownumbers : true,
				striped : true,
				fitColumns : true,
				onClickCell:function(rowIndex,field,value){
					if(field == 'message'){
						if (_self.lastIndex != rowIndex){
							$('#ideaTable').datagrid('endEdit', _self.lastIndex);
							$('#ideaTable').datagrid('beginEdit', rowIndex);
						}
						_self.lastIndex = rowIndex;
					}
				}
			});
		},
		yes : function(index, layero) {
			$('#ideaTable').datagrid('endEdit', _self.lastIndex);
			var data = $('#ideaTable').datagrid('getChanges');
			avicAjax.ajax({
				url : 'platform/bpm/business/saveGettracks',
				data : {
					data : JSON.stringify(data),
					processInstanceId : _self.data.procinstDbid
				},
				type : 'post',
				dataType : 'json',
				success : function(msg) {
					if (flowUtils.notNull(msg.error)) {
						flowUtils.error(msg.error);
					} else {
						flowUtils.success("修改成功");
						layer.close(index);
						_self.flowEditor.refreshTracks();
					}
				}
			});
		}
	});
};;
///<jscompress sourcefile="BpmGlobalresume.js" />
/**
 * 流程恢复
 */
function BpmGlobalresume(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalresume, isEvent);
	this.domeId = "bpm_globalresume";
	this.getHtml();
};
BpmGlobalresume.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobalresume.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeGlobalresume(this.data)){
		return;
	}
	var _self = this;
	flowUtils.confirm("您确定恢复该流程吗？", function() {
		avicAjax.ajax({
			url : "platform/bpm/business/doresume",
			data : {
				processInstanceId : _self.data.procinstDbid
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					flowUtils.success("操作成功");
					try{
						_self.flowEditor.defaultForm.afterGlobalresume(_self.data);
					}catch(e){
						
					}
					_self.flowEditor.createButtons();
					flowUtils.refreshBack();
				}
			}
		});
	});
};;
///<jscompress sourcefile="BpmGlobalsuspend.js" />
/**
 * 流程暂停
 */
function BpmGlobalsuspend(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalsuspend, isEvent);
	this.domeId = "bpm_globalsuspend";
	this.getHtml();
};
BpmGlobalsuspend.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobalsuspend.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeGlobalsuspend(this.data)){
		return;
	}
	var _self = this;
	flowUtils.confirm("您确定暂停该流程吗？", function() {
		avicAjax.ajax({
			url : "platform/bpm/business/dosuspend",
			data : {
				processInstanceId : _self.data.procinstDbid
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					flowUtils.success("操作成功!");
					try{
						_self.flowEditor.defaultForm.afterGlobalsuspend(_self.data);
					}catch(e){
						
					}
					_self.flowEditor.createButtons();
					flowUtils.refreshBack();
				}
			}
		});
	});
};;
///<jscompress sourcefile="BpmRetreat.js" />
/**
 * 流程退回，包括退回上一步和退回拟稿人
 */
function BpmRetreat(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
	this.doretreattodraft = buttonData.doretreattodraft;
	this.doretreattoprev = buttonData.doretreattoprev;
	this.doretreattowant = buttonData.doretreattowant;
	this.doretreattoactivity = buttonData.doretreattoactivity;
	if (flowUtils.notNull(this.doretreattodraft) || flowUtils.notNull(this.doretreattoprev) || flowUtils.notNull(this.doretreattowant) || flowUtils.notNull(this.doretreattoactivity)) {
		this.enable = true;
		this.flowEditor.needIdeaText = true;
	}
	this.getHtml();
};
BpmRetreat.prototype = new BpmButton();
/**
 * 执行
 */
BpmRetreat.prototype.executeTodraft = function() {
	if (!this.flowEditor.defaultForm.beforeRetreat(this.doretreattodraft)) {
		return;
	}
	var _self = this;
	// 自动保存
	if (this.flowEditor.defaultForm.isAutoSave && this.flowEditor.bpmSave.isEnable()) {
		this.flowEditor.defaultForm.save(function() {
			_self.executeTodraftBack();
			_self.flowEditor.createButtons();
		});
	} else {
		this.validIdeasBySelf("2", function () {
			_self.executeTodraftBack();
		});
	}
};
BpmRetreat.prototype.executeTodraftBack = function() {
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : _self.doretreattodraft.procinstDbid,
			executionId : _self.doretreattodraft.executionId,
			taskId : _self.doretreattodraft.taskId,
			outcome : _self.doretreattodraft.name,
			targetActivityName : _self.doretreattodraft.targetActivityName,
			type : 'doretreattodraft'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				_self.validJsonData(_self.doretreattodraft, result.taskUserSelect, "确定退回拟稿人吗？");
			}
		}
	});

	/**
	 * 回调
	 * 
	 * @param data
	 * @param users
	 */
	this.submit = function(data, users) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
		var idea = _self.getIdeaText();
		if(flowUtils.notNull(this.ideas_text)){
			idea = this.ideas_text + " " + idea;
		}
		var userJson = {
			users : users,
			idea : idea,
			compelManner : "",
			outcome : data.name
		};
		avicAjax.ajax({
			url : "platform/bpm/business/dobacktofirst",
			data : {
				procinstDbid : data.procinstDbid,
				executionId : data.executionId,
				userJson : JSON.stringify(userJson)
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					if(_self.isEvent){
						flowUtils.success("退回成功");
						flowUtils.refreshCurrentBack();
					}else{
						flowUtils.success("退回成功！表单将自动关闭", function() {
							flowUtils.refreshBack();
							flowUtils.closeWindowOnDialog();
                            setTimeout(function(){
                                _self.flowEditor.createButtons();
                            },500);
						}, true);
					}
					try {
						_self.flowEditor.defaultForm.afterRetreat(data);
					} catch (e) {

					}
				}
			}
		});
	};
};
BpmRetreat.prototype.executeToprev = function() {
	if (!this.flowEditor.defaultForm.beforeRetreat(this.doretreattoprev)) {
		return;
	}
	var _self = this;
	// 自动保存
	if (this.flowEditor.defaultForm.isAutoSave && this.flowEditor.bpmSave.isEnable()) {
		this.flowEditor.defaultForm.save(function() {
			_self.executeToprevBack();
			_self.flowEditor.createButtons();
		});
	} else {
		this.validIdeasBySelf("2", function () {
			_self.executeToprevBack();
		});
	}
};
BpmRetreat.prototype.executeToprevBack = function() {
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : _self.doretreattoprev.procinstDbid,
			executionId : _self.doretreattoprev.executionId,
			taskId : _self.doretreattoprev.taskId,
			outcome : _self.doretreattoprev.name,
			targetActivityName : _self.doretreattoprev.targetActivityName,
			type : 'doretreattoprev'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				_self.validJsonData(_self.doretreattoprev, result.taskUserSelect, "确定退回上一步吗？");
			}
		}
	});
	/**
	 * 回调
	 */
	this.submit = function(data, users) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
		var idea = _self.getIdeaText();
		if(flowUtils.notNull(this.ideas_text)){
			idea = this.ideas_text + " " + idea;
		}
		var userJson = {
			users : users,
			idea : idea,
			compelManner : "",
			outcome : data.name
		};
		avicAjax.ajax({
			url : "platform/bpm/business/dobacktoprev",
			data : {
				procinstDbid : data.procinstDbid,
				executionId : data.executionId,
				userJson : JSON.stringify(userJson)
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					if(_self.isEvent){
						flowUtils.success("退回成功");
						flowUtils.refreshCurrentBack();
					}else{
						flowUtils.success("退回成功！表单将自动关闭", function() {
							flowUtils.refreshBack();
							flowUtils.closeWindowOnDialog();
                            setTimeout(function(){
                                _self.flowEditor.createButtons();
                            },500);
						}, true);
					}
					try {
						_self.flowEditor.defaultForm.afterRetreat(data);
					} catch (e) {

					}
				}
			}
		});
	};
};
BpmRetreat.prototype.executeTowant = function() {
	if (!this.flowEditor.defaultForm.beforeRetreat(this.doretreattowant)) {
		return;
	}
	var _self = this;
	// 自动保存
	if (this.flowEditor.defaultForm.isAutoSave && this.flowEditor.bpmSave.isEnable()) {
		this.flowEditor.defaultForm.save(function() {
			_self.executeTowantSelectTask();
			_self.flowEditor.createButtons();
		});
	} else {
		this.validIdeasBySelf("2", function () {
			_self.executeTowantSelectTask();
		});
	}
};
BpmRetreat.prototype.executeTowantSelectTask = function(){
	var _self = this;
	this.retreattowantDialog = layer.open({
		type : 2,
		title : "任意退回节点选择",
		area : [ "800px", "450px" ],
		content : flowUtils.graphPath + "?entryId=" + _self.doretreattowant.procinstDbid + "&type=doretreattowant"
	});
	if(this.isEvent){
		//如果不是审批页面， 最大化
		layer.full(this.retreattowantDialog);
	}
	window.bpmRetreatToWant = this;
};

BpmRetreat.prototype.callback = function(targetActivityName) {
	layer.close(this.retreattowantDialog);
	var data = flowUtils.clone(this.doretreattowant);
	data.targetActivityName = targetActivityName;
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			taskId : data.taskId,
			outcome : data.name,
			targetActivityName : data.targetActivityName,
			type : 'doretreattowant'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				_self.validJsonData(data, result.taskUserSelect, "确定退回吗？");
			}
		}
	});

	/**
	 * 回调
	 * 
	 * @param data
	 * @param users
	 */
	this.submit = function(data, users) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
		var idea = _self.getIdeaText();
		if(flowUtils.notNull(this.ideas_text)){
			idea = this.ideas_text + " " + idea;
		}
		var userJson = {
			users : users,
			idea : idea,
			compelManner : "",
			outcome : data.name
		};
		avicAjax.ajax({
			url : "platform/bpm/business/dobacktowant",
			data : {
				procinstDbid : data.procinstDbid,
				executionId : data.executionId,
				userJson : JSON.stringify(userJson),
				activityName : data.targetActivityName
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					if(_self.isEvent){
						flowUtils.success("退回成功");
						flowUtils.refreshCurrentBack();
					}else{
						flowUtils.success("退回成功！表单将自动关闭", function() {
							flowUtils.refreshBack();
							flowUtils.closeWindowOnDialog();
                            setTimeout(function(){
                                _self.flowEditor.createButtons();
                            },500);
						}, true);
					}
					try {
						_self.flowEditor.defaultForm.afterRetreat(data);
					} catch (e) {

					}
				}
			}
		});
	};
};

BpmRetreat.prototype.executeToactivity = function(targetActivityName) {
	if (!this.flowEditor.defaultForm.beforeRetreat(this.doretreattoactivity)) {
		return;
	}
	var _self = this;
	// 自动保存
	if (this.flowEditor.defaultForm.isAutoSave && this.flowEditor.bpmSave.isEnable()) {
		this.flowEditor.defaultForm.save(function() {
			_self.executeToactivityBack(targetActivityName);
			_self.flowEditor.createButtons();
		});
	} else {
		this.validIdeasBySelf("2", function () {
			_self.executeToactivityBack(targetActivityName);
		});
	}
};

BpmRetreat.prototype.executeToactivityBack = function(targetActivityName) {
	var data = flowUtils.clone(this.doretreattoactivity);
	data.targetActivityName = targetActivityName;
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			taskId : data.taskId,
			outcome : data.name,
			targetActivityName : data.targetActivityName,
			type : 'doretreattoactivity'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				_self.validJsonData(data, result.taskUserSelect, "确定退回吗？");
			}
		}
	});

	/**
	 * 回调
	 * 
	 * @param data
	 * @param users
	 */
	this.submit = function(data, users) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
		var idea = _self.getIdeaText();
		if(flowUtils.notNull(this.ideas_text)){
			idea = this.ideas_text + " " + idea;
		}
		var userJson = {
			users : users,
			idea : idea,
			compelManner : "",
			outcome : data.name
		};
		avicAjax.ajax({
			url : "platform/bpm/business/dobacktoactivity",
			data : {
				procinstDbid : data.procinstDbid,
				executionId : data.executionId,
				userJson : JSON.stringify(userJson),
				activityName : data.targetActivityName
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					if(_self.isEvent){
						flowUtils.success("退回成功");
						flowUtils.refreshCurrentBack();
					}else{
						flowUtils.success("退回成功！表单将自动关闭", function() {
							flowUtils.refreshBack();
							flowUtils.closeWindowOnDialog();
                            setTimeout(function(){
                                _self.flowEditor.createButtons();
                            },500);
						}, true);
					}
					try {
						_self.flowEditor.defaultForm.afterRetreat(data);
					} catch (e) {

					}
				}
			}
		});
	};
};

/**
 * 校验数据
 * 
 * @param data
 * @param taskUserSelect
 */
BpmRetreat.prototype.validJsonData = function(data, taskUserSelect, message) {
	var _self = this;
	if (flowUtils.notNull(taskUserSelect)) {
		// 初始化路由对象
		this.conditions = this.getConditions(taskUserSelect);
		if (this.validIdeaMust()) {
			if (this.conditions.isBranch()) {
				new BpmActor(data, taskUserSelect, this).open();
			} else {
				flowUtils.confirm(message, function() {
					var user = new BpmActor(data, taskUserSelect, _self).getUsers();
					_self.submit(data, user);
				});
			}
		}
	}
};
/**
 * 流程填写意见判断
 * 
 * @returns {Boolean}
 */
BpmRetreat.prototype.validIdeaMust = function() {
	if(this.isEvent){
		return true;
	}
	if (this.conditions.isNeedIdea()) {// 意见必须填写
		var ideaText = this.getIdeaText();
		if (!flowUtils.notNull(ideaText)) {
			flowUtils.warning('请填写流程意见');
			this.focusIdeaText();
			return false;
		}
	}
	return true;
};
BpmRetreat.prototype.getHtml = function() {
	if(this.isEvent){
		return true;
	}
	if (this.isEnable()) {
		var _self = this;
		var button = $('<button class="listBtn grey btn btn-default dropdown-toggle" type="button" id="dropmenu_retreat" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt">退回</span><i></i></button>');
		var ul = $('<ul class="dropdown-menu" aria-labelledby="dropmenu_retreat">');
		if(this.doretreattodraft != null){
			var li_draft = $('<li></li>');
			var a_draft = $('<a href="javascript:void(0);">' + this.doretreattodraft.lable + '</a>');
			a_draft.on("click", function() {
				_self.executeTodraft();
			});
			li_draft.append(a_draft);
			ul.append(li_draft);
		}
		if(this.doretreattoprev != null){
			var li_prev = $('<li></li>');
			var a_prev = $('<a href="javascript:void(0);">' + this.doretreattoprev.lable + '</a>');
			a_prev.on("click", function() {
				_self.executeToprev();
			});
			li_prev.append(a_prev);
			ul.append(li_prev);
		}
		if(this.doretreattowant != null){
			var li_want = $('<li></li>');
			var a_want = $('<a href="javascript:void(0);">' + this.doretreattowant.lable + '</a>');
			a_want.on("click", function() {
				_self.executeTowant();
			});
			li_want.append(a_want);
			ul.append(li_want);
		}
		if(this.doretreattoactivity != null){
			var activityArr = this.doretreattoactivity.targetName.split(",");
			var activityNameArr = this.doretreattoactivity.lable.split(",");
			$.each(activityArr, function(k, m){
				var li_activity = $('<li></li>');
				var a_activity = $('<a href="javascript:void(0);">退回到【' + activityNameArr[k] + '】节点</a>');
				a_activity.on("click", function() {
					_self.executeToactivity(m);
				});
				li_activity.append(a_activity);
				ul.append(li_activity);
			});
		}
		$("#bpm_buttons_default1").append(button);
		$("#bpm_buttons_default1").append(ul);
	}
};;
///<jscompress sourcefile="BpmSave.js" />
/**
 * 保存
 */
function BpmSave(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
	this.data = buttonData.doformsave;
	if (this.flowEditor.isStart || flowUtils.notNull(this.data)) {
		this.enable = true;
	}
	this.domeId = "bpm_save";
	this.getHtml();
};
BpmSave.prototype = new BpmButton();
/**
 * 禁用标志
 * @type {boolean}
 */
BpmSave.prototype.disabled = false;
/**
 * 执行
 */
BpmSave.prototype.execute = function() {
	var _self = this;
	if(this.disabled){
		return;
	}
	this.disabled = true;
	setTimeout(function(){
		_self.disabled = false;
	},2000);

	if (this.flowEditor.isStart) {
		this.defaultForm.start(this.flowEditor.flowModel.defineId, function(startResult) {
			//flowUtils.success("");
			_self.flowEditor.afterStart(startResult);
			_self.flowEditor.createButtons();
			flowUtils.refreshBack();
		});
	} else {
		var _self = this;
		this.defaultForm.save(function() {
			//flowUtils.success("");
			_self.flowEditor.createButtons();
			//flowUtils.refreshBack();
		});
	}
};
BpmSave.prototype.getHtml = function() {
	if (this.isEnable()) {
		var _self = this;
		$("#" + this.domeId).off("click");
		$("#" + this.domeId).on("click", function() {
			_self.execute()
		});
		$("#" + this.domeId).show();
	} else {
		$("#" + this.domeId).hide();
		$("#" + this.domeId).off("click");
	}
};;
///<jscompress sourcefile="BpmStepuserdefined.js" />
/**
 * 自定义选人
 */
function BpmStepuserdefined(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dostepuserdefined, isEvent);
	this.domeId = "bpm_stepuserdefined";
	this.getHtml();
};
BpmStepuserdefined.prototype = new BpmButton();
/**
 * 执行
 */
BpmStepuserdefined.prototype.execute = function() {
	if (!this.flowEditor.defaultForm.beforeStepuserdefined(this.data)) {
		return;
	}
	var _self = this;
	this.stepuserdefinedDialog = layer.open({
		type : 2,
		title : "自定义审批人",
		area : [ "800px", "450px" ],
		content : flowUtils.graphPath + "?entryId=" + _self.data.procinstDbid + "&type=dostepuserdefined"
	});
	if(this.isEvent){
		//如果不是审批页面， 最大化
		layer.full(this.stepuserdefinedDialog);
	}
	window.bpmStepuserdefined = this;
};
/**
 * 执行
 */
BpmStepuserdefined.prototype.callback = function(activityName) {
	var data = flowUtils.clone(this.data);
	data.activityName = activityName;
	data.targetActivityName = activityName;
	new BpmActor(data, null, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmStepuserdefined.prototype.submit = function(data, users) {
	if (!flowUtils.notNull(users) || users.length == 0) {
		flowUtils.warning("选人错误");
		return;
	}
	var userJson = {
		users : users,
		idea : "",
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/douserdefined",
		data : {
			procinstDbid : data.procinstDbid,
			userJson : JSON.stringify(userJson),
			activityName : data.activityName
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				flowUtils.success("操作成功");
				try {
					_self.flowEditor.defaultForm.afterStepuserdefined(data);
				} catch (e) {

				}
			}
		}
	});
};;
///<jscompress sourcefile="BpmSubmit.js" />
/**
 * 提交，多个提交合成一个
 */
function BpmSubmit(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
	this.data = buttonData.dosubmit;
	this.transmitData = buttonData.dotransmitsubmit;
	if (this.flowEditor.isStart || flowUtils.notNull(this.data) || flowUtils.notNull(this.transmitData)) {
		this.enable = true;
	}
	if(flowUtils.notNull(buttonData.dosubmit) && flowUtils.notNull(buttonData.dosubmit[0].attribute) && flowUtils.notNull(buttonData.dosubmit[0].attribute.ideaElementIdBySelf)){
        this.ideaElementIdBySelf = buttonData.dosubmit[0].attribute.ideaElementIdBySelf;
	}
	//有提交按钮并且没有自定义意见框，则显示默认意见框
	if(this.enable && !this.hasIdeaElementBySelf()){
        this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_submit";
	this.getHtml();
	//是否是启动流程后的自动点击事件
    this.isAutoClickAfterStart = false;
};
BpmSubmit.prototype = new BpmButton();

/**
 * 禁用标志
 * @type {boolean}
 */
BpmSubmit.prototype.disabled = false;
/**
 * 执行
 */
BpmSubmit.prototype.execute = function(data) {
	var _self = this;
    if(this.disabled){
    	return;
	}
	this.disabled = true;
    setTimeout(function(){
        _self.disabled = false;
    },2000);

	if (this.flowEditor.isStart) {
		this.defaultForm.start(this.flowEditor.flowModel.defineId, function(startResult) {
			_self.flowEditor.afterStart(startResult);
			_self.flowEditor.createButtons(true);
			flowUtils.refreshBack();
		});
	} else {
		if (!this.flowEditor.defaultForm.beforeSubmit(data)) {
			return;
		}
		// 自动保存
		if (!this.isAutoClickAfterStart && !this.isEvent && this.flowEditor.defaultForm.isAutoSave && this.flowEditor.bpmSave.isEnable()) {
			this.flowEditor.defaultForm.save(function() {
				_self.flowEditor.createButtons(true, data.name);
			});
		} else {
			this.validIdeasBySelf("1", function () {
				_self.executeBack(data);
			});
		}
	}
};
BpmSubmit.prototype.executeBack = function(data) {
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			taskId : data.taskId,
			outcome : data.name,
			targetActivityName : data.targetActivityName,
			type : 'dosubmit'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				_self.validJsonData(data, result.taskUserSelect);
			}
		}
	});
};
/**
 * 校验数据并调用选人框
 * 
 * @param taskUserSelect
 */
BpmSubmit.prototype.validJsonData = function(data, taskUserSelect) {
	debugger;
	var _self = this;
	if (flowUtils.notNull(taskUserSelect)) {
		debugger;
		// 初始化路由对象
		this.conditions = this.getConditions(taskUserSelect);
		//强制表态
		if(!this.isEvent && this.conditions.isIdeaCompelManner()){
			if($(".bpm_compelManner_div input[name='bpm_compelManner']:checked").length == 0){
				$(".bpm_compelManner_div").show();
				flowUtils.warning("请您表态");
				return;
			}
		}
		if (this.validIdeaMust()) {
			var nextActivityType = this.conditions.getNextActivityType();
			if (nextActivityType) {
				if (nextActivityType == "end") {// 下一节点为流程流转结束(归档)
					flowUtils.confirm("确定提交吗？", function() {
						_self.submit(data, [], true);
					});
					return;
				} else if(nextActivityType == 'sub-process'){
					//子流程
					if(!this.conditions.isMustUser()){
						flowUtils.confirm("确定提交吗？", function() {
							_self.submit(data, [], true);
						});
						return;
					}
				} else if(nextActivityType == 'foreach'){
					//循环节点
					if(!this.conditions.isMustUser()){
						flowUtils.confirm("确定提交吗？", function() {
							_self.submit(data, [], true);
						});
						return;
					}
				} else if (nextActivityType == 'task') {
					// 非分支
					if (!this.conditions.isBranch()) {
						// 不显示选人框&&自动选人
						if (!this.conditions.isSelectUser() && this.conditions.isUserSelectTypeAuto()) {
							flowUtils.confirm("确定提交吗？", function() {
								var user = new BpmActor(data, taskUserSelect, _self).getUsers();
								_self.submit(data, user);
							});
							return;
						} else {
							// 不需要显示选人框
							if (!this.conditions.isSelectUser()) {
								flowUtils.warning("配置错误：配置不显示选人框，但未配置自动选人");
								return;
							}
						}
					}
				}
				new BpmActor(data, taskUserSelect, this, this.conditions.isUflow()).open();
			} else if (!taskUserSelect.nextTask) {
				// 填写意见提交
				flowUtils.confirm("确定提交吗？", function() {
					_self.submit(data, [], true);
				});
			}
		}
	}
};
/**
 * 流程填写意见判断
 * 
 * @returns {Boolean}
 */
BpmSubmit.prototype.validIdeaMust = function() {
	if (!this.isEvent && this.conditions.getIdeaType() == 'must') {// 意见必须填写
		var ideaText = this.getIdeaText();
		if (!flowUtils.notNull(ideaText)) {
			flowUtils.warning('请填写流程意见');
			this.focusIdeaText();
			return false;
		}
	}
	return true;
};
/**
 * 提交
 */
BpmSubmit.prototype.submit = function(data, users, canBlank, uflowDealType) {
	debugger;
	if (!canBlank) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
	}
	var idea = this.isEvent ? "同意" : this.getIdeaText();

	//重新组织意见
	idea = this.flowEditor.defaultForm.reGetidea(idea, users);

	var compelManner = "";
	if(this.conditions.isIdeaCompelManner()){
		if(this.isEvent){
			compelManner = "yes";
		}else{
			compelManner = $(".bpm_compelManner_div input[name='bpm_compelManner']:checked").val();
		}
	}
	if(flowUtils.notNull(this.ideas_text)){
		idea = this.ideas_text + " " + idea;
	}
	var userJson = {
		users : users,
		idea : idea,
		compelManner : compelManner,
		outcome : data.name
	};
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/dosubmit",
		data : {
			instanceId : data.procinstDbid,
			taskId : data.taskId,
			userJson : JSON.stringify(userJson),
			outcome : data.name,
			formJson : null,
			uflowDealType : uflowDealType,
			isUflow : this.conditions.isUflow()
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				if(_self.isEvent){
					flowUtils.success("提交成功！", function() {
						flowUtils.refreshCurrentBack();
					}, true);
				}else{
					flowUtils.success("提交成功！表单将自动关闭", function() {
						flowUtils.refreshBack();
						flowUtils.closeWindowOnDialog();
						setTimeout(function(){
							_self.flowEditor.createButtons();
						},500);
					}, true);
				}
				try {
					_self.flowEditor.defaultForm.afterSubmit(data);
				} catch (e) {

				}
			}
		}
	});
};
BpmSubmit.prototype.getHtml = function() {
	if (this.isEnable() && !this.isEvent) {
		var _self = this;
		if (this.data != null && this.data.length > 1) {
			//多条分支
			var button = $('<button class="listBtn btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt">提交</span><i></i></button>');
			button.attr("id", this.domeId);
			var ul = $('<ul class="dropdown-menu" aria-labelledby="' + this.domeId + '">');
			$.each(this.data, function(n, value) {
				var li = $('<li></li>');
				var a = $('<a href="javascript:void(0);">' + value.lable + '</a>');
				a.attr("title", value.description);
				a.on("click", function() {
					_self.execute(value);
				});
				li.append(a);
				ul.append(li);
				if(flowUtils.notNull(value.attribute)){
					if("yes" == value.attribute.ideaCompelManner){
						//$(".bpm_compelManner_div input[name='bpm_compelManner']").removeAttr("checked");
						$(".bpm_compelManner_div").show();
					}
				}
			});
			$("#bpm_buttons_default2").append(button);
			$("#bpm_buttons_default2").append(ul);
		} else if (this.data != null) {
			var data = this.data[0];
			var button = $('<button class="listBtn btn btn-default dropdown-toggle center" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt">提交</span></button>');
			button.attr("id", this.domeId);
			button.attr("title", data.description);
			button.on("click", function() {
				_self.execute(data);
			});
			$("#bpm_buttons_default2").append(button);
			if(flowUtils.notNull(data.attribute)){
				if("yes" == data.attribute.ideaCompelManner){
					//$(".bpm_compelManner_div input[name='bpm_compelManner']").removeAttr("checked");
					$(".bpm_compelManner_div").show();
				}
			}
		} else if (this.transmitData != null) {
			//完成传阅
			var button = $('<button class="listBtn btn btn-default dropdown-toggle center" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt">提交</span></button>');
			button.attr("id", this.domeId);
			button.attr("title", "填写意见");
			button.on("click", function() {
				_self.executeTransmit();
			});
			$("#bpm_buttons_default2").append(button);
		} else {
			//启动流程
			var button = $('<button class="listBtn btn btn-default dropdown-toggle center" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt" id="bpm_firsttasksubmitname">提交</span></button>');
			button.attr("id", this.domeId);
			button.on("click", function() {
				_self.execute();
			});
			$("#bpm_buttons_default2").append(button);
			if(flowUtils.notNull(this.flowEditor.ideaCompelManner)){
				if("yes" == this.flowEditor.ideaCompelManner){
					//$(".bpm_compelManner_div input[name='bpm_compelManner']").removeAttr("checked");
					$(".bpm_compelManner_div").show();
				}
			}
            $.ajax({
                url:"platform/bpm/business/getFirstTaskSubmitName",
                data : {},
                type : "POST",
                dataType : "TEXT",
                success : function(msg) {
                    if(flowUtils.notNull(msg)){
                        $("#bpm_firsttasksubmitname").html(msg);
                    }
                }
            });
		}
	}
};
/**
 * 完成传阅
 */
BpmSubmit.prototype.executeTransmit = function() {
	var _self = this;
	flowUtils.confirm("确定提交吗？", function() {
		_self.submitTransmit();
	});
};
BpmSubmit.prototype.submitTransmit = function() {
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/dosubmitTransmit",
		data : {
			instanceId : this.transmitData.procinstDbid,
			message : this.getIdeaText(),
			taskId : this.transmitData.taskId
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				flowUtils.success("提交成功！表单将自动关闭", function() {
					flowUtils.refreshBack();
					flowUtils.closeWindowOnDialog();
                    setTimeout(function(){
                        _self.flowEditor.createButtons();
                    },500);
				}, true);
			}
		}
	});
};
/**
 * 流程启动之后自动点击一次提交按钮,或者触发保存之后再来调用提交
 */
BpmSubmit.prototype.clickBut = function(outcome) {
	if (this.isEnable()) {
		if(flowUtils.notNull(outcome)){
			if (this.data != null && this.data.length > 0) {
				for(var i = 0; i < this.data.length; i++){
					if(this.data[i].name == outcome){
						this.executeBack(this.data[i]);
						return;
					}
				}
			}
			layer.msg("路由条件可能已经发生变化，请重新进行提交");
		}else{
			if (this.data != null && this.data.length > 1) {
				layer.msg("流程已创建，请选择一个分支进行提交");
				$("#" + this.domeId).parent().addClass("open");
			} else if (this.data != null) {
				this.isAutoClickAfterStart = true;
				try{
					$("#" + this.domeId).click();
				}catch(e){
					this.isAutoClickAfterStart = false;
				}
				this.isAutoClickAfterStart = false;
			}
		}
	}
};
BpmSubmit.prototype.quickExecute = function() {
	if (this.isEnable() && this.isEvent) {
		var _self = this;
		if (this.data != null && this.data.length > 1) {
			var html = "";
			$.each(this.data, function(n, value) {
				if(n == 0){
					html += '<input checked _val="' + n + '" type="radio" name="submitName" id="' + value.id + '">&nbsp;&nbsp;<label for="' + value.id + '">' + value.lable + '</label>';
				}else{
					html += '<br/><input _val="' + n + '" type="radio" name="submitName" id="' + value.id + '">&nbsp;&nbsp;<label for="' + value.id + '">' + value.lable + '</label>';
				}
			});
			
			layer.open({
				title : "请选择办理事项",
				content : html,
				btn : [ '确定', '取消' ],
				yes : function(index, layero) {
					var radio = layero.find("input[name='submitName']:checked");
					if(radio.length == 0){
						flowUtils.error("请选择办理事项");
					}else{
						var i = Number(radio.attr("_val"));
						layer.close(index);
						_self.execute(_self.data[i])
					}
				}
			});
		} else if (this.data != null) {
			this.execute(this.data[0]);
		}
	}else{
		flowUtils.error("目前没有办理权限");
	}
};;
///<jscompress sourcefile="BpmSupersede.js" />
/**
 * 流程转办
 */
function BpmSupersede(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dosupersede, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_supersede";
	this.getHtml();
};
BpmSupersede.prototype = new BpmButton();
/**
 * 执行
 */
BpmSupersede.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeSupersede(this.data)){
		return;
	}
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : _self.data.procinstDbid,
			executionId : _self.data.executionId,
			taskId : _self.data.taskId,
			outcome : _self.data.name,
			targetActivityName : _self.data.targetActivityName,
			type : 'dosupersede'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				new BpmActor(_self.data, result.taskUserSelect, _self).open();
			}
		}
	});
};
/**
 * 
 * @param data
 * @param users
 */
BpmSupersede.prototype.submit = function(data, users) {
	if (!flowUtils.notNull(users) || users.length == 0) {
		flowUtils.warning("选人错误");
		return;
	}
	var _self = this;
	var userJson = {
		users : users,
		idea : _self.getIdeaText(),
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/dosupersede",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson),
			selectUserId : null,
			formJson : null,
			activityName : data.targetActivityName
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				flowUtils.success("操作成功！表单将自动关闭", function() {
					flowUtils.refreshBack();
					flowUtils.closeWindowOnDialog();
                    setTimeout(function(){
                        _self.flowEditor.createButtons();
                    },500);
				}, true);
				try{
					_self.flowEditor.defaultForm.afterSupersede(data);
				}catch(e){
					
				}
			}
		}
	});
};;
///<jscompress sourcefile="BpmPresstodo.js" />
/**
 * 催办下节点
 */
function BpmPresstodo(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dopresstodo, isEvent);
	this.domeId = "bpm_presstodo";
	this.getHtml();
};
BpmPresstodo.prototype = new BpmButton();
/**
 * 执行
 */
BpmPresstodo.prototype.execute = function() {
	if (!this.flowEditor.defaultForm.beforePresstodo(this.data)) {
		return;
	}
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/beforepresstodo",
		data : {
			executionId : _self.data.executionId
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				_self.presstodo(result.result);
			}
		}
	});
	
};
BpmPresstodo.prototype.presstodo = function(result){
	var _self = this;
	var message = "";
	if(result.flg == "true"){
		message = "确定对下一节点进行催办吗？" + result.msg;
	}else{
		message = "下一节点在" + result.time + "被催办过，确定继续进行催办吗？" + result.msg;
	}
	flowUtils.confirm(message, function() {
		avicAjax.ajax({
			url : "platform/bpm/business/dopresstodo",
			data : {
				executionId : _self.data.executionId
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					flowUtils.success("催办成功");
					try {
						_self.flowEditor.defaultForm.afterPresstodo(_self.data);
					} catch (e) {

					}
				}
			}
		});
	});
}
;
///<jscompress sourcefile="BpmSupplement.js" />
/**
 * 补发
 */
function BpmSupplement(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dosupplement, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_supplement";
};
BpmSupplement.prototype = new BpmButton();
BpmSupplement.prototype.getHtmlForDefaultBar = function() {
	if (this.isEnable()) {
		var _self = this;
		var button = $('<button class="listBtn btn btn-default dropdown-toggle center" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt">' + this.data.lable + '</span></button>');
		button.on("click", function() {
			_self.execute();
		});
		$("#bpm_buttons_default2").append(button);
	}
};
/**
 * 执行
 */
BpmSupplement.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeSupplement(this.data)){
		return;
	}
	var _self = this;
	avicAjax.ajax({
		type : "POST",
		data : {
			processInstanceId : _self.data.procinstDbid
		},
		url : "platform/bpm/clientbpmdisplayaction/getcoordinate",
		dataType : "json",
		success : function(result) {
			if (flowUtils.notNull(result, result.activity)) {
				for(var key in result.activity){
					var activity = result.activity[key];
					var activityName = activity.activityName;
					var isCurrent = activity.isCurrent;
					var executionId = activity.executionId;
					var isAlone = activity.executionAlone;
					// 只有一个当前节点时候补发操作和拿回操作自动处理
					if (isAlone && isCurrent == "true") {
						_self.callback(executionId, activityName);
						return;
					}
				}
				_self.supplementTaskDialog = layer.open({
					type : 2,
					title : "补发节点选择",
					area : [ "800px", "450px" ],
					content : flowUtils.graphPath + "?entryId=" + _self.data.procinstDbid + "&type=dosupplement"
				});
				if(_self.isEvent){
					//如果不是审批页面， 最大化
					layer.full(_self.supplementTaskDialog);
				}
				window.bpmSupplement = _self;
			}
		}
	});
};
/**
 * 执行
 */
BpmSupplement.prototype.callback = function(executionId, targetActivityName) {
	if(flowUtils.notNull(this.supplementTaskDialog)){
		layer.close(this.supplementTaskDialog);
		this.supplementTaskDialog = null;
	}	
	var data = flowUtils.clone(this.data);
	data.executionId = executionId;
	data.targetActivityName = targetActivityName;
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			taskId : data.taskId,
			outcome : data.name,
			targetActivityName : data.targetActivityName,
			type : 'dosupplement'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				new BpmActor(data, result.taskUserSelect, _self).open();
			}
		}
	});
};
/**
 * 
 * @param data
 * @param users
 */
BpmSupplement.prototype.submit = function(data, users) {
	if (!flowUtils.notNull(users) || users.length == 0) {
		flowUtils.warning("选人错误");
		return;
	}
	var _self = this;
	var userJson = {
		users : users,
		idea : _self.getIdeaText(),
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/dosupplementassignee",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson),
			opType : 'dosupplement'
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				flowUtils.success("补发成功");
				try{
					_self.flowEditor.defaultForm.afterSupplement(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
			}
		}
	});
};;
///<jscompress sourcefile="BpmTaskreader.js" />
/**
 * 增加读者
 */
function BpmTaskreader(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dotaskreader, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_taskreader";
	this.getHtml();
};
BpmTaskreader.prototype = new BpmButton();
/**
 * 执行
 */
BpmTaskreader.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeTaskreader(this.data)){
		return;
	}
	new BpmActor(this.data, null, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmTaskreader.prototype.submit = function(data, users) {
	if (!flowUtils.notNull(users) || users.length == 0) {
		flowUtils.warning("选人错误");
		return;
	}
	var _self = this;
	var userJson = {
		users : users,
		idea : _self.getIdeaText(),
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/dotaskreader",
		data : {
			procinstDbid : data.procinstDbid,
			taskId : data.taskId,
			userJson : JSON.stringify(userJson)
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				flowUtils.success("操作成功");
				if(_self.isEvent){
					flowUtils.refreshCurrentBack();
				}
				try{
					_self.flowEditor.defaultForm.afterTaskreader(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
//				flowUtils.refreshBack();
			}
		}
	});
};;
///<jscompress sourcefile="BpmTransmit.js" />
/**
 * 流程转发
 */
function BpmTransmit(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dotransmit, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_transmit";
	this.getHtml();
};
BpmTransmit.prototype = new BpmButton();
/**
 * 执行
 */
BpmTransmit.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeTransmit(this.data)){
		return;
	}
	new BpmActor(this.data, null, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmTransmit.prototype.submit = function(data, users) {
	if (!flowUtils.notNull(users) || users.length == 0) {
		flowUtils.warning("选人错误");
		return;
	}
	var _self = this;
	var userJson = {
		users : users,
		idea : _self.getIdeaText(),
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/dotransmit",
		data : {
			procinstDbid : data.procinstDbid,
			taskId : data.taskId,
			userJson : JSON.stringify(userJson)
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				flowUtils.success("操作成功");
				if(_self.isEvent){
					flowUtils.refreshCurrentBack();
				}
				try{
					_self.flowEditor.defaultForm.afterTransmit(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
//				flowUtils.refreshBack();
			}
		}
	});
};;
///<jscompress sourcefile="BpmWithdraw.js" />
/**
 * 拿回
 */
function BpmWithdraw(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dowithdraw, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_withdraw";
};
BpmWithdraw.prototype = new BpmButton();
BpmWithdraw.prototype.getHtmlForDefaultBar = function() {
	if (this.isEnable()) {
		var _self = this;
		var button = $('<button class="listBtn grey btn btn-default dropdown-toggle center" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt">' + this.data.lable + '</span></button>');
		button.on("click", function() {
			_self.execute();
		});
		$("#bpm_buttons_default1").append(button);
	}
};
/**
 * 执行
 */
BpmWithdraw.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeWithdraw(this.data)){
		return;
	}
	var _self = this;
	avicAjax.ajax({
		type : "POST",
		data : {
			processInstanceId : _self.data.procinstDbid
		},
		url : "platform/bpm/clientbpmdisplayaction/getcoordinate",
		dataType : "json",
		success : function(result) {
			if (flowUtils.notNull(result, result.activity)) {
				for(var key in result.activity){
					var activity = result.activity[key];
					var activityName = activity.activityName;
					var isCurrent = activity.isCurrent;
					var executionId = activity.executionId;
					var isAlone = activity.executionAlone;
					// 只有一个当前节点时候补发操作和拿回操作自动处理
					if (isAlone && isCurrent == "true") {
						_self.callback(executionId, activityName);
						return;
					}
				}
				_self.withdrawTaskDialog = layer.open({
					type : 2,
					title : "拿回节点选择",
					area : [ "800px", "450px" ],
					content : flowUtils.graphPath + "?entryId=" + _self.data.procinstDbid + "&type=dowithdraw"
				});
				if(_self.isEvent){
					//如果不是审批页面， 最大化
					layer.full(_self.withdrawTaskDialog);
				}
				window.bpmWithdraw = _self;
			}
		}
	});
};
/**
 * 执行
 */
BpmWithdraw.prototype.callback = function(executionId, targetActivityName) {
	var _self = this;
	if(flowUtils.notNull(this.withdrawTaskDialog)){
		layer.close(this.withdrawTaskDialog);
		this.withdrawTaskDialog = null;
	}
	var data = flowUtils.clone(this.data);
	//循环节点中的拿回传入的executionId不准确
	//data.executionId = executionId;
	data.targetActivityName = targetActivityName;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			taskId : data.taskId,
			outcome : data.name,
			targetActivityName : data.targetActivityName,
			type : 'dowithdraw'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				flowUtils.confirm("确定拿回吗？", function(){
					var user = new BpmActor(data, result.taskUserSelect, _self).getUsers();
					_self.submit(data, user);
				});
			}
		}
	});
};
/**
 * 
 * @param data
 * @param users
 */
BpmWithdraw.prototype.submit = function(data, users) {
	if (!flowUtils.notNull(users) || users.length == 0) {
		flowUtils.warning("选人错误");
		return;
	}
	var _self = this;
	var userJson = {
		users : users,
		idea : _self.getIdeaText(),
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/dowithdrawcurract",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson)
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				flowUtils.success("拿回成功！表单将自动关闭", function() {
					flowUtils.refreshBack();
					flowUtils.closeWindowOnDialog();
                    setTimeout(function(){
                        _self.flowEditor.createButtons();
                    },500);
				}, true);
				try {
					_self.flowEditor.defaultForm.afterWithdraw(data);
				} catch (e) {

				}
			}
		}
	});
};;
///<jscompress sourcefile="BpmWithdrawassignee.js" />
/**
 * 节点内拿回
 */
function BpmWithdrawassignee(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dowithdrawassignee, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_withdrawassignee";
	this.getHtml();
};
BpmWithdrawassignee.prototype = new BpmButton();
/**
 * 执行
 */
BpmWithdrawassignee.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeWithdrawassignee(this.data)){
		return;
	}
	new BpmActor(this.data, null, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmWithdrawassignee.prototype.submit = function(data, users) {
	if (!flowUtils.notNull(users) || users.length == 0) {
		flowUtils.warning("选人错误");
		return;
	}
	var _self = this;
	var userJson = {
		users : users,
		idea : _self.getIdeaText(),
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/dowithdrawactassignee",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson)
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				flowUtils.success("减签成功");
				try{
					_self.flowEditor.defaultForm.afterWithdrawassignee(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
			}
		}
	});
};;
///<jscompress sourcefile="FlowPic.js" />
function initFlowPic(defineId) {
	$("#graph").attr("src", "platform/bpm/bpmPublishAction/getProcessImageTrackByDefid.gif?defid=" + defineId);
}
function bpm_RefreshPic(entryId) {
	if (flowUtils.notNull(entryId)) {
		$("#graph").attr("src", "avicit/platform6/bpmfixie/bpmbusiness/include/ProcessTrackFixie.jsp?processInstanceId=" + entryId);
	}
};
///<jscompress sourcefile="FlowTracks.js" />
function bpm_RefreshTracks(entryId){
	if (!flowUtils.notNull(entryId)) {
		return;
	}
	$.ajax({
		type : "POST",
		data : {
			entryId : entryId
		},
		url : "platform/bpm/business/doGettracks",
		dataType : "JSON",
		success : function(data) {
			if (flowUtils.notNull(data.error)) {
				flowUtils.error(data.error);
			} else {
				$("#bpm_tracks_list").empty();
				$.each(data.result.tracklist, function(i, tracks) {
					$.each(tracks, function(j, track) {
						var tempClass = "bpm_tracks_" + i;
						var tr = $("<tr></tr>");
						tr.addClass(tempClass);
						tr.hover(function() {
							$("." + tempClass).addClass("hover");
						}, function() {
							$("." + tempClass).removeClass("hover");
						});
						// 节点
						var td0 = $("<td></td>");
						td0.html(track.currentActiveLabel);
						var borderCss = null;
						if (tracks.length > 1) {
							if (j == 0) {
								td0.attr("rowspan", tracks.length * 2 - 1);
								td0.addClass("merge");
							} else {
								td0 = null;
								// borderCss = "0px";
								$("#bpm_tracks_list").append($("<tr class='" + tempClass + "'></tr>"));
							}
						}

						tr.append(td0);
						// 处理人
						tr.append(bpm_createTd(track.assigneeName, borderCss));
						// 接收时间
						tr.append(bpm_createTd(track.iTime, borderCss));
						// 处理时间
						tr.append(bpm_createTd(track.eTime, borderCss));
						// 操作类型
						tr.append(bpm_createTd(track.opType, borderCss));
						// 累计时间
						tr.append(bpm_createTd(track.useTime, borderCss));
						// 目标接收人
						tr.append(bpm_createTd(track.targetuser, borderCss));
						// 处理意见
						tr.append(bpm_createTd(track.message, borderCss));
						$("#bpm_tracks_list").append(tr);
					});
				});

				var timelineData = {};
				timelineData.list = [];
				$.each(data.result.timelist, function(i, tracks) {
					var timeO = {};
					timeO.title = tracks[0].dayName;
					timeO.list = [];
					$.each(tracks, function(j, track) {
						var o = {};
						o.l = track.timeName;
						o.r = "<span style=\"color:#c426b3\">" + track.operateUserName + "</span>在<span style=\"color:#2d52df\">" + track.currentActiveLabel + "</span>节点进行了<span style=\"color:#49bd32\">" + track.opType + "</span>操作";
						if (flowUtils.notNull(track.targetuser)) {
							o.r += ",目标接收人是<span style=\"color:#c426b3\">" + track.targetuser + "</span>";
						}
						o.r += "<br/>意见：<span style=\"color:#2d52df\">" + $.trim(track.message) + "</span>";
						timeO.list.push(o);
					});
					timelineData.list.push(timeO);
				});
				$('.time-line').timeliner({
					data : timelineData
				});
			}
		}
	});
}
function bpm_createTd(value, borderCss){
	var td = $("<td></td>");
	td.html(value);
	if (flowUtils.notNull(borderCss)) {
		td.css("border-top", borderCss);
	}
	return td;
};
///<jscompress sourcefile="BpmActor.js" />
function BpmActor(data,taskJsonData,obj, isUflow) {
	this.data = data;
	this.submitObj = obj;
	this.taskJsonData = taskJsonData;
	this.isUflow = isUflow;
};
//BpmSubmit.prototype = new BpmButton();
/**
 * 执行
 */
BpmActor.prototype.open = function() {
	var _self = this;
	var title = _self.getActorHandTitle();
	if(!flowUtils.notNull(title)){
		title = "下一节点";
	}
	var url = 'platform/bpmActor/bpmSelectUserAction2/main?procinstDbid=' + this.data.procinstDbid + '&executionId=' + this.data.executionId + '&taskId=' + this.data.taskId + '&outcome=' + this.data.name + '&targetActivityName=' + this.data.targetActivityName + '&type=' + this.data.event + '&doSubmitUrl=&doSubmitCallEvent=';
	top.layer.open({
		skin: 'bpm_selectUser_class',
		type : 2,
		title: "选择【" + title + "】处理人",
		area : [ "800px", "450px" ],
		content : url,
		btn : [ '确定', '取消' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;
			var selectedUsers = iframeWin.getSelectedUsers();
			
			if(selectedUsers == null || selectedUsers.length == 0){
				top.layer.msg("请选择处理人");
				return;
			}
			var uflowDealType = _self.getUflowDealType();
			var users;
			if(!_self.checkIsBranch()){//非分支提交
				if(_self.checkWorkHandUser()){//工作移交
					actorWorkerHandlerOperation(selectedUsers,_self,false,null, uflowDealType);
					return;
				} else {//非工作移交
					users = [{
						selectedUsers : selectedUsers,
						targetActivityName : _self.data.targetActivityName == null ? "" : _self.data.targetActivityName,
						outcome : _self.data.name  == null ? "" : _self.data.name,
						workhandUsers : []
					}];
				}
			} else {//分支
				users = selectedUsers;
				if(_self.checkWorkHandUser()){//工作移交
					var workHandSelectedUsers = _self.geBranchWorkHandSelectedUsers(users);
					actorWorkerHandlerOperation(workHandSelectedUsers,_self,true,users,uflowDealType);
					return;
				}
			}
			top.layer.closeAll();
			_self.submitObj.submit(_self.data, users, false, uflowDealType);
		},
		success : function(layero, index){
			if(_self.isUflow){
				var tempDom = $(".bpm_selectUser_class");
				if(tempDom.length == 0){
					tempDom = parent.$(".bpm_selectUser_class");
				}
				if(tempDom.length == 0){
					return;
				}
				tempDom.find(".layui-layer-btn").append("<div class='pull-left'><input type='radio' name='dealtype' value='4' checked style='vertical-align:middle; margin-top:-2px; margin-bottom:1px;'/>多人并行&nbsp;&nbsp<input type='radio' name='dealtype' value='3' style='vertical-align:middle; margin-top:-2px; margin-bottom:1px;'/>多人任意</div>");
			}

            if(flowUtils.notNull(_self.data) && "dostepuserdefined" == _self.data.event){
                var iframeWin = layero.find('iframe')[0].contentWindow;
				$.ajax({
					url:"platform/bpm/business/getBpmStepPerson",
                    data:{
						entryId:_self.data.procinstDbid,
                        activityName:_self.data.activityName
					},
                    type : "POST",
                    dataType : "JSON",
                    success : function(result) {
						if(flowUtils.notNull(result)){
							for(var i = 0; i < result.length; i++){
								var user = result[i];
								var obj = {
									id:user.id,
									name:user.name,
                                    attributes:{
                                        deptId:user.deptId,
                                        deptName:user.deptName
									}
								};
                                iframeWin.selectorData(obj);
							}
						}
                    }
				});
			}
		}
	});
};
BpmActor.prototype.getUflowDealType = function(){
	if(this.isUflow){
		var tempDom = $(".bpm_selectUser_class");
		if(tempDom.length == 0){
			tempDom = parent.$(".bpm_selectUser_class");
		}
		if(tempDom.length == 0){
			return "";
		}
		return tempDom.find(".layui-layer-btn").find("input[name='dealtype']:checked").val();
	}
	return "";
};
BpmActor.prototype.getUsers = function(){
	var users;
	var _self = this;
	var url = 'platform/bpmActor/bpmSelectUserAction2/getAutoSelectedUsersJSONData';
	$.ajax({
		url : url,
		async: false,
		dataType : "JSON",
		data : {
			procinstDbid : this.data.procinstDbid,
			executionId : this.data.executionId,
			taskId: this.data.taskId,
			targetActivityName : this.data.targetActivityName,
			type : this.data.event,
			outcome : this.data.name
		},
		type : "GET",
		success : function(msg) {
			if(_self.data.event  == "doretreattodraft" || _self.data.event  == "doretreattoprev" || _self.data.event  == "dowithdraw"){//非分支
				users = [{
					selectedUsers : msg,
					targetActivityName : _self.data.targetActivityName == null ? "" : _self.data.targetActivityName,
					outcome : _self.data.name == null ? "" : _self.data.name,
					workhandUsers : []
				}];
			} else {
				users = msg;
			}
		}
	});
	return users;
};
BpmActor.prototype.checkIsBranch = function(){
	try{
		if(this.submitObj.conditions.isBranch()){
			return true;
		} else {
			return false;
		}
	}catch(e){
		return false;
	}
}
/**
 * 获取对话框标题
 * @returns
 */
BpmActor.prototype.getActorHandTitle = function(){
	try{
		if(!this.checkIsBranch()){
			var title = this.taskJsonData.nextTask[0].currentActivityAttr.activityAlias;
			if(title != null){
				return title;
			}else{
				return this.submitObj.data.lable;
			}
		} else {
			return '分支';
		}
	}catch(e){
		return this.submitObj.data.lable;
	}
}
/**
 * 判断是否存在工作移交
 */
BpmActor.prototype.checkWorkHandUser = function(){
	if(this.taskJsonData && this.taskJsonData.nextTask){
		for(var i = 0 ; i < this.taskJsonData.nextTask.length ; i++){
			var jsonData = this.taskJsonData.nextTask[i];
			if(jsonData.currentActivityAttr.isWorkHandUser == 'yes'){
				return true;
			}
		}
	} else {
		return false;
	}
};
/**
 * 获取工作移交的选人结果
 * @param users
 * @returns {Array}
 */
BpmActor.prototype.geBranchWorkHandSelectedUsers = function(users){
	var returnSelectedUsers = new Array();
	for(var i = 0 ; i < users.length ; i++){
		var selectedUsers = users[i].selectedUsers;
		for(var j = 0 ; j < selectedUsers.length ; j++){
			returnSelectedUsers.push(selectedUsers[j]);
		}
	}
	return returnSelectedUsers;
};
/**
 * 工作移交处理
 * @param users
 * @param taskData
 */
function actorWorkerHandlerOperation(users,parentObject,isBranch,originalUsers, uflowDealType){
	$.ajax({
		   type: "POST",
		   url: 'platform/bpmActor/bpmSelectUserAction2/getWorkHandUsers',
		   async: false,
		   data: {
			   userList:JSON.stringify(users), 
			   processKey: parentObject.taskJsonData.processKey
		   },
		   dataType: 'json',
		   success: function(workHandUsersList){
		     if(workHandUsersList && workHandUsersList.length > 0){
		    	 //var url = 'platform/bpmActor/bpmSelectUserAction2/getWorkHandSelectUser?userList=' + encodeURI(JSON.stringify(workHandUsersList));
		    	 var url = 'platform/bpmActor/bpmSelectUserAction2/getWorkHandSelectUser?userList=' + encodeURI(encodeURI(JSON.stringify(workHandUsersList)));
		    	 top.layer.open({
		    		    skin: 'bs-modal',
		    			title: "选择流程委托处理人",
		    			content: url,
		    			area: ['600px', '400px'],
		    			type:2,
		    			shade:0.3,
		    			btn: ['确定', '取消'],
		    			yes:function(index, layero){
		    				var iframeWin = layero.find('iframe')[0].contentWindow;
		    				var selectedUsers = iframeWin.getWorkhandSelectedUsers();
		    				if(isBranch){
		    					for(var i = 0 ; i < originalUsers.length ; i++){
		    						originalUsers[i].workhandUsers = selectedUsers;
		    					}
		    					top.layer.closeAll();
		    					parentObject.submitObj.submit(parentObject.data, originalUsers, false, uflowDealType);
		    				} else {
		    					var workhandUsers = [{
									selectedUsers : users,
									targetActivityName : parentObject.data.targetActivityName == null ? "" : parentObject.data.targetActivityName,
									outcome : parentObject.data.name,
									workhandUsers : selectedUsers
								}];
		    					top.layer.closeAll();
		    					parentObject.submitObj.submit(parentObject.data, workhandUsers, false, uflowDealType);
		    				}
		    			},
		    			init:function(index, layer){
		    			}
		    		});
		     } else {
		    	 if(isBranch){
		    		 top.layer.closeAll();
 					parentObject.submitObj.submit(parentObject.data, originalUsers, false, uflowDealType);
 				} else {
 					var workhandUsers = [{
							selectedUsers : users,
							targetActivityName : parentObject.data.targetActivityName == null ? "" : parentObject.data.targetActivityName,
							outcome : parentObject.data.name,
							workhandUsers : null
						}];
 					top.layer.closeAll();
 					parentObject.submitObj.submit(parentObject.data, workhandUsers, false, uflowDealType);
 				}
		     }
		   },
		   error : function(msg){
			   layer.alert(msg, {
					icon : 2
				});
			   return ;
		   }
	});
}
;
///<jscompress sourcefile="FlowEditor.src.js" />
flowUtils.include("avicit/platform6/bpmreform/bpmbusiness/include/src/FlowIdeaBase.js");
flowUtils.include("avicit/platform6/bpmreform/bpmbusiness/include/src/FlowIdea.js");
/**
 * 流程操作
 */
function FlowEditor(defaultForm, flowIdea) {
	var defineId = _bpm_defineId, deploymentId = _bpm_deploymentId, firstTaskName = _bpm_firstTaskName, firstTaskAlias = _bpm_firstTaskAlias, entryId = _bpm_entryId, executionId = _bpm_executionId, taskId = _bpm_taskId, formId = _bpm_formId, ideaCompelManner = _bpm_ideaCompelManner;
	_flow_editor = this;
	var _self = this;
	this.simulation = _bpm_simulation;
	this.flowModel = new FlowModel(defineId, deploymentId, entryId, executionId, taskId);
	this.defaultForm = defaultForm;
	this.defaultForm.flowEditor = this;
	
	//加入流程意见对象flowIdea
	if(flowUtils.notNull(flowIdea)){
		this.flowIdea = flowIdea;
	}else{
		this.flowIdea = new FlowIdea();
	}
	this.flowIdea.flowEditor = this;
	
	//记录拟稿节点，是否需要强制表态
	this.ideaCompelManner = ideaCompelManner;
	// 初始化参数
	if (flowUtils.notNull(defineId)) {
		this.isStart = true;
		this.flowModel.setActivityname(firstTaskName);
		this.flowModel.setActivitylabel(firstTaskAlias);
		this.flowModel.setUserIdentityKey("6");
		this.flowModel.setUserIdentity("拟稿人");
	} else if (flowUtils.notNull(entryId, executionId, taskId, formId)) {
		this.defaultForm.setId(formId);
		this.defaultForm.initFormData();
		this.flowModel.defineId = this.getDefineIdByEntryId(entryId);
	} else {
		this.hideButtons();
		flowUtils.error("流程参数错误！无法初始化权限按钮！您可能是通过非法的途径进入了当前页面，例如重复刷新页面，拷贝链接到浏览器地址栏等操作。点击确定关闭表单", function() {
			flowUtils.closeWindowOnDialog();
		});
		return false;
	}
	var title = flowUtils.getUrlQuery("title");
	if (flowUtils.notNull(title)) {
		document.title = title;
	}
	// 初始化文档
	this.flowUploader = new FlowUploader(this);
	this.flowUploader.init();
	// 初始化流程图画布
	initFlowPic(this.flowModel.defineId);
	this.flowIdea.init();
	// 权限按钮
	this.createButtons();
};
/**
 * 表单对象
 */
FlowEditor.prototype.defaultForm = null;
/**
 * 数据模板
 */
FlowEditor.prototype.flowModel = null;
/**
 * 是否新建
 */
FlowEditor.prototype.isStart = false;
/**
 * 是否刷新流程图
 */
FlowEditor.prototype.needRefreshPic = false;
/**
 * 是否需要意见框
 */
FlowEditor.prototype.needIdeaText = false;
/**
 * 是否是模拟状态
 */
FlowEditor.prototype.simulation = "0";
/**
 * 自定义的加载后事件是否已经执行
 */
FlowEditor.prototype.afterInit = false;
/**
 * 隐藏按钮
 */
FlowEditor.prototype.hideButtons = function() {
	$(".bpmhide").hide();
	$("#bpm_buttons_default1").empty();
	$("#bpm_buttons_default2").empty();
};

/**
 * 权限按钮重置
 */
FlowEditor.prototype.createButtons = function(flg) {
	var _self = this;
	// 隐藏所有按钮
	this.hideButtons();
	if(this.simulation == "1"){
		//模拟状态
		this.bpmSubmit = new BpmSubmit(this, this.defaultForm, new Object());
		// 默认保存
		this.bpmSave = new BpmSave(this, this.defaultForm, new Object());
		
		this.bpmSubmit.execute = function(){
			flowUtils.success("模拟提交");
		};
		
		this.bpmSave.execute = function(){
			flowUtils.success("模拟保存");
		};
		
		$("#bpm_buttons_title").html("当前节点：" + this.flowModel.activitylabel);
		$("#bpm_buttons_desc").html("当前身份：" +  this.flowModel.userIdentity);
		//当前节点描述
		this.hoverRemark();
		// 控制表单元素
		this.controlFormInput();
		// 刷新引用文档
		this.refreshFiles();
		// 流程图
		this.needRefreshPic = true;
		//刷新权限按钮后事件
		this.defaultForm.afterCreateButtons();
		//自定义的加载事件
		if(!this.afterInit){
			this.defaultForm.afterInit();
			this.afterInit = true;
		}
		//显隐
		this.flowIdea.show();
	}else{
		if (this.isStart) {
			// 默认提交
			this.bpmSubmit = new BpmSubmit(this, this.defaultForm, new Object());
			// 默认保存
			this.bpmSave = new BpmSave(this, this.defaultForm, new Object());
			
			$("#bpm_buttons_title").html("当前节点：" + this.flowModel.activitylabel);
			$("#bpm_buttons_desc").html("当前身份：" +  this.flowModel.userIdentity);
			//当前节点描述
			this.hoverRemark();
			// 控制表单元素
			this.controlFormInput();
			// 刷新引用文档
			this.refreshFiles();
			// 流程图
			this.needRefreshPic = true;
			//刷新权限按钮后事件
			this.defaultForm.afterCreateButtons();
			//自定义的加载事件
			if(!this.afterInit){
				this.defaultForm.afterInit();
				this.afterInit = true;
			}
			//显隐
			this.flowIdea.show();
		} else {
			// 流程图
			if (_avicTabIndex == 1) {
				this.refreshPic();
				this.refreshTracks();
			} else {
				this.needRefreshPic = true;
			}
			
			avicAjax.ajax({
				type : "POST",
				data : {
					processInstanceId : _self.flowModel.entryId,
					executionId : _self.flowModel.executionId,
					taskId : _self.flowModel.taskId
				},
				url : "platform/bpm/business/getoperateright",
				dataType : "JSON",
				success : function(msg) {
					if (flowUtils.notNull(msg.error)) {
						flowUtils.error(msg.error);
					} else {
						_self.drawButtons(msg);
						//调用正文模板的方法
						if (typeof word_oa_refresh != 'undefined' && flowUtils.notNull(word_oa_refresh)) {
							word_oa_refresh(_self);
						}
						// 默认点击提交
						if (flg) {
							_self.bpmSubmit.clickBut();
						}
						//刷新权限按钮后事件
						_self.defaultForm.afterCreateButtons();
						//自定义的加载事件
						if(!_self.afterInit){
							_self.defaultForm.afterInit();
							_self.afterInit = true;
						}
					}
				}
			});
		}
	}
};
/**
 * 画按钮
 * 
 * @param json
 */
FlowEditor.prototype.drawButtons = function(json) {
	var bpmContent = json.bpmContent;
	this.flowModel.setActivityname(bpmContent.processActivityName);
	this.flowModel.setActivitylabel(bpmContent.processActivityLabel);
	this.flowModel.setUserIdentityKey(bpmContent.userIdentityKey);
	this.flowModel.setUserIdentity(bpmContent.userIdentity);
	$("#bpm_buttons_title").html("当前节点：" + this.flowModel.activitylabel);
	$("#bpm_buttons_desc").html("当前身份：" +  this.flowModel.userIdentity);
	//当前节点描述
	this.hoverRemark();
	// 刷新引用文档
	this.refreshFiles();
	
	var buttonArray = json.operateRight;
	if (buttonArray == null) {
		return;
	}
	var buttonData = {};
	$.each(buttonArray, function(i, button) {
		if (button.event == "dosubmit") {
			if (buttonData.dosubmit == null) {
				buttonData.dosubmit = [];
			}
			buttonData.dosubmit.push(button);
		} else {
			eval("buttonData." + button.event + "= button");
		}
	});
	
	this.needIdeaText = false;
	
	this.bpmSave = new BpmSave(this, this.defaultForm, buttonData);
	this.bpmRetreat = new BpmRetreat(this, this.defaultForm, buttonData);
	this.bpmSubmit = new BpmSubmit(this, this.defaultForm, buttonData);
	this.bpmWithdraw = new BpmWithdraw(this, this.defaultForm, buttonData);
	this.bpmSupplement = new BpmSupplement(this, this.defaultForm, buttonData);
	if (!this.bpmRetreat.enable && !this.bpmSubmit.enable) {
		this.bpmWithdraw.getHtmlForDefaultBar();
		this.bpmSupplement.getHtmlForDefaultBar();
	} else {
		this.bpmWithdraw.getHtml();
		this.bpmSupplement.getHtml();
	}
	this.bpmAdduser = new BpmAdduser(this, this.defaultForm, buttonData);
	this.bpmSupersede = new BpmSupersede(this, this.defaultForm, buttonData);
	this.bpmTransmit = new BpmTransmit(this, this.defaultForm, buttonData);
	this.bpmWithdrawassignee = new BpmWithdrawassignee(this, this.defaultForm, buttonData);
	this.bpmFocus = new BpmFocus(this, this.defaultForm, buttonData);
	this.bpmGlobalend = new BpmGlobalend(this, this.defaultForm, buttonData);
	this.bpmGlobalidea = new BpmGlobalidea(this, this.defaultForm, buttonData);
	this.bpmGlobaljump = new BpmGlobaljump(this, this.defaultForm, buttonData);
	this.bpmGlobalresume = new BpmGlobalresume(this, this.defaultForm, buttonData);
	this.bpmGlobalsuspend = new BpmGlobalsuspend(this, this.defaultForm, buttonData);
	this.bpmStepuserdefined = new BpmStepuserdefined(this, this.defaultForm, buttonData);
	this.bpmTaskreader = new BpmTaskreader(this, this.defaultForm, buttonData);
	this.bpmPresstodo = new BpmPresstodo(this, this.defaultForm, buttonData);
	if(this.needIdeaText){
		this.flowIdea.readonly(false);
		//显隐
		this.flowIdea.show();
	}else{
		this.flowIdea.clear();
		this.flowIdea.readonly(true);
		//显隐
		this.flowIdea.hide();
	}
	// 控制表单元素
	this.controlFormInput();
};
/**
 * 流程启动后
 * 
 * @param result
 */
FlowEditor.prototype.afterStart = function(result) {
	this.isStart = false;
	this.flowModel.setDefineId(result.defineId);
	this.flowModel.setEntryId(result.entryId);
	this.flowModel.setExecutionId(result.executionId);
	this.flowModel.setTaskId(result.taskId);
	this.defaultForm.setId(result.formId);
};
/**
 * 刷新流程图
 */
FlowEditor.prototype.refreshPic = function() {
	bpm_RefreshPic(this.flowModel.entryId);
};
/**
 * 刷新文字跟踪
 */
FlowEditor.prototype.refreshTracks = function() {
	bpm_RefreshTracks(this.flowModel.entryId);
};
/**
 * 刷新引用文档
 */
FlowEditor.prototype.refreshFiles = function() {
	this.flowUploader.refresh();
};
/**
 * 需要获取定义文件id
 * 
 * @param entryId
 */
FlowEditor.prototype.getDefineIdByEntryId = function(entryId) {
	var defineId = null;
	$.ajax({
		type : "POST",
		async : false,// 同步请求
		data : {
			entryId : entryId
		},
		url : "platform/bpm/business/getDefineIdByEntryId",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				defineId = msg.defineId;
			}
		}
	});
	return defineId;
};
/**
 * 控制表单元素
 */
FlowEditor.prototype.controlFormInput = function() {
	var _self = this;
	//是否电子表单
	var isEform = true;
	if(this.flowModel.userIdentityKey == "7" && this.bpmSave.isEnable()){
		//管理员允许编辑表单
	}else{
		// 全部只读，包括按钮
		$(".panel-body").eq(0).find("select").attr("disabled", "disabled");
		$(".panel-body").eq(0).find(':checkbox').attr("disabled", "disabled");
		$(".panel-body").eq(0).find(':radio').attr("disabled", "disabled");
		$(".panel-body").eq(0).find(':text').attr("disabled", "disabled");
		$(".panel-body").eq(0).find("textarea").attr("disabled", "disabled");
		//禁用图标事件
       // $(".panel-body").eq(0).find(".easyui-datebox").datebox({disabled:true});
      //  $(".panel-body").eq(0).find(".easyui-datetimebox").datetimebox({disabled:true});
      //  $(".panel-body").eq(0).find(".easyui-combobox").combobox({disabled:true});
		$(".panel-body").eq(0).find(".ext-input-right-icon").hide();
		
		//自定义元素置为只读
		$(".bpm_self_class").each(function(i){
			var id = $(this).attr("id");
			_self.defaultForm.controlSelfElement(id, false);
		});

		// 全部显示，包括按钮
//		$(".panel-body").eq(0).find("select").show();
//		$(".panel-body").eq(0).find(':checkbox').show();
//		$(".panel-body").eq(0).find(':radio').show();
//		$(".panel-body").eq(0).find(':text').show();
//		$(".panel-body").eq(0).find("textarea").show();
		
		//自定义元素置为显示
		$(".bpm_self_class").each(function(i){
//			var id = $(this).attr("id");
//			_self.defaultForm.controlSelfElementForAccess(id, true);
		});
		//附件置为只读
		this.defaultForm.setAttachMagic(false);
		
		// 允许编辑
		avicAjax.ajax({
			type : "POST",
			data : {
				defineId : this.flowModel.defineId,
				activityname : this.flowModel.activityname
			},
			url : "platform/bpm/business/getFormSecuritys",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					if (_self.bpmSave.isEnable()) {
						$.each(msg.result, function(i, n) {
							var operability = n.operability == "1";
							// 允许编辑
							if(operability){
								if(n.elementType == "bpm_self_class"){
									//自定义元素
									_self.defaultForm.controlSelfElement(n.tag, operability, n);
								}else if(n.elementType == "pt6:JigsawCheckBox" || n.elementType == "pt6:JigsawRadio" || n.elementType == "checkbox" || n.elementType == "radio"){
									var $tag = $('input[name="' + n.tag + '"]');
									$tag.removeAttr("disabled");
								}else if(n.elementType == "textarea"){
									var $tag = $('#' + n.tag);
									$tag.removeAttr("disabled");
								}else if(n.elementType == "eform_subtable_bpm_auth"){
									var tagArr = n.tag.split("__");
									var colName = tagArr[1];
									var subTableName = tagArr[0];
									//var colModel = $("#"+subTableName).datagrid('getColumnFields');
									var hasColNameName = false;
									var colNameName = colName+"Name";
									/*if(colModel!=null && colModel.length>0){
										for(var m=0;m<colModel.length;m++){
											if(colModel[m]==colNameName){
												hasColNameName = true;
												break;
											}
										}
									}*/
									if(hasColNameName){
										$("#"+subTableName).datagridex("readonly",colName+"Name",false);
										//$("#"+subTableName).jqGrid('setCell', colName+"Name", 'colLength', '', 'editable-cell');
									}else{
										//$("#"+subTableName).jqGrid('setCell', colName, 'colLength', '', 'editable-cell');
										//$("#"+subTableName).datagridex("readonly",colName,false);
									}
									
								}else if(n.elementType == "eform_subtable_bpm_button_auth"){
									//子表按钮不做处理
								}else{
									var $tag = $('#' + n.tag);
									if($tag.hasClass("easyui-datebox")){
										$tag.datebox({disabled:false});
									}else if($tag.hasClass("easyui-datetimebox")){
										$tag.datetimebox({disabled:false});
									}else if($tag.hasClass("easyui-combobox")){
										$tag.combobox({disabled:false});
									}else{
										$tag.removeAttr("disabled");
										//启用图标事件
										if($tag.parent().find(".ext-input-right-icon")){
											$tag.parent().find(".ext-input-right-icon").show();
										}
									}
									
								}
							}else{
								if(n.elementType == "eform_subtable_bpm_auth"){
									var tagArr = n.tag.split("__");
									var colName = tagArr[1];
									var subTableName = tagArr[0];
									
									//var colModel = $("#"+subTableName).datagrid('getColumnFields');
									var hasColNameName = false;
									var colNameName = colName+"Name";
									/*//if(colModel!=null && colModel.length>0){
										for(var m=0;m<colModel.length;m++){
											if(colModel[m]==colNameName){
												hasColNameName = true;
												break;
											}
										}
									}*/
									if(hasColNameName){
										$("#"+subTableName).datagridex("readonly",colName+"Name");
										//$("#"+subTableName).setColProp(colName+"Name",{editable:false});
									}else{
										//$("#"+subTableName).setColProp(colName,{editable:false});
										//$("#"+subTableName).datagridex("readonly",colName);
									}
									
								}
							}
						});
						var attachMagic = msg.attachMagic || msg.attachMagic == "true";
						if(attachMagic){
							_self.defaultForm.setAttachMagic(attachMagic);
						}						
						
						//附件权限
						$.each(msg.attachmentAuths, function(i, n) {
							var operability = n.operability == "1";
							var required = n.required == "1";
							
							_self.defaultForm.setAttachCanAddOrDel(n.tag, operability, n);
							if(operability && required){
								required = true;
							}else{
								required = false;
							}
							_self.defaultForm.setAttachRequired(n.tag,required,n);
							
						});
						
						/**
						 * 必填处理
						 */
						$.each(msg.result, function(i, n) {
							// 
							if(n.required == "0" || 
									(n.required == "1" && (n.accessibility == "0" || n.operability == "0"))){
								if(n.elementType == "bpm_self_class"){
									//自定义元素
									_self.defaultForm.controlSelfElementForRequired(n.tag, false, n);
								}else if(n.elementType == "checkbox" || n.elementType == "radio"){
									var $tag = $('input[name="' + n.tag + '"]');

									if(isEform){
                                        var parentTd = $tag.closest("td");
                                        if (parentTd){
                                            parentTd.attr('data-isnull',"true");
                                        }
									}else{
										$tag.rules("remove");
									}
									
									var $tagLabel = $('label[for="' + n.tag + '"]');
									var $i = $tagLabel.children("i[class=required]");
									if($i && $i.length>0){
										for(var a=0;a<$i.length;a++){
											$i[a].remove();
										}
									}
								}else if(n.elementType == "textarea"){
									var $tag = $('#' + n.tag);
									if(isEform){
										$tag.validatebox({    
										    required: false
										});
									}else{
										$tag.rules("remove");
									}
									var $tagLabel = $('label[for="' + n.tag + '"]');
									var $i = $tagLabel.children("i[class=required]");
									if($i && $i.length>0){
										for(var a=0;a<$i.length;a++){
											$i[a].remove();
										}
									}
								}else if(n.elementType == "eform_subtable_bpm_auth"){
									var tagArr = n.tag.split("__");
									var colName = tagArr[1];
									var subTableName = tagArr[0];
									//var colModel = $("#"+subTableName).datagrid('getColumnFields');
									var hasColNameName = false;
									var colNameName = colName+"Name";
									/*//if(colModel!=null && colModel.length>0){
										for(var m=0;m<colModel.length;m++){
											if(colModel[m]==colNameName){
												hasColNameName = true;
												break;
											}
											
										}
									}*/
									if(hasColNameName){
										$('#'+subTableName).datagridex("deleteValidate",colName+"Name","required");
										//$('#'+subTableName).validateJqGrid("deleteValidate",colName+"Name","required");
									}else{
										//$('#'+subTableName).datagridex("deleteValidate",colName,"required");
										//$('#'+subTableName).validateJqGrid("deleteValidate",colName,"required");
									}
									
								}else if(n.elementType == "eform_subtable_bpm_button_auth"){
									//子表按钮不做处理
								}else{
									var $tag = $('#' + n.tag);
									if($tag.hasClass("easyui-datebox")){
										var comValue = $tag.datebox('getValue');
										$tag.datebox({
											required: false
										});
                                        $tag.datebox('setValue', comValue);
									}else if($tag.hasClass("easyui-datetimebox")){
										var comValue = $tag.datetimebox('getValue');
										$tag.datetimebox({
											required: false
										});
                                        $tag.datetimebox('setValue', comValue);
									}else if($tag.hasClass("easyui-combobox")){
										var comValue = $tag.combobox('getValue');
										$tag.combobox({
											required: false,
                                            validType:null
										});
                                        $tag.combobox('setValue', comValue);
									}else{
										if(isEform){
											/*$tag.validatebox({
                                                required: false
                                            });*/
										}else{
											$tag.rules("remove");
										}
									}
									var $tagLabel = $('label[for="' + n.tag + '"]');
									var $i = $tagLabel.children("i[style='color:red']");
									if($i && $i.length>0){
										for(var a=0;a<$i.length;a++){
											$i[a].remove();
										}
									}
                                    var $tagLabelName = $('label[for="' + n.tag + 'Name"]');
                                    var $ii = $tagLabelName.children("i[style='color:red']");
                                    if($ii && $ii.length>0){
                                        for(var a=0;a<$ii.length;a++){
                                            $ii[a].remove();
                                        }
                                    }
								}
							}else if(n.required == "1" && n.accessibility == "1" && n.operability == "1"){
								if(n.elementType == "bpm_self_class"){
									//自定义元素
									_self.defaultForm.controlSelfElementForRequired(n.tag, n.required == "1", n);
								}else if(n.elementType == "checkbox" || n.elementType == "radio"){
									var $tag = $('input[name="' + n.tag + '"]');
									if(isEform){
                                        var parentTd = $tag.closest("td");
                                        if (parentTd){
                                            parentTd.attr('data-isnull',"false");
                                        }
									}else{
										$tag.rules("add",{required:true}); 
									}
									
									var $tagLabel = $('label[for="' + n.tag + '"]');
									var $i = $tagLabel.children("i[class=required]");
									if(!$i || $i.length<1){
										var requiredElement = $("<i style='color:red'>*</i>");
										$tagLabel.prepend(requiredElement);
									}
								}else if(n.elementType == "textarea"){
									var $tag = $('#' + n.tag);
									if(isEform){
										$tag.validatebox({    
										    required: true
										});
									}else{
										$tag.rules("add",{required:true}); 
									}
									var $tagLabel = $('label[for="' + n.tag + '"]');
									var $i = $tagLabel.children("i[class=required]");
									if(!$i || $i.length<1){
										var requiredElement = $("<i style='color:red'>*</i>");
										$tagLabel.prepend(requiredElement);
									}
								}else if(n.elementType == "eform_subtable_bpm_auth"){
									var tagArr = n.tag.split("__");
									var colName = tagArr[1];
									var subTableName = tagArr[0];
									
									//var colModel = $("#"+subTableName).datagrid('getColumnFields');
									var hasColNameName = false;
									var colNameName = colName+"Name";
									/*if(colModel!=null && colModel.length>0){
										for(var m=0;m<colModel.length;m++){
											if(colModel[m]==colNameName){
												hasColNameName = true;
												break;
											}
										}
									}*/
									if(hasColNameName){
										//$('#'+subTableName).datagridex("deleteValidate",colName+"Name","required");
										$('#'+subTableName).datagridex("addValidate",colName+"Name","required");
									}else{
										//$('#'+subTableName).datagridex("deleteValidate",colName,"required");
										$('#'+subTableName).datagridex("addValidate",colName,"required");
									}
								}else if(n.elementType == "eform_subtable_bpm_button_auth"){
									//子表按钮不做处理
								}else{
									var $tag = $('#' + n.tag);
									if($tag.hasClass("easyui-datebox")){
										var comValue = $tag.datebox('getValue');
										$tag.datebox({
											required: true
										});
                                        $tag.datebox('setValue', comValue);
									}else if($tag.hasClass("easyui-datetimebox")){
										var comValue = $tag.datetimebox('getValue');
										$tag.datetimebox({
											required: true
										});
                                        $tag.datetimebox('setValue', comValue);
									}else if($tag.hasClass("easyui-combobox")){
										var comValue = $tag.combobox('getValue');
										$tag.combobox({
											required: true,
                                            validType:'extendsIsNull'
										});
                                        $tag.combobox('setValue', comValue);
									}else{
										if(isEform){
											$tag.validatebox({    
											    required: true
											});
										}else{
											$tag.rules("add",{required:true}); 
										}
									}
									
									var $tagLabel = $('label[for="' + n.tag + '"]');
                                    var $tagLabelName = $('label[for="' + n.tag + 'Name"]');
									var $i = $tagLabel.children("i[style='color:red']");
									if(!$i || $i.length<1){
										var requiredElement = $("<i style='color:red'>*</i>");
										$tagLabel.prepend(requiredElement);
									}
                                    var $ii = $tagLabelName.children("i[style='color:red']");
                                    if(!$ii || $ii.length<1){
                                        var requiredElement = $("<i style='color:red'>*</i>");
                                        $tagLabelName.prepend(requiredElement);
                                    }
								}
								
							}
						});
					}
					$.each(msg.result, function(i, n) {
						var accessibility = n.accessibility == "1";
						// 进行隐藏
						if(!accessibility){
							if(n.elementType == "bpm_self_class"){
								//自定义元素
								_self.defaultForm.controlSelfElementForAccess(n.tag, accessibility, n);
							}else if(n.elementType == "checkbox" || n.elementType == "radio"){
								var $tag = $('input[name="' + n.tag + '"]');
								$tag.hide();
								var $tagLabel = $('label[for="' + n.tag + '"]');
								$tagLabel.hide();
							}else if(n.elementType == "textarea"){
								var $tag = $('#' + n.tag);
								$tag.hide();
								var $tagLabel = $('label[for="' + n.tag + '"]');
								$tagLabel.hide();
							}else if(n.elementType == "eform_subtable_bpm_auth"){
								var tagArr = n.tag.split("__");
								var colName = tagArr[1];
								var subTableName = tagArr[0];
								
								//var colModel = $("#"+subTableName).datagrid('getColumnFields');
								var hasColNameName = false;
								var colNameName = colName+"Name";
								/*if(colModel!=null && colModel.length>0){
									for(var m=0;m<colModel.length;m++){
										if(colModel[m]==colNameName){
											hasColNameName = true;
											break;
										}
									}
								}*/
								if(hasColNameName){
									jQuery("#" + subTableName).datagrid("hideColumn",colName+"Name");
								}else{
									/*jQuery("#" + subTableName).datagrid("hideColumn",colName);*/
								}
								
							}else if(n.elementType == "eform_subtable_bpm_button_auth"){
								_self.defaultForm.controlSubTableButtonForAccess(n.tag, accessibility, n);
							}else{
								var $tag = $('#' + n.tag);
								if($tag.hasClass("easyui-datebox")){
									$tag.datebox("destroy");
								}else if($tag.hasClass("easyui-numberbox")){
									$tag.numberbox("destroy");
								}else if($tag.hasClass("easyui-combobox")){
									$tag.combobox("destroy");
								}else if($tag.hasClass("easyui-datetimebox")){
									$tag.datetimebox("destroy");
								}else if($tag.hasClass("easyui-coding")){
									$tag.coding("destroy");
								}else if($tag.hasClass("groupCtrlSpan")){
									$tag.remove();
								}else if($tag.parent() && $tag.parent().hasClass("ext-selector-div")){
									$tag.parent().hide();
								}else{
									$tag.hide();
								}
								var $tagLabel = $('label[for="' + n.tag + '"]');
                                var $tagLabelName = $('label[for="' + n.tag + 'Name"]');
								$tagLabel.hide();
                                $tagLabelName.hide();
							}
						}else{
							if(n.elementType == "eform_subtable_bpm_auth"){
								var tagArr = n.tag.split("__");
								var colName = tagArr[1];
								var subTableName = tagArr[0];
								
								//var colModel = $("#"+subTableName).datagrid('getColumnFields');
								var hasColNameName = false;
								var colNameName = colName+"Name";
								/*if(colModel!=null && colModel.length>0){
									for(var m=0;m<colModel.length;m++){
										if(colModel[m]==colNameName){
											hasColNameName = true;
											break;
										}
									}
								}*/
								if(hasColNameName){
									jQuery("#" + subTableName).datagrid("showColumn",colName+"Name");
								}else{
									//jQuery("#" + subTableName).datagrid("showColumn",colName);
								}
								
							}else if(n.elementType == "eform_subtable_bpm_button_auth"){
								_self.defaultForm.controlSubTableButtonForAccess(n.tag, accessibility, n);
							}
						}
					});
				}
			}
		});
	}

};
/**
 * 初始化节点描述
 */
FlowEditor.prototype.hoverRemark = function() {
	if($("#bpm_buttons_remark").attr("isload") == "true"){
		return;
	}
	$("#bpm_buttons_remark").attr("isload","true");
	$.ajax({
		type : "POST",
		data : {
			defineId : this.flowModel.defineId,
			activityname : this.flowModel.activityname
		},
		url : "platform/bpm/business/getTaskRemark",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				var html = "";
				if(flowUtils.notNull(msg.result)){
					html = ""+msg.result+"";
				}else{
					html = "当前节点无描述";
				}
				$("#bpm_buttons_remark").attr("title", html);
			}
		}
	});
};
// 暴漏的全局属性
var _flow_editor = null;
var _avicTabIndex = 0;
function avicTabOnSwitch(index) {
	_avicTabIndex = index;
	if (index == 1) {
		if (typeof _flow_editor.needRefreshPic != "undefined" && _flow_editor.needRefreshPic) {
			_flow_editor.needRefreshPic = false;
			_flow_editor.refreshPic();
			_flow_editor.refreshTracks();
		}
	} else if (index == 2) {

	}
};;
