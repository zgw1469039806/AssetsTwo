function Data(datagrid, url, dataGridColModel,nodeId) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this.nodeId = nodeId;
	this._datagridId = "#" + datagrid;
	this.dataGridColModel = dataGridColModel;
	var _onSelect=function(){};//单击node事件
	this.getOnSelect=function(){
		return _onSelect;
	};
	this.setOnSelect=function(func){
		_onSelect=func;
	};
	//Data.jsp  show()
	var _onSelect1=function(){};
	this.getOnSelect1=function(){
		return _onSelect1;
	};
	this.setOnSelect1=function(func){
		_onSelect1=func;
	};
	this.init.call(this);
	
};
//初始化操作
Data.prototype.init = function() {
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl(),
		postData : {
			nodeId : _self.nodeId,
		},
		mtype : 'POST',
		datatype : "json",
		colModel : this.dataGridColModel,
		height : $(window).height() - 120 - 290, //120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		scrollOffset : 10, //设置垂直滚动条宽度
		rowNum : 10,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		pagerpos : 'left',
		viewrecords : true, 
		styleUI : 'Bootstrap',
		multiselect : true,
		autowidth : true,
		shrinkToFit : true,
		responsive : true, //开启自适应
		forceFit: true,
		/*cellEdit:true,
		cellsubmit : 'clientArray',*/
		onSelectRow:function(rowid){
			if(_self._datagridId =='#firstjqGrid'){
				ppId = rowid;
				_self.getOnSelect1()(ppId);//show();
				_self.getOnSelect()(ppId);//secondTable();
			}
		},
		gridComplete :function(){
			if(_self._datagridId =='#firstjqGrid'){
				var ids =  $(_self._datagridId).jqGrid('getDataIDs');
				if(ids.length==0){
					_self.getOnSelect()('-1111');
		                return false;
		            }
				for(var i=0;i<ids.length;i++){
		                if(ids[0]=="1"){
		                    $(_self._datagridId).jqGrid('setSelection',"1");
		                    return true;
		                }
		            }
				 $(_self._datagridId).jqGrid('setSelection',ids[0]);
			}
		},
		/*onCellSelect : function(rowid, index){
			if(_self._datagridId =='#secondjqGrid'){
				var rowData = $(_self._datagridId).jqGrid('getRowData',rowid);
				if(rowData.type == 2){
						if(index != 3 && index != 6){
							layer.msg('不可编辑');return;
						}
				}
				if(rowData.type == 0 || 1 || 3){
					if(index = 3){
						return;
					}
				}
					
						
		}
		},*/
		onCellSelect : function(rowid, index){
			if(_self._datagridId =='#secondjqGrid'){
				var rowData = $(_self._datagridId).jqGrid('getRowData',rowid);
				if(rowData.type == 2){
					if(index == 6){
						new H5CommonSelect({
							type : 'userSelect',
							idFiled : 'accessUser',
							textFiled : 'accessUserName',
							viewScope:'currentOrg',
							callBack:function(user){
								$(_self._datagridId).jqGrid('setRowData',rowid,{
									accessUserName:user.usernames,
									accessUser:user.userids
								});
							}
						});
					}
					if(index != 3 && index != 6){
						layer.msg('不可编辑');
					}
					return;
				}
				if(rowData.type == 0 || 1 || 3){
					if(index == 4){
						new H5CommonSelect({
							type:'roleSelect', 
							idFiled:'ruleId',
							textFiled:'accessRoleName',
							callBack:function(role){
								$(_self._datagridId).jqGrid('setRowData',rowid,{
									accessRoleName:role.roleNames,
									accessRole:role.roleids
								});
							}
						});
					}
					if(index == 5){
						new H5CommonSelect({
							type : 'deptSelect',
							idFiled : 'deptId',
							textFiled : 'sendDeptidAlias',
							callBack:function(dept){
								$(_self._datagridId).jqGrid('setRowData',rowid,{
									accessDeptName:dept.deptnames,
									accessDept:dept.deptids
								});
							}
						});
					}
					if(index == 6){
						new H5CommonSelect({
							type : 'userSelect',
							idFiled : 'userId',
							textFiled : 'recvUsersAlias',
							viewScope:'currentOrg',
							callBack:function(user){
								$(_self._datagridId).jqGrid('setRowData',rowid,{
									accessUserName:user.usernames,
									accessUser:user.userids
								});
							}
						});
					}
					if(index == 7){
						new H5CommonSelect({
							type:'groupSelect', 
							idFiled:'groupId',
							textFiled:'applyRoleidAlias',
							callBack:function(group){
								$(_self._datagridId).jqGrid('setRowData',rowid,{
									accessGroupName:group.groupNames,
									accessGroup:group.groupids
								});
							}
						});
					}
					if(index == 8){
						new H5CommonSelect({
							type:'positionSelect', 
							idFiled:'positionId',
							textFiled:'applyPositionidAlias',
							callBack:function(position){
								$(_self._datagridId).jqGrid('setRowData',rowid,{
									accessPositionName:position.positionNames,
									accessPosition:position.positionids
								});
							}
						})
					}
				}
			}
		},
		pager : _self.Pagerlbar
	});
};
Data.prototype.loadByAppId=function(nodeId){
	this.nodeId=nodeId;
	$(this._datagridId).jqGrid('setGridParam',{postData:{menuId:nodeId}}).trigger("reloadGrid");
};