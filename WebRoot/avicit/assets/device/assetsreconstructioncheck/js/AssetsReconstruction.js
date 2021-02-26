window.onload=function(){
    $("#ASSETS_RECONSTRUCTION_CHECK_insertBtn").unbind();
    $("#ASSETS_RECONSTRUCTION_CHECK_insertBtn").bind("click",function () {
        openProductModelLayer ();
    })
}


function openProductModelLayer (){
    comId = $("#comId").val();
    var attribute02 = $('#zhengji').val();
   this.openIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '添加',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/assetsreconstructioncheck/AssetsReconstructionCheckDetail.jsp?comId="+comId+"&attribute02="+attribute02
    });
};

function callback(){
    $("#ASSETS_RECONSTRUCTION_CHECK").jqGrid('setGridParam', {datatype: 'json'}).trigger("reloadGrid");
    layer.close(openIndex);

}
function callBackFn(selectedRow) {
    debugger;
    var row = selectedRow[0];
    $("#TEL").val(row.telephone);
    $("#COLLECT_YEAR").val( row.applyYear);
    $("#COLLECT_SELECT").val( row.formTitle);
    $("#zhengji").val( row.id);




    layer.close(openIndex);

}
function  openNoticeList() {
    this.openIndex = layer.open({
        type: 2,
        area: ['60%', '70%'],
        title: '添加',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/dynreconmsg/DynReconMsgSelect.jsp"
    });
}
