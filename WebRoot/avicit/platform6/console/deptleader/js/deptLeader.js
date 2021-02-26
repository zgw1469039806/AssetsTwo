/**
 * 初始化对象
 * @param datagrid 表格Id
 * @param url URL参数
 * @param keyWordId 关键字查询框Id
 * @param dataGridColModel 表格列属性Array
 */
function DeptLeader(datagrid, url,  keyWordId, dataGridColModel,searchMainNames) {
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
	this._keyWordId = "#" + keyWordId;
	this._searchNames = searchMainNames;
	this.dataGridColModel = dataGridColModel;
	this.notnullFiled = [];//非空字段
	this.notnullFiledComment = []; //非空字段注释
	//除时间,数字等类型长度校验字段
	this.lengthValidFiled = [];
	//除时间,数字等类型长度校验字段注释
	this.lengthValidFiledComment = [];
	//除时间,数字等类型长度
	this.lengthValidFiledSize = [];
	this.init.call(this);
};

/**
 * 初始化操作
 */
DeptLeader.prototype.init = function() {
	var _self = this;
		$(_self._datagridId).jqGrid({
		url : this.getUrl() + '/getData.json',
		/*url : 'platform/sysPermissionLeaddeptController/getData',*/
		mtype : 'POST',
		datatype : "json",
		toolbar : [ true, 'top' ],//启用toolbar
		colModel : this.dataGridColModel,//表格列的属性
		height : $(window).height() - 120,//初始化表格高度
		scrollOffset : 20, //设置垂直滚动条宽度
		rowNum : 1000,//每页条数
		rowList : [ 200, 100, 50, 30, 20, 10 ],//每页条数可选列表
		altRows : true,//斑马线
		pagerpos : 'left',//分页栏位置
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		hasTabExport:false, //导出
		hasColSet:false,  //设置显隐
		styleUI : 'Bootstrap', //Bootstrap风格
		viewrecords : true, //是否要显示总记录数
		multiselect : true,//可多选
		autowidth : true,//列宽度自适应
		responsive : true,//开启自适应
		/*pager : "#jqGridPager",目前后台没有分页逻辑,前台暂时去掉分页栏*/
		cellEdit : true,
		cellsubmit : 'clientArray'
	});
	//放入表格toolbar中
	$(this._jqgridToolbar).append($("#tableToolbar"));

	//初始化校验字段
	_self.notnullFiled.push("userid");
	_self.notnullFiledComment.push("员工姓名");
	_self.notnullFiled.push("deptid");
	_self.notnullFiledComment.push("所管部门");
};
/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
DeptLeader.prototype.insert = function() {
	$(this._datagridId).jqGrid('endEditCell');
	var newRowId = newRowStart + newRowIndex;
	var parameters = {
		rowID : newRowId,
		initdata : {},
		position : "first",
		useDefValues : true,
		useFormatter : true,
		addRowParams : {
			extraparam : {}
		}
	}
	$(this._datagridId).jqGrid('addRow', parameters);
	newRowIndex++;
};

/**
 * 非空验证
 * @param 
 * @param 
 */
DeptLeader.prototype.nullvalid = function(data, item, nullfiled,
		notnullFiledComment) {
	var msg = "";
	$.each(data, function(i, dataitem) {
		if (dataitem[item] == "") {
			temp = false;
			msg = notnullFiledComment[$.inArray(item, nullfiled)] + "为必填字段";
		}
	});
	return msg;
};

/**
 * 保存功能
 * @param form
 * @param callback
 */
DeptLeader.prototype.save = function() {
	var _self = this;
	$(this._datagridId).jqGrid('endEditCell');
	var data = $(this._datagridId).jqGrid('getChangedCells');
	if (data && data.length > 0) {
		for ( var i = 0; i < data.length; i++) {
			if (data[i].id.indexOf(newRowStart) > -1) {
				data[i].id = '';
			}
		}
	avicAjax.ajax({
		url : _self.getUrl() + "/save",
		data : {
			data : JSON.stringify(data)
		},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.reLoad();
				layer.msg('保存成功！');
				/*if (id == "insert") {
					layer.close(_self.insertIndex);
				} else {
					layer.close(_self.eidtIndex);
				}
				layer.msg('保存成功！');*/
			} else {
				layer.alert('保存失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0
				});
			}
		}
	});
	} else {
		layer.alert('请先修改数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
	}
};

/**
 * 删除
 */
DeptLeader.prototype.del = function() {
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
				url : _self.getUrl() + '/delete',
				data : JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success") {
						_self.reLoad();
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

/**
 * 重载数据
 */
DeptLeader.prototype.reLoad = function() {
	/*var searchdata = {
		keyWord : null,
		param : JSON.stringify(serializeObject($(this._formId)))
	}*/
	/*var searchdata = {keyWord:JSON.stringify({aa:1})};
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");*/
	var searchdata = {
			keyWord : null,
			//param : JSON.stringify(serializeObject($(this._formId)))
		}
		$(this._datagridId).jqGrid('setGridParam', {
			datatype : 'json',
			postData : searchdata
		}).trigger("reloadGrid");
};
/**
 * 关键字查询
 */
DeptLeader.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val()==$(this._keyWordId).attr("placeholder") ? "" :  $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for ( var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
		keyWord : JSON.stringify(param)
	}

	$(this._datagridId).jqGrid('setGridParam', {postData : searchdata}).trigger("reloadGrid");
	
}
