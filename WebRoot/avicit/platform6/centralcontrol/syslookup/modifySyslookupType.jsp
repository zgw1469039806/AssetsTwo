<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<style type="text/css">
.inputbox{
	background-color: #fff;
	border: 1px solid #95b8e7;
	color: #000;
	height: 18px;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">
		<form id='form'>
			<input type="hidden" name="sid" value='${syslookupType.sid}'/>
				<table width="100%" style="padding-top: 10px;">
					<tr>
						<th align="right"><span style="color: red;">*</span>系统代码类型 :</th>
						<td><span style="padding:0px;margin: 0px;">
							  	<input title="系统代码类型" class="inputbox" style="width: 180px;" type="text" name="lookupType" id="lookupType" value='${syslookupType.lookupType}' />
							</span></td>
						<th align="right">使用级别 :</th>
						<td><select name="usageModifier" class="easyui-combobox" data-options="width:173,editable:false,panelHeight:'auto'">
							<c:forEach items="${usageModifier}" var="usageModifier">
								<option value="${usageModifier.lookupCode}" <c:if test="${usageModifier.lookupCode eq syslookupType.usageModifier}">SELECTED</c:if>>${usageModifier.lookupName}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th align="right"><span style="color: red;">*</span>系统代码类型名称 :</th>
						<td>
							<span style="padding:0px;margin: 0px;">
								<input title="系统代码类型名称" class="inputbox" style="width: 180px;" type="text" name="lookupTypeName" id="lookupTypeName" value='${syslookupType.lookupTypeName}'/></span>
						</td>
						<th align="right">有效标识:</th>
						<td><select name="validFlag" class="easyui-combobox" data-options="width:173,editable:false,panelHeight:'auto'">
							<c:forEach items="${validFlag}" var="validFlag">
								<option value="${validFlag.lookupCode}" <c:if test="${validFlag.lookupCode eq syslookupType.validFlag}">SELECTED</c:if>>${validFlag.lookupName}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th align="right">应用程序名称:</th>
						<td><select name="sysApplicationId" class="easyui-combobox"  data-options="width:183,editable:false,panelHeight:'auto'">
							<c:forEach items="${appsList}" var="appsList">
								<option value="${appsList.id}" <c:if test="${appsList.id eq appId}">SELECTED</c:if>>${appsList.applicationName}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th align="right">描述:</th>
						<td colspan="3"><input title="系统代码类型名称" class="inputbox" style="width: 503px;" type="text" name="description" id="description" value='${syslookupType.description}'/></td>
					</tr>
				</table>
		</form>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td align="right" width="60%">
						<a title="保存" id="saveButton"  class="easyui-linkbutton" plain="false" onclick="saveForm();" href="javascript:void(0);">保存</a>
						<a title="返回" id="returnButton"  class="easyui-linkbutton"  plain="false" onclick="closeForm();" href="javascript:void(0);">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
	function closeForm(){
		parent.sysLookupType.closeDialog("#edit");
	}
	function saveForm(){
		var reg =/\s/;
		var lookupType =$('#lookupType').val();
		if(lookupType.length ===  0||reg.test(lookupType)){
			$.messager.alert('提示','系统代码类型不能为空，或含有空格字符！','warning');
			return;
		}
		if(lookupType.length >100){
			$.messager.alert('提示',"系统代码类型不能太长！",'warning');
			return;
		}
		var lookupTypeName =$('#lookupTypeName').val();
		if(lookupTypeName.length ===  0||reg.test(lookupTypeName)){
			$.messager.alert('提示','系统代码类型名称不能为空，或含有空格字符！','warning');
			return;
		}
		if(lookupTypeName.length >100){
			$.messager.alert('提示','系统代码类型名称不能太长！','warning');
			return;
		}
		parent.sysLookupType.save(serializeObject($('#form')),'${url}',"#edit");
	}
	</script>
</body>
</html>