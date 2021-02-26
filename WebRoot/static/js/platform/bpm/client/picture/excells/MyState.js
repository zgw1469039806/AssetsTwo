/**
 * state extends MyBase
 */
function MyState(id) {
	MyBase.call(this, id, "state");
	this.style = "image;image=static/js/platform/designer/images/48/task_wait.png;";
};
MyState.prototype = new MyBase();
