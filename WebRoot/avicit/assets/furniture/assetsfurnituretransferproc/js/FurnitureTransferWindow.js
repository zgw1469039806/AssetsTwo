/* window.onload是在页面加载完成之后执行 */
window.onload=function() {
    $("#ASSETS_FURNITURE_TRANSFER_SUB_insertBtn").unbind("click");
    $("#ASSETS_FURNITURE_TRANSFER_SUB_insertBtn").on("click",function () {
        var param =  JSON.stringify({unifiedId:"Z555555"});
        openProductModelLayer("false","","callBackFn","");
    })
}


var newRowIndex = 0;
var newRowStart = "new_row";

/* 设备通用选择框选择回填 */
function addAssetsRow(rowJson) {
    //获取待移交台账列表中的数据
    var allData = $('#ASSETS_FURNITURE_TRANSFER_SUB').jqGrid('getRowData');
    //判断待移交台账列表中的数据是否为空
    if((allData != null) && (allData != undefined) && (allData.length>0)){
        for(j=0; j<allData.length; j++){
            //判断待移交的设备是否已添加
            if(allData[j].UNIFIED_ID == rowJson.UNIFIED_ID){
                layer.msg('编号' + rowJson.UNIFIED_ID +'的设备已添加！');
                return;
            }
        }
    }

    var newRowId = newRowStart + newRowIndex;
    $('#ASSETS_FURNITURE_TRANSFER_SUB').jqGrid('endEditCell');
    // var newRowId = newRowStart + newRowIndex;
    var parameters = {
        rowID: newRowId,
        initdata:rowJson,
        position: "first",
        useDefValues: true,
        useFormatter: true,
        // cellEdit: true,
        // cellsubmit: 'clientArray',
        addRowParams: {extraparam: {}}
    }
    $('#ASSETS_FURNITURE_TRANSFER_SUB').jqGrid('addRow', parameters);
    $("#ASSETS_FURNITURE_TRANSFER_SUB").editRow(newRowIndex, true);
    newRowIndex++;
};

//弹框选择设备台账的回调函数
function callBackFn(rows, requestType) {
    switch (requestType) {
        case "productModelSelect":
            for(i=0; i<rows.length; i++){
                var row = rows[i];
                var rowJson = {};
                rowJson.UNIFIED_ID = row.unifiedId;
                rowJson.ASSET_ID = row.assetId;
                rowJson.FURNITURE_NAME = row.furnitureName;
                rowJson.FURNITURE_CATEGORY = row.furnitureCategory;
                rowJson.FURNITURE_SPEC = row.furnitureSpec;
                rowJson.OWNER_ID = row.ownerId;
                rowJson.OWNER_IDName = row.ownerIdAlias;
                rowJson.OWNER_DEPT = row.ownerDept;
                rowJson.OWNER_DEPTName = row.ownerDeptAlias;
                rowJson.USER_ID = row.userId;
                rowJson.USER_IDName = row.userIdAlias;
                rowJson.USER_DEPT = row.userDept;
                rowJson.USER_DEPTName = row.userDeptAlias;
                rowJson.MANUFACTURER_ID = row.manufacturerId;
                rowJson.CREATED_DATE = row.createdDate;
                rowJson.POSITION_ID = row.positionId;
                rowJson.FURNITURE_PHOTO = row.furniturePhoto;
                rowJson.FURNITURE_STATE = row.furnitureState;
                rowJson.furnitureStateName = row.furnitureStateName;

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
 * 家具台账信息选择框
 * param:
 *  singleSelect -是否单选（true-单选，false为多选；字符串）；
 *  requestType-页面请求标记，用于同一页面有多个相同弹出页时，调用回调函数赋值时使用，可为空字符串，代码默认取值‘productModelSelect’；
 *  callBackFn-回调函数名称，用户声明的“弹框选择家具台账的回调函数”的函数名字符串；
 */
function openProductModelLayer (singleSelect, requestType, callBackFn, param){
    sessionStorage.setItem("param",param);
    this.openIndex = layer.open({
        type: 2,
        area: ['60%', '70%'],
        title: '家具台账信息选择',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/furniture/assetsfurnitureaccount/AssetsFurnitureAccountSelect.jsp?singleSelect="+singleSelect+"&requestType="+requestType+"&callBackFn="+callBackFn
    });
};

/**
 * 提交前事件
 * 柯嘉  重写  提交前事件  函数，对子表数据进行非空校验
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeSubmit = function(data) {
    //重写提交前函数，判断子表是否有数据，如果没有数据禁止提交
    var Rowdata = ($('#ASSETS_FURNITURE_TRANSFER_SUB').jqGrid('getRowData'))
    if(Rowdata.length<1){
        layer.msg('请选择家具再提交！');
        return false;
    }else{
        return true;
    }
};