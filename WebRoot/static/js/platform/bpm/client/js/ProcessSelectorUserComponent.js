

var processSelectUserComponentEvent = {
		/**
		 * 树中数据用户节点选中到目标DataGrid
		 */
		selectedTreeUserNodeToTargetDataGrid : function(node,checked,branchNo){
			if(checked){//选中
				var record = {
			    		userId : node.id,
			    		userName : node.text,
			    		deptId : node.attributes.deptId,
			    		deptName : node.attributes.deptName,
			    		order : 0
				};
				processSelectUserComponentEvent.eventAppendToSelectorTargetDataGrid(branchNo,record);
			} else {//反选
				var index = getRecordIndexInTargetDataGrid(node.id,branchNo);
				//增加判断 add by xingc
				if(index != -1){
					$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('deleteRow', index);
				}
			}
		},
		
		/**
		 * 刷新目标DataGrid
		 * @param branchNo
		 */
		refreshSelectedTree: function (branchNo){
			var datas = reloadDataForDataGridOrderType($('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData'));
			$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('loadData',datas);
		},
		
		/**
		 * 根据userId,校验是否在目标选择的dataGrid中存在
		 * @param branchNo
		 * @param userId
		 * @return true  : 存在
		 *         false : 不存在
		 */
		eventCheckIsHaveForTargetDataGrid : function(branchNo,userId){
			var datas = $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData');
			if(datas.rows.length > 0){
				for(var i = 0 ; i < datas.rows.length ; i++){
					if(userId == datas.rows[i].userId){
						return true;
					}
				}
			}
			return false;
		},
		/**
		 * 向目标datagrid追加数据
		 * @param branchNo
		 * @param record
		 */
		eventAppendToSelectorTargetDataGrid : function(branchNo,record){
			if(conditions.getDealType(branchNo) == 1){//单人处理
				var datas = $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData');
				if(datas.rows.length > 0){
					var isRecoverFlag = confirm('该节点为【单人处理】方式,确定要覆盖吗?');
					if(isRecoverFlag){
						//清空目标选择datagrid数据
						var data = {
								total : 0,
								rows : new Array()
						};
						$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('loadData',data);
						
						//追加数据
						record.order = -2;
						record.orderIndex = 0;
						$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('appendRow',record);
					}
					//清空select source tab标签页各控件的多余选择
//					var userIds = new Array();
//					userIds.push(record.userId);
//					unCheckedOfSelectorData(userIds,branchNo);
				} else {
					//追加数据
					record.order = -2;
					record.orderIndex = 0;
					$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('appendRow',record);
				}
			} else {
				if (record != undefined && record.userId != undefined) {
					var rowIndex = $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getRowIndex', record.userId);
					//判断是否存在，不存在才增加
					if(rowIndex == -1){
						if(typeof(record.order) == "undefined"){
							record.order = 0;
						}
						$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('appendRow',record);
					}
				}
			}
		},
		/**
		 * 树的展开事件
		 * @param node
		 */
		eventSelectedTreeNodeExpand : function(object,node,branchNo){
			//判断该节点是否为单人处理,如果不是,搜行event事件 当设置节点审批人的时候不起效果dostepuserdefined
			if(conditions.getDealType(branchNo) != '1' && conditions.isUserSelectTypeAuto(branchNo) && type != 'dostepuserdefined'){
				var nodes = object.tree('getChildren',node.target);
				for(var i = 0 ; i < nodes.length ; i++){
					object.tree('check',nodes[i].target);
					if(nodes[i].attributes.nodeType == 'org' || nodes[i].attributes.nodeType == 'dept'){
						if(!isLeaf){
							if(nodes[i]){
								object.tree('expand',nodes[i].target);
							} else {
								object.tree('expand',nodes[i]);
							}
						}
					}
				}
			}
		},

		/**
		 * 根据"选人方式"进行操作
		 */
		eventOfUserSelectType : function(){
			var getDatas = new GetDatas();
			for(var branchNo = 0 ; branchNo < getDatas.getBranchLength() ;branchNo++){
				if(conditions.isUserSelectTypeAuto(branchNo) && type != 'dostepuserdefined' && type != 'doretreattodraft' && type != 'doretreattoactivity' && type != 'doretreattoprev' && type != 'dowithdraw'){//选人方式 是"自动"
					if(conditions.getDealType(branchNo) == '1'){//处理方式是"单人顺序"
						if(getDatas.getOrgList(branchNo).length == 0  
								&& getDatas.getDeptList(branchNo).length == 0 	
								&& getDatas.getPositionList(branchNo).length == 0 	
								&& getDatas.getGroupList(branchNo).length == 0 	
								&& getDatas.getRoleList(branchNo).length == 0 	
								&& getDatas.getUserList(branchNo).length == 1) {
							processSelectUserComponentEvent.eventLoadDataToSelectDataGrid(getDatas.getUserList(branchNo),branchNo);
						} else {
							var stepActivityName = getDatas.getNextActivityAlias(branchNo);
							$.messager.alert('提示','节点【' + stepActivityName + '】配置错误!','error');
						}
					} else {
						processSelectUserComponentEvent.eventLoadTabsDataToSelectDataGrid(branchNo);
						processSelectUserComponentEvent.eventLoadDataToSelectDataGrid(getDatas.getUserList(branchNo),branchNo);
					}
				}
				if(type == 'doretreattodraft' || type == 'doretreattoactivity' || type == 'doretreattoprev' || type == 'dowithdraw'){//退回拟稿人/退回上一步,自动选人
					processSelectUserComponentEvent.eventLoadDataToSelectDataGrid(getDatas.getUserList(branchNo),branchNo);
				}
			}
		},
		//加载指定数据到选中的DataGrid
		eventLoadDataToSelectDataGrid : function(datas,branchNo){
			//setTimeout(function(){
				for(var i = 0 ; i< datas.length ; i++){
					var record = {
							userId : datas[i].id,
							userName : datas[i].name,
							deptName : datas[i].deptName,
							deptId : datas[i].deptId
						};
					processSelectUserComponentEvent.eventAppendToSelectorTargetDataGrid(branchNo,record);
//					$("#selectorUserTabForTargetDataGrid_" + branchNo).datagrid('appendRow',);
				}
			//},1000);
		},
		//加载流程定义审批人时指定数据到选中的DataGrid
		eventLoadDataToSelectDataGridByUserDefined : function(datas,branchNo){
			//setTimeout(function(){
				for(var i = 0 ; i< datas.length ; i++){
					var record = {
							userId : datas[i].userId,
							userName : datas[i].userName,
							deptName : datas[i].deptName,
							deptId : datas[i].deptId
						};
					processSelectUserComponentEvent.eventAppendToSelectorTargetDataGrid(branchNo,record);
//					$("#selectorUserTabForTargetDataGrid_" + branchNo).datagrid('appendRow',);
				}
			//},1000);
		},
		/**
		 * 加载tab标签页的component的数据到选中的DataGrid
		 */
		eventLoadTabsDataToSelectDataGrid : function(branchNo){
			if($('#selectorUserTabs').find('#selectorUserTab_' + branchNo + '_Content').length == 0){//非分支
				var tabs = $('#selectorUserTabs').tabs('tabs');
				for(var i = 0 ; i < tabs.length ; i++){
					 var pp = $('#selectorUserTabs').tabs('getTab',i);
					 var tabId = pp.panel('options').id;
					 if (tabId != undefined && tabId.length > 5) {
						 var contentId = tabId.substring(5, tabId.length);
						 if (contentId.indexOf("Tree_") > -1) {
							 var roots = $('#' + contentId).tree('getRoots');
							 for(var j = 0 ; j < roots.length ; j++){
								 var root = roots[j];
								 $('#' + contentId).tree('select',root.target);
								 expandAllAndCheckTreeNode(contentId,root);
							 }
						 } else if (contentId.indexOf("Grid_") > -1) {
							 $('#' + contentId).datagrid('selectAll');
						 }
					 }
				}
			} else {//分支
				var tabs = $('#selectorUserTab_' + branchNo + '_Content').tabs('tabs');
				for(var i = 0 ; i < tabs.length ; i++){
					var pp = $('#selectorUserTab_' + branchNo + '_Content').tabs('getTab',i);
					 var tabId = pp.panel('options').id;
					 if (tabId != undefined && tabId.length > 5) {
						 var contentId = tabId.substring(5, tabId.length);
						 if (contentId.indexOf("Tree_") > -1) {
							 var roots = $('#' + contentId).tree('getRoots');
							 for(var j = 0 ; j < roots.length ; j++){
								 var root = roots[j];
								 $('#' + contentId).tree('select',root.target);
								 expandAllAndCheckTreeNode(contentId,root);
							 }
						 } else if (contentId.indexOf("Grid_") > -1) {
							 $('#' + contentId).datagrid('selectAll');
						 }
					 }
				}
			}
		},
		//是否显示选人框
		eventOfIsDisplayUserSelect : function(){
			var getDatas = new GetDatas();
			for(var branchNo = 0 ; branchNo < getDatas.getBranchLength() ;branchNo++){
				if(!conditions.isSelectUser(branchNo)){
					//parent.hideUserSelectArea();
				}
			}
		}
};



/**
 * 同步树及表格下所有选中的数据为uncheck状态
 * @param userIds Array
 * @param branchNo 分支序号
 */
function unCheckedOfSelectorData(userIds,branchNo){
	//1,先获取tab页
	//2,获取tab页的ui元素
	//3,判断ui元素的类型
	//4,获取ui元素的选中的数据
	//5,使该数据为uncheck状态
	var panels = $('.panel .panel-body');
	for(var i = 0 ; i < panels.length ; i++){
		if(panels[i].id.indexOf('tabs') != -1){
			var subPanels = $('#' + panels[i].id + ' div');
			for(var j = 0 ; j < subPanels.length ; j++){
				if(typeof(subPanels[j].id) != 'undefined' && subPanels[j].id != ''){
					if($('#' + subPanels[j].id).attr('branchNo') == branchNo){
						var checkedDatas;
						try{
							if((subPanels[j].id).indexOf('Tree')!=-1){
								// tree 操作
								checkedDatas = $('#' + subPanels[j].id).tree('getChecked');
								if (checkedDatas.length > 0){
									for(var k = 0 ; k < checkedDatas.length ; k++){
										for(var m = 0 ; m < userIds.length;m++){
											if(checkedDatas[k].id == userIds[m]){
												$('#' + subPanels[j].id).tree('uncheck', checkedDatas[k].target);
											}
										}
									}
								}
							}
							if((subPanels[j].id).indexOf('Grid')!=-1){
								// dataGrid 操作
								checkedDatas = $('#' + subPanels[j].id).datagrid('getChecked');
								if (checkedDatas.length > 0){
									for(var k = 0 ; k < checkedDatas.length ; k++){
										for(var m = 0 ; m < userIds.length;m++){
											if(checkedDatas[k].id == userIds[m]){
												var index = $('#' + subPanels[j].id).datagrid('getRowIndex', checkedDatas[k]);
												$('#' + subPanels[j].id).datagrid('uncheckRow', index);
											}
										}
									}
								}
							}
						}catch(e){}
					}
				}
			}
		}
	}
}

/**
 * 循环调用,展开树的节点
 */
function expandAndCheckTreeNode(treeId,node){
	$('#' + treeId).tree('expand',node.target);
	$('#' + treeId).tree('check',node.target);
}

function expandAllAndCheckTreeNode(treeId,node){
	$('#' + treeId).tree('expandAll',node.target);
	$('#' + treeId).tree('check',node.target);
}

/**
 * 绘制目标选人dataGird
 */
function drawSecondLayerTabsForTargetDataGrid(objId,branchNo){
	$('#' + objId).datagrid({
		fit: true,
		fitColumns: true,
		remoteSort: false,
		nowrap:false,
		idField:'userId',
		loadMsg : '正在加载数据，请稍候...',
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'移除全部',
			iconCls:'icon-users-remove',
			handler:function(){
//				var datas = $('#' + objId).datagrid('getData');
//				if (datas.rows.length > 0){
//					var userIds = new Array();
//					for(var i = 0 ; i < datas.rows.length ; i++){
//						//同步树及表格下所有选中的数据为uncheck状态
//						userIds.push(datas.rows[i].userId);
//					}
//					unCheckedOfSelectorData(userIds,branchNo);
//				}
				
				var data = {
						total : 0,
						rows : new Array()
				};
				$('#' + objId).datagrid('loadData',data);
			} 
		}],
		columns:[[
			{field:'userId',title:'用户ID',width:120,align:'left' ,hidden : true},
			{field:'userName',title:'用户名',width:150,align:'left',sortable:true},
			{field:'deptId',title:'部门ID',width:120,align:'left',hidden : true},
			{field:'deptName',title:'部门',width:150,align:'left'},
			{field:'selectedType',title:'当前选中的是用户还是部门',width:120,align:'left',hidden : true},
			{field:'removeOp',title:'',width:32,align:'center',sortable:'true',formatter:function(value,row,index){
				var e =  "";
				var d = "<span class=\"user-remove\" onclick=\"removeOp('" + objId + "','" + row.userId + "'," + branchNo + ");return false;\">&nbsp;&nbsp;&nbsp;&nbsp;</span>";
				return e+d;
			}},
			{field:'orderIndex',title:'排序值',width:20,align:'left',hidden : true},
			{field:'order',title:'',width:60,align:'center',sortable:'true',formatter:function(value,row,index){
				var e =  "";
				var d = "";
				if(value == -1){//first
					d = "<span class=\"user-order-desc\" onclick=\"orderDownOp(" + value + "," + index + "," + branchNo + ")\">&nbsp;&nbsp;&nbsp;&nbsp;</span>";
				} else if(value == 0){// middle
					d = "<span class=\"user-order-asc\" onclick=\"orderUpOp(" + value + "," + index + "," + branchNo + ")\">&nbsp;&nbsp;&nbsp;&nbsp;</span><span class=\"user-order-desc\" onclick=\"orderDownOp(" + value + "," + index + "," + branchNo + ")\">&nbsp;&nbsp;&nbsp;&nbsp;</span>";
				} else if(value == 1){//last
					d = "<span class=\"user-order-asc\" onclick=\"orderUpOp(" + value + "," + index + "," + branchNo + ")\">&nbsp;&nbsp;&nbsp;&nbsp;</span>";
				}
				return e + d;
			}}
		]]
	});
}
/**
 * 向上交换排序
 * @param value
 * @param index
 * @param branchNo
 */
function orderUpOp(value,index,branchNo){
	var datas = $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData');
	if(index == 0){
		return;
	}
	var changeData = datas.rows[index];
	datas.rows[index] = datas.rows[index - 1];
	datas.rows[index - 1] = changeData;
	datas = reloadDataForDataGridOrderType(datas);
	$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('loadData',datas);
	return;
}
/**
 * 向下交换排序
 * @param value
 * @param index
 * @param branchNo
 */
function orderDownOp(value,index,branchNo){
	var datas = $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData');
	if(datas.rows.length - 1 == index){
		return;
	}
	var changeData = datas.rows[index];
	datas.rows[index] = datas.rows[index + 1];
	datas.rows[index + 1] = changeData;
	datas = reloadDataForDataGridOrderType(datas);
	$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('loadData',datas);
	return;
}
/**
 * 移除操作
 * @param objId
 * @param userId
 * @param branchNo
 * @returns {Boolean}
 */
function removeOp(objId,userId,branchNo){
	var index = getRecordIndexInTargetDataGrid(userId,branchNo);
	//$('#' + objId).datagrid('deleteRow', index);
	var userIds = new Array();
	userIds.push(userId);
	unCheckedOfSelectorData(userIds,branchNo);
	//
	var index = getRecordIndexInTargetDataGrid(userId,branchNo);
	//增加判断 add by xingc
	if(index != -1){
		$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('deleteRow', index);
	}
	
	var datas = reloadDataForDataGridOrderType($('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData'));
	$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('loadData',datas);
	return false;
}
function reloadDataForDataGridOrderType(datas){
	if(datas.rows.length == 1){
		datas.rows[0].order = 2;
	} else {
		for(var i = 0 ; i < datas.rows.length ; i++){
			if(i == 0){
				datas.rows[i].order = -1;
			} else if(i == datas.rows.length - 1){
				datas.rows[i].order = 1;
			} else {
				datas.rows[i].order = 0;
			}
		}
	}
	return datas;
}
function eventOnFocus(obj){
    if(obj.value=="按登录名/用户名/用户名称首字母进行检索.."){
    	obj.style.color="#000000";
    	obj.value="";
     }
 }
function EventOnBlur(obj){
    if(obj.value==""){
    	obj.style.color="";
    	obj.value="按登录名/用户名/用户名称首字母进行检索..";
    }
}
/**
 * search event
 * @param obj
 * @param userId
 * @param userName
 * @param deptId
 * @param deptName
 */
function eventSearcherCheckBox(obj,userId,userName,deptId,deptName,branchNo){
	if(obj.checked){
		if(getRecordIndexInTargetDataGrid(userId,branchNo) == -1){
			var record = {
		    		userId : userId,
		    		userName : userName,
		    		deptId : deptId,
		    		deptName : deptName
				};
			processSelectUserComponentEvent.eventAppendToSelectorTargetDataGrid(branchNo,record);
		}
	}
	return;
}
/**
 * 获取数据记录在目标数据表格中的索引值
 */
function getRecordIndexInTargetDataGrid(userId,branchNo){
	var datas = $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData');
	if(datas.total == 0){
		return -1;
	} else {
		for( var i = 0 ; i < datas.rows.length ; i++){
			if(userId == datas.rows[i].userId){
				return i;
			}
		}
	}
	return -1;
}
