function searchByKeyWord(){
	var keyWord = $("#keyWord").val();
	var searchdata = {
			tableName: keyWord,
			param: null
		}
	$("#dataSourceTableModel").jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
}


function doImport(data){
	//alert(dataSourceTypeTree.selectedNodeId);
    avicAjax.ajax({
		url : 'platform/db/import/'+parent.dbTableTypeTree.selectedNodeId+'/doImportOut',
		data : {datas:data,dataSourceId:dataSourceTypeTree.selectedNodeId},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				parent.dbTableTypeTree.clickCurrentNode();
				parent.dbTableType.closeDialog("importOut");
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

function importOutTable(){
	var rowIds = $("#dataSourceTableModel").jqGrid('getGridParam', 'selarrrow');
	var rows = [];
	var l = rowIds.length;
	if (l > 0) {
		layer.confirm('确定导入已选表么?', {
			icon : 7,
			title : "请确认：",
			area : [ '400px', '' ]
		}, function(index) {
			for (; l--;) {
				var row = $("#dataSourceTableModel").jqGrid('getRowData',rowIds[l]);
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
