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
					class="form-control input-sm" placeholder="请输入角色名称查询"> <label
					id="Role_searchPart" onclick="roleSeach()" class="icon icon-search form-tool-searchicon"></label>
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
	$(document).ready( function() {
		var dataGridColModel = [ {
			label : 'id',
			name : 'id',
			key : true,
			width : 75,
			hidden : true
		}, {
			label : 'roleType',
			name : 'roleType',
			width : 75,
			hidden : true
		}, {
			label : '角色名称',
			name : 'roleName',
			width : 150
		}, {
			label : '角色编码',
			name : 'roleCode',
			hidden : true,
			width : 150
		}, {
			label : '角色描述',
			name : 'desc',
			width : 150
		} ];
		
		$('#jqGrid') .jqGrid( {
			url : 'h5/view/common/select/SelectController/getInitRoleInfo',
			mtype : 'POST',
			datatype : "json",
			postData : {viewScope : 'currentOrg'},
			colModel : dataGridColModel,
			height : $(window).height()-130 ,
			scrollOffset : 20, //设置垂直滚动条宽度
			altRows : true,
			userDataOnFooter : true,
			pagerpos : 'left',
			loadonce : false,
			viewrecords : true,
			styleUI : 'Bootstrap',
			viewrecords : true, //
			multiselect : true,
			hasTabExport:false,
			hasColSet:false,
			autowidth : true,
			responsive : true,
			multiboxonly : true,
			rowNum : 10,
			rowList : [ 200, 100, 50, 20, 10],
			pagerpos : 'left',
			pager: "#jqGridPager",
			onSelectRow : onSelectRow//js方法  
		});
		//回车查询
		$('#keyWord').on('keydown',function(e){
			if(e.keyCode == '13'){
					roleSeach();
			}
	    });
	    $("#jqGrid").jqGrid('hideCol', 'cb');
	});
	//单选
	function onSelectRow() {
		var type_id = $("#jqGrid").jqGrid('getGridParam','selarrrow');
		var rowData = $("#jqGrid").jqGrid('getRowData',type_id);
		var choseType=$("#myTabContent .active",parent.document).children().attr("val");
		var pid=parent.pId;
		parent.sysDbEntity.reLoad(pid,choseType,type_id[0]);
		
	}
    //关键字段查询
	function roleSeach() {
		var searchdata = {search_text: $('#keyWord').val()==$('#keyWord').attr("placeholder") ? "" :  $('#keyWord').val()};
		$('#jqGrid').jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
	}
	
	
	
	
	

	
</script>

</body>
</html>
