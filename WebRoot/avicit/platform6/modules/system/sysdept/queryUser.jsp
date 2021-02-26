<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户查询</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
	<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script type="text/javascript">

var baseurl = '<%=request.getContextPath()%>';

jQuery(function(){

	//选择部门
	var deptCommonSelector = new CommonSelector("dept","deptSelectCommonDialog","search_DEPT_ID","DEPT_NAME",null,null,null,true,null,null,"600","250");
	deptCommonSelector.init(true,null,1); //选择部门
	clearData();
	
	$('#searchform').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchData();
		}
	});
});

/**
 * 查询
 */
function searchData(){
	var data={
			search_USER_LEVEL:$.trim($('#search_USER_LEVEL').combobox("getValue")),
			search_POSITION_ID:$.trim($('#search_POSITION_ID').combobox("getValue")),
			search_USER_CODE:$.trim($('#search_USER_CODE').val()),
			search_USER_NAME:$.trim($('#search_USER_NAME').val()),
			search_LOGIN_NAME:$.trim($('#search_LOGIN_NAME').val()),
			search_DEPT_ID:$.trim($('#search_DEPT_ID').val()),
			search_MOBILE:$.trim($('#search_MOBILE').val()),
			search_EMAIL:$.trim($('#search_EMAIL').val()),
			search_STATUS:$.trim($('#search_STATUS').combobox("getValue")),
			id:$.trim($('#id').val()),
			type:$.trim($('#type').val())
	};
	
	parent.searchData(data);
}

/**
 * 重置数据
 */
function clearData(){
	
	$('#search_USER_LEVEL').combobox("clear");
	$('#search_POSITION_ID').combobox("clear");
	$('#search_USER_CODE').val("");
	$('#search_USER_NAME').val("");
	$('#search_LOGIN_NAME').val("");
	$('#search_DEPT_ID').val("");
	$('#search_MOBILE').val("");
	$('#search_EMAIL').val("");
	$('#DEPT_NAME').val("");
	$('#search_STATUS').combobox("clear");
}

/**
 * 关闭窗口
 */
function closeDialog(){
	parent.$("#queryUserDialog").dialog('close');
}
</script>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,title:''" >
	<form id="searchform">
	<input type="hidden" id="id" name="id" value="${id}">
	<input type="hidden" id="type" name="type" value="${type}">
	<table class="form_commonTable">
		<tr>
			<th width="15%" >用户编号：</th>
			<td width="35%">
				<input class="easyui-validatebox" type="text"  name="search_USER_CODE"
					id="search_USER_CODE" ></input>
			</td>
			<th width="15%" >部门 ：</th>
			<td>
				<input class="easyui-validatebox" readonly="readonly" type="text"  name="DEPT_NAME"
					id="DEPT_NAME" ></input>
				<input type="hidden" id="search_DEPT_ID" name="search_DEPT_ID"> 
			</td>
		</tr>
		<tr>
			<th>用户姓名：</th>
			<td>
				<input class="easyui-validatebox"  type="text"  name="search_USER_NAME"
					id="search_USER_NAME" ></input>
			</td>
			<th>岗位 ：</th>
			<td>
			<select class="easyui-combobox"
				data-options="{panelHeight:'120',editable:false,onShowPanel:comboboxOnShowPanel}" name="search_POSITION_ID" id="search_POSITION_ID" style="width: 155px">
					<c:forEach items="${positionList}" var="lookup">
						<option value="${lookup.positionId}">${lookup.positionName}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th>登录名称：</th>
			<td>
				<input class="easyui-validatebox"  type="text"  name="search_LOGIN_NAME"
					id="search_LOGIN_NAME" ></input>
			</td>
			<th>密级 ：</th>
			<td>
					<select class="easyui-combobox"
				data-options="{panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel}"name="search_USER_LEVEL" id="search_USER_LEVEL" style="width: 155px">
							<option value=""></option>
							<c:forEach items="${userSecetLevel}" var="lookup">
								<option value="${lookup.lookupCode}">${lookup.lookupName}</option>
							</c:forEach>
					</select>
			</td>
		</tr>
		<tr>
			<th>手机：</th>
			<td>
				<input class="easyui-validatebox" type="text"  name="search_MOBILE"
					id="search_MOBILE" ></input>
			</td>
			<th>邮箱地址：</th>
			<td>
				<input class="easyui-validatebox" type="text"  name="search_EMAIL"
					id="search_EMAIL" ></input>
			</td>
		</tr>
		<tr>
			<th>状态：</th>
			<td>
			 <select name="search_STATUS" id="search_STATUS" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
			 					<option value=""   selected="selected">无</option>
								<option value="1" >有效</option>
								<option value="3">无效</option>
								<option value="0">未锁定</option>
								<option value="lock">已锁定</option>
				</select>
			</td>
		</tr>
	</table>
    </form>
    
    
</div>

<div region="south" border="false" style="height: 35px">
	<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend" style="height:auto;display: block;">
	<table class="tableForm"  width='100%'>
		<tr>	
				<td align="right">
				<a  title="查询" id="searchButton"  class="easyui-linkbutton" iconCls="" plain="false" onclick="searchData();" href="javascript:void(0);">查询</a>
				<a  title="清空" id="clearButton"  class="easyui-linkbutton" iconCls="" plain="false" onclick="clearData();" href="javascript:void(0);">清空</a>
				<a  title="返回" id="backButton"  class="easyui-linkbutton" iconCls="" plain="false" onclick="closeDialog();" href="javascript:void(0);">返回</a>
				</td>
		</tr>
	</table>
  </div>
</div>
</body>
</html>