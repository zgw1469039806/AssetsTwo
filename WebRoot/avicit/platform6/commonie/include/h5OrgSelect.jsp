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
<title>选择组织</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css-fixie8-fonticon.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div>
		<table id="h5jqGridOrg"></table>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
	var idFiled = null;
	var textFiled = null;
	var setSelectedInfo = null;
	var viewScope = null;
	var defaultOrgId = null;
	
	function init(o){
		idFiled =o.idFiled;
		textFiled = o.textFiled;
		setSelectedInfo = o.setSelectedInfo;
		viewScope = o.viewScope;
		defaultOrgId = o.defaultOrgId;
		
		var SysGridColModel = [
             { label: 'id', name: 'id', key: true,  hidden:true },
             { label: '组织名称', name: 'orgName', width: 80 ,align:'center'}
         ];
   		
   		function ClickRow(rowid,status) {
   			var ret = {};
   			var rowData = $("#h5jqGridOrg").jqGrid('getRowData', rowid);

   			setSelectedInfo({id:rowData.id, text:rowData.orgName});
   		}
   		$('#h5jqGridOrg').jqGrid({
   			url : 'h5/view/common/select/SelectController/selectOrgName',
   			mtype : 'POST',
   			postData : {viewScope : viewScope,defaultOrgId : defaultOrgId},
   			datatype : "json",
   			colModel : SysGridColModel,
   			height : $(window).height() - 40,
   			scrollOffset : 20,
   			altRows : true,
   			userDataOnFooter : true,
   			pagerpos : 'left',
   			loadonce : true,
   			viewrecords : true,
   			styleUI : 'Bootstrap',
   			multiselect : false,
   			autowidth : true,
   			responsive : true, 
   			sortable : false,
   			onSelectRow:ClickRow
   		});
	};
	

	</script>
</html>