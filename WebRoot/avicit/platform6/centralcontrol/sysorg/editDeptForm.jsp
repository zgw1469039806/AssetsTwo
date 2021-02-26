<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="avicit.platform6.api.syslookup.SysLookupAPI"%>
<%@ page import="avicit.platform6.api.syslookup.impl.SysLookupAPImpl"%>
<%@ page import="avicit.platform6.api.syslookup.dto.SysLookupSimpleVo"%>
<%@ page import="avicit.platform6.core.spring.SpringFactory"%>
<%@ page import="avicit.platform6.core.properties.PlatformConstant"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	SysLookupAPI upLoader = SpringFactory.getBean(SysLookupAPI.class);
	Object code = SessionHelper.getCurrentUserLanguageCode(request);
	String s;
	if (code == null) {
		s = PlatformConstant.D_LANGUAGE;
	} else {
		s = code.toString();
	}
	Collection<SysLookupSimpleVo> lookUpdeptType = upLoader.getLookUpListByType("PLATFORM_DEPT_TYPE",SessionHelper.getApplicationId(),s);//修改平台，转换为通用代码，部门类型
	Collection<SysLookupSimpleVo> lookUpValidFlag = upLoader.getLookUpListByType("PLATFORM_VALID_FLAG",SessionHelper.getApplicationId(),s);//修改平台，转换为通用代码，是否有效
	
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门用户管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/CommonDialog.js" type="text/javascript"></script>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
var path="<%=ViewUtil.getRequestPath(request)%>";
var currTreeNode;
var deptCode = "";

$.extend($.fn.validatebox.defaults.rules,{
    //国内邮编验证
    zipcode: {
        validator: function (value) {
            var reg = /^[1-9]\d{5}$/;
            return reg.test(value);
        },
        message: "请输入正确的邮编格式"
    },
  //电话验证
    tel: {
        validator: function (value) {
        	var mobilereg = /^((13[0-9])|(15[^4,\D])|(18[0,5-9])|145|147)\d{8}$/;
            var phonereg = /^((0[0-9]{2,3})-)([0-9]{7,8})(-([0-9]{3,}))?$/;
            return mobilereg.test(value) || phonereg.test(value);
        },
        message: "请输入有效的电话号码"
    },
    fax :{
    	validator: function (value) {
        	var reg = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
            return reg.test(value);
        },
        message: "请输入有效的传真号码"
    }
});

$(document).ready(function(){ 
	
	var deptId='<%=request.getParameter("id")%>';
	loadDeptInfo(deptId);
	setFormReadOnly(false);
	$("#WORK_CALENDAR_ID").datebox({ editable:false });
	//addDept();
});

function setFormReadOnly(isReadOnly){
	if(!isReadOnly){
		$("form input[name!='PARENT_DEPT_NAME']").attr("disabled",false);
		$('form textarea').attr("disabled",false);
	}else{
		$("form input[name!='PARENT_DEPT_NAME']").attr("disabled",true);
		$('form textarea').attr("disabled",true);
	}
	//设置部门CODE为只读
	//$("#DEPT_CODE").attr("readonly", true);
};

function loadDeptInfo(deptId){
	$.ajax({
        cache: false,
        type: "POST",
        url:'platform/cc/sysdept/getDeptById.json?id='+deptId,
        dataType:"json",
        data:{id:deptId},
        error: function(request) {
        	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
        },
        success: function(data) {
			if(data.result==0&&data.sysDept){
				$('#deptEditForm').form('load',data.sysDept);
				deptCode = data.sysDept.DEPT_CODE;
			}else{
				$.messager.alert('提示',data.msg,'warning');
			}
        }
    }); 
};

function clearDeptForm(){
	$('#deptEditForm').form('load',{
		ID:'',
		ORG_ID:'',
		PARENT_DEPT_ID:'',
		DEPT_CODE:'',
		DEPT_NAME:'',
		DEPT_ALIAS:'',
		PARENT_DEPT_NAME:'',
		POST:'',
		TEL:'',
		FAX:'',
		EMAIL:'',
		WORK_CALENDAR_ID:'',
		ORDER_BY:'',
		DEPT_PLACE:'',
		DEPT_TYPE:'',
		VALID_FLAG:'',
		DEPT_DESC:''
		});
};

function showMessager(msg){
	var scroll =-document.body.scrollTop-document.documentElement.scrollTop;
	/*var isIE=!!window.ActiveXObject;
	var isIE6=isIE&&!window.XMLHttpRequest;
	//alert(document.documentElement.scrollTop);
	if(isIE6){
		//scroll+=129;
	}*/
	/*alert(document.body.scrollTop);
	alert(document.documentElement.scrollTop);
	alert(-document.body.scrollTop-document.documentElement.scrollTop+19);*/
	$.messager.show({
		title : '提示',
		msg : msg,
		timeout:2000,  
        showType:'slide',
        style:{
        	left:'',
        	right:0,
        	top:'',
            bottom:scroll
        }  
	});
};

function save(){
	if($('#DEPT_CODE').val().length >100){
		showMessager("部门编码不能太长！");
		return;
	}
	if($('#DEPT_NAME').val().length >100){
		showMessager("部门名称不能太长！");
		return;
	}
	 if(!$('#deptEditForm').form("validate")){
		 $.messager.alert('提示','请完善表单中的信息','warning');
		 return;
	 }
if (deptCode != $("#DEPT_CODE").val()){
		 

		 $.messager.confirm('请确认','更改部门编码可能导致数据同步及相关数据操作出现问题，是否继续？',
		function(b){
		if(b){
	 $.ajax({
	        cache:false,
	        type: "POST",
	        url:'platform/cc/sysdept/saveDept',
	        dataType:"json",
	        data:$('#deptEditForm').serialize(),
	        error: function(request) {
	        	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
	        },
	        success: function(data) {
				if(data.result==0){
					if(data.opType=="update"){
						parent.updateCurrentNode(data.sysDept);	
					}else if(data.opType="insert"){
						parent.addChildNode(data.sysDept);
													
					}
					parent.closeDialog("formEditDeptDialog");
				}else{
					$.messager.alert('提示',data.msg,'warning');
				}
	        }
	    });
		}
		 });
	 }else{
		 $.ajax({
		        cache:false,
		        type: "POST",
		        url:'platform/cc/sysdept/saveDept',
		        dataType:"json",
		        data:$('#deptEditForm').serialize(),
		        error: function(request) {
		        	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
		        },
		        success: function(data) {
					if(data.result==0){
						if(data.opType=="update"){
							parent.updateCurrentNode(data.sysDept);	
						}else if(data.opType="insert"){
							parent.addChildNode(data.sysDept);
														
						}
						parent.closeDialog("formEditDeptDialog");
					}else{
						$.messager.alert('提示',data.msg,'warning');
					}
		        }
		    });
	 }
}
</script>
</head>
<body class="easyui-layout"  fit="true">
<div region="center" border="false" style="overflow: hidden;">
			<form id="deptEditForm" name="deptEditForm" method="post">
				<input type="hidden"  name="ORG_ID" id="ORG_ID"></input>
				<input type="hidden"  name="ID" id="ID"></input>
				<input type="hidden"  name="PARENT_DEPT_ID" id="PARENT_DEPT_ID"></input>
				<input type="hidden"  name="PARENT_TYPE" id="PARENT_TYPE"></input>
				<table class="form_commonTable">
					<tr>
	                    <th width="10%"><span class="remind">*</span>部门编码:</th>
	                    <td width="40%" >
	                        <input title="部门代码" class="easyui-validatebox" data-options="required:true"  type="text" name="DEPT_CODE" id="DEPT_CODE"/>
	                    </td>
	                    <th width="10%"><span class="remind">*</span>部门名称:</th>
	                    <td>
	                        <input title="部门名称" class="easyui-validatebox" data-options="required:true"  type="text" name="DEPT_NAME" id="DEPT_NAME"/>
	                    </td>
	                </tr>
	                <tr>
	                    <th width="10%">部门别名:</th>
	                    <td width="40%">
	                        <input title="部门别名" class="easyui-text"  type="text" name="DEPT_ALIAS" id="DEPT_ALIAS"/>
	                    </td>
	                    <th width="10%">上级部门:</th>
	                    <td>
	                        <input title="上级部门" class="easyui-text" type="text" name="PARENT_DEPT_NAME" id="PARENT_DEPT_NAME"/>
	                    </td>
	                </tr>
					<tr>
	                    <th width="10%">邮编:</th>
	                    <td width="40%">
	                        <input title="邮编" class="easyui-validatebox" data-options="validType:'zipcode'" type="text" name="POST" id="POST"/>
	                    </td>
	                    <th width="10%">电话:</th>
	                    <td>
	                        <input title="电话" class="easyui-validatebox" data-options="validType:'tel'" type="text" name="TEL" id="TEL"/>
	                    </td>
	                </tr>
	                <tr>
	                    <th width="10%">传真:</th>
	                    <td width="40%">
	                        <input title="传真" class="easyui-validatebox" data-options="validType:'fax'" type="text" name="FAX" id="FAX"/>
	                    </td>
	                    <th width="10%">邮箱:</th>
	                    <td>
	                        <input title="邮箱" class="easyui-validatebox" data-options="validType:'email'" type="text" name="EMAIL" id="EMAIL"/>
	                    </td>
	                </tr>
	                <tr>
	                    <th width="10%">工作日历:</th>
	                    <td width="40%">
	                        <input title="工作日历" class="easyui-datebox" type="text" name="WORK_CALENDAR_ID" id="WORK_CALENDAR_ID"/>
	                    </td>
	                    <th width="10%">排序编号:</th>
	                    <td>
	                        <input title="排序编号" class="easyui-numberbox" data-options="max:65535" type="text" name="ORDER_BY" id="ORDER_BY"/>
	                    </td>
	                </tr>
	                <tr>
	                    <th width="10%">工作地点:</th>
	                    <td width="40%">
	                        <input title="工作地点" class="easyui-validatebox" type="text" name="DEPT_PLACE" id="DEPT_PLACE"/>
	                    </td>
	                    <th width="10%">部门类型:</th>
	                    <td>
                         	<c:forEach items="<%=lookUpdeptType%>" var="data">
								<span class="block-box"><input type="radio" class="radiobox" name="DEPT_TYPE" id="DEPT_TYPE" value="${data.lookupCode}"/><span class="radiobox-text">${data.lookupName}</span></span>
							</c:forEach>
                    	</td>
	                </tr>
	                <tr>
	                    <th width="10%">状态:</th>
	                    <td width="40%">
	                        <c:forEach items="<%=lookUpValidFlag%>" var="data">
								<span class="block-box"><input type="radio" class="radiobox" name="VALID_FLAG" id="VALID_FLAG" value="${data.lookupCode}"/><span class="radiobox-text">${data.lookupName}</span></span>
							</c:forEach>
	                    </td>
	                </tr>
	                <tr>
	                	<th valign="top">描述:</th>
							<td colspan="3"style="_padding-left:16px;">
								<textarea class="textareabox" style="height:50px;width:391px;_width:397px;" rows="4"
									id="DEPT_DESC" name="DEPT_DESC"></textarea>
							</td>
					</tr>
				</table>
			</form> 
</div>
<div data-options="region:'south',border:false" style="height:40px;">
	<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
				<table class="tableForm" border="0" cellspacing="1" width='100%'>
					<tr>	
						<td align="right">
							<a href="javascript:void(0)" id="saveBtn" class="easyui-linkbutton primary-btn"  onclick="save()" >保存</a>
							<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:parent.closeDialog('formEditDeptDialog')" >返回</a>
						</td>
					</tr>
				</table>
	</div>
</div>
</body>
</html>