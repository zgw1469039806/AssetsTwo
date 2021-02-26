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
	
	<title>显示规则设置</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='addFormViewDisplay' role="form" style="margin:20px">
		
				<input type="hidden" name="id" id="columnId">
				<table class="form_commonTable">
					<tr>
						<td width="35%"style="word-break: break-all; word-warp: break-word;">
							<label class="radio-inline">
							<input type="radio" name="displayRule" value="1" id="displayRuleLookup" title="通用代码">通用代码
							</label>
							<label class="radio-inline">
							<input type="radio" name="displayRule" value="2" id="displayRuleFormat" title="格式化">格式化
							</label>
						</td>
						<td width="40%"></td>
						<td width="5%"></td>
					</tr>
				</table>
				<table class="form_commonTable">
					<tr id="lookup" style="display: none">
							<th width="10%" style="word-break: break-all; word-warp: break-word;">
								<label for="displayRuleContent">通用代码类型</label>
							</th>
							<td width="40%">
								<input class="form-control input-sm" type="text" name="displayRuleContent"  title="通用代码类型"/>
								<label>当列中的值出现在通用代码类型时，自动转换对应的显示值，如果列值不在“通用代码类型”的范围内，则显示原始值</label>
							</td>
							<td width="5%"></td>
					</tr>
					<tr id="format" style="display: none">
							<td width="50%">
								<textarea class="form-control input-sm" rows="3" name="displayRuleContent" title="通用代码类型"></textarea>
								<label>语法格式：format(row,index){return '返回格式化字符串'};</label>
							</td>
							<td width="5%"></td>
					</tr>
				</table>	
		</form>
	</div>
	
<!-- 	<div data-options="region:'south',border:false" style="height: 40px;">
	<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
		<table class="tableForm" style="border: 0; cellspacing: 1; width: 100%">
			<tr>
				<td width="50%" style="padding-right: 4%;" align="right">
					<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="eformViewDisplay_saveForm">保存</a>
					<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="eformViewDisplay_closeForm">返回</a>
				</td>
			</tr>
		</table>
	</div>
</div> -->
	
	
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		$(document).ready(function () {
				$("#displayRuleLookup").on("click",function(){
					$("#lookup").toggle();
					$("#format").toggle();
				});
				$("#displayRuleFormat").on("click",function(){
					$("#lookup").toggle();
					$("#format").toggle();
	
				});
		 });

		        
	</script>
</body>
</html>