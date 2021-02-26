
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
            $('#DEVICE_MODEL').val(row.deviceModel);
            $('#OWNER_DEPT').val(row.ownerDept);
            $('#OWNER_DEPTName').val(row.ownerDeptAlias);
            $('#DEVICE_SPEC').val(row.deviceSpec);
            $('#POSITION_ID').val(row.positionId);
            $('#MANUFACTURER_ID').val(row.manufacturerId);
            $('#REPAIR_DEPT').val(row.repairDept);
            $('#REPAIR_DEPTName').val(row.repairDept);
            setSelectedText($('#DEVICE_CATEGORY'), row.deviceCategory);
            setSelectedText($('#IS_PC'), row.isPc);
            setSelectedText($('#IS_TEST_DEVICE'), row.isTestDevice);
            setSelectedText($('#IS_METERING'), row.isMetering);
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