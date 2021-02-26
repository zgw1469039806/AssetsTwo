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
    <!-- ControllerPath = "assets/device/assetsustdregisterproc/assetsUstdregisterProcController/operation/Detail/id" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id" value="<c:out  value='${assetsUstdregisterProcDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="registerNo">非标立项编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="registerNo" id="registerNo"
                           readonly="readonly" value="<c:out value='${assetsUstdregisterProcDTO.registerNo}'/>"/>
                </td>
                <th width="10%">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<c:out  value='${assetsUstdregisterProcDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               name="createdByDeptAlias" readonly="readonly"
                               value="<c:out  value='${assetsUstdregisterProcDTO.createdByDeptAlias}'/>">
                        <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="createdByTel">申请人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"
                           readonly="readonly" value="<c:out value='${assetsUstdregisterProcDTO.createdByTel}'/>"/>
                </td>
                <th width="10%">
                    <label for="formState">单据状态:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="formState" id="formState" readonly="readonly"
                           value="<c:out value='${assetsUstdregisterProcDTO.formState}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           readonly="readonly" value="<c:out value='${assetsUstdregisterProcDTO.deviceName}'/>"/>
                </td>
                <th width="10%">
                    <label for="deviceCategory">设备类别:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title=""
                                  isNull="true" lookupCode="DEVICE_CATEGORY"
                                  defaultValue='${assetsUstdregisterProcDTO.deviceCategory}'/>
                </td>
                <th width="10%">
                    <label for="techInchargeAlias">技术负责人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="techIncharge" name="techIncharge"
                               value="<c:out  value='${assetsUstdregisterProcDTO.techIncharge}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="techInchargeAlias"
                               name="techInchargeAlias" readonly="readonly"
                               value="<c:out  value='${assetsUstdregisterProcDTO.techInchargeAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="projectDirectorAlias">项目主管:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="projectDirector" name="projectDirector"
                               value="<c:out  value='${assetsUstdregisterProcDTO.projectDirector}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias"
                               name="projectDirectorAlias" readonly="readonly"
                               value="<c:out  value='${assetsUstdregisterProcDTO.projectDirectorAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="singleOrSet">台/套:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="singleOrSet" id="singleOrSet" title=""
                                  isNull="true" lookupCode="SINGLE_OR_SET"
                                  defaultValue='${assetsUstdregisterProcDTO.singleOrSet}'/>
                </td>
                <th width="10%">
                    <label for="setCount">台(套)数:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="setCount" id="setCount" readonly="readonly"
                               value="<c:out  value='${assetsUstdregisterProcDTO.setCount}'/>"
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
                    <label for="budgetPrice">预算单价:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="budgetPrice" id="budgetPrice" readonly="readonly"
                               value="<c:out  value='${assetsUstdregisterProcDTO.budgetPrice}'/>"
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
                    <label for="financialEstimate">经费概算:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="financialEstimate" id="financialEstimate"
                               readonly="readonly"
                               value="<c:out  value='${assetsUstdregisterProcDTO.financialEstimate}'/>"
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
                    <label for="financialResources">经费来源:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources"
                                  title="" isNull="true" lookupCode="FINANCIAL_RESOURCES"
                                  defaultValue='${assetsUstdregisterProcDTO.financialResources}'/>
                </td>
                <th width="10%">
                    <label for="belongProject">所属项目:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="belongProject" id="belongProject"
                           readonly="readonly" value="<c:out value='${assetsUstdregisterProcDTO.belongProject}'/>"/>
                </td>
                <th width="10%">
                    <label for="projectNo">项目序号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="projectNo" id="projectNo" readonly="readonly"
                           value="<c:out value='${assetsUstdregisterProcDTO.projectNo}'/>"/>
                </td>
                <th width="10%">
                    <label for="simpleOrLarge">简易/大型设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="simpleOrLarge" id="simpleOrLarge" title=""
                                  isNull="true" lookupCode="SIMPLE_LARGE_SCALE"
                                  defaultValue='${assetsUstdregisterProcDTO.simpleOrLarge}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="installPosition">安装地点:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="installPosition" id="installPosition"
                           readonly="readonly" value="<c:out value='${assetsUstdregisterProcDTO.installPosition}'/>"/>
                </td>
                <th width="10%">
                    <label for="isSatisfyBearing">安装设备楼层承重能否满足:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSatisfyBearing" id="isSatisfyBearing"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdregisterProcDTO.isSatisfyBearing}'/>
                </td>
                <th width="10%">
                    <label for="hasOutdoorUnit">设备是否有室外机:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasOutdoorUnit" id="hasOutdoorUnit" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdregisterProcDTO.hasOutdoorUnit}'/>
                </td>
                <th width="10%">
                    <label for="isAllowOutdoorunit">所安装位置是否允许安装室外机:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAllowOutdoorunit" id="isAllowOutdoorunit"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdregisterProcDTO.isAllowOutdoorunit}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="hasFoundation">所安装位置是否具备设置地基条件:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasFoundation" id="hasFoundation" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdregisterProcDTO.hasFoundation}'/>
                </td>
                <th width="10%">
                    <label for="useVoltage">使用电压:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="useVoltage" id="useVoltage"
                           readonly="readonly" value="<c:out value='${assetsUstdregisterProcDTO.useVoltage}'/>"/>
                </td>
                <th width="10%">
                    <label for="hasVoltageCondition">安装位置是否具备电压条件:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasVoltageCondition" id="hasVoltageCondition"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdregisterProcDTO.hasVoltageCondition}'/>
                </td>
                <th width="10%">
                    <label for="hasHumidityNeed">是否有温湿度要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasHumidityNeed" id="hasHumidityNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdregisterProcDTO.hasHumidityNeed}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="humidityNeed">温湿度要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="humidityNeed" id="humidityNeed"
                           readonly="readonly" value="<c:out value='${assetsUstdregisterProcDTO.humidityNeed}'/>"/>
                </td>
                <th width="10%">
                    <label for="hasCleanlinessNeed">是否有洁净度要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasCleanlinessNeed" id="hasCleanlinessNeed"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdregisterProcDTO.hasCleanlinessNeed}'/>
                </td>
                <th width="10%">
                    <label for="cleanlinessNeed">净度要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="cleanlinessNeed" id="cleanlinessNeed"
                           readonly="readonly" value="<c:out value='${assetsUstdregisterProcDTO.cleanlinessNeed}'/>"/>
                </td>
                <th width="10%">
                    <label for="hasWaterNeed">是否有用水要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasWaterNeed" id="hasWaterNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdregisterProcDTO.hasWaterNeed}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="waterNeed">用水要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="waterNeed" id="waterNeed" readonly="readonly"
                           value="<c:out value='${assetsUstdregisterProcDTO.waterNeed}'/>"/>
                </td>
                <th width="10%">
                    <label for="hasGasNeed">是否有用气要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasGasNeed" id="hasGasNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdregisterProcDTO.hasGasNeed}'/>
                </td>
                <th width="10%">
                    <label for="gasNeed">用气要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="gasNeed" id="gasNeed" readonly="readonly"
                           value="<c:out value='${assetsUstdregisterProcDTO.gasNeed}'/>"/>
                </td>
                <th width="10%">
                    <label for="hasLetNeed">是否有气体排放要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasLetNeed" id="hasLetNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdregisterProcDTO.hasLetNeed}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="letNeed">气体排放要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="letNeed" id="letNeed" readonly="readonly"
                           value="<c:out value='${assetsUstdregisterProcDTO.letNeed}'/>"/>
                </td>
                <th width="10%">
                    <label for="hasOtherNeed">是否有其他特殊要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasOtherNeed" id="hasOtherNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdregisterProcDTO.hasOtherNeed}'/>
                </td>
                <th width="10%">
                    <label for="otherNeed">其他特殊要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="otherNeed" id="otherNeed" readonly="readonly"
                           value="<c:out value='${assetsUstdregisterProcDTO.otherNeed}'/>"/>
                </td>
                <th width="10%">
                    <label for="hasAboveConditions">以上需求条件在拟安装地点是否都已具备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasAboveConditions" id="hasAboveConditions"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdregisterProcDTO.hasAboveConditions}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="supplementaryNotes">条件不具备补充说明:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="supplementaryNotes" id="supplementaryNotes"
                           readonly="readonly"
                           value="<c:out value='${assetsUstdregisterProcDTO.supplementaryNotes}'/>"/>
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
            formId: '${assetsUstdregisterProcDTO.id}',
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