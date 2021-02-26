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
}