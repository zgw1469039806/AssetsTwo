/**
 * MyGrid
 */
function MyGrid(html, headArr) {
	this.html = html;
	this.defaultRow = 0;
	this.headArr = headArr;
	this.dblDel = false;
};
MyGrid.prototype.setDefaultRow = function(defaultRow){
	this.defaultRow = defaultRow;
};
MyGrid.prototype.setDblDel = function(dblDel){
	this.dblDel = dblDel;
};
MyGrid.prototype.init = function() {
	$(this.html).addClass("pc6");
	var table = document.createElement("table");
	var thead = document.createElement("thead");
	var tbody = document.createElement("tbody");
	var tr = document.createElement("tr");
	$.each(this.headArr, function(i, n){
		var th = document.createElement("th");
		if("ch" == n){
			$(th).css("width", "40px");
		}else{
			$(th).text(n);
		}
		$(tr).append($(th));
	});
	$(thead).append($(tr));
	$(table).append($(thead));
	for(var i = 0; i < this.defaultRow; i++){
		var row = document.createElement("tr");
		$(row).attr("_id", i);
		$.each(this.headArr, function(i, n){
			var col = document.createElement("td");
			var input = document.createElement("input");
			$(input).attr("type", "text");
			$(input).css("width", "98%");
			$(input).css("border", "0px");
			$(col).append($(input));
			$(row).append($(col));
		});
		$(tbody).append($(row));
	}
	$(tbody).children().on("click", function(){
		$(tbody).children().removeClass("tr_on");
		$(this).addClass("tr_on");
	});
	$(table).append($(tbody));
	$(this.html).append($(table));
};
MyGrid.prototype.addRow = function(id, textArr) {
	var _self = this;
	var tr = document.createElement("tr");
	$(tr).attr("_id", id);
	$.each(textArr, function(i, n){
		var td = document.createElement("td");
		if("ch" == _self.headArr[i]){
			var checkbox = document.createElement("input");
			$(checkbox).attr("type", "checkbox");
			if(1 == n){
				$(checkbox).attr("checked", "true");
			}
			$(td).append($(checkbox));
		}else{
			$(td).text(n);
		}
		$(tr).append($(td));
	});
	if(this.dblDel){
		$(tr).on("dblclick", function(){
			$(tr).remove();
		});
	}
	$(tr).on("click", function(){
		$(tr).parent().children().removeClass("tr_on");
		$(tr).addClass("tr_on");
	});
	$(this.html).find("tbody").append($(tr));
};
MyGrid.prototype.doesRowExist = function(id) {
	return $(this.html).find("tr[_id='" + id + "']").length > 0;
};
MyGrid.prototype.selectRowById = function(id) {
	$(this.html).find("tr[_id='" + id + "']").trigger("click");
};
MyGrid.prototype.forEachRow = function(f) {
	$(this.html).find("tbody").find("tr").each(function(i){
		var id = $(this).attr("_id");
		f.call(this, id);
	});
};
MyGrid.prototype.cellById = function(id, index) {
	return $(this.html).find("tr[_id='" + id + "']").children().eq(index);
};
MyGrid.prototype.setColumnHidden = function(index, b) {
	$(this.html).find("tr").each(function(){
		if(b){
			$(this).children().eq(index).hide();
		}else{
			$(this).children().eq(index).show();
		}
	});
};
MyGrid.prototype.attachEvent = function(eventName, f) {
	if(eventName == "onRowSelect"){
		$(this.html).find("tbody").find("tr").on("click", function(){
			var id = $(this).attr("_id");
			f.call(id, 0);
		});
	}
};
MyGrid.prototype.getSelectedRowId = function() {
	return $(this.html).find(".tr_on").attr("_id");
};
MyGrid.prototype.getCheckedRows = function(index) {
	var result = "";
	$(this.html).find("tbody").find("tr").each(function(){
		if($(this).children().eq(index).find("input:checked").length > 0){
			result += $(this).attr("_id") + ",";
		}
	});
	if(result != ""){
		result = result.substring(0, result.length - 1);
	}
	return result;
};
MyGrid.prototype.clearAll = function() {
	$(this.html).find("tbody").find("tr").remove();
};
MyGrid.prototype.uid = function() {
	return guid();
};