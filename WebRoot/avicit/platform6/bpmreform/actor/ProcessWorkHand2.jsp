<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>

<title>AVICIT WORKFLOW 选人</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<script type="text/javascript" src="static/h5/singleLayOut/src/loading-mask.js"></script>
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap-theme.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/font-awesome-4.7.0/css/font-awesome.css"/>

<link rel="stylesheet" type="text/css" href="static/h5/jQuery-Timepicker-Addon-1.6.3/jquery-ui-1.12.1.custom/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/jquery.spinner-master/dist/css/bootstrap-spinner.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro.css" />

<link rel="stylesheet" type="text/css" href="static/h5/jqGrid-5.2.0/css/ui.jqgrid-bootstrap.css" />
<script type="text/javascript" src="static/js/platform/component/common/json2.js"></script>

<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="static/h5/bootstrap/3.3.4/js/bootstrap.js"></script>
<script type="text/javascript" src="static/h5/singleLayOut/src/jquery.resizable.js"></script>
<script type="text/javascript" src="static/h5/jquery-validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="static/h5/common-ext/h5-common-befer.js"></script>

<script type="text/javascript" src="static/h5/jqGrid-5.2.0/js/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="static/h5/jqGrid-5.2.0/js/jquery.jqGrid.custom.js"></script>

<script type="text/javascript" src="static/h5/jquery.spinner-master/dist/js/jquery.spinner.js"></script>
<script src="static/h5/layer-v2.3/layer/layer.js"></script>
<style type="text/css">
.check_no {
    width: 13px;
    height: 13px;
    background: url(static/images/platform/bpm/images/check_no.gif) no-repeat scroll 0 0 transparent;
    cursor: pointer;
}
.check_yes {
    width: 13px;
    height: 13px;
    background: url(static/images/platform/bpm/images/check_yes.gif) no-repeat scroll 0 0 transparent;
    cursor: pointer;
}
/*提示框背景颜色和字体颜色修改*/
.layui-layer-tips .layui-layer-content{
	background-color: #FAFAFA !important;
	color: #333;
}
.layui-layer-tips i.layui-layer-TipsB, .layui-layer-tips i.layui-layer-TipsT{
	border-right-color: #FAFAFA !important;
}
</style>
<script type="text/javascript">
var workhandJson = ${workhandJson};

var abc = [{"beginUserId":"402888125c1ecdec015c1f72e1f70081","beginUserName":"李aaaaaaaaaaaaa东","beginDeptId":null,"beginDeptName":"财aaaa务部","middleUserId":null,"middleUserName":null,"endUserId":"402888f95c34ec31015c3500b2840089","endUserName":"马六","endDeptId":"8a58ab4d4c2141fd014c217cdc5102b6","endDeptName":"研发中心","isBeginUser":true,"isEndUser":false}];
</script>
</head>
<body>
	<table id="workhandDataGrid"></table>
</body>
<script type="text/javascript">
var workhandDataGridObject;
$(document).ready(function () {
	var lastsel2;
   workhandDataGridObject = $("#workhandDataGrid").jqGrid({
    	datatype: "local",
		data: workhandJson,
		styleUI : 'Bootstrap',
        colModel: [
            { label: ' ', name: 'isBeginUser',width:40,hidden:true,sortable:false},
            { label: '委托人Id', name: 'beginUserId', width: 150,key: true, hidden:true},
            { label: '委托人', name: 'beginUserName', width: 100,sortable:false},
            { label: '委托人部门Id', name: 'beginDeptId', width: 150, hidden:true },
            { label:'委托人部门', name: 'beginDeptName', width: 150,sortable:false },
            { label:' ', name: 'isEndUser', width: 40,hidden:true,sortable:false},
            { label:'受托人Id', name: 'endUserId', width: 150, hidden:true },
            { label:'受托人', name: 'endUserName', width: 100,sortable:false },
            { label:'受托人部门Id', name: 'endDeptId', width: 150, hidden:true },
            { label:'受托人部门', name: 'endDeptName', width: 150,sortable:false}
            
        ],
    	onSelectRow: function(id,status){
    		if(status){
    			$("#workhandDataGrid" ).setRowData(  id , { isBeginUser: false , isEndUser: true  });
    		}else {
    			$("#workhandDataGrid" ).setRowData(  id , { isBeginUser: true , isEndUser: false  });
    		}
    	},
    	gridComplete:function(e){
    		var objIDs = $("#workhandDataGrid").jqGrid("getDataIDs");
    		for(var i = 0 ; i < objIDs.length ; i++){
    			$("#workhandDataGrid").jqGrid("setSelection",objIDs[i]);
    			$("#" + objIDs[i]).mouseover(function(){
    				var obj = $("#workhandDataGrid").jqGrid("getRowData",$(this).attr('id'));
    				layer.tips("选中后【" + obj.beginUserName + "】的待办工作将委托给【 " + obj.endUserName + "】",this,{
        				tips:3
        			});
        		});
    		}
    	  
    	},
		viewrecords: true,
		height: 250,
		width : 590,
        multiselect:true
    });
   
   function tips(cellvalue,options,rowObject){
	   return "<span class='autotip' beginUserName='" + rowObject.beginUserName + "' endUserName='" + rowObject.endUserName + "'>" + cellvalue + "</span>"; 
   }

});
function getWorkhandSelectedUsers(){
	return $("#workhandDataGrid").jqGrid("getRowData");
}
</script>
</html>
