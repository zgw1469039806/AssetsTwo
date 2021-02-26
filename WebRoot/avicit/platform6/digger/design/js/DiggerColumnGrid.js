function DiggerColumnGrid(datagrid,url,dataGridColModel,diggerId,diggerType){
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
	this._diggerType = diggerType;
	if(diggerType){
		this.notBeforeEditCellInit.call(this);
	} else {
		this.init.call(this);
	}

};
//初始化操作
DiggerColumnGrid.prototype.init = function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
		url: this.getUrl() + 'platform/digger/diggerManageController/getDiggerDatasourceGroupCountGridJsonData?diggerId=' + _self._diggerId,
		mtype: 'POST',
		datatype: "json",
		toolbar: [true,'top'],
		colModel: this.dataGridColModel,
		height:$(window).height() - 540,
		scrollOffset: 20, //设置垂直滚动条宽度
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
		beforeEditCell : _self.beforeEditCellEvent
	});
	$(this._jqgridToolbar).append($("#tableToolbar"));

};
/**
 * 行编辑前事件
 * @param rowid
 * @param cellname
 * @param value
 * @param iRow
 * @param iCol
 */
DiggerColumnGrid.prototype.beforeEditCellEvent = function(rowid, cellname, value, iRow, iCol){
	var _self = this;
	var dataSourceTypeValue = $('input[name="datasourcetype"]:checked').val();
	var diggerUrl = '';
	if(dataSourceTypeValue == 1){//获取选中的formId
		diggerUrl = $('#datasourceFormId').val();
	} else {//获取输入的sql语句
		diggerUrl = $('#sql').val();
	}
	$('#diggerColumnGrid').setColProp('fieldName', {editoptions: {
			custom_element: selectElem,
			custom_value: selectValue,
			forId: 'fieldName',
			value : getOptionValue(diggerUrl,dataSourceTypeValue),
			dataEvents : [{
				'type' : 'change',
				'fn' : function(e){
					var v = $(e.target).val();
					var rowid = $("#diggerColumnGrid").jqGrid("getGridParam","selrow");
					var fieldTitle = getFieldTitleValue($(e.target).get(0).selectedOptions[0].text);
					var val =fieldTitle.split(",")
					$("#diggerColumnGrid").jqGrid('setCell',rowid , 'fieldTitle' , val[0]);//设置列显示名称
                    $("#diggerColumnGrid").jqGrid('setCell',rowid , 'fieldType' , val[1]);//设置列数据类型

                    var entityName = getEntityName(diggerUrl,dataSourceTypeValue,v);
 					$("#diggerColumnGrid").jqGrid('setCell',rowid , 'entityName' , entityName);//设置表名称

                }
			}]
		}});

	$('#diggerColumnGrid').setColProp('statType', {editoptions: {
			dataEvents : [{
				'type' : 'change',
				'fn' : function(e){
					var v = $(e.target).val();
					var rowid = $("#diggerColumnGrid").jqGrid("getGridParam","selrow");
					if(v=="CROSS_GROUP"){
						$("#diggerColumnGrid").jqGrid('setCell',rowid , 'orderIndex' , '0');//设置排序
						$("#diggerColumnGrid").setColProp("orderIndex",{editable:false});

					}else{
						$("#diggerColumnGrid").jqGrid('setCell',rowid , 'orderIndex' , null);//
						$("#diggerColumnGrid").setColProp("orderIndex",{editable:true});
					}

				}
			}]
		}});
}
//普通类型的报表-初始化操作
DiggerColumnGrid.prototype.notBeforeEditCellInit = function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
		url: this.getUrl() + 'platform/digger/diggerManageController/getDiggerDatasourceGroupCountGridJsonData?diggerId=' + _self._diggerId,
		mtype: 'POST',
		datatype: "json",
		toolbar: [true,'top'],
		colModel: this.dataGridColModel,
		height:$(window).height()- 500,
		scrollOffset: 20, //设置垂直滚动条宽度
		rowNum: 10000	,
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
	$(this._jqgridToolbar).append($("#tableToolbar"));

};

DiggerColumnGrid.prototype.getId = function(){
	var _self = this;
	return _self._datagridId;
};

//保存功能
DiggerColumnGrid.prototype.save=function(form,id){
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
DiggerColumnGrid.prototype.insert = function(){
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
/**
 * 批量添加行
 */
DiggerColumnGrid.prototype.insertBatch = function(){
	//批量添加前，判断是否有数据，如果有数据，允许添加一行，如果没有数据，批量添加
	var _self = this;
	$(this._datagridId).jqGrid('endEditCell');
	var haveDatas = $(this._datagridId).jqGrid("getRowData");
	if(haveDatas.length > 0){
		$(this._datagridId).jqGrid('setGridParam',{beforeEditCell : _self.beforeEditCellEvent});
		_self.insert();
		return;
	}
	var dataSourceTypeValue = $('input[name="datasourcetype"]:checked').val();
	var diggerUrl = '';
	if(dataSourceTypeValue == 1){//获取选中的formId
		diggerUrl = $('#datasourceFormId').val();
	} else {//获取输入的sql语句
		diggerUrl = $('#sql').val();
	}
	var datas = getColumnValues(diggerUrl,dataSourceTypeValue);
	if(datas){
		for(var i = 0 ; i < datas.mapList.length ; i++){
			var data = datas.mapList[i];
			var newRowId = newRowStart + newRowIndex;
			var parameters = {
				rowID : newRowId,
				initdata : {
					fieldName : data.fieldName,
					fieldTitle : data.fieldTitle,
					entityName : data.entityName,
					isdisplay : data.isDisplay,
					orderIndex : newRowIndex,
                    fieldType : data.fieldType
				},
				role :"first",
				useDefValues : true,
				useFormatter : true,
				addRowParams : {extraparam:{}}
			};
			$(this._datagridId).jqGrid('addRow', parameters);
			newRowIndex++;
			$(this._datagridId).find("#" + newRowId).addClass('edited');
		}
	} else {
		parent.layer.alert('请配置或选择数据源！', {
				icon: 7,
				area: ['400px', ''],
				closeBtn: 0,
				btn: ['关闭'],
				title:"提示"
			}
		);
		return;
	}
};

//删除
DiggerColumnGrid.prototype.del=function(){
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
DiggerColumnGrid.prototype.deleteAll = function(value){
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
DiggerColumnGrid.prototype.reLoad=function(){
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

//格式化-外观
function formatAppearance(cellvalue, options,rowObject) {
    var rowId = options.rowId;
    var pos = options.pos;
    if(isEmpty(cellvalue)){
        return "<button onclick=openAppearanceDailog('"+cellvalue+"','"+rowId+"','"+pos+"');return false;>配置</button>";
    }else{
        return verifyAppearance(cellvalue,rowId,pos)
        // return "<button onclick=openAppearanceDailog('"+cellvalue+"','"+rowId+"','"+pos+"');return false;>编辑</button>";

    }
  }
//格式化-显示规则
function formatDisplayRule(cellvalue, options, rowObject) {
    var rowId = options.rowId;
    var pos = options.pos;
    var data ;
    if(cellvalue){
    	data = JSON.stringify(cellvalue).replace(/\"/g,"'");
	}
    if(isEmpty(cellvalue)){
        return "<button onclick=\"openDisplayRuleDailog("+data+",\'"+rowId+"\',\'"+pos+"\')\";return false;>配置</button>";
    }else{
        //判断是否是编辑或者配置 &#39;
        if(cellvalue.indexOf("&quot;")!=-1){
            var obj = JSON.parse(cellvalue.replace(new RegExp('&quot;',"gm"),'"'));

        }else if(cellvalue.indexOf("&#39;")!=-1){
            var obj = JSON.parse(cellvalue.replace(new RegExp('&#39;',"gm"),'"'));

        }else {
            var obj = JSON.parse(cellvalue);
        }

        return verifyDisplayRule(obj,rowId,pos);
        // return "<button onclick=\"openDisplayRuleDailog("+data+",\'"+rowId+"\',\'"+pos+"\')\";return false;>编辑</button>";
    }

}

//格式化-行为
function formatAction(cellvalue, options, rowObject) {
    var rowId = options.rowId;
    var pos = options.pos;
    if(isEmpty(cellvalue)){
        return "<button onclick=openActionDailog('"+cellvalue+"','"+rowId+"','"+pos+"');return false;>配置</button>";
    }else{
         return verifyAction(cellvalue,rowId,pos);
        // return "<button onclick=openActionDailog('"+cellvalue+"','"+rowId+"','"+pos+"');return false;>编辑</button>";

    }
}

//配置窗口-外观
function openAppearanceDailog(value,rowId,pos) {
        if (!isEmpty(value)){
            var index = parent.layer.open({
                type: 2,
                title: '配置【外观】',
                closeBtn : 0,
                skin: 'bs-modal',
                area: ['55%', '55%'],
                maxmin: false,
                content: "platform/digger/diggerManageController/getAppearanceConfig",
                btn: ['确定', '取消'],
                yes: function(index,layero){
                    var config = $(layero).find("iframe")[0].contentWindow.getFormConfig();
                    var jsonObj={
                        frontColor:config.frontColor,
                        bgColor:config.bgColor,
                        columnWidth:config.columnWidth,
                        columnWidthUnit:config.columnWidthUnit,
                        fontSize:config.fontSize,
                        allowWrapDisplay:config.allowWrapDisplay
                    }
                    $("#diggerColumnGrid").jqGrid('setCell',rowId,pos,JSON.stringify(jsonObj));
                    $('#'+rowId).addClass("edited");
                    parent.layer.close(index);
                },
                btn2: function(index,layero){
                    parent.layer.close(index);
                },
                success: function(layero, index) {
                    //弹窗之前赋值
                     $(layero).find("iframe")[0].contentWindow.setFormConfig(JSON.parse(value));
                }
            });

        }else{
            var index = parent.layer.open({
                type: 2,
                title: '配置【外观】',
                closeBtn : 0,
                skin: 'bs-modal',
                area: ['55%', '55%'],
                maxmin: false,
                content: "platform/digger/diggerManageController/getAppearanceConfig",
                btn: ['确定', '取消'],
                yes: function(index,layero){
                    var config = $(layero).find("iframe")[0].contentWindow.getFormConfig();
                    var jsonObj={
                        frontColor:config.frontColor,
                        bgColor:config.bgColor,
                        columnWidth:config.columnWidth,
                        columnWidthUnit:config.columnWidthUnit,
                        fontSize:config.fontSize,
                        allowWrapDisplay:config.allowWrapDisplay
                    }
                    $("#diggerColumnGrid").jqGrid('setCell',rowId,pos,JSON.stringify(jsonObj));
                    $('#'+rowId).addClass("edited");
                    parent.layer.close(index);
                },
                btn2: function(){
                    parent.layer.close(index);
                }
            });
        }
}
//配置窗口-显示规则
function openDisplayRuleDailog(value,rowId,pos) {
    if (!isEmpty(value)){
        var index =parent.layer.open({
            type: 2,
            title: '配置【显示规则】',
            closeBtn : 0,
            skin: 'bs-modal',
            area: ['55%', '55%'],
            maxmin: false,
            content: "platform/digger/diggerManageController/getDisplayRuleConfig",
            btn: ['确定', '取消'],
            yes: function(index,layero){
                //设置字段值
                var config = $(layero).find("iframe")[0].contentWindow.getFormConfig();
                $('#'+rowId).addClass("edited");
                $("#diggerColumnGrid").jqGrid('setCell',rowId,pos,JSON.stringify(config));
                $('#'+rowId).addClass("edited");
                parent.layer.close(index);
            },
            btn2: function(){
                parent.layer.close(index);
            },
            success: function(layero, index) {
                //弹窗之前赋值
                // $(layero).find("iframe")[0].contentWindow.setFormConfig(JSON.parse(value.replace(/'/g, '"')));
                // $(layero).find("iframe")[0].contentWindow.setFormConfig(JSON.parse(value.replace(/'/g, '"')));
                $(layero).find("iframe")[0].contentWindow.setFormConfig(value);

            }
        });
    }else{
        var index =parent.layer.open({
            type: 2,
            title: '配置【显示规则】',
            closeBtn : 0,
            skin: 'bs-modal',
            area: ['55%', '55%'],
            maxmin: false,
            content: "platform/digger/diggerManageController/getDisplayRuleConfig",
            btn: ['确定', '取消'],
            yes: function(index,layero){
                //设置字段值
                var config = $(layero).find("iframe")[0].contentWindow.getFormConfig();
                $('#'+rowId).addClass("edited");
                $("#diggerColumnGrid").jqGrid('setCell',rowId,pos,JSON.stringify(config));
                parent.layer.close(index);
            },
            btn2: function(){
                parent.layer.close(index);
            }
        });

    }

	return;
}
//配置窗口-行为
function openActionDailog(value,rowId,pos) {
    if (!isEmpty(value)){
        var index =parent.layer.open({
            type: 2,
            title: '配置【行为】',
            closeBtn : 0,
            skin: 'bs-modal',
            area: ['55%', '55%'],
            maxmin: false,
            content: "platform/digger/diggerManageController/getActionConfig",
            btn: ['确定', '取消'],
            yes: function(index,layero){
                var config = $(layero).find("iframe")[0].contentWindow.getFormConfig();
                $("#diggerColumnGrid").jqGrid('setCell',rowId,pos,JSON.stringify(config));
                $('#'+rowId).addClass("edited");
                parent.layer.close(index);
            },
            btn2: function(){
                parent.layer.close(index);
            },
            success: function(layero, index) {
                //弹窗之前赋值
                $(layero).find("iframe")[0].contentWindow.setFormConfig(JSON.parse(value))
            }
        });
    }else{
        var index =parent.layer.open({
            type: 2,
            title: '配置【行为】',
            closeBtn : 0,
            skin: 'bs-modal',
            area: ['55%', '55%'],
            maxmin: false,
            content: "platform/digger/diggerManageController/getActionConfig",
            btn: ['确定', '取消'],
            yes: function(index,layero){
                var config = $(layero).find("iframe")[0].contentWindow.getFormConfig();
                $("#diggerColumnGrid").jqGrid('setCell',rowId,pos,JSON.stringify(config));
                $('#'+rowId).addClass("edited");
                parent.layer.close(index);
            },
            btn2: function(){
                parent.layer.close(index);
            }

        });
    }

	return;
}

//格式化-列状态
function formatStateType(cellvalue, options, rowObject){
	if(cellvalue == "CROSS_GROUP"){
		return '汇总列';
	} else if(cellvalue == "CROSS_COUNT"){
		return "统计列"
	} else if(cellvalue == "DEFAULT"){
		return "普通列";
	}
}
//格式化-表头排序
function formatSortType(cellvalue, options, rowObject){
	if(cellvalue == "0"){
		return '升序';
	} else if(cellvalue == "1"){
		return "降序"
	}
}

//格式化-对齐方式
function formatAlignType(cellvalue, options, rowObject){
	if(cellvalue == "0"){
		return '左对齐';
	} else if(cellvalue == "1"){
		return "居中"
	} else if(cellvalue == "2"){
		return "右对齐"
	}
}
//格式化-隐藏
function formatIsDisplay(cellvalue, options, rowObject){
	var rowId = options.rowId;
	if(cellvalue == '1'){
		return "<input type='checkbox' onchange=\"isDisplayClickEvent('" + rowId + "',this);return false;\" value='1' checked='checked'>";
	} else {
		return "<input type='checkbox' onchange=\"isDisplayClickEvent('" + rowId + "',this);return false;\" value='0' >";
	}
}

function isDisplayClickEvent(rowId,obj){
	if(obj.checked){
		$(obj).attr("checked",true);
	} else {
		$(obj).attr("checked",false);
	}
	$(diggerColumnGrid.getId()).find("#" + rowId).addClass('edited');
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
function getDiggerColumnGridJsonData(){
	var _self = this;
	var rows = $("#diggerColumnGrid").jqGrid("getRowData");
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
			return false;
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
	$("#diggerColumnGrid").jqGrid('endEditCell');
	var data = $("#diggerColumnGrid").jqGrid('getChangedCells');
	if(data && data.length > 0){
		for(var i = 0; i < data.length; i++){
			if(data[i].id.indexOf(newRowStart) > -1){
				data[i].id = '';
			}
			data[i].fieldName = getFieldNameValue(data[i].fieldName);
			data[i].sortType = getSortTypeValue(data[i].sortType);
			data[i].alignType = getAlignTypeValue(data[i].alignType);
			data[i].statType = getStatTypeValue(data[i].statType);
			try{data[i].isdisplay = getIsDisplayValue(data[i].isdisplay)}catch (e) {}
            // str = str.match(/aaa(\S*)fff/)[1];
            if(data[i].appearance.indexOf("{") !=-1){
                var star = data[i].appearance.indexOf("{");
                var last = data[i].appearance.lastIndexOf("}");
                var str = data[i].appearance.substring(star,last+1);
                // var str = "{"+data[i].appearance.match(/{(\S*)}/)[1]+"}";
                data[i].appearance=str;
            }else{
                data[i].appearance="";
            }
            if(data[i].displayRule.indexOf("{") !=-1){
                var star = data[i].displayRule.indexOf("{");
                var last = data[i].displayRule.lastIndexOf("}");
                var str = data[i].displayRule.substring(star,last+1);
                // var str ="{"+data[i].dIisplayRule.match(/{(\S*)}/)[1]+"}";
                data[i].displayRule=str.replace(/\\'/g, '"');
            }else {
                data[i].displayRule="";
            }
            if(data[i].action.indexOf("{") !=-1){
                // var str="{"+data[i].action.match(/{(\S*)}/)[1]+"}";
                var star = data[i].action.indexOf("{");
                var last = data[i].action.lastIndexOf("}");
                var str = data[i].action.substring(star,last+1);
                data[i].action=str;
            }else {
                data[i].action="";
            }

		}
		return JSON.stringify(data);
	}
}

function getFieldNameValue(fieldName){
	if(fieldName.indexOf('(') > -1 && fieldName.indexOf(')') > -1){
		return fieldName.substr(0,fieldName.indexOf('('));
	} else{
		return fieldName;
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

function getAlignTypeValue(alignType){
	if(alignType.indexOf('左对齐') > -1){
		return '0';
	} else if(alignType.indexOf('居中') > -1){
		return '1';
	} else if(alignType.indexOf('右对齐') > -1){
		return '2';
	}
}

function getSortTypeValue(sortType){
	if(sortType.indexOf('升序') > -1){
		return '0';
	} else if(sortType.indexOf('降序') > -1){
		return '1';
	}
}


function getStatTypeValue(statType){
	if(statType.indexOf('不统计') > -1 || statType.indexOf('普通列') > -1){
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
	} else if(statType.indexOf('平均值') > -1){
		return 'AVG';
	} else if(statType.indexOf('汇总列') > -1){
		return 'CROSS_GROUP';
	} else if(statType.indexOf('统计列') > -1){
		return 'CROSS_COUNT';
	} else {
		return 'DEFAULT';
	}
}

/**
 * 保存时，获取隐藏值
 * @param value
 */
function getIsDisplayValue(value){
	if($(value).attr('checked') == 'checked'){
		return 1;
	} else {
		return 0;
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

function isEmpty(obj){
    if(typeof obj == "undefined" || obj == "null" || obj == ""||obj==null||obj == "undefined"){
        return true;
    }else{
        return false;
    }
}
function verifyDisplayRule(obj,rowId,pos) {
    var data = JSON.stringify(obj).replace(/\"/g,"'");
    //数据格式化
    if(!isEmpty(obj.formatValue) || !isEmpty(obj.suffix) || !isEmpty(obj.prefix)){
        return "<button onclick=\"openDisplayRuleDailog("+data+",\'"+rowId+"\',\'"+pos+"\')\";return false;>编辑</button>";

    }
    //数据映射
    if (obj.radioType=="0"){
        if(!isEmpty(obj.commonValueName)){
            return "<button onclick=\"openDisplayRuleDailog("+data+",\'"+rowId+"\',\'"+pos+"\')\";return false;>编辑</button>";
        }

    }
    if (obj.radioType=="1"){
        if(!isEmpty(obj.jsonValueName)){
            return "<button onclick=\"openDisplayRuleDailog("+data+",\'"+rowId+"\',\'"+pos+"\')\";return false;>编辑</button>";
        }
    }
    if (obj.radioType=="2"){
        if(!isEmpty(obj.orgValueName)){
            return "<button onclick=\"openDisplayRuleDailog("+data+",\'"+rowId+"\',\'"+pos+"\')\";return false;>编辑</button>";
        }
    }
    if (obj.radioType=="3"){
         if(!isEmpty(obj.commonCodeValueName)){
            return "<button onclick=\"openDisplayRuleDailog("+data+",\'"+rowId+"\',\'"+pos+"\')\";return false;>编辑</button>";
        }
    }
    if (obj.radioType=="4"){
        if(!isEmpty(obj.sqlValueName)){
            return "<button onclick=\"openDisplayRuleDailog("+data+",\'"+rowId+"\',\'"+pos+"\')\";return false;>编辑</button>";
        }
    }

    return "<button onclick=\"openDisplayRuleDailog("+data+",\'"+rowId+"\',\'"+pos+"\')\";return false;>配置</button>";

}


function verifyAppearance(cellvalue,rowId,pos){
    var obj = JSON.parse(cellvalue.replace(new RegExp('&quot;',"gm"),'"'));
    if(!isEmpty(obj.frontColor)||!isEmpty(obj.bgColor)||!isEmpty(obj.columnWidth)){
        return "<button onclick=openAppearanceDailog('"+cellvalue+"','"+rowId+"','"+pos+"');return false;>编辑</button>";

    }else{
        return "<button onclick=openAppearanceDailog('"+cellvalue+"','"+rowId+"','"+pos+"');return false;>配置</button>";

    }

}

function verifyAction(cellvalue,rowId,pos) {
    var obj = JSON.parse(cellvalue.replace(new RegExp('&quot;',"gm"),'"'));
    if(!isEmpty(obj.behaviourtarget2)){
        return "<button onclick=openActionDailog('"+cellvalue+"','"+rowId+"','"+pos+"');return false;>编辑</button>";

    }else{
        return "<button onclick=openActionDailog('"+cellvalue+"','"+rowId+"','"+pos+"');return false;>配置</button>";

    }

}





