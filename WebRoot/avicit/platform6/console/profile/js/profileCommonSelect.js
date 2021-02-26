function ProfileCommonSelect(option) {
	// 用户参数
	this.type = option.type;
	this.idFiled = option.idFiled;
	this.textFiled = option.textFiled;

	if (option.selectModel == null) {
		this.selectModel = "single";
	} else if (this.selectModel == "single") {
		this.selectModel = "single";
	} else {
		this.selectModel = "multi";
	}
	if (this.type == "siteSelect") {
		this.siteSelectUrl = "avicit/platform6/console/profile/siteselect.jsp";
	} else if (this.type == "appSelect") {
		this.appSelectUrl = "avicit/platform6/console/profile/appselect.jsp";
	} 

	this.init.call(this);
	return this;
};

ProfileCommonSelect.prototype.init = function() {
	var _self = this;
	if (_self.type == "siteSelect") {
		var selectDialog = openDialog({
			type : 'selectWindow',
			title : "请选择地点",
			url : _self.siteSelectUrl,
			width : "800px",
			height : "450px",
			opentype : 2,
			shade : true,
			submit : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				var data = iframeWin.getDataList();
				$("#" + _self.idFiled).val(data.ids);
				$("#" + _self.textFiled).val(data.Names);
			},
			init : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				iframeWin.init({
					selectModel : _self.selectModel,
					ids : $("#" + _self.idFiled).val(),
					idFiled : _self.idFiled,
					textFiled : _self.textFiled,
                    setPropertys: function(site){
                        $('#' + _self.idFiled).val(site.siteId);
                        $('#' + _self.textFiled).val(site.siteName);
                    }
				});
			}
		});
	} else if (_self.type == "appSelect") {
		var selectDialog = openDialog({
			type : 'selectWindow',
			title : "请选择应用",
			url : this.appSelectUrl,
			width : "800px",
			height : "450px",
			opentype : 2,
			shade : true,
			submit : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				var data = iframeWin.getDataList();
				$("#" + _self.idFiled).val(data.ids);
				$("#" + _self.textFiled).val(data.Names);
			},
			init : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				iframeWin.init({
					selectModel : _self.selectModel,
					ids : $("#" + _self.idFiled).val(),
					idFiled : _self.idFiled,
					textFiled : _self.textFiled,
                    setPropertys: function(app){
                        $('#' + _self.idFiled).val(app.appId);
                        $('#' + _self.textFiled).val(app.appName);
                    }
				});
			}
		});
	}
}
