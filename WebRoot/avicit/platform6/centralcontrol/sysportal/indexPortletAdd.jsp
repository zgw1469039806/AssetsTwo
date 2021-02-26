<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>

<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<style type="text/css">
body{
	font-family: Microsoft Yahei,sans-serif,Arial,Helvetica;
	font-size:14px;
	margin:10px 10px 10px 10px;
}

.panel-body{
	font-size:15px;
}
</style>

<%
String dialogId = request.getParameter("dialogId");
String isgloable = request.getParameter("isgloable");
String appId = request.getParameter("appId");
Object admin =session.getAttribute(AfterLoginSessionProcess.SESSION_IS_ADMIN);
%>
<script type="text/javascript">
var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
	var dialogId = "<%=dialogId%>";
	var isgloable = "<%=isgloable%>";
	var appId = "<%=appId%>";
	var admin= "<%=admin%>";
	function hideDialog(){
		if(parent!=null&&parent.$('#' + dialogId)!=null){
			parent.$('#' + dialogId).dialog('close');//关闭当前窗口
		}
	}
	$(function() {
		$.ajax({ 
			url: baseUrl+'platform/cc/sysportal/getIndexPortletList/'+admin+'.json?appId='+appId+'&isgloable='+isgloable,
			data : {},
			type : 'post',
			dataType : 'json',
			success: function(result){
				if (result.flag == "success") {
					var listHtml="<table width='100%' border='0' cellpadding='0' cellspacing='0' id='indexMpmPortlet'>";
					var portletList = result.portletList;
					var portletids = getExistsPortletids();
					for (var i = 0; i < portletList.length; i++) {
						var display = true;
						var portlet = portletList[i];
						if (portletids != 'undefind' && portletids != null) {
							if (portletids.indexOf("@"+portlet.portletId+"@") > -1) {
								display = false;
							}
						} 
						if (display){
							listHtml +="<tr>";
							listHtml+="<td width='100%' align='left'>&nbsp;&nbsp;<input type='checkbox' name='_portlet' value='"+portlet.portletId+"'/>"+portlet.title+"</td>"; 
							listHtml +="</tr>";
						}
					}
					setTimeout(_addHtmlCallback(listHtml),200);
					//listHtml +="</table>";
					//$("#addcheckbox").html(listHtml); 
// 					parent.parent.$("#_iframe_portletAddDialog").attr("height",($("#indexMpmPortlet").height()+80)+'px');
// 					parent.parent.$("#_iframe_portletAddDialog").attr("*height",($("#indexMpmPortlet").height()+80)+'px');
					//parent.parent.$("#_iframe_portletAddDialog").css("height",($("#indexMpmPortlet").height()+80)+'px').css("_height",($("#indexMpmPortlet").height()+80)+'px');
				}
			},
			error : function(){
				//alert('portlet配置信息保存失败!');
			}
		});
	});
	//回调解决异步加载问题
	function addHtmlCallback(listHtml){
		listHtml +="</table>";
		$("#addcheckbox").html(listHtml); 
		parent.parent.$("#_iframe_portletAddDialog").css("height",($("#indexMpmPortlet").height()+80)+'px').css("_height",($("#indexMpmPortlet").height()+80)+'px');
	}
	
	 function _addHtmlCallback(listHtml)  
	    {  
	        return function()  
	        {  
	        	addHtmlCallback(listHtml);  
	        }  
	  } 
	
	function addPortletToIndex(){
		var ids="";
        $("input[name='_portlet']:checkbox").each(function(){ 
            if($(this).attr("checked")){
                ids += $(this).val()+","
            }
        });
        var iframeBody = parent.parent.$("#iframeBody")[0].contentWindow;
        iframeBody.addPortlet(ids);
        hideDialog();
	}
	function getExistsPortletids(){
		var portletids = "@";
		var iframeBody = parent.$("#iframeBody")[0].contentWindow;
		var portletRow = iframeBody.$("#portalContent .ui-portlet");
		$.each(portletRow,function(k,v){
			 var indexs = iframeBody.getPortletInfo(v.id);
	         $.each(indexs, function(k1, v1) {
	        	 portletids = portletids + k1 + "@";
	         });
		});
		return portletids;
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:auto;padding-bottom:35px;">
		<div id="addcheckbox"></div>
	</div>
	<div data-options="region:'south',border:false" style="height:50px;">
	<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
				<table class="tableForm" border="0" cellspacing="1" width='100%'>
					<tr>	
						<td align="right">
								<a href="javascript:void(0)" class="easyui-linkbutton primary-btn"  onclick="addPortletToIndex()" >保存</a>
								<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="hideDialog();" >返回</a>
						</td>
					</tr>
				</table>
	</div>
</div>
</body>
</html>
