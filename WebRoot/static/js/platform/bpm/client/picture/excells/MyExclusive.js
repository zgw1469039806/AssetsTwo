/**
 * exclusive extends MyBase
 */
function MyExclusive(id) {
	MyBase.call(this, id, "decision");
	this.style = "image;image=static/js/platform/designer/images/48/gateway_exclusive.png;";
};
MyExclusive.prototype = new MyBase();
