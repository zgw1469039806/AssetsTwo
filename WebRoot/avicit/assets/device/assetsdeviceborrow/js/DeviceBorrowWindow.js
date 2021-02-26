
//弹框选择设备台账的回调函数
function callBackFn(rows, requestType) {
    var row = null;
    if(rows.length > 0){
        row = rows[0];
    }
    switch (requestType) {
        case "productModelSelect":
            $('#UNIFIED_ID').val(row.unifiedId);
            $('#DEVICE_NAME').val(row.deviceName);
            $('#DEVICE_CATEGORY').val(row.deviceCategoryId);
            //如果没有选择设备，设备类别可以编辑；如果选择过设备，将设备类别设置为不可编辑
            $('#DEVICE_CATEGORY').prop('disabled','disabled');
            $('#DEVICE_MODEL').val(row.deviceModel);
            $('#DEVICE_SPEC').val(row.deviceSpec);
            $('#POSITION_ID').val(row.Position);
            $('#MANUFACTURER_ID').val(row.manufacturerId);
            $('#CREATED_DATE').val(row.createdDate);
            $('#SECRET_LEVEL').val(row.secretLevel);
            $('#OWNER_IDName').val(row.ownerId);
            $('#OWNER_DEPTName').val(row.ownerDept);
            $('#USER_IDName').val(row.userId);
            $('#USER_DEPTName').val(row.userDept);
            $('#ORIGINAL_VALUE').val(row.originalValue);
            $('#TOTAL_DEPRECIATION').val(row.totalDepreciation);
            $('#NET_VALUE').val(row.netValue);
            $('#NET_SALVAGE').val(row.netSalvage);
            break;
        case "productSerySelect":
            $('#seryCode').val(row.seryCode);
            $('#seriesId').val(row.id);
            break;
    }
    closeLayer(openIndex);
}

//设置预计归还日期为:当前日期之后的10年区间
$("#EXPECT_RETURN_DATE").datepicker({
    minDate: 0,
    maxDate: '+10Y'
});

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
