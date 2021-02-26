/**
 * 
 */
function SoapWebservice(formSub,searchSubNames,keyWord,searchDialogSub,datagrid, url, form,parentId) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this._datagridId = "#" + datagrid;
	this._jqgridToolbar = "#t_" + datagrid;
	this._searchDialogId = "#" + searchDialogSub;
	this._keyWordId = "#" + keyWord;
	this._searchNames = searchSubNames;
	this.searchForm = "#" + formSub;
	this._doc = document;
	this._formId = "#" + form;
	this._parentId = parentId;
	this.Pagerlbar = "#" + datagrid + "Pager";
	
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
SoapWebservice.prototype.init = function() {
	var _self = this;
	var param = {id:_self._parentId};
	$(_self._datagridId).jqGrid({
		url : _self.getUrl() + 'getSoapWebservicesByPage.json',
		mtype : 'POST',
		postData : param,
		datatype : "json",
		toolbar : [ false, 'top' ],
		colModel : _self.dataGridColModel,
		height : $(window).height() - 120-40,
		scrollOffset : 20, //设置垂直滚动条宽度
		rowNum : 20,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		userDataOnFooter : true,
		pagerpos : 'left',
		hasTabExport:false, //导出
		hasColSet:false,  //设置显隐
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
		responsive : true,//开启自适应
		pager : _self.Pagerlbar
	});
	$(this._jqgridToolbar).append($("#tableToolbar"));
};

//重载数据
SoapWebservice.prototype.reLoad = function(id) {
	if (id != undefined) {
		this._parentId = id;
	}
	var searchdata = {
		//param : JSON.stringify({classId:id})
		id : id
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关闭对话框
SoapWebservice.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
//打开高级查询框
SoapWebservice.prototype.openSearchForm = function(searchDiv, par) {
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
SoapWebservice.prototype.searchData = function() {
	var searchdata = {
		id : this._parentId,
		keyWord : "",
		searchParam : JSON.stringify(serializeObject($(this.searchForm)))
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关键字段查询
SoapWebservice.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for (var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}

	var searchdata = {
		keyWord : JSON.stringify(param),
		id : this._parentId
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
/*清空查询条件*/
SoapWebservice.prototype.clearData = function() {
	clearFormData(this.searchForm);
	//this.searchData();
};

SoapWebservice.prototype.getSelectRow = function(){
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
