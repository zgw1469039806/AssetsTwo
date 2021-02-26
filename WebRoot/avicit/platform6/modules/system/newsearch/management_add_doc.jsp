<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";	
%>
<html>
<head>
<title>系统列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>

<body class="easyui-layout"  fit="true">
<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="datasourceName">数据源名称:</label></th>
					<td width="39%">
						<input title="" class="form-control input-sm" type="text" name="datasourceName" id="datasourceName" />
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="displayName">显示名称:</label></th>
					<td width="39%">
						<input title="" class="form-control input-sm" type="text" name="displayName" id="displayName" />
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="sysroleFk">权限控制:</label></th>
					<td width="39%"  colspan="3">
						<select class="form-control" name="sysroleFk" id="sysroleFk" title="" isNull="true" />
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="status">有效标识:</label></th>
					<td width="39%"  colspan="3">
						<select class="form-control" name="status" id="status">
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="datasourceDesc">简要描述:</label></th>
					<td width="39%">
						<input title="" class="form-control input-sm" type="text" name="datasourceDesc" id="datasourceDesc" style="height:60px" />
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="docPath">文档路径:</label></th>
					<td width="39%">
						<input title="" class="form-control input-sm" type="text" name="docPath" id="docPath"  style="height:60px" />
					</td>
				</tr>
			</table>
		</form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
	<div id="toolbar"
		class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
		<table class="tableForm" style="border:0;cellspacing:1;width:100%">
			<tr>
				<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
					<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" onclick="saveDoc()" role="button" title="保存" id="demoSingle_saveForm">保存</a>
					<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="commonTable_closeForm">返回</a>
				</td>
			</tr>
		</table>
	</div>
</div>
<!-- button js event -->
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
$(document).ready(function(){ 
    $.ajax({  
        url: 'platform/new/search/connection/listAuth.html',  
        data : {
		 	id : ""
		},
	    type : 'post',
        dataType: "json",  
        success: function (data) {  
        	$("#sysroleFk").append("<option>" + "</option>");
            $.each(data, function (index, units) {  
                $("#sysroleFk").append("<option value="+units.id+">" + units.roleName + "</option>");  
            });  
        },  

        error: function (XMLHttpRequest, textStatus, errorThrown) {  
            alert("error");  
        }  
    }); 
    formValidate($('#form'));
});
//控件校验   规则：表单字段name与rules对象保持一致
formValidate = function(form) {
	form.validate({
		rules : {
			datasourceName : {
				required : true,
				maxlength : 100
			},
			displayName : {
				required : true,
				maxlength : 100
			},
			datasourceDesc : {
				required : true,
				maxlength : 100
			},
			docPath : {
				required : true,
				maxlength : 100
			},
		}
	});
}
    //保存表单
    function saveDoc() {
    	var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
    	parent.searchIndex.save($('#form'),"addDoc");
	}
    //返回按钮绑定事件
	$('#commonTable_closeForm').bind('click', function(){
		closeForm();
	});
	function closeForm(){
		parent.searchIndex.closeDialog("insert");
	}
	
</script>
	
	
</body>
</html>