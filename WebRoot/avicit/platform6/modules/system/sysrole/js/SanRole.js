/**
 * 三员角色管理操作js
 * @author zhanglei
 */
function SanRole(datagrid,url,searchD,form){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
    this._datagridName=datagrid;
	this._datagridId="#"+datagrid;
	this._doc = document;
	this._scope={};//有效标识
	this._status={};//有效标识
	this._formId="#"+form;
	this._searchDiaId ="#"+searchD;
	var _onSelectRow=function(){};//对象化封装，防止别人篡改
    this.getOnSelectRow=function(){
    	return _onSelectRow;
    }
    this.setOnSelectRow=function(f){
    	_onSelectRow = f;
    }
    var _onLoadSuccess=function(){};//数据导入成功回调
    this.getOnLoadSuccess=function(){
    	return _onLoadSuccess;
    }
    this.setOnLoadSuccess=function(f){
    	_onLoadSuccess=f;
    }
};
//初始化操作
SanRole.prototype.init=function(pid){
	var _self = this;
	$.ajax({
		 url:'platform/syslookuptype/getLookUpCode/PLATFORM_USAGE_MODIFIER',
		 type : 'get',
		 dataType : 'json',
		 success : function(r){
			 _self._scope=r;
		 }
	 });
	$.ajax({
		 url:'platform/syslookuptype/getLookUpCode/PLATFORM_VALID_FLAG',
		 type : 'get',
		 dataType : 'json',
		 success : function(r){
			 _self._status=r;
		 }
	 });
	this._datagrid =$(this._datagridId).datagrid({
			url:this.getUrl()+"/roles.json",
			method:"get",
			onLoadSuccess: function(data){
				_self.getOnLoadSuccess()();
				_self._datagrid.datagrid('selectRow',0);
			},
			onSelect: function(rowIndex, rowData){
				_self.getOnSelectRow()(rowIndex, rowData,rowData.id);
			}
	})
};

//重载数据
SanRole.prototype.reLoad=function(){
	this._datagrid.datagrid('load',{}).datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
};
//******************************增删该操作  end   ***********************************
//******************************格式化显示  start ***********************************
SanRole.prototype.formatScope=function(value){
	return Platform6.fn.lookup.formatLookupType(value,this._scope);
};
SanRole.prototype.stop=function(){
	var _self=this;
	$.messager.confirm('请确认', '确定要禁用平台管理员？', function(b) {
		if (b) {
			$.ajax({
				url : 'platform/sysrole/stopAdmin.json',
				type : 'post',
				dataType : 'json',
				success : function(r) {
					_self.reLoad();
				}
			});
		}
	});
};
SanRole.prototype.formatValid=function(value){
	return Platform6.fn.lookup.formatLookupType(value,this._status);
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function SanRoleUser(datagrid,url,searchD,form){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
    this._datagridName=datagrid;
	this._datagridId="#"+datagrid;
	this._doc = document;
	this._scope={};//有效标识
	this._formId="#"+form;
	this._searchDiaId ="#"+searchD;
	this._pid;
};
SanRoleUser.prototype.loadById=function(pid){
	this._pid=pid;
	(this._datagrid&&this._datagrid.datagrid({url : this.getUrl() + "/users/" + pid}).datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections'))||this.init(pid);
};
SanRoleUser.prototype.init=function(pid){
	var _self = this;
	this.searchDialog =$(this._searchDiaId).css('display','block').dialog({
		title:'查询用户'
	});
	this.searchDialog.dialog('close',true);
	this.searchForm = $(this._formId).form();
	this.searchForm.find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			_self.searchData();
		}
	});

	/*$.ajax({
		 url:'platform/syslookuptype/getLookUpCode/PLATFORM_VALID_FLAG',
		 type : 'get',
		 dataType : 'json',
		 success : function(r){
			 _self._validation=r;
		 }
	 });*/
	this._datagrid =$(this._datagridId).datagrid({
			url : this.getUrl() + "/users/" + pid
	})
};
SanRoleUser.prototype.reLoad =function(){
	this._datagrid.datagrid('load',{ param : JSON.stringify(serializeObject(this.searchForm))});
};
//打开查询框
SanRoleUser.prototype.openSearchForm =function(){
	this.searchDialog.dialog('open',true);
};
//去后台查询
SanRoleUser.prototype.searchData =function(){
	this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	this._datagrid.datagrid('load',{ param : JSON.stringify(serializeObject(this.searchForm))});
};
//隐藏查询框
SanRoleUser.prototype.hideSearchForm =function(){
	this.searchDialog.dialog('close',true);
};
/*清空查询条件*/
SanRoleUser.prototype.clearData =function(){
	this.searchForm.find('input').val('');
	this._datagrid.datagrid('reload',{});
};
SanRoleUser.prototype.showAddUser =function(){
	this.nData = new CommonDialog("insert","700","400",this.getUrl()+'/add/'+this._pid,"添加",false,true,false);
	this.nData.show();
};
//关闭对话框
SanRoleUser.prototype.closeDialog=function(){
	$('#insert').dialog('close');
};
SanRoleUser.prototype.deleteUser =function(){
	var row = $('#dgRole').datagrid('getChecked');
	if (row.length > 1) {
		$.messager.alert('提示', '请选择一个角色', 'warning');
		return;
	}
	var roleId = row[0].id;
	var _self=this;
	var rows = $('#dgUser').datagrid('getChecked');
	var data = JSON.stringify(rows);

	if (rows.length > 0) {
		$.messager.confirm('请确认', '您确定要删除当前所选的数据？', function(b) {
			if (b) {
				$.ajax({
					url : 'platform/sysrole/deleteUserRole.json',
					data : {
						datas : data,
						roleId : roleId
					},
					type : 'post',
					dataType : 'json',
					success : function(r) {
						if (r.result == 0) {
							_self.reLoad();
							$.messager.show({
								title : '提示',
								msg : '删除成功！(只有一个角色的用户不能删除)'
							});
						} else {
							$.messager.alert('提示', r.msg, 'warning');
						}
					}
				});
			}
		});
	} else {
		$.messager.alert('提示', '请选择要删除的记录！', 'warning');
	}
};
SanRoleUser.prototype.saveUserRole =function(obj){
	var _self=this;
	$.ajax({
	    type: "POST",
	    url:'platform/sysrole/saveUserRole.json',
	    dataType:"json",
	    data: obj,
	    error: function(request) {
	    	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
	    },
	    success: function(data) {
			if(data.result==0){
				_self.reLoad();
				$.messager.show({
					title : '提示',
					msg : '添加成功！'
				});
				_self.closeDialog();
			}else{
				$.messager.alert('提示',data.msg,'warning');
			}
	    }
	}); 
};

