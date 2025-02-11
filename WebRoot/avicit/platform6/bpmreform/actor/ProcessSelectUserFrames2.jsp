﻿<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
String skinsValue = (String)session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN);
if(skinsValue == null){
	skinsValue="avicit/platform6/portal/themes/oa/skins/blue/skin/style.css";
}
%>
<!DOCTYPE html>
<html>
<head>
<title>AVICIT WORKFLOW 选人</title>
<meta http-equiv="X-UA-Compatible" content="chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap-theme.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.css" />
<link rel="stylesheet" type="text/css" href="static/h5/singleLayOut/themes/easyui-bootstrap.css">
<!-- <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/> -->

<!-- <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro.css"/> -->
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeviewmin.css"/>

<link rel="stylesheet" type="text/css" href="<%=skinsValue %>"/>


<script type="text/javascript" src="static/js/platform/component/common/json2.js"></script>
<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="static/h5/bootstrap/3.3.4/js/bootstrap.js"></script>
<script type="text/javascript" src="static/h5/singleLayOut/easyloader.js"></script>
<script type="text/javascript" src="static/h5/singleLayOut/src/jquery.resizable.js"></script>
<script type="text/javascript" src="static/h5/singleLayOut/plugins/jquery.panel.js"></script>
<script type="text/javascript" src="static/h5/singleLayOut/plugins/jquery.layout.js"></script>
<script type="text/javascript" src="static/h5/jquery-easyui-1.3.5/src/jquery.parser.js"></script>
<script type="text/javascript" src="static/h5/common-ext/window-ext.js"></script>
<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js"></script>
<script src="static/h5/layer-v2.3/layer/layer.js"></script>
<script src="static/js/platform/aceadmin/jquery-ui.js"></script>
<style type="text/css">
.user-lsit {
    display: block;
    width: 100%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    border-bottom: 1px dotted #ccc;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
.user-lsit:HOVER {
	background-color: #fafafa;
}
.target-selector-form {
    display:inline-block;
    width: 100%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    border-bottom: 1px dotted #ccc;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    cursor:move;
}
.target-selector-form:HOVER {
	background-color: #fafafa;
}
#myTabContent{
	height: 320px;
	overflow: auto;
	overflow-x: hidden;
}
#selectorTarget{
	width: 100%;
	height: 323px;
	overflow: auto;
	overflow-x: hidden;
}
label {
    display: inline-block;
    max-width: 100%;
    margin-bottom: 5px;
    font-weight: 100;
}
.target-selector-form .userName{
	width: 45%;
	float:left;
	text-align: left;
}
.target-selector-form .userName label{
	text-overflow:ellipsis;
	width: 200px;
	white-space:nowrap;
}

.target-selector-form .deptName{
	width: 45%;
	float:left;
	text-align: center;
}
.target-selector-form .deptName label{
	text-overflow:ellipsis;
	white-space:nowrap;
	width: 200px;
}
.target-selector-form .remove{
	width: 7%;
	float:left;
	text-align: right;
}
.target-selector-form  span {
	display:none;
	cursor: pointer;
}
.form_commonTable label{
	font-size: 14px;
}
.target-selector-form:hover  span {display:inline-block;}

.searchResult{
	width: 310px;
	border-top:0px solid #cccccc;
	border-right:1px solid #cccccc;
	border-left:1px solid #cccccc;
	border-bottom:1px solid #cccccc;
    padding: 5px 10px;
    font-size: 12px;
    line-height: 1.5;
    border-radius: 3px;
    position: absolute;
    z-index : 30;
    margin-top: 30px;
    margin-left: 0.5px;
    background-color: #ffffff;
    box-shadow:2px 2px 1px #cccccc;
     -moz-box-shadow:2px 2px 1px #cccccc;
     -webkit-box-shadow:2px 2px 1px #cccccc;
    display : none;
    max-height:200px;
    min-height:1px;
    overflow:auto;
}
.ztree{
	overflow-x:auto;
}
.user-lsit input[type=checkbox]:after {
    font-family: treeViewFont;
    content: "\f096";
}
.user-lsit input[type=checkbox]:checked:after {
    font-family: treeViewFont;
    content: "\f046";
}
</style>
<script type="text/javascript">
var secretLevel = '${secretLevel}';
var filterUser = '${filterUser}';
var formId = '${formId}';
var currentActivityAttr_single = "${currentActivityAttr_single}";
var currentActivityAttr_dealType = "${currentActivityAttr_dealType}";
var processKey = '${processKey}';

var targetActivityName = '${targetActivityName}';
var outcome = '${outcome}';
var processInstanceId = '${processInstanceId}';
var taskId = '${taskId}';
var executionId = '${executionId}';
var processInstanceId = '${processInstanceId}';
var type = '${type}';
var doSubmitUrl = '${doSubmitUrl}';
var doSubmitCallEvent = '${doSubmitCallEvent}';
var treeArr = new Array();
var selectedUsers = new Array();
function selectorData(object){
	if(checkRepeat(object.id)){
		return;
	}
	if(currentActivityAttr_single == 'yes' || currentActivityAttr_dealType == '1'){//单选用户
		if(selectedUsers.length > 0){
			top.layer.msg('当前节点只允许选择一个处理人！');
			return;
		}
	}

	//只添加用户（user）
	if(object.attributes.nodeType == "user"){
	var originalName = object.attributes.originalName?object.attributes.originalName:object.name;
        var userName = "<div class=\"userName\"><label>"+ originalName + "</label></div>";
        var deptName = "<div class=\"deptName\"><label>"+ object.attributes.deptName + "</label></div>";
        var remove = "<div class=\"remove\"><span onclick=\"removeEvent('" + object.id + "');return false;\">X</span></div>";
        var selectorObject = "<div class=\"target-selector-form\" id=\"" + object.id + "\">" + userName + deptName + remove +"</div>";
        $(selectorObject).appendTo($('#selectorTarget'));
        var selectorUser = {
            userId : object.id,
            userName : originalName,
            deptId : object.attributes.deptId,
            deptName : object.attributes.deptName
        };
        selectedUsers.push(selectorUser);
	}else if(object.attributes.nodeType == "dept"){//若节点是部门，则递归查询节点下的用户
        var childrenNodes = object.children;
        if(childrenNodes && (typeof childrenNodes.length != "undefined")){
            for(var i = 0 ; i < childrenNodes.length ; i++){
                var node = childrenNodes[i];
                selectorData(node);
            }
        }
	}else if(typeof object.attributes.nodeType == "undefined"){//用户维度选择，搜索选择时沿用原处理
        var userName = "<div class=\"userName\"><label>"+ object.name + "</label></div>";
        var deptName = "<div class=\"deptName\"><label>"+ object.attributes.deptName + "</label></div>";
        var remove = "<div class=\"remove\"><span onclick=\"removeEvent('" + object.id + "');return false;\">X</span></div>";
        var selectorObject = "<div class=\"target-selector-form\" id=\"" + object.id + "\">" + userName + deptName + remove +"</div>";
        $(selectorObject).appendTo($('#selectorTarget'));
        var selectorUser = {
            userId : object.id,
            userName : object.name,
            deptId : object.attributes.deptId,
            deptName : object.attributes.deptName
        };
        selectedUsers.push(selectorUser);
	}
}

function checkRepeat(obj){
	if($('#' + obj).length > 0){
		return true;
	}
}
// 移除
function removeEvent(id){
	if(selectedUsers.length > 0){
		for(var i = 0 ; i < selectedUsers.length ; i++){
			var selectedUser = selectedUsers[i];
			if(selectedUser.userId == id){
				selectedUsers.removeAt(i);
                for(var i = 0; i < treeArr.length; i++){
                    var nodes = treeArr[i].getNodesByParam("id", id);
                    if(nodes != null && nodes.length > 0){
                        for(var j = 0; j < nodes.length; j++){
                            treeArr[i].checkNode(nodes[j], false, true);
						}
                    }
                }
                $(".user-lsit").find("input[value='"+id+"']").removeAttr("checked");
			}
		}
	}
	$('#' + id).remove();
}

function removeNodeCheck(node){
    var childrenNodes = node.children;
    if(childrenNodes){
        for(var i = 0 ; i < childrenNodes.length ; i++){
            var childNode = childrenNodes[i];
            removeEvent(childNode.id);
            removeNodeCheck(childNode);
        }
    }
}
function selectorNodeData(node, treeObj){
	var childrenNodes = node.children;
	if(childrenNodes){
		for(var i = 0 ; i < childrenNodes.length ; i++){
			var childNode = childrenNodes[i];
			treeObj.checkNode(childNode, true, true);
			if(childNode.attributes.nodeType == "user"){
				selectorData(childNode);
			} else {
				selectorNodeData(childNode, treeObj);
			}
		}
	} else {
		$('#' + node.tId + '_switch').trigger('click');
	}
}
Array.prototype.removeAt = function(p_index) {
	if (p_index >= 0 && p_index < this.length) {
		this.splice(p_index, 1);
	} else {
		return false;
	}
};

function removeAll(){
	$('#selectorTarget').html('');
	selectedUsers.splice(0, selectedUsers.length);
	for(var i = 0; i < treeArr.length; i++){
	    treeArr[i].checkAllNodes(false);
	}
    $(".user-lsit").find("input[type='checkbox']").removeAttr("checked");
	return false;
}
function getSelectedUsers(){
	return selectedUsers;
}
function setSelectedUser(obj){
	selectedUsers.push(obj);
}
//live search
$(function(){
	$('.input-group input').keyup(function(event){
		if(event.keyCode == 13){
			var searchType = $(this).attr('searchType');
			var searchContent = $(this).val();
			var searchCondition= $(this).attr('searchCondition');
			if(searchContent != ''){
				search(this,searchType,searchContent,searchCondition);
			} else {
				top.layer.msg('请输入检索内容!');
			}
        }
	});

	$('.input-group button').click(function(){
		var searchType = $(this).attr('searchType');
		var searchCondition= $(this).attr('searchCondition');
		var searchContent = $(this).parents(".input-group").find('input').val();
		if(searchContent != ''){
			search(this,searchType,searchContent,searchCondition);
		} else {
			top.layer.msg('请输入检索内容!');
		}
	});
	$(".mouseleave").mouseleave(function(){
		$(this).hide(500);
	});
	function search(obj,searchType,searchContent,searchCondition){
		$.ajax({
			url : "platform/bpmActor/bpmSelectUserAction2/getSearchUsersJSONData",
			data : {
				searchType : searchType,
				searchContent : searchContent,
                secretLevel : secretLevel,
				searchCondition: searchCondition
			},
			type : "GET",
			success : function(msg) {
				var result = $(obj).parents(".input-group").find('.searchResult');
				result.show(200);
				if(msg){
					result.html(msg);
				} else {
					result.html('没有检索内容，请重新进行检索..');
				}
			},
			error : function(msg){
				//alert('错误提示:' + msg);
			}
		});
	}
	$("body").click(function(e){
		e = e || window.event;
		var dom =  e.srcElement|| e.target;
		var searchResult = $('.searchResult');
		if($(dom).parents(".input-group").find(".searchResult").length == 0 && searchResult.is(':visible')){
			searchResult.hide(200);
		}
	});
});
function searchUserListSelector(e,obj,userId,userName,deptId,deptName){
	if(obj.checked){
	    var tmp = {id:userId,name:userName,attributes:{deptId:deptId,deptName:deptName}};
	    selectorData(tmp);
	 }
	 e = e || window.event;
	 if(+'\v1') {
         e.stopPropagation();
     } else  {
         e.cancelBubble = true;
     }

}
</script>
</head>
<body class="easyui-layout" fit="true">
		${selectCompentContext}
	<input type="hidden" id="ideaCompelManner" name="ideaCompelManner" value='' />
</body>
<script>
// 	if (dataJson.nextTask != null && dataJson.nextTask.length == 1) {
// 		$("#selectorUserlayout")
// 				.append(
// 						"<div region=\"east\" split=\"true\" style=\"width:300px;\" id='selectedResultCompel'><div id=\"selectorUserTabForTargetDataGrid_0\"></div></div>");
// 	}
</script>
<script type='text/javascript'>
var secretLevel = '${secretLevel}';
var filterUser = '${filterUser}';
$(function() {
    $("#selectorTarget" ).sortable({
    	stop : function(event,ui){
    		var _tmps = $("#selectorTarget").find(".target-selector-form");
    		var _sorts = selectedUsers;
    		var _targetSorts = new Array();
    		for(var i = 0 ; i < _tmps.length; i++){
    			var _id = $(_tmps[i]).attr('id');
    			for(var j = 0 ; j < _sorts.length ; j++){
    				if(_id == _sorts[j].userId){
    					_targetSorts.push(_sorts[j]);
    					break;
    				}
    			}
    		}
    		selectedUsers = _targetSorts;
    	}
    });
    $("#selectorTarget" ).disableSelection();
  });
</script>
</html>
