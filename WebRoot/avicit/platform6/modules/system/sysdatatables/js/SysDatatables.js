/**
 * 
 */
function SysDatatables(datagrid, url, searchD, form) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _selectId = '';
	var _url = url;
	this.getUrl = function() {
		return _url;
	};
	this._datagridId = "#" + datagrid;
	this._doc = document;
	this._formId = "#" + form;
	this._searchDiaId = "#" + searchD;
	// this.init.call(this);

	// add
	var _onSelectRow = null;// 对象化封装，防止别人篡改
	this.getOnSelectRow = function() {
		return _onSelectRow;
	};
	this.setOnSelectRow = function(f) {
		_onSelectRow = f;
	};
	var _onLoadSuccess = null;
	this.getOnLoadSuccess = function() {
		return _onLoadSuccess;
	};
	this.setOnLoadSuccess = function(f) {
		_onLoadSuccess = f;
	};
};
// 初始化操作
SysDatatables.prototype.init = function() {
	var _self = this;
	this.searchDialog = $(this._searchDiaId).css('display', 'block').dialog({
		title : '查询'
	});
	this.searchForm = $(this._formId).form();
	this.searchForm.find('input').on('keyup', function(e) {
		if (e.keyCode == 13) {
			_self.searchData();
		}
	});
	this.searchDialog.dialog('close', true);
	// changer
	this._datagrid = $(this._datagridId).datagrid({
		url : this.getUrl() + "getSysDatatablessByPage.json",
		onSelect : function(rowIndex, rowData) {
			_self._selectId = rowData.id;
			_self.getOnSelectRow()(rowIndex, rowData, rowData.id);
		},
		onLoadSuccess : function(data) {
			_self.getOnLoadSuccess()();
			if (data.total > 0) {
				_self._datagrid.datagrid('selectRow', 0);
			} else {
				_self.getOnSelectRow()(null, null, -1);
			}
		}
	});
};
// 添加页面
SysDatatables.prototype.insert = function() {
	this.nData = new CommonDialog("insert", "790", "500", this.getUrl()
			+ 'Add/null', "添加", false, true, false);
	this.nData.show();
};
// 修改页面
SysDatatables.prototype.modify = function() {
	var rows = this._datagrid.datagrid('getChecked');
	if (rows.length !== 1) {
		$.messager.alert('提示', '请选择要编辑的记录！', 'warning');
		return false;
	}
	this.nData = new CommonDialog("edit", "790", "500", this.getUrl() + 'Edit/'
			+ rows[0].id, "编辑", false, true, false);
	this.nData.show();
};
// 详细页
SysDatatables.prototype.detail = function(id) {
	this.nData = new CommonDialog("edit", "790", "500", this.getUrl()
			+ 'Detail/' + id, "详情", false, true, false);
	this.nData.show();
};
// 保存功能
SysDatatables.prototype.save = function(form, id) {
	var _self = this;
	$.ajax({
		url : _self.getUrl() + "save",
		data : {
			data : JSON.stringify(form)
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
// 删除
SysDatatables.prototype.del = function() {
	var rows = this._datagrid.datagrid('getChecked');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		$.messager.confirm('请确认', '您确定要删除当前所选的数据？', function(b) {
			if (b) {
				for (; l--;) {
					ids.push(rows[l].id);
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
SysDatatables.prototype.reLoad = function() {
	this._datagrid.datagrid('load', {});
};
// 关闭对话框
SysDatatables.prototype.closeDialog = function(id) {
	$(id).dialog('close');
};

// 打开查询框
SysDatatables.prototype.openSearchForm = function() {
	this.searchDialog.dialog('open', true);
};
// 去后台查询
SysDatatables.prototype.searchData = function() {
	this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid(
			'clearSelections');
	this._datagrid.datagrid('load', {
		param : JSON.stringify(serializeObject(this.searchForm))
	});
};
// 隐藏查询框
SysDatatables.prototype.hideSearchForm = function() {
	this.searchDialog.dialog('close', true);
};
/* 清空查询条件 */
SysDatatables.prototype.clearData = function() {
	this.searchForm.find('input').val('');
	this.searchData();
};
SysDatatables.prototype.formate = function(value) {
	if (value) {
		return new Date(value).format("yyyy-MM-dd");
	}
	return '';
};
SysDatatables.prototype.formateDateTime = function(value) {
	if (value) {
		return new Date(value).format("yyyy-MM-dd hh:mm:ss");
	}
	return '';
};
// 返回主表的id
SysDatatables.prototype.getSelectID = function() {
	var rows = this._datagrid.datagrid('getChecked');

	var l = rows.length;
	if (l > 0) {
		this._selectId = rows[0].id;
	} else {
		this._selectId = null;
	}
	return this._selectId;
};
SysDatatables.prototype.searchDataBySfn = function(conditions) {
	this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid(
			'clearSelections');
	this._datagrid.datagrid('load', conditions);
};
