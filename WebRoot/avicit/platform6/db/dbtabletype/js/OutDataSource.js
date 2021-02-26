/**
 * Created by rx on 2017/9/13.
 */
function OutDataSource(dataSourceArea, dataSourceDiv) {
    this.dataSourceArea = dataSourceArea;
    this.dataSourceDiv = dataSourceDiv;

    this.selectedDataSourceId = null;
    this.init.call(this);
};
//初始化操作
OutDataSource.prototype.init = function () {
    var _this = this;
};


//选定数据源
OutDataSource.prototype.chooseDataSource = function (dataSourceId){
	if(dataSourceId==""){
    	var rows = $('#dataSourceTableModel').jqGrid('getGridParam','selarrrow');
        var ids = [];
    	var l =rows.length;
    	if(l==1){
    		dataSourceId = rows[0];
    	}else{
    		layer.alert('请选择一个数据源！',{
    	  		icon: 7,
    	  		title:'提示',
    	  		area: ['400px', ''], //宽高
    	  		closeBtn: 0
    		});
    		return false;
    	}
    }
	importOutDialog = layer.open({
        type: 2,
        title: '导入外部数据表',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content: "platform/db/dbTableManageController/toImportOutJsp?id=" + dataSourceId
    });
	
}

//表单验证
OutDataSource.prototype.formValidate = function (form) {

    form.validate({
        rules: {
        	name: {
                required: true,
                maxlength: 200
            },
            userName: {
                required: true,
                maxlength: 200
            },
            passWord: {
                required: true,
                maxlength: 200,
            },
            driver: {
                required: true,
                maxlength: 200,
            },
            urlValue: {
                required: true,
                maxlength: 200,
            }
        }
    });
};
//关闭弹出框
OutDataSource.prototype.closeDialog = function (type) {
    if (type == "add") {
        layer.close(addDialog);
    }
    if (type == "edit") {
        layer.close(editDialog);
    }
};
//获取数据源列表
OutDataSource.prototype.getDataSourceList = function (selectedNodeId) {
    var _this = this;		
	if(dataSourceTableModel==null || dataSourceTableModel==undefined){
		var searchSubNames = new Array();
		var searchSubTips = new Array();
		searchSubNames.push("name");
		searchSubTips.push("数据源名称");
		$('#componentModel_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
		var dataSourceTableModelGridColModel = [
			{
				label : 'id',
				name : 'id',
				key : true,
				width : 75,
				hidden : true
			},  {
				label : 'pk',
				name : 'pk',
				width : 150,
				editable : false,
				hidden : true
			},  {
				label : '数据源ID',
				name : 'dataSourceId',
				width : 150,
				editable : false,
				hidden : true
			},{
				label : '数据库表名',
				name : 'tableName',
				width : 150,
				editable : false
			},{
				label : '数据库表描述',
				name : 'tableComment',
				width : 150,
				editable : false
			}
		];

		var url = "platform/db/import/getImportOutTable";
		dataSourceTableModel = new OutDataSourceTableModel('dataSourceTableModel', url, "formSub", dataSourceTableModelGridColModel, 'searchDialogSub', selectedNodeId, 
				"", searchSubNames, "componentModel_keyWord");
	}else{
		dataSourceTableModel.reLoad(selectedNodeId);
	}
};

