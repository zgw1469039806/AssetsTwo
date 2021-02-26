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
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div class="toolbar-left">
		<div class="input-group form-tool-search">
			<input type="text" name="searchTable_keyWord"
				id="searchTable_keyWord" style="width: 240px;"
				class="form-control input-sm" placeholder="请输入英文表名"> <label
				id="searchTable_searchPart"
				class="icon icon-search form-tool-searchicon"></label>
		</div>

	</div>
	<table id="testCurrencyjqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
	var callbcak = null;
	function init(o){
		callbcak = o.callbcak;
	}

	var rows = new Array();
	$(document) .ready(
		function() {
			var dataGridColModel = [{
				label : 'id',
				name : 'id',
				key : true,
				width : 75,
				hidden : true
			}, {
				label : '英文表名',
				name : 'TABLE_NAME',
				width : 150,
				align : "center"
			}, {
				label : '表名称',
				name : 'COMMENTS',
				width : 150,
				align : "center"
			}];
	
			$('#testCurrencyjqGrid').jqGrid({
				url : "platform6/msystem/imp/sysimptemplate/sysImpTemplateController/operation/getTableDatasBypage",
				mtype : 'POST',
				datatype : "json",
				colModel : dataGridColModel,
				height : $(window).height() - 110,
				rowNum : 10,
				rowList : [ 200, 100, 50, 30, 20, 10 ],
				altRows : true,
				userDataOnFooter : true,
				pagerpos : 'left',
				styleUI : 'Bootstrap',
				viewrecords : true,
				multiselect : false,
				rownumbers : true,
				hasTabExport:false,
				hasColSet:false,
				autowidth : true,
				shrinkToFit : true,
				ondblClickRow:function(rowid,iRow,iCol,e){
					var data = $('#testCurrencyjqGrid').jqGrid("getRowData", rowid);
					if(typeof(callbcak) == 'function'){
						callbcak(data);
					}
				},
				responsive : true,//开启自适应
				pager : "#jqGridPager"
			});
			$("#searchTable_searchPart").bind('click', function() {
				var keyWord = $("#searchTable_keyWord").val();

                if(keyWord=="请输入英文表名"){
                    keyWord='';
                }
				$('#testCurrencyjqGrid').jqGrid('setGridParam', {
					datatype : 'json',
					postData : {
						'keyword' : keyWord
					}
				}).trigger("reloadGrid");
	
			});
			$("#searchTable_keyWord").bind('keyup',function(e) {
				if (e.keyCode == 13) {
					var keyWord = $("#searchTable_keyWord").val();
					$('#testCurrencyjqGrid').jqGrid(
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