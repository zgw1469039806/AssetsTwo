function NodeEvent(designerEditor, id, eventFlagClass) {
	this.designerEditor = designerEditor;
	this.id = id;
	  // 事件包围器
    this.wrapper = eventFlagClass ? $("#"+id+" div[class='"+eventFlagClass+"']") : $("#"+id+" div[class='avic-digital-flow-event']");
    // 输入区域表格事件
    this.constantsTable = this.wrapper.find("table[name=constants]");
    this.isModified = false;
    this.init();
	return this;
}

NodeEvent.prototype.init = function() {
	var _self = this;
	// 初始化常量表格的double事件
	_self.constantsTable.find("tbody>tr>td").on("dblclick", function(event){
		event.stopPropagation();
        var top = $(this);
        if(top.find("input") && top.find("input").length>0){
        	return;
		}
        var input = $('<input type="text"  style="width: 100%;"/>').val(top.html());
        top.html(input);
        input.focus().on("blur", function() {
            top.html(input.val());
        });

        return false;
    });

	// 初始化保存按钮
	_self.wrapper.find("button[name='btn-add-event']").on("click", function(event) {
		event.stopPropagation()
        if (!_self.validate(_self.wrapper)) {
            return ;
        }
        // 将本条记录封装成json数据
        var data =_self.assembleEventValueFromHtml(_self.wrapper);
        var text = '';
        // 封装常量
        _self.wrapper.find("table[name=constants] tbody>tr").each(function(){
            if($.trim($(this).find("td:eq(0)").text()).length != 0) {
                text += "【" + $(this).find("td:eq(0)").text() + "=" + $(this).find("td:eq(1)").text() + "】  ";
            }
        });

        _self.insertConstantsIntoTable(
        		_self.wrapper,
        		_self.wrapper.find("input[name='input-event-name']").val(),
        		_self.wrapper.find("input[name='input-event']").val(),
        		_self.wrapper.find("select[name='select-event-type']").val(),
        		$.trim(_self.assembleEventConstantValueFromHtml()),
        		data);
        _self.empty(_self.wrapper);
    });

}

// 验证事件输入框是否完整
// wrapper jquery对象
NodeEvent.prototype.validate = function(wrapper) {
   var eventName = wrapper.find("input[name='input-event-name']");
    if (eventName == undefined || eventName.val().length == 0) {
         layer.msg("您还没输入事件名称");
        return false;
    }
    var event =  wrapper.find("input[name='input-event']");
     if (event == undefined || event.val().length == 0) {
       layer.msg("您还没输入事件");
        return false;
    }
    return true;
}

NodeEvent.prototype.assembleEventConstantValueFromHtml = function () {
	var wrapper = this.wrapper;
	 var text = '';
     wrapper.find("table[name=constants] tbody>tr").each(function(){
         if($.trim($(this).find("td:eq(0)").text()).length != 0) {
             text += "【" + $(this).find("td:eq(0)").text() + "=" + $(this).find("td:eq(1)").text() + "】  ";
         }
     });
     return text;
}

NodeEvent.prototype.assembleEventValueFromHtml = function (wrapper) {
	var data = {};
	var eventType = wrapper.find("select[name='select-event-type']").val();
    var eventName = wrapper.find("input[name='input-event-name']").val();
    var event  = wrapper.find("input[name='input-event']").val();
    var fields = [];
    var text = '';
    wrapper.find("table[name=constants] tbody>tr").each(function(){
        if($.trim($(this).find("td:eq(0)").text()).length != 0) {
            var field = {fieldName:$(this).find("td:eq(0)").text(), fieldValue:$(this).find("td:eq(1)").text()};
            fields.push(field);
        }
    });
    data.eventType = eventType;
    data.eventName = eventName;
    data.event = event;
    data.fields = fields;
    return data;
}

NodeEvent.prototype.assembleEventValueFromXml = function (XmlNodeValue) {
//	<on event="start">
//    <event-listener name="ewf" class="fwe">
//      <field name="wef">
//        <string value="fwe"/>
//      </field>
//      <field name="fwe">
//        <string value="few"/>
//      </field>
//    </event-listener>
//  </on>
//	$(XmlNodeValue).children("on").each(function(){
}


NodeEvent.prototype.insertConstantsIntoTable = function (wrapper, eventName, event, eventType, constantValue, data) {
	var _self = this;
	var btn = '<a href="javascript:void(0)" name="table-btn-event-delete"><i class="iconfont icon-delete"></i></a>';
		btn += '<a href="javascript:void(0)" name="table-btn-event-modify" style="margin-left:5px"><i class="iconfont icon-edit"></i></a>';
    //var eventTypeName = eventType == "start"?"前置事件":(eventType == "end"?"后置事件":(eventType == "transfer"?"流转事件":"超时事件"));
	var eventTypeName = "";
	if(eventType=="start"){
		eventTypeName = "前置事件";
	}else if(eventType == "afterStart"){
		eventTypeName = "启动后事件";
	}else if(eventType == "end"){
		eventTypeName = "后置事件";
	}else if(eventType == "transfer"){
		eventTypeName = "流转事件";
	}else{
		eventTypeName = "超时事件";
	}
    var content = "<tr data='"+JSON.stringify(data)+"'><td style='display:none;'></td>";
	    content += "<td title='"+eventName+"'>"+eventName+"</td>";
	    content += "<td title='"+event+"'>"+event+"</td>";
	    content += "<td title='"+eventTypeName+"'>"+eventTypeName+"</td>";
	    content += "<td title='"+constantValue+"'>"+constantValue+"</td>";
	    content += " <td>";
	    content += btn;
	    content += " </td>";
	    content += " </tr>";
    wrapper.find("table[name='table-event-value']").append(content);
    // 添加行数据删除事件
	wrapper.find("table[name='table-event-value']>tbody>tr a[name='table-btn-event-delete']").off("click").on("click",function(){
		if(_self.isModified) {
			layer.msg("您还未保存现在的工作");
			return ;
		}
		$(this).parent().parent().fadeOut().remove();
	});
	// 添加行数据修改事件
	wrapper.find("table[name='table-event-value']>tbody>tr a[name='table-btn-event-modify']").off("click").on("click",function(){
		// 变更操作按钮
		if(!_self.toggleAddOrSaveBtn()) {
			return false;
		}
		// 回写输入表单
		//	{"eventType":"start","eventName":"sad","event":"sad","fields":[{"fieldName":"sad","fieldValue":"sad"}]}
		var currentLine = $(this).parent().parent();
		var constantData = JSON.parse(currentLine.attr("data"));
		for (var d in constantData) {
			if("eventName" == d) {
				wrapper.find("input[name='input-event-name']").val(constantData[d]);
			} else if ("event" == d){
				 wrapper.find("input[name='input-event']").val(constantData[d]);
			} else if ("eventType" == d) {
				wrapper.find("select[name='select-event-type']").val(constantData[d]);
			} else if ("fields" == d) {
				var fields = constantData[d];
				for (var i = 0 ; i < fields.length; i++) {
					var field = fields[i];
					var curTr = wrapper.find("table[name=constants]>tbody>tr").eq(i);
						 if(curTr.get(0)) {
							 curTr.children("td:eq(0)").html(field.fieldName);
							curTr.children("td:eq(1)").html(field.fieldValue||"");
						 } else {
							 wrapper.find("table[name=constants] > tbody").append("<tr><td>"+field.fieldName+"</td><td>"+(field.fieldValue||"")+"</td><tr>");
						 }
				}
			} else {
				layer.msg("数据错误");
				return false;
			}
		}

		// 绑定保存按钮，保存修改的内容
		wrapper.find($("button[name='btn-save-event']")).off("click").on("click", function() {
			_self.save(currentLine);
			_self.isModified = false;
			_self.toggleAddOrSaveBtn();
//			layer.msg("保存成功");
		});
	});
}

NodeEvent.prototype.empty = function (wrapper) {
		var w = wrapper || this.wrapper;
       w.find("input[name='input-event-name']").val("");
       w.find("input[name='input-event']").val("");
       w.find("table[name=constants] tbody>tr").each(function(){
           $(this).find("td").empty();
       });
}

/**
 *
 * @param dataLine 表单的tr 对象。编辑数据后的保存方法
 */
NodeEvent.prototype.save = function (dataLine) {
	var wrapper = this.wrapper;
	var eventName = wrapper.find("input[name='input-event-name']").val(),
		event = wrapper.find("input[name='input-event']").val(),
		eventType = wrapper.find("select[name='select-event-type']").val(),
	constantValue = this.assembleEventConstantValueFromHtml(),
	data = this.assembleEventValueFromHtml(wrapper);
	 //var eventTypeName = eventType == "start"?"前置事件":(eventType == "end"?"后置事件":(eventType == "transfer"?"流转事件":"超时事件"));
	var eventTypeName = "";
	if(eventType=="start"){
		eventTypeName = "前置事件";
	}else if(eventType == "afterStart"){
		eventTypeName = "启动后事件";
	}else if(eventType == "end"){
		eventTypeName = "后置事件";
	}else if(eventType == "transfer"){
		eventTypeName = "流转事件";
	}else{
		eventTypeName = "超时事件";
	}
	dataLine.attr("data", JSON.stringify(data));
	dataLine.find("td:eq(1)").attr("title", eventName).html(eventName);
	dataLine.find("td:eq(2)").attr("title", event).html(event);
	dataLine.find("td:eq(3)").attr("title", eventTypeName).html(eventTypeName);
	dataLine.find("td:eq(4)").attr("title", constantValue).html(constantValue);
	this.empty(wrapper);
}

//切换添加-保存按钮
NodeEvent.prototype.toggleAddOrSaveBtn = function() {
	var self = this;
	if(self.isModified) {
		layer.msg("您还未保存现在的工作");
		return false;
	}
    this.wrapper.find($("button[name='btn-add-event']")).each(function(index) {
        var $this = $(this);
        if ($this.hasClass("hidden")) {
            $this.removeClass("hidden");
            $this.siblings().addClass("hidden");
        } else {
        	self.isModified = true;
            $this.addClass("hidden");
            $this.siblings().removeClass("hidden");
        }
    });
    return true;
}

/**
 * 将数据封装成xml，保存到node中
 * @param node xml的节点
 * @param nodeName xml节点属性名称 暂时未使用
 */
NodeEvent.prototype.setEventXml = function (node, nodeName) {
	var _self = this;
//	{"eventType":"start","eventName":"rew","event":"ewr","fields":[{"fieldName":"wer","fieldValue":"wer"}]}
	/* <on event="start">
	    <event-listener name="ewf" class="fwe">
	      <field name="wef">
	        <string value="fwe"/>
	      </field>
	      <field name="fwe">
	        <string value="few"/>
	      </field>
	    </event-listener>
	  </on>*/
	var events = this.wrapper.find("table[name='table-event-value'] tbody>tr");
	// 准备好事件根节点
	var conditionStartNode = flowUtils.createElement('on');
		conditionStartNode.setAttribute('event', 'start');
	var conditionAfterStartNode = flowUtils.createElement('on');
	conditionAfterStartNode.setAttribute('event', 'afterStart');
	var conditionEndNode =   flowUtils.createElement('on');
		conditionEndNode.setAttribute('event', 'end');
	var conditionTransferNode =  flowUtils.createElement('on');
		conditionTransferNode.setAttribute('event', 'transfer');
		var conditionTimeoutNode =  flowUtils.createElement('on');
		conditionTimeoutNode.setAttribute('event', 'timeout');
	if (events.length > 0) {
		events.each(function(index) {
			// 解析一条数据
			var eventJSONValue = JSON.parse($(this).attr("data"));
			var eventListener = _self.eventListener(eventJSONValue);
			var eventType = eventJSONValue.eventType;
			if("start" == eventType) {
				conditionStartNode.appendChild(eventListener)
				node.appendChild(conditionStartNode);
			} else if ("afterStart" == eventType) {
				conditionAfterStartNode.appendChild(eventListener)
				node.appendChild(conditionAfterStartNode);
			}else if ("end" == eventType) {
				conditionEndNode.appendChild(eventListener)
				node.appendChild(conditionEndNode);
			} else if ("transfer" == eventType) {
				node.appendChild(eventListener);
			} else if ("timeout" == eventType) {

			} else {
				flowUtils.error("你搞一个错误的事件类型");
			}
		});
	}
}

/**
 * 封装eventListener
 * @param eventJSONValue
 * @returns
 */
NodeEvent.prototype.eventListener = function(eventJSONValue) {
	var eventListener = flowUtils.createElement('event-listener');
	eventListener.setAttribute('name', eventJSONValue.eventName);
	eventListener.setAttribute('class', eventJSONValue.event);
	// 解析field
	var fieldJSONValues = eventJSONValue.fields;
	for(var i= 0; i < fieldJSONValues.length; i++ ) {
		var fieldValue = fieldJSONValues[i];
		var fieldNode =  flowUtils.createElement('field');
		fieldNode.setAttribute('name', fieldValue.fieldName);
		var stringNode = flowUtils.createElement('string');
		stringNode.setAttribute('value', fieldValue.fieldValue);
		fieldNode.appendChild(stringNode);
		eventListener.appendChild(fieldNode);
	}
	return eventListener;
}

NodeEvent.prototype.setEventDom = function (tagNodeXml) {
//	<on event="start">
//    <event-listener name="ewf" class="fwe">
//      <field name="wef">
//        <string value="fwe"/>
//      </field>
//      <field name="fwe">
//        <string value="few"/>
//      </field>
//    </event-listener>
//  </on>
//	{"eventType":"start","eventName":"rew","event":"ewr","fields":[{"fieldName":"wer","fieldValue":"wer"}]}
	var self = this;
	// 如果是线的话，事件没有on属性
	var target = null;
	var eventType = null;
	if(tagNodeXml.nodeName == "transition") {
		target = $(tagNodeXml).children("event-listener");
		eventType = "transfer";
		this.eachEvent(target, eventType);
	} else {
        target = $(tagNodeXml).children("on[event='start']");
        this.eachEvent(target.children("event-listener"), "start");
	target = $(tagNodeXml).children("on[event='afterStart']");
	this.eachEvent(target.children("event-listener"), "afterStart");
        target = $(tagNodeXml).children("on[event='end']");
        this.eachEvent(target.children("event-listener"), "end");
    }

};
NodeEvent.prototype.eachEvent = function (targetXml, eventType) {
	var self = this;
    targetXml.each(function(i) {  // 每一行记录
        var eventName = $(this).attr("name");
        var event = $(this).attr("class");
		var display = $(this).attr("display");
		if("no" == display){
			return;
		}
        var fields = [];
        var constantValue = '';
        $(this).children('field').each(function(){
            var obj = {
                fieldName : $(this).attr("name"),
                fieldValue : $(this).children('string').attr("value")
            };
            constantValue += "【" + obj.fieldName + "=" + obj.fieldValue + "】  ";
            fields.push(obj);
        });

        var data = {};
        data.eventType = eventType;
        data.eventName = eventName;
        data.event = event;
        data.fields = fields;
        self.insertConstantsIntoTable(self.wrapper, eventName, event, eventType, constantValue, data)
    });
};

















