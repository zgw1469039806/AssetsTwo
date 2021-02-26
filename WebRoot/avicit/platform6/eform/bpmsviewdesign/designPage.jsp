<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String importlibs = "common,tree,form,table";
//获取参数    是否为设计    用例id
	String isDesign = request.getParameter("isDesign");
	String useCaseId = request.getParameter("useCaseId");
%>
<!DOCTYPE html>
<html><head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>视图设计</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
<script type="text/javascript">
var consoleFlag = "_console";//定义后台页面标识，固定后台样式不跟随前台换肤
</script>
	<link rel="stylesheet" id="themeskin" type="text/css" href="static/h5/skin/default.css">
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
<link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="avicit/platform6/eform/bpmsviewdesign/css/twoTabs.css"/>
<link rel="stylesheet" href="avicit/platform6/eform/bpmsviewdesign/css/style.css"/>
<link rel="stylesheet" href="avicit/platform6/eform/bpmsviewdesign/css/view.css"/>


    <link rel="stylesheet" href="avicit/platform6/eform/bpmsviewdesign/css/style.css"/>

    <link rel="stylesheet" href="static/h5/skin/iconfont/iconfont.css">
	<link rel="stylesheet" href="static/css/platform/eform/jquery.multiselect.css">

    <style type="text/css">
        .navbar-form span {
            margin-left: 10px;
        }
        .icon {
            font-size: 25px;
            cursor: pointer;
        }
    </style>

	<style>
	.property-control {
		margin-bottom: 15px;
		position: relative;
		padding-left: 100px;
	}
	.property-control label,.test input {
		display:inline-block;
	}
	.property-control label {
		text-overflow : ellipsis;
		white-space : nowrap;
		overflow : hidden;
		padding-right: 5px;
		position: absolute;
		left: 0;
		line-height: 30px;
		width: 100px;
		text-align: right;
	}
</style>
<script type="text/javascript">
    var contextPath = "<%=request.getContextPath()%>";
</script>
</head>

<body class="formdesign">
<div id="formArea" class="easyui-layout" fit="true" style="position: inherit;z-index: inherit;">
	<div data-options="region:'north',split:false,border:0" style="height:51px;overflow:hidden;">
		<div id="navbar" class="navbar navbar-default ace-save-state" style="margin-bottom:0px;">
		    <div class="navbar-container ace-save-state" id="navbar-container">
		        <div class="navbar-buttons navbar-header pull-right">
		            <div class="navbar-form navbar-left" id="buttonArea">
		                <span style="color: #58a9ff;">
		                    <i class="icon iconfont icon-Preservation" title="保存视图" onclick="viewDesignPage.save('0');"></i>
		                </span>
		                <span style="color: #58a9ff;">
		                    <i class="icon iconfont icon-baocunfabu" title="保存并发布视图" id="ccd"
		                    	></i>
		                </span>
		                <span style="border-left: 1px solid #B5B5B5;padding-bottom: 0px;padding-top: 7px;">
		                </span>
					<span style="color: #B5B5B5;">
                	<i class="icon iconfont icon-js" title="JS文件扩展" onclick="viewDesignPage.applyJs()"></i>
                	</span>
						<span style="color: #B5B5B5;">
                	<i class="icon iconfont icon-changyong" title="css文件扩展" onclick="viewDesignPage.applyCss()"></i>
                	</span>
		                <span style="color: #B5B5B5;">
		                    <i class="icon iconfont icon-preview" title="预览" onclick="viewDesignPage.view()"></i>
		                </span>
		              <!--   <span style="color: #B5B5B5;">
		                    <i class="icon iconfont icon-Save" title="保存模板" onclick="formEditor.saveAsTemplate()"></i>
		                </span>
		                <span style="color: #B5B5B5;" id="previewButton">
		                    <i class="icon iconfont icon-open" title="打开模板"></i>
		                </span> -->
		               <span id="layoutButton" style="color: #B5B5B5;">
                    		<i  class="icon iconfont icon-style" title="布局模板"></i>
              			</span>
						<span style="color: #B5B5B5;">
							<i class="icon iconfont icon-file" title="帮助" onclick="viewDesignPage.helpDoc()"></i>
						</span>

		            </div>
		        </div>
		    </div>
	    </div>
	</div>
	<div data-options="region:'west',split:true"
		style="width: 300px; padding: 0px; overflow: auto;">

		<!-- 快捷菜单  -->
		<div class="ztree-submenu rMenu">
		</div>
		<div>
			<ul id="viewTree" class="ztree"></ul>
		</div>
</div>
<div data-options="region:'center'">
		<div class="twoTabNav">
<ul class="nav nav-tabs">
		  <li ${propertiesActive }>
		  	<a href="javascript:void(0);">属性</a>
		  </li>
		  <li ${layoutActive}>
		  	<a href="javascript:void(0);">布局</a>
		  </li>

		</ul>
				<ul class="tab-cont" style="overflow: visible;">
					<li  id="comattr" ${propertiesActive }>
				  		<div class="demoCont">
							<div id="PropertyCard">
							</div>
						</div>
				  	</li>
				  	<li ${layoutActive}>
				  		<div class="demoCont" >
							<div class="eform-layout">
								<%--<c:out value='${layout}'  escapeXml="false"/>--%>
							</div>
						</div>
				  	</li>
				</ul>

	</div>
</div>
</div>
<%--样式列表--%>
<div class="row col-xs-12">
    <div id="top-style" class="modal aside" data-fixed="true" data-placement="top" data-background="true"
         data-backdrop="invisible" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body container" style="text-align: center;">
                    <%--样式列表显示位置--%>
                    <div id="styleList">
                    	<div class="eform-item" style="height:120px;">
							<div class="eform-item-top eform-position" style="height:50%">
							</div>
							<div class="eform-item-center eform-position"  style="height:50%">
						</div>
                    </div>
                    <div class="eform-item" style="height:120px;">
							<div class="eform-position eform-item-center">
							</div>
						</div>
						<div class="eform-item" style="height:120px;">
							<div class="eform-item-left eform-position" style="width:50%;"></div>
							<div class="eform-item-center eform-position" style="margin-left:50%;"></div>
						</div>
						<div class="eform-item" style="height:120px;">
							<div class="eform-item-left eform-position" style="width:20%;"></div>
							<div class="eform-item-center eform-position" style="margin-left:20%;"></div>
						</div>

						<div class="eform-item" style="height:120px;">
							<div class="eform-item-left eform-position" style="width:20%;"></div>
							<div class="eform-item-center eform-position" style="margin-left:20%;">
								<div class="eform-item-top eform-position" style="height:40%">
								</div>
								<div class="eform-item-center eform-position" style="height:60%">
								</div>
							</div>
						</div>
						<div class="eform-item" style="height:120px;">
							<div class="eform-item-left eform-position" style="width:20%;"></div>
							<div class="eform-item-center eform-position" style="margin-left:20%;">
								<div class="eform-item-center eform-position" style="height:50%">
									<div class="eform-item-left eform-position" style="width:50%">
									</div>
									<div class="eform-item-center eform-position" style="margin-left:50%;">
									</div>
								</div>
								<div class="eform-item-bottom eform-position" style="height:50%">
								</div>
							</div>
						</div>
						<div class="eform-item" style="height:120px;">
							<div class="eform-item-left eform-position" style="width:50%;">
								<div class="eform-item-top eform-position" style="height:50%">
								</div>
								<div class="eform-item-center eform-position" style="height:50%">
								</div>
							</div>
							<div class="eform-item-center eform-position" style="margin-left:50%;">
								<div class="eform-item-top eform-position" style="height:50%">
								</div>
								<div class="eform-item-center eform-position" style="height:50%">
								</div>
							</div>
						</div>

                    <div class="closeButton">
                        <button type="button" class="btn btn-sm btn-danger" data-dismiss="modal"><i class="ace-icon fa fa-arrow-up bigger-110"></i>收起</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/platform6/eform/bpmsviewdesign/js/avicSelect2.js"></script>

<!-- ace scripts -->
<script src="static/js/platform/aceadmin/ace/elements.aside.js"></script>
<script src="static/js/platform/aceadmin/ace/elements.scroller.js"></script>
<script src="static/js/platform/aceadmin/ace/ace.js"></script>

<script type="text/javascript" src="avicit/platform6/eform/formdesign/js/config.js"></script>
<script type="text/javascript" src="avicit/platform6/eform/bpmsviewdesign/js/main.js"></script>
<script type="text/javascript" src="avicit/platform6/eform/bpmsviewdesign/js/twoTabs.js"></script>
<script src="avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.js"></script>
<script src="static/js/platform/eform/common.js"></script>

<script type="text/javascript" src="avicit/platform6/eform/bpmsviewdesign/js/ViewEngine.js"></script>
<script type="text/javascript" src="avicit/platform6/eform/bpmsviewdesign/js/ViewDesignPage.js"></script>
<script type="text/javascript">
    var engine;
    var viewId = '${id}';
    var viewDesignPage;
    var viewEditor;
    var viewName = '${viewName}';
    var viewCode = '${viewCode}';
    var viewStyle = "${viewStyle}";
    var version = "${viewVersion}";
	var viewPublishStatus = "${viewPublishStatus}";
    var viewJs = "${viewJs}";
    var viewCss = "${viewCss}";
    loadExtraJs(function(){
        engine = new ViewEngine();
        engine.initButtonArea();




        $("#layoutButton").bind("click",function(){
            if (!engine.doValidate()){
                return false;
            }
            viewEditor.openTemplate();
        });


        engine.layout = "${layout}";
        engine.setLayout();
        //easyui tabs
        if (viewStyle != 'bootstrap' && $(engine.layout).find('.tabs_div').length > 0) {
            var tabsContent = $('<div style="height: 100%;" class="tabs_div" addheight="40" onclick="$(window).trigger(\'resize\');"></div>');
            tabsContent.append('<ul class="nav nav-tabs" role="tablist"></ul>');
            tabsContent.append('<div class="tab-content"></div>');

            $(engine.layout).find('.easyui-tabs').find('.eform-position-item').each(function (index, item) {
                var tabName = $(item).attr('title');
                var viewCom = item.innerHTML;

                var li = "";
                var div = "";
                if (index == 0) {
                    li = '<li role="presentation" class="active"><a href="#' + tabName + '" aria-controls="' + tabName + '" role="tab" data-toggle="tab" aria-expanded="true">' + tabName + '</a></li>';
                    div = '<div role="tabpanel" class="tab-pane eform-position-item active" id="' + tabName + '" style="height: 100%;">' + viewCom + '</div>';
                }
                else {
                    li = '<li role="presentation"><a href="#' + tabName + '" aria-controls="' + tabName + '" role="tab" data-toggle="tab" aria-expanded="false">' + tabName + '</a></li>';
                    div = '<div role="tabpanel" class="tab-pane eform-position-item" id="' + tabName + '" style="height: 100%;">' + viewCom + '</div>';
                }

                tabsContent.find(".nav-tabs").append(li);
                tabsContent.find(".tab-content").append(div);
            });

            var position = $('<div class="eform-position eform-item-center eform-position-item"></div>');
            position.append(tabsContent);

            engine.layout = position[0].outerHTML;
        }

        $(".eform-layout").html(engine.layout);
        viewEditor = new ViewEditor("formArea");
        viewEditor.viewStyle = viewStyle;
        var log, className = "dark", curDragNodes, autoExpandNode;
        function beforeDrag(treeId, treeNodes) {
            className = (className === "dark" ? "":"dark");
            for (var i=0,l=treeNodes.length; i<l; i++) {
                if (treeNodes[i].drag === false) {
                    curDragNodes = null;
                    return false;
                } else if (treeNodes[i].parentTId && treeNodes[i].getParentNode().childDrag === false) {
                    curDragNodes = null;
                    return false;
                }
            }
            curDragNodes = treeNodes;
            return true;
        }
        function beforeDragOpen(treeId, treeNode) {
            autoExpandNode = treeNode;
            return true;
        }
        function beforeDrop(treeId, treeNodes, targetNode, moveType, isCopy) {
            className = (className === "dark" ? "":"dark");
            return true;
        }
        function onDrag(event, treeId, treeNodes) {
            className = (className === "dark" ? "":"dark");
        }
        function onDrop(event, treeId, treeNodes, targetNode, moveType, isCopy) {
            className = (className === "dark" ? "":"dark");

        }
        function dropPrev(treeId, nodes, targetNode) {
            if(nodes[0].type == targetNode.type||nodes[0].parentTId == targetNode.parentTId){
            	if((nodes[0].type === 'filter' || nodes[0].type === 'filterOr' || nodes[0].type === 'filterGroup')&&nodes[0].parentTId != targetNode.parentTId){
            		return false;
				}
                return true;
            }else{
                return false;
            }
        }

		function dropInner(treeId, nodes, targetNode) {
			if((nodes[0].type === 'tableToolbarButton' || nodes[0].type === 'treeGridToolbarButton' || nodes[0].type === 'dataListToolbarButton')){
				if((targetNode.type === 'tableToolbarButtonGroup' || targetNode.type === 'dataListToolbarButtonGroup') && nodes[0].parentTId == targetNode.parentTId) {
					return true;
				}else if ((targetNode.type === 'treeGridToolbarButtonArea' || targetNode.type === 'tableToolbarButtonArea' || targetNode.type === 'dataListToolbarButtonArea') && nodes[0].getParentNode().parentTId == targetNode.tId){
					return true;
				}
			}else{
				return false;
			}
		}



        engine.treeNodes = ${treeNode};
        engine.setTreeNode();
        viewDesignPage = new ViewDesignPage();
        var setting = {
            check : {
                enable : false
            },
            view : {
                expandSpeed : 300
            },
            edit: {
                drag: {
                    autoExpandTrigger: true,
                    prev: dropPrev,
                    inner: dropInner,
                    next: dropPrev
                },
                enable: true,
                showRemoveBtn: false,
                showRenameBtn: false
            },
            data : {
                simpleData : {
                    enable : true,
                    idKey : "id",
                    pIdKey : "pid",
                    rootPId : 0
                }
            },
            callback : {
                beforeDrag: beforeDrag, //拖拽前：捕获节点被拖拽之前的事件回调函数，并且根据返回值确定是否允许开启拖拽操作
                beforeDrop: beforeDrop, //拖拽中：捕获节点操作结束之前的事件回调函数，并且根据返回值确定是否允许此拖拽操作
                beforeDragOpen: beforeDragOpen, //拖拽到的目标节点是否展开：用于捕获拖拽节点移动到折叠状态的父节点后，即将自动展开该父节点之前的事件回调函数，并且根据返回值确定是否允许自动展开操作
                onDrag: onDrag, //捕获节点被拖拽的事件回调函数
                onDrop: onDrop, //捕获节点拖拽操作结束的事件回调函数
                beforeClick: function (treeId, treeNode,clickFlag) {
                    $('.nav-tabs').find('>li:eq(0)').click();
                    if (!engine.listenNode(treeId, treeNode,clickFlag)) {
                        return false;
                    }
                },
                onRightClick : function OnRightClick(event, treeId, treeNode) {

                    var treeObj = $.fn.zTree.getZTreeObj(treeId);
					var nodes = treeObj.getSelectedNodes();
					if (nodes != null && nodes.length>1){

						var type = nodes[0].type;
						for (var index in nodes){
							if (index === "clone"){
								continue;
							}
							if (nodes[index].type != type){
								treeObj.selectNode(treeNode);
								engine.ShowMenu(event, treeId, treeNode);
								return;
							}
						}
						engine.ShowMenu(event, treeId, treeNode,true);

					}else {
						treeObj.selectNode(treeNode);
						engine.ShowMenu(event, treeId, treeNode);
					}
                }
            }
        };
        var data;
        if(engine.treeNodes!=null && typeof(engine.treeNodes) != 'undefined' && engine.treeNodes != ""){
            data = engine.treeNodes;
        }else{
            data = [{
                id : viewId,
                pid: 0,
                type : "view",
                name : viewName,
                attribute:{id : viewId, name : viewName},
				version:version
            }];
        }
        var viewTree = $.fn.zTree.init($("#viewTree"), setting, data);
        viewTree.expandAll(true);
        engine.InitEngine({viewTree: viewTree});
//	viewEditor.initLayout();

        //by ws
        engine.isDesign  = "<%=isDesign%>";
        engine.useCaseId = "<%=useCaseId %>";
        //by ws

    });


/*
$("#previewButton").bind("click",function(){
	var $html = $(".eform-layout").clone();
	$html.find(".add-com-area").remove();
	$html.find(".tools").remove();
	//window.showContent = $html.html();
	console.log($html.html());
	layer.open({
        type: 2,
        title: '电子表单预览',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsviewdesign/bpmsbootstrapPreview.jsp"
    });
});
*/


//集成模型系统start
var funinfochar = '${funinfo}';
//var funinfochar = '[{"key":"add()","value":"aaa.jsp"},{"key":"adsssd()","value":"abca.jsp"}]';
var funinfoArray = [];
if (funinfochar.length>0){
    funinfoArray = $.parseJSON(funinfochar);
}
function findFuninfo(value){
	if (!value){
		return null;
	}
	for (var i=0;i<funinfoArray.length;i++){
    	var info = funinfoArray[i];
    	if (info.key == value){
    		return info;
    	}
    }
	return null;
}
var componentViewId = '${componentViewId}';
if (componentViewId ==""){
	componentViewId = "-1";
}




</script>

</body>
</html>