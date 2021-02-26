function ProcessVariable (option) {
	this.callback = option.callback;
	this.option = option;
	this.pid = option.id;
	this.pname = option.name;
	this.processId = option.processId;
	this.template = "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/ProcessVariableForSelectUser.jsp?processId="+option.processId+"&pid="+option.id+"&pname="+option.name;
	this.init();
}

ProcessVariable.prototype.init = function() {
	var _self = this;
	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
		var box = layer.open({
			type:  2,
            area: [ "450px",  "370px"],
		    title: "流程变量",
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		    shade:   0.3,
	        maxmin: false, //开启最大化最小化按钮
		    content: _self.template,
            btn: ['确定', '关闭'],
            yes: function(index, layero){
                var iframeWin = layero.find('iframe')[0].contentWindow;
                var name = iframeWin.getJqGridRowValue("name");
                var alias = iframeWin.getJqGridRowValue("alias");
				var dataType = iframeWin.$("#dataType").val();
				var dataTypeName = iframeWin.$("#dataType").find("option:selected").text();
                var deptPositionId = iframeWin.$("#dataType").attr("deptPositionId");
				var deptPositionName = iframeWin.$("#dataType").attr("deptPositionName");
				if(flowUtils.notNull(name)){
                    addVariableNodeInfoUserSelectView(_self.pid,_self.pname,name,alias,dataType,dataTypeName,deptPositionId,deptPositionName);
                    layer.close(index);
				}else{
                	flowUtils.warning("请先选择数据");
				}
            }
		});
}

ProcessVariable.prototype.getJqGridRowValue = function (jqgrid, code) {
	var KeyValue = "";
	var selectedRowIds = jqgrid.getGridParam("selarrrow");
	if (selectedRowIds != "") {
		var len = selectedRowIds.length;
		for ( var i = 0; i < len; i++) {
			var rowData = jqgrid.getRowData(selectedRowIds[i]);
			KeyValue += rowData[code] + ";";
		}
		KeyValue = KeyValue.substr(0, KeyValue.length - 1);
	} else {
		var rowData = jqgrid.getRowData(
				jqgrid.getGridParam("selrow"));
		KeyValue = rowData[code];
	}
	return KeyValue;
}

ProcessVariable.prototype.getJqGridRowValueArr = function (jqgrid) {
	var ret = [];
	var selectedRowIds = jqgrid.getGridParam("selrow");
	if(this.multiple == true) {
		selectedRowIds = jqgrid.getGridParam("selarrrow");
	}
	if (selectedRowIds != "") {
		var len = selectedRowIds.length;
		for ( var i = 0; i < len; i++) {
			var rowData = jqgrid.getRowData(selectedRowIds[i]);
			ret.push(rowData);
		}
	} 
	return ret;
}
