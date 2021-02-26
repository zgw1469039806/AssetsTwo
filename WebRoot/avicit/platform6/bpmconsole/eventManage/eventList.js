function MyEventList() {
	this.eventGrid = $("#event_table");
	this.propertiesGrid = $("#properties_table");
	this.selectEventId = null;
	this.selectEventType = null;
	this.dialog = null;
}

MyEventList.prototype.selectEventList = function(rowIndex, rowData) {
	this.selectEventId = rowData.dbid;
	this.selectEventType = rowData.type;
	this.loadPropertiesList();
};
MyEventList.prototype.loadPropertiesList = function() {
	var _self = this;
	this.propertiesGrid.datagrid("load", {
		pid : _self.selectEventId
	});
	this.propertiesGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
};
MyEventList.prototype.loadEventList = function() {
	this.eventGrid.datagrid("reload");
	this.eventGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	this.selectEventId = null;
	this.selectEventId = null;
	this.loadPropertiesList();
};
MyEventList.prototype.delEvent = function() {
	var rows = this.eventGrid.datagrid('getChecked');
	if (rows.length == 0) {
		$.messager.alert("提示", "请勾选下面的列表前的框先选择要删除的数据", "warning");
		return;
	}
	var ids = [];
	for (var i = 0; i < rows.length; i++) {
		ids.push(rows[i].dbid);
	}
	var _self = this;
	$.messager.confirm('请确认', '您确定要删除所选的' + rows.length + '条数据吗？', function(b) {
		if (b) {
			$.ajax({
				url : 'platform/bpm/bpmconsole/eventManageAction/delEvent.json',
				data : {
					ids : ids.join(",")
				},
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success") {
						_self.loadEventList();
						$.messager.show({
							title : '提示',
							msg : '删除成功！'
						});
					} else {
						$.messager.alert("提示", r.error, "warning");
					}
				}
			});
		}
	});
};
MyEventList.prototype.delProperties = function() {
	var rows = this.propertiesGrid.datagrid('getChecked');
	if (rows.length == 0) {
		$.messager.alert("提示", "请勾选下面的列表前的框先选择要删除的数据", "warning");
		return;
	}
	var ids = [];
	for (var i = 0; i < rows.length; i++) {
		ids.push(rows[i].dbid);
	}
	var _self = this;
	$.messager.confirm('请确认', '您确定要删除所选的' + rows.length + '条数据吗？', function(b) {
		if (b) {
			$.ajax({
				url : 'platform/bpm/bpmconsole/eventManageAction/delProperties.json',
				data : {
					ids : ids.join(",")
				},
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success") {
						_self.loadPropertiesList();
						$.messager.show({
							title : '提示',
							msg : '删除成功！'
						});
					} else {
						$.messager.alert("提示", r.error, "warning");
					}
				}
			});
		}
	});
};
MyEventList.prototype.closeDialog = function() {
	this.dialog.close();
};
MyEventList.prototype.insertEvent = function() {
	this.dialog = new CommonDialog("insertEvent", "870", "520", 'platform/bpm/bpmconsole/eventManageAction/addEvent', "添加", false, true, false);
	this.dialog.show();
};
MyEventList.prototype.modifyEvent = function() {
	var row = this.eventGrid.datagrid('getSelected');
	if (row == null) {
		$.messager.alert("提示", "请单击下面的列表行先选择要编辑的数据", "warning");
		return;
	}
	this.dialog = new CommonDialog("modifyEvent", "870", "520", 'platform/bpm/bpmconsole/eventManageAction/editEvent?id=' + row.dbid, "编辑", false, true, false);
	this.dialog.show();
};
MyEventList.prototype.insertProperties = function() {
	if (this.selectEventId == null) {
		$.messager.alert("提示", "事件列表没有选中数据", "warning");
		return;
	}
	if (this.selectEventType != "流程事件监听") {
		$.messager.alert("提示", "事件列表选中数据的类型不是【流程事件监听】,不能添加参数", "warning");
		return;
	}
	this.dialog = new CommonDialog("insertProperties", "700", "300", 'platform/bpm/bpmconsole/eventManageAction/addProperties?thirdPartyDbid=' + this.selectEventId, "添加", false, true, false);
	this.dialog.show();
};
MyEventList.prototype.modifyProperties = function() {
	var row = this.propertiesGrid.datagrid('getSelected');
	if (row == null) {
		$.messager.alert("提示", "请单击下面的列表行先选择要编辑的数据", "warning");
		return;
	}
	this.dialog = new CommonDialog("modifyProperties", "700", "300", 'platform/bpm/bpmconsole/eventManageAction/editProperties?id=' + row.dbid, "编辑", false, true, false);
	this.dialog.show();
};
MyEventList.prototype.insertOrUpdateEvent = function(form) {
	var _self = this;
	$.ajax({
		url : 'platform/bpm/bpmconsole/eventManageAction/insertOrUpdateEvent.json',
		data : {
			data : JSON.stringify(form)
		},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				$.messager.show({
					title : '提示',
					msg : '保存成功！'
				});
				_self.loadEventList();
				_self.closeDialog();
			} else {
				$.messager.alert("提示", r.error, "warning");
			}
		}
	});
};
MyEventList.prototype.insertOrUpdateProperties = function(form) {
	var _self = this;
	$.ajax({
		url : 'platform/bpm/bpmconsole/eventManageAction/insertOrUpdateProperties.json',
		data : {
			data : JSON.stringify(form)
		},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				$.messager.show({
					title : '提示',
					msg : '保存成功！'
				});
				_self.loadPropertiesList();
				_self.closeDialog();
			} else {
				$.messager.alert("提示", r.error, "warning");
			}
		}
	});
};

var myEventList = new MyEventList();