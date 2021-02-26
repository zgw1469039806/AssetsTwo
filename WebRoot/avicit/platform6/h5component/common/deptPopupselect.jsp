<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,tree,form";	
%>
<!DOCTYPE html>
<html>
<head>
<title>部门选择</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css-fixie8-fonticon.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeviewmin-fixie8.css"/>
</head>
<body class=" easyui-layout" fit="true">
	<div data-options="region:'center',split:false,collapsible:false" style="width:250px;">
		<div class="row" style="margin: 5px;">
			<div>
				<ul id="selectDeptTree" class="ztree"></ul>
			</div>
		</div>
	</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script>
	var h5KadsView = null;
	var setting = null;
	var firstAsyncSuccessFlag2 = 0;
	var isShowChebox = false;
	var viewSystemDeptValue = false;
	var defaultLoadDeptId;
	var deptLevel;
	var viewScope = "";
	var defaultOrgId = "";
	function init(o){
		viewScope = o.viewScope;
		defaultOrgId = o.defaultOrgId;
		defaultLoadDeptId = o.defaultLoadDeptId;
		deptLevel = o.deptLevel;
		var selectModel = o.selectModel;
		var deptidArrays = ((o.deptids == null || o.deptids == '')?[]:o.deptids.split(";"));
		
		if(selectModel == 'multi'){
			isShowChebox = true;
		}
		
		setting = {
			view: {
				selectedMulti: false
			},
			check: {
				autoCheckTrigger:true,
				enable: isShowChebox
			},
			data: {
				key: {
					id: "id",
					name: "text",
					children: "children"
				},
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "parentId",
					rootPId: -1
				}
			},
			async: {
				enable: true,
				url:"h5/view/common/select/SelectController/getDeptSelectList",
				autoParam:["id","nodeType","orgId"],
				otherParam: {
					"viewSystemDept":function(){ return viewSystemDeptValue; },
					"defaultLoadDeptId":defaultLoadDeptId,
					"deptLevel": deptLevel,
					"viewScope" : viewScope,
					"defaultOrgId" : defaultOrgId
					},
				dataFilter: function(treeId, parentNode, childNodes){
					 if (!childNodes)
			            return null;
			        var childNodes = eval(childNodes);
			      //start
			        var deptlist = getDeptList();
					if(deptlist.deptids!=""){
						deptidArrays = deptlist.deptids.split(';');
					}
					//end
					for(var i = 0; i < childNodes.length; i++){
						for(var j = 0; j < deptidArrays.length; j++){
							if(childNodes[i].id == deptidArrays[j] ){
								childNodes[i].checked = true;
								if(h5KadsView != null){ 
									h5KadsView.add(childNodes[i].id, [childNodes[i].id, childNodes[i].text]);
									break;
								}
							}else{
								if(parentNode !=null && parentNode.checked == true){
									childNodes[i].checked = true;
									if(h5KadsView != null){ 
										h5KadsView.add(childNodes[i].id, [childNodes[i].id, childNodes[i].text]);
										break;
									}
								}
							}
						}
					}
			        return childNodes;
				}
			},
			callback: {
				onAsyncError:  function(){alert("加载失败！");},
				onAsyncSuccess:  function(event, treeId,treeNode, msg){
					var tree = $.fn.zTree.getZTreeObj(treeId);
					if (firstAsyncSuccessFlag2 == 0) {
		                 var nodes = tree.getNodes();  
		                 tree.expandNode(nodes[0], true);  
		                 firstAsyncSuccessFlag2 = 1;   
					}
					/*if(msg != undefined){
						var arr = msg.children;
						for(var i = 0; i < arr.length; i++){
							if($.inArray(arr[i].id, deptidArrays)==-1){
								arr[i].checked = false;
								tree.updateNode(arr[i]); 
							}
						}
					} */
					if(typeof(treeNode)!="undefined" && typeof(treeNode.checked)!="undefined"&& treeNode.checked == true){
						tree.checkNode(treeNode, true, true, true);
					}
					
				},
				onClick: function (event, treeId, treeNode){
					if(treeNode.nodeType == "dept"){
						h5KadsView.add(treeNode.id, [treeNode.id,treeNode.text]);
						if(isShowChebox){
							treeNode.checked = true;
							$.fn.zTree.getZTreeObj(treeId).updateNode(treeNode); 
						}else{
							 parent.setSelectedInfo(treeNode);
						}
						
					}
				},
				onCheck: function (event, treeId, treeNode) {
					if(treeNode.nodeType == "dept" ){
						if(treeNode.checked){
							h5KadsView.add(treeNode.id, [treeNode.id,treeNode.text]);
						}else{
							if(h5KadsView.getDataList().length > 0){
								h5KadsView.remove(treeNode.id);
							}
						}
					}
				}
			}
			
		};
	
		firstAsyncSuccessFlag2 = 0;
		$.fn.zTree.init($("#selectDeptTree"),setting, []);
		h5KadsView = new H5KadsView({
			id:'#platform-deptselect-userview',
		    selectModel: selectModel,
		    beferRemove: function(id){
		    	try{
		    	var tree = $.fn.zTree.getZTreeObj("selectDeptTree");
		    	if(id != "all"){
		    		var node = tree.getNodesByParam("id", id , null);
		    		node[0].checked = false;
		    		tree.updateNode(node[0]); 
		    	}}catch(e){}
		    },
		    afertRemove: function(){
		    	var tree = $.fn.zTree.getZTreeObj("selectDeptTree");
	    		if(h5KadsView.getDataList().length == 0){
	    			tree.checkAllNodes(false);
				}
		    },
		    template : function(){
				return '<div class="col-xs-12 alert-info userviewkads" data=\'{\"id\":\"#0#\", \"name\": \"#1#\"}\' id=\"kads_#0#\">'+
						    '<div class="col-xs-11">#1#</div><div class="col-xs-1"><span class="glyphicon glyphicon-remove" aria-hidden="true"  style="cursor:pointer" onclick="h5KadsView.remove(\'#0#\');"></span><div>'+
						    '</div>';
		    	
			}
		});
	    
		$.ajax({
	  		 url  : "h5/view/common/select/SelectController/getInitDeptInfo",
	  		 data : {"deptids": JSON.stringify(deptidArrays)},
	  		 type : 'post',
	  		 dataType : 'json',
	  		 success : function(r){
	  			for(var i = 0; i < r.length; i++){
	  				h5KadsView.add(r[i].id, [r[i].id,r[i].name]);
	  			}
	  	 	 }
		});


		$('.toolbox').on('change', function() {
	        if ($(this).is(':checked')) {
	            //$(this).siblings(".st").addClass('on');
	            $(this).attr("checked", true);
	        } else {
	            //$(this).siblings(".st").removeClass('on');
	            $(this).attr("checked", false);
	        }
			if($("#viewSystemDept").attr("checked") == "checked"){
				viewSystemDept = true;
			}else{
				viewSystemDept = false;
			}
			firstAsyncSuccessFlag2 = 0;
			$.fn.zTree.init($("#selectDeptTree"),setting, []);
			$("search_text").val();
			h5KadsView.removeAll();
	    });

	};

	function getDeptList(){
		var deptids = "";
		var deptnames = "";
		if(h5KadsView!=null){
			var deptlist = h5KadsView.getDataList();
			for(var i = 0;  i< deptlist.length; i ++ ){
				deptids = deptids + deptlist[i].id + ";";
				deptnames = deptnames + deptlist[i].name + ";";
			}
			deptids = deptids.substring(0, deptids.length-1);
			deptnames = deptnames.substring(0, deptnames.length-1);
			return {deptids: deptids, deptnames: deptnames }; 
		}else{
			return {};
		}
	}
	
	function removeAllDept (){
		$("search_text").val();
		h5KadsView.removeAll();
	};
</script>
</body>
</html>
