<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
String importlibs = "common,table,tree,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>组织选择</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeviewmin-fixie8.css"/>
<link rel="stylesheet" type="text/css" href="avicit/platform6/h5component/common/commonselect.css"/>

<style type="text/css">
	.checkbox-title-multi {
		padding-left: 4px;
		vertical-align: middle;
	}
</style>
</head>
<body class=" easyui-layout" fit="true">
	<div data-options="region:'west',split:false,collapsible:false" style="width:359px;overflow: hidden;">
		<div class="row"  style="margin-right: 5px;">
			<div  class="col-xs-6">
				<div class="input-group  input-group-sm" style="width:332px;padding-top:5px;">
					<input  class="form-control" placeholder="输入组织名称查询" type="text" id="search_text" name="search_text"  onkeyup="onSeach(event.keyCode, this.value)">
					<span class="input-group-btn">
			        <button class="btn btn-default" type="button" onclick="onSeach(13, $('#search_text').val())"><span class="glyphicon glyphicon-search"></span></button>
			      </span>
				</div>
			</div>
		</div>
		<div id='mdiv' style="height: 90%; width: 100%;">
			<ul id="selectDeptTree" class="ztree" style='overflow: auto;height: 100%; width: 100%;'></ul>
		</div>
	</div>
	<div data-options="region:'center',split:false" style="overflow: hidden;padding:0 14px;">
		<div id="tableToolbarCenter" class="toolbar">
			<div class="toolbar-left selected-check-all">
				<input type="checkbox" id="selectedCheckAll" title="全选" />
				<span id="selectedCheckboxTitle" class="role-checkbox-title">已选组织</span>
				<span id="selectedPanelTitle" class="selected-panel-title"></span>
			</div>
			<div class="toolbar-right role-delete-all">
				<label id="selectedDeleteAll" class="glyphicon glyphicon-trash" title="删除选中"></label>
			</div>
		</div>
		<table id="jqGridSelected"></table>
	</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="static/js/platform/eform/widget.js"></script>
<script src="static/js/platform/eform/mouse.js"></script>
<script src="static/js/platform/eform/sortable.js"></script>
<script src="static/js/platform/eform/jquery-ui.min.js"></script>
<script>
	var h5KadsView = null;
	var setting = null;
	var firstAsyncSuccessFlag2 = 0;
	var isShowChebox = false;
	var viewScope = "";
	var defaultOrgId = "";
    var defaultLoadOrgId = null;
	var callBack = null;
	var setPropertys = null;
	function init(o){
		viewScope = o.viewScope;
		defaultOrgId = o.defaultOrgId;
        defaultLoadOrgId = o.defaultLoadOrgId;
		var selectModel = o.selectModel;
		var orgidArrays = [];
		if (o.orgids&&o.orgids.indexOf(",")>-1){
			orgidArrays = ((o.orgids == null || o.orgids == '')?[]:o.orgids.split(","));
		}else{
			orgidArrays = ((o.orgids == null || o.orgids == '')?[]:o.orgids.split(";"));
		}

		if(selectModel == 'multi'){
			isShowChebox = true;
			$("#selectedCheckboxTitle").addClass("checkbox-title-multi");
		} else {
			$("#selectedCheckboxTitle").addClass("checkbox-title-single");
			$("#selectedCheckAll").hide();
			$("#selectedPanelTitle").hide();
		}
		callBack = o.callBack;
		setPropertys = o.setPropertys;
		setting = {
			view: {
				selectedMulti: false
			},
			check: {
				autoCheckTrigger:true,
				chkboxType: {"Y":"s", "N":"s"},
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
				url:"h5/view/common/select/SelectController/getOrgSelectList",
				autoParam:["id","nodeType","orgId"],
				otherParam: {
					"viewScope" : viewScope,
					"defaultLoadOrgId": defaultLoadOrgId,
					"defaultOrgId" : defaultOrgId
				},
				dataFilter: function(treeId, parentNode, childNodes){
					if (!childNodes)
			            return null;
			        var childNodes = eval(childNodes);
			        //start
			        var orglist = getOrgList();
					if(orglist.orgids!=""){
						if (orglist.orgids.indexOf(",")>-1){
							orgidArrays = orglist.orgids.split(',');
						}else {
							orgidArrays = orglist.orgids.split(';');
						}
					}
					//end
					for(var i = 0; i < childNodes.length; i++) {
						for(var j = 0; j < orgidArrays.length; j++){
							if(childNodes[i].id == orgidArrays[j] ){
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
					if(isShowChebox){
						// 多选时触发节点的onCheck事件
						// if(treeNode.nodeType == "dept") {
						// 	$.fn.zTree.getZTreeObj(treeId).checkNode(treeNode, !treeNode.checked, true, true);
						// }
					} else {
						if(treeNode.nodeType == "org"){
							addToSelectedOrg(treeNode.id, treeNodeToRowData(treeNode));
						}
					}
				},
				onCheck: function (event, treeId, _treeNode) {
					if (_treeNode.checked) {
						var tree = $.fn.zTree.getZTreeObj(treeId);
						if (_treeNode.isParent == true && _treeNode.children.length == 0) {
							if (!_treeNode.open) {
								tree.expandNode(_treeNode, true);
								return false;
							}
						}
						handleCheckedCascade(treeId, _treeNode);
					} else {
						handleUncheckedCascade(treeId, _treeNode);
					}
				},
				onDblClick: function (event, treeId, _treeNode) {
					if (!isShowChebox && _treeNode.nodeType === 'org' && !_treeNode.isParent) {
						dbClick(_treeNode);
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
		    		tree.cancelSelectedNode(node[0]);
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
				return '<div class="col-xs-12 alert-info userviewkads" data=\'{\"id\":\"#0#\", \"name\": \"#1#\", \"orgIdentity\": \"#2#\"}\' id=\"kads_#0#\">'+
						    '<div class="col-xs-11">#1#</div><div class="col-xs-1"><span class="glyphicon glyphicon-remove" aria-hidden="true"  style="cursor:pointer" onclick="h5KadsView.remove(\'#0#\');"></span><div>'+
						    '</div>';
		    	
			}
		});
		$.ajax({
	  		 url  : "h5/view/common/select/SelectController/getInitOrgInfo",
	  		 data : {"orgids": JSON.stringify(orgidArrays)},
	  		 type : 'post',
	  		 dataType : 'json',
	  		 async: false,
	  		 success : function(r){
	  			// for(var i = 0; i < r.length; i++){
	  			// 	h5KadsView.add(r[i].id, [r[i].id, r[i].name, r[i].orgIdentity]);
	  			// }
				 initSelectedOrgInfo(r);
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
	    });

	};

	function getOrgList(){
		var orgids = "";
		var orgnames = "";
		var orgIdentitys = ""
		
		var orglist = $("#jqGridSelected").jqGrid('getRowData');
		for(var i = 0;  i< orglist.length; i ++ ){
			orgids = orgids + orglist[i].id + ";";
			orgnames = orgnames + orglist[i].name + ";";
			orgIdentitys = orgIdentitys + orglist[i].orgIdentity+ ";";
		}
		orgids = orgids.substring(0, orgids.length-1);
		orgnames = orgnames.substring(0, orgnames.length-1);
		return {orgids: orgids, orgnames: orgnames , orgIdentitys: orgIdentitys};
	}

	function dbClick(node) {
		var ret = {};
		ret.orgids = node.id;
		ret.orgnames = node.text;
		ret.orgIdentitys = node.orgIdentity;
		setPropertys(ret);
		if (callBack != null && callBack != 'undefined') {
			if (typeof (callBack) === 'function') {
				callBack(ret);
			}
		}
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		parent.layer.close(index);
	}

	function onSeach(ecode, value){
		if(ecode == 13){
			if($("#viewSystemDept").attr("checked") == "checked"){
				viewSystemDeptValue = true;
			}else{
				viewSystemDeptValue = false;
			}
			if(value==null||value==""){
				firstAsyncSuccessFlag2 = 0;
				$.fn.zTree.init($("#selectDeptTree"),setting, []);
        		return;
        	}
        	var ids = "";
        	for(var i = 0; i < h5KadsView.getDataList().length; i++){
        	  ids += h5KadsView.getDataList()[i].id;
        	  if(i < h5KadsView.getDataList().length - 1){
        	     ids +=";"
        	  }
        	}
        	$.ajax({
                cache: true,
                type: "post",
                url: "h5/view/common/select/SelectController/searchOrg",
                dataType:"json",
                data:{
                	"search_text":value,
                	"selectedOrg": ids,
					"viewScope" : viewScope,
					"defaultLoadOrgId":defaultLoadOrgId,
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
            				chkboxType: {"Y":"s", "N":"s"},
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
								if(isShowChebox){
									// 多选时触发节点的onCheck事件
									// if(treeNode.nodeType == "dept") {
									// 	$.fn.zTree.getZTreeObj(treeId).checkNode(treeNode, !treeNode.checked, true, true);
									// }
								} else {
									if(treeNode.nodeType == "org"){
										addToSelectedOrg(treeNode.id, treeNodeToRowData(treeNode));
									}
								}
							},
							onCheck: function (event, treeId, _treeNode) {
								if (_treeNode.checked) {
									var tree = $.fn.zTree.getZTreeObj(treeId);
									if (_treeNode.isParent == true && _treeNode.children.length == 0) {
										if (!_treeNode.open) {
											tree.expandNode(_treeNode, true);
											return false;
										}
									}
									handleCheckedCascade(treeId, _treeNode);
								} else {
									handleUncheckedCascade(treeId, _treeNode);
								}
							},
							onDblClick: function (event, treeId, _treeNode) {
								if (!isShowChebox && _treeNode.nodeType === 'org' && !_treeNode.isParent) {
									dbClick(_treeNode);
								}
							}
        				}
            			
            		}, data);
                }
            });
		}
	};
	
	function removeAllOrg (){
		$("search_text").val();
		h5KadsView.removeAll();
	};

	var dataGridColModelSelected = [{
		label: 'id',
		name: 'id',
		key: true,
		width: 75,
		hidden: true
	}, {
		label: '全选',
		name: 'title',
		width: 260,
		formatter: formatTitleSelected,
		classes: 'selected-title-col'
	}, {
		label: '组织名',
		name: 'name',
		width: 150,
		hidden: true
	}, {
		label: '组织应用ID',
		name: 'orgIdentity',
		width: 150,
		hidden: true
	}, {
		label: '操作',
		name: 'op',
		width: 60,
		//hidden: true,
		formatter: formatOp,
		classes: 'selected-op-col'
	}];

	function initSelectedOrgInfo(orgArray) {
		$('#jqGridSelected').jqGrid({
			colModel: dataGridColModelSelected,
			height: $(window).height() - 93,
			datatype: "local",
			rowNum: 10,
			pagerpos: 'left',
			hasColSet: false,
			hasTabExport: false,
			altRows: true,
			userDataOnFooter: true,
			loadonce: false,
			viewrecords: true,
			styleUI: 'Bootstrap',
			multiboxonly: false,
			multiselect: true,
			autowidth: !isShowChebox,
			//rownumbers: true,
			responsive: !isShowChebox,//开启自适应
			//onSelectRow: onSelectRow,//js方法
			//ondblClickRow: ondblClickRow,
			gridComplete: function () {
				//单选隐藏checkbox
				if (!isShowChebox) {
					$('#selectedCheckAll').hide();
					$("#jqGridSelected").jqGrid('hideCol', 'cb');
					$("#jqGridSelected").jqGrid('hideCol', 'op');
					$("#selectedCheckboxTitle").addClass("checkbox-title-single");
				} else {
					//$("#jqGridSelected").jqGrid('showCol', 'op');
					$("#selectedCheckboxTitle").addClass("checkbox-title-multi");
					$(".ui-jqgrid .ui-jqgrid-btable tbody tr.jqgrow td").css("padding-left", "0");
				}
				$("#jqGridSelected_title").hide();
				$("#jqGridSelected_op").hide();
				$("#jqGridSelected_cb").hide();
				$("#jqGridSelected td[role=\"gridcell\"]").attr("title", "");
			}
		});

		$.each(orgArray, function (index, value) {
			addToSelectedOrg(value.id, value);
		});
		resetSelectNum();

		//实现行拖拽
		$('#jqGridSelected').jqGrid('sortableRows');

		$('#selectedCheckAll').bind('click', function (e) {
			var checkStatus = $(e.target)[0].checked;
			var allIds = $("#jqGridSelected").getDataIDs();
			var selIds = $("#jqGridSelected").jqGrid('getGridParam', 'selarrrow');
			if (checkStatus) {
				for (var i = allIds.length - 1; i >= 0; i--) {
					if ($.inArray(allIds[i], selIds) == -1) {
						$("#jqGridSelected").setSelection(allIds[i], true);
					}
				}
			} else {
				for (var i = selIds.length - 1; i >= 0; i--) {
					$("#jqGridSelected").setSelection(selIds[i], true);
				}
			}

		});
		$('#selectedDeleteAll').bind('click', function () {
			removeAllSelect();
			$('#selectedCheckAll').attr("checked", false);
		});
	}

	function addToSelectedOrg(rowId, rowData) {
		// 单选模式下清空已选择
		if(!isShowChebox) {
			$.each($("#jqGridSelected").getDataIDs(), function (index, elem) {
				$("#jqGridSelected").delRowData(elem);
			});
		}
		var exist = false;
		var allIds = $("#jqGridSelected").getDataIDs();
		for (var i = 0, len = allIds.length; i < len; i++) {
			if (allIds[i] == rowId) {
				exist = true;
				break;
			}
		}
		if (!exist) {
			$("#jqGridSelected").addRowData(rowId, rowData);
			allIds.push(rowId);
		}
		resetSelectNum();
	}

	/**移除选中的组织并将左侧checkbox取消选中*/
	function deleteSelectedCascade(rowId) {
		removeFromSelectedOrg(rowId);
		var treeObj = $.fn.zTree.getZTreeObj("selectDeptTree");
		var nodes = treeObj.getCheckedNodes(true);
		$.each(nodes, function (index, node) {
			if (node.id == rowId) {
				treeObj.checkNode(node, false, true);
			}
		});
	}

	/**移除选中的组织*/
	function removeFromSelectedOrg(rowId) {
		$("#jqGridSelected").delRowData(rowId);
		resetSelectNum();
	}

	function formatTitleSelected(cellvalue, options, rowObject) {
		return '<span class="selected-title-span" data-id="' + rowObject.id + '" title="" ><span class="user-name">' + rowObject.name + '</span></span>';
	}

	function formatOp(cellvalue, options, rowObject) {
		return '<span class="icon icon-drag" aria-hidden="true" title="移动"></span><span class="icon icon-close" aria-hidden="true" title="移除" onclick="deleteSelectedCascade(\'' + rowObject.id + '\');"></span>';
	}

	function treeNodeToRowData(treeNode){
		return {
			id: treeNode.id,
			name: treeNode.text,
			orgIdentity: treeNode.orgIdentity
		};
	}

	function removeAllSelect() {
		if (isShowChebox) {
			// 多选时删除选中
			var rows = $("#jqGridSelected").jqGrid('getGridParam', 'selarrrow');
			for (var i = rows.length - 1; i >= 0; i--) {
				var removeId = rows[i];
				deleteSelectedCascade(removeId);
			}
		} else {
			// 单选时删除所有
			$.each($("#jqGridSelected").getDataIDs(), function (index, elem) {
				deleteSelectedCascade(elem);
			});
		}
	}

	function resetSelectNum(){
		var selectCnt = $("#jqGridSelected").getDataIDs().length;
		if(selectCnt){
			$('.unselected-div').remove();
		} else {
			$('.unselected-div').remove();
			var elemDiv = '<div class="unselected-div"><img src="static/h5/common-ext/userUnselected.png" /><span class="unselected-div-title">暂未选择组织</span></div>';
			$('#gview_jqGridSelected .ui-jqgrid-bdiv').append(elemDiv);
		}
		$("#selectedPanelTitle").text("(" + selectCnt + ")");
	}

	function handleCheckedCascade(treeId, treeNode) {
		addToSelectedOrg(treeNode.id, treeNodeToRowData(treeNode));
		treeNode.children && $.each(treeNode.children, function (index, child) {
			handleCheckedCascade(treeId, child);
		});
	}

	function handleUncheckedCascade(treeId, treeNode) {
		removeFromSelectedOrg(treeNode.id, treeNodeToRowData(treeNode));
		treeNode.children && $.each(treeNode.children, function (index, child) {
			handleUncheckedCascade(treeId, child);
		});
	}

</script>
</body>
</html>
