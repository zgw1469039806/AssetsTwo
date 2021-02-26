function SysJobCalendarDate(datagrid, url, formSub, dataGridColModel,
		searchDialogSub, pid) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this._searchDialogId = "#" + searchDialogSub;
	this.searchForm = "#" + formSub;
	this.pid = pid;
	this._datagridId = "#" + datagrid;
	this.Toolbardiv = "#t_" + datagrid;
	this.Toolbar = "#toolbar_" + datagrid;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
//初始化操作
SysJobCalendarDate.prototype.init = function(pid) {
	//'platform/jobCalendarController/loadJobCalendarDates.json'
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl() + 'getSysJobCalendarDate',
		postData : {
			pid : _self.pid
		},
		mtype : 'POST',
		datatype : "json",
		toolbar : [ true, 'top' ],
		colModel : this.dataGridColModel,
		height : 220 - 39,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		width:300,
		scrollOffset : 10, //设置垂直滚动条宽度
		rowNum : 20,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		pagerpos : 'left',
		hasColSet:false,
		hasTabExport:false,
		pager: "#sysJobCalendarDateJqGridPager",
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		styleUI : 'Bootstrap',
		viewrecords : true, //
		multiselect : true,
		autowidth : true,
		shrinkToFit : true,
		responsive : true,//开启自适应
	});

	$(_self.Toolbardiv).append($(_self.Toolbar));

	$('.date-picker').datepicker({
		beforeShow : function() {
			setTimeout(function() {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
	});
	$('.time-picker').datetimepicker({
		oneLine : true,//单行显示时分秒
		closeText : '确定',//关闭按钮文案
		showButtonPanel : true,//是否展示功能按钮面板
		showSecond : false,//是否可以选择秒，默认否
		beforeShow : function(selectedDate) {
			if ($('#' + selectedDate.id).val() == "") {
				$(this).datetimepicker("setDate", new Date());
				$('#' + selectedDate.id).val('');
			}
			setTimeout(function() {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
	});
	$(_self._keyWordId).on('keydown', function(e) {
		if (e.keyCode == '13') {
			_self.searchByKeyWord();
		}
	});
};
//添加页面
SysJobCalendarDate.prototype.insert = function(pid) {
	if (this.pid == null || this.pid == "") {
		layer.alert('请选择一条主表数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn: ['关闭'],
			title:"提示"
		});
		return false;
	}
	this.insertIndex = layer.open({
		type : 2,
		title : '添加',
		skin : 'bs-modal',
		area : [ '40%', '65%' ],
		maxmin : false,
		content : this.getUrl() + 'Add/null'
	});
};
//修改页面
SysJobCalendarDate.prototype.modify = function() {
	if (this.pid == null || this.pid == "") {
		layer.alert('请选择一条主表数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn: ['关闭'],
			title:"提示"
		});
		return false;
	}
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择要编辑的数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn: ['关闭'],
			title:"提示"
		});
		return false;
	} else if (ids.length > 1) {
		layer.alert('只允许选择一条数据，进行编辑！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn: ['关闭'],
			title:"提示"
		});
		return false;
	}

	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.eidtIndex = layer.open({
		type : 2,
		title : '编辑',
		skin : 'bs-modal',
		area : [ '100%', '100%' ],
		maxmin : false,
		content : this.getUrl() + 'Edit/' + rowData.id
	});
};
//详细页
SysJobCalendarDate.prototype.detail = function(id) {
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
SysJobCalendarDate.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			jobCalendarId : {
				required : true,
				maxlength : 50
			},
			excludedDate : {
				required : true,
				dateISO : true
			},
			description : {
				maxlength : 200
			},
		}
	});
}
//保存功能
SysJobCalendarDate.prototype.save = function(form, id) {
	var _self = this;
	avicAjax.ajax({
		url : _self.getUrl() + "save",
		data : {
			data : JSON.stringify(serializeObject(form))
		},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.reLoad();
				if (id == "insert") {
					layer.close(_self.insertIndex);
				} else {
					layer.close(_self.eidtIndex);
				}
				layer.msg('保存成功！');
			} else {
				layer.alert('保存失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0,
					btn: ['关闭'],
					title:"提示"
				});
			}
		}
	});
};
//删除
SysJobCalendarDate.prototype.del = function() {
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		layer.confirm('确认要删除选中的数据吗?',  {icon: 3, title:"提示", closeBtn : 0,area: ['400px', '']}, function(index){
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
						_self.reLoad();
					} else {
						layer.alert('删除失败！' + r.error, {
							icon : 7,
							area : [ '400px', '' ],
							closeBtn : 0,
							btn: ['关闭'],
							title:"提示"
						});
					}
				}
			});
			layer.close(index);
		});
	} else {
		layer.alert('请选择要删除的数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title:"提示"
		});
	}
};
//重载数据
SysJobCalendarDate.prototype.reLoad = function(pid) {
	if (pid != undefined) {
		this.pid = pid;
	}
	var searchdata = {
		pid : pid
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关闭对话框
SysJobCalendarDate.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
//打开高级查询框
SysJobCalendarDate.prototype.openSearchForm = function(searchDiv, par) {
	var _self = this;
	par = null;
	//if(!par) par = $(window);
	var contentWidth = 600; //(par.width()*.6 >= 600)?600:par.width()*.6;
	var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
	var left = $(searchDiv).offset().left + $(searchDiv).outerWidth()
			- contentWidth;
	var text = $(searchDiv).text();
	var width = $(searchDiv).innerWidth();

	layer.config({
		extend : 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	layer.open({
		type : 1,
		shift : 5,
		title : false,
		scrollbar : false,
		move : false,
		area : [ contentWidth + 'px', '400px' ],
		offset : [ top + 'px', left + 'px' ],
		closeBtn : 0,
		shadeClose : true,
		btn : [ '查询', '清空', '取消' ],
		content : $(this._searchDialogId),
		success : function(layero, index) {
			var serachLabel = $(
					'<div class="serachLabel"><span>' + text
							+ '</span><span class="caret"></span></div>')
					.appendTo(layero);
			serachLabel.bind('click', function() {
				layer.close(index);
			});
			serachLabel.css('width', width + 'px');
		},
		yes : function(index, layero) {
			_self.searchData();
			layer.close(index);
		},
		btn2 : function(index, layero) {
			_self.clearData();
			return false;
		},
		btn3 : function(index, layero) {

		}
	});
};
/*清空查询条件*/
SysJobCalendarDate.prototype.clearData = function() {
	clearFormData(this.searchForm);
	this.searchData();
};
