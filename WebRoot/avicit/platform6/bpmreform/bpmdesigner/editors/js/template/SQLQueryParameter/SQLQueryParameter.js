function SQLQueryParameter (option) {
	this.id = option.id
	this.tableId = option.tableId;
	this.buttonId = option.buttonId;
	this.callback = option.callback;
	this.option = option;
	this.type = option.type;
	this.form = null;
	// 将配置信息保存到dom对象里，方便在弹出页面调用
	$("#"+this.tableId).data("data-object", this);
	var id = encodeURIComponent(this.tableId);
	this.template = "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/SQLQueryParameter/SQLQueryParameter.jsp?id="+id;
	this.init();
}

SQLQueryParameter.prototype.openDialog = function() {
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
		    			$.trim($form.find("#varType").val()),
		    			$.trim($form.find("#varInit").val()),
		    			$.trim($form.find("#varAlias").val())
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

SQLQueryParameter.prototype.init = function() {
	var _self = this;
	 $("#"+_self.id+" button[name='"+_self.buttonId+"']").on("click", function(e){
		 e.preventDefault();
		 _self.openDialog();
	 });
}
SQLQueryParameter.prototype.modifyValueTableTr = function ($tr, varName, varType, varInit,varAlias) {
	var _self = this;
	$tr.replaceWith(_self.getValueTableTr(_self.tableId,varName, varType, varInit,varAlias));
}

SQLQueryParameter.prototype.getXml = function(node) {
	var _self = this;
    var parameters = flowUtils.createElement(_self.type);
	$("#"+_self.tableId+" input").each(function(){
		var data = JSON.parse($(this).val());
		var type = flowUtils.createElement(data.varType);
		type.setAttribute("alias", data.varAlias);
		type.setAttribute("name", data.varName);
		if("object"==data.varType){
			type.setAttribute("expr", data.varInit);
		}else{
			type.setAttribute("value", data.varInit);
		}		
        parameters.appendChild(type);
	});
    node.appendChild(parameters);
}

SQLQueryParameter.prototype.getDom = function(node) {
	var _self = this;
	$(node).children(_self.type).children().each(function(){
		var _selfNode = this;
		var varType = _selfNode.tagName;
		var varAlias = $.trim(_selfNode.getAttribute("alias"));
		var varName = $.trim(_selfNode.getAttribute("name"));
		var varInit;
		if("object"==varType){
			varInit = $.trim(_selfNode.getAttribute("expr"));
		}else{
			varInit = $.trim(_selfNode.getAttribute("value"));
		}
		
		var table =  $("#"+_self.tableId+" tbody");
    	table.append(_self.getValueTableTr(_self.tableId,
    			varName,
    			varType,
    			varInit,
                varAlias
    			));
	}) ;
}

SQLQueryParameter.prototype.getValueTableTr = function (pid,varName, varType, varInit, varAlias) {
	var _self = this;
	var $tr = $("<tr data-toggle='popover' title=''></tr>");
   // 增加一个hover
   var _dataContent = '<table width="180px" border="0" style="font-size:12px;"  align="center">'
			+'<tr><td width="40%" height="25"><lable>参数名:</lable></td><td>'+varAlias+'</td></tr>'
			+'<tr><td width="40%" height="25"><lable>参数:</lable></td><td>'+varName+'</td></tr>'
				+'<tr ><td width="40%" height="25">类型:</td><td>'+varType+'</td></tr>'
				+'<tr><td width="40%" height="25" >参数值:</td><td>'+varInit+'</td></tr>'
				+'</table>';
   $tr.attr("data-content",_dataContent);
   $tr.popover({trigger:"hover",placement:"top",html:true});

    var $td1 = $("<td></td>");
    $td1.append(varAlias);
    // 添加隐藏input
    var $input = $("<input type='hidden'/>");
    var varValue ={
        varName : varName,
        varType : varType,
        varInit : varInit,
        varAlias : varAlias
    }
    $input.val(JSON.stringify(varValue));
    $td1.append($input);

   var $td2 = $("<td></td>");
   $td2.append(varName);
   var $td3 = $("<td></td>");
   $td3.append(varType);
   var $td4 = $("<td></td>");
   $td4.append(varInit);

   var op = "<td><a href='javascript:void(0)' name='deleteData'><i class='iconfont icon-delete'></i></a>" +
	   "<a href='javascript:void(0)' name='modifyData' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
   var $td5 = $(op);
   $td5.find("a[name='deleteData']").off("click").on("click",function() {
	   $(this).parent().parent().siblings("div").remove();
  	 $(this).parent().parent().remove();
   });
   $td5.find("a[name='modifyData']").off("click").on("click",function() {
	   var tableId =  encodeURIComponent(_self.tableId);
	   var $oldTr = $(this).parentsUntil("tr").parent();
	   layer.open({
		    type:  2,
		    area: [ "680px",  "300px"],
		    title: "模板选择",
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		    shade:   0.3,
	        maxmin: false, //开启最大化最小化按钮
		    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/SQLQueryParameter/SQLQueryParameter.jsp?id="+tableId+"&act=edit&idx="+$oldTr.index() ,
		    btn: ['确定', '关闭'],
		    yes: function(index, layero){
		    	var $form =_self.form;
		    	var isValidate = $form.validate();
		    	if (!isValidate.checkForm()) {
			            isValidate.showErrors();
			            return;
			     }
		    	_self.modifyValueTableTr($oldTr, $.trim($form.find("#varName").val()),
		    			$.trim($form.find("#varType").val()),
		    			$.trim($form.find("#varInit").val()),
                   		 $.trim($form.find("#varAlias").val()));
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
  
   $tr.append($td1).append($td2).append($td3).append($td4).append($td5);
   return $tr;
}

