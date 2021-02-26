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
<title>角色选择</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css-fixie8-fonticon.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class=" easyui-layout" fit="true">
 <div data-options="region:'center',onResize:function(a){$('#jqGrid').setGridWidth(a);$(window).trigger('resize');}">
    <div id="tableToolbar" class="toolbar">
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="keyWord" id="keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="请输入岗位名称查询"> <label
					id="Group_searchPart" onclick="positionSeach()" class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
	</div>
	<table id="jqGrid"></table>
	<div id="jqGridPager"></div>
</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script>
	//初始化表格参数
	$(document) .ready( function() {
		var dataGridColModel = [ {
			label : 'id',
			name : 'id',
			key : true,
			width : 75,
			hidden : true
		}, {
			label : '岗位名称',
			name : 'positionName',
			width : 150
		}, {
			label : '岗位描述',
			name : 'positionDesc',
			width : 150
		}, {
			label : '组织应用ID',
			name : 'orgIdentity',
			width : 150
			,hidden : true
		} ];
		
		$('#jqGrid') .jqGrid( {
			url : 'h5/view/common/select/SelectController/getInitPositionInfo',
			mtype : 'POST',
			datatype : "json",
			postData : {viewScope : 'currentOrg'},
			colModel : dataGridColModel,
			height : $(window).height()-130,
			scrollOffset : 20, //设置垂直滚动条宽度
			altRows : true,
			userDataOnFooter : true,
			pagerpos : 'left',
			loadonce : true,
			viewrecords : true,
			styleUI : 'Bootstrap',
			viewrecords : true, //
			hasTabExport:false,
			hasColSet:false,
			multiselect : true,
			autowidth : true,
			responsive : true,
			multiboxonly : true,
			rowNum:10,
	        rowList:[200,100,50,20,10],
	        altRows:true,
	        userDataOnFooter : true,
	        pager: "#jqGridPager",
			onSelectRow : onSelectRow//js方法  
		});
		//回车查询
		$('#keyWord').on('keydown',function(e){
			if(e.keyCode == '13'){
				positionSeach();
		    }
		});
		$("#jqGrid").jqGrid('hideCol', 'cb');
	});
	
	function onSelectRow() {
		var type_id = $("#jqGrid").jqGrid('getGridParam','selarrrow');
		var rowData = $("#jqGrid").jqGrid('getRowData',type_id[0]);
		var choseType=$("#myTabContent .active",parent.document).children().attr("val");
		var pid=parent.pId;
		parent.sysDbEntity.reLoad(pid,choseType,type_id[0]);
	};  
	//关键字段查询
	function positionSeach() {
		var searchdata = {search_text: $('#keyWord').val()==$('#keyWord').attr("placeholder") ? "" :  $('#keyWord').val()};
		$('#jqGrid').jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
	};
</script>

</body>
</html>
