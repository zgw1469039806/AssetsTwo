<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>在线用户</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style type="text/css">
   #gview_dgSession{
      padding-top:43px;
   }
</style>
</head>
<body class="easyui-layout" fit="true">
    <div data-options="region:'west',split:true,title:'应用列表',collapsible:false" style="height:0; overflow:hidden; font-size:0;width:260px;">
             <div id="tableToolbarM" class="toolbar">
                 <div class="toolbar-left">
                     <div class="input-group  input-group-sm">
                         <input  class="form-control" placeholder="输入名称查询" type="text" id="appSearchInput" name="txt">
                         <span class="input-group-btn">
                         <button id="appSearch" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
                     </span>
                     </div>
                 </div>
             </div>
             <div  id='mdiv' style="overflow:auto;">
                 <table id="jqGridApp"></table>
             </div>
	</div>
   <div id="panelmcenter" data-options="region:'center',title:''" style="padding:0px;">
      <div class="easyui-layout" data-options="fit:true">
	   <div id="panelnorth" data-options="region:'north'"  style="height:280px;">	
		  <iframe id="panelnorthif" src="avicit/platform6/bs3centralcontrol/onlineuser/userOnlineInfo.jsp" width="100%" height="98%" border="0" ></iframe>
	   </div>
        <div data-options="region:'center',split:true,title:'',onResize:function(a){$('#dgOnline').setGridWidth(a);$(window).trigger('resize');}" style="padding:0px;">
			<div id="tableToolbar" class="toolbar">
			   <div class="toolbar-left">
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysJobHistory_button_add"
						permissionDes="刷新">
						<a id="btRefresh" href="javascript:void(0)"
						   class="btn btn-primary form-tool-btn btn-sm " role="button"
						   title="刷新"><i class="glyphicon glyphicon-refresh"></i> 刷新</a>
					</sec:accesscontrollist>
			   </div>
			  <div style="position: absolute;left:120px;top:8px; width:780px;display:block;">
					<table width="100%">
						<tr>
							<td><span style="color: blue">当前在线人数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span id='totalNum' style="color: blue">0</span></td>
							<!-- <td><span id='totalNum' style="color: blue">0</span></td> -->
						</tr>
						<tr>
						 <span style="color: red;">注意, 由于存在用户网络突然中断或用户不注销直接关闭浏览器等特殊情况，当前在线人数只是一个概数，可能不准确，仅供参考</span></td>
						</tr>
					</table>
			  </div> 
			   <div class="toolbar-right">
			   		<div class="input-group-btn form-tool-searchbtn">
			   			<a id="btSearchOnline" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
			   		</div>
			   </div>
			</div>
			<table id="dgOnline"></table>
            <div id="jqGridPager"></div>
		</div>
		<!-- <div id="panelsouth" data-options="region:'east',split:true,width:fixwidth(.3),onResize:function(a){$('#dgSession').setGridWidth(a);$(window).trigger('resize');}" >	
			<table id="dgSession"></table>
        </div> -->
     </div>
    </div>
</body>
<!-- 高级查询 -->
<div id="highsearchDialog" style="overflow: auto;display: none">
 <form id='form'>
	<table class="form_commonTable">
	    <tr>
			<th>
				<label for="name">用户名:</label>
			</th>
			<td width="39%">
				<input title="用户名" class="form-control input-sm" type="text" style="width: 99%;"  name="userName" id="userName" />
			</td>
			<th>
				<label for="nameEn">部门名称:</label>
			</th>
			<td width="39%">
				<input title="部门名称" class="form-control input-sm" type="text" style="width: 99%;" name="deptName" id="deptName" />
			</td>
		</tr>
		<tr>
			<th>
				<label for="name">登录时间(起):</label>
			</th>
			<td width="39%">
				<div class="input-group input-group-sm">
	                <input class="form-control time-picker"  type="text" name="startTime" id="startTime"/><span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
	            </div> 
			</td>
			<th>
				<label for="nameEn">登录时间(止):</label>
			</th>
			<td width="39%">
				<div class="input-group input-group-sm">
	                <input class="form-control time-picker"  type="text" name="endTime" id="endTime"/><span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
	            </div> 
			</td>
		</tr>
	</table>
</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bs3centralcontrol/appliaction/js/AppList.js" type="text/javascript"></script>
<script type="text/javascript">
var loginNameStr;
var appid = "";
var isInit = true;
function formatValue(cellvalue, options, rowObject) {
	return '<a href="javascript:void(0);" onclick="deleteSession(\''
		+ rowObject.sessionId + '\'' +"," + '\'' + rowObject.loginName + '\');">踢出</a>';
			
}
$(document).ready(function () {
	var dgOnlineColModel =  [
	   { label: 'Session ID', name: 'sessionId', width: 200,hidden:true , sortable: false}
 	  ,{ label: '用户名', name: 'name', width: 150, sortable: false}
      ,{ label: '登录名', name: 'loginName', width: 150 , sortable: false}
      ,{ label: '部门名称', name: 'deptName', width: 150 , sortable: false}
      ,{ label: '网络地址', name: 'ip', width: 150, sortable: false}
      ,{ label: '登录时间', name: 'loginTime', width: 150, sortable: false}
      ,{ label: '在线时间', name: 'onlineTime', width: 150 , sortable: false}
      ,{ label: '操作', name: 'extra', width: 100,formatter:formatValue, sortable: false}
	];
	/*var timelyRefreshDialogColModel =  [
    	 { label: '最近请求时间', name: 'lastRequest', width: 220}
         ,{ label: '用户名', name: 'name', width: 150 }
        // ,{ label: 'Session ID', name: 'sessionId', width: 200 }
         ,{ label: '是否超时', name: 'expired', width: 100}
         ,{ label: '操作', name: 'extra', width: 100,formatter:formatValue}
   	];
	*/
	sysAppTree = new AppList('jqGridApp','1','searchDialog','form','keyWord');
	
	sysAppTree.setOnSelect(function(appId){
		appid = appId;
		$("#panelnorthif").attr('src', "avicit/platform6/bs3centralcontrol/onlineuser/userOnlineInfo.jsp?appid=" + appId);
		if(isInit){
			$("#dgOnline").jqGrid({
		    	url: 'platform/bs3onlineuser/h5OnlineUserController/getOnlineUserListByPage.json',
		    	postData : {appid : appId},
		        mtype: 'POST',
		        datatype: "json",
		        toolbar: [true,'top'],
		        colModel: dgOnlineColModel,
		        height:$(window).height()-$('#panelnorth').height()-120-17,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		        scrollOffset: 20, //设置垂直滚动条宽度
		        rowNum: 20	,
		        rowList:[200,100,50,30,20,10],
		        altRows:true,
		        userDataOnFooter: true,
		        pagerpos:'left',
		        styleUI : 'Bootstrap',
				viewrecords: true, 
				rownumbers:true,
				multiselect: false,
				autowidth: true,
				shrinkToFit: true,
				hasTabExport:false, //导出
				hasColSet:false,  //设置显隐
				responsive:true,//开启自适应
		        pager: "#jqGridPager",
		       	onSelectRow:function(rowid){
		       		/*var data = $(this).jqGrid('getRowData', rowid);
		       		loginNameStr= data.loginName;
					$("#dgSession").jqGrid('setGridParam', {
						url:'platform/bs3onlineuser/h5OnlineUserController/getPrinciplSessions.json',
						datatype : 'json',
						postData : {loginName:data.loginName}
					}).trigger("reloadGrid");*/
		       	},
		       	loadComplete:function(xhr){
		       		$('#totalNum').text(xhr.records);   //获取在线人数
		       	}
		    });
		    $("#t_dgOnline").append($("#tableToolbar"));
		    isInit = false;
		}else{
			reLoad(appId);
		}
		
	});
	
    /*$("#dgSession").jqGrid({
    	url: '',
        mtype: 'POST',
        postData : {
        	loginName :loginNameStr,
        	appid : appid
		},
        datatype: "local", //初始化不加载数据
        colModel: timelyRefreshDialogColModel,
        height:$(window).height()-$('#panelnorth').height()-120,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows: true,
        userDataOnFooter: true,
        pagerpos:'left',
        styleUI : 'Bootstrap',
        rownumbers: true,
		viewrecords: true, 
		multiselect: false,
		autowidth: true,
		shrinkToFit: true,
		responsive:true,//开启自适应
    });
    */
    $('#set_jqGridPager').remove();
    $('#exportExcel_jqGridPager').remove(); 

	//刷新按钮绑定事件
	$('#btRefresh').bind('click', function(){
		refresh();
	});
	$('.time-picker').datetimepicker({
	 	oneLine:true,//单行显示时分秒
	 	closeText:'确定',//关闭按钮文案
	 	showButtonPanel:true,//是否展示功能按钮面板
	 	showSecond:true,//是否可以选择秒，默认否
	 	timeFormat: 'HH:mm:ss',
	 	beforeShow: function(selectedDate) {
	 		if($('#'+selectedDate.id).val()==""){
	 			$(this).datetimepicker("setDate", new Date());
	 			$('#'+selectedDate.id).val('');
	 		}
	 		setTimeout(function () {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
	 	}
	});
	//打开高级查询框
	$('#btSearchOnline').bind('click',function(){
		var contentWidth = 600; 
		var top =  $(this).offset().top + $(this).outerHeight(true);
		var left = $(this).offset().left + $(this).outerWidth() - contentWidth;
		var text = $(this).text();
		var width = $(this).innerWidth();
		var highsearcgobj = $("#highsearchDialog");
		layer.config({
			  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
		layer.open({
			type: 1,
			shift: 5,
			title: false,
			scrollbar: false,
			move : false,
			area: [contentWidth + 'px', '200px'],
			offset: [top + 'px', left + 'px'],
			closeBtn: 0,
			shadeClose: true,
			btn: ['查询', '清空', '取消'],
			content: highsearcgobj ,
			success : function(layero, index) {
				var serachLabel = $('<div class="serachLabel"><span>'+ text +'</span><span class="caret"></span></div>').appendTo(layero);
				serachLabel.bind('click', function(){
					layer.close(index);
				});
				serachLabel.css('width', width + 'px');
			},
			yes: function(index, layero){
				searchUser();
				layer.close(index);//查询框关闭
			},
			btn2: function(index, layero){
				clearFormData("#form");
				searchUser();
				return false;
			},
			btn3: function(index, layero){
				
			}
		});  
	});
});

//踢出
function deleteSession(sessionId,userName) {
	layer.confirm('确定禁止本session?',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
		 avicAjax.ajax({
			 url:'platform/bs3onlineuser/h5OnlineUserController/deleteSession.json',
			 data:	{sessionId : sessionId,userName:userName},
			 type : 'post',
			 dataType : 'json',
			 success : function(data){
				 if(0 == data.result){
					 //$('#totalNum').text(data.result);   //获取在线人数
					 layer.msg('踢出成功！');
				 }else{
					 layer.alert('删除失败！' + data.msg, {
						  icon: 7,
						  area: ['400px', ''],
						  closeBtn: 0
						}
					);
				 }
			 }
		 });
		 layer.close(index);
	});   
}

//高级查询
function loadSearchOnlineInfo( userName, deptName, startTime, endTime){
	$("#dgOnline").jqGrid('setGridParam', {
		url:'platform/bs3onlineuser/h5OnlineUserController/getOnlineUserListByPage.json',
		datatype : 'json',
		postData : {
			userName: userName, 
			deptName: deptName,
			startTime: startTime,
			endTime: endTime
		}
	}).trigger("reloadGrid");
	
}
//高级查询获取表单数据
function searchUser(){
	var obj = serializeObject($('#form'));
	if(obj.startTime!="" && obj.endTime!="" && obj.startTime > obj.endTime)
	{
		layer.alert('起始时间大于终止时间', {
			  icon: 7,
			  area: ['400px', ''],
			  closeBtn: 0
			}
		);
		return;
	}
	
	loadSearchOnlineInfo(obj.userName, obj.deptName, obj.startTime, obj.endTime);
}
function reLoad(appId){
	searchdata = {
		appid : appId
	};
	
	$("#dgOnline").jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
}
//刷新
function refresh(){
	$("#dgOnline").jqGrid('setGridParam', {
		url:'platform/bs3onlineuser/h5OnlineUserController/getOnlineUserListByPage.json',
		datatype : 'json',
		postData : {}
	}).trigger("reloadGrid");
	$("#dgSession").jqGrid('setGridParam', {
		datatype : 'local',
	}).trigger("reloadGrid");
}
</script>
</html>