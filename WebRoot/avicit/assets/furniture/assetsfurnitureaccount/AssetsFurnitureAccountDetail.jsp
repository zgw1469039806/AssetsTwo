<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
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
    <!-- ControllerPath = "assets/furniture/assetsfurnitureaccount/assetsFurnitureAccountController/operation/Detail/id" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id" value="<c:out  value='${assetsFurnitureAccountDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId" readonly="readonly"
                           value="<c:out value='${assetsFurnitureAccountDTO.unifiedId}'/>"/>
                </td>
                <th width="10%">
                    <label for="assetId">资产编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="assetId" id="assetId" readonly="readonly"
                           value="<c:out value='${assetsFurnitureAccountDTO.assetId}'/>"/>
                </td>
                <th width="10%">
                    <label for="furnitureName">家具名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="furnitureName" id="furnitureName"
                           readonly="readonly" value="<c:out value='${assetsFurnitureAccountDTO.furnitureName}'/>"/>
                </td>
                <th width="10%">
                    <label for="furnitureCategory">家具分类:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="furnitureCategory" id="furnitureCategory"
                                  title="" isNull="true" lookupCode="FURNITURE_CATEGORY"
                                  defaultValue='${assetsFurnitureAccountDTO.furnitureCategory}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="ownerIdAlias">责任人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerId" name="ownerId"
                               value="<c:out  value='${assetsFurnitureAccountDTO.ownerId}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias"
                               name="ownerIdAlias" readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.ownerIdAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="ownerDeptAlias">责任人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept"
                               value="<c:out  value='${assetsFurnitureAccountDTO.ownerDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias"
                               name="ownerDeptAlias" readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.ownerDeptAlias}'/>">
                        <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="userIdAlias">使用人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userId" name="userId"
                               value="<c:out  value='${assetsFurnitureAccountDTO.userId}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="userIdAlias" name="userIdAlias"
                               readonly="readonly" value="<c:out  value='${assetsFurnitureAccountDTO.userIdAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="userDeptAlias">使用人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userDept" name="userDept"
                               value="<c:out  value='${assetsFurnitureAccountDTO.userDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="userDeptAlias"
                               name="userDeptAlias" readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.userDeptAlias}'/>">
                        <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="manufacturerId">生产厂家:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="manufacturerId" id="manufacturerId"
                           readonly="readonly" value="<c:out value='${assetsFurnitureAccountDTO.manufacturerId}'/>"/>
                </td>
                <th width="10%">
                    <label for="furnitureSpec">家具规格:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="furnitureSpec" id="furnitureSpec"
                           readonly="readonly" value="<c:out value='${assetsFurnitureAccountDTO.furnitureSpec}'/>"/>
                </td>
                <th width="10%">
                    <label for="createdDate">立卡日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDate" id="createdDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsFurnitureAccountDTO.createdDate}"/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="positionId">安装地点ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="positionId" id="positionId"
                           readonly="readonly" value="<c:out value='${assetsFurnitureAccountDTO.positionId}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="guaranteeDate">保修日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="guaranteeDate" id="guaranteeDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsFurnitureAccountDTO.guaranteeDate}"/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="contractNum">合同号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="contractNum" id="contractNum"
                           readonly="readonly" value="<c:out value='${assetsFurnitureAccountDTO.contractNum}'/>"/>
                </td>
                <th width="10%">
                    <label for="applyNum">申购单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="applyNum" id="applyNum" readonly="readonly"
                           value="<c:out value='${assetsFurnitureAccountDTO.applyNum}'/>"/>
                </td>
                <th width="10%">
                    <label for="checkNum">验收单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="checkNum" id="checkNum" readonly="readonly"
                           value="<c:out value='${assetsFurnitureAccountDTO.checkNum}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isFixedAssets">是否固定资产:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFixedAssets" id="isFixedAssets" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsFurnitureAccountDTO.isFixedAssets}'/>
                </td>
                <th width="10%">
                    <label for="assetsFinanceType">资产财务类别:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="assetsFinanceType" id="assetsFinanceType"
                           readonly="readonly" value="<c:out value='${assetsFurnitureAccountDTO.assetsFinanceType}'/>"/>
                </td>
                <th width="10%">
                    <label for="assetsSource">资产来源:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="assetsSource" id="assetsSource"
                           readonly="readonly" value="<c:out value='${assetsFurnitureAccountDTO.assetsSource}'/>"/>
                </td>
                <th width="10%">
                    <label for="assetsFinanceState">资产财务状态:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="assetsFinanceState" id="assetsFinanceState"
                           readonly="readonly"
                           value="<c:out value='${assetsFurnitureAccountDTO.assetsFinanceState}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="financeEntryDate">财务入账时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="financeEntryDate"
                               id="financeEntryDate" readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsFurnitureAccountDTO.financeEntryDate}"/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="originalValue">原值:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="originalValue" id="originalValue"
                               readonly="readonly" value="<c:out  value='${assetsFurnitureAccountDTO.originalValue}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="totalDepreciation">累计折旧:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalDepreciation" id="totalDepreciation"
                               readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.totalDepreciation}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="depreciationMethod">折旧方法:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="depreciationMethod" id="depreciationMethod"
                           readonly="readonly"
                           value="<c:out value='${assetsFurnitureAccountDTO.depreciationMethod}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="depreciationYear">折旧年限:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="depreciationYear" id="depreciationYear"
                               readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.depreciationYear}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="netSalvageRate">净残值率:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netSalvageRate" id="netSalvageRate"
                               readonly="readonly" value="<c:out  value='${assetsFurnitureAccountDTO.netSalvageRate}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="netSalvage">净残值:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netSalvage" id="netSalvage" readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.netSalvage}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="monthDepreciationRate">月折旧率:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthDepreciationRate" id="monthDepreciationRate"
                               readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.monthDepreciationRate}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="monthDepreciation">月折旧额:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthDepreciation" id="monthDepreciation"
                               readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.monthDepreciation}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="yearDepreciationRate">年折旧率:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="yearDepreciationRate" id="yearDepreciationRate"
                               readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.yearDepreciationRate}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="yearDepreciation">年折旧额:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="yearDepreciation" id="yearDepreciation"
                               readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.yearDepreciation}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="netValue">净值:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netValue" id="netValue" readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.netValue}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="monthCount">已提月份:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthCount" id="monthCount" readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.monthCount}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="monthRemain">未计提月份:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthRemain" id="monthRemain" readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.monthRemain}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="instituteOrCompany">研究所/公司:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="instituteOrCompany" id="instituteOrCompany"
                           readonly="readonly"
                           value="<c:out value='${assetsFurnitureAccountDTO.instituteOrCompany}'/>"/>
                </td>
                <th width="10%">
                    <label for="indexInfo">指标信息:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="indexInfo" id="indexInfo" readonly="readonly"
                           value="<c:out value='${assetsFurnitureAccountDTO.indexInfo}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isTransFixed">是否转固:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="isTransFixed" id="isTransFixed"
                           readonly="readonly" value="<c:out value='${assetsFurnitureAccountDTO.isTransFixed}'/>"/>
                </td>
                <th width="10%">
                    <label for="proofNum">凭证编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="proofNum" id="proofNum" readonly="readonly"
                           value="<c:out value='${assetsFurnitureAccountDTO.proofNum}'/>"/>
                </td>
                <th width="10%">
                    <label for="isInWorkflow">是否在流程中:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isInWorkflow" id="isInWorkflow" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsFurnitureAccountDTO.isInWorkflow}'/>
                </td>
                <th width="10%">
                    <label for="furniturePhoto">家具照片:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="furniturePhoto" id="furniturePhoto"
                           readonly="readonly" value="<c:out value='${assetsFurnitureAccountDTO.furniturePhoto}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="furnitureState">家具状态:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="furnitureState" id="furnitureState" title=""
                                  isNull="true" lookupCode="FURNITURE_STATE"
                                  defaultValue='${assetsFurnitureAccountDTO.furnitureState}'/>
                </td>
                <th width="10%">
                    <label for="parentId">父级家具ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="parentId" id="parentId" readonly="readonly"
                           value="<c:out value='${assetsFurnitureAccountDTO.parentId}'/>"/>
                </td>
                <th width="10%">
                    <label for="parentName">父级家具名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="parentName" id="parentName"
                           readonly="readonly" value="<c:out value='${assetsFurnitureAccountDTO.parentName}'/>"/>
                </td>

                <th width="10%">
                    <label for="guaranteePeriod">质保期(天):</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="guaranteePeriod" id="guaranteePeriod" readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.guaranteePeriod}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="unitPrice">单价:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice" readonly="readonly"
                               value="<c:out  value='${assetsFurnitureAccountDTO.unitPrice}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                    class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=4 * 2 - 1 %>">
                    <div id="attachment"></div>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
    //关闭Dialog
    function closeForm() {
        parent.assetsFurnitureAccount.closeDialog();
    }

    //加载完后初始化
    $(document).ready(function () {
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsFurnitureAccountDTO.id}',
            allowAdd: false,
            allowDelete: false
        });
        //返回按钮绑定事件
        $('#returnButton').bind('click', function () {
            closeForm();
        });
        //form控件禁用
        setFormDisabled();
        $(document).keydown(function (event) {
            event.returnValue = false;
            return false;
        });
    });
</script>
</body>
</html>