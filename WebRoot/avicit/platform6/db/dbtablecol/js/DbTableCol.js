/**
 * 初始化对象
 * @param datagrid 表格Id
 * @param url URL参数
 * @param searchDialogId 高级查询Id
 * @param form 高级查询formId
 * @param keyWordId 关键字查询框Id
 * @param searchNames 关键字查询项名称Array
 * @param dataGridColModel 表格列属性Array
 */
function DbTableCol(datagrid, url, searchDialogId, form, keyWordId,
		searchNames, dataGridColModel,tableId) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	};
	this._tableId = tableId;
	this.oldDecimal = "";
	this._datagridId = "#" + datagrid;
	this._jqgridToolbar = "#t_" + datagrid;
	this._doc = document;
	this.initData = [];
	this._formId = "#" + form;
	this._searchDialogId = "#" + searchDialogId;
	this._keyWordId = "#" + keyWordId;
	this._searchNames = searchNames;
	this.dataGridColModel = dataGridColModel;
	this.notnullFiled = [];//非空字段
	this.notnullFiledComment = []; //非空字段注释
	//除时间,数字等类型长度校验字段
	this.lengthValidFiled = [];
	//除时间,数字等类型长度校验字段注释
	this.lengthValidFiledComment = [];
	//除时间,数字等类型长度
	this.lengthValidFiledSize = [];
	this.isedit = true;
	this.init.call(this);
}
/**
 * 初始化操作
 */
DbTableCol.prototype.init = function() {

	var _self = this;
	var param = {tableId:this._tableId};
	if (dbtype != "1"){
		_self.isedit = false;
	}

	var jqgridHeight = $(window).height() - 120 - 40;
	var hasTop = true;
	if(this._tableId == "null"){
		jqgridHeight = $(window).height() - 120 - 80;
		hasTop = false;
	}


	$(_self._datagridId).jqGrid({
		url : this.getUrl() + 'getDbTableColsByPage.json',
		mtype : 'POST',
		datatype : "json",
		postData : param,
		toolbar : [ hasTop, 'top' ],//启用toolbar
		colModel : this.dataGridColModel,//表格列的属性
		height : jqgridHeight,//初始化表格高度
		scrollOffset : 20, //设置垂直滚动条宽度
		rowNum : 100,//每页条数
		rowList : [ 200, 100, 50, 30, 20, 10 ],//每页条数可选列表
		altRows : true,//斑马线
		pagerpos : 'left',//分页栏位置
		//rownumbers: true,
		//rownumWidth: 30,
		loadComplete : function(data) {
			_self.setData(data.rows);
			$(this).jqGrid('getColumnByUserIdAndTableName');
			var ids = $(this).jqGrid('getDataIDs');
			if (ids.length > 0) {
				for (var i = 0; i < ids.length; i++) {
					//如果可编辑，则开启行编辑
					if(_self.isedit){
						$(this).jqGrid("editRow", ids[i], {
							keys: true
						})
					}
					var rowid = ids[i];
					if (iscreated == "Y"){
						if(rowid.indexOf("new_row")==-1){
							$("#"+rowid+"_colName").attr("disabled","disabled");
							$("#"+rowid+"_colType").attr("disabled","disabled");
							//$("#"+rowid+"_colNullableName").attr("disabled","disabled");
						}else{
							$("#"+rowid+"_colName").removeAttr("disabled");
							$("#"+rowid+"_colType").removeAttr("disabled");
							//$("#"+rowid+"_colNullableName").removeAttr("disabled");
						}
					}
					var colName = $("#"+rowid+"_colName").val();
					var colIsPk = $("#"+rowid).find("td[aria-describedby='dbTableColjqGrid_colIsPk']").text()
					if (_self.isBaseCol(colName,colIsPk)){
						$("#"+rowid+"_colLength").attr("disabled","disabled");
						$("#"+rowid+"_attribute02").attr("disabled","disabled");
						$("#"+rowid+"_colComments").attr("disabled","disabled");
						$("#"+rowid+"_colDefault").attr("disabled","disabled");
					}else{
						var value = $("#"+rowid+"_colType").val();
						if(value == "VARCHAR2"){                             //新建字段控件改变字段类型
							$("#"+rowid+"_colLength").removeAttr("disabled");
							$("#"+rowid+"_attribute02").attr("disabled","disabled");
							$("#"+rowid+"_colComments").removeAttr("disabled","disabled");
							$("#"+rowid+"_colDefault").removeAttr("disabled","disabled");

						}else if(value == "DATE" || value == "CLOB" || value == "BLOB"){
							$("#"+rowid+"_colLength").attr("disabled","disabled");
							$("#"+rowid+"_attribute02").attr("disabled","disabled");
							$("#"+rowid+"_colComments").removeAttr("disabled","disabled");
							$("#"+rowid+"_colDefault").attr("disabled","disabled");
						}else if(value == "NUMBER"){
							$("#"+rowid+"_colLength").removeAttr("disabled","disabled");
							$("#"+rowid+"_attribute02").removeAttr("disabled","disabled");
							$("#"+rowid+"_colComments").removeAttr("disabled","disabled");
							$("#"+rowid+"_colDefault").removeAttr("disabled","disabled");
						}
					}

				}
			}
		},
		styleUI : 'Bootstrap', //Bootstrap风格
		viewrecords : true, //是否要显示总记录数
		multiselect : true,//可多选
		autowidth : true,//列宽度自适应
		multiboxonly:true,
		hasTabExport:false,
		hasColSet:false,
		pager : "#jqGridPager",
		cellEdit : this.isedit,
		cellsubmit : 'clientArray',
		onCellSelect: function(rowid, index, contents, event){

		},
		gridComplete: function() {
			//已分配 数量 和 已清分数量不等时，标粉
			_self.afterCompleteFunction();
		},
		beforeEditCell : function (rowid, cellname, value, iRow, iCol){

		},
		afterSaveCell:function(rowid, cellname, value, iRow, iCol){

		}

	});
	//$(this._datagridId).jqGrid('sortableRows');//实现行拖拽
	//放入表格toolbar中
	$(this._jqgridToolbar).append($("#tableToolbar"));

	//初始化时间控件
	$('.date-picker').datepicker({
		beforeShow : function() {
			setTimeout(function() {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
	});
	$('.time-picker').datetimepicker({
		oneLine : true,//单行显示时分秒
		showButtonPanel : true,//是否展示功能按钮面板
		closeText : '确定',
		showSecond : false,//是否可以选择秒，默认否
		beforeShow : function(selectedDate) {
			if ($('#' + selectedDate.id).val() == "") {
				$(this).datetimepicker("setDate", new Date());
				$('#' + selectedDate.id).val('');
			}
			setTimeout(function() {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
	});
	//初始化校验字段
	_self.lengthValidFiled.push("tableId");
	_self.lengthValidFiledSize.push(50);
	_self.lengthValidFiledComment.push("表外键");
	_self.lengthValidFiled.push("colName");
	_self.lengthValidFiledSize.push(50);
	_self.lengthValidFiledComment.push("列英文名称");
	_self.notnullFiled.push("colName");
	_self.notnullFiledComment.push("列英文名称");
	_self.lengthValidFiled.push("colType");
	_self.lengthValidFiledSize.push(50);
	_self.lengthValidFiledComment.push("列类型");
	_self.notnullFiled.push("colType");
	_self.notnullFiledComment.push("列类型");
	_self.lengthValidFiled.push("colLength");
	_self.lengthValidFiledSize.push(50);
	_self.lengthValidFiledComment.push("列长度");
	//_self.lengthValidFiled.push("colNullable");
	//_self.lengthValidFiledSize.push(100);
	//_self.lengthValidFiledComment.push("是否允许为空");
	_self.lengthValidFiled.push("colDefault");
	_self.lengthValidFiledSize.push(50);
	_self.lengthValidFiledComment.push("默认值");
	_self.lengthValidFiled.push("colComments");
	_self.lengthValidFiledSize.push(500);
	_self.lengthValidFiledComment.push("列中文名称");
	_self.lengthValidFiled.push("colIsPk");
	_self.lengthValidFiledSize.push(100);
	_self.lengthValidFiledComment.push("是否主键");
	_self.lengthValidFiled.push("sysApplicationId");
	_self.lengthValidFiledSize.push(50);
	_self.lengthValidFiledComment.push("应用ID");
};
/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
DbTableCol.prototype.insert = function(rowData) {
	var _self = this;
	//$(this._datagridId).jqGrid('endEditCell');
	var newRowId = newRowStart + newRowIndex;
	var rows = $(this._datagridId).jqGrid('getRowData');
	var colName = "DATA_";
	var isNewName = false;
	var newNumber = 1;
	while(!isNewName){
		isNewName = true;
		$(rows).each(function () {
			var domId = $(this.colName).attr("id");
			isNewName = isNewName && (colName+newNumber)!=$("#"+domId).val();
		});
		newNumber ++;
	}

	if(rowData == undefined){
		rowData = {colName:colName+(newNumber-1),colComments:colName+(newNumber-1),colType:"VARCHAR2",colLength:50,colIsPk:"N",tableId:this._tableId};
	}
	var parameters = {
		rowID : newRowId,
		initdata : rowData,
		position : "last",
		useDefValues : true,
		useFormatter : true,
		addRowParams : {
			extraparam : {}
		}
	};

	$(this._datagridId).jqGrid('addRow', parameters);
	$("#"+newRowId).addClass("edited");

	if(_self.isedit){
		$(this._datagridId).jqGrid("editRow", newRowId, {
			keys: true
		})
	}

	var value = $("#"+newRowId+"_colType").val();
	if(value == "VARCHAR2"){                             //新建字段控件改变字段类型
		$("#"+newRowId+"_colLength").removeAttr("disabled");
		$("#"+newRowId+"_attribute02").attr("disabled","disabled");
		$("#"+newRowId+"_colComments").removeAttr("disabled","disabled");
		$("#"+newRowId+"_colDefault").removeAttr("disabled","disabled");

	}else if(value == "DATE" || value == "CLOB" || value == "BLOB"){
		$("#"+newRowId+"_colLength").attr("disabled","disabled");
		$("#"+newRowId+"_attribute02").attr("disabled","disabled");
		$("#"+newRowId+"_colComments").removeAttr("disabled","disabled");
		$("#"+newRowId+"_colDefault").attr("disabled","disabled");
	}else if(value == "NUMBER"){
		$("#"+newRowId+"_colLength").removeAttr("disabled","disabled");
		$("#"+newRowId+"_attribute02").removeAttr("disabled","disabled");
		$("#"+newRowId+"_colComments").removeAttr("disabled","disabled");
		$("#"+newRowId+"_colDefault").removeAttr("disabled","disabled");
	}

	newRowIndex++;
};

DbTableCol.prototype.isBaseCol = function(colName,isPk){
	if(colName == "LAST_UPDATE_DATE" || colName == "LAST_UPDATED_BY" 
		|| colName == "CREATION_DATE" || colName == "CREATED_BY" 
			|| colName =="LAST_UPDATE_IP" || colName == "VERSION" || colName == "ORG_IDENTITY" || isPk =="Y"){
		return true;
	}
	return false;
};

DbTableCol.prototype.afterCompleteFunction = function(){
	//获取列表数据
	var ids = $(this._datagridId).jqGrid("getDataIDs");
	var rowDatas = $(this._datagridId).jqGrid("getRowData");
	for(var i=0;i < rowDatas.length;i++){
		var rowData = rowDatas[i];
		var colName = rowData.colName; 
		var isPk = rowData.colIsPk;
		if(this.isBaseCol(colName,isPk)){
		//获取每行下的TD更改CSS
		//第一种写法
		//$("#"+rowData.crmCustContractId).find("td").css("background-color", "pink");
		//第2种写法
			$("#"+ids[i]+ " td").css("background-color","rgb(208,208,208)");//--------(1)
		//alert($("#"+rowData.crmCustContractId).find("td")[0]);
		}
	}
	return true;
};

/**
 * 非空验证
 * @param 
 * @param 
 */
DbTableCol.prototype.nullvalid = function(data, item, nullfiled,
		notnullFiledComment) {
	var msg = "";
	$.each(data, function(i, dataitem) {
		if (dataitem[item] == "") {
			temp = false;
			msg = notnullFiledComment[$.inArray(item, nullfiled)] + "为必填字段";
		}
		if(dataitem.colIsPk == "Y"){
			dataitem.colIsSys = "Y";
		}else{
			dataitem.colIsSys = "N";
		}
	});
	return msg;
};

DbTableCol.prototype.setData = function(data){
	for (var i=0;i<data.length;i++){
		this.initData.push({id:data[i].id,data:data[i]});
	}
};

DbTableCol.prototype.getData = function(id){
	var _this = this;
    for (var i = 0; i < _this.initData.length; i++) {
        var jsonobj = _this.initData[i];
        if (jsonobj.id == id) {
            return jsonobj.data;
        }
    }
};

/**
 * 长度验证
 * @param 
 * @param 
 */
DbTableCol.prototype.lengthvalid = function(data, item, lengthValidFiled,
		lengthValidFiledComment, lengthValidFiledSize) {
	var msg = "";
	$
			.each(
					data,
					function(i, dataitem) {
						if (dataitem[item] != ""
								&& dataitem[item]
										.replace(/[^\x00-\xff]/g, "**").length > lengthValidFiledSize[$
										.inArray(item, lengthValidFiled)]) {
							msg = lengthValidFiledComment[$.inArray(item,
									lengthValidFiled)]
									+ "的输入长度超过预设长度"
									+ lengthValidFiledSize[$.inArray(item,
											lengthValidFiled)];
						}
					});
	return msg;
};

/**
 * 保存功能
 * @param form
 * @param callback
 */
DbTableCol.prototype.save = function(id) {
	var _self = this;
	//$(this._datagridId).jqGrid('endEditCell');
	var data = $(this._datagridId).jqGrid('getChangedCells');
	for(var i=0;i<data.length;i++)
	{
		    data[i].attribute02 = $('#'+$(data[i].attribute02).attr("id")).val();
			data[i].colComments = $('#'+$(data[i].colComments).attr("id")).val();
			data[i].colDefault = $('#'+$(data[i].colDefault).attr("id")).val();
			data[i].colIsSys = $('#'+$(data[i].colIsSys).attr("id")).val();
			data[i].colLength = $('#'+$(data[i].colLength).attr("id")).val();
			data[i].colName = $('#'+$(data[i].colName).attr("id")).val();
			//data[i].colNullable = $(data[i].colNullableName).find("select").val()

			data[i].colType = $('#'+$(data[i].colType).attr("id")).val();
			data[i].sysApplicationId = $('#'+$(data[i].sysApplicationId).attr("id")).val();
			//var nullable=data[i].colNullable;
			var isPk=data[i].colIsPk;
			/*if(nullable=="y"||nullable=="Y")
			{
			   data[i].colNullable="Y";
			}else
			{
				data[i].colNullable="N";
			}*/
			if(isPk=="y"||isPk=="Y")
			{
				data[i].colIsPk="Y";
			}else
			{
				data[i].colIsPk="N";
			}
			data[i].colName=data[i].colName.trim();
	}
	
	var hasvalidate = true;
	$.each(_self.notnullFiled, function(i, item) {
		var msg = _self.nullvalid(data, item, _self.notnullFiled,
				_self.notnullFiledComment);
		if (msg && msg.length > 0) {
			layer.alert(msg, {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0
			});
			hasvalidate = false;
			return false;
		}
	});
	if (iscreated == "Y"){
		for (var i=0;i<data.length;i++){
			var nid = data[i].id;
			var length = data[i].colLength;
			var oldData = this.getData(nid);
			
			if (oldData&&oldData.colLength){
				var oldLength = oldData.colLength;
				if (parseInt(oldLength)>parseInt(length)){
					layer.alert(oldData.colName+"字段长度错误，只可增大，不能减小", {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0
					});

					return false;
				}
			}
		}
	}
	$.each(_self.lengthValidFiled, function(i, item) {
		if (hasvalidate) {
			var msg = _self.lengthvalid(data, item, _self.lengthValidFiled,
					_self.lengthValidFiledComment, _self.lengthValidFiledSize);
			if (msg && msg.length > 0) {
				layer.alert(msg, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0
				});
				hasvalidate = false;
				return false;
			}
		}
	});
	if (!hasvalidate) {
		return false;
	}
	if (data && data.length > 0) {
		for ( var i = 0; i < data.length; i++) {
			if (data[i].id.indexOf(newRowStart) > -1) {
				data[i].id = '';
				data[i].tableId = id;
			}
			if (data[i].colType == "VARCHAR2" || data[i].colType == "NUMBER"){
				if (data[i].colLength == "0"){
					layer.alert('字段'+data[i].colName+'长度不能为0！', {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0
					});
					return false;
				}
				var colReg = /^\d+/;
				if(colReg.test(data[i].colName)){
					layer.alert('列名英文名称不能以数字开头！', {
						icon : 7,
						area : [ '300px', '' ], //宽高
						closeBtn : 0
					});
					return false;
				}
				var reg = /^[0-9]\d*$/;
				if(!reg.test(data[i].colLength)){
					layer.alert('列名为：“'+data[i].colName+'”的列长度输入有误，只能输入正整数！', {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0
					});
					return false;
				}
			}
			
		}

		avicAjax.ajax({
			url : _self.getUrl() + "save/"+id,
			data : {
				data : JSON.stringify(data)
			},
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag == "success") {
					_self.reLoad();
					layer.msg('保存成功！');
				} else {
					layer.alert('保存失败！' + r.e, {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0
					});
				}
			}
		});
	} else {
		layer.alert('请先修改数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
	}
};

/**
 * 详细页
 * @param id
 */
DbTableCol.prototype.detail = function(id) {
	this.detailIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '详细',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //不显示最大化最小化按钮
		content : this.getUrl() + 'Detail/' + id
	});
};

/**
 * 删除
 */
DbTableCol.prototype.del = function() {
	//$(this._datagridId).jqGrid('endEditCell');
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		layer.confirm('请确认删除后不会产生其它影响，若强制删除后则不可恢复，请慎用！是否删除？', {
			icon : 3,
			title : "提示：",
			closeBtn : 0,
			area : [ '400px', '' ]
		}, function(index) {
			for (; l--;) {
//				if (iscreated == "Y"){
//					if (rows[l].indexOf("new_row")==-1){
//						layer.alert('已经创建的字段无法删除！', {
//							icon : 7,
//							area : [ '400px', '' ], //宽高
//							closeBtn : 0
//						});
//						return false;
//					}
//				}
			
				if (rows[l].indexOf("new_row")!=-1){
					$(_self._datagridId).jqGrid("delRowData", rows[l]);  
				}else{
					var rowData = $(_self._datagridId).jqGrid('getRowData',rows[l]);
					if (rowData.colIsSys == "Y"){
						layer.alert('['+rowData.colName+']为系统字段，不能删除！', {
							icon : 7,
							area : [ '400px', '' ],
							closeBtn : 0
						});
						return false;
					}
					ids.push(rows[l]);
				}
				
			}
			var nowRowsCount = $(_self._datagridId).getGridParam("reccount");
			if(nowRowsCount==0){
				_self.reLoad();
			}
			if (ids.length>0){
				
				avicAjax.ajax({
					url : _self.getUrl() + 'delete',
					data : JSON.stringify(ids),
					contentType : 'application/json',
					type : 'post',
					dataType : 'json',
					success : function(r) {
						if (r.flag == "success") {
							layer.msg('删除成功！');
							_self.reLoad();
						} else {
							layer.alert('删除失败！' + r.error, {
								icon : 7,
								area : [ '400px', '' ],
								closeBtn : 0
							});
						}
					}
				});
			}
			layer.close(index);
		});
	} else {
		layer.alert('请选择要删除的记录！', {
			title : "提示：",
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
	}
};

//创建表
DbTableCol.prototype.create=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确定要创建该表吗?', {icon: 2, title:"请确认：", area: ['400px', '']}, function(index){
			for(;l--;){
				 ids.push(rows[l]);
			 }
			 avicAjax.ajax({
				 url:_self.getUrl()+'create',
				 data:	JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 layer.msg('创建成功！');
						 _self.reLoad();
					}else{
						layer.alert('创建失败！' + r.error, {
									  icon: 7,
									  area: ['400px', ''],
									  closeBtn: 0
									}
						);
					}
				 }
			 });
			 layer.close(index);
		});   
	}else{
		layer.alert('请选择要创建表的记录！', {
				  icon: 7,
				  area: ['400px', ''],
				  closeBtn: 0
				}
		);
	}
};

/**
 * 重载数据
 */
DbTableCol.prototype.reLoad = function() {
	var searchdata = {
		keyWord : null,
		param : JSON.stringify(serializeObject($(this._formId)))
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

/**
 * 打开高级查询框
 * @param searchBtn 高级查询按钮HTMLObject对象
 * @param contentWidth 高级查询框宽度
 * @param contentHeight 高级查询框高度
 */
DbTableCol.prototype.openSearchForm = function(searchDiv) {
	var _self = this;
	var contentWidth = 800;
	var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
	var left = $(searchDiv).offset().left + $(searchDiv).outerWidth()
			- contentWidth;
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
		area : [ contentWidth + 'px', '400px' ],
		offset : [ top + 'px', left + 'px' ],
		closeBtn : 0,
		shadeClose : true,
		btn : [ '查询', '清空', '取消' ],
		content : $(this._searchDialogId),
		success : function(layero, index) {
			var serachLabel = $(
					'<div class="serachLabel"><span>' + text
							+ '</span><span class="caret"></span></div>')
					.appendTo(layero);
			serachLabel.bind('click', function() {
				layer.close(index);
			});
			serachLabel.css('width', width + 'px');
		},
		yes : function(index, layero) {
			_self.searchData();
			layer.close(index);//查询框关闭
		},
		btn2 : function(index, layero) {
			clearFormData(_self._formId); //清空数据
			_self.searchData(); //查询
			return false;
		},
		btn3 : function(index, layero) {

		}
	});
};

/**
 * 高级查询
 */
DbTableCol.prototype.searchData = function() {
	var searchdata = {
		keyWord : null,
		param : JSON.stringify(serializeObject($(this._formId)))
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

/**
 * 关键字查询
 */
DbTableCol.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for ( var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}

	var searchdata = {
		keyWord : JSON.stringify(param),
		param : null
	};

	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

DbTableCol.prototype.copytable = function(){
	var _this = this;

	this.copyDialog = layer.open({
		type: 2,
		title: '拷贝本地数据表',
		skin: 'bs-modal',
		area: ['60%', '60%'],
		maxmin: false,
		content: "platform/db/dbCommonColController/toCopyJsp"
	});
};

DbTableCol.prototype.copyrow = function(){
	var _self = this;

	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择要复制的行！', {
				icon: 7,
				area: ['400px', ''], //宽高
				closeBtn: 0,
				btn: ['关闭'],
				title:"提示"
			}
		);
		return false;
	}
	for(var i = 0; i< ids.length; i++){
		var rowData = $(this._datagridId).jqGrid('getRowData',ids[i]);
		rowData.colName = $("#"+$(rowData.colName).attr("id")).val();
		rowData.colComments = $("#"+$(rowData.colComments).attr("id")).val();
		rowData.colLength = $("#"+$(rowData.colLength).attr("id")).val();
		rowData.attribute02 = $("#"+$(rowData.attribute02).attr("id")).val();
		rowData.id = '';
		rowData.tableId = _self._tableId;
		rowData.colDefault = $("#"+$(rowData.colDefault).attr("id")).val();;
		rowData.colIsSys = $("#"+$(rowData.colIsSys).attr("id")).val();
		rowData.sysApplicationId = $("#"+$(rowData.sysApplicationId).attr("id")).val();
		rowData.colType = $("#"+$(rowData.colType).attr("id")).val();
		this.insert(rowData);
	}
};


DbTableCol.prototype.commoncol = function(){
	var _this = this;

	var selectDialog = openDialog({
		type : 'selectWindow',
		title : "请选择常用字段",
		url : "avicit/platform6/db/dbcommoncol/commonColSelect.jsp",
		width : "720px",
		height : "460px",
		opentype : 2,
		shade : true,
		submit : function(index, layer) {
			var iframeWin = layer.find('iframe')[0].contentWindow;
			var r = iframeWin.getColList();
			for(var i = 0; i< r.length; i++) {
				var ele = r[i];
				var rowData = {};
				rowData.attribute02 = ele.colDecimal; //精度
				rowData.colIsPk = 'N';
				rowData.colIsPkName = '否';
				rowData.colComments = ele.colComments;//字段中文
				rowData.colLength = ele.colLength; //字段长度
				rowData.colName = ele.colName;  //字段名称
				//rowData.colNullable = 'N';
				rowData.id = '';
				rowData.colDefault = '';
				rowData.colIsSys = 'N';
				rowData.colType = ele.colType;
				rowData.tableId = dbTableCol._tableId;
				dbTableCol.insert(rowData);
			}
		},
		beferClose: function(index, layer){

		},
		init : function(index, layer) {
			var iframeWin = layer.find('iframe')[0].contentWindow;
			iframeWin.init();

		}
	});
};
// 关闭对话框
DbTableCol.prototype.closeDialog = function(id) {
	if (id == "copy") {
		layer.close(this.copyDialog);
	}
};


DbTableCol.prototype.searchWord = function(val) {
	var search_param = new Array(); //用于保存筛选规则
	var a = new GridSearch($(this._datagridId)); //创建实例-传入JqGrid的对象
	search_param.push({
		rule_name: 'vague', //筛选方式
		str: val, //筛选值
		column: 'colName' //列名
	});
	a.set_search_param(search_param); //提交设置规则
	a.search();
}

/*
        jqGrid 前端筛选功能
    */
var GridSearch = function (grid) {

	this.grid = grid;
	this.search_param = null;
	this.r = [];
	this.data = this.grid.jqGrid('getRowData');

	//根据键值删除指定的元素
	this.delete_val_by_key = function (keys, arr) {
		for (var j = 0, i = 0; i < keys.length; i++) {
			arr.splice(keys[i - j], 1);
			j++;
		}
		return arr;
	}

	/**
	 * 隐藏行
	 */
	this.hideRow = function(rowId) {
		this.grid.setRowData(rowId, null, {
			display : 'none'
		});
	}
	/**
	 * 显示行
	 */
	this.showRow = function(rowId) {
		this.grid.setRowData(rowId, null, {
			display : ''
		});
	}
	/**
	 * 显示全部行
	 */
	this.showAllRow = function() {
		for (var i = 0; i < this.data.length; i++) {
			this.showRow(i+1)
		}
	}

	//设置筛选参数
	this.set_search_param = function (search_param) {
		this.search_param = search_param;
	}

	//筛选规则
	/*模糊筛选*/
	this.vagueSearch = function (str, column) {
		var re = new RegExp(str, "i");
		// var is = [];
		for (var i = 0; i < this.data.length; i++) {
			var colValue = $("#"+$(this.data[i][column]).attr("id")).val();

			if (re.test(colValue)) {
				this.showRow($(this.data[i]['sysApplicationId']).attr('rowid'))
			}else{
				this.hideRow($(this.data[i]['sysApplicationId']).attr('rowid'));
			}
		}
	}

	/*区间查找*/
	this.betweenSearch = function (start, end, column) {
		// var is = [];
		for (var i = 0; i < this.data.length; i++) {
			if (this.data[i][column] >= start && this.data[i][column] <= end) {
				this.showRow(i+1)
			}else{
				this.hideRow(i+1);
			}
		}
	}

	/*根据参数选择规则筛选*/
	this.select = function (params) {
		//var rule_name = params.rule_name;
		switch (params.rule_name) {
			case 'between':
				//console.log(this.result);
				this.betweenSearch(params.start, params.end, params.column);
				break;
			case 'vague':
				this.vagueSearch(params.str, params.column);
				break;
		}
	}

	/*清空 result */
	this.clearData = function () {
		this.data = [];
	}

	//执行筛选
	this.search = function () {
		if (this.search_param) {
			if ($.type(this.search_param) == 'array') {
				for (var i = 0; i < this.search_param.length; i++) {
					if (this.search_param[i]) {
						this.select(this.search_param[i]);
					}else{
						this.showAllRow();
					}
				}
			} else {
				this.select(this.search_param);
			}
		}else{
			this.showAllRow();
		}
	}
}