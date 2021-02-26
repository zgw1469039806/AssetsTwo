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
    <!-- ControllerPath = "assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController/toAssetsStdtempapplyProcManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<style>
    tbody tr {
        text-align: center;
    }
</style>
<body class="easyui-layout">
<div id="panelnorth"
     data-options="region:'north',height:fixheight(1),onResize:function(a){$('#assetsStdtempapplyProc').setGridWidth(a);$('#assetsStdtempapplyProc').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
    <div id="toolbar_assetsStdtempapplyProc" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsStdtempapplyProc_button_add"
                                   permissionDes="添加">
                <a id="assetsStdtempapplyProc_insert" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i>
                    添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsStdtempapplyProc_button_edit"
                                   permissionDes="编辑">
                <a id="assetsStdtempapplyProc_modify" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="编辑"><i
                        class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsStdtempapplyProc_button_delete"
                                   permissionDes="删除">
                <a id="assetsStdtempapplyProc_del" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="删除"><i
                        class="fa fa-trash-o"></i> 删除</a>
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
                <input type="text" name="assetsStdtempapplyProc_keyWord" id="assetsStdtempapplyProc_keyWord"
                       style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsStdtempapplyProc_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsStdtempapplyProc_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button">高级查询 <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="assetsStdtempapplyProc"></table>
    <div id="assetsStdtempapplyProcPager"></div>
</div>
<div id="centerpanel" style="display: none"
     data-options="region:'center',split:true,onResize:function(a){$('#assetsSupplier').setGridWidth(a); $('#assetsSupplier').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
    <div id="toolbar_assetsSupplier" class="toolbar">
        <div class="toolbar-right">
            <div class="input-group form-tool-search" style="width:125px">
                <input type="text" name="assetsSupplier_keyWord" id="assetsSupplier_keyWord" style="width:125px;"
                       class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsSupplier_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsSupplier_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
                    <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="assetsSupplier"></table>
    <div id="assetsSupplierPager"></div>
</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
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
                <th width="10%">单据状态 :</th>
                <td width="15%">
                    <input title="单据状态 " class="form-control input-sm" type="text" name="formState" id="formState"/>
                </td>
                <th width="10%">设备名称 :</th>
                <td width="15%">
                    <input title="设备名称 " class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备规格 :</th>
                <td width="15%">
                    <input title="设备规格 " class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>
                <th width="10%">设备型号 :</th>
                <td width="15%">
                    <input title="设备型号 " class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
                <th width="10%">密级 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="密级 "
                                  isNull="true" lookupCode="SECRET_LEVEL"/>
                </td>
                <th width="10%">参考厂家 :</th>
                <td width="15%">
                    <input title="参考厂家 " class="form-control input-sm" type="text" name="referencePlant"
                           id="referencePlant"/>
                </td>
            </tr>
            <tr>
                <th width="10%">台（套）数 :</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="deviceNum" id="deviceNum"
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
                <th width="10%">单价(元) :</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice"
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
                <th width="10%">总金额（元） :</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalPrice" id="totalPrice"
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
                <th width="10%">设备类型 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceType" id="deviceType" title="设备类型 "
                                  isNull="true" lookupCode="DEVICE_TYPE"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备类别 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory"
                                  title="设备类别 " isNull="true" lookupCode="DEVICE_CATEGORY"/>
                </td>
                <th width="10%">是否计量 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title="是否计量 "
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否现场计量 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSceneMetering" id="isSceneMetering"
                                  title="是否现场计量 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否保养 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMaintain" id="isMaintain" title="是否保养 "
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否精度检查 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAccuracyCheck" id="isAccuracyCheck"
                                  title="是否精度检查 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否定检 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isRegularCheck" id="isRegularCheck"
                                  title="是否定检 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否点检 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpotCheck" id="isSpotCheck" title="是否点检 "
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否特种设备 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpecialDevice" id="isSpecialDevice"
                                  title="是否特种设备 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否精度指标 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPrecisionIndex" id="isPrecisionIndex"
                                  title="是否精度指标 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否需要安装 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall"
                                  title="是否需要安装 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">安装地点 :</th>
                <td width="15%">
                    <input title="安装地点 " class="form-control input-sm" type="text" name="installPosition"
                           id="installPosition"/>
                </td>
                <th width="10%">是否需要地基基础 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFoundation" id="isFoundation"
                                  title="是否需要地基基础 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否涉及安全生产 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSafetyProduction" id="isSafetyProduction"
                                  title="是否涉及安全生产 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">经费来源 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources"
                                  title="经费来源 " isNull="true" lookupCode="FINANCIAL_RESOURCES"/>
                </td>
                <th width="10%">所属项目:</th>
                <td width="15%">
                    <input title="所属项目" class="form-control input-sm" type="text" name="toProject" id="toProject"/>
                </td>
                <th width="10%">批复名称:</th>
                <td width="15%">
                    <input title="批复名称" class="form-control input-sm" type="text" name="approvalName"
                           id="approvalName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">主管总师:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="chiefEngineer" name="chiefEngineer">
                        <input class="form-control" placeholder="请选择用户" type="text" id="chiefEngineerAlias"
                               name="chiefEngineerAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">项目序号:</th>
                <td width="15%">
                    <input title="项目序号" class="form-control input-sm" type="text" name="projectNum" id="projectNum"/>
                </td>
                <th width="10%">项目主管:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="projectDirector" name="projectDirector">
                        <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias"
                               name="projectDirectorAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">需求紧急程度 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="demandUrgencyDegree" id="demandUrgencyDegree"
                                  title="需求紧急程度 " isNull="true" lookupCode="DEMAND_URGENCY_DEGREE"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否需要设备培训 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTrain" id="isTrain" title="是否需要设备培训 "
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否是计算机 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPc" id="isPc" title="是否是计算机 " isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">计划到货时间 (从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="planDeliveryTimeBegin"
                               id="planDeliveryTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">计划到货时间 (至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="planDeliveryTimeEnd"
                               id="planDeliveryTimeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">采购员 :</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="buyer" name="buyer">
                        <input class="form-control" placeholder="请选择用户" type="text" id="buyerAlias" name="buyerAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">采购计划员 :</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="planBuyer" name="planBuyer">
                        <input class="form-control" placeholder="请选择用户" type="text" id="planBuyerAlias"
                               name="planBuyerAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">是否具有无线功能 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWireless" id="isWireless" title="是否具有无线功能 "
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">设备购置类型 :</th>
                <td width="15%">
                    <input title="设备购置类型 " class="form-control input-sm" type="text" name="devicePurchaseType"
                           id="devicePurchaseType"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备购置原因 :</th>
                <td width="15%">
                    <input title="设备购置原因 " class="form-control input-sm" type="text" name="devicePurchaseCause"
                           id="devicePurchaseCause"/>
                </td>
                <th width="10%">技术指标 :</th>
                <td width="15%">
                    <input title="技术指标 " class="form-control input-sm" type="text" name="technicalIndex"
                           id="technicalIndex"/>
                </td>
                <th width="10%">技术指标 :</th>
                <td width="15%">
                    <input title="技术指标 " class="form-control input-sm" type="text" name="technicalIndex02"
                           id="technicalIndex02"/>
                </td>
                <th width="10%">指标先进性 :</th>
                <td width="15%">
                    <input title="指标先进性 " class="form-control input-sm" type="text" name="advancement"
                           id="advancement"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备可靠性 :</th>
                <td width="15%">
                    <input title="设备可靠性 " class="form-control input-sm" type="text" name="deviceReliability"
                           id="deviceReliability"/>
                </td>
                <th width="10%">是否属于即将产能淘汰设备 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWeedOut" id="isWeedOut"
                                  title="是否属于即将产能淘汰设备 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">已有设备为什么不能满足要求 :</th>
                <td width="15%">
                    <input title="已有设备为什么不能满足要求 " class="form-control input-sm" type="text" name="notMeetDemand"
                           id="notMeetDemand"/>
                </td>
                <th width="10%">设备利用率情况 :</th>
                <td width="15%">
                    <input title="设备利用率情况 " class="form-control input-sm" type="text" name="useRatio" id="useRatio"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备能耗情况 :</th>
                <td width="15%">
                    <input title="设备能耗情况 " class="form-control input-sm" type="text" name="energyConsumption"
                           id="energyConsumption"/>
                </td>
                <th width="10%">设备耗材经济性 :</th>
                <td width="15%">
                    <input title="设备耗材经济性 " class="form-control input-sm" type="text" name="consumableEconomics"
                           id="consumableEconomics"/>
                </td>
                <th width="10%">设备通用性 :</th>
                <td width="15%">
                    <input title="设备通用性 " class="form-control input-sm" type="text" name="universality"
                           id="universality"/>
                </td>
                <th width="10%">设备维保费用情况 :</th>
                <td width="15%">
                    <input title="设备维保费用情况 " class="form-control input-sm" type="text" name="maintainCost"
                           id="maintainCost"/>
                </td>
            </tr>
            <tr>
                <th width="10%">安全性 :</th>
                <td width="15%">
                    <input title="安全性 " class="form-control input-sm" type="text" name="security" id="security"/>
                </td>
                <th width="10%">安装设备楼层承重是否满足 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isBearingMeet" id="isBearingMeet"
                                  title="安装设备楼层承重是否满足 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">设备是否有室外机 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOutdoorUnit" id="isOutdoorUnit"
                                  title="设备是否有室外机 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">所安装位置是否允许安装室外机 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAllowOutdoorUnit" id="isAllowOutdoorUnit"
                                  title="所安装位置是否允许安装室外机 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备是否需要地基基础 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedFoundation" id="isNeedFoundation"
                                  title="设备是否需要地基基础 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">所安装位置是否具备设置地基条件 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFoundationCondition"
                                  id="isFoundationCondition" title="所安装位置是否具备设置地基条件 " isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">使用电压 :</th>
                <td width="15%">
                    <input title="使用电压 " class="form-control input-sm" type="text" name="serviceVoltage"
                           id="serviceVoltage"/>
                </td>
                <th width="10%">安装位置是否具备电压条件 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isVoltageCondition" id="isVoltageCondition"
                                  title="安装位置是否具备电压条件 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否对温湿度有要求 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isHumidityNeed" id="isHumidityNeed"
                                  title="是否对温湿度有要求 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">温湿度要求 :</th>
                <td width="15%">
                    <input title="温湿度要求 " class="form-control input-sm" type="text" name="humidityNeed"
                           id="humidityNeed"/>
                </td>
                <th width="10%">是否对洁净度有要求 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isCleanlinessNeed" id="isCleanlinessNeed"
                                  title="是否对洁净度有要求 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">洁净度要求 :</th>
                <td width="15%">
                    <input title="洁净度要求 " class="form-control input-sm" type="text" name="cleanlinessNeed"
                           id="cleanlinessNeed"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否有用水要求 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWaterNeed" id="isWaterNeed" title="是否有用水要求 "
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">用水要求 :</th>
                <td width="15%">
                    <input title="用水要求 " class="form-control input-sm" type="text" name="waterNeed" id="waterNeed"/>
                </td>
                <th width="10%">是否有用气要求 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isGasNeed" id="isGasNeed" title="是否有用气要求 "
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">用气要求 :</th>
                <td width="15%">
                    <input title="用气要求 " class="form-control input-sm" type="text" name="gasNeed" id="gasNeed"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否是否有气体、污水排放 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isLet" id="isLet" title="是否是否有气体、污水排放 "
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">气体、污水排放要求 :</th>
                <td width="15%">
                    <input title="气体、污水排放要求 " class="form-control input-sm" type="text" name="letNeed" id="letNeed"/>
                </td>
                <th width="10%">是否有其他特殊要求 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOtherNeed" id="isOtherNeed"
                                  title="是否有其他特殊要求 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">其他特殊要求 :</th>
                <td width="15%">
                    <input title="其他特殊要求 " class="form-control input-sm" type="text" name="otherNeed" id="otherNeed"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否有噪音 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNoise" id="isNoise" title="是否有噪音 "
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">噪音是否影响安装地工作办公 :</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNoiseInfluence" id="isNoiseInfluence"
                                  title="噪音是否影响安装地工作办公 " isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">以上需求条件在拟安装地点是否都已具备 :</th>
                <td width="15%">
                    <input title="以上需求条件在拟安装地点是否都已具备 " class="form-control input-sm" type="text" name="aboveNeedHave"
                           id="aboveNeedHave"/>
                </td>
                <th width="10%">审批总师 :</th>
                <td width="15%">
                    <input title="审批总师 " class="form-control input-sm" type="text" name="examineApproveEngineer"
                           id="examineApproveEngineer"/>
                </td>
            </tr>
            <tr>
                <th width="10%">专业审核员 :</th>
                <td width="15%">
                    <input title="专业审核员 " class="form-control input-sm" type="text" name="professionalAuditor"
                           id="professionalAuditor"/>
                </td>
                <th width="10%">主管所领导 :</th>
                <td width="15%">
                    <input title="主管所领导 " class="form-control input-sm" type="text" name="competentLeader"
                           id="competentLeader"/>
                </td>
                <th width="10%">部门领导结论 :</th>
                <td width="15%">
                    <input title="部门领导结论 " class="form-control input-sm" type="text" name="deptHeadConclusion"
                           id="deptHeadConclusion"/>
                </td>
                <th width="10%">部门领导意见 :</th>
                <td width="15%">
                    <input title="部门领导意见 " class="form-control input-sm" type="text" name="deptHeadOpinion"
                           id="deptHeadOpinion"/>
                </td>
            </tr>
            <tr>
                <th width="10%">专业审核员意见 :</th>
                <td width="15%">
                    <input title="专业审核员意见 " class="form-control input-sm" type="text" name="professionalAuditorOpinion"
                           id="professionalAuditorOpinion"/>
                </td>
                <th width="10%">总师结论 :</th>
                <td width="15%">
                    <input title="总师结论 " class="form-control input-sm" type="text" name="chiefEngineerConclusion"
                           id="chiefEngineerConclusion"/>
                </td>
                <th width="10%">总师意见 :</th>
                <td width="15%">
                    <input title="总师意见 " class="form-control input-sm" type="text" name="chiefEngineerOpinion"
                           id="chiefEngineerOpinion"/>
                </td>
                <th width="10%">主管所领导结论 :</th>
                <td width="15%">
                    <input title="主管所领导结论 " class="form-control input-sm" type="text" name="competentLeaderConclusion"
                           id="competentLeaderConclusion"/>
                </td>
            </tr>
            <tr>
                <th width="10%">主管所领导意见 :</th>
                <td width="15%">
                    <input title="主管所领导意见 " class="form-control input-sm" type="text" name="competentLeaderOpinion"
                           id="competentLeaderOpinion"/>
                </td>
                <th width="10%">简易/大型设备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="largeDeviceType" id="largeDeviceType"
                                  title="简易/大型设备" isNull="true" lookupCode="simple_large_scale"/>
                </td>
                <th width="10%">研究所/公司:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="instituteOrCompany" id="instituteOrCompany"
                                  title="研究所/公司" isNull="true" lookupCode="LARGE_DEVICE_TYPE"/>
                </td>
                <th width="10%">申请人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPersion" name="createdByPersion">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersionAlias"
                               name="createdByPersionAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
    </form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
    <form id="formSub">
        <table class="form_commonTable">
            <tr>
                <th width="10%">供应商名称:</th>
                <td width="15%">
                    <input title="供应商名称" class="form-control input-sm" type="text" name="name" id="name"/>
                </td>
                <th width="10%">供应商地址:</th>
                <td width="15%">
                    <input title="供应商地址" class="form-control input-sm" type="text" name="address" id="address"/>
                </td>
                <th width="10%">联系人:</th>
                <td width="15%">
                    <input title="联系人" class="form-control input-sm" type="text" name="contact" id="contact"/>
                </td>
                <th width="10%">联系电话:</th>
                <td width="15%">
                    <input title="联系电话" class="form-control input-sm" type="text" name="contactNumber"
                           id="contactNumber"/>
                </td>
            </tr>
            <tr>
                <th width="10%">经验范围:</th>
                <td width="15%">
                    <input title="经验范围" class="form-control input-sm" type="text" name="businessScope"
                           id="businessScope"/>
                </td>
                <th width="10%">供应商状态：0:正常状态 2:停用:</th>
                <td width="15%">
                    <input title="供应商状态：0:正常状态 2:停用" class="form-control input-sm" type="text" name="status"
                           id="status"/>
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
<script src="avicit/assets/device/assetsstdtempapplyproc/js/AssetsStdtempapplyProc.js" type="text/javascript"></script>
<script src="avicit/assets/device/assetsstdtempapplyproc/js/AssetsSupplier.js" type="text/javascript"></script>
<script type="text/javascript">
    var assetsStdtempapplyProc;
    var assetsSupplier;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsStdtempapplyProc.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsStdtempapplyProc.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsStdtempapplyProc.reLoad();
    };

    $(document).ready(function () {
        var searchMainNames = new Array();
        var searchMainTips = new Array();
        searchMainNames.push("createdByTel");
        searchMainTips.push("申请人电话");
        searchMainNames.push("formState");
        searchMainTips.push("单据状态 ");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#assetsStdtempapplyProc_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#assetsStdtempapplyProc_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);
        var searchSubNames = new Array();
        var searchSubTips = new Array();
        searchSubNames.push("name");
        searchSubTips.push("供应商名称");
        searchSubNames.push("address");
        searchSubTips.push("供应商地址");
        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
        $('#assetsSupplier_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        $('#assetsSupplier_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);
        var assetsStdtempapplyProcGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '序号', name: 'attribute18', width: 150}
            , {label: '申购单号', name: 'stdId', width: 150, formatter: formatValue}
            , {label: '设备名称 ', name: 'deviceName', width: 150}
            , {label: '设备类型 ', name: 'deviceType', width: 150}
            , {label: '申请人 ', name: 'createdBy', width: 150}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '数量 ', name: 'deviceNum', width: 150}
            , {label: '预算 ', name: 'totalPrice', width: 150}
            , {label: '申请日期 ', name: 'creationDate', width: 150, formatter: format}
            , {label: '要求到货时间 ', name: 'planDeliveryTime', width: 150, formatter: format}
            , {label: '申请人电话', name: 'createdByTel', width: 150}
            , {label: '单据状态 ', name: 'businessstate_', width: 150}

            <%--, {label: '设备规格 ', name: 'deviceSpec', width: 150}--%>
            <%--, {label: '设备型号 ', name: 'deviceModel', width: 150}--%>
            <%--, {label: '密级 ', name: 'secretLevel', width: 150}--%>
            <%--, {label: '参考厂家 ', name: 'referencePlant', width: 150}--%>

            <%--, {label: '单价(元) ', name: 'unitPrice', width: 150}--%>


            <%--, {label: '设备类别 ', name: 'deviceCategory', width: 150}--%>
            <%--, {label: '是否计量 ', name: 'isMetering', width: 150}--%>
            <%--, {label: '是否现场计量 ', name: 'isSceneMetering', width: 150}--%>
            <%--, {label: '是否保养 ', name: 'isMaintain', width: 150}--%>
            <%--, {label: '是否精度检查 ', name: 'isAccuracyCheck', width: 150}--%>
            <%--, {label: '是否定检 ', name: 'isRegularCheck', width: 150}--%>
            <%--, {label: '是否点检 ', name: 'isSpotCheck', width: 150}--%>
            <%--, {label: '是否特种设备 ', name: 'isSpecialDevice', width: 150}--%>
            <%--, {label: '是否精度指标 ', name: 'isPrecisionIndex', width: 150}--%>
            <%--, {label: '是否需要安装 ', name: 'isNeedInstall', width: 150}--%>
            <%--, {label: '安装地点 ', name: 'installPosition', width: 150}--%>
            <%--, {label: '是否需要地基基础 ', name: 'isFoundation', width: 150}--%>
            <%--, {label: '是否涉及安全生产 ', name: 'isSafetyProduction', width: 150}--%>
            <%--, {label: '经费来源 ', name: 'financialResources', width: 150}--%>
            <%--, {label: '所属项目', name: 'toProject', width: 150}--%>
            <%--, {label: '批复名称', name: 'approvalName', width: 150}--%>
            <%--, {label: '主管总师', name: 'chiefEngineerAlias', width: 150}--%>
            <%--, {label: '项目序号', name: 'projectNum', width: 150}--%>
            <%--, {label: '项目主管', name: 'projectDirectorAlias', width: 150}--%>
            <%--, {label: '需求紧急程度 ', name: 'demandUrgencyDegree', width: 150}--%>
            <%--, {label: '是否需要设备培训 ', name: 'isTrain', width: 150}--%>
            <%--, {label: '是否是计算机 ', name: 'isPc', width: 150}--%>

            <%--, {label: '采购员 ', name: 'buyerAlias', width: 150}--%>
            <%--, {label: '采购计划员 ', name: 'planBuyerAlias', width: 150}--%>
            <%--, {label: '是否具有无线功能 ', name: 'isWireless', width: 150}--%>
            <%--, {label: '设备购置类型 ', name: 'devicePurchaseType', width: 150}--%>
            <%--, {label: '设备购置原因 ', name: 'devicePurchaseCause', width: 150}--%>
            <%--, {label: '技术指标 ', name: 'technicalIndex', width: 150}--%>
            <%--, {label: '技术指标 ', name: 'technicalIndex02', width: 150}--%>
            <%--, {label: '指标先进性 ', name: 'advancement', width: 150}--%>
            <%--, {label: '设备可靠性 ', name: 'deviceReliability', width: 150}--%>
            <%--, {label: '是否属于即将产能淘汰设备 ', name: 'isWeedOut', width: 150}--%>
            <%--, {label: '已有设备为什么不能满足要求 ', name: 'notMeetDemand', width: 150}--%>
            <%--, {label: '设备利用率情况 ', name: 'useRatio', width: 150}--%>
            <%--, {label: '设备能耗情况 ', name: 'energyConsumption', width: 150}--%>
            <%--, {label: '设备耗材经济性 ', name: 'consumableEconomics', width: 150}--%>
            <%--, {label: '设备通用性 ', name: 'universality', width: 150}--%>
            <%--, {label: '设备维保费用情况 ', name: 'maintainCost', width: 150}--%>
            <%--, {label: '安全性 ', name: 'security', width: 150}--%>
            <%--, {label: '安装设备楼层承重是否满足 ', name: 'isBearingMeet', width: 150}--%>
            <%--, {label: '设备是否有室外机 ', name: 'isOutdoorUnit', width: 150}--%>
            <%--, {label: '所安装位置是否允许安装室外机 ', name: 'isAllowOutdoorUnit', width: 150}--%>
            <%--, {label: '设备是否需要地基基础 ', name: 'isNeedFoundation', width: 150}--%>
            <%--, {label: '所安装位置是否具备设置地基条件 ', name: 'isFoundationCondition', width: 150}--%>
            <%--, {label: '使用电压 ', name: 'serviceVoltage', width: 150}--%>
            <%--<sec:accesscontrollist hasPermission="3" domainObject="assetsStdtempapplyProc_table_isVoltageCondition" permissionDes="安装位置是否具备电压条件 ">--%>
            <%--, {label: '安装位置是否具备电压条件 ', name: 'isVoltageCondition', width: 150}--%>
            <%--</sec:accesscontrollist>--%>
            <%--, {label: '是否对温湿度有要求 ', name: 'isHumidityNeed', width: 150}--%>
            <%--, {label: '温湿度要求 ', name: 'humidityNeed', width: 150}--%>
            <%--, {label: '是否对洁净度有要求 ', name: 'isCleanlinessNeed', width: 150}--%>
            <%--, {label: '洁净度要求 ', name: 'cleanlinessNeed', width: 150}--%>
            <%--, {label: '是否有用水要求 ', name: 'isWaterNeed', width: 150}--%>
            <%--, {label: '用水要求 ', name: 'waterNeed', width: 150}--%>
            <%--, {label: '是否有用气要求 ', name: 'isGasNeed', width: 150}--%>
            <%--, {label: '用气要求 ', name: 'gasNeed', width: 150}--%>
            <%--, {label: '是否是否有气体、污水排放 ', name: 'isLet', width: 150}--%>
            <%--, {label: '气体、污水排放要求 ', name: 'letNeed', width: 150}--%>
            <%--, {label: '是否有其他特殊要求 ', name: 'isOtherNeed', width: 150}--%>
            <%--, {label: '其他特殊要求 ', name: 'otherNeed', width: 150}--%>
            <%--, {label: '是否有噪音 ', name: 'isNoise', width: 150}--%>
            <%--, {label: '噪音是否影响安装地工作办公 ', name: 'isNoiseInfluence', width: 150}--%>
            <%--, {label: '以上需求条件在拟安装地点是否都已具备 ', name: 'aboveNeedHave', width: 150}--%>
            <%--, {label: '审批总师 ', name: 'examineApproveEngineer', width: 150}--%>
            <%--, {label: '专业审核员 ', name: 'professionalAuditor', width: 150}--%>
            <%--, {label: '主管所领导 ', name: 'competentLeader', width: 150}--%>
            <%--, {label: '部门领导结论 ', name: 'deptHeadConclusion', width: 150}--%>
            <%--, {label: '部门领导意见 ', name: 'deptHeadOpinion', width: 150}--%>
            <%--, {label: '专业审核员意见 ', name: 'professionalAuditorOpinion', width: 150}--%>
            <%--, {label: '总师结论 ', name: 'chiefEngineerConclusion', width: 150}--%>
            <%--, {label: '总师意见 ', name: 'chiefEngineerOpinion', width: 150}--%>
            <%--, {label: '主管所领导结论 ', name: 'competentLeaderConclusion', width: 150}--%>
            <%--, {label: '主管所领导意见 ', name: 'competentLeaderOpinion', width: 150}--%>
            <%--, {label: '简易/大型设备', name: 'largeDeviceType', width: 150}--%>
            <%--, {label: '研究所/公司', name: 'instituteOrCompany', width: 150}--%>
            <%--, {label: '申请人', name: 'createdByPersionAlias', width: 150}--%>
            <%--, {label: '流程当前步骤', name: 'activityalias_', width: 150}--%>
            <%--, {label: '流程状态', name: 'businessstate_', width: 150}--%>
        ];
        var assetsSupplierGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '供应商名称', name: 'name', width: 150}
            , {label: '供应商地址', name: 'address', width: 150}
            , {label: '联系人', name: 'contact', width: 150}
            , {label: '联系电话', name: 'contactNumber', width: 150}
            , {label: '经验范围', name: 'businessScope', width: 150}
            , {label: '供应商状态：0:正常状态 2:停用', name: 'status', width: 150}
        ];

        assetsStdtempapplyProc = new AssetsStdtempapplyProc('assetsStdtempapplyProc', '${url}', 'form', assetsStdtempapplyProcGridColModel, 'searchDialog',
            function (pid) {
                assetsSupplier = new AssetsSupplier('assetsSupplier', '${surl}', "formSub", assetsSupplierGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsSupplier_keyWord");
            },
            function (pid) {
                assetsSupplier.reLoad(pid);
            },
            searchMainNames,
            "assetsStdtempapplyProc_keyWord");
        //主表操作
        //添加按钮绑定事件
        $('#assetsStdtempapplyProc_insert').bind('click', function () {
            assetsStdtempapplyProc.insert();
        });
        //编辑按钮绑定事件
        $('#assetsStdtempapplyProc_modify').bind('click', function () {
            assetsStdtempapplyProc.modify();
        });
        //删除按钮绑定事件
        $('#assetsStdtempapplyProc_del').bind('click', function () {
            assetsStdtempapplyProc.del();
        });
        //打开高级查询框
        $('#assetsStdtempapplyProc_searchAll').bind('click', function () {
            assetsStdtempapplyProc.openSearchForm(this, $('#assetsStdtempapplyProc'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsStdtempapplyProc_searchPart').bind('click', function () {
            assetsStdtempapplyProc.searchByKeyWord();
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsStdtempapplyProc.initWorkFlow($(this).val());
        });
        //子表操作
        //打开高级查询
        $('#assetsSupplier_searchAll').bind('click', function () {
            assetsSupplier.openSearchForm(this, $('#assetsSupplier'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsSupplier_searchPart').bind('click', function () {
            assetsSupplier.searchByKeyWord();
        });

        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#chiefEngineerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'chiefEngineer', textFiled: 'chiefEngineerAlias'});
            this.blur();
            nullInput(e);
        });
        $('#projectDirectorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'projectDirector', textFiled: 'projectDirectorAlias'});
            this.blur();
            nullInput(e);
        });
        $('#buyerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'buyer', textFiled: 'buyerAlias'});
            this.blur();
            nullInput(e);
        });
        $('#planBuyerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'planBuyer', textFiled: 'planBuyerAlias'});
            this.blur();
            nullInput(e);
        });
        $('#createdByPersionAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'createdByPersion', textFiled: 'createdByPersionAlias'});
            this.blur();
            nullInput(e);
        });


    });

</script>
</html>