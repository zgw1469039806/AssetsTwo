function DiggerQueryDataGrid(datagrid,url,dataGridColModel,diggerId){
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
	this.init.call(this);
};
//初始化操作
DiggerQueryDataGrid.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
		url: this.getUrl() + 'platform/digger/diggerManageController/getDiggerQueryGridJsonData?diggerId=' + _self._diggerId,
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
			var dataSourceTypeValue = $('#datasourcetype').val();
			var diggerUrl =  $('#diggerUrl').val();
			//设置字段选择值
			$('#diggerQueryGrid').setColProp('fieldName', {editoptions: {
				custom_element: selectElem,
				custom_value: selectValue,
				forId: 'fieldName',
				value : getOptionValue(diggerUrl,dataSourceTypeValue),
				dataEvents : [{
					'type' : 'change',
					'fn' : function(e){
						var v = $(e.target).val();
						var rowid = $("#diggerQueryGrid").jqGrid("getGridParam","selrow");
						var fieldTitle = getFieldTitleValue($(e.target).get(0).selectedOptions[0].text);
						$("#diggerQueryGrid").jqGrid('setCell',rowid , 'fieldTitle' , fieldTitle);//设置列显示名称
						var entityName = getEntityName(diggerUrl,dataSourceTypeValue,v);
						$("#diggerQueryGrid").jqGrid('setCell',rowid , 'entityName' , entityName);//设置表名称
					}
				}]
			}});
			//设置比较方式选择值
			var id = $(_self._datagridId).jqGrid('getGridParam', 'selrow');
			var currentRolRtFieldTypeValue
			if (id) {
				var ret = $(_self._datagridId).jqGrid('getRowData', id);
				currentRolRtFieldTypeValue = ret.rtFieldType;
			}
			$('#diggerQueryGrid').setColProp('compareType', {editoptions: {
					custom_element: selectElem,
					custom_value: selectValue,
					forId: 'fieldName',
					value : getCompareTypeOptionValue(currentRolRtFieldTypeValue),
					dataEvents : [{
						'type' : 'change',
						'fn' : function(e){

						}
					}]
				}});
		}

	});
	$(this._jqgridToolbar).append($("#queryTableToolbar"));
};

function getCompareTypeOptionValue(value){
	if(value == '数值'){
		return {'=':'等于','>':'大于','<':'小于','!=':'不等于','>=':'大于等于','<=':'小于等于'};
	} else if(value == '日期'){
		return {'=':'等于','>':'大于','<':'小于','!=':'不等于','>=':'大于等于','<=':'小于等于'};
	} else {
		return {'=':'等于','>':'大于','<':'小于','!=':'不等于','>=':'大于等于','<=':'小于等于','like':'全包含','notlike':'不包含','leftlike':'左包含','rightlike':'右包含'};
	}
}

//保存功能
DiggerQueryDataGrid.prototype.save = function(form){
	var _self = this;
	var queryDataGridJsonData = getQueryDataGridJsonData();
	var diggerId =  form.find("#diggerId").val();
	var parm = "diggerId=" + diggerId + "&queryDataGridJsonData=" + queryDataGridJsonData;
	avicAjax.ajax({
		url : "platform/digger/diggerManageController/saveDiggerQueryConfig",
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

/**
 * 添加行
 */
var newRowIndex = 0;
var newRowStart = "new_row";
DiggerQueryDataGrid.prototype.insert = function(){
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
DiggerQueryDataGrid.prototype.del=function(){
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
				url:_self.getUrl() +'platform/digger/diggerManageController/deleteDiggerQueryGridData',
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
DiggerQueryDataGrid.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this._formId)))}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};

function formatCompareTypeColumn(cellvalue, options, rowObject) {
	if(cellvalue == ">"){
		return '大于';
	} else if(cellvalue == "<"){
		return '小于';
	}else if(cellvalue == "="){
		return '等于';
	}else if(cellvalue == "!="){
		return '不等于';
	}else if(cellvalue == ">="){
		return '大于等于';
	}else if(cellvalue == "<="){
		return '小于等于';
	}else if(cellvalue == "like"){
		return '全包含';
	}else if(cellvalue == "notlike"){
		return '不包含';
	}else if(cellvalue == "leftlike"){
		return '左包含';
	}else if(cellvalue == "rightlike"){
		return '右包含';
	}else {
		return '';
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
function formatJoinTypeColumn(cellvalue, options, rowObject) {
	if(cellvalue == "0"){
		return '与';
	} else {
		return '或';
	}
}
function formatRtFieldTypeColumn(cellvalue, options, rowObject) {
	if(cellvalue == "text"){
		return '文本';
	} else if(cellvalue == "num"){
		return '数值';
	} else if(cellvalue == 'date'){
		return '日期';
	} else {
		return '文本';
	}
}

function formatRtFieldDisplayTypeColumn(cellvalue, options, rowObject) {
	if(cellvalue == "text"){
		return '文本';
	} else if(cellvalue == "num"){
		return '数值';
	} else if(cellvalue == 'date'){
		return '日期';
	} else if(cellvalue == 'user'){
		return '选用户';
	} else if(cellvalue == 'dept'){
		return '选部门';
	} else if(cellvalue == 'org'){
		return '选组织';
	} else if(cellvalue == 'role'){
		return '选角色';
	} else if(cellvalue == 'group'){
		return '选群组';
	} else if(cellvalue == 'position'){
		return '选岗位';
	} else {
		return '文本';
	}
}

//获取diggerQueryGrid修改的son数据
function getQueryDataGridJsonData(){
	var _self = this;
	var data = $("#diggerQueryGrid").jqGrid('getChangedCells');

	var rows= $("#diggerQueryGrid").jqGrid("getRowData");
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
	$("#diggerQueryGrid").jqGrid('endEditCell');
	var data = $("#diggerQueryGrid").jqGrid('getChangedCells');
	if(data && data.length > 0){
		for(var i = 0; i < data.length; i++){
			if(data[i].id.indexOf(newRowStart) > -1){
				data[i].id = '';
			}

			if(data[i].joinType.indexOf('与') > -1){
				data[i].joinType = '0';
			}else{
				data[i].joinType = '1';
			}
			data[i].fieldName = getFieldNameValue(data[i].fieldName);
			data[i].compareType = getCompareTypeValue(data[i].compareType);
			data[i].rtFieldType = getRtFieldTypeValue(data[i].rtFieldType);
			data[i].rtFieldDisplayType = getRtFieldDisplayType(data[i].rtFieldDisplayType);
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

function getCompareTypeValue(statType){
	if(statType.indexOf('大于') > -1){
		return '>';
	} else if(statType.indexOf('小于') > -1){
		return '<';
	} else if(statType.indexOf('等于') > -1){
		return '=';
	} else if(statType.indexOf('不等于') > -1){
		return '!=';
	} else if(statType.indexOf('大于等于') > -1){
		return '>=';
	} else if(statType.indexOf('小于等于') > -1){
		return '<=';
	} else if(statType.indexOf('全包含') > -1){
		return 'like';
	}  else if(statType.indexOf('不包含') > -1){
		return 'notlike';
	} else if(statType.indexOf('左包含') > -1){
		return 'leftlike';
	} else if(statType.indexOf('右包含') > -1){
		return 'rightlike';
	} else {
		return '=';
	}
}

function getRtFieldTypeValue(statType){
	if(statType.indexOf('文本') > -1){
		return 'text';
	} else if(statType.indexOf('数值') > -1){
		return 'num';
	} else if(statType.indexOf('日期') > -1){
		return 'date';
	}  else {
		return 'text';
	}
}

function getRtFieldDisplayType(statType){
	if(statType.indexOf('文本') > -1){
		return 'text';
	} else if(statType.indexOf('数值') > -1){
		return 'num';
	} else if(statType.indexOf('日期') > -1){
		return 'date';
	}  else if(statType.indexOf('日期') > -1){
		return 'date';
	}  else if(statType.indexOf('选用户') > -1){
		return 'user';
	}  else if(statType.indexOf('选部门') > -1){
		return 'dept';
	}  else if(statType.indexOf('选组织') > -1){
		return 'org';
	}  else if(statType.indexOf('选角色') > -1){
		return 'role';
	}  else if(statType.indexOf('选群组') > -1){
		return 'group';
	}  else if(statType.indexOf('选岗位') > -1){
		return 'position';
	}  else {
		return 'text';
	}
}

function getOptionValue(diggerUrl,dataSourceTypeValue){
	//先要通过数据源id获取配置的字段列信息;
	var diggerUrl = diggerUrl;
	if(diggerUrl == ''){
		return;
	}
	var options = {};
	$.ajax({
		async: false,  //千万要记住加这个属性配置
		type: "get",
		dataType:"json",
		url: "digger/diggerManageController/getDatasourceOptionJsonData?diggerUrl=" + diggerUrl + '&datasourceType=' + dataSourceTypeValue,
		success: function(data) {
			options =  data;
		},
		error : function(e){
			alert(e);
		}
	});
	return options;
}

/**
 * 获取表名称-根据列名称值
 * @returns {{}}
 */
function getEntityName(diggerurl,datasourcetype,fieldName){
	var options = '';
	$.ajax({
		async: false,  //千万要记住加这个属性配置
		type: "get",
		dataType:"text",
		url: "digger/diggerManageController/getDatasourceGoupCountByFieldName?diggerUrl=" + diggerurl + '&datasourceType=' + datasourcetype + '&fieldName=' + fieldName,
		success: function(text) {
			options =  text;
		},
		error : function(e){
			alert(e);
		}
	});
	return options;
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

function getFieldNameValue(fieldName){
	if(fieldName.indexOf('(') > -1 && fieldName.indexOf(')') > -1){
		return fieldName.substr(0,fieldName.indexOf('('));
	}
}

