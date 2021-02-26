/**
 * 
 */
function RestResourceManage(datagrid, url, searchD, form, keyWordId, searchNames,
		dataGridColModel,initId) {
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
	this.initId = initId;
	this.init.call(this);
	this.hasInit = false;
};
//初始化操作
RestResourceManage.prototype.init = function() {
	var _self = this;
	var param = {systemId:_self.initId};
	$(_self._datagridId).jqGrid({
		url : 'platform6/newrestmanage/controller/ResteasyResourcesController/operation/getResteasyResourcessByPage.json',
		mtype : 'POST',
		datatype : "json",
		postData : param,
		toolbar : [ true, 'top' ],
		colModel : this.dataGridColModel,
		height : this._doc.documentElement.clientHeight-160,//$('#east1').height()-110
		scrollOffset : 20, //设置垂直滚动条宽度
		rowNum : 20,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		userDataOnFooter : true,
		pagerpos : 'left',
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		styleUI : 'Bootstrap',
		viewrecords : true,
		multiselect : true,
		autowidth : true,
		shrinkToFit : true,
		hasTabExport:false, //导出
		hasColSet:false,  //设置显隐
		responsive : true,//开启自适应
		pager : "#jqGridPager",
		rownumbers:false,
		loadComplete:function(){
			$("#jqGridPager").find("table").css("font-size","12px");
			if(! _self.hasInit){
                setTimeout(function(){
                    $(document).trigger('resize');
                    _self.hasInit = true;
                },100)
            }
		}
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
	$(_self._keyWordId).on('keydown', function(e) {
		if (e.keyCode == '13') {
			_self.searchByKeyWord();
		}
	});
};
//添加页面
RestResourceManage.prototype.insert = function(pid) {
	_self = this,
	avicAjax.ajax({
		url : 'platform6/newrestmanage/controller/ResteasyResourcesController/operation/judge',
		data : JSON.stringify(pid),
		contentType : 'application/json',
		type : 'post',
		async : false,
		dataType : 'json',
		success : function(r) {
			if (r.flag == "system") {
				_self.insertIndex = layer.open({
					type : 2,
					area : [ '60%', '60%' ],
					title : '添加',
					skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
					maxmin : false, //开启最大化最小化按钮
					content : 'platform6/newrestmanage/controller/ResteasyResourcesController/operation/Add/null/'+pid
				});
			} else if(r.flag == "org"){
				layer.alert('请选择服务节点！' , {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0,
					title : '提示'
				});
			}
		}
	});
};
//编辑页面
RestResourceManage.prototype.modify = function() {
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择要编辑的数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return false;
	} else if (ids.length > 1) {
		layer.alert('只允许选择一条数据，进行编辑！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.eidtIndex = layer.open({
				type : 2,
				area : [ '60%', '60%' ],
				title : '编辑',
				skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
				maxmin : false, //开启最大化最小化按钮
				content : 'platform6/newrestmanage/controller/ResteasyResourcesController/operation/Edit/' + rowData.id+'/null'
			});
};
//详细页
RestResourceManage.prototype.detail = function(id) {
	this.detailIndex = layer.open({
				type : 2,
				area : [ '100%', '100%' ],
				title : '详细页',
				skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
				maxmin : false, //开启最大化最小化按钮
				content : 'platform6/system/wordTemplet/SysWordTempletController/operation/'
						+ 'Detail/' + id
			});
};
//保存服务设置
RestResourceManage.prototype.saveConfig = function() {
	thisUrl='platform/restmanage/auth/add.html';
	
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择要保存的数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return false;
	} else if (ids.length > 1) {
		layer.alert('只允许选择一条数据，进行保存！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	var res = rowData.id;
	var systemIdTemp = rowData.systemId;
	avicAjax.ajax({
		url : thisUrl,
		data : {
			systemId:systemIdTemp,
			res:res
		},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			
				layer.msg('保存成功！');
			
		}
	});
};
//打开高级查询框
RestResourceManage.prototype.openSearchForm = function(searchDiv) {
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
		area : [ contentWidth + 'px', '200px' ],
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
			$("#systemId").empty();
			$.ajax({  
	            url: 'platform/platform6/newrestmanage/controller/resteasySystemController/operation/listAll',  
	            data : {
				 	id : ""
				},
			    type : 'post',
	            dataType: "json",  
	            success: function (data) {  
	            	$("#systemId").append("<option></option>");  
	                $.each(data, function (index, units) {  
	                    $("#systemId").append("<option value="+units.id+">" + units.systemName + "</option>");  
	                });
	            },  
	
	            error: function (XMLHttpRequest, textStatus, errorThrown) {  
	                alert("error");  
	            }  
	        });
			return false;
		},
		btn3 : function(index, layero) {

		}
	});
};
//控件校验   规则：表单字段name与rules对象保持一致
RestResourceManage.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			restUrl : {
				required : true,
				maxlength : 200,
				alnum : true
			},
			urlDesc : {
				required : true,
				maxlength : 500
			},
			orgId : {
				maxlength : 50,
				required : true
			},
			systemId : {
				required : true,
				maxlength : 100
			},
			status : {
				maxlength : 2,
				required : true
			}
		}
	});
}
//保存功能
RestResourceManage.prototype.save = function(form, id) {
	var _self = this;
	avicAjax.ajax({
		url : 'platform6/newrestmanage/controller/ResteasyResourcesController/operation/save',
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
					closeBtn : 0
				});
			}
		}
	});
};
//删除
RestResourceManage.prototype.del = function() {
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		layer.confirm('确认要删除选择的数据吗?', {
			icon : 3,
			title : "提示",
			closeBtn : 0,
			area : [ '400px', '' ]
		}, function(index) {
			for (; l--;) {
				ids.push(rows[l]);
			}
			avicAjax.ajax({
				url : 'platform6/newrestmanage/controller/ResteasyResourcesController/operation/delete',
				data : JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success") {
						_self.reLoad();
						layer.msg('删除成功！');
					} else {
						layer.alert('删除失败！' + r.error, {
							icon : 7,
							area : [ '400px', '' ],
							title : "提示",
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
			title :'提示'
		});
	}
};
//重载数据
RestResourceManage.prototype.reLoad = function(pid) {
	if(pid != null){
		this.pid = pid;
	}
	var searchdata = {
		systemId:this.pid
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关闭对话框
RestResourceManage.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
//高级查询
RestResourceManage.prototype.searchData = function() {
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
RestResourceManage.prototype.searchByKeyWord = function() {
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
RestResourceManage.prototype.hideSearchForm = function() {
	layer.close(searchDialogindex);
};
/*清空查询条件*/
RestResourceManage.prototype.clearData = function() {
	clearFormData(this._formId);
	this.searchData();
};
