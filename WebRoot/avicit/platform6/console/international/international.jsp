<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<c:choose>
   <c:when test='${state eq "1"}'>
    <div data-options="region:'north'" style="height:90px;padding:5px;">
		<font color="red"><b>提示：</b>
		<br>1:当您编辑多语言数据，提交服务器以后，系统会在一分钟之内自动刷新缓存，
		<br>2:多语言编辑只会对运行文件（WEB-INF\classes\i18n\model_XX_XX.properties）进行修改。如果您是WAR包部署方式请及时备份资源文件，修改WAR包对应的资源文件，以免修改的数据丢失。
		<br>3:在您进行系统开发时，如果存在多语言的用户需求，平台建议按组件粒度将多语言文件配置进来 。</font>
	</div>
	<div data-options="region:'center'" style="border:0px">
		<div id="tableToolbar" class="toolbar">
		 	<table class="form_commonTable">
		 		<tr>
		 		<td width="10%">
		 		<label>请选择语言文件：</label>
		 		</td>
		 		<td width="12%">
					<select id="cc" class="form-control input-sm" name="state">
					<c:forEach items="${models}" var="e">
						<c:choose>
						   <c:when test="${model eq e}">
						    <option selected="selected" value="${e}">${e}</option>
						   </c:when>
						   <c:otherwise>
						     <option value="${e}">${e}</option>
						   </c:otherwise>
						</c:choose>
			        </c:forEach>
					</select>
				</td>
		 		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_international_button_add" permissionDes="添加">
					<td width="5%"><a id="international_add" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" onclick="add();" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a></td>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_international_button_edit" permissionDes="编辑">
					<td width="63%"><a id="international_edit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" onclick="modify();" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a></td>
				</sec:accesscontrollist>
				</tr>
		 	</table>
	 	</div>
	 	<table id="dgsysinternationalManage"></table>
	 	<div id="jqGridPager"></div>
	</div>
   </c:when>
   <c:otherwise>
        <div data-options="region:'center'" style="padding:10px;">
		<font color="red"><b>提示：</b><br>${msg}</font>
	</div>
   </c:otherwise>
</c:choose>
	<div id="editor" title="多语言编辑器">
		<form id='form' method="post">
    		<table  class="form_commonTable">
    			<tr>
    				<td><font color="red"><b>* </b></font>多语言键值：</sfn></td>
    				<td>
						<div class=""><input type="text" class="form-control input-sm" name="key" onkeyup="this.value=this.value.replace(/[^a-zA-Z]/g,'')" onchange="this.value=this.value.replace(/[^a-zA-Z]/g,'')"  required="true" id="key" style="width:350px;ime-mode: disabled;" ></input></div>
    				</td>
    			</tr>
    			<c:forEach items="${lang}" var="e" varStatus="s">
	    			<tr>
	    				<td><font color="red"><b>* </b></font>${e}：</td>
	    				<td>
							<div class=""><input class="form-control input-sm"  name="${loc[s.count-1]}" required="true" id="${loc[s.count-1]}" style="width:350px;" ></input></div>
	    				</td>
	    			</tr>
		        </c:forEach>
    		</table>
	    </form>
  </div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
	//----------------------------------------------------------------------
	//<summary>
	//限制只能输入字母
	//</summary>
	//----------------------------------------------------------------------
	$.fn.onlyAlpha = function () {
	 $(this).keypress(function (event) {
	     var eventObj = event || e;
	     var keyCode = eventObj.keyCode || eventObj.which;
	     if ((keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122))
	         return true;
	     else
	         return false;
	 }).focus(function () {
	     this.style.imeMode = 'disabled';
	 }).bind("paste", function () {
 		 var e = window.event || arguments.callee.caller.arguments[0];
		 if(e.clipboardData) {
			 for (var i = 0, len = e.clipboardData.items.length; i < len; i++) {
				 var item = e.clipboardData.items[i];
				 if (item.kind === "string") {
					 e.preventDefault();
					 item.getAsString(function (str) {
						 if (/^[a-zA-Z]+$/.test(str)){
							 document.getElementById("key").value=document.getElementById("key").value+str;
						 }else{
							 document.getElementById("key").value=document.getElementById("key").value;
						 }
					 })
				 } else if (item.kind === "file") {
					 var f= item.getAsFile();
					 console.log(f);
				 }
			 }
		 }else if(window.clipboardData) {
			 var txt = window.clipboardData.getData("Text");
			 console.log(txt);
			 if (/^[a-zA-Z]+$/.test(txt)){
				 return true;
			 }else{
				 return false;
			 }

		 }else {
			 console.log('浏览器版本过低');
		 }
	 });

	};
	 
	function add(){
		$("#key").attr("readonly",false); 
		$("#key").val("");
		<c:forEach items="${lang}" var="e" varStatus="s">	$("#${loc[s.count-1]}").val(""); </c:forEach>
		
		index = layer.open({
			type: 1,
			shift: 5,
			title: '添加',
			scrollbar: false,
			move : false,
			area: ['500px', '350px'],
			closeBtn: 0,
			shadeClose: true,
			btn: ['保存', '返回'],
			content: $('#editor'),
			yes: function(index, layero){
				save(index);
			},
			btn1: function(index, layero){
				layer.close(index);
			}
		});
	};
	
	function modify(){
		var ids = $("#dgsysinternationalManage").jqGrid('getGridParam','selarrrow');
		if(ids.length == 0){
			layer.alert('请选择要编辑的数据！', {icon : 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
			return false;
		}else if(ids.length > 1){
			layer.alert('只允许选择一条数据进行编辑！', {icon : 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
			return false;
		}
		var rowData = $("#dgsysinternationalManage").jqGrid('getRowData', ids[0]);
		$("#key").attr("readonly",true); 
		$("#key").val(rowData.key);
		<c:forEach items="${lang}" var="e" varStatus="s">	$("#${loc[s.count-1]}").val(rowData.${loc[s.count-1]}); </c:forEach>
		index = layer.open({
			type: 1,
			shift: 5,
			title: false,
			scrollbar: false,
			move : false,
			area: ['500px', '350px'],
			closeBtn: 0,
			shadeClose: true,
			btn: ['保存', '返回'],
			content: $('#editor'),
			yes: function(index, layero){
				save(index);
			},
			btn1: function(index, layero){
				layer.close(index);
			}
		});
	};
	function save(index){
		var validate = true;
		$("#form :input").each(function(){
			if(this.value == ""){
				layer.msg('请输入数据！');
				this.focus();
				validate = false;
				return false;
			}
		});
		if(!validate) return false;
		var submitdata = {
				key:$("#key").val(),
				values:[
					<c:forEach items="${lang}" var="e" varStatus="s">
					$("#${loc[s.count-1]}").val(),
					</c:forEach>
					""
				],
				locals:[
				   <c:forEach items="${lang}" var="e" varStatus="s">
					"${loc[s.count-1]}",
					</c:forEach>
					""
				]
		};
		var model =  $("#cc").val();
		$.ajax({
			 url:"sysInternationalController/operation/save?model=" + model,
			 data :{data:JSON.stringify(submitdata)},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					layer.msg('保存成功！');
					$("#dgsysinternationalManage").jqGrid('setGridParam',{}).trigger("reloadGrid");
					layer.close(index);
				 }else{
					 layer.alert('保存失败！' + r.error, {
						  icon: 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0,
						  title :'提示'

						}
					);
				 } 
			 }
		 });
	};
	
	$(function(){
		$("#dgsysinternationalManage").jqGrid({
	    	url: 'sysInternationalController/listH5.json?model=${model}',
	        mtype: 'POST',
	        datatype: "json",
	        colModel: [
                   { label: '多语言键值', name: 'key', key: true, width: 100}
               <c:forEach items="${lang}" var="e" varStatus="s">
              	 ,{ label: '${e}', name: '${loc[s.count-1]}', key: true, width: 100}
               </c:forEach>
	        ],
	        toolbar: [true,'top'],
	        height:$(window).height()-240,
	        scrollOffset: 20,
	        rowNum:100,
	        rowList:[2000,1000,500,100],
	        altRows:true,
	        userDataOnFooter: true,
	        pagerpos:'left',
			loadComplete:function(){
				$(this).jqGrid('getColumnByUserIdAndTableName');
			},
			viewrecords: true,
	        styleUI : 'Bootstrap',
			multiselect: true,
			autowidth: true,
			shrinkToFit: true,
			hasTabExport:false, //导出
			hasColSet:false,  //设置显隐
			responsive:true,//开启自适应
	        pager: "#jqGridPager"
	    });
		
	    $("#t_dgsysinternationalManage").append($("#tableToolbar"));
		$("#key").onlyAlpha();
		$("#cc").on({"change":
			function () {
				location="<%=ViewUtil.getRequestPath(request)%>/sysInternationalController/initPageH5?model=" + this.value;
			}
		});
	});
</script>
</html>