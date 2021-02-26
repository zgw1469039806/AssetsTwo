<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>候选人</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link href="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/theme.css" rel="stylesheet">
<link href="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect.css" rel="stylesheet">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelectView.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/CommonSelectTree.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
</head>

<body>
        <div class="container">
           <form class="form-horizontal">
			   <div class="form-group ">
				   <label class="col-sm-2 control-label">事件选择</label>
				   <div class="col-sm-10">
					   <select class="form-control" name="userSelect">
					   </select>
				   </div>
			   </div>
			    <div class="form-group">
			    <label for="input-function-name" class="col-sm-2 control-label"><i class="required">*</i>函数:</label>
			    <div class="col-sm-10">
			      <input name="input-function-name" id="input-function-name"  type="text" class="form-control" onkeyup="check(this)"/>
			    </div>
			  </div>
			  </form>
              <%--<div class="pull-right">
              	 <button name="chooseDeptButtion" type="button" class="btn btn-default form-tool-btn btn-sm " disabled="disabled">确定</button>
              </div>--%>
        </div>
</body>
<script type="text/javascript">
var index = parent.layer.getFrameIndex(window.name); //获取窗口索引

/*$(function(){
	var pid = flowUtils.getUrlQuery("id");
	var pname = flowUtils.getUrlQuery("name");
	$("button[name='chooseDeptButtion']").on('click',function(){
		parent.addCustomNodeInfoUserSelectView(pid,pname,$("#input-function-name").val(),$("#input-function-name").val());
		parent.layer.close(index);
	});
	
});*/

function check(obj){
	if(obj.value!=''){
		$("button[name='chooseDeptButtion']").removeAttr("disabled");
	}else{
		$("button[name='chooseDeptButtion']").attr("disabled","disabled");
	}
}
$(function () {
	$.ajax({
		type : "POST",
		url : "platform/bpm/bpmconsole/eventManageAction/getEventListForDesigner",
		data : {
			type : "流程自定义选人"
		},
		dataType : "json",
		success : function(result) {
			$("select[name = 'userSelect']").each(function (i, n) {
				$(result).each(function (j, m) {
					var option = $("<option value='"+m.value+"'>"+m.text+"</option>");
					$(n).append(option);
				});
			});
		}
	});

	$("select[name = 'userSelect']").change(function () {
		var value = $(this).val();
		var _self = $(this);
		$(_self).parents(".form-group").siblings().find("#input-function-name").val("");
		if (value != "") {
			$.ajax({
				type : "POST",
				url : "platform/bpm/bpmconsole/eventManageAction/getEventInfoForDesigner",
				data : {
					id : value
				},
				dataType : "json",
				success : function(result) {
					var bpmClass = result.bpmClass;
					if (bpmClass) {
						$(_self).parents(".form-group").siblings().find("#input-function-name").val(bpmClass.path);
					}
				}
			});
		}
	});
});
</script>
</html>

