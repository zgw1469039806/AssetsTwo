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
<title>地点选择</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class=" easyui-layout" fit="true">
	<table id="jqGrid"></table>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<script>
	var selectModel = null;
	var ids = null;
	var idFiled = null;
	var textFiled = null;
    var setPropertys = null;
	//初始化表格参数
	function init(o) {
		selectModel = o.selectModel;
		ids = o.ids;
		idFiled = o.idFiled;
		textFiled =o.textFiled;
        setPropertys = o.setPropertys;

		var dataGridColModel = [
			  {label :'id', name : 'id', key : true, width : 75, hidden : true}
			, {label : '地点编码', name : 'code', width : 150 }
			, { label : '地点名称', name : 'name', width : 150 }
		];
		var mult;
		if (selectModel == "single") {
			mult = true;
		} else if (selectModel == "multi") {
			mult = false;
		}
		$('#jqGrid').jqGrid({
			url : 'console/profile/operation/sub/getSiteList',
			mtype : 'POST',
			datatype : "json",
			colModel : dataGridColModel,
			height : $(window).height() - 120,
			scrollOffset : 20, //设置垂直滚动条宽度
			altRows : true,
			userDataOnFooter : true,
			pagerpos : 'left',
			loadonce : true,
			viewrecords : true,
			styleUI : 'Bootstrap',
			viewrecords : true,
			multiboxonly : mult,
			multiselect : true,
			repeatitems:true,
			jsonReader : {
			 	root:"mapList"
			},
			autowidth : true,
			responsive : true,//开启自适应  
			onSelectRow : onSelectRow,//js方法  
			ondblClickRow : ondblClickRow,
			gridComplete : function() {
				if (ids) {
					var ida = ids.split(',');
					for ( var o = 0; o < ida.length; o++) {
						var id = ida[o];
						$(this).jqGrid("setSelection", id);
					}
				}
			}
		});
		//单选隐藏checkbox
		if (selectModel == "single") {
			$("#jqGrid").jqGrid('hideCol', 'cb');
		}

	};

	function ondblClickRow() {
		if (selectModel == "single") {
			var rowId = GetJqGridRowValue("#jqGrid", "id");
			var rowData = $("#jqGrid").jqGrid('getRowData', rowId);
			var site ={};
			site.siteId = rowData.id;
			site.siteName = rowData.name;
			setPropertys(site);
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			parent.layer.close(index);
		}
	}
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
	// 	单选
	function onSelectRow() {
		var rolelist = $("#jqGrid").jqGrid('getGridParam', 'selarrrow');
		if (selectModel == "single" && rolelist.length > 1) {
			layer.alert("单选，请选择一条数据!");
			$(this).trigger("reloadGrid");
			$(this).jqGrid("setSelection", rolelist[0]);
			return false;
		}
	};
	
	//回填数据
	function getDataList() {
		var siteids = "";
		var siteNames = ""
		var roleidlist = $("#jqGrid").jqGrid('getGridParam', 'selarrrow');
		for ( var i = 0; i < roleidlist.length; i++) {
			var id = roleidlist[i];
			var rowData = $("#jqGrid").jqGrid('getRowData', id);
			siteids = siteids + rowData.id + ",";
			siteNames = siteNames + rowData.name + ",";
		}
		siteids = siteids.substring(0, siteids.length - 1);
		siteNames = siteNames.substring(0, siteNames.length - 1);

		return {
			ids : siteids,
			Names : siteNames,
		};

	};
</script>

</body>
</html>
