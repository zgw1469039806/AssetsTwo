<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<title>AVICIT WORKFLOW 选人</title>
<meta http-equiv="X-UA-Compatible" content="chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<base href="<%=ViewUtil.getRequestPath(request) %>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessUserDialogJsInclude.jsp"></jsp:include>
<script src="static/js/platform/bpm/client/js/cookie.jquery.js" type="text/javascript" charset="UTF-8"></script>
<script src="static/js/platform/component/jQuery/jquery-easyui-1.3.5/plugins/jquery.toolbar.js" type="text/javascript" charset="utf-8"></script>
<script src="static/js/platform/component/jQuery/jquery-easyui-1.3.5/extend/easyui.layout.extend.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="static/js/platform/component/jQuery/jQuery-liveSearch/themes/jquery.liveSearch.css">
<script src="static/js/platform/component/jQuery/jQuery-liveSearch/jquery.liveSearch.js" type="text/javascript" charset="utf-8"></script>
<script language="JavaScript" src="static/js/platform/bpm/client/js/ProcessSelectorUserComponent.js" type="text/javascript" charset="utf-8"></script>
<script language="JavaScript" src="static/js/platform/bpm/client/js/ProcessSelectorUserCF.js" type="text/javascript" charset="utf-8"></script>
<script language="JavaScript" src="static/js/platform/bpm/client/js/ProcessSelectorCommonIdearComponent.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript">

var baseurl = '<%=request.getContextPath()%>';
var dataJson = ${taskUserSelect};
var processInstanceId = '${processInstanceId}';
var executionId = '${executionId}';
var outcome = '${outcome}';
var type = '${type}';
var mySelectUser  = ${mySelectUser};
var taskId = '${taskId}';
var targetActivityName = '${targetActivityName}';
var orgId = '${orgId}';
var doSubmitUrl = '${doSubmitUrl}';
var doSubmitCallEvent = '${doSubmitCallEvent}';
var secretLevel = '${secretLevel}';
var filterUser = '${filterUser}';
var processKey = '${processKey}';
var commonContacts = null;
</script>
</head>
<body>
<!-- 
	<div style="width:100%;height:275px;" id="topFrame">
		<iframe name="selectorUser" id="selectorUser" width="100%" height="100%" id="selectorUser" marginwidth="0" marginheight="0" src="${selectWebPath}"  scrolling="no" frameborder="0"></iframe>
	</div> 
	<div style="width:100%;height:135px;" id="bottomFrame">
		<iframe name="commonIdear" id="commonIdear" width="100%" height="100%" id="commonIdear"  marginwidth="0" marginheight="0" src="${commonIdearWebPath}"  scrolling="no" frameborder="0"></iframe> 
	</div>
	-->

   <div class="easyui-layout" fit="true" id='selectorUserlayout'>
   		<div region="center" id="workflowSelectorSource"></div>
   		<div region="south" split="true" style="height:125px;" id='ideaCompel' ><div id="toolbar"></div><textarea id="textAreaIdeas" style="width:98.5%;height:75px;"></textarea></div>
   </div>
   <!-- 加载常用意见 -->
   <div id="shareit-box">
		<div id="shareit-header"></div>
		<div id="shareit-body">
			<div id="shareit-blank"></div>
			<div id="shareit-url"></div>
		</div>
	</div>
   <!-- 强制表态需要 -->
   <input type="hidden" id="ideaCompelManner" name="ideaCompelManner" value='' />
    <!--右键菜单-->
	<div id="addContactMenu" class="easyui-menu" style="width:140px;">
		<div onclick="addContact()" data-options="iconCls:'icon-add'">添加到常用联系人</div>
	</div>
	<!--右键菜单-->
	<div id="delContactMenu" class="easyui-menu" style="width:140px;">
		<div onclick="delContact()" data-options="iconCls:'icon-remove'">删除常用联系人</div>
	</div>
</body>
<script>
	if(dataJson.nextTask != null && dataJson.nextTask.length == 1){
		$("#selectorUserlayout").append("<div region=\"east\" split=\"true\" style=\"width:300px;\" id='selectedResultCompel'><div id=\"selectorUserTabForTargetDataGrid_0\"></div></div>");
	}
	function addContact(){
		if(commonContacts!=null){
            $.ajax({
                type: "POST",
                url: getPath2() + '/platform/user/bpmSelectUserAction/addCommonContact',
                async: false,
                data: 'contactId='+commonContacts.contactId
                    +'&contactDeptId='+commonContacts.contactDeptId
                    +'&processKey='+commonContacts.processKey
                    +'&toActivityName='+commonContacts.toActivityName,
                dataType: 'json',
                success: function(result){
                	if(result.success=="false"){
						$.messager.alert('错误',result.msg,'error');
						return ;
					}else{//增加节点
						var treeId = commonContacts.treeId;
						var commonContactsNode = $("#"+treeId).tree("find","commonContacts");
						var data = [];
						var nodeData = {
						   "id":commonContacts.contactId,
						   "text":commonContacts.contactName,
						   "iconCls":"icon-user",
						   "state":true,
						   "attributes":{
						   		"nodeType":"user",
								"isRemoveContacts":"1",
								"processKey":commonContacts.processKey,
								"toActivityName":commonContacts.toActivityName,
								"deptId":commonContacts.contactDeptId,
								"deptName":commonContacts.contactDeptName
							}
						};
						data.push(nodeData);
						$("#"+treeId).tree("append",{
							"parent":commonContactsNode.target,
							"data":data
						});
					}
                },
                error : function(msg){
                    $.messager.alert('错误',msg.responseText,'error');
                    return ;
                }
            });
			commonContacts = null;
		}
	}

	function delContact(){
		if(commonContacts!=null){
			var tree = $("#"+commonContacts.treeId);
			var node = tree.tree("getSelected");
			$.ajax({
				type: "POST",
				url: getPath2() + '/platform/user/bpmSelectUserAction/delCommonContact',
				async: false,
				data: 'contactId='+commonContacts.contactId
						+'&contactDeptId='+commonContacts.contactDeptId
						+'&processKey='+commonContacts.processKey
						+'&toActivityName='+commonContacts.toActivityName,
				dataType: 'json',
				success: function(result){
					if(result.success=="true"){
						tree.tree("remove",node.target);
					}else{
						$.messager.alert('错误',result.msg,'error');
						return ;
					}
				},
				error : function(msg){
					$.messager.alert('错误',msg.responseText,'error');
					return ;
				}
			});
			commonContacts = null;
		}
	}
</script>

</html>
