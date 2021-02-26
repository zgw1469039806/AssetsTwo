function DiggerExecuteDetailGrid(datagrid, url, dataGridColModel, diggerId,paramName,seriesName,condition){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	var	_url=url;
	this.getUrl = function(){
		return _url;
	}
	this._datagridId="#" + datagrid;
	this._jqgridToolbar="#t_" + datagrid;
	this._doc = document;
	this.dataGridColModel = dataGridColModel;
	this._diggerId = diggerId;
	this._paramName = paramName;
	this._seriesName = seriesName;
	this._condition = condition;
	this.init.call(this);
};
//初始化操作
DiggerExecuteDetailGrid.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
		url: this.getUrl() + 'platform/digger/diggerExecuteController/getDisplayDetailJSONData?diggerId=' + _self._diggerId + '&paramName=' + _self._paramName + '&seriesName=' + _self._seriesName + '&condition=' + _self._condition,
		mtype: 'POST',
		datatype: "json",
		toolbar: [true,'top'],
		colModel: this.dataGridColModel,
		height:$(window).height()-120,
		scrollOffset: 20, //设置垂直滚动条宽度
		rowNum: 20	,
		rowList:[200,100,50,30,20,10],
		altRows:true,
		userDataOnFooter: true,
		pagerpos:'left',
		styleUI : 'Bootstrap',
		viewrecords: true,
		multiselect: true,
		autowidth: true,
		shrinkToFit: true,
		responsive:true,//开启自适应
		pager: "#jqGridPager",
		cellEdit:true,
		cellsubmit: 'clientArray'

	});
};





