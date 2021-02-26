<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>查看权限明细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style type="text/css">
	#t_sysDataPermissionsAuth{
		display: none;
	}
</style>
</head>
<body>
	<div class="toolbar-left">
		<div class="input-group form-tool-search">
			<input type="text" name="searchTable_keyWord" id="searchTable_keyWord" style="width: 240px;" class="form-control input-sm" placeholder="请输入角色名称" />
			<label id="searchTable_searchPart" class="icon icon-search form-tool-searchicon"></label>
		</div>
	</div>
	<table id="sysDataPermissionsAuth"></table>
	<div id="sysDataPermissionsAuthPager"></div>

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	
	<script type="text/javascript" src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/js/SysDataPermissionsAuthDetail.js?v=<%=System.currentTimeMillis() %>"></script>
	<script type="text/javascript">
		var idMap;
		$(function(){
			avicAjax.ajax({
				url:"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/getRuleDto",
				data : {methodId : '${methodId}'},
				type : 'get',
				dataType : 'json',
				async:false,
				success : function(r){
					if (r.flag == "success"){
						idMap = new Map();
						$.each(r.authMap, function (index, data) {
							idMap.put(data.identifier,data);
						});
					}
				}
			});
			var gridColModel = [{
	        		label : 'id',
	         		name : 'id',
	         		key : true,
	         		hidden : true
	         	}, {
	         		label : '角色名称',
	         		name : 'roleName',
	         		width : 75,
	         		align:'center',
	         		sortable : false
	         	}, {
	         		label : '公式',
	         		name : 'formula',
	         		width : 100,
	         		sortable : false
	         	}, {
	         		label : '过滤条件',
	         		name : 'filterCondition',
	         		width : 200,
	         		sortable : false,
	         		formatter : formatFilterCondition
	         	}, {
	         		label : '过滤条件SQL',
	         		name : 'filterConditionSql',
	         		width : 200,
	         		sortable : false,
	         		formatter : formatFilterConditionSql
	         	}];
	
	 		var allRuleList = '${allRule}';
	 		var jsonList = JSON.parse(allRuleList);
	 		if(jsonList.length > 0){
	 			$.each(jsonList,function(index,data){
		 			gridColModel.push({
		        		label: data.label,
		        		name: data.name,
		        		width : 100,
		        		align:'center',
		        		formatter : formatValue,
		        		sortable : false
		        	});
		 		});
	 		}
	 		
	 		$("#sysDataPermissionsAuth").jqGrid({
	 			url:"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/getShowAuthDetailPage",
	 			postData: {methodId:'${methodId}'},
	 	        mtype: 'POST',
	 	        datatype: "json",
	 	        toolbar: [true,'top'],//启用toolbar
	 	        colModel: gridColModel, //表格列的属性
	 	        height:$(window).height()-140, //初始化表格高度
	 	        scrollOffset: 20, //设置垂直滚动条宽度
	 	        altRows:true,//斑马线
	 	        userDataOnFooter: true,
	 	        pagerpos:'left',//分页栏位置
	 	        multiboxonly: true,
	 	        loadComplete:function(){
	 				$("#jqgh_sysDataPermissionsAuth_roleName").css("text-align","center");
	 			},
	 	        styleUI : 'Bootstrap',//Bootstrap风格
	 			viewrecords: true, //是否要显示总记录数
	 			multiselect: false, //可多选
	 			autowidth: true, //列宽度自适应
	 			shrinkToFit: true,
	 			responsive:true//开启自适应
	 	    });
	 		
	 		if(jsonList.length > 0){
	 			$("#sysDataPermissionsAuth").jqGrid('setGroupHeaders', {
		 		    useColSpanStyle: true, 
		 		    groupHeaders:[
		 		    	{startColumnName: 'roleName', numberOfColumns: 4, titleText: '公式详情'},
		 		    	{startColumnName: jsonList[0].name, numberOfColumns: jsonList.length, titleText: '规则详情'}
		 		    ]  
		 		});	
	 		} else {
	 			$("#sysDataPermissionsAuth").jqGrid('setGroupHeaders', {
		 		    useColSpanStyle: true, 
		 		    groupHeaders:[
		 		    	{startColumnName: 'roleName', numberOfColumns: 4, titleText: '公式详情'}
		 		    ]  
		 		});	
	 		}
	 	   	
	 	   $("#searchTable_searchPart").bind('click', function() {
				var keyWord = $("#searchTable_keyWord").val();
				$('#sysDataPermissionsAuth').jqGrid('setGridParam', {
					datatype : 'json',
					postData : {
						'keyword' : keyWord
					}
				}).trigger("reloadGrid");
			});
			$("#searchTable_keyWord").bind('keyup',function(e) {
				if (e.keyCode == 13) {
					var keyWord = $("#searchTable_keyWord").val();
					$('#sysDataPermissionsAuth').jqGrid('setGridParam', {
						datatype : 'json',
						postData : {
							'keyword' : keyWord
						}
					}).trigger("reloadGrid");
				}
			});
		});
	</script>
	<script type="text/javascript">
		function isIE() {
		 	if (!!window.ActiveXObject || "ActiveXObject" in window){
				return true;
		 	} else {
				return false;
		 	}
		}
		if(isIE()){
			$("body").width("99%");
		}
	</script>
</body>
</html>