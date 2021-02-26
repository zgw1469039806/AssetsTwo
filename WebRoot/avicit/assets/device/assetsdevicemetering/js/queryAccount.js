/* window.onload是在页面加载完成之后执行 */
window.onload=function() {
    $("#DYN_DEVICE_TOOL_insertBtn").unbind("click");
    $("#DYN_DEVICE_TOOL_insertBtn").on("click",function () {
        // var param =  JSON.stringify({unifiedId:"Z555555"});
        openProductModelLayer("false","","callBackFnSubTable","");
    });

    $("#UNIFIED_ID").unbind("click");
    $("#UNIFIED_ID").on("click",function () {
        // var param =  JSON.stringify({unifiedId:"Z555555"});
        openProductModelLayer("false","","callBackFn","");
    });
}


var newRowIndex = 0;
var newRowStart = "new_row";

/* 设备通用选择框选择回填 */
function addAssetsRow(rowJson) {
    //获取待移交台账列表中的数据
    var allData = $('#DYN_DEVICE_TOOL').jqGrid('getRowData');

    //判断待移交台账列表中的数据是否为空
    if((allData != null) && (allData != undefined) && (allData.length>0)){
        for(j=0; j<allData.length; j++){
            //判断待移交的设备是否已添加
            if(allData[j].UNIFIED_ID == rowJson.UNIFIED_ID){
                layer.msg('编号' + rowJson.unifiedId +'的设备已添加！');
                return;
            }
        }
    }

    debugger;
    var newRowId = newRowStart + newRowIndex;
    var parameters = {
        rowID: newRowId,
        initdata: rowJson,
        position: "first",
        useDefValues: true,
        useFormatter: true,
        addRowParams: {extraparam: {}}
    };
    $('#DYN_DEVICE_TOOL').jqGrid('addRow', parameters);

    newRowIndex++;
};


function setSelectedText(select, text) {
    var totalLen =  select[0].length;
    if(text == 'Y'){
        text = '是'
    }else if(text == 'N'){
        text = '否'
    }
    for(var i = 0; i < totalLen; i++){
        if(select[0].options[i].text == text) {
            select[0].options[i].selected = true;
            break;
        }
    }
}

//弹框选择设备台账的回调函数
function callBackFn(rows, requestType) {
    var row = null;
    if(rows.length > 0){
        row = rows[0];
    }
    switch (requestType) {
        case "productModelSelect":
            console.log(row);
            $('#UNIFIED_ID').val(row.unifiedId);
            $('#DEVICE_NAME').val(row.deviceName);
            $('#OWNER_ID').val(row.ownerId);
            $('#OWNER_IDName').val(row.ownerIdAlias);
            $('#DEVICE_MODEL').val(row.deviceSpec);
            $('#OWNER_DEPT').val(row.ownerDept);
            $('#OWNER_DEPTName').val(row.ownerDeptAlias);
            $('#DEVICE_SPEC').val(row.deviceSpec);
            $('#POSITION_ID').val(row.positionId);
            $('#MANUFACTURER_ID').val(row.manufacturerId);
            $('#METER_PLAN_PERSON').val(row.planMeterman);
            $('#METER_PLAN_PERSONName').val(row.planMetermanAlias);
            $('#METER_PERSON').val(row.meterman);
            $('#METER_PERSONName').val(row.metermanAlias);
            $('#METER_MODE').val(row.meterMode);
            setSelectedText($('#DEVICE_CATEGORY'), row.deviceCategory);
            setSelectedText($('#IS_METERING'), row.isMetering);
            break;
        case "productSerySelect":
            $('#seryCode').val(row.seryCode);
            $('#seriesId').val(row.id);
            break;
    }
    closeLayer(openIndex);
}

//弹框选择设备台账的回调函数
function callBackFnSubTable(rows, requestType) {
    switch (requestType) {
        case "productModelSelect":
            for(i=0; i<rows.length; i++){
                var row = rows[i];
                var rowJson = {};

                rowJson.UNIFIED_ID = row.unifiedId;
                rowJson.DEVICE_NAME = row.deviceName;
                rowJson.DEVICE_SPEC = row.deviceSpec;
                rowJson.DEVICE_MODEL = row.deviceModel;
                rowJson.DEVICE_CATEGORY = row.deviceCategory;


                addAssetsRow(rowJson);
            }
            break;
        case "productSerySelect":
            $('#seryCode').val(row.seryCode);
            $('#seriesId').val(row.id);
            break;
    }

    closeLayer(openIndex);

}

//弹窗关闭函数
function closeLayer(){
    layer.close(openIndex);
}

/**
 * 设备台账信息选择框
 * param:
 *  singleSelect -是否单选（true-单选，false为多选；字符串）；
 *  requestType-页面请求标记，用于同一页面有多个相同弹出页时，调用回调函数赋值时使用，可为空字符串，代码默认取值‘productModelSelect’；
 *  callBackFn-回调函数名称，用户声明的“弹框选择设备台账的回调函数”的函数名字符串；
 */
function openProductModelLayer (singleSelect, requestType, callBackFn, param){
    sessionStorage.setItem("param",param);
    this.openIndex = layer.open({
        type: 2,
        area: ['60%', '70%'],
        title: '台账信息选择',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/assetsdeviceaccount/AssetsDeviceAccountSelect.jsp?singleSelect="+singleSelect+"&requestType="+requestType+"&callBackFn="+callBackFn

    });
}