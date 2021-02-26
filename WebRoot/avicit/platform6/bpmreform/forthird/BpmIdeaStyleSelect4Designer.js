function BpmIdeaStyleSelect(callback) {
	this.callback = callback;
	return this;
};
BpmIdeaStyleSelect.prototype.show = function() {
	var _self = this;
	layer.open({
		type : 2,
		area : [ "800px", "350px" ],
		title : "选择流程意见",
		shade : 0.3,
		maxmin : false, // 开启最大化最小化按钮
		content : "avicit/platform6/bpmreform/forthird/BpmIdeaStyleSelect4Designer.jsp",
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
					_self.callback("", "", "");
					layer.close(index);
				});
			} else {
				var idArr = data.ids.split("@");
				var texts = data.texts;
				_self.callback(idArr[0], idArr[1], texts);
				layer.close(index);
			}
		}
	});
};