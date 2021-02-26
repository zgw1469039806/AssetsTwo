/**
 * 关联流程
 */
function BpmButRelation(flowEditor, defaultForm, buttonData, isEvent) {
    BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
    this.enable = flowUtils.notNull(this.flowEditor.flowModel.entryId);
    this.domeId = "bpm_but_relation";
    this.getHtml();
};
BpmButRelation.prototype = new BpmButton();
/**
 * 执行
 */
BpmButRelation.prototype.execute = function () {
    var url = "avicit/platform6/bpmreform/bpmbusiness/include2/bpmRelationflow.jsp?entryId=" + this.flowEditor.flowModel.entryId;
    var dialog = layer.open({
        type: 2,
        title: "关联流程",
        area: ["800px", "450px"],
        content: url
    });
    layer.full(dialog);
};