function DiggerMutilHeaderGrid(datagrid,url,mutilHeaderGridModel,diggerId){
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
	this._mutilHeaderGridModel = mutilHeaderGridModel;
	this._diggerId = diggerId;
	this.init.call(this);
};
//初始化操作
DiggerMutilHeaderGrid.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
		url: this.getUrl() + 'platform/digger/diggerManageController/getDiggerMultiHeaderJsonData?diggerId=' + _self._diggerId,
		mtype: 'POST',
		datatype: "json",
		toolbar: [true,'top'],
		colModel: this._mutilHeaderGridModel,
		height:$(window).height()-500,
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
	$(this._jqgridToolbar).append($("#queryTableToolbar"));
};

function getLayerTypeColumnValue(value){
	if(value == "一级表头"){
		return '1';
	} else if(value == "二级表头"){
		return '2';
	}else if(value == "三级表头"){
		return '3';
	} else{
		return "";
	}
}

//保存功能
DiggerMutilHeaderGrid.prototype.save = function(form){
	var _self = this;
	var jsonData = getMutilHeaderGridJsonData();
	if(!jsonData){
		return;
	}
	var diggerId =  form.find("#diggerId").val();
	var parm = "diggerId=" + diggerId + "&jsonData=" + jsonData;
	avicAjax.ajax({
		url : "platform/digger/diggerManageController/saveDiggerMutilHeaderConfig",
		data : parm,
		type : 'post',
		dataType : 'text',
		success : function(r){
			layer.msg('保存成功！');
			_self.reLoad();
		},
		error : function(r){
			layer.alert('保存失败！' + r, {
					icon: 7,
					area: ['400px', ''], //宽高
					closeBtn: 0,
					btn: ['关闭'],
					title:"提示"
				}
			);
		}
	});
};
//获取diggerQueryGrid修改的son数据
function getMutilHeaderGridJsonData(){
	var _self = this;
	var rows= $("#mutilHeaderGrid").jqGrid("getRowData");
	var l = rows.length,cache= {};
	for( ; l-- ; ){
		row =rows[l];
		if(row.headerName ==''){
			layer.alert('表头列名称不允许为空，请输入！', {
					icon: 0,
					title :'提示',
					area: ['400px', ''], //宽高
					closeBtn: 0
				}
			);
			return;
		}
		if(cache['n' + row.headerName]){
			layer.alert('输入的表头列名称已经存在，请重新输入！' , {
					icon: 0,
					title :'提示',
					area: ['400px', ''], //宽高
					closeBtn: 0
				}
			);
			return false;
		}
		cache["n"+row.fieldName]='cunzai';

	}
	$("#mutilHeaderGrid").jqGrid('endEditCell');
	if(!checkColSpanValue()){
		return false;
	}
	var data = $("#mutilHeaderGrid").jqGrid('getChangedCells');
	if(data && data.length > 0){
		for(var i = 0; i < data.length; i++){
			if(data[i].id.indexOf(newRowStart) > -1){
				data[i].id = '';
			}
			data[i].layer = getLayerTypeColumnValue(data[i].layer);
		}
		return JSON.stringify(data);
	}else{
		layer.alert('没有修改的数据！', {
				icon: 0,
				area: ['400px', ''], //宽高
				closeBtn: 0,
				title:'提示'
			}
		);
	}
}

/**
 * 校验跨越列数colspan是否等行总的列数
 * @returns {boolean}
 */
function checkColSpanValue(){
	var rows = $("#mutilHeaderGrid").jqGrid("getRowData");
	var colspans = 0;
	var colspanTotal = $("#colSpanTotal").val();
	for(var i = 0; i < rows.length; i++){
		var row = rows[i];
		var tmp = 0;
		if(isNaN(row.colspan)){
			tmp = $(row.colspan).val();
		} else {
			tmp = row.colspan;
		}
		colspans = colspans + parseInt(tmp);
	}
	if(colspans != parseInt(colspanTotal)){
		layer.alert('跨越列数总合必须等于' + colspanTotal + '，请输入！', {
				icon: 0,
				title :'提示',
				area: ['400px', ''], //宽高
				closeBtn: 0
			}
		);
		return false;
	}
	return true;
}

/**
 * 添加行
 */
var newRowIndex = 0;
var newRowStart = "new_row";
DiggerMutilHeaderGrid.prototype.insert = function(){
	$(this._datagridId).jqGrid('endEditCell');
	var newRowId = newRowStart + newRowIndex;
	var parameters = {
		rowID : newRowId,
		initdata : {},
		role :"first",
		useDefValues : true,
		useFormatter : true,
		addRowParams : {extraparam:{}}
	};
	$(this._datagridId).jqGrid('addRow', parameters);
	newRowIndex++;

};


//删除
DiggerMutilHeaderGrid.prototype.del=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确认要删除选中的数据吗?',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
			for(;l--;){
				ids.push(rows[l]);
			}
			avicAjax.ajax({
				url:_self.getUrl() +'platform/digger/diggerManageController/deleteDiggerMultiHeaderGridData',
				data:	JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r){
					if (r.flag == "success") {
						_self.reLoad();
					}else{
						layer.alert('删除失败！' + r.error, {
								icon: 7,
								area: ['400px', ''],
								closeBtn: 0,
								btn: ['关闭'],
								title:"提示"
							}
						);
					}
				}
			});
			layer.close(index);
		});
	}else{
		layer.alert('请选择要删除的数据！', {
				icon: 7,
				area: ['400px', ''], //宽高
				closeBtn: 0,
				btn: ['关闭'],
				title:"提示"
			}
		);
	}
};
//重载数据
DiggerMutilHeaderGrid.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this._formId)))}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};

function formatLayerTypeColumn(cellvalue, options, rowObject) {
	if(cellvalue == "1"){
		return '一级表头';
	} else if(cellvalue == "2"){
		return '二级表头';
	}else if(cellvalue == "3"){
		return '三级表头';
	} else{
		return "";
	}
}


