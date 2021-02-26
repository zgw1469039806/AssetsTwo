/**
 * 
 */
function EformDatasourceWs(datagrid, url, form,parentId) {
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
	this._parentId = parentId;
	
	var dataGridColModel = [ {
		label : '标识',
		name : 'id',
		key : true,
		width : 75
	},{
		lable:'参数名',
		name:'paramName',
		hidden:true
	},{
		label : '名称',
		name : 'name',
		width : 75
	},{
		label : '用户',
		name : 'user',
		width : 75
	}];
	
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
//初始化操作
EformDatasourceWs.prototype.init = function() {
	var _self = this;
	var param = {id:_self._parentId};
	$(_self._datagridId).jqGrid({
		url : this.getUrl() + 'getSoapWebservicesByPage.json',
		mtype : 'POST',
		postData : param,
		datatype : "json",
		toolbar : [ true, 'top' ],
		colModel : this.dataGridColModel,
		height : $(window).height() - 120,
		scrollOffset : 20, //设置垂直滚动条宽度
		rowNum : 10,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		userDataOnFooter : true,
		pagerpos : 'left',
		hasTabExport:false, //导出
		hasColSet:false,  //设置显隐
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
			$("#jqGridPager_center").remove();
			setTimeout(function(){
        		$(document).trigger('resize');
        	},100)
		},
		styleUI : 'Bootstrap',
		viewrecords : true,
		multiselect : true,
		autowidth : true,
		shrinkToFit : true,
		responsive : true,//开启自适应
		pager : "#jqGridPager"
	});
	$(this._jqgridToolbar).append($("#tableToolbar"));
};

EformDatasourceWs.prototype.getSelectRow = function(){
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
		return null;
	} else if (ids.length > 1) {
		layer.alert('请选择一条数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
		return null;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	return rowData;
};
//添加页面
EformDatasourceWs.prototype.insert = function() {
	this.insertIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '添加【Soap WebService】',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : this.getUrl() + 'Add/null'
	});
};
//编辑页面
EformDatasourceWs.prototype.modify = function() {
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
		return false;
	} else if (ids.length > 1) {
		layer.alert('请选择一条数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.eidtIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '编辑【Soap WebService】',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : this.getUrl() + 'Edit/' + rowData.id
	});
};
//详细页
EformDatasourceWs.prototype.detail = function(id) {
	this.detailIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '详细页',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : this.getUrl() + 'Detail/' + id
	});
};
//控件校验   规则：表单字段name与rules对象保持一致
EformDatasourceWs.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			wsdlurl : {
				required: true,
				maxlength : 100
			},
			method : {
				required: true,
				maxlength : 100
			},
			name : {
				required: true,
				maxlength : 100
			},
			user : {
				required: true,
				maxlength : 100
			},
			password : {
				required: true,
				maxlength : 100
			},
			wsinterface : {
				required: true,
				maxlength : 100
			},
			param : {
				maxlength : 100
			},
		}
	});
}
//保存功能
EformDatasourceWs.prototype.save = function(form, id,classId) {
	var _self = this;
	var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);
	avicAjax.ajax({
		url : _self.getUrl() + "save",
		data : {formDataJson:formDataJson,classId:classId},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.reLoad(classId);
				
				layer.msg('保存成功！');
			} else {
				layer.alert('保存失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0
				});
			}
		}
	});
};
//保存编辑
EformDatasourceWs.prototype.saveEdit = function(form, id,classId) {
	var _self = this;
	var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);
	avicAjax.ajax({
		url : _self.getUrl() + "saveEdit",
		data : {formDataJson:formDataJson,classId:classId},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.reLoad(classId);
				
				layer.msg('保存成功！');
			} else {
				layer.alert('保存失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0
				});
			}
		}
	});
};
//删除
EformDatasourceWs.prototype.del = function(classId) {
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		layer.confirm('确定要删除该数据吗?', {
			icon : 2,
			title : "请确认：",
			area : [ '400px', '' ]
		}, function(index) {
			for (; l--;) {
				ids.push(rows[l]);
			}
			avicAjax.ajax({
				url : _self.getUrl() + 'delete',
				data : JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success") {
						_self.reLoad(classId);
					} else {
						layer.alert('删除失败！' + r.error, {
							icon : 7,
							area : [ '400px', '' ],
							closeBtn : 0
						});
					}
				}
			});
			layer.close(index);
		});
	} else {
		layer.alert('请选择要删除的记录！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
	}
};
//重载数据
EformDatasourceWs.prototype.reLoad = function(id) {
	var searchdata = {
		param : JSON.stringify({classId:id})
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关闭对话框
EformDatasourceWs.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
