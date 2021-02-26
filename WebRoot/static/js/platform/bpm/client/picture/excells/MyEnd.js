/**
 * end extends MyBase
 */
function MyEnd(id) {
	MyBase.call(this, id, "end");
	this.style = "image;image=static/js/platform/designer/images/48/end_event_terminate.png;";
};
MyEnd.prototype = new MyBase();
