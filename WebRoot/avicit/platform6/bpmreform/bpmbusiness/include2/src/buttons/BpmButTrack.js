/**
 * 流程跟踪
 */
function BpmButTrack(flowEditor, defaultForm, buttonData, isEvent) {
    BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
    this.enable = true;
    this.domeId = "bpm_but_track";
    this.getHtml();
};
BpmButTrack.prototype = new BpmButton();
/**
 * 执行
 */
BpmButTrack.prototype.execute = function() {
    var url = "avicit/platform6/bpmreform/bpmdesigner/picture/picAndTracks.jsp?";
    if(flowUtils.notNull(this.flowEditor.flowModel.entryId)){
        url += "entryId=" + this.flowEditor.flowModel.entryId;
    }else{
        url += "deploymentId=" + this.flowEditor.flowModel.deploymentId;
    }
    var dialog = layer.open({
        type : 2,
        title : "流程跟踪",
        area : [ "800px", "450px" ],
        content : url
    });
    layer.full(dialog);
};