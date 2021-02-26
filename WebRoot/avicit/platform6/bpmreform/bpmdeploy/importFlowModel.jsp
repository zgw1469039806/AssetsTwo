<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>导入流程模板</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div id="tableToolbar" class="toolbar">
		<form role="form" id="uploadForm" style="padding-top:20px;" enctype="multipart/form-data" method="post">
			<div class="form-group">
				<table class="form_commonTable">
					<tr>
						<th width="20%"><label for="changeType">类型:</label></th>
						<td width="80%">
							<label class="radio-inline">
							    <input type="radio"  value="1" class="merchantzc_radio" checked name="changeType">BPMS文件
							</label>
							<label class="radio-inline">
							    <input type="radio"  value="0" class="merchantzc_radio" name="changeType">ARIS BPMN文件
							</label>
						</td>
					</tr>
					<tr>
						<th width="20%"><label for="changeType">导入的文件:</label></th>
						<td><input type="file" name="jpdlx2" id="jpdlx2" accept=".jpdlx2,.bpmn"></td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="id" id="id" value="<%=request.getParameter("id")%>"/>
			<input type="hidden" name="type" id="type" value="<%=request.getParameter("type")%>"/>
			<input type="hidden" name="importType" id="importType" value="1"/>
		</form>
	</div>
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
	$(document).ready(function (){
		$(".merchantzc_radio").click(function(){
			var importTypeValue = $('input[name="changeType"]:checked ').val();
			$("#importType").val(importTypeValue);
		});
	});
	function upload(index){
		var fileInput = $("#uploadForm").find("#jpdlx2");
		for (var i = 0; i < fileInput.length; i++) {
			var fileName = $(fileInput[i]).val();
			if (flowUtils.notNull(fileName)) {
				fileName = fileName.replaceAll("\\", "//");
				while (fileName.indexOf("//") != -1) {
					fileName = fileName.slice(fileName.indexOf("//") + 1);
				}
				var fileNameArr = fileName.split("\.");
				var ext = fileNameArr[fileNameArr.length - 1].toLowerCase();
				if($("#importType").val()==1){
					if (ext != "jpdlx2") {
						layer.msg("方式为“BPMS文件”时，只能导入jpdlx2格式的文件！");
						return;
					}
				}else{
					if (ext != "bpmn") {
						layer.msg("方式为“ARIS BPMN文件”时，只能导入bpmn格式的文件！");
						return;
					}
				}
			}else{
				layer.msg("请选择导入的文件！");
				return;
			}
		}
		flowUtils.confirm("确定导入？", function(){
			$("#uploadForm").ajaxSubmit({
				type : 'POST',
				url : 'platform/bpm/designer/uploadFile',
				dataType : 'text',
				success : function(r) {
					if (flowUtils.notNull(r)) {
						flowUtils.error(r);
					} else {
						$("#jpdlx2").attr("disabled","disabled")
                        flowUtils.success("导入成功",closeOpenedDialog);//回调函数中关闭对话框
						parent.flowTypeTree.clickNode();
					}
				}
			});
		});
        //关闭对话框，提示信息结束回调
        function closeOpenedDialog() {//提示信息结束回调
            parent.layer.close(index);//关闭对话框
        }
	}
</script>
</html>
