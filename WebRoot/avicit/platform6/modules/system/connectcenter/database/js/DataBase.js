/**
 * Created by rx on 2017/9/13.
 */
function DataBase(dataBaseArea, dataBaseDiv) {
    this.dataBaseArea = dataBaseArea;
    this.dataBaseDiv = dataBaseDiv;

    this.selectedDataBaseId = null;
    this.init.call(this);
};
//初始化操作
DataBase.prototype.init = function () {
    var _this = this;

};

//添加
DataBase.prototype.addData = function (){
	addDialog = layer.open({
        type: 2,
        title: '添加【DataBase】',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content: "platform/database/dataBaseController/addDataBase"
    });
}
//编辑
DataBase.prototype.editData = function () {
    var _this = this;
    var rows = $('#dataBaseModel').jqGrid('getGridParam','selarrrow');
	var l =rows.length;
	if(l==1){
		dataBaseId = rows[0];
		editDialog = layer.open({
	        type: 2,
	        title: '编辑【DataBase】',
	        skin: 'bs-modal',
	        area: ['100%', '100%'],
	        maxmin: false,
	        content: "platform/database/dataBaseController/editDataBase?id=" + dataBaseId
	    });
	}else{
		layer.alert('请选择一条记录编辑！',{
	  		icon: 7,
	  		title:'提示',
	  		area: ['400px', ''], //宽高
	  		closeBtn: 0
		});
		return false;
	}
};
//删除
DataBase.prototype.deleteData = function () {
    var _this = this;
    
    var rows = $('#dataBaseModel').jqGrid('getGridParam','selarrrow');
    var ids = [];
	var l =rows.length;
	if(l>0){
		layer.confirm('确定要删除数据源吗？',{
			icon : 3,
			title : '提示'
		},  function (index) {
			for(;l--;){
				 ids.push(rows[l]);
			 }
	        $.ajax({
	            url: "platform/database/dataBaseController/deleteDataBase",
	            data: JSON.stringify(ids),
	            contentType : 'application/json',
	            type: "post",
	            async: false,
	            dataType: "json",
	            success: function (r) {
	            	if (r.flag == "success") {
	            		layer.msg('操作成功！',{icon: 1});
	            		dataBaseModel.reLoad(connectTypeTree.selectedNodeId);
					}else{
						layer.alert('操作失败！' + r.error,{
				  		icon: 7,
				  		area: ['400px', ''], //宽高
				  		closeBtn: 0
			    		}
	         			);
					}
	            }
	        });
	        layer.close(index);
	    });
	}else{
		layer.alert('请选择要删除的记录！',{
	  		icon: 7,
	  		title:'提示',
	  		area: ['400px', ''], //宽高
	  		closeBtn: 0
		}
 );
	}
    
};
//表单验证
DataBase.prototype.formValidate = function (form) {

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
//测试连接 + r.error
DataBase.prototype.testConnect = function (form,classId) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }
    
    var formSerializeValue = form.serialize();
    //formSerializeValue = decodeURIComponent(formSerializeValue,true);//解决序列化时乱码
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);
    var parm = "formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/database/connectDBController/testConnectOracle",
        data: {formDataJson:formDataJson,classId:classId},
        type: "post",
        async: false,
        dataType: "json",
        success: function (r) {
        	if (r.flag == "success") {
        		layer.msg('连接成功！',{icon: 1});
			}else{
				layer.alert('连接失败！',{
		  		icon: 7,
		  		area: ['400px', ''], //宽高
		  		closeBtn: 0
	    		}
     			);
			}
        }
    });
};
//提交添加
DataBase.prototype.subAdd = function (form,classId) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }
    
    var formSerializeValue = form.serialize();
    formSerializeValue = decodeURIComponent(formSerializeValue,true);//解决序列化时乱码
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);
    
    var parm = "formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/database/dataBaseController/subAddDataBase",
        data: {formDataJson:formDataJson,classId:classId},
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                //_this.setComponent(backData.data);

                layer.msg('操作成功！',{icon: 1});

                _this.closeDialog("add");
            }
            else {
                layer.msg('操作失败！',{icon: 2});
            }
        }
    });
    dataBaseModel.reLoad(connectTypeTree.selectedNodeId);
};
//提交编辑
DataBase.prototype.subEdit = function (form) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/database/dataBaseController/subEditDataBase",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                layer.msg('操作成功！',{icon: 1});
                _this.closeDialog("edit");
            }
            else {
                layer.msg('操作失败！',{icon: 2});
            }
        }
    });
    dataBaseModel.reLoad(connectTypeTree.selectedNodeId);
};
//关闭弹出框
DataBase.prototype.closeDialog = function (type) {
    if (type == "add") {
        layer.close(addDialog);
    }
    if (type == "edit") {
        layer.close(editDialog);
    }
};
//获取数据源列表
DataBase.prototype.getDataBaseList = function (selectedNodeId) {
    var _this = this;
    if(showType=="2"){		
		if(dataBaseModel==null || dataBaseModel==undefined){
			var searchSubNames = new Array();
			var searchSubTips = new Array();
			searchSubNames.push("name");
			searchSubTips.push("数据源名称");
			$('#componentModel_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
			var dataBaseModelGridColModel = [
				{
					label : '数据源类型',
					name : 'classId',
					key : true,
					hidden : true
				},{
					label : '标识',
					name : 'id',
					key : true,
					width:200
				}, {
					label : '名称',
					name : 'name',
					align : 'center',
					sortable : false
				}, {
					label : '用户',
					name : 'userName',
					align : 'center',
					sortable : false
				}, {
					label : '初始连接池',
					name : 'initPollConnect',
					hidden:true,
					align : 'center',
					sortable : true
				}, {
					label : '最大连接池',
					name : 'maxPollConnect',
					align : 'center',
					hidden:true,
					sortable : true
				}, {
					label : '使用状态',
					name : 'isUsed',
					align : 'center',
					sortable : true,
					formatter:getformviewStatus
				}
				,  {
					label : '操作',
					name : 'opt',
					align : 'center',
					sortable : false,
					formatter:getOptButtons
				}
			];

			var url = "platform/database/dataBaseController/getDataBaseByPage";
			dataBaseModel = new DataBaseModel('dataBaseModel', url, "formSub", dataBaseModelGridColModel, 'searchDialogSubDB', selectedNodeId, 
					"", searchSubNames, "DBModel_keyWord");
		}else{
			dataBaseModel.reLoad(selectedNodeId);
		}
	}else{
	    $('#' + _this.componentDiv).empty();
	    $.ajax({
	        url: "platform/eform/bpmsManageController/getComponentList",
	        data: "selectedNodeId=" + selectedNodeId,
	        type: "post",
	        async: false,
	        dataType: "json",
	        success: function (backData) {
	            var componentList = backData.data;
	
	            for (var i = 0; i < componentList.length; i++) {
	                _this.setComponent(componentList[i]);
	            }
	        }
	    });
	}
};

DataBase.prototype.isUsedDo = function (nodeId) {
	var comfirmMsg = "确定要启用该数据源吗？";
	layer.confirm(comfirmMsg, function (index){
		$.ajax({
	        url: "platform/database/dataBaseController/isUsedDo",
	        data: {nodeId:nodeId},
	        type: "post",
	        async: false,
	        dataType: "json",
	        success: function (backData) {
	            if (backData.result == "1") {
	                layer.msg('操作成功！',{icon: 1});
	            }
	            else {
	                layer.msg('操作失败！',{icon: 2});
	            }
	        }
	    });
		dataBaseModel.reLoad(connectTypeTree.selectedNodeId);
	});
    
    
};
DataBase.prototype.isUsedUndo = function (nodeId) {
	var comfirmMsg = "确定要停用该数据源吗？";
	layer.confirm(comfirmMsg, function (index){
		$.ajax({
	        url: "platform/database/dataBaseController/isUsedUndo",
	        data: {nodeId:nodeId},
	        type: "post",
	        async: false,
	        dataType: "json",
	        success: function (backData) {
	            if (backData.result == "1") {
	                layer.msg('操作成功！',{icon: 1});
	            }
	            else {
	                layer.msg('操作失败！',{icon: 2});
	            }
	        }
	    });
	    dataBaseModel.reLoad(connectTypeTree.selectedNodeId);
	});
    
};

function getformviewStatus(cellvalue, options, rowObject){
	if(rowObject.isUsed == "1"){
		return '<font color="#0F9D58">启用</font>';
	}else{
		return '<font color="#AABBAF">停用</font>';
	}
}
function getOptButtons(cellvalue, options, rowObject) {
	if(rowObject.isUsed == "1"){
		return '<a href="javascript:void(0)" class="glyphicon glyphicon-off" title="停用" onClick="dataBase.isUsedUndo(\''+rowObject.id+'\')"></a>';
	}else{
		return '<a href="javascript:void(0)" class="glyphicon glyphicon-upload" title="启用" onClick="dataBase.isUsedDo(\''+rowObject.id+'\')"></a>';
	}
}

