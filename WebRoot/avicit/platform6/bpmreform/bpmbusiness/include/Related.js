function Related(datagrid, url, dataGridColModel,form,nodeId,nodeType,pdId,keyWordId,searchNames) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this.nodeId = nodeId;
	this.nodeType = nodeType;
	this.pdId=pdId;
	this._formId = "#" + form;
	this._keyWordId = "#" + keyWordId;
	this._searchNames = searchNames;
	this._datagridId = "#" + datagrid;
	this.dataGridColModel = dataGridColModel;
	var _onSelect=function(){};//单击node事件
	this.getOnSelect=function(){
		return _onSelect;
	};
	this.setOnSelect=function(func){
		_onSelect=func;
	};
	this.init.call(this);
	
};
//初始化操作
Related.prototype.init = function() {
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl(),
		postData : {
			nodeId : _self.nodeId,
			nodeType : _self.nodeType,
			pdId : _self.pdId,
		},
		mtype : 'POST',
		datatype : "json",
		colModel : this.dataGridColModel,
		height : $(window).height() - 120 - 0, //120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		scrollOffset : 10, //设置垂直滚动条宽度
		rowNum : 10,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		pagerpos : 'left',
		viewrecords : true, 
		styleUI : 'Bootstrap',
		multiselect : true,
		autowidth : true,
		shrinkToFit : true,
		responsive : true, //开启自适应
		forceFit: true,
		pager : "#firstPager",
        onSelectRow: function(rowid) { //单击选择行的回调
            _self.getOnSelect()(rowid);
        }
    });
	$(_self._keyWordId).on('keydown', function(e) {
		if (e.keyCode == '13') {
			_self.searchByKeyWord();
		}
	});
};
//关键字段查询
Related.prototype.searchByKeyWord = function() {
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
Related.prototype.loadByAppId=function(nodeId,nodeType,pdId){
	this.nodeId=nodeId;
	this.nodeType=nodeType;
	this.pdId=pdId;
	$(this._datagridId).jqGrid('setGridParam',{postData:{nodeId:nodeId,nodeType:nodeType,pdId:pdId}}).trigger("reloadGrid");
};