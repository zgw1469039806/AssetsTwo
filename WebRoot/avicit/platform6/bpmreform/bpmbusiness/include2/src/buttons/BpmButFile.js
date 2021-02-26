/**
 * 引用文档
 */
function BpmButFile(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
	this.enable = false;
	this.domeId = "bpm_but_file";
	this.getHtml();
};
BpmButFile.prototype = new BpmButton();
/**
 * 执行
 */
BpmButFile.prototype.execute = function() {
	var dialog = layer.open({
		type : 2,
		title : "引用文档",
		area : [ "800px", "450px" ],
		content : ""
	});
	layer.full(dialog);
};