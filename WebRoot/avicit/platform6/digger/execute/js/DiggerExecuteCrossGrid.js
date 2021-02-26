function DiggerExecuteCrossGrid(datagrid, url, dataGridColModel, diggerId,rownumbers,isDisplayPage,condition){
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
	this._condition = condition;
	this._rownumbers = rownumbers;
	this._isDisplayPage = isDisplayPage;
	this.init.call(this);
};
//初始化操作
DiggerExecuteCrossGrid.prototype.init= function(){
	var _self = this;
	var options = _self.getOptions();
	if(_self._isDisplayPage){//分页
		options = _self.getOptionsByPage();
	}
	$(_self._datagridId).jqGrid(options);
};

// 查询
DiggerExecuteCrossGrid.prototype.executeQuery = function(conditions){
	var _self = this;
	var paramData = {
		queryCondition : conditions
	};
	$(_self._datagridId).jqGrid('setGridParam',{postData: paramData}).trigger("reloadGrid");
	return;
};

DiggerExecuteCrossGrid.prototype.getOptionsByPage = function(){
	var height = 200;
	if($("#condition").css('display') == 'none'){
		height = 140;
	}
	var _self = this;
	var option = {
		url: this.getUrl() + 'platform/digger/diggerExecuteController/getCrossJSONData?diggerId=' + _self._diggerId + "&condition=" + _self._condition,
		mtype: 'POST',
		datatype: "json",
		colModel: this.dataGridColModel,
		height:$(window).height() - height,
		scrollOffset: 20, //设置垂直滚动条宽度
		rowNum: 20,
		rowList:[200,100,50,30,20,15,10,5],
		pager: "#jqGridPager",
		altRows:true,
		userDataOnFooter: true,
		pagerpos:'left',
		styleUI : 'Bootstrap',
		viewrecords: true,
		autowidth: true,
		shrinkToFit: true,
		rownumbers : _self._rownumbers,
		cellsubmit: 'clientArray',
		hasColSet:false,
		hasTabExport:false,
		responsive:true,//开启自适应
		gridComplete:function(){
			var ids = $(_self._datagridId).getDataIDs();
			for(var i = 0 ; i < ids.length;i++){
				var rowData = $(_self._datagridId).getRowData(ids[i]);
				if(rowData.CROSSTABLEHEADER == '总计'){
					$('#'+ids[i]).find("td").addClass("totalBackgroupColor");
				}
			}
			_self.setMultiHeaders();
		}
	};
	return option;
};
DiggerExecuteCrossGrid.prototype.getOptions = function(){
	var _self = this;
	var option = {
		url: this.getUrl() + 'platform/digger/diggerExecuteController/getCrossJSONData?diggerId=' + _self._diggerId + "&condition=" + _self._condition,
		mtype: 'POST',
		datatype: "json",
		colModel: this.dataGridColModel,
		height:$(window).height() - 200,
		scrollOffset: 20, //设置垂直滚动条宽度
		rowNum: 1000000,
		rowList:[200,100,50,30,20,15,10,5],
		altRows:true,
		userDataOnFooter: true,
		pagerpos:'left',
		styleUI : 'Bootstrap',
		viewrecords: true,
		autowidth: true,
		shrinkToFit: true,
		rownumbers : _self._rownumbers,
		cellsubmit: 'clientArray',
		hasColSet:false,
		hasTabExport:false,
		responsive:true,//开启自适应
		gridComplete:function(){
			var ids = $(_self._datagridId).getDataIDs();
			for(var i = 0 ; i < ids.length;i++){
				var rowData = $(_self._datagridId).getRowData(ids[i]);
				if(rowData.CROSSTABLEHEADER == '总计'){
					$('#'+ids[i]).find("td").addClass("totalBackgroupColor");
				}
			}
			_self.setMultiHeaders();
		}
	};
	return option;
}
DiggerExecuteCrossGrid.prototype.setMultiHeaders = function(){
	var _self = this;
	$.ajax({
		url: "platform/digger/diggerExecuteController/getMultiHeader?diggerId=" + $('#diggerId').val(),
		type: "get",
		async: false,
		dataType: "json",
		success: function (backData) {
			$( _self._datagridId).jqGrid('setGroupHeaders', {
				useColSpanStyle: true,
				groupHeaders: backData
				// 	[
				// 	{ startColumnName: 'RISK_NUM', numberOfColumns: 3, titleText: '组团' },
				// 	{ startColumnName: 'RESPONSIBLE_USER_ID', numberOfColumns: 6, titleText: '双跨参团' }
				// ]
			});
		},
		error: function(backData){

		}
	});

}




