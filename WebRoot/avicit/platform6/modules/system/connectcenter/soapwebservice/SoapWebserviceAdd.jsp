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
<!-- ControllerPath = "train/demo/soapwebservice/soapWebserviceController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style type="text/css">
#paradiv{
  padding-top: 0px;
    padding-right: 0px;
    padding-bottom: 0px;
    padding-left: 0px;
}
#paramhead{
    text-align : center;
}
#param1{
    background-color : #fff;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
		<input type="hidden" id="classId" name="classId">
			<table class="form_commonTable" id="wsTable">
				<tr>
					<th width="15%"><label for="id">标识:</label></th>
					<td colspan="3" width="85%"><input class="form-control input-sm"
						type="text" style="border-style:none;border:0px;width: 100%;font-weight:bold;font-style:italic;" name="id" id="id" readonly="readonly"/></td>
				</tr>
				<tr >
					<th width="15%"><label for="name">名称:</label></th>
					<td colspan="3" width="85%"><input class="form-control input-sm"
						type="text" name="name" id="name" /></td>
				</tr>
				<tr>
					<th width="15%"><label for="changeType">认证方式:</label></th>
					<td colspan="3" width="85%">
						<label class="radio-inline">
						    <input type="radio"  value="1" class="merchantzc_radio" checked name="changeType">无  
						</label>
						<label class="radio-inline">
						    <input type="radio"  value="0" class="merchantzc_radio" name="changeType">用户名口令
						</label>
					</td>
				</tr>
				<tr id="trUser" style="display:none">
					<th width="15%"><label for="user">用户:</label></th>
					<td colspan="3" width="85%"><input class="form-control input-sm"
						type="text" name="user" id="user"/></td>
				</tr>
				<tr id="trPassword" style="display:none">
					<th width="15%"><label for="password">口令:</label></th>
					<td colspan="3" width="85%"><input class="form-control input-sm"
						type="text" name="password" id="password"/></td>
				</tr>
				<tr>
					<th width="15%"><label for="wsdlurl">WSDL URL:</label></th>
					<td colspan="3" width="85%"><input class="form-control input-sm"
						type="text" name="wsdlurl" id="wsdlurl" placeholder="http://localhost:8001/Service/helloWorld?wsdl" onchange="resloveWsdlurl()"/></td>
				</tr>
				<tr>
					<th width="15%"><label for="wsinterface">端口:</label></th>
					<td colspan="3" width="85%">
						<select class="form-control" name="wsinterface" id="wsinterface" title="" isNull="true" onchange="resloveInterface(this)" />
					</td>
					<input type="hidden" name="soapVersion" id="soapVersion" />
					<input type="hidden" name="paramNum" id="paramNum" />
					<input type="hidden" name="authType" id="authType" />
					<input type="hidden" name="soapAction" id="soapAction" />
				</tr>
				<tr>
					<th width="15%"><label for="method">操作:</label></th>
					<td colspan="3" width="85%">
						<select class="form-control" name="method" id="method" title="" isNull="true" onchange="resloveMethod(this)"/>
					</td>
				</tr>
			</table>
			<table class="form_commonTable" id="paramTable">
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="保存" id="soapWebservice_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="soapWebservice_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script src="avicit/platform6/modules/system/connectcenter/database/js/Guid.js"></script>
	<script type="text/javascript">
		var avicAjaxLoading2;
		var avicAjaxLoading3;
		var avicAjaxLoading4;
		var changeTypeValue = "";
		function closeForm(){
			parent.layer.close(parent.layer.getFrameIndex(window.name));
		}
		
		function saveForm(classId){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.soapwebservice.save($('#form'),"insert",classId);
			  parent.layer.close(parent.layer.getFrameIndex(window.name));
		}
		function resloveWsdlurl(){
			avicAjaxLoading2 = layer.load(2,{shade: [0.2, '#000'],scrollbar: false});
			$("#wsinterface").empty();
			$("#method").empty();
			$("#soapAction").val("");
			removeTable();
			$.ajax({
				url : 'platform/soapwebservice/soapWebserviceController/operation/resolveWsdlurl',
				data : {wsdlurl:$('#wsdlurl').val()},
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success"){
						$("#wsinterface").append("<option></option>"); 
						$.each(r.wsdlInterfaceNameList, function (index, units) { 
		                    $("#wsinterface").append("<option value="+units.wsinterface+" data-operation="+units.soapVersion+" >" + units.wsinterface + "</option>");  
		                });
						$("#wsinterface").on('change',function(){
							var str = $(this).find('option:selected').data('operation');
							$('#soapVersion').val(str);
						});
					}else{
						layer.alert('操作失败！' + "解析wsdlurl出错，请检查服务是否开启！",{
					  		icon: 7,
					  		area: ['400px', ''], //宽高
					  		closeBtn: 0
				    		});
					}
					
					layer.close(avicAjaxLoading2);
				}
			});
		}
		
		function resloveInterface(obj){
			avicAjaxLoading3 = layer.load(2,{shade: [0.2, '#000'],scrollbar: false});
			var value = obj.options[obj.selectedIndex].value;
			$("#method").empty();
			$("#soapAction").val("");
			removeTable();
			$.ajax({
				url : 'platform/soapwebservice/soapWebserviceController/operation/resolveWsdlMethod',
				data : {wsinterface:value,wsdlurl:$('#wsdlurl').val()},
				contentType : 'application/json',
				type : 'get',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success"){
						$("#method").append("<option></option>"); 
						$.each(r.wsdlOperNameList, function (index, units) {  
		                    $("#method").append("<option value="+units+">" + units + "</option>");  
		                });
					}else{
						layer.alert('操作失败！' + r.error,{
					  		icon: 7,
					  		area: ['400px', ''], //宽高
					  		closeBtn: 0
				    		});
					}
					layer.close(avicAjaxLoading3);
				}
			});
		}
		
		function resloveMethod(obj){
			avicAjaxLoading4 = layer.load(2,{shade: [0.2, '#000'],scrollbar: false});
			$("#soapAction").val("");
			removeTable();
			$.ajax({  
	            url: 'platform/soapwebservice/soapWebserviceController/operation/resolveWsdlParam',  
	            data : {
	            	soapVersion:$('#soapVersion').val(),
	            	wsMethod : $('#method').val(),
				 	wsdlurl:$('#wsdlurl').val()
				},
				contentType : 'application/json',
			    type : 'get',
	            dataType: "json",  
	            success: function (r) {
	            	if (r.flag == "success"){
	            		var parahead = '<tr>';
	           			parahead+= '<th colspan="2" width="15%"><label for="method">参数:</label></th>'
	        			parahead+= '<td width="42%" id="paradiv">';
	        			parahead+= '<input class="form-control input-sm" readonly="true" type="text" id="paramhead" value="名称" placeholder=""/>';
	        			parahead+= '</td>';
	        			parahead+= '<td width="42%" id="paradiv">';
	        			parahead+= '<input class="form-control input-sm" readonly="true" type="text" id="paramhead" value="值" placeholder=""/>';
	        			parahead+= '</td>';
	        			parahead+= '</tr>';
	        			$("#paramTable").append(parahead);
		        		var paranum = 0;
		            	$.each(r.paramList, function (index, units) { 
		            		var str = '<tr>';
		            			str+= '<th colspan="2" width="15%">';
		            			str+= '</th>';
		            			str+= '<td width="42%" id="paradiv">';
		            			str+= '<input class="form-control input-sm" readonly="true" type="text" id="param1" name="paramN'+index+'" value="'+units+'" placeholder=""/>';
		            			str+= '</td>';
		            			str+= '<td width="42%" id="paradiv">';
		            			str+= '<input class="form-control input-sm" type="text" name="paramV'+index+'" placeholder=""/>';
		            			str+= '</td>';
		            			str+= '</tr>';	            		
		            		$("#paramTable").append(str);
		            		paranum= paranum+1;
		                });
		            	$("#paramNum").val(paranum);
		            	$("#soapAction").val(r.soapAction);
	            	}else{
						layer.alert('操作失败！' + r.error,{
					  		icon: 7,
					  		area: ['400px', ''], //宽高
					  		closeBtn: 0
				    		});
					}
	            	layer.close(avicAjaxLoading4);
	            }  
	        });
		}
		function removeTable(){
			var tb = document.getElementById('paramTable');
		     var rowNum=tb.rows.length;
		     for (i=0;i<rowNum;i++)
		     {
		         tb.deleteRow(i);
		         rowNum=rowNum-1;
		         i=i-1;
		     }
		}
		$(document).ready(function () {
			var guid = new GUID();
			$('#id').val(guid.newGUID());
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
			 $("#classId").val(parent.connectTypeTree.selectedNodeId);
			
			parent.soapwebservice.formValidate($('#form'));
			//保存按钮绑定事件
			$('#soapWebservice_saveForm').bind('click', function(){
				saveForm($("#classId").val());
			}); 
			//返回按钮绑定事件
			$('#soapWebservice_closeForm').bind('click', function(){
				closeForm();
			});
			
			//添加验证规则：逗号格式校验
			jQuery.validator.addMethod("comma", function(value, element){
				return this.optional(element) ||!value.match(/，/);
			}, "不能包含全角(中文)逗号！");
			
			//radio切换
			changeTypeValue = $('input[name="changeType"]:checked ').val();
			$("#authType").val(changeTypeValue);
	        if(changeTypeValue == 0){  
	        	document.getElementById('trUser').style.display = '';
            	document.getElementById('trPassword').style.display = '';
	        }  
	        if(changeTypeValue == 1){  
	        	document.getElementById('trUser').style.display = 'none';
            	document.getElementById('trPassword').style.display = 'none';
	        }  
	        $(".merchantzc_radio").click(function(){  
	            changeTypeValue = $('input[name="changeType"]:checked ').val();  
	            $("#authType").val(changeTypeValue);
	            if(changeTypeValue == 0){  
	            	document.getElementById('trUser').style.display = '';
	            	document.getElementById('trPassword').style.display = '';
	            	$("#user").val('');
	            	$("#password").val('');
	            }  
	            if(changeTypeValue == 1){  
	            	document.getElementById('trUser').style.display = 'none';
	            	document.getElementById('trPassword').style.display = 'none';
	            	$("#user").val('');
	            	$("#password").val('');
	            }  
	        })
																																																																																																																									
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>