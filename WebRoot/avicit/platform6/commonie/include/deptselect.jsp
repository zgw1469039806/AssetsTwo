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
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro-ie6.css" />

<link rel="stylesheet" type="text/css" href="static/fixie/bsie/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="static/fixie/bsie/bootstrap/css/bootstrap-ie6.css">
<link rel="stylesheet" type="text/css" href="static/fixie/bsie/bootstrap/css/ie.css">

<style>
	.userviewkads {
	    color: #454545;
	    background: #FFF;
	    height: auto;
	    padding: 0 5px;
	    line-height: 30px;
	    border-bottom:1px solid #b9b9b9;
	}
	.userviewkads div {
		display: inline-block;
		*display: inline;
		*zoom: 1;
	}
</style>
</head>
<body class=" easyui-layout" fit="true">
	<div data-options="region:'north'" style="height:40px;margin-right: 5px;">
	<div id="tools" class="datagrid-toolbar">
				<table width="99%">
					<tr>
						<td>
							<div class="ext-toolbar-left">
								<div class="input-group  input-group-sm">
							      <input  class="form-control" placeholder="输入部门名称查询" type="text" id="search_text" name="search_text"  onkeyup="onSeach(event.keyCode, this.value)">
							      <span class="input-group-btn">
							        <button class="btn btn-default" style="padding:2px 8px;" type="button" onclick="onSeach(13, $('#search_text').val())"><span class="icon-xxx icon-search"></span></button>
							      </span>
							    </div>
							</div>
							<div class="ext-toolbar-right">
								<table  style="width:160px;margin-top:2px;float: right;">
									<tr>
									<td style="width:30px;">
										<button type="button" onclick="removeAllDept();" aria-label="清空" class="btn btn-default" style="padding:3px 5px">
									  	<span class="icon icon-trash"></span>
										</button>
									</td>
									<td class="isShowVoid" style="text-align:right;">
										<input id="viewSystemDept" class="toolbox input-checkbox" type="checkbox">
									</td>
									<td class="isShowVoid">
										&nbsp;显示无效部门
									</td>
									 </tr>
								</table>
							</div>
						</td>
					</tr>
			</table>
		</div>
	</div>
	<div data-options="region:'west',split:false,collapsible:false" style="width:250px;">
		<div class="row" style="margin: 5px;">
			
			<div id='mdiv' style="overflow:auto;">
				<ul id="selectDeptTree" class="ztree" style="height: 100%;overflow-x: hidden;"></ul>
			</div>
		</div>
	</div>
	<div data-options="region:'center',title:'已选择部门'">
		<div id="platform-deptselect-userview" class="row" style="width:100%;">
		</div>
	</div>
<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js"></script>
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
	var isShowVoid = false;
	function init(o){
		isShowVoid = o.isShowVoid;
		viewScope = o.viewScope;
		defaultOrgId = o.defaultOrgId;
		defaultLoadDeptId = o.defaultLoadDeptId;
		deptLevel = o.deptLevel;
		var selectModel = o.selectModel;
		var deptidArrays = ((o.deptids == null || o.deptids == '')?[]:o.deptids.split(";"));
		if(selectModel == 'multi'){
			isShowChebox = true;
		}
		if(isShowVoid){
			$(".isShowVoid").hide();
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
									h5KadsView.add(childNodes[i].id, [childNodes[i].id, childNodes[i].text, childNodes[i].orgIdentity]);
									break;
								}
							}else{
								if(parentNode !=null && parentNode.checked == true){
									childNodes[i].checked = true;
									if(h5KadsView != null){ 
										h5KadsView.add(childNodes[i].id, [childNodes[i].id, childNodes[i].text, childNodes[i].orgIdentity]);
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
				onAsyncError:  function(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown){ layer.alert(XMLHttpRequest);},
				onAsyncSuccess:  function(event, treeId, treeNode, msg){
					var tree = $.fn.zTree.getZTreeObj(treeId);
					if (firstAsyncSuccessFlag2 == 0) {
						var nodes = tree.getNodes();  
		                 tree.expandNode(nodes[0], true);  
		                 firstAsyncSuccessFlag2 = 1;   
					}
					if(typeof(treeNode)!="undefined" && typeof(treeNode.checked)!="undefined"&& treeNode.checked == true){
						tree.checkNode(treeNode, true, true, true);
					} 
				},
				onClick: function (event, treeId, treeNode){
					if(treeNode.nodeType == "dept"){
						h5KadsView.add(treeNode.id, [treeNode.id,treeNode.text, treeNode.orgIdentity]);
						if(isShowChebox){
							treeNode.checked = true;
							$.fn.zTree.getZTreeObj(treeId).updateNode(treeNode); 
						}
					}
				},
				onCheck: function (event, treeId, treeNode) {
					if(treeNode.nodeType == "dept" ){
						if(treeNode.checked){
							h5KadsView.add(treeNode.id, [treeNode.id,treeNode.text, treeNode.orgIdentity]);
						}else{
							if(h5KadsView.getDataList().length > 0){
								h5KadsView.remove(treeNode.id);
							}
						}
					}
					if(treeNode.isParent == true && treeNode.children.length == 0){
						 var tree = $.fn.zTree.getZTreeObj(treeId);
		                 tree.expandNode(treeNode, true);
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
				return '<div class="alert-info userviewkads" data=\'{\"id\":\"#0#\", \"name\": \"#1#\", \"orgIdentity\": \"#2#\"}\' id=\"kads_#0#\">'+
						    '<div style="width:90%">#1#</div><div style="width:10%"><span class="icon icon-remove" aria-hidden="true"  style="cursor:pointer" onclick="h5KadsView.remove(\'#0#\');"></span><div>'+
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
	  				h5KadsView.add(r[i].id, [r[i].id, r[i].name, r[i].orgIdentity]);
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
				viewSystemDeptValue = true;
			}else{
				viewSystemDeptValue = false;
			}
			firstAsyncSuccessFlag2 = 0;
			$.fn.zTree.init($("#selectDeptTree"),setting, []);
			$("search_text").val();
			//h5KadsView.removeAll();
	    });

	};

	function getDeptList(){
		var deptids = "";
		var deptnames = "";
		var orgIdentitys = ""
		
		var deptlist = h5KadsView.getDataList();
		for(var i = 0;  i< deptlist.length; i ++ ){
			deptids = deptids + deptlist[i].id + ";";
			deptnames = deptnames + deptlist[i].name + ";";
			orgIdentitys = orgIdentitys + deptlist[i].orgIdentity+ ";";
		}
		deptids = deptids.substring(0, deptids.length-1);
		deptnames = deptnames.substring(0, deptnames.length-1);
		return {deptids: deptids, deptnames: deptnames , orgIdentitys: orgIdentitys};
	}

	function onSeach(ecode, value){
		if(ecode == 13){
			if($("#viewSystemDept").attr("checked") == "checked"){
				viewSystemDeptValue = true;
			}else{
				viewSystemDeptValue = false;
			}
			if(value==null||value==""||value=="输入部门名称查询"){
				firstAsyncSuccessFlag2 = 0;
				$.fn.zTree.init($("#selectDeptTree"),setting, []);
        		return;
        	}
        	$.ajax({
                cache: true,
                type: "post",
                url: "h5/view/common/select/SelectController/searchDept",
                dataType:"json",
                data:{
                	"search_text":value,
                	"selectedDept": JSON.stringify(h5KadsView.getDataList()),
                	"viewSystemDept":viewSystemDeptValue,
					"defaultLoadDeptId":defaultLoadDeptId,
					"deptLevel": deptLevel,
					"viewScope" : viewScope,
					"defaultOrgId" : defaultOrgId
                },
                async: false,
                error: function(request) {
                	throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
                },
                success: function(data) {
                	$.fn.zTree.init($("#selectDeptTree"), {
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
            					enable: false,
            					idKey: "id",
            					pIdKey: "parentId",
            					rootPId: -1
            				}
            			},callback: {
            				onClick: function (event, treeId, treeNode){
        						if(treeNode.nodeType == "dept"){
        							h5KadsView.add(treeNode.id, [treeNode.id, treeNode.text, treeNode.orgIdentity]);
        							if(isShowChebox){
        								treeNode.checked = true;
        								 $.fn.zTree.getZTreeObj(treeId).updateNode(treeNode); 
        							}
        						}
        					},
        					onCheck: function (event, treeId, treeNode) {
        						if(treeNode.nodeType == "dept" ){
        							if(treeNode.checked){
        								h5KadsView.add(treeNode.id, [treeNode.id, treeNode.text, treeNode.orgIdentity]);
        							}else{
        								if(h5KadsView.getDataList().length > 0){
        									h5KadsView.remove(treeNode.id);
        								}
        							}
        						}
        					}
        				}
            			
            		}, data);
                }
            });
		}
	};
	
	function removeAllDept (){
		$("search_text").val();
		h5KadsView.removeAll();
	};
</script>
</body>
</html>
