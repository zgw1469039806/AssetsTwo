<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,tree,form";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的任务</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro-ie6.css" />


<link rel="stylesheet" type="text/css" href="static/fixie/bsie/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="static/fixie/bsie/bootstrap/css/bootstrap-ie6.css">
<link rel="stylesheet" type="text/css" href="static/fixie/bsie/bootstrap/css/ie.css">
<script src="static/h5/jquery-ui-1.9.2.custom/development-bundle/ui/jquery.ui.core.js"></script>
<script src="static/h5/jquery-ui-1.9.2.custom/development-bundle/ui/jquery.ui.widget.js"></script>
<script src="static/js/platform/aceadmin/jquery.ui.mouse.js"></script>
<script src="static/js/platform/aceadmin/jquery.ui.sortable.js"></script>
<style type="text/css">
.user-lsit {
    display: block;
    width: 100%;
    height: 24px;
    padding: 0px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    border-bottom: 1px solid #ccc;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
.user-lsit:HOVER {
	background-color: #eeeeee;
}
.target-selector-form {
    display:inline-block;
    width: 100%;
    height: 28px;
    /**padding: 6px 12px;*/
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
	background-color: #eeeeee;
}
#myTabContent{
	height: 320px;
	overflow: auto;
	overflow-x: hidden;
}
#selectorTarget{
	width: 100%;
	height: 313px;
	overflow: auto;
	overflow-x: hidden;
}
label {
    display: inline-block;
    max-width: 100%;
    margin-bottom: 0px;
    font-weight: 100;
    width:100%;
    height:100%;
    padding: 5px 0px 0px 0px;
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
/**.target-selector-form:hover  span {display:block;}*/

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
    left:1px;
    z-index : 30;
    margin-top: 30px;
    margin-left: 0.5px;
    background-color: #ffffff;
    box-shadow:2px 2px 1px #cccccc;
     -moz-box-shadow:2px 2px 1px #cccccc;
     -webkit-box-shadow:2px 2px 1px #cccccc;
    display : none;
    height:300px!important;
    /**min-height:1px;*/
    overflow:auto;
}
.ztree{
	overflow-x:auto;
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

var selectedUsers = [];
function selectorData(object){
	if(checkRepeat(object.id)){
		return;
	}
	if(currentActivityAttr_single == 'yes' || currentActivityAttr_dealType == '1'){//单选用户
		if(selectedUsers.length > 0){
			top.layer.msg('当前节点只允许选择一个处理人！', {
				icon : 7
			});
			return;
		}
	}
	var userName = "<div class=\"userName\"><label>"+ object.name + "</label></div>";
	var deptName = "<div class=\"deptName\"><label>"+ object.attributes.deptName + "</label></div>";
	var remove = "<div class=\"remove\"><span onclick=\"removeEvent('" + object.id + "');return false;\">X</span></div>";
	var selectorObject = "<div class=\"target-selector-form\" onmouseover=\"onmouseoverTarget('"+object.id+"')\" onmouseout=\"onmouseoutTarget('"+object.id+"')\" id=\"" + object.id + "\">" + userName + deptName + remove +"</div>";
	$(selectorObject).appendTo($('#selectorTarget'));
	var selectorUser = {
			userId : object.id,
			userName : object.name,
			deptId : object.attributes.deptId,
			deptName : object.attributes.deptName
	};
	selectedUsers.push(selectorUser);
}

function onmouseoverTarget(id){
	$("#"+id).find("span").show();
	//alert(1);
}

function onmouseoutTarget(id){
	$("#"+id).find("span").hide();
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
			}
		}
	}
	$('#' + id).remove();
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
	$('.input-group input').keyup(function(){
		if(event.keyCode == 13){
			var searchType = $(this).attr('searchType');
			var searchContent = $(this).val();
			var searchCondition= $(this).attr('searchCondition');
			var placeholder = $(this).attr('placeholder');
			if(searchContent != '' && searchContent != placeholder){
				search(this,searchType,searchContent,searchCondition);
			} else {
				top.layer.msg('请输入检索内容!', {
					icon : 7
				});
			}
        }
	});
	$('.input-group button').click(function(){
		var searchType = $(this).attr('searchType');
		var searchCondition= $(this).attr('searchCondition');
		var searchContent = $(this).parents(".input-group").find('input').val();
        var placeholder = $(this).parents(".input-group").find('input').attr('placeholder');
		if(searchContent != '' && searchContent != placeholder){
			search(this,searchType,searchContent,searchCondition);
		} else {
			top.layer.msg('请输入检索内容!', {
				icon : 7
			});
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
					if(searchType=='role'){
						$("#role_Tab").height(200);
					}else if(searchType=='orgDept'){
						$("#orgDept_Tab").height(200);
					}else if(searchType=='group'){
						$("#group_Tab").height(200);
					}else if(searchType=='position'){
						$("#position_Tab").height(200);
					}
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
        if($(dom).parents(".input-group").find(".searchResult").length == 0){
            var searchResult = $('.searchResult');
            searchResult.each(function(i,n){
                if($(n).is(':visible')){
                    $(n).parents(".tabs-panels").find("#role_Tab").css("height","auto");
                    $(n).parents(".tabs-panels").find("#orgDept_Tab").css("height","auto");
                    $(n).parents(".tabs-panels").find("#group_Tab").css("height","auto");
                    $(n).parents(".tabs-panels").find("#position_Tab").css("height","auto");
                    $(n).hide(200);
                }
            });
		}
		/*if($(dom).parents(".input-group").find(".searchResult").length == 0 && searchResult.is(':visible')){
			$("#role_Tab").css("height","auto");
			$("#orgDept_Tab").css("height","auto");
			$("#group_Tab").css("height","auto");
			$("#position_Tab").css("height","auto");
			searchResult.hide(200);
		}*/
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

function userListSelector(obj,userId,userName,deptId,deptName){
	  if(obj.checked){
	    var tmp = {id:userId,name:userName,attributes:{deptId:deptId,deptName:deptName}};
	    selectorData(tmp);
	   } }
</script>
</head>
<body class="easyui-layout" fit="true">
	${selectCompentContext}
	<input type="hidden" id="ideaCompelManner" name="ideaCompelManner" value='' />

</body>
<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js"></script>
<script type='text/javascript'>
var secretLevel = '${secretLevel}';
var filterUser = '${filterUser}';
var formId = '${formId}';
$(function() {
    $("#selectorTarget" ).sortable({
    	stop : function(event,ui){
    		var _tmps = $("#selectorTarget").find(".target-selector-form");
    		var _sorts = selectedUsers;
    		var _targetSorts = [];
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
