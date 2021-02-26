/**
 * @author zhanglei
 */
function ChooseLanguage(datagrid,url,dataGridColModel){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	this._datagridId="#"+datagrid;
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this.dataGridColModel = dataGridColModel;
	this.Pagerlbar = "#" + datagrid + "Pager";
	this.init.call(this);
}

ChooseLanguage.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : _self.getUrl() + 'getAllLanguage.json',
		mtype : 'POST',
		multiselect : false,
		datatype : "json",
		toolbar : [ false, 'top' ],
		colModel : _self.dataGridColModel,
		height : $(window).height() - 120 - 17,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		scrollOffset : 10,
		rowNum : 20,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		userDataOnFooter : true,
		pagerpos : 'left',
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		styleUI : 'Bootstrap',
		cellsubmit : 'clientArray',
		cellEdit : true,
		hasTabExport:false, //导出
		hasColSet:false,  //设置显隐
		viewrecords : true,
		//multiboxonly : true,
		autowidth : true,
		shrinkToFit : true,
		responsive : true,
		rownumbers:true
	});
};

//保存
ChooseLanguage.prototype.save=function(type){
	var _self = this;
	var arr = [];
	$(_self._datagridId).jqGrid('endEditCell');
	var Changedata = $(_self._datagridId).jqGrid('getChangedCells');
	var srowData= $(_self._datagridId).jqGrid('getRowData');
	for(var o in Changedata){
		var rowData= $(this._datagridId).jqGrid('getRowData', Changedata[o].id);
		arr.push(rowData);
	}
	var data =JSON.stringify(arr);
	if(data.length > 0){
		 $.ajax({
			 url: _self.getUrl()+'/save.json',
			 data : {datas : data},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					 layer.msg('保存成功！');
					 if (type != null && type =='1'){
						 parent.sysLookupType.reLoad();
						 parent.closeL();
					 }else if(type != null && type =='2'){
						 parent.sysLookup.reLoad();
						 parent.closeLook();
					 }
				 }else{
					 layer.alert('保存失败！' + r.error, {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0
					 });
				 } 
			 }
		 });
	 }else{
		 layer.alert('没有要提交的数据！', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0
		 });
	 } 
};

