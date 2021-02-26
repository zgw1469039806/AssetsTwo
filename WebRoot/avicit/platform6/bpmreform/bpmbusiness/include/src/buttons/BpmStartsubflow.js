/**
 * 发起子流程
 */
function BpmStartsubflow(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dostartsubprocess, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_startsubprocess";
	this.getHtml();
};
BpmStartsubflow.prototype = new BpmButton();
/**
 * 执行
 */
BpmStartsubflow.prototype.execute = function() {
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getSubPdId",
		data : {
			procinstDbid : this.data.procinstDbid,
			executionId : this.data.executionId
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				if(result.ids.length == 0){
					//flowUtils.warning("该功能未设置相应的流程模板！");
					//默认展示所有流程模板
					_self.showAllFlowModel();
				}else if(result.ids.length == 1){
					_self.executeUserInfo(result.ids[0].id);
				}else{
					_self.executeSelectId(result.ids);
				}
			}
		}
	});
};
var _bpm_BpmStartsubflow = null;
BpmStartsubflow.prototype.showAllFlowModelFlg = false;
BpmStartsubflow.prototype.showAllFlowModel = function() {
	_bpm_BpmStartsubflow = this;
	var _self = this;
	layer.open({
		type: 2,
		title: "选择子流程模板",
		area: ["800px", "450px"],
		content: "platform/bpm/business/showAllFlowModel",
		end : function() {
			_self.showAllFlowModelFlg = false;
		},
	});
	this.showAllFlowModelFlg = true;
};
BpmStartsubflow.prototype.executeSelectId = function(ids) {
	var _self = this;
	layer.open({
	    type:  1,
	    area: [ "300px",  "450px"],
	    title: "流程模板选择",
	    content: "<table id='processGrid'></table>",
	    btn: ['确定', '关闭'],
		 success : function(layero, index) {
			$("#processGrid").jqGrid({
				datastr : JSON.stringify(ids),
				datatype : "jsonstring",
				colModel : [{
					name : 'id',
					key : true,
					hidden : true
				}, {
					label : '流程名称',
					name : 'name',
					align : 'center'
				} ],
				rownumbers : true,
				altRows : true,
				styleUI : 'Bootstrap',
				autowidth : true,
				height : '100%',
				multiselect: false,  
				multiboxonly:true,  
				beforeSelectRow: _self.beforeSelectRow
			});
		},
		yes: function(index, layero){
			var id = $("#processGrid").jqGrid("getGridParam","selrow");
			if (id != "") {
				_self.executeUserInfo(id);
			} else{
				layer.msg("请选择数据");
				return;
			}
			layer.close(index);
		}
	});
};
BpmStartsubflow.prototype.beforeSelectRow = function(){
	$("#processGrid").jqGrid('resetSelection');  
    return true;
};
BpmStartsubflow.prototype.executeUserInfo = function(id) {
	if(this.showAllFlowModelFlg){
		layer.closeAll();
	}
	this.data.deployId = id;
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : _self.data.procinstDbid,
			executionId : _self.data.executionId,
			taskId : _self.data.taskId,
			outcome : _self.data.name,
			targetActivityName : _self.data.targetActivityName,
			type : 'dostartsubprocess'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				new BpmActor(_self.data, result.taskUserSelect, _self).open();
			}
		}
	});
};
/**
 * 
 * @param data
 * @param users
 */
BpmStartsubflow.prototype.submit = function(data, users) {
	if (!flowUtils.notNull(users) || users.length == 0) {
		flowUtils.warning("选人错误");
		return;
	}
	var _self = this;
	var userJson = {
		users : users,
		idea : _self.getIdeaText(),
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/dostartsubprocess",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson),
			id : data.deployId
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				flowUtils.success("操作成功!");
				_self.flowEditor.createButtons();
				//刷新上下游页签
				_self.flowEditor.reloadProcesslevelPage();
				flowUtils.refreshBack();
			}
		}
	});
};