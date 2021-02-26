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
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
    <style>
        .ztree {
            overflow-x:auto;
        }
    </style>
</head>

<body>
        <div class="container-fluid">
            <div 
                style="min-height: 270px; border-color: azure;">
                    <div class="input-group  input-group-sm">
                        <input class="form-control" placeholder="输入岗位名称查询"
                               type="text" id="search_position_text" name="search_position_text"> <span
                            class="input-group-btn">
                                                    <button id="btn-search-position" class="btn btn-default" type="button">
                                                        <span class="glyphicon glyphicon-search"></span>
                                                    </button>
                                                </span>
                    </div>
                    <div class="col-sm-5">
                         <ul id="selectDeptTree" class="ztree"></ul>
                    </div>
              </div>
              <!-- 
              <div class="pull-right">
              	 <button name="chooseDeptButtion" type="button" class="btn btn-default form-tool-btn btn-sm ">确定</button>
              </div>
               -->
        </div>
        <div id="userSelectTpl" class="hidden">
<div class="target-selector-form userSelectedViews" data='#data#' id="#primaryId#"  onclick="javascript:void(0)">
                    <div class="userName">#name#</div>
                    <div class="deptName">#currentType#</div>
                    <div class="remove">
                     <a href="javascript:void(0)">
                    <span class="glyphicon glyphicon-remove"></span>
                    </a>
                    </div>
    </div> 
</div>
</body>
<script type="text/javascript">
var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
var tree;
var pid = flowUtils.getUrlQuery("id");
var pname = flowUtils.getUrlQuery("name");
$(function(){
	tree = new DeptSelectTree({});
    $("#search_position_text").keydown(function(e) {
        if(e.keyCode==13){
            search($("#search_position_text").val(),"selectDeptTree");
        }
    });
    $("#btn-search-position").on("click",function() {
        search($("#search_position_text").val(),"selectDeptTree");
    });
	$("button[name='chooseDeptButtion']").on('click',function(){
		var selectedNodes = tree.zTree.getSelectedNodes();
		if(selectedNodes.length <= 0) {
		} else {
			var node = selectedNodes[0];
			if(node.nodeType != "position") {
				parent.userSelectTree.addDeptInfoUserSelectView(pid,pname,"",{text:""});
				parent.layer.close(index);
			} else {
				parent.userSelectTree.addDeptInfoUserSelectView(pid,pname,node.id,node);
				parent.layer.close(index);
			}
		}
	});
});

function search(searchValue,treeId){
    if(searchValue==null||searchValue==""){
        tree.zTree =  $.fn.zTree.init($("#"+treeId), tree.setting.call(tree));
        return;
    }
    $.ajax({
        cache: true,
        type: "post",
        url: "bpm/designeruser/getOrgPositionTreeSearch",
        dataType:"json",
        data:{searchText:searchValue},
        async: false,
        error: function(request) {
            throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
        },
        success: function(data) {
            tree.zTree =  $.fn.zTree.init($("#"+treeId), {
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
                    onClick: function(event, treeId, treeNode){

                    },
                    onDblClick:function(event, treeId, treeNode){

                    }
                }

            }, data);
        }
    });
}

function getSelectNode(){
	var selectedNodes = tree.zTree.getSelectedNodes();
	
	if(selectedNodes.length <= 0) {
	} else {
		var node = selectedNodes[0];
		if(node.nodeType != "position") {
            parent.setPosition("","");
			parent.layer.close(index);
		} else {
			//parent.userSelectTree.addDeptInfoUserSelectView(pid,pname,node.id,node);
            parent.setPosition(node.id,node.text);
			parent.layer.close(index);
		}
	}
}

function DeptSelectTree(option) {
	this.treeId = "selectDeptTree";
	this.initUrl = "bpm/designeruser/getOrgPositionTree";
	this.onClickTimer = null;
	this.activeFirst = false;
	this.init.call(this);
}

DeptSelectTree.prototype.getInitUrl = function() {
	return "bpm/designeruser/getOrgPositionTree";
}

DeptSelectTree.prototype.init = function() {
	var _self = this;
	_self.zTree =  $.fn.zTree.init($("#"+_self.treeId), _self.setting.call(_self));
}

DeptSelectTree.prototype.setting = function() {
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
	            		_self.zTree.selectNode(_self.zTree.getNodes()[0]);
	            	}
            	}
            },
            onClick: function(event, treeId, treeNode) {
            	clearTimeout(_self.onClickTimer);
            	_self.onClickTimer = setTimeout(function() {
                },300);
            },
            onDblClick: function(event, treeId, treeNode) {
            	clearTimeout(_self.onClickTimer);
                if (treeNode) {
					/**
                	var type = treeNode.nodeType;
                    if(type == "user" || type == "position" || type == "group" || type == "role") {
                    	addNodeIntoUserSelectView(treeNode.id, treeNode.id, treeNode.nodeType, treeNode.text)
                    } else {
                    	layer.msg("开发中");
                    } */
                }
            }
        }
    };
};
</script>
</html>

