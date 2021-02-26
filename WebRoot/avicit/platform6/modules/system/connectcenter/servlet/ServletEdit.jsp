<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.Map" %> 
<%@ page import="java.util.HashMap" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "train/demo/restFul/restFulController/operation/Edit/id" -->
<title>编辑</title>
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
			<input type="hidden" name="version"
				value="${servletDTO.version}" /> 
			<table class="form_commonTable">
				<tr>
					<th width="15%"><label for="id">标识:</label></th>
					<td colspan="3" width="85%"><input class="form-control input-sm"
						type="text" style="border-style:none;border:0px;width: 100%;font-weight:bold;font-style:italic;" name="id" id="id" readonly="readonly" value="${servletDTO.id}"/> </td>
				</tr>
				<tr>
					<th width="15%"><label for="name">名称:</label></th>
					<td colspan="3" width="85%"><input class="form-control input-sm"
						type="text" name="name" id="name" value="${servletDTO.name}"/></td>
				</tr>
				<tr>
					<th width="15%"><label for="url">url:</label></th>
					<td colspan="3" width="85%"><input class="form-control input-sm"
						type="text" name="url" id="url" placeholder=""  value="${servletDTO.url}"/></td>
				</tr>
				
			</table>
			<c:set var="paramIndex" value="0"></c:set>
			<table class="form_commonTable" id="paramTable">
				<tbody>
					<tr>
						<th colspan="2" width="15%">
							<label>请求参数：</label>
						</th>
						<td width="34%" id="paradiv">
							<input class="form-control input-sm" readonly="true" type="text" id="paramhead" value="名称" placeholder=""/>
						</td>
						<td width="34%" id="paradiv">
							<input class="form-control input-sm" readonly="true" type="text" id="paramhead" value="值" placeholder=""/>
						</td>
						<td width="10%" id="paradiv">
							<input class="form-control input-sm" readonly="true" type="text" id="paramhead" value="操作" placeholder=""/>
						</td>
						<th width="50px;" id="paradiv">
							<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="添加" id="addParam">添加</a>
						</th>
					 </tr>
					<c:forEach var="mymap" items="${servletDTO.paramMap}">
					<c:set var="paramIndex" value="${paramIndex+1}"></c:set>
					<tr>
						<th colspan="2" width="15%">
						</th>
						<td width="34%" id="paradiv">
						<input class="form-control input-sm" type="text" id="param1" name="paramN${paramIndex}" value="${mymap.key }" placeholder=""/>
						</td>
						<td width="34%" id="paradiv">
						<input class="form-control input-sm" type="text" name="paramV${paramIndex}" value="${mymap.value }" placeholder=""/>
						</td>
						<td width="10%" style="text-align:center;" id="paradiv">
						 <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="删除" id="delParam" onClick="delParam(this)">删除</a>
						</td>
						<th width="50px;" id="paradiv">
						</th>
					</tr>	     
					</c:forEach>
				</tbody>
				
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="测试连接" id="servlet_TestConnection">测试连接</a> 
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="servlet_saveForm">保存</a> 
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="servlet_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		var paramIndex=${paramIndex};
		function deleteAllTableData(tableId){
			$("#"+tableId+" tr:not(:first)").html("");
		}
		function closeForm(){
			parent.layer.close(parent.layer.getFrameIndex(window.name));
		}
		function saveForm(calssId){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			parent.servlet.saveEdit($('#form'),"eidt",calssId);
			parent.layer.close(parent.layer.getFrameIndex(window.name));
		}

		function testServlet(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	        parent.servlet.testServlet($('#form'));
		}
			
		$(document).ready(function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});

			$("#paramTable").show();
			
			parent.servlet.formValidate($('#form'));
			//保存按钮绑定事件
			$('#servlet_saveForm').bind('click', function(){
				saveForm("${servletDTO.classId}");
			}); 
			//返回按钮绑定事件
			$('#servlet_closeForm').bind('click', function(){
				//alert("eeee");
				closeForm();
			});

			$("#servlet_TestConnection").bind("click",function(){
				testServlet();
			});
			
			//添加验证规则：逗号格式校验
			jQuery.validator.addMethod("comma", function(value, element){
				return this.optional(element) ||!value.match(/，/);
			}, "不能包含全角(中文)逗号！");
			
																																																																																																																							
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);

			$("#addParam").bind("click",function(){
				paramIndex++;
				var str = '<tr>';
    			str+= '<th colspan="2" width="15%">';
    			str+= '</th>';
    			str+= '<td width="34%" id="paradiv">';
    			str+= '<input class="form-control input-sm" type="text" id="param1" name="paramN'+paramIndex+'" placeholder=""/>';
    			str+= '</td>';
    			str+= '<td width="34%" id="paradiv">';
    			str+= '<input class="form-control input-sm" type="text" name="paramV'+paramIndex+'" placeholder=""/>';
    			str+= '</td>';
    			str+= '<td width="10%" style="text-align:center;" id="paradiv">';
    			str+= ' <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="删除" id="delParam" onClick="delParam(this)">删除</a>';
    			str+= '</td>';
    			str+= '<th width="50px;" id="paradiv">';
    			str+= '</th>';
    			str+= '</tr>';	            		
    			$("#paramTable").append(str);
			});

			
		});

		function delParam(nowObj){
			$(nowObj).parent().parent().remove();
		}
	</script>
</body>
</html>