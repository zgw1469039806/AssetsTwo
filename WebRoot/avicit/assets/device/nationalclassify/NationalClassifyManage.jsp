<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";

String isTestDevice = request.getParameter("isTestDevice"); //菜单路径参数是否测试设备isTestDevice
String isPc = request.getParameter("isPc"); //菜单路径参数是否计算机isPc


%>
<!DOCTYPE html>
<html>
<head>
	<!-- ControllerPath = "assets/device/nationalclassify/nationalClassifyController/toNationalClassifyManage" -->
	<title>管理</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	
	<!-----------------------------------------zTree需要引入的css------------------------------------------->
	<link type="text/css" rel="stylesheet" href="static/css/zTree_v3/demo.css">
	<link type="text/css" rel="stylesheet" href="static/css/zTree_v3/zTreeStyle/zTreeStyle.css">

	<link type="text/css" rel="stylesheet" href="static/css/jquery-ui-1.8.16.custom.css">
	
	<!-----------------------------------------zTree需要引入的js------------------------------------------->
	<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="static/js/zTree_v3/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="static/js/zTree_v3/jquery.ztree.exhide.js"></script>
	<script type="text/javascript" src="static/js/zTree_v3/jquery.ztree.exedit.js"></script>
	<script type="text/javascript" src="static/js/zTree_v3/fuzzysearch.js"></script>
	
	<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
</head>

<script type="text/javascript">


	//定义serializeObject方法，序列化表单
	$.fn.serializeObject = function() {
	    var o = {};
	    var a = this.serializeArray();
	 
	    $.each(a, function() {
	        if (o[this.name]) {
	            if (!o[this.name].push) {
	                o[this.name] = [ o[this.name] ];
	            }
	 
	            o[this.name].push(this.value || '');
	        } 
	        else {
	            o[this.name] = this.value || '';
	        }
	 
	    });
	 
	    return o;
	};

	function showElement(id, x, y){
		var theElement = document.getElementById(id);
		
		theElement.style.display = "inline";
		theElement.style.top = x + 'px';
		theElement.style.left = y + 'px';
	}
	
	function hiddenElement(id){
		document.getElementById(id).style.display = "none";
	}

	var setting = {
		edit: {
			enable: true,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		check: {
			enable: true//checkbox
		},
		view: {
			nameIsHTML: true, //允许name支持html				
			selectedMulti: false,
			dblClickExpand: false,
			addDiyDom: addDiyDom,
			showLine: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: onClick,
			onRightClick: OnRightClick,
			beforeRename: beforeRename
		}
	};
	
	//添加自定义元素
	function addDiyDom(treeId, treeNode) {	
		//缩小子节点与父节点元素左边距差
		if((treeNode.pId != undefined) && (treeNode.pId != null) &&(treeNode.pId != "")){		
			document.getElementById(treeNode.tId).style.marginLeft = "-10px";
		}
	}
	
	//显示右键菜单
	function showRMenu(type, x, y) {
		$("#treeMenu ul").show();
		y += document.body.scrollTop;
		x += document.body.scrollLeft;

        treeMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});
		document.getElementById("rMenuDetail").style.display = "block";
		$("body").bind("mousedown", onBodyMouseDown);
	}
	
	var currentNode;
	var pasteNodes;

	/**
	 * 默认筛选条件
	 * 以session存储分类数据
	*/
    var classData;
    var isTestDevice = '<%=isTestDevice%>';
    var isPc = '<%=isPc%>';
    if(isTestDevice == "Y") {
        classData = JSON.stringify({isTestDevice: "Y"});
        sessionStorage.setItem("classData",classData);
    }
    else if(isPc == "Y"){
        classData = JSON.stringify({isPc: "Y"});
        sessionStorage.setItem("classData",classData);
	}

	//树菜单鼠标单击函数
	function onClick(event, treeId, treeNode, clickFlag){
        currentNode = treeNode;
        var nationClass = currentNode.itemNum;
        /*单击类别树节点，按照设备类别筛选台账列表-begin*/
        if(isTestDevice == "Y") {
            //是测试设备台账条件下的分类树筛选
            classData = JSON.stringify({isTestDevice: "Y", deviceCategory:nationClass});
            sessionStorage.setItem("classData",classData);//以session存储分类数据
        }
        else if(isPc == "Y"){
            //是计算机条件下的分类树筛选
            classData = JSON.stringify({isPc: "Y", deviceCategory:nationClass});
            sessionStorage.setItem("classData",classData);//以session存储分类数据
        }
        else{
            //仅按分类树筛选
            classData = JSON.stringify({deviceCategory:nationClass});
            sessionStorage.setItem("classData",classData);//以session存储分类数据
		}
		document.getElementById('assetsDeviceAccountManageIframe').contentWindow.location.reload(true);

        // var select = window.parent.document.getElementById("searchDialog").getElementsByTagName("select")[0];
        // select.defaultValue = "";
        // if(select != undefined){
        //     //先取消之前的选中
        //     select.selectedIndex = -1;
        //     //按照左侧树的类别，设置选中
        //     for (var i = 0; i < select.options.length; i++){
        //         if (select.options[i].value == currentNode.itemNum){
        //             select.options[i].selected = true;
        //             break;
        //         }
        //     }
        // }
        //
        // window.parent.document.getElementById("assetsDeviceAccount_searchAll").click();
        // window.parent.document.getElementsByClassName("layui-layer-btn0")[0].click();
        /*单击类别树节点，按照设备类别筛选台账列表-end*/
    }
	
	//树菜单鼠标右键函数
	function OnRightClick(event, treeId, treeNode) {
		currentNode = treeNode;
		var zTree = $.fn.zTree.getZTreeObj("classifyTreeDemo");
		zTree.selectNode(treeNode);
		
		var menuRight = document.getElementById("treeMenu");
		menuRight.style.display = "inline";
		menuRight.style.top = event.clientY + 'px';
		
		if((document.body.clientWidth-event.clientX) < 100){
			menuRight.style.left = (document.body.clientWidth-105) + 'px';
		}
		else{
			menuRight.style.left = event.clientX + 'px';
		}
	}
	
	//复制节点
	function copyNode() {
		document.getElementById('treeMenu').style.display = "none";
		
		var zTree = $.fn.zTree.getZTreeObj("classifyTreeDemo"),
		nodes = zTree.getSelectedNodes();
		if (nodes.length == 0) {
			alert("请先选择一个节点");
			return;
		}
		
		pasteNodes = nodes[0];
	}

	//粘贴节点
	function pasteNode() {
		document.getElementById('treeMenu').style.display = "none";
		
		if(!pasteNodes){
			layer.alert('请先选择一个节点进行复制！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
				  title:"提示"
				}
			);
		}
		else if (pasteNodes === currentNode) {
			layer.alert('不能复制，源节点 与 目标节点相同！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
				  title:"提示"
				}
			);
		}
		else{
			var ids = [];
			ids.push(pasteNodes.id);
			ids.push(currentNode.id);
			
			$.ajax({
				 url:'assets/device/nationalclassify/nationalClassifyController/operation/paste',
				 data:	JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 var zTree = $.fn.zTree.getZTreeObj("classifyTreeDemo");
						 var fatherNodeList = new Array();
						 fatherNodeList[0] = currentNode;
							
						 var nodeJson = r.newNodesJson;
						 nodeJson = JSON.parse(nodeJson);
						 var treeNode;
						 for(var i = 0; i<nodeJson.length; i++){
							//获取节点父节点
							for(var j = 0; j<fatherNodeList.length; j++){
								if(nodeJson[i].pId == fatherNodeList[j].id){
									treeNode = fatherNodeList[j];
									
									//在相应父节点下创建子节点
									treeNode = zTree.addNodes(treeNode, {id: nodeJson[i].id, pId: nodeJson[i].pId, isParent:false, name: nodeJson[i].name, treePath:nodeJson[i].treePath});
									treeNode = treeNode[0];
									
									fatherNodeList = fatherNodeList.slice(0, j+1);
									fatherNodeList[j+1] = treeNode;
									
									//将通过复制创建的节点的根节点设置为选择状态
									if(i == 0){
										zTree.selectNode(treeNode);
									}
									
									break;
								}
							}
						 }
					 }
					 else{
						layer.alert('复制失败！' + r.error, {
							  icon: 7,
							  area: ['400px', ''],
							  closeBtn: 0,
							  btn: ['关闭'],
		                      title:"提示"
							}
						);
					 }
				 }
			 });
		}
	}
	
	function goAddNode(){
		showElement('addNodeDiv', '100', '400')
		document.getElementById('treeMenu').style.display = "none";
		
		document.getElementById('parentid').value = currentNode.id;
		document.getElementById('treePath').value = currentNode.treePath;
		document.getElementById('fatherNum').value = currentNode.itemNum;
	}
	
	function addNode(e) {
		document.getElementById("itemNum").value = document.getElementById("fatherNum").value + document.getElementById("sonNum").value;
		document.getElementById("fatherNum").value = currentNode.itemNum;

		$.ajax({
			 url:"assets/device/nationalclassify/nationalClassifyController/operation/save",
			 data : {data :JSON.stringify($("#form").serializeObject())},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					 var zTree = $.fn.zTree.getZTreeObj("classifyTreeDemo");
					 var treeNode = currentNode;
					 var nodeName = document.getElementById('name').value;
						
					 //添加子节点
					 if (treeNode) {
					 	 treeNode = zTree.addNodes(treeNode, {id:r.id, pId:treeNode.id, isParent:false, name:nodeName, treePath:currentNode.treePath});
					 } 
					 //添加根节点
					 else {
						 treeNode = zTree.addNodes(null, {id:r.id, pId:0, isParent:false, name:nodeName});
					 }
					 
					 zTree.selectNode(treeNode[0]);
					 document.getElementById('addNodeDiv').style.display = "none";
				 }
				 else{
					 alert('保存失败！' + r.error);
				 } 
			 }
		 });
	};
	
	function deleteNode() {
		document.getElementById('treeMenu').style.display = "none";
		zTree.selectNode(currentNode);
		
		if((currentNode != null) && (currentNode != undefined)){
			layer.confirm('确认要删除选中的数据吗?',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
					 var ids = [];
					 ids.push(currentNode.id);
					 
					 $.ajax({
						 url:'assets/device/nationalclassify/nationalClassifyController/operation/delete',
						 data:	JSON.stringify(ids),
						 contentType : 'application/json',
						 type : 'post',
						 dataType : 'json',
						 success : function(r){
							 if (r.flag == "success") {
								 var zTree = $.fn.zTree.getZTreeObj("classifyTreeDemo");
								 var callbackFlag = $("#callbackTrigger").attr("checked");
								 zTree.removeNode(currentNode, callbackFlag);
									
								 currentNode = null;
							 }
							 else{
								layer.alert('删除失败：' + r.error, {
									  icon: 7,
									  area: ['400px', ''],
									  closeBtn: 0,
									  btn: ['关闭'],
				                      title:"提示"
									}
								);
							 }
						 }
					 });
					 layer.close(index);
				});   
		}else{
		    layer.alert('请选择要删除的数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
				  title:"提示"
				}
			);
		}
	};
	
	function addCollect(e) {
		document.getElementById('treeMenu').style.display = "none";
		$.ajax({
			 url:"assets/device/usercollect/userCollectController/operation/save",
			 data : {data : '{"nodeId":"' + currentNode.id + '","nodePid":"' + currentNode.pId + '","nodeTreepath":"' + currentNode.treePath + '","itemNum":"' + currentNode.itemNum + '"}'},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					 var zTree = $.fn.zTree.getZTreeObj("classifyTreeDemo");
					 var treeNode = zTree.getNodes()[0];

					 //添加子节点
					 treeNode = zTree.addNodes(treeNode, {id:(currentNode.id + '-1'), pId:'MyCollect-1', isParent:false, name:currentNode.name, treePath:currentNode.treePath, itemNum:currentNode.itemNum});
					 zTree.selectNode(treeNode[0]);
				 }
				 else{
					 layer.alert('收藏失败：' + r.error, {
						  icon: 7,
						  area: ['400px', ''],
						  closeBtn: 0,
						  btn: ['关闭'],
	                      title:"提示"
						}
					);
				 } 
			 }
		 });
	};
	
	function deleteCollect(e) {
		document.getElementById('treeMenu').style.display = "none";
		$.ajax({
			 url:"assets/device/usercollect/userCollectController/operation/delete",
			 data : {nodeId : currentNode.id},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					 var zTree = $.fn.zTree.getZTreeObj("classifyTreeDemo");

					 //删除节点
					 var callbackFlag = $("#callbackTrigger").attr("checked");
					 zTree.removeNode(currentNode, callbackFlag);
				 }
				 else{
					 layer.alert('取消收藏失败：' + r.error, {
						  icon: 7,
						  area: ['400px', ''],
						  closeBtn: 0,
						  btn: ['关闭'],
	                      title:"提示"
						}
					);
				 } 
			 }
		 });
	};
	
	function orignPath(e) {
		document.getElementById('treeMenu').style.display = "none";
		var zTree = $.fn.zTree.getZTreeObj("classifyTreeDemo");
		var nodes = zTree.getNodes();
		var selectNodes = zTree.getSelectedNodes();
		var treePath = selectNodes[0].treePath;
		
		 //展开节点
		 var callbackFlag = $("#callbackTrigger").attr("checked");
		 for (var i=0; i<nodes.length;) {
			 zTree.setting.view.fontCss = {};
			 if(treePath.indexOf(nodes[i].id) != -1){
				 zTree.expandNode(nodes[i], true, null, null, callbackFlag);
				 console.log(nodes[i].id);
				 
				 if((nodes[i].id+'-1') == selectNodes[0].id){
					 console.log(nodes[i].id+'-1');
					 zTree.selectNode(nodes[i]);
					 break;
				 }

				 nodes = nodes[i].children;
				 if(nodes == null){
					 break;
				 }
				 i = 0;
			 }
			 else{
				 i++;
			 }
		 }
	};
	
	function upDownNode(moveType) {
		document.getElementById('treeMenu').style.display = "none";
		
		var zTree = $.fn.zTree.getZTreeObj("classifyTreeDemo");
		var nodes = zTree.getSelectedNodes();
		
		var targetNode = null;
		if(moveType == 'prev'){
			targetNode = nodes[0].getPreNode();
		}
		else if(moveType == 'next'){
			targetNode = nodes[0].getNextNode();
		}
		
		//顶部节点不可上移，底部节点不可下移
		if(targetNode == null){
			return;
		}
		
		$.ajax({
			 url:"assets/device/usercollect/userCollectController/operation/upDownNode",
			 data : {
				 		sourceId : nodes[0].id,
				 		targetId : targetNode.id,
				 	},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					 //移动节点
					 zTree.moveNode(targetNode, nodes[0], moveType, false);
				 }
				 else{
					 layer.alert('节点上下移失败：' + r.error, {
						  icon: 7,
						  area: ['400px', ''],
						  closeBtn: 0,
						  btn: ['关闭'],
	                      title:"提示"
						}
					);
				 } 
			 }
		 });
	};
	
	function editName() {
		document.getElementById('treeMenu').style.display = "none";
		
		var zTree = $.fn.zTree.getZTreeObj("classifyTreeDemo");
		var nodes = zTree.getSelectedNodes();
		zTree.editName(nodes[0]);
	};
	
	function beforeRename(treeId, treeNode, newName){
		$.ajax({
			 url:"assets/device/usercollect/userCollectController/operation/editNodeName",
			 data : {
				 		nodeId : treeNode.id,
				 		newName : newName,
				 	},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag != "success"){
					 layer.alert('名称修改失败：' + r.error, {
						  icon: 7,
						  area: ['400px', ''],
						  closeBtn: 0,
						  btn: ['关闭'],
	                      title:"提示"
						}
					);
				 } 
			 }
		 });
	}

	var zNodes = ${classifyTree};
	// var zNodes = [{"id":"0zujqor261","itemNum":"1030400","name":"烟囱","pId":"ts7gdlin28","treePath":"ts7gdlin28,0zujqor261"}]
	var zTree, treeMenu;
	$(document).ready(function() {
		//重新初始化菜单树
		$.fn.zTree.init($("#classifyTreeDemo"), setting, zNodes);
		zTree = $.fn.zTree.getZTreeObj("classifyTreeDemo");
        treeMenu = $("#treeMenu");
		
		//初始化查询
		fuzzySearch('classifyTreeDemo','#classifyKey',null,true);
	});
</script>

<BODY>
	<!-- 页面主体-->
	<div style='background-color:#F2F2F2; height:965px;'>
		<!-- 左侧菜单树 -->
		<div id="left_tree" style="float:left; width: 10.5%; background-color:#FFFFFF; margin-top:5px;">
			<p style="margin-top:5px; height:25px">
				<input autocomplete='on' class='inputText' style='position:absolute; margin-left:4px; display:inline-block;
					width: 10%; height:24px; border:1px solid #bbb; color:gray; -webkit-border-radius:3px; font-style:font-style;
					font-size:13px;' id='classifyKey' placeholder='请输入搜索关键字'/>
				<img style='position:absolute; top:15px; left: 9%; width:20px;height:20px;' src='avicit/assets/device/nationalclassify/rightmenu/icon042.gif' >
			</p>
			<ul id="classifyTreeDemo" class="ztree" style='width: 98%; margin-top:4px; height:920px;'></ul>
		</div>
		
		<!-- 台账列表内容 -->
		<div id="main_frame" style='width: 89%; height:100%; background-color:#FFFFFF; float:left; margin-left:5px; margin-top:5px;'>
			<iframe name="assetsDeviceAccountManageIframe" id="assetsDeviceAccountManageIframe" src="assets/device/assetsdeviceaccount/assetsDeviceAccountController/toAssetsDeviceAccountManage" frameborder="0" align="left" width="100%" height="100%" scrolling="no">
			</iframe>
		</div>
	</div>




	<!-- 鼠标右键菜单 -->
	<div id="treeMenu" style='width: 100px; position: absolute; display: none;'>
	    <div id='rMenuDetail'>
			<div style='display: block; width: 100px'>
				<div style='width: 19px; height:20px; float:left; background-color: #C9C9C9'></div>
				<div style='width: 100px; height:20px; background-color: #DCDCDC' onclick="goAddNode();">&nbsp;&nbsp;新增</div>
			</div>
			<div style='display: block; width: 100px'>
				<div style='width: 19px; height:20px; float:left; background-color: #C9C9C9'></div>
				<div style='width: 100px; height:20px; background-color: #DCDCDC' onclick="copyNode();">&nbsp;&nbsp;复制</div>
			</div>
			<div style='display: block; width: 100px'>
				<div style='width: 19px; height:20px; float:left; background-color: #C9C9C9'></div>
				<div style='width: 100px; height:20px; background-color: #DCDCDC' onclick="pasteNode();">&nbsp;&nbsp;粘贴</div>
			</div>
			<div style='display: block; width: 100px'>
				<div style='width: 19px; height:20px; float:left; background-color: #C9C9C9'></div>
				<div style='width: 100px; height:20px; background-color: #DCDCDC' onclick="deleteNode();">&nbsp;&nbsp;删除</div>
			</div>
			<div style='display: block; width: 100px'>
				<div style='width: 19px; height:20px; float:left; background-color: #C9C9C9'></div>
				<div style='width: 100px; height:20px; background-color: #DCDCDC' onclick="addCollect();">&nbsp;&nbsp;收藏</div>
			</div>
			<div style='display: block; width: 100px'>
				<div style='width: 19px; height:20px; float:left; background-color: #C9C9C9'></div>
				<div style='width: 100px; height:20px; background-color: #DCDCDC' onclick="deleteCollect();">&nbsp;&nbsp;取消收藏</div>
			</div>
			<div style='display: block; width: 100px'>
				<div style='width: 19px; height:20px; float:left; background-color: #C9C9C9'></div>
				<div style='width: 100px; height:20px; background-color: #DCDCDC' onclick="orignPath();">&nbsp;&nbsp;原路径</div>
			</div>
			<div style='display: block; width: 100px'>
				<div style='width: 19px; height:20px; float:left; background-color: #C9C9C9'></div>
				<div style='width: 100px; height:20px; background-color: #DCDCDC' onclick="upDownNode('prev');">&nbsp;&nbsp;上移</div>
			</div>
			<div style='display: block; width: 100px'>
				<div style='width: 19px; height:20px; float:left; background-color: #C9C9C9'></div>
				<div style='width: 100px; height:20px; background-color: #DCDCDC' onclick="upDownNode('next');">&nbsp;&nbsp;下移</div>
			</div>
			<div style='display: block; width: 100px'>
				<div style='width: 19px; height:20px; float:left; background-color: #C9C9C9'></div>
				<div style='width: 100px; height:20px; background-color: #DCDCDC' onclick="editName();">&nbsp;&nbsp;修改名称</div>
			</div>
		</div>
	</div>
	
	<!-- 编辑指南 -->
	<div id="addNodeDiv" style='width: 400px; position: absolute; border:2.5px solid #F2F2F2; display: none; background-color:#FFFFFF;'>
		<p style='margin-top:5px; height:25px; font-family:微软雅黑; font-weight:bold; color:#3399FF; margin-left:5px; border-bottom:1px solid #E9E9E9;'>添加节点</p>
    	<div data-options="region:'center',split:true,border:false" style='width:350px;'>
			<form id='form'>
				<input type="hidden" name="id" id="id"/>
				<input type="hidden" name="parentid" id="parentid"/>
				<input type="hidden" name="treePath" id="treePath"/>
				<input type="hidden" name="itemNum" id="itemNum" />
				<input type="hidden" name="isvalid" id="isvalid" value="Y"/>
						
				<table class="form_commonTable">
					<tr>
						<th width="30%"><label for="fatherNum">节点名称:</label></th>
						<td width="70%"><input class="form-control input-sm" type="text" name="name" id="name" /></td>
					</tr>
					<tr>
						<th width="30%"><label for="isvalid">节点编号:</label></th>
						<td width="70%">
							<input type="text" name="fatherNum" id="fatherNum" style='width: 80px; height: 30px;'/>—
							<input type="text" name="sonNum" id="sonNum" style='width: 80px; height: 30px;'/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="height: 60px;">
			<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
				<table class="tableForm" style="border: 0; cellspacing: 1; width: 100%">
					<tr>
						<td width="50%" style="padding-right: 4%;" align="right">
							<a onclick="addNode()" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"title="保存">保存</a> 
							<a onclick="hiddenElement('addNodeDiv')" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回">返回</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</BODY>
</html>