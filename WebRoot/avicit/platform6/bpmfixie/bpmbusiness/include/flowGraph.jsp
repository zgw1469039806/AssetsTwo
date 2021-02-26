<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	/* url参数 */
	String entryId = request.getParameter("entryId");
	if (entryId == null) {
		entryId = "";
	}
	String type = request.getParameter("type");
	if (type == null) {
		type = "";
	}
	String info = "";
	if (type.equals("doglobaljump")) {
		info = "在有多个并发节点的情况下，请您先选择一个流程跳转的起始节点（点击红框标记的节点），然后再选择一个目标节点后执行流程跳转操作";
	} else if (type.equals("dowithdraw")) {
		info = "在有多个并发节点的情况下，请您先选择一个流程拿回的节点（点击红框标记的节点），然后执行流程拿回操作";
	} else if (type.equals("dosupplement")) {
		info = "在有多个并发节点的情况下，请您先选择一个流程补发的节点（点击红框标记的节点），然后执行流程补发操作";
	} else if (type.equals("dostepuserdefined")) {
		info = "请您选择一个要定义流程审批人的节点，选择审批人然后点击提交";
	} else {
		info = "参数错误";
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程图</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<script type="text/javascript">
	//全局变量
	var entryId = '<%=entryId%>';
	var type = '<%=type%>';
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body style="margin: 0px; overflow: hidden;">
<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
	<div id="tip" style="position: relative; padding-left: 24px; background-color: #fdfcc2; border: solid 2px #ffe4c4; font-family: Microsoft YaHei; FONT-SIZE: 12px">
		<span><%=info%></span>
	</div>
	<div id="bpmImageDiv" style="position: relative;">
		<img id="img" src="platform/bpm/clientbpmdisplayaction/getfiguretrack.gif?processInstanceId=<%=entryId%>" />
	</div>
<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
//跳转、补发、拿回、全局读者动作
function MyDesignerEditor() {
};
MyDesignerEditor.prototype.arrayObj = new Array();
MyDesignerEditor.prototype.drawAct = function(activityMap, processInstanceId) {
	var _self = this;
	$.each(activityMap, function(i, activity) {
		var x = activity.left;
		var y = activity.top;
		var h = activity.height;
		var w = activity.width;
		var activityAlias = activity.activityAlias;
		var activityName = activity.activityName;
		var isCurrent = activity.isCurrent;
		var executionId = activity.executionId;
		var isAlone = activity.executionAlone;
		var sameActName = activity.sameActName;
		if(type == "dostepuserdefined"){
			if (isCurrent == "true") {
				$("#bpmImageDiv").append("<div id='"+executionId+"' onclick=\"designerEditor.dostepuserdefined('"+activityName+"');\" style='background:url(static/images/platform/bpm/client/images/tick2.png) no-repeat center;cursor:pointer;z-index:400;position:absolute;border:3px solid red;left:"+x+"px;top:"+y+"px;width:"+w+"px;height:"+h+"px;'></div>");
			}else{
				$("#bpmImageDiv").append("<div id='"+executionId+"' onclick=\"designerEditor.dostepuserdefined('"+activityName+"');\" style='background:url(static/images/platform/bpm/client/images/tick2.png) no-repeat center;cursor:pointer;z-index:400;position:absolute;left:"+x+"px;top:"+y+"px;width:"+w+"px;height:"+h+"px;'></div>");
			}
		}else{
			if (isCurrent == "true") {
				if (type == 'dosupplement') {
					$("#bpmImageDiv").append("<div id='"+executionId+"' onclick=\"designerEditor.dosupplement('"+executionId+"','"+activityName+"');\" style='background:url(static/images/platform/bpm/client/images/tick2.png) no-repeat center;cursor:pointer;z-index:400;position:absolute;border:3px solid red;left:"+x+"px;top:"+y+"px;width:"+w+"px;height:"+h+"px;'></div>");
				}
				if (type == 'doglobaljump') {
					$("#bpmImageDiv").append("<div id='"+executionId+"' onclick=\"designerEditor.dojump(this,'"+processInstanceId+"','"+isCurrent+"','"+activityName+"','"+activityAlias+"','"+executionId+"','"+isAlone+"');\" style='background:url(static/images/platform/bpm/client/images/tick2.png) no-repeat center;cursor:pointer;z-index:400;position:absolute;border:3px solid red;left:"+x+"px;top:"+y+"px;width:"+w+"px;height:"+h+"px;'></div>");
				}
				if (type == 'dowithdraw') {
					$("#bpmImageDiv").append("<div id='"+executionId+"' onclick=\"designerEditor.dowithdraw('"+executionId+"','"+activityName+"');\" style='background:url(static/images/platform/bpm/client/images/tick2.png) no-repeat center;cursor:pointer;z-index:400;position:absolute;border:3px solid red;left:"+x+"px;top:"+y+"px;width:"+w+"px;height:"+h+"px;'></div>");
				}
			}else{
				if (type == 'doglobaljump') {
					$("#bpmImageDiv").append("<div id='"+executionId+"' onclick=\"designerEditor.dojump(this,'"+processInstanceId+"','"+isCurrent+"','"+activityName+"','"+activityAlias+"','"+executionId+"','"+isAlone+"');\" style='background:url(static/images/platform/bpm/client/images/tick2.png) no-repeat center;cursor:pointer;z-index:400;position:absolute;left:"+x+"px;top:"+y+"px;width:"+w+"px;height:"+h+"px;'></div>");
				}
			}
		}
		if (isCurrent == "true") {
			_self.arrayObj.push($("#" + executionId));
		}
	});
};
MyDesignerEditor.prototype.dowithdraw = function(executionId, activityName) {
	parent.bpmWithdraw.callback(executionId, activityName);
};
MyDesignerEditor.prototype.dosupplement = function(executionId, activityName) {
	parent.bpmSupplement.callback(executionId, activityName);
};
MyDesignerEditor.prototype.dostepuserdefined = function(activityName) {
	parent.bpmStepuserdefined.callback(activityName);
};
MyDesignerEditor.prototype.startExecutionId = null;
MyDesignerEditor.prototype.dojump = function(obj, processInstanceId, isCurrent, activityName, activityAlias, executionId, isAlone) {
	var _self = this;
	// 只有一个当前节点，默认是开始节点
	if (isAlone)  {
		if (isCurrent == "true") {
			return;
		}
	} else {
		if (isCurrent == "true") {
			this.startExecutionId = executionId;
			$(obj).css("border", "3px solid blue");
			$.each(this.arrayObj, function(i, n) {
				if (n.attr("id") != $(obj).attr("id")) {
					n.css("border", "3px solid red");
				}
			});
			return;
		} else {
			if (!flowUtils.notNull(this.startExecutionId)) {
				flowUtils.warning("请您先选择一个当前节点作为流程跳转的起始节点");
				return;
			}
		}
	}
	// Added in 01-16
	var rst;
	if (flowUtils.notNull(this.startExecutionId)) {
		rst = this.validateDestActivity(processInstanceId, this.startExecutionId, activityName);
	} else {
		rst = this.validateDestActivity(processInstanceId, executionId, activityName);
	}
	if (rst.flag == "failed") {
		flowUtils.warning("无法跳转到所选节点，请您重新选择");
		return;
	}
	// 分支跳转
	if (flowUtils.notNull(this.startExecutionId)) {
		executionId = this.startExecutionId;
	}
	parent.bpmGlobaljump.callback(executionId, activityName);
};
MyDesignerEditor.prototype.validateDestActivity = function(processInstanceId, executionId, activityName) {
	var result = "";
	$.ajax({
		type : "POST",
		data : {
			procinstDbid : processInstanceId,
			executionId : executionId,
			activityName : activityName
		},
		url : "platform/bpm/clientbpmoperateaction/validateDestActivity",
		async : false,
		dataType : "json",
		success : function(msg) {
			result = msg;
		}
	});
	return result;
};
var designerEditor = new MyDesignerEditor();
$(function() {
	$.ajax({
		type : "POST",
		data : {
			processInstanceId : entryId
		},
		url : "platform/bpm/clientbpmdisplayaction/getcoordinate",
		dataType : "json",
		success : function(result) {
			if (flowUtils.notNull(result, result.activity)) {
				designerEditor.drawAct(result.activity, entryId);
			}
		}
	});
});
</script>
</body>
</html>