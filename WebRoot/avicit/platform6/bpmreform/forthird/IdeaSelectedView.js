function IdeaSelectedView(option) {
	this.id = option.id; // 用户选择视图id
	this.template = option.template;
	var self = this;

	this.removeAll = function() {
		$("#" + self.id).empty();
	};

	this.remove = function(id) {
		var obj = $("#" + self.id).find("div[id='" + id + "']");
		obj.remove();
	};
	
	this.removeStartWith = function(id) {
		var obj = $("#" + self.id).find("div[id^='" + id + "']");
		obj.remove();
	};

	this.addObject = function(id, name) {
		if ($("#" + self.id).find("div[id='" + id + "']").length > 0) {
			layer.msg("已添加该条记录");
			return;
		}
		var tmp = self.template.replace(/#id#/g, id).replace(/#flowname#/g, name);
		$("#" + self.id).append(tmp);
	};
	this.print = function() {
	};
	this.getSelectedFlow = function() {
		var ids = "";
		var texts = "";
		$("#" + self.id).children().each(function() {
			ids += "," + $(this).attr("id");
			texts += "," + $(this).find(".flowname").text().trim();
		});
		return {
			ids : (ids.length > 0 ? ids.substr(1) : ids),
			texts : (texts.length > 0 ? texts.substr(1) : texts)
		};
	}
}