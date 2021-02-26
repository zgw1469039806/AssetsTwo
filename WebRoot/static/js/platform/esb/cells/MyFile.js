/**
 * MyFile extends MyBase
 */
function MyFile(id) {
	MyBase.call(this, id, "file", "FILE");
};
MyFile.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyFile.prototype.init = function() {
	this.initBase();
	this.tagName = "file:inbound-endpoint";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyFile.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	this.tagName = xmlValue.get(0).tagName;
	if(this.tagName == "file:outbound-endpoint"){
		$("#" + this.id).find("#outbound-endpoint").attr("checked", true);
		$("#" + this.id).find("#outbound-endpoint").next().trigger('click');
	}
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	var _self = this;
	this.setDomValByAttr("lu_jing", xmlValue, "path");
	this.setDomValByAttr("shu_chu_mo_shi", xmlValue, "outputPattern");
	this.setDomValByAttr("yi_dong_ming_ming_mo_shi", xmlValue, "moveToPattern");
	this.setDomValByAttr("yi_dong_lu_jing", xmlValue, "moveToDirectory");
	this.setDomValByAttr("shua_xin_pin_lv", xmlValue, "pollingFrequency");
	this.setDomValByAttr("deng_dai_chu_li_shi_jian", xmlValue, "fileAge");
	$(xmlValue).children().each(function(){
		var patternVal = $(this).attr("pattern");
		$("#" + _self.id).find("#wen_jian_lei_xing_guo_lv").val(patternVal)
	});
	this.setDomValByAttr("di_zhi", xmlValue, "address");
	this.setDomValByAttr("xiang_ying_chao_shi_shi_jian", xmlValue, "responseTimeout");
	this.setDomValByAttr("zi_fu_bian_ma", xmlValue, "encoding");
	this.setDomValByAttr("MIME_TYPE", xmlValue, "mimeType");
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyFile.prototype.getOtherAttr = function(node) {
	if(!myAction.xmlns.containsKey("xmlns:file")){
		myAction.xmlns.put("xmlns:file", "http://www.mulesoft.org/schema/mule/file");
		myAction.schemaLocation.put("file", "http://www.mulesoft.org/schema/mule/file http://www.mulesoft.org/schema/mule/file/current/mule-file.xsd");
	}
	//属性信息
	var $toggle = $("#" + this.id).find("#inbound-endpoint").prop('checked');
	this.setXmlAttrByVal("path", "lu_jing", node);
    if($toggle){
    	this.setXmlAttrByVal("moveToPattern", "yi_dong_ming_ming_mo_shi", node);
    	this.setXmlAttrByVal("moveToDirectory", "yi_dong_lu_jing", node);
    	this.setXmlAttrByVal("pollingFrequency", "shua_xin_pin_lv", node);
    	this.setXmlAttrByVal("fileAge", "deng_dai_chu_li_shi_jian", node);
    	var patternVal = $("#" + this.id).find("#wen_jian_lei_xing_guo_lv").val();
    	if($.notNull(patternVal)){
    		var filter = ComUtils.createElement("file:filename-regex-filter");
    		filter.setAttribute("pattern", patternVal);
    		node.appendChild(filter);
    	}
    }else{
    	this.setXmlAttrByVal("outputPattern", "shu_chu_mo_shi", node);
    }
	this.setXmlAttrByVal("address", "di_zhi", node);
	this.setXmlAttrByVal("responseTimeout", "xiang_ying_chao_shi_shi_jian", node);
	this.setXmlAttrByVal("encoding", "zi_fu_bian_ma", node);
	this.setXmlAttrByVal("mimeType", "MIME_TYPE", node);
};
MyFile.prototype.endpointChanged = function(value) {
	this.tagName = "file:" + value;
};
/**
 * 获取属性分项列表
 * 
 * @returns {Array}
 */
MyFile.prototype.getItem = function() {
	return [ {
		text : "通用"
	}, {
		text : "高级"
	} ];
};