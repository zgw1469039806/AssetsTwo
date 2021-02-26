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
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
</head>
<body class=" easyui-layout" fit="true">
	<table id="jqGrid"></table>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<script>
var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
var id = decodeURIComponent(flowUtils.getUrlQuery("id"));

var parentObj = parent.$("#"+id).data("data-object");
var option = parentObj.option;
var dataVal = parent.$("#"+id).val();
	$(function() {
		var url = "platform/bpm/bpmdesigner/bpmWebDesigner/getZWMBList";
		if (option.type == "redTemplate") {
			url = "platform/bpm/bpmdesigner/bpmWebDesigner/getTHMBList";
		}
		var dataGridColModel = [ {
			label : 'id',
			name : 'id',
			key : true,
			width : 75,
			hidden : true
		}, {
			label : '模板名称',
			name : 'templetName',
			width : 150
		}, {
			label : '模板版本',
			name : 'version',
			width : 150
		} ];
		
		var jq = $('#jqGrid').jqGrid({
			url : url,
			mtype : 'POST',
			datatype : "json",
			colModel : dataGridColModel,
			height : $(window).height() - 120,
			scrollOffset : 20, //设置垂直滚动条宽度
			altRows : true,
			userDataOnFooter : true,
			loadonce : true,
			viewrecords : true,
			styleUI : 'Bootstrap',
			viewrecords : true,
			autowidth : true,
			responsive : true,//开启自适应  
			multiboxonly : false,
			multiselect : true,
			onSelectAll : true,
			onSelectRow : onSelectRow,//js方法  
			ondblClickRow : ondblClickRow, //双击事件
			gridComplete : function() {
				 if (dataVal) {
					var pos = dataVal.split(';');
					for ( var o = 0; o < pos.length; o++) {
						var id = pos[o];
						$(this).jqGrid("setSelection", id);
					}
				}
			}
		});
		parentObj.jqGrid = jq;
	});
	
	
	//验证单选
	function onSelectRow() {
			/* var positionidlist = $("#jqGrid").jqGrid('getGridParam',
					'selarrrow');
			if (selectModel == "single" && positionidlist.length > 1) {
				$(this).trigger("reloadGrid");
				$(this).jqGrid("setSelection", positionidlist[0]);
				layer.alert("单选，请选择一条数据!");
				return false;
		
		} */
	}
	function ondblClickRow() {
		/* if (selectModel == "single") {
		var rowId = GetJqGridRowValue("#jqGrid", "id");
		var rowData = $("#jqGrid").jqGrid('getRowData', rowId);
		parent.$("#" + prositionid).attr("value", rowData.id);
		parent.$("#" + prositionName).attr("value", rowData.positionName);
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		parent.layer.close(index); 
	}*/}
	//双击
	function GetJqGridRowValue(jgrid, code) {
		var KeyValue = "";
		var selectedRowIds = $(jgrid).jqGrid("getGridParam", "selarrrow");
		if (selectedRowIds != "") {
			var len = selectedRowIds.length;
			for ( var i = 0; i < len; i++) {
				var rowData = $(jgrid).jqGrid('getRowData', selectedRowIds[i]);
				KeyValue += rowData[code] + ",";
			}
			KeyValue = KeyValue.substr(0, KeyValue.length - 1);
		} else {
			var rowData = $(jgrid).jqGrid('getRowData',
					$(jgrid).jqGrid('getGridParam', 'selrow'));
			KeyValue = rowData[code];
		}
		return KeyValue;
	}
	
</script>
</body>
</html>
