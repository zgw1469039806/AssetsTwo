<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
    String singleSelect = request.getParameter("singleSelect"); // 是否单选参数（true-单选,flae-多选）
    if ("undefined".equals(singleSelect) || "".equals(singleSelect) || !"false".equals(singleSelect)) { // 如果不传或者传false以外的值时默认单选
        singleSelect = "true";
    }
    String requestType = request.getParameter("requestType"); // 页面调用字段识别，用于一个页面有多个相同弹出页面时使用
    if ("undefined".equals(requestType) || "".equals(requestType)) {
        requestType = "productModelSelect";
    }
    String callBackFn = request.getParameter("callBackFn"); // 回调函数名称
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/furniture/assetsfurnitureaccount/assetsFurnitureAccountController/toAssetsFurnitureAccountManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<style>
    /*.ui-jqgrid .ui-jqgrid-bdiv {*/
    /*height: 500px!important;*/
    /*}*/

    .ui-jqgrid .ui-jqgrid-btable tbody tr.jqgrow td {
        text-align: center;
    }

    .ui-jqgrid .ui-jqgrid-btable {
        text-align: center;
    }

    .ui-jqgrid .ui-jqgrid-hbox {
        padding-right: 0px!important;
    }
</style>

<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFurnitureAccount_button_add"--%>
                               <%--permissionDes="添加">--%>
            <%--<a id="assetsFurnitureAccount_insert" href="javascript:;" class="btn btn-primary form-tool-btn btn-sm"--%>
               <%--role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>--%>
        <%--</sec:accesscontrollist>--%>
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFurnitureAccount_button_edit"--%>
                               <%--permissionDes="编辑">--%>
            <%--<a id="assetsFurnitureAccount_modify" href="javascript:;" class="btn btn-primary form-tool-btn btn-sm"--%>
               <%--role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>--%>
        <%--</sec:accesscontrollist>--%>
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFurnitureAccount_button_delete"--%>
                               <%--permissionDes="删除">--%>
            <%--<a id="assetsFurnitureAccount_del" href="javascript:;" class="btn btn-primary form-tool-btn btn-sm"--%>
               <%--role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>--%>
        <%--</sec:accesscontrollist>--%>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFurnitureAccount_button_submit"
                               permissionDes="提交">
            <a id="assetsFurnitureAccount_submit" href="javascript:;" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="提交"><i class="fa fa-plus"></i> 提交</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsFurnitureAccount_keyWord" id="assetsFurnitureAccount_keyWord"
                   style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsFurnitureAccount_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsFurnitureAccount_searchAll" href="javascript:;" class="btn btn-defaul btn-sm" role="button">高级查询
                <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsFurnitureAccountjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">资产编号:</th>
                <td width="15%">
                    <input title="资产编号" class="form-control input-sm" type="text" name="assetId" id="assetId"/>
                </td>
                <th width="10%">家具名称:</th>
                <td width="15%">
                    <input title="家具名称" class="form-control input-sm" type="text" name="furnitureName"
                           id="furnitureName"/>
                </td>
                <th width="10%">家具分类:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="furnitureCategory" id="furnitureCategory"
                                  title="家具分类" isNull="true" lookupCode="FURNITURE_CATEGORY"/>
                </td>
            </tr>
            <tr>
                <th width="10%">责任人:</th>
                <td width="15%">
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
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias"
                               name="ownerDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">使用人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userId" name="userId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="userIdAlias" name="userIdAlias">
                        <span class="input-group-addon">
                        <i class="glyphicon glyphicon-user"></i>
                      </span>
                    </div>
                </td>
                <th width="10%">使用人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userDept" name="userDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="userDeptAlias"
                               name="userDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">生产厂家:</th>
                <td width="15%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId"
                           id="manufacturerId"/>
                </td>
                <th width="10%">家具规格:</th>
                <td width="15%">
                    <input title="家具规格" class="form-control input-sm" type="text" name="furnitureSpec"
                           id="furnitureSpec"/>
                </td>
                <th width="10%">立卡日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateBegin"
                               id="createdDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">立卡日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateEnd" id="createdDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">安装地点ID:</th>
                <td width="15%">
                    <input title="安装地点ID" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
                <th width="10%">质保截止日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="guaranteeDateBegin"
                               id="guaranteeDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">质保截止日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="guaranteeDateEnd"
                               id="guaranteeDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">合同号:</th>
                <td width="15%">
                    <input title="合同号" class="form-control input-sm" type="text" name="contractNum" id="contractNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">申购单号:</th>
                <td width="15%">
                    <input title="申购单号" class="form-control input-sm" type="text" name="applyNum" id="applyNum"/>
                </td>
                <th width="10%">验收单号:</th>
                <td width="15%">
                    <input title="验收单号" class="form-control input-sm" type="text" name="checkNum" id="checkNum"/>
                </td>
                <th width="10%">是否固定资产:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFixedAssets" id="isFixedAssets"
                                  title="是否固定资产" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">资产财务类别:</th>
                <td width="15%">
                    <input title="资产财务类别" class="form-control input-sm" type="text" name="assetsFinanceType"
                           id="assetsFinanceType"/>
                </td>
            </tr>
            <tr>
                <th width="10%">资产来源:</th>
                <td width="15%">
                    <input title="资产来源" class="form-control input-sm" type="text" name="assetsSource"
                           id="assetsSource"/>
                </td>
                <th width="10%">资产财务状态:</th>
                <td width="15%">
                    <input title="资产财务状态" class="form-control input-sm" type="text" name="assetsFinanceState"
                           id="assetsFinanceState"/>
                </td>
                <th width="10%">财务入账时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="financeEntryDateBegin"
                               id="financeEntryDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">财务入账时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="financeEntryDateEnd"
                               id="financeEntryDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">原值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="originalValue" id="originalValue"
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
                <th width="10%">累计折旧:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalDepreciation" id="totalDepreciation"
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
                <th width="10%">折旧方法:</th>
                <td width="15%">
                    <input title="折旧方法" class="form-control input-sm" type="text" name="depreciationMethod"
                           id="depreciationMethod"/>
                </td>
                <th width="10%">折旧年限:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="depreciationYear" id="depreciationYear"
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
                <th width="10%">净残值率:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netSalvageRate" id="netSalvageRate"
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
                <th width="10%">净残值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netSalvage" id="netSalvage"
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
                <th width="10%">月折旧率:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthDepreciationRate" id="monthDepreciationRate"
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
                <th width="10%">月折旧额:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthDepreciation" id="monthDepreciation"
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
                <th width="10%">年折旧率:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="yearDepreciationRate" id="yearDepreciationRate"
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
                <th width="10%">年折旧额:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="yearDepreciation" id="yearDepreciation"
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
                <th width="10%">净值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netValue" id="netValue"
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
                <th width="10%">已提月份:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthCount" id="monthCount"
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
                <th width="10%">未计提月份:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthRemain" id="monthRemain"
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
                <th width="10%">研究所/公司:</th>
                <td width="15%">
                    <input title="研究所/公司" class="form-control input-sm" type="text" name="instituteOrCompany"
                           id="instituteOrCompany"/>
                </td>
                <th width="10%">指标信息:</th>
                <td width="15%">
                    <input title="指标信息" class="form-control input-sm" type="text" name="indexInfo" id="indexInfo"/>
                </td>
                <th width="10%">是否转固:</th>
                <td width="15%">
                    <input title="是否转固" class="form-control input-sm" type="text" name="isTransFixed"
                           id="isTransFixed"/>
                </td>
            </tr>
            <tr>
                <th width="10%">凭证编号:</th>
                <td width="15%">
                    <input title="凭证编号" class="form-control input-sm" type="text" name="proofNum" id="proofNum"/>
                </td>
                <th width="10%">是否在流程中:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isInWorkflow" id="isInWorkflow" title="是否在流程中"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">家具照片:</th>
                <td width="15%">
                    <input title="家具照片" class="form-control input-sm" type="text" name="furniturePhoto"
                           id="furniturePhoto"/>
                </td>
                <th width="10%">家具状态:</th>
                <td width="15%">
                    <input title="家具状态" class="form-control input-sm" type="text" name="furnitureState"
                           id="furnitureState"/>
                </td>
            </tr>
            <tr>
                <th width="10%">父级家具ID:</th>
                <td width="15%">
                    <input title="父级家具ID" class="form-control input-sm" type="text" name="parentId" id="parentId"/>
                </td>
                <th width="10%">父级家具名称:</th>
                <td width="15%">
                    <input title="父级家具名称" class="form-control input-sm" type="text" name="parentName" id="parentName"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/furniture/assetsfurnitureaccount/js/AssetsFurnitureAccountSelect.js"
        type="text/javascript"></script>
<script type="text/javascript">
    var assetsFurnitureAccountSelect;
    var singleSelect = '<%=singleSelect%>';
    var requestType = '<%=requestType%>';
    var callBackFn = '<%=callBackFn%>';

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsFurnitureAccountSelect.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsFurnitureAccountSelect.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '序号', name: 'attribute01', width: 150}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '资产编号', name: 'assetId', width: 150, hidden: true}
            , {label: '家具名称', name: 'furnitureName', width: 150}
            , {label: '家具分类', name: 'furnitureCategory', width: 150}
            , {label: '责任人ID', name: 'ownerId', width: 150, hidden: true}
            , {label: '责任人', name: 'ownerIdAlias', width: 150}
            , {label: '责任人部门ID', name: 'ownerDept', width: 150, hidden: true}
            , {label: '责任人部门', name: 'ownerDeptAlias', width: 150}
            , {label: '使用人ID', name: 'userId', width: 150, hidden: true}
            , {label: '使用人', name: 'userIdAlias', width: 150, hidden: true}
            , {label: '使用人部门ID', name: 'userDept', width: 150, hidden: true}
            , {label: '使用人部门', name: 'userDeptAlias', width: 150, hidden: true}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '家具规格', name: 'furnitureSpec', width: 150}
            , {label: '立卡日期', name: 'createdDate', width: 150, formatter: format}
            , {label: '安装地点', name: 'positionId', width: 150}
            , {label: '质保期', name: 'guaranteePeriod', width: 150}
            , {label: '质保截止日期', name: 'guaranteeDate', width: 150, formatter: format}
            , {label: '单价', name: 'unitPrice', width: 150, hidden: true}
            , {label: '合同号', name: 'contractNum', width: 150, hidden: true}
            , {label: '申购单号', name: 'applyNum', width: 150, hidden: true}
            , {label: '验收单号', name: 'checkNum', width: 150, hidden: true}
            , {label: '是否固定资产', name: 'isFixedAssets', width: 150, hidden: true}
            , {label: '资产财务类别', name: 'assetsFinanceType', width: 150, hidden: true}
            , {label: '资产来源', name: 'assetsSource', width: 150, hidden: true}
            , {label: '资产财务状态', name: 'assetsFinanceState', width: 150, hidden: true}
            , {label: '财务入账时间', name: 'financeEntryDate', width: 150, formatter: format, hidden: true}
            , {label: '原值', name: 'originalValue', width: 150}
            , {label: '累计折旧', name: 'totalDepreciation', width: 150, hidden: true}
            , {label: '折旧方法', name: 'depreciationMethod', width: 150, hidden: true}
            , {label: '折旧年限', name: 'depreciationYear', width: 150, hidden: true}
            , {label: '净残值率', name: 'netSalvageRate', width: 150, hidden: true}
            , {label: '净残值', name: 'netSalvage', width: 150, hidden: true}
            , {label: '月折旧率', name: 'monthDepreciationRate', width: 150, hidden: true}
            , {label: '月折旧额', name: 'monthDepreciation', width: 150, hidden: true}
            , {label: '年折旧率', name: 'yearDepreciationRate', width: 150, hidden: true}
            , {label: '年折旧额', name: 'yearDepreciation', width: 150, hidden: true}
            , {label: '净值', name: 'netValue', width: 150}
            , {label: '已提月份', name: 'monthCount', width: 150, hidden: true}
            , {label: '未计提月份', name: 'monthRemain', width: 150, hidden: true}
            , {label: '研究所/公司', name: 'instituteOrCompany', width: 150, hidden: true}
            , {label: '指标信息', name: 'indexInfo', width: 150, hidden: true}
            , {label: '是否转固', name: 'isTransFixed', width: 150, hidden: true}
            , {label: '凭证编号', name: 'proofNum', width: 150, hidden: true}
            , {label: '是否在流程中', name: 'isInWorkflow', width: 150, hidden: true}
            , {label: '家具照片', name: 'furniturePhoto', width: 150, hidden: true}
            , {label: '家具状态', name: 'furnitureState', width: 150, hidden: true}
            , {label: '父级家具ID', name: 'parentId', width: 150, hidden: true}
            , {label: '父级家具名称', name: 'parentName', width: 150, hidden: true}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        searchNames.push("assetId");
        searchTips.push("资产编号");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsFurnitureAccount_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsFurnitureAccountSelect = new AssetsFurnitureAccount('assetsFurnitureAccountjqGrid', '${url}', 'searchDialog', 'form', 'assetsFurnitureAccount_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsFurnitureAccount_insert').bind('click', function () {
            assetsFurnitureAccountSelect.insert();
        });
        //编辑按钮绑定事件
        $('#assetsFurnitureAccount_modify').bind('click', function () {
            assetsFurnitureAccountSelect.modify();
        });
        //删除按钮绑定事件
        $('#assetsFurnitureAccount_del').bind('click', function () {
            assetsFurnitureAccountSelect.del();
        });
        //查询按钮绑定事件
        $('#assetsFurnitureAccount_searchPart').bind('click', function () {
            assetsFurnitureAccountSelect.searchByKeyWord();
        });
        //查询框回车事件
        $('#assetsFurnitureAccount_keyWord').bind('keyup', function (e) {
            if (e.keyCode == 13) {
                assetsFurnitureAccountSelect.searchByKeyWord();
            }
        });
        //打开高级查询框
        $('#assetsFurnitureAccount_searchAll').bind('click', function () {
            assetsFurnitureAccountSelect.openSearchForm(this);
        });
    });
    $('#assetsFurnitureAccount_submit').bind('click',
        function () {
            assetsFurnitureAccountSelect.submit();
        });

</script>
</html>