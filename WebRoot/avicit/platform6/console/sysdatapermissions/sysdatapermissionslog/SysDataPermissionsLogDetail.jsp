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
<html>
<head>
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="version"
				value="<c:out  value='${sysDataPermissionsLogDTO.version}'/>" /> <input
				type="hidden" name="id"
				value="<c:out  value='${sysDataPermissionsLogDTO.id}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">
					</th>
					<td width="35%" style="padding-bottom: 0px;">
						<button id="copyBeforeSql" type="button" class="btn btn-primary btn-sm" style="float: right;" data-clipboard-action="copy" data-clipboard-target="#beforeSql">
							<span class="glyphicon glyphicon-copy" aria-hidden="true"></span> 复制SQL
						</button>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">
					</th>
					<td width="35%" style="padding-bottom: 0px;">
						<button id="copyAfterSql" type="button" class="btn btn-primary btn-sm" style="float: right;" data-clipboard-action="copy" data-clipboard-target="#afterSql">
							<span class="glyphicon glyphicon-copy" aria-hidden="true"></span> 复制SQL
						</button>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">
						<label for="beforeSql">数据权限控制前SQL:</label>
					</th>
					<td width="35%" style="padding-top: 0px;">
						<textarea class="form-control input-sm" rows="20" name="beforeSql" id="beforeSql" readonly="readonly"><c:out  value='${sysDataPermissionsLogDTO.beforeSql}'/></textarea>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">
						<label for="afterSql">数据权限控制后SQL:</label>
					</th>
					<td width="35%" style="padding-top: 0px;">
						<textarea class="form-control input-sm" rows="20" name="afterSql" id="afterSql" readonly="readonly"><c:out  value='${sysDataPermissionsLogDTO.afterSql}'/></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript" src="static/h5/clipboard/clipboard.min.js"></script>
	<script type="text/javascript">
		function copyVal(inputId){
			if (window.clipboardData) {
			    if (window.clipboardData.setData('TEXT', $("#"+inputId).val())) {
			    	layer.msg("复制成功",{icon:1});
			    } else {
			    	layer.alert("复制失败！请开启浏览器剪贴板权限！",{icon:2});
			    }
			}
		}
		document.ready = function() {
			$("#copyBeforeSql").on("click",function(){
				if(isIE()){
					copyVal("beforeSql");
				} else {
					var clipboard1 = new ClipboardJS('#copyAfterSql');
					var clipboard2 = new ClipboardJS('#copyBeforeSql');
					
					clipboard2.on('success', function(e) {
				    	layer.msg("复制成功",{icon:1});		
				    });
					clipboard2.on('error', function(e) {
				    	layer.msg("复制失败");		
				    });
				}
			});
			$("#copyAfterSql").on("click",function(){
				if(isIE()){
					copyVal("afterSql");
				} else {
					var clipboard1 = new ClipboardJS('#copyAfterSql');
					var clipboard2 = new ClipboardJS('#copyBeforeSql');
					
					clipboard1.on('success', function(e) {
				        layer.msg("复制成功",{icon:1});
				    });
					clipboard1.on('error', function(e) {
				    	layer.msg("复制失败");
				    });
				}
			});
		};
		
		$(document).keydown(function(event) {
			event.returnValue = false;
			return false;
		});
		
		function isIE() {
		 	if (!!window.ActiveXObject || "ActiveXObject" in window){
				return true;
		 	} else {
				return false;
		 	}
		}
	</script>
</body>
</html>