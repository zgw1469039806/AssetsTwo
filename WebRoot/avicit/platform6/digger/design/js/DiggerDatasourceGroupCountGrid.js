function DiggerDatasourceGroupCountGrid(datagrid,url,dataGridColModel,diggerId){
	if(!datagrid || typeof(datagrid) !== 'string' && datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	var	_url = url;
	this.getUrl = function(){
		return _url;
	}
	this._datagridId="#" + datagrid;
	this._jqgridToolbar="#t_" + datagrid;
	this._doc = document;
	this.dataGridColModel = dataGridColModel;
	this._diggerId = diggerId;
	this.init.call(this);
};
//初始化操作
DiggerDatasourceGroupCountGrid.prototype.init = function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
		url: this.getUrl() + 'platform/digger/diggerManageController/getDiggerDatasourceGroupCountGridJsonData?diggerId=' + _self._diggerId,
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
		cellsubmit: 'clientArray',
		beforeEditCell : function(rowid, cellname, value, iRow, iCol){
			var dataSourceTypeValue = $('input[name="datasourcetype"]:checked').val();
			var diggerUrl = '';
			if(dataSourceTypeValue == 1){//获取选中的formId
				diggerUrl = $('#datasourceFormId').val();
			} else {//获取输入的sql语句
				diggerUrl = $('#sql').val();
			}
			$('#diggerDatasourceGroupCountGrid').setColProp('fieldName', {editoptions: {
					custom_element: selectElem,
					custom_value: selectValue,
					forId: 'fieldName',
					value : getOptionValue(diggerUrl,dataSourceTypeValue),
					dataEvents : [{
						'type' : 'change',
						'fn' : function(e){
							var v = $(e.target).val();
							var rowid = $("#diggerDatasourceGroupCountGrid").jqGrid("getGridParam","selrow");
							var fieldTitle = getFieldTitleValue($(e.target).get(0).selectedOptions[0].text);
							$("#diggerDatasourceGroupCountGrid").jqGrid('setCell',rowid , 'fieldTitle' , fieldTitle);//设置列显示名称
							var entityName = getEntityName(diggerUrl,dataSourceTypeValue,v);
							$("#diggerDatasourceGroupCountGrid").jqGrid('setCell',rowid , 'entityName' , entityName);//设置表名称
						}
					}]
			}});
		}
	});
	$(this._jqgridToolbar).append($("#tableToolbar"));

};

//保存功能
DiggerDatasourceGroupCountGrid.prototype.save=function(form,id){
	var _self = this;
	avicAjax.ajax({
		url:_self.getUrl() + "save",
		data : {data :JSON.stringify(serializeObject(form))},
		type : 'post',
		dataType : 'json',
		success : function(r){
			if (r.flag == "success"){
				_self.reLoad();
				if(id == "insert"){
					layer.close(_self.insertIndex);
				}else{
					layer.close(_self.eidtIndex);
				}
				layer.msg('保存成功！');
			}else{
				layer.alert('保存失败！' + r.error, {
						icon: 7,
						area: ['400px', ''], //宽高
						closeBtn: 0,
						btn: ['关闭'],
						title:"提示"
					}
				);
			}
		}
	});
};

/**
 * 添加行
 */
var newRowIndex = 0;
var newRowStart = "new_row";
DiggerDatasourceGroupCountGrid.prototype.insert = function(){
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

function insert(){

}

//删除
DiggerDatasourceGroupCountGrid.prototype.del=function(){
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
				url:_self.getUrl() +'platform/digger/diggerManageController/deleteDiggerDatasourceGroupCountGridData',
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
DiggerDatasourceGroupCountGrid.prototype.deleteAll = function(value){
	var _self = this;
	layer.confirm('切换数源时，要清空列属性配置。确认要切换吗?',
		{icon: 3, title:"提示", area: ['400px', '']},
		function(index){
			avicAjax.ajax({
				url:_self.getUrl() +'platform/digger/diggerManageController/deleteDiggerDatasourceGroupCountGridDataByDiggerId',
				data: {
					diggerId : $('#datasourceForm').find('#id').val()
				},
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r){
					if (r.flag == "success") {
						if(value == "1"){
							$('tr#bo_datasource').show();
							$('tr#sql_datasource').hide();
						} else {
							$('tr#bo_datasource').hide();
							$('tr#sql_datasource').show();
						}
						_self.reLoad();
					}
				}
			});
			layer.close(index);
		},function(index){
			if(value == "1"){
				$(":radio[name='datasourcetype'][value='0']").prop("checked", "checked");
			} else {
				$(":radio[name='datasourcetype'][value='1']").prop("checked", "checked");
			}
		});
}
//重载数据
DiggerDatasourceGroupCountGrid.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this._formId)))}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};

function formatCountColumn(cellvalue, options, rowObject) {
	if(cellvalue == "DEFAULT"){
		return '不统计';
	} else if(cellvalue == "COUNT"){
		return '计数(COUNT)';
	}else if(cellvalue == "COUNTDISTINCT"){
		return '不重复计数(COUNTDISTINCT)';
	}else if(cellvalue == "SUM"){
		return '求和(SUM)';
	}else if(cellvalue == "MAX"){
		return '最大值(MAX)';
	}else if(cellvalue == "MIN"){
		return '最小值(MIN)';
	}else if(cellvalue == "AVG"){
		return '平均值(AVG)';
	}else {
		return '不统计';
	}
}

function formatterDisplayPosition(cellvalue, options, rowObject) {
	if(cellvalue == "0"){
		return 'X轴';
	} else if(cellvalue == "1"){
		return 'Y轴';
	} else if(cellvalue == "2"){
		return 'Z辅助轴';
	} else {
		return 'X轴';
	}
}

function formatFieldColumn(cellvalue, options, rowObject) {
	if(typeof cellvalue == 'undefined'){
		return '';
	}
	if(cellvalue && cellvalue != ''){
		return cellvalue;
	}else{
		var rowId = options.rowId;
		var datas = options.colModel.editoptions.value;
		var forId = options.colModel.editoptions.forId;
		var code = rowObject[forId];
		return datas[code] ? datas[code] : '';
	}
}
function formatGroupColumn(cellvalue, options, rowObject) {
	if(cellvalue == "1"){
		return '分组';
	} else {
		return '不分组';
	}
}



//获取groupcountdatagrid修改的son数据
function getGroupCountDataGridJsonData(){
	var _self = this;
	var data = $("#diggerDatasourceGroupCountGrid").jqGrid('getChangedCells');

	var rows= $("#diggerDatasourceGroupCountGrid").jqGrid("getRowData");
	var l = rows.length,cache= {};
	for( ; l-- ; ){
		row =rows[l];
		if(row.fieldName =='' || row.fieldTitle==''){
			layer.alert('列名称或列显示名称不允许为空，请输入！', {
					icon: 0,
					title :'提示',
					area: ['400px', ''], //宽高
					closeBtn: 0
				}
			);
			return;
		}
		if(cache['n' + row.fieldName]){
			layer.alert('输入的列名称已经存在，请重新输入！' , {
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
	$("#diggerDatasourceGroupCountGrid").jqGrid('endEditCell');
	var data = $("#diggerDatasourceGroupCountGrid").jqGrid('getChangedCells');
	if(data && data.length > 0){
		for(var i = 0; i < data.length; i++){
			if(data[i].id.indexOf(newRowStart) > -1){
				data[i].id = '';
			}
			if(data[i].mapType.indexOf('不分组') > -1){
				data[i].mapType = '';
			}else{
				data[i].mapType = 'STAT';
			}
			data[i].statType = getStatTypeValue(data[i].statType);
			data[i].fieldName = getFieldNameValue(data[i].fieldName);
			data[i].displayPosition = getDisplayPositionValue(data[i].displayPosition);
		}
		return JSON.stringify(data);
	}
	return "";
}

function getFieldNameValue(fieldName){
	if(fieldName.indexOf('(') > -1 && fieldName.indexOf(')') > -1){
		return fieldName.substr(0,fieldName.indexOf('('));
	}
}

function getFieldTitleValue(fieldName){
	if(fieldName.indexOf('(') + 1 > -1 && fieldName.indexOf(')') - 1 > -1){
		fieldName =  fieldName.substr(fieldName.indexOf('(') + 1);
		fieldName = fieldName.substr(0,fieldName.indexOf(')'));
		return fieldName;
	} else {
		return fieldName;
	}
}


function getStatTypeValue(statType){
	if(statType.indexOf('不统计') > -1){
		return 'DEFAULT';
	} else if(statType.indexOf('计数(COUNT)') > -1){
		return 'COUNT';
	} else if(statType.indexOf('不重复计数(COUNTDISTINCT)') > -1){
		return 'COUNTDISTINCT';
	} else if(statType.indexOf('求和(SUM)') > -1){
		return 'SUM';
	} else if(statType.indexOf('最大值(MAX)') > -1){
		return 'MAX';
	} else if(statType.indexOf('最小值(MIN)') > -1){
		return 'MIN';
	} else if(statType.indexOf('平均值')){
		return 'AVG';
	} else {
		return 'DEFAULT';
	}
}

function getDisplayPositionValue(displayPosition){
	if(displayPosition.indexOf('X轴') > -1){
		return '0';
	} else if(displayPosition.indexOf('Y轴') > -1){
		return '1';
	} else if(displayPosition.indexOf('Z辅助轴') > -1){
		return '2';
	} else {
		return '0';
	}
}




