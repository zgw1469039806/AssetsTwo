<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="static/js/platform/component/common/json2.js"></script>
<style type="text/css">
	.skins{
		width: 20px;
		height: 20px;
		float : left;
	}
</style>
</head>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'north'" style="height:280px;overflow: hidden;">
			<div class="toolbar-right" style="padding:4px 0 4px 4px;">
			   		<a id="save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="保存"><i class="icon icon-save"></i> 保存</a>
			 </div>
			<table width="100%" height="240px;" border="0" cellspacing="0" class="toolbar-right-table">
			  <tr>
			    <td width="30%" align="center" valign="middle">${previews}</td>
			    <td width="30%"  valign="middle"><table width="100%" border="0">
			      <tr>
			        <td height="30px" valign="top">名称:</td>
			        <td valign="top">${typeName}</td>
			      </tr>
			      <tr>
			        <td height="30px" valign="top">key:</td>
			        <td valign="top">${typeKey}</td>
			      </tr>
			      <tr>
			        <td height="30px" valign="top">实现类:</td>
			        <td valign="top">${impl}</td>
			      </tr>
			      <tr>
			      	<td height="30px" valign="top">皮肤:</td>
			        <td valign="top">${skins}</td>
			      </tr>
			      <tr>
			        <td>&nbsp;</td>
			        <td>&nbsp;</td>
			      </tr>
			    </table></td>
			  </tr>
			</table>
		</div>
        <div data-options="region:'center'" id="centerLayout" style="height:300px;">
        	<table id="roleList"></table>
        	<div id="jqGridPager1"></div>
        </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<!-- 模块js -->
<script type="text/javascript">
$(document).ready(function(){
	$('#centerLayout').css("height",document.documentElement.clientHeight - 20);
});
jQuery("#roleList").jqGrid({
	url : 'console/auth/${orgIdentity}/R/list?appId=${appId}',
	mtype : 'POST',
	datatype: "json",
	height : $(window).height() - 300,
	multiselect: true,
	styleUI : 'Bootstrap',
	rowNum: 5,
    rowList:[5,10,20],
    altRows:true,
    pagerpos:'left',
    pager: "#jqGridPager1",
    hasTabExport:false,
	hasColSet:false,
	viewrecords: true, //
	autowidth: true,
	responsive:true,
   	colModel:[
   		{name:'id',index:'id', width:55,hidden:true},
   		{name:'roleName',index:'roleName', label:'角色名称',width:410,align:"left"},
   		{name:'roleCode',index:'roleCode', label:'角色编码',width:300, align:"left"},
   		{name:'roleType',index:'roleType', label:'角色类型',width:300,hidden:false,formatter:formatter}
   	],
   	sortname: 'id',
   	gridComplete : function(){
   		setSelectedGrid();
   	},
    loadComplete: function () {
        //解决ie下出现两次滚动条问题
        if (navigator.userAgent.indexOf("MSIE 8.0") > -1
            || navigator.userAgent.indexOf("MSIE 9.0") > -1) {//ie
            $('.ui-jqgrid-bdiv').css("height",$(window).height()-350);
        } else if(navigator.userAgent.indexOf("Firefox") > 0){//Firefox
            $('.ui-jqgrid-bdiv').css("height",$(window).height()-348);
        }else {//谷歌
            $('.ui-jqgrid-bdiv').css("height",$(window).height()-356);
        }

    }
});
//jQuery("#roleList").jqGrid('navGrid','#jqGridPager1',{edit:false,add:false,del:false});
function formatter(cellvalue, options, rowObject){
	if(cellvalue == "0"){
		return "系统";
	}else{
		return "自定义";
	}
}
var typeKey = '${typeKey}';
//保存按钮绑定事件
$('#save').bind('click', function() {
	var ids = $("#roleList").jqGrid("getGridParam","selarrrow");
	if(ids == ''){
		top.layer.alert('请选择角色！',{title : '提示',icon: 7, area: ['400px', ''],closeBtn: 0});
		return;
	}
	$.ajax({
		url:'platform/console/portal/toSavePortalConfig',
		data : {
			typeKey : typeKey,
			skinsType : $("input[name='skinRadio']:checked").val(),
			roleListIds : JSON.stringify(ids),
			resourceType : 'role',
			appId : $('#appId').val(),
			orgIdentity : $('#orgIdentity').val()
		},
		dataType : "JSON",
		type : 'GET',
		success : function(msg){
			if( msg.responseText == 'sucess'){
				top.layer.msg('设置成功！',{
					icon: 1,
					area: ['200px', ''],
					closeBtn: 0
				});
			} else {
				top.layer.alert('设置失败！',{
					  icon: 7,
					  area: ['400px', ''],
					  closeBtn: 0,
					  title:'提示'
				    }
		         );
			}
		},
		error : function(msg){
			if( msg.responseText == 'sucess'){
				top.layer.msg('设置成功！',{
					icon: 1,
					area: ['200px', ''],
					closeBtn: 0
				});
			} else {
				top.layer.alert('设置失败！',{
					  icon: 7,
					  area: ['400px', ''],
					  closeBtn: 0,
					  title:'提示'
				    }
		         );
			}
		}
	});
});
//设置行选中
function setSelectedGrid(){
	$.ajax({
		url:'platform/console/portal/getPortalConfig',
		data : {
			typeKey : typeKey,
			resourceType : 'role',
			appId : '${appId}'
		},
		dataType : "JSON",
		type : 'GET',
		success : function(msg){
			var skinsType;
			for(var i = 0 ; i < msg.length ; i++){
				$("#roleList").jqGrid("setSelection",msg[i].resourceId);
				skinsType = msg[i].skinsType;
			}
			if(skinsType){
				$("input[name='skinRadio'][value='" + skinsType + "']").attr("checked",true); 
			}
		},
		error : function(msg){
			alert('error');
		}
	});
}

</script>
<input type='hidden' id='appId' name='appId' value='${appId }'>
<input type='hidden' id='orgIdentity' name='orgIdentity' value='${orgIdentity }'>
</body>
</html>