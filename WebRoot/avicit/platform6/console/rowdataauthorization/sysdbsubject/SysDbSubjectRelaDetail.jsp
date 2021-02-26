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
<title>群组选择</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css-fixie8-fonticon.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<table id="jqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<script>
$(document).ready( function() {
	var dataGridColModel = [ {
		label : 'id',
		name : 'id',
		key : true,
		width : 75,
		hidden : true
	}, {
		label : '维度类型',
		name : 'type',
		width : 150
	}, {
		label : '维度名称',
		name : 'typeId',
		width : 150
	} , {
		label : '创建者数据',
		name : 'pream1',
		width : 150
	}, {
		label : '部门数据',
		name : 'pream2',
		width : 150
	}, {
        label : '组织数据',
        name : 'pream10',
        width : 150
    },{
        label : '组织应用数据',
        name : 'pream11',
        width : 150
    },{
		label : '下级部门数据',
		name : 'pream3',
		width : 150
	}, {
		label : '上级部门数据',
		name : 'pream4',
		width : 150
	}/*, {
		label : '指定组织的数据',
		name : 'pream5',
		width : 150
	}*/, {
		label : '指定部门数据',
		name : 'pream6',
		width : 150
	}, {
		label : '指定用户数据',
		name : 'pream7',
		width : 150
	}, {
		label : '自定义扩展',
		name : 'pream8',
		width : 150
	}, {
		label : '密级权限控制',
		name : 'pream9',
		width : 150
	}, {
		label : '执行顺序号',
		name : 'weight',
		width : 150
	}];
	 $('#jqGrid').jqGrid({
			url : '${url}/getSysDbRelationshipsByTableList',
			mtype : 'POST',
			datatype : "json",
			postData : {tableId:'${tableId}'},
			colModel : dataGridColModel,
			height : $(window).height() - 120,
			scrollOffset : 20, //设置垂直滚动条宽度
			altRows : true,
			userDataOnFooter : true,
			pagerpos : 'left',
			loadonce : true,
			viewrecords : true,
			styleUI : 'Bootstrap',
			viewrecords : true, //
			autowidth : true,
			responsive : true,//开启自适应  
			multiboxonly : true,
			multiselect : true,
			rowNum : 10,
			rowList : [ 200, 100, 50, 30, 20, 10,5],
			pagerpos : 'left',
		});
})

</script>
</body>
</html>
