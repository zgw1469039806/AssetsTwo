function BpmAuthControl(option) {
	this.id  = option.id;
	this.checkedDom = option.checkedDom || "";
	this.divAuthBox = option.divAuthBox;
	this.operator = option.operator;
	this.init.call(this);
}

BpmAuthControl.prototype.init = function() {
	var _self = this;
	$("#"+this.id).find("input[name='"+this.checkedDom+"']").on("click",function(){
		this.checked?
				$("#"+ this.id +" div[class='"+_self.divAuthBox+"']").show() : $("div[class='"+_self.divAuthBox+"']").hidden();
	});
}