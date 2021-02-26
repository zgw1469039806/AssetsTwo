<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程路由条件demo</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<h3 style="text-align:center;margin-top:20px;">流程路由条件demo</h3>
		<hr style="height:1px;border:none;border-top:1px solid #555555;" />
		<p style="font-size:14px;">
			<pre>
				package avicit.platform6study.bpmdemo.conditon;
				import org.slf4j.Logger;
				import org.slf4j.LoggerFactory;
				import avicit.platform6.bpm.api.model.OpenExecution;
				import avicit.platform6.bpm.pvm.internal.model.RouteConditionInterface;
				
				/**
				 * 流程条件类demo
				 */
				public class ConditionClasses implements RouteConditionInterface{
				
					private Logger logger = LoggerFactory.getLogger(this.getClass());
					
					/**
					 * 读取TRAFFIC流程变量，判断是否是"飞机"出差的 
					 */
					public boolean evaluate(OpenExecution execution) {
						String traffic = (String)execution.getVariable("TRAFFIC");
						if(traffic!=null&&traffic.equals("飞机")){
							return false;
						}else{
							return true;
						}
					}
				}
			</pre>
		</p>
	</div>
</body>
</html>