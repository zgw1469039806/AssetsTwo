/**
 * join extends MyBase
 */
function MyJoin(id) {
	MyBase.call(this, id, "join");
	this.style = "image;image=static/js/platform/designer/images/48/gateway_join.png;";
};
MyJoin.prototype = new MyBase();
