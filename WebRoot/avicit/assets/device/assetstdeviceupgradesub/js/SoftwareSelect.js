/* window.onload是在页面加载完成之后执行 */
window.onload=function() {
    $("#ASSETS_TDEVICE_UPGRADE_SUB_insertBtn").unbind("click");
    $("#ASSETS_TDEVICE_UPGRADE_SUB_insertBtn").on("click", function () {
        $("#bpm_save").click();
        var comId = $("#comId").val();
        var unifiedId = $("#UNIFIED_ID").val();
        if ("" != unifiedId) {

            openTdeviceSoftwareAdd(comId, unifiedId);
        } else {
            layer.msg('请先选择设备再添加！');       //不需要点确认的提示，几秒钟后自动消失
        }
    })
}

//弹窗关闭函数
function closeLayer(){
    layer.close(openIndex);
}
//弹框选择设备台账的回调函数
function callBackFnSoftware() {
    $('#ASSETS_TDEVICE_UPGRADE_SUB').jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
}

//测试设备软件添加页面弹出函数
function openTdeviceSoftwareAdd (comId,unifiedId){
    this.openIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '测试设备软件添加页',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/assetstdeviceupgradesub/AssetsTdeviceUpgradeSubAdd.jsp?comId="+comId+"&unifiedId="+unifiedId

    });
};
