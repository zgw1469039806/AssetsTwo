<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table";
%>
<!DOCTYPE html>
<html>
<head>
<title>人员密级与文档密级关系管</title>
<!-- syssecret/toSecret -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style>
.imgOffOn{
	cursor:pointer;
}
</style>
</head>
<body class=" easyui-layout" fit="true">
	 <div data-options="region:'center', onResize:function(a){$('#demoMainDept').setGridWidth(a);$(window).trigger('resize');}">
		 <div id="tableToolbar" class="toolbar">
			<h4>人员密级</h4>
		</div>
		<table id="dataGridMain"></table>
	</div>
	<div data-options="region:'east',collapsible:false,split:true,width:fixwidth(.5),onResize:function(a){$('#demoSubUser').setGridWidth(a);$(window).trigger('resize');}">
		<div id="tableToolbarSub" class="toolbar">
			<h4>文档密级</h4>
		</div>
		<table id="dataGridSub"></table>
	</div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<script>
	window.changeSingleAuth = function(element) {
		var wordSecret = element.alt;
		if(!wordSecret)
			return;
		if(!window.SECRET_ID) {
			return;
		}
		$.ajax({
			url: "platform/syssecret/saveSingleSetAuth.json",
			type: "POST",
			dataType: "json",
			data: {
				userSecret: window.SECRET_ID,
				wordSecret: wordSecret
			},
			success: function(result) {
				if(!result || "success" != result.flag ){
					layer.msg('修改失败！');
					return;
				}
	    		var searchdata = {userSecret: window.SECRET_ID};
	        	$("#dataGridSub").jqGrid('setGridParam',{datatype:'json', datatype: 'json',postData: searchdata}).trigger("reloadGrid");
			}
		});	
		
	};
	function remarkformat(cellvalue, options, rowObject) {
		if ("1" == cellvalue){
			return "<img src='static/images/platform/sysmenuaccesscontrol/ok.png' class='imgOffOn' title='允许访问' onclick='window.changeSingleAuth(this);' alt="
			+ rowObject['lookupCode'] + ">";
		}else{
			return "<img src='static/images/platform/sysmenuaccesscontrol/no.gif' class='imgOffOn' title='禁止访问' onclick='window.changeSingleAuth(this);' alt="
			+ rowObject['lookupCode'] + ">";
		}
	}

	$(document).ready(function () {
		var dataGridMain = [
   			  {label :'人员密级数值', name : 'lookupCode',sortable:false, key : true, width : 100}
   			, {label : '文档密级', name : 'lookupName',sortable:false, width : 100 }
   		];
		
		var dataGridSub = [
			  {label :'文档密级数值', name : 'lookupCode',sortable:false, key : true, width : 100}
			, {label : '文档密级', name : 'lookupName',sortable:false, width : 100 }
			, { label : '访问权限', name : 'remark',sortable:false, width : 100, formatter : remarkformat}
		];
		
		var issubinit = false;
		$('#dataGridMain').jqGrid({
			url : 'platform/syssecret/getUserSecretList.json',
			mtype : 'POST',
			datatype : "json",
			colModel : dataGridMain,
			height : $(window).height() - 120,
			scrollOffset : 20, //设置垂直滚动条宽度
			altRows : true,
			userDataOnFooter : true,
			pagerpos : 'left',
			styleUI : 'Bootstrap',
			viewrecords : true,
			multiboxonly : true,
			forceFit: true,
			multiselect : true,
			repeatitems:true,
			autowidth : true,
			responsive : true,
	        onSelectRow: function(rowid) {
	        	if(issubinit){
	        		var searchdata = {userSecret:rowid};
		        	$("#dataGridSub").jqGrid('setGridParam',{datatype:'json', datatype: 'json',postData: searchdata}).trigger("reloadGrid");
					window.SECRET_ID = rowid;
	        	}
	        },
	        loadComplete:function(){
	        	var rowdata = $('#dataGridMain').jqGrid('getRowData');
	        	if(issubinit == false){
	        		var p_lookupCode = "";
			        if(rowdata != null && rowdata.length > 0){
			            $('#dataGridMain').setSelection(rowdata[0].lookupCode);
			        	p_lookupCode = rowdata[0].lookupCode;
			        	window.SECRET_ID = rowdata[0].lookupCode;
		        	}else{
		        		var p_lookupCode = "-1";
		        	}
			        $("#dataGridSub").jqGrid({
		            	url: 'platform/syssecret/getWordSecretList.json',
		            	postData : {userSecret : p_lookupCode},
		                mtype: 'POST',
		                datatype: "json",
		                colModel: dataGridSub,
		                height:$(window).height()-120-17,
		                scrollOffset: 10,
		                altRows:true,
		                pagerpos:'left',
		                styleUI : 'Bootstrap', 
		                forceFit: true,
		        		viewrecords: true, 
		        		multiselect: true,
		        		autowidth: true,
		        		responsive:true
		            });
		            issubinit = true;
		        }else{
		        	if(rowdata != null && rowdata.length > 0){
			            $('#dataGridMain').setSelection(rowdata[0].lookupCode);
			        	window.SECRET_ID = rowdata[0].lookupCode;
			        	var searchdata = {userSecret:rowdata[0].lookupCode};
			        	$("#dataGridSub").jqGrid('setGridParam',{datatype:'json', datatype: 'json',postData: searchdata}).trigger("reloadGrid");

		        	}else{
			        	var searchdata = {userSecret:"-1"};
			        	$("#dataGridSub").jqGrid('setGridParam',{datatype:'json', datatype: 'json',postData: searchdata}).trigger("reloadGrid");
		        	}
	        	}
	        }
		});
		
	    $("#t_dataGridMain").append($("#tableToolbar"));
	    $("#t_dataGridSub").append($("#tableToolbarSub"));
	});
</script>
</body>
</html>
