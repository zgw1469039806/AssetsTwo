function FormAuth (option) {
	this.dataDomId = option.dataDomId;
	this.showDomId = option.showDomId
	this.callback = option.callback;
	this.type = option.type;
	this.jqGrid = null;
	this.option = option;
	// 将配置信息保存到dom对象里，方便在弹出页面调用
	$("#"+this.dataDomId).data("data-object", this);
	var id = encodeURIComponent(this.dataDomId);
	this.template = option.template || "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/FormAuthTpl/FormAuth.jsp?id="+id;
	this.init();
}

FormAuth.prototype.init = function() {
	var _self = this;
	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
		var box = layer.open({
		    type:  2,
		    area: [ "800px",  "450px"],
		    title: "模板选择",
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		    shade:   0.3,
	        maxmin: false, //开启最大化最小化按钮
		    content: _self.template ,
		    btn: ['确定', '关闭'],
		    yes: function(index, layero){
		    	$("#"+ _self.dataDomId).val(_self.getJqGridRowValue(_self.jqGrid, "id"));
		    	var show = _self.getJqGridRowValue(_self.jqGrid, "templetName");
		    	$("#"+ _self.showDomId).val(show);
		    	$("#"+ _self.showDomId).attr("title",show);
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

FormAuth.prototype.getJqGridRowValue = function (jqgrid, code) {
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
		var rowData = jqgrid.getRowData(jqgrid.getGridParam('selrow'));
		KeyValue = rowData[code];
	}
	return KeyValue;
}
