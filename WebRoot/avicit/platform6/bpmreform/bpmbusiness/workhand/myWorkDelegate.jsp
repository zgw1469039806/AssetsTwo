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
<title>我的受托</title>
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
<table id="workDelegate"></table>
<div id="workDelegatePager"></div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmbusiness/workhand/js/myWorkDelegate.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>

<script type="text/javascript">
	var workDelegate;
	
	$(document).ready(function() {
		var workDelegateGridColModel = [	
		            {label : 'id', name : 'id', key : true, width : 75,hidden : true},
					{label : '委托人', name : 'workOwnerName', width : 150,align:"center",formatter:formatDetail,sortable : false},
					// {label : '委托人部门', name : 'workOwnerDeptName', width : 150,align:"center"},
					{label : '默认受托人', name : 'receptUserName', width : 150,align:"center",sortable : false},
					{label : '默认受托人部门', name : 'receptDeptName', width : 150,align:"center",sortable : false},
					{label : '移交原因', name : 'handReason', width : 100 ,align:"center",sortable : false},
					{label : '创建时间', name : 'handDate', width : 100, align:"center",formatter:formatterDate,sortable : true},
					{label : '开始时间', name : 'handEffectiveDate', width : 150,formatter:formatterDate,align:"center",sortable : true},
					{label : '结束时间', name : 'backDate', width : 150, align:"center",formatter:formatterDate,sortable : true},
					{label : '当前状态', name : 'validFlag', width : 100, align:"center",formatter:formatterValidFlag,sortable : true},
                    {label : '操作', name : '', width : 150, align:"center",formatter:formatterOpt,sortable : false}
        ];

		var url = "platform/bpm/clientbpmWorkHandAction/getSysWorkHandListByPage2?queryType=2";
		workDelegate = new MyWorkDelegate('workDelegate', url, "formSub", workDelegateGridColModel);
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
	
	function formatterOpt(value, options, rowObject) {
		var html = '';
    	if(rowObject.validFlag == '1'){
    		var beginDate = rowObject.handEffectiveDate;
    		var beginDateStr = (new Date(beginDate)).format("yyyy-MM-dd");
    		var nowDate = new Date();
    		var nowDateStr = nowDate.format("yyyy-MM-dd");
    		if(beginDateStr>nowDateStr){
    			html += '<a href="javascript:void(0)" name="btn-flow-variable-reject" onclick="rejectWorkhand(\''+rowObject.id+'\')">驳回</a>';
    		}
    	}    
    	return html;
	};
	
	function rejectWorkhand(id){
		workDelegate.rejectWorkhand(id);
	}

</script>
</html>