/**
 * MyBase
 */
function MyBase(designerEditor, id, tagName) {
	this.designerEditor = designerEditor;
	this.id = id;// ID,流程的ID为流程的KEY
	this.tagName = tagName;
	this.cell;// 对应mxCell,通过getCell()获取
	this.forkJoinArr = [];
	this.defineId = typeof(_type) != "undefined" ? (_type == 2 ? _pdId : _id) : null;
	this.picIndex = 1;
};
/****************初始化、组装xml入口***************************/
/**
 * 初始化属性信息，新增mxCell时触发，子类重写
 */
MyBase.prototype.init = function() {
};
/**
 * 为流程跟踪提供的特殊方法
 * @param xmlValue
 * @param rootXml
 */
MyBase.prototype.initTracks = function(xmlValue, rootXml) {
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
MyBase.prototype.addForkJoin = function(forkJoinId) {
	this.forkJoinArr.push(forkJoinId);
};
MyBase.prototype.hasForkJoin = function() {
	return this.forkJoinArr.length > 0 ? true : false;
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 * @param rootXml
 */
MyBase.prototype.initLoad = function(xmlValue, rootXml) {
};
/**
 * 基础初始化功能，复制对应dom到相应区域内
 */
MyBase.prototype.initBase = function() {
	var temp = $("#" + this.tagName).clone(true, true);
	temp.attr("id", this.id);
	temp.addClass("temp");
	if(this.tagName == "process"){
		temp.appendTo(this.designerEditor.homeDiv);
		$("#" + this.id).show();
	}else{
		temp.appendTo(this.designerEditor.profileDiv);
		$("#" + this.id).hide();
	}
};
/**
 * 初始化基本信息，流程不需要该方法
 */
MyBase.prototype.initJBXX = function() {
	$("#" + this.id).find("#xian_shi_ming_cheng").val($.trim(this.alias));
	$("#" + this.id).find("#luo_ji_biao_shi").val(this.name);
};
MyBase.prototype.rename = function(newName) {
	if(this.alias == this.name){
		this.name = newName;
		this.alias = newName;
		$("#" + this.id).find("#luo_ji_biao_shi").val(this.name);
		$("#" + this.id).find("#xian_shi_ming_cheng").val($.trim(this.alias));
	}else {
		this.name = newName;
		$("#" + this.id).find("#luo_ji_biao_shi").val(this.name);
	}
};
/**
 * 组装processXML,流程子类改写了该方法
 * 
 * @returns
 */
MyBase.prototype.getXmlDoc = function() {
	this.cell = this.getCell();// 重写获取cell,后续操作直接拿this.cell
	var node = null;
	var enc = new mxCodec();
	
	this.designerEditor.editor.graph.setCellStyles("imageBorder", "", [ this.cell ]);
	
	var nodeCell = enc.encode(this.cell);
	if(this.tagName == "transition"){
		var node = flowUtils.createElement(this.tagName);
		node.setAttribute("_id", this.id);
		node.appendChild(nodeCell);
	}else{
		node = nodeCell;
	}
	this.putAttr("alias", this.alias, node);
	this.putAttr("g", this.getG(), node);
	this.putAttr("name", this.name, node);
	this.getOtherAttr(node);
	return node;
};
/**
 * 自定义扩展,子类需要重写，用于组装processXML时组织非公共部分
 * 
 * @param node
 */
MyBase.prototype.getOtherAttr = function(node) {
};
/************页签相关*****************/
/**
 * 点击mxCell时，显示对应的属性
 */
MyBase.prototype.showProp = function() {
	$(".prop_wrap").hide();
	$("#" + this.id).show();
	this.designerEditor.myCurCellId = this.id;
	setTimeout(function(){
		$('#propMainDiv').find('.nav-tabs').find('li').eq(1).trigger("click");
		$('#propMainDiv').find('.nav-tabs').find('a').eq(0).trigger("blur");
	}, 100);

	this.controlCandidate();
	this.afterShowProp();
};
MyBase.prototype.afterShowProp = function() {

};
MyBase.prototype.controlCandidate = function() {
	if(this.tagName == "transition" && $("#" + this.id).find('#draft-candidate-data-field').length > 0){
		var targetId = this.getCell().target.id;
		var targetNode = this.designerEditor.myCellMap.get(targetId);
		if(targetNode.tagName == "task"){
			var sourceId = this.getCell().source.id;
			var sourceNode = this.designerEditor.myCellMap.get(sourceId);
			if(sourceNode.tagName == "custom" || sourceNode.tagName == "java" || sourceNode.tagName == "sql"
				|| sourceNode.tagName == "state" || sourceNode.tagName == "ws" || sourceNode.tagName == "sub-process"){
				$("#" + this.id).find('#draft-candidate-data-field').parents(".candidate").show();
				return;
			}
		}
		$("#" + this.id).find('#draft-candidate-data-field').parents(".candidate").hide().find("input,textarea").val("");
	}
};
/********************方法*****************************/
/**
 * 销毁dom对象
 */
MyBase.prototype.remove = function() {
	$("#" + this.id).remove();
};

/**
 * 获取当前对应的mxCell
 * 
 * @returns
 */
MyBase.prototype.getCell = function() {
	return this.designerEditor.editor.graph.getModel().getCell(this.id);
};
/**
 * 解析位置G,连线子类改写了该方法
 * 
 * @returns {String}
 */
MyBase.prototype.getG = function() {
	var mxGeometry = this.cell.getGeometry();
	var x = "";
	var y = "";
	var parentLayer = this.cell.getParent();
	if(parentLayer != null && parentLayer.id != '1'){
		var parentMxGeometry = parentLayer.getGeometry();
		x = Math.round(parentMxGeometry.x) + Math.round(mxGeometry.x);
		y = Math.round(parentMxGeometry.y) + Math.round(mxGeometry.y);
	}else{
		x = Math.round(mxGeometry.x);
		y = Math.round(mxGeometry.y);
	}
	var g = x + ",";
	g += y + ",";
	g += mxGeometry.width + ",";
	g += mxGeometry.height;
	return g;
};
/**
 * 解析字符串G，连线重写了该方法
 * 
 * @returns {object}
 */
MyBase.prototype.getmxCellG = function() {
	var arr = this.g.split(",");
	var result = {};
	result.x = arr[0];
	result.y = arr[1];
	result.width = arr[2];
	result.height = arr[3];
	return result;
};
/**
 * 监听name改变事件，流程子类和连线子类改写了该方法
 * 
 * @param value
 */
MyBase.prototype.labelChanged = function(value) {
	this.alias = value;
	if(_iconType == "1"){
		//新图元
		if(this.tagName == "start" || this.tagName == "end" || this.tagName == "decision" || this.tagName == "fork" || this.tagName == "join"){
			return;
		}
	}
	this.designerEditor.editor.graph.labelChanged(this.getCell(), value);
};
/**
 * 通过name解析数字，例如end1解析出数字:1
 */
MyBase.prototype.resolve = function() {
	return Number(this.name.replace(this.tagName, ""));
};
/**
 * 构建mxCell,连线子类改写了该方法，流程不需要该方法
 */
MyBase.prototype.createMxCell = function(xmlValue) {
	var mxCellG = this.getmxCellG();
	var tagCell = flowUtils.createElement(this.tagName);
	tagCell.setAttribute("id", this.id);
	if(_iconType == "1"){
		//新图元
		if(this.tagName != "start" && this.tagName != "end" && this.tagName != "decision" && this.tagName != "fork" && this.tagName != "join"){
			tagCell.setAttribute("label", $.trim(this.alias));
		}
	}else{
		tagCell.setAttribute("label", $.trim(this.alias));
	}
	if(this.designerEditor.useNewDesigner){
		if(flowUtils.notNull(xmlValue.firstElementChild)){
			if(this.tagName == "start" || this.tagName == "end" || this.tagName == "decision" || this.tagName == "fork" || this.tagName == "join"){
				xmlValue.firstElementChild.firstElementChild.setAttribute('width', '55');
				xmlValue.firstElementChild.firstElementChild.setAttribute('height', '50');
			}
			tagCell.appendChild(xmlValue.firstElementChild);
		}else{
			if(this.tagName == "start" || this.tagName == "end" || this.tagName == "decision" || this.tagName == "fork" || this.tagName == "join"){
				xmlValue.firstChild.firstChild.setAttribute('width', '55');
				xmlValue.firstChild.firstChild.setAttribute('height', '50');
			}
			tagCell.appendChild(xmlValue.firstChild);
		}
		return tagCell;
	}
	var mxCell = flowUtils.createElement("mxCell");
	var mxGeometry = flowUtils.createElement("mxGeometry");
	mxCell.setAttribute("style", this.style);
	mxCell.setAttribute("vertex", "1");
	mxCell.setAttribute("parent", "1");

	mxGeometry.setAttribute("x", mxCellG.x);
	mxGeometry.setAttribute("y", mxCellG.y);
	mxGeometry.setAttribute("width", mxCellG.width);
	mxGeometry.setAttribute("height", mxCellG.height);
	mxGeometry.setAttribute("as", "geometry");

	mxCell.appendChild(mxGeometry);
	tagCell.appendChild(mxCell);
	return tagCell;
};

MyBase.prototype.doubleClickCell = function(){
};
/*******************组装xml、解析xml*******************************************/
/**********整理一下其他基本方法****************************/
/**
 * 往tagNodeXml中添加对应key-value,value进行空值判断
 * 
 * @param attrName
 * @param attrValue
 * @param tagNodeXml
 */
MyBase.prototype.putAttr = function(attrName, attrValue, tagNodeXml) {
	if(flowUtils.notNull(attrValue)){
		tagNodeXml.setAttribute(attrName, attrValue);
	}
};
/**
 * 从tagNodeXml中取出指定attrName的值
 * 
 * @param tagNodeXml
 * @param attrName
 */
MyBase.prototype.getAttr = function(tagNodeXml, attrName) {
	return $.trim(tagNodeXml.getAttribute(attrName));
};
/**
 * 创建节点meta添加到知道tagNodeXml中
 * @param metaName
 * @param metaValue
 * @param tagNodeXml
 */
MyBase.prototype.addMeta = function(metaName, metaValue, tagNodeXml) {
	if(flowUtils.notNull(metaValue)){
		var meta = flowUtils.createElement("meta");
		meta.setAttribute("name", metaName);
		meta.appendChild(flowUtils.createTextNode(metaValue));
		tagNodeXml.appendChild(meta);
	}
};
/**
 * 解析得到制定meta的值
 * @param tagNodeXml
 * @param metaName
 */
MyBase.prototype.getMeta = function(tagNodeXml, metaName) {
	return $.trim($(tagNodeXml).children("meta[name='"+metaName+"']").text());
};
/*********************setxml********************************/
/**
 * 设置xml的attr,取值为dom的value
 * @param domId
 * @param tagNodeXml
 * @param attrName
 */
MyBase.prototype.setXmlAttrByVal = function(domId, tagNodeXml, attrName) {
	this.putAttr(attrName, $("#" + this.id).find("#" + domId).val(), tagNodeXml);
};
/**
 * 设置xml的meta,取值为dom的value
 * @param domId
 * @param tagNodeXml
 * @param metaName
 */
MyBase.prototype.setXmlMetaByVal = function(domId, tagNodeXml, metaName) {
	var text = $("#" + this.id).find("#" + domId).val();
	if(flowUtils.notNull(text)){
		text = "<![CDATA[" + text + "]]>";
		this.addMeta(metaName, text, tagNodeXml);
	}
};
/**
 * 设置xml的attr,取值为dom对象(check radio)
 * @param domName
 * @param tagNodeXml
 * @param attrName
 */
MyBase.prototype.setXmlAttrByCheck = function(domName, tagNodeXml, attrName) {
	this.putAttr(attrName, $("#" + this.id).find("input[name='" + domName + "']:checked").val(), tagNodeXml);
};
/**
 * 设置xml的meta,取值为dom对象(check radio)
 * @param domName
 * @param tagNodeXml
 * @param metaName
 */
MyBase.prototype.setXmlMetaByCheck = function(domName, tagNodeXml, metaName) {
 // 获取input勾选值，勾选:yes, 未勾选:no
 // modify by hangchao.you 201704
	var $that = $("#" + this.id).find("input[name='" + domName + "']");
	var content = $that.is(":checked") ? "yes":"no";
	this.addMeta(metaName, content, tagNodeXml);
//	this.addMeta(metaName, $("#" + this.id).find("input[name='" + domName + "']:checked").val(), tagNodeXml);
};
/**
 * 设置xml的attr,取值为dom对象(prop)
 * @param domId
 * @param tagNodeXml
 * @param attrName
 * @param domProp
 */
MyBase.prototype.setXmlAttrByProp = function(domId, tagNodeXml, attrName, domProp) {
	this.putAttr(attrName, $("#" + this.id).find("#" + domId).attr(domProp), tagNodeXml);
};
/**
 * 设置xml的meta,取值为dom对象(prop)
 * @param domId
 * @param tagNodeXml
 * @param metaName
 * @param domProp
 */
MyBase.prototype.setXmlMetaByProp = function(domId, tagNodeXml, metaName, domProp) {
	this.addMeta(metaName, $("#" + this.id).find("#" + domId).attr(domProp), tagNodeXml);
};
/************************setDom******************************/
/**
 * 设置dom对象的value,取值为xml的attr
 * @param domId
 * @param tagNodeXml
 * @param attrName
 */
MyBase.prototype.setDomValByAttr = function(domId, tagNodeXml, attrName) {
	$("#" + this.id).find("#" + domId).val(this.getAttr(tagNodeXml, attrName));
};
/**
 * 设置dom对象的value,取值为xml的meta
 * @param domId
 * @param tagNodeXml
 * @param metaName
 */
MyBase.prototype.setDomValByMeta = function(domId, tagNodeXml, metaName) {
	$("#" + this.id).find("#" + domId).val(this.getMeta(tagNodeXml, metaName));
};
/**
 * 设置dom对象(check radio),取值为xml的attr
 * @param domId
 * @param tagNodeXml
 * @param attrName
 * @param domValue
 */
MyBase.prototype.setDomCheckByAttr = function(domId, tagNodeXml, attrName, domValue) {
	var attrValue = this.getAttr(tagNodeXml, attrName);
	if(attrValue == domValue){
		$("#" + this.id).find("#" + domId).attr("checked", true);
		$("#" + this.id).find("#" + domId).trigger('click');
	}
};
/**
 * 设置dom对象(check radio),取值为xml的meta
 * @param domId
 * @param tagNodeXml
 * @param metaName
 * @param domValue
 */
MyBase.prototype.setDomCheckByMeta = function(domId, tagNodeXml, metaName, domValue) {
	var metaValue = this.getMeta(tagNodeXml, metaName);
	$("#" + this.id).find("#" + domId).prop("checked", metaValue == undefined ? (domValue=="yes" ? true :false)
			: (metaValue =="yes" ? true :false) );
//	$("#" + this.id).find("#" + domId).trigger('click');
};
/**
 * 设置dom对象(自定义属性),取值为xml的attr
 * @param domId
 * @param tagNodeXml
 * @param attrName
 * @param domProp
 */
MyBase.prototype.setDomPropByAttr = function(domId, tagNodeXml, attrName, domProp) {
	var attrValue = this.getAttr(tagNodeXml, attrName);
	if(flowUtils.notNull(attrValue)){
		$("#" + this.id).find("#" + domId).attr(domProp, attrValue);
	}
};
/**
 * 设置dom对象(自定义属性),取值为xml的meta
 * @param domId
 * @param tagNodeXml
 * @param metaName
 * @param domProp
 */
MyBase.prototype.setDomPropByMeta = function(domId, tagNodeXml, metaName, domProp) {
	var metaValue = this.getMeta(tagNodeXml, metaName);
	if(flowUtils.notNull(metaValue)){
		$("#" + this.id).find("#" + domId).attr(domProp, metaValue);
	}
};

/**
 * 构建备注部分，子类直接调用
 */
MyBase.prototype.createRemarkXml = function(tagNodeXml) {
	var text = $('#' + this.id).find('#bei_zhu_xin_xi').val();
	if(text != undefined && text.length > 0){
		text = "<![CDATA[" + text + "]]>";
		this.addMeta("remark", text, tagNodeXml);
	}
};
/**
 * 加载初始化备注部分
 * @param tagNodeXml
 */
MyBase.prototype.createRemarkDom = function(tagNodeXml) {
	this.setDomValByMeta("bei_zhu_xin_xi", tagNodeXml, "remark");
};

/**
 * 构建权限XML
 * @param tagNodeXml xml
 * @param domId tbodyDomId
 * @param tagName xmlTagName
 */
MyBase.prototype.createQXXml = function(tagNodeXml, checkId, type, name, rootNodeXml) {
	var $checkDom = $('#' + this.id).find("input[name='" + checkId+"']");
	var key=$checkDom.prop('checked');
	if(key){
		var $divAuthBox = $checkDom.parentsUntil("div[class^='div-auth-checkbox']").parent().siblings("div[class^='div-auth-box']");
		// 操作人
		var flagProcess = $divAuthBox.find("input[name='operator-data-field']");
		var flagScope = $divAuthBox.find("input[name='candidate-data-field']");
		var flagPreProcessing = $divAuthBox.find("input[name='preprocess-data-field']");
		var flagPostProcessing = $divAuthBox.find("input[name='postprocess-data-field']");
		
		var flagActivity = $divAuthBox.find("input[name='input_kua_jie_dian_tui_hui_activity']");


		var magic = flowUtils.createElement("magic");
		magic.setAttribute('type', type);
		magic.setAttribute('name', name);

		var flgAlias = $divAuthBox.find("input[name='operator-alias']");
		if(flowUtils.notNull(flgAlias.val())) {
			var alias = $.trim(flgAlias.val());
			magic.setAttribute('alias', alias);
		}

		var flgJScript = $divAuthBox.find("input[name='operator-jScript']");
		if(flowUtils.notNull(flgJScript.val())) {
			var jScript = $.trim(flgJScript.val());
			magic.setAttribute('jScript', jScript);
		}

		var possess = flowUtils.createElement("possess");
		var scope = flowUtils.createElement("scope");
		var preProcessing = flowUtils.createElement("pre-processing");
		var postProcessing = flowUtils.createElement("post-processing");
		
		var activity = flowUtils.createElement("activity");
		
		var ownerId = flagProcess.attr("actorsid");
		if(flowUtils.notNull(ownerId)){
			possess.setAttribute('owner', ownerId);
			this.createUserSelectXml(ownerId, flagProcess.val(), rootNodeXml);
		}else{
			possess.setAttribute('owner', "");
		}
		var selectId = flagScope.attr("actorsid");
		if(flowUtils.notNull(selectId)){
			scope.setAttribute('select', selectId);
			this.createUserSelectXml(selectId, flagScope.val(), rootNodeXml);
		}else{
			scope.setAttribute('select', "");
		}
		
		var preAlias = "";
		var preName = "";
		if(flowUtils.notNull(flagPreProcessing.val())){
			preAlias = $.trim(flagPreProcessing.val().split("【")[0]);
			preName = $.trim(flagPreProcessing.val().split("【")[1]).replace("】", "");
		}
		preProcessing.setAttribute('class', preName);
		preProcessing.appendChild(flowUtils.createTextNode(preAlias));
		
		var postAlias = "";
		var postName = "";
		if(flowUtils.notNull(flagPostProcessing.val())){
			postAlias = $.trim(flagPostProcessing.val().split("【")[0]);
			postName = $.trim(flagPostProcessing.val().split("【")[1]).replace("】", "");
		}
		postProcessing.setAttribute('class', postName);
		postProcessing.appendChild(flowUtils.createTextNode(postAlias));
		
		var activityAlias = "";
		var activityName = "";
		if(flowUtils.notNull(flagActivity.val())){
			var vArr = flagActivity.val().split(",");
			for(var k = 0; k < vArr.length; k ++){
				if(k > 0){
					activityAlias += ",";
					activityName += ",";
				}
				activityAlias += $.trim(vArr[k].split("【")[0]);
				activityName += $.trim(vArr[k].split("【")[1]).replace("】", "");
			}
		}
		activity.setAttribute('activityName', activityName);
		activity.appendChild(flowUtils.createTextNode(activityAlias));
		
		magic.appendChild(possess);
		magic.appendChild(scope);
		magic.appendChild(preProcessing);
		magic.appendChild(postProcessing);
		
		magic.appendChild(activity);
		
		tagNodeXml.appendChild(magic);
	}
};

/**
 * 权限加载
 * @param tagNodeXml xml
 * @param domId tbodyDomId
 * @param tagName xmlTagName
 */
MyBase.prototype.createQXDom = function(tagNodeXml, checkId, type){
	var self = this;
	$(tagNodeXml).children("magics").children("magic[type='" + type + "']").each(function(){
		var $checkDom = $('#' + self.id).find("input[name='" + checkId+"']");
		var $divAuthBox = $checkDom.parentsUntil("div[class^='div-auth-checkbox']").parent().siblings("div[class^='div-auth-box']");
		
		var ownerId = $(this).find("possess").attr("owner");
		var selectId = $(this).find("scope").attr("select");

		var alias = $(this).attr("alias");
		if(flowUtils.notNull(alias)) {
			var $aliasDom = $divAuthBox.find("input[name='operator-alias']");
			$aliasDom.val(alias);
		}

		var jScript = $(this).attr("jScript");
		if(flowUtils.notNull(jScript)) {
			var $jScriptDom = $divAuthBox.find("input[name='operator-jScript']");
			$jScriptDom.val(jScript);
		}

		if(flowUtils.notNull(ownerId)){
			// 操作人
			var flagProcess = $divAuthBox.find("input[name='operator-data-field']");
			var flagProcessText = $divAuthBox.find("input[name='operator-text-field']");
			flagProcess.attr("actorsId", ownerId);
			var actors = self.getUserSelectObjFromXml(ownerId, tagNodeXml);
			flagProcess.val(JSON.stringify(actors));
			var actorsText = self.getUserSelectTextFieldValue(actors);
			flagProcessText.val(actorsText);
			flagProcessText.attr("title", actorsText);
		}
		if(flowUtils.notNull(selectId)){
			var flagScope = $divAuthBox.find("input[name='candidate-data-field']");
			var flagScopeText = $divAuthBox.find("input[name='candidate-text-field']");
			flagScope.attr("actorsId", selectId);
			var actors = self.getUserSelectObjFromXml(selectId, tagNodeXml);
			flagScope.val(JSON.stringify(actors));
			var actorsText = self.getUserSelectTextFieldValue(actors);
			flagScopeText.val(actorsText);
			flagScopeText.attr("title", actorsText);
		}
		
		var preProcessing  = $.trim($(this).find("pre-processing").attr("class"));
		var postProcessing  = $.trim($(this).find("post-processing").attr("class"));
		var preProcessingText  = $.trim($(this).find("pre-processing").text());
		var postProcessingText  = $.trim($(this).find("post-processing").text());
		
		var activityName  = $.trim($(this).find("activity").attr("activityName"));
		var activityAlias  = $.trim($(this).find("activity").text());
		
		var flagPreProcessing = $divAuthBox.find("input[name='preprocess-data-field']");
		if(flowUtils.notNull(preProcessing)){
			var data = preProcessingText + "【" + preProcessing + "】";
			flagPreProcessing.val(data);
			flagPreProcessing.attr("title",data);
		}
		
		var flagPostProcessing = $divAuthBox.find("input[name='postprocess-data-field']");
		if(flowUtils.notNull(postProcessing)){
			var data = postProcessingText + "【" + postProcessing + "】";
			flagPostProcessing.val(data);
			flagPostProcessing.attr("title",data);
		}
		
		var flgActivity = $divAuthBox.find("input[name='input_kua_jie_dian_tui_hui_activity']");
		if(flowUtils.notNull(activityName)){
			var nameArr = activityName.split(",");
			var aliasArr = activityAlias.split(",");
			var v = "";
			for(var k = 0; k < nameArr.length; k++){
				if(k > 0){
					v += ",";
				}
				v += aliasArr[k] + "【" + nameArr[k] + "】";
			}
			flgActivity.val(v);
			flgActivity.attr("title",v);
		}
		
		$checkDom.trigger('click');
	});
};
/**
 * 文档权限
 * @param tagNodeXml
 */
MyBase.prototype.createWDQXDom = function(tagNodeXml){
	var self = this;
	$(tagNodeXml).children("docRights").children("docRight").each(function(){
		var domId = $(this).attr("type");
		$("#" + self.id).find("input[name='" + domId+"']").trigger('click');
		$(this).children("subDocRight").each(function(){
			var subId = $(this).attr("type");
			var $inputDom = $("#" + self.id).find("." + domId).find("#" + subId);
			if($inputDom.is("input[type='checkbox']")){
				$inputDom.trigger('click');
			}else if($inputDom.is(".wd_text")){
				$inputDom.val($(this).attr("name"));
				$inputDom.attr("wd_text_ids", $(this).attr("value"));
			}else if($inputDom.is(".wd_actor")){
				$inputDom.attr("actorsId", $(this).attr("value"));
				$inputDom.val(actorFactory.getActorsTextById($(this).attr("value")));
			}
		});
	});
};
/**
 * 文档权限
 * @param tagNodeXml
 * @param domId
 * @param domName
 * @param rootNodeXml
 */
MyBase.prototype.createWDQXXml = function(tagNodeXml, domId, domName, rootNodeXml){
	var self = this;
	if($("#" + this.id).find("input[name='" + domId+"']").prop('checked')){
		var docRight = flowUtils.createElement("docRight");
		docRight.setAttribute("type", domId);
		docRight.setAttribute("name", domName);
		$("#" + this.id).find("." + domId).find("input[type='checkbox']:checked").each(function(){
			var subDocRight = flowUtils.createElement("subDocRight");
			subDocRight.setAttribute("type", $(this).attr("id"));
			subDocRight.setAttribute("name", $(this).next().text());
			subDocRight.setAttribute("value", $(this).attr("id"));
			docRight.appendChild(subDocRight);
		});
		$("#" + this.id).find("." + domId).find(".wd_text").each(function(){
			if($.notNull($(this).val())){
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", $(this).attr("id"));
				subDocRight.setAttribute("name", $(this).val());
				subDocRight.setAttribute("value", $(this).attr("wd_text_ids"));
				docRight.appendChild(subDocRight);
			}
		});
		$("#" + this.id).find("." + domId).find(".wd_actor").each(function(){
			if($.notNull($(this).val())){
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", $(this).attr("id"));
				subDocRight.setAttribute("name", $(this).parent().prev().text());
				subDocRight.setAttribute("value", $(this).attr("actorsId"));
				docRight.appendChild(subDocRight);
				self.createUserSelectXml(rootNodeXml, $(this).attr("actorsId"));
			}
		});
		tagNodeXml.appendChild(docRight);
	}
};

MyBase.prototype.setConditionXml = function(executorDomId, tableExecutorDomId, tagNodeXml) {
	var $obj = $('#' + this.id).find('#' + tableExecutorDomId + ' tr[name!="title"]');
	if($obj.length > 0) {
		var node = flowUtils.createElement('conditions');
		// 执行方式 and || or 
		node.setAttribute('type', $('#' + this.id).find('#' + executorDomId).val());
		$obj.each(function(){
			var conditionNode = flowUtils.createElement('condition');
			//如果td中有longJs属性且不为空，则xml需要保存longJs和表达式
			//var curTd = $(this).find("td");
			var longJs = $(this).find("td").eq(0).find("input");
			if(typeof longJs != "undefined" && longJs.text() != '' && longJs.text() != null){
                conditionNode.setAttribute('type', $(this).find("td").eq(1).text().trim());
                conditionNode.appendChild(flowUtils.createTextNode("<![CDATA[" + longJs.text().trim() + "]]>"));

                conditionNode.setAttribute('computeRes', $(this).find("td").eq(2).text().trim());
			}else{
                conditionNode.setAttribute('type', $(this).find("td").eq(1).text().trim());
                conditionNode.appendChild(flowUtils.createTextNode("<![CDATA[" + $(this).find("td").eq(2).text().trim() + "]]>"));
			}
			node.appendChild(conditionNode);
		});
		tagNodeXml.appendChild(node);
	}
	
}


MyBase.prototype.getUserSelectTextFieldValue = function(userList) {
	var showUserList = "";
	var selectedDept = ""
	var selectedUser = "";
	var selectedPosition = "";
	var selectedRole = "";
	var selectedGroup = "";
	var selectedRelation = "";
	for(var i = 0;  i< userList.length; i++ ){
		var user = userList[i];
//		【部门】研发中心#普通员工;【用户】张三;【角色】一般用户;【群组】群组1;【岗位】普通员工;
		var type = user.type;
		if(type == "dept") {
			
			if(''==user.position.positionId){
				selectedDept += user.name+";";
			}else{
				selectedDept += user.name+"#"+user.position.positionName+";";
			}
		} else if (type == "user" ) {
			selectedUser += user.name+";";
		} else if (type == "position") {
			selectedPosition +=  user.name+";";
		} else if (type == "role") {
			selectedRole += user.name + ";";
		} else if (type == "group") {
			selectedGroup += user.name + ";";
		} else if (type == "relation") {
			selectedRelation += user.name;
			if(user.deptlevel) selectedRelation += "#"+user.deptlevel.deptlevelName;
			if(user.position) selectedRelation += "#"+user.position.positionName;
			if(user.step) selectedRelation += "#"+user.step.stepName;
			if(user.customfunction) selectedRelation += "#"+user.customfunction.customfunctionName;
			if(user.variable) selectedRelation += "#"+user.variable.dataTypeName+"#"+user.variable.variableAlias;
			if(user.intersection) selectedRelation += "#交集选人#"+user.intersection.intersectionAlias;
			selectedRelation += ";";
		}
	}
	if (selectedDept != "") {
		selectedDept = "【部门】" + selectedDept;
		showUserList += selectedDept;
	}
	if (selectedUser != "") {
		selectedUser = "【用户】" + selectedUser;
		showUserList += selectedUser;
	}
	if (selectedPosition != "") {
		selectedPosition = "【岗位】" + selectedPosition;
		showUserList += selectedPosition;
	}
	if (selectedRole != "") {
		selectedRole = "【角色】" + selectedRole;
		showUserList += selectedRole;
	}
	if (selectedGroup != "") {
		selectedGroup = "【群组】" + selectedGroup;
		showUserList += selectedGroup;
	}
	if (selectedRelation != "") {
		selectedRelation = "【关系】" + selectedRelation;
		showUserList += selectedRelation;
	}
	return showUserList;
}

/**
 * {
 *     userSelectContainer :'candidate-container' ,  选人容器id
 *     dataField:'candidate-data-field',	数据存储id
 *     textField:'candidate-text-field'		文本显示id
 *   }
 * @param option 
 * @param tagNodeXml
 */
MyBase.prototype.setUserSelectDom = function(option, tagNodeXml) {
	var _self = this;
	var candidateId = _self.getAttr(tagNodeXml, "candidate-users");
	if (candidateId.length > 0) {
		var actors = _self.getUserSelectObjFromXml(candidateId, tagNodeXml);
		$("#"+_self.id +" #"+option.dataField).val(JSON.stringify(actors));
		$("#"+_self.id +" #"+option.dataField).attr("actorsId",candidateId);
		$("#"+_self.id +" #"+option.textField).val(_self.getUserSelectTextFieldValue(actors));
	}
};

/**
 * { 创建人工节点候选人的时候，获取用户xml信息
 *     userSelectContainer :'candidate-container' ,  选人容器id
 *     dataField:'candidate-data-field',	数据存储id
 *     textField:'candidate-text-field'		文本显示id
 *   }
 * @param option 
 * @param tagNodeXml
 */
MyBase.prototype.setUserSelectXml = function(option , tagNodeXml ) {
	// 获取选中的人员信息
	var $candidate = $("#"+this.id +" #"+option.dataField);
	var actorsId = $candidate.attr("actorsId");
	var actorDataValue = $candidate.val();
	if (actorsId == undefined || actorDataValue == undefined || actorDataValue.length == 0) {
		return;
	}
	
	var node = flowUtils.createElement('actors'); // 创建一个人员xml节点
	tagNodeXml.setAttribute("candidate-users", actorsId); // 流程节点选人id
	node.setAttribute("id", actorsId);
	// 开始封装人员xml信息
	var actorJSONArray = JSON.parse(actorDataValue);
	for(var i=0 ; i < actorJSONArray.length ; i++) {
	   var actorNode = flowUtils.createElement('actor'); 
	   var	aActorJson = actorJSONArray[i];
	   actorNode.setAttribute("type", aActorJson.type);
	   var idNode = flowUtils.createElement('id'); 
	   idNode.appendChild(flowUtils.createTextNode(aActorJson.id));
   	   var nameNode = flowUtils.createElement('name'); 
   	   nameNode.appendChild(flowUtils.createTextNode(aActorJson.name));
   	   actorNode.appendChild(idNode);
   	   actorNode.appendChild(nameNode);
   	   if (aActorJson.type == "dept") {
   		   if(aActorJson.position){
	   			var positionNode = flowUtils.createElement('position'); 
	   	   		var positionIdNode = flowUtils.createElement('id'); 
	   	   			positionIdNode.appendChild(flowUtils.createTextNode(aActorJson.position.positionId));
	   	   		var positionNameNode = flowUtils.createElement('name'); 
	   	   			positionNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.position.positionName + "]]>"));
	   	   		positionNode.appendChild(positionIdNode);
	   	   		positionNode.appendChild(positionNameNode);
	   	   		actorNode.appendChild(positionNode);
   		   }
   		 
		} else if (aActorJson.type == "relation") {
			if(aActorJson.position) {
				 var positionNode = flowUtils.createElement('position'); 
		   	   		var positionIdNode = flowUtils.createElement('id'); 
	   	   			positionIdNode.appendChild(flowUtils.createTextNode(aActorJson.position.positionId));
	   	   		var positionNameNode = flowUtils.createElement('name'); 
	   	   			positionNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.position.positionName + "]]>"));
	   	   		positionNode.appendChild(positionIdNode);
	   	   		positionNode.appendChild(positionNameNode);
	   	   		actorNode.appendChild(positionNode);
			}
			if(aActorJson.deptlevel) {
				 var deptlevelNode = flowUtils.createElement('deptlevel'); 
		   	   		var deptlevelIdNode = flowUtils.createElement('id'); 
		   	   			deptlevelIdNode.appendChild(flowUtils.createTextNode(aActorJson.deptlevel.deptlevelId));
	   	   		var deptlevelNameNode = flowUtils.createElement('name'); 
	   	   			deptlevelNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.deptlevel.deptlevelName + "]]>"));
	   	   			deptlevelNode.appendChild(deptlevelIdNode);
	   	   			deptlevelNode.appendChild(deptlevelNameNode);
	   	   		actorNode.appendChild(deptlevelNode);
			}
			if(aActorJson.step) {
				 var stepNode = flowUtils.createElement('step'); 
		   	   		var stepIdNode = flowUtils.createElement('id'); 
		   	   			stepIdNode.appendChild(flowUtils.createTextNode(aActorJson.step.stepId));
	   	   		var stepNameNode = flowUtils.createElement('name'); 
	   	   			stepNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.step.stepName + "]]>"));
	   	   			stepNode.appendChild(stepIdNode);
	   	   			stepNode.appendChild(stepNameNode);
	   	   		actorNode.appendChild(stepNode);
			}
			if(aActorJson.customfunction) {
				var customfunctionNode = flowUtils.createElement('customfunction'); 
				var customfunctionIdNode = flowUtils.createElement('id'); 
				// customfunctionIdNode.appendChild(flowUtils.createTextNode(aActorJson.customfunction.customfunctionId));
				customfunctionIdNode.appendChild(flowUtils.createTextNode(aActorJson.customfunction.customfunctionName));
				var customfunctionNameNode = flowUtils.createElement('name'); 
				customfunctionNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.customfunction.customfunctionName + "]]>"));
				customfunctionNode.appendChild(customfunctionIdNode);
				customfunctionNode.appendChild(customfunctionNameNode);
				actorNode.appendChild(customfunctionNode);
			}
			
			if(aActorJson.variable){
            	var variableNode = flowUtils.createElement("variable");
            	var variableIdNode = flowUtils.createElement("id");
            	variableIdNode.appendChild(flowUtils.createTextNode("#{"+aActorJson.variable.variableName+"}"));
            	var variableNameNode = flowUtils.createElement("name");
            	variableNameNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.variable.variableAlias+"]]>"));
            	variableNode.appendChild(variableIdNode);
            	variableNode.appendChild(variableNameNode);
            	actorNode.appendChild(variableNode);
            	
            	var typeNode = flowUtils.createElement("type")
            	var typeIdNode = flowUtils.createElement("id");
            	typeIdNode.appendChild(flowUtils.createTextNode(aActorJson.variable.dataType));
            	var typeNameNode = flowUtils.createElement("name");
            	typeNameNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.variable.dataTypeName+"]]>"));
            	typeNode.appendChild(typeIdNode);
            	typeNode.appendChild(typeNameNode);
            	actorNode.appendChild(typeNode);

				var deptPositionNode = flowUtils.createElement("deptPosition")
				var deptPositionIdNode = flowUtils.createElement("id");
				deptPositionIdNode.appendChild(flowUtils.createTextNode(aActorJson.variable.deptPositionId));
				var deptPositionNameNode = flowUtils.createElement("name");
				deptPositionNameNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.variable.deptPositionName+"]]>"));
				deptPositionNode.appendChild(deptPositionIdNode);
				deptPositionNode.appendChild(deptPositionNameNode);
				actorNode.appendChild(deptPositionNode);
            }
			if(aActorJson.intersection){
            	var intersectionNode = flowUtils.createElement("intersection");
            	var intersectionIdNode = flowUtils.createElement("id");
            	intersectionIdNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.intersection.intersectionValue+"]]>"));
            	var intersectionNameNode = flowUtils.createElement("name");
            	intersectionNameNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.intersection.intersectionAlias+"]]>"));
            	intersectionNode.appendChild(intersectionIdNode);
            	intersectionNode.appendChild(intersectionNameNode);
            	actorNode.appendChild(intersectionNode);
            }
		}
	   node.appendChild(actorNode);
	}
	tagNodeXml.appendChild(node);
}

MyBase.prototype.createUserSelectXml = function(actorsId , actorDataValue, tagNodeXml) {
	// 获取选中的人员信息
	if (actorsId == undefined || actorDataValue == undefined || actorDataValue.length == 0) {
		return;
	}
	
	var node = flowUtils.createElement('actors'); // 创建一个人员xml节点
	//tagNodeXml.setAttribute("candidate-users", actorsId); // 流程节点选人id
	node.setAttribute("id", actorsId);
	// 开始封装人员xml信息
	var actorJSONArray = JSON.parse(actorDataValue);
	for(var i=0 ; i < actorJSONArray.length ; i++) {
	   var actorNode = flowUtils.createElement('actor'); 
	   var	aActorJson = actorJSONArray[i];
	   actorNode.setAttribute("type", aActorJson.type);
	   var idNode = flowUtils.createElement('id'); 
	   idNode.appendChild(flowUtils.createTextNode(aActorJson.id));
   	   var nameNode = flowUtils.createElement('name'); 
   	   nameNode.appendChild(flowUtils.createTextNode(aActorJson.name));
   	   actorNode.appendChild(idNode);
   	   actorNode.appendChild(nameNode);
   	   if (aActorJson.type == "dept") {
   		if(aActorJson.position) {
	   		 var positionNode = flowUtils.createElement('position'); 
	   	   		var positionIdNode = flowUtils.createElement('id'); 
	   	   			positionIdNode.appendChild(flowUtils.createTextNode(aActorJson.position.positionId));
	   	   		var positionNameNode = flowUtils.createElement('name'); 
	   	   			positionNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.position.positionName + "]]>"));
	   	   		positionNode.appendChild(positionIdNode);
	   	   		positionNode.appendChild(positionNameNode);
	   	   		actorNode.appendChild(positionNode);
	   		}
		} else if (aActorJson.type == "relation") {
			if(aActorJson.position) {
				 var positionNode = flowUtils.createElement('position'); 
		   	   		var positionIdNode = flowUtils.createElement('id'); 
	   	   			positionIdNode.appendChild(flowUtils.createTextNode(aActorJson.position.positionId));
	   	   		var positionNameNode = flowUtils.createElement('name'); 
	   	   			positionNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.position.positionName + "]]>"));
	   	   		positionNode.appendChild(positionIdNode);
	   	   		positionNode.appendChild(positionNameNode);
	   	   		actorNode.appendChild(positionNode);
			}
			if(aActorJson.deptlevel) {
				 var deptlevelNode = flowUtils.createElement('deptlevel'); 
		   	   		var deptlevelIdNode = flowUtils.createElement('id'); 
		   	   			deptlevelIdNode.appendChild(flowUtils.createTextNode(aActorJson.deptlevel.deptlevelId));
	   	   		var deptlevelNameNode = flowUtils.createElement('name'); 
	   	   			deptlevelNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.deptlevel.deptlevelName + "]]>"));
	   	   			deptlevelNode.appendChild(deptlevelIdNode);
	   	   			deptlevelNode.appendChild(deptlevelNameNode);
	   	   		actorNode.appendChild(deptlevelNode);
			}
			if(aActorJson.step) {
				 var stepNode = flowUtils.createElement('step'); 
		   	   		var stepIdNode = flowUtils.createElement('id'); 
		   	   			stepIdNode.appendChild(flowUtils.createTextNode(aActorJson.step.stepId));
	   	   		var stepNameNode = flowUtils.createElement('name'); 
	   	   			stepNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.step.stepName + "]]>"));
	   	   			stepNode.appendChild(stepIdNode);
	   	   			stepNode.appendChild(stepNameNode);
	   	   		actorNode.appendChild(stepNode);
			}
			if(aActorJson.customfunction) {
				var customfunctionNode = flowUtils.createElement('customfunction'); 
				var customfunctionIdNode = flowUtils.createElement('id'); 
				// customfunctionIdNode.appendChild(flowUtils.createTextNode(aActorJson.customfunction.customfunctionId));
				customfunctionIdNode.appendChild(flowUtils.createTextNode(aActorJson.customfunction.customfunctionName));
				var customfunctionNameNode = flowUtils.createElement('name'); 
				customfunctionNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.customfunction.customfunctionName + "]]>"));
				customfunctionNode.appendChild(customfunctionIdNode);
				customfunctionNode.appendChild(customfunctionNameNode);
				actorNode.appendChild(customfunctionNode);
			}
			
			if(aActorJson.variable){
            	var variableNode = flowUtils.createElement("variable");
            	var variableIdNode = flowUtils.createElement("id");
            	variableIdNode.appendChild(flowUtils.createTextNode("#{"+aActorJson.variable.variableName+"}"));
            	var variableNameNode = flowUtils.createElement("name");
            	variableNameNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.variable.variableAlias+"]]>"));
            	variableNode.appendChild(variableIdNode);
            	variableNode.appendChild(variableNameNode);
            	actorNode.appendChild(variableNode);
            	
            	var typeNode = flowUtils.createElement("type")
            	var typeIdNode = flowUtils.createElement("id");
            	typeIdNode.appendChild(flowUtils.createTextNode(aActorJson.variable.dataType));
            	var typeNameNode = flowUtils.createElement("name");
            	typeNameNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.variable.dataTypeName+"]]>"));
            	typeNode.appendChild(typeIdNode);
            	typeNode.appendChild(typeNameNode);
            	actorNode.appendChild(typeNode);

				var deptPositionNode = flowUtils.createElement("deptPosition")
				var deptPositionIdNode = flowUtils.createElement("id");
				deptPositionIdNode.appendChild(flowUtils.createTextNode(aActorJson.variable.deptPositionId));
				var deptPositionNameNode = flowUtils.createElement("name");
				deptPositionNameNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.variable.deptPositionName+"]]>"));
				deptPositionNode.appendChild(deptPositionIdNode);
				deptPositionNode.appendChild(deptPositionNameNode);
				actorNode.appendChild(deptPositionNode);
            }
			
			if(aActorJson.intersection){
            	var intersectionNode = flowUtils.createElement("intersection");
            	var intersectionIdNode = flowUtils.createElement("id");
            	intersectionIdNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.intersection.intersectionValue+"]]>"));
            	var intersectionNameNode = flowUtils.createElement("name");
            	intersectionNameNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.intersection.intersectionAlias+"]]>"));
            	intersectionNode.appendChild(intersectionIdNode);
            	intersectionNode.appendChild(intersectionNameNode);
            	actorNode.appendChild(intersectionNode);
            }
		}
	   node.appendChild(actorNode);
	}
	tagNodeXml.appendChild(node);
}

MyBase.prototype.getUserSelectObjFromXml = function(actorsId , tagNodeXml ) {
	var _self = this;
	var usersObj = [];
// 反向解析用户信息，并保存为js对象
	$(tagNodeXml).children("actors[id='"+actorsId+"']").each(function(){ // 可能有多个，兼容一下
		$(this).children('actor').each(function(){
			var user = {};
			var type = $(this).attr("type");
			var id = $.trim($(this).children("id").text());
			var name = $.trim($(this).children("name").text());
			user.id = id;
			user.treeId = id;
			user.type = type;
			user.name = name;
			if(type == "dept") {
				user.typeName = "用户";
				var $position = $(this).children("position");
				user.position = {
						positionId : $.trim($position.children("id").text()),
						positionName :   $.trim($position.children("name").text())
				}
				user.primaryId = user.treeId+"_"+type+"_"+id+(user.position.positionId?"_"+user.position.positionId:"");	
			} else if (type == "user" || type == "position" || type == "group" || type == "role") {
				user.typeName = "用户";
				user.primaryId = id+"_"+type+"_"+id;	
			} else if(type = "relation") {
				var $position = $(this).children("position");
				 if($position.get(0)) {
						user.position = {
								positionId : $.trim($position.children("id").text()),
								positionName :  $.trim($position.children("name").text())
						}
			    }
				 
				var $deptlevel = $(this).children("deptlevel");
			      if($deptlevel.get(0)) {
			        	user.deptlevel = {
			        			deptlevelId : $.trim($deptlevel.children("id").text()),
			        			deptlevelName : $.trim($deptlevel.children("name").text())
			           	};
			    }  
			    
			    var $step = $(this).children("step");
			    if($step.get(0)) {
		        	user.step = {
		        			stepId : $.trim($step.children("id").text()),
		        			stepName : $.trim($step.children("name").text())
		        		};
			    }  
			    var $customfunction = $(this).children("customfunction");
			    if($customfunction.get(0)) {
			    	user.customfunction = {
			    			customfunctionId : $.trim($customfunction.children("id").text()),
			    			customfunctionName : $.trim($customfunction.children("name").text())
			    	};
			    }  
			    
			    var $variable = $(this).children("variable");
				var $type = $(this).children("type");
				var $deptPosition = $(this).children("deptPosition");
			    if($variable.get(0)){
			    	var varId = $.trim($variable.children("id").text());
			    	varId = varId.replace("#","").replace("{", "").replace("}", "");
                    var variableName = $.trim($variable.find("name").eq(0).text());
					var dataType = $.trim($type.children("id").text());
					var dataTypeName = $.trim($type.find("name").eq(0).text());
					var deptPositionId = "";
					var deptPositionName = "";
					if($deptPosition.get(0)){
						deptPositionId = $.trim($deptPosition.children("id").text());
						deptPositionName = $.trim($deptPosition.find("name").eq(0).text());
					}
			    	user.variable = {			    			
			    			variableName : varId,
			    			variableAlias: variableName,
							dataType:dataType,
							dataTypeName:dataTypeName,
						    deptPositionId:deptPositionId,
						    deptPositionName:deptPositionName
			    	};
			    }
			    
			    var $intersection = $(this).children("intersection");
			    if($intersection.get(0)){
			    	var intersectionValue = $.trim($intersection.find("id").eq(0).text());;
                    var intersectionAlias = $.trim($intersection.find("name").eq(0).text());
			    	user.intersection = {			    			
			    			intersectionValue : intersectionValue,
			    			intersectionAlias: intersectionAlias
			    	};
			    }
			        
			    user.typeName = "关系";
			    user.primaryId =  user.treeId+"_"+type+"_"+id+
			    					(user.deptlevel?"_"+user.deptlevel.deptlevelId:"") +
			    					(user.position?"_"+user.position.positionId:"") +
			    					(user.step?"_"+user.step.stepId:"") +
			    					(user.customfunction?"_"+user.customfunction.customfunctionId:"") +
			    					(user.variable?"_"+user.variable.variableName:"")+
			    					(user.intersection?"_"+user.intersection.intersectionValue:"");
			}
			usersObj.push(user);
		});
	});
	return usersObj;
}

MyBase.prototype.refreshUploader = function() {
	if (this.bpmDocUploader.uploader) this.bpmDocUploader.uploader.refresh;
}

function addProcessAuth (id, className, showField, showname) {
	 $("#"+id).find("div[class='"+className+"'] input[name='"+showField+"']").val(showname);
}
function getProcessAuth (id, className, showField) {
    return $("#"+id).find("div[class='"+className+"'] input[name='"+showField+"']").val();
}
MyBase.prototype.addXmlElement = function(metaName, metaValue, tagNodeXml) {
	if(flowUtils.notNull(metaValue)){
		var meta = flowUtils.createElement(metaName);
		meta.appendChild(flowUtils.createTextNode(metaValue));
		tagNodeXml.appendChild(meta);
	}
};
/**
 * 解析得到制定meta的值
 * @param tagNodeXml
 * @param metaName
 */
MyBase.prototype.getXmlElement = function(tagNodeXml, metaName) {
	return $.trim($(tagNodeXml).children(metaName).text());
};

/**
 * 重新加载注册列表
 * @param domName   注册列表的选择框dom名称
 * @param option	获取到注册列表信息
 * @param type	扩展字段
 */
MyBase.prototype.reloadOptions = function(domName, option, type) {
	 var _self = this;
	 var $Select = $("#"+this.id + " select[name='"+domName+"']");
	 $Select.empty();
	 	for (var i = 0; i< option.length; i++) {
	 		var d = option[i];
	 		  var val = d.value;
			  var text = d.text;
			  $Select.append("<option  value='"+val+"'>"+text+"</option>");
	 	}
		$Select.off("change").on('change', function() {
		 		if (this.value != "") {
					$.ajax({
						type : "POST",
						url : "platform/bpm/bpmconsole/eventManageAction/getEventInfoForDesigner",
						data : {
							id : this.value
						},
						dataType : "json",
						success : function(result) {
							 if(!type || type == "流程启动条件") {
								 var bpmClass = result.bpmClass;
									var properties = result.properties;
						            var input = $Select.parent().parent().parent().find("input");
						            input.val(bpmClass.path);
							 } else if (type == "流程事件监听") {
								 var bpmClass = result.bpmClass;
								 var properties = result.properties;
								 $("#"+_self.id + " input[name='input-event-name']").val(bpmClass.name);
								 $("#"+_self.id + " input[name='input-event']").val(bpmClass.path);
								 var $table = 	$("#"+_self.id + " table[name='constants']");
								 for (var i=0 ; i < properties.length; i++) {
									 var property = properties[i];
									 var tr = $table.find(">tbody>tr").eq(i);
									 if(tr.get(0)) {
										 tr.children("td").eq(0).text(property.name);
										 tr.children("td").eq(1).text(property.initExpr||"");
									 } else {
										 $table.find(">tbody").append("<tr><td>"+property.name+"</td><td>"+(property.initExpr||"")+"</td><tr>");
									 }
								 }
							 }
							
						}
					});
				} else {
					_self.nodeEvent.empty();
				}

	        });
	 	
 }

/**
 * 获取全局节点实例
 */
MyBase.prototype.processInstance = function() {
	var process = null;
	var values = this.designerEditor.myCellMap.values();
	$.each(values, function(i, n){
		if(n.tagName == "process"){
			process = n;
			return false;
		} 
	});
	return process;
}
