<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>门户复制</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<link href="static/css/platform/sysdept/icon.css" type="text/css"
	rel="stylesheet">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>

<script type="text/javascript">


$(function() {
	
	var fromCombo = $("#from").combobox({
			valueField : 'id',
			textField : 'name',
			editable : false,
			panelHeight : 200
	});
	
	var toCombo = $("#to").combobox({
		valueField : 'id',
		textField : 'name',
		editable : false,
		panelHeight : 200
	});
	
	$.ajax({
		url : 'platform/sysuser/getOrgListByUserId.json',
		type : 'get',
		dataType : 'json',
		success : function(r) {
			if (r && r.flag == 0) {
				fromCombo.combobox('loadData', r.orglist);
				fromCombo.combobox('setValue', r.currentOrgId);
				
				toCombo.combobox('loadData', r.orglist);
				toCombo.combobox('setValue', r.currentOrgId);
			}
		}
	});

});

function doCopy(){
	// 如果from和to执行同一个组织，跳过复制操作
	if($('#from').combobox('getValue') === $('#to').combobox('getValue')){
		$.messager.show({
			title:'提示',
			msg:'请选择不同的组织！'
		});
		return;		
	}

	$.ajax({
		url : 'platform/IndexPortalController/copyIndexProtlet.json',
		data : {
			fromOrgId:$('#from').combobox('getValue'),
			toOrgId:$('#to').combobox('getValue')
		},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if(r.flag == "success"){
				$.messager.show({
					title:'提示',
					msg:'复制成功！'
				});
			}else{
				$.messager.show({
					title:'提示',
					msg:'复制失败'
				});
			}
			
		}
	});
	
}
</script>
<body>
	<form id="copyPortlet" name="copyPortlet" method="post">
		<table  width="100%" style="padding-top: 10px;">
			<tr>
				<td width="80" align="right"><span>源组织：</span>
				</td>
				<td>
					<div id="from" class="easyui-combobox" name="fromSysOrg"
						style="width:200px;display:inline"></div></td>
			</tr>
			<tr>
				<br/>
			</tr>
			<tr>
				<td width="80" align="right"><span>目标组织：</span>
				</td>
				<td>
					<div id="to" class="easyui-combobox" name="toSysOrg"
						style="width:200px;display:inline"></div></td>
			</tr>
		</table>
	</form>
	
	<div style="text-align: right;">
		<div style="width:285px;">
			<br/>
			<button id="confirmBtn" onclick="doCopy();">复制</button>
		</div>
	</div>

</body>
</html>







