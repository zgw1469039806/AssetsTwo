function OutDataSourceTableModel(datagrid, url, formSub, dataGridColModel, searchDialogSub, nodeId, nodeType,searchSubNames, bpmHistProcinst_KeyWord) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this.pageId = datagrid+"Pager";
	this._searchDialogId = "#" + searchDialogSub;
	this.searchForm = "#" + formSub;
	this.nodeId = nodeId;
	this._datagridId = "#" + datagrid;
	this.Toolbardiv = "#t_" + datagrid;
	this.Toolbar = "#toolbar_" + datagrid;
	this.Pagerlbar = "#" + datagrid + "Pager";
	this._keyWordId = "#" + bpmHistProcinst_KeyWord;
	this._searchNames = searchSubNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
//初始化操作
OutDataSourceTableModel.prototype.init = function() {
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl(),
		postData : {
			nodeId : _self.nodeId,
			tableName : ''
		},
		mtype : 'POST',
		datatype : "json",
		toolbar : [ false, 'top' ],
		colModel : this.dataGridColModel,
		height : $(window).height() - 250, //120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		width : $(window).width()-270,
		scrollOffset : 10, //设置垂直滚动条宽度
		rowNum : 'all',//每页数量
		altRows : true,//斑马纹
		pagerpos : 'left',
		viewrecords : true, //是否显示总记录数
		styleUI : 'Bootstrap',
		multiselect :true,//是否可以多选
		autowidth : true,
		responsive : true //开启自适应

	});
	
	$(_self.Toolbardiv).append($(_self.Toolbar));

	$(_self._keyWordId).on('keydown', function(e) {
		if (e.keyCode == '13') {
			_self.searchByKeyWord();
		}
	});
};


//控件校验   规则：表单字段name与rules对象保持一致
OutDataSourceTableModel.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			
		}
	});
};

//重载数据
OutDataSourceTableModel.prototype.reLoad = function(nodeId) {
	if (nodeId != undefined) {
		this.nodeId = nodeId;
	}
	
	var searchdata = {
		nodeId : nodeId,
		tableName : ''
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关闭对话框
OutDataSourceTableModel.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
//打开高级查询框
OutDataSourceTableModel.prototype.openSearchForm = function(searchDiv, par) {
	var _self = this;
	par = null;
	//if(!par) par = $(window);
	var contentWidth = 600; //(par.width()*.6 >= 600)?600:par.width()*.6;
	var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
	var left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
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
		area : [ contentWidth + 'px', '350px' ],
		offset : [ top + 'px', left + 'px' ],
		closeBtn : 0,
		shadeClose : true,
		btn : [ '查询', '清空', '取消' ],
		content : $(this._searchDialogId),
		success : function(layero, index) {
			var serachLabel = $('<div class="serachLabel"><span>' + text + '</span><span class="caret"></span></div>').appendTo(layero);
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
		btn3 : function(index, layero) {}
	});
};
//高级查询
OutDataSourceTableModel.prototype.searchData = function() {
	var searchdata = {
		nodeId : this.nodeId,
		searchParam : JSON.stringify(serializeObject($(this.searchForm)))
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关键字段查询
OutDataSourceTableModel.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for (var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}

	var searchdata = {
		keyWord : JSON.stringify(param),
		nodeId : this.nodeId
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};




//隐藏查询框
OutDataSourceTableModel.prototype.hideSearchForm = function() {
	layer.close(searchDialogindex);
};
/*清空查询条件*/
OutDataSourceTableModel.prototype.clearData = function() {
	clearFormData(this.searchForm);
	//this.searchData();
};