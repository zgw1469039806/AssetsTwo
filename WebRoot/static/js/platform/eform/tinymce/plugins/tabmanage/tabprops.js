var itemcount = 1;
var dataJsonList = [];
var curId = "";

function addTabItem(){
	var id = GenNonDuplicateID();
	var data = {
			tabname:"页签"+itemcount,
			tabid:id
	};
	putJsonData(id,data);
	drawListArea();
	itemcount++;
	$("#"+id).click();
}


function removeItem(obj){
	var id = $(obj).parent().attr("id");
	delJsonData(id);
	drawListArea();
	if (!isEmpty()){
		var fistId = dataJsonList[0].id;
		$("#"+fistId).click();
	}
}

function update(id){
	var json = $("#property_form").serializeObject();
	updateJsonData(id,json);
	drawListArea();
}

function itemClick(obj){
	var id = $(obj).attr("id");
	curId = id;
	$("#list_area").find(".current").removeClass("current");
	$(obj).addClass("current");
	$("#property_form").show();
	initHidden();
}

function drawListArea(){
	$("#list_area").html("");
	if (!isEmpty()){
		for (var i=0;i<dataJsonList.length;i++){
			var id = dataJsonList[i].id;
			var item = $('<li id="'+id+'" class="item-list"></li>');
			if (id == curId){
				item.addClass("current");
			}
			item.append('<span class="item-order" order="'+(i+1)+'">['+(i+1)+']</span>').append('<span class="item-title">'+dataJsonList[i].data.tabname+'</span>');
			var removeButton = $('<a href="javascript:void(0)" class="remove"></a>');
			removeButton.append('<i class="fa fa-times"></i>');
			item.append(removeButton);
			removeButton.click(function(){
				removeItem(this);
			});
			
			item.click(function(){
				itemClick(this);
			}).hover(function(){
				$(this).addClass("hover");
			},function(){
				$(this).removeClass("hover");
			});
			$("#list_area").append(item);
			
		}
	}
}

function isEmpty(){
	if (dataJsonList.length>0){
		$(".empty-tip").hide();
		return false;
	}else{
		$(".empty-tip").show();
		$("#property_form").hide();
		return true;
	}
}

function setProperty(id){
	var jsondata = getJsonData(id);
	$("#property_form").each( function(){
		this.reset();
		$(this).find("input[type='checkbox'],input[type='radio']").attr("checked",false);
	});
	if (jsondata){
		$("#property_form").setform(jsondata);
	}
}

//初始化隐藏区域，绘制html，赋值，并将默认值更新入数组
function initHidden(){
	initHiddenAttrArea(curId);
	setProperty(curId);
	update(curId);
}

//初始化隐藏区域html及绑定事件
function initHiddenAttrArea(curId){
}

//初始化页面入口
// $(document).ready(function(){
// 	init();
//
// });

function init(list){
	$("#item_add").click(function(){
		addTabItem();
	});


	$("#property_form").find("input").on("keyup",function(){
		update(curId);
	});

	$("#list_area").sortable({
		stop: function(e,t){
			var $li = $(t.item);
			var id = $li.attr("id");
			var order = $li.prev().find(".item-order").attr("order")||"0";
			var data = getJsonData(id);
			delJsonData(id);
			putJsonData(id,data,parseInt(order));
			drawListArea();
			$("#"+curId).click();
		}
	});

	$("#property_form").hide();
	if (list.length>0){
		for (var i=0;i<list.length;i++){
			var data = list[i];
			var id = GenNonDuplicateID();
			putJsonData(id,data);
		}
		drawListArea();
		if (!isEmpty()){
			var fistId = dataJsonList[0].id;
			$("#"+fistId).click();
		}
	}
}

function putJsonData(id, json, index) {
	if (index != undefined) {
		dataJsonList.splice(index, 0, {
			id: id,
			data: json
		});
	} else {
		dataJsonList.push({
			id: id,
			data: json
		});
	}
}

function delJsonData(id){
	for (var i=0;i<dataJsonList.length;i++){
		if (dataJsonList[i].id == id){
			dataJsonList.splice(i, 1);
			break;
		}
	}
}

function updateJsonData(id,json){
	for (var j=0;j<dataJsonList.length;j++){
		if (dataJsonList[j].id == id){
			dataJsonList[j].data = json;
			break;
		}
	}
}

function getJsonData(id){
	if (id){
		for (var i=0;i<dataJsonList.length;i++){
			if (dataJsonList[i].id == id){
				return dataJsonList[i].data;
			}
		}
	}
}