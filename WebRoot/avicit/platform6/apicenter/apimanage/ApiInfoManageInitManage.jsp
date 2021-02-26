<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/monitor/apicenter/monitorapiinfo/monitorApiInfoController/toMonitorApiInfoManage" -->
<title>API中心管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<%-- <sec:accesscontrollist hasPermission="3" domainObject="formdialog_monitorApiInfo_button_add" permissionDes="添加">
				<a id="monitorApiInfo_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist> --%>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_monitorApiInfo_button_edit" permissionDes="编辑">
				<a id="monitorApiInfo_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_monitorApiInfo_button_delete" permissionDes="删除">
				<a id="monitorApiInfo_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_monitorApiInfo_button_quick" permissionDes="快速编辑">
				<a id="monitorApiInfo_quick" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="快速编辑"><i class="fa fa-edit"></i> 快速编辑</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="monitorApiInfo_keyWord" id="monitorApiInfo_keyWord" style="width: 240px;" class="form-control input-sm" placeholder="请输入查询条件"> <label
					id="monitorApiInfo_searchPart" class="icon icon-search form-tool-searchicon"></label>
			</div>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="monitorApiInfo_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
			</div>
		</div>
	</div>
	<table id="monitorApiInfojqGrid"></table>
	<div id="jqGridPager"></div>

<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
			    <th width="10%">API名称:</th>
				<td width="39%"><input title="API名称" class="form-control input-sm" type="text" name="apiName" id="apiName" /></td>
			    <th width="15%">服务编码:</th>
				<td width="35%"><input title="服务编码" class="form-control input-sm" type="text" name="serviceCode" id="serviceCode" /></td>
			</tr>
			<tr>
				<th width="10%">业务域:</th>
				<td width="39%">
				   <div class="input-group  input-group-sm">
				   <input type="hidden" id="businessDomain" name="businessDomain"> 
				   <input class="form-control businessDomainValue" type="text" id="businessDomainValue"> 
				   <span class="input-group-addon businessDomainValue" id="aa"> <i class="glyphicon glyphicon-equalizer"></i></span>
				   </div>
				<!-- <input title="业务域" class="form-control input-sm" type="text" name="businessDomain" id="businessDomain" /> -->
				
				</td>
				<th width="10%">应用编码:</th>
				<td width="39%"><input title="应用编码" class="form-control input-sm" type="text" name="appCode" id="appCode" /></td>
				
							</tr>
			<tr>
				<th width="10%">应用名称:</th>
				<td width="39%"><input title="应用名称" class="form-control input-sm" type="text" name="appName" id="appName" /></td>
			    <th width="10%">应用版本:</th>
				<td width="39%"><input title="应用版本" class="form-control input-sm" type="text" name="appVersion" id="appVersion" /></td>
			
			</tr>
			<tr>
				<th width="10%">API地址:</th>
				<td width="39%"><input title="API地址" class="form-control input-sm" type="text" name="apiServiceUri" id="apiServiceUri" /></td>
			    <th width="10%">API请求方式:</th>
				<td width="39%">
				     <c:set var="apiRequestMethods" value="get,post,put,delete,head,patch,options,trace"/>
				     <select class="form-control input-sm" name="apiRequestMethod" id="apiRequestMethod">
						  <option value="">--请选择--</option>
				          <c:forEach items="${apiRequestMethods}" var="e">
						  <option value="${e}">${e}</option>
				          </c:forEach>
					 </select>
			    </td>
			</tr>
			<tr>
			    <th width="10%">责任部门:</th>
				<td width="39%">
				   <div class="input-group  input-group-sm">
				   	  <input type="hidden"  id="deptName" name="deptName">
				      <input class="form-control" type="text" id="deptNameAlias" name="deptNameAlias" >
				      <span class="input-group-addon">
				        <i class="glyphicon glyphicon-equalizer"></i>
				      </span>
			        </div>
				</td>
			    
				<th width="10%">技术支持:</th>
				<td width="39%"><input title="技术支持" class="form-control input-sm" type="text" name="apiTechSupport" id="apiTechSupport" /></td>
			</tr>
		</table>
	</form>
</div>

<!-- 快速维护 -->
<div id="updateApiInfoQuickDialog" style="overflow: auto; display: none">
     <form id="quick_form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="12%"><i class="required">*</i>应用编码:</th>
				<td width="38%">
				    <select class="form-control input-sm quick" id="quick_appCode">
				        <option value="">--请选择--</option>
				        <c:forEach items="${appCodeList}" var ="appCode">
				           <option value="${appCode}">${appCode}</option>
				        </c:forEach>
				    </select>
				</td>
				<th width="12%"><i class="required">*</i>业务域:</th>
				<td width="38%">
				   <div class="input-group  input-group-sm">
				   <input type="hidden" class="quick" id="quick_businessDomain"> 
				   <input class="form-control quick_businessDomainValue quick" placeholder="业务域" type="text" id="quick_businessDomainValue"> 
				   <span class="input-group-addon quick_businessDomainValue " id="aa"> <i class="glyphicon glyphicon-equalizer"></i></span>
				   </div>
				</td>
			</tr>
			<tr>
				<th width="10%"><i class="required">*</i>应用版本:</th>
				<td width="39%">
				    <select class="form-control input-sm quick" id="quick_appVersion">
				        <option value="">--请选择--</option>
				        <c:forEach items="${appVersionList}" var ="appVersion">
				           <option value="${appVersion}">${appVersion}</option>
				        </c:forEach>
				    </select>
				</td>
			    <th width="10%"><i class="required">*</i>责任部门:</th>
				<td width="39%">
				   <div class="input-group  input-group-sm">
				   	  <input type="hidden" class="quick"  id="quick_deptName">
				      <input class="form-control quick" placeholder="责任部门" type="text" id="quick_deptNameAlias">
				      <span class="input-group-addon">
				         <i class="glyphicon glyphicon-equalizer"></i>
				      </span>
			        </div>
				</td>
			</tr>
			<tr>
				<th width="10%"><i class="required">*</i>应用名称:</th>
				<td width="89%"  colspan="3">
				   <input title="应用名称" placeholder="应用名称"  class="quick form-control input-sm" type="text" id="quick_appName" />
				</td>
			</tr>
			<tr>
				<th width="10%" >应用描述:</th>
				<td width="89%" colspan="3">
				    <input title="应用描述" placeholder="应用描述"  class="quick form-control input-sm" type="text" id="quick_appDesc" />
			    </td>
			</tr>
		</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/apicenter/apimanage/js/ApiManagerInfo.js" type="text/javascript"></script>
<script type="text/javascript">
	var monitorApiInfo;
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="monitorApiInfo.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="monitorApiInfo.detail(' + rowObject.id + ');">' + thisDate + '</a>';
	}

	$(document).ready(
		function() {
			var dataGridColModel = [ {
				label : 'id',
				name : 'id',
				key : true,
				width : 75,
				hidden : true
			},  {
				label : 'API名称',
				name : 'apiName',
				width : 150,
				formatter : formatValue
			},{
				label : '服务编码',
				name : 'serviceCode',
				width : 150
			},{
				label : '业务域编码',
				name : 'businessDomain',
				width : 150
			},{
				label : '应用编码',
				name : 'appCode',
				width : 150
			},{
				label : '应用名称',
				name : 'appName',
				width : 150
			},  {
				label : '应用描述',
				name : 'appDesc',
				width : 150,
				hidden : true
			}, {
				label : '应用版本',
				name : 'appVersion',
				width : 100,
				align:"center"
			},  {
				label : '服务描述',
				name : 'serviceDesc',
				width : 150,
				hidden : true
			}, {
				label : 'API地址',
				name : 'apiServiceUri',
				width : 150
			}, {
				label : 'API描述',
				name : 'apiDesc',
				width : 150,
				hidden : true
			}, {
				label : 'API版本',
				name : 'apiVersion',
				width : 150,
				hidden : true
			}, {
				label : 'API请求方式',
				name : 'apiRequestMethod',
				width : 100,
				align:"center"
			}, {
				label : 'API请求参数',
				name : 'apiRequestParam',
				width : 150,
				hidden : true
			}, {
				label : 'API请求头',
				name : 'apiRequestHeader',
				width : 150,
				hidden : true
			},{
				label : 'API返回格式',
				name : 'apiReturnFormat',
				width : 100,
				align:"center",
				hidden : true
			}, {
				label : 'API返回参数',
				name : 'apiReturnParam',
				width : 150,
				hidden : true
			}, {
				label : 'API返回示例',
				name : 'apiResponseSampleCode',
				width : 150,
				hidden : true
			},
			{
				label : 'API错误码',
				name : 'apiErrorInfo',
				width : 150,
				hidden : true
			},  {
				label : '责任部门ID',
				name : 'deptName',
				width : 150,
				hidden : true
			},   {
				label : '责任部门',
				name : 'deptNameAlias',
				width : 150
			}, {
				label : 'API技术支持',
				name : 'apiTechSupport',
				width : 150
			}];
			var searchNames = new Array();
			var searchTips = new Array();
			searchNames.push("apiName");
			searchTips.push("API名称");
			searchNames.push("serviceCode");
			searchTips.push("服务编码");
			var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
			$('#monitorApiInfo_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
			monitorApiInfo = new MonitorApiInfo('monitorApiInfojqGrid', '${url}','searchDialog', 'form','monitorApiInfo_keyWord', searchNames,dataGridColModel);
			//添加按钮绑定事件
			$('#monitorApiInfo_insert').bind('click', function() {
				monitorApiInfo.insert();
			});
			//编辑按钮绑定事件
			$('#monitorApiInfo_modify').bind('click', function() {
				monitorApiInfo.modify();
			});
			//删除按钮绑定事件
			$('#monitorApiInfo_del').bind('click', function() {
				monitorApiInfo.del();
			});
			/* $('#monitorApiInfo_del').bind('click', function() {
				monitorApiInfo.del();
			}); */
			//查询按钮绑定事件
			$('#monitorApiInfo_searchPart').bind('click',
					function() {
						monitorApiInfo.searchByKeyWord();
					});
			//打开高级查询框
			$('#monitorApiInfo_searchAll').bind('click',
					function() {
						monitorApiInfo.openSearchForm(this);
			});
			//责任部门
			$('#deptNameAlias').on('focus', function(e) {
				new H5CommonSelect({
					type : 'deptSelect',
					idFiled : 'deptName',
					textFiled : 'deptNameAlias'
				});
				this.blur();
				nullInput(e);
			});
			
			//责任部门
			$('#quick_deptNameAlias').on('focus', function(e) {
				new H5CommonSelect({
					type : 'deptSelect',
					idFiled : 'quick_deptName',
					textFiled : 'quick_deptNameAlias'
				});
				this.blur();
				nullInput(e);
			});

			//打开高级查询框
			$('#monitorApiInfo_quick').bind('click',
					function() {
						monitorApiInfo.openQuickForm(this);
			});
			
			$('.quick_businessDomainValue').on('click', function(e) {
				layer.open({
						type : 2,
						area : [ '300px', '450px' ],
						title : '请选择业务域',
						btn: ['确定', '取消'],
						maxmin : false, // 开启最大化最小化按钮
						content : 'apicenter/apiorganization/apiOrganizationController/toApiOrganizationManage/quick_businessDomain/quick_businessDomainValue',
						yes: function(index){
					        layer.close(index);
					    },
					    btn2: function(){
					    	$("#quick_businessDomainValue").val("");
							$("#quick_businessDomain").val("");
					    },
					    cancel: function(){
					    	$("#quick_businessDomainValue").val("");
							$("#quick_businessDomain").val("");
					      }
					});
			});
			
		});
</script>
</body>
</html>