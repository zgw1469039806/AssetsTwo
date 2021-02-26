/**
 * 
 */
function MdaCollections(datagrid, url, searchD, form, keyWordId, searchNames,
		dataGridColModel) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this._datagridId = "#" + datagrid;
	this._jqgridToolbar = "#t_" + datagrid;
	this._doc = document;
	this._formId = "#" + form;
	this._searchDialogId = "#" + searchD;
	this._keyWordId = "#" + keyWordId;
	this._searchNames = searchNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
// 初始化操作
MdaCollections.prototype.init = function() {
	var _self = this;
	this._datagrid = $(this._datagridId).datagrid({
		url : this.getUrl() + "getMdaCollectionssByPage.json"
	});
	$(this._jqgridToolbar).append($("#tableToolbar"));
	$(_self._keyWordId).on('keydown', function(e) {
		if (e.keyCode == '13') {
			_self.searchByKeyWord();
		}
	});
};
//中间文件
MdaCollections.prototype.addjsondata = function(addjsonurl) {
	this.nData = new CommonDialog("addjson", "850", "500", addjsonurl, "加载中间数据", false, true, false);
	this.nData.show();
};
//detail
MdaCollections.prototype.solrDetail = function(solrurl) {
	this.nData = new CommonDialog("solrDetail", "2000", "1000", solrurl, "索引数据详情", false, true, false);
	this.nData.show();
};
//自定义URL跳转
MdaCollections.prototype.doJump4URL = function(doJump4URL) {
	this.nData = new CommonDialog("doJump4URL", "2000", "1000", doJump4URL, "自定义URL跳转", false, true, false);
	this.nData.show();
};
// 控件校验 规则：表单字段name与rules对象保持一致
MdaCollections.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			name : {
				required : true,
				maxlength : 32
			},
			createtime : {
				dateISO : true
			},
			enabletime : {
				dateISO : true
			},
			disabletime : {
				dateISO : true
			},
			status : {
				maxlength : 1
			},
		}
	});
}
// 删除
MdaCollections.prototype.del = function() {
	var rows = this._datagrid.datagrid('getChecked');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
	  $.messager.confirm('请确认','您确定要删除当前所选的数据？',function(b){
		 if(b){
			 for(;l--;){
				 ids.push(rows[l].id);
			 }
			 $.ajax({
				 url:_self.getUrl()+'delete',
				 data:	JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 _self.reLoad();
						 _self._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						 $.messager.show({
							 title : '提示',
							 msg : '删除成功！'
						});
					}else{
						$.messager.show({
							 title : '提示',
							 msg : r.error
						});
					}
				 }
			 });
		 } 
	  });
	}else{
	  $.messager.alert('提示','请选择要删除的记录！','warning');
	}
};
// 重载数据
MdaCollections.prototype.reLoad = function() {
	this._datagrid.datagrid('load', {});
};
// 关闭对话框
MdaCollections.prototype.closeDialog = function(id) {
	$(id).dialog('close');
};
// 关键字段查询
MdaCollections.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for ( var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}
/*	var searchdata = {
		keyWord : JSON.stringify(param),
		param : null
	}*/
	this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	this._datagrid.datagrid('load',{ keyWord : JSON.stringify(param)});
/*	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");*/
}
/* 清空查询条件 */
MdaCollections.prototype.clearData = function() {
	clearFormData(this._formId);
	this.searchData();
};
