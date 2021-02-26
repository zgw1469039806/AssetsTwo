/**
 * 帮助
 */
function BpmButHelp(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
	this.enable = true;
	this.domeId = "bpm_but_help";
	this.getHtml();
};
BpmButHelp.prototype = new BpmButton();
/**
 * 执行
 */
BpmButHelp.prototype.execute = function() {
	help($("#" + this.domeId).find("a"));
};