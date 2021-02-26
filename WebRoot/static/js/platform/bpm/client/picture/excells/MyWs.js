/**
 * ws extends MyBase
 */
function MyWs(obj) {
	MyBase.call(this, obj, "ws");
	this.style = "image;image=static/js/platform/designer/images/48/task_webservice.png;";
};
MyWs.prototype = new MyBase();
