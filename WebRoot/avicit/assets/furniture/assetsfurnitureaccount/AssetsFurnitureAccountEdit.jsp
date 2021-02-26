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
<head>
    <title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- ControllerPath = "demo/demoreception/demoReceptionController/operation/Add/id" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsFurnitureAccountDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsFurnitureAccountDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"
                           value="<c:out value='${assetsFurnitureAccountDTO.unifiedId}'/>"/>
                </td>
                <th width="10%">
                    <label for="assetId">资产编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="assetId" id="assetId"
                           value="<c:out value='${assetsFurnitureAccountDTO.assetId}'/>"/>
                </td>
                <th width="10%">
                    <label for="furnitureName">家具名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="furnitureName" id="furnitureName"
                           value="<c:out value='${assetsFurnitureAccountDTO.furnitureName}'/>"/>
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
                               name="ownerIdAlias" value="<c:out  value='${assetsFurnitureAccountDTO.ownerIdAlias}'/>">
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
                               name="ownerDeptAlias"
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
                               value="<c:out  value='${assetsFurnitureAccountDTO.userIdAlias}'/>">
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
                               name="userDeptAlias"
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
                           value="<c:out value='${assetsFurnitureAccountDTO.manufacturerId}'/>"/>
                </td>
                <th width="10%">
                    <label for="furnitureSpec">家具规格:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="furnitureSpec" id="furnitureSpec"
                           value="<c:out value='${assetsFurnitureAccountDTO.furnitureSpec}'/>"/>
                </td>
                <th width="10%">
                    <label for="createdDate">立卡日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDate" id="createdDate"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsFurnitureAccountDTO.createdDate}"/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="positionId">安装地点ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="positionId" id="positionId"
                           value="<c:out value='${assetsFurnitureAccountDTO.positionId}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="guaranteeDate">保修日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="guaranteeDate" id="guaranteeDate"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsFurnitureAccountDTO.guaranteeDate}"/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="contractNum">合同号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="contractNum" id="contractNum"
                           value="<c:out value='${assetsFurnitureAccountDTO.contractNum}'/>"/>
                </td>
                <th width="10%">
                    <label for="applyNum">申购单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="applyNum" id="applyNum"
                           value="<c:out value='${assetsFurnitureAccountDTO.applyNum}'/>"/>
                </td>
                <th width="10%">
                    <label for="checkNum">验收单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="checkNum" id="checkNum"
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
                           value="<c:out value='${assetsFurnitureAccountDTO.assetsFinanceType}'/>"/>
                </td>
                <th width="10%">
                    <label for="assetsSource">资产来源:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="assetsSource" id="assetsSource"
                           value="<c:out value='${assetsFurnitureAccountDTO.assetsSource}'/>"/>
                </td>
                <th width="10%">
                    <label for="assetsFinanceState">资产财务状态:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="assetsFinanceState" id="assetsFinanceState"
                           value="<c:out value='${assetsFurnitureAccountDTO.assetsFinanceState}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="financeEntryDate">财务入账时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="financeEntryDate"
                               id="financeEntryDate"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsFurnitureAccountDTO.financeEntryDate}"/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="originalValue">原值:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="originalValue" id="originalValue"
                               value="<c:out  value='${assetsFurnitureAccountDTO.originalValue}'/>"
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
                           value="<c:out value='${assetsFurnitureAccountDTO.depreciationMethod}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="depreciationYear">折旧年限:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="depreciationYear" id="depreciationYear"
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
                               value="<c:out  value='${assetsFurnitureAccountDTO.netSalvageRate}'/>"
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
                        <input class="form-control" type="text" name="netSalvage" id="netSalvage"
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
                        <input class="form-control" type="text" name="netValue" id="netValue"
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
                        <input class="form-control" type="text" name="monthCount" id="monthCount"
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
                        <input class="form-control" type="text" name="monthRemain" id="monthRemain"
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
                           value="<c:out value='${assetsFurnitureAccountDTO.instituteOrCompany}'/>"/>
                </td>
                <th width="10%">
                    <label for="indexInfo">指标信息:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="indexInfo" id="indexInfo"
                           value="<c:out value='${assetsFurnitureAccountDTO.indexInfo}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isTransFixed">是否转固:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="isTransFixed" id="isTransFixed"
                           value="<c:out value='${assetsFurnitureAccountDTO.isTransFixed}'/>"/>
                </td>
                <th width="10%">
                    <label for="proofNum">凭证编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="proofNum" id="proofNum"
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
                           value="<c:out value='${assetsFurnitureAccountDTO.furniturePhoto}'/>"/>
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
                    <input class="form-control input-sm" type="text" name="parentId" id="parentId"
                           value="<c:out value='${assetsFurnitureAccountDTO.parentId}'/>"/>
                </td>
                <th width="10%">
                    <label for="parentName">父级家具名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="parentName" id="parentName"
                           value="<c:out value='${assetsFurnitureAccountDTO.parentName}'/>"/>
                </td>

                <th width="10%">
                    <label for="guaranteePeriod">质保期(天):</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="guaranteePeriod" id="guaranteePeriod"
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
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice"
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
                <td colspan="<%=4 * 2 - 1%>">
                    <div id="attachment"></div>
                </td>
            </tr>
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height:60px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0);" title="保存" id="saveButton"
                       class="btn btn-primary form-tool-btn typeb btn-sm">保存</a>
                    <a href="javascript:void(0);" title="返回" id="returnButton"
                       class="btn btn-grey form-tool-btn btn-sm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
    // 关闭Dialog
    function closeForm() {
        parent.assetsFurnitureAccount.closeDialog('edit');
    }

    // 保存表单
    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }

        //验证附件密级
        var files = $('#attachment').uploaderExt('getUploadFiles');
        for (var i = 0; i < files.length; i++) {
            var name = files[i].name;
            var secretLevel = files[i].secretLevel;
            //这里验证密级
        }
        //限制保存按钮多次点击
        $('#saveButton').addClass('disabled').unbind("click");
        parent.assetsFurnitureAccount.save($('#form'), callback);
    }

    //上传附件
    function callback(id) {
        var files = $('#attachment').uploaderExt('getUploadFiles');
        if (files == 0) {
            closeForm();
        } else {
            $("#id").val(id);
            $('#attachment').uploaderExt('doUpload', id);
        }
    }

    //附件上传完后执行
    function afterUploadEvent() {
        parent.assetsFurnitureAccount.closeDialog('edit');
    }

    // 加载完后初始化
    $(document).ready(function () {
        //初始化日期控件
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
            beforeShow: function (selectedDate) {
                if ($('#' + selectedDate.id).val() == "") {
                    $(this).datetimepicker("setDate", new Date());
                    $('#' + selectedDate.id).val('');
                }
            }
        });
        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);

        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsFurnitureAccountDTO.id}',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: afterUploadEvent
        });

        //绑定表单验证规则
        parent.assetsFurnitureAccount.formValidate($('#form'));

        //保存按钮绑定事件
        $('#saveButton').bind('click', function () {
            saveForm();
        });

        //返回按钮绑定事件
        $('#returnButton').bind('click', function () {
            closeForm();
        });

        $('#ownerIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerId', textFiled: 'ownerIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#ownerDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDept', textFiled: 'ownerDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#userIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'userId', textFiled: 'userIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#userDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'userDept', textFiled: 'userDeptAlias'});
            this.blur();
            nullInput(e);
        });
    });
</script>
</body>
</html>