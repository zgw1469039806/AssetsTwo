/**
 * 
 */
function MobileCommandInfo(datagrid, url) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _selectId='';
	var _onSelectRow = null;
	var _onLoadSuccess = null;
	this.getOnSelectRow=function(){
		return _onSelectRow;
	};
	this.setOnSelectRow=function(f){
		_onSelectRow = f;
	};

	this.getOnLoadSuccess=function(){
		return _onLoadSuccess;
	};
	this.setOnLoadSuccess=function(f){
		_onLoadSuccess = f;
	};
	var _url = url;
	this.getUrl = function() {
		return _url;
	};
	this._datagridId = "#" + datagrid;
	this._doc = document;
//	this.init.call(this);
};

MobileCommandInfo.prototype.init = function(pid) {
	var _self = this;
	
	/* * this.searchDialog =$(this._searchDiaId).css('display','block').dialog({
	 * title:'查询' }); this.searchForm = $(this._formId).form();
	 * this.searchForm.find('input').on('keyup',function(e){ if(e.keyCode ==
	 * 13){ _self.searchData(); } }); this.searchDialog.dialog('close',true);
	 */
	// changer
	this._datagrid = $(this._datagridId).datagrid({
		url : this.getUrl() + "getMobileCommandInfo/" + pid,
		onSelect: function(rowIndex, rowData) {
			_self._selectId = rowData.id;
			_self.getOnSelectRow()(rowIndex, rowData, rowData.id);
			$('#dgmobileCommandHeaders').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
			$('#dgmobileCommandHeaders').datagrid('reload');
			$('#dgmobileCommandExtend').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
			$('#dgmobileCommandExtend').datagrid('reload');
		},
		onLoadSuccess : function(data) {
			_self.getOnLoadSuccess()();
			if (data.total > 0) {
				_self._datagrid.datagrid('selectRow', 0);
			} else {
				_self._selectId = '';
				_self.getOnSelectRow()(null, null, -1);
			}
		}
	});
};

function getRnd() {
	var rnd = Math.random();
	return rnd;
};
// 初始化操作

/*  MobileCommandInfo.prototype.init=function(pid){
  this._datagrid=$(this._datagridId).datagrid({
 url:this.getUrl()+"getMobileCommandInfo/"+pid });
  };
 */
MobileCommandInfo.prototype.loadByPid = function(pid) {
	return this._datagrid ? this._datagrid.datagrid({
		url : this.getUrl() + "getMobileCommandInfo/" + pid
	}) : this.init(pid);
};
// 添加页面
MobileCommandInfo.prototype.insert = function(pid) {
	this.nData = new CommonDialog("insert", "790", "400", this.getUrl()
			+ 'Add/' + pid, "添加", false, true, false);
	this.nData.show();
};
// 修改页面
MobileCommandInfo.prototype.modify = function() {
	var rows = this._datagrid.datagrid('getChecked');
	if (rows.length !== 1) {
		alert("请选择一条数据编辑！");
		return false;
	}
	this.nData = new CommonDialog("edit", "790", "400", this.getUrl() + 'Edit/'
			+ rows[0].id, "编辑", false, true, false);
	this.nData.show();
};
// 详细页
MobileCommandInfo.prototype.detail = function(id) {
	this.nData = new CommonDialog("edit", "790", "400", this.getUrl()
			+ 'Detail/' + id, "详情", false, true, false);
	this.nData.show();
};
// 保存功能
MobileCommandInfo.prototype.save = function(form, id) {
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
MobileCommandInfo.prototype.del = function() {
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
MobileCommandInfo.prototype.reLoad = function() {
//	var rnd = getRnd();
	this._datagrid.datagrid('load', {
//		avic_random : rnd
	});
};
// 关闭对话框
MobileCommandInfo.prototype.closeDialog = function(id) {
	$(id).dialog('close');
};
MobileCommandInfo.prototype.getSelectID = function() {
	return this._selectId;
};
MobileCommandInfo.prototype.searchDataBySfn =function(conditions){
    this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    this._datagrid.datagrid('load',conditions);
};

