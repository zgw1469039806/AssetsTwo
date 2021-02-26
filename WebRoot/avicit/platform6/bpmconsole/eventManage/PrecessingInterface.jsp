<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程动作监听demo</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<h3 style="text-align:center;margin-top:20px;">流程动作监听demo</h3>
		<hr style="height:1px;border:none;border-top:1px solid #555555;" />
		<p style="font-size:14px;">
			<pre>
				public class RejectToFistActPreProcessing implements PrecessingInterface{
				
					private Logger logger = LoggerFactory.getLogger(this.getClass());
					
					@Override
					public void execute(ExecutionImpl execution, Map<String, Object> args) {
						// 流程执行Id
						String executionId = execution.getId();
						// 流程实例Id
						long processInstanceId = execution.getProcessInstanceId();
						// 流程节点名称
						execution.getActivityAlias();
						// 流程定义id
						execution.getProcessDefinitionId();
						//如果大写ID取不到 formId 的值，请将 ID 改写成小写 id
						String formId = (String) execution.getVariable("ID");
						//如果需要操作数据库，请通过SpringFactory获得bean，比如：
						SysApplicationService sysApplicationService = SpringFactory.getBean(SysApplicationService.class);
						List<SysApplication> list = sysApplicationService.getAllList();
						log.info("=======BpmDBListener取得SysApplication个数="+list.size());
						logger.info("根据上面提供的变量进行业务操作");
					}
				
				}

			</pre>
		</p>
	</div>
</body>
</html>