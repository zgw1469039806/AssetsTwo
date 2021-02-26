/**
 * custom extends MyBase
 */
function MyCustom(id) {
	MyBase.call(this, id, "custom");
	this.style = "image;image=static/js/platform/designer/images/48/task_custom.png;";
};
MyCustom.prototype = new MyBase();
