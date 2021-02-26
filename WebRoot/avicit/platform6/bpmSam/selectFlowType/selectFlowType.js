/**
 * Created by lianch on 2017/8/18.
 */
function SelectFolwType(formId, bpmType) {
    this.formId = formId;
    this.bpmType = bpmType;

    this.selectDialog = null;
}

SelectFolwType.prototype.init = function () {
    var _this = this;

    var formId = _this.formId;
    var bpmType = _this.bpmType;
    var parm = "formId=" + formId + "&bpmType=" + bpmType;
    
    $("#" + bpmType).click(function () {
        _this.selectDialog = layer.open({
            type: 2,
            title: '选择模型分类',
            skin: 'bs-modal',
            area: ['350px', '350px'],
            maxmin: false,
            content: "avicit/platform6/bpmSam/selectFlowType/selectFlowType.jsp?" + parm
        });
    });
    $("#" + bpmType).css("cursor", "pointer");
}