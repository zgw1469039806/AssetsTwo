function MethodAndClass (option) {
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
	this.template = "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/MethodAndClass/MethodAndClass.jsp?id="+id;
	this.init();
}

MethodAndClass.prototype.openDialog = function() {
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
		    			$.trim($form.find("#varInit").val())
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

MethodAndClass.prototype.init = function() {
	var _self = this;
	 $("#"+_self.id+" button[name='"+_self.buttonId+"']").on("click", function(e){
		 e.preventDefault();
		 _self.openDialog();
	 });
}
MethodAndClass.prototype.modifyValueTableTr = function ($tr, varName, varType, varInit) {
	var _self = this;
	$tr.replaceWith(_self.getValueTableTr(_self.tableId,varName, varType, varInit));
}

MethodAndClass.prototype.getXml = function(node) {
	var _self = this;
	$("#"+_self.tableId+" input").each(function(){
		var data = JSON.parse($(this).val());
		var arg = flowUtils.createElement(_self.type);
		arg.setAttribute("name", data.varName);
		var type = flowUtils.createElement(data.varType);
		if(data.varType == "object"){
			type.setAttribute("expr", data.varInit);
		}else{
			type.setAttribute("value", data.varInit);
		}
		arg.appendChild(type);
		node.appendChild(arg);
	});
}

MethodAndClass.prototype.getDom = function(node) {
	var _self = this;
	$(node).children(_self.type).each(function(){
		var _selfNode = this;
		var varName = $.trim(_selfNode.getAttribute("name"));
		var varType = "long";
		var varInit = "";
		$(_selfNode).children().each(function(){
			varType = $.trim(this.tagName);
			if(varType == "object"){
				varInit = $.trim(this.getAttribute("expr"));
			}else{
				varInit = $.trim(this.getAttribute("value"));
			}
		});
		var table =  $("#"+_self.tableId+" tbody");
    	table.append(_self.getValueTableTr(_self.tableId,
    			varName,
    			varType,
    			varInit
    			));
	}) ;
}

MethodAndClass.prototype.getValueTableTr = function (pid,varName, varType, varInit) {
	var _self = this;
	var $tr = $("<tr data-toggle='popover' title=''></tr>");
   // 增加一个hover
   var _dataContent = '<table width="180px" border="0" style="font-size:12px;"  align="center">'
			+'<tr><td width="40%" height="25"><lable>名称:</lable></td><td>'+varName+'</td></tr>'         				
				+'<tr ><td width="40%" height="25">类型:</td><td>'+varType+'</td></tr>'         				
				+'<tr><td width="40%" height="25" >初始值:</td><td>'+varInit+'</td></tr>'
				+'</table>';
   $tr.attr("data-content",_dataContent);
   $tr.popover({trigger:"hover",placement:"top",html:true});
   var $td1 = $("<td></td>");
   $td1.append(varName);
   // 添加隐藏input
   var $input = $("<input type='hidden'/>");
   var varValue ={
		   varName : varName,
		   varType : varType,
		   varInit : varInit,
   }
   $input.val(JSON.stringify(varValue));
   $td1.append($input);
   var $td2 = $("<td></td>");
   $td2.append(varType);
   var $td3 = $("<td></td>");
   $td3.append(varInit);
   
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
		    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/MethodAndClass/MethodAndClass.jsp?id="+tableId+"&act=edit&idx="+$oldTr.index() ,
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
  
   $tr.append($td1).append($td2).append($td3).append($td4);
   return $tr;
}

