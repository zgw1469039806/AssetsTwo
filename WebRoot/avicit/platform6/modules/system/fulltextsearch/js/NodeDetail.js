/**
 * 
 */
function NodeDetail(datagrid, url, searchD, form, keyWordId, searchNames,length,canRead) {
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
	this._length = length;
	this._canRead = canRead;
	function formatIndexType(cellvalue, options, rowObject) {
		
	}
	var dataGridColModel = [ {
		label : '大小',
		name : 'length',
		width : 60
	}, {
		label : '是否可读',
		name : 'canRead',
		width : 60
	}];
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
//初始化操作
NodeDetail.prototype.init = function() {
	var _self = this;
	var param = {length:_self.length,canRead:_self.canRead};
	$(_self._datagridId).jqGrid({
		url : '',
		mtype : 'POST',
		postData : param,
		datatype : "local",
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
		multiselect : false,
		autowidth : true,
		shrinkToFit : true,
		responsive : true,//开启自适应
		pager : "#jqGridPager"
	});
	$(this._jqgridToolbar).append($("#tableToolbar"));

};
/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
NodeDetail.prototype.insert = function(length1,canRead1) {
	var _self = this;
	$(_self._datagridId).jqGrid("clearGridData");

	var newRowId = newRowStart + newRowIndex;
	var parameters = {
		rowID : newRowId,
		initdata : {length : length1,canRead : canRead1},
		position : "first",
		useDefValues : true,
		useFormatter : true,
		addRowParams : {
			extraparam : {}
		}
	};
	$(_self._datagridId).jqGrid('addRow', parameters);
};
