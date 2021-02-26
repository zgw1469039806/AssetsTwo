var itemcount = 1;
var dataJsonList = [];
var curId = "";

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
			item.append('<span class="item-title">'+dataJsonList[i].data.orgname+'</span>');

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
		if (!jsondata.hasOwnProperty("selectarray")){
			jsondata.selectarray = "";
		}
		$("#property_form").setform(jsondata);
	}
}

//初始化隐藏区域，绘制html，赋值，并将默认值更新入数组
function initHidden(){
	drawAttrArea(curId);
	setProperty(curId);
	update(curId);
}

function drawAttrArea(id){
	if (selecttype === "deptSelect") {
		$("#selecttitle").text("部门范围");
		$('#selectarrayName').unbind("click").click(function (e) {
			new H5CommonSelect({
				type: 'deptSelect',
				idFiled: 'selectarray',
				textFiled: 'selectarrayName',
				viewScope: 'all',
				selectModel: 'multi',
				defaultOrgId:id
				,
				callBack: function (dept) {
					var deptid = dept.deptids.replace(/\;/g,",");
					var deptname = dept.deptnames.replace(/\;/g,",");
					$("#selectarrayName").val(deptname);
					$("#selectarray").val(deptid);
					update(curId);
				}
			});
		});
	}else if (selecttype === "roleSelect"){
		$("#selecttitle").text("角色范围");
		$('#selectarrayName').unbind("click").click(function (e) {
			new H5CommonSelect({
				type: 'roleSelect',
				idFiled: 'selectarray',
				textFiled: 'selectarrayName',
				viewScope: 'all',
				selectModel: 'multi',
				defaultOrgId:id
				,
				callBack: function (role) {
					var roleid = role.roleids.replace(/\;/g,",");
					var rolename = role.roleNames.replace(/\;/g,",");
					$("#selectarrayName").val(rolename);
					$("#selectarray").val(roleid);
					update(curId);
				}
			});
		});
	}else if (selecttype === "groupSelect"){
		$("#selecttitle").text("群组范围");
		$('#selectarrayName').unbind("click").click(function (e) {
			new H5CommonSelect({
				type: 'groupSelect',
				idFiled: 'selectarray',
				textFiled: 'selectarrayName',
				viewScope: 'all',
				selectModel: 'multi',
				defaultOrgId:id
				,
				callBack: function (group) {
					var groupid = group.groupids.replace(/\;/g,",");
					var groupname = group.groupNames.replace(/\;/g,",");
					$("#selectarrayName").val(groupname);
					$("#selectarray").val(groupid);
					update(curId);
				}
			});
		});
	}else if (selecttype === "positionSelect"){
		$("#selecttitle").text("岗位范围");
		$('#selectarrayName').unbind("click").click(function (e) {
			new H5CommonSelect({
				type: 'positionSelect',
				idFiled: 'selectarray',
				textFiled: 'selectarrayName',
				viewScope: 'all',
				selectModel: 'multi',
				defaultOrgId:id
				,
				callBack: function (position) {
					var positionid = position.positionids.replace(/\;/g,",");
					var positionname = position.positionNames.replace(/\;/g,",");
					$("#selectarrayName").val(positionname);
					$("#selectarray").val(positionid);
					update(curId);
				}
			});
		});
	}else if (selecttype === "orgSelect"){
		$("#selecttitle").text("组织范围");
		$('#selectarrayName').unbind("click").click(function (e) {
			new H5CommonSelect({
				type: 'orgSelect',
				idFiled: 'selectarray',
				textFiled: 'selectarrayName',
				viewScope: 'all',
				selectModel: 'multi',
				defaultOrgId:id
				,
				callBack: function (org) {
					var orgid = org.orgids.replace(/\;/g,",");
					var orgname = org.orgnames.replace(/\;/g,",");
					$("#selectarrayName").val(orgname);
					$("#selectarray").val(orgid);
					update(curId);
				}
			});
		});
	}
}


//初始化页面入口
$(document).ready(function(){

	
	$("#property_form").find("input").on("keyup",function(){
		update(curId);
	});


	$("#property_form").hide();

	$.ajax({
		url: 'platform/eform/bpmsClient/getOrgList',
		type: 'POST',
		dataType: 'json',
		success: function (backData, status) {
			if (backData.data){
				var list;
				if (selecttype === "deptSelect") {
					list = $('#deptlist', window.parent.document).val();
				}else if (selecttype === "roleSelect"){
					list = $('#rolelist', window.parent.document).val();
				}else if (selecttype === "groupSelect"){
					list = $('#grouplist', window.parent.document).val();
				}else if (selecttype === "positionSelect"){
					list = $('#positionlist', window.parent.document).val();
				}else if (selecttype === "orgSelect"){
					list = $('#orglist', window.parent.document).val();
				}

				if (list){
					var list = $.parseJSON(list);
					for (var i=0;i<list.length;i++){
						var data = list[i];
						var id = data.orgid;
						putJsonData(id,data);
					}

				}


				for (var index in backData.data){
					if (index === "clone") continue;
					var data = backData.data[index];
					var orgid = data.id;
					var olddata = getJsonData(orgid)
					if (olddata){
						olddata.orgname = data.name;
						updateJsonData(orgid,olddata);
					}else{
						var jsondata = {orgid:orgid,orgname:data.name}
						putJsonData(orgid,jsondata);
					}
				}
				drawListArea();
				if (!isEmpty()){
					var fistId = dataJsonList[0].id;
					$("#"+fistId).click();
				}
			}
		}
	})
});

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

