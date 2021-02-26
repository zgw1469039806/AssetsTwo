<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>语言配置</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
    <div data-options="region:'center',onResize:function(a){$('#dgchooseLanguage').setGridWidth(a);$(window).trigger('resize');}">
		<table id="dgchooseLanguage"></table>
		<div id="dgchooseLanguagePager"></div>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="center"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="确定" id="submitButton">确定</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消"
						id="syscron_closeForm">取消</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script src="avicit/platform6/console/lookuptype/js/ChooseLanguage.js" type="text/javascript"></script>
	<script type="text/javascript">
	var chooseLanguage;
	$(document).ready(function(){
		var dataGridColModel = [ {
			label : 'id',
			name : 'id',
			width : 75,
			hidden : true
		},{
			label : '${hiddendisplay}',
			name : '${hiddenName}',
			width : 75,
			hidden : true
		}, {
			label : '<span style="color:#ff0000"> * </span>语言编号',
			name : 'sysLanguageCode',
			sortable:false,
			key : true,
			width : 150
		}, {
			label : '<span style="color:#ff0000"> * </span>语言名称',
			name : 'sysLanguageName',
			sortable:false,
			width : 100
		}, {
			label : '${display}',
			name : '${name}',
			editable : true,
			edittype : "text",
			width : 100
			
		}, {
			label : '描述',
			name : 'description',
			sortable:false,
			editable : true,
			edittype : "text",
			width : 100
		} ];
		chooseLanguage =new ChooseLanguage('dgchooseLanguage','${url}',dataGridColModel);
		$('#submitButton').bind('click', function() {
			save();
		});
		$('#syscron_closeForm').bind('click', function() {
			closeForm();
		});
	}); 
	
	function closeForm(){
		if ('${type}' == '1'){
			parent.closeL();
		}else{
			parent.closeLook();
		}
	}
	
	function save(){
		chooseLanguage.save('${type}');
	}
		
	</script>
</body>
</html>