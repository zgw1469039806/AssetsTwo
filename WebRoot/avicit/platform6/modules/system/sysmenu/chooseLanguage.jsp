<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>语言配置</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center'" style="background:#ffffff;">
		<!-- <div id="toolbarchooseLanguage" class="datagrid-toolbar">
		 	<table>
		 		<tr>
					<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="chooseLanguage.save();" href="javascript:void(0);">保存</a></td>
				</tr>
		 	</table>
	 	</div> -->
	 	<table id="dgchooseLanguage"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				idField :'id',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				method:'get',
				striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',hidden:true" width="220">id</th>
					<th data-options="field:'sysLanguageCode', required:true,align:'center'"  width="220"><span style="color:red;">*</span>语言编号</th>
					<th data-options="field:'sysLanguageName',required:true,align:'center'"  width="220"><span style="color:red;">*</span>语言名称</th>
					<th data-options="field:'name',align:'center',align:'center'" editor="{type:'text'}" width="220">菜单名称</th>
					<th data-options="field:'comments',align:'center',align:'center'" editor="{type:'text'}" width="220">菜单描述</th>
				</tr>
			</thead> 
		</table>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td align="right" width="60%">
					  	<a title="保存" id="saveButton"  class="easyui-linkbutton" plain="false" onclick="save();" href="javascript:void(0);">保存</a>
						<a title="返回" id="returnButton"  class="easyui-linkbutton"  plain="false" onclick="closeForm();" href="javascript:void(0);">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<script src="avicit/platform6/modules/system/sysmenu/js/ChooseLanguage.js" type="text/javascript"></script>
	<script type="text/javascript">
	var chooseLanguage;
	$(function(){
		chooseLanguage =new ChooseLanguage('dgchooseLanguage','${url}','form1');
	});
	
	function closeForm(){
		parent.sysMenu.closeDialog("#chooseL");
	}
	
	function save(){
		chooseLanguage.save(afterSaveLanguage);

		//parent.sysMenu.afterSaveLanguage(name,'#chooseL');
	}
	
	function afterSaveLanguage(name,comments,dialog){
		parent.sysMenu.afterSaveLanguage(name,comments,dialog);
	}
		
	</script>
</body>
</html>