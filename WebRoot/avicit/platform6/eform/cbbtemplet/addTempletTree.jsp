<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String parentTempType = request.getAttribute("parentTempType").toString();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">
		<form id='form'>
			<!-- <input type="hidden" name="sid" value=""/> -->
				<input type="hidden" id="parentId" name="parentId" value="${parentId}">
				<input type="hidden" id="id" name="id" value="">
				<input type="hidden" id="sysApplicationId" name="sysApplicationId" value="${appId}">
				<input type="hidden" id="sysId" name="sysId" value="${appId}">
				<input type="hidden" id="secretLevel" name="secretLevel" value="${secretLevel}">
				<table class="form_commonTable">
					<tr>
						<th width="10%"><span class="remind">*</span>模板编号:</th>
						<td width="40%">
							<input title="模板编号" class="easyui-validatebox" type="text" name="tempCode" id="tempCode"/>
						</td>
						<th width="10%">节点类型:</th>
						<td width="40%"><select name="tempType" id='tempType' class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							</select>
						</td>
					</tr>
					<tr>
						<th><span class="remind">*</span>模板名称:</th>
						<td>
							<input title="系统代码类型名称" class="easyui-validatebox" type="text" name="tempName" id="tempName"/>
						</td>
					</tr>
					<tr>
						<th>描述:</th>
						<td colspan="3"><input title="描述" class="easyui-validatebox" type="text" name="remark" id="remark"/></td>
					</tr>
				</table>
		</form>
		
	</div>
		<div data-options="region:'south',border:false" style="height:40px;">	
	<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
	<table class="tableForm" border="0" cellspacing="1" width='100%'>
			<tr>	
				<td align="right">
					<a href="javascript:void(0)" class="easyui-linkbutton primary-btn"  onclick="saveForm();" >保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="closeForm();" >返回</a>
				</td>
			</tr>
	</table>
	</div>
</div>
	<script type="text/javascript">
	var parentTempType = "<%=parentTempType%>";
	$(function(){
		initSelect();
	});
	
	function initSelect(){
		if (parentTempType == "R"){
			$('#tempType').combobox({   
				valueField:'value',  
				textField:'text', 
				disabled:true,
				data: [{
					text: '系统标识',
					value: 'S'
				}]
			});
			$('#tempType').combobox('setValue', 'S');
		}else{
			$('#tempType').combobox({   
				valueField:'value',  
				textField:'text', 
				editable:false,
				data: [{
					text: '模板夹',
					value: 'F'
				},
				{
					text: '模板',
					value: 'C'
				}]
			});
			$('#tempType').combobox('setValue', 'C');
		}
	}
	
	function closeForm(){
		parent.tree.closeDialog("#insert");
	}
	function saveForm(){
		var reg =/\s/;
		var tempCode =$('#tempCode').val();
		if(tempCode.length ===  0||reg.test(tempCode)){
			$.messager.alert('提示','模板编号不能为空，或含有空格字符！','warning');
			return;
		}
		if(tempCode.length >100){
			$.messager.alert('提示',"模板编号不能太长！",'warning');
			return;
		}
		var tempName =$('#tempName').val();
		if(tempName.length ===  0||reg.test(tempName)){
			$.messager.alert('提示','模板名称不能为空，或含有空格字符！','warning');
			return;
		}
		if(tempName.length >100){
			$.messager.alert('提示','模板名称不能太长！','warning');
			return;
		}
		parent.tree.save(serializeObject($('#form')),"#insert");
	}
	</script>
</body>
</html>