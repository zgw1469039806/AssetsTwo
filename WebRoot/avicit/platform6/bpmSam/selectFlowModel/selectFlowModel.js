/**
 * Created by lianch on 2017/9/19.
 */
function SelectFolwModel(bdformId, bpmModel) {
    this.bdformId = bdformId;
    this.bpmModel = bpmModel;

    this.selectDialog = null;
}

SelectFolwModel.prototype.init = function () {
    var _this = this;

    var bdformId = _this.bdformId;
    var bpmModel = _this.bpmModel;
    var parm = "bdformId=" + bdformId + "&bpmModel=" + bpmModel;
    
    $("#" + bpmModel).click(function () {
        _this.selectDialog = layer.open({
            type: 2,
            title: '选择模型分类',
            skin: 'bs-modal',
            area: ['350px', '350px'],
            maxmin: false,
            content: "avicit/platform6/bpmSam/selectFlowModel/selectFlowModel.jsp?" + parm
        });
    });
    $("#" + bpmModel).css("cursor", "pointer");
}