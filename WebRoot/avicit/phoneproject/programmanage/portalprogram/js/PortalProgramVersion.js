/**
 * 
 */
function PortalProgramVersion(datagrid, url) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	};
	this._datagridId = "#" + datagrid;
	this._doc = document;
	// this.init.call(this);
};

function getRnd() {
	var rnd = Math.random();
	return rnd;
};
// 初始化操作
PortalProgramVersion.prototype.init = function(pid) {
	this._datagrid = $(this._datagridId).datagrid({
		url : this.getUrl() + "getPortalProgramVersion/" + pid
	});
};
PortalProgramVersion.prototype.loadByPid = function(pid) {
	if(this._datagrid){
		this._datagrid.datagrid('clearSelections');
		this._datagrid.datagrid('clearChecked');
	}	
	return this._datagrid ? this._datagrid.datagrid({
		url : this.getUrl() + "getPortalProgramVersion/" + pid
	}) : this.init(pid);
};
// 添加页面
PortalProgramVersion.prototype.insert = function(pid) {
	if(pid==null){
		 $.messager.show({
			 title : '提示',
			 msg : '请选择应用！'
		});
		 return;
	}
	this.nData = new CommonDialog("insert", "700", "400", this.getUrl()
			+ 'Add/' + pid, "添加", false, true, false);
	this.nData.show();
};
// 修改页面
PortalProgramVersion.prototype.modify = function() {
	var rows = this._datagrid.datagrid('getChecked');
	if (rows.length != 1) {
		alert("请选择一条数据编辑！");
		return false;
	}
	this.nData = new CommonDialog("edit", "700", "400", this.getUrl() + 'Edit/'
			+ rows[0].id, "编辑", false, true, false);
	this.nData.show();
};
// 详细页
PortalProgramVersion.prototype.detail = function(id) {
	this.nData = new CommonDialog("edit", "600", "400", this.getUrl()
			+ 'Detail/' + id, "详情", false, true, false);
	this.nData.show();
};
// 保存功能
PortalProgramVersion.prototype.save = function(form,id,versionId,file,unzipPath) {
	var _self = this;
	$.ajax({
		 async: false,
		url : _self.getUrl() + "save",
		data : {
			data : JSON.stringify(form),
			versionId:versionId,
			file : file,
			unzipPath :unzipPath,
			id :  id
		},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.reLoad();
				_self._datagrid.datagrid('uncheckAll').datagrid('unselectAll')
						.datagrid('clearSelections');
				$(id).dialog('close');
				$.messager.show({
					title : '提示',
					msg : '保存成功！'
				});
			} else {
				$.messager.show({
					title : '提示',
					msg : r.error
				});
			}
		}
	});
};
// 启用;禁用
PortalProgramVersion.prototype.change = function(state) {
	var rows = this._datagrid.datagrid('getChecked');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		for (; l--;) {
			ids.push(rows[l].id);
		}
		ids.push(state);
		$.ajax({
			url : _self.getUrl() + 'update',
			data : JSON.stringify(ids),
			contentType : 'application/json',
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag == "success") {
					_self.reLoad();
					// _self._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
					$.messager.show({
						title : '提示',
						msg : '成功！'
					});
				} else {
					$.messager.show({
						title : '提示',
						msg : r.error
					});
				}
			}
		});

	}
};
// 删除
PortalProgramVersion.prototype.del = function(id,programVersionState) {

	var _self = this;
	var ids = [];
	var l;
	if(id!=null && programVersionState!=null){
		l=100000000;
		
	}else{
		var rows = this._datagrid.datagrid('getChecked');
		l =rows.length;
	}
	if (l > 0) {
		$.messager.confirm('请确认', '您确定要删除当前所选的数据？', function(b) {
			if (b) {
				if(l==100000000){
					 if("启用"==programVersionState){
						 $.messager.show({
							 title : '提示',
							 msg : '有程序已经启动！'
						});
						 return;
					 }
					 ids.push(id); 
				 }else{
					 for (;l--;) {
						 if("启用"==rows[l].programVersionState){
							 $.messager.show({
								 title : '提示',
								 msg : '版本已经启动！'
							});
							 return;
						 }
						ids.push(rows[l].id);
					}
				 }
				
				$.ajax({
					url : _self.getUrl() + 'delete',
					data : JSON.stringify(ids),
					contentType : 'application/json',
					type : 'post',
					dataType : 'json',
					success : function(r) {
						if (r.flag == "success") {
							_self.reLoad();
							_self._datagrid.datagrid('uncheckAll').datagrid(
									'unselectAll').datagrid('clearSelections');
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						} else {
							$.messager.show({
								title : '提示',
								msg : r.error
							});
						}
					}
				});
			}
		});
	} else {
		$.messager.alert('提示', '请选择要删除的记录！', 'warning');
	}
};
// 重载数据
PortalProgramVersion.prototype.reLoad = function() {
	//this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearCheckeds');
	var rnd = getRnd();
	this._datagrid.datagrid('load', {
		avic_random : rnd
	});
};
// 关闭对话框
PortalProgramVersion.prototype.closeDialog = function(id) {
	$(id).dialog('close');
};