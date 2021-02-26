<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<HTML>
<head>
<TITLE> ZTREE DEMO - Standard Data </TITLE>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- ControllerPath = "demo/demoreception/demoReceptionController/operation/Edit/id" -->
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="datasourceName">数据源名称:</label></th>
					<td width="39%">
						<input title="" class="form-control input-sm" type="text" name="datasourceName" id="datasourceName" value='<c:out value='${searchDatasourcesDTO.datasourceName}'/>'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="displayName">显示名称:</label></th>
					<td width="39%">
						<input title="" class="form-control input-sm" type="text" name="displayName" id="displayName" value='<c:out value='${searchDatasourcesDTO.displayName}'/>'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="connectionFk">数据库连接:</label></th>
					<td width="39%"  colspan="3">
						<select class="form-control" name="connectionFk" id="connectionFk" title="" isNull="true" />
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="sysroleFk">权限控制:</label></th>
					<td width="39%"  colspan="3">
						<select class="form-control" name="sysroleFk" id="sysroleFk" title="" isNull="true" />
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="status">有效标识:</label></th>
					<td width="39%"  colspan="3">
						<select class="form-control" name="status" id="status">
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="datasourceDesc">简要描述:</label></th>
					<td width="39%">
						<input title="" class="form-control input-sm" type="text" name="datasourceDesc" id="datasourceDesc" style="height:60px" value='<c:out value='${searchDatasourcesDTO.datasourceDesc}'/>'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="sqlStatement">SQL语句:</label></th>
					<td width="39%">
						<input title="" class="form-control input-sm" type="text" name="sqlStatement" id="sqlStatement"  style="height:60px" value='<c:out value='${searchDatasourcesDTO.sqlStatement}'/>'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="displayUrl">展示路径:</label></th>
					<td width="39%">
						<input title="" class="form-control input-sm" type="text" name="displayUrl" id="displayUrl" style="height:60px" value='<c:out value='${searchDatasourcesDTO.displayUrl}'/>'/>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right: 4%;float:right;display:block;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="demoSingle_saveForm">保存</a>
						<a href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="demoSingle_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		function closeForm(){
			parent.searchIndex.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			parent.searchIndex.saveEdit($('#form'),"eidt");
		}

		$(document).ready(function () {			
			$.ajax({  
	            url: 'platform/new/search/connection/listAll.html',  
	            data : {
				 	id : ""
				},
			    type : 'post',
	            dataType: "json",  
	            success: function (data) {  
	            	$("#connectionFk").append("<option>" + "</option>");
	                $.each(data, function (index, units) {  
	                    $("#connectionFk").append("<option value="+units.id+">" + units.connectionName + "</option>");  
	                });
	                $('#connectionFk').val('${searchDatasourcesDTO.connectionFk}');
	            },  

	            error: function (XMLHttpRequest, textStatus, errorThrown) {  
	                alert("error");  
	            }  
	        }); 
			$.ajax({  
	            url: 'platform/new/search/connection/listAuth.html',  
	            data : {
				 	id : ""
				},
			    type : 'post',
	            dataType: "json",  
	            success: function (data) {  
	            	$("#sysroleFk").append("<option>" + "</option>");
	                $.each(data, function (index, units) {  
	                    $("#sysroleFk").append("<option value="+units.id+">" + units.roleName + "</option>");  
	                });  
	                $("#sysroleFk").val('${searchDatasourcesDTO.sysroleFk}');
	            },  

	            error: function (XMLHttpRequest, textStatus, errorThrown) {  
	                alert("error");  
	            }  
	        }); 
			
			$("#status").val('${searchDatasourcesDTO.status}');
			
			$('.date-picker').datepicker();
			
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false//是否可以选择秒，默认否
			});
			//保存按钮绑定事件
			$('#demoSingle_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#demoSingle_closeForm').bind('click', function(){
				closeForm();
			});
			$('#applyUseridAlias').on('focus',function(e){
				// if(e.keyCode != '13'){
				// 	e.returnValue=false;
				// 	return false;
				// }
				new H5CommonSelect({type:'userSelect', idFiled:'applyUserid',textFiled:'applyUseridAlias'});
			}); 
			// $('#userbtn').on('click',function(){
			// 	new H5CommonSelect({type:'userSelect', idFiled:'applyUserid',textFiled:'applyUseridAlias'});
			// });
			$('#applyDeptidAlias').on('focus',function(e){
				// if(e.keyCode != '13'){
				// 	e.returnValue=false;
				// 	return false;
				// }
				new H5CommonSelect({type:'deptSelect', idFiled:'applyDeptid',textFiled:'applyDeptidAlias'});
			});
			// $('#deptbtn').on('click',function(){
			// 	new H5CommonSelect({type:'deptSelect', idFiled:'applyDeptid',textFiled:'applyDeptidAlias'});
			// });
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
			formValidate($('#form'));
		});
		//控件校验   规则：表单字段name与rules对象保持一致
	    formValidate = function(form) {
	    	form.validate({
	    		rules : {
	    			datasourceName : {
	    				required : true,
	    				maxlength : 50
	    			},
	    			displayName : {
	    				required : true,
	    				maxlength : 50
	    			},
	    			datasourceDesc : {
	    				required : true,
	    				maxlength : 500
	    			},
	    			sqlStatement : {
	    				required : true,
	    				maxlength : 500
	    			},
	    			displayUrl : {
	    				maxlength : 500
	    			},
	    		}
	    	});
	    }
		$(function(){
			$('.form_commonTable').delegate(".input-group-addon","click.auto",function(){
				$(this).parent().find('input[type="text"]').trigger('focus');
			});
		})
	</script>
</body>
</html>