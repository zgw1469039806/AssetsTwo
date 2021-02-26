/**
 * Created by xb on 2017/5/17.
 */
function EformFormViewDetail() {
    this.newRowIndex = 0;
    this.newRowStart = "new_row";
    this.tableColumnInfo = [];
    this.customButtonRequireField = ["buttonCode","buttonName","buttonIcon","isDefaultName"];
	this.customButtonRequrieFieldName = ["按钮ID","名称","按钮图标","类型"];
	this.basicSearchRequireField = ["columnName","colTitle","display"];
	this.basicSearchRequrieFieldName = ["列名称","标题","显示"];
	this.advenceSearchRequireField = ["columnName","colTitle","comparativeMode","elementType","defaultValue"];
	this.advenceSearchRequrieFieldName = ["列名称","显示名称","比较方式","UI组件","默认值"];
};

//判断字符串是否是uundefined null ""
function isNotEmpty(checkObject){
    if(!checkObject){
        return false;
    }
    if(checkObject ==  "undefined" || checkObject == null || checkObject == "" 
        || typeof(checkObject) == "undefined" || checkObject == "null"){
        return false;
    }
    return true;
}

//取得列名
function getAdvenceColumnSelectList(data){
    var dataTarget = "";
    $.each(data, function (index, value) {
        if(value.colType !== "CLOB" && value.colType !== "BLOB"){
            dataTarget = dataTarget + value.columnName + ":" +  value.columnName + ";";
        }
    });
    return dataTarget.substring(0,dataTarget.length-1);
}

//格式化提交数据
function formatData(data, checkField){
    var result= [];
    var i = 0;
    //数据上是编辑状态及没有填入必须字段的行设置为空
    $.each(data, function (index, value) { 
        $.each(value, function (key, obj) { 
            if(obj.indexOf('<a href=') > -1 || obj.indexOf('id="new_row') > -1){
                data[index][key] = '';
            }
        });
    });
    //删除为空的数据
    $.each(data, function (index, value) {
        var flag = true;
        $.each(checkField, function (key, field) { 
            if(value[field] == ""){
                flag = false;
            }
        });
        if(flag){
            result[i] = value;
            i++;
        }
    });
    return result;
}

//得到表格数据
function getDataGridData(jqGrid, field, selarrrow){
    //jqGridColumnInfo.jqGrid("endEditCell");
    //var columnInfoData = jqGridColumnInfo.jqGrid("getChangedCells");
    var selrow = jqGrid.jqGrid('getGridParam', selarrrow);
    if(selarrrow == "selarrrow"){
        $.each(selrow, function (index, value) { 
              jqGrid.jqGrid("saveRow", value);
        });
    }else{
         jqGrid.jqGrid("saveRow", selrow);
    }
    if(field){
        return formatData(jqGrid.jqGrid("getRowData"),field)
    }
    return jqGrid.jqGrid("getRowData");
}

//得到基础查询表格数据
function getBasicGridData(jqGrid){


}

//表单验证
EformFormViewDetail.prototype.formValidate = function (form) {
    var _this = this;
    form.validate({
        rules: {
            viewName: {
                required: true,
                maxlength: 200
            },
            viewDesc: {
                required: false,
                maxlength: 1000
            },
            viewStyle: {
                required: true
            },
            tableId: {
                required: true,
                maxlength: 50
            },
            viewWhere: {
                required: false,
                maxlength: 2000
            },
            orderBy:{
                digits:true,
                required: true,
                maxlength: 10
            }
        }
    });
};
//提交添加
EformFormViewDetail.prototype.subAdd = function (form, jqGridColumnInfo, jqGridCsutomButton, jqGridBasicSearch, jqGirdAdvenceSearch) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    //试图基本信息数据
    var formSerializeValue = form.serialize();
    var formDataJson = decodeURI(convertFormSerializeValueToJson(formSerializeValue));
    //列属性数据
    var columnInfoData = getDataGridData(jqGridColumnInfo, null, "selrow");
    //按钮信息数据
    var customButtonData = getDataGridData(jqGridCsutomButton, _this.customButtonRequireField, "selarrrow");
    //基本查询信息数据
    var basicSearchData = getDataGridData(jqGridBasicSearch, _this.basicSearchRequireField, "selarrrow");
    //高级查询信息数据
    var advenceSearchData = getDataGridData(jqGirdAdvenceSearch ,_this.advenceSearchRequireField, "selarrrow");

    //初始化参数
    var parm = {"formDataJson": formDataJson,
                "columnInfoData": JSON.stringify(columnInfoData),
                "customButtonData": JSON.stringify(customButtonData),
                "basicSearchData": JSON.stringify(basicSearchData),
                "advenceSearchData": JSON.stringify(advenceSearchData)};

    $.ajax({
        url: "platform/eform/eformViewInfoController/addEformFormView",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result > 0) {
                parent.eformFormView.setViewInfo(backData.data);
                layer.msg('操作成功');
                _this.closeDialog();
            }else {
                layer.msg('操作失败');
            }
        }
    });
};
//提交编辑
EformFormViewDetail.prototype.subEdit = function (form,  jqGridColumnInfo, jqGridCsutomButton, jqGridBasicSearch, jqGirdAdvenceSearch) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    //JSON化表单数据
    var formSerializeValue = form.serialize();
    var formDataJson = decodeURI(convertFormSerializeValueToJson(formSerializeValue));
    //取得列属性数据
    var columnInfoData = getDataGridData(jqGridColumnInfo, null, "selrow");
    //按钮信息数据
	var customButtonData = getDataGridData(jqGridCsutomButton, _this.customButtonRequireField,"selarrrow");
    //基本查询信息数据
	var basicSearchData = getDataGridData(jqGridBasicSearch, _this.basicSearchRequireField,"selarrrow");
    //高级查询信息数据
	var advenceSearchData = getDataGridData(jqGirdAdvenceSearch ,_this.advenceSearchRequireField,"selarrrow");

    //初始化参数
    var parm = {"formDataJson": formDataJson,
                "columnInfoData": JSON.stringify(columnInfoData),
                "customButtonData": JSON.stringify(customButtonData),
                "basicSearchData": JSON.stringify(basicSearchData),
                "advenceSearchData": JSON.stringify(advenceSearchData)};

    $.ajax({
        url: "platform/eform/eformViewInfoController/subEditEformFormView",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result > 0) {
                var viewInfo = $('#' + _this.formViewDiv).find("#" + backData.data.id);
                viewInfo.find(".eform-item-bottom-name").attr("title", backData.data.viewName);
                viewInfo.find(".eform-item-bottom-name").text(backData.data.viewName);
                layer.msg('操作成功');
                _this.closeDialog();
            }else {
                layer.msg('操作失败');
            }
        }
    });
};

//关闭弹出框
EformFormViewDetail.prototype.closeDialog = function () {
    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    parent.layer.close(index);
};

//初始化下拉框
EformFormViewDetail.prototype.initTableColumeSelect = function (tableId, viewInfoId, orderColId, orderColHiddenId, operationType) {
    _this = this;
    var tableIdVal = $("#"+ tableId).val();
    if(tableIdVal !== ""){
        $("#"+orderColId).empty();
        $.ajax({
            type: "GET",
            url: "platform/eform/eformViewInfoController/getViewColumnInfoList",
            data: {"tableId":tableIdVal,"viewInfoId":"null","operationType":"add"},
            dataType: "json",
            sync:false,
            success: function (response) {
                if (isNotEmpty(response.rows)) {
                    _this.tableColumnInfo = response.rows;
                    $.each(response.rows, function (index, object) {
                    var optionHtml = '<option value="'+ object.columnName +'">'+ object.columnName +'</option>';
                        $("#"+orderColId).append($(optionHtml));
                    });
                    //设定选中值
                    if($("#"+orderColHiddenId).length > 0){
                        $("#"+orderColId).val($("#"+orderColHiddenId).val());
                    }else{
                        $("#"+orderColId).find("option:first").prop("selected",true);
                    }

                    //加载列属性数据
                    _this.loadColumnData(tableId,viewInfoId,$("#jqGridColumnInfo"),operationType);

                    //实例基本查询jqgrid
                    _this.instanceJqGridBasicSearch(viewInfoId,$("#jqGridBasicSearch"),operationType);

                    //实例高级查询jqgrid
                    _this.instanceJqGridAdvenceSearch(viewInfoId,$("#jqGridAdvenceSearch"),operationType);
                }
            }
        });
    }

    if(tableIdVal == ""){
        _this.tableColumnInfo = [];
    }

}

//加载数据
EformFormViewDetail.prototype.loadColumnData = function(tableId, viewInfoId, jqGrid, operationType){

	_this = this;
	var tableIdVal = $("#"+ tableId).val();
    var viewInfoIdVal = $("#"+ viewInfoId).val();
    var param, dataType, data, url;
    if(operationType == "add"){
        param = "";
        dataType = "local";
        url = "";
        data = _this.tableColumnInfo;
    }else{
        param = {"tableId":"null","viewInfoId":viewInfoIdVal,"operationType":"edit"};
        dataType = "json";
        url = 'platform/eform/eformViewInfoController/getViewColumnInfoList';
        data = [];
    }
   	if( tableIdVal !== ""){
       	jqGrid.jqGrid("setGridParam",{
       		postData: param,
       		datatype: dataType,
            data: data,
            url: url
       	}).trigger("reloadGrid");

    }else{
        //当存储模型为空时清空数据
       	jqGrid.jqGrid("clearGridData");
    }
}

EformFormViewDetail.prototype.instanceJqGridColumnInfo = function(jqGridColumnInfo){
    var _this = this;

    var lastSelection;
    jqGridColumnInfo.jqGrid({
        url: 'platform/eform/eformViewInfoController/getViewColumnInfoList',
        mtype: 'POST',
        postData:"",
        datatype: "local",
        toolbar: [false,''],
        editurl:"clientArray",
        colModel: [
            { label: 'id', name: 'id', key: true, hidden:true },
            { label: '列名', name: 'columnName', width: 220 , align:"left" },
            { label: '标题', name: 'colTitle', width: 220 , align:"left", editable : true, edittype: "text", editrules:{required:true}, editoptions : {maxlength : "50"} },
           //{ label: '显示', name: 'display', width: 100 , editable : true, edittype: "checkbox", editoptions: {value : "0:NO;1:YES"} },
            { label: '显示', name: 'display', width: 100 , align:"center", formatter:"checkbox",formatoptions:{disabled:false},editoptions: {value : "Y:N"},defaultValue:"Y"},
            { label: '外观', name: 'columnSytle', width: 300 , align:"center", formatter: _this.formatterOpenStyleDialog },
            { label: '背景颜色', name: 'bgColor', hidden:true },
            { label: '字体颜色', name: 'fontColor' , hidden:true },
            { label: '字体大小', name: 'fontSize' , hidden:true },
            { label: '列宽', name: 'colWidth' , hidden:true },
            //{ label: '对齐', name: 'align', width: 100 , align:"center", editable : true, edittype: "select", editoptions: {value : "0:左;1:中;2:右"} },
            //{ label: '对齐', name: 'align', width: 100 , align:"center", editable: true, formatter:"select", editoptions: {value : "0:左;1:中;2:右"} },
            { label: '对齐', name: 'align', width: 130 , align:"center", formatter:_this.formatterAlignSelect, unformat:_this.unFormatterAlignSelect },  
            //{ label: '排序', name: 'colSotr', width: 100 , align:"center", editable : true, edittype: "select", editoptions: {value : "0:升序;1:降序"} },
            //{ label: '排序', name: 'colSotr', width: 100 , align:"center", editable: true, formatter:"select", editoptions: {value : "0:升序;1:降序"} },
            //{ label: '排序', name: 'colSotr', width: 110 , align:"center", formatter: _this.formatterColSotrSelect, unformat:_this.unFormatterColSotrSelect },
            { label: '显示规则', name: 'displayConfig', width: 150 , align:"center", formatter: _this.formatterOpenDisplayDialog },
            { label: '显示规则类型', name: 'displayRule', hidden:true }, 
            { label: '显示规则内容', name: 'displayRuleContent', hidden:true },
            { label: '行为', name: 'action', width: 150 , align:"center", formatter: _this.formatterOpenActionDialog },
            { label: '关联表单', name: 'formId' , hidden:true },
            { label: '关联表单名称', name: 'formName' , hidden:true },
            { label: '打开方式', name: 'formOpen', hidden:true }
        ],
        scrollOffset: 20, //设置垂直滚动条宽度
        styleUI : 'Bootstrap', 
        viewrecords: true, //
        multiselect: false, //
        autowidth: true,
        responsive:true,//开启自适应
        caption:"列属性",
        jsonReader: {  
            root:"rows",   
            total: "total",
            repeatitems: false
        },
        onSelectRow:function(id) {
                if (id && id !== lastSelection) {
                    jqGridColumnInfo.jqGrid('saveRow',lastSelection);
                    jqGridColumnInfo.jqGrid('editRow',id, {keys: true} );
                    lastSelection = id;
                }
        }                       
    })
};


//修改外观列的显示式样
EformFormViewDetail.prototype.formatterOpenStyleDialog =  function(cellvalue, options, rowObject) {
    var columnSytle = "";
    if(isNotEmpty(rowObject.bgColor)){
        columnSytle = columnSytle + " 背景颜色:" + rowObject.bgColor; 
    }
    if(isNotEmpty(rowObject.fontColor)){
        columnSytle = columnSytle + " 字体颜色:" + rowObject.fontColor; 
    }
    if(isNotEmpty(rowObject.fontSize)){
        columnSytle = columnSytle + " 字体大小:" + rowObject.fontSize; 
    }
    if(isNotEmpty(rowObject.colWidth)){
        columnSytle = columnSytle + " 列宽:" + rowObject.colWidth; 
    }

    if(columnSytle.length > 0){
            return '<a href="javascript:void(0);" onclick="eformFormViewDetail.openStyleDialog(\''+ options.rowId + '\',\''+ rowObject.bgColor + '\',\''+ rowObject.fontColor + '\',\''+ rowObject.fontSize + '\',\'' + rowObject.colWidth + '\',\'' + "jqGridColumnInfo" +'\');">' + columnSytle + '</a>';
        }else{
            return '<a href="javascript:void(0);" class="btn btn-info form-tool-btn btn-sm" role="button" onclick="eformFormViewDetail.openStyleDialog(\''+ options.rowId + '\',\''+ rowObject.bgColor + '\',\''+ rowObject.fontColor + '\',\''+ rowObject.fontSize + '\',\''+ rowObject.colWidth + '\',\'' + "jqGridColumnInfo" +'\');">配置</a>';
    }
};

//修改显示规则列的显示式样    
EformFormViewDetail.prototype.formatterOpenDisplayDialog = function(cellvalue, options, rowObject) {
    return '<a href="javascript:void(0);" class="btn btn-info form-tool-btn btn-sm" role="button"  onclick="eformFormViewDetail.openDisplayDialog(\''+ options.rowId + '\',\'' + rowObject.displayRule + '\',\'' + rowObject.displayRuleContent + '\',\'' + "jqGridColumnInfo" +'\');">配置</a>';
};

//修改行为列的显示式样        
EformFormViewDetail.prototype.formatterOpenActionDialog = function(cellvalue, options, rowObject) {
    return '<a href="javascript:void(0);" class="btn btn-info form-tool-btn btn-sm" role="button" onclick="eformFormViewDetail.openActionDialog(\''+ options.rowId + '\',\'' + rowObject.formId + '\',\'' +  rowObject.formName + '\',\'' + rowObject.formOpen + '\',\'' + "jqGridColumnInfo" +'\');">配置</a>';
};

//修改隐藏列的显示式样 
EformFormViewDetail.prototype.formatterDisplayCheckbox = function(cellvalue, options, rowObject) {
    return '<input type="checkbox" name="" id="" value="1"/>';
};

//修改对齐列的显示式样 
EformFormViewDetail.prototype.formatterAlignSelect = function(cellvalue, options, rowObject) {
    var alignSlectId = "alignSlect" + options.rowId;
    var selectInput = '<select  class="form-control input-sm" name="" id="'+ alignSlectId +'" > ';
    if(rowObject.align == 1){
        selectInput = selectInput + ' <option value="1" selected>左</option> ' +
                                    ' <option value="2">中</option> ' +
                                    ' <option value="3">右</option> ';
    }else if(rowObject.align == 2){
        selectInput = selectInput + ' <option value="1">左</option> ' +
                                    ' <option value="2" selected>中</option> ' +
                                    ' <option value="3">右</option> ';
    }else{
        selectInput = selectInput + ' <option value="1">左</option> ' +
                                    ' <option value="2">中</option> ' +
                                    ' <option value="3" selected>右</option> ';
    }
    selectInput = selectInput + ' </select>';
    return selectInput;
}; 

//返回对齐列的值
EformFormViewDetail.prototype.unFormatterAlignSelect = function(cellvalue, options, cellObject) {
    return $(cellObject).find("option:selected").val();;
};

//修改排序的显示式样 
EformFormViewDetail.prototype.formatterColSotrSelect = function(cellvalue, options, rowObject) {
    var colSotrSelectId = "colSotrSelect" + options.rowId;
    var selectInput = '<select  class="form-control input-sm" name="" id="'+ colSotrSelectId +'">' ;
    if(rowObject.colSotr == 1){
        selectInput = selectInput + ' <option value="1" selected>升序</option> ' +
                                    ' <option value="2">降序</option> ' ;
    }else{
        selectInput = selectInput + ' <option value="1">升序</option> ' +
                                    ' <option value="2" selected>降序</option> ' ;
    }
    selectInput = selectInput + ' </select>';
    return selectInput;
}; 

//返回排序列的值
EformFormViewDetail.prototype.unFormatterColSotrSelect = function(cellvalue, options, cellobject) {
    return $(cellobject).find("option:selected").val();;
};     


//打开外观dialog
EformFormViewDetail.prototype.openStyleDialog = function(rowId, bgColor, fontColor, fontSize, colWidth, jqGridId) {

   this.styleDialogIndex = layer.open({
        type: 2,
        title: '外观设置',
        skin: 'bs-modal',
        area: ['50%', '70%'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsformmanage/eformFormView/eformFormViewStyle.jsp",
        success: function(layero, index){
            var childrenBody = layer.getChildFrame('body',index);//建立父子联系
            if(isNotEmpty(bgColor)){
                childrenBody.find('#bgColor').val(bgColor);
            }
            if(isNotEmpty(fontColor)){
                childrenBody.find('#fontColor').val(fontColor);
            }
            if(isNotEmpty(colWidth)){
                childrenBody.find('#colWidth').val(colWidth);
            }
            if(isNotEmpty(fontSize)){
                childrenBody.find('#fontSize').val(fontSize);
            }
            
        },
        btn:['确认','取消'],
        yes:function(index, layero){
            var childrenBody = layer.getChildFrame('body',index);//建立父子联系
            $("#"+jqGridId).jqGrid("saveRow",rowId);
            var rowObject = $("#"+jqGridId).jqGrid("getRowData", rowId);
            rowObject.fontColor = childrenBody.find('#fontColor').val();
            rowObject.bgColor = childrenBody.find('#bgColor').val();
            rowObject.fontSize = childrenBody.find('#fontSize').val();
            rowObject.colWidth = childrenBody.find('#colWidth').val();
            $("#"+jqGridId).jqGrid('setRowData', rowId, rowObject);
            layer.close(index);
        },
        btn2:function(index, layero){
            layer.close(index);
        }
    });
};

//打开显示dialog
EformFormViewDetail.prototype.openDisplayDialog = function (rowId, displayRule, displayRuleContent, jqGridId) {

    this.styleDialogIndex = layer.open({
        type: 2,
        title: '显示规则',
        skin: 'bs-modal',
        area: ['50%', '60%'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsformmanage/eformFormView/eformFormViewDisplay.jsp",
        success: function(layero, index){
            var childrenBody = layer.getChildFrame('body',index);//建立父子联系
            if(displayRule == 1){
                childrenBody.find("#lookup").show();
                childrenBody.find("#format").hide();
                childrenBody.find('#displayRuleLookup').prop("checked", true);
                childrenBody.find('#displayRuleFormat').prop("checked", false);
                childrenBody.find('[name="displayRuleContent"]:visible').val(displayRuleContent);
                childrenBody.find('[name="displayRuleContent"]:hidden').val();
            }else if(displayRule == 2){
                childrenBody.find("#lookup").hide();
                childrenBody.find("#format").show();
                childrenBody.find('#displayRuleLookup').prop("checked", false);
                childrenBody.find('#displayRuleFormat').prop("checked", true);
                childrenBody.find('[name="displayRuleContent"]:visible').val(displayRuleContent);
                childrenBody.find('[name="displayRuleContent"]:hidden').val();
            }else{
                childrenBody.find('#displayRuleLookup').prop("checked", true);
                childrenBody.find('#displayRuleFormat').prop("checked", false);
                childrenBody.find("#lookup").css({"display":""});
                childrenBody.find("#format").hide();
            }
        },
        btn:['保存','返回'],
        yes:function(index, layero){
            var childrenBody = layer.getChildFrame('body',index);//建立父子联系
            $("#"+jqGridId).jqGrid("saveRow",rowId);
            var rowObject = $("#"+jqGridId).jqGrid("getRowData", rowId);
            rowObject.displayRule = childrenBody.find('input[name="displayRule"]:checked').val();
            rowObject.displayRuleContent = childrenBody.find('[name="displayRuleContent"]:visible').val().replace(/\'/g,"\\'").replace(/\"/g,"\\'");
            $("#"+jqGridId).jqGrid('setRowData', rowId, rowObject);
            layer.close(index);
        },
        btn2:function(index, layero){
            layer.close(index);
        }
    });
};

//打开行为dialog
EformFormViewDetail.prototype.openActionDialog = function (rowId, formId, formName, formOpen, jqGridId) {
    this.styleDialogIndex = layer.open({
        type: 2,
        title: '行为规则',
        skin: 'bs-modal',
        area: ['50%', '60%'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsformmanage/eformFormView/eformFormViewAction.jsp",
        success: function(layero, index){
            var childrenBody = layer.getChildFrame('body',index);//建立父子联系
            if(isNotEmpty(formId)){
                childrenBody.find('#formId').val(formId);
            }
            if(isNotEmpty(formName)){
               childrenBody.find('#formName').val(formName);
            }
            if(isNotEmpty(formOpen)){
               childrenBody.find('#formOpen').val(formOpen);
            }
        },
        btn:['保存','返回'],
        yes:function(index, layero){
            var childrenBody = layer.getChildFrame('body',index);//建立父子联系
            $("#"+jqGridId).jqGrid("saveRow",rowId);
            var rowObject = $("#"+jqGridId).jqGrid("getRowData", rowId);
            rowObject.formId = childrenBody.find('#formId').val();
            rowObject.formOpen = childrenBody.find('#formOpen').val();
            rowObject.formName = childrenBody.find('#formName').val();
            $("#"+jqGridId).jqGrid('setRowData', rowId, rowObject);
            layer.close(index);
        },
        btn2:function(index, layero){
            layer.close(index);
        }
    });
}


//按钮
EformFormViewDetail.prototype.instanceJqGridCustomButton = function(viewInfoId, jqGridCustomButton, operationType, toolbarId){
    var _this = this;
    var lastSelection;

    var viewInfoIdVal = $("#"+ viewInfoId).val();
    var param, datatype, url;
    if(operationType == "add"){
        param = {"viewInfoId":"null"};
        datatype = "local";
        url = "";
    }else{
        param = {"viewInfoId":viewInfoIdVal};
        datatype = "json";
        url = 'platform/eform/eformViewInfoController/getCustomButtonList';
    }

    jqGridCustomButton.jqGrid({
        url: url,
        mtype: 'POST',
       	postData: param,
       	datatype:"json",
        toolbar: [false,''],
        editurl:"clientArray",
        //toolbar: [ true, "top"],
        colModel: [
            { label: 'id', name: 'id', key: true, hidden:true },
            { label: 'tableId', name: 'tableId', hidden:true },
            { label: '按钮ID', name: 'buttonCode', width: 220 , align:"left",editable : true, edittype: "text", editrules:{required:true}, editoptions : {maxlength : "50"} },
            { label: '名称', name: 'buttonName', width: 220 , align:"left", editable : true, edittype: "text", editrules:{required:true}, editoptions : {maxlength : "50"} },
            //{ label: '类型', name: 'isDefault', width: 100 , align:"center", formatter:_this.formatterIsDefaultSelect, unformat:_this.unFormatterIsDefaultSelect },
            { label: '按钮图标', name: 'buttonIcon', width: 150 , align:"left", editable : true, edittype:"text", editrules:{required:true}, editoptions : {maxlength : "50"}},
            { label: '类型ID', name: 'isDefault', hidden:true},
            { label: '类型', name: 'isDefaultName', width: 150 , align:"center", editable : true, edittype:"custom", editrules:{required:true},
                formatter:_this.formatIsDefaultName, editoptions: {custom_element:selectElem, custom_value:selectValue, forId:'isDefault', value: {"0":"默认","1":"自定义"}, defaultValue:"1"}},
            { label: '显示', name: 'isDisplay', width: 150 , align:"center", formatter:"checkbox",formatoptions:{disabled:false},editoptions: {value : "Y:N"},defaultValue:"Y"},
            { label: '行为设置', name: 'actionSetting' , width: 150 ,align:"center", formatter: _this.formatterOpenActionSettingDialog },
            { label: '关联表单', name: 'formId' , hidden:true },
            { label: '关联表单名称', name: 'formName' , hidden:true },
            { label: '行为目标', name: 'actionTarget' , hidden:true },
            { label: 'JAVA增强', name: 'eventClass' , hidden:true }
        ],
        scrollOffset: 20, //设置垂直滚动条宽度
        styleUI : 'Bootstrap', 
        viewrecords: true, //
        multiselect: true, //
        autowidth: true,
        responsive:true,//开启自适应
        jsonReader: {  
            root:"rows",    
            total: "total",
            repeatitems: false
        },
        onSelectRow:function(id) {
            var rowObject = jqGridCustomButton.jqGrid("getRowData", id);
            if(rowObject && !(rowObject.isDefault == "0" && 
                (rowObject.buttonCode == "new" || rowObject.buttonCode == "edit" || rowObject.buttonCode == "delete" ))){
                if (id && id !== lastSelection) {
                    jqGridCustomButton.jqGrid('saveRow',lastSelection);
                    jqGridCustomButton.jqGrid('editRow',id, {keys: true} );
                    lastSelection = id;
                }
            }   
        }                       
    });
    //添加toolbar
    //jqGridCustomButton.append($("#custumButtonToolbar"));
    if(operationType == "add"){
        var initData = 
            [
                {"id":"1","buttonCode":"new","buttonName":"添加","buttonIcon":"icon-add","isDefault":"0","isDisplay":"Y","actionSetting":"","tableId":"","actionTarget":"","eventClass":""},
                {"id":"2","buttonCode":"edit","buttonName":"编辑","buttonIcon":"icon-edit","isDefault":"0","isDisplay":"Y","actionSetting":"","tableId":"","actionTarget":"","eventClass":""},
                {"id":"3","buttonCode":"delete","buttonName":"删除","buttonIcon":"icon-remove","isDefault":"0","isDisplay":"Y","actionSetting":"","tableId":"","actionTarget":"","eventClass":""}
            ];
        //初始化数据
        jqGridCustomButton.jqGrid("addRowData", "id", initData);
    }
};

//修改排序的显示式样 
EformFormViewDetail.prototype.formatIsDefaultName = function(cellvalue, options, rowObject) {
    if(cellvalue && cellvalue != ''){
		return cellvalue;
	}else{
		var rowId = options.rowId;
		var datas = options.colModel.editoptions.value;
		var forId = options.colModel.editoptions.forId;
		var code = rowObject[forId];
		return datas[code] ? datas[code] : '';
	}
}; 

//修改显示规则列的显示式样    
EformFormViewDetail.prototype.formatterOpenActionSettingDialog = function(cellvalue, options, rowObject) {
    return '<a href="javascript:void(0);" class="btn btn-info form-tool-btn btn-sm" role="button"  onclick="eformFormViewDetail.openActionSettingDialog(\''+ options.rowId + '\',\'' + rowObject.formId + '\',\'' + rowObject.formName + '\',\'' + rowObject.actionTarget + '\',\''+ rowObject.eventClass + '\',\'' + "jqGridCustomButton" +'\');">配置</a>';
};

//打开行为设置dialog
EformFormViewDetail.prototype.openActionSettingDialog = function (rowId, formId, formName, actionTarget, eventClass, jqGridId) {

    this.styleDialogIndex = layer.open({
        type: 2,
        title: '行为规则',
        skin: 'bs-modal',
        area: ['50%', '60%'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsformmanage/eformFormView/eformFormViewActionSetting.jsp",
        success: function(layero, index){
            var childrenBody = layer.getChildFrame('body',index);//建立父子联系
            if(isNotEmpty(tableId)){
               childrenBody.find('#formId').val(formId);
            }
            if(isNotEmpty(formName)){
               childrenBody.find('#formName').val(formName);
            }
            if(isNotEmpty(actionTarget)){
               childrenBody.find('#actionTarget').val(actionTarget);
            }
            if(isNotEmpty(eventClass)){
               childrenBody.find('#eventClass').val(eventClass);
            }

        },
        btn:['保存','返回'],
        yes:function(index, layero){
            var childrenBody = layer.getChildFrame('body',index);//建立父子联系
            $("#"+jqGridId).jqGrid("saveRow",rowId);
            var rowObject = $("#"+jqGridId).jqGrid("getRowData", rowId);
            rowObject.formId = childrenBody.find('#formId').val();
            rowObject.formName = childrenBody.find('#formName').val();
            rowObject.actionTarget = childrenBody.find('#actionTarget').val();
            rowObject.eventClass = childrenBody.find('#eventClass').val();
            $("#"+jqGridId).jqGrid('setRowData', rowId, rowObject);
            layer.close(index);
        },
        btn2:function(index, layero){
            layer.close(index);
        }
    });
}

//添加按钮
EformFormViewDetail.prototype.addOperation = function(jqGrid,fields){
    //jqGrid.jqGrid('endEditCell');
    //先保存数据
    var selrow = jqGrid.jqGrid('getGridParam','selarrrow');
    $.each(selrow, function (idx, val) { 
             jqGrid.jqGrid("saveRow", val);
    });

    //检查
    var allData =  jqGrid.jqGrid('getRowData');
    var validFlag = true;
    $.each(allData, function (idx, val) {

        $.each(this, function (key,value) { 
             if(value.indexOf('<') > -1 && value.indexOf('rowid="new_row') > -1){
                val[key] = '';
             }
        }); 
        $.each(fields, function (key,value) { 
             if(!isNotEmpty(val[value])){
                validFlag = false;
                return false;
             }
        }); 
        if(!validFlag){
            if(selrow == 0){
                layer.alert("请在编辑行输入信息！");
            }
            return false;
        }
    });

    if(validFlag){
        //添加数据
        var newRowId = this.newRowStart + this.newRowIndex;
        var parameters = {
                rowID : newRowId,
                initdata : {},
                position :"first",
                useDefValues : true,
                useFormatter : true,
                addRowParams : {extraparam:{}}
        }
        jqGrid.jqGrid('addRow', parameters);
        jqGrid.jqGrid('setSelection', newRowId);
        this.newRowIndex++;  
    }
	
}

//判断是否是默认按钮
function checkDeleteDefaultButton(jqGrid, len, rows){
    for(var i=0;i < len;i++){
        var rowObject = jqGrid.jqGrid("getRowData", rows[i]);
        if(rowObject && rowObject.isDefault == "0" && 
                (rowObject.buttonCode == "new" || rowObject.buttonCode == "edit" || rowObject.buttonCode == "delete" )){            
                return false;
        }
    }
    return true;
}

//删除按钮
EformFormViewDetail.prototype.deleteOperation = function(jqGrid, deleteUrl, operationType, deleteObject){
    var rows = jqGrid.jqGrid('getGridParam','selarrrow');
	var ids = [];
	var len = rows.length;
    var deleteFlag = true;

    if(deleteObject == "customButton"){
        deleteFlag = checkDeleteDefaultButton(jqGrid, len, rows);
    }
    if(!deleteFlag){
        layer.alert('不能删除默认按钮！');
    }else{
        //添加页面的场合
        if(operationType == "add"){
            if(rows.length == 0){
                layer.alert('请选择要删除的记录！');
            }else{
                for(var i = rows.length -1 ; i > -1 ;i--){
                    jqGrid.jqGrid('delRowData', rows[i]);
                }
            }
        }else{
        //编辑页面的场合
            if(len > 0){
                layer.confirm('确定要删除该数据吗?', {icon: 2, title:"请确认：", area: ['400px', '']}, function(index){
                        for(;len--;){
                            ids.push(rows[len]);
                        }
                        $.ajax({
                            url:deleteUrl,
                            data:	{"ids":JSON.stringify(ids)},
                            //contentType : 'application/json',
                            type : 'post',
                            dataType : 'json',
                            success : function(r){
                                if (r.result > 0) {
                                    for(var i = rows.length -1 ; i > -1 ;i--){
                                        jqGrid.jqGrid('delRowData', rows[i]);
                                    }
                                    layer.msg("删除成功。");
                                }else{
                                    layer.msg('删除失败！');
                                }
                            }
                        });
                        layer.close(index);
                    });   
            }else{
                layer.alert('请选择要删除的记录！');
            }
        }
    }
}

//重载数据
EformFormViewDetail.prototype.reLoadDatagrid = function(jqGrid, url, param){
	jqGrid.jqGrid('setGridParam',{
        param :param,
        datatype : "json",
        url : url
    }).trigger("reloadGrid");
}

//基本查询
EformFormViewDetail.prototype.instanceJqGridBasicSearch = function(viewInfoId, jqGridBasicSearch, operationType){
    var _this = this;
    var lastSelection;

    var viewInfoIdVal = $("#"+ viewInfoId).val();
    var param, datatype, url, data;
    if(operationType == "add"){
        param = {"viewInfoId":"null"};
        datatype = "local";
        url = "";
        data = _this.tableColumnInfo;
    }else{
        param = {"viewInfoId":viewInfoIdVal,"searchType":"1"};
        datatype = "json";
        url = 'platform/eform/eformViewInfoController/getViewSearchList';
        data = [];
    }

    jqGridBasicSearch.jqGrid({
        url: url,
        data:data,
        mtype: 'POST',
        postData: param,
        datatype: datatype,
        editurl:"clientArray",
        toolbar: [false, "top"],
        colModel: [
            { label: 'id', name: 'id', key: true, hidden:true },
            { label: '列名称', name: 'columnName', width: 250 , align:"left"},
            { label: '标题', name: 'colTitle', width: 250 , align:"left"},
            { label: '显示', name: 'display', width: 250 , align:"center",formatter:"checkbox",formatoptions:{disabled:false},editoptions: {value : "Y:N"},defaultValue:"Y"}
            
        ],
        //height:$(window).height()-250,
        scrollOffset: 20, //设置垂直滚动条宽度
        styleUI : 'Bootstrap', 
        viewrecords: true, //
        multiselect: true, //
        autowidth: true,
        responsive:true,//开启自适应
        jsonReader: {  
            root:"rows", 
            total: "total",
            repeatitems: false
        }                      
    });

}


//高级查询
EformFormViewDetail.prototype.instanceJqGridAdvenceSearch = function(viewInfoId, jqGridAdvenceSearch, operationType){
    var _this = this;
    var lastSelection;
    var viewInfoIdVal = $("#"+ viewInfoId).val();
    var param, datatype, url;
    if(operationType == "add"){
        param = {"viewInfoId":"null"};
        datatype = "local";
        url = "";
    }else{
        param = {"viewInfoId":viewInfoIdVal,"searchType":"2"};
        datatype = "json";
        url = 'platform/eform/eformViewInfoController/getViewSearchList';
    }

    jqGridAdvenceSearch.jqGrid({
        url: url,
        mtype: 'POST',
        postData: param,
        datatype: datatype,
        editurl:"clientArray",
        toolbar: [false, "top"],
        colModel: [
            { label: 'id', name: 'id', key: true, hidden:true },
            { label: '列名称', name: 'columnName', width: 220 , align:"left",editable : true, edittype: "select", editrules:{required:true}, editoptions: {value : getAdvenceColumnSelectList(_this.tableColumnInfo)}},
            { label: '显示名称', name: 'colTitle', width: 220 , align:"left",editable : true, edittype: "text", editrules:{required:true}, editoptions : {maxlength : "50"} },
            { label: '比较方式', name: 'comparativeMode', width: 220 ,align:"center", editable : true, editrules:{required:true}, edittype:"select", editoptions: {value : {"eq":"等于","nq":"不等于","lt":"小于","gt":"大于","le":"小于等于","ge":"大于等于","cn":"包含","ncn":"不包含"}}},
            { label: 'UI组件', name: 'elementType', width: 220 ,align:"center",editable : true, editrules:{required:true}, edittype:"select", editoptions: {value : {"date":"时间","number":"数值","text":"文本","radio":"单选框","select":"下拉框","checkbox":"复选框"}}},
            { label: '默认值', name: 'defaultValue', width: 220 , align:"left", editable : true, edittype: "text", editrules:{required:true}, editoptions : {maxlength : "50"} }
        ],
        //height:$(window).height()-250,
        scrollOffset: 20, //设置垂直滚动条宽度
        styleUI : 'Bootstrap', 
        viewrecords: true, //
        multiselect: true, //
        autowidth: true,
        responsive:true,//开启自适应
        jsonReader: {  
            root:"rows", 
            total: "total",
            repeatitems: false
        },
        onSelectRow:function(id) {
                if (id && id !== lastSelection) {
                    jqGridAdvenceSearch.jqGrid('saveRow',lastSelection);
                    jqGridAdvenceSearch.jqGrid('editRow',id, {keys: true} );
                    lastSelection = id;
                }
        }                       
    });

}





