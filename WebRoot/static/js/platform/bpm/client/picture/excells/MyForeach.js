/**
 * foreach extends MyBase
 */
function MyForeach(id) {
	MyBase.call(this, id, "foreach");
	this.style = "image;image=static/js/platform/designer/images/48/gateway_foreach.png;";
};
MyForeach.prototype = new MyBase();
