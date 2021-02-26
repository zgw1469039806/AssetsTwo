<%@page import="avicit.platform6.core.rest.client.RestClientConfig"%>
<%@page import="avicit.platform6.modules.system.sysfileupload.service.SwfUploadService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="avicit.platform6.core.spring.SpringFactory"%>
<%@page import="avicit.platform6.commons.utils.ComUtil"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.api.session.SessionHelper" %>
<%@page import="java.util.*"%>
<%
	String form_id = ComUtil.replaceNull2Space(request.getParameter("form_id"));
	String save_type = ComUtil.replaceNull2Space(request.getParameter("save_type"));
	String secret_level = ComUtil.replaceNull2Space(request.getParameter("secret_level"));
	String file_category = ComUtil.replaceNull2Space(request.getParameter("file_category"));
	String form_field = ComUtil.replaceNull2Space(request.getParameter("form_field"));
	String form_code = ComUtil.replaceNull2Space(request.getParameter("form_code"));
	String collapsed = ComUtil.replaceNull2Space(request.getParameter("collapsed"));
	String encryption = ComUtil.replaceNull2Space(request.getParameter("encryption"));
	String appId = RestClientConfig.systemid;
	String lang = SessionHelper.getCurrentUserLanguageCode(request);
	SwfUploadService swfUploadService = (SwfUploadService) SpringFactory.getBean(SwfUploadService.class);
	
	Map<String,String> para = new HashMap<String,String>();
	para.put("formId", form_id);
	para.put("saveType", save_type);
	para.put("secretLevel", secret_level);
	para.put("fileCategory", file_category);
	para.put("appId",appId);
	para.put("language",lang);
	para.put("formCode",form_code);
	
	Map<String,String> result = swfUploadService.getAttachViewHtml(para,SessionHelper.getLoginSysUser(request));
	String attachHtml = result.get("html");
	if (form_field != null && !"".equals(form_field)){
		String[] fields = form_field.split(",");
		para.put("formCode","");
		for (String field : fields){
			para.put("formId", field);
			Map<String,String> res = swfUploadService.getAttachViewHtml(para,SessionHelper.getLoginSysUser(request));
			attachHtml += res.get("html");
		}
	}
%>

<script src="static/js/platform/component/jQuery/jquery-easyui-1.3.5/extend/easyui.fieldset.extentd.js" type="text/javascript"></script>
<script type="text/javascript">
var baseurl = "<%=ViewUtil.getRequestPath(request)%>";
	var form_id = "<%=form_id%>";
	var save_type = "<%=save_type%>";
	var collapsed = "<%=collapsed%>";
	var encryption = "<%=encryption%>";

	function downloadFile(fileId,formId,formTable,saveType){
		window.open("<%=request.getContextPath()%>/platform/swfUploadController/doDownload?fileuploadBusinessId="+formId+"&encryption="+encryption+"&fileuploadBusinessTableName="+formTable+"&fileuploadIsSaveToDatabase=<%=save_type%>&fileId="+fileId,"_blank");
	}
	
	$(function(){  
		var collapsedFlag = false;
        if (collapsed =="true"){
        	collapsedFlag = true;
        }else{
        	collapsedFlag = false;
        }
	    $("#"+"<%=form_code%>fs").lqfieldset({  
	        title:'附件',  
	        collapsible:true,  
	        collapsed:collapsedFlag,  
	        checkboxToggle:false  
	    }); 
	});
</script>
<link href="avicit/platform6/modules/system/swfupload/swf/css/default.css"
	rel="stylesheet" type="text/css" />
	<div id="<%=form_code%>fs" style="overflow:hidden">
	<table width="95%" cellspacing="1" cellpadding="1" border="0">
		<tr>
			<td colspan="2">
				<TABLE id="<%=form_code%>" width="100%" border="0" cellpadding="1"
					cellspacing="1">
					<tr class="newUploadTitle">
							<th align="center" nowrap>
								附件名称
							</th>
							<% if(file_category!=null && !file_category.equals("")) {%>
							<th align="center" nowrap>
								附件类型
							</th>
							<%} %>
							<% if(secret_level!=null && !secret_level.equals("")) {%>
							<th align="center" nowrap>
								附件密级
							</th>
							<%} %>
							<th align="center" nowrap>
								附件大小
							</th>
							<th  align="center" nowrap>
								操作
							</th>
						</tr>
					<%=attachHtml%>
				</table>
			</td>
		</tr>

	</table>
</div>