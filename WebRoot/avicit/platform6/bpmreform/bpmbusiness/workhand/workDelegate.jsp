<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>我的委托</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<style type="text/css">
body {
	margin: 0;
	padding: 0;
}


</style>
</head>
<body>

<div id="toolbar_workDelegate" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3"
			domainObject="workDelegate_insert" permissionDes="新建委托">
			<a id="workDelegate_insert" href="javascript:void(0)"
			class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="新建委托">
			<i class="fa fa-plus"></i> 新建委托</a>
		</sec:accesscontrollist>
		<a id="workDelegate_fetch" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="拿回已移交的待办"><i class="glyphicon glyphicon-arrow-left"></i> 拿回已移交的待办</a>

	</div>
</div>
<table id="workDelegate"></table>
<div id="workDelegatePager"></div>

</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmbusiness/workhand/js/workDelegate.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>

<script type="text/javascript">
	var workDelegate;

	$(document).ready(function() {
		var searchSubNames = new Array();
		var searchSubTips = new Array();
		searchSubNames.push("procDefName");
		searchSubTips.push("标题");
		$('#workDelegate_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
		var workDelegateGridColModel = [
		            {label : 'id', name : 'id', key : true, width : 75,hidden : true},
					{label : '委托人', name : 'workOwnerName', width : 150,align:"center",formatter:formatDetail,sortable : false},
					{label : '默认受托人', name : 'receptUserName', width : 200,align:"center",sortable : false},
					{label : '默认受托人部门', name : 'receptDeptName', width : 200,align:"center",sortable : false},
					{label : '委托方式', name : 'attribute01', width : 100,align:"center",sortable : false,formatter:function(value, options, rowObject){
					    if(value == '0') {
					        return "系统";
                        } else {
					        return "自定义";
                        }
                        }},
					{label : '移交原因', name : 'handReason', width : 150 ,align:"center",sortable : false},
					{label : '创建时间', name : 'handDate', width : 150, align:"center",formatter:formatterDate,sortable : true},
					{label : '开始时间', name : 'handEffectiveDate', width : 150,formatter:formatterDate,align:"center",sortable : true},
					{label : '结束时间', name : 'backDate', width : 150, align:"center",formatter:formatterDate,sortable : true},
					{label : '当前状态', name : 'validFlag', width : 100, align:"center",formatter:formatterValidFlag,sortable : true},
                    {label : '操作', name : '', width : 100, align:"center",formatter:act,sortable : false}
        ];

		var url = "platform/bpm/clientbpmWorkHandAction/getSysWorkHandListByPage2";
		workDelegate = new WorkDelegate('workDelegate', url, "formSub", workDelegateGridColModel);
		//添加按钮绑定事件
   		$('#workDelegate_insert').on('click', function() {
        	workDelegate.insert();
    	});
    	// 拿回已已移交的按钮绑定事件
    	$('#workDelegate_fetch').on('click', function() {
       	    workDelegate.fetch();
    	});
	});

	function formatDetail(cellvalue, options, rowObject){
		return '<a  href="javascript:void(0)" '
		+'  title="委托详情" onClick="workHandDetail(\''+rowObject.id+'\')">'+cellvalue+'</a>';
	};

	function workHandDetail(id){
		workDelegate.workHandDetail(id);
	}

	function formatterValidFlag(cellvalue, options, rowObject) {
    	var validString = "";
    	if(cellvalue == "1"){
    		var beginDate = rowObject.handEffectiveDate;
    		var beginDateStr = (new Date(beginDate)).format("yyyy-MM-dd");
    		var nowDate = new Date();
    		var nowDateStr = nowDate.format("yyyy-MM-dd");
    		if(beginDateStr>nowDateStr){
    			validString = "未开始";
    		}else{
    			validString = "委托中";
    		}
  	  }else if(cellvalue == "0"){
  	      validString = "无效";
  	  }else if(cellvalue == "2"){
  	      validString = "已完成";
  	 }
  	 return validString;
   };

   function formatterDate(value, options, rowObject) {
    	var newDate = new Date(value);
    	return newDate.Format("yyyy-MM-dd");
	};

	function act(value, options, rowObject) {
		var html = '<a href="javascript:void(0)" name="btn-flow-variable-delete" onclick="workDelegate.deleteData(\''+rowObject.id+'\')">删除</a>';
		if(rowObject.validFlag == "1"){
    		var beginDate = rowObject.handEffectiveDate;
    		var beginDateStr = (new Date(beginDate)).format("yyyy-MM-dd");
    		var nowDate = new Date();
    		var nowDateStr = nowDate.format("yyyy-MM-dd");
    		if(beginDateStr>nowDateStr){
    			html += ' | <a href="javascript:void(0)" name="btn-flow-variable-update" onclick="workDelegate.toUpdate(\''+rowObject.id+'\')">修改</a>';
    		}
    		if(beginDateStr<=nowDateStr){
    			html += ' | <a href="javascript:void(0)" name="btn-flow-variable-delete" onclick="workDelegate.completeData(\''+rowObject.id+'\')">完成</a>';
    		}
   	 }
   	 return html;
	};

</script>
</html>
