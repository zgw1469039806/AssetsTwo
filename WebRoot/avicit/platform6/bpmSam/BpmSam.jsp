<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
    String importlibs = "common,form,table";
%>

<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>流程梳理</title>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body>
<div class="easyui-layout" fit=true>
    <div data-options="region:'north',split:true" style="height:50px;">
        <div class="toolbar">
                <a id="changeModel" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="转换可执行的流程模型"><i class="icon icon-zhuanhuan"></i> 转换可执行的流程模型</a>
                <a id="checkInstance" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="查看运行的流程实例"><i class="icon icon-eye"></i> 查看运行的流程实例</a>
        </div>
    </div>

    <div data-options="region:'center'" style="width:1400px;height:900px;overflow-x:hidden;">
		<iframe  class="embed-responsive-item" frameborder="0" id="arisFrame" name="arisFrame" src="http://10.216.38.94/BPM/login.jsp" width="1350" height="900"></iframe>
    </div>
</div>
<input type='hidden' id='arisEpcId' name='arisEpcId' value='123'>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include> 
<script type="text/javascript">
      //分类事件
      var changeWindow;
      $("#changeModel").click(function () {
    	  //ajax请求成功则为true
    	  $.ajax({
					  type:'get',
					  async: false,
					  url: 'bpmSam/bpmn2jbpm/operation/getCookiesId',
					  dataType:'text',
					  success: function(r){
						   if(r!=null&&r!=""&&r!=undefined){ 
				    		  changeWindow = top.layer.open({
				    	      	    type: 2,
				    	      	    title: '转换可执行的BPMN流程',
				    	      	    skin: 'bs-modal',
				    	      	    area: ['50%', '70%'],
				    	              maxmin: false,
				    	      	    content: 'avicit/platform6/bpmSam/changeModel.jsp?epcId='+r
				    	      	});
				    	   }else{
				    		  layer.alert('请选择要转换的aris流程文件！' , {
									icon : 7,
									title : '提示',
									area : [ '400px', '' ], //宽高
									closeBtn : 0
								});
				    	  } 
					  },
					  error: function(){
							
					  }
				});
      });
      $("#checkInstance").click(function () {
    	  //ajax请求后台获取cookie里的id作为模板id去查看其流程实例
    	  $.ajax({
					  type:'get',
					  async: false,
					  url: 'bpmSam/bpmn2jbpm/operation/getProcessId',
					  contentType : 'application/json',
					  dataType:'json',
					  success: function(r){
						  if(r==""||r==null||r==undefined ){
							  layer.alert('请选择要查看的aris流程文件！' , {
									icon : 7,
									area : [ '400px', '' ], //宽高
									closeBtn : 0
								});
						  }else if(r[0]=="8a58bc1760247cbf016026149ebb024b"){
							  layer.alert('请先进行aris流程模型转换！' , {
									icon : 7,
									area : [ '400px', '' ], //宽高
									closeBtn : 0
								});
						  }else{
							  var pdidString = "";
							   $.each(r, function (index, units) {
								   units = "'" + units + "-1',";
								  pdidString = pdidString + units;
							  });
							  if(pdidString!=""){
								  pdidString = pdidString.substring(0,pdidString.length-1);
							  }
							  top.layer.open({
					        	    type: 2,
					        	    title: '流程运行实例',
					        	    skin: 'bs-modal',
					        	    area: ['65%', '80%'],
					                maxmin: false,
					        	    content: 'avicit/platform6/bpmSam/checkRunningProcess/runningProcess.jsp?pdid='+pdidString //"8a58cd4f5e025eb8015e0260208100c3-1"
					        	});
				    	  }
					  },
					  error: function(){
							
					  }
				});
      });
      
</script>
</html>