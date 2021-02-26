<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<html>
<head>
<title>选择组织</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script>
	var baseurl = '<%=request.getContextPath()%>';
	var orgDatajson = ${orgDatajson};
	var historyData = ${historyData};
	var singleSelect = '${singleSelect}';

	/*if (!isNaN(singleSelect)){
	 singleSelect=false;
	 }*/
	if(singleSelect == 'true') {
		singleSelect = true;
	}
	else if(singleSelect == 'false') {
		singleSelect = false;
	}
	else if(singleSelect == '-1') {
		singleSelect = false;
	}
	else {
		if(singleSelect == '1') {
			singleSelect = true;
		}
		else {
			singleSelect = false;
		}
	}

	var multipleOrg = '${multipleOrg}';
	$(function() {
		var dataGridHeight = $(".easyui-layout").height();
		$("#orgTree_org").css("height", dataGridHeight - 40);
		loadSelectedTable(dataGridHeight);
		$("#ButtonDiv").css("height", dataGridHeight - 5);
		$("#ButtonDiv").css("padding-top", dataGridHeight / 2 - 30);
		if (typeof (historyData) == 'undefined') {
			historyData = {
				total : 0,
				rows : new Array()
			};
		}
		loadSelectGridDatas(historyData);
		loadOrgTree();
	});
	/**
	 * 加载组织树
	 */
	function loadOrgTree() {
		var orgData = eval(orgDatajson);
		$('#orgTree_org').tree({
			checkbox : true,
			lines : true,
			method : 'post',
			data : orgData,
			onCheck : function(node, checked) {
				var currNodeName = removeNodeNameParent(node.text);
				var selectionData = {
					"orgId" : node.id,
					"orgName" : currNodeName
				};
				if (checked) {
					var rowIndex_ = getDataGridRowIndex(node.id);
					if (rowIndex_ == -1) {
						$('#selectOrgTargetDataGrid').datagrid('appendRow', selectionData);
					}
					var rowIndex = getDataGridRowIndex(node.id);
					$('#selectOrgTargetDataGrid').datagrid('checkRow', rowIndex);
				} else {
					var rowIndex = getDataGridRowIndex(node.id);
					if (rowIndex != -1) {
						$('#selectOrgTargetDataGrid').datagrid('deleteRow', rowIndex);
					}
				}
			},
			onBeforeCheck:function(node, checked){
				if(singleSelect == true && checked == true) {
					var nodes = $('#orgTree_org').tree('getChecked');
					for(var i = 0; i < nodes.length; i++){
						$('#orgTree_org').tree('uncheck',nodes[i].target);
					}

					removeAllOrgClick();
				}
			}
		});
	}
	/**
	 * 初始化datagrid
	 */
	function loadSelectedTable(dataGridHeight) {
		$('#selectOrgTargetDataGrid').datagrid({
			fitColumns : true,
			remoteSort : false,
			nowrap : false,
			idField : 'orgId',
			loadMsg : "数据加载中.....",
			singleSelect : false,
			rownumbers : true,
			height : dataGridHeight,
			autoRowHeight : false,
			striped : true,
			collapsible : true,
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true
			} ] ],
			checkOnSelect : true,
			selectOnCheck : true,
			onCheck : function(rowIndex, rowData) {
			},
			columns : [ [ {
				field : 'orgId',
				title : '组织ID',
				width : 120,
				align : 'center',
				hidden : true
			}, {
				field : 'orgName',
				title : '组织名称',
				width : 150,
				align : 'center'
			} ] ],
			onLoadSuccess : function(data) {
				if (data.rows.length > 0) {
					$('#selectOrgTargetDataGrid').datagrid("checkAll");
				}
			},
			onDblClickRow : function(rowIndex, rowData) {
				$('#selectOrgTargetDataGrid').datagrid('deleteRow', rowIndex);
				var nodes = $('#orgTree_org').tree('getChecked');
				if (null != nodes && typeof (nodes) != 'undefined' && nodes.length > 0) {
					for (var j = 0; j < nodes.length; j++) {
						if (nodes[j].id == rowData.deptId) {
							$('#orgTree_org').tree('uncheck', nodes[j].target);
							break;
						}
					}
				}
			}
		});
	}
	/**
	 * 打开页面时将已选择的数据带回datagrid显示
	 */
	function loadSelectGridDatas(datas) {
		$('#selectOrgTargetDataGrid').datagrid('loadData', datas);
	}
	//展开树
	function expand() {
		var node = $('#orgTree_org').tree('getSelected');
		if (node) {
			$('#orgTree_org').tree('expand', node.target);
		} else {
			$('#orgTree_org').tree('expandAll');
		}
	}

	/**
	 * 移除所有选中的部门（包含datagrid和tree）
	 */
	function removeAllSelectedOrgClick() {
		removeGridAllSelectedData();
		var nodes = $('#orgTree_org').tree('getChecked');
		for (var i = 0; i < nodes.length; i++) {
			if (getRecordIndexInTargetDataGrid(nodes[i].id) == -1) {
				$('#orgTree_org').tree('uncheck', nodes[i].target);
			}
		}
	}

	/**
	 * 移除全部部门
	 */
	function removeAllOrgClick() {
		$('#selectOrgTargetDataGrid').datagrid('clearChecked');
		$('#selectOrgTargetDataGrid').datagrid('loadData', []);
		var nodes = $('#orgTree_org').tree('getChecked');
		for (var j = 0; j < nodes.length; j++) {
			$('#orgTree_org').tree('uncheck', nodes[j].target);
		}
	}
	/**
	 * 移除dataGrid所有选择的数据
	 */
	function removeGridAllSelectedData() {
		var dataGridData = $('#selectOrgTargetDataGrid').datagrid('getChecked');
		var checkDataSize = dataGridData.length;
		if (checkDataSize > 0) {
			$('#selectOrgTargetDataGrid').datagrid('deleteRow', getRecordIndexInTargetDataGrid(dataGridData[0].orgId));
			var currDataGridData = $('#selectOrgTargetDataGrid').datagrid('getChecked');
			if (currDataGridData.length >= 1) {
				removeGridAllSelectedData();
			}
		}
	}
	/**
	 根据idField的值取得该行数据在datagrid中的rowIndex
	 **/
	function getRecordIndexInTargetDataGrid(userId) {
		return getDataGridRowIndex(userId);
	}
	/**
	 * 根据idField的值取得该行数据在datagrid中的rowIndex
	 */
	function getDataGridRowIndex(rowData) {
		return $('#selectOrgTargetDataGrid').datagrid('getRowIndex', rowData);
	}
	/**
	 * 取得datagrid中已选择全部数据
	 */
	function getSelectedResultDataJson() {
		return $('#selectOrgTargetDataGrid').datagrid('getChecked');
	}
	/**
	 * 取得datagrid中全部数据
	 */
	function getAllResultDataJson() {
		return $('#selectOrgTargetDataGrid').datagrid('getData').rows;
	}
</script>
</style>
</head>
<body class="easyui-layout" fit="true">
	<div region="west" style="width:250px;overflow: hidden;float:left;">
		<ul id="orgTree_org" style="width:auto;overflow: auto;"></ul>
	</div>
	<div region="center" border="false" id="ButtonDiv" style="width:150px;overflow: hidden;float:left;">
		<table border="0" align="center">
			<tr>
				<td>
					<input type="button" value="<<移除" style="cursor:pointer;width:65px;" onclick="removeAllSelectedOrgClick();" />
					<br /> 
					<br /> 
					<input type="button" value="<<清空" style="cursor:pointer;width:65px;" onclick="removeAllOrgClick();" />
					<br />
				</td>
			</tr>
		</table>
	</div>
	<div region="east" border="false" style="overflow: hidden;float:right;width:250px;">
		<div id="selectOrgTargetDataGrid"></div>
	</div>
</body>
</html>
