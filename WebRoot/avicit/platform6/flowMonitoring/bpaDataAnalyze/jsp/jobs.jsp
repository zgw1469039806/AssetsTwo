<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<% 
String importlibs = "common,tree,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工设置</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/flowMonitoring/bpaDataAnalyze/css/analyze.css">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<link rel="stylesheet" href="avicit/platform6/bpmreform/bpmdeploy/css/style.css"/>
<style type="text/css">
.ztree li span.button.ico_docu:before {
    opacity: 0;
    content: "\e677";
}
.ztree li span.button.ico_open:before {
    opacity: 0;
    content: "\e678";
}
.ztree li span.button.ico_close:before {
    opacity: 0;
    content: "\e676";
}
.fmt_opt{
		min-width: 8px;

	}
	.jqgrow td a {
		color:#fff;
	}
	
	
.icon-edit {
    background: rgba(0, 0, 0, 0) url('avicit/platform6/console/org/images/iconselectors.gif') no-repeat scroll -200px 0;
}
</style>
</head>
<body>
<div>
		<ul id="positionTree" class="ztree" style="height: 100%"></ul>
</div>
</body>
<script type="text/javascript" src="avicit/platform6/flowMonitoring/bpaDataAnalyze/js/PositionTree.js"></script>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
var posID = parent.selectedIds;
var indexPosDept = parent.index;
var positionTree;
var position_ids=null;
var position_Names=null;
//岗位人员ID及名称
function onPosDeptUsrCheck1(e,treeId,treeNode){
    var treeObj=$.fn.zTree.getZTreeObj(treeId),nodes=treeObj.getCheckedNodes(true),positionids="",positionNames="";
    for(var i=0;i<nodes.length;i++){
        if(nodes[i].nodeType == "user"){
            if(i == nodes.length-1){
                positionids+=nodes[i].id;//id字符串拼接
                positionNames += nodes[i].text;
            }else{
                positionids+=nodes[i].id + ",";
                positionNames += nodes[i].text+ ",";
            }
        }
    }
    position_ids = positionids;
    position_Names = positionNames;
}

$(document).ready(function() {
    // 岗位/部门人员选择树
    positionTree = new PositionTree("positionTree",null,posID,indexPosDept);
});
var callbackdatajobs1 = function() {
		return position_ids;
}
var callbackdatajobs2 = function() {
		return position_Names;
}

</script>
</html>