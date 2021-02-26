/**
 * sql extends MyBase
 */
function MySql(id) {
	MyBase.call(this, id, "sql");
	this.style = "image;image=static/js/platform/designer/images/48/task_sql.png;";
};
MySql.prototype = new MyBase();
