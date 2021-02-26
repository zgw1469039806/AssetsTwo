/**
 * start extends MyBase
 */
function MyStart(id) {
	MyBase.call(this, id, "start");
	this.style = "image;image=static/js/platform/designer/images/48/start_event_empty.png;";
};
MyStart.prototype = new MyBase();
