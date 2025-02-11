<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<HEAD>
<title>详细</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- ControllerPath = "assets/device/assetsustdtempacceptance/assetsUstdtempAcceptanceController/operation/Detail/id" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
										   				<input type="hidden" name="id" value="<c:out  value='${assetsUstdtempAcceptanceDTO.id}'/>" />		    
			   		    								   		    																																																																																																																																																																																																																																																																																																											<table class="form_commonTable">
				 <tr>
																																		 																	 													<th width="10%">
						    						  	<label for="acceptanceId">验收单号:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="acceptanceId"  id="acceptanceId" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.acceptanceId}'/>"/>
													   </td>
																														   									 									 																	 													<th width="10%">
						    						    <label for="createdByDeptAlias">申请人部门:</label></th>
						    							<td width="39%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="createdByDept" name="createdByDept"  value="<c:out  value='${assetsUstdtempAcceptanceDTO.createdByDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias"  readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.createdByDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="formState">单据状态:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.formState}'/>"/>
													   </td>
																														   									 									 																	 													<th width="10%">
						    						  	<label for="contractNum">合同编号:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="contractNum"  id="contractNum" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.contractNum}'/>"/>
													   </td>
															</tr>
								<tr>
																														   									 									 									 									 									 																	 													<th width="10%">
						    						  	<label for="deviceName">设备名称:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.deviceName}'/>"/>
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="unifiedId">统一编号:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.unifiedId}'/>"/>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="secretLevel">密级:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="" isNull="true" lookupCode="SECRET_LEVEL" defaultValue='${assetsUstdtempAcceptanceDTO.secretLevel}'/>
						    						   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="manufacturerId">生产厂家:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="manufacturerId"  id="manufacturerId" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.manufacturerId}'/>"/>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="stdId">申购单号:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="stdId"  id="stdId" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.stdId}'/>"/>
													   </td>
																														   									 																	 													<th width="10%">
						    						    <label for="chargeDeptAlias">责任部门:</label></th>
						    							<td width="39%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="chargeDept" name="chargeDept"  value="<c:out  value='${assetsUstdtempAcceptanceDTO.chargeDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="chargeDeptAlias" name="chargeDeptAlias"  readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.chargeDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						    <label for="chargePersonAlias">责任人:</label></th>
						    							<td width="39%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="chargePerson" name="chargePerson"  value="<c:out  value='${assetsUstdtempAcceptanceDTO.chargePerson}'/>"/>
							      <input class="form-control" placeholder="请选择用户" type="text" id="chargePersonAlias" name="chargePersonAlias" readonly="readonly"  value="<c:out  value='${assetsUstdtempAcceptanceDTO.chargePersonAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="chargePersonTel">责任人联系方式:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="chargePersonTel"  id="chargePersonTel" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.chargePersonTel}'/>"/>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="unitPrice">单价(元):</label></th>
						    							<td width="39%">
														  									 									 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="unitPrice" id="unitPrice" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.unitPrice}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>
																	 													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="deviceCategory">设备类别:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title="" isNull="true" lookupCode="DEVICE_CATEGORY" defaultValue='${assetsUstdtempAcceptanceDTO.deviceCategory}'/>
						    						   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="isRegularCheck">是否定检:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="isRegularCheck" id="isRegularCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.isRegularCheck}'/>
						    						   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="isSpotCheck">是否点检:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="isSpotCheck" id="isSpotCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.isSpotCheck}'/>
						    						   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="isAccuracyCheck">是否精度检查:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="isAccuracyCheck" id="isAccuracyCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.isAccuracyCheck}'/>
						    						   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="isMaintain">是否保养:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="isMaintain" id="isMaintain" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.isMaintain}'/>
						    						   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="isMetering">是否计量:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.isMetering}'/>
						    						   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="isNeedInstall">是否需要安装:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.isNeedInstall}'/>
						    						   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="isSceneMetering">是否现场计量:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="isSceneMetering" id="isSceneMetering" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.isSceneMetering}'/>
						    						   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="meteringId">计量标识:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="meteringId"  id="meteringId" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.meteringId}'/>"/>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						    <label for="metermanAlias">计量人员:</label></th>
						    							<td width="39%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="meterman" name="meterman"  value="<c:out  value='${assetsUstdtempAcceptanceDTO.meterman}'/>"/>
							      <input class="form-control" placeholder="请选择用户" type="text" id="metermanAlias" name="metermanAlias" readonly="readonly"  value="<c:out  value='${assetsUstdtempAcceptanceDTO.metermanAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="meteringDate">计量时间:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="meteringDate" readonly="readonly" id="meteringDate" value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${assetsUstdtempAcceptanceDTO.meteringDate}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="meteringCycle">计量周期:</label></th>
						    							<td width="39%">
														  									 									 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="meteringCycle" id="meteringCycle" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.meteringCycle}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>
																	 													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="position">安装地点:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="position"  id="position" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.position}'/>"/>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="isSafetyProduction">是否涉及安全生产:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="isSafetyProduction" id="isSafetyProduction" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.isSafetyProduction}'/>
						    						   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="financialResources">经费来源:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="financialResources"  id="financialResources" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.financialResources}'/>"/>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="belongProject">所属项目:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="belongProject"  id="belongProject" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.belongProject}'/>"/>
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="projectNo">项目序号:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="projectNo"  id="projectNo" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.projectNo}'/>"/>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="replyName">批复名称:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="replyName"  id="replyName" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.replyName}'/>"/>
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="approvalFormNumber">立项单号:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="approvalFormNumber"  id="approvalFormNumber" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.approvalFormNumber}'/>"/>
													   </td>
															</tr>
								<tr>
																														   									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 																	 													<th width="10%">
						    						  	<label for="abcCategory">ABC分类:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="abcCategory"  id="abcCategory" readonly="readonly" value="<c:out value='${assetsUstdtempAcceptanceDTO.abcCategory}'/>"/>
													   </td>
																														   									 						</tr>
						<tr>
						  <th><label for="attachment">附件</label></th>
							<td colspan="<%=2 * 2 - 1 %>">
								<div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
							</td>
						</tr>
				  </table>
		</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
//加载完后初始化
$(document).ready(function () {
	//初始化附件上传组件
    $('#attachment').uploaderExt({
		formId: '${assetsUstdtempAcceptanceDTO.id}',
		allowAdd: false,
		allowDelete: false
    });
	//form控件禁用
	setFormDisabled();
	$(document).keydown(function(event){  
		event.returnValue = false;
		return false;
	});  
});
</script>
</body>
</html>