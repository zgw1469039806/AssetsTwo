/**
 * sub-process extends MyBase
 */
function MySubprocess(id) {
	MyBase.call(this, id, "sub-process");
	this.style = "image;image=static/js/platform/designer/images/48/task_subprocess.png;";
};
MySubprocess.prototype = new MyBase();
