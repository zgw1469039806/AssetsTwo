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
    <!-- ControllerPath = "assets/device/assetsfrmlossproc/assetsFrmlossProcController/operation/Detail/id" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id" value="<c:out  value='${assetsFrmlossProcDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="frmlossNo">报损编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="frmlossNo" id="frmlossNo" readonly="readonly"
                           value="<c:out value='${assetsFrmlossProcDTO.frmlossNo}'/>"/>
                </td>
                <th width="10%">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<c:out  value='${assetsFrmlossProcDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               name="createdByDeptAlias" readonly="readonly"
                               value="<c:out  value='${assetsFrmlossProcDTO.createdByDeptAlias}'/>">
                        <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="createdByTel">申请人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"
                           readonly="readonly" value="<c:out value='${assetsFrmlossProcDTO.createdByTel}'/>"/>
                </td>
                <th width="10%">
                    <label for="formState">单据状态:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="formState" id="formState" readonly="readonly"
                           value="<c:out value='${assetsFrmlossProcDTO.formState}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId" readonly="readonly"
                           value="<c:out value='${assetsFrmlossProcDTO.unifiedId}'/>"/>
                </td>
                <th width="10%">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           readonly="readonly" value="<c:out value='${assetsFrmlossProcDTO.deviceName}'/>"/>
                </td>
                <th width="10%">
                    <label for="deviceModel">设备型号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"
                           readonly="readonly" value="<c:out value='${assetsFrmlossProcDTO.deviceModel}'/>"/>
                </td>
                <th width="10%">
                    <label for="deviceSpec">设备规格:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"
                           readonly="readonly" value="<c:out value='${assetsFrmlossProcDTO.deviceSpec}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="manufacturerId">生产厂家:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="manufacturerId" id="manufacturerId"
                           readonly="readonly" value="<c:out value='${assetsFrmlossProcDTO.manufacturerId}'/>"/>
                </td>
                <th width="10%">
                    <label for="createdDate">立卡日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDate" id="createdDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsFrmlossProcDTO.createdDate}"/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="positionId">安装地点ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="positionId" id="positionId"
                           readonly="readonly" value="<c:out value='${assetsFrmlossProcDTO.positionId}'/>"/>
                </td>
                <th width="10%">
                    <label for="ownerIdAlias">责任人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerId" name="ownerId"
                               value="<c:out  value='${assetsFrmlossProcDTO.ownerId}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias"
                               name="ownerIdAlias" readonly="readonly"
                               value="<c:out  value='${assetsFrmlossProcDTO.ownerIdAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="ownerMobile">责任人联系电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="ownerMobile" id="ownerMobile"
                           readonly="readonly" value="<c:out value='${assetsFrmlossProcDTO.ownerMobile}'/>"/>
                </td>
                <th width="10%">
                    <label for="ownerDeptAlias">责任部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept"
                               value="<c:out  value='${assetsFrmlossProcDTO.ownerDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias"
                               name="ownerDeptAlias" readonly="readonly"
                               value="<c:out  value='${assetsFrmlossProcDTO.ownerDeptAlias}'/>">
                        <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="originalValue">账面原值:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="originalValue" id="originalValue"
                               readonly="readonly" value="<c:out  value='${assetsFrmlossProcDTO.originalValue}'/>"
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
                               readonly="readonly" value="<c:out  value='${assetsFrmlossProcDTO.totalDepreciation}'/>"
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
                    <label for="netValue">账面净值:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netValue" id="netValue" readonly="readonly"
                               value="<c:out  value='${assetsFrmlossProcDTO.netValue}'/>"
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
                    <label for="netSalvage">预计净残值:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netSalvage" id="netSalvage" readonly="readonly"
                               value="<c:out  value='${assetsFrmlossProcDTO.netSalvage}'/>"
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
                    <label for="frmlossReason">报损原因:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" readonly="readonly" name="frmlossReason"
                              id="frmlossReason">${assetsFrmlossProcDTO.frmlossReason}</textarea>
                </td>
                <th width="10%">
                    <label for="riskAnalysis">有关产品的风险分析:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" readonly="readonly" name="riskAnalysis"
                              id="riskAnalysis">${assetsFrmlossProcDTO.riskAnalysis}</textarea>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="recycleWarehouse">回收库:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="recycleWarehouse" id="recycleWarehouse"
                                  title="" isNull="true" lookupCode="RECOVERY_STORE"
                                  defaultValue='${assetsFrmlossProcDTO.recycleWarehouse}'/>
                </td>
                <th width="10%">
                    <label for="ifRecycle">是否已回收:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="ifRecycle" id="ifRecycle" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsFrmlossProcDTO.ifRecycle}'/>
                </td>
                <th width="10%">
                    <label for="deviceState">设备状态:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceState" id="deviceState"
                           readonly="readonly" value="<c:out value='${assetsFrmlossProcDTO.deviceState}'/>"/>
                </td>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=4 * 2 - 1 %>">
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
            formId: '${assetsFrmlossProcDTO.id}',
            allowAdd: false,
            allowDelete: false
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