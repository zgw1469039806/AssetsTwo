<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "phoneproject/programauthoritymanage/portalprogram/PortalProgramController/PortalProgramInfo" -->
<title>权限管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<script
		src=" avicit/phoneproject/programauthoritymanage/portalprogram/js/PortalProgram.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var portalProgram;
		var programId;//应用id
		var tabIndex=0;//关系标签页的索引
		$(function() {
			portalProgram = new PortalProgram('dgPortalProgram', '${url}','searchDialog', 'portalProgram');
		});
		function formateprogramState(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					portalProgram.programState);
		}
	</script>
<body class="easyui-layout" fit="true">
<div data-options="region:'west',title:' 应用信息',split:true,iconCls:'icon-save'" style="width:550px;background:#f5fafe;overflow-y:hidden;">
	<div id="toolbar">
		<input id="search" class="easyui-searchbox" style="width:200px" data-options="prompt:'关键字查询',searcher:PortalProgram.prototype.searchData"/>
	</div>
	<table id="dgPortalProgram"
		data-options="
			fit: true,
			rownumbers: true,
			fitColumns: true,
			autoRowHeight: false,
			toolbar:'#toolbar',
			idField :'id',
			singleSelect: true,
			pagination:true,
			pageSize:dataOptions.pageSize,
			pageList:dataOptions.pageList,
			loadMsg:'数据加载中,请稍候',
			striped:true">
		<thead>
			<tr>
				<th data-options="field:'programName', align:'center'" width="220">应用名称</th>
				<th data-options="field:'programCode', align:'center'" width="220">应用代码</th>
				<th data-options="field:'programState', align:'center',formatter:formateprogramState" width="220">应用状态</th>
			</tr>
		</thead>
	</table>
</div> 
<div data-options="region:'center',iconCls:'icon-search',title:'权限设置'" style="background:#ffffff; overflow:hidden;">
	<%@ include file ="/avicit/phoneproject/programauthoritymanage/programrelation/ProgramRelationManage.jsp"%>
</div>

</body>
</html>