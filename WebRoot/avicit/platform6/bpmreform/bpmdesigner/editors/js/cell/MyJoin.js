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
/**** 	条件各种事件结束	 ****/