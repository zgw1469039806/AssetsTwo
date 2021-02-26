firstUnifiedId = $("#UNIFIED_ID").val();    /* 获取表单最初的 统一编号 */

//第一层页面 主表的 弹框选择设备台账的回调函数
function callBackFn(rows, requestType) {
    var row = null;
    if(rows.length > 0){
        row = rows[0];
    }
    var lastUnifiedId = row.unifiedId;  /* 回填数据中的 统一编号 */
    /* 如果主表的统一编码发生变更，则删除已勾选的子表的全部数据 */
    if(firstUnifiedId!=lastUnifiedId && null!=firstUnifiedId && ""!=firstUnifiedId){
        /* 模拟点击删除操作 */
        $("#cb_ASSETS_TDEVICE_UPGRADE_SUB").click();        /* 点击子表的全选复选框 */
        $("#ASSETS_TDEVICE_UPGRADE_SUB_deleteBtn").click(); /* 点击子表的删除按钮 */
        $(".layui-layer-btn0").click();                     /* 点击弹窗的确认 */
        layer.msg("设备已更改，所选软件已清除！");
    }

    /* 通过ajax获取表单中统一编号包含的软件子表中所有适用产品机型的数据的合集 */
    var uid = JSON.stringify({uid:row.unifiedId});
    avicAjax.ajax({
        url: "platform/assets/device/assetstdeviceappproduct/assetsTdeviceAppproductController/query/planemodel",
        data:uid ,
        type: 'POST',
        contentType:'application/json',
        dataType : 'json',
        success: function(planemodels) {
            planemodel=planemodels["planemodels"];
            $('#PLANE_MODEL').val(planemodel);
        }
    });

    /* 通过ajax获取表单中统一编号包含的软件子表中所有适用产品名称的数据的合集 */
    var uid = JSON.stringify({uid:row.unifiedId});
    avicAjax.ajax({
        url: "platform/assets/device/assetstdeviceappproduct/assetsTdeviceAppproductController/query/productname",
        data:uid ,
        type: 'POST',
        contentType:'application/json',
        dataType : 'json',
        success: function(productnames) {
            productname=productnames["productName"];
            $('#PRODUCT_NAME').val(productname);
        }
    });
    switch (requestType) {
        case "productModelSelect":
            $('#UNIFIED_ID').val(row.unifiedId);
            $('#DEVICE_NAME').val(row.deviceName);
            $('#DEVICE_CATEGORY').val(row.deviceCategoryId);
            $('#DEVICE_MODEL').val(row.deviceModel);
            $('#DEVICE_SPEC').val(row.deviceSpec);
            $('#POSITION_ID').val(row.Position);
            $('#MANUFACTURER_ID').val(row.manufacturerId);
            $('#CREATED_DATE').val(row.createdDate);
            $('#SECRET_LEVEL').val(row.secretLevel);
            $('#OWNER_ID').val(row.ownerId);
            $('#OWNER_IDName').val(row.ownerIdAlias);
            $('#OWNER_DEPT').val(row.ownerDept);
            $('#OWNER_DEPTName').val(row.ownerDeptAlias);
            $('#USER_ID').val(row.userId);
            $('#USER_IDName').val(row.userIdAlias);
            $('#USER_DEPTName').val(row.userDeptAlias);
            $('#USER_DEPT').val(row.userDept);
            $('#SECRET_LEVEL').val(row.secretLevel);
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

function callBackReload() {
    /* 重新加载子表页面 */
    $('#ASSETS_TDEVICE_UPGRADE_SUB').jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
}
