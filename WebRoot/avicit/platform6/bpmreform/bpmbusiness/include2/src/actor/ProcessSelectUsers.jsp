<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree,form";
%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>流程选人</title>
 	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
     <link rel="stylesheet" href="avicit/platform6/bpmreform/bpmbusiness/include2/common/css/style.css">
    <link rel="stylesheet" href="avicit/platform6/bpmreform/bpmbusiness/include2/common/css/reset.css">
    <link rel="stylesheet" href="avicit/platform6/bpmreform/bpmbusiness/include2/common/css/comment.css">
    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeviewmin.css"/>

<style type="text/css">
.user-lsit {
    display: block;
    width: 100%;
    height: 34px;
    padding: 6px 12px;
    font-size: 13px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    border-bottom:1px solid #e8e8e8;
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
.user-lsit:HOVER {
	background-color: #f5f5f5;
}

.userListDiv{
    height: 270px;
    overflow-y: auto;
}

input[type=checkbox]:checked:after, input[type=radio]:checked:after {
    color: #2fad95;
}
.user-lsit label input{
	margin-right:5px;
	float:left;
}
label {
    display: inline-block;
    max-width: 100%;
    margin-bottom: 5px;
    font-weight: 100;
    line-height:20px;
}

.form_commonTable label{
	font-size: 14px;
}
/* UI调整搜索结果页面宽度 */
.searchResult{
	width: 240px;
    font-size: 12px;
    line-height: 1.5;
    border-radius: 3px;
    position: absolute;
    z-index : 30;
    margin-top: 35px;
    background-color: #ffffff;
    display : none;
    max-height:200px;
    min-height:1px;
    overflow:auto;
}

</style>
</head>

<body>

    <div id="comment-panel">
        <div class="chose-panel" id="selectUserDiv">
            <h2>选择</h2>
            <div class="tree-list" id="nodeTreeList">
            </div>
            <div class="checkedbox-list" id="selectedList">
            </div>
        </div>
        <div class="opinion-panel" id="opPanelDiv">
            <div class="op-title" id="opTitleDiv">
                意见
            </div>
            <div class="op-edit-box">
                <div class="op-tools">
                    <div class="title">常用意见</div>
                    <ul class="often">
                        <li class="quikmsg"><em class="icon icon-c-view"></em>已阅</li>
                        <li class="quikmsg"><em class="icon icon-c-yes"></em>同意</li>
                        <li class="quikmsg"><em class="icon icon-c-no"></em>不同意</li>
                        <%--<li>
                            <em class="icon icon-c-more"></em>更多
                            <div class="often-more">
                                <ul>
                                </ul>
                            </div>

                        </li>--%>
                    </ul>
                    <div class="op-btns">
                        <div class="like"><em class="icon icon-c-like"></em>添加到收藏</div>
                        <div class="setting">
                            <em class="icon icon-c-setting"></em>收藏
                            <div class="setting-detail">
                                <div class="sd-box">
                                    <%--<div class="title-tool">
                                        <em class="sm-check-all" title="全选"></em>
                                        <em class="clear-all" title="删除选中"></em>
                                    </div>--%>
                                    <ul id="setting-msg-drag">
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="op-textarea">
                    <textarea name="myIdea" id="myIdea" cols="30" rows="10"></textarea>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
    <!-- 页面功能 -->
    <script type="text/javascript"
        src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/jquery.dragsort-0.5.2.min.js"></script>
    <script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
    <script src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/comment.js"></script>
    <script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/actor/BpmSelectUser.js"></script>
    <script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/actor/IdeaController.js"></script>
</body>
<script type="text/javascript">
var _bpmSelectUser;
var treeArr = new Array();

function hideSelectView(){
	$("#selectUserDiv").hide();
	$("#opTitleDiv").hide();
	$("#opPanelDiv").attr("class","opinion-panel full");
}

$(function () {
	var _actorModel = parent._actorModel;
	var _data = parent._data;
	_bpmSelectUser = new BpmSelectUser(_actorModel,_data);
	//不需要显示选人框的处理
	if(!_bpmSelectUser.showSelectUser()){
		hideSelectView();
	}

	//不需要显示意见框的处理,增加读者不需要填写意见
	/**
	if(_data.event == 'dotaskreader'){
		BpmSelectUser.js$("#opPanelDiv").hide();
	}*/
	if(_actorModel.nextTask){
		var leftHtml = _bpmSelectUser.generateLeftHtml();
		$("#nodeTreeList").html(leftHtml);
		var rightHtml = _bpmSelectUser.generateRightHtml();
	    $("#selectedList").html(rightHtml);
	    _bpmSelectUser.autoSelectToCheckUserList();
		$('.input-group input').keyup(function(event){
			if(event.keyCode == 13){
				var searchType = $(this).attr('searchType');
				var searchContent = $(this).val();
				var secretLevel = $(this).attr('secretLevel');
				var treeId = $(this).attr('treeId');
				var single = $(this).attr('single');
				var dealType = $(this).attr('dealType');
				var searchCondition= $(this).attr('searchCondition');
                var activityName = $(this).attr("activityName");
				if(searchContent != ''){
					search(this,searchType,searchContent,searchCondition,secretLevel,treeId,single,dealType,activityName);
				} else {
					top.layer.msg('请输入检索内容!');
				}
	        }
		});

		$('.input-group button').click(function(){
			var searchType = $(this).attr('searchType');
			var searchCondition= $(this).attr('searchCondition');
			var secretLevel = $(this).attr('secretLevel');
			var treeId = $(this).attr('treeId');
			var single = $(this).attr('single');
			var dealType = $(this).attr('dealType');
			var activityName = $(this).attr("activityName");
			var searchContent = $(this).parents(".input-group").find('input').val();
			if(searchContent != ''){
				search(this,searchType,searchContent,searchCondition,secretLevel,treeId,single,dealType,activityName);
			} else {
				top.layer.msg('请输入检索内容!');
			}
		});

		var btns = $(".bpm_selectUser_class .layui-layer-btn",window.parent.document);
		if(btns.children().length==3){
			btns.children().eq(1).attr("class","layui-layer-btn0");
		}
	}


	initComment(_actorModel);
    initIdeaComment(_actorModel);

	$("body").click(function(e){
		e = e || window.event;
		var dom =  e.srcElement|| e.target;
		var searchResult = $('.searchResult');
		if($(dom).parents(".input-group").find(".searchResult").length == 0 && searchResult.is(':visible')){
			searchResult.hide(200);
		}
	});
});

function selectorNodeData(node,treeId,single,dealType,activityName){
    var childrenNodes = node.children;
    if(childrenNodes){
        for(var i = 0 ; i < childrenNodes.length ; i++){
            var childNode = childrenNodes[i];
            var treeObj = $.fn.zTree.getZTreeObj(treeId);
            treeObj.checkNode(childNode, true, true);
            if(childNode.attributes.nodeType == "user"){
                selectorData(childNode,treeId,single,dealType,activityName);
            } else {
                selectorNodeData(childNode,treeId,single,dealType,activityName);
            }
        }
    } else {
        $('#' + node.tId + '_switch').trigger('click');
    }
}

function checkRepeat(treeChildArea,userId){
	var selectedUser = $("#"+treeChildArea).find("div[id='"+userId+"']");
	if(selectedUser && selectedUser.length>0){
		return true;
	}
}

function userListSelector(obj,userId,userName,deptId,deptName,activityName,single,dealType)
{
	var a = "";
	var treeChildArea = $('#sub-tree-user-'+activityName).data('for');
	var subUserTreeId = "sub-tree-user-"+activityName;
	if(obj.checked){
		var tmp = {id:userId,name:userName,attributes:{deptId:deptId,deptName:deptName}};
	    selectorData(tmp,subUserTreeId,single,dealType,activityName);
	}else{
		removeEvent(userId,subUserTreeId);
	}
}

function removeEvent(userId,treeId){
	var treeChildArea = $("#" + treeId).data('for');
	$("#"+treeChildArea+" #"+userId).remove();
	if (!$('#'+treeChildArea).find('.elm-checked').length) {
		$('#'+treeChildArea).parent().find('.cb-tool .btns').removeClass('on');
	}
}


function removeNodeCheck(node,treeId){
    var childrenNodes = node.children;
    if(childrenNodes){
        for(var i = 0 ; i < childrenNodes.length ; i++){
            var childNode = childrenNodes[i];
            removeEvent(childNode.id,treeId);
            removeNodeCheck(childNode,treeId);
        }
    }
}

/**
 * 配置选人的自动选人方法
 */
function selectUserForStepuserdefined(object,treeChildArea,activityName){
    var originalName = object.attributes.originalName?object.attributes.originalName:object.name;
    $('#'+treeChildArea).append("<div id='"+object.id+"' userName='"+originalName+"' deptId='"+object.attributes.deptId+"' deptName='"+object.attributes.deptName+"' class='elm-checked' data-activityName='"+activityName+"' data-treeid='' data-type='tree'>"+originalName+"</div>");
    $('#'+ treeChildArea).parent().find('.cb-tool .btns').addClass('on');

}

function selectorData(object,treeId,single,dealType,activityName){
	var treeChildArea = $("#" + treeId).data('for');
	if(checkRepeat(treeChildArea,object.id)){
		return;
	}
	if(dealType == '1' || single == 'yes'){//单选用户
		if($("#"+treeChildArea).find(".elm-checked").length>0){
			top.layer.msg('当前节点只允许选择一个处理人！');
			return;
		}
	}

	//只添加用户（user）
	if(object.attributes.nodeType == "user"){
        var originalName = object.attributes.originalName?object.attributes.originalName:object.name;
		$('#'+treeChildArea).append("<div id='"+object.id+"' userName='"+originalName+"' deptId='"+object.attributes.deptId+"' deptName='"+object.attributes.deptName+"' class='elm-checked' data-activityName='"+activityName+"' data-treeid='"+treeId+"' data-type='tree'>"+originalName+"</div>");
		$('#'+ treeChildArea).parent().find('.cb-tool .btns').addClass('on');
	}else if(object.attributes.nodeType == "org"){//组织
        var childrenNodes = object.children;
        if(childrenNodes && (typeof childrenNodes.length != "undefined")){
            for(var i = 0 ; i < childrenNodes.length ; i++){
                var node = childrenNodes[i];
                selectorData(node,treeId,single,dealType,activityName);
            }
        }
	}else if(object.attributes.nodeType == "dept"){//若节点是部门，则递归查询节点下的用户
        var childrenNodes = object.children;
        if(childrenNodes && (typeof childrenNodes.length != "undefined")){
            for(var i = 0 ; i < childrenNodes.length ; i++){
                var node = childrenNodes[i];
                selectorData(node,treeId,single,dealType,activityName);
            }
        }
	}else if(typeof object.attributes.nodeType == "undefined"){//用户维度选择，搜索选择时沿用原处理
        $('#'+treeChildArea).append("<div id='"+object.id+"' userName='"+object.name+"' deptId='"+object.attributes.deptId+"' deptName='"+object.attributes.deptName+"' class='elm-checked' data-activityName='"+activityName+"' data-treeid='"+treeId+"' data-type='tree'>"+object.name+"</div>");
		$('#'+ treeChildArea).parent().find('.cb-tool .btns').addClass('on');
	}

	formatDrag($('#'+treeChildArea), 'div', function () {
    },true);
}


function search(obj,searchType,searchContent,searchCondition,secretLevel,treeId,single,dealType,activityName){
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
				var msg = msg.replace(/searchUserListSelector\(/g,"searchUserListSelector('"+activityName+"','"+treeId+"','"+single+"','"+dealType+"',");
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

function searchUserListSelector(activityName,treeId,single,dealType,e,obj,userId,userName,deptId,deptName){
	if(obj.checked){
	    var tmp = {id:userId,name:userName,attributes:{deptId:deptId,deptName:deptName}};
	    selectorData(tmp,treeId,single,dealType,activityName);
	 }
	 e = e || window.event;
	 if(+'\v1') {
         e.stopPropagation();
     } else  {
         e.cancelBubble = true;
     }

}

function getSelectedUsers(){
	 var _activityUserList = [];
	 var _actorModel = parent._actorModel;
	 var _outcome = _actorModel.currentActivityAttr.outcome;
	 for(var i=0;i<_actorModel.nextTask.length;i++){
		 var _nextActorModel = _actorModel.nextTask[i];
		 var curActor = {};
		 var userList = [];
		 curActor.outcome = _outcome;
		 curActor.targetActivityName = _nextActorModel.currentActivityAttr.activityName;
		 var checkboxList = $("#cba-for-tree-"+_nextActorModel.currentActivityAttr.activityName);
		 checkboxList.find("div[class^='elm-checked']").each(function(index,element){
			var userId = $(this).attr("id");
			var userName = $(this).attr("userName");
			var deptId = $(this).attr("deptId");
			var deptName = $(this).attr("deptName");
             var selectorUser = {
                 userId : userId,
                 userName : userName,
                 deptId : deptId,
                 deptName : deptName
             };
			userList.push(selectorUser);
		 });
		 curActor.selectedUsers = userList;
		 curActor.workhandUsers = [];
		 _activityUserList.push(curActor);
	 }

	 return _activityUserList;
}

function getIdea(){
	return $("#myIdea").val();
}

function focusIdeaText(){
	$("#myIdea").focus();
}

Array.prototype.removeAt = function(p_index) {
	if (p_index >= 0 && p_index < this.length) {
		this.splice(p_index, 1);
	} else {
		return false;
	}
};

</script>
</html>

