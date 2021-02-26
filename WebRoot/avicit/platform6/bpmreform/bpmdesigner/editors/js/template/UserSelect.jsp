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
<title>候选人</title>
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
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelectView.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/CommonSelectTree.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/js/RelationSelectTree.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/js/ProcessVariableForSelectUser.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/expand/userExpand.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/intersection/Intersection.js"></script>
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
                                    aria-expanded="false"> 群组 </a></li>
                                <li class=""><a data-toggle="tab" href="javascript:void(0)"
                                    aria-expanded="false"> 岗位 </a></li>
                                <li class=""><a data-toggle="tab" href="javascript:void(0)"
                                    aria-expanded="false"> 关系 </a></li>
                                
                            </ul>
                            <div class="tab-content" style="min-height: 316px;border-width: 1px;border-style: solid;border-color: #D4D4D4;">
                                <div class="active">
                                    <div class="row" style="margin: 5px;">
                                        <div class="input-group  input-group-sm">
                                            <input class="form-control" placeholder="输入用户名称查询"
                                                type="text" id="search_text" name="search_text"> <span
                                                class="input-group-btn">
                                                <button id="btn-search-user" class="btn btn-default" type="button">
                                                    <span class="glyphicon glyphicon-search"></span>
                                                </button>
                                            </span>
                                        </div>
                                        <div class="treeViewDiv">
                                            <ul id="selectUserTree" class="ztree"></ul>
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
                                            <input class="form-control" placeholder="输入群组名称查询"
                                                type="text" id="search_group_text" name="search_group_text"> <span
                                                class="input-group-btn">
                                                <button id="btn-search-group" class="btn btn-default" type="button">
                                                    <span class="glyphicon glyphicon-search"></span>
                                                </button>
                                            </span>
                                        </div>
                                        <div class="treeViewDiv">
                                            <ul id="selectGroupTree" class="ztree"></ul>
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
                                   <div class="">
                                	<div class="row" style="margin: 5px;">
                                        <div class="treeViewDiv">
                                            <ul id="selectRelationTree" class="ztree"></ul>
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
 var userSelectTree = null;
 var roleSelectTree = null;
 var deptSelectTree = null;
 var groupSelectTree = null;
 var relationSelectTree = null;
 var processId;
$(function() {
  processId = flowUtils.getUrlQuery("processId");
  userSelectView = new UserSelectView({
        id:'#platform-userselect-userview',
        beforeRemove: function(id){
            var tree = $.fn.zTree.getZTreeObj("selectUserTree");
            var node = tree.getNodesByParam("id", id , null);
        },
        afterRemove: function(){
        },
        template : function(){
                return $("#userSelectTpl").html();
        }
    });
  userSelectTree =  new UserSelectTree({});
  roleSelectTree = new CommonSelectTree({treeId:"selectRoleTree", type:"role", search_input:"search_role_text", search_but:"btn-search-role"});
  groupSelectTree = new CommonSelectTree({treeId:"selectGroupTree", type:"group", search_input:"search_group_text", search_but:"btn-search-group"});
  positionSelectTree = new CommonSelectTree({treeId:"selectPositionTree", type:"position", search_input:"search_position_text", search_but:"btn-search-position"});
  relationSelectTree  = new RelationSelectTree({processId:processId});
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
                        value.variable?value.variable.variableAlias:null,
                        value.intersection?value.intersection.intersectionValue:null,
                        value.intersection?value.intersection.intersectionAlias:null,
                        value.variable?value.variable.dataType:null,
                        value.variable?value.variable.dataTypeName:null,
                        value.variable?value.variable.deptPositionId:null,
                        value.variable?value.variable.deptPositionName:null
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

function addVariableNodeInfoUserSelectView(pid,pname,variableName,variableAlias,dataType,dataTypeName,deptPositionId,deptPositionName) {
	addNodeIntoUserSelectView(pid, pid,"relation",pname,null,null,null,null,null,null,null,null,variableName,variableAlias,null, null, dataType,dataTypeName,deptPositionId,deptPositionName);
}

function addIntersectionNodeInfoUserSelectView(pid,pname,intersectionValue,intersectionAlias) {
	addNodeIntoUserSelectView(pid, pid,"relation",pname,null,null,null,null,null,null,null,null,null,null,intersectionValue,intersectionAlias);
}

/**
 * 添加一个人员节点到用户选择视图
 */
function addActorIntoUserSelectView(treeId, id, type, name, actorInfo) {
	
}

function addNodeIntoUserSelectView(treeId, id, type, name, deptlevelId, deptlevelName, positionId, positionName,stepId,stepName,customfunctionId,customfunctionName,variableName,variableAlias,intersectionValue,intersectionAlias,dataType,dataTypeName,deptPositionId,deptPositionName) {
	var nodeInfo = null;
	if(type == "user" || type == "position" || type == "group" || type == "role" ) {
		nodeInfo = userSelectView.getCommonNodeInfo(treeId, id, name, type);
	} else if (type == "dept") {
		nodeInfo = userSelectView.getDeptTypeNode(treeId, id, name,  positionId, positionName);
	} else if (type == "relation"){
	    if(customfunctionId){
            customfunctionId = "customfunctionId";
        }
		nodeInfo = userSelectView.getRelationNode(treeId, id, name, positionId, positionName, deptlevelId, deptlevelName,stepId,stepName,customfunctionId,customfunctionName,variableName,variableAlias,intersectionValue,intersectionAlias,dataType,dataTypeName,deptPositionId,deptPositionName);
	} else {
		layer.msg("功能开发中");
	}
	userSelectView.addObject(nodeInfo.primaryId, nodeInfo);
}


function UserSelectTree(option) {
	this.treeId = option.treeId || "selectUserTree";
	this.initUrl = option.url || "bpm/designeruser/getOrgDeptUserTrees";
	this.search = option.search || "bpm/designeruser/getOrgDeptUserTreeBySearch";
	this.onClickTimer = null;
	this.activeFirst = false;
	this.init.call(this);
};

UserSelectTree.prototype.init = function() {
	var _self = this;
	$("#btn-search-user").on("click",function() {
		_self.searchUser($("#search_text").val());
 	})
 	$("#search_text").keydown(function(e) {
		if(e.keyCode==13){
			_self.searchUser($("#search_text").val());
		}
	});
	
	_self.zTree =  $.fn.zTree.init($("#"+_self.treeId), _self.setting.call(_self));
};

UserSelectTree.prototype.searchUser = function(value) {
	var _self = this;
    if(value==null||value==""){
    	_self.zTree =  $.fn.zTree.init($("#"+_self.treeId), _self.setting.call(_self));
        return;
    }
    $.ajax({
        cache: true,
        type: "post",
        url: _self.search,
        dataType:"json",
        data:{searchText:value},
        async: false,
        error: function(request) {
            throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
        },
        success: function(data) {
        	_self.zTree =  $.fn.zTree.init($("#"+_self.treeId), {
                view: {
                    selectedMulti: false,
                    dblClickExpand: false
                },
                check: {
                    autoCheckTrigger:false,
                    enable: false
                },
                data: {
                    key: {
                        id: "id",
                        name: "text",
                        children: "children"
                    },
                    simpleData: {
                        enable: false,
                        idKey: "id",
                        pIdKey: "parentId",
                        rootPId: -1
                    }
                },callback: {
                    onClick: _self.zTreeOnClick,
                    onDblClick: _self.zTreeOnDblClick
                }
                
            }, data);
        }
    });
};

UserSelectTree.prototype.addDeptInfoUserSelectView = function(pid, pname, treeId, treeNode) {
	addNodeIntoUserSelectView(pid, pid, "dept", pname, null, null, treeId, treeNode.text);
};


UserSelectTree.prototype.zTreeOnClick = function(event, treeId, treeNode) {
	var _self = this;
    if (treeNode) {
        if(treeNode.nodeType == "user") {
            addNodeIntoUserSelectView(treeNode.id, treeNode.id, treeNode.nodeType, treeNode.text);
        } else if (treeNode.nodeType == "dept") { // 如果是选部门，则需弹出选部门框
        	layer.open({
        	    type:  2,
        	    area: [ "400px",  "350px"],
        	    title: "请选择岗位",
        	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        	    shade:   0.3,
                maxmin: false, //开启最大化最小化按钮
        	    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/deptSelectTree.jsp?id="+treeNode.id+"&name="+treeNode.text ,
        	    btn: ['确定', '关闭'],
        	    yes: function(index, layero){
        	    	var iframeWin = layero.find('iframe')[0].contentWindow;
        	    	iframeWin.getSelectNode();
        	         
        		 },
        		 cancel: function(index){
        	     },
        	     success: function(layero, index){
        	     }
        	});
        }
    }
//	clearTimeout(_self.onClickTimer);
//	_self.onClickTimer = setTimeout(function() {
//    },300);
};

UserSelectTree.prototype.zTreeOnDblClick = function(event, treeId, treeNode) {
	var _self = this;
	clearTimeout(_self.onClickTimer);
    if (treeNode) {
        if(treeNode.nodeType == "user") {
        	addNodeIntoUserSelectView(treeNode.id, treeNode.id, treeNode.nodeType, treeNode.text);
        } else if (treeNode.nodeType == "dept") { // 如果是选部门，则需弹出选部门框
        	layer.open({
        	    type:  2,
        	    area: [ "400px",  "350px"],
        	    title: "请选择岗位",
        	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        	    shade:   0.3,
                maxmin: false, //开启最大化最小化按钮
        	    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/deptSelectTree.jsp?id="+treeNode.id+"&name="+treeNode.text ,
        	    btn: ['确定', '关闭'],
        	    yes: function(index, layero){
        	    	var iframeWin = layero.find('iframe')[0].contentWindow;
        	    	iframeWin.getSelectNode();
        	         
        		 },
        		 cancel: function(index){
        	     },
        	     success: function(layero, index){
        	     }
        	});
        }
    }
};

UserSelectTree.prototype.setting = function() {
	var _self = this;
	return {
        view: {
            selectedMulti: false,
            dblClickExpand: false
        },
        check: {
            autoCheckTrigger:false,
            enable: false
        },
        data: {
            key: {
                id: "id",
                name: "text",
                children: "children"
            },
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "parentId",
                rootPId: -1
            }
        },
        edit : {
            enable : false,
            showRemoveBtn : false,
            showRenameBtn : false
        },
        async: {
            enable: true,
            type: "post",
            url: _self.initUrl,
            autoParam:["id","nodeType","orgId"],
            dataFilter: function(treeId, parentNode, childNodes){
                 if (!childNodes)
                    return null;
                var childNodes = eval(childNodes);

                /**
                for(var i=0 ; i < childNodes.length; i++) {
                	var node = childNodes[i];
                	node.open = true;
                } */
                return childNodes;
            }
        },
       callback: {
            onAsyncError:  function(){
                layer.msg("加载失败！");
            },
            onAsyncSuccess:  function(event, treeId, msg){
            	if(!_self.activeFirst) {
	            	var node = _self.zTree.getNodeByParam('_parentId', "-1");//获取id为1的点  
	            	if(node) {
	            		_self.zTree.expandNode(node);
	            		_self.activeFirst = true;
	            	}
            	}
            },
            onClick: _self.zTreeOnClick,
            onDblClick: _self.zTreeOnDblClick
        }
    };
};
    
</script>

</html>

