<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<link rel="stylesheet" type="text/css" href="static/h5/select2/select2.css"/>
<style type="text/css">
	.checkbox-inline + .checkbox-inline, .radio-inline + .radio-inline {
   	 	margin-left: 0px;
	}
	.sysdatapermissionTips1,.sysdatapermissionTips2,.sysdatapermissionTips3,.sysdatapermissionTips4{
		float: left;
	    width: 16px;
	    height: 16px;
	    background-image: url(static/images/platform/common/tips.png);
	    margin-right: 3px;
	    margin-top: 1px;
	}
</style>

</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<h3 style="text-align: center; font-weight: 600;">添加方法</h3>
		<form id='form' style="width: 96%;">
			<input type="hidden" name="id" id="id" />
			<input type="hidden" name="menuId" id="menuId" value="${menuId }"/>
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="type">类型:</label></th>
					<td width="23%">
						<label class="radio-inline">
							<input type="radio" name="type" value="0" checked="checked" />普通模块
						</label>
						<label class="radio-inline">
							<input type="radio" name="type" value="1" />电子表单
						</label>
						<label class="radio-inline">
							<input type="radio" name="type" value="2" />选择页
						</label>
					</td>
				</tr>
				
				<tr class="selectTr" style="display: none;">
					<th width="10%"><label for="selectType"><div class="sysdatapermissionTips3"></div>选择页面类型:</label></th>
					<td width="23%">
						<label class="radio-inline">
							<input type="radio" name="selectType" value="0" checked="checked" />平台自定义选择页
						</label>
						<label class="radio-inline">
							<input type="radio" name="selectType" value="1" />电子表单数据字典
						</label>
						<label class="radio-inline">
							<input type="radio" name="selectType" value="2" />自定义选择页
						</label>
					</td>
					<th width="10%"><label for="selectId"><div class="sysdatapermissionTips2"></div><i class="required">*</i>选择页唯一标识:</label></th>
					<td width="23%">
						<input class="form-control input-sm" type="text" name="selectId" id="selectId" />
					</td>
				</tr>
				<tr class="selectTr" style="display: none;">
					<th width="10%"><label>标识符说明:</label></th>
					<td width="23%" colspan="3">
						<input class="form-control input-sm" type="text" id="selectIdRemarks" />
					</td>
				</tr>
				<tr class="selectCustomTr" style="display: none;">
					<th width="10%"><label><i class="required">*</i>选择页Mapper名称:</label></th>
					<td width="23%">
						<input class="form-control input-sm" type="text" id="selectMapperName" name="selectMapperName"/>
					</td>
					<th width="10%"><label><div class="sysdatapermissionTips4"></div><i class="required">*</i>执行方法:</label></th>
					<td width="23%">
						<input class="form-control input-sm" type="text" id="selectMethodName" name="selectMethodName" />
					</td>
				</tr>
				
				<tr class="defaultAndEformTr">
					<th width="10%"><label for="tableName"><i class="required">*</i>表名称:</label></th>
					<td width="23%">
						<div class="input-group input-group-sm">
							<input class="form-control input-sm" type="text" name="tableName" id="tableName"/>
		                	<span class="input-group-addon" id="dataSourceBtn"><i class="glyphicon glyphicon-th-list"></i></span>
		          	  	</div>	
					</td>
					<th width="10%"><label for="tableRemarks"><i class="required">*</i>表说明:</label></th>
					<td width="23%"><input class="form-control input-sm" type="text" name="tableRemarks" id="tableRemarks" /></td>
				</tr>
				<tr class="EformTr" style="display: none;">
					<th width="10%"><label for="viewCode"><i class="required">*</i>视图编码:</label></th>
					<td width="23%">
						<div class="input-group input-group-sm">
							<input class="form-control input-sm" type="text" name="viewCode" id="viewCode"/>
		                	<span class="input-group-addon" id="viewCodeBtn"><i class="glyphicon glyphicon-th-list"></i></span>
		          	  	</div>	
					</td>
					<th width="10%"><label for="viewName">视图名称:</label></th>
					<td width="23%"><input class="form-control input-sm" type="text" name="viewName" id="viewName" /></td>
				</tr>
				
				<tr class="defaultTr">
					<th width="10%"><label for="mapperName"><div class="sysdatapermissionTips1"></div><i class="required">*</i>mapper名称:</label></th>
					<td width="23%">
						<div class="input-group input-group-sm">
							<input class="form-control input-sm" type="text" name="mapperName" id="mapperName"/>
		                	<span class="input-group-addon" id="mapperNameBtn"><i class="glyphicon glyphicon-th-list"></i></span>
		          	  	</div>	
					</td>
					<th width="10%"><label for="mapperRemarks"><i class="required">*</i>mapper说明:</label></th>
					<td width="23%"><input class="form-control input-sm" type="text" name="mapperRemarks" id="mapperRemarks" /></td>
				</tr>
				<tr class="defaultTr">
					<th width="10%"><label for="method"><i class="required">*</i>执行方法:</label></th>
					<td width="23%">
						<select class="js-example-basic-multiple" id="method" name="method" multiple="multiple" style="width: 100%"></select>
					</td>
					<th width="10%"><label>原sql预览:</label></th>
					<td width="23%">
						<select id="showOldSqlSelect" class="form-control input-sm"></select>
					</td>
				</tr>
				<tr class="defaultTr">
					<th width="10%"><label for="methodRemarks"><i class="required">*</i>方法说明:</label></th>
					<td width="23%">
						<textarea class="form-control input-sm" name="methodRemarks" id="methodRemarks" rows="3"></textarea>
					</td>
					<th width="10%"></th>
					<td width="23%" rowspan="2" id="textareaHtmlTd"></td>
				</tr>
				
				<tr>
					<th width="10%">初始化权限规则:</th>
					<td width="23%">
						<div class="input-group-sm "> 
							<c:forEach items="${allDefaultRule }" var="defaultRule">
								<label class="checkbox-inline"><input type="checkbox" name="defMethod" value="${defaultRule.id }">${defaultRule.ruleName }</label> 【${defaultRule.ruleRemarks }】<br/>
							</c:forEach>
						</div>
					</td>
				</tr>

			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
						title="保存" id="sysDataPermissionsMethod_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="sysDataPermissionsMethod_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript" src="static/h5/select2/select2.js"></script>
	<script type="text/javascript" src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/js/MethodCommon.js?v=<%=System.currentTimeMillis()%>"></script>
	<script type="text/javascript">
		function closeForm() {
			parent.sysDataPermissionsMethod.closeDialog("insert");
		}
		function saveForm() {
			//限制保存按钮多次点击
			$('#sysDataPermissionsMethod_saveForm').addClass('disabled').unbind("click");
			parent.sysDataPermissionsMethod.save($('#form'), "insert");
		}

		$(document).ready(function() {
			//保存按钮绑定事件
			$('#sysDataPermissionsMethod_saveForm').bind('click', function() {
				if(validateForm()){
					saveForm();
				}
			});
			
			//返回按钮绑定事件
			$('#sysDataPermissionsMethod_closeForm').bind('click', function() {
				closeForm();
			});
			
			$("#method").select2({});
		});
	</script>
</body>
</html>