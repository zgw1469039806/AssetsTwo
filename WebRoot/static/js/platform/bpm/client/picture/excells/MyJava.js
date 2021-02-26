/**
 * java extends MyBase
 */
function MyJava(id) {
	MyBase.call(this, id, "java");
	this.style = "image;image=static/js/platform/designer/images/48/task_java.png;";
};
MyJava.prototype = new MyBase();
