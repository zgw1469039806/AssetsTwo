<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" value="<c:out value='${dbCommonColDTO.id}'/>" />
			<input type="hidden" name="version" value="<c:out  value='${dbCommonColDTO.version}'/>"/>
			<table class="form_commonTable">
				<tr>
					<th width="10%">
						<label for="colName">字段名称:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="colName"  id="colName" value="<c:out value='${dbCommonColDTO.colName}'/>">
   					</td>
					<th width="10%">
						<label for="colComments">字段描述:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="colComments"  id="colComments" value="<c:out value='${dbCommonColDTO.colComments}'/>">
   					</td>
				</tr>
				<tr>
					<th width="10%">
						<label for="colType">数据类型:</label></th>
					<td width="39%">
						<pt6:h5select css_class="form-control input-sm" name="colType" id="colType" title="" isNull="true" lookupCode="PLATFORM_DB_COL_TYPE" defaultValue="${dbCommonColDTO.colType}" />
					</td>
					<th>
						<label for="colLength">字段长度:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="colLength" id="colLength" data-min="1" data-max="4000" data-step="1" data-precision="0" value="<c:out value='${dbCommonColDTO.colLength}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
						<%--<input class="form-control input-sm" type="text" name="colLength"  id="colLength" value="<c:out value='${dbCommonColDTO.colLength}'/>">--%>
   					</td>

				</tr>
				<tr>
					<th>
						<label for="colDecimal">小数位数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="colDecimal" id="colDecimal" data-min="0" data-max="12" data-step="1" data-precision="0" value="<c:out value='${dbCommonColDTO.colDecimal}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
						<%--<input class="form-control input-sm" type="text" name="colDecimal"  id="colDecimal" value="<c:out value='${dbCommonColDTO.colDecimal}'/>">--%>
					</td>
					<th>
						<label for="orderBy">排序:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="orderBy" id="orderBy" data-min="0" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dbCommonColDTO.orderBy}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>

				</tr>
				<tr>
					<th>
						<label for="colDomType">字段类型:</label></th>
					<td>
						<pt6:h5select css_class="form-control input-sm" name="colDomType" id="colDomType" title="" isNull="true" lookupCode="PLATFORM_DB_COL_DOM_TYPE" defaultValue="${dbCommonColDTO.colDomType}" />
					</td>
					<th>
						<label for="colClass">所属分类:</label></th>
					<td>
						<pt6:h5select css_class="form-control input-sm" name="colClass" id="colClass" title="" isNull="true" lookupCode="PLATFORM_DB_COL_CLASS" defaultValue="${dbCommonColDTO.colClass}" />
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
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="dbCommonCol_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="dbCommonCol_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		$.validator.addMethod("english", function(value, element) {
			var chrnum = /^[^\u4e00-\u9fa5]*$/;
			var flag = (parent.verifyIsSpecial(value) || parent.verifyIsChinese(value) || parent.verifyIsNumStart(value))
			return this.optional(element) || !flag;
		}, "不能包含特殊字符、空格、中文或以数字开头！");
		//初始化时间控件
		function initDateSelect(){
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
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);


		}
		
		function closeForm(){
			parent.dbCommonCol.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
  		 	$('#dbCommonCol_saveForm').addClass('disabled').unbind("click");	
			parent.dbCommonCol.save($('#form'),"edit");
		}
		$(document).ready(function () {
			initDateSelect();

			parent.dbCommonCol.initDomSelect($("#colType").val(),$("#colDomType"));
			parent.dbCommonCol.formValidate($('#form'));
			//保存按钮绑定事件
			$('#dbCommonCol_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#dbCommonCol_closeForm').bind('click', function(){
				closeForm();
			});

			$('#colLength').on('change',function (ele, val) {
				var colLength = $(ele.currentTarget).val();
				if(colLength == null || colLength == "" || colLength == undefined){
					$("#colLength").val(1);
				}
			});

			var colType = $('#colType').val();
			if(colType  == "VARCHAR2"){
				$("#colDecimal").val(null);
				$("#colLength").removeAttr("readonly")
				$("#colDecimal").attr("readonly","readonly")
				$("#colLength").rules("add",{required:true});
			}else if(colType  == "DATE"){
				$("#colLength").val(null);
				$("#colDecimal").val(null);
				$("#colLength").attr("readonly","readonly")
				$("#colDecimal").attr("readonly","readonly")
				$("#colLength").rules("remove");
			}else if(colType  == "NUMBER"){
				$("#colLength").removeAttr("readonly")
				$("#colDecimal").removeAttr("readonly","readonly")
				$("#colLength").rules("add",{required:true});
			}else if(colType  == "CLOB" || colTypeVal  == "BLOB"){
				$("#colLength").val(null);
				$("#colDecimal").val(null);
				$("#colLength").attr("readonly","readonly")
				$("#colDecimal").attr("readonly","readonly")
				$("#colLength").rules("remove");
			}

			$('#colType').on('change',function (ele, val) {
				var colTypeVal = $(ele.currentTarget).val();
				if(colTypeVal  == "VARCHAR2"){
					$("#colLength").val(50);
					$("#colDecimal").val(null);
					$("#colLength").removeAttr("readonly")
					$("#colDecimal").attr("readonly","readonly")
					$("#colLength").rules("add",{required:true});
				}else if(colTypeVal  == "DATE"){
					$("#colLength").val(null);
					$("#colDecimal").val(null);
					$("#colLength").attr("readonly","readonly")
					$("#colDecimal").attr("readonly","readonly")
					$("#colLength").rules("remove");
				}else if(colTypeVal  == "NUMBER"){
					$("#colLength").val(8);
					$("#colDecimal").val(null);
					$("#colLength").removeAttr("readonly")
					$("#colDecimal").removeAttr("readonly","readonly")
					$("#colLength").rules("add",{required:true});
				}else if(colTypeVal  == "CLOB" || colTypeVal  == "BLOB"){
					$("#colLength").val(null);
					$("#colDecimal").val(null);
					$("#colLength").attr("readonly","readonly")
					$("#colDecimal").attr("readonly","readonly")
					$("#colLength").rules("remove");
				}
				parent.dbCommonCol.initDomSelect(colTypeVal,$("#colDomType"));
			});
		});
	</script>
</body>
</html>
