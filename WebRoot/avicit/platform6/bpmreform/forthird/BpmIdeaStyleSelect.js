function BpmIdeaStyleSelect(formcode) {
	this.formcode = formcode;
};
BpmIdeaStyleSelect.prototype.show = function(callback, ids, texts) {
	var _self = this;
	layer.open({
		type : 2,
		area : [ "800px", "450px" ],
		title : "选择流程意见配置项",
		shade : 0.3,
		maxmin : false, // 开启最大化最小化按钮
		content : "avicit/platform6/bpmreform/forthird/BpmIdeaStyleSelect.jsp?formcode=" + this.formcode,
		btn : [ '确定', '关闭' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;
			var data = iframeWin.getSelectedData();
			if (data == null || data.ids == "") {
				layer.confirm("确定不选择任何数据吗？", {
					icon : 3,
					title : '提示'
				}, function(index1) {
					layer.close(index1);
					callback(data);
					layer.close(index);
				});
			} else {
				callback(data);
				layer.close(index);
			}
		},
		success: function(layero, index){
			var iframeWin = layero.find('iframe')[0].contentWindow;
			if(typeof ids != "undefined" && ids.length > 0){
				var idArr = ids.split(",");
				var textArr = texts.split(",");
				for(var i = 0; i < idArr.length; i++){
					iframeWin.ideaSelectedView.addObject(idArr[i], textArr[i]);
				}
			}
		}
	});
};