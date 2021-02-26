<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
String importlibs = "common,tree,table,form";
String instanceId = "\'"+request.getParameter("instId")+"\'";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>相关流程选择</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<link rel="stylesheet" type="text/css" href="avicit/platform6/console/authorization/css/auth.css"/>
</head>
<body class="easyui-layout" fit="true" style="overflow: hidden;">
	<div data-options="region:'west',split:false,border:true,collapsible:false" id="west" style="width: 350px;">
			<div  id='mdiv' style="overflow:auto;">
				<ul id="consoleMenu" class="ztree"></ul>
			</div>
	</div>
	<div data-options="region:'center',split:false,border:true">
	<div id="toolbar_related" class="toolbar">
		<div class="toolbar-right">
			<div id="commonSearch" class="input-group form-tool-search">
				<input type="text" name="related_keyWord"
					id="related_keyWord" style="width:240px;"
					class="form-control input-sm" placeholder="请输入标题"> <label
					id="related_searchPart"
					class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
</div>
			<table id="firstjqGrid"></table>
			<div id="firstPager"></div>
	</div>

</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include/MenuTree.js" ></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/Related.js" type="text/javascript"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script  type="text/javascript">
    var instanceId = <%=instanceId%>;//当前流程实例id
	var menuTree,pId,firstList;

	var fristTable = function() {
			if (!firstList) {
				var DatazGridColModel = [
				             			  {label : 'dbid',name : 'dbId',key : true,hidden : true}
				            			, {label : '标题',name : 'title',align : 'left',sortable : false,formatter : getTraceButtons}
				            			, {label : '申请日期',name : 'startDate',width: 150,formatter : function(value, rec) {
				            					var startdateMi = value;
				            					if (startdateMi == undefined) {
				            						return '';
				            					}
				            					var newDate = new Date(startdateMi);
				            					return newDate.format("yyyy-MM-dd hh:mm:ss");
				            			  }
				            			}
				            			,{label : '当前节点',name : 'activityName',align : 'left',sortable : false}
				            			, {label : '状态',name : 'businessState',width : 60,fixed : true,align : 'center',sortable : true,
				            				formatter : function(cellvalue, options, rowObject) {
				            					if (cellvalue == 'start') {
				            						return '拟稿中';
				            					} else if (cellvalue == 'active') {
				            						return '流转中';
				            					} else if (cellvalue == 'ended') {
				            						return '已完成';
				            					}else{
				            						return cellvalue;
				            					}

				            				}
				            			}
				            			, {label : '处理人',name : 'assigneeName',align : 'left',sortable : false}
				            		];
						var searchNames = new Array();
						var searchTips = new Array();
						searchNames.push("title");
						searchTips.push("标题");
						var searchC = searchTips.length == 2 ? '或'
								+ searchTips[1] : "";
						$('#related_keyWord').attr('placeholder',
								'请输入' + searchTips[0] + searchC);

						var url = "bpm/process/searchHistProcessByPage?type=2";
						firstList = new Related('firstjqGrid', url,DatazGridColModel,'form',pId,nodeType,pdId,'related_keyWord',searchNames);
						firstList.setOnSelect(function (rowData) {
                            if(rowData == instanceId){
                                layer.msg('选择的相关流程不能是当前流程实例！', {icon: 7});
                                $("#firstjqGrid").jqGrid('setSelection',rowData,false);
							}
                        })
			}else{
				firstList.loadByAppId(pId,nodeType,pdId);
			}
	};

	function getTraceButtons(cellvalue, options, rowObject){
		if(cellvalue==undefined || cellvalue==''){
			cellvalue=rowObject.procDefName;
			if(cellvalue==undefined || cellvalue==''){
				cellvalue="无";
			}
		}
		return '<a href="javascript:void(0)" onClick="flowUtils.detail(\''+rowObject.dbId+'\')">'+cellvalue+'</a>';
	}
	//查询按钮绑定事件
	$('#related_searchPart').bind('click', function() {
		firstList.searchByKeyWord();
	});


	$(function() {
		$('#mdiv').height(document.documentElement.clientHeight - 50);
		//菜单树初始化
		menuTree = new MenuTree('consoleMenu', 'bpm/monitor/getFlowModelTree', '', 'txt', 'searchbtn');

		menuTree.setOnSelect(function(treeNode) {
			pId = treeNode.id;//菜单ID
			nodeType = treeNode.nodeType;
			if(treeNode.attributes != null){
				pdId = treeNode.attributes.pdId;
			}else{
				pdId = null;
			}
			fristTable();
		}).init();

	});
</script>
</html>
