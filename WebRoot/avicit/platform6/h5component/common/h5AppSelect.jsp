<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>选择应用</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css-fixie8-fonticon.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div>
		<table id="h5jqGridApp"></table>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
	var idFiled = null;
	var textFiled = null;
	var callBack = null;
	var appSelectType = null;
	var setSelectedInfo = null;
	
	function init(o){
		appSelectType=o.appSelectType;
		idFiled =o.idFiled;
		textFiled = o.textFiled;
		callBack = o.callBack;
		setSelectedInfo = o.setSelectedInfo;
		var SysGridColModel = [
             { label: 'id', name: 'id', key: true,  hidden:true },
             { label: '应用名称', name: 'applicationName', width: 80 ,align:'center'}
         ];
   		
   		function onlClickRow(rowid,status) {
   			var ret = {};
   			var rowData = $("#h5jqGridApp").jqGrid('getRowData', rowid);

   			setSelectedInfo({id:rowData.id, text:rowData.applicationName});
   		}
   		$('#h5jqGridApp').jqGrid({
   			url : 'h5/view/common/select/SelectController/selectAppName?appSelectType=' + appSelectType,
   			mtype : 'POST',
   			datatype : "json",
   			colModel : SysGridColModel,
   			height : $(window).height() - 40,
   			scrollOffset : 20, //设置垂直滚动条宽度
   			altRows : true,
   			userDataOnFooter : true,
   			pagerpos : 'left',
   			loadonce : true,
   			viewrecords : true,
   			styleUI : 'Bootstrap',
   			multiselect : false,
   			autowidth : true,
   			responsive : true,//开启自适应  
   			sortable : false,
   			onSelectRow:onlClickRow
   		});
	};
	

	</script>
</html>