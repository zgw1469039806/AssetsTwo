/**
 * jms extends MyBase
 */
function MyJms(id) {
	MyBase.call(this, id, "jms");
	this.style = "image;image=static/js/platform/designer/images/48/task_jms.png;";
};
MyJms.prototype = new MyBase();
