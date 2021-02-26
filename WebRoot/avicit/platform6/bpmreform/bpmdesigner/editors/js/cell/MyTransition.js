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
