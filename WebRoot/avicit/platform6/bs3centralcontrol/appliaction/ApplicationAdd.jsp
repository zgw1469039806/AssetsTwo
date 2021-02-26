<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,form";	
%>
<!DOCTYPE html>
<HTML>
<head>
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="applicationName">应用名称:</label></th>
					<td width="39%">
		                <input class="form-control input-sm" type="text" name="applicationName" id="applicationName" />
					</td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="applicationCode">应用编码:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="applicationCode" id="applicationCode"/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="basepath">应用地址:</label></th>
					<td width="39%"><input type="text" class="form-control input-sm" rows="3" title="菜单URL" name="basepath" id="basepath"></input></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="orderBy">应用排序:</label></th>
					<td width="39%"><div class="input-group input-group-sm spinner" data-trigger="spinner">
					   <input title="" type="text" class="form-control" name="orderBy" id="orderBy"  data-min="0" data-max="1000" data-step="1" data-precision="0">
					   <span class="input-group-addon">
					      <a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>
					      <a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a>
					   </span>
					</div></td>
				</tr>

				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="runState">应用状态:</label></th>
					<td width="39%">
						<label class="radio-inline"> <input id="runState" name="runState" title="正常" type="radio" value="1" >正常</label>
						<label class="radio-inline"> <input name="runState" title="无效" type="radio" value="0" checked>无效</label>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="isPortal">是否门户:</label></th>
					<td width="39%">
						<select id="isPortal" name="isPortal">
						  <option value="0">否</option>
						  <option value="1">是</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="description">描述:</label></th>
					<td width="39%" colspan="3"><textarea class="form-control input-sm" rows="3" title="描述" name="description" id="description"></textarea></td>
				</tr>
					
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
						<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="demoSingle_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="demoSingle_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		function closeForm(){
			parent.menuPortal.closeDialog("insert");
		};
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.menuPortal.save($('#form'),"insert");
		};
		$(function(){
			parent.menuPortal.formValidate($('#form'));
			//保存按钮绑定事件
			$('#demoSingle_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#demoSingle_closeForm').bind('click', function(){
				closeForm();
			});
		});
	</script>
</body>
</html>