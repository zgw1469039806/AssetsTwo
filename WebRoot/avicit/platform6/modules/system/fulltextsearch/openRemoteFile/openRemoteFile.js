/**
 * Created by lianch on 2018/3/14.
 */
function OpenRemoteFile(formId) {
    this.formId = formId;

    this.selectDialog = null;
}

OpenRemoteFile.prototype.init = function () {
    var _this = this;

    var formId = _this.formId;
    var parm = "formId=" + formId;
    
    $("#" + formId).click(function () {
        _this.selectDialog = top.layer.open({
            type: 2,
            title: '选择磁盘文件',
            skin: 'bs-modal',
            area: ['800px', '500px'],
            maxmin: false,
            content: "avicit/platform6/modules/system/fulltextsearch/openRemoteFile/openRemoteFile.jsp?" + parm
        });
    });
    $("#" + formId).css("cursor", "pointer");
}