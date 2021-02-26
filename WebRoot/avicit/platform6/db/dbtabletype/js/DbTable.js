/**
 * Created by lianch on 2017/5/25.
 */
function DbTable(componentArea, componentDiv) {
    this.componentArea = componentArea;
    this.componentDiv = componentDiv;

    this.selectedEformComponentId = null;
    this.init.call(this);
}
//初始化操作
DbTable.prototype.init = function () {
    var _this = this;

    var template = $(
          '<div class="eform-item" id="">'
            + '<div class="eform-item-title" title="" data-toggle="popover" data-container="body" data-placement="auto bottom">'
                + '<i class="iconfont icon-shujuku eform-item-group"></i>'
            + '</div>'
            + '<div class="eform-item-bottom">'
            	+'<div style="width:90%;float: left;text-align: center;">'
	                + '<div class="eform-item-bottom-name" title="模块">模块</div>'
	                + '<div class="eform-item-bottom-tablename" title="模块">模块</div>'
	            +'</div>'
	            +'<div class="eform-item-btn-area">'
	                + '<span class="eform-item-bottom-btn">'
	                    + '<i class="glyphicon glyphicon-option-vertical"></i>'
	                + '</span>'
	            +'</div>'
            + '</div>'
            + '<div class="eform-item-tools" style="display: none;">'
                + '<div class="editDbTable"><i class="glyphicon glyphicon-pencil"></i>编辑表</div>'
                + '<div class="deleteDbTable"><i class="glyphicon glyphicon-trash"></i>删除表</div>'
                + '<div class="createDbTable"><i class="glyphicon glyphicon-file"></i>创建表</div>'
                + '<div class="reImportDbXml"><i class="glyphicon glyphicon-floppy-save"></i>覆盖导入</div>'
                + '<div class="exportDbXml"><i class="glyphicon glyphicon-floppy-open"></i>导出</div>'
                + '<div class="changeDirectory"><i class="glyphicon glyphicon-transfer"></i>切换目录</div>'
            + '</div>'
//            + '<div class="eform-item-checkbox">'
//                + '<input type="checkbox">'
//            + '</div>'
        + '</div>'
    );

    this.template = template;
};
//页面新建一个DbTable
DbTable.prototype.setComponent = function (data, searchDbDiv) {
    var _this = this;

    var dbtable = _this.template.clone();
    
    //唯一标识
    dbtable.attr("id", data.id);
    dbtable.attr("iscreated",data.tableIsCreated);

    dbtable.find(".eform-item-title").attr("title","");
    var dataSourceName = '';
    if(data.dataSourceId != null && data.dataSourceId.length==32){
    	dataSourceName = "CC("+data.connectType+"-"+data.dataSourceName+")";
    }else{
    	dataSourceName = "local";
    }
    var tableIsCreated = '';
    if(data.tableIsCreated =='Y'){
    	tableIsCreated = "是";
    }else{
    	tableIsCreated = "否";
    }
    var _dataContent = '';
    var tableNameShow="";
    var tableCommentsShow="";
    if(data.tableName.length>17)
    {
    	tableNameShow=data.tableName.substring(0,17)+'\n'+data.tableName.substring(17);
    }else
    {
    	tableNameShow=data.tableName;
    }

    if(data.tableComments.length>17)
    {
        tableCommentsShow=data.tableComments.substring(0,17)+'\n'+data.tableComments.substring(17);
    }else
    {
        tableCommentsShow=data.tableComments;
    }

    var dbtype = '';
    if (data.dbType == "1"){
        dbtype = "数据表";
    }else if (data.dbType == "2"){
        dbtype = "视图";
    }else if (data.dbType == "3"){
        dbtype = "系统表";
    }


    _dataContent = '<table width="180px" border="0" style="font-size:12px;"  align="center">'
		+'<tr><td width="40%" height="25"><lable>表英文名:</lable></td><td>'+tableNameShow+'</td></tr>'
		+'<tr><td width="40%" height="25"><lable>表中文名:</lable></td><td>'+tableCommentsShow+'</td></tr>'
		+'<tr><td width="40%" height="25">数&nbsp;&nbsp;据&nbsp;&nbsp;源:</td><td>'+dataSourceName+'</td></tr>'
        +'<tr><td width="40%" height="25">类&nbsp;&nbsp;&nbsp;&nbsp;型:</td><td>'+dbtype+'</td></tr>'
		+'<tr><td width="40%" height="25">是否创建:</td><td>'+tableIsCreated+'</td></tr>'
		+'</table>';
    dbtable.find(".eform-item-title").attr("data-content",_dataContent);
    dbtable.find("[data-toggle='popover']").popover({html:true,trigger:'hover'});
    
    //显示属性
    dbtable.find(".eform-item-bottom-name").attr("title", data.tableComments);
    if(data.tableComments.length > 7) {
        dbtable.find(".eform-item-bottom-name").text(data.tableComments.substring(0, 7)+"...");
    }
    else {
        dbtable.find(".eform-item-bottom-name").text(data.tableComments);
    }
    
  //显示属性
    dbtable.find(".eform-item-bottom-tablename").attr("title", data.tableName);
    if(data.tableName.length > 10) {
        dbtable.find(".eform-item-bottom-tablename").text(data.tableName.substring(0, 10)+"...");
    }
    else {
        dbtable.find(".eform-item-bottom-tablename").text(data.tableName);
    }

    //模块点击事件绑定
    dbtable.find(".eform-item-title").click(function () {
        _this.selectedEformComponentId = data.id;

        var table = $("#"+data.id);
    	var iscreated = table.attr("iscreated");
        //打开详细页
        layer.open({
    	    type: 2,
    	    area: ['100%', '100%'],
    	    title: '详细页-'+data.tableName,
    	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
            maxmin: false, //开启最大化最小化按钮
    	    content: 'platform6/db/dbtablecol/dbTableColController/toDbTableColManage/'+data.id
    	    			+"?iscreated="+iscreated+"&dataSourceName="+dataSourceName+"&tableName="+data.tableName+"&dbtype="+data.dbType
    	});

        return false;
    });

    //显隐工具栏按钮事件绑定
    dbtable.find(".eform-item-bottom-btn").click(function () {
    	$(".eform-item-tools").hide();
        dbtable.find('.eform-item-tools').toggle(200);
        return false;
    });

    //工具栏事件绑定
    dbtable.find(".deleteDbTable").click(function () {
    	var table = $("#"+data.id);
    	var iscreated = table.attr("iscreated");
        _this.deleteTable(data.id,iscreated,data.tableName,data.tableType);
        return false;
    });
    dbtable.find(".editDbTable").click(function () {
        _this.edit(data.id);
        return false;
    });
    dbtable.find(".createDbTable").click(function () {
        _this.create(data.id);
        return false;
    });
    dbtable.find(".reImportDbXml").click(function () {
        _this.reImportDbXml(data);
        return false;
    });
    dbtable.find(".exportDbXml").click(function () {
        _this.exportDbXml(data);
        return false;
    });
    dbtable.find(".changeDirectory").click(function () {
        _this.changeDirectory(data);
        return false;
    });
    
    $('body').click( function() {  
    	dbtable.find('.eform-item-tools').hide();
    });  
    
  //如果物理表已创建，图标显示变为蓝色
    if(data.tableIsCreated == "Y"){
    	dbtable.find("i.eform-item-group").css("color","rgb(0, 153, 204)");
//    	dbtable.find(".deleteDbTable").remove();
    	dbtable.find(".createDbTable").remove();
    }
    if(data.dbType == "1"){
        dbtable.find("i.eform-item-group").attr("class","iconfont icon-shujuku eform-item-group");
    }else if (data.dbType == '2'){
        dbtable.find("i.eform-item-group").attr("class","icon iconfont icon-preview eform-item-group");
    }else if (data.dbType == '3'){
        dbtable.find("i.eform-item-group").attr("class","icon iconfont icon-shezhi eform-item-group");
    }


    var componentDiv = _this.componentDiv;
    if (searchDbDiv != null) {
        componentDiv = searchDbDiv;
    }

    $('#' + componentDiv).append(dbtable);
};

DbTable.prototype.clickTitle = function (id,tableName,dataSourceId,dbType){
	this.selectedEformComponentId =id;

	var dataSourceName = '';
    if(dataSourceId != null && dataSourceId.length==32){
    	dataSourceName = "CC";
    }else{
    	dataSourceName = "local";
    }
    var table = $("#"+id);
	var iscreated = table.attr("iscreated");
    //打开详细页
    layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '详细页-'+tableName,
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform6/db/dbtablecol/dbTableColController/toDbTableColManage/'+id+"?iscreated="
        +iscreated+"&dataSourceName="+dataSourceName+"&dbtype="+dbType
	});
};

//添加
DbTable.prototype.add = function () {
    var _this = this;

    if (dbTableTypeTree.selectedNodeId == null) {
    	layer.alert('请选择树节点！');
    }else if(dbTableTypeTree.selectedNodeId == "1"){
    	layer.msg('不能在根目录添加表模型！', {icon: 7});
    }
    else {
        addDialog = layer.open({
            type: 2,
            title: '添加表模型',
            closeBtn : 0,
            skin: 'bs-modal',
            area: ['60%', '60%'],
            maxmin: false,
            content: "platform/db/dbTableManageController/toAddDbTable"
        });
    }
};
//编辑
DbTable.prototype.edit = function (dbTableId) {
    var _this = this;

    editDialog = layer.open({
        type: 2,
        title: '编辑表模型',
        closeBtn : 0,
        skin: 'bs-modal',
        area: ['60%', '60%'],
        maxmin: false,
        content: "platform/db/dbTableManageController/editDbTable?id=" + dbTableId
    });
};
//删除
DbTable.prototype.deleteTable = function (dbTableId,iscreated,tablename,typeid) {
    var _this = this;
    var tip =  "确定要删除表模型吗？";
    if (iscreated == "Y"){
    	tip = "该表已经创建，删除同时不会废弃已创建的实体表，是否继续？"
    }
	    layer.confirm(tip,{
			icon : 3,
			title : '提示',
			closeBtn : 0 ,
			area: ['400px', '']
		},function (index) {
	        $.ajax({
	            url: "platform/db/dbTableManageController/deleteDbTable",
	            data: "id=" + dbTableId+"&tableName=" + tablename+"&typeId=" + typeid,
                type: "post",
	            async: false,
	            dataType: "json",
	            success: function (backData) {
	                if (backData.result == "1") {
	                    var dbtable = $('#' + _this.componentDiv).find("#" + dbTableId);
	                    dbtable.remove();
	                    if (eformComponentModel !=null && eformComponentModel!="undefined")
	                    	eformComponentModel.reLoad(dbTableTypeTree.selectedNodeId);
	                    layer.msg('操作成功');
	                }else if(backData.result == "-1"){
	                	layer.msg('该表已经被使用，不能删除！');
	                }
	                else {
	                    layer.msg('操作失败');
	                }
	            }
	        });
	    });
    
};

//添加
DbTable.prototype.commonColSet = function () {
    var _this = this;

    addDialog = layer.open({
        type: 2,
        title: '常用字段设置',
        closeBtn : 1,
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content: "platform/db/dbCommonColController/toDbCommonColManage"
    });
};

//创建表
DbTable.prototype.create = function (dbTableId) {
    var _this = this;
    var dbtable = $('#' + _this.componentDiv).find("#" + dbTableId);
    var iscreated = dbtable.attr("iscreated");
    if (iscreated == "Y"){
    	layer.msg("该表已经创建！");
    	return false;
    }
    layer.confirm('确定要创建表吗？',  {
		icon : 3,
		title : '提示',
		closeBtn : 0 ,
		area: ['400px', '']
	},function (index) {
        $.ajax({
            url: "platform/db/dbTableManageController/createDbTable",
            data: "id=" + dbTableId,
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                if (backData.result == "1") {
                	//创建完成，置换图标颜色
                    dbtable.attr("iscreated","Y");
                    dbtable.find("i.eform-item-group").css("color","rgb(0, 153, 204)");
                    //dbtable.find(".deleteDbTable").remove();
                	dbtable.find(".createDbTable").remove();
                	if (eformComponentModel !=null && eformComponentModel!="undefined")
                		eformComponentModel.reLoad(dbTableTypeTree.selectedNodeId);
                    layer.msg('操作成功');
                }
                else {
                	layer.alert(backData.result, {icon: 2});
                }
            }
        });
    });
};
//导入存储模型xml
DbTable.prototype.importDbXml = function () {
    if (dbTableTypeTree.selectedNodeId == null) {
        layer.alert('请选择树节点！');
    }else if(dbTableTypeTree.selectedNodeId == "1"){
        layer.msg('不能在根目录导入存储模型！', {icon: 7});
    }
    else {
        uploadDialog = layer.open({
            type: 2,
            title: '导入存储模型xml',
            skin: 'bs-modal',
            area: ['50%', '50%'],
            maxmin: false,
            content: "avicit/platform6/db/dbtabletype/importDbTable.jsp"
        });
    }
};
//覆盖导入存储模型xml
DbTable.prototype.reImportDbXml = function (data) {
    uploadDialog = layer.open({
        type: 2,
        title: '覆盖导入存储模型xml',
        skin: 'bs-modal',
        area: ['50%', '50%'],
        maxmin: false,
        content: "avicit/platform6/db/dbtabletype/reImportDbTable.jsp?dbId=" + data.id
    });
};
//导出存储模型xml
DbTable.prototype.exportDbXml = function (data) {
    var downloadUrl = "platform/eform/bpmsManageController/exportDbXml/" + data.id;
    new DownLoad4URL('downloadIFrame', 'downloadForm', null, downloadUrl).downLoad();
};
//切换存储模型目录
DbTable.prototype.changeDirectory = function (data) {
    var _this = this;
    changeDirectoryDialog  = layer.open({
        type: 2,
        title: '切换目录',
        skin: 'bs-modal',
        area: ['30%', '60%'],
        maxmin: false,
        content: "avicit/platform6/db/dbtabletype/changeDBTableDirectory.jsp?dbId=" + data.id + "&pId=" + data.tableType
    });
};
//表单验证
DbTable.prototype.formValidate = function (form) {
    var _this = this;

    form.validate({
        rules: {
        	tableName:{
        		english : true,
        		required: true
        	},
        	tableComments:{
        		required: true,
                maxlength: 50
        	},
            componentName: {
                required: true,
                maxlength: 100
            },
            componentDesc: {
                required: true,
                maxlength: 200
            },
            orderBy: {
                required: true,
                maxlength: 50,
                digits: true
            }
        }
    });
};
//提交添加
DbTable.prototype.subAdd = function (form) {
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
        url: "platform/db/dbTableManageController/addDbTable",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                _this.setComponent(backData.data);
                if (eformComponentModel !=null && eformComponentModel!="undefined")
                	eformComponentModel.reLoad(dbTableTypeTree.selectedNodeId);
                layer.msg('操作成功');

                _this.closeDialog("add");
            }
            else {
                layer.alert(backData.error, {icon: 7});
            }
        }
    });
};
//提交编辑
DbTable.prototype.subEdit = function (form) {
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
        url: "platform/db/dbTableManageController/subEditDbTable",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                var dbtable = $('#' + _this.componentDiv).find("#" + backData.data.id);
                dbtable.find(".eform-item-bottom-name").attr("title", backData.data.tableComments);
                if(backData.data.tableComments.length > 7) {
                    dbtable.find(".eform-item-bottom-name").text(backData.data.tableComments.substring(0, 7)+"...");
                }
                else {
                    dbtable.find(".eform-item-bottom-name").text(backData.data.tableComments);
                }
                dbtable.find(".eform-item-bottom-tablename").attr("title", backData.data.tableName);
                if(backData.data.tableName.length > 10) {
                    dbtable.find(".eform-item-bottom-tablename").text(backData.data.tableName.substring(0, 10)+"...");
                }
                else {
                    dbtable.find(".eform-item-bottom-tablename").text(backData.data.tableName);
                }
                var _dataContent = '';
                var tableNameShow="";
                var tableCommentsShow="";
                if(backData.data.tableName.length>17)
                {
                	tableNameShow=backData.data.tableName.substring(0,17)+'\n'+backData.data.tableName.substring(17);
                }else
                {
                	tableNameShow=backData.data.tableName;
                }
                
                var dataSourceNameShow="";
                if(backData.data.dataSourceId != null && backData.data.dataSourceId.length==32){
                	dataSourceNameShow = "CC("+backData.data.connectType+"-"+backData.data.dataSourceName+")";
                }else{
                	dataSourceNameShow = "local";
                }

                var dbtype = '';
                if (backData.data.dbType == "1"){
                    dbtype = "数据表";
                }else if (backData.data.dbType == "2"){
                    dbtype = "视图";
                }else if (backData.data.dbType == "3"){
                    dbtype = "系统表";
                }
                
                _dataContent = '<table width="180px" border="0" style="font-size:12px;"  align="center">'
            		+'<tr><td width="40%" height="25"><lable>表英文名:</lable></td><td>'+tableNameShow+'</td></tr>'
            		+'<tr><td width="40%" height="25"><lable>表中文名:</lable></td><td>'+backData.data.tableComments+'</td></tr>'
            		+'<tr><td width="40%" height="25">数&nbsp;&nbsp;据&nbsp;&nbsp;源:</td><td>'+dataSourceNameShow+'</td></tr>'
                    +'<tr><td width="40%" height="25">类&nbsp;&nbsp;&nbsp;&nbsp;型:</td><td>'+dbtype+'</td></tr>'
            		+'<tr><td width="40%" height="25">是否创建:</td><td>'+backData.data.tableIsCreated+'</td></tr>'
            		+'</table>';
                dbtable.find(".eform-item-title").attr("data-content",_dataContent);
                dbtable.find("[data-toggle='popover']").popover({html:true,trigger:'hover'});
                if (eformComponentModel !=null && eformComponentModel!="undefined")
                	eformComponentModel.reLoad(dbTableTypeTree.selectedNodeId);
                layer.msg('操作成功');

                _this.closeDialog("edit");
            }
            else {
                layer.msg('操作失败');
            }
        }
    });
};
//关闭弹出框
DbTable.prototype.closeDialog = function (type) {
    if (type == "add") {
        layer.close(addDialog);
    }
    if (type == "edit") {
        layer.close(editDialog);
    }
    if (type == "upload") {
        layer.close(uploadDialog);
    }
    if (type == "changeDirectory") {
        layer.close(changeDirectoryDialog);
    }
};
//获取表模型列表
DbTable.prototype.getComponentList = function (selectedNodeId) {
    var _this = this;
    if(showType=="2"){		
		if(eformComponentModel==null || eformComponentModel==undefined){
			var searchSubNames = [];
			searchSubNames.push("tableName");
			searchSubNames.push("tableComments");
			var componentModelGridColModel = [
				{
					label : 'id',
					name : 'id',
					key : true,
					hidden : true
				}			
				, {
					label : '表英文名称',
					name : 'tableName',
					width : 40,
					align : 'left',
					sortable : true,
					formatter:getEdit
				}
				,{
					label : '表中文名称',
					name : 'tableComments',
					width : 40,
					align : 'left',
					sortable : true
				},
                {
                    label : '存储模型类型',
                    name : 'dbType',
                    width : 40,
                    formatter: getDbtype,
                    align : 'left',
                    sortable : true
                },
				{
					label : '是否创建',
					name : 'tableIsCreated',
					width : 30,
					formatter: getIsCreated,
					align : 'left',
					sortable : true
				}
				
				,  {
					label : '操作',
					name : 'opt',
					width : 35,
					align : 'left',
					sortable : false,
					formatter:getOptButtons
				}
			];

			var url = "platform/db/dbTableManageController/getDbTableByPage";
			eformComponentModel = new DbTableModel('componentModel', url, "formSub", componentModelGridColModel, 'searchDialogSub', selectedNodeId, 
					"", searchSubNames, "componentModel_keyWord");
		}else{
			eformComponentModel.reLoad(selectedNodeId);
		}
	}else{
	    $('#' + _this.componentDiv).empty();
	    $.ajax({
	        url: "platform/db/dbTableManageController/getDbTableList",
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

function getEdit(cellvalue, options, rowObject){
	return '<a href="javascript:void(0)" '
	+'  title="'+rowObject.tableName+'" onClick="dbTable.clickTitle(\''+rowObject.id+'\',\''+rowObject.tableName+'\',\''+rowObject.dataSourceId+'\',\''+rowObject.dbType+'\')">'+rowObject.tableName+'</a>';
}

function getOptButtons(cellvalue, options, rowObject) {
	if (rowObject.tableIsCreated == "Y"){
		return '<a href="javascript:void(0)" class="glyphicon glyphicon-pencil"'
			+'  title="编辑表" onClick="dbTable.edit(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
			+'   title="删除表" onClick="dbTable.deleteTable(\''+rowObject.id+'\',\''+rowObject.tableIsCreated+'\')"></a>&nbsp;&nbsp;'
            +'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-save"'
            +'   title="覆盖导入" onClick="dbTable.reImportDbXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>&nbsp;&nbsp;'
            +'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-open"'
            +'   title="导出" onClick="dbTable.exportDbXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>&nbsp;&nbsp;'
            +'  <a href="javascript:void(0)" class="glyphicon glyphicon-transfer"'
            +'   title="切换目录" onClick="dbTable.changeDirectory('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>';
	}else{
		return '<a href="javascript:void(0)" class="glyphicon glyphicon-pencil"'
		+'  title="编辑表" onClick="dbTable.edit(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
		+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
		+'   title="删除表" onClick="dbTable.deleteTable(\''+rowObject.id+'\',\''+rowObject.tableIsCreated+'\')"></a>&nbsp;&nbsp;'
		+'  <a href="javascript:void(0)" class="glyphicon glyphicon-file"'
		+'   title="创建表" onClick="dbTable.create(\''+rowObject.id+'\')"></a>';

	}
}

function getIsCreated(cellvalue, options, rowObject){
	if (cellvalue == "Y"){
		return "<font color='green'>已创建</font>";
	}else{
		return "<font color='red'>未创建</font>";
	}
}

function getDbtype(cellvalue, options, rowObject){
    if (cellvalue == "1"){
        return "<font color='green'>数据表</font>";
    }else if (cellvalue == "2"){
        return "<font color='red'>视图</font>";
    }else if (cellvalue == "3"){
        return "<font color='#a52a2a'>系统表</font>";
    }
}