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
			if(!this.hasFlashWarning){
				flowUtils.warning("没有安装flash插件，将无法使用流程文档及附件的上传功能！");
				this.hasFlashWarning = true;
			}
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
};