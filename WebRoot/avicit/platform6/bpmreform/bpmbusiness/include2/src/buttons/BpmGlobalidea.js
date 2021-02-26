/**
 * 流程意见修改
 */
function BpmGlobalidea(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalidea, isEvent);
	this.domeId = "doglobalidea";
	this.getHtml();
};
BpmGlobalidea.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobalidea.prototype.execute = function() {
	var _self = this;
	layer.open({
		type : 1,
		title : "修改意见",
		area : [ "800px", "450px" ],
		content : "<table id='ideaTable'></table>",
		btn : [ '确定', '关闭' ],
		success : function(layero, index) {
			$("#ideaTable").jqGrid({
				url : "platform/bpm/business/doGettracksByPage?entryId=" + _self.data.procinstDbid,
				mtype : 'POST',
				datatype : "json",
				rowNum : -1,
				colModel : [ {
					name : 'dbid',
					key : true,
					hidden : true
				}, {
					label : '节点',
					name : 'currentActiveLabel',
					align : 'center'
				}, {
					label : '处理人',
					name : 'assigneeName',
					align : 'center'
				}, {
					label : '接收时间',
					name : 'iTime',
					align : 'center'
				}, {
					label : '处理时间',
					name : 'eTime',
					align : 'center'
				}, {
					label : '操作类型',
					name : 'opType',
					align : 'center'
				}, {
					label : '处理意见',
					name : 'message',
					editable : true
				} ],
				rownumbers : true,
				altRows : true,
				styleUI : 'Bootstrap',
				autowidth : true,
				cellEdit : true,
				cellsubmit : 'clientArray',
				height : 300
			});
		},
		yes : function(index, layero) {
			$("#ideaTable").jqGrid('endEditCell');
			var data = $("#ideaTable").jqGrid('getChangedCells');
			avicAjax.ajax({
				url : 'platform/bpm/business/saveGettracks',
				data : {
					data : JSON.stringify(data),
					processInstanceId : _self.data.procinstDbid
				},
				type : 'post',
				dataType : 'json',
				success : function(msg) {
					if (flowUtils.notNull(msg.error)) {
						flowUtils.error(msg.error);
					} else {
						flowUtils.success("修改成功");
						layer.close(index);
						_self.flowEditor.refreshIdea();
					}
				}
			});
		}
	});
};