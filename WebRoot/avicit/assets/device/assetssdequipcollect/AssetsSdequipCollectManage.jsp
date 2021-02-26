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
    <!-- ControllerPath = "assets/device/assetssdequipcollect/assetsSdequipCollectController/toAssetsSdequipCollectManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',onResize:function(a){$('#assetsSdequipCollect').setGridWidth(a);$(window).trigger('resize');}">
    <div id="toolbar_assetsSdequipCollect" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsSdequipCollect_button_add"
                                   permissionDes="主表添加">
                <a id="assetsSdequipCollect_insert" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i>
                    添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsSdequipCollect_button_edit"
                                   permissionDes="主表编辑">
                <a id="assetsSdequipCollect_modify" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="编辑"><i
                        class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsSdequipCollect_button_delete"
                                   permissionDes="主表删除">
                <a id="assetsSdequipCollect_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
            </sec:accesscontrollist>
        </div>
        <div class="toolbar-right">
            <div class="input-group form-tool-search" style="width:125px">
                <input type="text" name="assetsSdequipCollect_keyWord" id="assetsSdequipCollect_keyWord"
                       style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsSdequipCollect_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsSdequipCollect_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button" title="高级查询">高级查询 <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="assetsSdequipCollect"></table>
    <div id="assetsSdequipCollectPager"></div>
</div>
<div data-options="region:'east',split:true,width:fixwidth(.5),onResize:function(a){$('#assetsSupplier').setGridWidth(a);$(window).trigger('resize');}">
    <div id="toolbar_assetsSupplier" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsSupplier_button_add"
                                   permissionDes="子表添加">
                <a id="assetsSupplier_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsSupplier_button_edit"
                                   permissionDes="子表编辑">
                <a id="assetsSupplier_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsSupplier_button_delete"
                                   permissionDes="子表删除">
                <a id="assetsSupplier_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
            </sec:accesscontrollist>
        </div>
        <div class="toolbar-right">
            <div class="input-group form-tool-search" style="width:125px">
                <input type="text" name="assetsSupplier_keyWord" id="assetsSupplier_keyWord" style="width:125px;"
                       class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsSupplier_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsSupplier_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button"
                   title="高级查询">高级查询 <span class="caret"></span></a>
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
        <table class="form_commonTable">
            <tr>
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
                <th width="10%">设备规格:</th>
                <td width="15%">
                    <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>
                <th width="10%">设备型号:</th>
                <td width="15%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
                <th width="10%">密级:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="密级"
                                  isNull="true" lookupCode="SECRET_LEVEL"/>
                </td>
            </tr>
            <tr>
                <th width="10%">参考厂家:</th>
                <td width="15%">
                    <input title="参考厂家" class="form-control input-sm" type="text" name="referencePlant"
                           id="referencePlant"/>
                </td>
                <th width="10%">台（套）数:</th>
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
                <th width="10%">单价(元):</th>
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
                <th width="10%">总金额（元）:</th>
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
            </tr>
            <tr>
                <th width="10%">设备类型:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceType" id="deviceType" title="设备类型"
                                  isNull="true" lookupCode="DEVICE_TYPE"/>
                </td>
                <th width="10%">设备类别:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory"
                                  title="设备类别" isNull="true" lookupCode="DEVICE_CATEGORY"/>
                </td>
                <th width="10%">是否计量:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title="是否计量"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否现场计量:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSceneMetering" id="isSceneMetering"
                                  title="是否现场计量" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否保养:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMaintain" id="isMaintain" title="是否保养"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否精度检查:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAccuracyCheck" id="isAccuracyCheck"
                                  title="是否精度检查" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否定检:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isRegularCheck" id="isRegularCheck"
                                  title="是否定检" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否点检:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpotCheck" id="isSpotCheck" title="是否点检"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否特种设备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpecialDevice" id="isSpecialDevice"
                                  title="是否特种设备" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否精度指标:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPrecisionIndex" id="isPrecisionIndex"
                                  title="是否精度指标" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否需要安装:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall"
                                  title="是否需要安装" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">安装地点:</th>
                <td width="15%">
                    <input title="安装地点" class="form-control input-sm" type="text" name="installPosition"
                           id="installPosition"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否需要地基基础:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFoundation" id="isFoundation"
                                  title="是否需要地基基础" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否涉及安全生产:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSafetyProduction" id="isSafetyProduction"
                                  title="是否涉及安全生产" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">经费来源:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources"
                                  title="经费来源" isNull="true" lookupCode="FINANCIAL_RESOURCES"/>
                </td>
                <th width="10%">所属项目:</th>
                <td width="15%">
                    <input title="所属项目" class="form-control input-sm" type="text" name="toProject" id="toProject"/>
                </td>
            </tr>
            <tr>
                <th width="10%">批复名称:</th>
                <td width="15%">
                    <input title="批复名称" class="form-control input-sm" type="text" name="approvalName"
                           id="approvalName"/>
                </td>
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
            </tr>
            <tr>
                <th width="10%">需求紧急程度:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="demandUrgencyDegree" id="demandUrgencyDegree"
                                  title="需求紧急程度" isNull="true" lookupCode="DEMAND_URGENCY_DEGREE"/>
                </td>
                <th width="10%">是否需要设备培训:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTrain" id="isTrain" title="是否需要设备培训"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否是计算机:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPc" id="isPc" title="是否是计算机" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">计划到货时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="planDeliveryTimeBegin"
                               id="planDeliveryTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">计划到货时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="planDeliveryTimeEnd"
                               id="planDeliveryTimeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">采购员:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="buyer" name="buyer">
                        <input class="form-control" placeholder="请选择用户" type="text" id="buyerAlias" name="buyerAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">采购计划员:</th>
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
                <th width="10%">是否具有无线功能:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWireless" id="isWireless" title="是否具有无线功能"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备购置类型:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="devicePurchaseType" id="devicePurchaseType"
                                  title="设备购置类型" isNull="true" lookupCode="DEVICE_PURCHASE_TYPE"/>
                </td>
                <th width="10%">设备购置原因:</th>
                <td width="15%">
                    <input title="设备购置原因" class="form-control input-sm" type="text" name="devicePurchaseCause"
                           id="devicePurchaseCause"/>
                </td>
                <th width="10%">技术指标:</th>
                <td width="15%">
                    <input title="技术指标" class="form-control input-sm" type="text" name="technicalIndex"
                           id="technicalIndex"/>
                </td>
                <th width="10%">技术指标:</th>
                <td width="15%">
                    <input title="技术指标" class="form-control input-sm" type="text" name="technicalIndex02"
                           id="technicalIndex02"/>
                </td>
            </tr>
            <tr>
                <th width="10%">指标先进性:</th>
                <td width="15%">
                    <input title="指标先进性" class="form-control input-sm" type="text" name="advancement" id="advancement"/>
                </td>
                <th width="10%">设备可靠性:</th>
                <td width="15%">
                    <input title="设备可靠性" class="form-control input-sm" type="text" name="deviceReliability"
                           id="deviceReliability"/>
                </td>
                <th width="10%">是否属于即将产能淘汰设备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWeedOut" id="isWeedOut" title="是否属于即将产能淘汰设备"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">已有设备为什么不能满足要求:</th>
                <td width="15%">
                    <input title="已有设备为什么不能满足要求" class="form-control input-sm" type="text" name="notMeetDemand"
                           id="notMeetDemand"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备利用率情况:</th>
                <td width="15%">
                    <input title="设备利用率情况" class="form-control input-sm" type="text" name="useRatio" id="useRatio"/>
                </td>
                <th width="10%">设备能耗情况 :</th>
                <td width="15%">
                    <input title="设备能耗情况 " class="form-control input-sm" type="text" name="energyConsumption"
                           id="energyConsumption"/>
                </td>
                <th width="10%">设备耗材经济性:</th>
                <td width="15%">
                    <input title="设备耗材经济性" class="form-control input-sm" type="text" name="consumableEconomics"
                           id="consumableEconomics"/>
                </td>
                <th width="10%">设备通用性:</th>
                <td width="15%">
                    <input title="设备通用性" class="form-control input-sm" type="text" name="universality"
                           id="universality"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备维保费用情况:</th>
                <td width="15%">
                    <input title="设备维保费用情况" class="form-control input-sm" type="text" name="maintainCost"
                           id="maintainCost"/>
                </td>
                <th width="10%">安全性:</th>
                <td width="15%">
                    <input title="安全性" class="form-control input-sm" type="text" name="security" id="security"/>
                </td>
                <th width="10%">安装设备楼层承重是否满足:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isBearingMeet" id="isBearingMeet"
                                  title="安装设备楼层承重是否满足" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">设备是否有室外机:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOutdoorUnit" id="isOutdoorUnit"
                                  title="设备是否有室外机" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">所安装位置是否允许安装室外机:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAllowOutdoorUnit" id="isAllowOutdoorUnit"
                                  title="所安装位置是否允许安装室外机" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">设备是否需要地基基础:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedFoundation" id="isNeedFoundation"
                                  title="设备是否需要地基基础" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">所安装位置是否具备设置地基条件:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFoundationCondition"
                                  id="isFoundationCondition" title="所安装位置是否具备设置地基条件" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">使用电压:</th>
                <td width="15%">
                    <input title="使用电压" class="form-control input-sm" type="text" name="serviceVoltage"
                           id="serviceVoltage"/>
                </td>
            </tr>
            <tr>
                <th width="10%">安装位置是否具备电压条件:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isVoltageCondition" id="isVoltageCondition"
                                  title="安装位置是否具备电压条件" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
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
                <th width="10%">是否对洁净度有要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isCleanlinessNeed" id="isCleanlinessNeed"
                                  title="是否对洁净度有要求" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">洁净度要求:</th>
                <td width="15%">
                    <input title="洁净度要求" class="form-control input-sm" type="text" name="cleanlinessNeed"
                           id="cleanlinessNeed"/>
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
                <th width="10%">是否有用气要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isGasNeed" id="isGasNeed" title="是否有用气要求"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">用气要求:</th>
                <td width="15%">
                    <input title="用气要求" class="form-control input-sm" type="text" name="gasNeed" id="gasNeed"/>
                </td>
                <th width="10%">是否是否有气体、污水排放:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isLet" id="isLet" title="是否是否有气体、污水排放"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">气体、污水排放要求:</th>
                <td width="15%">
                    <input title="气体、污水排放要求" class="form-control input-sm" type="text" name="letNeed" id="letNeed"/>
                </td>
                <th width="10%">是否有其他特殊要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOtherNeed" id="isOtherNeed"
                                  title="是否有其他特殊要求" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">其他特殊要求:</th>
                <td width="15%">
                    <input title="其他特殊要求" class="form-control input-sm" type="text" name="otherNeed" id="otherNeed"/>
                </td>
                <th width="10%">是否有噪音:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNoise" id="isNoise" title="是否有噪音"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">噪音是否影响安装地工作办公:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNoiseInfluence" id="isNoiseInfluence"
                                  title="噪音是否影响安装地工作办公" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">以上需求条件在拟安装地点是否都已具备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="aboveNeedHave" id="aboveNeedHave"
                                  title="以上需求条件在拟安装地点是否都已具备" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">审批总师:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="examineApproveEngineer" name="examineApproveEngineer">
                        <input class="form-control" placeholder="请选择用户" type="text" id="examineApproveEngineerAlias"
                               name="examineApproveEngineerAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">专业审核员:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="professionalAuditor" name="professionalAuditor">
                        <input class="form-control" placeholder="请选择用户" type="text" id="professionalAuditorAlias"
                               name="professionalAuditorAlias">
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
                <th width="10%">部门领导结论:</th>
                <td width="15%">
                    <input title="部门领导结论" class="form-control input-sm" type="text" name="deptHeadConclusion"
                           id="deptHeadConclusion"/>
                </td>
            </tr>
            <tr>
                <th width="10%">部门领导意见:</th>
                <td width="15%">
                    <input title="部门领导意见" class="form-control input-sm" type="text" name="deptHeadOpinion"
                           id="deptHeadOpinion"/>
                </td>
                <th width="10%">专业审核员意见:</th>
                <td width="15%">
                    <input title="专业审核员意见" class="form-control input-sm" type="text" name="professionalAuditorOpinion"
                           id="professionalAuditorOpinion"/>
                </td>
                <th width="10%">总师结论:</th>
                <td width="15%">
                    <input title="总师结论" class="form-control input-sm" type="text" name="chiefEngineerConclusion"
                           id="chiefEngineerConclusion"/>
                </td>
                <th width="10%">总师意见:</th>
                <td width="15%">
                    <input title="总师意见" class="form-control input-sm" type="text" name="chiefEngineerOpinion"
                           id="chiefEngineerOpinion"/>
                </td>
            </tr>
            <tr>
                <th width="10%">主管所领导结论:</th>
                <td width="15%">
                    <input title="主管所领导结论" class="form-control input-sm" type="text" name="competentLeaderConclusion"
                           id="competentLeaderConclusion"/>
                </td>
                <th width="10%">主管所领导意见:</th>
                <td width="15%">
                    <input title="主管所领导意见" class="form-control input-sm" type="text" name="competentLeaderOpinion"
                           id="competentLeaderOpinion"/>
                </td>
                <th width="10%">简易/大型设备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="largeDeviceType" id="largeDeviceType"
                                  title="简易/大型设备" isNull="true" lookupCode="LARGE_DEVICE_TYPE"/>
                </td>
                <th width="10%">研究所/公司:</th>
                <td width="15%">
                    <input title="研究所/公司" class="form-control input-sm" type="text" name="instituteOrCompany"
                           id="instituteOrCompany"/>
                </td>
            </tr>
            <tr>
                <th width="10%">安装地点（未使用）:</th>
                <td width="15%">
                    <input title="安装地点（未使用）" class="form-control input-sm" type="text" name="positionId"
                           id="positionId"/>
                </td>
                <th width="10%">标准设备年度申购征集通知单id:</th>
                <td width="15%">
                    <input title="标准设备年度申购征集通知单id" class="form-control input-sm" type="text" name="parentId"
                           id="parentId"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
    <form id="formSub">
        <input type="hidden" name="deptid" id="deptid"/>
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
                <th width="10%">经营范围:</th>
                <td width="15%">
                    <input title="经营范围" class="form-control input-sm" type="text" name="businessScope"
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
<script src="avicit/assets/device/assetssdequipcollect/js/AssetsSdequipCollect.js" type="text/javascript"></script>
<script src="avicit/assets/device/assetssdequipcollect/js/AssetsSupplier.js" type="text/javascript"></script>
<script type="text/javascript">
    var assetsSdequipCollect;
    var assetsSupplier;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsSdequipCollect.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsSdequipCollect.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    $(document).ready(function () {
        var searchMainNames = new Array();
        var searchMainTips = new Array();
        searchMainNames.push("createdByTel");
        searchMainTips.push("申请人电话");
        searchMainNames.push("formState");
        searchMainTips.push("单据状态");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#assetsSdequipCollect_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        var searchSubNames = new Array();
        var searchSubTips = new Array();
        searchSubNames.push("name");
        searchSubTips.push("供应商名称");
        searchSubNames.push("address");
        searchSubTips.push("供应商地址");
        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
        $('#assetsSupplier_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        var assetsSdequipCollectGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '申请人', name: 'createdByPersionAlias', width: 150}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '申请人电话', name: 'createdByTel', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '密级', name: 'secretLevel', width: 150}
            , {label: '参考厂家', name: 'referencePlant', width: 150}
            , {label: '台（套）数', name: 'deviceNum', width: 150}
            , {label: '单价(元)', name: 'unitPrice', width: 150}
            , {label: '总金额（元）', name: 'totalPrice', width: 150}
            , {label: '设备类型', name: 'deviceType', width: 150}
        ];
        var assetsSupplierGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '供应商名称', name: 'name', width: 150}
            , {label: '供应商地址', name: 'address', width: 150}
            , {label: '联系人', name: 'contact', width: 150}
            , {label: '联系电话', name: 'contactNumber', width: 150}
            , {label: '经营范围', name: 'businessScope', width: 150}
            , {label: '供应商状态：0:正常状态 2:停用', name: 'status', width: 150}
        ];

        assetsSdequipCollect = new AssetsSdequipCollect('assetsSdequipCollect', '${url}', 'form', assetsSdequipCollectGridColModel, 'searchDialog',
            function (pid) {
                assetsSupplier = new AssetsSupplier('assetsSupplier', '${surl}', "formSub", assetsSupplierGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsSupplier_keyWord");
            },
            function (pid) {
                assetsSupplier.reLoad(pid);
            },
            searchMainNames,
            "assetsSdequipCollect_keyWord");
        //主表操作
        //添加按钮绑定事件
        $('#assetsSdequipCollect_insert').bind('click', function () {
            assetsSdequipCollect.insert();
        });
        //编辑按钮绑定事件
        $('#assetsSdequipCollect_modify').bind('click', function () {
            assetsSdequipCollect.modify();
        });
        //删除按钮绑定事件
        $('#assetsSdequipCollect_del').bind('click', function () {
            assetsSdequipCollect.del();
        });
        //打开高级查询框
        $('#assetsSdequipCollect_searchAll').bind('click', function () {
            assetsSdequipCollect.openSearchForm(this, $('#assetsSdequipCollect'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsSdequipCollect_searchPart').bind('click', function () {
            assetsSdequipCollect.searchByKeyWord();
        });
        //子表操作
        //添加按钮绑定事件
        $('#assetsSupplier_insert').bind('click', function () {
            assetsSupplier.insert();
        });
        //编辑按钮绑定事件
        $('#assetsSupplier_modify').bind('click', function () {
            assetsSupplier.modify();
        });
        //删除按钮绑定事件
        $('#assetsSupplier_del').bind('click', function () {
            assetsSupplier.del();
        });
        //打开高级查询
        $('#assetsSupplier_searchAll').bind('click', function () {
            assetsSupplier.openSearchForm(this, $('#assetsSupplier'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsSupplier_searchPart').bind('click', function () {
            assetsSupplier.searchByKeyWord();
        });

        $('#createdByPersionAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'createdByPersion', textFiled: 'createdByPersionAlias'});
            this.blur();
        });
        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
        });
        $('#chiefEngineerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'chiefEngineer', textFiled: 'chiefEngineerAlias'});
            this.blur();
        });
        $('#projectDirectorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'projectDirector', textFiled: 'projectDirectorAlias'});
            this.blur();
        });
        $('#buyerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'buyer', textFiled: 'buyerAlias'});
            this.blur();
        });
        $('#planBuyerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'planBuyer', textFiled: 'planBuyerAlias'});
            this.blur();
        });
        $('#examineApproveEngineerAlias').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'examineApproveEngineer',
                textFiled: 'examineApproveEngineerAlias'
            });
            this.blur();
        });
        $('#professionalAuditorAlias').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'professionalAuditor',
                textFiled: 'professionalAuditorAlias'
            });
            this.blur();
        });
        $('#competentLeaderAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'competentLeader', textFiled: 'competentLeaderAlias'});
            this.blur();
        });


    });

</script>
</html>