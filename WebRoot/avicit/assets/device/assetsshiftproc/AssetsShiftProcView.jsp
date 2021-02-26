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
    <!-- ControllerPath = "assets/device/assetsshiftproc/assetsShiftProcController/operation/Detail/id" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id" value="<c:out  value='${assetsShiftProcDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="shiftNo">移位编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="shiftNo" id="shiftNo" readonly="readonly"
                           value="<c:out value='${assetsShiftProcDTO.shiftNo}'/>"/>
                </td>
                <th width="10%">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<c:out  value='${assetsShiftProcDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               name="createdByDeptAlias" readonly="readonly"
                               value="<c:out  value='${assetsShiftProcDTO.createdByDeptAlias}'/>">
                        <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="createdByTel">申请人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"
                           readonly="readonly" value="<c:out value='${assetsShiftProcDTO.createdByTel}'/>"/>
                </td>
                <th width="10%">
                    <label for="formState">单据状态:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="formState" id="formState" readonly="readonly"
                           value="<c:out value='${assetsShiftProcDTO.formState}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId" readonly="readonly"
                           value="<c:out value='${assetsShiftProcDTO.unifiedId}'/>"/>
                </td>
                <th width="10%">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           readonly="readonly" value="<c:out value='${assetsShiftProcDTO.deviceName}'/>"/>
                </td>
                <th width="10%">
                    <label for="deviceModel">设备型号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"
                           readonly="readonly" value="<c:out value='${assetsShiftProcDTO.deviceModel}'/>"/>
                </td>
                <th width="10%">
                    <label for="deviceSpec">设备规格:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"
                           readonly="readonly" value="<c:out value='${assetsShiftProcDTO.deviceSpec}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="positionId">现安装地点:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="positionId" id="positionId"
                           readonly="readonly" value="<c:out value='${assetsShiftProcDTO.positionId}'/>"/>
                </td>
                <th width="10%">
                    <label for="shiftPosition">新安装位置:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="shiftPosition" id="shiftPosition"
                           readonly="readonly" value="<c:out value='${assetsShiftProcDTO.shiftPosition}'/>"/>
                </td>
                <th width="10%">
                    <label for="shiftCost">移位费用:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="shiftCost" id="shiftCost" readonly="readonly"
                               value="<c:out  value='${assetsShiftProcDTO.shiftCost}'/>"
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
                    <label for="shiftReason">设备移位理由:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" readonly="readonly" name="shiftReason"
                              id="shiftReason">${assetsShiftProcDTO.shiftReason}</textarea>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="simpleOrLarge">简易/大型设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="simpleOrLarge" id="simpleOrLarge" title=""
                                  isNull="true" lookupCode="SIMPLE_LARGE_SCALE"
                                  defaultValue='${assetsShiftProcDTO.simpleOrLarge}'/>
                </td>
                <th width="10%">
                    <label for="isSatisfyBearing">安装设备楼层承重是否满足:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSatisfyBearing" id="isSatisfyBearing"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.isSatisfyBearing}'/>
                </td>
                <th width="10%">
                    <label for="hasOutdoorUnit">设备是否有室外机:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasOutdoorUnit" id="hasOutdoorUnit" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.hasOutdoorUnit}'/>
                </td>
                <th width="10%">
                    <label for="isAllowOutdoorunit">所安装位置是否允许安装室外机:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAllowOutdoorunit" id="isAllowOutdoorunit"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.isAllowOutdoorunit}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="hasFoundation">设备是否需要地基基础:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasFoundation" id="hasFoundation" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.hasFoundation}'/>
                </td>
                <th width="10%">
                    <label for="useVoltage">使用电压:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="useVoltage" id="useVoltage"
                           readonly="readonly" value="<c:out value='${assetsShiftProcDTO.useVoltage}'/>"/>
                </td>
                <th width="10%">
                    <label for="hasVoltageCondition">安装位置是否具备电压条件:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasVoltageCondition" id="hasVoltageCondition"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.hasVoltageCondition}'/>
                </td>
                <th width="10%">
                    <label for="hasHumidityNeed">是否有温湿度要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasHumidityNeed" id="hasHumidityNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.hasHumidityNeed}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="humidityNeed">温湿度要求:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" readonly="readonly" name="humidityNeed"
                              id="humidityNeed">${assetsShiftProcDTO.humidityNeed}</textarea>
                </td>
                <th width="10%">
                    <label for="hasCleanlinessNeed">是否有洁净度要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasCleanlinessNeed" id="hasCleanlinessNeed"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.hasCleanlinessNeed}'/>
                </td>
                <th width="10%">
                    <label for="cleanlinessNeed">洁净度要求:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" readonly="readonly" name="cleanlinessNeed"
                              id="cleanlinessNeed">${assetsShiftProcDTO.cleanlinessNeed}</textarea>
                </td>
                <th width="10%">
                    <label for="hasWaterNeed">是否有用水要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasWaterNeed" id="hasWaterNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.hasWaterNeed}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="waterNeed">用水要求:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" readonly="readonly" name="waterNeed"
                              id="waterNeed">${assetsShiftProcDTO.waterNeed}</textarea>
                </td>
                <th width="10%">
                    <label for="hasGasNeed">是否有用气要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasGasNeed" id="hasGasNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.hasGasNeed}'/>
                </td>
                <th width="10%">
                    <label for="gasNeed">用气要求:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" readonly="readonly" name="gasNeed"
                              id="gasNeed">${assetsShiftProcDTO.gasNeed}</textarea>
                </td>
                <th width="10%">
                    <label for="hasLetNeed">是否有气体、污水排放:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasLetNeed" id="hasLetNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.hasLetNeed}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="letNeed">气体、污水排放要求:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" readonly="readonly" name="letNeed"
                              id="letNeed">${assetsShiftProcDTO.letNeed}</textarea>
                </td>
                <th width="10%">
                    <label for="hasOtherNeed">是否有其他特殊要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasOtherNeed" id="hasOtherNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.hasOtherNeed}'/>
                </td>
                <th width="10%">
                    <label for="otherNeed">其他特殊要求:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" readonly="readonly" name="otherNeed"
                              id="otherNeed">${assetsShiftProcDTO.otherNeed}</textarea>
                </td>
                <th width="10%">
                    <label for="hasAboveConditions">以上需求条件在拟安装地点是否都已具备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasAboveConditions" id="hasAboveConditions"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.hasAboveConditions}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="hasNoise">是否有噪音:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasNoise" id="hasNoise" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsShiftProcDTO.hasNoise}'/>
                </td>
                <th width="10%">
                    <label for="noiseInfluence">噪音是否影响安装地工作办公:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="noiseInfluence" id="noiseInfluence" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsShiftProcDTO.noiseInfluence}'/>
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
            formId: '${assetsShiftProcDTO.id}',
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