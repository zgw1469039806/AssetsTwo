/**
 * 保存
 */
function BpmSave(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
	this.data = buttonData.doformsave;
	if (this.flowEditor.isStart || flowUtils.notNull(this.data)) {
		this.enable = true;
	}
	this.domeId = "bpm_save";
	this.getHtml();
};
BpmSave.prototype = new BpmButton();
/**
 * 禁用标志
 * @type {boolean}
 */
BpmSave.prototype.disabled = false;
/**
 * 执行
 */
BpmSave.prototype.execute = function() {
	var _self = this;
	if(this.disabled){
		return;
	}
	this.disabled = true;
	setTimeout(function(){
		_self.disabled = false;
	},2000);

	if (this.flowEditor.isStart) {
		this.defaultForm.start(this.flowEditor.flowModel.defineId, function(startResult) {
			flowUtils.success("暂存成功");
			_self.flowEditor.afterStart(startResult);
			_self.flowEditor.createButtons();
			flowUtils.refreshBack();
		});
	} else {
		this.defaultForm.save(function() {
			flowUtils.success("暂存成功");
			_self.flowEditor.createButtons();
			//flowUtils.refreshBack();
		});
	}
};
BpmSave.prototype.getHtml = function() {
	if (this.isEnable()) {
		var _self = this;
		$("#" + this.domeId).off("click");
		$("#" + this.domeId).on("click", function() {
			_self.execute()
		});
		$("#" + this.domeId).show();
	} else {
		$("#" + this.domeId).hide();
		$("#" + this.domeId).off("click");
	}
};