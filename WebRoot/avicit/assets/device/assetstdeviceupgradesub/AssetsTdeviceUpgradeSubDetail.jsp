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
    <!-- ControllerPath = "assets/device/assetstdeviceupgradesub/assetsTdeviceUpgradeSubController/operation/Detail/id" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id" value="<c:out  value='${assetsTdeviceUpgradeSubDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="softwareName">软件名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareName" id="softwareName"
                           readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareName}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwareBasicName">软件简称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareBasicName" id="softwareBasicName"
                           readonly="readonly"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareBasicName}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwareId">CSCI标识:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareId" id="softwareId"
                           readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareId}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwareCode">软件代号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareCode" id="softwareCode"
                           readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareCode}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="softwareVersion">原软件版本:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareVersion" id="softwareVersion"
                           readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareVersion}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwareVersionNew">升级软件版本:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareVersionNew" id="softwareVersionNew"
                           readonly="readonly"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareVersionNew}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwareReleaseNum">软件发布号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareReleaseNum" id="softwareReleaseNum"
                           readonly="readonly"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareReleaseNum}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwarePeriod">研制阶段:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="softwarePeriod" id="softwarePeriod" title=""
                                  isNull="true" lookupCode="DEVELOPMENT_PERIOD"
                                  defaultValue='${assetsTdeviceUpgradeSubDTO.softwarePeriod}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="softwareCodeSize">代码规模:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="softwareCodeSize" id="softwareCodeSize"
                               readonly="readonly"
                               value="<c:out  value='${assetsTdeviceUpgradeSubDTO.softwareCodeSize}'/>"
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
                    <label for="softwareLeaderAlias">软件负责人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="softwareLeader" name="softwareLeader"
                               value="<c:out  value='${assetsTdeviceUpgradeSubDTO.softwareLeader}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="softwareLeaderAlias"
                               name="softwareLeaderAlias" readonly="readonly"
                               value="<c:out  value='${assetsTdeviceUpgradeSubDTO.softwareLeaderAlias}'/>">
                        <span class="input-group-addon">
                             <i class="glyphicon glyphicon-user"></i>
                          </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="softwareLanguage">编码语言:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareLanguage" id="softwareLanguage"
                           readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareLanguage}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwareRunEnvironment">运行环境:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareRunEnvironment"
                           id="softwareRunEnvironment" readonly="readonly"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareRunEnvironment}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="softwareDevEnvironment">开发环境:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareDevEnvironment"
                           id="softwareDevEnvironment" readonly="readonly"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareDevEnvironment}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="tdeviceSoftwareId">软件台账ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="tdeviceSoftwareId" id="tdeviceSoftwareId"
                           readonly="readonly"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.tdeviceSoftwareId}'/>"/>
                </td>
                <th width="10%">
                    <label for="upgradeInfo">升级说明:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" readonly="readonly" name="upgradeInfo"
                              id="upgradeInfo">${assetsTdeviceUpgradeSubDTO.upgradeInfo}</textarea>
                </td>

            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=4 * 2 - 1 %>">
                    <div id="attachment"></div>
                </td>
            </tr>
            <tr style="display: none">
                <th width="10%">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId" readonly="readonly"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.unifiedId}'/>"/>
                </td>
                <th width="10%">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeSubDTO.deviceName}'/>"/>
                </td>
                <th width="10%">
                    <label for="remarks">备注:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" readonly="readonly" name="remarks"
                              id="remarks">${assetsTdeviceUpgradeSubDTO.remarks}</textarea>
                </td>
                <th width="10%">
                    <label for="tdeviceForeign">子表外键:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="tdeviceForeign" id="tdeviceForeign"
                           readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeSubDTO.tdeviceForeign}'/>"/>
                </td>
            </tr>
            <tr style="display: none">
                <th width="10%">
                    <label for="attachementName">附件名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="attachementName" id="attachementName"
                           readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeSubDTO.attachementName}'/>"/>
                </td>
                <th width="10%">
                    <label for="attachementUrl">附件地址:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="attachementUrl" id="attachementUrl"
                           readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeSubDTO.attachementUrl}'/>"/>
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
        parent.assetsTdeviceUpgradeSub.closeDialog();
    }

    //加载完后初始化
    $(document).ready(function () {
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsTdeviceUpgradeSubDTO.id}',
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