<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>请选择数据表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div class="toolbar-left">
		<div class="input-group form-tool-search">
			<input type="text" name="searchTable_keyWord" id="searchTable_keyWord" style="width: 240px;" class="form-control input-sm" placeholder="请输入表名" />
			<label id="searchTable_searchPart" class="icon icon-search form-tool-searchicon"></label>
		</div>
	</div>
	<table id="tableNameJqGrid"></table>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
	function selectRow(){
		var selectRow = $("#tableNameJqGrid").jqGrid('getGridParam','selarrrow');
		if(selectRow.length != 1){
			layer.msg("请选择一条记录");
			return false;
		}
		return $("#tableNameJqGrid").jqGrid('getRowData', selectRow[0]);
	}

	$(document) .ready(function() {
		var dataGridColModel = [{
			label : 'id',
			name : 'id',
			key : true,
			width : 75,
			hidden : true
		}, {
			label : '表名称',
			name : 'tableName',
			width : 150,
			align : "center",
			sortable : false
		}, {
			label : '表描述',
			name : 'tableComment',
			width : 150,
			align : "center",
			sortable : false
		}];

		$('#tableNameJqGrid').jqGrid({
			url : "platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/operation/getTableDatasBypage2",
			mtype : 'POST',
			datatype : "json",
			colModel : dataGridColModel,
			height : $(window).height() - 110 - 20,
			scrollOffset : 20, //设置垂直滚动条宽度
			altRows : true,
			styleUI : 'Bootstrap',
			viewrecords : true,
			rowNum: 'all',//每页条数
			userDataOnFooter : true,
			multiselect : true,
			autowidth : true,
			shrinkToFit : true,
			responsive : true//开启自适应
		});
		$("#searchTable_searchPart").bind('click', function() {
			var keyWord = $("#searchTable_keyWord").val();

               if(keyWord=="请输入表名"){
                   keyWord='';
               }
			$('#tableNameJqGrid').jqGrid('setGridParam', {
				datatype : 'json',
				postData : {
					'tableName' : keyWord
				}
			}).trigger("reloadGrid");

		});
		$("#searchTable_keyWord").bind('keyup',function(e) {
			if (e.keyCode == 13) {
				var keyWord = $("#searchTable_keyWord").val();
				$('#tableNameJqGrid').jqGrid('setGridParam', {
					datatype : 'json',
					postData : {
						'tableName' : keyWord
					}
				}).trigger("reloadGrid");
			}
		});
	});
</script>
</html>