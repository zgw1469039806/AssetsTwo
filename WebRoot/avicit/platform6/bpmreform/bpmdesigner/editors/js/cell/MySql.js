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

}