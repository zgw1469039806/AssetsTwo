/**
 * 
 */
function SysSearchInfo(datagrid, url, searchD, form, keyWordId, searchNames,parentId) {
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
	this._parentId = parentId;
	function formatIndexType(cellvalue, options, rowObject) {
		
	}
	var dataGridColModel = [ {
		label : 'id',
		name : 'id',
		key : true,
		width : 60,
		hidden : true
	}, {
		label : '名称',
		name : 'name',
		width : 60
	}, {
		label : '分类',
		name : 'classifyName',
		width : 60
	}, {
		label : '检索类型',
		name : 'indexType',
		width : 60
	},{
		label : '打开方式',
		name : 'openType',
		width : 60
	}, {
		label : '描述',
		name : 'description',
		width : 60
	} ];
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
//初始化操作
SysSearchInfo.prototype.init = function() {
	var _self = this;
	var param = {id:_self._parentId};
	$(_self._datagridId).jqGrid({
		url : this.getUrl() + 'getSysSearchInfosByPage.json',
		mtype : 'POST',
		postData : param,
		datatype : "json",
		toolbar : [ true, 'top' ],
		colModel : this.dataGridColModel,
		height : $(window).height()-120,
		scrollOffset : 20, //设置垂直滚动条宽度
		rowNum : 20,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		userDataOnFooter : true,
		pagerpos : 'left',
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
			setTimeout(function(){
        		$(document).trigger('resize');
        	},100)
		},
		styleUI : 'Bootstrap',
		viewrecords : true,
		multiselect : true,
		autowidth : true,
		shrinkToFit : true,
        hasTabExport:false, //导出
        hasColSet:false,  //设置显隐
		responsive : true,//开启自适应
		pager : "#jqGridPager"
	});
	$(this._jqgridToolbar).append($("#tableToolbar"));

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
	//禁止时间和日期格式手输
	$('.date-picker').on('keydown', nullInput);
	$('.time-picker').on('keydown', nullInput);
	//回车查询
	$(_self._keyWordId).on('keydown', function(e) {
		if (e.keyCode == '13') {
			_self.searchByKeyWord();
		}
	});
};
//添加页面
SysSearchInfo.prototype.insert = function() {
	this.insertIndex = layer.open({
        type: 2,
        title: '添加全文检索配置',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content: "avicit/platform6/modules/system/fulltextsearch/searchConfig/addSearchConfig.jsp"
    });
};
//编辑页面
SysSearchInfo.prototype.modify = function() {
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择要编辑的数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
		return false;
	} else if (ids.length > 1) {
		layer.alert('只允许选择一条数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.eidtIndex = layer.open({
        type: 2,
        title: '编辑全文检索配置',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content: "avicit/platform6/modules/system/fulltextsearch/searchConfig/editSearchConfig.jsp?rowId=" + rowData.id
    });
};
//详细页
SysSearchInfo.prototype.detail = function(id) {
	this.detailIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '详细页',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : this.getUrl() + 'Detail/' + id
	});
};
//打开高级查询框
SysSearchInfo.prototype.openSearchForm = function(searchDiv) {
	var _self = this;
	var contentWidth = 800;
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
			layer.close(index);//查询框关闭
		},
		btn2 : function(index, layero) {
			_self.clearData();
			return false;
		},
		btn3 : function(index, layero) {

		}
	});
};
//控件校验   规则：表单字段name与rules对象保持一致
SysSearchInfo.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			name : {
				required: true,
				maxlength : 1000
			},
			classify : {
				required: true,
				maxlength : 50
			},
			indexType : {
				required: true,
				maxlength : 50
			},
			dataSource : {
				maxlength : 50
			},
			sqlState : {
				required: true,
				maxlength : 1000
			},
			openType : {
				maxlength : 255
			},
			openUrl : {
				required: true,
				maxlength : 255
			},
			description : {
				maxlength : 1000
			},
			attribute01 : {
				maxlength : 1000
			}
		}
	});
}
//保存添加功能
SysSearchInfo.prototype.save = function(form, id) {
	var _self = this;
	var saveType;
	if(id == "insert"){
		saveType = "saveAdd"
	}else{
		saveType = "saveEdit"
	}
	avicAjax.ajax({
		url : _self.getUrl() + saveType,
		data : {
			data : JSON.stringify(serializeObject(form))
			},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.reLoad();
				layer.msg('保存成功！');
				if (id == "insert") {
					
				} else {
					//如果修改了openUrl或者openType，则自动重建索引
					if(r.resultSign == "yes"){
						_self.buildIndex();
					}
				}
			} else {
				layer.alert('保存失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
			}
		}
	});
};
//删除
SysSearchInfo.prototype.del = function(classId) {
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		layer.confirm('确认要删除选中的数据及相关的索引、事件吗?', {
			icon : 3,
			title : "提示",
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
							closeBtn : 0,
							btn : [ '关闭' ],
							title : "提示"
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
			btn : [ '关闭' ],
			title : "提示"
		});
	}
};
//重载数据
SysSearchInfo.prototype.reLoad = function(id) {
	/*if (id != undefined) {
		this._parentId = id;
	}*/
	var searchdata = {
		//param : JSON.stringify({classId:id})
		id : id
	}
	/*var searchdata = {
		param : JSON.stringify(serializeObject($(this._formId)))
	}*/
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关闭对话框
SysSearchInfo.prototype.closeDialog = function(id) {
	var _this = this;
	if (id == "insert") {
		layer.close(_this.insertIndex);
	} else {
		layer.close(_this.eidtIndex);
	}
};
//高级查询
SysSearchInfo.prototype.searchData = function() {
	var searchdata = {
		keyWord : null,
		param : JSON.stringify(serializeObject($(this._formId)))
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关键字段查询
SysSearchInfo.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr(
			"placeholder") ? "" : $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for ( var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
		keyWord : JSON.stringify(param),
		param : null
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
}
//隐藏查询框
SysSearchInfo.prototype.hideSearchForm = function() {
	layer.close(searchDialogindex);
};
/*清空查询条件*/
SysSearchInfo.prototype.clearData = function() {
	clearFormData(this._formId);
	this.searchData();
};
//重建索引
SysSearchInfo.prototype.buildIndex = function() {
	var _self = this;
	avicAjax.ajax({
		url : _self.getUrl() + 'bulidIndex',
		contentType : 'application/json',
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				layer.msg('重建成功！');
			}else if(r.flag == "noSolr"){
				layer.alert('重建失败！请确认solr服务已启动！', {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
			}else{
				layer.alert('重建失败！', {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
			}
		}
	});
};
