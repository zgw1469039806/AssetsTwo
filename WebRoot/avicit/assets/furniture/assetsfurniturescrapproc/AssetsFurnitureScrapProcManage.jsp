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
    <!-- ControllerPath = "assets/furniture/assetsfurniturescrapproc/assetsFurnitureScrapProcController/toAssetsFurnitureScrapProcManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<!-- 下行height:fixheight(1)设置主子表子表不显示，主子表默认为fixheight(.5) -->
<body class="easyui-layout" fit="true">
<div id="panelnorth"
     data-options="region:'north',height:fixheight(1),onResize:function(a){$('#assetsFurnitureScrapProc').setGridWidth(a);$('#assetsFurnitureScrapProc').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
    <div id="toolbar_assetsFurnitureScrapProc" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFurnitureScrapProc_button_add"
                                   permissionDes="添加">
                <a id="assetsFurnitureScrapProc_insert" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i>
                    添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFurnitureScrapProc_button_edit"
                                   permissionDes="编辑">
                <a id="assetsFurnitureScrapProc_modify" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="编辑"><i
                        class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFurnitureScrapProc_button_delete"
                                   permissionDes="删除">
                <a id="assetsFurnitureScrapProc_del" href="javascript:void(0)"
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
                <input type="text" name="assetsFurnitureScrapProc_keyWord" id="assetsFurnitureScrapProc_keyWord"
                       style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsFurnitureScrapProc_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsFurnitureScrapProc_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button">高级查询 <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="assetsFurnitureScrapProc"></table>
    <div id="assetsFurnitureScrapProcPager"></div>
</div>
<div id="centerpanel"
     data-options="region:'center',split:true,onResize:function(a){$('#assetsFurnitureScrapSub').setGridWidth(a); $('#assetsFurnitureScrapSub').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
    <div id="toolbar_assetsFurnitureScrapSub" class="toolbar">
        <div class="toolbar-right">
            <div class="input-group form-tool-search" style="width:125px">
                <input type="text" name="assetsFurnitureScrapSub_keyWord" id="assetsFurnitureScrapSub_keyWord"
                       style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsFurnitureScrapSub_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsFurnitureScrapSub_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button">高级查询 <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="assetsFurnitureScrapSub"></table>
    <div id="assetsFurnitureScrapSubPager"></div>
</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">报废单号:</th>
                <td width="15%">
                    <input title="报废单号" class="form-control input-sm" type="text" name="procId" id="procId"/>
                </td>

                <th width="10%">申请人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPerson" name="createdByPerson">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAlias"
                               name="createdByPersonAlias">
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
            </tr>
            <tr>
                <th width="10%">报废原因:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="报废原因" name="scrapReason"
                              id="scrapReason"></textarea>
                </td>
                <th width="10%">备注:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="备注" name="remarks" id="remarks"></textarea>
                </td>
            </tr>
            <%--
            <tr>
                <th width="10%">流程名称:</th>
                <td width="15%">
                    <input title="流程名称" class="form-control input-sm" type="text" name="procName" id="procName"/>
                </td>
                <th width="10%">单据状态:</th>
                <td width="15%">
                    <input title="单据状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
                </td>
            </tr>
            --%>
        </table>
    </form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
    <form id="formSub">
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
                <th width="10%">家具规格:</th>
                <td width="15%">
                    <input title="家具规格" class="form-control input-sm" type="text" name="furnitureSpec"
                           id="furnitureSpec"/>
                </td>
                <th width="10%">责任人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerIdSub" name="ownerId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAliasSub"
                               name="ownerIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">责任人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDeptSub" name="ownerDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAliasSub"
                               name="ownerDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">使用人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userIdSub" name="userId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="userIdAliasSub"
                               name="userIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">使用人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userDeptSub" name="userDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="userDeptAliasSub"
                               name="userDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">生产厂家:</th>
                <td width="15%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId"
                           id="manufacturerId"/>
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
                <th width="10%">家具照片:</th>
                <td width="15%">
                    <input title="家具照片" class="form-control input-sm" type="text" name="furniturePhoto"
                           id="furniturePhoto"/>
                </td>
                <th width="10%">家具状态:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="furnitureState" id="furnitureState"
                                  title="家具状态" isNull="true" lookupCode="FURNITURE_STATE"/>
                </td>
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
            </tr>
            <tr>
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
<script type="text/javascript">
    var assetsFurnitureScrapProc;
    var assetsFurnitureScrapSub;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsFurnitureScrapProc.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsFurnitureScrapProc.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsFurnitureScrapProc.reLoad();
    };

    $(document).ready(function () {
        var searchMainNames = new Array();
        var searchMainTips = new Array();
        searchMainNames.push("procId");
        searchMainTips.push("报废单号");
        // searchMainNames.push("procName");
        // searchMainTips.push("流程名称");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#assetsFurnitureScrapProc_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#assetsFurnitureScrapProc_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);
        var searchSubNames = new Array();
        var searchSubTips = new Array();
        searchSubNames.push("unifiedId");
        searchSubTips.push("统一编号");
        searchSubNames.push("assetId");
        searchSubTips.push("资产编号");
        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
        $('#assetsFurnitureScrapSub_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        $('#assetsFurnitureScrapSub_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);
        var assetsFurnitureScrapProcGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            // , {label: '流程名称', name: 'procName', width: 150}
            , {label: '报废单号', name: 'procId', width: 150, formatter: formatValue}
            // , {label: '单据状态', name: 'formState', width: 150}
            , {label: '申请人', name: 'createdByPersonAlias', width: 150}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '申请人电话', name: 'createdByTel', width: 150}
            , {label: '报废原因', name: 'scrapReason', width: 150}
            , {label: '备注', name: 'remarks', width: 150}
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            , {label: '流程状态', name: 'businessstate_', width: 150}
        ];
        var assetsFurnitureScrapSubGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '资产编号', name: 'assetId', width: 150}
            , {label: '家具名称', name: 'furnitureName', width: 150}
            , {label: '家具分类', name: 'furnitureCategoryName', width: 150}
            , {label: '家具规格', name: 'furnitureSpec', width: 150}
            , {label: '责任人', name: 'ownerIdAlias', width: 150}
            , {label: '责任人部门', name: 'ownerDeptAlias', width: 150}
            , {label: '使用人', name: 'userIdAlias', width: 150}
            , {label: '使用人部门', name: 'userDeptAlias', width: 150}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '立卡日期', name: 'createdDate', width: 150, formatter: format}
            , {label: '安装地点ID', name: 'positionId', width: 150}
            , {label: '家具照片', name: 'furniturePhoto', width: 150}
            , {label: '家具状态', name: 'furnitureStateName', width: 150}
            , {label: '原值', name: 'originalValue', width: 150}
            , {label: '净值', name: 'netValue', width: 150}
        ];

        assetsFurnitureScrapProc = new AssetsFurnitureScrapProc('assetsFurnitureScrapProc', '${url}', 'form', assetsFurnitureScrapProcGridColModel, 'searchDialog',
            function (pid) {
                assetsFurnitureScrapSub = new AssetsFurnitureScrapSub('assetsFurnitureScrapSub', '${surl}', "formSub", assetsFurnitureScrapSubGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsFurnitureScrapSub_keyWord");
            },
            function (pid) {
                assetsFurnitureScrapSub.reLoad(pid);
            },
            searchMainNames,
            "assetsFurnitureScrapProc_keyWord");
        //主表操作
        //添加按钮绑定事件
        $('#assetsFurnitureScrapProc_insert').bind('click', function () {
            assetsFurnitureScrapProc.insert();
        });
        //编辑按钮绑定事件
        $('#assetsFurnitureScrapProc_modify').bind('click', function () {
            assetsFurnitureScrapProc.modify();
        });
        //删除按钮绑定事件
        $('#assetsFurnitureScrapProc_del').bind('click', function () {
            assetsFurnitureScrapProc.del();
        });
        //打开高级查询框
        $('#assetsFurnitureScrapProc_searchAll').bind('click', function () {
            assetsFurnitureScrapProc.openSearchForm(this, $('#assetsFurnitureScrapProc'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsFurnitureScrapProc_searchPart').bind('click', function () {
            assetsFurnitureScrapProc.searchByKeyWord();
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsFurnitureScrapProc.initWorkFlow($(this).val());
        });
        //子表操作
        //打开高级查询
        $('#assetsFurnitureScrapSub_searchAll').bind('click', function () {
            assetsFurnitureScrapSub.openSearchForm(this, $('#assetsFurnitureScrapSub'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsFurnitureScrapSub_searchPart').bind('click', function () {
            assetsFurnitureScrapSub.searchByKeyWord();
        });

        $('#createdByPersonAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'createdByPerson', textFiled: 'createdByPersonAlias'});
            this.blur();
            nullInput(e);
        });
        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });

        $('#ownerIdAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerIdSub', textFiled: 'ownerIdAliasSub'});
            this.blur();
            nullInput(e);
        });

        $('#ownerDeptAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDeptSub', textFiled: 'ownerDeptAliasSub'});
            this.blur();
            nullInput(e);
        });
        $('#userIdAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'userIdSub', textFiled: 'userIdAliasSub'});
            this.blur();
            nullInput(e);
        });

        $('#userDeptAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'userDeptSub', textFiled: 'userDeptAliasSub'});
            this.blur();
            nullInput(e);
        });

    });

</script>
<script src="avicit/assets/furniture/assetsfurniturescrapproc/js/AssetsFurnitureScrapProc.js"
        type="text/javascript"></script>
<script src="avicit/assets/furniture/assetsfurniturescrapproc/js/AssetsFurnitureScrapSub.js"
        type="text/javascript"></script>
</html>