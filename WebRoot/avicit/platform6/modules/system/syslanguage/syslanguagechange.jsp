<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<base href="<%=ViewUtil.getRequestPath(request) %>">
	<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
	<script type="text/javascript" charset="utf-8">
		var code='${code}';
		$(function() {
			var d =$('#cc').combobox({    
			    valueField:'languageCode',    
			    textField:'languageName',
			    editable:false,
			    panelHeight:70,
			    onSelect:select
			});
			$.ajax({
				url: 'platform/syslanguage/syslist.json',
				type :'get',
				dataType :'json',
				success :function(r){
					if(r&&r.flag==0){
						d.combobox('loadData', r.list);
					}
				}
			});
			d.combobox('setValue',code);
		});
		
		var select=function(record){
			$.ajax({
				url : 'platform/syscustomed/sysCustomedController/saveCustomesLanguage.json',
				data : {lggCode : record.languageCode},
				type : 'post',
				dataType : 'json',
				success : function(result) {}
			});
		};
	</script>
</head>
<body>
	
	<div style="margin-top: 10px;">
	    <table>
	    	<tr>
	    		<td width="80" align="right"><span>选择语言：</span></td>
	    		<td>
	    			<div id="cc" class="easyui-combobox" name="sysLanguage" style="width:150px;display:inline">
					</div>
	    		</td>
	    	</tr>
	    </table>
	</div>	
</body>
</html>