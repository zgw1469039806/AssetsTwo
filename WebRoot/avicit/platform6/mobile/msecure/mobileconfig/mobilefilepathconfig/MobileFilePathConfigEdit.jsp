<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/msecure/mobileconfig/mobilefilepathconfig/MobileFilePathConfigController/operation/Edit/id" -->
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" value='${mobileFilePathConfigDTO.id}' />
			<table class="form_commonTable">
				<tr>
					<th width="15%"><span class="remind">*</span>应用配置:</th>
					<td width="35%"><input title="FILE_PATH_NAME"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[100]'"
						type="text" name="filePathName" id="filePathName"
						value='<c:out value='${mobileFilePathConfigDTO.filePathName}'/>' />
					</td>
					<th width="15%"><span class="remind">*</span>文件路径:</th>
					<td width="35%"><input title="FILE_PATH"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[500]'"
						type="text" name="filePath" id="filePath"
						value='<c:out value='${mobileFilePathConfigDTO.filePath}'/>' /></td>
				</tr>
				<tr>
					<th>描述:</th>
					<td colspan="3"><input title="DESCRIPTION"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[240]'"
						type="text" name="description" id="description"
						value='<c:out value='${mobileFilePathConfigDTO.description}'/>' />
					</td>
				</tr>
			</table>
		</form>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td width="50%" align="right">
						<a title="保存" id="saveButton" class="easyui-linkbutton primary-btn" onclick="saveForm();" href="javascript:void(0);">保存</a>
						<a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>  
	<script type="text/javascript">
		$.extend($.fn.validatebox.defaults.rules, {    
        maxLength: {    
            validator: function(value, param){    
                return param[0] >= value.length;
                
            },    
            message: '请输入最多 {0} 字符.'   
        }    
    });  
	$(function(){
																																																																																																																																																							})
	function closeForm(){
		parent.mobileFilePathConfig.closeDialog("#edit");
	}
	function saveForm(){
	    if ($('#form').form('validate') == false) {
            return;
        }
		parent.mobileFilePathConfig.save(serializeObject($('#form')),"#edit");
	}
	</script>
</body>
</html>