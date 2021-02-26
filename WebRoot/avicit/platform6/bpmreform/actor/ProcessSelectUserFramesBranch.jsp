<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<title>AVICIT WORKFLOW 选人</title>
<meta http-equiv="X-UA-Compatible" content="chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap-theme.css"/>

<script type="text/javascript" src="static/js/platform/component/common/json2.js"></script>
<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="static/h5/bootstrap/3.3.4/js/bootstrap.js"></script>
<script type="text/javascript" src="static/h5/jquery-easyui-1.3.5/src/jquery.parser.js"></script>
<script src="static/h5/layer-v2.3/layer/layer.js"></script>
<style type="text/css">

label {
    display: inline-block;
    max-width: 100%;
    margin-bottom: 5px;
    font-weight: 100;
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

var selectedUsers = new Array();
function selectorDataBranch(object,targetActivityName,outcome){
	var i = selectedUsers.length;
	while(i--){
		if(selectedUsers[i].targetActivityName == targetActivityName){
			selectedUsers.splice(i,1);
		}
	}
	if(object != null && object.length > 0){
		selectedUsers.push({
			selectedUsers : object,
			targetActivityName : targetActivityName,
			outcome : outcome
		});
	}
}
Array.prototype.removeAt = function(p_index) {
	if (p_index >= 0 && p_index < this.length) {
		this.splice(p_index, 1);
	} else {
		return false;
	}
};

function getSelectedUsers(){
	var activityNameArr = new Array();
	var flg = true;
	$("._required").each(function(j, n){
		if(!flg){
			return;
		}
		for(var i = 0; i < selectedUsers.length; i++){
			var _activityName = selectedUsers[i].targetActivityName;
			if(_activityName == $(n).attr("_requiredName")){
				return;
			}
		}
		flg = false;	
	});
	if(!flg){
		return null;
	}else{
		return selectedUsers;
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
	
</script>
</html>
