<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<% 
String importlibs = "common,tree,table,form";	
String _treeNodeId = "\'"+request.getParameter("_treeNodeId")+"\'";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>节点设置</title>
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
<div id="flowNodeTree">
</div>
</body>
<script type="text/javascript" src="avicit/platform6/flowMonitoring/bpaDataAnalyze/js/flowNodeTree.js"></script>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
var flowID = parent.selectedIds;
var flowNodeTree;
//流程节点树取ID及名称
var flow_ids = null;
var flow_Names = null;
var full_Names = null;

var tempActivityNames=[];
var tempFullNames=[];
var tempProcID=[];

function onCheck1(e,treeId,treeNode){
    var treeObj=$.fn.zTree.getZTreeObj(treeId);nodes=treeObj.getCheckedNodes(true);
    var flowNames="",fullNames="";

    // 选中的flowID(实为父节点)
    var _rootnode = treeObj.getNodesByFilter(function (node) { return node.level == 0 }, true);

    var _fullnodes = treeObj.getNodes();
    for(var i=0;i<_fullnodes.length;i++){
        
        var checked = _fullnodes[i].checked;  // 检测该树下的每个节点是否选中

        if(checked){
            // 仅节点名
            var j=0;
            for(j=0;j<tempActivityNames.length;j++){
                if(tempActivityNames[j]==_fullnodes[i].activityAlias){ break; }
            }
            if(j==tempActivityNames.length){ tempActivityNames.push(_fullnodes[i].activityAlias); }

            // 全名
            var tempfull = _fullnodes[i].processName + ":" + _fullnodes[i].activityAlias;
            for(j=0;j<tempFullNames.length;j++){
                if(tempFullNames[j]==tempfull){
                    if(tempProcID[j]==_rootnode.processId){ break; }
                }
            }
            if(j==tempFullNames.length){ tempProcID.push(_rootnode.processId); tempFullNames.push(tempfull); }
        }else{ // 取消选择时
            var j=0;
            var tempfull = _fullnodes[i].processName + ":" + _fullnodes[i].activityAlias;
            for(j=0;j<tempFullNames.length;j++){
                if(tempFullNames[j]==tempfull && tempProcID[j]==_rootnode.processId)
                { tempProcID.splice(j,1); tempFullNames.splice(j,1); break; }
            }
        }
    }

    // 整合成字符串
    for(var i=0; i<tempActivityNames.length; i++){
        flowNames += tempActivityNames[i] + ",";
    }
    for(var i=0; i<tempFullNames.length; i++){
        fullNames += tempFullNames[i] + ",";
    }
    flowNames=(flowNames.substring(flowNames.length-1)==',')?flowNames.substring(0,flowNames.length-1):flowNames;
    fullNames=(fullNames.substring(fullNames.length-1)==',')?fullNames.substring(0,fullNames.length-1):fullNames;

    flow_Names = flowNames;
    full_Names = fullNames;
}
$(document).ready(function() {	
    //节点树
    flowNodeTree = new flowNodeTree("flowNodeTree",null,flowID); 
});
var callbackdatanode1 = function() {
	return flow_ids;  //  未使用到该变量
}
var callbackdatanode2 = function() {
	return flow_Names;
}
var callbackdatanode3 = function() {
    return full_Names;
}
var callbackdatanode4 = function() {
    return tempProcID;
}

</script>
</html>