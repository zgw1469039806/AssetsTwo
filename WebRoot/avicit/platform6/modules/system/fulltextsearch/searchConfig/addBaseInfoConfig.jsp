<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "test/demo/syssearchinfo/sysSearchInfoController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" id="id"/>
			<input type="hidden" id="classifyName" name="classifyName"/>
			<input type="hidden" name="indexType" id="indexType" />
			<input type="hidden" name="attribute03" id="attribute03" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="name">名称:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="name" id="name" /></td>
					<th width="10%"><label for="classify">分类:</label></th>
					<td width="39%">
						<select class="form-control" name="classify" id="classify" title="" isNull="true" />
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="changeType">检索类型:</label></th>
					<td colspan="3" width="85%">
						<label class="radio-inline">
						    <input type="radio"  value="1" class="merchantzc_radio" checked name="changeType">数据存储  
						</label>
						<label class="radio-inline">
						    <input type="radio"  value="0" class="merchantzc_radio" name="changeType">磁盘文件
						</label>
					</td>
				</tr>
				<tr id="displayDS">
					<th width="10%"><label for="dataSource">数据源:</label></th>
					<td colspan="3" width="39%">
						<select class="form-control" name="dataSource" id="dataSource" title="" isNull="true" onChange="openCC(this)">
							<option value = "local">本地数据源</option>
							<option value = "cc">cc数据源</option>
						</select>
					</td>
				</tr>
				<tr id="displayAtt2" style="display:none">
					<th width="10%"><label for="attribute02">cc数据源:</label></th>
					<td colspan="3" width="39%">
						<input class="form-control" type="text" placeholder="请选择cc数据源..." name="attribute02" id="attribute02" readonly/>
					</td>
				</tr>
				<tr id="displayAtt1" style="display:none">
					<th width="10%"><label for="attribute01">检索路径:</label></th>
					<td colspan="3" width="39%">
						<input class="form-control" type="text" placeholder="请选择磁盘文件..." name="attribute01" id="attribute01" readonly/>
					</td>
				</tr>
				<tr id="displaySQL">
					<th width="10%"><label for="sqlState">SQL语句:</label></th>
					<td colspan="3" width="39%"><textarea class="form-control input-sm" rows="3"
						name="sqlState" id="sqlState"></textarea></td>
				</tr>
				<tr id="displayOpenType">
					<th width="10%"><label for="openType">打开方式:</label></th>
					<td colspan="3" width="39%">
						<select class="form-control" name="openType" id="openType" title="" isNull="true">
							<option value = "dialog">dialog</option>
							<option value = "mainFrame">mainFrame</option>
							<option value = "tab">tab</option>
						</select>
					</td>
				</tr>
				<tr id="displayOpenUrl">
					<th width="10%"><label for="openUrl">打开URL:</label></th>
					<td colspan="3" width="39%"><input class="form-control input-sm"
						type="text" name="openUrl" id="openUrl" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="description">描述:</label></th>
					<td colspan="3" width="39%"><textarea class="form-control input-sm" rows="3"
						name="description" id="description"></textarea></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="保存" id="sysSearchInfo_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="sysSearchInfo_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script src="avicit/platform6/modules/system/fulltextsearch/openRemoteFile/openRemoteFile.js"></script>
	<script src="avicit/platform6/modules/system/fulltextsearch/openCCFile/openCCFile.js"></script>
	<script type="text/javascript">
		var openRemoteFile = new OpenRemoteFile("attribute01");
		openRemoteFile.init();
		var openCCFile = new OpenCCFile("attribute03","attribute02");
		openCCFile.init();
		var changeTypeValue = "";
		function closeForm(){
			parent.parent.searchInfo.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	        //限制保存按钮多次点击
  		 	$('#sysSearchInfo_saveForm').addClass('disabled');	
			parent.parent.searchInfo.save($('#form'),"insert");
		}
	
		$(document).ready(function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
				beforeShow: function(selectedDate) {
					if($('#'+selectedDate.id).val()==""){
						$(this).datetimepicker("setDate", new Date());
						$('#'+selectedDate.id).val('');
					}
				}
			});
			//$("#classify").val(parent.parent.searchTypeTree.selectedNodeId);
			$('#id').val("${param.infoId}");
			parent.parent.searchInfo.formValidate($('#form'));
			
			//radio切换
			changeTypeValue = $('input[name="changeType"]:checked ').val();
			$("#indexType").val(changeTypeValue);
			$(".merchantzc_radio").click(function(){ 
				changeTypeValue = $('input[name="changeType"]:checked ').val();  
	            $("#indexType").val(changeTypeValue);
	            if(changeTypeValue == 0){  
	            	document.getElementById('displayDS').style.display = 'none';
	            	document.getElementById('displaySQL').style.display = 'none';
	            	document.getElementById('displayOpenType').style.display = 'none';
	            	document.getElementById('displayOpenUrl').style.display = 'none';
	            	document.getElementById('displayAtt2').style.display = 'none';
	            	document.getElementById('displayAtt1').style.display = '';
	            	$("#attribute01").val('');
	            	$("#sqlState").val('');
	            	$("#openType").val('dialog');
	            	$("#openUrl").val('');
	            	$("#dataSource").val('local');
	            	$("#attribute02").val('');
	            }  
	            if(changeTypeValue == 1){  
	            	document.getElementById('displayDS').style.display = '';
	            	document.getElementById('displaySQL').style.display = '';
	            	document.getElementById('displayOpenType').style.display = '';
	            	document.getElementById('displayOpenUrl').style.display = '';
	            	document.getElementById('displayAtt1').style.display = 'none';
	            	$("#attribute01").val('');
	            	$("#sqlState").val('');
	            	$("#openType").val('dialog');
	            	$("#openUrl").val('');
	            	$("#dataSource").val('local');
	            }
			});
			
			//保存按钮绑定事件
			$('#sysSearchInfo_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#sysSearchInfo_closeForm').bind('click', function(){
				closeForm();
			});
			//获取分类列表
			$.ajax({  
	            url: 'platform/fulltextSearch/fulltextSearchController/operation/getLastNodeList',  
			    type : 'get',
	            dataType: "json",  
	            success: function (data) {  
	                $.each(data, function (index, units) {  
	                    $("#classify").append("<option value="+units.id+" data-operation ="+ units.name +">" + units.name + "</option>");  
	                }); 
	                $("#classify").val(parent.parent.searchTypeTree.selectedNodeId);
	                $("#classifyName").val(parent.parent.searchTypeTree.selectedNodeName);
	                $("#classify").on('change',function(){
						var str = $(this).find('option:selected').data('operation');
						$('#classifyName').val(str);
					}); 
	            },  

	            error: function (XMLHttpRequest, textStatus, errorThrown) {  
	                alert("error");  
	            }  
	        }); 
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>