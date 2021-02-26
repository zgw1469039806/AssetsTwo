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
    <!-- ControllerPath = "assets/device/assetstdeviceupgradeproc/assetsTdeviceUpgradeProcController/toAssetsTdeviceUpgradeProcManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceUpgradeProc_button_add"
                               permissionDes="添加">
            <a id="assetsTdeviceUpgradeProc_insert" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceUpgradeProc_button_edit"
                               permissionDes="编辑">
            <a id="assetsTdeviceUpgradeProc_modify" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑" style="display:none;"><i
                    class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceUpgradeProc_button_delete"
                               permissionDes="删除">
            <a id="assetsTdeviceUpgradeProc_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
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
            <input type="text" name="assetsTdeviceUpgradeProc_keyWord" id="assetsTdeviceUpgradeProc_keyWord"
                   style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsTdeviceUpgradeProc_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsTdeviceUpgradeProc_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
               role="button">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsTdeviceUpgradeProcjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
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
                <th width="10%">单据状态:</th>
                <td width="15%">
                    <input title="单据状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
                </td>
            </tr>
            <tr>
                <th width="10%">流程名称:</th>
                <td width="15%">
                    <input title="流程名称" class="form-control input-sm" type="text" name="procName" id="procName"/>
                </td>
                <th width="10%">流程ID:</th>
                <td width="15%">
                    <input title="流程ID" class="form-control input-sm" type="text" name="procId" id="procId"/>
                </td>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备类别:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory"
                                  title="设备类别" isNull="true" lookupCode="DEVICE_CATEGORY"/>
                </td>
                <th width="10%">设备规格:</th>
                <td width="15%">
                    <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
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
                <th width="10%">出厂编号:</th>
                <td width="15%">
                    <input title="出厂编号" class="form-control input-sm" type="text" name="productNum" id="productNum"/>
                </td>
                <th width="10%">出厂日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="productDateBegin"
                               id="productDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">出厂日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="productDateEnd" id="productDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
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
                <th width="10%">升级内容及理由:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="升级内容及理由" name="upgradeReason"
                              id="upgradeReason"></textarea>
                </td>
                <th width="10%">升级过程:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="升级过程" name="upgradeProcess"
                              id="upgradeProcess"></textarea>
                </td>
            </tr>
            <tr>
                <th width="10%">备注:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="备注" name="remarks" id="remarks"></textarea>
                </td>
                <th width="10%">适用产品机型:</th>
                <td width="15%">
                    <input title="适用产品机型" class="form-control input-sm" type="text" name="planeModel" id="planeModel"/>
                </td>
                <th width="10%">适用产品名称:</th>
                <td width="15%">
                    <input title="适用产品名称" class="form-control input-sm" type="text" name="productName"
                           id="productName"/>
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
<!-- 业务的js -->
<script src="avicit/assets/device/assetstdeviceupgradeproc/js/AssetsTdeviceUpgradeProc.js"
        type="text/javascript"></script>
<script type="text/javascript">
    var assetsTdeviceUpgradeProc;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsTdeviceUpgradeProc.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsTdeviceUpgradeProc.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsTdeviceUpgradeProc.reLoad();
    };
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            // , {label: '流程名称', name: 'procName', width: 150}
            , {label: '升级单号', name: 'procId', width: 150, formatter: formatValue}
            , {label: '统一编号', name: 'unifiedId', width: 150, formatter: formatValue}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备类别', name: 'deviceCategory', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '立卡日期', name: 'createdDate', width: 150, formatter: format}
            , {label: '安装地点ID', name: 'positionId', width: 150}
            , {label: '申请人', name: 'createdByPersonAlias', width: 150}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '申请人电话', name: 'createdByTel', width: 150}
            // , {label: '出厂编号', name: 'productNum', width: 150}
            // , {label: '出厂日期', name: 'productDate', width: 150, formatter: format}
            // , {label: '责任人', name: 'ownerIdAlias', width: 150}
            // , {label: '责任人部门', name: 'ownerDeptAlias', width: 150}
            // , {label: '升级内容及理由', name: 'upgradeReason', width: 150}
            // , {label: '升级过程', name: 'upgradeProcess', width: 150}
            // , {label: '备注', name: 'remarks', width: 150}
            , {label: '适用产品机型', name: 'planeModel', width: 150}
            , {label: '适用产品名称', name: 'productName', width: 150}
            // , {label: '单据状态', name: 'formState', width: 150}
            <sec:accesscontrollist hasPermission="3" domainObject="assetsTdeviceUpgradeProc_table_activityalias" permissionDes="流程当前步骤">
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="assetsTdeviceUpgradeProc_table_businessstate" permissionDes="流程状态">
            , {label: '流程状态', name: 'businessstate_', width: 150}
            </sec:accesscontrollist>
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("procId");
        searchTips.push("升级单号");
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsTdeviceUpgradeProc_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsTdeviceUpgradeProc = new AssetsTdeviceUpgradeProc('assetsTdeviceUpgradeProcjqGrid', '${url}', 'searchDialog', 'form', 'assetsTdeviceUpgradeProc_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsTdeviceUpgradeProc_insert').bind('click', function () {
            assetsTdeviceUpgradeProc.insert();
        });
        //编辑按钮绑定事件
        $('#assetsTdeviceUpgradeProc_modify').bind('click', function () {
            assetsTdeviceUpgradeProc.modify();
        });
        //删除按钮绑定事件
        $('#assetsTdeviceUpgradeProc_del').bind('click', function () {
            assetsTdeviceUpgradeProc.del();
        });
        //查询按钮绑定事件
        $('#assetsTdeviceUpgradeProc_searchPart').bind('click', function () {
            assetsTdeviceUpgradeProc.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsTdeviceUpgradeProc_searchAll').bind('click', function () {
            assetsTdeviceUpgradeProc.openSearchForm(this, 800, 400);
        });
        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsTdeviceUpgradeProc.initWorkFlow($(this).val());
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

    });

</script>
</html>