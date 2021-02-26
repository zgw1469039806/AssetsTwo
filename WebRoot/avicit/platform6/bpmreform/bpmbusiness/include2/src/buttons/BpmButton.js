/**
 * 按钮基类
 */
function BpmButton(flowEditor, defaultForm, data, isEvent) {
	this.flowEditor = flowEditor;
	this.defaultForm = defaultForm;
	this.data = data;
	if (flowUtils.notNull(this.data)) {
		this.enable = true;
	}
	this.domeId = "";
	this.isEvent = isEvent;
};
BpmButton.prototype.enable = false;
BpmButton.prototype.isEnable = function() {
	return this.enable;
};
/**
 * 执行
 */
BpmButton.prototype.execute = function() {
	flowUtils.success("该方法开发中");
};
BpmButton.prototype.getHtml = function() {
	if(this.isEvent){
		return;
	}
	// 隐藏并清空事件
	$("#" + this.domeId).children("a").off("click");
	if (this.isEnable()) {
		if(this.data && this.data.alias){
			$("#" + this.domeId).find("span").html(this.data.alias);
		}else {
			$("#" + this.domeId).find("span").html($("#" + this.domeId).find("a").attr("title"));
		}
		var _self = this;
		$("#" + this.domeId).children("a").on("click", function() {
			_self.execute();
		});
		this.flowEditor.showButtons(this.domeId);
	}
};
BpmButton.prototype.submit = function(data, users) {
	flowUtils.warning("未实现的方法");
};
BpmButton.prototype.validIdeasBySelf = function(valid_value, callback){
	var self = this;
	if(this.flowEditor.flowModel.ideasBySelf != null && this.flowEditor.flowModel.ideasBySelf.length > 0){
		var content = "<form class='container-fluid'>\n";
		var flg = false;
		for(var i = 0; i < this.flowEditor.flowModel.ideasBySelf.length; i++){
			var ideas = this.flowEditor.flowModel.ideasBySelf[i];
			if(ideas.outcome == "0" || ideas.outcome == valid_value){
				flg = true;
				content += "  <div class=\"form-group\">\n" +
					"    <label><input type='radio' name='ideas_radio'/> " + ideas.content + "</label>\n" +
					"  </div>\n";
			}
		}
		content += "</form>";
		if(!flg){
			callback();
			return;
		}
		layer.open({
			type : 1,
			title : "强制表态",
			area : [ "300px", "400px" ],
			content : content,
			btn: ['确定', '取消'],
			yes: function(index, layero){
				var ideas_radio = $("input[name='ideas_radio']:checked");
				if(ideas_radio.length == 0){
					flowUtils.warning("请先表态");
					return;
				}
				self.ideas_text = ideas_radio.parent().text().trim();
				callback();
				layer.close(index);//查询框关闭
			}
		});
	}else {
		callback();
	}
};
