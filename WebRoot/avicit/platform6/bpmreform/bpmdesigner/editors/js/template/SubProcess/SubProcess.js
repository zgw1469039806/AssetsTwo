function SubProcess (option) {
	this.dataDomId = option.dataDomId;
	this.showDomId = option.showDomId
	this.callback = option.callback;
	this.dataDomId2 = option.dataDomId2;
	this.option = option;
	this.process = option.process;
	this.multiple = typeof option.multiple == 'undefined' ? true : option.multiple; 
	// 将配置信息保存到dom对象里，方便在弹出页面调用
	$("#"+this.dataDomId).data("data-object", this);
	var id = encodeURIComponent(this.dataDomId);
	this.template = "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/SubProcess/SubProcess.jsp?id="+id;
	this.init();
}

SubProcess.prototype.init = function() {
	var _self = this;
	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
		var box = layer.open({
		    type:  2,
		    area: [ "800px",  "450px"],
		    title: "子流程选择框",
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		    shade:   0.3,
	        maxmin: false, //开启最大化最小化按钮
		    content: _self.template ,
		    btn: ['确定', '关闭'],
		    yes: function(index, layero){
		    	var selectedKey = _self.getJqGridRowValue(_self.jqGrid, "key");
		    	var selectedId = _self.getJqGridRowValue(_self.jqGrid, "id");
		    	if(!selectedId && !selectedKey){
                    layer.msg("请选择数据");
		    		return;
		    	}
		    	$("#"+ _self.dataDomId).val(selectedKey);
		    	$("#"+ _self.dataDomId2).val(selectedId);
		    	var show = _self.getJqGridRowValue(_self.jqGrid, "displayName");
		    	$("#"+ _self.showDomId).val(show);
		    	$("#"+ _self.showDomId).attr("title",show);
                if(_self.callback && typeof _self.callback == 'function') {
                    _self.callback(_self.getJqGridRowValueArr(_self.jqGrid));
                }
		    	layer.close(index);
			 },
			cancel: function(index){
				layer.close(index);
				$('html').addClass('fix-ie-font-face');
				setTimeout(function() {
					$('html').removeClass('fix-ie-font-face');
				}, 10);
		    },
		   success: function(layero, index){
		   }
		});
}

SubProcess.prototype.getJqGridRowValue = function (jqgrid, code) {
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

SubProcess.prototype.getJqGridRowValueArr = function (jqgrid) {
	var ret = [];
	var selectedRowIds = jqgrid.getGridParam("selrow");
	if(this.multiple == true) {
		selectedRowIds = jqgrid.getGridParam("selarrrow");
		if (selectedRowIds != "") {
			var len = selectedRowIds.length;
			for ( var i = 0; i < len; i++) {
				var rowData = jqgrid.getRowData(selectedRowIds[i]);
				ret.push(rowData);
			}
		} 
	}else{
		if (selectedRowIds != ""){
			var rowData = jqgrid.getRowData(selectedRowIds);
			ret.push(rowData);
		}
	}
	
	return ret;
}
