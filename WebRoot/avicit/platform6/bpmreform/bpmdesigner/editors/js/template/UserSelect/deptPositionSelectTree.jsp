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
<link href="avicit/platform6/bpmreform/bpmdesigner/editors/js/common/common.css" rel="stylesheet">
<link href="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect.css" rel="stylesheet">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
 <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
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
        <form class="form-inline">
             <div class="form-group">
                  <label for="select-deptlevel" >部门等级:</label>
                          <select class="form-control" id="select-deptlevel" name="select-human-task-process-mode">
                            <option value="1">顶级部门</option>
                            <option value="2">上上级部门</option>
                            <option value="3">上级部门</option>
                            <option value="4" selected>当前部门</option>
                          </select>
              </div>
              </form>
              <hr style="margin-top: 0px;margin-bottom: 0px;">
              <div class="row">
            <div class="candidate-choose-box"
                style="min-height: 200px; border-color: azure;">
                    <div class="col-sm-5">
                         <ul id="selectDeptTree" class="ztree"></ul>
                    </div>
              </div>
              </div>
              <%--<div class="row">
                <div class="pull-right">
              	 <button name="chooseDeptButtion" type="button" class="btn btn-default form-tool-btn btn-sm ">确定</button>
              </div>
              </div>--%>
            
        </div>
</body>
<script type="text/javascript">
var index = parent.layer.getFrameIndex(window.name); //获取窗口索引

var tree;
$(function(){
	tree = new DeptSelectTree({});
	/*var pid = flowUtils.getUrlQuery("id");
	var pname = flowUtils.getUrlQuery("name");*/
	/*$("button[name='chooseDeptButtion']").on('click',function(){
		var selectedNodes = tree.zTree.getSelectedNodes();
		if(selectedNodes.length <= 0) {
		} else {
			var node = selectedNodes[0];
			if(node.nodeType != "position") {
				parent.addNodeIntoUserSelectView(pid,pid,"relation",pname, $("#select-deptlevel").val(), $("select[id='select-deptlevel'] option:selected").text(),"",{text:""});
				parent.layer.close(index);
			} else {
				parent.addNodeIntoUserSelectView(pid,pid,"relation",pname, $("#select-deptlevel").val(), $("select[id='select-deptlevel'] option:selected").text(),node.id,node.text);
				parent.layer.close(index);
			}
		}
	});*/
});
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
	// parent.layer.iframeAuto(index);
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
            url: _self.initUrl + "?showRoles=" + flowUtils.getUrlQuery("showRoles"),
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

