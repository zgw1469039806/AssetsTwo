/**
 * 
 */
function SysProfileOption(datagrid, url, searchForm, dataGridColModel,
		searchDialog, afterInit, clickRowLoad, searchMainNames,
		demoMainDept_KeyWord, appid) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	};
	this.appid = appid;
	this._datagridId = "#" + datagrid;
	this.Toolbardiv = "#t_" + datagrid;
	this.Toolbar = "#toolbar_" + datagrid;
	this._searchDialogId = "#" + searchDialog;
	this.Pagerlbar = "#" + datagrid + "Pager";
	this.searchForm = "#" + searchForm;
	this._keyWordId = "#" + demoMainDept_KeyWord;
	this._searchNames = searchMainNames;
	this.dataGridColModel = dataGridColModel;
	this.afterInit = afterInit;
	this.clickRowLoad = clickRowLoad;
	this.init.call(this);
}
//初始化操作
SysProfileOption.prototype.init = function() {
	var _self = this;
	var issubinit = false;
	$(_self._datagridId).jqGrid({
		url : this.getUrl() + 'getSysProfileOptionsByPage.json',
		postData: {    
			appid: _self.appid  
		},  
		mtype : 'POST',
		multiselect : true,
		datatype : "json",
		toolbar : [ true, 'top' ],
		colModel : this.dataGridColModel,
		height : $(window).height() - 120 - 17,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		scrollOffset : 10,
		rowNum : 20,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		userDataOnFooter : true,
		pagerpos : 'left',
		styleUI : 'Bootstrap',
		viewrecords : true,
		multiboxonly : true,
		autowidth : true,
		shrinkToFit : true,
		hasTabExport:false, //导出
		hasColSet:false,  //设置显隐
		responsive : true,
		pager : _self.Pagerlbar,
		onSelectAll: function(){
			_self.clickRowLoad("");
		},
		onSelectRow : function(rowid, status) {
			var rows = $(_self._datagridId).jqGrid('getGridParam', 'selarrrow');
			if (issubinit &&  rows.length == 1) {
				_self.clickRowLoad(rows[0]);
			}else{
				if(issubinit){
					_self.clickRowLoad("");
				}
			}
		},
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
			var rowdata = $(_self._datagridId).jqGrid('getRowData');
			if (issubinit == false) {
				if (rowdata != null && rowdata.length > 0) {
					$(_self._datagridId).setSelection(rowdata[0].id);
					_self.afterInit(rowdata[0].id); 
					issubinit = true;
				} else {
					_self.afterInit("-1");
					issubinit = true;
				}
			} else {
				if (rowdata != null && rowdata.length > 0) {
					$(_self._datagridId).setSelection(rowdata[0].id);
					_self.clickRowLoad(rowdata[0].id);

				} else {
					_self.clickRowLoad("");
				}
			}
		}
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
SysProfileOption.prototype.getOption = function() {
	var ret = [];
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	if(rowData.siteEnabledFlag == "Y"){
		ret.push({"key":"1", "name":"地点"});
	}
	if(rowData.appEnabledFlag == "Y"){
		ret.push({"key":"2", "name":"应用"});
	}
	if(rowData.roleEnabledFlag == "Y"){
		ret.push({"key":"3", "name":"角色"});
	}
	if(rowData.userEnabledFlag == "Y"){
		ret.push({"key":"4", "name":"用户"});
	}
	if(rowData.deptEnabledFlag == "Y"){
		ret.push({"key":"5", "name":"部门"});
	}
	return ret;
};

//添加页面
SysProfileOption.prototype.insert = function() {
	if(this.appid == -11){
		layer.alert('公共数据必须属于一个应用，不能直接添加，请选择应用后添加！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			title:'提示',
			closeBtn : 0
		});
		return false;
	}
	this.insertIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '添加',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : this.getUrl() + 'Add/null'
	});
};
//编辑页面
SysProfileOption.prototype.modify = function() {
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择要编辑的数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			title:'提示',
			closeBtn : 0
		});
		return false;
	} else if (ids.length > 1) {
		layer.alert('只允许选择一条数据，进行编辑！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			title:'提示',
			closeBtn : 0
		});
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.eidtIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '编辑',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : this.getUrl() + 'Edit/' + rowData.id
	});
};
//详细页
SysProfileOption.prototype.detail = function(id) {
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
SysProfileOption.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			sysApplicationId : {
				maxlength : 50
			},
			profileOptionCode : {
				required: true,
				maxlength : 50
			},
			profileOptionName : {
				required: true,
				maxlength : 100
			},
			description : {
				maxlength : 240
			},
			ynMultiValue : {
				maxlength : 1
			},
			userChangeableFlag : {
				maxlength : 1
			},
			userVisibleFlag : {
				maxlength : 1
			},
			siteEnabledFlag : {
				maxlength : 1
			},
			appEnabledFlag : {
				maxlength : 1
			},
			roleEnabledFlag : {
				maxlength : 1
			},
			userEnabledFlag : {
				maxlength : 1
			},
			deptEnabledFlag : {
				maxlength : 1
			},
			sqlValidation : {
				maxlength : 500
			},
			validFlag : {
				maxlength : 1
			},
			systemFlag : {
				maxlength : 1
			},
			usageModifier : {
				maxlength : 1
			},
		}
	});
};
//保存功能
SysProfileOption.prototype.save = function(form, idType) {
	var _self = this;
	var code = form.find("input[type=text][name='profileOptionCode']").val();
	var rowData = $(this._datagridId).jqGrid('getRowData');
	var id = form.find("input[type=hidden][name='id']").val();
	var data = [];
	$.each(rowData ,function(i,item){
		if(code == item.profileOptionCode){
			data[i] = item.profileOptionCode;
		}
	});
	for(var i=0;i<(data.length);i++){
		if(data[i] == code && id ==""){
			layer.alert('文件代码重复！', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0
			});
			return ;
		}
	}
	var datas = serializeObject(form);
	var checkboxElment = form.find("input[type=checkbox]");
	$.each(checkboxElment ,function(i,item){
		if(!$(item).is(':checked')){
			var checkName = item.name;
			if(datas[checkName] == ""){
				datas[checkName] = "N";
			}
		}
	});
	avicAjax.ajax({
		url : _self.getUrl() + "save",
		data : {
			data : JSON.stringify(datas),
			appid : _self.appid
		},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.reLoad();
				if (idType == "insert") {
					layer.close(_self.insertIndex);
				} else {
					layer.close(_self.eidtIndex);
				}
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
SysProfileOption.prototype.del = function() {
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		layer.confirm('确认要删除选择的数据吗? 数据的级别信息也会被删除！', {
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
						_self.reLoad();
					} else {
						layer.alert('删除失败！' + r.error, {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0
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
			 title:'提示'
		});
	}
};

SysProfileOption.prototype.importProfile = function() {
    var _self = this;
    layer.open({
        type : 2,
        area : [ '70%', '70%' ],
        title : '导入',
        skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin : false, //开启最大化最小化按钮
        content : _self.getUrl() + 'importManage',
        cancel: function(index, layero){
            var iframeWin = $(layero).find('iframe')[0].contentWindow;
            if (iframeWin.needReload == true) {
                _self.reLoad();
            }
        }
    });
};
SysProfileOption.prototype.exportProfile = function() {
    var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    var _self = this;
    var ids = [];
    var l = rows.length;
    if (l > 0) {
        for (; l--;) {
            ids.push(rows[l]);
        }
        var params = {};
        params.ids = JSON.stringify(ids);
        var url = _self.getUrl() + 'export';
        var ep = new exportData('export', 'export', params, url);
        ep.excuteExport();
    } else {
        parent.layer.alert('请选择要导出的数据！', {
            icon: 0,
            title: '提示',
            area: ['400px', ''],
            closeBtn: 0
        });
    }

};

//重载数据
SysProfileOption.prototype.reLoad = function(appid) {
	this.appid = appid;
	var searchdata = {};
	if(appid == null || appid == ""){
		searchdata = {
			param : JSON.stringify(serializeObject($(this.searchForm)))
		};
	}else{
		searchdata = {
			param : JSON.stringify(serializeObject($(this.searchForm))),
			appid : appid
		};
	}
	
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
/**
 * 点击左侧应用切换
 * @param appid
 */
SysProfileOption.prototype.switchApp = function(appid) {
    if(appid === this.appid){
        // reload
        $(this._datagridId).trigger("reloadGrid");
        return;
    }
    this.appid = appid;
    // 重置发送到后端的数据
    var searchdata = {};
    if(appid != null && appid != ''){
        searchdata = {
            appid : appid,
            keyWord: null,
            param : null
        }
    }

    $(this._datagridId).jqGrid('setGridParam', {
        datatype : 'json',
        postData : searchdata
    }).trigger("reloadGrid");
};

//关闭对话框
SysProfileOption.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
//打开高级查询框
SysProfileOption.prototype.openSearchForm = function(searchDiv, par) {
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
//高级查询
SysProfileOption.prototype.searchData = function() {
	var searchdata = {
		keyWord : null,
		param : JSON.stringify(serializeObject($(this.searchForm)))
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关键字段查询
SysProfileOption.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val()==$(this._keyWordId).attr("placeholder") ? "" :  $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for ( var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
		keyWord : JSON.stringify(param),
		param : null
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//隐藏查询框
SysProfileOption.prototype.hideSearchForm = function() {
	layer.close(searchDialogindex);
};
/*清空查询条件*/
SysProfileOption.prototype.clearData = function() {
	clearFormData(this.searchForm);
	this.searchData();
};
