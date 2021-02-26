<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.syssso.loder.SsoPropsLoader"%>
<% 
String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>sso配置</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,title:'应用列表',collapsible:false,width:fixwidth(.2),onResize:function(a){$('#sysLookup').setGridWidth(a);$(window).trigger('resize');}"">
        <div id="tableToolbarM" class="toolbar">
            <div class="toolbar-left">
                <div class="input-group  input-group-sm">
                    <input  class="form-control" placeholder="输入名称查询" type="text" id="appSearchInput" name="txt">
                    <span class="input-group-btn">
                    <button id="appSearch" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
                </span>
                </div>
            </div>
        </div>
        <table id="jqGridApp"></table>
	 </div>
	 <div id="panelnorth" data-options="region:'center',split:true">
 	  <div id="toolbar_sso" class="toolbar">
			<div class="toolbar-left">
				<a id="saveButton" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm btn-point" role="button" title="保存"><i class="icon icon-save"></i> 保存</a>
				<a id="returnButton" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="取消"><i class="fa fa-trash-o"></i> 清空</a>
			</div>
	  </div>
      <form id="form" method="post">
             <table class="form_commonTable">
				<tr>
					<th>
						<label for="ssoLoginUrl">SSO登录URL</label>
					</th>
					<td width="35%">
						<input  class="form-control input-sm" type="text" style="width: 99%;" type="text" name="ssoLoginUrl" id="ssoLoginUrl" value="${ssoLoginUrl}"/>
					</td>
					<th>
						<label for="ssoLogoutUrl">SSO退出URL</label>
					</th>
					<td width="35%">
						<input  class="form-control input-sm" type="text" style="width: 99%;" type="text" name="ssoLogoutUrl" id="ssoLogoutUrl"  value="${ssoLogoutUrl}"/>
					</td>
				</tr>
				
				<tr>
					<th>
						<label for="serverName">当前应用服务器名称</label>
					</th>
					<td>
						<input   class="form-control input-sm" type="text" name="serverName" id="serverName" value="${serverName}"/>
					</td>
					<th>
						<label for="serviceUrl">当前应用登录URL</label>
					</th>
					<td width="35%">
						<input  class="form-control input-sm" type="text" name="serviceUrl" id="serviceUrl" value="${serviceUrl}"/>
					</td>
				</tr>
			
				<tr>
					<th>
						<label for="ssoServerUrl">SSO服务器</label>
					</th>
					<td>
						<input  class="form-control input-sm" type="text" name="ssoServerUrl" id="ssoServerUrl" value="${ssoServerUrl}"/>
					</td>
					<th>
						<label for="ssoEnabled">SSO登录启用</label>
					</th>
					<td width="35%">
						<input   class="form-control input-sm" type="checkbox" name="ssoEnabled" id="ssoEnabled"/>
					</td>
				</tr>
			</table>
		</form>
 </div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
<script src="avicit/platform6/bs3centralcontrol/appliaction/js/AppList.js" type="text/javascript"></script>
<script type="text/javascript">
var sysAppTree;
var appid;

$(function(){
	sysAppTree = new AppList('jqGridApp','1','searchDialog','form','keyWord');
	
	sysAppTree.setOnSelect(function(appId){
		appid = appId;
	    $("#form").validate().resetForm();
		$.ajax({
			url : 'platform/bs3h5SsoUpdate/casConfig/'+appid,
			type : 'post',
			dataType : 'json',
			success : function(result) {
				$('#ssoLoginUrl').val(result.ssoLoginUrl);
				$('#ssoLogoutUrl').val(result.ssoLogoutUrl);
				$('#serverName').val(result.serverName);
				$('#serviceUrl').val(result.serviceUrl);
				$('#ssoServerUrl').val(result.ssoServerUrl);
				var falg = result.ssoEnabled;
				if(falg){
					document.getElementById("ssoEnabled").checked = true;
				}else{
					document.getElementById("ssoEnabled").checked = false;
				}
				//$('#ssoEnabled').attr('checked',result.ssoEnabled ==='true');
			}
			
		});
		
	});
	//sysAppTree.init();
});

/**
 * 
 */
 function saveForm(){
	var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }
	var enable=false;
	if($('#ssoEnabled').attr('checked')){
		enable=true;
	}
	$.ajax({
		url : 'platform/bs3h5SsoUpdate/saveorupdate/'+appid,
		data : {
			datas : JSON.stringify(serializeObject($('#form'))),enable:enable
		},
		type : 'post',
		dataType : 'json',
		success : function(result) {
			if (result.flag == "success") {
				layer.msg("配置成功");
			}else {
				
				layer.msg("配置失败");
			}
		}
	});
}
function resetForm(){
	clearFormData("#form");
}
document.ready = function () {
	$('#form').validate({
		rules: {
			ssoLoginUrl: {
				required: true
			},
			ssoLogoutUrl: {
				required: true
			},
			serverName: {
				required: true
			},
			serviceUrl: {
				required: true
			}
		}
	});
	//保存按钮绑定事件
	$('#saveButton').bind('click', function(){
		saveForm();
	});
	//返回按钮绑定事件
	$('#returnButton').bind('click', function(){
		resetForm();
	});
	//$('#ssoEnabled').attr('checked', '${ssoEnabled}');
};
</script>
</body>
</html>