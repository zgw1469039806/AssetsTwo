<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
String importlibs = "common,table,form";
%>
<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>选择电子表单视图编码</title>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body>
	<div class="toolbar-left">
		<div class="input-group form-tool-search">
			<input type="text" name="keyWord" id="keyWord" style="width: 240px;" class="form-control input-sm" placeholder="请输入视图编码或视图名称" />
			<label id="searchTable_searchPart" class="icon icon-search form-tool-searchicon"></label>
		</div>
	</div>
	<table id="eformViewCodeJqGrid"></table>
	<div id="jqGridPager"></div>
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
	function selectRow(){
		var selectRow = $("#eformViewCodeJqGrid").jqGrid('getGridParam','selarrrow');
		if(selectRow.length != 1){
			layer.msg("请选择一条记录");
			return false;
		}
		return $("#eformViewCodeJqGrid").jqGrid('getRowData', selectRow[0]);
	}
	
	$(document) .ready(function() {
		var dataGridColModel = [{
			label : 'id',
			name : 'id',
			key : true,
			width : 75,
			hidden : true
		}, {
			label : '视图编码',
			name : 'VIEW_CODE',
			width : 150,
			align : "center",
			sortable : false
		}, {
			label : '视图名称',
			name : 'VIEW_NAME',
			width : 150,
			align : "center",
			sortable : false
		}, {
			label : '视图描述',
			name : 'VIEW_DESC',
			width : 150,
			align : "center",
			sortable : false
		}];
	
		$('#eformViewCodeJqGrid').jqGrid({
			url : "platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/selectEformViewCodeByPage",
			mtype : 'POST',
			datatype : "json",
			colModel : dataGridColModel,
			height : $(window).height() - 100,
			scrollOffset : 20,
			altRows : true,
			styleUI : 'Bootstrap',
			viewrecords : true,
			hasColSet : false,
			pagerpos:'left',
			rowNum: 10,
			rowList:[30,20,10],
			userDataOnFooter : true,
			multiselect : true,
			autowidth : true,
			shrinkToFit : true,
			responsive : true,
			pager: "#jqGridPager"
		});
		//$(_self._jqgridToolbar).append($("#tableToolbar"));
		$("#searchTable_searchPart").bind('click', function() {
			var keyWord = $("#keyWord").val();
			if (keyWord=="请输入表名"){
				keyWord='';
			}
			$('#eformViewCodeJqGrid').jqGrid('setGridParam', {
				datatype : 'json',
				postData : {
					'keyword' : keyWord
				}
			}).trigger("reloadGrid");
	
		});
		$("#keyWord").bind('keyup',function(e) {
			if (e.keyCode == 13) {
				var keyWord = $("#keyWord").val();
				$('#eformViewCodeJqGrid').jqGrid('setGridParam', {
					datatype : 'json',
					postData : {
						'keyword' : keyWord
					}
				}).trigger("reloadGrid");
			}
		});
	});
</script>

</html>