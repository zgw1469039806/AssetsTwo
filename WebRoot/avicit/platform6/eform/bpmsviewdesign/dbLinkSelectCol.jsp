<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
	String dbid = request.getParameter("dbid");
%>
<!DOCTYPE html>
<html>
<head>
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css-fixie8-fonticon.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
		<table id="sysLookupType"></table>
		<div id="sysLookupTypePager"></div>
	</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
var rowObjData;
var lookup_validFlag = {1:"有效",0:"无效"};
var colnames;
var callBack;
var idFiled;
var textFiled;
var dbid = "<%=dbid%>";
function init(o){
	colnames = o.colnames;
};


function getSelectRowData(){
	var rowDatas = [];
	var ids = $("#sysLookupType").jqGrid('getGridParam', 'selarrrow');
	for (var i=0;i<ids.length;i++){
		var rowData = $("#sysLookupType").jqGrid('getRowData', ids[i]);
		rowDatas.push(rowData);
	}

	return rowDatas;
}
$(document).ready(
	function() {
		var searchMainNames = new Array();
		var searchMainTips = new Array();
		searchMainNames.push("lookupType");
		searchMainTips.push("代码类型");
		searchMainNames.push("lookupTypeName");
		searchMainTips.push("代码名称");
		$('#sysLookupType_keyWord').attr('placeholder',
				'请输入' + searchMainTips[0] + '或' + searchMainTips[1]);

		var sysLookupTypeGridColModel = [ {
			label : 'id',
			name : 'id',
			key : true,
			width : 75,
			hidden : true
		}, {
			label : '表外键',
			name : 'tableId',
			width : 150,
			hidden : true
		}, {
			label : '列英文名称',
			name : 'colName',
			width : 150
		},{
			label : '列中文名称',
			name : 'colComments',
			width : 150
		}, {
			label : '列类型',
			name : 'colType',
			width : 150,
			edittype : "select",
			editoptions : {
				value : {"VARCHAR2":"VARCHAR2","DATE":"DATE","NUMBER":"NUMBER","BLOB":"BLOB","CLOB":"CLOB"}
			}
		}, {
			label : '列长度',
			name : 'colLength',
			width : 150,
			align: "right"
		},  {
			label : '列小数位',
			name : 'attribute02',
			width : 150,
			align: "right"
		}];
		var param = {tableId:dbid};
		$('#sysLookupType').jqGrid({
			url :'platform6/db/dbtablecol/dbTableColController/operation/getDbTableColsByPage.json',
			mtype : 'POST',
			datatype : "json",
			postData : param,
			colModel : sysLookupTypeGridColModel,//表格列的属性
			height : $(window).height() - 50,//初始化表格高度
			scrollOffset : 20, //设置垂直滚动条宽度
			rowNum : 1000,//每页条数
			rowList : [ 200, 100, 50, 30, 20, 10 ],//每页条数可选列表
			altRows : true,//斑马线
			pagerpos : 'left',//分页栏位置
			styleUI : 'Bootstrap', //Bootstrap风格
			viewrecords : true, //是否要显示总记录数
			multiselect : true,//可多选
			autowidth : true,//列宽度自适应
			hasTabExport:false,
			hasColSet:false,
			cellEdit : false,
			cellsubmit : 'clientArray',
			loadComplete : function() {
				var rowIds = jQuery("#sysLookupType").jqGrid('getDataIDs');
				for(var k=0; k<rowIds.length; k++) {
					var curRowData =  jQuery("#sysLookupType").jqGrid('getRowData', rowIds[k]);
					if (colnames != null && colnames!=undefined && colnames!="") {
						var names = colnames.split(",");
						for (i = 0; i < names.length; i++) {
							var name = names[i];
							if (curRowData.colName == name) {
								jQuery("#sysLookupType").setSelection(rowIds[k], false);
							}
						}
					}
				}
			}
		});
		$('#sysLookupType_keyWord').on('keydown', function(e) {
			if (e.keyCode == '13') {
				searchData();
			}
		});
		//关键字段查询按钮绑定事件
		$('#sysLookupType_searchPart').bind('click', function() {
			searchData();
		});
		
		function searchData(){
			var keyWord = $('#sysLookupType_keyWord').val()==$('#sysLookupType_keyWord').attr("placeholder") ? "" :  $('#sysLookupType_keyWord').val();
			var param = {};
			for ( var i in searchMainNames) {
				var name = searchMainNames[i];
				param[name] = keyWord;
			}
			var searchdata = {
				keyWord : JSON.stringify(param),
				param : null
			}
			$('#sysLookupType').jqGrid('setGridParam', {
				datatype : 'json',
				postData : searchdata
			}).trigger("reloadGrid");
		}
});
</script>
</html>