<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "tree,common,form";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>交集选人</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link href="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/theme.css" rel="stylesheet">
<link href="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect.css" rel="stylesheet">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
 <!-- <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>  -->
 <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeviewmin.css"/>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/intersection/Intersection.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/intersection/UserSelectView.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/intersection/CommonSelectTree.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/expand/userExpand.js"></script>
    <style>
        .ztree {
            overflow-x:auto;
        }
    </style>
</head>

<body>
        <div class="container-fluid">
            <div class="candidate-choose-box"
                style="min-height: 355px; border-color: azure;">
             
                    <div class="col-xs-5">
                        <div class="tabbable" style="height: 355px;">
                            <ul class="nav nav-pills" id="candidate-tab" name="candidate-tab">
                                <li class="active"><a data-toggle="tab"
                                    href="javascript:void(0)" aria-expanded="true"> 部门 </a></li>
                                <li class=""><a data-toggle="tab" href="javascript:void(0)"
                                    aria-expanded="false"> 角色 </a></li>                         
                                <li class=""><a data-toggle="tab" href="javascript:void(0)"
                                    aria-expanded="false"> 岗位 </a></li> 
                            </ul>
                            <div class="tab-content" style="min-height: 316px;border-width: 1px;border-style: solid;border-color: #D4D4D4;">
                                <div class="active">
                                    <div class="row" style="margin: 5px;">
                                        <div class="input-group  input-group-sm">
                                            <input class="form-control" placeholder="输入部门名称查询"
                                                type="text" id="search_dept_text" name="search_dept_text"> <span
                                                class="input-group-btn">
                                                <button id="btn-search-dept" class="btn btn-default" type="button">
                                                    <span class="glyphicon glyphicon-search"></span>
                                                </button>
                                            </span>
                                        </div>
                                        <div class="treeViewDiv">
                                            <ul id="selectDeptTree" class="ztree"></ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="">
									<div class="row" style="margin: 5px;">
										<div class="input-group  input-group-sm">
                                            <input class="form-control" placeholder="输入角色名称查询"
                                                type="text" id="search_role_text" name="search_role_text"> <span
                                                class="input-group-btn">
                                                <button id="btn-search-role" class="btn btn-default" type="button">
                                                    <span class="glyphicon glyphicon-search"></span>
                                                </button>
                                            </span>
                                        </div>
                                        <div class="treeViewDiv">
                                            <ul id="selectRoleTree" class="ztree"></ul>
                                        </div>
                                    </div>
								</div>
                                <div class="">
                                	<div class="row" style="margin: 5px;">
                                		<div class="input-group  input-group-sm">
                                            <input class="form-control" placeholder="输入岗位名称查询"
                                                type="text" id="search_position_text" name="search_position_text"> <span
                                                class="input-group-btn">
                                                <button id="btn-search-position" class="btn btn-default" type="button">
                                                    <span class="glyphicon glyphicon-search"></span>
                                                </button>
                                            </span>
                                        </div>
                                        <div class="treeViewDiv">
                                            <ul id="selectPositionTree" class="ztree"></ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-7" style="padding-top: 19px;">
                  
              <table style="width: 100%; height: 100%" border="0">
              	<thead></thead>
              	<tbody>
              		<tr height="35px">
				<td align="right" valign="bottom" style="border-bottom: 1px solid #dddddd">
					<span class="glyphicon glyphicon-trash" aria-hidden="true" style="cursor: pointer;" onclick="removeAllUser(); return false;"></span>&nbsp;
				</td>
				</tr>
				<tr>
					<td style="background-color: #ffffff" valign="top" align="left">
						<div id="platform-userselect-userview">
						
	                    </div>
					</td>
				</tr>
              	</tbody>
              </table>
              </div>
            </div>
        </div>
</body>

<div id="userSelectTpl" class="hidden">
<div class="target-selector-form userSelectedViews" data='#data#' id="#primaryId#"  onclick="javascript:void(0)">
                    <div class="userName" title="#title#" style="white-space:nowrap;text-overflow:ellipsis;overflow:hidden;">#name#</div>
                    <div class="deptName">#currentType#</div>
                    <div class="remove">
                     <a href="javascript:void(0)">
                    <span class="glyphicon glyphicon-remove"></span>
                    </a>
                    </div>
    </div> 
</div>

<script type="text/javascript">
// 选人数据容器
 var userSelectView = null;
 var roleSelectTree = null;
 var deptSelectTree = null;
 var positionSelectTree = null;
 var processId;
$(function() {
  processId = flowUtils.getUrlQuery("processId");
  userSelectView = new UserSelectView({
        id:'#platform-userselect-userview',
        template : function(){
                return $("#userSelectTpl").html();
        }
    });
  deptSelectTree =  new CommonSelectTree({treeId:"selectDeptTree", type:"dept", search_input:"search_dept_text", search_but:"btn-search-dept"});
  roleSelectTree = new CommonSelectTree({treeId:"selectRoleTree", type:"role", search_input:"search_role_text", search_but:"btn-search-role"});
  positionSelectTree = new CommonSelectTree({treeId:"selectPositionTree", type:"position", search_input:"search_position_text", search_but:"btn-search-position"});
});




function removeAllUser (){
    $("search_text").val();
    userSelectView.removeAll();
}



function initUserSelectView(initData) {
    if (initData) {
        var curJSONObj = JSON.parse(initData);
        $.each(curJSONObj, function(index, value){
        	if(value.type == "dept") {
        		addDeptInfoUserSelectView(value.id, value.name, value.position?value.position.positionId:"", value.position?value.position.positionName:"");
        	} else {
        		addNodeIntoUserSelectView(value.treeId, value.id, value.type, value.name,
        				value.deptlevel?value.deptlevel.deptlevelId:null,
        				value.deptlevel?value.deptlevel.deptlevelName:null,
        				value.position?value.position.positionId:null,
        				value.position?value.position.positionName:null,
        				value.step?value.step.stepId:null,	
        				value.step?value.step.stepName:null,
                		value.customfunction?value.customfunction.customfunctionId:null,
                        value.customfunction?value.customfunction.customfunctionName:null,
                        value.variable?value.variable.variableName:null,
                        value.variable?value.variable.variableAlias:null
                        		
        			);
        	}
        });
    }
}

function addDeptInfoUserSelectView(pid,pname,cid, cname) {
	addNodeIntoUserSelectView(pid, pid, "dept", pname, null, null, cid, cname)
}

function addStepNodeInfoUserSelectView(pid,pname,stepId,stepName) {
	addNodeIntoUserSelectView(pid, pid,"relation",pname,null,null,null,null,stepId,stepName);
}

function addCustomNodeInfoUserSelectView(pid,pname,customfunctionId,customfunctionName) {
	addNodeIntoUserSelectView(pid, pid,"relation",pname,null,null,null,null,null,null,customfunctionId,customfunctionName);
}

function addVariableNodeInfoUserSelectView(pid,pname,variableName,variableAlias,dataType,dataTypeName) {
	addNodeIntoUserSelectView(pid, pid,"relation",pname,null,null,null,null,null,null,null,null,variableName,variableAlias,dataType,dataTypeName);
}

/**
 * 添加一个人员节点到用户选择视图
 */
function addActorIntoUserSelectView(treeId, id, type, name, actorInfo) {
	
}

function addNodeIntoUserSelectView(treeId, id, type, name, deptlevelId, deptlevelName, positionId, positionName,stepId,stepName,customfunctionId,customfunctionName,variableName,variableAlias,dataType,dataTypeName) {
	var nodeInfo = null;
	if(type == "user" || type == "position" || type == "group" || type == "role") {
		nodeInfo = userSelectView.getCommonNodeInfo(treeId, id, name, type);
	} else if (type == "dept") {
		nodeInfo = userSelectView.getDeptTypeNode(treeId, id, name,  positionId, positionName);
	} else if (type == "relation"){
        if(customfunctionId){
            customfunctionId = "customfunctionId";
        }
		nodeInfo = userSelectView.getRelationNode(treeId, id, name, positionId, positionName, deptlevelId, deptlevelName,stepId,stepName,customfunctionId,customfunctionName,variableName,variableAlias,dataType,dataTypeName);
	} else {
		layer.msg("功能开发中");
	}
	userSelectView.addObject(nodeInfo.primaryId, nodeInfo);
}


    
</script>

</html>

