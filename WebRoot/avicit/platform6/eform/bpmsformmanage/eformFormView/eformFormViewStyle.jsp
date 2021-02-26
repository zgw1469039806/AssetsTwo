<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
	String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
	
	<title>外观设置</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='addFormViewStyle' role="form" style="margin-top: 30px">
				<!-- 外观表单 -->
				<input type="hidden" name="id" id="columnId">
				<table class="form_commonTable">
					<tr>
						<th width="10%" style="word-break: break-all; word-warp: break-word;">
							<label for="bgColor">背景颜色</label>
						</th>
						<td width="40%">
							<input class="form-control input-sm" type="text" name="bgColor" id="bgColor" title="背景颜色"/>
						</td>
						<td width="5%"></td>
					</tr>
					<tr>
						<th width="10%" style="word-break: break-all; word-warp: break-word;">
							<label for="fontColor">字体颜色</label>
						</th>
						<td width="40%">
							<input class="form-control input-sm" type="text" name="fontColor" id="fontColor" title="字体颜色"/>
						</td>
						<td width="5%"></td>
					</tr>
					<tr>
						<th width="10%" style="word-break: break-all; word-warp: break-word;">
							<label for="fontSize">字体大小</label>
						</th>
						<td width="40%">
							<select class="form-control input-sm" id="fontSize" name="fontSize" title="字体大小">
					        	<option value="12px" >12px</option>
					        	<option value="14px" >14px</option>
					        	<option value="16px" >16px</option>
					        </select>
						</td>
						<td width="5%"></td>
					</tr>
					<tr>
						<th width="10%" style="word-break: break-all; word-warp: break-word;">
							<label for="fontColor">列宽</label>
						</th>
						<td width="40%">
							<input class="form-control input-sm" type="text" name="colWidth" id="colWidth" title="列宽"/>
						</td>
						<td width="5%"></td>
					</tr>
				</table>	
		</form>
	</div>
	
	
	
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		$(document).ready(function () {
			$('#bgColor,#fontColor').ColorPicker({
				onSubmit: function(hsb, hex, rgb, el) {
					$(el).val(hex);
					$(el).ColorPickerHide();
				},
				onBeforeShow: function () {
					$(this).ColorPickerSetColor(this.value);
				}
			})
			.bind('keyup', function(){
				$(this).ColorPickerSetColor(this.value);
			});

		});
		        
	</script>
</body>
</html>