/**
 * fork extends MyBase
 */
function MyFork(id) {
	MyBase.call(this, id, "fork");
	this.style = "image;image=static/js/platform/designer/images/48/gateway_fork.png;";
};
MyFork.prototype = new MyBase();
