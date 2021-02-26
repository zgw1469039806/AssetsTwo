/**
 * 模块列表操作类
 */
function FlowListEditor(formCode) {
	this.formCode = formCode;
	this.obj = null;
	if (!flowUtils.notNull(this.formCode)) {
		flowUtils.warning("没有指定必要的参数：formCode！请联系管理员！");
		return;
	}
	var _self = this;
	$.ajax({
		type : "POST",
		data : {
			formCode : this.formCode
		},
		url : "platform/bpm/clientbpmdisplayaction/getprocessbyformcode",
		dataType : "json",
		success : function(obj) {
			_self.obj = obj;
		}
	});
};
/**
 * 添加按钮
 */
FlowListEditor.prototype.addFlow = function(id) {
	if (this.obj != null && this.obj.length == 1) {
		_bpm_listeditor_start(this.obj[0].dbid, this.obj[0].name,id);
	} else if (this.obj != null && this.obj.length > 1) {
		this.openDefDialog(id);
	} else {
		flowUtils.warning("没有找到符合条件的流程模板！请联系管理员！");
	}
};
FlowListEditor.prototype.openDefDialog = function(id) {
	var _self = this;
	_bpm_listeditor_dialog = layer.open({
		type : 1,
		title : "流程模板选择",
		area : [ "300px", "400px" ],
		content : "<table id='defTable'></table>",
		end : function() {
			_bpm_listeditor_dialog = null;
		},
		success : function(layero, index) {
			$("#defTable").jqGrid({
				datastr : JSON.stringify(_self.obj),
				datatype : "jsonstring",
				colModel : [ {
					name : 'dbid',
					key : true,
					hidden : true
				}, {
					label : '流程名称',
					name : 'name',
					align : 'center',
					formatter : function(value, row, index){ _self.formatDefValue(value, row, index,id)}
				}, {
					label : '版本',
					name : 'version',
					align : 'center'
				} ],
				rownumbers : true,
				altRows : true,
				styleUI : 'Bootstrap',
				width : 290,
                height:320
			});
		}
	});
};
FlowListEditor.prototype.formatDefValue = function(cellvalue, options, rowObject,id) {
	if (id!=null && id!=undefined){
		return "<a href='javascript:void(0);' onclick='_bpm_listeditor_start(\"" + rowObject.dbid + "\",\"" + cellvalue + "\",\""+id+"\");'>" + cellvalue + "</a>";
	}else {
		return "<a href='javascript:void(0);' onclick='_bpm_listeditor_start(\"" + rowObject.dbid + "\",\"" + cellvalue + "\");'>" + cellvalue + "</a>";
	}
};
var _bpm_listeditor_dialog = null;
function _bpm_listeditor_start(defId, defName,id) {
	if (id!=null && id!=undefined &&id != ""){
		flowUtils.openOnDialog("platform/bpm/business/start?businessId="+id+"&defineId=" + defId, defName);
	}else {
		flowUtils.openOnDialog("platform/bpm/business/start?defineId=" + defId, defName);
	}
	if (_bpm_listeditor_dialog != null) {
		layer.close(_bpm_listeditor_dialog);
		_bpm_listeditor_dialog = null;
	}
}
