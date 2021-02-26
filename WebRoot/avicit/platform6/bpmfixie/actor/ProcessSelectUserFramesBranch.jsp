<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>AVICIT WORKFLOW 选人</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro-ie6.css" />
<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>

<style type="text/css">

label {
    display: inline-block;
    max-width: 100%;
    margin-bottom: 5px;
    font-weight: 100;
}

.userIcon{
    background-image: url(static/h5/jquery-ztree/3.5.12/css/zTreeStyle/img/metro-ie6.png);
    background-position: -152px -28px;
    width: 21px;
    height: 21px;
}

.userButton{

	line-height: 0;
    margin: 0;
    display: inline-block;
    vertical-align: top;
    border: 0 none;
    cursor: pointer;
    outline: none;
    background-color: transparent;
    background-repeat: no-repeat;
    background-attachment: scroll;
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
