<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
	String processInstanceId = "\'"+request.getParameter("processInstanceId")+"\'";//流程实例id
%>
<!DOCTYPE html>
<html>
<head>
<title>流程实例变量</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" href="avicit/platform6/bpmreform/bpmmonitor/css/style.css"/>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
}

</style>

</head>
<body>
	<div id="toolbar_bpmProcessVar" class="toolbar">
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="bpmProcessVar_keyWord"
					id="bpmProcessVar_keyWord" style="width:240px;"
					class="form-control input-sm" placeholder="请输入查询条件"> <label
					id="bpmProcessVar_searchPart"
					class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
	</div>
	<table id="bpmProcessVar"></table>
	<!--  <div id="bpmProcessVarPager"></div>-->

</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmmonitor/js/BpmProcessVar.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
	var bpmProcessVar;
	var processInstanceId = <%=processInstanceId%>;

	$(document).ready(function() {
		var searchSubNames = new Array();
		var searchSubTips = new Array();
		searchSubNames.push("strName");
		searchSubTips.push("参数名称");
		$('#bpmProcessVar_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
		var bpmProcessVarGridColModel = [
			{
				label : 'dbid',
				name : 'dbid',
				key : true,
				hidden : true
			}
			, {
				label : '参数名称',
				name : 'key_',
				width : 50,
				sortable : false
			}
			, {
				label : '参数类型',
				name : 'class_',
				width : 40,
				align : 'left',
				sortable : false,
				formatter:function(value,rec){
					var type=value;
					if(type=='string'){
  						return '字符串';
  					}else if(type=='long' || type=='int' ){
  						return '整型';
  					}else if(type=='double'){
						return '数值';
					}else if(type=='date'){
						return '日期';
					}
					else if(type=='blob'){
  						return '二进制大对象';
  					}else{
  						return '其它类型';
  					}
				}
			}
			, {
				label : '参数值',
				name : 'string_value_',
				width : 100,
				align : 'left',
				sortable : false,
				formatter:function(value,options, rowObject){
					var type=rowObject.class_;
					if(type=='string'){
						return rowObject.string_value_;
					}else if(type=='long' || type=='int' ){
						return rowObject.long_value_;
					}else if(type=='double'){
						return rowObject.double_value_;
					}else if(type=='date'){
						return rowObject.date_value_;
					}else{
						return '';
					}


				}
			}
		];

        var url = 'bpm/monitor/getProcessEntryVariable?processInstanceId='+processInstanceId;
		bpmProcessVar = new BpmProcessVar('bpmProcessVar', url, '', bpmProcessVarGridColModel, '',  searchSubNames, "bpmProcessVar_keyWord");

		//关键字段查询按钮绑定事件
		$('#bpmProcessVar_searchPart').bind('click', function() {
			bpmProcessVar.searchByKeyWord();
		});

	});
</script>
</html>
