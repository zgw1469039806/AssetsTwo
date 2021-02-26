function H5CommonLookupTypeSelect(option) {
	// 用户参数
	this.type = option.type;
	this.idFiled = option.idFiled;
	this.textFiled = option.textFiled;
	this.callBack = option.callBack;
	this.beferClose = option.beferClose;
	if (this.type == "lookupSelect") {
		this.lookupTypeSelectUrl = "avicit/platform6/h5component/common/LookupTypeSelect.jsp";
	}
	this.init.call(this);
	return this;
};
H5CommonLookupTypeSelect.prototype.init = function() {
	var _self = this;
	var selectDialog = openDialog({
		type : 'selectWindow',
		title : "请选择通用代码类型",
		url : _self.lookupTypeSelectUrl,
		width : "800px",
		height : "450px",
		opentype : 2,
		shade : true,
		submit : function(index, layer) {
			var iframeWin = layer.find('iframe')[0].contentWindow;
			var objData = iframeWin.rowObjData;
			$('#'+_self.idFiled).val(objData.id);
			$('#'+_self.textFiled).val(objData.lookupType);
			if(_self.callBack!=null && _self.callBack!='undefined'){
				if(typeof(_self.callBack) === 'function'){
		 			_self.callBack(objData);
		 		}
			}
		},
		beferClose: function(index, layer){
			if(typeof(_self.beferClose) === 'function'){
	 			_self.beferClose(index, layer);
	 		}
		},
		init : function(index, layer) {
			var iframeWin = layer.find('iframe')[0].contentWindow;
			var lookuptypeid = "";
			if ($("#" + _self.idFiled).length > 0) {
				lookuptypeid = $("#" + _self.idFiled).val();
			}
			iframeWin.init({
				lookuptypeid:lookuptypeid,
				idFiled : _self.idFiled,
				textFiled :_self.textFiled,
				callBack:_self.callBack
			});
		}
	});
}
