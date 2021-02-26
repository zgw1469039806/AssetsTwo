<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
	<%
		String id = request.getParameter("id");
	%>
	
	<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
	<title>添加正文模板</title>
	<style>
		body td{
			font-family: Microsoft Yahei,sans-serif,Arial,Helvetica;
			font-size: 12px;
			padding-left: 0.5em;
		}
	</style>
	<script type="text/javascript">
	var baseurl = '<%=request.getContextPath()%>';
		$(function(){
			ajaxRequest("POST","id=<%=id%>","platform/bpm/bpmconsole/wordTempletAction/getWordTemplet","json","getWordTempletBack");
	    });
	   
	   	function getWordTempletBack(retValue){
	    	var wordTemplet=retValue.obj;
	    	$("#id").attr("value",wordTemplet.id); 
	    	$("#templetName").attr("value",wordTemplet.templetName);
	    	$('#templetType').combobox('setValue',wordTemplet.templetType); 
	    	$("#templetVersion").attr("value",wordTemplet.templetVersion); 
	    	$('#templetState').combobox('setValue',wordTemplet.templetState); 
	    	$("#orderBy").attr("value",wordTemplet.orderBy); 
	    	$("#flowKey").attr("value",wordTemplet.flowKey); 
	    	$("#version").attr("value",wordTemplet.version);
	    	$("#createdBy").attr("value",wordTemplet.createdBy); 
	    	$("#creationDate").attr("value",wordTemplet.creationDate);
	    	$("#attribute01").attr("value",wordTemplet.attribute01); 
	    }
	</script>
</head>

<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id="form1" method="post">
			<input id="id"  name="id" style="display:none;"/>
			<input id="version"  name="version" style="display:none;"/>
			<input id="createdBy"  name="createdBy" style="display:none;"/>
			<input id="creationDate"  name="creationDate" style="display:none;"/>
			<input id="attribute01"  name="attribute01" style="display:none;"/>
        	<table class="form_commonTable">
				<tr>
					<th width="15%"><span class="remind">*</span>模板名称:</th>
					<td width="35%">
						<input title="模板名称" class="easyui-validatebox" data-options="required:true,validType:'maxLength[50]'" type="text" name="templetName" id="templetName" />
					</td>
					<th width="15%"><span class="remind">*</span>模板类型:</th>
					<td width="35%">
						<select class="easyui-combobox" name="templetType" id="templetType" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">   
						    <option value="1">正文模板</option>  
						    <option value="2">红头模板</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><span class="remind">*</span>模板版本:</th>
					<td>
						<input title="模板版本" class="easyui-validatebox" data-options="required:true,validType:'maxLength[50]'" type="text" name="templetVersion" id="templetVersion" />
					</td>
					<th><span class="remind">*</span>模板状态:</th>
					<td>
						<select class="easyui-combobox" name="templetState" id="templetState" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">   
						    <option value="Y">有效</option> 
						    <option value="N">无效</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><span class="remind">*</span>模板排序:</th>
					<td>
						<input title="模板排序"  class="easyui-numberbox"  data-options="min:0,max:9999,precision:0,required:true"  type="text" name="orderBy" id="orderBy" />
					</td>
					<th></th>
					<td>
					</td>
				</tr>
				<!-- 把所属流程的配置去掉，不需要这么繁琐 -->
				<!-- 
				<tr>
					<td >所属流程</td>
					<td colspan="3"> 
						<textarea name="flowKey" id="flowKey" class="easyui-validatebox" style="height:60px;width:480px;"></textarea>
					</td>
				</tr>
				 -->
			</table>
		</form>
	</div>
</body>
</html>

