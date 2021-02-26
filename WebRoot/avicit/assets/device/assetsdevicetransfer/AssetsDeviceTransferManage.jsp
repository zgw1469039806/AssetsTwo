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
    <!-- ControllerPath = "assets/device/assetsdevicetransfer/assetsDeviceTransferController/toAssetsDeviceTransferManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<!-- 下行height:fixheight(1)设置主子表子表不显示，主子表默认为fixheight(.5) -->
<div id="panelnorth"
     data-options="region:'north',height:fixheight(1),onResize:function(a){$('#assetsDeviceTransfer').setGridWidth(a);$('#assetsDeviceTransfer').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
    <div id="toolbar_assetsDeviceTransfer" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceTransfer_button_add"
                                   permissionDes="添加">
                <a id="assetsDeviceTransfer_insert" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i>
                    添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceTransfer_button_edit"
                                   permissionDes="编辑">
                <a id="assetsDeviceTransfer_modify" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="编辑"><i
                        class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceTransfer_button_delete"
                                   permissionDes="删除">
                <a id="assetsDeviceTransfer_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
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
                <input type="text" name="assetsDeviceTransfer_keyWord" id="assetsDeviceTransfer_keyWord"
                       style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsDeviceTransfer_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsDeviceTransfer_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button">高级查询 <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="assetsDeviceTransfer"></table>
    <div id="assetsDeviceTransferPager"></div>
</div>
<div id="centerpanel"
     data-options="region:'center',split:true,onResize:function(a){$('#assetsTransferprocDevice').setGridWidth(a); $('#assetsTransferprocDevice').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
    <div id="toolbar_assetsTransferprocDevice" class="toolbar">
        <div class="toolbar-right">
            <div class="input-group form-tool-search" style="width:125px">
                <input type="text" name="assetsTransferprocDevice_keyWord" id="assetsTransferprocDevice_keyWord"
                       style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsTransferprocDevice_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsTransferprocDevice_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button">高级查询 <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="assetsTransferprocDevice"></table>
    <div id="assetsTransferprocDevicePager"></div>
</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">移交单号:</th>
                <td width="15%">
                    <input title="移交单号" class="form-control input-sm" type="text" name="procId" id="procId"/>
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
                <th width="10%">接收人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="receiver" name="receiver">
                        <input class="form-control" placeholder="请选择用户" type="text" id="receiverAlias"
                               name="receiverAlias">
                        <span class="input-group-addon">
                            <i class="glyphicon glyphicon-user"></i>
                          </span>
                    </div>
                </td>
                <th width="10%">接收人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="receiverDept" name="receiverDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="receiverDeptAlias"
                               name="receiverDeptAlias">
                        <span class="input-group-addon">
                            <i class="glyphicon glyphicon-equalizer"></i>
                          </span>
                    </div>
                </td>
                <th width="10%">接收人电话:</th>
                <td width="15%">
                    <input title="接收人电话" class="form-control input-sm" type="text" name="receiverTel" id="receiverTel"/>
                </td>
                <th width="10%">接收安装地点ID:</th>
                <td width="15%">
                    <input title="接收安装地点ID" class="form-control input-sm" type="text" name="receivePositionId"
                           id="receivePositionId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">移交原因:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="移交原因" name="transferReason"
                              id="transferReason"></textarea>
                </td>
            </tr>
            <%--
            <tr>
                <th width="10%">单据状态:</th>
                <td width="15%">
                    <input title="单据状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
                </td>
                <th width="10%">流程名称:</th>
                <td width="15%">
                    <input title="流程名称" class="form-control input-sm" type="text" name="procName" id="procName"/>
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
                <th width="10%">资产编号:</th>
                <td width="15%">
                    <input title="资产编号" class="form-control input-sm" type="text" name="assetId" id="assetId"/>
                </td>
                <th width="10%">设备类别:</th>
                <td width="15%">
                    <input title="设备类别" class="form-control input-sm" type="text" name="deviceCategory"
                           id="deviceCategory"/>
                </td>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
                <th width="10%">设备型号:</th>
                <td width="15%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备规格:</th>
                <td width="15%">
                    <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
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
                <th width="10%">密级:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="密级"
                                  isNull="true" lookupCode="SECRET_LEVEL"/>
                </td>
                <th width="10%">是否统管设备:</th>
                <td width="15%">
                    <input title="是否统管设备" class="form-control input-sm" type="text" name="isManage" id="isManage"/>
                </td>
                <th width="10%">是否在流程中:</th>
                <td width="15%">
                    <input title="是否在流程中" class="form-control input-sm" type="text" name="isInWorkflow"
                           id="isInWorkflow"/>
                </td>
            </tr>
            <tr>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
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
<script src="avicit/assets/device/assetsdevicetransfer/js/AssetsDeviceTransfer.js" type="text/javascript"></script>
<script src="avicit/assets/device/assetsdevicetransfer/js/AssetsTransferprocDevice.js" type="text/javascript"></script>
<script type="text/javascript">
    var assetsDeviceTransfer;
    var assetsTransferprocDevice;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsDeviceTransfer.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsDeviceTransfer.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsDeviceTransfer.reLoad();
    };

    $(document).ready(function () {
        var searchMainNames = new Array();
        var searchMainTips = new Array();
        searchMainNames.push("procId");
        searchMainTips.push("移交单号");
        // searchMainNames.push("transferReason");
        // searchMainTips.push("移交原因");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#assetsDeviceTransfer_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#assetsDeviceTransfer_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);
        var searchSubNames = new Array();
        var searchSubTips = new Array();
        searchSubNames.push("assetId");
        searchSubTips.push("资产编号");
        searchSubNames.push("deviceCategory");
        searchSubTips.push("设备类别");
        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
        $('#assetsTransferprocDevice_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        $('#assetsTransferprocDevice_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);
        var assetsDeviceTransferGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '移交单号', name: 'procId', width: 150, formatter: formatValue}
            // , {label: '流程名称', name: 'procName', width: 150, formatter: formatValue}
            , {label: '申请人', name: 'createdByPersonAlias', width: 150}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '申请人电话', name: 'createdByTel', width: 150}
            , {label: '接收人', name: 'receiverAlias', width: 150}
            , {label: '接收人部门', name: 'receiverDeptAlias', width: 150}
            , {label: '接收人电话', name: 'receiverTel', width: 150}
            , {label: '接收安装地点ID', name: 'receivePositionId', width: 150}
            , {label: '移交原因', name: 'transferReason', width: 150}
            // , {label: '单据状态', name: 'formState', width: 150}
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            , {label: '流程状态', name: 'businessstate_', width: 150}
        ];
        var assetsTransferprocDeviceGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '资产编号', name: 'assetId', width: 150}
            , {label: '设备类别', name: 'deviceCategory', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '责任人', name: 'ownerIdAlias', width: 150}
            , {label: '责任人部门', name: 'ownerDeptAlias', width: 150}
            , {label: '使用人', name: 'userIdAlias', width: 150}
            , {label: '使用人部门', name: 'userDeptAlias', width: 150}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '立卡日期', name: 'createdDate', width: 150, formatter: format}
            , {label: '安装地点ID', name: 'positionId', width: 150}
            , {label: '密级', name: 'secretLevelName', width: 150}
            , {label: '是否统管设备', name: 'isManage', width: 150}
            , {label: '是否在流程中', name: 'isInWorkflow', width: 150}
            , {label: '统一编号', name: 'unifiedId', width: 150}
        ];
        assetsDeviceTransfer = new AssetsDeviceTransfer('assetsDeviceTransfer', '${url}', 'form', assetsDeviceTransferGridColModel, 'searchDialog',
            function (pid) {
                assetsTransferprocDevice = new AssetsTransferprocDevice('assetsTransferprocDevice', '${surl}', "formSub", assetsTransferprocDeviceGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsTransferprocDevice_keyWord");
            },
            function (pid) {
                assetsTransferprocDevice.reLoad(pid);
            },
            searchMainNames,
            "assetsDeviceTransfer_keyWord");
        //主表操作
        //添加按钮绑定事件
        $('#assetsDeviceTransfer_insert').bind('click', function () {
            assetsDeviceTransfer.insert();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceTransfer_modify').bind('click', function () {
            assetsDeviceTransfer.modify();
        });
        //删除按钮绑定事件
        $('#assetsDeviceTransfer_del').bind('click', function () {
            assetsDeviceTransfer.del();
        });
        //打开高级查询框
        $('#assetsDeviceTransfer_searchAll').bind('click', function () {
            assetsDeviceTransfer.openSearchForm(this, $('#assetsDeviceTransfer'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsDeviceTransfer_searchPart').bind('click', function () {
            assetsDeviceTransfer.searchByKeyWord();
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsDeviceTransfer.initWorkFlow($(this).val());
        });
        //子表操作
        //打开高级查询
        $('#assetsTransferprocDevice_searchAll').bind('click', function () {
            assetsTransferprocDevice.openSearchForm(this, $('#assetsTransferprocDevice'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsTransferprocDevice_searchPart').bind('click', function () {
            assetsTransferprocDevice.searchByKeyWord();
        });

        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#receiverAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'receiver', textFiled: 'receiverAlias'});
            this.blur();
            nullInput(e);
        });
        $('#receiverDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'receiverDept', textFiled: 'receiverDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#createdByPersonAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'createdByPerson', textFiled: 'createdByPersonAlias'});
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
</html>