/**
 * 相关流程
 */
function BpmRelationflow(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dorelationprocess, isEvent);
	this.domeId = "bpm_relationprocess";
	this.getHtml();
};
BpmRelationflow.prototype = new BpmButton();
/**
 * 执行
 */
BpmRelationflow.prototype.execute = function() {
	var _self = this;
	var procinstDbid = this.data.procinstDbid;
	this.index = layer.open({
		type : 2,
		area : [ '90%', '90%' ],
		title : '添加',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : 'avicit/platform6/bpmreform/bpmbusiness/include/relatedBpm.jsp?pid=' + encodeURIComponent(this.data.procinstDbid),
		end : function(){
			//刷新相关流程页签
			_self.flowEditor.reloadProcesslevelPage();
		}
	});
};
