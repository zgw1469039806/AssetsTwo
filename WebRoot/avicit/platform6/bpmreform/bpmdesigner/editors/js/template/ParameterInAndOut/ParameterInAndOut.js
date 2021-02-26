function ParameterInAndOut (option) {
	this.id = option.id;
	this.parentId = option.parentId;
	this.tableId = option.tableId;
	this.buttonId = option.buttonId;
	this.callback = option.callback;
	this.option = option;
	this.type = option.type;
	this.form = null;
	// 将配置信息保存到dom对象里，方便在弹出页面调用
	$("#"+this.tableId).data("data-object", this);
	var id = encodeURIComponent(this.tableId);
	this.template = "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ParameterInAndOut/ParameterInAndOut.jsp?id="+id;
	this.init();
}

ParameterInAndOut.prototype.openDialog = function() {
	var _self = this;
	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
		var box = layer.open({
		    type:  2,
		    area: [ "680px",  "300px"],
		    title: "模板选择",
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		    shade:   0.3,
	        maxmin: false, //开启最大化最小化按钮
		    content: _self.template ,
		    btn: ['确定', '关闭'],
		    yes: function(index, layero){
		    	var $form =_self.form;
		    	var isValidate = $form.validate();
		    	if (!isValidate.checkForm()) {
			            isValidate.showErrors();
			            return;
			     }
		    	var table =  $("#"+_self.tableId+" tbody");
		    	table.append(_self.getValueTableTr(_self.tableId,
		    			$.trim($form.find("#varName").val()),
		    			$.trim($form.find("#varInit").val()),
		    			true,
		    			true
		    			));
		    	layer.close(index);
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
}

ParameterInAndOut.prototype.init = function() {
	var _self = this;
	 $("#"+_self.id+" button[name='"+_self.buttonId+"']").on("click", function(e){
		 e.preventDefault();
		 _self.openDialog();
	 });
}
ParameterInAndOut.prototype.modifyValueTableTr = function ($tr, varName,  varInit) {
	var _self = this;
	$tr.replaceWith(_self.getValueTableTr(_self.tableId,varName, varInit,true,true));
}

ParameterInAndOut.prototype.getXml = function(node) {
	var _self = this;
	$("#"+_self.tableId+" input").each(function(){
		var data = JSON.parse($(this).val());
		var arg = flowUtils.createElement(_self.type);
		arg.setAttribute("var", data.varName);
		arg.setAttribute("subvar", data.varInit);

		node.appendChild(arg);
	});
}
ParameterInAndOut.prototype.getOutXml = function(node) {
	var _self = this;
	$("#"+_self.tableId+" input").each(function(){
		var data = JSON.parse($(this).val());
		var arg = flowUtils.createElement(_self.type);
		arg.setAttribute("subvar", data.varName);
		arg.setAttribute("var", data.varInit);

		node.appendChild(arg);
	});
}
ParameterInAndOut.prototype.getDom = function(node) {
	var _self = this;
	var table =  $("#"+_self.tableId+" tbody");
	$(node).children(_self.type).each(function(){
		var _selfNode = this;
		var varName = $.trim(_selfNode.getAttribute("var"));
		var varInit = $.trim(_selfNode.getAttribute("subvar"));
    	table.append(_self.getValueTableTr(_self.tableId,
    			varName,
    			varInit,
    			true,
    			false
    			));
	}) ;
	var subTableDataMap = {};
	$(node).children("form-in").each(function(){
		var _selfNode = this;
		var varName = $.trim(_selfNode.getAttribute("fromComments"));
		var varInit = $.trim(_selfNode.getAttribute("colComments"));

		var isSubTable = $.trim(_selfNode.getAttribute("isSubTable"));
		if("1"!=isSubTable){
            table.append(_self.getValueTableTr(_self.tableId,
                varName,
                varInit,
                false,
                false
            ));
        }else{
            var subFormTable = $.trim(_selfNode.getAttribute("subFormTable"));
            var field = {};
            field.fromComments = varName;
            field.colComments = varInit;
            if(subTableDataMap[subFormTable]){
                subTableDataMap[subFormTable].push(field);
            }else{
                subTableDataMap[subFormTable] = [];
                subTableDataMap[subFormTable].push(field);
            }
        }
	}) ;
    var parentDiv = table.parent().parent();
    parentDiv.find(".subTable").remove();
    for(var key in subTableDataMap){
        var subTableCols = subTableDataMap[key];
        var $subTable = $("<table  class='table table-hover table-bordered table-fix subTable'></table>");
        $subTable.attr("id","subTable_"+key);
        var $thead = $("<thead></thead>");
        var $theadTrTitle = $("<tr style='background-color: #f3f4f480!important'></tr>");
        var $theadTdTitle = $("<td colspan='2'>主流程子表["+key+"]</td>");
        $theadTrTitle.append($theadTdTitle);
        $thead.append($theadTrTitle);
        var $theadTr = $("<tr></tr>");
        var $theadTd1 = $("<td style=\"width: 40%\">主流程子表输出参数</td>");
        var $theadTd2 = $("<td style=\"width: 40%\">子流程子表接收参数</td>");
        $theadTr.append($theadTd1);
        $theadTr.append($theadTd2);
        $thead.append($theadTr);
        $subTable.append($thead);
        var $tbody = $("<tbody></tbody>");
        for(var i=0;i<subTableCols.length;i++){
            var subField = subTableCols[i];
            var varName = subField.fromComments;
            var varInit = subField.colComments;
            $subTable.append(_self.getValueTableTr(_self.tableId,
                varName,
                varInit,
                false,
                false
            ));
        }
        $subTable.append($tbody);
        parentDiv.append($subTable);

    }
}
ParameterInAndOut.prototype.getOutDom = function(node) {
	var _self = this;
	var table =  $("#"+_self.tableId+" tbody");
	$(node).children(_self.type).each(function(){
		var _selfNode = this;
		var varName = $.trim(_selfNode.getAttribute("subvar"));
		var varInit = $.trim(_selfNode.getAttribute("var"));
    	table.append(_self.getValueTableTr(_self.tableId,
    			varName,
    			varInit,
    			true,
    			false
    			));
	}) ;
	
	$(node).children("form-out").each(function(){
		var _selfNode = this;
		var varName = $.trim(_selfNode.getAttribute("fromComments"));
		var varInit = $.trim(_selfNode.getAttribute("colComments"));
		table.append(_self.getValueTableTr(_self.tableId,
    			varName,
    			varInit,
    			false,
    			false
    			));
	}) ;
}
ParameterInAndOut.prototype.getValueTableTr = function (pid,varName,  varInit,hasInput,isModify) {
	var _self = this;
	var $tr = $("<tr data-toggle='popover' title=''></tr>");
   // 增加一个hover
   var _dataContent = '<table width="180px" border="0" style="font-size:12px;"  align="center">'
			+'<tr><td width="40%" height="25"><lable>输出参数:</lable></td><td>'+varName+'</td></tr>'
				+'<tr><td width="40%" height="25" >输入参数:</td><td>'+varInit+'</td></tr>'
				+'</table>';
   $tr.attr("data-content",_dataContent);
   $tr.popover({trigger:"hover",placement:"top",html:true});
   var $td1 = $("<td></td>");
   $td1.append(varName);
   if(hasInput){
	// 添加隐藏input
	   var $input = $("<input type='hidden'/>");
	   var varValue ={
			   varName : varName,
			   varInit : varInit,
	   }
	   $input.val(JSON.stringify(varValue));
	   $td1.append($input);
   }
   var $td3 = $("<td></td>");
   $td3.append(varInit);
   if(isModify){
	   var op = "<td><a href='javascript:void(0)' name='deleteData'><i class='iconfont icon-delete'></i></a>" +
	   "<a href='javascript:void(0)' name='modifyData' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
	   var $td4 = $(op);
	   $td4.find("a[name='deleteData']").off("click").on("click",function() {
		   $(this).parent().parent().siblings("div").remove();
	  	 $(this).parent().parent().remove();
	   });
	   $td4.find("a[name='modifyData']").off("click").on("click",function() {
		   var tableId =  encodeURIComponent(_self.tableId);
		   var $oldTr = $(this).parentsUntil("tr").parent();
		   layer.open({
			    type:  2,
			    area: [ "680px",  "300px"],
			    title: "模板选择",
			    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
			    shade:   0.3,
		        maxmin: false, //开启最大化最小化按钮
			    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ParameterInAndOut/ParameterInAndOut.jsp?id="+tableId+"&act=edit&idx="+$oldTr.index() ,
			    btn: ['确定', '关闭'],
			    yes: function(index, layero){
			    	var $form =_self.form;
			    	var isValidate = $form.validate();
			    	if (!isValidate.checkForm()) {
				            isValidate.showErrors();
				            return;
				     }
			    	_self.modifyValueTableTr($oldTr, $.trim($form.find("#varName").val()),
			    			$.trim($form.find("#varInit").val()));
			    	layer.close(index);
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
	   $tr.append($td1).append($td3).append($td4);
   }else{
	   $tr.append($td1).append($td3);
   }
   
   return $tr;
}

ParameterInAndOut.prototype.initDataFromParent = function(){
	var _self = this;	
	var table =  $("#"+_self.tableId+" tbody");
	table.empty();
	var arrInput = $("#"+_self.parentId+" #"+_self.tableId+" input",window.parent.document);
	$("#"+_self.parentId+ " #"+_self.tableId+" input",window.parent.document).each(function(){
		var _selfNode = this;
		var data = JSON.parse($(this).val());		
		var varName = data.varName;
		var varInit = data.varInit;
    	table.append(_self.getValueTableTr(_self.tableId,
    			varName,
    			varInit,
    			true,
    			true
    			));

	});
}

ParameterInAndOut.prototype.setDataToParent = function(fieldData){
    var _self = this;
    var table =  $("#"+_self.parentId+" #"+_self.tableId+" tbody",window.parent.document);
    table.empty();
    $("#"+_self.tableId+" input").each(function(){
        var _selfNode = this;
        var data = JSON.parse($(this).val());
        var varName = data.varName;
        var varInit = data.varInit;
        table.append(_self.getValueTableTr(_self.tableId,
            varName,
            varInit,
            true,
            false
        ));

    });
    if(fieldData && fieldData.length){
        for(var i=0;i<fieldData.length;i++){
            var data = fieldData[i];
            if(data.subFormCol =='' || data.subFormCol == '请选择'){
                continue;
            }
            var varName = data.fromComments;
            var varInit = data.colComments;
            table.append(_self.getValueTableTr(_self.tableId,
                varName,
                varInit,
                false,
                false
            ));
        }
    }
}

ParameterInAndOut.prototype.setSubTableDataToParent = function(subTableDataMap){
    var _self = this;
    var table =  $("#"+_self.parentId+" #"+_self.tableId+" tbody",window.parent.document);
    var parentDiv = table.parent().parent();
    parentDiv.find(".subTable").remove();
    for(var key in subTableDataMap){
        var subTableCols = subTableDataMap[key];
        var $subTable = $("<table class='table table-hover table-bordered table-fix subTable'></table>");
        $subTable.attr("id","subTable_"+key);
        var $thead = $("<thead></thead>");
        var $theadTrTitle = $("<tr></tr>");
        var $theadTdTitle = $("<td colspan='2'>主流程子表【"+key+"】</td>");
        $theadTrTitle.append($theadTdTitle);
        $thead.append($theadTrTitle);
        var $theadTr = $("<tr></tr>");
        var $theadTd1 = $("<td style=\"width: 40%\">主流程子表输出参数</td>");
        var $theadTd2 = $("<td style=\"width: 40%\">子流程子表接收参数</td>");
        $theadTr.append($theadTd1);
        $theadTr.append($theadTd2);
        $thead.append($theadTr);
        $subTable.append($thead);
        var $tbody = $("<tbody></tbody>");
        for(var i=0;i<subTableCols.length;i++){
            var subField = subTableCols[i];
            var varName = subField.fromComments;
            var varInit = subField.colComments;
            $subTable.append(_self.getValueTableTr(_self.tableId,
                varName,
                varInit,
                false,
                false
            ));
        }
        $subTable.append($tbody);
        parentDiv.append($subTable);

    }
}

