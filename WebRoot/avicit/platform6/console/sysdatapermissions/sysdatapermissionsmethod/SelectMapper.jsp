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
			<input type="text" name="searchTable_keyWord"
				id="searchTable_keyWord" style="width: 240px;"
				class="form-control input-sm" placeholder="请输入Mapper名称"> <label
				id="searchTable_searchPart"
				class="icon icon-search form-tool-searchicon"></label>
		</div>
	</div>
	<table id="jqGridTable"></table>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
	function selectRow(){
		var selectRow = $("#jqGridTable").jqGrid('getGridParam','selarrrow');
		if(selectRow.length != 1){
			layer.msg("请选择一条记录");
			return false;
		}
		return $("#jqGridTable").jqGrid('getRowData', selectRow[0]);
	}

	var rows = new Array();
	$(document) .ready(function() {
			var dataGridColModel = [{
				label : 'mapperName',
				name : 'mapperName',
				key : true,
				hidden : true
			},{
				label : 'mapper名称',
				name : 'mapperName',
				width : 150,
				align : "center",
				sortable : false
			}];
	
			$('#jqGridTable').jqGrid({
				url : "platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/getAllMapperData",
				mtype : 'POST',
				datatype : "json",
				colModel : dataGridColModel,
				height : $(window).height() - 110,
				altRows : true,
				userDataOnFooter : true,
				pagerpos : 'left',
				styleUI : 'Bootstrap',
				viewrecords : true,
				multiselect : true,
				autowidth : true,
				shrinkToFit : true,
				responsive : true,
				loadComplete:function(){
	 				$("#jqgh_jqGridTable_mapperName").css("text-align","center");
	 			}
			});
			$("#searchTable_searchPart").bind('click', function() {
				var keyWord = $("#searchTable_keyWord").val();
				$('#jqGridTable').jqGrid('setGridParam', {
					datatype : 'json',
					postData : {
						'keyword' : keyWord
					}
				}).trigger("reloadGrid");
	
			});
			$("#searchTable_keyWord").bind('keyup',function(e) {
				if (e.keyCode == 13) {
					var keyWord = $("#searchTable_keyWord").val();
					$('#jqGridTable').jqGrid(
							'setGridParam', {
								datatype : 'json',
								postData : {
									'keyword' : keyWord
								}
							}).trigger("reloadGrid");
				}
			});

		}
	);
</script>
</html>