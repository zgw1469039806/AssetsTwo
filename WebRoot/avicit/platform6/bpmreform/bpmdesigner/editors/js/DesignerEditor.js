///<jscompress sourcefile="MyBase.js" />
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
;
///<jscompress sourcefile="MyCustom.js" />
/**
 * custom extends MyBase
 */
function MyCustom(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "custom");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_custom.png;";
};
MyCustom.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyCustom.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getCustom();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-custom-node");
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyCustom.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setCustom(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
		// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-custom-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);

	var custom_class = this.getAttr(xmlValue,"class");
    $("#"+this.id+" #node_class").val(custom_class);
	$("#"+this.id+" input[name='custom_class_check']").each(function (i, n) {
		if($(n).val() == custom_class){
			$(n).click();
		}
	});
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MyCustom.prototype.getOtherAttr = function(node) {
// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
	this.putAttr("class",$("#"+this.id+" #node_class").val(),node);
};;
///<jscompress sourcefile="MyEnd.js" />
/**
 * end extends MyBase
 */
function MyEnd(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "end");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/end_event_terminate.png;";
};
MyEnd.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyEnd.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getEnd();
	this.labelChanged("结束");
	this.initJBXX();// 初始化基本信息
	// 节点事件
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-end-node");
	// 初始化各种事件
	this.initEvent();
};
/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyEnd.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-end-node");
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setEnd(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	// 初始化各种事件
	this.initEvent();
		// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
	// 回写权限
	var _self = this;
	$(xmlValue).children("docRights").children("docRight").each(function(){
			var docThis = this;
			var domId = $(docThis).attr("type");
			$("#" + _self.id).find("input[name='" + domId+"']").trigger("click");
			$(docThis).children("subDocRight").each(function(){
			var subDomId = $(this).attr("type");
			var subValue = $(this).attr("value");
				if(domId == "wordRead" || domId == "wordEdit") {
					// 如果子节点是checkbox,则根据值勾选相应的内容
					$("#" + _self.id).find("input[type='checkbox'][name='"+subDomId+"']").prop("checked", true);
				} else if (domId == "wordRedTemplet" || domId ==  "wordCreate") {
						// 正文模板、套红模板回写
					var show = $(this).attr("name");
					var data = $(this).attr("value");
					var dataInput = $("#" + _self.id).find("input[name='"+(domId ==  "wordCreate"?"taskFormValueWordCreate":"taskFormValueWordRedTemplet")+"']");
					var textInput = $("#" + _self.id).find("input[name='"+(domId ==  "wordCreate"?"taskFormTextWordCreate":"taskFormTextWordRedTemplet")+"']");
					dataInput.val(data);
					textInput.val(show);
					textInput.attr("title",show);
				} else if(domId == "wordPrint"){
					var ownerId = subValue;
					if(flowUtils.notNull(ownerId)){
						var dataArea = $("#" + _self.id).find("input[name='taskFormValue"+subDomId+"']");
						var textArea = $("#" + _self.id).find("input[name='taskFormText"+subDomId+"']");
						dataArea.attr("actorsId", ownerId);
						var actors = _self.getUserSelectObjFromXml(ownerId, xmlValue);
						dataArea.val(JSON.stringify(actors));
						var actorsText = _self.getUserSelectTextFieldValue(actors);
						textArea.val(actorsText);
						textArea.attr("title", actorsText);
					}
				} else if(domId == "wordValue"){
						// 域值同步回写
						var show = $(this).attr("name");
						var data = $(this).attr("value");
						if(data) {
							var dataInput = $("#" + _self.id).find("input[name='taskFormValueWordValue']");
							var textInput = $("#" + _self.id).find("input[name='taskFormTextWordValue']");
							dataInput.val(data);
							textInput.val(show);
							textInput.attr("title",show);
						}
				} else {
						flowUtils.error("你碰到了一个错误");
				}
				});
		});
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MyEnd.prototype.getOtherAttr = function(node) {
	
	//文档权限
	var docRights = flowUtils.createElement("docRights");
	this.createFormSaveXml("wordRead","查看正文", docRights);
	this.createFormSaveXml("wordPrint","打印正文", docRights,node);
	if(docRights.childNodes.length > 0){
		node.appendChild(docRights);
	}

	// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
	
};

MyEnd.prototype.createFormSaveXml = function (type, name, docRights, rootNode) {
	var _self = this;
	if($("#" + _self.id).find("input[name='"+type+"']").prop('checked')) {
		var docRight = flowUtils.createElement("docRight");
		docRight.setAttribute("type", type);
		docRight.setAttribute("name", name);
		// 子节点
		if(type == "wordEdit") {
			var wordRevisions = $("#" + _self.id).find("input[type='checkbox'][name='wordRevisions']");
			if(wordRevisions.prop('checked')) {
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", "wordRevisions");
				subDocRight.setAttribute("name", "编辑时留痕");
				subDocRight.setAttribute("value", "wordRevisions");
				docRight.appendChild(subDocRight);
			}
			var wordShowRevisions = $("#" + _self.id).find("input[type='checkbox'][name='wordShowRevisions']");
			if(wordShowRevisions.prop('checked')) {
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", "wordShowRevisions");
				subDocRight.setAttribute("name", "显示留痕");
				subDocRight.setAttribute("value", "wordShowRevisions");
				docRight.appendChild(subDocRight);
			}
		}
		if(type == "wordRead") {
			var read1 = $("#" + _self.id).find("input[type='checkbox'][name='read1']");
			if(read1.prop('checked')) {
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", "read1");
				subDocRight.setAttribute("name", "显示清稿");
				subDocRight.setAttribute("value", "read1");
				docRight.appendChild(subDocRight);
			}
			var read2 = $("#" + _self.id).find("input[type='checkbox'][name='read2']");
			if(read2.prop('checked')) {
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", "read2");
				subDocRight.setAttribute("name", "显示清稿");
				subDocRight.setAttribute("value", "read2");
				docRight.appendChild(subDocRight);
			}
		}
		
		if(type == "wordCreate" || type == "wordRedTemplet") {
			var data = $("#" + _self.id).find("input[name='taskFormValue"+(type.toString()[0].toUpperCase() + type.toString().slice(1))+"']");
			var show = $("#" + _self.id).find("input[name='taskFormText"+(type.toString()[0].toUpperCase() + type.toString().slice(1))+"']");
			var subDocRight = flowUtils.createElement("subDocRight");
			subDocRight.setAttribute("type", type == "wordCreate" ? "wordTemplates":"wordRedTemplates");
			subDocRight.setAttribute("name", show.val());
			subDocRight.setAttribute("value", data.val());
			docRight.appendChild(subDocRight);
		}
		
		// 勾选了打印正文
		if(type == "wordPrint") {
			// 找到所有人员信息
			$("#" + _self.id).find("input[name^='taskFormValuewordSecret']").each(function(){
				var id = $(this).attr("id");
				var ownerId = $(this).attr("actorsid");
				var value = $(this).val();
				if(value) {
					_self.createUserSelectXml(ownerId, value, rootNode);
					var subDocRight = flowUtils.createElement("subDocRight");
					subDocRight.setAttribute("type", id.slice("taskFormValue".length));
					subDocRight.setAttribute("name", $(this).parent().parent().parent().find("label").text());
					subDocRight.setAttribute("value", ownerId);
					docRight.appendChild(subDocRight);
				}
			});
		}
		if(type == "wordValue") {
			//  阈值同步
			var data = $("#" + _self.id).find("input[name='taskFormValueWordValue']");
			var show = $("#" + _self.id).find("input[name='taskFormTextWordValue']");
			var subDocRight = flowUtils.createElement("subDocRight");
			subDocRight.setAttribute("type", "wordFieldName");
			subDocRight.setAttribute("name", show.val());
			subDocRight.setAttribute("value", data.val());
			docRight.appendChild(subDocRight);
		}
		docRights.appendChild(docRight);
	}
}

MyEnd.prototype.initEvent = function() {
	var _self =  this;
//	 正文相关权限
	 $("#"+_self.id+" div[name^='div-word']").find("input[type='checkbox']").on("click", function(){
		var checkbox = this;
		var checkboxName = $(checkbox).attr("name");
		var container = $("#"+_self.id+" div[name='container-"+checkboxName+"']");
		if(checkbox.checked) {
			if(container.hasClass("hidden")) {
				container.removeClass("hidden");
			}
		} else {
			container.addClass("hidden");
			// 清空选择表单
			container.find("input").val("");
			container.find("input[type='checkbox']").prop("checked",false);
		}
	});
	 
	// 各种打印级别选人
	 $("#"+_self.id).find("button[name^='btnTaskFormwordSecret']").off("click").on("click",function() {
		 var containerDiv = "";
         var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
		 var dataField = $(this).parent().siblings("div").find("input[name^='taskFormValuewordSecret']").attr("name");
		 var textField = $(this).parent().siblings("div").find("input[name^='taskFormTextwordSecret']").attr("name");
		 var option = {processId:process.id,type:'userSelect', userSelectContainer :containerDiv ,dataField:dataField,textField:textField,topId:_self.id};
		 new UserSelect(option);
	 });
};
///<jscompress sourcefile="MyExclusive.js" />
/**
 * exclusive extends MyBase
 */
function MyExclusive(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "decision");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/gateway_exclusive.png;";
};
MyExclusive.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyExclusive.prototype.init = function() {
	this.initBase();
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-exclusive-node");
	this.name = "exclusive" + this.designerEditor.countUtils.getExclusive();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyExclusive.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setExclusive(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-exclusive-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyExclusive.prototype.getOtherAttr = function(node) {
// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
};
/**
 * 通过name解析数字，例如end1解析出数字:1
 */
MyExclusive.prototype.resolve = function() {
	return Number(this.name.replace("exclusive", ""));
};;
///<jscompress sourcefile="MyForeach.js" />
/**
 * foreach extends MyBase
 */
function MyForeach(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "foreach");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/gateway_foreach.png;";
};
MyForeach.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyForeach.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getForeach();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	this.initEvent();//初始化事件
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-foreach-node");
	
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyForeach.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setForeach(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	var isMustUser = $.trim($(xmlValue).children("meta[name='isMustUser']").text());
    if(isMustUser=='yes'){
    	$("#"+this.id+" #bixuxuanren").prop("checked",true);
    	if($("#"+this.id+ " div[name='zidongxuanren-area']").hasClass("hidden")) {
    		$("#"+this.id+ " div[name='zidongxuanren-area']").removeClass("hidden");
        }
        if(!$("#"+this.id+ " div[name='zidongxuanren-collection']").hasClass("hidden")) {
        	$("#"+this.id+ " div[name='zidongxuanren-collection']").addClass("hidden");
        }
        var userSelectType = $.trim($(xmlValue).children("meta[name='userSelectType']").text());
    	if(userSelectType == "auto"){
            $("#"+this.id+" #zidongxuanren").prop("checked",true);
        }
    }else{
    	$("#"+this.id+" #bixuxuanren").prop("checked",false);
    	if(!$("#"+this.id+ " div[name='zidongxuanren-area']").hasClass("hidden")) {
    		$("#"+this.id+ " div[name='zidongxuanren-area']").addClass("hidden");
        }
        if($("#"+this.id+ " div[name='zidongxuanren-collection']").hasClass("hidden")) {
        	$("#"+this.id+ " div[name='zidongxuanren-collection']").removeClass("hidden");
        }
    }
	this.initEvent();
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-foreach-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
    $("#"+this.id+" #inputValueBackVar").val(this.getAttr(xmlValue,"var"));
    $("#"+this.id+" #inputTextBackVar").val(this.getAttr(xmlValue,"var"));
    $("#"+this.id+" #inputValueCollection").val(this.getAttr(xmlValue,"in"));
    $("#"+this.id+" #inputTextCollection").val(this.getAttr(xmlValue,"in"));
    
    //候选人
 	this.setUserSelectDom({userSelectContainer :'candidate-container' ,dataField:'candidate-data-field',textField:'candidate-text-field'}, xmlValue);
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MyForeach.prototype.getOtherAttr = function(node) {
    //this.initEvent();

	// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
    this.putAttr("var",$("#"+this.id+" #inputValueBackVar").val(), node);
    var inputValueCollection =  $("#"+this.id+" #inputValueCollection").val();
    if(flowUtils.notNull(inputValueCollection)){
    	this.putAttr("in",inputValueCollection, node);
    }
    
    var isMustUser = $("#"+this.id+" #inputValueBackVar");
    var isBxxr = $("#"+this.id+" #bixuxuanren").is(":checked");
    if(isBxxr){
    	this.addMeta("isMustUser","yes",node);
        var zidongxuanren = $("#"+this.id+" #zidongxuanren").is(":checked");
        if(zidongxuanren){
            this.addMeta("userSelectType","auto",node);
        }
    }else{
    	this.addMeta("isMustUser","no",node);
    }
	
	// 选人
	this.setUserSelectXml({userSelectContainer :'candidate-container' ,dataField:'candidate-data-field',textField:'candidate-text-field'}, node);

};

MyForeach.prototype.initEvent = function() {
    var _self  = this;
    $("#"+_self.id+" button[name='button-BackVar']").off("click").on("click", function(){
        var process = null;
        var values = _self.designerEditor.myCellMap.values();
        $.each(values, function(i, n){
            if(n.tagName == "process"){
                process = n;
            }
        });
        new ProcessVariable({dataDomId:_self.id+" #inputValueBackVar",showDomId:_self.id+" #inputTextBackVar", callback:function(data){
            var d = data[0];
            $("#"+_self.id+" #inputValueBackVar").val(d.name);
            $("#"+_self.id+" #inputTextBackVar").val(d.name);
        },process:process,
            multiple:false});
    });

    $("#"+_self.id+" button[name='button-Collection']").off("click").on("click", function(){
        var process = null;
        var values = _self.designerEditor.myCellMap.values();
        $.each(values, function(i, n){
            if(n.tagName == "process"){
                process = n;
            }
        });
        new ProcessVariable({dataDomId:_self.id+" #inputValueCollection",showDomId:_self.id+" #inputTextCollection", callback:function(data){
            var d = data[0];
            $("#"+_self.id+" #inputValueCollection").val('#{' + d.name + '}');
            $("#"+_self.id+" #inputTextCollection").val('#{' + d.name + '}');
        },process:process,
            multiple:false});
    });

    $("#"+_self.id+" #bixuxuanren").off("click").on("click", function(){
        if(this.checked) {
            if($("#"+_self.id+ " div[name='zidongxuanren-area']").hasClass("hidden")) {
            	$("#"+_self.id+ " div[name='zidongxuanren-area']").removeClass("hidden");
            }
            if(!$("#"+_self.id+ " div[name='zidongxuanren-collection']").hasClass("hidden")) {
            	$("#"+_self.id+ " div[name='zidongxuanren-collection']").addClass("hidden");
            }
        } else {
            if(!$("#"+_self.id+ " div[name='zidongxuanren-area']").hasClass("hidden")) {
            	$("#"+_self.id+ " div[name='zidongxuanren-area']").addClass("hidden");
            }
            if($("#"+_self.id+ " div[name='zidongxuanren-collection']").hasClass("hidden")) {
            	$("#"+_self.id+ " div[name='zidongxuanren-collection']").removeClass("hidden");
            }
        }
    });
    
     //候选人事件
 	 $("#"+this.id+" button[name=button-auth-candidate]").off("click").on("click",function(){
         var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
 	     var option = {type:'userSelect',
 			 userSelectContainer :'candidate-container' ,
 			 dataField:'candidate-data-field',
 			 textField:'candidate-text-field',
 			 topId:_self.id,
             processId:process.id,
 		 	callback:function(data){
			//          	console.log("-----------");
			//          	console.log(data);
			//          	console.log("=============");
 		 }};
          _self.candidateSelect = new UserSelect(option);
      });
};
///<jscompress sourcefile="MyFork.js" />
/**
 * fork extends MyBase
 */
function MyFork(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "fork");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/gateway_fork.png;";
};
MyFork.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyFork.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getFork();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-fork-node");
	
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyFork.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setFork(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-fork-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyFork.prototype.getOtherAttr = function(node) {
// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
};;
///<jscompress sourcefile="MyJava.js" />
/**
 * java extends MyBase
 */
function MyJava(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "java");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_java.png;";
};
MyJava.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyJava.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getJava();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	this.initEvent();
	/**
	 * 处理ie9及以下浏览器 不支持placeholder的问题
	 */
	var flowComponent = $("#"+this.id).find("#flow-component");
	this.fixPlaceHold(flowComponent);
	var flowMethod = $("#"+this.id).find("#flow-method");
	this.fixPlaceHold(flowMethod);	
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-java-node");
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyJava.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setJava(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是节点私有的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	this.initEvent();
	$("#"+this.id).find("#flow-component").val(this.getAttr(xmlValue, "class"));
	$("#"+this.id).find("#flow-method").val(this.getAttr(xmlValue, "method"));
	
	// 流程变量回写
	$("#"+this.id+" #inputValueFlowVariable").val(this.getAttr(xmlValue, "var"));
	$("#"+this.id+" #inputTextFlowVariable").val(this.getAttr(xmlValue, "var"));

	this.methodClass.getDom(xmlValue);
	this.fieldClass.getDom(xmlValue);
	
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-java-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyJava.prototype.getOtherAttr = function(node) {
	// 基本信息
	var flowComponent = $("#"+this.id).find("#flow-component").val();
	this.putAttr("class", flowComponent, node);
	var flowMethod = $("#"+this.id).find("#flow-method").val();
	this.putAttr("method", flowMethod, node);
	
	// 获取流程变量
	var d = $("#"+this.id+" #inputValueFlowVariable").val();
	this.putAttr("var", d, node);
	
	// 取得参数变量
/*	<arg name="111">
    <string value="1111"/>
  </arg>
  <arg name="222">
    <string value="2222"/>
  </arg>*/
//	{"varName":"qweewqwe","varType":"long","varInit":"qwe324qeqw"}
	var _self = this;
	_self.methodClass.getXml(node);
	_self.fieldClass.getXml(node);

	/*$("#"+_self.id+" #table-flow-add-field input").each(function(){
		var data = JSON.parse($(this).val());
		var arg = flowUtils.createElement("field");
		_self.putAttr("name", data.varName, arg);
		var type = flowUtils.createElement(data.varType);
		_self.putAttr("value", data.varInit, type);
		arg.appendChild(type);
		node.appendChild(arg);
	});*/
	
	// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
};

MyJava.prototype.initEvent = function() {
	var _self  = this;
	 $("#"+_self.id+" button[name='button-flow-variable']").on("click", function(){
		 var process = null;
		 var values = _self.designerEditor.myCellMap.values();
			$.each(values, function(i, n){
				if(n.tagName == "process"){
					process = n;
				}
		 });
		 new ProcessVariable({dataDomId:_self.id+" #inputValueFlowVariable",showDomId:_self.id+" #inputTextFlowVariable", callback:function(data){
			var d = data[0];
			$("#"+_self.id+" #inputValueFlowVariable").val(d.name);
			$("#"+_self.id+" #inputTextFlowVariable").val(d.name);
		 },process:process,
		 multiple:false});
	 });
	 
	 _self.methodClass = new MethodAndClass({id:_self.id, buttonId:"buttonAddMethodClass", tableId:_self.id+" #table-flow-add-methodClass",type:"arg", callback:function(data){
		 var d = data[0];
	 }});
	 _self.fieldClass = new MethodAndClass({id:_self.id, buttonId:"buttonAddFieldClass", tableId:_self.id+" #table-flow-add-fieldClass",type:"field", callback:function(data){
		 var d = data[0];
	 }});
};

MyJava.prototype.fixPlaceHold = function(dom){
    if(navigator.appName == "Microsoft Internet Explorer"&&parseInt(navigator.appVersion.split(";")[1].replace(/[ ]/g, "").replace("MSIE",""))<=9){
        var targets = dom?dom:$('input[placeholder]');
        targets.each(function(){
            var $this = $(this);
            $this.val($this.attr('placeholder'));
            $this.on('focus.placeholder',function(){
                if($this.val() == $this.attr('placeholder')){
                    $this.val('');
                }
            }).on('blur.placeholder',function(){
                if(!$this.val()){
                    $this.val($this.attr('placeholder'));
                }
            });
        });
    }
}

;
///<jscompress sourcefile="MyJms.js" />
/**
 * jms extends MyBase
 */
function MyJms(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "jms");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_jms.png;";
};
MyJms.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyJms.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getJms();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-jms-node");
    this.initEvent();
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyJms.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setJms(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
    this.initEvent();
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-jms-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
	this.setDomValByAttr("initial-context-factory",xmlValue,"initial-context-factory");
	this.setDomValByAttr("provider-url",xmlValue,"provider-url");
	this.setDomValByAttr("connection-factory",xmlValue,"connection-factory");
	this.setDomValByAttr("destination",xmlValue,"destination");

    var transacted = this.getAttr(xmlValue, "transacted");
    if(transacted == "true") {
        $("#" + this.id).find("#transacted").trigger("click");
	}
    var acknowledge = this.getAttr(xmlValue, "acknowledge");
    $("#" + this.id).find("input[name='acknowledge'][value='"+acknowledge+"']").prop("checked","checked");
    var message = this.getAttr(xmlValue, "message");
    $("#" + this.id).find("input[name='message'][value='"+message+"']").trigger('click');
    if(message == "text" || message == "object") {
    	var messageValue = "";
			if(message == "text") {
                messageValue = $.trim($(xmlValue).children("text").text());
			} else {
                messageValue = $.trim($(xmlValue).children("object").attr("expr"));
			}
		    $("#" + this.id).find("input[name='returnValue_"+message+"']").val(messageValue);
    } else {
		this.jmsCollection.getDom(xmlValue);
	}

};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MyJms.prototype.getOtherAttr = function(node) {
// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
	this.setXmlAttrByVal("initial-context-factory",node,"initial-context-factory");
	this.setXmlAttrByVal("provider-url",node,"provider-url");
	this.setXmlAttrByVal("connection-factory",node,"connection-factory");
	this.setXmlAttrByVal("destination",node,"destination");
	// this.setXmlAttrByCheck("transacted", node,"transacted");
    this.putAttr("transacted", $("#" + this.id).find("input[name='transacted']").is(":checked"),node);
    this.putAttr("acknowledge", $("#" + this.id).find("input[type='radio'][name='acknowledge']:checked").val(), node)
	var message = $("#" + this.id).find("input[type='radio'][name='message']:checked").val();
    this.putAttr("message", message, node);
	if(message == "text" || message == "object") {
        var messageValue = $("#" + this.id).find("input[name='returnValue_"+message+"']").val();
		var messageNode = flowUtils.createElement(message);
		node.appendChild(messageNode);
		if(message == "text") {
            messageNode.appendChild(flowUtils.createTextNode(messageValue));
		} else {
            messageNode.setAttribute("expr", messageValue);
		}
	} else {
		this.jmsCollection.getXml(node);
	}
};

MyJms.prototype.initEvent = function() {
	var that = this;
    $("#"+that.id+" input[type='radio'][name='message']").on("click", function() {
    	var inputValue =$(this).val();
		$("#"+that.id).find("div[class^='area-input']").each(function(){
			if(!$(this).hasClass("hidden")) {
                $(this).addClass("hidden");
			}
		});
		$("#"+that.id).find("div[class^='area-input-"+inputValue+"']").removeClass("hidden");
    });

    that.jmsCollection = new JMSCollection({id:that.id, buttonId:"buttonAddMethodClass", tableId:that.id+" #table-flow-add-methodClass",type:"entry", callback:function(data){
        var d = data[0];
    }});
};
///<jscompress sourcefile="MyJoin.js" />
/**
 * join extends MyBase
 */
function MyJoin(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "join");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/gateway_join.png;";
};
MyJoin.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyJoin.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getJoin();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	
	// 观察全局变量变化
	this.observeGlobalVariable();
	// 初始化一次流程变量
    this.processInstance().notify();
	
	this.initEvent();
	
	
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-join-node");
	
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyJoin.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setJoin(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	
	// 观察全局变量变化
	this.observeGlobalVariable();
	// 路由条件
	this.initEvent();
	// 回写路由条件
	var joinType = this.getMeta(xmlValue, "joinType");
	if (joinType == "condition") {
		this.createConditionDom("zhi_xing_fang_shi", "table-executor", xmlValue);
	} else if(joinType == "arbitrary"){
		var multiplicity = this.getAttr(xmlValue,"multiplicity");
		$("#"+this.id).find("input[name='input-num']").val(multiplicity);
	}
	$("#"+this.id).find("input[name='input-radio-merge-condition'][value='"+joinType+"']").trigger("click");
	
	
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-join-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyJoin.prototype.getOtherAttr = function(node) {
	var _self = this;
	
	var joinType = $("#"+this.id).find("input[name='input-radio-merge-condition']:checked").val();
	_self.addMeta("joinType", joinType, node);
	if(joinType == "condition") {
		// 获取合并条件xml
		this.setConditionXml("zhi_xing_fang_shi", "table-executor",  node); 
	} else if (joinType == "arbitrary") {
		_self.putAttr("multiplicity", $("#"+_self.id).find("input[name='input-num']").val(), node)
	} 
	
	
	// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
};


/**
 * 订阅了全局节点中变量的变化
 * @param data   json数据
 * @param context	MyProcess 上下文实例
 */
MyJoin.prototype.updateGlobalVariable = function(data, context) {
	var _self = this;
	var $yinru = $("#"+_self.id+" select[name='yin_ru_bian_liang']");
	$yinru.empty();
	$yinru.append("<option selected value='0'>引入变量</option>");
	 var varContent = data;
	 if(varContent.length > 0) {
		 // 添加下拉框
		for(var i = 0; i < varContent.length ; i++) {
			// var option = "<option>"+varContent[i].name+"("+varContent[i].type+" "+varContent[i].initExpr+")"+"</option>"
            var option = "<option>#{"+varContent[i].name+"}"+"</option>";
			$yinru.append(option);
		}
	 }
}

MyJoin.prototype.observeGlobalVariable = function(){
	var _self = this;
	_self.processInstance().observers.add(_self);
};

MyJoin.prototype.initEvent = function ( ) {
	var _self = this;
	 $("#"+_self.id+" select[name='yin_ru_bian_liang']").on('change', function() {
		 	if(this.value == 0) {
		 		return;
		 	}
         var that = $(this);
         var target = that.parent().parent().siblings("div").find("textarea")
         var c = target.val().length == 0 ? that.val() : target.val() + "," + that.val();
         target.val(c);
    });
}


/**** 	条件各种事件开始	 ****/

/**
 * 初始化：条件
 * @param executorDomId  执行方式domId
 * @param tableExecutorDomId	数据table domId
 * @param tagNodeXml	
 */
MyJoin.prototype.createConditionDom = function(executorDomId, tableExecutorDomId, tagNodeXml) {
	var self = this;
	$(tagNodeXml).children("conditions").each(function(){
		var type = $(this).attr("type");
		$('#' + self.id).find('#' + executorDomId).val(type);
		var $tbody = $("#" + self.id).find("#" +  tableExecutorDomId).find("tbody");
		$(this).children("condition").each(function(i){
			var idx = i;
			var c_type = $(this).attr("type");
			var value = $(this).text();
			// 该方法中的参数是jquery参数
			EventThatInsertStartConditionContentIntoTableWhenInit($tbody, c_type, $("<input value='"+value+"'/>"));
		});
	});
};

MyJoin.prototype.modifyStartCondition = function (obj) {
		var $modifyBtn = $(obj);
		var $targetTr = $modifyBtn.parent().parent();
		var $tabName = $targetTr.find("td:eq(1)");
		var tabIndex =  $tabName.text().toLowerCase()== "expr" ? 0 : 1;
		var $val =  $targetTr.find("td:eq(2)");
		// 切换tab
		$modifyBtn.find("div[name='demoCont'] ul").find("li:eq("+tabIndex+")").click();
		// 先找到顶层的div 
		var $top = $modifyBtn.parents("table[name=table-executor]").parent().parent();
		// 进行tab切换
		this.changeStartConditionTab($top.find("ul:eq(0)").find("li").eq(tabIndex));
		// 赋值
		$top.find("ul:eq(1)")
				.find("li")
				.eq(tabIndex)
				.find(tabIndex == 0? "textarea" : "input")
				.val($val.text().trim());

		// 查找添加buttion
		var $oldAddButton = $top.find("ul:eq(1)")
				.find("li")
				.eq(tabIndex).find("button[name='btn-add-start-condition']");
		// 更改为 保存添加按钮
		var $oldBtn = $oldAddButton.clone(true);
		$oldAddButton.off("click").text("保存").on("click", function() {
            var $content = tabIndex == 0 ?  $(this).parent().parent().parent().find("textarea") :
           	 $(this).parent().parent().parent().find("input");
            if ($content && $content.val().length != 0) {
            	$val.text($content.val());
            	$content.val("");
				// 恢复原来的添加按钮
				$(this).replaceWith($oldBtn);           	
            } else {
                alert("您还没输入内容");
            }
            return false;
		});
 }
MyJoin.prototype.changeStartConditionTab = function (obj) {
		var that = $(obj);
    //切换标签
    that.addClass('active')
        .siblings('li')
        .removeClass('active')
        .parent('.global-attrs-tab')
        .siblings('.tab-cont')
        .find('>li:eq(' + that.index() + ')')
        .addClass('active')
        .siblings('li')
        .removeClass('active');
      // 选中input
     that.find("input").prop("checked",true);
}
/**** 	条件各种事件结束	 ****/;
///<jscompress sourcefile="MyProcess.js" />
/**
 * process extends MyBase
 */
function MyProcess(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "process");
	// 修改锁
	this.lock =  {
			varModifyLock : false
	};

	// 观察者模式
	// 主要观察全局变量的变化
	this.observers =  new ObserverList();
}

MyProcess.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyProcess.prototype.init = function() {
	this.initBase();
	// 配置各种监听事件
	this.initEvent();
	// 初始化文档上传对象
	this.bpmDocUploader = new BpmDocUploader({id:this.id,defineId:this.defineId,activityName:"global",uploaderId:"bpm-designer-upload"});
	//配置流程待办标题
	$("#formName_biaoTi").click(function(){
		_self.configProcessTaskTitle();
	});
	//配置实例标题
	$("#shi_li_biao_ti").click(function(){
		_self.configProcessInstanceTitle();
	});
	// 初始化节点事件
	 this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-flow-event");
	var _self = this;
	this.selectPublishBpmEform1 = new SelectPublishEform("guan_lian_biao_dan", "formName", this.id, "Y", "");
	this.selectPublishBpmEform1.init( function(data) {
		var values = _self.designerEditor.myCellMap.values();
 		$.each(values, function(i, n){
 			if(n.tagName == "task"){
 				this.syncTaskForm(data.id, data.name);
 			}
 		});
 	});
	//配置流程待办标题

	this.name = this.designerEditor.processKey;
	this.alias = _bmpsName;
	$("#" + this.id).find("#liu_cheng_ming_cheng").val(this.alias);
	$("#" + this.id).find("#liu_cheng_biao_shi").val(this.name);

	this.observers.add(this);
};

/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyProcess.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	// 配置各种监听事件
	this.initEvent();
	this.name = this.designerEditor.processKey;
	// 初始化文档上传对象
	this.bpmDocUploader = new BpmDocUploader({id:this.id,defineId:this.defineId,activityName:"global",uploaderId:"bpm-designer-upload"});
	// 流程关联表单
	var _self = this;
	this.selectPublishBpmEform1 = new SelectPublishEform("guan_lian_biao_dan", "formName", this.id, "Y", "");
	this.selectPublishBpmEform1.init( function(data) {
		var values = _self.designerEditor.myCellMap.values();
 		$.each(values, function(i, n){
 			if(n.tagName == "task"){
 				this.syncTaskForm(data.id, data.name);
 			}
 		});
 	});

	//配置流程待办标题
	$("#formName_biaoTi").click(function(){
		_self.configProcessTaskTitle();
	});
	//配置实例标题
	$("#shi_li_biao_ti").click(function(){
		_self.configProcessInstanceTitle();
	});
	// 全局属性：
	// 启动权限
	this.initStartAuthTableDom(xmlValue,"table-auth-user","users");
	this.initStartAuthTableDom(xmlValue,"table-auth-dept","depts");
	this.initStartAuthTableDom(xmlValue,"table-auth-role","roles");
	this.initStartAuthTableDom(xmlValue,"table-auth-group","groups");
	this.initStartAuthTableDom(xmlValue,"table-auth-position","positions");
   //	按钮权限
	this.createQXDom(xmlValue, "yi_jian_xiu_gai", "globalIdea");
	this.createQXDom(xmlValue, "liu_cheng_tiao_zhuan", "globalJump");
	this.createQXDom(xmlValue, "liu_cheng_zan_ting", "globalSuspend");
	this.createQXDom(xmlValue, "liu_cheng_hui_fu", "globalResume");
	this.createQXDom(xmlValue, "liu_cheng_jie_shu", "globalEnd");
	this.createQXDom(xmlValue, "guan_zhu_gong_zuo", "focus");
	this.createQXDom(xmlValue, "xiang_guan_liu_cheng", "relationprocess");
	this.createQXDom(xmlValue, "guan_lian_fu_liucheng", "relationparentprocess");

	$("#"+_self.id).find("input[_type='bpm_but_attribute']").each(function (i, n) {
		_self.createQXDom(xmlValue, $(n).attr("name"), $(n).attr("name"));
	});

	// 全局属性：事件
	 this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-flow-event");

	this.alias = $.trim(xmlValue.getAttribute("name"));
	$("#" + this.id).find("#liu_cheng_ming_cheng").val($.trim(this.alias));
	$("#" + this.id).find("#liu_cheng_biao_shi").val(this.name);
	/*其他*/
	var descriptionNode = $(xmlValue).children("description");
	if(descriptionNode.length == 0){
		this.setDomValByAttr("liu_cheng_miao_shu", xmlValue, "description");
	}else {
		$("#" + this.id).find("#liu_cheng_miao_shu").val(descriptionNode.text());
	}

	this.setDomValByAttr("shi_li_biao_ti", xmlValue, "title");
	this.setDomCheckByMeta("shi_li_biao_ti_geng_xin", xmlValue, "titleAutoUpdate");
	this.setDomValByMeta("dai_ban_biao_ti", xmlValue, "todo");
	this.setDomValByMeta("formName_biaoTi", xmlValue, "todo");
	this.setDomValByMeta("liu_cheng_shan_chu", xmlValue, "deleteEvent");

	this.setDomCheckByMeta("process_yi_dong_shen_pi", xmlValue, "processMobileApproval", "yes");

	this.setDomCheckByMeta("wen_zi_gen_zong", xmlValue, "showTrackInForm", "yes");

	this.createConditionDom("zhi_xing_fang_shi", "table-executor", xmlValue);//启动条件

	this.createFlowVariableDom("table-flow-variable", xmlValue); // 流程变量回写

	/*tab5 流程事件回写*/
	 this.nodeEvent.setEventDom(xmlValue);

	//全局表单
	var globalformid = $.trim(xmlValue.getAttribute("globalformid"));
	var globalformname = $.trim(xmlValue.getAttribute("globalformname"));
	$('#' + this.id).find('#guan_lian_biao_dan').val(globalformid);
	$('#' + this.id).find('#formName').val(globalformname);

	// 意见配置
	this.setOpinionDOM("table-process-add-opinion", xmlValue);

	/**kpi设置*/
	this.setDomValByMeta("kpi_process_reasonable_day", xmlValue, "kpiProcessReasonableDay");
	this.setDomValByMeta("kpi_process_reasonable_hour", xmlValue, "kpiProcessReasonableHour");
	this.setDomValByMeta("kpi_process_reasonable_minute", xmlValue, "kpiProcessReasonableMinute");
	this.setDomValByMeta("kpi_process_warning_day", xmlValue, "kpiProcessWarningDay");
	this.setDomValByMeta("kpi_process_warning_hour", xmlValue, "kpiProcessWarningHour");
	this.setDomValByMeta("kpi_process_warning_minute", xmlValue, "kpiProcessWarningMinute");
	this.setDomCheckByMeta("is_participate_KPI", xmlValue, "isParticipateKPI");

	this.setDomValByMeta("flow_owner_deptId", xmlValue, "flowOwnerDeptId");
	this.setDomValByMeta("flow_owner_deptName", xmlValue, "flowOwnerDeptName");
	this.setDomValByMeta("flow_owner_userId", xmlValue, "flowOwnerUserId");
	this.setDomValByMeta("flow_owner_userName", xmlValue, "flowOwnerUserName");

	this.setDomCheckByMeta("event_auto_perform", xmlValue, "event_auto_perform");

	this.observers.add(this);

};

//配置流程实例标题
MyProcess.prototype.configProcessInstanceTitle = function(){
	var _self = this;
	var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
	var processId = process.id;
	var value = $("#shi_li_biao_ti").val();
	value = encodeURIComponent(value);
	layer.open({
		type: 2,
		title: '配置【实例标题】',
		skin: 'index-model',
		area: ['400px', '350px'],
		content: 'bpm/business/expr?value=' + value+'&processId='+processId,
		btn: ['确认', '取消'],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;
			var value = iframeWin.getValue();
			$("#shi_li_biao_ti").val(value);
			layer.close(index);
		}
	});
};

//配置流程待办标题
MyProcess.prototype.configProcessTaskTitle = function(){
	var _self = this;
	var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
	var processId = process.id;
	var value = $("#dai_ban_biao_ti").val();
	value = encodeURIComponent(value);
	layer.open({
		type: 2,
        title: '配置【待办标题】',
        skin: 'index-model',
        area: ['400px', '350px'],
        content: 'bpm/business/expr?value=' + value+'&processId='+processId,
        btn: ['确认', '取消'],
        yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;
			var value = iframeWin.getValue();
			$("#formName_biaoTi").val(value);
			$("#dai_ban_biao_ti").val(value);
			layer.close(index);
		}
    });
};
/**
 * 重写了组装processXML的方法，自定义所有信息
 *
 * @returns
 */
MyProcess.prototype.getXmlDoc = function() {
	var node = flowUtils.createElement(this.tagName);
	this.putAttr("name", this.alias, node);
	this.putAttr("key", this.name, node);

//	封装意见设置
	this.setOpinionXml("table-process-add-opinion",node);
	/* tab1 封装基本信息*/
	// 属性
	//this.setXmlAttrByVal("", node, "description"); // 流程描述
	var descriptionValue = $("#" + this.id).find("#liu_cheng_miao_shu").val();
	var descriptionNode = flowUtils.createElement("description");
	descriptionNode.appendChild(flowUtils.createTextNode(descriptionValue));
	node.appendChild(descriptionNode);

	// 实例
	this.setXmlAttrByVal("shi_li_biao_ti", node, "title");
	this.setXmlMetaByCheck("shi_li_biao_ti_geng_xin", node, "titleAutoUpdate");
	this.setXmlMetaByVal("dai_ban_biao_ti", node, "todo");
	this.setXmlMetaByVal("liu_cheng_shan_chu", node, "deleteEvent");
	this.setXmlMetaByCheck("process_yi_dong_shen_pi", node, "processMobileApproval");

	this.setXmlMetaByCheck("wen_zi_gen_zong", node, "showTrackInForm");

	/* tab2 封装启动条件 */
	this.setConditionXml("zhi_xing_fang_shi", "table-executor",  node);

	/*tab3 封装流程变量*/
	this.setFlowVariableXml("table-flow-variable", node);

	/*tab4 封装流程权限*/
	//启动权限
	var processAuth = flowUtils.createElement("processAuth");
	this.getStartAuthTableXml(processAuth, "table-auth-user","user");
	this.getStartAuthTableXml(processAuth, "table-auth-dept", "dept");
	this.getStartAuthTableXml(processAuth, "table-auth-role", "role");
	this.getStartAuthTableXml(processAuth, "table-auth-group", "group");
	this.getStartAuthTableXml(processAuth, "table-auth-position", "position");
	if(processAuth.childNodes.length > 0){
		node.appendChild(processAuth);
	}
	//按钮权限
	var magicsNode = flowUtils.createElement("magics");
	this.createQXXml(magicsNode, "yi_jian_xiu_gai", "globalIdea", "意见修改", node);
	this.createQXXml(magicsNode, "liu_cheng_tiao_zhuan", "globalJump", "流程跳转", node);
	this.createQXXml(magicsNode, "liu_cheng_zan_ting", "globalSuspend", "流程暂停", node);
	this.createQXXml(magicsNode, "liu_cheng_hui_fu", "globalResume", "流程恢复", node);
	this.createQXXml(magicsNode, "liu_cheng_jie_shu", "globalEnd", "流程结束", node);
	this.createQXXml(magicsNode, "guan_zhu_gong_zuo", "focus", "关注工作", node);
	this.createQXXml(magicsNode, "xiang_guan_liu_cheng", "relationprocess", "相关流程", node);
	this.createQXXml(magicsNode, "guan_lian_fu_liucheng", "relationparentprocess", "关联父流程", node);

	var _self = this;
	$("#"+_self.id).find("input[_type='bpm_but_attribute']").each(function (i, n) {
		_self.createQXXml(magicsNode, $(n).attr("name"), $(n).attr("name"),  $(n).attr("_name"), node);
	});

	if(magicsNode.childNodes.length > 0){
		node.appendChild(magicsNode);
	}

	/*tab5 封装流程事件*/
	 this.nodeEvent.setEventXml(node, "start");//event

	//全局表单
	this.putAttr("globalformid", $('#' + this.id).find('#guan_lian_biao_dan').val(), node);
	this.putAttr("globalformname", $('#' + this.id).find('#formName').val(), node);

	/** KPI设置*/
	this.setXmlMetaByVal("kpi_process_reasonable_day", node, "kpiProcessReasonableDay");
	this.setXmlMetaByVal("kpi_process_reasonable_hour", node, "kpiProcessReasonableHour");
	this.setXmlMetaByVal("kpi_process_reasonable_minute", node, "kpiProcessReasonableMinute");
	this.setXmlMetaByVal("kpi_process_warning_day", node, "kpiProcessWarningDay");
	this.setXmlMetaByVal("kpi_process_warning_hour", node, "kpiProcessWarningHour");
	this.setXmlMetaByVal("kpi_process_warning_minute", node, "kpiProcessWarningMinute");
	this.setXmlMetaByCheck("is_participate_KPI", node, "isParticipateKPI");

	this.setXmlMetaByVal("flow_owner_deptId", node, "flowOwnerDeptId");
	this.setXmlMetaByVal("flow_owner_deptName", node, "flowOwnerDeptName");
	this.setXmlMetaByVal("flow_owner_userId", node, "flowOwnerUserId");
	this.setXmlMetaByVal("flow_owner_userName", node, "flowOwnerUserName");

	this.setXmlMetaByCheck("event_auto_perform", node, "event_auto_perform");

	if($("#" + this.id).find("input[name='event_auto_perform']").is(":checked")){
		var eventListener = flowUtils.createElement('event-listener');
		eventListener.setAttribute('name', "结束后自动激活父流程");
		eventListener.setAttribute('class', "avicit.platform6.bpm.bpmreform.event.AutoPerformProcess");
		eventListener.setAttribute('display', "no");
		var endListenerList = $(node).children("on[event='end']");
		if(endListenerList.length == 0){
			var conditionEndNode =   flowUtils.createElement('on');
			conditionEndNode.setAttribute('event', 'end');
			conditionEndNode.appendChild(eventListener)
			node.appendChild(conditionEndNode);
		}else{
			endListenerList.append(eventListener);
		}
	}
	return node;
};
/**
 * 重写了name监听事件，不需要其他处理
 *
 * @param value
 */
MyProcess.prototype.labelChanged = function(value) {
	this.alias = value;
};

/**** 	基本信息各种事件开始	 ****/

/**
 * 创建意见dom
 */
MyProcess.prototype.setOpinionDOM = function (tableTbodydomId, tagNodeXml) {
	var _self = this;
	var table =  $("#"+_self.id+" table[name='"+tableTbodydomId+"'] tbody");
	$(tagNodeXml).children("ideas").children("idea").each(function() {
		var opinionName =  $.trim(_self.getXmlElement(this, "opinionName"));
	    var opinionCode = $.trim(_self.getXmlElement(this, "opinionCode"));
	    var opinionOrder = $.trim(_self.getXmlElement(this, "opinionOrder"));
	    var opinionNode = $.trim(_self.getXmlElement(this, "opinionNode"));
	    var opinionNodeText = $.trim(_self.getXmlElement(this, "opinionNodeText"));
	    var positionId = $.trim(_self.getXmlElement(this, "positionId"));
	    var positionText = $.trim(_self.getXmlElement(this, "positionText"));
	    var showPositionId = $.trim(_self.getXmlElement(this, "showPositionId"));
	    var showPositionText = $.trim(_self.getXmlElement(this, "showPositionText"));
	    var eSign = $.trim(_self.getXmlElement(this, "eSign"));
	    var ideaStyle = $.trim(_self.getXmlElement(this, "ideaStyle"));
	    var opinionType = $.trim(_self.getXmlElement(this, "opinionType"));
	    var subprocessDefId = $.trim(_self.getXmlElement(this, "subprocessDefId"));
	    var subopinionCode = $.trim(_self.getXmlElement(this, "subopinionCode"));
	    var subopinionName = $.trim(_self.getXmlElement(this, "subopinionName"));
	    var showIdeaStyle = $.trim(_self.getXmlElement(this, "showIdeaStyle"));
	    table.append(_self.getOpinionTableTr(_self.id ,opinionName,
	   		 opinionCode,opinionOrder,positionId,positionText ,
	   		 showPositionText,showPositionId,eSign,ideaStyle,showIdeaStyle,opinionNode,opinionNodeText, opinionType, subprocessDefId, subopinionCode, subopinionName));
	});
};

MyProcess.prototype.setOpinionXml = function (domId, tagNodeXml) {
	var _self = this;
	var ideas = flowUtils.createElement("ideas");
	$("#"+_self.id).find("table[name='"+domId+"'] tbody tr").each(function(i){
		var jsonData = JSON.parse($(this).find("input").val());
		var idea = flowUtils.createElement("idea");
		_self.addXmlElement("opinionName", jsonData.opinionName, idea);
		_self.addXmlElement("opinionCode", jsonData.opinionCode, idea);
		_self.addXmlElement("opinionOrder", jsonData.opinionOrder, idea);
		_self.addXmlElement("opinionNode", jsonData.opinionNode, idea);
		_self.addXmlElement("opinionNodeText", jsonData.opinionNodeText, idea);
		_self.addXmlElement("positionId", jsonData.positionId, idea);
		_self.addXmlElement("positionText", jsonData.positionText, idea);
		_self.addXmlElement("showPositionId", jsonData.showPositionId, idea);
		_self.addXmlElement("showPositionText", jsonData.showPositionText, idea);
		_self.addXmlElement("eSign", jsonData.eSign, idea);
		_self.addXmlElement("ideaStyle", jsonData.ideaStyle, idea);
		_self.addXmlElement("opinionType", jsonData.opinionType, idea);
		_self.addXmlElement("subprocessDefId", jsonData.subprocessDefId, idea);
		_self.addXmlElement("subopinionCode", jsonData.subopinionCode, idea);
		_self.addXmlElement("subopinionName", jsonData.subopinionName, idea);
		_self.addXmlElement("showIdeaStyle", jsonData.showIdeaStyle, idea);
		ideas.appendChild(idea);
	});
	tagNodeXml.appendChild(ideas);
}

/**
 * 编辑意见的时候，获取意见信息
 */
MyProcess.prototype.getInitOpinion = function (pid, idx) {
	 var tr =  $("#"+pid+" table[name='table-process-add-opinion'] tbody tr").eq(idx);
	 return JSON.parse(tr.find("input").val());
}
/**
 * 获取所有意见的code
 */
MyProcess.prototype.getInitOpinionCodes = function (pid, idx) {
	var codeArr = [];
    $("#"+pid+" table[name='table-process-add-opinion'] tbody tr").each(function(i, n){
    	if(i == idx){
    		return;
		}
        var data = JSON.parse($(n).find("input").val());
        codeArr.push(data.opinionCode);
	});
    return codeArr;
}
/**
 * 保存意见
 * @param pid
 * @param $form
 */
MyProcess.prototype.addOpinion = function (pid, $form) {
	var table =  $("#"+pid+" table[name='table-process-add-opinion'] tbody")
	var opinionName =  $.trim($form.find("#opinionName").val());
    var opinionCode = $.trim($form.find("#opinionCode").val());
    var opinionOrder = $.trim($form.find("#opinionOrder").val());
    var opinionNode = $.trim($form.find("#opinionNode").val());
    var opinionNodeText = $.trim($form.find("#opinionNodeText").val());
    var positionId = $.trim($form.find("#positionId").val().replaceAll(";",","));
    var positionText = $.trim($form.find("#positionText").val().replaceAll(";",","));
    var showPositionId = $.trim($form.find("#showPositionId").val().replaceAll(";",","));
    var showPositionText = $.trim($form.find("#showPositionText").val().replaceAll(";",","));
    var eSign = $.trim($form.find("#eSign").val());
    var ideaStyle = $.trim($form.find("#ideaStyle").val());
    var opinionType = $.trim($form.find("#opinionType").val());
    var subprocessDefId = $.trim($form.find("#subprocessDefId").val());
    var subopinionCode = $.trim($form.find("#subopinionCode").val());
    var subopinionName = $.trim($form.find("#subopinionName").val());
    var showIdeaStyle = $.trim($form.find("#ideaStyle option[value='"+ideaStyle+"']").text());
    table.append(this.getOpinionTableTr(pid,opinionName,
   		 opinionCode,opinionOrder,positionId,positionText ,
   		 showPositionText,showPositionId,eSign,ideaStyle,showIdeaStyle,opinionNode,opinionNodeText, opinionType, subprocessDefId, subopinionCode, subopinionName));
}

MyProcess.prototype.getOpinionTableTr = function (pid,
   		 opinionName,
   		 opinionCode,
   		 opinionOrder,
   		 positionId,
   		 positionText ,
   		 showPositionText,
   		 showPositionId,
   		 eSign,
   		 ideaStyle,
   		 showIdeaStyle,
   		 opinionNode,
   		 opinionNodeText, opinionType, subprocessDefId, subopinionCode, subopinionName) {
	var _self = this;
	var $tr = $("<tr data-toggle='popover' data-container='body' title=''></tr>");
    // 增加一个hover
    var _dataContent = '<table width="180px" border="0" style="font-size:12px;table-layout:fixed;"  align="center">'
			+'<tr><td width="40%" height="25"><lable>名称:</lable></td><td>'+opinionName+'</td></tr>'
				+'<tr ><td width="40%" height="25">代码:</td><td>'+opinionCode+'</td></tr>'
				+'<tr><td width="40%" height="25" >排序:</td><td>'+opinionOrder+'</td></tr>'
/*				+'<tr><td width="40%" height="25" >节点:</td><td >'+opinionNodeText+'</td></tr>'
				+'<tr><td width="40%" height="25">查看岗位:</td><td>'+positionText+'</td></tr>'
				+'<tr><td width="40%" height="25">显示岗位:</td><td>'+showPositionText+'</td></tr>'*/
				+'</table>';
    $tr.attr("data-content",_dataContent);
    $tr.popover({trigger:"hover",placement:"top",html:true});
    var $td1 = $("<td></td>");
    $td1.append(opinionName);
    // 添加隐藏input
    var $input = $("<input type='hidden'/>");
    var opinion ={
   		 opinionName : opinionName,
   		 opinionCode : opinionCode,
   		 opinionOrder : opinionOrder,
   		 positionId : positionId,
   		 positionText : positionText,
   		 showPositionText : showPositionText,
   		 showPositionId : showPositionId,
   		 eSign : eSign,
   		 ideaStyle : ideaStyle,
   		opinionType : opinionType,
   		subprocessDefId : subprocessDefId,
   		subopinionCode : subopinionCode,
   		subopinionName : subopinionName,
   		showIdeaStyle : showIdeaStyle,
   		opinionNode : opinionNode,
   		opinionNodeText : opinionNodeText
    }
    $input.val(JSON.stringify(opinion));
    $td1.append($input);
    var op = "<td><a href='javascript:void(0)' name='deleteOpinion'><i class='iconfont icon-delete'></i></a>" +
 	   "<a href='javascript:void(0)' name='modifyOpinion' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
    var $td2 = $(op);
    $td2.find("a[name='deleteOpinion']").off("click").on("click",function() {
    	var $tr = $(this).parent().parent();
    	var ariaDescribedby =$tr.attr("aria-describedby");
    	$("#"+ariaDescribedby).remove();
        $tr.remove();
    });
    $td2.find("a[name='modifyOpinion']").off("click").on("click",function() {
    	var idx = $(this).parent().parent().index();
   	 layer.open({
     	    type:  2,
     	    area: [ "80%",  "80%"],
     	    title: "意见修改",
     	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
     	    shade:   0.3,
     	    maxmin: false, //开启最大化最小化按钮
     	    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ProcessOpinion/processOpinionEdit.jsp?id="+pid+"&idx="+idx,
     	   btn: ['确定', '关闭'],
     	   yes: function(index, layero){
       	    	var iframeWin = layero.find('iframe')[0].contentWindow;
       	    	var isValidate = iframeWin.$("#form").validate();
    	        if (!isValidate.checkForm()) {
    	            isValidate.showErrors();
    	            return false;
    	        }
    	        _self.saveModifyOpinion(_self.id, idx, iframeWin.$("#form"));
//    	       layer.msg("保存成功");
    	       layer.close(index);
       		 }
     	});
    });

    $tr.append($td1).append($td2);
    return $tr;
}

MyProcess.prototype.saveModifyOpinion = function (pid, idx, $form) {
	var _self = this;
	 var opinionName =  $form.find("#opinionName").val();
	 var opinionCode = $form.find("#opinionCode").val();
	 var opinionOrder = $form.find("#opinionOrder").val();
	 var opinionNode = $.trim($form.find("#opinionNode").val());
	 var opinionNodeText = $.trim($form.find("#opinionNodeText").val());
	 var positionId = $form.find("#positionId").val().replaceAll(";",",");
	 var positionText = $form.find("#positionText").val().replaceAll(";",",");
	 var showPositionId = $form.find("#showPositionId").val().replaceAll(";",",");
	 var showPositionText = $form.find("#showPositionText").val().replaceAll(";",",");
	 var eSign = $.trim($form.find("#eSign").val());
	 var ideaStyle = $.trim($form.find("#ideaStyle").val());
	 var opinionType = $.trim($form.find("#opinionType").val());
	 var subprocessDefId = $.trim($form.find("#subprocessDefId").val());
	 var subopinionCode = $.trim($form.find("#subopinionCode").val());
	 var subopinionName = $.trim($form.find("#subopinionName").val());
	  var showIdeaStyle = $.trim($form.find("#ideaStyle option[value='"+ideaStyle+"']").text());
	 var $tr = $("<tr data-toggle='popover' data-container='body' title=''></tr>");
	 // 增加一个hover
	 var _dataContent = '<table width="180px" border="0" style="font-size:12px;table-layout:fixed;"  align="center">'
		 +'<tr><td width="40%" height="25"><lable>名称:</lable></td><td>'+opinionName+'</td></tr>'
		 +'<tr ><td width="40%" height="25">代码:</td><td>'+opinionCode+'</td></tr>'
		 +'<tr><td width="40%" height="25" >排序:</td><td>'+opinionOrder+'</td></tr>'
/*		 +'<tr><td width="40%" height="25" >节点:</td><td>'+opinionNodeText+'</td></tr>'
		 +'<tr><td width="40%" height="25">查看岗位:</td><td>'+positionText+'</td></tr>'
		 +'<tr><td width="40%" height="25">显示岗位:</td><td>'+showPositionText+'</td></tr>'*/
		 +'</table>';
	 $tr.attr("data-content",_dataContent);
	 $tr.popover({trigger:"hover",placement:"top",html:true});
	 var $td1 = $("<td></td>");
	 $td1.append(opinionName);
	 // 添加隐藏input
	 var $input = $("<input type='hidden'/>");
	 var opinion ={
			 opinionName : opinionName,
			 opinionCode : opinionCode,
			 opinionOrder : opinionOrder,
			 opinionNode : opinionNode,
			 opinionNodeText : opinionNodeText,
			 positionId : positionId,
			 positionText : positionText,
			 showPositionText : showPositionText,
			 showPositionId : showPositionId,
			 eSign : eSign,
			 ideaStyle : ideaStyle,
			 opinionType: opinionType,
			 subprocessDefId: subprocessDefId,
			 subopinionCode: subopinionCode,
			 subopinionName: subopinionName,
			 showIdeaStyle :showIdeaStyle
	 }
	 $input.val(JSON.stringify(opinion));
	 $td1.append($input);
	 var op = "<td><a href='javascript:void(0)' name='deleteOpinion'><i class='iconfont icon-delete'></i></a>" +
	 "<a href='javascript:void(0)' name='modifyOpinion' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
	 var $td2 = $(op);
	 $td2.find("a[name='deleteOpinion']").off("click").on("click",function() {
         var $tr = $(this).parent().parent();
         var ariaDescribedby =$tr.attr("aria-describedby");
         $("#"+ariaDescribedby).remove();
         $tr.remove();
	 });
	 $td2.find("a[name='modifyOpinion']").off("click").on("click",function() {
		 var idx = $(this).parent().parent().index();
		 layer.open({
			 type:  2,
			 area: [ "80%",  "80%"],
			 title: "意见修改",
			 skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
			 shade:   0.3,
			 maxmin: false, //开启最大化最小化按钮
			 content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ProcessOpinion/processOpinionEdit.jsp?id="+pid+"&idx="+idx,
			 btn: ['确定', '关闭'],
     	   yes: function(index, layero){
       	    	var iframeWin = layero.find('iframe')[0].contentWindow;
       	    	var isValidate = iframeWin.$("#form").validate();
    	        if (!isValidate.checkForm()) {
    	            isValidate.showErrors();
    	            return false;
    	        }
    	        _self.saveModifyOpinion(_self.id, idx, iframeWin.$("#form"));
//    	       layer.msg("保存成功");
    	       layer.close(index);
       		 }
		 });
	 });
	 $tr.append($td1).append($td2);
	 var oldTr =  $("#"+pid+" table[name='table-process-add-opinion'] tbody tr").eq(idx);
	 $tr.replaceAll(oldTr);
}

/**** 	基本信息各种事件结束	 ****/

/**** 	启动条件各种事件开始	 ****/

/**
 * 初始化：启动条件
 * @param executorDomId  执行方式domId
 * @param tableExecutorDomId	数据table domId
 * @param tagNodeXml
 */
MyProcess.prototype.createConditionDom = function(executorDomId, tableExecutorDomId, tagNodeXml) {
	var self = this;
	$(tagNodeXml).children("conditions").each(function(){
		var type = $(this).attr("type");
		$('#' + self.id).find('#' + executorDomId).val(type);
		var $tbody = $("#" + self.id).find("#" +  tableExecutorDomId).find("tbody");
		$(this).children("condition").each(function(i){
			var idx = i;
			var c_type = $(this).attr("type");
            var computeRes = $(this).attr("computeRes");
			var value = $(this).text();
			// 该方法中的参数是jquery参数
            if (computeRes != null && computeRes != ''){
                // 该方法中的参数是jquery参数
                EventThatInsertStartConditionContentIntoTableWhenInit($tbody, c_type, $("<input value='"+computeRes +"'longJson='"+value+"'/>"));
            } else {
                // 该方法中的参数是jquery参数
                EventThatInsertStartConditionContentIntoTableWhenInit($tbody, c_type, $("<input value='"+value+"'/>"));
            }
		});
	});
};

MyProcess.prototype.modifyStartCondition = function (obj) {
		var $modifyBtn = $(obj);
		var $targetTr = $modifyBtn.parent().parent();
		var $tabName = $targetTr.find("td:eq(1)");
		var tabIndex =  $tabName.text().toLowerCase()== "expr" ? 0 : 1;
		var $val =  $targetTr.find("td:eq(2)");
		// 切换tab
		$modifyBtn.find("div[name='demoCont'] ul").find("li:eq("+tabIndex+")").click();
		// 先找到顶层的div
		var $top = $modifyBtn.parents("table[name=table-executor]").parent().parent();
		// 进行tab切换
		this.changeStartConditionTab($top.find("ul:eq(0)").find("li").eq(tabIndex));
		// 赋值
		$top.find("ul:eq(1)")
				.find("li")
				.eq(tabIndex)
				.find(tabIndex == 0? "textarea" : "input")
				.val($val.text().trim());

		// 查找添加buttion
		var $oldAddButton = $top.find("ul:eq(1)")
				.find("li")
				.eq(tabIndex).find("button[name='btn-add-start-condition']");
		// 更改为 保存添加按钮
		var $oldBtn = $oldAddButton.clone(true);
		$oldAddButton.off("click").text("保存").on("click", function() {
            var $content = tabIndex == 0 ?  $(this).parent().parent().parent().find("textarea") :
           	 $(this).parent().parent().parent().find("input");
            if ($content && $content.val().length != 0) {
            	$val.text($content.val());
            	$content.val("");
				// 恢复原来的添加按钮
				$(this).replaceWith($oldBtn);
            } else {
                alert("您还没输入内容");
            }
            return false;
		});
 }
MyProcess.prototype.changeStartConditionTab = function (obj) {
		var that = $(obj);
    //切换标签
    that.addClass('active')
        .siblings('li')
        .removeClass('active')
        .parent('.global-attrs-tab')
        .siblings('.tab-cont')
        .find('>li:eq(' + that.index() + ')')
        .addClass('active')
        .siblings('li')
        .removeClass('active');
      // 选中input
     that.find("input").prop("checked",true);
}

/**** 	启动条件各种事件结束	 ****/

MyProcess.prototype.getFlowVariables = function (variableDomId) {
	var _self = this;
	var dataArr = []
	var $tableTbody = $("#"+_self.id).find("table[name='table-flow-variable'] tbody tr");
	if($tableTbody.length > 0) {
		$tableTbody.each(function(index) {
			var $hiddenInput = $(this).find("td:eq(0) > div > input");
			try {
				var dataJSON = JSON.parse($hiddenInput.val());
				dataArr.push(dataJSON);
			} catch(err) {

			}
		});
	}
	return dataArr;
}



 /**	流程变量各种事件开始		**/

MyProcess.prototype.setFlowVariableXml = function(variableDomId, tabNodeXml) {
		// 从隐藏表单中获取数据
		var $obj = $('#' + this.id).find('#' + variableDomId + ' tbody tr');
		if($obj.length > 0) {
			var node = flowUtils.createElement('variables');
			$obj.each(function(index) {
				var $hiddenInput = $(this).find("td:eq(0) > div > input");
				var dataJSON = JSON.parse($hiddenInput.val());
				var varNode = flowUtils.createElement('variable');
				varNode.setAttribute("alias", dataJSON.alias);
				varNode.setAttribute("name", dataJSON.name);
				varNode.setAttribute('required', "N");
				varNode.setAttribute("init-expr", dataJSON.initExpr);
				varNode.setAttribute("type", dataJSON.type);
				varNode.setAttribute("desc", dataJSON.desc);
				node.appendChild(varNode);
			});
			tabNodeXml.appendChild(node);
		}
}

/**
 * 封装流程变量基本信息
 * @param varName
 * @param varibale
 * @param varVal
 * @param varType
 * @param varDesc
 * @returns
 */
MyProcess.prototype.assembleBpmVariableJSONData = function(varName, varibale, varVal, varType, varDesc) {
	var data = {
			alias 			: varName,
			name 			: varibale,
			initExpr 		: varVal,
			type 			: varType,
			desc			: varDesc
	};
	return JSON.stringify(data);
}

 /**
  * 初始化页面的时候，回写流程变量dom
  * @param tableDomId
  * @param tagNodeXml
  */
 MyProcess.prototype.createFlowVariableDom = function(tableDomId, tagNodeXml) {
		var self = this;
		$(tagNodeXml).children("variables").children("variable").each(function(){
			var $tableTbody = $("#"+self.id).find("table[name='table-flow-variable'] tbody");
			var variableName = $(this).attr("alias");
			var variable = $(this).attr("name");
			var variableValue = $(this).attr("init-expr");
			var variableType = $(this).attr("type");
			var variableDesc = $(this).attr("desc");
			self.insertFlowVariableContentIntoTable($tableTbody, variableName, variable, variableValue, variableType, variableDesc)
		});
		self.introVariableListener();
}

 /**
  * 封装基本信息到给定的tbody中
  * @param $tableTbody
  * @param variableName
  * @param variable
  * @param variableValue
  * @param variableType
  * @param variableDesc
  */
 MyProcess.prototype.insertFlowVariableContentIntoTable =  function ($tableTbody, variableName, variable, variableValue, variableType, variableDesc) {
     var _self = this;
	 var btn = '<a href="javascript:void(0)" name="btn-flow-variable-delete"><i class="iconfont icon-delete"></i></a>';
     btn += '<a href="javascript:void(0)" name="btn-flow-variable-modify" style="margin-left:5px"><i class="iconfont icon-edit"></i></a>';

     var varJSONData = _self.assembleBpmVariableJSONData(variableName, variable, variableValue, variableType, variableDesc);

     // 隐藏表单
     var hiddenInput = "<div class='hidden'>";
     	hiddenInput += "<input name='dataValue' value='" + varJSONData + "'/>"
     	hiddenInput += "</div>";
     var content = variable + "(" + variableType + ")" + (variableValue ? "=" + variableValue : "");
     var c = '<tr title="' + content + '" ><td style="display:none;">' + hiddenInput + '</td><td>' + variableName + '</td><td>' + content + '</td> <td> ' + btn + '</td></tr>';
     $tableTbody.append(c);
     _self.reloadVaribaleButtonEvent();

 }

 /**
  * 重新绑定表格中信息的事件
  */
 MyProcess.prototype.reloadVaribaleButtonEvent = function () {
	 var _self = this;
	 $("a[name='btn-flow-variable-delete']").off('click').on('click', function(argument) {
		 if (!_self.lock.varModifyLock) {
			 _self.userClickVariableDelete(this);
			 _self.introVariableListener();
		 } else {
			 layer.msg("请先保存当前操作项");
		 }
	 });;
	 $("a[name='btn-flow-variable-modify']").off('click').on('click', function(argument) {
			 _self.userClickVariableModify(this);
	 });
 }

 /**
  * obj 流程变量中的修改按钮dom
  */
 MyProcess.prototype.userClickVariableModify = function(obj) {
	 var _self = this;
	 if (_self.lock.varModifyLock) {
		 layer.msg("请先保存当前操作项");
		 return false;
	 }
	 // 假装加了一个锁,防止用户点击多次修改.
	 // 此处也可以让用户多次点击修改，以最后一次点击为准
	  _self.lock.varModifyLock = true;
      // 显示保存按钮并在该方法中添加事件
	 _self.toggleSiblingsButton($("button[name='btn-save-flow-variable']"));

     // 后续赋值使用
     var $topTR = $(obj).parent().parent();

     // 获取到该tab的最顶部dom
     var $top = $(obj).parent().parent().parent().parent().parent().parent();

     // 获取变量的 json内容
     var dataValue = $topTR.find("td>div>input[name=dataValue]").val();
     var dataJSON = JSON.parse(dataValue);

     $top.find("input[name='avic-input-variable-name']").val(dataJSON.alias);
     $top.find("input[name='avic-input-variable']").val(dataJSON.name);
     $top.find("select[name='avic-input-variable-type']").val(dataJSON.type);
     $top.find("input[name='avic-input-variable-value']").val(dataJSON.initExpr);
     $top.find("textarea[name='avic-input-variable-desc']").val(dataJSON.desc);

     // 获取显示内容
     var $showVaribaleName = $topTR.find("td:eq(1)");
     var $showVaribaleExpress = $topTR.find("td:eq(2)");


     // 添加保存按钮事件
     $("button[name='btn-save-flow-variable']").off("click").on("click", function() {
         var obj = $(this);
         _self.toggleSiblingsButton(obj);
         // 隐藏表单赋值
         var varName = $top.find("input[name='avic-input-variable-name']").val();
         var varibale = $top.find("input[name='avic-input-variable']").val();
         var varValue = $top.find("input[name='avic-input-variable-value']").val();
         var varType = $top.find("select[name='avic-input-variable-type']").val();
         var varDesc = $top.find("textarea[name='avic-input-variable-desc']").val();
         $topTR.find("td>div>input[name=dataValue]").val(function(){
        	 return _self.assembleBpmVariableJSONData(varName,
        			 varibale,
        			 varValue,
        			 varType,
        			 varDesc)
         });

         var content = varibale + "(" + varType + ")" + (varValue ? "=" + varValue : "");
         // 修改tr的 title
         $topTR.attr("title", content);
         // 显示赋值
         $showVaribaleName.text(varName);

         $showVaribaleExpress.text(content);
         // 清空输入框
         obj.parent().parent().prevAll().find("input,textarea").val("");

         _self.lock.varModifyLock = false;
         _self.introVariableListener();
         return false;
     });
 }

 /**
  * 流程变量内容中的删除操作
  * obj 删除dom
  */
 MyProcess.prototype.userClickVariableDelete = function(obj) {
	 var _self = this;
	 if(!_self.lock.varModifyLock) { // 如果有正在进行的操作,则不允许删除
		 $(obj).parent().parent().remove();
	 } else {
		 layer.msg("请先保存当前项");
	 }
 }

 /**
  * 动态切换流程变量的保存、修改按钮
  * @param $btn
  */
 MyProcess.prototype.toggleSiblingsButton = function($btn) {
     $btn.each(function() {
         if ($(this).hasClass("hidden")) {
             $(this).removeClass("hidden");
             $(this).siblings().addClass("hidden");
         } else {
             $(this).addClass("hidden");
             $(this).siblings().removeClass("hidden");
         }
     });
 }

 MyProcess.prototype.introVariableListener = function() {
	 var _self = this;
	 _self.notify(_self);
 }
 /*MyProcess.prototype.reloadOptions = function(domName, option, type) {
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

 }*/
 /**	流程变量各种事件结束		**/

/* 启动权限开始  */

 MyProcess.prototype.initStartAuthTableDom = function (tagNodeXml, tableName, nodeType) {
	 var _self = this;
	 $(tagNodeXml).children("processAuth").children(nodeType).children().each(function(){
		 // 取id
		 var id = _self.getAttr(this, "id");
		 var name = $.trim($(this).find("name").text());
		 var type = $.trim($(this).find("type").text());
		 _self.addStartAuthTableContent (tableName, id, name, type);
	 });
 }

 MyProcess.prototype.getStartAuthTableXml = function (processAuth, tableName, xmlValuetype) {
	 var _self = this;
	 // 传入的xmlValueType分别为 user dept role group position
	 // 对应的xml节点分别为 users depts roles groups positions
	 var target = flowUtils.createElement(xmlValuetype+"s");
	 var $inputs =  $("#"+_self.id+" table[name='"+tableName+"'] tbody input");
	 $inputs.each(function() {
		 // 获取隐藏表单内容
		 var value = JSON.parse($(this).val());
		 // 创建对应的节点
		 // 创建节点属性，节点属性值为id
		var valueNode = flowUtils.createElement(xmlValuetype);
		valueNode.setAttribute("id", value.id);
		// 配置名称
		var nameNode = flowUtils.createElement("name");
		nameNode.appendChild(flowUtils.createTextNode(value.name))
		valueNode.appendChild(nameNode);
		// 配置类型
		var typeNode = flowUtils.createElement("type");
		typeNode.appendChild(flowUtils.createTextNode(value.type))
		valueNode.appendChild(typeNode);
		target.appendChild(valueNode);
	 });
	 processAuth.appendChild(target);
 }


 MyProcess.prototype.addStartAuthTableContent = function (tableName, id, name, type) {
	 if(flowUtils.notNull(id)){
		 var idArr = [];
		 var nameArr = [];
		 /*if(type == "user" || type == "dept"){
			 idArr = id.split(";");
			 nameArr = name.split(";");
		 }else{
			 idArr = id.split(",");
			 nameArr = name.split(",");
		 }*/
		 idArr = id.split(";");
		 nameArr = name.split(";");
		 if(idArr.length != 0 && idArr.length == nameArr.length){
			 var _self = this;
			 var table =  $("#"+this.id+" table[name='"+tableName+"'] tbody")
			 $.each(idArr, function(i, n){
				 if($("#" + _self.id + "_" + n).length == 0){
					 table.append(_self.getStartAuthTableTr(n, nameArr[i], type));
				 }
			 });
		 }
	 }
 }

 MyProcess.prototype.getStartAuthTableTr = function (id, name, type) {
	 var $tr = $("<tr data-toggle='popover' data-container='body' title=''></tr>");
	    // 增加一个hover
	    var _dataContent = '<table width="180px" border="0" style="font-size:12px;"  align="center">'
				+'<tr><td width="40%" height="25"><lable>名称:</lable></td><td>'+name+'</td></tr>'
					+'<tr ><td width="40%" height="25">编号:</td><td>'+id+'</td></tr>'
					+'</table>';
	    $tr.attr("data-content",_dataContent);
	    $tr.popover({trigger:"hover",placement:"top",html:true});
	    var $td1 = $("<td></td>");
	    $td1.append(id);
	    // 添加隐藏input
	    var $input = $("<input type='hidden'/>");
	    var auth ={
	    		id : id,
	    		name : name,
	    		type : type
	    }
	    $input.val(JSON.stringify(auth));
	    $td1.append($input);
	    var $td2 = $("<td></td>");
	    $td2.append(name);
	    var op = "<td><a href='javascript:void(0)' name='deleteStartAuth'><i class='iconfont icon-delete'></i></a> </td>";
	    var $td3 = $(op);
	    $td3.find("a[name='deleteStartAuth']").off("click").on("click",function() {
	    	$(this).parent().parent().popover('destroy');
	    	$(this).parent().parent().siblings("div").remove();
	    	$(this).parent().parent().remove();
	    });
	    $tr.append($td1).append($td2).append($td3);
	    $tr.attr("id", this.id + "_" + id);
	    return $tr;
 }
 /* 启动权限结束  */

 /* 同步人工节点表单开始*/
// MyBase.prototype.syncTaskForm = function(data) {
// 	 var values = this.designerEditor.myCellMap.values();
// 		$.each(values, function(i, n){
// 			if(n.tagName == "task"){
// 				this.syncTaskForm(data.id, data.name);
// 			}
// 		});
// }
 /* 同步人工节点表单结束*/

 MyProcess.prototype.updateGlobalVariable = function(data, context) {
		var _self = this;
		var $yinru = $("#"+_self.id+" select[name='yin_ru_bian_liang']");
		$yinru.empty();
		$yinru.append("<option selected value='0'>引入变量</option>");
		 var varContent = data;
		 if(varContent.length > 0) {
			 // 添加下拉框
			for(var i = 0; i < varContent.length ; i++) {
				var option = "<option>#{"+varContent[i].name+"}"+"</option>";
                // var option = "<option>"+varContent[i].name+"("+varContent[i].type+" "+varContent[i].initExpr+")"+"</option>"
				$yinru.append(option);
			}
		 }
	}

 MyProcess.prototype.initEvent = function() {
		var _self = this;

		// 流程意见配置
		 $("#"+_self.id+" button[name='btn-process-add-opinion']").off('click').on('click', function(e) {
			 layer.open({
         	    type:  2,
         	    area: [ "80%",  "80%"],
         	    title: "意见新增",
         	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
         	    shade:   0.3,
                maxmin: false, //开启最大化最小化按钮
         	    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ProcessOpinion/processOpinionAdd.jsp?id="+_self.id,
         	   btn: ['确定', '关闭'],
         	   yes: function(index, layero){
	       	    	var iframeWin = layero.find('iframe')[0].contentWindow;
	       	    	var isValidate = iframeWin.$("#form").validate();
	    	        if (!isValidate.checkForm()) {
	    	            isValidate.showErrors();
	    	            return false;
	    	        }
	    	        _self.addOpinion(_self.id, iframeWin.$("#form"));
//	    	       layer.msg("保存成功");
	    	       layer.close(index);
	       		 }
         	});
			 return false;
		 });

		 $("#"+_self.id+" select[name='yin_ru_bian_liang']").off('click').on('change', function() {
			 	if(this.value == 0) {
			 		return;
			 	}
	            var that = $(this);
	            var target = that.parent().parent().siblings("div").find("textarea")
	            var c = target.val().length == 0 ? that.val() : target.val() + "," + that.val();
	            target.val(c);
	       });

		 // 添加全局的流程变量，添加变量后会通知观察者
		  $("#"+_self.id+" button[name='btn-add-flow-variable']").off('click').on('click', function(argument) {
	            var $parent = $(this).parent().parent().parent();
	            var $variableName = $parent.find("input[name='avic-input-variable-name']");
	            var $variable = $parent.find("input[name='avic-input-variable']");
	            var $variableValue = $parent.find("input[name='avic-input-variable-value']");
	            var $variableType = $parent.find("select[name='avic-input-variable-type']");
	            var $variableDesc = $parent.find("textarea[name='avic-input-variable-desc']");
	            if (!$variableName || $variableName.val().length == 0) {
	                $variableName.focus();
	                layer.msg("还没填写变量名称");
	                return false;
	            }
	            if (!$variable || $variable.val().length == 0) {
	                $variable.focus();
	                layer.msg("还没填写变量");
	                return false;
	            }
	            // if (!$variableValue || $variableValue.val().length == 0) {
	            //     $variableValue.focus();
	            //     layer.msg("还没填写变量值");
	            //     return false;
	            // }

	            var $tableTbody = $parent.find("table[name='table-flow-variable'] tbody");
	            _self.insertFlowVariableContentIntoTable($tableTbody, $variableName.val(), $variable.val(), $variableValue.val(),
	                $variableType.val(), $variableDesc.val());
	            $variableName.val("");
	            $variable.val("");
	            $variableValue.val("");
	            $variableDesc.val("");
	            _self.introVariableListener();
	            return false;
	        });

		  $("#"+_self.id +" div[class^='div-auth-checkbox'] input[type='checkbox']").off('click').on("click",function() {
			  var selfCheckbox = this;
			  if(selfCheckbox.checked) {
				 var $divAuth =  $(selfCheckbox).parentsUntil(".form-group").parent().siblings("div[class^='div-auth-box']");
				 $divAuth.removeClass("hidden");
				 var divAuthClassName = $divAuth.attr("class");
				 // 存在操作人选择
				 if($divAuth.find("input[name='operator-data-field']").get(0)) {
					 // 增加按钮事件
					 $divAuth.find("button[name='button-auth-operator']").off("click").on("click",function() {
                         var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
						 var option = {processId:process.id,type:'userSelect', userSelectContainer :divAuthClassName ,dataField:'operator-data-field',textField:'operator-text-field',topId:_self.id};
						 new UserSelect(option);
					 })

				 }
				 if($divAuth.find("input[name='candidate-data-field']").get(0)) {
					 // 增加按钮事件
					 $divAuth.find("button[name='button-auth-candidate']").off("click").on("click",function() {
                         var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
					 	var option = {processId:process.id,type:'userSelect', userSelectContainer :divAuthClassName ,dataField:'candidate-data-field',textField:'candidate-text-field',topId:_self.id};
						 new UserSelect(option);
					 })
				 }
				 if($divAuth.find("input[name='preprocess-data-field']").get(0)) {
					 // 预处理按钮事件
					 $divAuth.find("button[name='button-auth-preprocess']").off("click").on("click",function() {
						 layer.open({
	                    	    type:  2,
	                    	    area: [ "400px",  "350px"],
	                    	    title: "函数输入框",
	                    	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
	                    	    shade:   0.3,
	                            maxmin: false, //开启最大化最小化按钮
	                    	    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/AuthProcessTpl/authProcessTpl.jsp?id="+_self.id+"&name=preprocess-data-field&className="+divAuthClassName,
	                    	});
					 })
				 }
				 if($divAuth.find("input[name='postprocess-data-field']").get(0)) {
					 // 预处理按钮事件
					 $divAuth.find("button[name='button-auth-postprocess']").off("click").on("click",function() {
						 layer.open({
							 type:  2,
							 area: [ "400px",  "350px"],
							 title: "函数输入框",
							 skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
							 shade:   0.3,
							 maxmin: false, //开启最大化最小化按钮
							 content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/AuthProcessTpl/authProcessTpl.jsp?id="+_self.id+"&name=postprocess-data-field&className="+divAuthClassName,
						 });
					 })
				 }

			  } else {
				  var $divAuthBox = $(selfCheckbox).parentsUntil(".form-group").parent().siblings("div[class^='div-auth-box']");
				  $divAuthBox.addClass("hidden").find("input").val("");
			  }
		  });

		// 权限配置
		 $("#"+_self.id+" button[name='btn-tab-add-auth']").off('click').on('click', function(e) {
			 e.preventDefault();
			var dataRole =  $(this).attr("data-role");

			if(dataRole == "user") {
				var u1 = {
						type : 'userSelect',
						idFiled : _self.id+' #inputSelectUser',
						textFiled : _self.id+' #inputSelectUserText',
						selectModel : "multi",
						callBack: function(data) {
							_self.addStartAuthTableContent("table-auth-"+dataRole,data.userids,data.usernames,dataRole);
						},
						viewScope : 'currentOrg'
					};
				new H5CommonSelect(u1);
			}
			if(dataRole == "dept") {
				var u1 = {
						type : 'deptSelect',
						idFiled : _self.id+' #inputSelectDept',
						textFiled : _self.id+' #inputSelectDeptText',
						selectModel : "multi",
						callBack: function(data) {
							_self.addStartAuthTableContent("table-auth-"+dataRole,data.deptids,data.deptnames,dataRole);
						},
						viewScope : 'currentOrg'
				};
				new H5CommonSelect(u1);
			}
			if(dataRole == "role") {
				var u1 = {
						type : 'roleSelect',
						idFiled : _self.id+' #inputSelectRole',
						textFiled : _self.id+' #inputSelectRoleText',
						selectModel : "multi",
						callBack: function(data) {
							_self.addStartAuthTableContent("table-auth-"+dataRole,data.roleids,data.roleNames,dataRole);
						},
						viewScope : 'currentOrg'
				};
				new H5CommonSelect(u1);
			}
			if(dataRole == "group") {
				var u1 = {
						type : 'groupSelect',
						idFiled : _self.id+' #inputSelectGroup',
						textFiled : _self.id+' #inputSelectGroupText',
						selectModel : "multi",
						callBack: function(data) {
							_self.addStartAuthTableContent("table-auth-"+dataRole,data.groupids,data.groupNames,dataRole);
						},
						viewScope : 'currentOrg'
				};
				new H5CommonSelect(u1);
			}
			if(dataRole == "position") {
				var u1 = {
						type : 'positionSelect',
						idFiled : _self.id+' #inputSelectPosition',
						textFiled : _self.id+' #inputSelectPositionText',
						selectModel : "multi",
						callBack: function(data) {
							_self.addStartAuthTableContent("table-auth-"+dataRole,data.positionids,data.positionNames,dataRole);
						},
						viewScope : 'currentOrg'
				};
				new H5CommonSelect(u1);
			}
		 });

		 //expr配置
		 $("#"+_self.id+" button[name='btn-expr-config']").off('click').on("click", function(){
				var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
				var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
		        new ExprConfig({id:_self.id,domId:_self.id+" #expr-config-value-new",globalformid:globalformid,
                    processFlag:true,
		        	callback:function(data){

		        }});
		    });
		 $("#"+_self.id+" #flow_owner_deptName").off('click').on("click", function(){
			 var u1 = {
						type : 'deptSelect',
						idFiled : _self.id+' #flow_owner_deptId',
						textFiled : _self.id+' #flow_owner_deptName',
						selectModel : "single",
						callBack: function(data) {
							$("#"+ _self.id+' #flow_owner_userId').val("");
							$("#"+ _self.id+' #flow_owner_userName').val("");
						},
						viewScope : 'currentOrg'
				};
				new H5CommonSelect(u1);
		 });
		 $("#"+_self.id+" #flow_owner_userName").off('click').on("click", function(){
			 var u1 = {
						type : 'userSelect',
						idFiled : _self.id+' #flow_owner_userId',
						textFiled : _self.id+' #flow_owner_userName',
						deptidFiled:_self.id+' #flow_owner_deptId',
						deptNameFiled:_self.id+' #flow_owner_deptName',
						selectModel : "single",
						viewScope : 'currentOrg'
					};
				new H5CommonSelect(u1);
		 });
};


MyProcess.prototype.addObserver = function( observer ){
	  this.observers.add( observer );
};

MyProcess.prototype.notify = function( context ){
	  var observerCount = this.observers.count();
	  var jsonData = this.getFlowVariables();
	  for(var i=0; i < observerCount; i++){
	    this.observers.get(i).updateGlobalVariable(jsonData, context );
	  }
};

function ObserverList() {
	this.observerList = [];
}

ObserverList.prototype.add = function(obj) {
	this.observerList.push(obj);
};

ObserverList.prototype.removeAt = function( index ){
	  this.observerList.splice( index, 1 );
};

ObserverList.prototype.remove = function( obj ){
	var index = this.indexOf(obj,0);
	this.observerList.splice( index, 1 );
};

ObserverList.prototype.indexOf = function( obj, startIndex ){
	  var i = startIndex;
	  while( i < this.observerList.length ){
	    if( this.observerList[i] === obj ){
	      return i;
	    }
	    i++;
	  }
	  return -1;
};

ObserverList.prototype.count = function(){
	  return this.observerList.length;
};

ObserverList.prototype.get = function( index ){
	  if( index > -1 && index < this.observerList.length ){
	    return this.observerList[ index ];
	  }
};
;
///<jscompress sourcefile="MySql.js" />
/**
 * sql extends MyBase
 */
function MySql(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "sql");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_sql.png;";
};
MySql.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MySql.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getSql();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-sql-node");
    // 界面模型事件
    this.initEvent();
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MySql.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setSql(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是节点私有的*******/
    // 界面模型事件
    this.initEvent();
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-sql-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
	
    var self = this;
    $(xmlValue).children("dataSource").each(function(){
		$("#" + self.id).find("#shujuyuan").val($.trim($(this).text()));
	});
    
    $("#"+this.id+" input[name='inputValueBackVar']").val(this.getAttr(xmlValue,"var"));
    $("#"+this.id+" input[name='inputTextBackVar']").val(this.getAttr(xmlValue,"var"));

    var unique = this.getAttr(xmlValue,"unique");
    if(unique == "true") {
        $("#" + this.id + " input[name='fanhuiweiyizhi']").trigger("click");
    }
    $("#"+this.id +" #chaxuntiaojian").val($.trim($(xmlValue).children("query").text()));
    this.sqlQueryParameter.getDom(xmlValue);
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MySql.prototype.getOtherAttr = function(node) {

	// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
	var dataSource = $("#"+this.id+" #shujuyuan").val();
	if(flowUtils.notNull(dataSource)){
		var dataSourceNode = flowUtils.createElement("dataSource");
		dataSourceNode.appendChild(flowUtils.createTextNode(dataSource));
		node.appendChild(dataSourceNode);
	}
	
	this.addMeta("error","break",node);
    this.putAttr("var",$("#"+this.id+" input[name='inputValueBackVar']").val(),node);
    this.putAttr("unique",$("#"+this.id+" input[name='fanhuiweiyizhi']").is(":checked"),node);
   	var query =  $("#"+this.id +" #chaxuntiaojian").val();
    if(flowUtils.notNull(query)){
        var meta = flowUtils.createElement("query");
        meta.appendChild(flowUtils.createTextNode(query));
        node.appendChild(meta);
    }
    this.sqlQueryParameter.getXml(node);

};

MySql.prototype.initEvent = function() {
	var _self = this;
    $("#"+_self.id+" button[name='button-BackVar']").on("click", function(){
        var process = null;
        var values = _self.designerEditor.myCellMap.values();
        $.each(values, function(i, n){
            if(n.tagName == "process"){
                process = n;
            }
        });
        new ProcessVariable({dataDomId:_self.id+" #inputValueBackVar",showDomId:_self.id+" #inputTextBackVar", callback:function(data){
            var d = data[0];
            var txt = d.name;
            $("#"+_self.id+" #inputValueBackVar").val(txt);
            $("#"+_self.id+" #inputTextBackVar").val(txt);
        },process:process,
            multiple:false});
    });

    _self.sqlQueryParameter = new SQLQueryParameter({id:_self.id, buttonId:"buttonAddSQLQueryParameter", tableId:_self.id+" #table-flow-add-SQLQueryParameter",type:"parameters", callback:function(data){
        var d = data[0];
    }});

};
///<jscompress sourcefile="MyStart.js" />
/**
 * start extends MyBase
 */
function MyStart(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "start");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/start_event_empty.png;";
};
MyStart.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyStart.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getStart();
	this.labelChanged("开始");
	this.initJBXX();// 初始化基本信息
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-start-node");
	
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyStart.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setStart(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	
	// 节点基本信息
	this.setDomValByMeta("start-node-desc", xmlValue, "remark");
	
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-start-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyStart.prototype.getOtherAttr = function(node) {
	/*  <start alias="开始" g="100,40,55,50" name="start2">
	    <meta name="remark"><![CDATA[dsad]]></meta>
	  </start>*/
	this.setXmlMetaByVal("start-node-desc", node, "remark");
	// 获取事件xml
	this.nodeEvent.setEventXml(node, "");//event
};;
///<jscompress sourcefile="MyState.js" />
/**
 * state extends MyBase
 */
function MyState(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "state");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_wait.png;";
};
MyState.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyState.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getState();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-state-node");
	
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyState.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setState(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-state-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyState.prototype.getOtherAttr = function(node) {
// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
};
;
///<jscompress sourcefile="MySubprocess.js" />
/**
 * sub-process extends MyBase
 */
function MySubprocess(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "sub-process");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_subprocess.png;";
};
MySubprocess.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MySubprocess.prototype.init = function() {
	this.initBase();
	this.name = "Subprocess" + this.designerEditor.countUtils.getSubprocess();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-subprocess-node");
    // 界面模型的事件
    this.initEvent();
};
/**
 * 为流程跟踪提供的特殊方法
 * @param xmlValue
 * @param rootXml
 */
MySubprocess.prototype.initTracks = function(xmlValue, rootXml) {
    this.name = xmlValue.getAttribute("name");
    this.alias = $.trim(xmlValue.getAttribute("alias"));
    this.g = xmlValue.getAttribute("g");
    this.deploymentId = this.getAttr(xmlValue,"sub-process-id");
    rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
    this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MySubprocess.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setSubprocess(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/


	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-subprocess-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
	// 界面模型的事件
    this.initEvent();
    $("#"+this.id+" #inputValueSubFlowId").val(this.getAttr(xmlValue,"sub-process-id"));
    $("#"+this.id+" #inputValueSubFlowName").val(this.getAttr(xmlValue,"sub-process-key"));
    $("#"+this.id+" #inputTextSubFlowName").val(this.getAttr(xmlValue,"sub-process-name"));
    var shifoutongbu = this.getMeta(xmlValue, "asynchronous");
    $("#" + this.id).find("input[name='shifoutongbu'][value='"+shifoutongbu+"']").prop("checked","checked");
    var isMustUser = this.getMeta(xmlValue,"isMustUser");
    if(isMustUser == "yes") {
        $("#"+this.id+" #ziliuchengxuanren").trigger("click");
        var metaValue = this.getMeta(xmlValue, "userSelectType");
        $("#" + this.id).find("#yunxuzidongxuanren").prop("checked", metaValue =="auto" ? true :false);
        this.setUserSelectDom({dataField:'candidate-data-field',textField:'candidate-text-field'}, xmlValue);
	}
	this.setDomCheckByMeta("putongliucheng", xmlValue, "putongliucheng", "no");

    $("#"+this.id+" input[name='inputValueOutCome']").val(this.getAttr(xmlValue, "outcome"));
    $("#"+this.id+" input[name='inputTextOutCome']").val(this.getAttr(xmlValue, "outcome"));
    this.parameterIn.getDom(xmlValue);
    this.parameterOut.getOutDom(xmlValue);
    this.getFormInDom(xmlValue);
    this.getFormOutDom(xmlValue);
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MySubprocess.prototype.getOtherAttr = function(node) {
// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
	 this.putAttr("sub-process-id", $("#"+this.id+" #inputValueSubFlowId").val(), node);
    this.putAttr("sub-process-key", $("#"+this.id+" #inputValueSubFlowName").val(), node);
    this.putAttr("sub-process-name", $("#"+this.id+" #inputTextSubFlowName").val(), node);
    this.addMeta("asynchronous",$("#"+this.id+" input[name='shifoutongbu']:checked").val(),node);

    if($("#"+this.id+" input[name='ziliuchengxuanren']").is(":checked")) {
        this.addMeta("isMustUser","yes",node);
        this.addMeta("userSelectType",$("#"+this.id+" input[name='yunxuzidongxuanren']").is(":checked")?"auto":"manual",node);
        this.setUserSelectXml({dataField:'candidate-data-field'}, node);
    } else {
        this.addMeta("isMustUser","no",node);
	}
	this.setXmlMetaByCheck("putongliucheng", node, "putongliucheng");

    this.putAttr("outcome",$("#"+this.id+" input[name='inputValueOutCome']").val(),node);
    this.parameterIn.getXml(node);
    this.parameterOut.getOutXml(node);
    this.getFormInXml(node);
    this.getFormOutXml(node);
};
/**
 * 通过name解析数字，例如end1解析出数字:1
 */
MySubprocess.prototype.resolve = function() {
	return Number(this.name.replace("Subprocess", ""));
};

MySubprocess.prototype.initEvent = function() {
	var _self = this;
    $("#"+_self.id+" button[name='button-sub-flowname']").on("click", function(){
        new SubProcess({dataDomId:_self.id+" #inputValueSubFlowName",showDomId:_self.id+" #inputTextSubFlowName", callback:function(data){
        }, multiple:false, dataDomId2:_self.id+" #inputValueSubFlowId"});
    });

    
    $("#"+_self.id+" #ziliuchengxuanren").on("click", function(){
    	if(this.checked) {
    		if($("#"+_self.id+" div[name='zidongxuanren-area']").hasClass("hidden")) {
                $("#"+_self.id+" div[name='zidongxuanren-area']").removeClass("hidden");
			}
		} else {
            if(!$("#"+_self.id+" div[name='zidongxuanren-area']").hasClass("hidden")) {
                $("#"+_self.id+" div[name='zidongxuanren-area']").addClass("hidden");
            }
		}
	});
    var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
    $("#"+_self.id+" button[name='button-auth-candidate']").on('click',function() {
        var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
    	var option = {processId:process.id,type:'userSelect',dataField:"candidate-data-field",textField:"candidate-text-field",topId:_self.id,processId:process.id};
        new UserSelect(option);
	});


    $("#"+_self.id+" button[name='button-OutCome']").on("click", function(){
        var process = null;
        var values = _self.designerEditor.myCellMap.values();
        $.each(values, function(i, n){
            if(n.tagName == "process"){
                process = n;
            }
        });
        new ProcessVariable({dataDomId:_self.id+" #inputValueOutCome",showDomId:_self.id+" #inputTextOutCome", callback:function(data){
            var d = data[0];
            var txt = "#{"+d.name+"}";
            $("#"+_self.id+" #inputValueOutCome").val(txt);

            $("#"+_self.id+" #inputTextOutCome").val(txt);
        },process:process,
            multiple:false});
    });

    _self.parameterIn = new ParameterInAndOut({id:_self.id, buttonId:"buttonAddParameterIn", tableId:_self.id+" #table-flow-ParameterIn",type:"parameter-in", callback:function(data){
//       console.log(data);
    }});
    _self.parameterOut = new ParameterInAndOut({id:_self.id, buttonId:"buttonAddParameterOut", tableId:_self.id+" #table-flow-ParameterOut",type:"parameter-out", callback:function(data){
//       console.log(data);
    }});
    
    $("#"+_self.id+" button[name='formFieldParameterConfig']").on("click", function(){
    	var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
		var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
        var subProcessKey = $("#"+_self.id+" #inputValueSubFlowName").val();
        var subProcessId = $("#"+_self.id+" #inputValueSubFlowId").val();
        if(!flowUtils.notNull(subProcessId) && !flowUtils.notNull(subProcessKey)){
        	layer.msg("您还没选择子流程");
        	return false;
        }
        
        new FormFieldParameter({id:_self.id,dataDomId1:_self.id+" #fieldArgsMainProcessToSub",dataDomId2:_self.id+" #fieldArgsSubProcessToMain",callback:function(data){
            
        },process:process,mainProcessFormId:globalformid,
        subProcessKey:subProcessKey});
    });

};
MySubprocess.prototype.getFormInXml = function(node) {
	var _self = this;
	var formInVal = $("#"+_self.id+" #fieldArgsMainProcessToSub").val();
	if(flowUtils.notNull(formInVal)){
		var formInArr = JSON.parse(formInVal);
		if(formInArr.length){
			for(i=0;i<formInArr.length;i++){
				var data = formInArr[i];
				var arg = flowUtils.createElement("form-in");
				arg.setAttribute("formTable", data.formTable);
				arg.setAttribute("formCol", data.formCol);
				arg.setAttribute("subFormTable", data.subFormTable);
				arg.setAttribute("subFormCol", data.subFormCol);
				arg.setAttribute("colType", data.colType);
				arg.setAttribute("tableModify", data.tableModify);
				arg.setAttribute("colComments",data.colComments);
				arg.setAttribute("isOrgIdentity",data.isOrgIdentity);
				arg.setAttribute("fromComments",data.fromComments);
				arg.setAttribute("isSubTable",data.isSubTable=="1"?"1":"");
				arg.setAttribute("fromFkColName",data.fromFkColName);
				arg.setAttribute("toFkColName",data.toFkColName);
				node.appendChild(arg);
			}
		}
	}
};
MySubprocess.prototype.getFormOutXml = function(node) {
	var _self = this;
	var formOutVal = $("#"+_self.id+" #fieldArgsSubProcessToMain").val();
	if(flowUtils.notNull(formOutVal)){
		var formOutArr = JSON.parse(formOutVal);
		if(formOutArr.length){
			for(i=0;i<formOutArr.length;i++){
				var data = formOutArr[i];
				var arg = flowUtils.createElement("form-out");
				arg.setAttribute("formTable", data.formTable);
				arg.setAttribute("formCol", data.formCol);
				arg.setAttribute("subFormTable", data.subFormTable);
				arg.setAttribute("subFormCol", data.subFormCol);
				arg.setAttribute("colType", data.colType);
				arg.setAttribute("tableModify", data.tableModify);
				arg.setAttribute("colComments",data.colComments);
				arg.setAttribute("isOrgIdentity",data.isOrgIdentity);
				arg.setAttribute("fromComments",data.fromComments);
				node.appendChild(arg);
			}
		}
	}
};
MySubprocess.prototype.getFormInDom = function(node) {
	var _self = this;
	var dataArr = [];
	$(node).children("form-in").each(function(){
		var _selfNode = this;
		var dataObj = {};
		dataObj.formTable = $.trim(_selfNode.getAttribute("formTable"));
		dataObj.formCol = $.trim(_selfNode.getAttribute("formCol"));
		dataObj.subFormTable = $.trim(_selfNode.getAttribute("subFormTable"));
		dataObj.subFormCol = $.trim(_selfNode.getAttribute("subFormCol"));
		dataObj.colType = $.trim(_selfNode.getAttribute("colType"));
		dataObj.tableModify = $.trim(_selfNode.getAttribute("tableModify"));
		dataObj.colComments = $.trim(_selfNode.getAttribute("colComments"));
		dataObj.isOrgIdentity = $.trim(_selfNode.getAttribute("isOrgIdentity"));
		dataObj.fromComments = $.trim(_selfNode.getAttribute("fromComments"));
		dataObj.isSubTable = $.trim(_selfNode.getAttribute("isSubTable"));
		dataObj.fromFkColName = $.trim(_selfNode.getAttribute("fromFkColName"));
		dataObj.toFkColName = $.trim(_selfNode.getAttribute("toFkColName"));
		dataArr.push(dataObj);
	}) ;
	var formInDataStr = JSON.stringify(dataArr);
	$("#"+_self.id+" #fieldArgsMainProcessToSub").val(formInDataStr);
	
};
MySubprocess.prototype.getFormOutDom = function(node) {
	var _self = this;
	var dataArr = [];
	$(node).children("form-out").each(function(){
		var _selfNode = this;
		var dataObj = {};
		dataObj.formTable = $.trim(_selfNode.getAttribute("formTable"));
		dataObj.formCol = $.trim(_selfNode.getAttribute("formCol"));
		dataObj.subFormTable = $.trim(_selfNode.getAttribute("subFormTable"));
		dataObj.subFormCol = $.trim(_selfNode.getAttribute("subFormCol"));
		dataObj.colType = $.trim(_selfNode.getAttribute("colType"));
		dataObj.tableModify = $.trim(_selfNode.getAttribute("tableModify"));
		dataObj.colComments = $.trim(_selfNode.getAttribute("colComments"));
		dataObj.isOrgIdentity = $.trim(_selfNode.getAttribute("isOrgIdentity"));
		dataObj.fromComments = $.trim(_selfNode.getAttribute("fromComments"));
		dataArr.push(dataObj);
	}) ;
	var formOutDataStr = JSON.stringify(dataArr);
	$("#"+_self.id+" #fieldArgsSubProcessToMain").val(formOutDataStr);
	
};
MySubprocess.prototype.doubleClickCell = function(){
	var subFlowId = $("#"+this.id+" #inputValueSubFlowId").val();
	var subFlowName = $("#"+this.id+" #inputTextSubFlowName").val();
	if(flowUtils.notNull(subFlowId)){
		layer.open({
			type : 2,
			title: subFlowName,
			area : [ "800px", "500px" ],
			content : "platform/bpm/bpmPublishAction/getProcessImageTrack.gif?processInstanceId=" + subFlowId
		});
	}
};;
///<jscompress sourcefile="MySwimlane.js" />
/**
 * swimlane extends MyBase
 */
function MySwimlane(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "swimlane");
	this.swimlaneType = "";
};
MySwimlane.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MySwimlane.prototype.init = function() {
	if(this.designerEditor.isSwimlane1(this.getCell())){
		this.swimlaneType = "swimlane1";
		this.designerEditor.swimlane1 ++;
	}else{
		this.swimlaneType = "swimlane2";
		this.designerEditor.swimlane2 ++;
	}
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getSwimlane();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MySwimlane.prototype.initLoad = function(xmlValue, rootXml) {
	if(this.designerEditor.isSwimlane1(xmlValue)){
		this.swimlaneType = "swimlane1";
		this.designerEditor.swimlane1 ++;
	}else{
		this.swimlaneType = "swimlane2";
		this.designerEditor.swimlane2 ++;
	}
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setSwimlane(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MySwimlane.prototype.getOtherAttr = function(node) {
	node.setAttribute("cellType", this.swimlaneType);
};
/**
 * 销毁dom对象
 */
MySwimlane.prototype.remove = function() {
	if(this.swimlaneType == "swimlane1"){
		this.designerEditor.swimlane1 --;
	}else if(this.swimlaneType = "swimlane2"){
		this.designerEditor.swimlane2 --;
	}
	$("#" + this.id).remove();
};;
///<jscompress sourcefile="MyTask.js" />
/**
 * task extends MyBase
 */
function MyTask(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "task");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_human.png;";
}
MyTask.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyTask.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getTask();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	this.initEvent(); //
	// 初始化文档上传对象
	this.bpmDocUploader = new BpmDocUploader({id:this.id,defineId:this.defineId,activityName:this.name,uploaderId:"bpm-designer-upload"});
	// 初始化节点事件
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-human-task-event");

	var _self = this;
	// 节点关联表单
	this.selectPublishBpmEform1 = new SelectPublishEform("task_guan_lian_biao_dan", "task_formName", this.id, "Y", "");
	this.selectPublishBpmEform1.init( function(data) {
		$('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type", "task");
		$("#"+_self.id +" input[type='checkbox'][name='formSave']").trigger("click");
 	});
	var process = this.designerEditor.myCellMap.get(this.designerEditor.processKey)
    var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
    var globalformname = $.trim($('#' + process.id).find('#formName').val());
    if(flowUtils.notNull(globalformid)){
    	this.syncTaskForm(globalformid, globalformname);
    }
    //网安需求，拿回默认选中
	$('#' + _self.id).find('input[name="input_liu_cheng_na_hui"]').trigger('click');
};
//临时扩展用
MyTask.prototype.setUserSelectDomText = "";
MyTask.prototype.initTracks = function(xmlValue, rootXml) {
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell

	var candidateId = this.getAttr(xmlValue, "candidate-users");
	if (candidateId.length > 0) {
		var actors = this.getUserSelectObjFromXml(candidateId, xmlValue);
		this.setUserSelectDomText = this.getUserSelectTextFieldValue(actors);
	}

	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyTask.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setTask(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	this.initEvent(); //
	// 初始化文档上传对象
	this.bpmDocUploader = new BpmDocUploader({id:this.id,defineId:this.defineId,activityName:this.name,uploaderId:"bpm-designer-upload"});
	var _self =this;
	// 节点关联表单
	this.selectPublishBpmEform1 = new SelectPublishEform("task_guan_lian_biao_dan", "task_formName", _self.id, "Y", "");
	this.selectPublishBpmEform1.init( function(data) {
		$('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type", "task");
	//	$("#"+_self.id +" input[type='checkbox'][name='formSave']").trigger("click");
 	});
	this.SelectNonEform = new SelectPublishEform("task_wai_bu_url_form", "task_wai_bu_url", _self.id, "Y", "");
	this.SelectNonEform.init( function(data) {
		// $('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type", "task");
		// $("#"+_self.id +" input[type='checkbox'][name='formSave']").trigger("click");

 	});

	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	// 人工节点 tab1 基本信息开始
	//待办标题
	this.setDomValByMeta("dai_ban_biao_ti", xmlValue, "todo");
	this.setDomValByMeta("formName_biaoTi", xmlValue, "todo");
	// 移动审批属性
	this.setDomCheckByMeta("task_yi_dong_shen_pi", xmlValue, "taskMobileApproval", "no");
	// 短信通知
	this.setDomCheckByMeta("duan_xin_tong_zhi", xmlValue, "phoneInfo", "no");
	// 工作移交
	this.setDomCheckByMeta("gong_zuo_yi_jiao", xmlValue, "isWorkHandUser", "yes");
	// 密级控制
	this.setDomCheckByMeta("mi_ji_kong_zhi", xmlValue, "isSecret", "no");
	if($("#" + this.id).find("#mi_ji_kong_zhi").is(":checked")){
		$("#"+this.id).find("div[name='mi_ji_bian_liang_show']").removeClass("hidden");
		this.setDomValByMeta("mi_ji_bian_liang", xmlValue, "secretVar");
	}


    // 读者需发待阅
    this.setDomCheckByMeta("input_isSendReaderTodo", xmlValue, "isSendReaderTodo", "no");


	// 备注信息
	this.createRemarkDom(xmlValue);

    //附件下载配置
    var down_yes = this.getMeta(xmlValue, "down_yes");
    if(down_yes == "no"){
        $("#" + this.id).find("#down_yes").prop("checked", false);
	}
    this.setDomCheckByMeta("down_yes_secret", xmlValue, "down_yes_secret", "no");
    $("#" + this.id).find(".down_yes_class input").each(function(i, n){
        _self.setDomCheckByMeta($(n).attr("id"), xmlValue, $(n).attr("id"), "yes");
    });
    if($("#" + this.id).find("#down_yes_secret").is(":checked")){
        $("#" + this.id).find(".down_yes_class").show();
        $("#" + this.id).find('input[class^=down_yes_secret_class_]').each(function(i, n){
        	var secretLevel = $(this).attr("secretLevel");
        	if(this.checked){
        		$(this).parents("form").find(".down_yes_userSecret_class_"+secretLevel).show();
            }else{
            	$('input[id^=down_yes_secret_'+secretLevel+'_]').removeAttr("checked");
            	$(this).parents("form").find(".down_yes_userSecret_class_"+secretLevel).hide();
            }
        });

	}

	// 意见
	var metaValue = this.getMeta(xmlValue, "ideaType");
	$("#" + this.id).find("#task_bi_xu_tian_xie_yi_jian").prop("checked", metaValue == undefined ? false
			: (metaValue =="must" ? true :false) );
	this.setDomValByMeta("zi_ding_yi_yi_jian_kuang", xmlValue, "ideaElementIdBySelf");
	// 强制表态
	this.setDomCheckByMeta("task_yun_xu_qiang_zhi_biao_tai", xmlValue, "ideaCompelManner", "no");
	// 必须退回
	this.setDomCheckByMeta("tast_tui_hui_yi_jian", xmlValue, "isNeedIdea", "yes");

	this.setDomCheckByMeta("wen_zi_gen_zong", xmlValue, "showTrackInForm", "yes");
	// 意见显示方式
	var xianshiValue = this.getMeta(xmlValue, "ideaDisplayStyle");
	$("#" + this.id).find("input[name='task-yi-jian-xian-shi'][value='"+xianshiValue+"']").prop("checked","checked");

	// 人工节点 tab1 基本信息结束


	// 人工节点-参与者-候选人
	this.setUserSelectDom({userSelectContainer :'draft-candidate-container' ,dataField:'draft-candidate-data-field',textField:'draft-candidate-text-field'}, xmlValue);
	//成飞自定义选人 后台获取部门接口地址
	this.setDomValByMeta("zu_zhi_jie_kou", xmlValue, "deptImpl");
	// 自动选人
	// 兼容旧数据处理
	// 如果都选中或者都没选中，则默认选中自动选人
	this.setDomCheckByMeta("candidate-auto-polling", xmlValue, "isAutoGetUser", "yes");
	//组织机构树展开到部门
	this.setDomCheckByMeta("orgTreeOpenToDept", xmlValue, "orgTreeOpenToDept", "no");
	//组织机构树默认展开
	this.setDomCheckByMeta("orgTreeDefaultOpen", xmlValue, "orgTreeDefaultOpen", "no");
	//部门树隐藏组织层级
	this.setDomCheckByMeta("deptTreeHideOrg", xmlValue, "deptTreeHideOrg", "no");
	 // 显示选人框
	this.setDomCheckByMeta("show-selection-box", xmlValue, "isSelectUser", "no");

	this.setDomCheckByMeta("candidate-necessary", xmlValue, "isMustUser", "no"); // 必须选人
	// 选人方式：自动或手动
	$("#" + this.id).find("#person-automatic-selection").prop("checked",this.getMeta(xmlValue, "userSelectType") == "auto"? true : false);

	// 人工节点-参与者-处理方式
	var dealtype = this.getAttr(xmlValue, "dealtype");
	$("#" + this.id).find("select[name='select-human-task-process-mode']").val(dealtype);
	$("#" + this.id).find("select[name='select-human-task-process-mode']").trigger('change');
	if(dealtype == "4"){
		//this.setDomCheckByMeta("input-user-multiple-choose", xmlValue, "single", "yes");
		$(xmlValue).children("meta[name='number']").each(function(){
			$("#" + _self.id).find("input[type=radio][name=input-radio-human-task-select-task]").eq(1).trigger('click');
			$("#" + _self.id).find("input[name=input-num]").eq(1).val($.trim($(this).text()));
		});
		$(xmlValue).children("meta[name='percent']").each(function(){
			$("#" + _self.id).find("input[type=radio][name=input-radio-human-task-select-task]").eq(2).trigger('click');
			$("#" + _self.id).find("input[name=input-num]").eq(2).val($.trim($(this).text()));
		});
        $(xmlValue).children("meta[name='role_number']").each(function(){
            $("#" + _self.id).find("input[type=radio][name=input-radio-human-task-select-task]").eq(3).trigger('click');
            $("#" + _self.id).find("input[name=input-num]").eq(3).val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='position_number']").each(function(){
            $("#" + _self.id).find("input[type=radio][name=input-radio-human-task-select-task]").eq(4).trigger('click');
            $("#" + _self.id).find("input[name=input-num]").eq(4).val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='group_number']").each(function(){
            $("#" + _self.id).find("input[type=radio][name=input-radio-human-task-select-task]").eq(5).trigger('click');
            $("#" + _self.id).find("input[name=input-num]").eq(5).val($.trim($(this).text()));
        });

		$(xmlValue).children("meta[name='dept_one']").each(function(){
			$("#" + _self.id).find("input[type=radio][name=input-radio-human-task-select-task]").eq(6).trigger('click');
		});

        $(xmlValue).children("meta[name='dealtype_4_roleId']").each(function(){
            $("#" + _self.id).find("#dealtype_4_roleId").val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='dealtype_4_roleName']").each(function(){
            $("#" + _self.id).find("#dealtype_4_roleName").val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='dealtype_4_positionId']").each(function(){
            $("#" + _self.id).find("#dealtype_4_positionId").val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='dealtype_4_positionName']").each(function(){
            $("#" + _self.id).find("#dealtype_4_positionName").val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='dealtype_4_groupId']").each(function(){
            $("#" + _self.id).find("#dealtype_4_groupId").val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='dealtype_4_groupName']").each(function(){
            $("#" + _self.id).find("#dealtype_4_groupName").val($.trim($(this).text()));
        });
	}


    // 先判断节点表单是否存在，如果存在则显示节点表单，如果不存在，则从全局表单中取值并将data-type配置成global，如果全局表单也不存在，那就这样吧
    // 如果选择了节点表单，将data-type配置成task
    // 如果修改全局表单，根据data-type值判断是否更新人工节点的表单
    // 如果勾选了“可编辑”，则将该节点的data-type配置成task
    var taskFormId = $.trim(xmlValue.getAttribute("taskFormId"));
    var taskFormName = $.trim(xmlValue.getAttribute("taskFormName"));
    var urlParam = $.trim(xmlValue.getAttribute("urlParam"));
    if(flowUtils.notNull(urlParam)){
		$('#' + this.id).find('#urlParam').val(urlParam);
	}
    if(flowUtils.notNull(taskFormId)) {
        $('#' + this.id).find('#task_guan_lian_biao_dan').val(taskFormId);
        $('#' + this.id).find('#task_guan_lian_biao_dan').attr("data-type", "task");
        $('#' + this.id).find('#task_formName').val(taskFormName);
    } else {
        var process = this.designerEditor.myCellMap.get(this.designerEditor.processKey)
        var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
        var globalformname = $.trim($('#' + process.id).find('#formName').val());
        this.syncTaskForm(globalformid, globalformname);
    }
	// 保存表单
	$(xmlValue).children("docRights").children("docRight[type='formSave']").each(function() {
	    // 如果勾选了可编辑，则需要将xml中的权限字段输出到前端，并根据内容决定是否选中
		var $formSave = $("#" + _self.id).find("input[name='formSave']");
        $formSave.prop("checked", true)
		$("#" + _self.id).find(".basic-form-save-area").removeClass("hidden");
		// 如果勾选了保存保单，则将节点置data-type为task
		$('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type", "task");
		// 同步属性权限
		if($(xmlValue).children("attrsAuth").length>0){
			$(xmlValue).children("attrsAuth").children().each(function() {
				var isModified = $.trim($(this).text()) == "yes" ? true:false;
				var accessibility = true;
				var required = false;
				 $("#" + _self.id).find("table[name='table-attr-auth'] tbody").append(_self.syncFormAttrTr(this.nodeName,_self.getAttr(this,"attrName"),isModified,accessibility,_self.getAttr(this,"elementType"),required));
			});
		}else{
			$(xmlValue).children("fieldsAuth").children().each(function() {
				var id = _self.getAttr(this,"id");
				var name = _self.getAttr(this,"name");
				var isModified = _self.getAttr(this,"isModified")=="yes"?true:false;
				var accessibility = _self.getAttr(this,"accessibility")=="yes"?true:false;
				var required = _self.getAttr(this,"required")=="yes"?true:false;
				var type = _self.getAttr(this,"type");
				if(type=='eform_subtable_bpm_button_auth'){
					$("#" + _self.id).find("table[name='table-attr-auth'] tbody").append(_self.syncSubFormButtonAttrTr(id,name,isModified,accessibility,type,required));
				}else{
					$("#" + _self.id).find("table[name='table-attr-auth'] tbody").append(_self.syncFormAttrTr(id,name,isModified,accessibility,type,required));
				}
			});
		}

		//同步附件权限
		$(xmlValue).children("attachmentAuth").children().each(function() {
			var id = _self.getAttr(this,"id");
			var name = _self.getAttr(this,"name");
			var isModified = _self.getAttr(this,"isModified")=="yes"?true:false;
			var required = _self.getAttr(this,"required")=="yes"?true:false;
			var type = _self.getAttr(this,"type");
			var modifySecretLevel = _self.getAttr(this,"modifySecretLevel")=="yes"?true:false;
			 $("#" + _self.id).find("table[name='table-attachment-auth'] tbody").append(_self.syncFormAttachmentAttrTr(id,name,isModified,type,required,modifySecretLevel));
		});
		//字段关联权限
		$(xmlValue).children("fieldsRelationAuth").each(function() {
			var fieldsRelationAuth = $(this).text();
			if(flowUtils.notNull(fieldsRelationAuth)){
				_self.getFieldRelationAuthFromXml(fieldsRelationAuth);
			}
		});
	});
	// 正文权限 这部分代码需要排除可编辑按钮
    $(xmlValue).children("docRights").children("docRight").each(function(){
        var docThis = this;
        var domId = $(docThis).attr("type");
        if(domId != 'formSave' && domId != 'attachCreate') {
            $("#" + _self.id).find("input[name='" + domId+"']").trigger("click");
            $(docThis).children("subDocRight").each(function(){
                var subDomId = $(this).attr("type");
                var subValue = $(this).attr("value");
                if(domId == "wordRead" || domId == "wordEdit") {
                    // 如果子节点是checkbox,则根据值勾选相应的内容
                    $("#" + _self.id).find("input[type='checkbox'][name='"+subDomId+"']").prop("checked", true);
                } else if (domId == "wordRedTemplet" || domId ==  "wordCreate") {
                    // 正文模板、套红模板回写
                    var show = $(this).attr("name");
                    var data = $(this).attr("value");
                    var dataInput = $("#" + _self.id).find("input[name='"+(domId ==  "wordCreate"?"taskFormValueWordCreate":"taskFormValueWordRedTemplet")+"']");
                    var textInput = $("#" + _self.id).find("input[name='"+(domId ==  "wordCreate"?"taskFormTextWordCreate":"taskFormTextWordRedTemplet")+"']");
                    dataInput.val(data);
                    textInput.val(show);
                    textInput.attr("title",show);
                } else if(domId == "wordPrint"){
                    var ownerId = subValue;
                    if(flowUtils.notNull(ownerId)){
                        var dataArea = $("#" + _self.id).find("input[name='taskFormValue"+subDomId+"']");
                        var textArea = $("#" + _self.id).find("input[name='taskFormText"+subDomId+"']");
                        dataArea.attr("actorsId", ownerId);
                        var actors = _self.getUserSelectObjFromXml(ownerId, xmlValue);
                        dataArea.val(JSON.stringify(actors));
                        var actorsText = _self.getUserSelectTextFieldValue(actors);
                        textArea.val(actorsText);
                        textArea.attr("title", actorsText);
                    }
                } else if(domId == "wordValue"){
                    // 域值同步回写
                    var show = $(this).attr("name");
                    var data = $(this).attr("value");
                    if(data) {
                        var dataInput = $("#" + _self.id).find("input[name='taskFormValueWordValue']");
                        var textInput = $("#" + _self.id).find("input[name='taskFormTextWordValue']");
                        dataInput.val(data);
                        textInput.val(show);
                        textInput.attr("title",show);
                    }
                } else {
                }
            });
        }
    });

	// 人工节点-权限回写
	this.createQXDom(xmlValue, "input_tui_hui_ni_gao_ren", "reTreatToDraft");
	this.createQXDom(xmlValue, "input_tui_hui_shang_yi_bu", "reTreatToPrev");
	this.createQXDom(xmlValue, "input_ren_yi_tui_hui", "reTreatToWant");
	this.createQXDom(xmlValue, "input_kua_jie_dian_tui_hui", "reTreatToActivity");
	this.createQXDom(xmlValue, "input_liu_cheng_na_hui", "withdraw");
	this.createQXDom(xmlValue, "input_liu_cheng_bu_fa", "supplement");

	this.createQXDom(xmlValue, "input_fa_song_yue_zhi", "transmit");
	this.createQXDom(xmlValue, "input_chao_song", "carbonCopy");

	this.createQXDom(xmlValue, "input_liu_cheng_wei_tuo", "supersede");
    this.setDomCheckByMeta("input_liu_cheng_wei_tuo_multi", xmlValue, "supersede_multi", "yes");
	this.createQXDom(xmlValue, "input_liu_cheng_jia_qian", "addUser");

	//this.createQXDom(xmlValue, "liu_cheng_zeng_fa_submit", "addUserAndSubmit");
	this.createQXDom(xmlValue, "input_liu_cheng_jian_qian", "withdrawAssignee");
	this.createQXDom(xmlValue, "input_pei_zhi_xuan_ren", "stepUserDefined");

	this.createQXDom(xmlValue, "input_zengjiaduzhe", "taskreader");
	this.createQXDom(xmlValue, "input_morenduzhe", "defaultreader");

	this.createQXDom(xmlValue, "input_faqiziliucheng", "startsubprocess");

	$("#"+_self.id).find("input[_type='bpm_but_attribute']").each(function (i, n) {
		_self.createQXDom(xmlValue, $(n).attr("name"), $(n).attr("name"));
	});

	// 人工节点-回写事件
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-human-task-event");
	this.nodeEvent.setEventDom(xmlValue);

	/**
	 * 催办信息
	 */
	//手动催办
	this.setDomCheckByMeta("task_cuiban_sd", xmlValue, "handHastenTask", "no");
	//自动催办
	this.setDomCheckByMeta("task_cuiban_zd", xmlValue, "autoHastenTask", "no");

	var handHastenTask = this.getMeta(xmlValue, "handHastenTask");

	var autoHastenTask = this.getMeta(xmlValue, "autoHastenTask");

	if(handHastenTask=='yes' || autoHastenTask=='yes'){

		this.showOrHiddenCuiban(true, true);
		//提醒方式-待阅
		this.setDomCheckByMeta("task_cuiban_txfs_dy", xmlValue, "toReadRemind", "no");
		//提醒方式-系统消息
		this.setDomCheckByMeta("task_cuiban_txfs_xt", xmlValue, "sysMessageRemind", "no");
		//提醒方式-邮件
		this.setDomCheckByMeta("task_cuiban_txfs_yj", xmlValue, "mailRemind", "no");
		//提醒方式-短信
		this.setDomCheckByMeta("task_cuiban_txfs_dx", xmlValue, "smsRemind", "no");
		//提醒方式-自定义
		this.setDomCheckByMeta("task_cuiban_txfs_zdy", xmlValue, "zdyRemind", "no");
		//催办实现类
		this.setDomValByMeta("task_cuiban_sxl", xmlValue, "hastenTaskClass");
	}

	if(autoHastenTask=='yes'){
		this.showOrHiddenCuiban(true, false);
		//办理期限
		this.setDomValByMeta("task_cuiban_blqx", xmlValue, "timeLimit");
		//最大催办次数
		this.setDomValByMeta("task_cuiban_cbcs", xmlValue, "maxHastenTimes");
		//警告时限
		this.setDomValByMeta("task_cuiban_jgsx", xmlValue, "warningTimeLimit");
		//催办频率
		this.setDomValByMeta("task_cuiban_cbpl", xmlValue, "hastenFrequency");
	}

	/**kpi设置*/
	this.setDomValByMeta("kpi_task_reasonable_day", xmlValue, "kpiTaskReasonableDay");
	this.setDomValByMeta("kpi_task_reasonable_hour", xmlValue, "kpiTaskReasonableHour");
	this.setDomValByMeta("kpi_task_reasonable_minute", xmlValue, "kpiTaskReasonableMinute");
	this.setDomValByMeta("kpi_task_warning_day", xmlValue, "kpiTaskWarningDay");
	this.setDomValByMeta("kpi_task_warning_hour", xmlValue, "kpiTaskWarningHour");
	this.setDomValByMeta("kpi_task_warning_minute", xmlValue, "kpiTaskWarningMinute");

	/**子流程*/
	this.getSubFromDom(xmlValue);

	var event_auto_start = this.getMeta(xmlValue, "event_auto_start");
	if(event_auto_start == "yes"){
		$("#" + this.id).find("#event_auto_start").trigger('click');
		this.setDomValByMeta("event_auto_start_defaultFlow_text", xmlValue, "event_auto_start_defaultFlow_text");
		this.setDomValByMeta("event_auto_start_defaultFlow_id", xmlValue, "event_auto_start_defaultFlow_id");
		this.setDomValByMeta("event_auto_start_defaultFlow_id2", xmlValue, "event_auto_start_defaultFlow_id2");
		this.setDomValByMeta("event_auto_start_table_text", xmlValue, "event_auto_start_table_text");
		this.setDomValByMeta("event_auto_start_table_id", xmlValue, "event_auto_start_table_id");
		this.setDomValByMeta("event_auto_start_table_name", xmlValue, "event_auto_start_table_name");
		this.setDomValByMeta("event_auto_start_fk_text", xmlValue, "event_auto_start_fk_text");
		this.setDomValByMeta("event_auto_start_fk_id", xmlValue, "event_auto_start_fk_id");
		this.setDomValByMeta("event_auto_start_user_text", xmlValue, "event_auto_start_user_text");
		this.setDomValByMeta("event_auto_start_user_id", xmlValue, "event_auto_start_user_id");
		this.setDomValByMeta("event_auto_start_flow_text", xmlValue, "event_auto_start_flow_text");
		this.setDomValByMeta("event_auto_start_flow_id", xmlValue, "event_auto_start_flow_id");
	}

	this.setDomCheckByMeta("event_auto_deleteSubProcess", xmlValue, "event_auto_deleteSubProcess");

	var task_zi_ding_yi_jian = this.getMeta(xmlValue, "task_zi_ding_yi_jian");
	if(task_zi_ding_yi_jian == "yes") {
		$("#" + this.id).find("#task_zi_ding_yi_jian").trigger('click');
		var $table = $("#" + this.id).find("#table_task_zi_ding_yi_jian tbody");
		$(xmlValue).children("ideasBySelf").children().each(function(i, n) {
			var content = $(this).text();
			var outcome = $(this).attr("outcome");
			var outcome_name = $(this).attr("outcome_name");
			addZiDingYiJiangTr($table, content, outcome, outcome_name)
		});
	}

	/**
	 * 流程数据同步
	 */
	if(flowUtils.notNull(_processDataSynJs)){
		this.getDataSynFromXml(xmlValue);
	}

	/**
	 * 表单字段关联控制
	 */
};
/**
 * 组装processXML的自定义信息
 *
 * @param node
 */
MyTask.prototype.getOtherAttr = function(node) {
	var _self = this;
	// 人工节点 tab1 基本信息开始
	//待办标题
	this.setXmlMetaByVal("dai_ban_biao_ti", node, "todo");
		// 移动审批属性
	this.setXmlMetaByCheck("task_yi_dong_shen_pi", node, "taskMobileApproval");
	// 短信通知
	this.setXmlMetaByCheck("duan_xin_tong_zhi", node, "phoneInfo");
	// 工作移交
	this.setXmlMetaByCheck("gong_zuo_yi_jiao", node, "isWorkHandUser");
	// 密级控制
	this.setXmlMetaByCheck("mi_ji_kong_zhi", node, "isSecret");
	this.addMeta("secretVar", "<![CDATA[" + $("#"+this.id).find("input[name='mi_ji_bian_liang']").val() + "]]>", node);

    // 读者需发待阅
    this.setXmlMetaByCheck("input_isSendReaderTodo", node, "isSendReaderTodo");

	// 备注信息
	this.createRemarkXml(node);

	//附件下载配置
    this.setXmlMetaByCheck("down_yes", node, "down_yes");
    this.setXmlMetaByCheck("down_yes_secret", node, "down_yes_secret");
    $("#" + this.id).find(".down_yes_class input:checked").each(function(i, n){
        _self.setXmlMetaByCheck($(n).attr("id"), node, $(n).attr("id"));
	});


	// 意见
	var content = $("#" + this.id).find("input[name='task_bi_xu_tian_xie_yi_jian']").is(":checked") ?
			"must" : "can";
	this.addMeta("ideaType", "<![CDATA[" + content + "]]>", node);
    this.setXmlMetaByVal("zi_ding_yi_yi_jian_kuang", node, "ideaElementIdBySelf");
	// 强制表态
	this.setXmlMetaByCheck("task_yun_xu_qiang_zhi_biao_tai", node, "ideaCompelManner");
	// 必须退回
	this.setXmlMetaByCheck("tast_tui_hui_yi_jian", node, "isNeedIdea");

	this.setXmlMetaByCheck("wen_zi_gen_zong", node, "showTrackInForm");
	// 意见显示方式
	var content = $("#" + this.id).find("input[type='radio'][name='task-yi-jian-xian-shi']:checked");
	this.addMeta("ideaDisplayStyle", content.val(), node);

	// 人工节点 tab1 基本信息结束

	// 人工节点-参与者-处理人
	// 选人
	this.setUserSelectXml({userSelectContainer :'draft-candidate-container' ,dataField:'draft-candidate-data-field',textField:'draft-candidate-text-field'}, node);
	//成飞自定义选人 后台获取部门接口
	this.setXmlMetaByVal("zu_zhi_jie_kou", node, "deptImpl");
	// 自动获取用户
	this.setXmlMetaByCheck("candidate-auto-polling", node, "isAutoGetUser");

	//组织机构树展开到部门
	this.setXmlMetaByCheck("orgTreeOpenToDept", node, "orgTreeOpenToDept");
	//组织机构树默认展开
	this.setXmlMetaByCheck("orgTreeDefaultOpen", node, "orgTreeDefaultOpen");
	//部门树隐藏组织层级
	this.setXmlMetaByCheck("deptTreeHideOrg", node, "deptTreeHideOrg");

	// 选人方式：自动或手动
	this.addMeta("userSelectType", $("#" + this.id).find("input[name='person-automatic-selection']").is(":checked") ? "auto":"manual", node);
	// 显示选人框
	this.setXmlMetaByCheck("show-selection-box", node, "isSelectUser");
	// 必须选人
	this.setXmlMetaByCheck("candidate-necessary", node, "isMustUser");

	// 人工节点-参与者-处理方式
	var dealtype = $("#" + this.id).find("select[name='select-human-task-process-mode']").val();
	this.putAttr("dealtype", dealtype, node);
	if(dealtype == "4"){
		// 完成个数或者百分率
		var t = $("#" + this.id).find("input[type='radio'][name='input-radio-human-task-select-task']:checked");
		// 设置完成个数或完成百分率
		var $base = t.parents(".multiple-task");
		if (t != undefined && t.val() != 'none' && t.val() != 'dept_one') {
			var index = t.parent().parent().index();
			this.addMeta(t.val() , $base.find("input[name=input-num]").eq(index).val(), node);
			if(t.val() == "role_number"){
                this.addMeta("dealtype_4_roleId" , $base.find("#dealtype_4_roleId").val(), node);
                this.addMeta("dealtype_4_roleName" , $base.find("#dealtype_4_roleName").val(), node);
			}else if(t.val() == "position_number"){
                this.addMeta("dealtype_4_positionId" , $base.find("#dealtype_4_positionId").val(), node);
                this.addMeta("dealtype_4_positionName" , $base.find("#dealtype_4_positionName").val(), node);
			}else if(t.val() == "group_number"){
                this.addMeta("dealtype_4_groupId" , $base.find("#dealtype_4_groupId").val(), node);
                this.addMeta("dealtype_4_groupName" , $base.find("#dealtype_4_groupName").val(), node);
            }
		}else if(t != undefined && t.val() == 'dept_one'){
			this.addMeta("dept_one" , "true", node);
		}
		//this.setXmlMetaByCheck("input-user-multiple-choose", node, "single");
	}

	// 人工节点 - 表单
	// 如果用户选择了节点表单，那么就将数据保存到xml
	// 正文权限不受可编辑属性的控制
	var formChoose = $("#" + this.id).find("input[name='input-radio-platform-form']:checked").val();
	if(formChoose == "form") { // 用户选择了内部表单
		var urlParam = $('#' + this.id).find('#urlParam').val();
		if(flowUtils.notNull(urlParam)){
			this.putAttr("urlParam", urlParam, node);
		}
		var dataType = $("#" + this.id).find("input[name='task_guan_lian_biao_dan']").attr("data-type");
		var taskFormId = null;
		var taskFormName = null;
		if ((flowUtils.notNull(dataType) && dataType !== "global") || flowUtils.notNull(urlParam)) {
			// 节点表单
			if(flowUtils.notNull(dataType) && dataType !== "global"){
				taskFormId = $('#' + this.id).find('#task_guan_lian_biao_dan').val();
				taskFormName = $('#' + this.id).find('#task_formName').val();
			}else{
				var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
				taskFormId = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
				taskFormName = $.trim($('#' + process.id).find('#formName').val());
			}
			this.putAttr("taskFormId", taskFormId, node);
			this.putAttr("taskFormName",taskFormName, node);

			if($("#" + this.id).find("input[name='formSave']").is(':checked')) {

				// 获取属性编辑权限
			/*	<attrsAuth formId="xxxxxx">
					<xxx attrAuth=xxx elementType=xxxx>yes</xxx>
					<xxx>yes</xxx>
					<xxx>no</xxx>
				</attrsAuth>*/
				/**
				if(taskFormId != null) { // 表示用户手动选择了表单
					var attrsAuth = flowUtils.createElement("attrsAuth");
					// this.putAttr("formId", taskFormId, attrsAuth);
					$("#" + _self.id).find("table[name='table-attr-auth']").find("tbody > tr").each(function(){
						var tag = $(this).find("input[name='tag']").val();
						var tagName = $(this).find("input[name='tagName']").val();
						var isModified = $(this).find("input[name='isModified']").is(":checked");
						var attr = flowUtils.createElement(tag);
                        var elementType = $(this).find("input[name='elementType']").val();
						_self.putAttr("attrName", tagName, attr);
                        _self.putAttr("elementType", elementType, attr);
						attr.appendChild(flowUtils.createTextNode(isModified?"yes":"no"));
						attrsAuth.appendChild(attr);
					});
					node.appendChild(attrsAuth);
				}*/

				if(taskFormId != null) { // 表示用户手动选择了表单
					var fieldsAuth = flowUtils.createElement("fieldsAuth");
					// this.putAttr("formId", taskFormId, attrsAuth);
					$("#" + _self.id).find("table[name='table-attr-auth']").find("tbody > tr").each(function(){
						var tag = $(this).find("input[name='tag']").val();
						var tagName = $(this).find("input[name='tagName']").val();
						var isModified = $(this).find("input[name='isModified']").is(":checked");
						var accessibility = $(this).find("input[name='accessibility']").is(":checked");
						var required = $(this).find("input[name='required']").is(":checked");
						var type = $(this).find("input[name='elementType']").val();
						var field = flowUtils.createElement("field");
						field.setAttribute("id",tag);
						field.setAttribute("name",tagName);
						field.setAttribute("isModified",isModified?"yes":"no");
						field.setAttribute("accessibility",accessibility?"yes":"no");
						field.setAttribute("required",required?"yes":"no");
						field.setAttribute("type",type);
						fieldsAuth.appendChild(field);
					});
					node.appendChild(fieldsAuth);

					//附件权限
					var attachmentAuth = flowUtils.createElement("attachmentAuth");
					$("#" + _self.id).find("table[name='table-attachment-auth']").find("tbody > tr").each(function(){
						var tag = $(this).find("input[name='tag']").val();
						var tagName = $(this).find("input[name='tagName']").val();
						var isModified = $(this).find("input[name='isModified']").is(":checked");
						var required = $(this).find("input[name='required']").is(":checked");
						var type = $(this).find("input[name='elementType']").val();
						var modifySecretLevel = $(this).find("input[name='modifySecretLevel']").is(":checked");
						var attachment = flowUtils.createElement("attachment");
						attachment.setAttribute("id",tag);
						attachment.setAttribute("name",tagName);
						attachment.setAttribute("isModified",isModified?"yes":"no");
						attachment.setAttribute("required",required?"yes":"no");
						attachment.setAttribute("type",type);
						attachment.setAttribute("modifySecretLevel",modifySecretLevel?"yes":"no");
						attachmentAuth.appendChild(attachment);
					});
					node.appendChild(attachmentAuth);
					/**
					 * 字段关联权限
					 */
					var fieldRelationControlConfigValue = $("#" + _self.id+" #fieldRelationControlConfigValue").val();
					if(flowUtils.notNull(fieldRelationControlConfigValue)){
						var fieldsRelationAuth = flowUtils.createElement("fieldsRelationAuth");
						fieldsRelationAuth.appendChild(flowUtils.createTextNode("<![CDATA[" + fieldRelationControlConfigValue + "]]>"));
						node.appendChild(fieldsRelationAuth);
					}

				}
			}
		}

        //文档权限
        var docRights = flowUtils.createElement("docRights");
        _self.createFormSaveXml("formSave","保存表单", docRights);
        _self.createFormSaveXml("attachCreate","增删附件", docRights);
		/*_self.createFormSaveXml("attachShowByNode","按节点过滤", docRights);*/
        if(docRights.childNodes.length > 0){
            node.appendChild(docRights);
        }
	} else {

	}



	// 人工节点 - 权限
	var magicsNode = flowUtils.createElement("magics");
	this.createQXXml(magicsNode, "input_tui_hui_ni_gao_ren", "reTreatToDraft", "退回拟稿人", node);
	this.createQXXml(magicsNode, "input_tui_hui_shang_yi_bu", "reTreatToPrev", "退回上一步", node);
	this.createQXXml(magicsNode, "input_ren_yi_tui_hui", "reTreatToWant", "任意退回", node);
	this.createQXXml(magicsNode, "input_kua_jie_dian_tui_hui", "reTreatToActivity", "跨节点退回", node);
	this.createQXXml(magicsNode, "input_liu_cheng_na_hui", "withdraw", "拿回", node);
	this.createQXXml(magicsNode, "input_liu_cheng_bu_fa", "supplement", "补发", node);
	this.createQXXml(magicsNode, "input_fa_song_yue_zhi", "transmit", "发送阅知", node);
	this.createQXXml(magicsNode, "input_chao_song", "carbonCopy", "抄送", node);
	this.createQXXml(magicsNode, "input_liu_cheng_wei_tuo", "supersede", "流程转办", node);
    this.setXmlMetaByCheck("input_liu_cheng_wei_tuo_multi", node, "supersede_multi");
	this.createQXXml(magicsNode, "input_liu_cheng_jia_qian", "addUser", "加签", node);
	//this.createQXXml(magicsNode, "liu_cheng_zeng_fa_submit", "addUserAndSubmit", "增发并提交", node);
	this.createQXXml(magicsNode, "input_liu_cheng_jian_qian", "withdrawAssignee", "减签", node);
	this.createQXXml(magicsNode, "input_pei_zhi_xuan_ren", "stepUserDefined", "配置选人", node);
	this.createQXXml(magicsNode, "input_zengjiaduzhe", "taskreader", "增加读者", node);
	this.createQXXml(magicsNode, "input_morenduzhe", "defaultreader", "增加读者", node);
	this.createQXXml(magicsNode, "input_faqiziliucheng", "startsubprocess", "发起子流程", node);

	$("#"+_self.id).find("input[_type='bpm_but_attribute']").each(function (i, n) {
		_self.createQXXml(magicsNode, $(n).attr("name"), $(n).attr("name"),  $(n).attr("_name"), node);
	});

	if(magicsNode.childNodes.length > 0){
		node.appendChild(magicsNode);
	}

	// 人工节点 - 获取事件xml
	this.nodeEvent.setEventXml(node, "start");//event


	/**
	 * 催办信息开始
	 */
	//手动催办
	this.setXmlMetaByCheck("task_cuiban_sd", node, "handHastenTask");
	//自动催办
	this.setXmlMetaByCheck("task_cuiban_zd", node, "autoHastenTask");
	if($("#" + this.id).find("input[name='task_cuiban_sd']").is(':checked')
			|| $("#" + this.id).find("input[name='task_cuiban_zd']").is(':checked')){
		//提醒方式-待阅
		this.setXmlMetaByCheck("task_cuiban_txfs_dy", node, "toReadRemind");
		//提醒方式-系统消息
		this.setXmlMetaByCheck("task_cuiban_txfs_xt", node, "sysMessageRemind");
		//提醒方式-邮件
		this.setXmlMetaByCheck("task_cuiban_txfs_yj", node, "mailRemind");
		//提醒方式-短信
		this.setXmlMetaByCheck("task_cuiban_txfs_dx", node, "smsRemind");
		//提醒方式-自定义
		this.setXmlMetaByCheck("task_cuiban_txfs_zdy", node, "zdyRemind");
		//催办实现类
		this.addMeta("hastenTaskClass",$("#" + _self.id).find("#task_cuiban_sxl").val(),node);
	}
	if($("#" + this.id).find("input[name='task_cuiban_zd']").is(':checked')){
		var timeLimit = $("#" + _self.id).find("#task_cuiban_blqx").val();
		var maxHastenTimes = $("#" + _self.id).find("#task_cuiban_cbcs").val();
		var warningTimeLimit = $("#" + _self.id).find("#task_cuiban_jgsx").val();
		var hastenFrequency = $("#" + _self.id).find("#task_cuiban_cbpl").val();
		//办理期限
		this.addMeta("timeLimit",timeLimit,node);
		//最大催办次数
		this.addMeta("maxHastenTimes",maxHastenTimes,node);
		//警告时限
		this.addMeta("warningTimeLimit",warningTimeLimit,node);
		//催办频率
		this.addMeta("hastenFrequency",hastenFrequency,node);
		//组装 on元素
		if(flowUtils.notNull(timeLimit)){
			var timeLimitInt = parseInt(timeLimit);
			if(timeLimitInt>0){
				var warningTimeLimitInt = 0;
				if(flowUtils.notNull(warningTimeLimit)){
					warningTimeLimitInt = parseInt(warningTimeLimit);
					if(warningTimeLimitInt<0){
						warningTimeLimitInt = 0;
					}
				}
				var duedate = timeLimitInt-warningTimeLimitInt;
				if(duedate<0){
					duedate = 0;
				}
				var timeEventNode = flowUtils.createElement('on');
				timeEventNode.setAttribute("event", "timeout");
				var timerNode = flowUtils.createElement("timer");
				timerNode.setAttribute("duedate",duedate+" business days");
				var repeat = 0;
				if(flowUtils.notNull(hastenFrequency)){
					repeat = parseInt(hastenFrequency);
					if(repeat<0){
						repeat = 0;
					}
				}
				if(repeat>0){
					timerNode.setAttribute("repeat",repeat+" business hours");
				}

				timeEventNode.appendChild(timerNode);

				var eventClassNode = flowUtils.createElement('event-listener');
				eventClassNode.setAttribute("name","pressTodoTimer");
				eventClassNode.setAttribute("class","avicit.platform6.bpm.bpmreform.event.PressTodoTimer");
				timeEventNode.appendChild(eventClassNode);
				node.appendChild(timeEventNode);
			}
		}
	}

	/** KPI设置*/
	this.setXmlMetaByVal("kpi_task_reasonable_day", node, "kpiTaskReasonableDay");
	this.setXmlMetaByVal("kpi_task_reasonable_hour", node, "kpiTaskReasonableHour");
	this.setXmlMetaByVal("kpi_task_reasonable_minute", node, "kpiTaskReasonableMinute");
	this.setXmlMetaByVal("kpi_task_warning_day", node, "kpiTaskWarningDay");
	this.setXmlMetaByVal("kpi_task_warning_hour", node, "kpiTaskWarningHour");
	this.setXmlMetaByVal("kpi_task_warning_minute", node, "kpiTaskWarningMinute");

	/**子流程*/
	this.getSubXml(node);

	this.setXmlMetaByCheck("event_auto_start", node, "event_auto_start");

	if($("#" + this.id).find("input[name='event_auto_start']").is(":checked")){
		var eventListener = flowUtils.createElement('event-listener');
		eventListener.setAttribute('name', "结束后根据子表数据自动发起子流程");
		eventListener.setAttribute('class', "avicit.platform6.bpm.bpmreform.event.AutoStartSubProcess");
		eventListener.setAttribute('display', "no");
		var endListenerList = $(node).children("on[event='end']");
		if(endListenerList.length == 0){
			var conditionEndNode =   flowUtils.createElement('on');
			conditionEndNode.setAttribute('event', 'end');
			conditionEndNode.appendChild(eventListener)
			node.appendChild(conditionEndNode);
		}else{
			endListenerList.append(eventListener);
		}
		this.setXmlMetaByVal("event_auto_start_defaultFlow_text", node, "event_auto_start_defaultFlow_text");
		this.setXmlMetaByVal("event_auto_start_defaultFlow_id", node, "event_auto_start_defaultFlow_id");
		this.setXmlMetaByVal("event_auto_start_defaultFlow_id2", node, "event_auto_start_defaultFlow_id2");
		this.setXmlMetaByVal("event_auto_start_table_text", node, "event_auto_start_table_text");
		this.setXmlMetaByVal("event_auto_start_table_id", node, "event_auto_start_table_id");
		this.setXmlMetaByVal("event_auto_start_table_name", node, "event_auto_start_table_name");
		this.setXmlMetaByVal("event_auto_start_fk_text", node, "event_auto_start_fk_text");
		this.setXmlMetaByVal("event_auto_start_fk_id", node, "event_auto_start_fk_id");
		this.setXmlMetaByVal("event_auto_start_user_text", node, "event_auto_start_user_text");
		this.setXmlMetaByVal("event_auto_start_user_id", node, "event_auto_start_user_id");
		this.setXmlMetaByVal("event_auto_start_flow_text", node, "event_auto_start_flow_text");
		this.setXmlMetaByVal("event_auto_start_flow_id", node, "event_auto_start_flow_id");
	}

	this.setXmlMetaByCheck("event_auto_deleteSubProcess", node, "event_auto_deleteSubProcess");

	this.setXmlMetaByCheck("task_zi_ding_yi_jian", node, "task_zi_ding_yi_jian");

	if($("#" + this.id).find("input[name='task_zi_ding_yi_jian']").is(":checked")){
		var ideasBySelf = flowUtils.createElement("ideasBySelf");
		$("#" + this.id).find("#table_task_zi_ding_yi_jian tbody tr").each(function (i, n) {
			var content = $(n).find("td").eq(0).text();
			var outcome = $(n).find("td").eq("1").find("input").val();
			var outcome_name = $(n).find("td").eq("1").text();
			var sub = flowUtils.createElement("sub");
			sub.appendChild(flowUtils.createTextNode("<![CDATA[" + $.trim(content) + "]]>"));
			sub.setAttribute('outcome', $.trim(outcome));
			sub.setAttribute('outcome_name', $.trim(outcome_name));
			ideasBySelf.appendChild(sub);
		});
		if(ideasBySelf.children.length > 0){
			node.appendChild(ideasBySelf);
		}
	}

	if($("#" + this.id).find("input[name='event_auto_deleteSubProcess']").is(":checked")){
		var eventListener = flowUtils.createElement('event-listener');
		eventListener.setAttribute('name', "再次启动时删除子流程");
		eventListener.setAttribute('class', "avicit.platform6.bpm.bpmreform.event.AutoDeleteSubProcess");
		eventListener.setAttribute('display', "no");
		var endListenerList = $(node).children("on[event='start']");
		if(endListenerList.length == 0){
			var conditionEndNode =   flowUtils.createElement('on');
			conditionEndNode.setAttribute('event', 'start');
			conditionEndNode.appendChild(eventListener)
			node.appendChild(conditionEndNode);
		}else{
			endListenerList.append(eventListener);
		}
	}

	//表单复制
	if(true) {
		var eventListener2 = flowUtils.createElement('event-listener');
		eventListener2.setAttribute('name', "表单复制");
		eventListener2.setAttribute('class', "avicit.platform6.bpm.bpmreform.event.AutoCopyFormData");
		eventListener2.setAttribute('display', "no");
		var endListenerList2 = $(node).children("on[event='end']");
		if (endListenerList2.length == 0) {
			var conditionEndNode2 = flowUtils.createElement('on');
			conditionEndNode2.setAttribute('event', 'end');
			conditionEndNode2.appendChild(eventListener2)
			node.appendChild(conditionEndNode2);
		} else {
			endListenerList2.append(eventListener2);
		}
	}

	/**
	 * 流程数据同步
	 */
	if(flowUtils.notNull(_processDataSynJs)){
		this.saveDataSynToXml(node);
	}
};

MyTask.prototype.createFormSaveXml = function (type, name, docRights, rootNode) {
	var _self = this;
	if($("#" + _self.id).find("input[name='"+type+"']").prop('checked')) {
		var docRight = flowUtils.createElement("docRight");
		docRight.setAttribute("type", type);
		docRight.setAttribute("name", name);
		// 子节点
		if(type == "wordEdit") {
			var wordRevisions = $("#" + _self.id).find("input[type='checkbox'][name='wordRevisions']");
			if(wordRevisions.prop('checked')) {
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", "wordRevisions");
				subDocRight.setAttribute("name", "编辑时留痕");
				subDocRight.setAttribute("value", "wordRevisions");
				docRight.appendChild(subDocRight);
			}
			var wordShowRevisions = $("#" + _self.id).find("input[type='checkbox'][name='wordShowRevisions']");
			if(wordShowRevisions.prop('checked')) {
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", "wordShowRevisions");
				subDocRight.setAttribute("name", "显示留痕");
				subDocRight.setAttribute("value", "wordShowRevisions");
				docRight.appendChild(subDocRight);
			}
		}
		if(type == "wordRead") {
			var read1 = $("#" + _self.id).find("input[type='checkbox'][name='read1']");
			if(read1.prop('checked')) {
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", "read1");
				subDocRight.setAttribute("name", "显示清稿");
				subDocRight.setAttribute("value", "read1");
				docRight.appendChild(subDocRight);
			}
			var read2 = $("#" + _self.id).find("input[type='checkbox'][name='read2']");
			if(read2.prop('checked')) {
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", "read2");
				subDocRight.setAttribute("name", "显示清稿");
				subDocRight.setAttribute("value", "read2");
				docRight.appendChild(subDocRight);
			}
		}

		if(type == "wordCreate" || type == "wordRedTemplet") {
			var data = $("#" + _self.id).find("input[name='taskFormValue"+(type.toString()[0].toUpperCase() + type.toString().slice(1))+"']");
			var show = $("#" + _self.id).find("input[name='taskFormText"+(type.toString()[0].toUpperCase() + type.toString().slice(1))+"']");
			var subDocRight = flowUtils.createElement("subDocRight");
			subDocRight.setAttribute("type", type == "wordCreate" ? "wordTemplates":"wordRedTemplates");
			subDocRight.setAttribute("name", show.val());
			subDocRight.setAttribute("value", data.val());
			docRight.appendChild(subDocRight);
		}

		// 勾选了打印正文
		if(type == "wordPrint") {
			// 找到所有人员信息
			$("#" + _self.id).find("input[name^='taskFormValuewordSecret']").each(function(){
				var id = $(this).attr("id");
				var ownerId = $(this).attr("actorsid");
				var value = $(this).val();
				if(value) {
					_self.createUserSelectXml(ownerId, value, rootNode);
					var subDocRight = flowUtils.createElement("subDocRight");
					subDocRight.setAttribute("type", id.slice("taskFormValue".length));
					subDocRight.setAttribute("name", $(this).parent().parent().parent().find("label").text());
					subDocRight.setAttribute("value", ownerId);
					docRight.appendChild(subDocRight);
				}
			});
		}
		if(type == "wordValue") {
			//  阈值同步
			var data = $("#" + _self.id).find("input[name='taskFormValueWordValue']");
			var show = $("#" + _self.id).find("input[name='taskFormTextWordValue']");
			var subDocRight = flowUtils.createElement("subDocRight");
			subDocRight.setAttribute("type", "wordFieldName");
			subDocRight.setAttribute("name", show.val());
			subDocRight.setAttribute("value", data.val());
			docRight.appendChild(subDocRight);
		}
		docRights.appendChild(docRight);
	}
}

/**
 * 自动选人、显示选人框只能勾选一个
 * obj 当前勾选的选择框
 */
MyTask.prototype.toggleAutoSelectUserOrShowBoxEvent = function(obj) {
	var _self = this;
	var showBox = $("#"+_self.id).find("input[name='show-selection-box']");
	var selectUser = $("#"+_self.id).find("input[name='person-automatic-selection']");
	if(obj.attr("name") == "person-automatic-selection"){
		selectUser.prop("checked") ? "" : showBox.prop("checked",true)
	} else {
		showBox.prop("checked") ? "" : selectUser.prop("checked",true);
	}
}
/**
 * 组织结构树展开到部门、组织结构树默认展开只能勾选一个
 * @param obj
 */
MyTask.prototype.toggleOrgTreeOpenToDeptOrorgTreeDefaultOpen = function(obj) {
	var _self = this;
	var orgTreeDefaultOpen = $("#"+_self.id).find("input[name='orgTreeDefaultOpen']");
	var orgTreeOpenToDept = $("#"+_self.id).find("input[name='orgTreeOpenToDept']");
	if(obj.attr("name") == "orgTreeDefaultOpen"){
		if(orgTreeDefaultOpen.prop("checked")){
			orgTreeOpenToDept.prop("checked",false)
		}
	} else {
		if(orgTreeOpenToDept.prop("checked")){
			orgTreeDefaultOpen.prop("checked",false)
		}
	}
}

MyTask.prototype.initEvent = function() {
	var _self = this;
	//配置待办标题
	$("#"+this.id+" #formName_biaoTi").click(function(){
		_self.configTaskTitle();
	});
	// 人工节点 候选人事件
	 $("#"+this.id+" button[name=btn-add-candidate]").on("click",function(){
		 var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
         var option = {type:'userSelect',
			 userSelectContainer :'draft-candidate-container' ,
			 dataField:'draft-candidate-data-field',
			 textField:'draft-candidate-text-field',
			 topId:_self.id,
			 processId:process.id,
		 	callback:function(data){
         	//console.log("-----------");
         	//console.log(data);
         	//console.log("=============");
		 }};
         _self.candidateSelect = new UserSelect(option);
     });

	 $("#"+this.id+" select[name='select-human-task-process-mode']").on("change", function() {
         var selected = $(this).val();
         if (selected == 4) {
             $(this).parent().parent().next().removeClass("hidden");
         } else {
             $(this).parent().parent().next().addClass("hidden");
         }
     });

	 $("#"+this.id+" input[type='radio'][name='input-radio-human-task-select-task']").on("click", function() {
         var index = $(this).parent().parent().index();
         var $target = $(this).parent().parent().parent().next().children().eq(index);
         $target.removeClass("hidden").siblings().addClass("hidden");
     });

	 $("#"+this.id+" input[type='checkbox'][name='person-automatic-selection'],input[type='checkbox'][name='show-selection-box']").on("change", function() {
		_self.toggleAutoSelectUserOrShowBoxEvent($(this));
	 });

	$("#"+this.id+" input[type='checkbox'][name='orgTreeDefaultOpen'],input[type='checkbox'][name='orgTreeOpenToDept']").on("change", function() {
		_self.toggleOrgTreeOpenToDeptOrorgTreeDefaultOpen($(this));
	});

	 $("#"+this.id+" input[type='checkbox'][name='mi_ji_kong_zhi']").on("click",function() {
		 $(this).is(":checked")? $("#"+_self.id).find("div[name='mi_ji_bian_liang_show']").removeClass("hidden"):
			 $("#"+_self.id).find("div[name='mi_ji_bian_liang_show']").addClass("hidden");
	 });

	 $("#"+_self.id +" div[class^='div-auth-checkbox'] input[type='checkbox']").on("click",function() {
		  var selfCheckbox = this;
		  if(selfCheckbox.checked) {
			 var $divAuth =  $(selfCheckbox).parentsUntil(".form-group").parent().siblings("div[class^='div-auth-box']");
			 $divAuth.removeClass("hidden");
			 var divAuthClassName = $divAuth.attr("class");
			 // 存在操作人选择
			 if($divAuth.find("input[name='operator-data-field']").get(0)) {
				 // 增加按钮事件
				 $divAuth.find("button[name='button-auth-operator']").off("click").on("click",function() {
                     var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
					 var option = {processId:process.id,type:'userSelect', userSelectContainer :divAuthClassName ,dataField:'operator-data-field',textField:'operator-text-field',topId:_self.id};
					 new UserSelect(option);
				 });
			 }
			 if($divAuth.find("input[name='candidate-data-field']").get(0)) {
				 // 增加按钮事件
				 $divAuth.find("button[name='button-auth-candidate']").off("click").on("click",function() {
                     var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
					 var option = {processId:process.id,type:'userSelect', userSelectContainer :divAuthClassName ,dataField:'candidate-data-field',textField:'candidate-text-field',topId:_self.id};
					 new UserSelect(option);
				 });
			 }
			 if($divAuth.find("input[name='preprocess-data-field']").get(0)) {
				 // 预处理按钮事件
				 $divAuth.find("button[name='button-auth-preprocess']").off("click").on("click",function() {
					 layer.open({
                   	    type:  2,
                   	    area: [ "400px",  "350px"],
                   	    title: "函数输入框",
                   	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                   	    shade:   0.3,
                           maxmin: false, //开启最大化最小化按钮
                   	    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/AuthProcessTpl/authProcessTpl.jsp?id="+_self.id+"&name=preprocess-data-field&className="+divAuthClassName,
                   	});
				 });
			 }
			 if($divAuth.find("input[name='postprocess-data-field']").get(0)) {
				 // 预处理按钮事件
				 $divAuth.find("button[name='button-auth-postprocess']").off("click").on("click",function() {
					 layer.open({
						 type:  2,
						 area: [ "400px",  "350px"],
						 title: "函数输入框",
						 skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
						 shade:   0.3,
						 maxmin: false, //开启最大化最小化按钮
						 content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/AuthProcessTpl/authProcessTpl.jsp?id="+_self.id+"&name=postprocess-data-field&className="+divAuthClassName,
					 });
				 });
			 }
			 if($divAuth.find("input[name='input_kua_jie_dian_tui_hui_activity']").get(0)) {
				 $divAuth.find("button[name='button-kua_jie_dian_tui_hui_activity']").off("click").on("click",function() {
					 layer.open({
						    type:  1,
						    area: [ "800px",  "450px"],
						    title: "节点选择",
						    content: "<table id='activityGrid'></table>",
						    btn: ['确定', '关闭'],
							 success : function(layero, index) {
								 var vArr = [];
								 var values = _self.designerEditor.myCellMap.values();
								$.each(values, function(i, n){
									if(n.tagName == "task"){
										var o = {};
										o.name = n.name;
										o.alias = n.alias;
										vArr.push(o);
									}
								});
								$("#activityGrid").jqGrid({
									datastr : JSON.stringify(vArr),
									datatype : "jsonstring",
									colModel : [{
										label : '逻辑标识',
										name : 'name',
										key : true,
										align : 'center'
									}, {
										label : '节点名称',
										name : 'alias',
										align : 'center'
									} ],
									rownumbers : true,
									altRows : true,
									styleUI : 'Bootstrap',
									autowidth : true,
									height : '100%',
									multiselect : true
								});
							},
							yes: function(index, layero){
								var nameArr = [];
								var aliasArr = [];
								var selectedRowIds = $("#activityGrid").getGridParam("selarrrow");
								if (selectedRowIds != "") {
									var len = selectedRowIds.length;
									for ( var i = 0; i < len; i++) {
										var rowData = $("#activityGrid").getRowData(selectedRowIds[i]);
										nameArr.push(rowData.name);
										aliasArr.push(rowData.alias);
									}
								} else{
									layer.msg("请选择数据");
									return;
								}

								var v = "";
								for(var i = 0; i < nameArr.length; i++){
									if(i > 0){
										v += ",";
									}
									v += aliasArr[i] + "【" + nameArr[i] + "】";
								}
								$("#" + _self.id + " input[name='input_kua_jie_dian_tui_hui_activity']").val(v);
								$("#" + _self.id + " input[name='input_kua_jie_dian_tui_hui_activity']").attr("title",v);
								layer.close(index);
							}
						});
				 });
			 }

		  } else {
			  var $divAuthBox = $(selfCheckbox).parentsUntil(".form-group").parent().siblings("div[class^='div-auth-box']");
			  $divAuthBox.addClass("hidden").find("input").val("");
			  var $subprocesstable =  $divAuthBox.find("#table_subprocess tbody");
			  $subprocesstable.empty();
		  }
	  });

	 // 节点表单配置
	 $("#"+_self.id +" input[type='checkbox'][name='formSave']").on("click",function() {
		 var selfCheckbox = this;
		 if(selfCheckbox.checked) {
			$("#" + _self.id).find(".basic-form-save-area").removeClass("hidden");
			_self.syncFormAttrs();
		 } else {
			 $("#" + _self.id).find(".basic-form-save-area").addClass("hidden");
			 $("#" + _self.id).find(".basic-form-save-area input[type='checkbox']").prop("checked",false);
			 $("#" + _self.id).find("table[name='table-attr-auth'] tbody>tr").remove();
			 $("#" + _self.id).find("table[name='table-attachment-auth'] tbody>tr").remove();
		 }
		// 如果勾选了保存保单，则将节点置data-type为task
		$('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type", "task");
	 });

	// 节点表单配置
	 $("#"+_self.id +" #refreshForm").on("click",function() {
		 var selfCheckbox = $("#"+_self.id +" input[type='checkbox'][name='formSave']");
		 if(selfCheckbox.prop("checked")) {
			 _self.syncFormAttrs(true);
		 }
	 });

	 $("#"+_self.id +" input[type='checkbox'][name='formCheckAll']").on('click',function () {
         var selfCheckbox = this;
         if(selfCheckbox.checked) {
             $("#"+_self.id +" table[name='table-attr-auth']").find("input[name=isModified]").prop("checked",true);
         } else {
             $("#"+_self.id +" table[name='table-attr-auth']").find("input[name=isModified]").prop("checked",false);
         }
     });

	 $("#"+_self.id +" input[type='checkbox'][name='formAccessibilityCheckAll']").on('click',function () {
         var selfCheckbox = this;
         if(selfCheckbox.checked) {
             $("#"+_self.id +" table[name='table-attr-auth']").find("input[name=accessibility]").prop("checked",true);
         } else {
             $("#"+_self.id +" table[name='table-attr-auth']").find("input[name=accessibility]").prop("checked",false);
         }
     });

	 $("#"+_self.id +" input[type='checkbox'][name='formRequiredCheckAll']").on('click',function () {
         var selfCheckbox = this;
         if(selfCheckbox.checked) {
             $("#"+_self.id +" table[name='table-attr-auth']").find("input[name=required]").prop("checked",true);
         } else {
             $("#"+_self.id +" table[name='table-attr-auth']").find("input[name=required]").prop("checked",false);
         }
     });

	 $("#"+_self.id +" input[type='checkbox'][name='formAttachmentAddCheckAll']").on('click',function () {
         var selfCheckbox = this;
         if(selfCheckbox.checked) {
             $("#"+_self.id +" table[name='table-attachment-auth']").find("input[name=isModified]").prop("checked",true);
         } else {
             $("#"+_self.id +" table[name='table-attachment-auth']").find("input[name=isModified]").prop("checked",false);
         }
     });

	 $("#"+_self.id +" input[type='checkbox'][name='formAttachmentRequiredCheckAll']").on('click',function () {
         var selfCheckbox = this;
         if(selfCheckbox.checked) {
             $("#"+_self.id +" table[name='table-attachment-auth']").find("input[name=required]").prop("checked",true);
         } else {
             $("#"+_self.id +" table[name='table-attachment-auth']").find("input[name=required]").prop("checked",false);
         }
     });

	 $("#"+_self.id +" input[type='checkbox'][name='formAttachmentModifySecretLevelCheckAll']").on('click',function () {
         var selfCheckbox = this;
         if(selfCheckbox.checked) {
             $("#"+_self.id +" table[name='table-attachment-auth']").find("input[name=modifySecretLevel]").prop("checked",true);
         } else {
             $("#"+_self.id +" table[name='table-attachment-auth']").find("input[name=modifySecretLevel]").prop("checked",false);
         }
     });

	// 切换表单配置项的时候，如果选择非平台表单，则清空所选内容
	 $("#" + this.id + " input[name='input-radio-platform-form']").on("click",function() {
		 var selfRadio = this;
		 if(selfRadio.value == "url") {
		    // flowUtils.warning("功能开发中");
			 $("#" + _self.id).find(".div-formSave-area").addClass("hidden");
			 $("#" + _self.id).find(".basic-form-save-area").addClass("hidden");
			 $("#" + _self.id).find("input[type='checkbox']").prop("checked",false);
			 $("#" + _self.id).find("table[name='table-attr-auth'] tbody>tr").remove();

			 // 将表单重置为全局
			 $('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type","global");
			 var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
			 var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
			 var globalformname = $.trim($('#' + process.id).find('#formName').val());
			 _self.syncTaskForm(globalformid, globalformname);
		 }  else {
			 $("#" + _self.id).find(".div-formSave-area").removeClass("hidden");
		 }

	 });


	 //	 正文相关权限
	 $("#"+_self.id+" div[name^='div-word']").find("input[type='checkbox']").on("click", function(){
 		var checkbox = this;
 		var checkboxName = $(checkbox).attr("name");
 		var container = $("#"+_self.id+" div[name='container-"+checkboxName+"']");
 		if(checkbox.checked) {
 			if(container.hasClass("hidden")) {
 				container.removeClass("hidden");
 			}
 		} else {
 			container.addClass("hidden");
 			// 清空选择表单
 			container.find("input").val("");
 			container.find("input[type='checkbox']").prop("checked",false);
 		}
 	});

	 // 创建正文
	 $("#"+_self.id+" button[name='btnTaskFormWordCreate']").on("click", function(){
		 new FormAuth({dataDomId:_self.id+" #taskFormValueWordCreate",showDomId:_self.id+" #taskFormTextWordCreate", callback:"",type:"wordCreate"});
	 });
	 //	 套红功能
	 $("#"+_self.id+" button[name='btnTaskFormWordRedTemplet']").on("click", function(){
		 new FormAuth({dataDomId:_self.id+" #taskFormValueWordRedTemplet",showDomId:_self.id+" #taskFormTextWordRedTemplet", callback:"",type:"redTemplate"});
	 });

//	 域值同步
	 $("#"+_self.id+" button[name='btnTaskFormWordValue']").on("click", function(){
		 var process = null;
		 var values = _self.designerEditor.myCellMap.values();
			$.each(values, function(i, n){
				if(n.tagName == "process"){
					process = n;
				}
		 });
		 new ProcessVariable({dataDomId:_self.id+" #taskFormValueWordValue",showDomId:_self.id+" #taskFormTextWordValue", callback:"",process:process});
	 });

	 // 各种打印级别选人
	 $("#"+_self.id).find("button[name^='btnTaskFormwordSecret']").off("click").on("click",function() {
		 var containerDiv = "";
         var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
		 var dataField = $(this).parent().siblings("div").find("input[name^='taskFormValuewordSecret']").attr("name");
		 var textField = $(this).parent().siblings("div").find("input[name^='taskFormTextwordSecret']").attr("name");
		 var option = {processId:process.id,type:'userSelect', userSelectContainer :containerDiv ,dataField:dataField,textField:textField,topId:_self.id};
		 new UserSelect(option);
	 });

	 //密级变量按钮事件
	 $("#"+_self.id+" button[name='button-mi_ji_bian_liang']").on("click", function(){
	        var process = null;
	        var values = _self.designerEditor.myCellMap.values();
	        $.each(values, function(i, n){
	            if(n.tagName == "process"){
	                process = n;
	            }
	        });
	        new ProcessVariable({dataDomId:_self.id+" #mi_ji_bian_liang",showDomId:_self.id+" #mi_ji_bian_liang", callback:function(data){
	            var d = data[0];
	            var mjblVal = "\#{"+d.name+"}";
	            $("#"+_self.id+" #mi_ji_bian_liang").val(mjblVal);
	        },process:process,
	            multiple:false});
	    });


	 //手动催办
	 $("#"+_self.id+" input[type='checkbox'][name='task_cuiban_sd']").on("click",function() {
		 if($(this).is(":checked")){
			 _self.showOrHiddenCuiban(true, true);
		 }else{
			 if(!$("#"+_self.id+" input[type='checkbox'][name='task_cuiban_zd']").is(":checked")){
				 _self.showOrHiddenCuiban(false, true);
			 }
		 }
	 });
	//自动催办
	 $("#"+_self.id+" input[type='checkbox'][name='task_cuiban_zd']").on("click",function() {
		 if($(this).is(":checked")){
			 _self.showOrHiddenCuiban(true, false);
		 }else{
			 if( $("#"+_self.id+" input[type='checkbox'][name='task_cuiban_sd']").is(":checked")){
				 _self.showOrHiddenCuiban(false, false);
				 _self.showOrHiddenCuiban(true, true);
			 }else{
				 _self.showOrHiddenCuiban(false, false);
			 }

		 }
	 });


	 //添加子流程
	 $("#"+_self.id+" button[name='addSubProcess']").on("click", function(){
	        new SubProcess({dataDomId:_self.id+" #inputValueSubFlowName",showDomId:_self.id+" #inputTextSubFlowName", callback:function(data){
	        	var $table =  $("#"+_self.id+" #table_subprocess tbody");
	        	if(data!=null && data.length>0){
	        		for(var i=0;i<data.length;i++){
	        			var obj = data[i];
	        			var $tr = $("<tr></tr>");
	        			var $td1 = $("<td></td>");
	        			$td1.append(obj.displayName);
	        			var $hidden1 = $("<input type='hidden' id='subflowid_"+obj.id+"' value='"+obj.id+"'/>");
	        			var $hidden_name = $("<input type='hidden' id='subflowname_"+obj.id+"' value='"+obj.displayName+"'/>");
	        			var $hidden_key = $("<input type='hidden' id='subflowkey_"+obj.id+"' value='"+obj.key+"'/>");
	        			$td1.append($hidden1);
	        			$td1.append($hidden_name);
	        			$td1.append($hidden_key);

	        			var op = "<td><a href='javascript:void(0)' name='deleteData'><i class='iconfont icon-delete'></i></a>" +
	        			   "<a href='javascript:void(0)' name='modifyData' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
        			   var $td2 = $(op);
        			   $td2.find("a[name='deleteData']").off("click").on("click",function() {
        				   $(this).parent().parent().siblings("div").remove();
        			  	 $(this).parent().parent().remove();
        			   });
        			   $td2.find("a[name='modifyData']").off("click").on("click",function() {
        				   var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
        					var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
        			        var subProcessKey = obj.key;
        			        var subProcessId = obj.id;
        			        if(!flowUtils.notNull(subProcessId) && !flowUtils.notNull(subProcessKey)){
        			        	layer.msg("您还没选择子流程");
        			        	return false;
        			        }

        			        new FormFieldParameter({id:_self.id,dataDomId1:_self.id+" #formInData_"+obj.id,dataDomId2:_self.id+" #formOutData_"+obj.id,callback:function(data){

        			        },process:process,mainProcessFormId:globalformid,
        			        subProcessKey:subProcessKey,hiddenVarParameter:'1'});
        			   });
	        			var $hidden2 = $("<input type='hidden' id='formInData_"+obj.id+"'/>");
	        			var $hidden3 = $("<input type='hidden' id='formOutData_"+obj.id+"'/>");
	        			$td2.append($hidden2);
	        			$td2.append($hidden3);

	        			$tr.append($td1).append($td2);
	        			$table.append($tr);
	        		}
	        	}
	        }, multiple:false, dataDomId2:_self.id+" #inputValueSubFlowId"});
	  });

	 if(flowUtils.notNull(_processDataSynJs)){
		 var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
		 var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
		 var processDataSynchronization = new ProcessDataSynchronization({id:_self.id,dataDomId:_self.id+" #shujutongbu",callback:function(data){
			 },process:process,task:_self,formId:globalformid,tableId:"table-shujutongbu-value"});

		 $("#"+_self.id+" button[name='btn-shujutongbu-add']").on("click", function(){
			 var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
			 processDataSynchronization.formId = globalformid;
			 processDataSynchronization.add();
		 });
		 $("#"+_self.id+" button[name='btn-shujutongbu-viewLog']").on("click", function(){
			 var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
			 processDataSynchronization.formId = globalformid;
			 processDataSynchronization.viewLog();
		 });

	 }
	$("#"+_self.id+" button[name='btn-fieldRelationControlConfig']").on("click", function(){
		var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
		var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
		new FieldRelationControl({id:_self.id,dataDomId:_self.id+" #fieldRelationControlConfigValue",callback:function(data){

			},process:process,formId:globalformid,tableId:"table-field-relation-control"});
	});


};

MyTask.prototype.syncFormAttrTr = function(tag, tagName, isModified,accessibility,elementType,required) {
	 var html = " <tr>" +
		' <td title="'+ tagName + '('+tag+')">'+tagName+'('+tag+')</td>' +
		'  <td>' +
		'   <input type="hidden" name="tag" value="'+tag+'"/>' +
		'    <input type="hidden" name="tagName" value="'+tagName+'"/>' +
         '    <input type="hidden" name="elementType" value="'+elementType+'"/>' +
		'    <input type="checkbox" name="isModified" '+(isModified?'checked':'')+'/>' +
		'  </td>' +
		'  <td>' +
		'    <input type="checkbox" name="accessibility" '+(accessibility?'checked':'')+'/>' +
		'  </td>' +
		'  <td>' +
		'    <input type="checkbox" name="required" '+(required?'checked':'')+'/>' +
		'  </td>' +
		'  </tr>';
	 return html;
}

MyTask.prototype.syncSubFormButtonAttrTr = function(tag, tagName, isModified,accessibility,elementType,required) {
	 var html = " <tr>" +
		' <td title="'+ tagName + '('+tag+')">'+tagName+'('+tag+')</td>' +
		'  <td>' +
		'   <input type="hidden" name="tag" value="'+tag+'"/>' +
		'    <input type="hidden" name="tagName" value="'+tagName+'"/>' +
        '    <input type="hidden" name="elementType" value="'+elementType+'"/>' +
		'  </td>' +
		'  <td>' +
		'    <input type="checkbox" name="accessibility" '+(accessibility?'checked':'')+'/>' +
		'  </td>' +
		'  <td>' +
		'  </td>' +
		'  </tr>';
	 return html;
}

MyTask.prototype.syncFormAttachmentAttrTr = function(tag, tagName, isModified,elementType,required,modifySecretLevel) {
	 var html = " <tr>" +
		' <td title="'+ tagName + '('+tag+')">'+tagName+'('+tag+')</td>' +
		'  <td>' +
		'   <input type="hidden" name="tag" value="'+tag+'"/>' +
		'    <input type="hidden" name="tagName" value="'+tagName+'"/>' +
        '    <input type="hidden" name="elementType" value="'+elementType+'"/>' +
		'    <input type="checkbox" name="isModified" '+(isModified?'checked':'')+'/>' +
		'  </td>' +
		'  <td>' +
		'    <input type="checkbox" name="required" '+(required?'checked':'')+'/>' +
		'  </td>' +
		'  <td>' +
		'    <input type="checkbox" name="modifySecretLevel" '+(modifySecretLevel?'checked':'')+'/>' +
		'  </td>' +
		'  </tr>';
	 return html;
}

MyTask.prototype.syncFormAttrs = function(refresh) {
	 var _self = this;
/*	 var html = " <tr>" +
	' <td>aaaaaa(字段名称)</td>' +
	'  <td>' +
	'   <input type="hidden" name="tag" value="tag123"/>' +
	'    <input type="hidden" name="tagName" value="属性名称"/>' +
	'    <input type="checkbox" name="isModified"/>' +
	'  </td>' +
	'  </tr>';*/
	//var modifiedData = {};
	//var accessibilityData = {};
	//var requiredData = {};
	var formElementData = [];
	var attachmentData = [];
	if(refresh){
		$("#" + _self.id).find("table[name='table-attr-auth'] tbody>tr").each(function(i, n){
			var tag = $(n).find("input[name='tag']").val();
			var isModified = $(n).find("input[name='isModified']").prop("checked");
			var accessibility = $(n).find("input[name='accessibility']").prop("checked");
			var required = $(n).find("input[name='required']").prop("checked");
			var formElement = {};
            formElement.tag = tag;
            formElement.isModified = isModified;
            formElement.accessibility = accessibility;
            formElement.required = required;
            formElementData.push(formElement);
			//eval("modifiedData." + tag + " = isModified");
			//eval("accessibilityData." + tag + " = accessibility");
			//eval("requiredData." + tag + " = required");
		});
		$("#" + _self.id).find("table[name='table-attr-auth'] tbody>tr").remove();

		$("#" + _self.id).find("table[name='table-attachment-auth'] tbody>tr").each(function(i, n){
			var tag = $(n).find("input[name='tag']").val();
			var isModified = $(n).find("input[name='isModified']").prop("checked");
			var required = $(n).find("input[name='required']").prop("checked");
			var modifySecretLevel = $(n).find("input[name='modifySecretLevel']").prop("checked");
			var attachment = {};
			attachment.tag = tag;
			attachment.isModified = isModified;
			attachment.required = required;
			attachment.modifySecretLevel = modifySecretLevel;
			attachmentData.push(attachment);
			//eval("attachmentModifiedData." + tag + " = isModified");
			//eval("attachmentRequiredData." + tag + " = required");
		});
		$("#" + _self.id).find("table[name='table-attachment-auth'] tbody>tr").remove();
	}
	 var formid =  $('#' + _self.id).find('#task_guan_lian_biao_dan').val();
	 $.ajax({
			type : "POST",
			url : "platform/bpm/designer/getFormElement",
			data : {
				id :  formid,
				/*modifiedData : JSON.stringify(modifiedData),
				accessibilityData : JSON.stringify(accessibilityData),
				requiredData : JSON.stringify(requiredData),*/
                formElementData : JSON.stringify(formElementData),
				attachmentData : JSON.stringify(attachmentData)
			},
			dataType : "json",
			success : function(result) {
				var datas = result.result;
				if(datas) {
					$.each(datas, function(i,v){
						if(v.elementType=='eform_mutiattach_auth'){
							$("#" + _self.id).find("table[name='table-attachment-auth'] tbody").append(_self.syncFormAttachmentAttrTr(v.tag,v.tagName,v.operability,v.elementType,v.required,v.modifySecretLevel));
						}else if(v.elementType=='eform_subtable_bpm_button_auth'){
							$("#" + _self.id).find("table[name='table-attr-auth'] tbody").append(_self.syncSubFormButtonAttrTr(v.tag,v.tagName,v.operability,v.accessibility,v.elementType,v.required));
						}else{
							$("#" + _self.id).find("table[name='table-attr-auth'] tbody").append(_self.syncFormAttrTr(v.tag,v.tagName,v.operability,v.accessibility,v.elementType,v.required));
						}
					})
				} else {
					flowUtils.error( result.error);
				}
			}
	});
}

MyTask.prototype.syncTaskForm = function (globalformid, globalformname) {
		var _self = this;
		// 先取全局表单
		// 更新所有人工节点中表单data-type=global的表单
		var dataType = $('#' + _self.id).find("input[name='task_guan_lian_biao_dan']").attr("data-type");
		if (dataType == "global" || dataType == undefined || dataType == "") {
			$('#' + _self.id).find('#task_guan_lian_biao_dan').val(globalformid);
			$('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type","global");
			$('#' + _self.id).find('#task_formName').val(globalformname);
		}
}

MyTask.prototype.showOrHiddenCuiban = function(isShow,isSdcb){
	var _self = this;
	if(isShow){
		if(isSdcb){
			$("#" + _self.id).find("#task_cuiban_txfs_div").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div1").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div2").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_sxl_div").removeClass("hidden");
		}else{
			$("#" + _self.id).find("#task_cuiban_txfs_div").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div1").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div2").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_sxl_div").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_blqx_div").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_cbcs_div").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_jgsx_div").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_cbpl_div").removeClass("hidden");
		}
	}else{
		if(isSdcb){
			$("#" + _self.id).find("#task_cuiban_txfs_div").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div1").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div2").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_sxl_div").addClass("hidden");
		}else{
			$("#" + _self.id).find("#task_cuiban_txfs_div").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div1").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div2").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_sxl_div").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_blqx_div").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_cbcs_div").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_jgsx_div").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_cbpl_div").addClass("hidden");
		}
	}
}

//配置流程待办标题
MyTask.prototype.configTaskTitle = function(){
	var _self = this;
	var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
	var processId = process.id;
	var value = $("#" + _self.id).find("#dai_ban_biao_ti").val();
	value = encodeURIComponent(value);
	layer.open({
		type: 2,
        title: '配置【待办标题】',
        skin: 'index-model',
        area: ['400px', '350px'],
        content: 'bpm/business/expr?value=' + value+'&processId='+processId,
        btn: ['确认', '取消'],
        yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;
			var value = iframeWin.getValue();
			$("#" + _self.id).find("#formName_biaoTi").val(value);
			$("#" + _self.id).find("#dai_ban_biao_ti").val(value);
			layer.close(index);
		}
    });
};


MyTask.prototype.getSubXml = function(node) {
	var _self = this;
	var sub = flowUtils.createElement("sub");

	var hasSubFlow = false;
	$("#"+_self.id+" input[id^='subflowid_']").each(function(){
		var _selfNode = this;
		hasSubFlow = true;
		var id = $(_selfNode).val();
		var name = $("#"+_self.id+" #subflowname_"+id).val();
		var key = $("#"+_self.id+" #subflowkey_"+id).val();
		var formInData = $("#"+_self.id+" #formInData_"+id).val();
		var procmodel = flowUtils.createElement("procmodel");
		procmodel.setAttribute("id", id);
		procmodel.setAttribute("name", name);
		procmodel.setAttribute("key", key);
		sub.appendChild(procmodel);
		if(flowUtils.notNull(formInData)){
			var formInArr = JSON.parse(formInData);
			if(formInArr.length){
				for(i=0;i<formInArr.length;i++){
					var data = formInArr[i];
					var arg = flowUtils.createElement("form-in");
					arg.setAttribute("formTable", data.formTable);
					arg.setAttribute("formCol", data.formCol);
					arg.setAttribute("subFormTable", data.subFormTable);
					arg.setAttribute("subFormCol", data.subFormCol);
					arg.setAttribute("colType", data.colType);
					arg.setAttribute("tableModify", data.tableModify);
					arg.setAttribute("colComments",data.colComments);
					arg.setAttribute("isOrgIdentity",data.isOrgIdentity);
					arg.setAttribute("fromComments",data.fromComments);
					arg.setAttribute("isSubTable",data.isSubTable=="1"?"1":"");
					arg.setAttribute("fromFkColName",data.fromFkColName);
					arg.setAttribute("toFkColName",data.toFkColName);
					procmodel.appendChild(arg);
				}
			}
		}

	});

	if(hasSubFlow){
		node.appendChild(sub);
	}

};


MyTask.prototype.getSubFromDom = function(node) {
	var _self = this;
	var $table =  $("#"+_self.id+" #table_subprocess tbody");
	$table.empty();
	$(node).children("sub").children("procmodel").each(function(){
		var procmodel = this;
		var id = $.trim(procmodel.getAttribute("id"));
		var name = $.trim(procmodel.getAttribute("name"));
		var key = $.trim(procmodel.getAttribute("key"));
		var dataArr = [];
		$(procmodel).children("form-in").each(function(){
			var _selfNode = this;
			var dataObj = {};
			dataObj.formTable = $.trim(_selfNode.getAttribute("formTable"));
			dataObj.formCol = $.trim(_selfNode.getAttribute("formCol"));
			dataObj.subFormTable = $.trim(_selfNode.getAttribute("subFormTable"));
			dataObj.subFormCol = $.trim(_selfNode.getAttribute("subFormCol"));
			dataObj.colType = $.trim(_selfNode.getAttribute("colType"));
			dataObj.tableModify = $.trim(_selfNode.getAttribute("tableModify"));
			dataObj.colComments = $.trim(_selfNode.getAttribute("colComments"));
			dataObj.isOrgIdentity = $.trim(_selfNode.getAttribute("isOrgIdentity"));
			dataObj.fromComments = $.trim(_selfNode.getAttribute("fromComments"));
			dataObj.isSubTable = $.trim(_selfNode.getAttribute("isSubTable"));
			dataObj.fromFkColName = $.trim(_selfNode.getAttribute("fromFkColName"));
			dataObj.toFkColName = $.trim(_selfNode.getAttribute("toFkColName"));
			dataArr.push(dataObj);
		});
		var formInDataStr = JSON.stringify(dataArr);
		var $tr = $("<tr></tr>");
		var $td1 = $("<td></td>");
		$td1.append(name);
		var $hidden1 = $("<input type='hidden' id='subflowid_"+id+"' value='"+id+"'/>");
		var $hidden_name = $("<input type='hidden' id='subflowname_"+id+"' value='"+name+"'/>");
		var $hidden_key = $("<input type='hidden' id='subflowkey_"+id+"' value='"+key+"'/>");
		$td1.append($hidden1);
		$td1.append($hidden_name);
		$td1.append($hidden_key);

		var op = "<td><a href='javascript:void(0)' name='deleteData'><i class='iconfont icon-delete'></i></a>" +
		   "<a href='javascript:void(0)' name='modifyData' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
	   var $td2 = $(op);
	   $td2.find("a[name='deleteData']").off("click").on("click",function() {
		   $(this).parent().parent().siblings("div").remove();
	  	 $(this).parent().parent().remove();
	   });
	   $td2.find("a[name='modifyData']").off("click").on("click",function() {
		   var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
			var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
	        var subProcessKey = key;
	        var subProcessId = id;
	        if(!flowUtils.notNull(subProcessId) && !flowUtils.notNull(subProcessKey)){
	        	layer.msg("您还没选择子流程");
	        	return false;
	        }

	        new FormFieldParameter({id:_self.id,dataDomId1:_self.id+" #formInData_"+id,dataDomId2:_self.id+" #formOutData_"+id,callback:function(data){

	        },process:process,mainProcessFormId:globalformid,
	        subProcessKey:subProcessKey,hiddenVarParameter:'1'});
	   });
		var $hidden2 = $("<input type='hidden' id='formInData_"+id+"' value='"+formInDataStr+"'/>");
		$td2.append($hidden2);

		$tr.append($td1).append($td2);
		$table.append($tr);

	});
};

/**
 * 保存流程数据同步信息到xml
 * @param node
 */
MyTask.prototype.saveDataSynToXml = function(node){
	var _self = this;
	var _tr = $("#"+_self.id+" #table-shujutongbu-value tbody").find("tr");
	if(_tr && _tr.length){
		var dataSyns = flowUtils.createElement('dataSyns');
		_tr.each(function(){
			var dataSyn = flowUtils.createElement('dataSyn');
			var data = $(this).find("td").eq(0).find("input").val();
			dataSyn.appendChild(flowUtils.createTextNode("<![CDATA[" + data.trim() + "]]>"));
			dataSyns.appendChild(dataSyn);
		});
		node.appendChild(dataSyns);
		var endEventListener = flowUtils.createElement('event-listener');
		endEventListener.setAttribute('name', "节点完成后同步流程数据");
		var waSysDataAfterClass = getWaSysDataAfterClass();
		//endEventListener.setAttribute('class', "avicit.platform6.bpm.bpmreform.event.SynDataAfter");
		endEventListener.setAttribute('class', waSysDataAfterClass);
		endEventListener.setAttribute('display', "no");
		var endListenerList = $(node).children("on[event='end']");
		if(endListenerList.length == 0){
			var conditionEndNode =   flowUtils.createElement('on');
			conditionEndNode.setAttribute('event', 'end');
			conditionEndNode.appendChild(endEventListener)
			node.appendChild(conditionEndNode);
		}else{
			endListenerList.append(endEventListener);
		}

		var startEventListener = flowUtils.createElement('event-listener');
		startEventListener.setAttribute('name', "节点创建前同步流程数据");
		var waSynDataBeforeClass = getWaSynDataBeforeClass();
		//startEventListener.setAttribute('class', "avicit.platform6.bpm.bpmreform.event.SynDataBefore");
		startEventListener.setAttribute('class', waSynDataBeforeClass);
		startEventListener.setAttribute('display', "no");
		var startListenerList = $(node).children("on[event='start']");
		if(startListenerList.length == 0){
			var conditionEndNode =   flowUtils.createElement('on');
			conditionEndNode.setAttribute('event', 'start');
			conditionEndNode.appendChild(startEventListener)
			node.appendChild(conditionEndNode);
		}else{
			startListenerList.append(startEventListener);
		}

	}
};

/**
 * 保存流程数据同步信息到xml
 * @param node
 */
MyTask.prototype.getDataSynFromXml = function(node){
	var _self = this;
	var $table = $("#"+_self.id+" #table-shujutongbu-value tbody");
	$table.empty();
	var dataDomId = _self.id+" #shujutongbu";
	var encodeDataDomId = encodeURIComponent(dataDomId);
	var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
	var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
	var dataObject = {};
	dataObject.dataDomId = dataDomId;
	dataObject.formId = globalformid;
	dataObject.process = process;
	$("#"+dataDomId).data("data-object", dataObject);
	$(node).children("dataSyns").children("dataSyn").each(function(){
		var dataSynStr = $(this).text();
		var synObject = JSON.parse(dataSynStr);
		$table.append(_self.getDataSynTableTr(synObject,dataDomId,encodeDataDomId));
	});
};

MyTask.prototype.getDataSynTableTr = function(synObject,dataDomId,encodeDataDomId){
	var _self = this;
	var _tr = $("<tr></tr>");
	var _td1 = $("<td></td>");
	_td1.append(synObject.dbTableName);
	var _hidden = $("<input type='hidden'/>");
	_hidden.val(JSON.stringify(synObject));
	_td1.append(_hidden);
	_tr.append(_td1);
	var _td2 = $("<td></td>");
	var typeName = "";
	if(synObject.type=="0"){
		typeName = "新增";
	}else if(synObject.type=="1"){
		typeName = "修改";
	}else if(synObject.type=="2"){
		typeName = "新增或修改";
	}else if(synObject.type=="3"){
		typeName = "删除";
	}
	_td2.append(typeName);
	_tr.append(_td2);
	var op = "<td><a href='javascript:void(0)' name='deleteData'><i class='iconfont icon-delete'></i></a>" +
		"<a href='javascript:void(0)' name='modifyData' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
	var _td3 = $(op);
	_td3.find("a[name='deleteData']").off("click").on("click",function() {
		$(this).parent().parent().remove();
	});
	_td3.find("a[name='modifyData']").off("click").on("click",function() {
		var $oldTr = $(this).parentsUntil("tr").parent();
		var synObjectStr = $oldTr.find("td:eq(0)").find("input").val();
		var synObject = JSON.parse(synObjectStr);
		$("#"+dataDomId).data("synObject",synObject);
		layer.config({
			extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
		layer.open({
			type:  2,
			area: [ "700px",  "600px"],
			title: "流程数据同步",
			skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
			shade:   0.3,
			maxmin: true, //开启最大化最小化按钮
			content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ProcessDataSynchronization/ProcessDataSynchronization.jsp?dataDomId="
				+encodeDataDomId+"&edit=1",
			btn: ['确定', '关闭'],
			yes: function(index, layero){
				var iframeWin = layero.find('iframe')[0].contentWindow;
				var validateResult = iframeWin.validateForm();
				if(validateResult){
					var synObject = iframeWin.getSynObject();
					$oldTr.replaceWith(_self.getDataSynTableTr(synObject,dataDomId,encodeDataDomId));
					layer.close(index);
				}
			},
			cancel: function(index){
				layer.close(index);
				$('html').addClass('fix-ie-font-face');
				setTimeout(function() {
					$('html').removeClass('fix-ie-font-face');
				}, 10);
			},
			success: function(layero, index){
			}
		});
	});
	_tr.append(_td3);
	return _tr;
};

/**
 * 获取字段关联权限配置
 * @param node
 */
MyTask.prototype.getFieldRelationAuthFromXml = function(fieldsRelationAuthJson){
	var _self = this;
	$("#" + _self.id+" #fieldRelationControlConfigValue").val(fieldsRelationAuthJson);
	var _table =  $("#"+_self.id+" #table-field-relation-control tbody");
	_table.empty();
	if(fieldsRelationAuthJson!=''){
		var fieldsRelationAuth = JSON.parse(fieldsRelationAuthJson);
		if(fieldsRelationAuth && fieldsRelationAuth.length){
			for(var i=0;i<fieldsRelationAuth.length;i++){

				var configObj = fieldsRelationAuth[i];
				var conditonValues = configObj.conditonValues;
				var conditionHtml = "";
				var conditonTitle = "";
				if(conditonValues && conditonValues.length){
					for(var j=0;j<conditonValues.length;j++){
						conditionHtml += conditonValues[j].controlTagName+" "+conditonValues[j].operName+" "+conditonValues[j].compareValueName+"<br>";
						conditonTitle += conditonValues[j].controlTagName+" "+conditonValues[j].operName+" "+conditonValues[j].compareValueName+"\n";
					}
				}
				var _tr = $("<tr></tr>");
				var _td1 = $("<td></td>");
				_td1.append(conditionHtml);
				_td1.attr("title",conditonTitle);
				_tr.append(_td1);
				var _td2 = $("<td></td>");
				var beControledFields = configObj.beControledFields;
				var beControledFieldsHtml = "";
				var beControledFieldsTitle = "";
				if(beControledFields && beControledFields.length){
					for(var m=0;m<beControledFields.length;m++){
						beControledFieldsHtml+=beControledFields[m].tagName;
						if(beControledFields[m].accessibility == "1"){
							beControledFieldsHtml+=" 可显示";
							beControledFieldsTitle+=" 可显示";
						}else{
							beControledFieldsHtml+=" 隐藏";
							beControledFieldsTitle+=" 隐藏";
						}
						if(beControledFields[m].hideRow == "1"){
							beControledFieldsHtml+=" 隐藏行";
							beControledFieldsTitle+=" 隐藏行";
						}else{
							beControledFieldsHtml+=" 不隐藏行";
							beControledFieldsTitle+=" 不隐藏行";
						}
						if(beControledFields[m].operability == "1"){
							beControledFieldsHtml+=" 可编辑";
							beControledFieldsTitle+=" 可编辑";
						}else{
							beControledFieldsHtml+=" 不可编辑";
							beControledFieldsTitle+=" 不可编辑";
						}
						if(beControledFields[m].required == "1"){
							beControledFieldsHtml+=" 必填";
							beControledFieldsTitle+=" 必填";
						}else{
							beControledFieldsHtml+=" 非必填";
							beControledFieldsTitle+=" 非必填";
						}
						beControledFieldsHtml+="<br>";
						beControledFieldsTitle+="\n";
					}
				}
				_td2.append(beControledFieldsHtml);
				_td2.attr("title",beControledFieldsTitle);
				_tr.append(_td1);
				_tr.append(_td2);
				_table.append(_tr);
			}
		}
	}
}
;
///<jscompress sourcefile="MyTransition.js" />
/**
 * transition extends MyBase
 */
function MyTransition(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "transition");
};
MyTransition.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyTransition.prototype.init = function() {
	this.initBase();
	var targetName = this.designerEditor.myCellMap.get(this.getCell().target.id).name;
	this.name = "to " + targetName;
	// this.alias = "to " + targetName;
	this.alias = "提交";
	this.initJBXX();// 初始化基本信息
	
	// 观察全局变量变化
	this.observeGlobalVariable();
	// 新建的时候同步一次全局属性
    this.processInstance().notify();
	this.initEvent();
	// 初始化流转事件
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-human-task-event");
};
/**
 * 为流程跟踪提供的特殊方法
 * @param xmlValue
 * @param rootXml
 */
MyTransition.prototype.initTracks = function(xmlValue, rootXml, tagId) {
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	rootXml.appendChild(this.createMxCell(tagId, xmlValue));// 创建mxCell
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyTransition.prototype.initLoad = function(xmlValue, rootXml, tagId) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.order = xmlValue.getAttribute("order");
	$("#" + this.id).find("#xian_shi_shun_xu").val(this.order);
	this.description = xmlValue.getAttribute("description");
	$("#" + this.id).find("#miao_shu").val(this.description);
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(tagId, xmlValue));// 创建mxCell
	
	// 观察全局变量变化
	this.observeGlobalVariable();
	// 路由条件
	this.initEvent();
	// 回写路由条件
	this.createConditionDom("zhi_xing_fang_shi", "table-executor", xmlValue);
	// 初始化流转事件
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-human-task-event");
	// 回写流转事件
	this.nodeEvent.setEventDom(xmlValue);
	//回写超时流转
	this.createTimeOutDom(xmlValue);
	// 参与者-候选人
	this.setUserSelectDom({userSelectContainer :'draft-candidate-container' ,dataField:'draft-candidate-data-field',textField:'draft-candidate-text-field'}, xmlValue);
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyTransition.prototype.getOtherAttr = function(node) {
	this.putAttr("to", this.designerEditor.myCellMap.get(this.cell.target.id).name, node);
	/*其他*/
	this.putAttr("order", $.trim($('#' + this.id).find('#xian_shi_shun_xu').val()), node);
	this.putAttr("description", $.trim($('#' + this.id).find('#miao_shu').val()), node);
	// 获取路由条件xml
	this.setConditionXml("zhi_xing_fang_shi", "table-executor",  node); 
	// 获取流转事件xml
	this.nodeEvent.setEventXml(node, "event");
	//超时流转xml
	this.saveTimeOutXml(node);
	// 选人
	this.setUserSelectXml({userSelectContainer :'draft-candidate-container' ,dataField:'draft-candidate-data-field',textField:'draft-candidate-text-field'}, node);
};
/**
 * 重写name监听事件，不需要往连线上写值
 * 
 * @param value
 */
MyTransition.prototype.labelChanged = function(value) {
	this.alias = value;
};
/**
 * 构建mxCell
 */
MyTransition.prototype.createMxCell = function(tagId, xmlValue) {
	//流程图的处理
	var targetName = this.name.split(" ")[1];
	var targetNode =  this.designerEditor.myLoadMap.get(targetName);
	if(targetNode.tagName == "fork" || targetNode.tagName == "join" || targetNode.tagName == "foreach"){
		this.designerEditor.myCellMap.get(tagId).addForkJoin(targetNode.id);
	}
	
	if(this.designerEditor.useNewDesigner){
		if(flowUtils.notNull(xmlValue.firstElementChild)){
			return xmlValue.firstElementChild;
		}else{
			return xmlValue.firstChild;
		}
	}
	var mxCell = flowUtils.createElement("mxCell");
	var mxGeometry = flowUtils.createElement("mxGeometry");
	mxCell.setAttribute("id", this.id);
	mxCell.setAttribute("value", "");
	mxCell.setAttribute("edge", "1");
	mxCell.setAttribute("parent", "1");
	mxCell.setAttribute("source", tagId);
	mxCell.setAttribute("target", this.designerEditor.myLoadMap.get(targetName).id);

	mxGeometry.setAttribute("relative", "1");
	mxGeometry.setAttribute("as", "geometry");

	//扩展，如果记录了连线位置，则给point
	var mxCellG = this.getmxCellG();
	if(flowUtils.notNull(mxCellG)){
		var mxArray=flowUtils.createElement("Array");
		mxArray.setAttribute("as", "points");
		var mxPoint = flowUtils.createElement("mxPoint");
		mxPoint.setAttribute("x", mxCellG.x);
		mxPoint.setAttribute("y", mxCellG.y);
		mxArray.appendChild(mxPoint);
		mxGeometry.appendChild(mxArray);
	}
	
	mxCell.appendChild(mxGeometry);
	return mxCell;
};
/**
 * 重写解析位置G的方法
 * 
 * @returns {String}
 */
MyTransition.prototype.getG = function() {
	//扩展，如果有自定义连线位置，则记录
	var mxGeometry = this.cell.getGeometry();
	if(flowUtils.notNull(mxGeometry.points) && mxGeometry.points.length > 0){
		var point = mxGeometry.points[0];
		var rs = point.x + "," + point.y + ",-5,-22";
		return rs;
	}
	return "-5,-22";
};
/**
 * 解析字符串G，连线重写了该方法
 * 
 * @returns {object}
 */
MyTransition.prototype.getmxCellG = function() {
	var arr = this.g.split(",");
	if(arr.length == 4){
		var result = {};
		result.x = arr[0];
		result.y = arr[1];
		return result;
	}else{
		return null;
	}
};

/**
 * 订阅了全局节点中变量的变化
 * @param data   json数据
 * @param context	MyProcess 上下文实例
 */
MyTransition.prototype.updateGlobalVariable = function(data, context) {
	var _self = this;
	var $yinru = $("#"+_self.id+" select[name='yin_ru_bian_liang']");
	$yinru.empty();
	$yinru.append("<option selected value='0'>引入变量</option>");
	 var varContent = data;
	 if(varContent.length > 0) {
		 // 添加下拉框
		for(var i = 0; i < varContent.length ; i++) {
			//var option = "<option>"+varContent[i].name+"("+varContent[i].type+" "+varContent[i].initExpr+")"+"</option>"
            var option = "<option>#{"+varContent[i].name+"}"+"</option>";
			$yinru.append(option);
		}
	 }
}

MyTransition.prototype.observeGlobalVariable = function(){
	var _self = this;
	_self.processInstance().observers.add(_self);
};

MyTransition.prototype.initEvent = function () {
	var _self = this;
	// 人工节点 候选人事件
	$("#"+this.id+" button[name=btn-add-candidate]").on("click",function(){
		var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
		var option = {type:'userSelect',
			userSelectContainer :'draft-candidate-container' ,
			dataField:'draft-candidate-data-field',
			textField:'draft-candidate-text-field',
			topId:_self.id,
			processId:process.id,
			callback:function(data){
				//console.log("-----------");
				//console.log(data);
				//console.log("=============");
			}};
		_self.candidateSelect = new UserSelect(option);
	});
	 $("#"+_self.id+" select[name='yin_ru_bian_liang']").on('change', function() {
		 	if(this.value == 0) {
		 		return;
		 	}
         var that = $(this);
         var target = that.parent().parent().siblings("div").find("textarea")
         var c = target.val().length == 0 ? that.val() : target.val() + "," + that.val();
         target.val(c);
    });
	 
	$("#"+_self.id+" button[name='button_chu_fa_gui_ze']").on("click", function(){
	        
	        new TransitionTimeOut({id:_self.id,domId:_self.id+" #chu_fa_gui_ze",callback:function(data){
	            
	        }});
	    });
	$("#"+_self.id+" button[name='btn-expr-config']").on("click", function(){
		var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
		var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
        new ExprConfig({id:_self.id,domId:_self.id+" #expr-config-value-new",globalformid:globalformid,
            processFlag:false,
        	process:process,
        	callback:function(data){
          
        }});
    });
	
}


/**** 	启动条件各种事件开始	 ****/

/**
 * 初始化：启动条件
 * @param executorDomId  执行方式domId
 * @param tableExecutorDomId	数据table domId
 * @param tagNodeXml	
 */
MyTransition.prototype.createConditionDom = function(executorDomId, tableExecutorDomId, tagNodeXml) {
	var self = this;
	$(tagNodeXml).children("conditions").each(function(){
		var type = $(this).attr("type");
		$('#' + self.id).find('#' + executorDomId).val(type);
		var $tbody = $("#" + self.id).find("#" +  tableExecutorDomId).find("tbody");
		$(this).children("condition").each(function(i){
			var idx = i;
            var c_type = $(this).attr("type");
			var computeRes = $(this).attr("computeRes");
			var value = $(this).text();
			if (computeRes != null && computeRes != ''){
                // 该方法中的参数是jquery参数
                EventThatInsertStartConditionContentIntoTableWhenInit($tbody, c_type, $("<input value='"+computeRes +"'longJson='"+value+"'/>"));
			} else {
                // 该方法中的参数是jquery参数
                EventThatInsertStartConditionContentIntoTableWhenInit($tbody, c_type, $("<input value='"+value+"'/>"));
			}

		});
	});
};

MyTransition.prototype.modifyStartCondition = function (obj) {
		var $modifyBtn = $(obj);
		var $targetTr = $modifyBtn.parent().parent();
		var $tabName = $targetTr.find("td:eq(1)");
		var tabIndex =  $tabName.text().toLowerCase()== "expr" ? 0 : 1;
		var $val =  $targetTr.find("td:eq(2)");
		// 切换tab
		$modifyBtn.find("div[name='demoCont'] ul").find("li:eq("+tabIndex+")").click();
		// 先找到顶层的div 
		var $top = $modifyBtn.parents("table[name=table-executor]").parent().parent();
		// 进行tab切换
		this.changeStartConditionTab($top.find("ul:eq(0)").find("li").eq(tabIndex));
		// 赋值
		$top.find("ul:eq(1)")
				.find("li")
				.eq(tabIndex)
				.find(tabIndex == 0? "textarea" : "input")
				.val($val.text().trim());

		// 查找添加buttion
		var $oldAddButton = $top.find("ul:eq(1)")
				.find("li")
				.eq(tabIndex).find("button[name='btn-add-start-condition']");
		// 更改为 保存添加按钮
		var $oldBtn = $oldAddButton.clone(true);
		$oldAddButton.off("click").text("保存").on("click", function() {
            var $content = tabIndex == 0 ?  $(this).parent().parent().parent().find("textarea") :
           	 $(this).parent().parent().parent().find("input");
            if ($content && $content.val().length != 0) {
            	$val.text($content.val());
            	$content.val("");
				// 恢复原来的添加按钮
				$(this).replaceWith($oldBtn);           	
            } else {
                alert("您还没输入内容");
            }
            return false;
		});
 }
MyTransition.prototype.changeStartConditionTab = function (obj) {
		var that = $(obj);
    //切换标签
    that.addClass('active')
        .siblings('li')
        .removeClass('active')
        .parent('.global-attrs-tab')
        .siblings('.tab-cont')
        .find('>li:eq(' + that.index() + ')')
        .addClass('active')
        .siblings('li')
        .removeClass('active');
      // 选中input
     that.find("input").prop("checked",true);
     
}

MyTransition.prototype.saveTimeOutXml = function(node) {
	var _self = this;
	var cfgz = $("#"+_self.id+" #chu_fa_gui_ze").val();
	if(cfgz!=''){
		var timer = flowUtils.createElement("timer");
		timer.setAttribute("duedate", cfgz);
		node.appendChild(timer);
	}
}

MyTransition.prototype.createTimeOutDom = function(xmlValue){
	var timer = $(xmlValue).children("timer");
	if(timer!=null && timer.length>0){
		var duedate = timer[0].getAttribute("duedate");
		$("#"+this.id+" #chu_fa_gui_ze").val(duedate);
	}
}

/**** 	启动条件各种事件结束	 ****/
;
///<jscompress sourcefile="MyWs.js" />
/**
 * ws extends MyBase
 */
function MyWs(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "ws");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_webservice.png;";
};
MyWs.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyWs.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getWs();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-ws-node");
    this.initEvent();
};
/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyWs.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setWs(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	this.initEvent();
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-ws-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);

    $("#"+this.id+" #inputValueBackVar").val(this.getAttr(xmlValue,"var"));
    $("#"+this.id+" #inputTextBackVar").val(this.getAttr(xmlValue,"var"));
    $("#"+this.id+" #jgzhl").val(this.getAttr(xmlValue,"resultConvertClass"));
    $("#"+this.id+" #dingzhishixian").val(this.getMeta(xmlValue,"wsClient"));
    var sync = $.trim(this.getMeta(xmlValue,"sync"));
    if(sync == "true") {
    	$("#"+this.id +" #shifoutongbu").trigger("click");
	}
    var serviceId = this.getAttr(xmlValue,"serviceId");
    if(flowUtils.notNull(serviceId)){
    	$("#"+this.id+" #serviceId").val(serviceId);
    	$("#"+this.id+" #serviceName").val(this.getAttr(xmlValue,"serviceName"));
    	$("#"+this.id+" #serviceType").val(this.getAttr(xmlValue,"serviceType"));
    	var serviceType = this.getAttr(xmlValue,"serviceType");
    	if(serviceType=="restful"){
			 $("#"+this.id+" #paramType").val(this.getAttr(xmlValue,"paramType"));
			 var paramType = this.getAttr(xmlValue,"paramType");
			 if(paramType=="text"){
				 $("#"+this.id+" #paramTableDiv").hide();
				 var $table =  $("#"+this.id+" table[name='methodParamsTable'] tbody");
				 $table.empty();
				 $("#"+this.id+" #paramTextDiv").attr("style","display:block;");
				 this.setParamText(xmlValue);
			 }else{
				 $("#"+this.id+" #paramTableDiv").attr("style","display:block;");
				 $("#"+this.id+" #paramTextDiv").hide();
				 this.setParamTable(xmlValue);
			 }
   	    }else{
			  $("#"+this.id+" #paramTableDiv").attr("style","display:block;");
			  $("#"+this.id+" #paramTextDiv").hide();
			  this.setParamTable(xmlValue);
   	    }
    	this.hiddenServiceItems();
    }else{
    	$("#"+this.id+" #fuwudizhi").val(this.getAttr(xmlValue,"url"));
        $("#"+this.id+" #zhixingfangfa").val(this.getAttr(xmlValue, "method"));
        $("#"+this.id+" #yonghuming").val(this.getMeta(xmlValue,"accessUser"));
        $("#"+this.id+" #mima").val(this.getMeta(xmlValue,"accessPwd"))
    }
	this.methodClass.getDom(xmlValue);


};
/**
 * 组装processXML的自定义信息
 *
 * @param node
 */
MyWs.prototype.getOtherAttr = function(node) {
	// 获取事件xml
	this.nodeEvent.setEventXml(node, "");

	this.putAttr("url",$("#"+this.id+" #fuwudizhi").val(), node);
    this.putAttr("method",$("#"+this.id+" #zhixingfangfa").val(), node);
    this.putAttr("var",$("#"+this.id+" #inputValueBackVar").val(), node);
    this.putAttr("serviceId", $("#"+this.id+" #serviceId").val(), node);
    this.putAttr("serviceName", $("#"+this.id+" #serviceName").val(), node);
    this.putAttr("serviceType", $("#"+this.id+" #serviceType").val(), node);
    this.putAttr("paramType", $("#"+this.id+" #paramType").val(), node);
    this.putAttr("paramText", $("#"+this.id+" #paramText").val(), node);
    this.getParamTextValues(node);
    this.putAttr("resultConvertClass", $("#"+this.id+" #jgzhl").val(), node);
    this.addMeta("accessUser",$("#"+this.id+" #yonghuming").val(),node);
    this.addMeta("accessPwd",$("#"+this.id+" #mima").val(),node);
    this.addMeta("wsClient",$("#"+this.id+" #dingzhishixian").val(),node);
    this.addMeta("error","break",node);
    this.addMeta("sync",$("#"+this.id+" #shifoutongbu").is(":checked"),node);
	this.methodClass.getXml(node);
	this.getParamValues(node);

};

MyWs.prototype.initEvent = function() {
    var _self  = this;
    $("#"+_self.id+" button[name='button-BackVar']").on("click", function(){
        var process = null;
        var values = _self.designerEditor.myCellMap.values();
        $.each(values, function(i, n){
            if(n.tagName == "process"){
                process = n;
            }
        });
        new ProcessVariable({dataDomId:_self.id+" #inputValueBackVar",showDomId:_self.id+" #inputTextBackVar", callback:function(data){
            var d = data[0];
            $("#"+_self.id+" #inputValueBackVar").val(d.name);
            $("#"+_self.id+" #inputTextBackVar").val(d.name);
        },process:process,
            multiple:false});
    });

    _self.methodClass = new MethodAndClass({id:_self.id, buttonId:"buttonAddMethodClass", tableId:_self.id+" #table-flow-add-methodClass",type:"arg", callback:function(data){
        var d = data[0];
    }});


    $("#"+this.id+" button[name=serviceSelect]").on("click",function(){
    	var option = {
			 selectContainer :'webservice-container' ,
			 dataField:'serviceId',
			 textField:'serviceName',
			 topId:_self.id,
			 processId:process.id,
		 	callback:function(serviceType,data){
        	 _self.hiddenServiceItems();
        	 $("#"+_self.id+" #serviceType").val(serviceType);
        	 if(serviceType=="restful"){
        		 $("#"+_self.id+" #paramType").val(data.paramType);
        		 if(data.paramType=="text"){
        			 $("#"+_self.id+" #paramTableDiv").hide();
					 var $table =  $("#"+_self.id+" table[name='methodParamsTable'] tbody");
					 $table.empty();
            		 $("#"+_self.id+" #paramTextDiv").attr("style","display:block;");
            		 $("#"+_self.id + " #paramTextValueType").val("text");
					 $("#"+_self.id + " input[name='paramTextValueTypeCheck']").prop("checked",false);
					 var selectHtml = _self.getFieldsSelectHtml();
					 $("#"+_self.id + " #selectFieldDiv").empty();
            		 $("#"+_self.id + " #selectFieldDiv").append(selectHtml);
					 $("#"+_self.id + " #selectFieldDiv").find("select[name='field']").hide();
					 $("#"+_self.id + " #paramTextDiv").find("#paramText").attr("style","display:block;");
					 $("#"+_self.id + " input[name='paramTextValueTypeCheck']").on("change",function(){
						 if($(this).is(':checked')){
							 $("#"+_self.id + " #paramTextValueType").val("select");
							 $(this).parent().find(" select[name='field']").attr("style","display:block;");
							 $(this).parent().find(" #paramText").hide();
						 }else{
							 $("#"+_self.id + " #paramTextValueType").val("text");
							 $(this).parent().find("select[name='field']").hide();
							 $(this).parent().find("#paramText").attr("style","display:block;");
						 }
					 });

        		 }else{
        			 $("#"+_self.id+" #paramTableDiv").attr("style","display:block;");
            		 $("#"+_self.id+" #paramTextDiv").hide();
					 $("#"+_self.id+" #paramText").val();
            		 _self.initParamTable(data,'methodParamsTable');
        		 }
        	 }else{
        		 $("#"+_self.id+" #paramTableDiv").attr("style","display:block;");
        		 $("#"+_self.id+" #paramTextDiv").hide();
        		 _self.initParamTable(data,'methodParamsTable');
        	 }
		 }};
        _self.serviceSelect = new WebService(option);
    });

};

MyWs.prototype.hiddenServiceItems = function(){
	$("#"+this.id+" #fuwudizhi").attr("disabled",true);
    $("#"+this.id+" #zhixingfangfa").attr("disabled",true);

    $("#"+this.id+" #yonghuming").attr("disabled",true);
    $("#"+this.id+" #mima").attr("disabled",true);
};

MyWs.prototype.initParamTable = function(data,tableName){
	var _self = this;
	var paramNames = data.paramName;
	if(paramNames!=null && paramNames != ''){
		var paramArr = paramNames.split(",");
		var $table =  $("#"+_self.id+" table[name='"+tableName+"'] tbody");
		$("#"+_self.id+" table[name='"+tableName+"'] tbody tr").remove();
		var selectHtml = _self.getFieldsSelectHtml();
		for(var i=0;i<paramArr.length;i++){
			var $tr = $("<tr></tr>");
			var $td1 = $("<td width='30%'></td>");
			$td1.append(paramArr[i]);
			$tr.append($td1);
			var $td2 = $("<td></td>");
			var $checkbox = "<input type='checkbox' name='valueTypeCheck' />&nbsp;选择";
			var $hideden = "<input type='hidden' name='valueType' >";
			var $input = "<input type='text' class='form-control' name='"+paramArr[i]+"' value='' title='"+paramArr[i]+"'/>";
			$td2.append($hideden);
			$td2.append($checkbox);
			$td2.append($input);
			$td2.append(selectHtml);
			$td2.find("input[type='checkbox']").on("change",function(){
				if($(this).is(':checked')){
					$(this).parent().find("input[type='hidden']").val("select");
					$(this).parent().find("input[type='text']").hide();
					$(this).parent().find("select[name='field']").attr("style","display:block;");
				}else{
					$(this).parent().find("input[type='hidden']").val("text");
					$(this).parent().find("input[type='text']").attr("style","display:block;");
					$(this).parent().find("select[name='field']").hide();
				}
			});
			$tr.append($td2);
			$table.append($tr);
		}
	}
};

MyWs.prototype.getParamValues = function(node){
	var _self = this;
	$("#"+_self.id+" #methodParamsTable input").each(function(){
		if(this.type=='text'){
			var paramName = this.name;
			var paramVal = this.value;
			var param = flowUtils.createElement("param");
			param.setAttribute("name", paramName);
			param.setAttribute("value", paramVal);
			var valueType = $(this).parent().find("input[name='valueType']");
			if(flowUtils.notNull(valueType)){
				if(valueType.val() == "select"){
					param.setAttribute("valueType", "select");
					var selectedObj = $(this).parent().find("select[name='field']").find("option:selected");
					var fieldType = selectedObj.attr("fieldType");
					param.setAttribute("fieldType", fieldType);
					var fieldId = selectedObj.attr("fieldId");
					param.setAttribute("fieldId", fieldId);
					var fieldName = selectedObj.attr("fieldName");
					param.setAttribute("fieldName", fieldName);
					var colType = selectedObj.attr("colType");
					param.setAttribute("colType", colType);
					var formId = selectedObj.attr("formId");
					param.setAttribute("formId", formId);
					var tableName = selectedObj.attr("tableName");
					param.setAttribute("tableName", tableName);
				}else{
					param.setAttribute("valueType", "text");
				}
			}else{
				param.setAttribute("valueType", "text");
			}
			node.appendChild(param);
		}
	});
};

MyWs.prototype.getParamTextValues = function(node){
	var _self = this;
	var paramType = $("#"+_self.id+" #paramType").val();
	if(paramType == "text"){
		var paramTextValueType = $("#"+_self.id+" #paramTextValueType").val();
		if(paramTextValueType == "select"){
			this.putAttr("paramTextValueType", "select", node);
			var param = flowUtils.createElement("paramText");
			var $select = $("#"+_self.id + " #selectFieldDiv select[name='field']").find("option:selected");
			var fieldType = $select.attr("fieldType");
			param.setAttribute("fieldType", fieldType);
			var fieldId = $select.attr("fieldId");
			param.setAttribute("fieldId", fieldId);
			var fieldName = $select.attr("fieldName");
			param.setAttribute("fieldName", fieldName);
			var colType = $select.attr("colType");
			param.setAttribute("colType", colType);
			var formId = $select.attr("formId");
			param.setAttribute("formId", formId);
			var tableName = $select.attr("tableName");
			param.setAttribute("tableName", tableName);
			node.appendChild(param);
		}else{
			this.putAttr("paramTextValueType", "text", node);
		}
	}
};

MyWs.prototype.setParamText = function(node){
	var _self = this;
	var paramTextValueType = _self.getAttr(node,"paramTextValueType");
	var selectHtml = _self.getFieldsSelectHtml();
	$("#"+_self.id + " #selectFieldDiv").append(selectHtml);
	if(paramTextValueType == "select"){
		$("#"+_self.id + "#paramTextValueType").val("select");
		$("#" + _self.id +" #paramText").hide();
		$("#" + _self.id + " select[name='field']").attr("style","display:block;");
		$("#"+_self.id + " input[name='paramTextValueTypeCheck']").prop("checked",true);
		if($(node).children("paramText") && $(node).children("paramText").length){
			$(node).children("paramText").each(function(){
				var _selfNode = this;
				var fieldId = $.trim(_selfNode.getAttribute("fieldId"));
				$("#" + _self.id + " select[name='field']").find("option:contains('"+fieldId+"')").attr("selected",true);
			});
		}
	}else{
		$("#"+_self.id + "#paramTextValueType").val("text");
		$("#"+_self.id+" #paramText").val(_self.getAttr(node,"paramText"));
		$("#" + _self.id + " select[name='field']").hide();
		$("#" + _self.id +" #paramText").attr("style","display:block;");
		$("#"+_self.id + " input[name='paramTextValueTypeCheck']").prop("checked",false);
	}
	$("#"+_self.id + " input[name='paramTextValueTypeCheck']").on("change",function(){
		if($(this).is(':checked')){
			$("#"+_self.id + " #paramTextValueType").val("select");
			$(this).parent().find(" select[name='field']").attr("style","display:block;");
			$(this).parent().find(" #paramText").hide();
		}else{
			$("#"+_self.id + " #paramTextValueType").val("text");
			$(this).parent().find("select[name='field']").hide();
			$(this).parent().find("#paramText").attr("style","display:block;");
		}
	});
};

MyWs.prototype.setParamTable = function(node){
	var _self = this;
	var $table =  $("#"+_self.id+" table[name='methodParamsTable'] tbody");
	if($(node).children("param") && $(node).children("param").length){
		var selectHtml = _self.getFieldsSelectHtml();
		$(node).children("param").each(function(){
			var _selfNode = this;
			var varName = $.trim(_selfNode.getAttribute("name"));
			var varValue = $.trim(_selfNode.getAttribute("value"));
			var valueType = _selfNode.getAttribute("valueType");
			var fieldType = _selfNode.getAttribute("fieldType");
			var fieldId = _selfNode.getAttribute("fieldId");
			var fieldName = _selfNode.getAttribute("fieldName");
			var colType = _selfNode.getAttribute("colType");
			var formId = _selfNode.getAttribute("formId");
			var tableName = _selfNode.getAttribute("tableName");


			var $tr = $("<tr></tr>");
			var $td1 = $("<td width='30%'></td>");
			$td1.append(varName);
			$tr.append($td1);
			var $td2 = $("<td></td>");
			var $checked = "";
			if(valueType == "select"){
				$checked = "checked";
			}
			var $checkbox = "<input type='checkbox' name='valueTypeCheck' "+$checked+"/>&nbsp;选择&nbsp;";
			var $hideden = "<input type='hidden' name='valueType' value='"+valueType+"'>";
			var $input = "<input type='text' class='form-control' name='"+varName+"' value='"+varValue+"' title='"+varName+"'/>";
			$td2.append($hideden);
			$td2.append($checkbox);
			$td2.append($input);
			$td2.append(selectHtml);
			if(valueType == "select"){
				$td2.find("input[type='text']").hide();
				$td2.find("select[name='field']").attr("style","display:block;");
				$td2.find("select[name='field']").find("option:contains('"+fieldId+"')").attr("selected",true);
			}else{
				$td2.find("input[type='text']").attr("style","display:block;");
				$td2.find("select[name='field']").hide();
			}
			$td2.find("input[type='checkbox']").on("change",function(){
				if($(this).is(':checked')){
					$(this).parent().find("input[type='hidden']").val("select");
					$(this).parent().find("input[type='text']").hide();
					$(this).parent().find("select[name='field']").attr("style","display:block;");
				}else{
					$(this).parent().find("input[type='hidden']").val("text");
					$(this).parent().find("input[type='text']").attr("style","display:block;");
					$(this).parent().find("select[name='field']").hide();
				}
			});
			$tr.append($td2);
			$table.append($tr);
			//$table.find("input[type='text']").attr("style","");
		});


	}

};

MyWs.prototype.getFieldsSelectHtml = function(){
	var _self = this;
	var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
	var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
	var selectHtml = '';
	selectHtml+='<select class="form-control input-sm"  name="field"  title=""  style="display: none;">';
	selectHtml+= '<option value="">&nbsp;&nbsp;&nbsp;请选择</option>';
	selectHtml+="<optgroup label='" + "流程常量" + "'></optgroup>";
	selectHtml+="<option value='currPerfomer' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='currPerfomer'"
		+ " fieldName='" + "当前节点处理人" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;当前节点处理人</option>";
	selectHtml+="<option value='currPerfomerCurrDept' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='currPerfomerCurrDept'"
		+ " fieldName='" + "当前节点处理人" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;节点处理人当前部门</option>";
	selectHtml+="<option value='starter' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='starter'"
		+ " fieldName='" + "拟稿人" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;拟稿人</option>";
	selectHtml+="<option value='starterCurrDept' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='starterCurrDept'"
		+ " fieldName='" + "拟稿人部门" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;拟稿人部门</option>";
	selectHtml+="<option value='processInstanceId' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='processInstanceId'"
		+ " fieldName='" + "流程实例ID" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;流程实例ID</option>";
	selectHtml+="<option value='formId' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='formId'"
		+ " fieldName='" + "表单ID" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;表单ID</option>";
	selectHtml+="<option value='processDefId' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='processDefId'"
		+ " fieldName='" + "流程定义ID" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;流程定义ID</option>";
	selectHtml+="<option value='activityName' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='activityName'"
		+ " fieldName='" + "当前节点名称" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;当前节点名称</option>";

	avicAjax.ajax({
		url: "platform/bpm/designer/getProcessFormFieldsForVar",
		data: "globalformid=" + globalformid,
		type: "post",
		async: false,
		dataType: "json",
		success: function (backData) {
		    var formFields = null;
		    if(flowUtils.notNull(backData.fields)){
                formFields = JSON.parse(backData.fields);
            }
			if(flowUtils.notNull(formFields)){
				selectHtml+="<optgroup label='" + "主表字段" + "'></optgroup>";
				for(var i=0;i<formFields.length;i++){
					var tableName = backData.tableName;
					//外部表字段表名加@区分
					if(formFields[i].domdataId){
						tableName = "@"+formFields[i].tableName;
					}
					selectHtml+="<option value='" + formFields[i].colName + "' "
						+ " colType='" + formFields[i].colType + "'"
						+ " fieldType='2'"
						+ " fieldId='" + formFields[i].colName + "'"
						+ " fieldName='" + formFields[i].colLabel + "'"
						+ " formId='" + globalformid + "'"
						+ " tableName='" + tableName + "'>&nbsp;&nbsp;&nbsp;" + formFields[i].colLabel + "(" + formFields[i].colName + ")" + "</option>";
				}
			}
			//处理关联子表的字段
			var subMap = backData.subFieldsMap;
			var key = null;//子表名称
			var value = null;//子表字段内容
			if(flowUtils.notNull(subMap)){
				for (var entry in subMap) {
					//key = entry;
					key = "子表字段" + "(" + entry + ")";
					value = subMap[entry];
					if (value != null && value != '') {
						var subFormFields = JSON.parse(value);
						if (subFormFields.length > 0) {
							selectHtml+="<optgroup label='" + key + "'></optgroup>";
						}
						for (var j = 0; j < subFormFields.length; j++) {
							selectHtml+="<option value='" + subFormFields[j].colName + "' "
								+ " subFlag='true'"
								+ " colType='" + subFormFields[j].colType + "'"
								+ " fieldType='3'"
								+ " fieldId='" + subFormFields[j].colName + "'"
								+ " fieldName='" + subFormFields[j].colLabel + "'"
								+ " tableName='" + entry + "'"
								+ " formId='" + globalformid + "'"
								+ " mainTableName='" + backData.tableName + "'"
								+ " fieldShowType='" + subFormFields[j].elementType + "'>&nbsp;&nbsp;&nbsp;" + subFormFields[j].colLabel + "(" + subFormFields[j].colName + ")" + "</option>";
						}
					}

				}
			}

		}
	});
	selectHtml+= '</select>';
	return selectHtml;
};
;
///<jscompress sourcefile="MyRules.js" />
/**
 * rules extends MyBase
 */
function MyRules(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "rules");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_rule.png;";
};
MyRules.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyRules.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getRules();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyRules.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setRules(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	this.setDomValByMeta("rulesPath", xmlValue, "rulesPath");
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MyRules.prototype.getOtherAttr = function(node) {
	this.setXmlMetaByVal("rulesPath", node, "rulesPath");
};;
///<jscompress sourcefile="MyText.js" />
/**
 * text extends MyBase
 */
function MyText(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "text");
};
MyText.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyText.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getText();
	this.labelChanged("添加文本");
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyText.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setText(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MyText.prototype.getOtherAttr = function(node) {
};
MyText.prototype.afterShowProp = function() {
	var cell = this.getCell();
	var color = this.designerEditor.getStyleValue('fontColor', cell);
	if(color){
		$('#' + this.id).find('#textColor').val(color);
	}
	var size = this.designerEditor.getStyleValue('fontSize', cell);
	if(size){
		$('#' + this.id).find('#textSize').val(size + "");
	}
};
;
///<jscompress sourcefile="MyRest.js" />
/**
 * rest extends MyBase
 */
function MyRest(designerEditor, id) {
    MyBase.call(this, designerEditor, id, "rest");
    this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_rest.png;";
};
MyRest.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyRest.prototype.init = function() {
    this.initBase();
    this.name = this.tagName + this.designerEditor.countUtils.getRest();
    this.labelChanged(this.name);
    this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyRest.prototype.initLoad = function(xmlValue, rootXml) {
    this.initBase();
    this.name = xmlValue.getAttribute("name");
    this.alias = $.trim(xmlValue.getAttribute("alias"));
    this.g = xmlValue.getAttribute("g");
    this.designerEditor.countUtils.setRest(this.resolve());// 设置自增长数字
    this.initJBXX();// 初始化基本信息
    /*****以上是公共的*******/
    /*****以下是公共的*******/
    rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
    this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 组装processXML时的自定义信息
 *
 * @param node
 */
MyRest.prototype.getOtherAttr = function(node) {
};;
///<jscompress sourcefile="DesignerEditor.src.js" />
/**
 * 编辑器
 */
function DesignerEditor() {
};
// 编辑器
DesignerEditor.prototype.editor = null;
DesignerEditor.prototype.setEditor = function(editor) {
	this.editor = editor;
};
// 定义存储数据的map对象
DesignerEditor.prototype.myCellMap = null;
// 流程key
DesignerEditor.prototype.processKey = null;
// 临时map，按名称记录对象
DesignerEditor.prototype.myLoadMap = null;
// 自增序列
DesignerEditor.prototype.countUtils = null;
// 当前对象ID
DesignerEditor.prototype.myCurCellId = null;
// 全局属性区域
DesignerEditor.prototype.homeDiv = null;
// 节点属性区域
DesignerEditor.prototype.profileDiv = null;
// controller
DesignerEditor.prototype.controlPath = "platform/bpm/designer/";
// 是否是新的设计器编辑的流程，意味着加载解析方式的不同
DesignerEditor.prototype.useNewDesigner = false;
// 横向泳道
DesignerEditor.prototype.swimlane1 = 0;
// 纵向泳道
DesignerEditor.prototype.swimlane2 = 0;
// 校验后是否允许保存
DesignerEditor.prototype.allowSave = true;
//是否自由流程
DesignerEditor.prototype.isUflow = false;

/**
 * 初始化
 */
DesignerEditor.prototype.init = function() {
	var _self = this;
	this.myCellMap = new Map();
	this.myLoadMap = new Map();
	this.countUtils = new CountUtils();
	this.homeDiv = $("#homeDiv");
	this.profileDiv = $("#profileDiv");
	if (_type == 3) {
		// 新建
		this.processKey = _id;// key值和id值一样
		var myProcess = new MyProcess(this, this.processKey);
		myProcess.init();
		this.myCellMap.put(this.processKey, myProcess);
		//流程名称
		if(flowUtils.notNull(_name)){
			myProcess.alias = _name;
			$("#" + this.processKey).find("#liu_cheng_ming_cheng").val(_name);
		}
		// 初始化泳道
		if (_isUflow == "1" && flowUtils.notNull(_swimlane)) {
			_swimlane = $.trim(_swimlane);
			_swimlane = _swimlane.replaceAll("，",",");
			_swimlane = _swimlane.replaceAll(" ",",");
			var swimlaneArr = _swimlane.split(",");
			var template = this.editor.templates["swimlane1"];
			var startTemplate = this.editor.templates["start"];
			var taskTemplate = this.editor.templates["task"];
			var endTemplate = this.editor.templates["end"];
			
			var startCell = this.editor.graph.cloneCells([ startTemplate ])[0];
			var endCell = this.editor.graph.cloneCells([ endTemplate ])[0];
			var lastTaskCell = null;
			
			for (var i = 0; i < swimlaneArr.length; i++) {
				if(!flowUtils.notNull(swimlaneArr[i])){
					continue;
				}
				
				var cell = this.editor.graph.cloneCells([ template ])[0];
				this.editor.addVertex(null, cell, 10, 10 + i * 110);
				$("#" + cell.id).find("#xian_shi_ming_cheng").val(swimlaneArr[i]);
				this.myCellMap.get(cell.id).labelChanged(swimlaneArr[i]);
				
				if(i == 0){
					this.editor.addVertex(cell, startCell, cell.getGeometry().x + 50, cell.getGeometry().y + (cell.getGeometry().height - startCell.getGeometry().height)/2);
				}
				var taskCell = this.editor.graph.cloneCells([ taskTemplate ])[0];
				this.editor.addVertex(cell, taskCell, startCell.getGeometry().x + startCell.getGeometry().width + 60, cell.getGeometry().y + (cell.getGeometry().height - taskCell.getGeometry().height)/2);
				$("#" + taskCell.id).find("#xian_shi_ming_cheng").val(swimlaneArr[i]);
				this.myCellMap.get(taskCell.id).labelChanged(swimlaneArr[i]);
				
				if(lastTaskCell == null){
					this.editor.graph.addEdge(this.editor.createEdge(startCell, taskCell), null, startCell, taskCell);
					this.editor.graph.selectVertices(cell);
					this.editor.execute("alignCellsMiddle");
					this.editor.execute("selectNone");
				}else{
					this.editor.graph.addEdge(this.editor.createEdge(lastTaskCell, taskCell), null, lastTaskCell, taskCell);
				}
				lastTaskCell = taskCell;
				
				if(i == (swimlaneArr.length - 1)){
					this.editor.addVertex(cell, endCell, taskCell.getGeometry().x + taskCell.getGeometry().width + 60, cell.getGeometry().y + (cell.getGeometry().height - endCell.getGeometry().height)/2);
					this.editor.graph.addEdge(this.editor.createEdge(taskCell, endCell), null, taskCell, endCell);
					this.editor.graph.selectVertices(cell);
					this.editor.execute("alignCellsMiddle");
					this.editor.execute("selectNone");
				}
			}
			this.editor.execute("autoLayout");
		}
		//自由流程
		if(_isUflow == "2"){
			var startTemplate = this.editor.templates["start"];
			var taskTemplate = this.editor.templates["task"];
			var endTemplate = this.editor.templates["end"];
			
			var startCell = this.editor.graph.cloneCells([ startTemplate ])[0];
			this.editor.addVertex(null, startCell, 30, 30);
			
			var taskCell = this.editor.graph.cloneCells([ taskTemplate ])[0];
			this.editor.addVertex(null, taskCell, startCell.getGeometry().x + startCell.getGeometry().width + 30, 30);
			$("#" + taskCell.id).find("#xian_shi_ming_cheng").val("节点1");
			this.myCellMap.get(taskCell.id).labelChanged("节点1");
			
			var endCell = this.editor.graph.cloneCells([ endTemplate ])[0];
			this.editor.addVertex(null, endCell, taskCell.getGeometry().x + taskCell.getGeometry().width + 30, 30);
			
			this.editor.graph.addEdge(this.editor.createEdge(startCell, taskCell), null, startCell, taskCell);
			var toEndEdge = this.editor.graph.addEdge(this.editor.createEdge(taskCell, endCell), null, taskCell, endCell);
			$("#" + toEndEdge.id).find("#xian_shi_ming_cheng").val("结束流程");
			this.myCellMap.get(toEndEdge.id).labelChanged("结束流程");
			
			this.editor.execute("selectAll");
			this.editor.execute("alignCellsMiddle");
			this.editor.execute("selectNone");
		}
	} else {
		avicAjax.ajax({
			type : "POST",
			data : {
				id : _id,
				type : _type,
				pdId : _pdId,
				deployId : _deployId,
				_iconType: _iconType
			},
			url : this.controlPath + "getProcessXml?date=" + new Date().getTime(),
			dataType : "json",
			success : function(result) {
				if (flowUtils.notNull(result.processXml)) {
					// 加载
					var xml = mxUtils.parseXml(result.processXml);
					//保存老的流程对象，调用网安保存流程同步配置日志时使用
					_oldProcess = xml.getElementsByTagName("process")[0];
					var xmlvalue = _self.converToGraphXml(xml);
					_self.editor.readGraphModel(xmlvalue);

                    var process = null;
                    var values = _self.myCellMap.values();
                    $.each(values, function(i, n){
                        if(n.tagName == "process"){
                            process = n;
                            return false;
                        }
                    });
                    if(process != null) {
                        process.notify();
					}

				} else {
					// 查不到对应流程文件
					flowUtils.error("查不到对应流程文件");
				}
			}
		});
	}
	if(_isUflow == "2"){
		this.isUflow = true;
	}
	//自由流，限制界面功能
	if(this.isUflow){
		this.editor.graph.cellsLocked = true;
		$("#toolbar_div").hide();
		$("#graph").css("left","5px");
	}
};
/**
 * 创建元素对象
 */
DesignerEditor.prototype.createBaseByTagName = function(tagName, id, vertex, edge) {
	var baseNode = null;
	if (vertex) {
		if (tagName == "start") {
			baseNode = new MyStart(this, id);
		} else if (tagName == "end") {
			baseNode = new MyEnd(this, id);
		} else if (tagName == "task") {
			baseNode = new MyTask(this, id);
		} else if (tagName == "java") {
			baseNode = new MyJava(this, id);
		} else if (tagName == "sql") {
			baseNode = new MySql(this, id);
		} else if (tagName == "ws") {
			baseNode = new MyWs(this, id);
		} else if (tagName == "state") {
			baseNode = new MyState(this, id);
		} else if (tagName == "fork") {
			baseNode = new MyFork(this, id);
		} else if (tagName == "join") {
			baseNode = new MyJoin(this, id);
		} else if (tagName == "decision") {
			baseNode = new MyExclusive(this, id);
		} else if (tagName == "sub-process") {
			baseNode = new MySubprocess(this, id);
		} else if (tagName == "foreach") {
			baseNode = new MyForeach(this, id);
		} else if (tagName == "jms") {
			baseNode = new MyJms(this, id);
		} else if (tagName == "custom") {
			baseNode = new MyCustom(this, id);
		} else if (tagName == "rules") {
			baseNode = new MyRules(this, id);
		} else if (tagName == "swimlane") {
			baseNode = new MySwimlane(this, id);
		} else if (tagName == "text") {
			baseNode = new MyText(this, id);
		} else if (tagName == "rest") {
            baseNode = new MyRest(this, id);
        }
	} else if (edge) {
		baseNode = new MyTransition(this, id);
	}
	return baseNode;
};
/**
 * 判断是否横向泳道
 */
DesignerEditor.prototype.isSwimlane1 = function(cell) {
	return cell.getAttribute("cellType") == "swimlane1";
};

/**
 * 添加元件事件
 * 
 * @param cells
 */
DesignerEditor.prototype.addCell = function(cell) {
	if (!this.myCellMap.containsKey(cell.id)) {
		var nodeBase = this.createBaseByTagName(cell.value.nodeName, cell.id, cell.vertex, cell.edge);
		nodeBase.init();
		this.myCellMap.put(cell.id, nodeBase);
	}
};
/**
 * 删除元件事件
 * 
 * @param cells
 */
DesignerEditor.prototype.removeCells = function(cells) {
	for (var i = 0; i < cells.length; i++) {
		var cell = cells[i];
		this.myCellMap.get(cell.id).remove();
		this.myCellMap.remove(cell.id);
		if (cell.value.nodeName == "swimlane" && cell.children != null) {
			this.removeCells(cell.children);
		}
	}
};
/**
 * 双击元件事件
 * 
 * @param cells
 */
DesignerEditor.prototype.doubleClickCell = function(cell) {
	if(flowUtils.notNull(cell)){
		if (cell.value.nodeName == "sub-process") {
			this.myCellMap.get(cell.id).doubleClickCell();
		}
	}
};
/**
 * 构建process文件
 * 
 * @returns
 */
DesignerEditor.prototype.showProcess = function() {
	var process = this.myCellMap.get(this.processKey).getXmlDoc();
	process.setAttribute("useNewDesigner", "true");
	process.setAttribute("iconType", _iconType);
	process.setAttribute("isUflow", _isUflow);
	var transitionMap = new Map();
	var values = this.myCellMap.values();
	for (var i = 0; i < values.length; i++) {
		var baseNode = values[i];
		if (baseNode.tagName == "transition") {
			var sourceId = baseNode.getCell().source.id;
			if (transitionMap.containsKey(sourceId)) {
				transitionMap.get(sourceId).push(baseNode.getXmlDoc());
			} else {
				var transitionArr = new Array();
				transitionArr.push(baseNode.getXmlDoc());
				transitionMap.put(sourceId, transitionArr);
			}
		}
	}
	var start = 0;
	var end = 0;
	var task = 0;
	for (var i = 0; i < values.length; i++) {
		var baseNode = values[i];
		var cell = baseNode.getCell();
		if(baseNode.tagName == "start"){
			start ++;
			if(_needfirstuser != "true"){
				if(cell.edges && cell.edges.length > 0){
					var firstCell = cell.edges[0].target;
					var $candidate = $("#"+firstCell.id +" #draft-candidate-data-field");
					var actorDataValue = $candidate.val();
					if(actorDataValue.length > 0){
						var actorJSONArray = JSON.parse(actorDataValue);
						if(actorJSONArray.length > 0){
							this.allowSave = false;
							flowUtils.warning("拟稿节点不应该配置参与者");
							return;
						}
					}
				}
			}
		}
		if(baseNode.tagName == "end"){
			end ++;
		}
		if(baseNode.tagName == "task"){
			task ++;
		}
		if (baseNode.tagName != "process" && baseNode.tagName != "transition") {
			if(baseNode.tagName != "swimlane" && baseNode.tagName != "text"){
				if(!cell.edges || cell.edges.length == 0){
					this.allowSave = false;
					flowUtils.warning("不应有孤立的流程节点");
					return;
				}
			}
			var node = baseNode.getXmlDoc();
			if (transitionMap.containsKey(baseNode.id)) {
				var transitionArr = transitionMap.get(baseNode.id);
				for (j = 0; j < transitionArr.length; j++) {
					node.appendChild(transitionArr[j]);
				}
			}
			process.appendChild(node);
		}
	}
	if(start == 0 || end == 0 || task == 0){
		this.allowSave = false;
		flowUtils.warning("流程文件至少应包含开始节点、结束节点和一个人工节点");
		return;
	}

	//return mxUtils.getPrettyXml(process);
    return this.getPrettyXml(process);
};
/**
 * 循环各个元素进行转换
 */
DesignerEditor.prototype.cycleTags = function(tagName, process, rootXml, transitionArr) {
	var tags = process.getElementsByTagName(tagName);
	for (var i = 0; i < tags.length; i++) {
		if(tagName == "text" && !flowUtils.notNull(tags[i].getAttribute("id"))){
			continue;
		}
		var tagId = this.countUtils.getSelfId();
		if (this.useNewDesigner) {
			tagId = tags[i].getAttribute("id");
			this.countUtils.setSelfId(Number(tagId));
		}
		var tagNode = this.createBaseByTagName(tagName, tagId, 1, 0);
		tagNode.initLoad(tags[i], rootXml);
		this.myCellMap.put(tagId, tagNode);
		var transitions = tags[i].getElementsByTagName("transition");
		for (var j = 0; j < transitions.length; j++) {
			var transitionObject = {};
			transitionObject.xml = transitions[j];
			transitionObject.sourceId = tagId;
			transitionArr.push(transitionObject);
		}
	}
};
/**
 * 循环各个元素进行转换
 */
DesignerEditor.prototype.converToGraphXml = function(data) {
	// process
	var process = data.getElementsByTagName("process")[0];
	this.processKey = process.getAttribute("key");
	this.useNewDesigner = "true" == process.getAttribute("useNewDesigner") ? true : false;
	var myProcess = new MyProcess(this, this.processKey);
	myProcess.initLoad(process);
	this.myCellMap.put(this.processKey, myProcess);

	var graphXml = flowUtils.createElement("mxGraphModel");
	var rootXml = flowUtils.createElement("root");
	var workflowXml = flowUtils.createElement("Workflow");
	workflowXml.setAttribute("id", "0");
	var mxCell0 = flowUtils.createElement("mxCell");
	workflowXml.appendChild(mxCell0);
	var layerXml = flowUtils.createElement("Layer");
	layerXml.setAttribute("id", "1");
	var mxCell1 = flowUtils.createElement("mxCell");
	mxCell1.setAttribute("parent", "0");
	layerXml.appendChild(mxCell1);
	rootXml.appendChild(workflowXml);
	rootXml.appendChild(layerXml);

	var transitionArr = new Array();// 先循环节点，连线只是存储，最后再执行连线初始化，因为连线需要寻找target，即目标节点
	this.cycleTags("swimlane", process, rootXml, transitionArr);
	this.cycleTags("start", process, rootXml, transitionArr);
	this.cycleTags("end", process, rootXml, transitionArr);
	this.cycleTags("task", process, rootXml, transitionArr);
	this.cycleTags("java", process, rootXml, transitionArr);
	this.cycleTags("sql", process, rootXml, transitionArr);
	this.cycleTags("ws", process, rootXml, transitionArr);
	this.cycleTags("state", process, rootXml, transitionArr);
	this.cycleTags("fork", process, rootXml, transitionArr);
	this.cycleTags("join", process, rootXml, transitionArr);
	this.cycleTags("decision", process, rootXml, transitionArr);
	this.cycleTags("sub-process", process, rootXml, transitionArr);
	this.cycleTags("foreach", process, rootXml, transitionArr);
	this.cycleTags("jms", process, rootXml, transitionArr);
	this.cycleTags("custom", process, rootXml, transitionArr);
	this.cycleTags("rules", process, rootXml, transitionArr);
	this.cycleTags("text", process, rootXml, transitionArr);
    this.cycleTags("rest", process, rootXml, transitionArr);
	for (var i = 0; i < transitionArr.length; i++) {
		var transitionId = this.countUtils.getSelfId();
		if (this.useNewDesigner) {
			transitionId = transitionArr[i].xml.getAttribute("_id");
			this.countUtils.setSelfId(Number(transitionId));
		}
		var transitionNode = new MyTransition(this, transitionId);
		transitionNode.initLoad(transitionArr[i].xml, rootXml, transitionArr[i].sourceId);
		this.myCellMap.put(transitionId, transitionNode);
	}

	graphXml.appendChild(rootXml);
	return graphXml;
};
/**
 * 保存为新版本
 */
DesignerEditor.prototype.saveToNew_xml = function() {
	var postData = this.getPostData();
	if(flowUtils.notNull(postData)){
		var _self = this;
		postData.type = "3";//新建
		flowUtils.confirm("确定保存为新版本？", function() {
			avicAjax.ajax({
				url : _self.controlPath + "saveFlowModel",
				type : "POST",
				data : postData,
				datatype : "json",
				success : function(r) {
					if (flowUtils.notNull(r.error)) {
						flowUtils.error(r.error);
					} else {
						flowUtils.success("保存为新版本成功！页面将自动关闭", function() {
							flowUtils.refreshBack();
							flowUtils.closeWindow();
							//调用网安方法保存流程节点同步配置日志
							if(flowUtils.notNull(_processDataSynJs)){
								//修改时触发
								if(_pdId !=""){
									saveWaProcessSynConfigLog(_oldProcess,_newProcess);
								}
							}
						}, true);
					}
				}
			});
		});
	}
};
/**
 * 保存
 */
DesignerEditor.prototype.save_xml = function() {
	var postData = this.getPostData();
	if(flowUtils.notNull(postData)){
		var _self = this;
		flowUtils.confirm(this.validDelNodeFlg()?"确定保存？":"本次编辑有节点被删除，可能会影响现有正在运行的数据，确定保存并覆盖现有流程版本吗？", function() {
			avicAjax.ajax({
				url : _self.controlPath + "saveFlowModel",
				type : "POST",
				data : postData,
				datatype : "json",
				success : function(r) {
					if (flowUtils.notNull(r.error)) {
						flowUtils.error(r.error);
					} else {
						flowUtils.success("保存成功");
						flowUtils.refreshBack();
						//调用网安方法保存流程节点同步配置日志
						if(flowUtils.notNull(_processDataSynJs)){
							//修改时触发
							if(_pdId !=""){
								var xml = postData.flow_xml;
								var xmlObj = mxUtils.parseXml(xml);
								var process = xmlObj.getElementsByTagName("process")[0];
								saveWaProcessSynConfigLog(_oldProcess,process);
							}
						}
					}
				}
			});
		});
	}
};
/**
 * 发布
 */
DesignerEditor.prototype.send_xml = function() {
	var postData = this.getPostData();
	if(flowUtils.notNull(postData)){
		var _self = this;
		postData.sendXml = "true";
		flowUtils.confirm("确定保存并发布吗？", function() {
			avicAjax.ajax({
				url : _self.controlPath + "saveFlowModel",
				type : "POST",
				data : postData,
				datatype : "json",
				success : function(r) {
					if (flowUtils.notNull(r.error)) {
						flowUtils.error(r.error);
					} else {
						flowUtils.success("保存并发布成功！页面将自动关闭", function() {
							flowUtils.refreshBack();
							flowUtils.closeWindow();
							//调用网安方法保存流程节点同步配置日志
							if(flowUtils.notNull(_processDataSynJs)){
								//修改时触发
								if(_pdId !=""){
									saveWaProcessSynConfigLog(_oldProcess,_newProcess);
								}
							}
						}, true);
					}
				}
			});
		});
	}
};
/**
 * 校验保存时是否有节点被删除
 */
DesignerEditor.prototype.validDelNodeFlg = function(){
	for(var i = 0; i < this.myLoadMap.values().length; i++){
		var loadNode = this.myLoadMap.values()[i];
		if(!this.myCellMap.containsKey(loadNode.id)){
			return false;
		}
	}
	return true;
};

DesignerEditor.prototype.getPostData = function(){
	var flowName = this.myCellMap.get(this.processKey).alias;
	if (!flowUtils.notNull(flowName)) {
		flowUtils.warning("流程名称不能为空");
		return;
	}
	this.allowSave = true;
	var postData = {};
	postData.catalogId = _catalog;
	postData.id = _id;
	postData.type = _type;
	postData.flowName = flowName;
	postData.flowKey = this.processKey;
	postData.flowDesc = "";
	postData.pdId = _pdId;
	postData.deployId = _deployId;
	postData.isUflow = _isUflow;
	// 在组织xml的同时，组织要入库的数据到xml中，中间校验出现问题，置this.allowSave为false
	// postData.flow_xml = this.showProcess();
	//回归项目修改
	var flow_xml = this.showProcess();

	if (!this.allowSave) {
		return;
	}
	// postData.png_xml = this.getImageXml();
	//回归项目修改
	var png_xml = this.getImageXml();
	postData.flow_xml = Base64.encode(flow_xml);
	postData.png_xml = Base64.encode(png_xml);

	var bounds = this.editor.graph.getGraphBounds();
	var w = Math.ceil(bounds.x + bounds.width + 4);
	var h = Math.ceil(bounds.y + bounds.height + 4);
	postData.w = w;
	postData.h = h;
	return postData;
};
DesignerEditor.prototype.validMoveCells = function(cells, dx, dy, clone, target, evt, mapping) {
	if (target != null && target.value.nodeName == "swimlane") {
		for (var i = 0; i < cells.length; i++) {
			if (cells[i].value.nodeName == "swimlane") {
				flowUtils.warning("泳道内不能放置泳道");
				return false;
			}
		}
	}
	return true;
};
/**
 * 创建ImageXml
 * 
 * @returns
 */
DesignerEditor.prototype.getImageXml = function() {
	var xmlDoc = mxUtils.createXmlDocument();
	var root = xmlDoc.createElement('output');
	xmlDoc.appendChild(root);
	
	var xmlCanvas = new mxXmlCanvas2D(root);
	xmlCanvas.converter.setBaseUrl(_bpm_baseurl);
	var imgExport = new mxImageExport();
	imgExport.drawState(this.editor.graph.getView().getState(this.editor.graph.model.root), xmlCanvas);
	
	return mxUtils.getXml(root);
};
DesignerEditor.prototype.validDeleteCell = function(cells, includeEdges){
	if(this.isUflow){
		flowUtils.warning("自由流程只能调整布局，不能手动增删节点");
		return false;
	}
	return true;
};
DesignerEditor.prototype.validAddCell = function(cell, parent, index, source, target) {
	if(this.isUflow){
		flowUtils.warning("自由流程只能调整布局，不能手动增删节点");
		return false;
	}
	if (cell.edge) {
		if (source.value.nodeName == "end") {
			flowUtils.warning("结束节点不能作为起点");
			return false;
		} else if (target.value.nodeName == "start") {
			flowUtils.warning("开始节点不能作为终点");
			return false;
		} else if(source.value.nodeName == "start"){
			if (target.value.nodeName != "task") {
				flowUtils.warning("开始节点只能指向人工节点");
				return false;
			}else if(source.edges && source.edges.length != 0){
				flowUtils.warning("开始节点只能指向一个人工节点");
				return false;
			}
		}
	} else if (cell.vertex && cell.value.nodeName == "start") {
		var values = this.myCellMap.values();
		for (var i = 0; i < values.length; i++) {
			if (values[i].tagName == "start") {
				flowUtils.warning("不能添加多个开始节点");
				return false;
			}
		}
	} else if (cell.vertex && cell.value.nodeName == "swimlane") {
		if ((this.isSwimlane1(cell) && this.swimlane2 > 0) || (!this.isSwimlane1(cell) && this.swimlane1 > 0)) {
			flowUtils.warning("横向泳道与纵向泳道不能混用");
			return false;
		} else if (parent.value.nodeName == "swimlane") {
			flowUtils.warning("泳道内不能放置泳道");
			return false;
		}
	}
	return true;
};
DesignerEditor.prototype.validConnectCell = function(_mxgraph, edge, terminal, source, constraint){
	if(this.isUflow){
		flowUtils.warning("自由流程只能调整布局，不能手动改动连线");
		return false;
	}
	var sourceCell = null;
	var targetCell = null;
	if(source){
		sourceCell = terminal;
		targetCell = edge.target;
	}else{
		sourceCell = edge.source;
		targetCell = terminal;
	}
	if (sourceCell.value.nodeName == "end") {
		flowUtils.warning("结束节点不能作为起点");
		return false;
	} else if (targetCell.value.nodeName == "start") {
		flowUtils.warning("开始节点不能作为终点");
		return false;
	} else if(sourceCell.value.nodeName == "start"){
		if (targetCell.value.nodeName != "task") {
			flowUtils.warning("开始节点只能指向人工节点");
			return false;
		}else if(sourceCell.edges && sourceCell.edges.length != 0){
			flowUtils.warning("开始节点只能指向一个人工节点");
			return false;
		}
	}
	var cellNode = this.myCellMap.get(edge.id);
	if(!source){
		cellNode.rename("to " + this.myCellMap.get(targetCell.id).name);
	}
	setTimeout(function () {
		cellNode.controlCandidate();
	}, 500);
	return true;
};
DesignerEditor.prototype.changeSelected = function() {
	var _self = this;
	if (_self.editor.graph != null) {
		if(_self.myCurCellId != null){
			var preCell = _self.editor.graph.getModel().getCell(_self.myCurCellId);
			if(flowUtils.notNull(preCell) && flowUtils.notNull(preCell.style) && preCell.style.indexOf("symbol") == "0"){
				_self.editor.graph.setCellStyles("imageBorder", "", [ preCell ]);
			}
		}
		if (!_self.editor.graph.isSelectionEmpty()) {
			var cell = _self.editor.graph.getSelectionCell();
			if(flowUtils.notNull(cell, cell.style) && cell.style.indexOf("symbol") == "0"){
				_self.editor.graph.setCellStyles("imageBorder", "green", [ cell ]);
			}
			_self.myCellMap.get(cell.id).showProp();
		} else {
			$(".prop_wrap").hide();
			_self.myCurCellId = null;
			setTimeout(function(){
				$('#propMainDiv').find('.nav-tabs').find('li').eq(0).trigger("click");
				$('#propMainDiv').find('.nav-tabs').find('a').eq(1).trigger("blur");
				$("#toolbar").find("img").eq(0).trigger("click");
			}, 100);
		}
	}
};
/**
 * 自定义undo操作，只undo移动节点，出现添加或删除节点，则clear
 * @param manager
 * @param undoableEdit
 * @returns {Boolean}
 */
DesignerEditor.prototype.validUndoCell = function(manager, undoableEdit){
	for(var i = 0; i < undoableEdit.changes.length; i++){
		if(undoableEdit.changes[i].constructor != mxGeometryChange){
			manager.clear();
			return false;
		}
	}
	return true;
};
DesignerEditor.prototype.goLeft = function(editor) {
	var cells = editor.graph.getSelectionCells();
	if (flowUtils.notNull(cells)) {
		editor.graph.moveCells(cells, -1, 0);
	}
};
DesignerEditor.prototype.goUp = function(editor) {
	var cells = editor.graph.getSelectionCells();
	if (flowUtils.notNull(cells)) {
		editor.graph.moveCells(cells, 0, -1);
	}
};
DesignerEditor.prototype.goRight = function(editor) {
	var cells = editor.graph.getSelectionCells();
	if (flowUtils.notNull(cells)) {
		editor.graph.moveCells(cells, 1, 0);
	}
};
DesignerEditor.prototype.goDown = function(editor) {
	var cells = editor.graph.getSelectionCells();
	if (flowUtils.notNull(cells)) {
		editor.graph.moveCells(cells, 0, 1);
	}
};
DesignerEditor.prototype.autoLayout = function(editor) {
	var cells = editor.graph.getChildVertices();
	if (flowUtils.notNull(cells)) {
		var o = {};
		var vCells = new Map();
		if (this.swimlane1 > 0) {
			for (var i = 0; i < cells.length; i++) {
				if (cells[i].vertex && cells[i].value.nodeName == "swimlane") {
					var y = Number(cells[i].getGeometry().y);
					vCells.put(y, cells[i]);
					if (!flowUtils.notNull(o.miny) || o.miny > y) {
						o.miny = y;
					}
					if (!flowUtils.notNull(o.maxy) || o.maxy < y) {
						o.maxy = y;
					}
				}
			}
			if (vCells.size() > 1) {
				var keys = vCells.keys();
				keys = keys.sort(function(a, b) {
					return a - b;
				})
				var width = vCells.get(keys[0]).getGeometry().width;
				var x = vCells.get(keys[0]).getGeometry().x;
				var h = 0;
				for (var i = 0; i < keys.length; i++) {
					vCells.get(keys[i]).getGeometry().width = width;
					editor.graph.moveCells([ vCells.get(keys[i]) ], 1, 0);
					editor.graph.moveCells([ vCells.get(keys[i]) ], x - vCells.get(keys[i]).getGeometry().x, (o.miny + h) - Number(keys[i]));
					h += vCells.get(keys[i]).getGeometry().height;
					vCells.remove(keys[i]);
				}
			}
		} else {
			for (var i = 0; i < cells.length; i++) {
				if (cells[i].vertex && cells[i].value.nodeName == "swimlane") {
					var x = Number(cells[i].getGeometry().x);
					vCells.put(x, cells[i]);
					if (!flowUtils.notNull(o.minx) || o.minx > x) {
						o.minx = x;
					}
					if (!flowUtils.notNull(o.maxx) || o.maxx < x) {
						o.maxx = x;
					}
				}
			}
			if (vCells.size() > 1) {
				var keys = vCells.keys();
				keys = keys.sort(function(a, b) {
					return a - b;
				})
				var height = vCells.get(keys[0]).getGeometry().height;
				var y = vCells.get(keys[0]).getGeometry().y;
				var w = 0;
				for (var i = 0; i < keys.length; i++) {
					vCells.get(keys[i]).getGeometry().height = height;
					editor.graph.moveCells([ vCells.get(keys[i]) ], 0, 1);
					editor.graph.moveCells([ vCells.get(keys[i]) ], (o.minx + w) - Number(keys[i]), y - vCells.get(keys[i]).getGeometry().y);
					w += vCells.get(keys[i]).getGeometry().width;
					vCells.remove(keys[i]);
				}
			}
		}
	}
};
/**
 * 直线
 * @param editor
 */
DesignerEditor.prototype.changeEdgeStyle1 = function(editor) {
	var cell = editor.graph.getSelectionCell();
	if (flowUtils.notNull(cell) && cell.edge) {
		editor.graph.setCellStyles("edgeStyle", "straightEdge", [cell]);
	}
	this.clearWaypoints(editor);
};
/**
 * 曲线
 * @param editor
 */
DesignerEditor.prototype.changeEdgeStyle2 = function(editor) {
	var cell = editor.graph.getSelectionCell();
	if (flowUtils.notNull(cell) && cell.edge) {
		editor.graph.setCellStyles("edgeStyle", null, [cell]);
	}
	this.clearWaypoints(editor);
};
/**
 * 清空拐点
 * @param editor
 */
DesignerEditor.prototype.clearWaypoints = function(editor) {
	var graph = editor.graph;
	var cells = graph.getSelectionCells();

	if (cells != null)
	{
		cells = graph.addAllEdges(cells);

		graph.getModel().beginUpdate();
		try
		{
			for (var i = 0; i < cells.length; i++)
			{
				var cell = cells[i];

				if (graph.getModel().isEdge(cell))
				{
					var geo = graph.getCellGeometry(cell);

					if (geo != null)
					{
						geo = geo.clone();
						geo.points = null;
						graph.getModel().setGeometry(cell, geo);
					}
				}
			}
		}
		finally
		{
			graph.getModel().endUpdate();
		}
	}
};
/**
 * 增加拐点
 * @param editor
 */
DesignerEditor.prototype.addWayPoint = function(editor) {
	var graph = editor.graph;
	var cell = graph.getSelectionCell();

	if (cell != null && graph.getModel().isEdge(cell))
	{
		var handler = graph.selectionCellsHandler.getHandler(cell);

		if (handler instanceof mxEdgeHandler)
		{
			var t = graph.view.translate;
			var s = graph.view.scale;
			var dx = t.x;
			var dy = t.y;

			var parent = graph.getModel().getParent(cell);
			var pgeo = graph.getCellGeometry(parent);

			while (graph.getModel().isVertex(parent) && pgeo != null)
			{
				dx += pgeo.x;
				dy += pgeo.y;

				parent = graph.getModel().getParent(parent);
				pgeo = graph.getCellGeometry(parent);
			}

			var x = Math.round(graph.snap(graph.popupMenuHandler.triggerX / s - dx));
			var y = Math.round(graph.snap(graph.popupMenuHandler.triggerY / s - dy));

			handler.addPointAt(handler.state, x, y);
		}
	}
};
DesignerEditor.prototype.comWidth = function(editor) {
	var cells = editor.graph.getSelectionCells();
	if (flowUtils.notNull(cells)) {
		var o = {};
		var vCells = new Map();
		for (var i = 0; i < cells.length; i++) {
			if (cells[i].vertex && cells[i].value.nodeName != "swimlane") {
				var x = Number(cells[i].getGeometry().x);
				vCells.put(x, cells[i]);
				if (!flowUtils.notNull(o.minx) || o.minx > x) {
					o.minx = x;
				}
				if (!flowUtils.notNull(o.maxx) || o.maxx < x) {
					o.maxx = x;
				}
			}
		}
		if (vCells.size() > 1) {
			var w = (o.maxx - o.minx) / (vCells.size() - 1);
			var keys = vCells.keys();
			keys = keys.sort(function(a, b) {
				return a - b;
			})
			for (var i = 0; i < keys.length; i++) {
				editor.graph.moveCells([ vCells.get(keys[i]) ], (o.minx + w * i) - Number(keys[i]), 0);
				vCells.remove(keys[i]);
			}
		}
	}
};
DesignerEditor.prototype.comHeight = function(editor) {
	var cells = editor.graph.getSelectionCells();
	if (flowUtils.notNull(cells)) {
		var o = {};
		var vCells = new Map();
		for (var i = 0; i < cells.length; i++) {
			if (cells[i].vertex && cells[i].value.nodeName != "swimlane") {
				var y = Number(cells[i].getGeometry().y);
				vCells.put(y, cells[i]);
				if (!flowUtils.notNull(o.miny) || o.miny > y) {
					o.miny = y;
				}
				if (!flowUtils.notNull(o.maxy) || o.maxy < y) {
					o.maxy = y;
				}
			}
		}
		if (vCells.size() > 1) {
			var h = (o.maxy - o.miny) / (vCells.size() - 1);
			var keys = vCells.keys();
			keys = keys.sort(function(a, b) {
				return a - b;
			})
			for (var i = 0; i < keys.length; i++) {
				editor.graph.moveCells([ vCells.get(keys[i]) ], 0, (o.miny + h * i) - Number(keys[i]));
				vCells.remove(keys[i]);
			}
		}
	}
};
/**
 * 重写的mxUtils中的方法，因为原方法在处理text类型时会多加一个空格
 *
 * @param node
 * @param tab
 * @param indent
 * @returns
 */
DesignerEditor.prototype.getPrettyXml = function(node, tab, indent) {
    var result = [];

    if (node != null) {
        tab = tab || '  ';
        indent = indent || '';

        if (node.nodeType == mxConstants.NODETYPE_TEXT) {
            result.push(node.nodeValue);
        } else {
            result.push(indent + '<' + node.nodeName);

            // Creates the string with the node attributes
            // and converts all HTML entities in the values
            var attrs = node.attributes;

            if (attrs != null) {
                for (var i = 0; i < attrs.length; i++) {
                    var val = mxUtils.htmlEntities(attrs[i].nodeValue);
                    result.push(' ' + attrs[i].nodeName + '="' + val + '"');
                }
            }

            // Recursively creates the XML string for each
            // child nodes and appends it here with an
            // indentation
            var tmp = node.firstChild;

            if (tmp != null) {
                var temIndent = "";
                result.push('>');
                if (tmp.nodeType != mxConstants.NODETYPE_TEXT) {
                    temIndent = indent;
                    result.push('\n');
                }

                while (tmp != null) {
                    result.push(this.getPrettyXml(tmp, tab, indent
                        + tab));
                    tmp = tmp.nextSibling;
                }

                result.push(temIndent + '</' + node.nodeName + '>\n');
            } else {
                result.push('/>\n');
            }
        }
    }

    return result.join('');
};
/**
 *
 * @param key
 * @param cell
 * @returns {string|null}
 */
DesignerEditor.prototype.getStyleValue = function(key, cell) {
	var style = this.editor.graph.model.getStyle(cell);
	if (style != null) {
		var pairs = style.split(';');
		for (var i = 0; i < pairs.length; i++) {
			if (pairs[i].indexOf('=') != -1) {
				var styleValue = pairs[i].split("=");
				if(styleValue[0] == key){
					return styleValue[1];
				}
			}
		}
	}
	return null;
};
function isEdgeStraight(editor, cell, evt) {
	var graph = editor.graph;
	if(cell != null && cell.edge && graph.getSelectionCells().length == 1){
		var state = graph.view.getState(cell);
		if(mxUtils.getValue(state.style, "edgeStyle", null) == 'straightEdge'){
			return true;
		}
	}
	return false;
}
function isEdgeNotStraight(editor, cell, evt) {
	var graph = editor.graph;
	if(cell != null && cell.edge && graph.getSelectionCells().length == 1){
		var state = graph.view.getState(cell);
		if(mxUtils.getValue(state.style, "edgeStyle", null) != 'straightEdge'){
			return true;
		}
	}
	return false;
}
function canAddPoint(editor, cell, evt) {
	if(!isEdgeStraight(editor, cell, evt)){
		return false;
	}
	var graph = editor.graph;
	var handler = graph.selectionCellsHandler.getHandler(cell);
	var isWaypoint = false;

	if (handler instanceof mxEdgeHandler && handler.bends != null && handler.bends.length > 2)
	{
		var index = handler.getHandleForEvent(graph.updateMouseEvent(new mxMouseEvent(evt)));
		isWaypoint = index > 0 && index < handler.bends.length - 1;
	}
	return !isWaypoint;
}
function isEdgeSolidLine(editor, cell, evt) {
	return !isEdgeDottedLine(editor, cell, evt);
}
function isEdgeDottedLine(editor, cell, evt) {
	var graph = editor.graph;
	if(cell != null && cell.edge && graph.getSelectionCells().length == 1){
		var state = graph.view.getState(cell);
		if(mxUtils.getValue(state.style, mxConstants.STYLE_DASHED, null) == '1'){
			return true;
		}
	}
	return false;
}
DesignerEditor.prototype.changeSolidLine = function(editor) {
	var cell = editor.graph.getSelectionCell();
	if (flowUtils.notNull(cell) && cell.edge) {
		editor.graph.setCellStyles(mxConstants.STYLE_DASHED, null, [cell]);
	}
};
DesignerEditor.prototype.changeDottedLine = function(editor) {
	var cell = editor.graph.getSelectionCell();
	if (flowUtils.notNull(cell) && cell.edge) {
		editor.graph.setCellStyles(mxConstants.STYLE_DASHED, '1', [cell]);
	}
};;
