<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdevicerepair/assetsDeviceRepairController/toAssetsDeviceRepairManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceRepair_button_add"
                               permissionDes="添加">
            <a id="assetsDeviceRepair_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceRepair_button_add1"
                               permissionDes="添加">
            <a id="assetsDeviceRepair_insert1" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="维修员录入故障"><i class="fa fa-plus"></i> 维修员录入故障</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceRepair_button_edit"
                               permissionDes="编辑">
            <a id="assetsDeviceRepair_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="编辑" style="display:none;"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceRepair_button_delete"
                               permissionDes="删除">
            <a id="assetsDeviceRepair_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="删除" style="display:none;"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <select id="workFlowSelect" class="form-control input-sm workflow-select">
            <option value="all" selected="selected">全部</option>
            <option value="start">拟稿中</option>
            <option value="active">流转中</option>
            <option value="ended">已完成</option>
        </select>
        <div class="input-group form-tool-search">
            <input type="text" name="assetsDeviceRepair_keyWord" id="assetsDeviceRepair_keyWord" style="width:240px;"
                   class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsDeviceRepair_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsDeviceRepair_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
                <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsDeviceRepairjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">申请人:</th>
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
                <th width="10%">统一编号:</th>
                <td width="39%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">表单状态:</th>
                <td width="39%">
                    <input title="表单状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
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
                <th width="10%">责任人联系方式:</th>
                <td width="39%">
                    <input title="责任人联系方式" class="form-control input-sm" type="text" name="contact" id="contact"/>
                </td>
                <th width="10%">安装地点:</th>
                <td width="39%">
                    <input title="安装地点" class="form-control input-sm" type="text" name="position" id="position"/>
                </td>
            </tr>
            <tr>
                <th width="10%">生产厂家:</th>
                <td width="39%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturer"
                           id="manufacturer"/>
                </td>
                <th width="10%">是否计算机:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="isPc" id="isPc" title="是否计算机" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否测试设备:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="isTestDevice" id="isTestDevice" title="是否测试设备"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否需要计量:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title="是否需要计量"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">维修部门:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="repairDept" name="repairDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="repairDeptAlias"
                               name="repairDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">故障现象描述:</th>
                <td width="39%">
                    <textarea class="form-control input-sm" rows="3" title="故障现象描述" name="failureDesc"
                              id="failureDesc"></textarea>
                </td>
            </tr>
            <tr>
                <th width="10%">故障维修记录:</th>
                <td width="39%">
                    <textarea class="form-control input-sm" rows="3" title="故障维修记录" name="repairDesc"
                              id="repairDesc"></textarea>
                </td>
                <th width="10%">维修完成时间(从):</th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="repairFinishTimeBegin"
                               id="repairFinishTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">维修完成时间(至):</th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="repairFinishTimeEnd"
                               id="repairFinishTimeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">结果确认:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="finishAck" id="finishAck" title="结果确认"
                                  isNull="true" lookupCode="RESULT_CHECK"/>
                </td>
            </tr>
            <tr>
                <th width="10%">维修质量:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="repairQuality" id="repairQuality" title="维修质量"
                                  isNull="true" lookupCode="REPAIR_ASSESSMENT"/>
                </td>
                <th width="10%">故障分析:</th>
                <td width="39%">
                    <pt6:h5checkbox css_class="checkbox-inline" name="failureAnalysisId" title="故障分析" canUse="0"
                                    lookupCode="FAILURE_TYPE_ANALYSE"/>
                </td>
            </tr>
            <tr>
                <th width="10%">故障分析描述:</th>
                <td width="39%">
                    <textarea class="form-control input-sm" rows="3" title="故障分析描述" name="failureAnalysisDesc"
                              id="failureAnalysisDesc"></textarea>
                </td>
                <th width="10%">服务态度:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="serviceAttitude" id="serviceAttitude"
                                  title="服务态度" isNull="true" lookupCode="REPAIR_ASSESSMENT"/>
                </td>
            </tr>
            <tr>
                <th width="10%">维修进度:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="repairProgress" id="repairProgress"
                                  title="维修进度" isNull="true" lookupCode="REPAIR_ASSESSMENT"/>
                </td>
                <th width="10%">维修计划员:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="repairPlanStaff" name="repairPlanStaff">
                        <input class="form-control" placeholder="请选择用户" type="text" id="repairPlanStaffAlias"
                               name="repairPlanStaffAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">维修员:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="repairStaff" name="repairStaff">
                        <input class="form-control" placeholder="请选择用户" type="text" id="repairStaffAlias"
                               name="repairStaffAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">计量计划员:</th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meterPlanStaff" name="meterPlanStaff">
                        <input class="form-control" placeholder="请选择用户" type="text" id="meterPlanStaffAlias"
                               name="meterPlanStaffAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">是否存在额外开支:</th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="hasExtraExpense" id="hasExtraExpense"
                                  title="是否存在额外开支" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">额外开支说明:</th>
                <td width="39%">
                    <textarea class="form-control input-sm" rows="3" title="额外开支说明" name="extraExpenseExplain"
                              id="extraExpenseExplain"></textarea>
                </td>
            </tr>
            <tr>
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
<!-- 业务的js -->
<script src="avicit/assets/device/assetsdevicerepair/js/AssetsDeviceRepair.js" type="text/javascript"></script>
<script type="text/javascript">
    var assetsDeviceRepair;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsDeviceRepair.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsDeviceRepair.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsDeviceRepair.reLoad();
    };
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '维修单编号', name: 'procId', width: 150,formatter: formatValue}
            , {label: '创建时间', name: 'creationDate', width: 150, formatter: format}
            , {label: '申请人', name: 'applicantIdAlias', width: 150}
            , {label: '申请人部门', name: 'applicantDepartAlias', width: 150}
            , {label: '统一编号', name: 'unifiedId', width: 150,formatter: formatValue}
            , {label: '表单状态', name: 'formState', width: 150, hidden: true}
            , {label: '设备名称', name: 'deviceName', width: 150,formatter: formatValue}
            , {label: '设备类别', name: 'deviceCategory', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150, hidden: true}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '责任人', name: 'ownerIdAlias', width: 150}
            <sec:accesscontrollist hasPermission="3" domainObject="assetsDeviceRepair_table_ownerDept" permissionDes="责任人部门">
            , {label: '责任人部门', name: 'ownerDeptAlias', width: 150}
            </sec:accesscontrollist>
            , {label: '责任人联系方式', name: 'contact', width: 150, hidden: true}
            , {label: '安装地点', name: 'position', width: 150, hidden: true}
            , {label: '生产厂家', name: 'manufacturer', width: 150}
            , {label: '是否计算机', name: 'isPc', width: 150, hidden: true}
            , {label: '是否测试设备', name: 'isTestDevice', width: 150, hidden: true}
            , {label: '是否需要计量', name: 'isMetering', width: 150, hidden: true}
            , {label: '维修部门', name: 'repairDeptAlias', width: 150, hidden: true}
            , {label: '故障现象描述', name: 'failureDesc', width: 150, hidden: true}
            , {label: '故障维修记录', name: 'repairDesc', width: 150, hidden: true}
            , {label: '维修完成时间', name: 'repairFinishTime', width: 150, formatter: format, hidden: true}
            , {label: '结果确认', name: 'finishAck', width: 150, hidden: true, hidden: true}
            , {label: '维修质量', name: 'repairQuality', width: 150, hidden: true}
            , {label: '故障分析', name: 'failureAnalysisId', width: 150, hidden: true}
            , {label: '故障分析描述', name: 'failureAnalysisDesc', width: 150, hidden: true}
            , {label: '服务态度', name: 'serviceAttitude', width: 150, hidden: true}
            , {label: '维修进度', name: 'repairProgress', width: 150, hidden: true}
            , {label: '维修计划员', name: 'repairPlanStaffAlias', width: 150}
            , {label: '维修员', name: 'repairStaffAlias', width: 150}
            , {label: '计量计划员', name: 'meterPlanStaffAlias', width: 150, hidden: true}
            , {label: '是否存在额外开支', name: 'hasExtraExpense', width: 150, hidden: true}
            , {label: '额外开支说明', name: 'extraExpenseExplain', width: 150, hidden: true}
            <sec:accesscontrollist hasPermission="3" domainObject="assetsDeviceRepair_table_activityalias" permissionDes="流程当前步骤">
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="assetsDeviceRepair_table_businessstate" permissionDes="流程状态">
            , {label: '流程状态', name: 'businessstate_', width: 150}
            </sec:accesscontrollist>
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        searchNames.push("formState");
        searchTips.push("表单状态");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsDeviceRepair_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsDeviceRepair = new AssetsDeviceRepair('assetsDeviceRepairjqGrid', '${url}', 'searchDialog', 'form', 'assetsDeviceRepair_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsDeviceRepair_insert').bind('click', function () {
            assetsDeviceRepair.insert();
        });
        $('#assetsDeviceRepair_insert1').bind('click', function () {
            assetsDeviceRepair.insert1();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceRepair_modify').bind('click', function () {
            assetsDeviceRepair.modify();
        });
        //删除按钮绑定事件
        $('#assetsDeviceRepair_del').bind('click', function () {
            assetsDeviceRepair.del();
        });
        //查询按钮绑定事件
        $('#assetsDeviceRepair_searchPart').bind('click', function () {
            assetsDeviceRepair.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsDeviceRepair_searchAll').bind('click', function () {
            assetsDeviceRepair.openSearchForm(this, 800, 400);
        });
        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsDeviceRepair.initWorkFlow($(this).val());
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
        $('#repairDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'repairDept', textFiled: 'repairDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#repairPlanStaffAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'repairPlanStaff', textFiled: 'repairPlanStaffAlias'});
            this.blur();
            nullInput(e);
        });
        $('#repairStaffAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'repairStaff', textFiled: 'repairStaffAlias'});
            this.blur();
            nullInput(e);
        });
        $('#meterPlanStaffAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'meterPlanStaff', textFiled: 'meterPlanStaffAlias'});
            this.blur();
            nullInput(e);
        });

    });

</script>
</html>