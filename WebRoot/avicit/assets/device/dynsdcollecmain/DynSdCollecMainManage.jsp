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
    <!-- ControllerPath = "assets/device/dynsdcollecmain/dynSdCollecMainController/toDynSdCollecMainManage" -->
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
<body class="easyui-layout" fit="true">
<div id="panelnorth"
     data-options="region:'north',height:fixheight(.3),onResize:function(a){$('#dynSdCollecMain').setGridWidth(a);$('#dynSdCollecMain').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
    <div id="toolbar_dynSdCollecMain" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynSdCollecMain_button_add"
                                   permissionDes="添加">
                <a id="dynSdCollecMain_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynSdCollecMain_button_edit"
                                   permissionDes="编辑">
                <a id="dynSdCollecMain_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   style="display:none;" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynSdCollecMain_button_delete"
                                   permissionDes="删除">
                <a id="dynSdCollecMain_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
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
                <input type="text" name="dynSdCollecMain_keyWord" id="dynSdCollecMain_keyWord" style="width:125px;"
                       class="form-control input-sm" placeholder="请输入查询条件">
                <label id="dynSdCollecMain_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="dynSdCollecMain_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
                    <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="dynSdCollecMain"></table>
    <div id="dynSdCollecMainPager"></div>
</div>

<div id="centerpanel"
     data-options="region:'center',split:true,onResize:function(a){$('#assetsSdequipCollect').setGridWidth(a); $('#assetsSdequipCollect').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
    <div class="eform-tab" style="border: 1px dashed #BBB;" contenteditable="false">
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation active"
                contenteditable="false"><a href="#5e0774cd-52f0-4aee-96e3-2728424c1e8c"
                                           aria-controls="5e0774cd-52f0-4aee-96e3-2728424c1e8c" role="tab"
                                           data-toggle="tab">上报列表</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false">
                <a href="#8a3a00db-cdd1-4089-923c-1e138c9a8678" aria-controls="8a3a00db-cdd1-4089-923c-1e138c9a8678"
                   role="tab" data-toggle="tab">下发列表</a></li>
        </ul>
        <div class="tab-content" style="height: 100%; min-height: 40px;">
            <div role="tabpanel" class="tab-pane active" contenteditable="false"
                 id="5e0774cd-52f0-4aee-96e3-2728424c1e8c" style="height: 100%; min-height: 40px;">
                <div id="toolbar_assetsSdequipCollect" class="toolbar">
                    <div class="toolbar-left">
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynSdCollecMain_button_add"
                                               permissionDes="导出">
                            <a id="assetssdequipcollect_export" href="javascript:void(0)"
                               class="btn btn-default form-tool-btn btn-sm"
                               role="button" title="导出"><i class="glyphicon glyphicon-export"></i> 导出</a>
                        </sec:accesscontrollist>
                    </div>

                    <div class="toolbar-right">
                        <div class="input-group form-tool-search" style="width:125px">
                            <input type="text" name="assetsSdequipCollect_keyWord" id="assetsSdequipCollect_keyWord"
                                   style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
                            <label id="assetsSdequipCollect_searchPart"
                                   class="icon icon-search form-tool-searchicon"></label>
                        </div>
                        <div class="input-group-btn form-tool-searchbtn">
                            <a id="assetsSdequipCollect_searchAll" href="javascript:void(0)"
                               class="btn btn-defaul btn-sm"
                               role="button">高级查询 <span class="caret"></span></a>
                        </div>
                    </div>
                </div>
                <table id="assetsSdequipCollect"></table>
                <div id="assetsSdequipCollectPager"></div>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="8a3a00db-cdd1-4089-923c-1e138c9a8678"
                 style="height: 100%; min-height: 40px;">
                <div id="toolbar_assetsSdequipCollectCm" class="toolbar">
                    <div class="toolbar-left">
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynSdCollecMain_button_add"
                                               permissionDes="导入">
                            <a id="assetssdequipcollect_import" href="javascript:void(0)"
                               class="btn btn-default form-tool-btn btn-sm"
                               role="button" title="导入"><i class="glyphicon glyphicon-import"></i> 导入</a>
                        </sec:accesscontrollist>
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynSdCollecMain_button_add"
                                               permissionDes="提交">
                            <a id="submit_assetsSdequipCollectCmPager" href="javascript:void(0)"
                               class="btn btn-default form-tool-btn btn-sm"
                               role="button" title="提交"><i class="glyphicon glyphicon-export"></i> 批量下发</a>
                        </sec:accesscontrollist>
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynSdCollecMain_button_delete"
                                               permissionDes="删除">
                            <a id="delete_assetsSdequipCollectCmPager" href="javascript:void(0)"
                               class="btn btn-default form-tool-btn btn-sm"
                               role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                        </sec:accesscontrollist>
                    </div>

                    <div class="toolbar-right">
                        <div class="input-group form-tool-search" style="width:125px">
                            <input type="text" name="assetsSdequipCollect_keyWord" id="assetsSdequipCollectCm_keyWord"
                                   style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
                            <label id="assetsSdequipCollectCm_searchPart"
                                   class="icon icon-search form-tool-searchicon"></label>
                        </div>
                        <div class="input-group-btn form-tool-searchbtn">
                            <a id="assetsSdequipCollectCm_searchAll" href="javascript:void(0)"
                               class="btn btn-defaul btn-sm"
                               role="button">高级查询 <span class="caret"></span></a>
                        </div>
                    </div>
                </div>
                <table id="assetsSdequipCollectCm"></table>
                <div id="assetsSdequipCollectCmPager"></div>
            </div>
        </div>
    </div>

</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">发布人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="author" name="author">
                        <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" name="authorAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">发布日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedateBegin"
                               id="releasedateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">发布日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedateEnd" id="releasedateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">电话:</th>
                <td width="15%">
                    <input title="电话" class="form-control input-sm" type="text" name="telephone" id="telephone"/>
                </td>
            </tr>
            <tr>
                <th width="10%">发布人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="dept" name="dept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" name="deptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">备注:</th>
                <td width="15%">
                    <input title="备注" class="form-control input-sm" type="text" name="formRemarks" id="formRemarks"/>
                </td>
                <th width="10%">标题:</th>
                <td width="15%">
                    <input title="标题" class="form-control input-sm" type="text" name="formTitle" id="formTitle"/>
                </td>
                <th width="10%">年度:</th>
                <td width="15%">
                    <input title="年度" class="form-control input-sm" type="text" name="applyYear" id="applyYear"/>
                </td>
            </tr>
            <tr>
                <th width="10%">部门上报截至日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="deptDeadlineBegin"
                               id="deptDeadlineBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">部门上报截至日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="deptDeadlineEnd"
                               id="deptDeadlineEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">个人上报截至日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="personDeadlineBegin"
                               id="personDeadlineBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">个人上报截至日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="personDeadlineEnd"
                               id="personDeadlineEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
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
                <th width="10%">申购单号:</th>
                <td width="15%">
                    <input title="申购单号" class="form-control input-sm" type="text" name="stdId" id="stdId"/>
                </td>
                <th width="10%">申请人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPersionSub" name="createdByPersion">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersionAliasSub"
                               name="createdByPersionAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">申请人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDeptSub" name="createdByDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAliasSub"
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
            </tr>
            <tr>
                <th width="10%">单据状态:</th>
                <td width="15%">
                    <input title="单据状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
                </td>
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
            </tr>
            <tr>
                <th width="10%">密级:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="密级"
                                  isNull="true" lookupCode="SECRET_LEVEL"/>
                </td>
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
            </tr>
            <tr>
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
                <th width="10%">设备类型:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceType" id="deviceType" title="设备类型"
                                  isNull="true" lookupCode="LARGE_DEVICE_TYPE"/>
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
            </tr>
            <tr>
                <th width="10%">是否现场计量:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSceneMetering" id="isSceneMetering"
                                  title="是否现场计量" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
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
            </tr>
            <tr>
                <th width="10%">是否点检:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpotCheck" id="isSpotCheck" title="是否点检"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
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
            </tr>
            <tr>
                <th width="10%">安装地点:</th>
                <td width="15%">
                    <input title="安装地点" class="form-control input-sm" type="text" name="installPosition"
                           id="installPosition"/>
                </td>
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
            </tr>
            <tr>
                <th width="10%">所属项目:</th>
                <td width="15%">
                    <input title="所属项目" class="form-control input-sm" type="text" name="toProject" id="toProject"/>
                </td>
                <th width="10%">批复名称:</th>
                <td width="15%">
                    <input title="批复名称" class="form-control input-sm" type="text" name="approvalName"
                           id="approvalName"/>
                </td>
                <th width="10%">主管总师:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="chiefEngineerSub" name="chiefEngineer">
                        <input class="form-control" placeholder="请选择用户" type="text" id="chiefEngineerAliasSub"
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
            </tr>
            <tr>
                <th width="10%">项目主管:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="projectDirectorSub" name="projectDirector">
                        <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAliasSub"
                               name="projectDirectorAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
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
            </tr>
            <tr>
                <th width="10%">计划到货时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="planDeliveryTimeBegin"
                               id="planDeliveryTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
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
                        <input type="hidden" id="buyerSub" name="buyer">
                        <input class="form-control" placeholder="请选择用户" type="text" id="buyerAliasSub"
                               name="buyerAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">采购计划员:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="planBuyerSub" name="planBuyer">
                        <input class="form-control" placeholder="请选择用户" type="text" id="planBuyerAliasSub"
                               name="planBuyerAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">是否具有无线功能:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWireless" id="isWireless" title="是否具有无线功能"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">设备购置类型:</th>
                <td width="15%">
                    <input title="设备购置类型" class="form-control input-sm" type="text" name="devicePurchaseType"
                           id="devicePurchaseType"/>
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
            </tr>
            <tr>
                <th width="10%">技术指标:</th>
                <td width="15%">
                    <input title="技术指标" class="form-control input-sm" type="text" name="technicalIndex02"
                           id="technicalIndex02"/>
                </td>
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
                    <input title="是否属于即将产能淘汰设备" class="form-control input-sm" type="text" name="isWeedOut"
                           id="isWeedOut"/>
                </td>
            </tr>
            <tr>
                <th width="10%">已有设备为什么不能满足要求:</th>
                <td width="15%">
                    <input title="已有设备为什么不能满足要求" class="form-control input-sm" type="text" name="notMeetDemand"
                           id="notMeetDemand"/>
                </td>
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
            </tr>
            <tr>
                <th width="10%">设备通用性:</th>
                <td width="15%">
                    <input title="设备通用性" class="form-control input-sm" type="text" name="universality"
                           id="universality"/>
                </td>
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
            </tr>
            <tr>
                <th width="10%">设备是否有室外机:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOutdoorUnit" id="isOutdoorUnit"
                                  title="设备是否有室外机" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
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
            </tr>
            <tr>
                <th width="10%">使用电压:</th>
                <td width="15%">
                    <input title="使用电压" class="form-control input-sm" type="text" name="serviceVoltage"
                           id="serviceVoltage"/>
                </td>
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
            </tr>
            <tr>
                <th width="10%">是否对洁净度有要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isCleanlinessNeed" id="isCleanlinessNeed"
                                  title="是否对洁净度有要求" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
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
                <th width="10%">是否是否有气体、污水排放:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isLet" id="isLet" title="是否是否有气体、污水排放"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">气体、污水排放要求:</th>
                <td width="15%">
                    <input title="气体、污水排放要求" class="form-control input-sm" type="text" name="letNeed" id="letNeed"/>
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
            </tr>
            <tr>
                <th width="10%">以上需求条件在拟安装地点是否都已具备:</th>
                <td width="15%">
                    <input title="以上需求条件在拟安装地点是否都已具备" class="form-control input-sm" type="text" name="aboveNeedHave"
                           id="aboveNeedHave"/>
                </td>
                <th width="10%">审批总师:</th>
                <td width="15%">
                    <input title="审批总师" class="form-control input-sm" type="text" name="examineApproveEngineer"
                           id="examineApproveEngineer"/>
                </td>
                <th width="10%">专业审核员:</th>
                <td width="15%">
                    <input title="专业审核员" class="form-control input-sm" type="text" name="professionalAuditor"
                           id="professionalAuditor"/>
                </td>
                <th width="10%">主管所领导:</th>
                <td width="15%">
                    <input title="主管所领导" class="form-control input-sm" type="text" name="competentLeader"
                           id="competentLeader"/>
                </td>
            </tr>
            <tr>
                <th width="10%">部门领导结论:</th>
                <td width="15%">
                    <input title="部门领导结论" class="form-control input-sm" type="text" name="deptHeadConclusion"
                           id="deptHeadConclusion"/>
                </td>
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
            </tr>
            <tr>
                <th width="10%">总师意见:</th>
                <td width="15%">
                    <input title="总师意见" class="form-control input-sm" type="text" name="chiefEngineerOpinion"
                           id="chiefEngineerOpinion"/>
                </td>
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
                                  title="简易/大型设备" isNull="true" lookupCode="SIMPLE_LARGE_SCALE"/>
                </td>
            </tr>
            <tr>
                <th width="10%">研究所/公司:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="instituteOrCompany" id="instituteOrCompany"
                                  title="研究所/公司" isNull="true" lookupCode="INSTITUTE_OR_COMPANY"/>
                </td>
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

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script src="avicit/assets/device/dynsdcollecmain/js/DynSdCollecMain.js" type="text/javascript"></script>
<script src="avicit/assets/device/dynsdcollecmain/js/AssetsSdequipCollect.js" type="text/javascript"></script>
<script src="avicit/assets/device/dynsdcollecmain/js/AssetsSdequipCollectCm.js" type="text/javascript"></script>

<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<%--<script src="static/js/platform/index/js/jQuery/jQuery-easyui-1.2.6/jquery.easyui.min.js" type="text/javascript"></script>--%>
<%--<script src="static/js/platform/esb/easyui/plugins/jquery.messager.js" type="text/javascript"></script>--%>


<%--<script src="static/js/platform/index/js/jQuery/jQuery-easyui-1.2.6/jquery.easyui.min.js" type="text/javascript"></script>--%>
<script src="avicit/platform6/bs3centralcontrol/appliaction/js/AppList.js" type="text/javascript"></script>
<script type="text/javascript" src="avicit/platform6/console/consolelog/js/conlog.js"></script>


<script type="text/javascript">
    var dynSdCollecMain;
    var assetsSdequipCollect;
    var assetsSdequipCollectCm;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="dynSdCollecMain.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="dynSdCollecMain.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        dynSdCollecMain.reLoad();
    };

    $(document).ready(function () {
        var searchMainNames = new Array();
        var searchMainTips = new Array();
        searchMainNames.push("formTitle");
        searchMainTips.push("标题");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#dynSdCollecMain_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#dynSdCollecMain_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);
        var searchSubNames = new Array();
        var searchSubTips = new Array();
        searchSubNames.push("stdId");
        searchSubTips.push("申购单号");
        searchSubNames.push("createdByTel");
        searchSubTips.push("申请人电话");
        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
        $('#assetsSdequipCollect_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        $('#assetsSdequipCollect_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);
        var dynSdCollecMainGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '标题', name: 'formTitle', width: 300, formatter: formatValue}
            , {label: '发布人', name: 'authorAlias', width: 150}
            , {label: '发布日期', name: 'releasedate', width: 150, formatter: format}
            , {label: '发布人部门', name: 'deptAlias', width: 150}
            , {label: '年度', name: 'applyYear', width: 150}
            , {label: '部门上报截至日期', name: 'deptDeadline', width: 150, formatter: format}
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            , {label: '流程状态', name: 'businessstate_', width: 150}
        ];
        var assetsSdequipCollectGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '申购单号', name: 'stdId', width: 150, hidden: true}
            , {label: '申请人', name: 'createdByPersionAlias', width: 150}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '申请人账号', name: 'attribute02', width: 150, hidden: true}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备类型', name: 'deviceTypeName', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '参考厂家', name: 'referencePlant', width: 150}
            , {label: '台（套）数', name: 'deviceNum', width: 150}
            , {label: '单价', name: 'unitPrice', width: 150}
            , {label: '总金额', name: 'totalPrice', width: 150}
            , {label: '采购计划员', name: 'planBuyerAlias', width: 150, hidden: true}
            , {label: '采购计划员账号', name: 'attribute03', width: 150, hidden: true}
            , {label: '计划到货日期', name: 'planDeliveryTime', width: 150, hidden: true}
            /*  , {label: '设备类别', name: 'deviceCategoryName', width: 150}
              , {label: '是否计量', name: 'isMeteringName', width: 150}
              , {label: '是否现场计量', name: 'isSceneMeteringName', width: 150}
              , {label: '是否保养', name: 'isMaintainName', width: 150}
              , {label: '是否精度检查', name: 'isAccuracyCheckName', width: 150}
              , {label: '是否定检', name: 'isRegularCheckName', width: 150}
              , {label: '是否点检', name: 'isSpotCheckName', width: 150}
              , {label: '是否特种设备', name: 'isSpecialDeviceName', width: 150}
              , {label: '是否精度指标', name: 'isPrecisionIndexName', width: 150}
              , {label: '是否需要安装', name: 'isNeedInstallName', width: 150}
              , {label: '安装地点', name: 'installPosition', width: 150}
              , {label: '是否需要地基基础', name: 'isFoundationName', width: 150}
              , {label: '是否涉及安全生产', name: 'isSafetyProductionName', width: 150}
              , {label: '经费来源', name: 'financialResourcesName', width: 150}
              , {label: '所属项目', name: 'toProject', width: 150}
              , {label: '批复名称', name: 'approvalName', width: 150}
              , {label: '主管总师', name: 'chiefEngineerAlias', width: 150}
              , {label: '项目序号', name: 'projectNum', width: 150}
              , {label: '项目主管', name: 'projectDirectorAlias', width: 150}
              , {label: '需求紧急程度', name: 'demandUrgencyDegreeName', width: 150}
              , {label: '是否需要设备培训', name: 'isTrainName', width: 150}
              , {label: '是否是计算机', name: 'isPcName', width: 150}
              , {label: '计划到货时间', name: 'planDeliveryTime', width: 150, formatter: format}
              , {label: '采购员', name: 'buyerAlias', width: 150}
              , {label: '采购计划员', name: 'planBuyerAlias', width: 150}
              , {label: '是否具有无线功能', name: 'isWirelessName', width: 150}
              , {label: '设备购置类型', name: 'devicePurchaseType', width: 150}
              , {label: '设备购置原因', name: 'devicePurchaseCause', width: 150}
              , {label: '技术指标', name: 'technicalIndex', width: 150}
              , {label: '技术指标', name: 'technicalIndex02', width: 150}
              , {label: '指标先进性', name: 'advancement', width: 150}
              , {label: '设备可靠性', name: 'deviceReliability', width: 150}
              , {label: '是否属于即将产能淘汰设备', name: 'isWeedOut', width: 150}
              , {label: '已有设备为什么不能满足要求', name: 'notMeetDemand', width: 150}
              , {label: '设备利用率情况', name: 'useRatio', width: 150}
              , {label: '设备能耗情况 ', name: 'energyConsumption', width: 150}
              , {label: '设备耗材经济性', name: 'consumableEconomics', width: 150}
              , {label: '设备通用性', name: 'universality', width: 150}
              , {label: '设备维保费用情况', name: 'maintainCost', width: 150}
              , {label: '安全性', name: 'security', width: 150}
              , {label: '安装设备楼层承重是否满足', name: 'isBearingMeetName', width: 150}
              , {label: '设备是否有室外机', name: 'isOutdoorUnitName', width: 150}
              , {label: '所安装位置是否允许安装室外机', name: 'isAllowOutdoorUnitName', width: 150}
              , {label: '设备是否需要地基基础', name: 'isNeedFoundationName', width: 150}
              , {label: '所安装位置是否具备设置地基条件', name: 'isFoundationConditionName', width: 150}
              , {label: '使用电压', name: 'serviceVoltage', width: 150}
              , {label: '安装位置是否具备电压条件', name: 'isVoltageConditionName', width: 150}
              , {label: '是否对温湿度有要求', name: 'isHumidityNeedName', width: 150}
              , {label: '温湿度要求', name: 'humidityNeed', width: 150}
              , {label: '是否对洁净度有要求', name: 'isCleanlinessNeedName', width: 150}
              , {label: '洁净度要求', name: 'cleanlinessNeed', width: 150}
              , {label: '是否有用水要求', name: 'isWaterNeedName', width: 150}
              , {label: '用水要求', name: 'waterNeed', width: 150}
              , {label: '是否有用气要求', name: 'isGasNeedName', width: 150}
              , {label: '用气要求', name: 'gasNeed', width: 150}
              , {label: '是否是否有气体、污水排放', name: 'isLetName', width: 150}
              , {label: '气体、污水排放要求', name: 'letNeed', width: 150}
              , {label: '是否有其他特殊要求', name: 'isOtherNeedName', width: 150}
              , {label: '其他特殊要求', name: 'otherNeed', width: 150}
              , {label: '是否有噪音', name: 'isNoiseName', width: 150}
              , {label: '噪音是否影响安装地工作办公', name: 'isNoiseInfluenceName', width: 150}
              , {label: '以上需求条件在拟安装地点是否都已具备', name: 'aboveNeedHave', width: 150}
              , {label: '审批总师', name: 'examineApproveEngineer', width: 150}
              , {label: '专业审核员', name: 'professionalAuditor', width: 150}
              , {label: '主管所领导', name: 'competentLeader', width: 150}
              , {label: '部门领导结论', name: 'deptHeadConclusion', width: 150}
              , {label: '部门领导意见', name: 'deptHeadOpinion', width: 150}
              , {label: '专业审核员意见', name: 'professionalAuditorOpinion', width: 150}
              , {label: '总师结论', name: 'chiefEngineerConclusion', width: 150}
              , {label: '总师意见', name: 'chiefEngineerOpinion', width: 150}
              , {label: '主管所领导结论', name: 'competentLeaderConclusion', width: 150}
              , {label: '主管所领导意见', name: 'competentLeaderOpinion', width: 150}
              , {label: '简易/大型设备', name: 'largeDeviceTypeName', width: 150}
              , {label: '研究所/公司', name: 'instituteOrCompanyName', width: 150}
              , {label: '安装地点（未使用）', name: 'positionId', width: 150}
              , {label: '标准设备年度申购征集通知单id', name: 'parentId', width: 150}*/
        ];

        var assetsSdequipCollectCmGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '申购单号', name: 'stdId', width: 150, hidden: true}
            , {label: '申请人', name: 'createdByPersionAlias', width: 150}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '申请人账号', name: 'attribute02', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备类型', name: 'deviceTypeName', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '参考厂家', name: 'referencePlant', width: 150}
            , {label: '台（套）数', name: 'deviceNum', width: 150}
            , {label: '单价', name: 'unitPrice', width: 150}
            , {label: '总金额', name: 'totalPrice', width: 150}
            , {label: '采购计划员', name: 'planBuyerAlias', width: 150}
            , {label: '采购计划员账号', name: 'attribute03', width: 150}
            , {label: '计划到货日期', name: 'planDeliveryTime', width: 150, formatter: format}
            /* , {label: '设备类别', name: 'deviceCategoryName', width: 150}
             , {label: '是否计量', name: 'isMeteringName', width: 150}
             , {label: '是否现场计量', name: 'isSceneMeteringName', width: 150}
             , {label: '是否保养', name: 'isMaintainName', width: 150}
             , {label: '是否精度检查', name: 'isAccuracyCheckName', width: 150}
             , {label: '是否定检', name: 'isRegularCheckName', width: 150}
             , {label: '是否点检', name: 'isSpotCheckName', width: 150}
             , {label: '是否特种设备', name: 'isSpecialDeviceName', width: 150}
             , {label: '是否精度指标', name: 'isPrecisionIndexName', width: 150}
             , {label: '是否需要安装', name: 'isNeedInstallName', width: 150}
             , {label: '安装地点', name: 'installPosition', width: 150}
             , {label: '是否需要地基基础', name: 'isFoundationName', width: 150}
             , {label: '是否涉及安全生产', name: 'isSafetyProductionName', width: 150}
             , {label: '经费来源', name: 'financialResourcesName', width: 150}
             , {label: '所属项目', name: 'toProject', width: 150}
             , {label: '批复名称', name: 'approvalName', width: 150}
             , {label: '主管总师', name: 'chiefEngineerAlias', width: 150}
             , {label: '项目序号', name: 'projectNum', width: 150}
             , {label: '项目主管', name: 'projectDirectorAlias', width: 150}
             , {label: '需求紧急程度', name: 'demandUrgencyDegreeName', width: 150}
             , {label: '是否需要设备培训', name: 'isTrainName', width: 150}
             , {label: '是否是计算机', name: 'isPcName', width: 150}
             , {label: '计划到货时间', name: 'planDeliveryTime', width: 150, formatter: format}
             , {label: '采购员', name: 'buyerAlias', width: 150}
             , {label: '采购计划员', name: 'planBuyerAlias', width: 150}
             , {label: '是否具有无线功能', name: 'isWirelessName', width: 150}
             , {label: '设备购置类型', name: 'devicePurchaseTypeName', width: 150}
             , {label: '设备购置原因', name: 'devicePurchaseCause', width: 150}
             , {label: '技术指标', name: 'technicalIndex', width: 150}
             , {label: '技术指标', name: 'technicalIndex02', width: 150}
             , {label: '指标先进性', name: 'advancement', width: 150}
             , {label: '设备可靠性', name: 'deviceReliability', width: 150}
             , {label: '是否属于即将产能淘汰设备', name: 'isWeedOutName', width: 150}
             , {label: '已有设备为什么不能满足要求', name: 'notMeetDemand', width: 150}
             , {label: '设备利用率情况', name: 'useRatio', width: 150}
             , {label: '"设备能耗情况 "', name: 'energyConsumption', width: 150}
             , {label: '设备耗材经济性', name: 'consumableEconomics', width: 150}
             , {label: '设备通用性', name: 'universality', width: 150}
             , {label: '设备维保费用情况', name: 'maintainCost', width: 150}
             , {label: '安全性', name: 'security', width: 150}
             , {label: '安装设备楼层承重是否满足', name: 'isBearingMeetName', width: 150}
             , {label: '设备是否有室外机', name: 'isOutdoorUnitName', width: 150}
             , {label: '所安装位置是否允许安装室外机', name: 'isAllowOutdoorUnitName', width: 150}
             , {label: '设备是否需要地基基础', name: 'isNeedFoundationName', width: 150}
             , {label: '所安装位置是否具备设置地基条件', name: 'isFoundationConditionName', width: 150}
             , {label: '使用电压', name: 'serviceVoltage', width: 150}
             , {label: '安装位置是否具备电压条件', name: 'isVoltageConditionName', width: 150}
             , {label: '是否对温湿度有要求', name: 'isHumidityNeedName', width: 150}
             , {label: '温湿度要求', name: 'humidityNeed', width: 150}
             , {label: '是否对洁净度有要求', name: 'isCleanlinessNeedName', width: 150}
             , {label: '洁净度要求', name: 'cleanlinessNeed', width: 150}
             , {label: '是否有用水要求', name: 'isWaterNeedName', width: 150}
             , {label: '用水要求', name: 'waterNeed', width: 150}
             , {label: '是否有用气要求', name: 'isGasNeedName', width: 150}
             , {label: '用气要求', name: 'gasNeed', width: 150}
             , {label: '是否是否有气体、污水排放', name: 'isLetName', width: 150}
             , {label: '气体、污水排放要求', name: 'letNeed', width: 150}
             , {label: '是否有其他特殊要求', name: 'isOtherNeedName', width: 150}
             , {label: '其他特殊要求', name: 'otherNeed', width: 150}
             , {label: '是否有噪音', name: 'isNoiseName', width: 150}
             , {label: '噪音是否影响安装地工作办公', name: 'isNoiseInfluenceName', width: 150}
             , {label: '以上需求条件在拟安装地点是否都已具备', name: 'aboveNeedHave', width: 150}
             , {label: '审批总师', name: 'examineApproveEngineerAlias', width: 150}
             , {label: '专业审核员', name: 'professionalAuditorAlias', width: 150}
             , {label: '主管所领导', name: 'competentLeaderAlias', width: 150}
             , {label: '部门领导结论', name: 'deptHeadConclusion', width: 150}
             , {label: '部门领导意见', name: 'deptHeadOpinion', width: 150}
             , {label: '专业审核员意见', name: 'professionalAuditorOpinion', width: 150}
             , {label: '总师结论', name: 'chiefEngineerConclusion', width: 150}
             , {label: '总师意见', name: 'chiefEngineerOpinion', width: 150}
             , {label: '主管所领导结论', name: 'competentLeaderConclusion', width: 150}
             , {label: '主管所领导意见', name: 'competentLeaderOpinion', width: 150}
             , {label: '简易/大型设备', name: 'largeDeviceTypeName', width: 150}
             , {label: '研究所/公司', name: 'instituteOrCompanyName', width: 150}
             , {label: '安装地点（未使用）', name: 'positionId', width: 150}
             , {label: '标准设备年度申购征集通知单id', name: 'parentId', width: 150}*/
        ];

        dynSdCollecMain = new DynSdCollecMain('dynSdCollecMain', '${url}', 'form', dynSdCollecMainGridColModel, 'searchDialog',
            function (pid) {

                assetsSdequipCollect = new AssetsSdequipCollect('assetsSdequipCollect', '${surl}', "formSub", assetsSdequipCollectGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsSdequipCollect_keyWord");
            },
            function (pid) {

                assetsSdequipCollect.reLoad(pid);
            },
            function (pid) {

                assetsSdequipCollectCm = new AssetsSdequipCollectCm('assetsSdequipCollectCm', '${surl}', "formSub", assetsSdequipCollectCmGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsSdequipCollectCm_keyWord");
            },
            function (pid) {

                assetsSdequipCollectCm.reLoad(pid);
            },
            searchMainNames,
            "dynSdCollecMain_keyWord");
        //主表操作
        //添加按钮绑定事件
        $('#dynSdCollecMain_insert').bind('click', function () {
            dynSdCollecMain.insert();
        });
        //编辑按钮绑定事件
        $('#dynSdCollecMain_modify').bind('click', function () {
            dynSdCollecMain.modify();
        });
        //删除按钮绑定事件
        $('#dynSdCollecMain_del').bind('click', function () {
            dynSdCollecMain.del();
        });
        //打开高级查询框
        $('#dynSdCollecMain_searchAll').bind('click', function () {
            dynSdCollecMain.openSearchForm(this, $('#dynSdCollecMain'));
        });
        //关键字段查询按钮绑定事件
        $('#dynSdCollecMain_searchPart').bind('click', function () {
            dynSdCollecMain.searchByKeyWord();
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            dynSdCollecMain.initWorkFlow($(this).val());
        });
        //子表1操作
        //打开高级查询
        $('#assetsSdequipCollect_searchAll').bind('click', function () {
            assetsSdequipCollect.openSearchForm(this, $('#assetsSdequipCollect'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsSdequipCollect_searchPart').bind('click', function () {
            assetsSdequipCollect.searchByKeyWord();
        });
        //子表2操作
        //打开高级查询
        $('#assetsSdequipCollectCm_searchAll').bind('click', function () {
            assetsSdequipCollectCm.openSearchForm(this, $('#assetsSdequipCollectCm'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsSdequipCollectCm_searchPart').bind('click', function () {
            assetsSdequipCollectCm.searchByKeyWord();
        });
        $('#authorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'author', textFiled: 'authorAlias'});
            this.blur();
            nullInput(e);
        });
        $('#deptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'dept', textFiled: 'deptAlias'});
            this.blur();
            nullInput(e);
        });

        $('#createdByPersionAliasSub').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'createdByPersionSub',
                textFiled: 'createdByPersionAliasSub'
            });
            this.blur();
            nullInput(e);
        });

        $('#createdByDeptAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDeptSub', textFiled: 'createdByDeptAliasSub'});
            this.blur();
            nullInput(e);
        });
        $('#chiefEngineerAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'chiefEngineerSub', textFiled: 'chiefEngineerAliasSub'});
            this.blur();
            nullInput(e);
        });

        $('#projectDirectorAliasSub').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'projectDirectorSub',
                textFiled: 'projectDirectorAliasSub'
            });
            this.blur();
            nullInput(e);
        });

        $('#buyerAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'buyerSub', textFiled: 'buyerAliasSub'});
            this.blur();
            nullInput(e);
        });

        $('#planBuyerAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'planBuyerSub', textFiled: 'planBuyerAliasSub'});
            this.blur();
            nullInput(e);
        });


        /*年度计划上报表导出*/
        $('#assetssdequipcollect_export').bind('click', function () {
            exportAll();
        });

        /*年度计划下发表导入，generateExcel()：根据需求生成模板；importSdequipPlan()：导入功能界面*/
        $('#assetssdequipcollect_import').bind('click', function () {

            generateExcel();
            importSdequipPlan();
        });

        $('#delete_assetsSdequipCollectCmPager').bind('click', function () {

            debugger;
            assetsSdequipCollectCm.del();
        });


        /*年度计划下发表批量下发功能：*/
        $('#submit_assetsSdequipCollectCmPager').bind('click', function () {

        })

        /*弹出页关闭页面方法（弹出页的关闭按钮js在其父页面）*/
        $(".layui-layer-close1").on("click", function () {
            var closewindow = window.document.getElementsByClassName("layui-layer-ico layui-layer-close layui-layer-close1");
            closewindow[0].click();
        });

    });


</script>
</html>