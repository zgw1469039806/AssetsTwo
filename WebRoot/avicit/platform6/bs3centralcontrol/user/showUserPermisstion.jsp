<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
	String userId = (String) request.getParameter("userId");
%>
<!DOCTYPE html>
<html>
<head>
<title>查看个人权限</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
	
</script>
</head>
<body>



	<table id="jqGrid"></table>
</body>

<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bs3centralcontrol/user/js/consoleUser.js"
	type="text/javascript"></script>
<script type="text/javascript">


	$(document)
			.ready(
					function() {

						var dataGridColModel = [
								{
									label : 'id',
									name : 'id',
									index : 'id',
									key : true,
									width : 75,
									hidden : true
								},
								{
									label : '一级菜单',
									name : 'name',
									index : 'name',
									width : 100,
									align : 'center',
									cellattr : function(rowId, tv, rawObject,
											cm, rdata) {

										//合并单元格

										return 'id=\'name' + rowId + "\'";

									}
								},
								{
									label : '二级菜单',
									name : 'sencondName',
									index : 'sencondName',
									width : 200,
									align : 'center',
									cellattr : function(rowId, tv, rawObject,
											cm, rdata) {

										//合并单元格

										return 'id=\'sencondName' + rowId
												+ "\'";

									}
								},
								{
									label : '三级菜单',
									name : 'thirdName',
									index : 'thirdName',
									width : 200,
									align : 'center',
									cellattr : function(rowId, tv, rawObject,
											cm, rdata) {

										//合并单元格

										return 'id=\'thirdName' + rowId + "\'";

									}
								},
								{
									label : '四级菜单',
									name : 'fourthName',
									index : 'fourthName',
									width : 200,
									align : 'center',
									cellattr : function(rowId, tv, rawObject,
											cm, rdata) {

										//合并单元格

										return 'id=\'fourthName' + rowId + "\'";

									}
								}

						];

						$('#jqGrid')
								.jqGrid(
										{
											url : 'platform/ccShowPermissController/newfindUserResources.json?userId=' + '<%=userId%>',
											mtype : 'POST',
											datatype : "json",
											colModel : dataGridColModel,
											height : document.documentElement.clientHeight - 100,
											rowNum : -1,
											altRows : true,
											pagerpos : 'left',
											styleUI : 'Bootstrap',
											viewrecords : true, //
											autowidth : true,
											hasColSet : false,
											hasTabExport : false,
											responsive : true,
											gridComplete : function() {

												var gridName = "jqGrid";
												Merger(gridName, 'name');
												Merger(gridName, 'sencondName');
												Merger(gridName, 'thirdName');

											}

										});

						function Merger(gridName, CellName) {
							var gridL = $("#" + gridName + "").getDataIDs();
							var length = gridL.length;
							for (var i = 0; i < length; i++) {
								var before = $("#" + gridName + "").jqGrid(
										'getRowData', gridL[i]);
								var rowSpanTaxCount = 1;
								for (j = i + 1; j <= length; j++) {
									var end = $("#" + gridName + "").jqGrid(
											'getRowData', gridL[j]);
									if (before[CellName] == end[CellName]) {
										rowSpanTaxCount++;
										$("#" + gridName + "").setCell(
												gridL[j], CellName, '', {
													display : 'none'
												});
									} else {
										rowSpanTaxCount = 1;
										break;
									}
									$("#" + CellName + "" + gridL[i] + "")
											.attr("rowspan", rowSpanTaxCount);
								}
							}
						}

					});
</script>
</html>