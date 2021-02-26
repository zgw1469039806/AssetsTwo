<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>综合选择</title>
<base href="<%=ViewUtil.getRequestPath(request) %>"></base>
<title>添加</title>
<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" />
			<table class="form_commonTable">
				<tr>
					<th width="12%" style="word-break: break-all; word-warp: break-word;"><span class="remind">*</span> 岗位:</th>
					<td width="37%">
						<input title="岗位" class="inputbox" type="hidden" name="name" id="name" />
						<input class="easyui-validatebox" type="text" title="岗位" name="nameAlias" data-options="required:true" id="nameAlias"></input>
					</td>
					<th width="12%" style="word-break: break-all; word-warp: break-word;"></th>
					<td width="37%">
					</td>
				</tr>
				
				<tr>
					<th width="12%" style="word-break: break-all; word-warp: break-word;"><span class="remind">*</span> 用户:</th>
					<td width="37%">
						<input title="用户" class="inputbox" type="hidden" name="name1" id="name1" />
						<input class="easyui-validatebox" type="text" title="用户" name="nameAlias1" data-options="required:true" id="nameAlias1"></input>
					</td>
					<th width="12%" style="word-break: break-all; word-warp: break-word;"></th>
					<td width="37%">
					</td>
				</tr>
				
				<tr>
					<th width="12%" style="word-break: break-all; word-warp: break-word;"><span class="remind">*</span> 部门:</th>
					<td width="37%">
						<input title="部门" class="inputbox" type="hidden" name="name2" id="name2" />
						<input class="easyui-validatebox" type="text" title="部门" name="nameAlias2" data-options="required:true" id="nameAlias2"></input>
					</td>
					<th width="12%" style="word-break: break-all; word-warp: break-word;"></th>
					<td width="37%">
					</td>
				</tr>
			</table>
		</form>

	</div>
</body>
<script type="text/javascript">
	//岗位选择绑定事件
	var p1 ={
			type : 'positionSelect',
			idFiled : 'name',
			textFiled : 'nameAlias'
	};
	$("#nameAlias").on('focus', function(e) {
		new EasyuiCommonSelect(p1);
		this.blur();
	});
	//用户选择绑定事件
	var p2 ={
			type : 'userSelect',
			idFiled : 'name1',
			textFiled : 'nameAlias1'
	};
	$("#nameAlias1").on('focus', function(e) {
		new EasyuiCommonSelect(p2);
		this.blur();
	});

	
	//部门选择绑定事件
	var p3 ={
			type : 'deptSelect',
			idFiled : 'name2',
			textFiled : 'nameAlias2'
	};
	$("#nameAlias2").on('focus', function(e) {
		new EasyuiCommonSelect(p3);
		this.blur();
	});
</script>
</html>