<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "phoneproject/portalimage/PortalImageController/operation/Edit/id" -->
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow: auto; padding-bottom: 35px;">
		<form id='form'>
			<input type="hidden" name="id" value='${portalImageDTO.id}' />
			<table width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right"><span class="remind">*</span>图片名称:</th>
					<td><input title="图片名称" class="inputbox easyui-validatebox" data-options="validType:'maxLength[200]',required:true,validType:'pattern'"
						style="width: 180px;" type="text" name="imageName" id="imageName" value='${portalImageDTO.imageName}' /></td>
					<th align="right"><span class="remind">*</span>显示顺序:</th>
					<td><input title="显示顺序" class="easyui-numberbox easyui-validatebox" data-options="validType:'maxLength[22]',required:true,validType:'number'"
						style="width: 180px;" type="text" name="imageOrder" id="imageOrder" value='${portalImageDTO.imageOrder}' /></td>
				</tr>
			</table>
		</form>
		<fieldset style="margin:20px;font-weight:bold">
		<legend><span class="remind">*</span>图片</legend>
		<div class="formExtendBase">
			<div class="column">
				<jsp:include page="/avicit/platform6/modules/system/swfupload/swfEditInclude.jsp">
				<jsp:param name="file_size_limit" value="10 MB"/>
				<jsp:param name="file_types" value="*.jpg;*.jpeg;*.gif;*.ico;*.png;*.psd;*.raw"/>
				<jsp:param name="file_upload_limit" value="1"/>
				<jsp:param name="save_type" value="false"/>
				<jsp:param name="form_id" value="${portalImageDTO.id}"/>
				<jsp:param name="form_code" value="portal_program_img"/>
				<jsp:param name="allowAdd" value="true"/>
				<jsp:param name="allowDel" value="true"/>
				<jsp:param name="cleanOnExit" value="true"/>
				<jsp:param name="secret_level" value="PLATFORM_FILE_SECRET_LEVEL"/>
				</jsp:include>
			</div>
		</div>
	</fieldset>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="保存" id="saveButton" class="easyui-linkbutton" onclick="saveForm();"
						href="javascript:void(0);">保存</a> <a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		$.extend($.fn.validatebox.defaults.rules, {
			maxLength : {
				validator : function(value, param) {
					return param[0] >= value.length;

				},
				message : '请输入最多 {0} 字符.'
			},
			pattern:{
				validator : function(value, param) {
					return /^[a-zA-Z][a-zA-Z0-9_-]*$/.test(value);

				},
				message : '只能是字母数字下划线中横杠,且以字母开头.'
			},
			number:{
				validator : function(value, param) {
					return /^\d*$/.test(value);

				},
				message : '只能是数字.'
			}
		});
		$(function() {
		})
		function closeForm() {
			parent.portalImage.closeDialog("#edit");
		}
		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			var stats = swfu.getStats();
			if (stats.successful_uploads!=1) {
				$.messager.show({
					 title : '提示',
					 msg : '请上传图片'
				});
				return;
			}
			parent.portalImage.save(serializeObject($('#form')), "#edit");
		}
	</script>
</body>
</html>