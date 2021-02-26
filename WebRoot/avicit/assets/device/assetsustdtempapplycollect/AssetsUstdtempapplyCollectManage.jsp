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
    <!-- ControllerPath = "assets/device/assetsustdtempapplycollect/assetsUstdtempapplyCollectController/toAssetsUstdtempapplyCollectManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempapplyCollect_button_add"
                               permissionDes="添加">
            <a id="assetsUstdtempapplyCollect_insert" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempapplyCollect_button_edit"
                               permissionDes="编辑">
            <a id="assetsUstdtempapplyCollect_modify" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i>
                编辑</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempapplyCollect_button_delete"
                               permissionDes="删除">
            <a id="assetsUstdtempapplyCollect_del" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i>
                删除</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsUstdtempapplyCollect_keyWord" id="assetsUstdtempapplyCollect_keyWord"
                   style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsUstdtempapplyCollect_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsUstdtempapplyCollect_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
               role="button" title="高级查询">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsUstdtempapplyCollectjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th width="10%">申购单号:</th>
                <td width="15%">
                    <input title="申购单号" class="form-control input-sm" type="text" name="stdId" id="stdId"/>
                </td>
                <th width="10%">申请人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               name="createdByDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">申请人电话:</th>
                <td width="15%">
                    <input title="申请人电话" class="form-control input-sm" type="text" name="createdByTel"
                           id="createdByTel"/>
                </td>
                <th width="10%">单据状态:</th>
                <td width="15%">
                    <input title="单据状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
                <th width="10%">设备类别:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory"
                                  title="设备类别" isNull="true" lookupCode="DEVICE_CATEGORY"/>
                </td>
                <th width="10%">承制单位:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="manufactureUnit" name="manufactureUnit">
                        <input class="form-control" placeholder="请选择部门" type="text" id="manufactureUnitAlias"
                               name="manufactureUnitAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">课题代号:</th>
                <td width="15%">
                    <input title="课题代号" class="form-control input-sm" type="text" name="subjectCode" id="subjectCode"/>
                </td>
            </tr>
            <tr>
                <th width="10%">主管机关:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="competentAuthority" name="competentAuthority">
                        <input class="form-control" placeholder="请选择部门" type="text" id="competentAuthorityAlias"
                               name="competentAuthorityAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">型号主管:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="modelDirector" name="modelDirector">
                        <input class="form-control" placeholder="请选择用户" type="text" id="modelDirectorAlias"
                               name="modelDirectorAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">主管所领导:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="competentLeader" name="competentLeader">
                        <input class="form-control" placeholder="请选择用户" type="text" id="competentLeaderAlias"
                               name="competentLeaderAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">申购理由及用途:</th>
                <td width="15%">
                    <input title="申购理由及用途" class="form-control input-sm" type="text" name="applyReasonPurpose"
                           id="applyReasonPurpose"/>
                </td>
            </tr>
            <tr>
                <th width="10%">原有设备的情况:</th>
                <td width="15%">
                    <input title="原有设备的情况" class="form-control input-sm" type="text" name="orignEquipSituation"
                           id="orignEquipSituation"/>
                </td>
                <th width="10%">使用效率情况:</th>
                <td width="15%">
                    <input title="使用效率情况" class="form-control input-sm" type="text" name="efficiencySituation"
                           id="efficiencySituation"/>
                </td>
                <th width="10%">研制内容:</th>
                <td width="15%">
                    <input title="研制内容" class="form-control input-sm" type="text" name="developmentContent"
                           id="developmentContent"/>
                </td>
                <th width="10%">技术指标:</th>
                <td width="15%">
                    <input title="技术指标" class="form-control input-sm" type="text" name="technicalIndex"
                           id="technicalIndex"/>
                </td>
            </tr>
            <tr>
                <th width="10%">研制周期:</th>
                <td width="15%">
                    <input title="研制周期" class="form-control input-sm" type="text" name="developmentCycle"
                           id="developmentCycle"/>
                </td>
                <th width="10%">是否需要安装:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall"
                                  title="是否需要安装" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">安装地点ID:</th>
                <td width="15%">
                    <input title="安装地点ID" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
                <th width="10%">使用电压:</th>
                <td width="15%">
                    <input title="使用电压" class="form-control input-sm" type="text" name="serviceVoltage"
                           id="serviceVoltage"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否对温湿度有要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isHumidityNeed" id="isHumidityNeed"
                                  title="是否对温湿度有要求" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">温湿度要求:</th>
                <td width="15%">
                    <input title="温湿度要求" class="form-control input-sm" type="text" name="humidityNeed"
                           id="humidityNeed"/>
                </td>
                <th width="10%">是否有用水要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWaterNeed" id="isWaterNeed" title="是否有用水要求"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">用水要求:</th>
                <td width="15%">
                    <input title="用水要求" class="form-control input-sm" type="text" name="waterNeed" id="waterNeed"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否有用气要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isGasNeed" id="isGasNeed" title="是否有用气要求"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">用气要求:</th>
                <td width="15%">
                    <input title="用气要求" class="form-control input-sm" type="text" name="gasNeed" id="gasNeed"/>
                </td>
                <th width="10%">是否有气体排放:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isLet" id="isLet" title="是否有气体排放"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">气体排放要求:</th>
                <td width="15%">
                    <input title="气体排放要求" class="form-control input-sm" type="text" name="letNeed" id="letNeed"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否有其他特殊要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOtherNeed" id="isOtherNeed"
                                  title="是否有其他特殊要求" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">其他特殊要求:</th>
                <td width="15%">
                    <input title="其他特殊要求" class="form-control input-sm" type="text" name="otherNeed" id="otherNeed"/>
                </td>
                <th width="10%">以上需求条件在拟安装地点是否都已具备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAboveConditions" id="isAboveConditions"
                                  title="以上需求条件在拟安装地点是否都已具备" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否计量:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title="是否计量"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">计量要求:</th>
                <td width="15%">
                    <input title="计量要求" class="form-control input-sm" type="text" name="meteringRequirement"
                           id="meteringRequirement"/>
                </td>
                <th width="10%">经费概算:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="financialEstimate" id="financialEstimate"
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
                <th width="10%">经费来源:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources"
                                  title="经费来源" isNull="true" lookupCode="FINANCIAL_RESOURCES"/>
                </td>
                <th width="10%">所属项目:</th>
                <td width="15%">
                    <input title="所属项目" class="form-control input-sm" type="text" name="belongProject"
                           id="belongProject"/>
                </td>
            </tr>
            <tr>
                <th width="10%">项目序号:</th>
                <td width="15%">
                    <input title="项目序号" class="form-control input-sm" type="text" name="projectNo" id="projectNo"/>
                </td>
                <th width="10%">批复名称:</th>
                <td width="15%">
                    <input title="批复名称" class="form-control input-sm" type="text" name="replyName" id="replyName"/>
                </td>
                <th width="10%">立项单号:</th>
                <td width="15%">
                    <input title="立项单号" class="form-control input-sm" type="text" name="approvalFormNumber"
                           id="approvalFormNumber"/>
                </td>
                <th width="10%">是否测试设备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTestDevice" id="isTestDevice" title="是否测试设备"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">主管设备所领导:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="competentDeviceLeader" name="competentDeviceLeader">
                        <input class="form-control" placeholder="请选择用户" type="text" id="competentDeviceLeaderAlias"
                               name="competentDeviceLeaderAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">主表id:</th>
                <td width="15%">
                    <input title="主表id" class="form-control input-sm" type="text" name="headerId" id="headerId"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/device/assetsustdtempapplycollect/js/AssetsUstdtempapplyCollect.js"
        type="text/javascript"></script>
<script type="text/javascript">
    var assetsUstdtempapplyCollect;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsUstdtempapplyCollect.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsUstdtempapplyCollect.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '申购单号', name: 'stdId', width: 150, formatter: formatValue}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '申请人电话', name: 'createdByTel', width: 150}
            , {label: '单据状态', name: 'formState', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备类别', name: 'deviceCategory', width: 150}
            , {label: '承制单位', name: 'manufactureUnitAlias', width: 150}
            , {label: '课题代号', name: 'subjectCode', width: 150}
            , {label: '主管机关', name: 'competentAuthorityAlias', width: 150}
            , {label: '型号主管', name: 'modelDirectorAlias', width: 150}
            , {label: '主管所领导', name: 'competentLeaderAlias', width: 150}
            , {label: '申购理由及用途', name: 'applyReasonPurpose', width: 150}
            , {label: '原有设备的情况', name: 'orignEquipSituation', width: 150}
            , {label: '使用效率情况', name: 'efficiencySituation', width: 150}
            , {label: '研制内容', name: 'developmentContent', width: 150}
            , {label: '技术指标', name: 'technicalIndex', width: 150}
            , {label: '研制周期', name: 'developmentCycle', width: 150}
            , {label: '是否需要安装', name: 'isNeedInstall', width: 150}
            , {label: '安装地点ID', name: 'positionId', width: 150}
            , {label: '使用电压', name: 'serviceVoltage', width: 150}
            , {label: '是否对温湿度有要求', name: 'isHumidityNeed', width: 150}
            , {label: '温湿度要求', name: 'humidityNeed', width: 150}
            , {label: '是否有用水要求', name: 'isWaterNeed', width: 150}
            , {label: '用水要求', name: 'waterNeed', width: 150}
            , {label: '是否有用气要求', name: 'isGasNeed', width: 150}
            , {label: '用气要求', name: 'gasNeed', width: 150}
            , {label: '是否有气体排放', name: 'isLet', width: 150}
            , {label: '气体排放要求', name: 'letNeed', width: 150}
            , {label: '是否有其他特殊要求', name: 'isOtherNeed', width: 150}
            , {label: '其他特殊要求', name: 'otherNeed', width: 150}
            , {label: '以上需求条件在拟安装地点是否都已具备', name: 'isAboveConditions', width: 150}
            , {label: '是否计量', name: 'isMetering', width: 150}
            , {label: '计量要求', name: 'meteringRequirement', width: 150}
            , {label: '经费概算', name: 'financialEstimate', width: 150}
            , {label: '经费来源', name: 'financialResources', width: 150}
            , {label: '所属项目', name: 'belongProject', width: 150}
            , {label: '项目序号', name: 'projectNo', width: 150}
            , {label: '批复名称', name: 'replyName', width: 150}
            , {label: '立项单号', name: 'approvalFormNumber', width: 150}
            , {label: '是否测试设备', name: 'isTestDevice', width: 150}
            , {label: '主管设备所领导', name: 'competentDeviceLeaderAlias', width: 150}
            , {label: '主表id', name: 'headerId', width: 150}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("stdId");
        searchTips.push("申购单号");
        searchNames.push("createdByTel");
        searchTips.push("申请人电话");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsUstdtempapplyCollect_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsUstdtempapplyCollect = new AssetsUstdtempapplyCollect('assetsUstdtempapplyCollectjqGrid', '${url}', 'searchDialog', 'form', 'assetsUstdtempapplyCollect_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsUstdtempapplyCollect_insert').bind('click', function () {
            assetsUstdtempapplyCollect.insert();
        });
        //编辑按钮绑定事件
        $('#assetsUstdtempapplyCollect_modify').bind('click', function () {
            assetsUstdtempapplyCollect.modify();
        });
        //删除按钮绑定事件
        $('#assetsUstdtempapplyCollect_del').bind('click', function () {
            assetsUstdtempapplyCollect.del();
        });
        //查询按钮绑定事件
        $('#assetsUstdtempapplyCollect_searchPart').bind('click', function () {
            assetsUstdtempapplyCollect.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsUstdtempapplyCollect_searchAll').bind('click', function () {
            assetsUstdtempapplyCollect.openSearchForm(this);
        });
        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#manufactureUnitAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'manufactureUnit', textFiled: 'manufactureUnitAlias'});
            this.blur();
            nullInput(e);
        });
        $('#competentAuthorityAlias').on('focus', function (e) {
            new H5CommonSelect({
                type: 'deptSelect',
                idFiled: 'competentAuthority',
                textFiled: 'competentAuthorityAlias'
            });
            this.blur();
            nullInput(e);
        });
        $('#modelDirectorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'modelDirector', textFiled: 'modelDirectorAlias'});
            this.blur();
            nullInput(e);
        });
        $('#competentLeaderAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'competentLeader', textFiled: 'competentLeaderAlias'});
            this.blur();
            nullInput(e);
        });
        $('#competentDeviceLeaderAlias').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'competentDeviceLeader',
                textFiled: 'competentDeviceLeaderAlias'
            });
            this.blur();
            nullInput(e);
        });

    });

</script>
</html>