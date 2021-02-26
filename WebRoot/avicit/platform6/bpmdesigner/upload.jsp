<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>单位列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<%
	String jpdlId = request.getParameter("jpdlId");
	String type = request.getParameter("type");
%>
</head>
<body class="easyui-layout" fit="true">
	<form id="uploadForm" action="" enctype="multipart/form-data" method="post">
		<table width="100%" border="0">
			<tr>
				<td width="10%" align="right" nowrap="nowrap">选择本地流程文件</td>
				<td width="90%" align="left"><input type="file" name="jpdl" id="jpdl" accept=".jpdlx,.jpdl" /></td>
			</tr>
		</table>
		<input type="hidden" name="id" id="jpdlId" />
		<input type="hidden" name="type" id="jpdlType" />
		<input type="hidden" name="extName" id="extName" />
	</form>
</body>
<script type="text/javascript">
var nodeId = "<%=jpdlId%>";
var type = "<%=type%>";
$("#uploadForm").off("change");
$("#jpdl").val("");
$("#jpdlId").val(nodeId);
$("#jpdlType").val(type);
$("#uploadForm").on("change", function(){
	$("#extName").val("");
	var fileInput = $("#uploadForm").find("#jpdl");
	for (var i = 0; i < fileInput.length; i++) {
		var fileName = $(fileInput[i]).val();
		if ($.notNull(fileName)) {
			fileName = fileName.replaceAll("\\", "//");
			while (fileName.indexOf("//") != -1) {
				fileName = fileName.slice(fileName.indexOf("//") + 1);
			}
			var fileNameArr = fileName.split("\.");
			var ext = fileNameArr[fileNameArr.length - 1].toLowerCase();
			if (ext != "jpdlx" && ext != "jpdl") {
				dhtmlxUtils.error("只能导入jpdlx格式和jpdl格式的文件！");
				return;
			}
			$("#extName").val(ext);
		}
	}
	dhtmlx.confirm({
		title : "导入",
		text : "请慎重操作，确定导入吗？",
		callback : function(result) {
			if (result) {
				$('#uploadForm').form('submit', {
					url: _controlPath + 'uploadFile',
					success: function(result){
						if ($.notNull(result)) {
							dhtmlxUtils.error(result);
						} else {
							if($("#extName").val() == "jpdlx"){
								dhtmlxUtils.message("导入成功！");
							}else{
								dhtmlxUtils.message("导入成功！流程图更新需要打开后重新保存一下！");
							}
							_openWinForFile.close();
						}
					}
				});
			}
		}
	});
});
</script>
</html>