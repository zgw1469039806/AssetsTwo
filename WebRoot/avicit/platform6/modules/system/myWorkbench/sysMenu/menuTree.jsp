<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#workbenchMenuEditUl {
		list-style-type: none;
	}
	#workbenchMenuEditUl li {
		border: 1px solid #ccc;
		margin: 2px;
		text-align: center;
		height: 80px;
	}
	.closeIcon{
		float: right;
	}
	.closeIcon i{
		cursor: pointer;
	}
	.menuIcon{
		margin-top: 8px;
		margin-bottom: 5px;
	}
	.menuName{
		font-size: 13px;
	}
</style>

<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	<h4 class="modal-title">自定义菜单</h4>
</div>

<div class="modal-body">
	<div class="row">
		<div class="col-xs-4" id="treeShowDiv">
			<ul id="sysMenuTree">
				<!-- 预定义树展示位置 -->
			</ul>	
		</div>
		
		<div class="col-xs-8" id="workbenchMenuEditDiv">
			<form id="subWorkbenchMenuEditForm">
				<ul id="workbenchMenuEditUl">
					<!-- 预定义菜单拖放位置 -->
				</ul>
			</form>			
		</div>
	</div>
</div>

<div class="modal-footer">
	<button type="button" class="btn btn-sm btn-default" data-dismiss="modal"><i class="ace-icon fa fa-close bigger-110"></i>取消</button>
	<button type="button" class="btn btn-sm btn-primary" id="subWorkbenchMenuEditFormButton"><i class="ace-icon fa fa-arrow-right bigger-110"></i>提交</button>
</div>



<!-- page specific plugin scripts -->
<script src="static/js/platform/aceadmin/fuelux/fuelux.tree.min.js"></script>

<!-- 设置展示树div的样式 -->
<script type="text/javascript">
	$("#treeShowDiv").css("height", $(window).height() - 240);
	$("#treeShowDiv").css("overflow", "scroll");
	$("#treeShowDiv").css("overflow-x", "hidden");
	//$("#treeShowDiv").css("border-right", "1px dashed #ccc");
	
	$("#workbenchMenuEditDiv").css("height", $(window).height() - 240);
	$("#workbenchMenuEditDiv").css("overflow", "scroll");
	$("#workbenchMenuEditDiv").css("overflow-x", "hidden");
</script>

<!-- 设置业务入口 -->
<script>
	$(function() {
		$("#workbenchMenuEditUl").sortable();
		$("#workbenchMenuEditUl").disableSelection();
	});
</script>

<!-- 树操作模块 -->
<script type="text/javascript">
jQuery(function($){
	var dataSource = function(options, callback){
		var pId = 0;//初始值，后台判断
		
		if("type" in options && options.type == "folder") {
			pId = options.additionalParameters["id"];
		}
		
        if (pId != null) {
        	$.get("platform/myWorkbenchController/getMySysMenu/" + pId + ".json",
        		function(backData, status){
        			var tree_data = $.parseJSON(backData);//将json字符串转为对象
        			
        			callback({data: tree_data});
        		}
        	);
        }
	}
	
	$('#sysMenuTree').ace_tree({
		dataSource: dataSource,//数据源
		multiSelect: true,
		cacheItems: true,
		'open-icon' : 'ace-icon tree-minus',
		'close-icon' : 'ace-icon tree-plus',
		'itemSelect' : true,
		'folderSelect': false,
		'selected-icon' : 'ace-icon fa fa-check',
		'unselected-icon' : 'ace-icon fa fa-times',
		loadingHTML : '<div class="tree-loading"><i class="ace-icon fa fa-refresh fa-spin blue"></i></div>'
	});
	
	//选中、取消选择节点时的操作
	$('#sysMenuTree').on('deselected.fu.tree selected.fu.tree', function(event, data) {
		//$('#treeId').tree('selectedItems')选中的多个节点的json对象列表
		//event.type值根据操作分别为selected和deselected
		//data.selected为所有选中节点json数组对象；data.target为当前激活的节点json对象（包括选中和取消选中）
		
		if(event.type == "selected"){
			var selectNode = data.target;
			
			var sysMenuId = selectNode.additionalParameters["id"];
			var sysMenuName = selectNode["text"];
			
			//该菜单在已有控制台菜单中不存在
			if($("#itemSort_" + sysMenuId).length == 0) {
				var li = "";
				li += 
				"<li class='col-xs-10 col-sm-5 col-md-3' id='itemSort_"+sysMenuId+"'>" +
					"<div class='closeIcon'>" +
						"<i class='ace-icon fa fa-times grey' onclick='closeByIcon(\""+sysMenuId+"\")'></i>" +
					"</div>" +
					"<div class='menuIcon'>" +
						"<a href='javascript:;' onclick='ajaxOpenPage(\"MODAL\", \"mainModal-60pct\", \"avicit/platform6/modules/system/myWorkbench/sysMenu/iconChoose.jsp?menuId="+sysMenuId+"\", \"\")'>" +
							"<i class='ace-icon fa fa-pencil-square-o bigger-300' id='icon-"+sysMenuId+"'></i>" +
						"</a>" +
					"</div>" +
					"<div class='menuName'>" +
						"<input type='text' id='aliasMenuName-"+sysMenuId+"' name='aliasMenuName-"+sysMenuId+"' value='"+sysMenuName+"' class='required' style='border: 0px; width: 100%; height: 21px; text-align: center;'>" +
						"<input type='hidden' id='iconClass-"+sysMenuId+"' name='iconClass-"+sysMenuId+"' value='ace-icon fa fa-pencil-square-o bigger-300'>" +
					"</div>" +
				"</li>";
				
				$(li).appendTo($("#workbenchMenuEditUl"));
			}
			//该菜单在已有控制台菜单中已存在
			if($("#itemSort_" + sysMenuId).length == 1) {
				//do nothing
			}
		}
		if(event.type == "deselected"){
			var deselectNode = data.target;
			
			var sysMenuId = deselectNode.additionalParameters["id"];
			$("#itemSort_" + sysMenuId).remove();
		}
	});

	//展开、关闭父节点时的操作
	$('#sysMenuTree').on('disclosedFolder.fu.tree closed.fu.tree', function(event, parentData) {
		//alert(JSON.stringify(parentData));//当前父节点的json信息
	});
	
});
</script>

<!-- 初次进入获取已有业务入口 -->
<script type="text/javascript">
	$.get("platform/myWorkbenchController/workbenchMenuEditInit.json", 
		function(backData, status){
			//回调函数
			var jsonObj = backData;
			
			var myWorkbenchMenuList = jsonObj["myWorkbenchMenuList"];
			for (var i = 0; i < myWorkbenchMenuList.length; i++) {
				var workbenchMenuNode = myWorkbenchMenuList[i];
				
				var sysMenuId = workbenchMenuNode["sysMenuId"];
				var aliasMenuName = workbenchMenuNode["aliasMenuName"];
				var iconClass = workbenchMenuNode["iconClass"];
				
				var li = "";
				li += 
				"<li class='col-xs-10 col-sm-5 col-md-3' id='itemSort_"+sysMenuId+"'>" +
					"<div class='closeIcon'>" +
						"<i class='ace-icon fa fa-times grey' onclick='closeByIcon(\""+sysMenuId+"\")'></i>" +
					"</div>" +
					"<div class='menuIcon'>" +
						"<a href='javascript:;' onclick='ajaxOpenPage(\"MODAL\", \"mainModal-60pct\", \"avicit/platform6/modules/system/myWorkbench/sysMenu/iconChoose.jsp?menuId="+sysMenuId+"\", \"\")'>" +
							"<i class='"+iconClass+"' id='icon-"+sysMenuId+"'></i>" +
						"</a>" +
					"</div>" +
					"<div class='menuName'>" +
						"<input type='text' id='aliasMenuName-"+sysMenuId+"' name='aliasMenuName-"+sysMenuId+"' value='"+aliasMenuName+"' class='required' style='border: 0px; width: 100%; height: 21px; text-align: center;'>" +
						"<input type='hidden' id='iconClass-"+sysMenuId+"' name='iconClass-"+sysMenuId+"' value='"+iconClass+"'>" +
					"</div>" +
				"</li>";
				
				$(li).appendTo($("#workbenchMenuEditUl"));
			}
		}
	);
</script>

<!-- 通过icon关闭方框 -->
<script type="text/javascript">
	function closeByIcon(sysMenuId){
		//关闭方框
		$("#itemSort_" + sysMenuId).remove();	

		//取消选择左侧相对应菜单
		var menuName = "";
		var selectedItemsArray = $('#sysMenuTree').tree('selectedItems');
		for(var i = 0; i < selectedItemsArray.length; i++) {
			var selectedItem = selectedItemsArray[i];
			
			if(sysMenuId == selectedItem.additionalParameters["id"]) {
				menuName = selectedItem.text;
				break;
			}
		}
		
		if(menuName != "") {
			var elementsArray = $("[class='icon-item ace-icon fa fa-check']")
			for(var i = 0; i < elementsArray.length; i++) {
				var selectedElement = elementsArray[i];
				var text = selectedElement.nextSibling.nextSibling.innerHTML;
				
				if(text == menuName) {
					selectedElement.click();//模拟点击
					break;
				}
			}
		}
	}
</script>

<!-- 提交表单模块 -->
<script type="text/javascript">
	$("#subWorkbenchMenuEditFormButton").click(
		function(){
			//jquery.validate表单验证
			if($("#subWorkbenchMenuEditForm").valid()){
				
				//不调用ajaxToDo方法，手动解析，避免操作完成后关闭modal触发监听事件
				$.post("platform/myWorkbenchController/subWorkbenchMenuEdit.json", 
						$("#subWorkbenchMenuEditForm").serialize() + "&" + $("#workbenchMenuEditUl").sortable("serialize"), 
					function(backData, status){
						//回调函数
						var jsonObj = backData;
					    
					    var showMessage = "";
					    if(jsonObj.statusCode == "200"){
					    	showMessage = "<span class='label label-lg label-success label-white'>" +
							  			  "<i class='ace-icon fa fa-check'></i>成功" +
							  			  "</span>&nbsp;&nbsp;" +
							  			  jsonObj.message;
						}
					    if(jsonObj.statusCode == "300"){
					    	showMessage = "<span class='label label-lg label-warning label-white'>" +
					  		  			  "<i class='ace-icon fa fa-exclamation-triangle'></i>警告" +
					  		  			  "</span>&nbsp;&nbsp;" +
							  			  jsonObj.message;
						}
					    
					    //1.关闭modal
					    //if(jsonObj.closeModalDiv != ""){
					    	//$("#" + jsonObj.closeModalDiv).modal("hide");
					    //}
					    
					    //2.弹出提示框
					    bootbox.dialog({
							title : "提示",
							message : showMessage,
							buttons : {
								main : {
									label : "确定",
									className : "btn-sm btn-primary"
								}
							}
						});
					    
					  	//3.根据需要刷新页面
					    //if (jsonObj.refreshType == "DIV") {
							//ajaxOpenPage("DIV", jsonObj.refreshDiv, jsonObj.refreshUrl, "");
						//}
						//if (jsonObj.refreshType == "MODAL") {
							//ajaxOpenPage("MODAL", jsonObj.refreshDiv, jsonObj.refreshUrl, "");
						//}
						
						
						
						//再次ajax从而刷新主页面菜单
						if(jsonObj.statusCode == "200"){
							var menu = $("#mega-menu",  window.parent.document);//父页面iframe调用
							var firstNode = menu.children(":first");
							menu.empty();
							firstNode.appendTo(menu);
							
							$.get("platform/myWorkbenchController/getRefreshMenu.json", 
								function(backData, status){
									//回调函数
									$(backData["backHtml"]).appendTo(menu);
									//menu.html(backData["backHtml"]);
								}
							);
						}
						
					}
				);
				
			}
		}
	);
</script>

<!-- 监听关闭modal事件，关闭父页面tab -->
<script type="text/javascript">
	$('#mainModal-50pct').on('hidden.bs.modal', function (e) {
		//用JS模拟点击A标签事件，须先往A标签中的文字添加能被JS捕获的元素，然后再用JS模拟点击该元素即可。
		var selectedTab = $(".tabs-selected", window.parent.document)//父页面iframe调用
		var closeTabIcon = selectedTab.children(":eq(1)");
		closeTabIcon.append("<span id='closeMe'></span>");
		$("#closeMe", window.parent.document).click();//模拟点击
	})
</script>