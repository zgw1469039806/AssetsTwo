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
    <!-- ControllerPath = "assets/device/assetsoperationcertificate/assetsOperationCertificateController/toAssetsOperationCertificateManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div id="panelnorth"
    data-options="region:'north',onResize:function(a){$('#assetsOperationCertificate').setGridWidth(a);$('#assetsOperationCertificate').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
    <div id="toolbar_assetsOperationCertificate" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsOperationCertificate_button_add"
                                   permissionDes="主表添加">
                <a id="assetsOperationCertificate_insert" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i>
                    添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsOperationCertificate_button_edit"
                                   permissionDes="主表编辑">
                <a id="assetsOperationCertificate_modify" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="编辑"><i
                        class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsOperationCertificate_button_delete"
                                   permissionDes="主表删除">
                <a id="assetsOperationCertificate_del" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i>
                    删除</a>
            </sec:accesscontrollist>
        </div>
        <div class="toolbar-right">
            <div class="input-group form-tool-search" style="width:240px">
                <input type="text" name="assetsOperationCertificate_keyWord" id="assetsOperationCertificate_keyWord"
                       style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsOperationCertificate_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsOperationCertificate_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button">高级查询 <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="assetsOperationCertificate"></table>
    <div id="assetsOperationCertificatePager"></div>
</div>
<div id="centerpanel"
    data-options="region:'center',split:true,onResize:function(a){$('#assetsOperationDevice').setGridWidth(a);$('#assetsOperationDevice').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
    <div id="toolbar_assetsOperationDevice" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsOperationDevice_button_add"
                                   permissionDes="子表添加">
                <a id="assetsOperationDevice_insert" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i>
                    添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsOperationDevice_button_edit"
                                   permissionDes="子表编辑">
                <a id="assetsOperationDevice_modify" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="编辑"><i
                        class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsOperationDevice_button_delete"
                                   permissionDes="子表删除">
                <a id="assetsOperationDevice_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
            </sec:accesscontrollist>
        </div>
        <div class="toolbar-right">
            <div class="input-group form-tool-search" style="width:240px">
                <input type="text" name="assetsOperationDevice_keyWord" id="assetsOperationDevice_keyWord"
                       style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsOperationDevice_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsOperationDevice_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button">高级查询 <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="assetsOperationDevice"></table>
    <div id="assetsOperationDevicePager"></div>
</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <table class="form_commonTable">
            <tr>
                <th width="10%">操作证名称:</th>
                <td width="15%">
                    <input title="操作证名称" class="form-control input-sm" type="text" name="certificateName"
                           id="certificateName"/>
                </td>
                <th width="10%">操作证编号:</th>
                <td width="15%">
                    <input title="操作证编号" class="form-control input-sm" type="text" name="certificateNum"
                           id="certificateNum"/>
                </td>
                <th width="10%">操作证类型:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="certificateType" id="certificateType"
                                  title="操作证类型" isNull="true" lookupCode="CERTIFICATE_TYPE"/>
                </td>
                <th width="10%">操作证状态:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="certificateStatus" id="certificateStatus"
                                  title="操作证状态" isNull="true" lookupCode="CERTIFICATE_STATUS"/>
                </td>
            </tr>
            <tr>
                <th width="10%">操作证设备数量:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="certificateDeviceCount"
                               id="certificateDeviceCount" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">操作证描述:</th>
                <td width="15%">
                    <input title="操作证描述" class="form-control input-sm" type="text" name="certificateInfo"
                           id="certificateInfo"/>
                </td>
                <th width="10%">持证人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="holderId" name="holderId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="holderIdAlias"
                               name="holderIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">持证人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="holderDept" name="holderDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="holderDeptAlias"
                               name="holderDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">持证人联系方式:</th>
                <td width="15%">
                    <input title="持证人联系方式" class="form-control input-sm" type="text" name="holderPhone"
                           id="holderPhone"/>
                </td>
                <th width="10%">发证部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="managerDept" name="managerDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="managerDeptAlias"
                               name="managerDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">发证人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="managerId" name="managerId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="managerIdAlias"
                               name="managerIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">发证日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateBegin"
                               id="createdDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">发证日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateEnd" id="createdDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <%--<th width="10%">序号:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="序号" class="form-control input-sm" type="text" name="serialNumber" id="serialNumber"/>--%>
                <%--</td>--%>
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
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <%--<th width="10%">设备id:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="设备id" class="form-control input-sm" type="text" name="deviceId" id="deviceId"/>--%>
                <%--</td>--%>
                <th width="10%">设备型号:</th>
                <td width="15%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
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
            </tr>
            <tr>

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
                <th width="10%">安装位置:</th>
                <td width="15%">
                    <input title="安装位置" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
                <th width="10%">有效期(天):</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="validPeriod" id="validPeriod"
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
                <th width="10%">生效日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="beginDateBegin" id="beginDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>

                <th width="10%">生效日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="beginDateEnd" id="beginDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">失效日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="endDateBegin" id="endDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">失效日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="endDateEnd" id="endDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <%--<tr>--%>
                <%--<th width="10%">序号:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="序号" class="form-control input-sm" type="text" name="serialNumber" id="serialNumber"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/device/assetsoperationcertificate/js/AssetsOperationCertificate.js"
        type="text/javascript"></script>
<script src="avicit/assets/device/assetsoperationcertificate/js/AssetsOperationDevice.js"
        type="text/javascript"></script>
<script type="text/javascript">
    var assetsOperationCertificate;
    var assetsOperationDevice;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsOperationCertificate.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsOperationCertificate.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    $(document).ready(function () {
        var searchMainNames = new Array();
        var searchMainTips = new Array();
        searchMainNames.push("certificateName");
        searchMainTips.push("操作证名称");
        searchMainNames.push("certificateNum");
        searchMainTips.push("操作证编号");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#assetsOperationCertificate_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        var searchSubNames = new Array();
        var searchSubTips = new Array();
        searchSubNames.push("deviceName");
        searchSubTips.push("设备名称");
        searchSubNames.push("unifiedId");
        searchSubTips.push("统一编号");
        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
        $('#assetsOperationDevice_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        var assetsOperationCertificateGridColModel = [
            {label: '序号', name: 'serialNumber', width: 150}
            , {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '操作证名称', name: 'certificateName', width: 150}
            , {label: '操作证编号', name: 'certificateNum', width: 150}
            , {label: '操作证类型', name: 'certificateType', width: 150}
            , {label: '操作证状态', name: 'certificateStatus', width: 150}
            , {label: '操作证设备数量', name: 'certificateDeviceCount', width: 150}
            , {label: '操作证描述', name: 'certificateInfo', width: 150}
            , {label: '持证人', name: 'holderIdAlias', width: 150}
            , {label: '持证人部门', name: 'holderDeptAlias', width: 150}
            , {label: '持证人联系方式', name: 'holderPhone', width: 150}
            , {label: '发证部门', name: 'managerDeptAlias', width: 150}
            , {label: '发证人', name: 'managerIdAlias', width: 150}
            , {label: '发证日期', name: 'createdDate', width: 150, formatter: format}

        ];
        var assetsOperationDeviceGridColModel = [
            {label: '序号', name: 'serialNumber', width: 150}
            , {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '设备id', name: 'deviceId', width: 150, hidden: true}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '责任人', name: 'ownerIdAlias', width: 150}
            , {label: '责任人部门', name: 'ownerDeptAlias', width: 150}
            , {label: '安装位置', name: 'positionId', width: 150}
            , {label: '有效期(天)', name: 'validPeriod', width: 150}
            , {label: '生效日期', name: 'beginDate', width: 150, formatter: format}
            , {label: '失效日期', name: 'endDate', width: 150, formatter: format}

        ];

        assetsOperationCertificate = new AssetsOperationCertificate('assetsOperationCertificate', '${url}', 'form', assetsOperationCertificateGridColModel, 'searchDialog',
            function (pid) {
                assetsOperationDevice = new AssetsOperationDevice('assetsOperationDevice', '${surl}', "formSub", assetsOperationDeviceGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsOperationDevice_keyWord");
            },
            function (pid) {
                assetsOperationDevice.reLoad(pid);
            },
            searchMainNames,
            "assetsOperationCertificate_keyWord");
        //主表操作
        //添加按钮绑定事件
        $('#assetsOperationCertificate_insert').bind('click', function () {
            assetsOperationCertificate.insert();
        });
        //编辑按钮绑定事件
        $('#assetsOperationCertificate_modify').bind('click', function () {
            assetsOperationCertificate.modify();
        });
        //删除按钮绑定事件
        $('#assetsOperationCertificate_del').bind('click', function () {
            assetsOperationCertificate.del();
        });
        //打开高级查询框
        $('#assetsOperationCertificate_searchAll').bind('click', function () {
            assetsOperationCertificate.openSearchForm(this, $('#assetsOperationCertificate'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsOperationCertificate_searchPart').bind('click', function () {
            assetsOperationCertificate.searchByKeyWord();
        });
        //子表操作
        //添加按钮绑定事件
        $('#assetsOperationDevice_insert').bind('click', function () {
            assetsOperationDevice.insert(assetsOperationCertificate.getSelectID());
        });
        //编辑按钮绑定事件
        $('#assetsOperationDevice_modify').bind('click', function () {
            assetsOperationDevice.modify();
        });
        //删除按钮绑定事件
        $('#assetsOperationDevice_del').bind('click', function () {
            assetsOperationDevice.del();
        });
        //打开高级查询
        $('#assetsOperationDevice_searchAll').bind('click', function () {
            assetsOperationDevice.openSearchForm(this, $('#assetsOperationDevice'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsOperationDevice_searchPart').bind('click', function () {
            assetsOperationDevice.searchByKeyWord();
        });

        $('#holderIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'holderId', textFiled: 'holderIdAlias'});
            this.blur();
        });
        $('#holderDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'holderDept', textFiled: 'holderDeptAlias'});
            this.blur();
        });
        $('#managerDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'managerDept', textFiled: 'managerDeptAlias'});
            this.blur();
        });
        $('#managerIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'managerId', textFiled: 'managerIdAlias'});
            this.blur();
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

    });

</script>
</html>