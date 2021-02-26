<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/select2/select2.css"/>
<style type="text/css">
	.sysdatapermissionTips1,.sysdatapermissionTips2,.sysdatapermissionTips3,.sysdatapermissionTips4{
		float: left;
	    width: 16px;
	    height: 16px;
	    background-image: url(static/images/platform/common/tips.png);
	    margin-right: 3px;
	    margin-top: 1px;
	}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<h3 style="text-align: center; font-weight: 600;">方法详情</h3>
		<form id='form' style="width: 96%;">
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="type">类型:</label></th>
					<td width="23%">
						<label class="radio-inline">
							<input disabled="disabled" type="radio" name="type" value="0" />普通模块
						</label>
						<label class="radio-inline">
							<input disabled="disabled" type="radio" name="type" value="1" />电子表单
						</label>
						<label class="radio-inline">
							<input disabled="disabled" type="radio" name="type" value="2" />选择页
						</label>
					</td>
				</tr>

				<tr class="selectTr" style="display: none;">
					<th width="10%"><label for="selectType"><div class="sysdatapermissionTips3"></div>选择页面类型:</label></th>
					<td width="23%">
						<label class="radio-inline">
							<input disabled="disabled" type="radio" name="selectType" value="0" />平台自定义选择页
						</label>
						<label class="radio-inline">
							<input disabled="disabled" type="radio" name="selectType" value="1" />电子表单数据字典
						</label>
						<label class="radio-inline">
							<input disabled="disabled" type="radio" name="selectType" value="2" />自定义选择页
						</label>
					</td>
					<th width="10%"><label for="selectId"><div class="sysdatapermissionTips2"></div>选择页唯一标识:</label></th>
					<td width="23%">
						<input disabled="disabled" class="form-control input-sm" type="text" name="selectId" id="selectId" value="<c:out  value='${sysDataPermissionsMethodDTO.selectId}'/>"/>
					</td>
				</tr>
				<tr class="selectTr" style="display: none;">
					<th width="10%"><label>标识符说明:</label></th>
					<td width="23%" colspan="3">
						<input disabled="disabled"  class="form-control input-sm" type="text" id="selectIdRemarks" value="<c:out  value='${sysDataPermissionsMethodDTO.tableRemarks}'/>"/>
					</td>
				</tr>
				
				<tr class="selectCustomTr" style="display: none;">
					<th width="10%"><label>选择页Mapper名称:</label></th>
					<td width="23%">
						<input disabled="disabled" class="form-control input-sm" type="text" id="selectMapperName" name="selectMapperName" value="<c:out  value='${sysDataPermissionsMethodDTO.mapperName}'/>"/>
					</td>
					<th width="10%"><label><div class="sysdatapermissionTips4"></div>执行方法:</label></th>
					<td width="23%">
						<input disabled="disabled" class="form-control input-sm" type="text" id="selectMethodName" name="selectMethodName" value="<c:out  value='${sysDataPermissionsMethodDTO.method}'/>"/>
					</td>
				</tr>

				<tr class="defaultAndEformTr">
					<th width="10%"><label for="tableName">表名称:</label></th>
					<td width="23%">
						<input disabled="disabled" class="form-control input-sm" type="text" name="tableName" id="tableName" value="<c:out  value='${sysDataPermissionsMethodDTO.tableName}'/>" />
					</td>
					<th width="10%"><label for="tableRemarks">表说明:</label></th>
					<td width="23%"><input disabled="disabled" class="form-control input-sm" type="text" name="tableRemarks" id="tableRemarks" value="<c:out  value='${sysDataPermissionsMethodDTO.tableRemarks}'/>" /></td>
				</tr>
				<tr class="EformTr" style="display: none;">
					<th width="10%"><label for="viewCode">视图编码:</label></th>
					<td width="23%">
						<input disabled="disabled" class="form-control input-sm" type="text" name="viewCode" id="viewCode" value="<c:out  value='${sysDataPermissionsMethodDTO.viewCode}'/>"/>
					</td>
					<th width="10%"><label for="viewName">视图名称:</label></th>
					<td width="23%"><input disabled="disabled" class="form-control input-sm" type="text" name="viewName" id="viewName" value="<c:out  value='${sysDataPermissionsMethodDTO.viewName}'/>"/></td>
				</tr>

				<tr class="defaultTr">
					<th width="10%"><label for="mapperName"><div class="sysdatapermissionTips1"></div>mapper名称:</label></th>
					<td width="23%">
						<input class="form-control input-sm" disabled="disabled" type="text" name="mapperName" id="mapperName" value="<c:out  value='${sysDataPermissionsMethodDTO.mapperName}'/>" />
					</td>
					<th width="10%"><label for="mapperRemarks">mapper说明:</label></th>
					<td width="23%"><input class="form-control input-sm" disabled="disabled"
						type="text" name="mapperRemarks" id="mapperRemarks" value="<c:out  value='${sysDataPermissionsMethodDTO.mapperRemarks}'/>" /></td>
				</tr>
				<tr class="defaultTr">
					<th width="10%"><label for="method">执行方法:</label></th>
					<td width="23%" colspan="3">
						<select class="js-example-basic-multiple" disabled="disabled" id="method" name="method" multiple="multiple" style="width: 100%"></select>
					</td>
				</tr>
				<tr class="defaultTr">
					<th width="10%"><label for="methodRemarks">方法说明:</label></th>
					<td width="23%" colspan="3">
						<textarea class="form-control input-sm" name="methodRemarks" disabled="disabled" id="methodRemarks" rows="3">${sysDataPermissionsMethodDTO.methodRemarks}</textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript" src="static/h5/select2/select2.js"></script>
	<script type="text/javascript" src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/js/MethodCommon.js?v=<%=System.currentTimeMillis()%>"></script>
	<script type="text/javascript">
		document.ready = function() {
			initForm();
		};

		function initForm() {
			var typeVal = '${sysDataPermissionsMethodDTO.type}';
			$.each($('input:radio[name="type"]'),function(index,data){
				var currentVal = data.value;
				if(currentVal == typeVal){
					$(data).attr("checked","checked");
				}
			});

			if(typeVal == "0"){ // 非电子表单
				$(".defaultTr").show();
				$(".defaultAndEformTr").show();
				$(".selectTr").hide();
				if("" != '${method}'){
					var methodHtml = "";
					$.each("${method}".split(","),function(i,d){
						var str = d.substr(d.lastIndexOf(".")+1);
						methodHtml+="<option value='"+str+"'>"+str+"</option>";
					});
					$("#method").html(methodHtml);
					$('#method').val("${sysDataPermissionsMethodDTO.method}".split(','));
					$('#method').trigger('change.select2');
				}
			} else if(typeVal == "1"){ // 电子表单
				$(".defaultAndEformTr").show();
				$(".EformTr").show();
				$(".defaultTr").hide();
				$(".selectTr").hide();
			} else if(typeVal == "2"){ // 选择页
				$(".defaultAndEformTr").hide();
				$(".defaultTr").hide();
				$(".selectTr").show();

				var selectTypeVal = '${sysDataPermissionsMethodDTO.selectType}';
				$.each($('input:radio[name="selectType"]'),function(index,data){
					var currentVal = data.value;
					if(currentVal == selectTypeVal){
						$(data).attr("checked","checked");
					}
				});
				if(selectTypeVal=='2'){
					$(".selectCustomTr").show();
				}
			}

			$("#method").select2({});
		}
	</script>
</body>
</html>