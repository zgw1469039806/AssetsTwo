<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";
String code = request.getParameter("lookupTypeCode");
%>
<!DOCTYPE html>
<html>
<head>
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
</HEAD>
<BODY>
	<form id='form'>
		<input type="hidden" name="id" />
		<table class="form_commonTable">
            <tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;">多维通用代码:</th>
				<td>
					<select id="sysLookupHiberarchy_0" class="form-control lookupHiberarchy"  data-lookupCodeType="<%=code%>" style="width:100px;float:left;" >
					   <option value="0">请选择</option>
					</select>
				</td>
			</tr> 
			<tr>
			    <th width="10%" style="word-break: break-all; word-warp: break-word;">获取多维通用代码值:</th>
			    <td>
					<input type="button" value="set" style="float:left;" onclick="setDatas();"><input type="button" value="get" style="float:left;" onclick="getDatas();"><input type="text"  id="showSelectValue" style="width:300px;float:left;" />
			   </td>
			</tr>
		</table>
	</form>
</BODY>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="/pt6/static/h5/avicCascadeSelect/avictCascade.js" ></script>
<script id="script_e10">
$(document).ready(function() {
	$('#sysLookupHiberarchy_0').cascadeSelect({
		//baseUrl:'console/LookupHiberarchy', //controller路径
        //baseMethodTopUrl:'/searchTopLookupType/', //初始化一级通用代码controller方法的路径
        //baseMethodNextUrl:'/searchNextlookuptype/'//查找下一级通用代码controller方法的路径
	});
	
});
//get
function getDatas(){
	var arr = $('#sysLookupHiberarchy_0').cascadeSelect('getSelectData');
	var strValue="";
	var strText="";
	for(var i = 0;i<arr.length;i++){
		if(arr[i].lookTypeText  != '请选择'){
			strValue += arr[i].lookTypeValue;
			strText  += arr[i].lookTypeText;
			if(i < arr.length-1){
				strValue+="&";
				strText+="-";
			}	
		}
	}
	$('#showSelectValue').val(strText);
}
//set
function setDatas(){
	var arr = [{lookTypeText:"地区",lookTypeValue:"8a58c6bb60c031d40160c080efe800c8"},{lookTypeText:"陕西省",lookTypeValue:"8a58c6bb60c031d40160c081722100ce"},{lookTypeText:"西安市",lookTypeValue:"8a58c6bb60c031d40160c083744600e1"},{lookTypeText:"雁塔区",lookTypeValue:"8a58c6bb60c031d40160c085a85a00f6"}];
	$('#sysLookupHiberarchy_0').cascadeSelect('setSelectData',arr);
}		
	</script>
</HTML>