<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程事件监听demo</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<h3 style="text-align:center;margin-top:20px;">流程事件监听demo</h3>
		<hr style="height:1px;border:none;border-top:1px solid #555555;" />
		<p style="font-size:14px;">
			<pre>
				package avicit.platform6study.bpmdemo.event;
				import java.util.ArrayList;
				import java.util.List;
				import org.slf4j.Logger;
				import org.slf4j.LoggerFactory;
				import avicit.platform6.bpm.api.listener.EventListener;
				import avicit.platform6.bpm.api.listener.EventListenerExecution;
				/**
				 * bmp事件类demo,该类演示了如何获取流程实例Id，formId,流程变量的读写， 以及类属性的赋值
				 * @author
				 *
				 */
				public class BpmLogListener implements EventListener{
					Logger log = LoggerFactory.getLogger(BpmLogListener.class);   
					
					//该属性值可以由设计器设置
					String msg;
					public void notify(EventListenerExecution execution) {
						//流程执行Id
						String executionId = execution.getId();
						//流程实例Id
						long processInstanceId = execution.getProcessInstanceId();
						//业务表单Id，可能是大写，这是由开发模块的方式决定的，jdbc addon保存的是ID
						String formId = (String) execution.getVariable("ID");
						//业务表单Id,可能是小写，这是由开发模块的方式决定的
						String formId2 = (String) execution.getVariable("id");
						//流程节点名称
						//String ActivityName = execution.getActivity().getName();
						//从流程变量中取值
						List<String> logs = (List<String>)execution.getVariable("logs");
						if (logs==null) {
							logs = new ArrayList<String>();
							//设置流程变量
							execution.setVariable("logs", logs);
						}
						logs.add(msg);
						execution.setVariable("logs", logs);
						log.info("===执行自定义事件BpmLogEvent:"+msg);
						
						//如果需要操作数据库，请通过SpringFactory获得bean，比如：
				//		SysApplicationService sysApplicationService = SpringFactory.getBean(SysApplicationService.class);
				//		List<SysApplication> list = sysApplicationService.getAllList();
				//		log.info("=======BpmDBListener取得SysApplication个数="+list.size());
					}
				}
			</pre>
		</p>
	</div>
</body>
</html>