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

