<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

</head>
<body class=" easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<table class="form_commonTable">
				<tr>
					<th width="15%" style="word-break: break-all; word-warp: break-word;"><label for="timeRule">时间规则:</label></th>
					<td width="25%"><input title="时间规则" class="form-control input-sm num_only" type="text" name="timeRule" id="timeRule" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="timeType">时间类型:</label></th>
					<td width="20%">
						<select class="form-control input-sm"  name="timeType" id="timeType" title="">
							<option value=""></option>
							<option value="business">business</option>
						</select>
					
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="timeUnit">时间单位:</label></th>
					<td width="20%">
						<select class="form-control input-sm"  name="timeUnit" id="timeUnit" title="">
							<option value="seconds">seconds</option>
							<option value="minutes">minutes</option>
							<option value="hours">hours</option>
							<option value="days">days</option>
							<option value="weeks">weeks</option>
							<option value="months">months</option>
							<option value="years">years</option>
						</select>
					</td>
				</tr>
			</table>
			
		</form>
	</div>
</body>

<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
	
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/prop.js"></script>
<script>
	$(function() {
		$("form").validate({
			rules: {
				/*timeRule: {
					required: true,
				}*/
			}
		});
		var parentId = decodeURIComponent(flowUtils.getUrlQuery("id"));
		var parentObj = parent.$("#"+parentId).data("data-object");
		parentObj.form = $("#form");
		var timerVal = parent.$("#"+parentId).val();
		if(timerVal!=''){
			var timerArr = timerVal.split(" ");
			if(timerArr.length>2){
				/*console.log(timerArr[0]+" "+timerArr[1]+" "+timerArr[2]);*/
				$("#timeRule").val(timerArr[0]);
				$("#timeType").val(timerArr[1]);
				$("#timeUnit").val(timerArr[2]);
			}else{
				/*console.log(timerArr[0]+" "+timerArr[1]);*/
				$("#timeRule").val(timerArr[0]);
				$("#timeUnit").val(timerArr[1]);
				
			}
		}
	});
	
</script>
</body>
</html>
