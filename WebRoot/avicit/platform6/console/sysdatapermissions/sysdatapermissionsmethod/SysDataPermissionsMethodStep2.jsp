<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,tree,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>步骤2</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css" />
</head>
<body class="easyui-layout">
	<center style="overflow: auto;height: 100%">
		<div data-options="region:'west'" style="width: 300px; border-top-style: hidden;">
			<div id="tableToolbarM" class="toolbar">
				<div class="toolbar-left">
					<div class="input-group  input-group-sm">
						<input class="form-control" placeholder="输入菜单名称查询" type="text" id="txt" name="txt" />
						<span class="input-group-btn">
							<button id="searchbtn" class="btn btn-default" type="button">
								<span class="glyphicon glyphicon-search"></span>
							</button>
						</span>
					</div>
				</div>
			</div>
			<div id='mdiv' style="overflow: auto;">
				<ul id="consoleMenu" class="ztree"></ul>
			</div>
		</div>
	</center>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/js/MenuTree.js?v=<%=System.currentTimeMillis() %>" type="text/javascript"></script>

<script type="text/javascript">
	var menuTree;
	var menuId = "";

	$(document).ready(function() {
		//菜单树初始化
		menuTree = new MenuTree('consoleMenu',' ${urlMenu}/console/${params}','','txt','searchbtn');
		menuTree.setOnSelect(function(treeNode) {
			menuId=treeNode.id;
		}).init();
	});
	function getFormData(){
		var treeChildren = menuTree.tree.getSelectedNodes()[0].childCount;
		if(undefined != treeChildren && treeChildren > 0){
			layer.alert("只能在末级节点添加方法！",{icon:2});
			return false;
		}
		return menuId;
	}
</script>
</html>