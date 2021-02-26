function searchByKeyWord(){
	var placeholder =$("#keyWord").attr("placeholder");
	var keyWord = "";
	if (placeholder != $("#keyWord").val()){
		keyWord = $("#keyWord").val();
	}
	var searchdata = {
			tableName: keyWord,
			param: null
		}
	$("#jqGrid").jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
}


function doImport(data){
    avicAjax.ajax({
		url : 'platform/db/import/'+parent.dbTableTypeTree.selectedNodeId+'/doImport',
		data : {datas:data},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				parent.dbTableTypeTree.clickCurrentNode();
				parent.dbTableType.closeDialog("import");
			} else {
				layer.alert('导入失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0
				});
			}
		}
	});
}

function importTable(){
	var rowIds = $("#jqGrid").jqGrid('getGridParam', 'selarrrow');
	var rows = [];
	var l = rowIds.length;
	if (l > 0) {
		layer.confirm('确定导入已选表么?', {
			icon : 7,
			title : "请确认：",
			area : [ '400px', '' ]
		}, function(index) {
			for (; l--;) {
				var row = $("#jqGrid").jqGrid('getRowData',rowIds[l]);
				rows.push(row);
			}
			var data =JSON.stringify(rows);

            avicAjax.ajax({
				url : 'platform/db/import/checkTableName',
				data : {datas:data},
				type : 'post',
				dataType : 'json',
				success : function(r) {
					var flag = true;
					var msg = "";
					if (r.flag == "success") {
						flag = true;
					}else if(r.flag == "echo"){
						flag = true;
						msg = r.error;
					}else {
						flag = false;
					}
					if (flag&&msg){
						layer.confirm(msg+'，确定覆盖导入?', {
							icon : 7,
							title : "请确认：",
							area : [ '400px', '' ]
						},function(index){
							doImport(data);
						});
					}else if(flag){
						doImport(data);
					}else{
						layer.alert('导入失败！' + r.error, {
							icon : 7,
							area : [ '400px', '' ],
							closeBtn : 0
						});
					}
				}
			});
			
			
		});
	} else {
		layer.alert('请选择要导入的表！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
	}
}


function copyTable(){
	var ids = $("#jqGrid").jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择要复制的表！', {
				icon: 7,
				area: ['400px', ''], //宽高
				closeBtn: 0,
				btn: ['关闭'],
				title:"提示"
			}
		);
		return false;
	}else if(ids.length > 1){
		layer.alert('只允许选择一条数据！', {
				icon: 7,
				area: ['400px', ''], //宽高
				closeBtn: 0,
				btn: ['关闭'],
				title:"提示"
			}
		);
		return false;
	}
	var rowData = $("#jqGrid").jqGrid('getRowData', ids[0]);
	avicAjax.ajax({
		url : 'platform/platform6/db/dbtablecol/dbTableColController/operation/getAllCol/' + rowData.tableName,
		data : {},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if(r != null && r != undefined){
				for(var i = 0; i< r.length; i++){
					var ele = r[i];
					var rowData = {};
					var colType = ele.dataType;
					if(colType == "NUMBER"){
						rowData.attribute02 = ele.scale; //精度
					}else{
						rowData.attribute02 = null; //精度
					}

					var colLength = ele.dataLength;
					if(colType == "DATE" || colType == "CLOB" ||colType == "BLOB"){
						rowData.colLength = null;
					}else{
						rowData.colLength = colLength;
					}


					rowData.colIsPk = ele.isPrimary;
					rowData.colIsPkName = (ele.isPrimary=='Y'?'是':'否');
					rowData.colComments = ele.comment;//字段中文
					rowData.colName = ele.columnName;  //字段名称
					rowData.colNullable = ele.isNullable;
					rowData.id = '';
					rowData.tableId = parent.dbTableCol._tableId;
					rowData.colDefault = null;
					rowData.colIsSys = null;
					rowData.sysApplicationId = null;
					rowData.colType = ele.dataType;
					parent.dbTableCol.insert(rowData);
				}
			}

			parent.dbTableCol.closeDialog("copy");
		}
	});
}
