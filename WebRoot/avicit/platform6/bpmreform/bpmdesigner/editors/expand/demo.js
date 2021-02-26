/**
* demo
*/
function Demo() {
	this.id = "demo";
	this.text = "自定义选人规则";
};
Demo.prototype.getOption = function() {
	return {
		id : this.id,
		text : this.text
	};
};
Demo.prototype.click = function() {
	//若有多个参数，可以使用“_”将参数和id拼装成一个字符串，解析时按照规则解析，例如1为普通岗位，则可以这样拼    this.id+"_1",this.text+"#普通岗位"
	addNodeIntoUserSelectView(this.id, this.id, "relation", this.text);
};