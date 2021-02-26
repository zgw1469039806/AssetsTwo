<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/msecure/mobiledevelopproduct/MobileDevelopProductController/operation/Edit/id" -->
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" value='${mobileDevelopProductDTO.id}' />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><span style="color:red;">*</span>对应设备:</th>
					<td width="40%">
						<select name="appid" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<c:forEach items="${mobileApp}" var="mobileApp">
							<option value="${mobileApp.id}"
								<c:if test="${mobileApp.id eq mobileDevelopProductDTO.appid}">SELECTED</c:if>>${mobileApp.appName}</option>
							</c:forEach>
						</select>
					</td>
					<th width="10%">设备系统:</th>
					<td width="40%">
						<pt6:syslookup name="platform" lookupCode="PLATFORM_MOBILE_PLATFORM" defaultValue='${mobileDevelopProductDTO.platform}' dataOptions="onShowPanel:comboboxOnShowPanel,editable:false,panelHeight:'auto'">
						</pt6:syslookup> 
					</td>
				</tr>
				<tr>
					<th>证书类型:</th>
					<td>
						<pt6:syslookup name="certType" lookupCode="PLATFORM_MOBILE_CERT_TYPE" defaultValue='${mobileDevelopProductDTO.certType}' dataOptions="onShowPanel:comboboxOnShowPanel,editable:false,panelHeight:'auto'">
						</pt6:syslookup> 
					</td>
					<th>证书密码:</th>
					<td><input title="PASSWORD"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[100]'" style="width: 180px;"
						type="text" name="password" id="password"
						value='<c:out value='${mobileDevelopProductDTO.password}'/>' /></td>
				</tr>
				<tr>
					<th>备注:</th>
					<td colspan="3"><input title="REMARK"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[3000]'" style="width: 180px;"
						type="text" name="remark" id="remark"
						value='<c:out value='${mobileDevelopProductDTO.remark}'/>' /></td>
				</tr>
			</table>
		</form>
		<jsp:include
			page="/avicit/platform6/modules/system/swfupload/swfEditInclude.jsp">
			<jsp:param name="file_size_limit" value="5000MB" />
			<jsp:param name="file_types" value="*.*" />
			<jsp:param name="file_upload_limit" value="10" />
			<jsp:param name="save_type" value="false" />
			<jsp:param name="form_id" value='${mobileDevelopProductDTO.id}' />
			<jsp:param name="form_code" value="mobile_cert" />
			<jsp:param name="allowAdd" value="true" />
			<jsp:param name="allowDel" value="true" />
			<jsp:param name="cleanOnExit" value="true" />
			<jsp:param name="hiddenUploadBtn" value="true" />
			<jsp:param name="secret_level" value="PLATFORM_FILE_SECRET_LEVEL" />
		</jsp:include>

		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="保存" id="saveButton"
						class="easyui-linkbutton primary-btn" onclick="saveForm();"
						href="javascript:void(0);">保存</a> <a title="返回" id="returnButton"
						class="easyui-linkbutton" onclick="closeForm();"
						href="javascript:void(0);">返回</a></td>
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
		parent.mobileDevelopProduct.closeDialog("#edit");
	}
	function saveForm(){
	    if ($('#form').form('validate') == false) {
            return;
        }
		parent.mobileDevelopProduct.save(serializeObject($('#form')),callback);
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