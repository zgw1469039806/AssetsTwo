<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "ee/mobileupdatesmart/MobileUpdateSmartController/operation/Edit/id" -->
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" value='${mobileUpdateSmartDTO.id}' />
			<input type="hidden" name="appVersionId" value='${pid}'/>
			<table class="form_commonTable">
				<tr>
					<th width="10%">更新版本:</th>
					<td width="40%"><input title="SMART_VERSION"
						class="inputbox easyui-numberbox"
						style="width: 180px;"
						type="text" name="smartVersion" id="smartVersion" 
						value='<c:out value='${mobileUpdateSmartDTO.smartVersion}'/>'/></td>
					
					<th width="10%">发布状态:</th>
					<td width="40%">
					
						<select class="easyui-combobox" name="publicStatus" id="publicStatus" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">   
						    <option value="0" <c:if test="${mobileUpdateSmartDTO.publicStatus eq '0'}"> SELECTED</c:if>>未发布</option>   
						    <option value="1" <c:if test="${mobileUpdateSmartDTO.publicStatus eq '1'}"> SELECTED</c:if>>已发布</option>  
						</select> 
						</td>
					
				</tr>
				<tr>
					<th>备注:</th>
					<td colspan="3"><input title="DESCRIPT"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[4000]'" style="width: 180px;"
						type="text" name="descript" id="descript"
						value='<c:out value='${mobileUpdateSmartDTO.descript}'/>' /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<jsp:include page="/avicit/platform6/modules/system/swfupload/swfEditInclude.jsp">
            <jsp:param name="file_size_limit" value="5000MB" />
            <jsp:param name="file_types" value="*.*" />
            <jsp:param name="file_upload_limit" value="10" />
            <jsp:param name="save_type" value="true" /> 
            <jsp:param name="form_id" value='${mobileUpdateSmartDTO.id}' />
            <jsp:param name="form_code" value="mobile_smart_update" />
            <jsp:param name="allowAdd" value="true" />
            <jsp:param name="allowDel" value="true" />
            <jsp:param name="cleanOnExit" value="true" />
            <jsp:param name="hiddenUploadBtn" value="true" />
            <jsp:param name="secret_level" value="PLATFORM_FILE_SECRET_LEVEL" />
        </jsp:include>
					
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
		parent.mobileUpdateSmart.closeDialog("#edit");
	}
	function saveForm(){
	    if ($('#form').form('validate') == false) {
            return;
        }
		parent.mobileUpdateSmart.save(serializeObject($('#form')),callback);
	}
	   function callback(id){
        var flag = upload(id);
        if (!flag){
            closeForm();
            $.messager.show({
                 title : '提示',
                 msg : '保存成功！'
            });
        }
    }
    
    function afterUploadEvent(){
        closeForm();
        $.messager.show({
             title : '提示',
             msg : '保存成功！'
        });
    }
	
	</script>
</body>
</html>