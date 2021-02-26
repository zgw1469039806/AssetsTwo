<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,tree,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>菜单管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<style type="text/css">
	.fmt_opt{
		min-width: 8px;

	}
	.jqgrow td a {
		color:#fff;
	}
	.remind-text{
    color:#585858;
   }
   .text-link{
    color:#ff6600;
	padding:0 2px;
   }
   .text-link:hover{
    color:#ff6600;
   }
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true" style="width: 250px;border-top-style: hidden;overflow: hidden;">
		<%--<div class="row" style="margin: 5px;">--%>
            <div id="tableToolbarM" class="toolbar">
                <div class="toolbar-left">
                  <div class="input-group  input-group-sm">
                      <input  class="form-control" placeholder="输入名称查询" type="text" id="txt" name="txt">
                      <span class="input-group-btn">
								<button id="searchbtn" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
							</span>
                  </div>
                </div>
            </div>
            <div  id='mdiv' style="overflow:auto;">
				<ul id="consoleMenu" class="ztree"></ul>
            </div>
		<%--</div>--%>
	</div>
	<div data-options="region:'center',onResize:function(a){$('#jqGrid').setGridWidth(a);$(window).trigger('resize');}">
		<div id="tableToolbar" class="toolbar">
			<div class="toolbar-left">
				<a id="menuInsert" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
				title="添加"><i class="icon icon-add"></i> 添加</a>
				<a id="menuModify" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn btn-sm" role="button"
				title="编辑"><i class="icon icon-edit"></i> 编辑</a>

				<a id="menuDel" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn btn-sm" role="button"
				title="删除"><i class="icon icon-delete"></i> 删除</a>

				<a id="menuImport" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn btn-sm" role="button"
				title="导入"><i class="icon icon-daoru"></i> 导入</a>

				<a id="menuExport" href="javascript:void(0)"
				   class="btn btn-primary form-tool-btn btn-sm" role="button"
				   title="导出"><i class="icon icon-daochu"></i> 导出</a>

				<a id="menuLink" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="引用"><i class="icon icon-link"></i> 引用</a>
				<span class="remind-text">◆ 提示：当您修改菜单内容后，需<a id="auth" name="auth" href="javascript:void(0)"
							   class="text-link" role="button"
							   title="刷新菜单授权缓存"> 刷新菜单授权缓存</a>才能生效</span>
			</div>
		</div>
		<table id="jqGrid"></table>
	</div>
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/console/menu/js/MenuTree.js" ></script>
<script type="text/javascript" src="avicit/platform6/console/menu/js/MenuList.js" ></script>
<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
<script type="text/javascript" src="static/js/platform/component/common/exportData.js"></script>
<%--<script type="text/javascript" src="avicit/platform6/console/menu/js/swfobject.js" ></script>
<script type="text/javascript" src="avicit/platform6/console/menu/js/web_socket.js" ></script>--%>
<script  type="text/javascript">
	var mappLength = 0;
	try{
		mappLength = parent.parent.$('#jqGridApp').jqGrid('getDataIDs').length;
	}catch (e) {
		mappLength = 0;
	}

    function WebSocketTest()
    {
        if ("WebSocket" in window)
        {
            alert("您的浏览器支持 WebSocket!");

            // 打开一个 web socket
            var ws = new WebSocket("ws://localhost:9998/echo");

            ws.onopen = function()
            {
                // Web Socket 已连接上，使用 send() 方法发送数据
                ws.send("发送数据");
                alert("数据发送中...");
            };

            ws.onmessage = function (evt)
            {
                var received_msg = evt.data;
                alert("数据已接收...");
            };

            ws.onclose = function()
            {
                // 关闭 websocket
                alert("连接已关闭...");
            };
        }

        else
        {
            // 浏览器不支持 WebSocket
            alert("您的浏览器不支持 WebSocket!");
        }
    }

    //WebSocketTest();




var menuTree,menuList,pId;
$('#mdiv').height(document.documentElement.clientHeight-46);
function formatValue(cellvalue, options, rowObject) {
	return '<a href="javascript:void(0);" onclick="demoSingle.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
    }
    var fmtStatus =function(cellvalue){
	return menuList.MenuStatus[cellvalue];
};
function fmtMenuIcon(cellvalue, options, rowObject) {
	return '<i class="'+cellvalue+'" ></i>';
}
var fmtShow=function(cellvalue){
	return menuList.MenuShow[cellvalue];
};
var fmtOpt=function(){
	var  dd='<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm fmt_opt" role="button" title="编辑">编辑</a><a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm fmt_opt" role="button" title="删除">删除</a>';
	//return dd.html();
	return dd;
};
$(function(){
	var searchNames = [];
	searchNames.push("menuName");//用户可自定义查询条件，修改参数。
	
	var dataGridColModel =  [
	{ label: 'id', name: 'id', key: true, hidden:true },
	{ label: '菜单名称', name: 'menuName', width: 100,sortable:false,align:'center'},
	{ label: '菜单编码', name: 'menuCode', width: 80,sortable:false,align:'center' },
	{ label: '菜单路径', name: 'menuUrl', width: 230,sortable:false ,align:'left'},
	{ label: '菜单图标', name: 'menuIcon', width: 50,sortable:false ,align:'center',formatter:fmtMenuIcon},
	{ label: '菜单状态', name: 'menuStatus', width: 40,sortable:false,align:'center',formatter:fmtStatus},
	{ label: '是否展示', name: 'isShow', width: 40,sortable:false,align:'center',formatter:fmtShow},
	{ label: '菜单排序', name: 'menuOrder', width: 50,sortable:false,align:'center'}
	];
	menuList = new MenuList('jqGrid','${url}','searchDialog','form','keyWord',searchNames,dataGridColModel);

    // 仅前台菜单支持导入导出
	var param = '${url}'.split("/").pop();
	var appid = param.split("-")[0];
	var type = param.split("-")[2];
	if(type == '1'){
        $('#menuImport').bind('click', function() {
            menuList.doimport();
        });
        $('#menuExport').bind('click', function() {
            menuList.doexport();
        });

		if(mappLength == 0 || appid != '1') {
			$('#menuLink').hide();
		} else {
			$('#menuLink').bind('click', function() {
				menuList.mappMenuLink();
			});
		}
    }else{
        $('#menuExport').hide();
        $('#menuImport').hide();

        $('#menuLink').hide();
    }
	
	//菜单树初始化
	menuTree = new MenuTree('consoleMenu','${url}','','txt','searchbtn');

	menuTree.setOnSelect(function(treeNode) {
			pId=treeNode.id;
			menuList.loadByPid(pId);
		}).init();
		//menuTree.init();
	});
	$('#menuInsert').bind('click', function() {
		menuList.insert(pId);
	});
	$('#menuModify').bind('click', function() {
		menuList.modify(pId);
	});
	$('#menuDel').bind('click', function() {
		menuList.del();
	});
	//刷新菜单的缓存
	$("#auth").on("click", function() {
		var type= $(this).attr("name");
		var url = "platform/cache/RefreshCacheController/refresh";
        var loading=layer.load(1, {
            title : '请稍后',
            msg : '正在刷新缓存...',
            shade: [0.1,'#fff']
        });
		$.ajax({
			type : "POST",
			data : {
				type : type
			},
			url : url,
			dataType : "json",
			success : function(r) {
                layer.close(loading);
				if (r.success) {
                    layer.msg('刷新成功！',{
                        icon: 1,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
				} else {
                    layer.alert('刷新失败！' + r.e, {
                        icon: 2,
                        area: ['400px', ''],
                        closeBtn: 0
                    });
				}
                $("#auth").blur();
			}
		});
	});
	//重绘图标
	 function redrawTreePseudoEl(){
		   if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
			   var buttonEl = $("#consoleMenu").find('.button');
			   buttonEl.addClass('content-empty');
		 		  setTimeout(function(){
		 			 buttonEl.removeClass('content-empty');
		 		  },1000);
		 		  var iconEl =$("#tableToolbar").find('.icon');
		 		    iconEl.addClass('content-empty');
		 		  setTimeout(function(){
		 			 iconEl.removeClass('content-empty');
		 		  },1000);
		 	  }
	 }
</script>
</html>