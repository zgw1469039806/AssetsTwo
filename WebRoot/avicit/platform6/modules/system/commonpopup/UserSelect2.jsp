<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<title>选择人员</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div region="west" style="width: 350px">
		<div class="easyui-tabs">
			
			<c:if test="${deptTab == true }">
				<div title="部门" id="deptTab" data-options="closable:false" style="padding:10px;width:auto;">
					<div id="toolbar" class="datagrid-toolbar">
						<input class="userQueryText" id="dept_query"></input>
					</div>
					<ul class="userTree" style="width:auto;overflow:auto;"></ul>
				</div>
			</c:if>
			
			<c:if test="${roleTab == true }">
				<div title="角色" id="roleTab" data-options="closable:false" style="padding:10px;width:auto;">
					<div id="toolbar" class="datagrid-toolbar">
						<input class="userQueryText" id="role_query"></input>
					</div>
					<ul class="userTree" style="width:auto;overflow:auto;"></ul>
				</div>
			</c:if>
			
			<c:if test="${positionTab == true }">
				<div title="岗位" id="positionTab" data-options="closable:false" style="padding:10px;width:auto;">
					<div id="toolbar" class="datagrid-toolbar">
						<input class="userQueryText" id="position_query"></input>
					</div>
					<ul class="userTree" style="width:auto;overflow:auto;"></ul>
				</div>
			</c:if>
			
			<c:if test="${groupTab == true }">
				<div title="系统群组" id="groupTab" data-options="closable:false" style="padding:10px;width:auto;">
					<div id="toolbar" class="datagrid-toolbar">
						<input class="userQueryText" id="group_query"></input>
					</div>
					<ul class="userTree" style="width:auto;overflow:auto;"></ul>
				</div>
			</c:if>
			
			<c:if test="${groupPersonTab == true }">
				<div title="个人群组" id="groupPersonTab" data-options="closable:false" style="padding:10px;width:auto;">
					<div id="toolbar" class="datagrid-toolbar">
						<input class="userQueryText" id="groupPerson_query"></input>
					</div>
					<ul class="userTree" style="width:auto;overflow:auto;"></ul>
				</div>
			</c:if>
		</div>
	</div>

	<div region="center" border="false" style="overflow:hidden;float:left;" id="ButtonDiv">
		<table border="0" align="center">
			<tr>
				<td><input type="button" value="<<移除" style="cursor:pointer;width:65px;" onclick="removeAllSelectedUsersClick();" /><br /> <br /> <input type="button" value="<<清空" style="cursor:pointer;width:65px;" onclick="removeAllUserClick();" /><br /></td>
			</tr>
		</table>
	</div>
	<div region="east" border="false" style="overflow:hidden;float:right;width:320px;">
		<div id="selectUserTargetDataGrid"></div>
	</div>
	<script>
		var baseurl = '<%=request.getContextPath()%>';
		var orgDatajson = ${orgDatajson};
		var historyData = ${historyData};
		var singleSelect = ${singleSelect};
		var multipleOrg = '${multipleOrg}';
		var extParameter = '${extParameter}';
		var displaySubDeptUser = '${displaySubDeptUser}';
		var functionAction = true;
		
		if (singleSelect == 'true') {
			singleSelect = true;
		} else if (singleSelect == 'false') {
			singleSelect = false;
		} else if (singleSelect == '-1') {
			singleSelect = false;
		} else {
			if (singleSelect == '1') {
				singleSelect = true;
			} else {
				singleSelect = false;
			}
		}
		
		var role_url = "platform/commonSelection/SelectionUser2Controller/r?multipleOrg=" + multipleOrg +"&extParameter=" + encodeURI(extParameter);
		var position_url = "platform/commonSelection/SelectionUser2Controller/p?multipleOrg=" + multipleOrg +"&extParameter=" + encodeURI(extParameter);
		var group_url = "platform/commonSelection/SelectionUser2Controller/g?multipleOrg=" + multipleOrg +"&extParameter=" + encodeURI(extParameter);
		var groupPerson_url = "platform/commonSelection/SelectionUser2Controller/gp?multipleOrg=" + multipleOrg +"&extParameter=" + encodeURI(extParameter);

		$(function() {
			$('.userQueryText').searchbox({
				width : 240,
				searcher: function (value){
					query(value, this.id);
				},
				prompt : "请输入查询内容"
			});
			<c:if test="${deptTab == true }">
				loadOrgTree($('#deptTab .userTree'), orgDatajson);
			</c:if>
			<c:if test="${roleTab == true }">
				loadOrgTreeOther($('#roleTab .userTree'), role_url, "role");
			</c:if>
			<c:if test="${positionTab == true }">
				loadOrgTreeOther($('#positionTab .userTree'), position_url, "position");
			</c:if>
			<c:if test="${groupTab == true }">
				loadOrgTreeOther($('#groupTab .userTree'), group_url, "group");
			</c:if>
			<c:if test="${groupPersonTab == true }">
				loadOrgTreeOther($('#groupPersonTab .userTree'), groupPerson_url, "groupPerson");
			</c:if>
			
			var dataGridHeight = $(".easyui-layout").height();
			$(".userTree").css("height", dataGridHeight - 82);
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
		});
		
		/**
		 * 初始化datagrid
		 */
		function loadSelectedTable(dataGridHeight) {
			$('#selectUserTargetDataGrid').datagrid({
				fitColumns : true,
				remoteSort : false,
				nowrap : false,
				idField : 'userId',
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
				columns : [ [ {
					field : 'userId',
					title : '用户ID',
					width : 120,
					align : 'center',
					hidden : true
				}, {
					field : 'userNo',
					title : '用户编号',
					width : 120,
					align : 'center',
					hidden : true
				}, {
					field : 'userName',
					title : '用户名',
					width : 150,
					align : 'center'
				}, {
					field : 'deptId',
					title : '部门ID',
					width : 120,
					align : 'center',
					hidden : true
				}, {
					field : 'deptName',
					title : '部门',
					width : 150,
					align : 'center'
				} ] ],
				onLoadSuccess : function(data) {
					if (data.rows.length > 0) {
						$('#selectUserTargetDataGrid').datagrid("checkAll");
					}
				},
				onDblClickRow : function(rowIndex, rowData) {
					$('#selectUserTargetDataGrid').datagrid('deleteRow', rowIndex);
					
					<c:if test="${deptTab == true }">
						removeTreeCheck($('#deptTab .userTree'), rowData.userId);
					</c:if>
					<c:if test="${roleTab == true }">
						removeTreeCheck($('#roleTab .userTree'), rowData.userId);
					</c:if>
					<c:if test="${positionTab == true }">
						removeTreeCheck($('#positionTab .userTree'), rowData.userId);
					</c:if>
					<c:if test="${groupTab == true }">
						removeTreeCheck($('#groupTab .userTree'), rowData.userId);
					</c:if>
					<c:if test="${groupPersonTab == true }">
						removeTreeCheck($('#groupPersonTab .userTree'), rowData.userId);
					</c:if>
				}
			});
		}
		
		function removeTreeCheck($tree, userId){
			var nodes = $tree.tree('getChecked');
			if(null != nodes && typeof(nodes)!='undefined' && nodes.length>0){
				for(var j = 0; j< nodes.length; j++){
					if(nodes[j].id==userId){
						$tree.tree('uncheck',nodes[j].target); 
						break ;
					}
				}
			}
		}
		
		/**
		 * 打开页面时将已选择的数据带回datagrid显示
		 */
		function loadSelectGridDatas(datas) {
			$('#selectUserTargetDataGrid').datagrid('loadData', datas);
		}
		
		/**
		 * 根据idField的值取得该行数据在datagrid中的rowIndex
		 */
		function getDataGridRowIndex(rowData) {
			return $('#selectUserTargetDataGrid').datagrid('getRowIndex', rowData);
		}
		
		/**
		 * 当用户点击部门节点时动态将部门人员及子部门人员自动添加至datagrid
		 */
		function displayAllUsers(data) {
			if (typeof (data) != 'undefined') {
				var users = data.allUsers;
				var checkBoxChecked = data.checked;
				if (checkBoxChecked == 'true') {
					$.each(users, function(x, user) {
						var insertIndex = getDataGridRowIndex(user.userId);
						if (insertIndex == -1) {
							$('#selectUserTargetDataGrid').datagrid('appendRow', user);
							$('#selectUserTargetDataGrid').datagrid('checkRow', getDataGridRowIndex(user.userId));
						}
					});
				} else if (checkBoxChecked == 'false') {
					$.each(users, function(y, user) {
						var deleteIndex = getDataGridRowIndex(user.userId);
						if (deleteIndex != -1) {
							$('#selectUserTargetDataGrid').datagrid('deleteRow', deleteIndex);
						}
					});
				}
			}
		}
		
		/**
		 * 移除全部用户
		 */
		function removeAllUserClick() {
			$('#selectUserTargetDataGrid').datagrid('clearChecked');
			$('#selectUserTargetDataGrid').datagrid('loadData', []);
			
			<c:if test="${deptTab == true }">
				removeAllUserClickTree($('#deptTab .userTree'));
			</c:if>
			<c:if test="${roleTab == true }">
				removeAllUserClickTree($('#roleTab .userTree'));
			</c:if>
			<c:if test="${positionTab == true }">
				removeAllUserClickTree($('#positionTab .userTree'));
			</c:if>
			<c:if test="${groupTab == true }">
				removeAllUserClickTree($('#groupTab .userTree'));
			</c:if>
			<c:if test="${groupPersonTab == true }">
				removeAllUserClickTree($('#groupPersonTab .userTree'));
			</c:if>
			
		}
		
		function removeAllUserClickTree($tree){
			var nodes = $tree.tree('getChecked');
			for (var j = 0; j < nodes.length; j++) {
				$tree.tree('uncheck', nodes[j].target);
			}
		}
		/**
		 * 移除全部选择的用户
		 */
		function removeAllSelectedUsersClick() {
			removeGridAllSelectedData();
			
			<c:if test="${deptTab == true }">
				removeAllSelectedUsersClickTree($('#deptTab .userTree'));
			</c:if>
			<c:if test="${roleTab == true }">
				removeAllSelectedUsersClickTree($('#roleTab .userTree'));
			</c:if>
			<c:if test="${positionTab == true }">
				removeAllSelectedUsersClickTree($('#positionTab .userTree'));
			</c:if>
			<c:if test="${groupTab == true }">
				removeAllSelectedUsersClickTree($('#groupTab .userTree'));
			</c:if>
			<c:if test="${groupPersonTab == true }">
				removeAllSelectedUsersClickTree($('#groupPersonTab .userTree'));
			</c:if>
			
		}
		
		function removeAllSelectedUsersClickTree($tree){
			var nodes = $tree.tree('getChecked');
			for (var i = 0; i < nodes.length; i++) {
				if (getRecordIndexInTargetDataGrid(nodes[i].id) == -1 && nodes[i].iconCls == "icon-user") {
					$tree.tree('uncheck', nodes[i].target);
				}
			}
		}
		
		/**
		 * 移除dataGrid所有选择的数据
		 */
		function removeGridAllSelectedData() {
			var dataGridData = $('#selectUserTargetDataGrid').datagrid('getChecked');
			var checkDataSize = dataGridData.length;
			if (checkDataSize > 0) {
				$('#selectUserTargetDataGrid').datagrid('deleteRow', getRecordIndexInTargetDataGrid(dataGridData[0].userId));
				var currDataGridData = $('#selectUserTargetDataGrid').datagrid('getChecked');
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
		
		var _checkflg = new Object();
		/**
		 * 加载组织树
		 */
		function loadOrgTree($tree, data) {
			var orgData = eval(data);
			$tree.tree({
				checkbox : true,
				lines : true,
				method : 'post',
				data : orgData,
				onCheck : function(node, checked) {
					var nodeType = node.attributes.nodeType;
					if (nodeType == 'user') {
						var parentNode = $tree.tree('getParent', node.target);
						if (_checkflg[parentNode.id]) {
							return;
						}
						var currNodeName = removeNodeNameParent(node.text);
						var userNo = node.attributes.userNo;
						var selectionData = {
							"userId" : node.id,
							"userName" : currNodeName,
							"deptId" : parentNode.id,
							"deptName" : parentNode.text,
							"userNo" : userNo
						};
						if (checked) {
							var rowIndex_ = getDataGridRowIndex(node.id);
							if (rowIndex_ == -1) {
								$('#selectUserTargetDataGrid').datagrid('appendRow', selectionData);
							}
							var rowIndex = getDataGridRowIndex(node.id);
							$('#selectUserTargetDataGrid').datagrid('checkRow', rowIndex);
						} else {
							var rowIndex = getDataGridRowIndex(node.id);
							if (rowIndex != -1) {
								$('#selectUserTargetDataGrid').datagrid('deleteRow', rowIndex);
							}
						}
					} else if (nodeType == 'dept' && functionAction == true) {
						var param = "deptId=" + node.id + "&checked=" + checked;
						if (displaySubDeptUser != null && typeof (displaySubDeptUser) != 'undefined' && displaySubDeptUser != 'null') {
							param += "&displaySubDeptUser=" + displaySubDeptUser;
						}
						param += "&extParameter=" + encodeURI(extParameter);
						ajaxRequest("POST", param, "platform/commonSelection/commonSelectionController/getAllSysUsersByDeptId", "json", "displayAllUsers");
					} else if (nodeType == 'dept' && functionAction == false) {
						var childNodes = $tree.tree("getChildren", node.target);
						$.each(childNodes, function(i, currNode) {
							var currNodeName_ = removeNodeNameParent(currNode.text);
							var userNo = currNode.attributes.userNo;
							var currSelectionData = {
								"userId" : currNode.id,
								"userName" : currNodeName_,
								"deptId" : node.id,
								"deptName" : node.text,
								"userNo" : userNo
							};
							if (checked) {
								var rowIndex_ = getDataGridRowIndex(currNode.id);
								if (rowIndex_ == -1) {
									$('#selectUserTargetDataGrid').datagrid('appendRow', currSelectionData);
								}
								var rowIndex = getDataGridRowIndex(currNode.id);
								$('#selectUserTargetDataGrid').datagrid('checkRow', rowIndex);
							} else {
								var rowIndex = getDataGridRowIndex(currNode.id);
								if (rowIndex != -1) {
									$('#selectUserTargetDataGrid').datagrid('deleteRow', rowIndex);
								}
							}
						});
					}
				},
				onBeforeCheck : function(node, checked) {
					if (singleSelect == true && checked == true) {
						removeAllUserClick();
					}
				},
				onBeforeExpand : function(node, param) {
					var beforeExpandUrl = 'platform/commonSelection/commonSelectionController/getDepts';
					var paramReq = '?nodeType=' + node.attributes.nodeType + '&deptId=' + node.id + '&orgId=' + node.id + '&selectType=user';
					var para = node.attributes.para;
					if (para != null && typeof (para) != 'undefined') {
						paramReq += "&param=" + para;
					}
					if (extParameter != null && typeof (extParameter) != 'undefined') {
						paramReq += "&extParameter=" + encodeURI(extParameter);
					}
					$tree.tree('options').url = beforeExpandUrl + paramReq;
					_checkflg[node.id] = true;
				},
				onExpand : function(node) {
					_checkflg[node.id] = false;
				},
				onLoadSuccess : function(node, data) {
					//隐藏org前面的checkbox
					$(this).find(".icon-home").next('span.tree-checkbox').hide();
				}
			});
		}
		
		/**
		 * 加载组织树
		 */
		function loadOrgTreeOther($tree, url, type) {
			$tree.tree({
				checkbox : true,
				lines : true,
				method : 'post',
				url : url,
				onCheck : function(node, checked) {
					var nodeType = node.attributes.nodeType;
					if (nodeType == 'user') {
						var parentNode = $tree.tree('getParent', node.target);
						if (_checkflg[parentNode.id]) {
							return;
						}
						var currNodeName = removeNodeNameParent(node.text);
						var userNo = node.attributes.userNo;
						var deptId = node.attributes.deptId;
						var deptName = node.attributes.deptName;
						var selectionData = {
							"userId" : node.id,
							"userName" : currNodeName,
							"deptId" : deptId,
							"deptName" : deptName,
							"userNo" : userNo
						};
						if (checked) {
							var rowIndex_ = getDataGridRowIndex(node.id);
							if (rowIndex_ == -1) {
								$('#selectUserTargetDataGrid').datagrid('appendRow', selectionData);
							}
							var rowIndex = getDataGridRowIndex(node.id);
							$('#selectUserTargetDataGrid').datagrid('checkRow', rowIndex);
						} else {
							var rowIndex = getDataGridRowIndex(node.id);
							if (rowIndex != -1) {
								$('#selectUserTargetDataGrid').datagrid('deleteRow', rowIndex);
							}
						}
					} else if (nodeType == type) {
						if (_checkflg[type]) {
							return;
						}
						var childNodes = $tree.tree("getChildren", node.target);
						$.each(childNodes, function(i, currNode) {
							var currNodeName_ = removeNodeNameParent(currNode.text);
							var userNo = currNode.attributes.userNo;
							var deptId = currNode.attributes.deptId;
							var deptName = currNode.attributes.deptName;
							var currSelectionData = {
								"userId" : currNode.id,
								"userName" : currNodeName_,
								"deptId" : deptId,
								"deptName" : deptName,
								"userNo" : userNo
							};
							if (checked) {
								var rowIndex_ = getDataGridRowIndex(currNode.id);
								if (rowIndex_ == -1) {
									$('#selectUserTargetDataGrid').datagrid('appendRow', currSelectionData);
								}
								var rowIndex = getDataGridRowIndex(currNode.id);
								$('#selectUserTargetDataGrid').datagrid('checkRow', rowIndex);
							} else {
								var rowIndex = getDataGridRowIndex(currNode.id);
								if (rowIndex != -1) {
									$('#selectUserTargetDataGrid').datagrid('deleteRow', rowIndex);
								}
							}
						});
					}
				},
				onBeforeCheck : function(node, checked) {
					if (singleSelect == true && checked == true) {
						removeAllUserClick();
					}
				},
				onBeforeExpand : function(node, param) {
					$tree.tree('options').url = url + '&pid=' + node.id;;
					_checkflg[node.id] = true;
				},
				onExpand : function(node) {
					_checkflg[node.id] = false;
					_checkflg[type] = false;
				}
			});
		}
		
		/**
		 * 取得datagrid中已选择全部数据
		 */
		function getSelectedResultDataJson(){
			return $('#selectUserTargetDataGrid').datagrid('getChecked');
		}
		
		/**
		 * 取得datagrid中全部数据
		 */
		function getAllResultDataJson() {
			return $('#selectUserTargetDataGrid').datagrid('getData').rows;
		}
		
		/**
		 * 树查询回调函数（查询关键字为空调用）
		 */
		function loadUserTreeDefaultQueryResult(queryResult) {
			var queryJson = eval(queryResult);
			$('#deptTab .userTree').tree("loadData", queryJson);
		}
		/**
		 * 树查询回调函数
		 */
		function loadUserTreeQueryResult(queryResult) {
			var queryJson = eval(queryResult);
			$('#deptTab .userTree').tree("loadData", queryJson);
			$('#deptTab .userTree').tree('expandAll');
		}
		
		/**
		 * 树查询回调函数
		 */
		function loadUserTreeQueryResultRole(queryResult) {
			var queryJson = eval(queryResult);
			_checkflg["role"] = true;
			$('#roleTab .userTree').tree("loadData", queryJson);
			$('#roleTab .userTree').tree('expandAll');
		}
		
		/**
		 * 树查询回调函数
		 */
		function loadUserTreeQueryResultPosition(queryResult) {
			var queryJson = eval(queryResult);
			_checkflg["position"] = true;
			$('#positionTab .userTree').tree("loadData", queryJson);
			$('#positionTab .userTree').tree('expandAll');
		}
		
		/**
		 * 树查询回调函数
		 */
		function loadUserTreeQueryResultGroup(queryResult) {
			var queryJson = eval(queryResult);
			_checkflg["group"] = true;
			$('#groupTab .userTree').tree("loadData", queryJson);
			$('#groupTab .userTree').tree('expandAll');
		}
		
		/**
		 * 树查询回调函数
		 */
		function loadUserTreeQueryResultGroupPerson(queryResult) {
			var queryJson = eval(queryResult);
			_checkflg["groupPerson"] = true;
			$('#groupPersonTab .userTree').tree("loadData", queryJson);
			$('#groupPersonTab .userTree').tree('expandAll');
		}
		/**
		 * 查询事件
		 */
		function query(value, id) {
			if (undefined == value || null == value) {
				value = '';
			}

			if (value == "请输入查询内容") {
				value = "";
			}
			
			if(id == "dept_query"){
				var param = "selectType=user&userKeyWord=" + encodeURI(value) + "&extParameter=" + encodeURI(extParameter);
				if (multipleOrg != null && typeof (multipleOrg) != 'undefined') {
					param += "&multipleOrg=" + multipleOrg;
				}
				if (value.length == 0) {
					functionAction = true;
					ajaxRequest("POST", param, "platform/commonSelection/commonSelectionController/getOrgQueryResult", "json", "loadUserTreeDefaultQueryResult");
				} else {
					functionAction = false;
					ajaxRequest("POST", param, "platform/commonSelection/commonSelectionController/getOrgQueryResult", "json", "loadUserTreeQueryResult");
				}
			} else if(id == "role_query"){
				var param = "userKeyWord=" + encodeURI(value);
				if (value.length == 0) {
					$('#roleTab .userTree').tree('options').url = role_url;
					$('#roleTab .userTree').tree("reload");
				} else {
					ajaxRequest("POST", param, role_url, "json", "loadUserTreeQueryResultRole");
				}
			} else if(id == "position_query"){
				var param = "userKeyWord=" + encodeURI(value);
				if (value.length == 0) {
					$('#positionTab .userTree').tree('options').url = position_url;
					$('#positionTab .userTree').tree("reload");
				} else {
					ajaxRequest("POST", param, position_url, "json", "loadUserTreeQueryResultPosition");
				}
			} else if(id == "group_query"){
				var param = "userKeyWord=" + encodeURI(value);
				if (value.length == 0) {
					$('#groupTab .userTree').tree('options').url = group_url;
					$('#groupTab .userTree').tree("reload");
				} else {
					ajaxRequest("POST", param, group_url, "json", "loadUserTreeQueryResultGroup");
				}
			} else if(id == "groupPerson_query"){
				var param = "userKeyWord=" + encodeURI(value);
				if (value.length == 0) {
					$('#groupPersonTab .userTree').tree('options').url = groupPerson_url;
					$('#groupPersonTab .userTree').tree("reload");
				} else {
					ajaxRequest("POST", param, groupPerson_url, "json", "loadUserTreeQueryResultGroupPerson");
				}
			}
		}
	</script>
</body>
</html>
