<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdevicemetering/assetsDeviceMeteringController/toAssetsDeviceMeteringManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div id="panelnorth"
     data-options="region:'north',height:fixheight(.5),onResize:function(a){$('#assetsDeviceMetering').setGridWidth(a);$('#assetsDeviceMetering').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
    <div id="toolbar_assetsDeviceMetering" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceMetering_button_add"
                                   permissionDes="添加">
                <a id="assetsDeviceMetering_insert" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i>
                    添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceMetering_button_add_staff"
                                   permissionDes="添加">
                <a id="assetsDeviceMetering_insert_staff" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="计量计划员发起"><i class="fa fa-plus"></i>
                    计量计划员发起</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceMetering_button_edit"
                                   permissionDes="编辑">
                <a id="assetsDeviceMetering_modify" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="编辑"><i
                        class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceMetering_button_delete"
                                   permissionDes="删除">
                <a id="assetsDeviceMetering_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   style="display:none;" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
            </sec:accesscontrollist>
        </div>
        <div class="toolbar-right">
            <select id="workFlowSelect"
                    class="form-control input-sm workflow-select">
                <option value="all" selected="selected">全部</option>
                <option value="start">拟稿中</option>
                <option value="active">流转中</option>
                <option value="ended">已完成</option>
            </select>
            <div class="input-group form-tool-search" style="width:125px">
                <input type="text" name="assetsDeviceMetering_keyWord" id="assetsDeviceMetering_keyWord"
                       style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsDeviceMetering_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsDeviceMetering_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button">高级查询 <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="assetsDeviceMetering"></table>
    <div id="assetsDeviceMeteringPager"></div>
</div>
<div id="centerpanel"
     data-options="region:'center',split:true,onResize:function(a){$('#dynDeviceTool').setGridWidth(a); $('#dynDeviceTool').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
    <div id="toolbar_dynDeviceTool" class="toolbar">
        <div class="toolbar-right">
            <div class="input-group form-tool-search" style="width:125px">
                <input type="text" name="dynDeviceTool_keyWord" id="dynDeviceTool_keyWord" style="width:125px;"
                       class="form-control input-sm" placeholder="请输入查询条件">
                <label id="dynDeviceTool_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="dynDeviceTool_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
                    <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="dynDeviceTool"></table>
    <div id="dynDeviceToolPager"></div>
</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">申请人ID:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="applicantId" name="applicantId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="applicantIdAlias"
                               name="applicantIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">申请人部门:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="applicantDepart" name="applicantDepart">
                        <input class="form-control" placeholder="请选择部门" type="text" id="applicantDepartAlias"
                               name="applicantDepartAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">责任人:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerId" name="ownerId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias"
                               name="ownerIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">责任人部门:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias"
                               name="ownerDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">送检人ID:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="senddevicePid" name="senddevicePid">
                        <input class="form-control" placeholder="请选择用户" type="text" id="senddevicePidAlias"
                               name="senddevicePidAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">送检人部门:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="senddeviceDept" name="senddeviceDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="senddeviceDeptAlias"
                               name="senddeviceDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">取走人ID:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="takedevicePid" name="takedevicePid">
                        <input class="form-control" placeholder="请选择用户" type="text" id="takedevicePidAlias"
                               name="takedevicePidAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">取走人部门:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="takedeviceDept" name="takedeviceDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="takedeviceDeptAlias"
                               name="takedeviceDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">外送员ID:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="deliveryPid" name="deliveryPid">
                        <input class="form-control" placeholder="请选择用户" type="text" id="deliveryPidAlias"
                               name="deliveryPidAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">外送员部门:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="deliveryDept" name="deliveryDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="deliveryDeptAlias"
                               name="deliveryDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">表单状态:</th>
                <td width="39%">
                    <input title="表单状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
                </td>
                <th width="10%">统一编号:</th>
                <td width="39%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备名称:</th>
                <td width="39%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
                <th width="10%">设备类别:</th>
                <td width="39%">
                    <input title="设备类别" class="form-control input-sm" type="text" name="deviceCategory"
                           id="deviceCategory"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备规格:</th>
                <td width="39%">
                    <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>
                <th width="10%">设备型号:</th>
                <td width="39%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
            </tr>
            <tr>
                <th width="10%">密级:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="密级"
                                  isNull="true" lookupCode="SECRET_LEVEL"/>
                </td>
                <th width="10%">安装地点ID:</th>
                <td width="39%">
                    <input title="安装地点ID" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">生产厂家:</th>
                <td width="39%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturer"
                           id="manufacturer"/>
                </td>
                <th width="10%">是否计量:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title="是否计量"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">计量方式:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="meterMode" id="meterMode" title="计量方式"
                                  isNull="true" lookupCode="METERING_MODE"/>
                </td>
                <th width="10%">计量完成时间(从):</th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="meterFinishDateBegin"
                               id="meterFinishDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">计量完成时间(至):</th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="meterFinishDateEnd"
                               id="meterFinishDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">计量周期:</th>
                <td width="39%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="meterCycle" id="meterCycle"
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
                <th width="10%">上次计量时间(从):</th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMeteringDateBegin"
                               id="lastMeteringDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上次计量时间(至):</th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMeteringDateEnd"
                               id="lastMeteringDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">计量员:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meterPerson" name="meterPerson">
                        <input class="form-control" placeholder="请选择用户" type="text" id="meterPersonAlias"
                               name="meterPersonAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">计量计划员:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meterPlanPerson" name="meterPlanPerson">
                        <input class="form-control" placeholder="请选择用户" type="text" id="meterPlanPersonAlias"
                               name="meterPlanPersonAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">外送员:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meterTakeawayPerson" name="meterTakeawayPerson">
                        <input class="form-control" placeholder="请选择用户" type="text" id="meterTakeawayPersonAlias"
                               name="meterTakeawayPersonAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">计量结论:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="meterConclusion" id="meterConclusion"
                                  title="计量结论" isNull="true" lookupCode="METERING_CONCLUTION"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否派生超差追溯:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="isDeriveOft" id="isDeriveOft" title="是否派生超差追溯"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">快递单号:</th>
                <td width="39%">
                    <input title="快递单号" class="form-control input-sm" type="text" name="expressNumber"
                           id="expressNumber"/>
                </td>
            </tr>
            <tr>
                <th width="10%">预送检日期(从):</th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="deliveryDateBegin"
                               id="deliveryDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">预送检日期(至):</th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="deliveryDateEnd"
                               id="deliveryDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">计量文件受控号:</th>
                <td width="39%">
                    <input title="计量文件受控号" class="form-control input-sm" type="text" name="procedureFileId"
                           id="procedureFileId"/>
                </td>
                <th width="10%">计量任务来源:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="meteringOrigin" id="meteringOrigin"
                                  title="计量任务来源" isNull="true" lookupCode="METERING_ORIGIN_TYPE"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否允许外送检:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="isDeliveryAllowed" id="isDeliveryAllowed"
                                  title="是否允许外送检" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">形式审核结论:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="formCheckConclude" id="formCheckConclude"
                                  title="形式审核结论" isNull="true" lookupCode="conclusion"/>
                </td>
            </tr>
            <tr>
                <th width="10%">计量室主任审核结论:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="managerConclude" id="managerConclude"
                                  title="计量室主任审核结论" isNull="true" lookupCode="conclusion"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
    <form id="formSub">
        <table class="form_commonTable">
            <tr>
                <th width="10%">计量文件规范号:</th>
                <td width="39%">
                    <input title="计量文件规范号" class="form-control input-sm" type="text" name="procedureFile"
                           id="procedureFile"/>
                </td>
                <th width="10%">设备名称:</th>
                <td width="39%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">生产厂家:</th>
                <td width="39%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId"
                           id="manufacturerId"/>
                </td>
                <th width="10%">统一编号:</th>
                <td width="39%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备类别:</th>
                <td width="39%">
                    <input title="设备类别" class="form-control input-sm" type="text" name="deviceCategory"
                           id="deviceCategory"/>
                </td>
                <th width="10%">设备规格:</th>
                <td width="39%">
                    <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备型号:</th>
                <td width="39%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script src="avicit/assets/device/assetsdevicemetering/js/AssetsDeviceMetering.js" type="text/javascript"></script>
<script src="avicit/assets/device/assetsdevicemetering/js/DynDeviceTool.js" type="text/javascript"></script>
<script type="text/javascript">
    var assetsDeviceMetering;
    var dynDeviceTool;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsDeviceMetering.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsDeviceMetering.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsDeviceMetering.reLoad();
    };

    $(document).ready(function () {
        var searchMainNames = new Array();
        var searchMainTips = new Array();
        searchMainNames.push("formState");
        searchMainTips.push("表单状态");
        searchMainNames.push("unifiedId");
        searchMainTips.push("统一编号");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#assetsDeviceMetering_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#assetsDeviceMetering_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);
        var searchSubNames = new Array();
        var searchSubTips = new Array();
        searchSubNames.push("procedureFile");
        searchSubTips.push("计量文件规范号");
        searchSubNames.push("deviceName");
        searchSubTips.push("设备名称");
        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
        $('#dynDeviceTool_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        $('#dynDeviceTool_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);
        var assetsDeviceMeteringGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '计量申请单号', name: 'procId', width: 150,formatter: formatValue}
            , {label: '创建时间', name: 'creationDate', width: 150, formatter: format}
            , {label: '申请人', name: 'applicantIdAlias', width: 150}
            , {label: '申请人部门', name: 'applicantDepartAlias', width: 150, hidden: true}
            , {label: '责任人', name: 'ownerIdAlias', width: 150, hidden: true}
            , {label: '责任人部门', name: 'ownerDeptAlias', width: 150, hidden: true}
            , {label: '送检人', name: 'senddevicePidAlias', width: 150, hidden: true}
            , {label: '送检人部门', name: 'senddeviceDeptAlias', width: 150, hidden: true}
            , {label: '取走人', name: 'takedevicePidAlias', width: 150, hidden: true}
            , {label: '取走人部门', name: 'takedeviceDeptAlias', width: 150, hidden: true}
            , {label: '外送员', name: 'deliveryPidAlias', width: 150, hidden: true}
            , {label: '外送员部门', name: 'deliveryDeptAlias', width: 150, hidden: true}
            , {label: '表单状态', name: 'formState', width: 150, hidden: true}
            , {label: '统一编号', name: 'unifiedId', width: 150,formatter: formatValue}
            , {label: '设备名称', name: 'deviceName', width: 150,formatter: formatValue}
            , {label: '设备类别', name: 'deviceCategory', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '密级', name: 'secretLevel', width: 150, hidden: true}
            , {label: '安装地点', name: 'positionId', width: 150, hidden: true}
            , {label: '生产厂家', name: 'manufacturer', width: 150, hidden: true}
            , {label: '是否计量', name: 'isMetering', width: 150, hidden: true}
            , {label: '计量方式', name: 'meterMode', width: 150}
            , {label: '计量完成时间', name: 'meterFinishDate', width: 150, formatter: format, hidden: true}
            , {label: '计量周期', name: 'meterCycle', width: 150}
            , {label: '上次计量时间', name: 'lastMeteringDate', width: 150, formatter: format}
            , {label: '计量员', name: 'meterPersonAlias', width: 150}
            , {label: '计量计划员', name: 'meterPlanPersonAlias', width: 150}
            , {label: '外送员', name: 'meterTakeawayPersonAlias', width: 150, hidden: true}
            , {label: '计量结论', name: 'meterConclusion', width: 150, hidden: true}
            , {label: '是否派生超差追溯', name: 'isDeriveOft', width: 150, hidden: true}
            , {label: '快递单号', name: 'expressNumber', width: 150, hidden: true}
            , {label: '预送检日期', name: 'deliveryDate', width: 150, formatter: format, hidden: true}
            , {label: '计量文件受控号', name: 'procedureFileId', width: 150, hidden: true}
            , {label: '计量任务来源', name: 'meteringOrigin', width: 150, hidden: true}
            , {label: '是否允许外送检', name: 'isDeliveryAllowed', width: 150, hidden: true}
            , {label: '形式审核结论', name: 'formCheckConclude', width: 150, hidden: true}
            , {label: '计量室主任审核结论', name: 'managerConclude', width: 150, hidden: true}
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            , {label: '流程状态', name: 'businessstate_', width: 150}
        ];
        var dynDeviceToolGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '计量文件规范号', name: 'procedureFile', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '设备类别', name: 'deviceCategory', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
        ];

        assetsDeviceMetering = new AssetsDeviceMetering('assetsDeviceMetering', '${url}', 'form', assetsDeviceMeteringGridColModel, 'searchDialog',
            function (pid) {
                dynDeviceTool = new DynDeviceTool('dynDeviceTool', '${surl}', "formSub", dynDeviceToolGridColModel, 'searchDialogSub', pid, searchSubNames, "dynDeviceTool_keyWord");
            },
            function (pid) {
                dynDeviceTool.reLoad(pid);
            },
            searchMainNames,
            "assetsDeviceMetering_keyWord");
        //主表操作
        //添加按钮绑定事件
        $('#assetsDeviceMetering_insert').bind('click', function () {
            assetsDeviceMetering.insert();
        });
        $('#assetsDeviceMetering_insert_staff').bind('click', function () {
            assetsDeviceMetering.insert_staff();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceMetering_modify').bind('click', function () {
            assetsDeviceMetering.modify();
        });
        //删除按钮绑定事件
        $('#assetsDeviceMetering_del').bind('click', function () {
            assetsDeviceMetering.del();
        });
        //打开高级查询框
        $('#assetsDeviceMetering_searchAll').bind('click', function () {
            assetsDeviceMetering.openSearchForm(this, $('#assetsDeviceMetering'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsDeviceMetering_searchPart').bind('click', function () {
            assetsDeviceMetering.searchByKeyWord();
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsDeviceMetering.initWorkFlow($(this).val());
        });
        //子表操作
        //打开高级查询
        $('#dynDeviceTool_searchAll').bind('click', function () {
            dynDeviceTool.openSearchForm(this, $('#dynDeviceTool'));
        });
        //关键字段查询按钮绑定事件
        $('#dynDeviceTool_searchPart').bind('click', function () {
            dynDeviceTool.searchByKeyWord();
        });

        $('#applicantIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'applicantId', textFiled: 'applicantIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#applicantDepartAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'applicantDepart', textFiled: 'applicantDepartAlias'});
            this.blur();
            nullInput(e);
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
        $('#senddevicePidAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'senddevicePid', textFiled: 'senddevicePidAlias'});
            this.blur();
            nullInput(e);
        });
        $('#senddeviceDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'senddeviceDept', textFiled: 'senddeviceDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#takedevicePidAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'takedevicePid', textFiled: 'takedevicePidAlias'});
            this.blur();
            nullInput(e);
        });
        $('#takedeviceDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'takedeviceDept', textFiled: 'takedeviceDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#deliveryPidAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'deliveryPid', textFiled: 'deliveryPidAlias'});
            this.blur();
            nullInput(e);
        });
        $('#deliveryDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'deliveryDept', textFiled: 'deliveryDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#meterPersonAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'meterPerson', textFiled: 'meterPersonAlias'});
            this.blur();
            nullInput(e);
        });
        $('#meterPlanPersonAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'meterPlanPerson', textFiled: 'meterPlanPersonAlias'});
            this.blur();
            nullInput(e);
        });
        $('#meterTakeawayPersonAlias').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'meterTakeawayPerson',
                textFiled: 'meterTakeawayPersonAlias'
            });
            this.blur();
            nullInput(e);
        });


    });

</script>
</html>