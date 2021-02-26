/**
 * 流程意见修改
 */
function BpmGlobalidea(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalidea, isEvent);
	this.domeId = "bpm_globalidea";
	this.getHtml();
	this.lastIndex = -1;
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
			$("#ideaTable").datagrid({
				url : "platform/bpm/business/doGettracksByPage?entryId=" + _self.data.procinstDbid,
				method : "POST",
				idField : "dbid",
				columns : [[ {
					field : 'dbid',
					hidden : true
				}, {
					title : '节点',
					field : 'currentActiveLabel',
					align : 'center',
					width : 100
				}, {
					title : '处理人',
					field : 'assigneeName',
					align : 'center',
					width : 80
				}, {
					title : '接收时间',
					field : 'iTime',
					align : 'center',
					width : 110
				}, {
					title : '处理时间',
					field : 'eTime',
					align : 'center',
					width : 110
				}, {
					title : '操作类型',
					field : 'opType',
					align : 'center',
					width : 80
				}, {
					title : '处理意见',
					field : 'message',
					editor : "text",
					width : 200
				} ]],
				rownumbers : true,
				striped : true,
				fitColumns : true,
				onClickCell:function(rowIndex,field,value){
					if(field == 'message'){
						if (_self.lastIndex != rowIndex){
							$('#ideaTable').datagrid('endEdit', _self.lastIndex);
							$('#ideaTable').datagrid('beginEdit', rowIndex);
						}
						_self.lastIndex = rowIndex;
					}
				}
			});
		},
		yes : function(index, layero) {
			$('#ideaTable').datagrid('endEdit', _self.lastIndex);
			var data = $('#ideaTable').datagrid('getChanges');
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
						_self.flowEditor.refreshTracks();
					}
				}
			});
		}
	});
};