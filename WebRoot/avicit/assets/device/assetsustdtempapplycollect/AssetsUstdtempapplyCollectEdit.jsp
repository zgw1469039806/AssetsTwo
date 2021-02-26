<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsustdtempapplycollect/assetsUstdtempapplyCollectController/operation/Edit/id" -->
    <title>编辑</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsUstdtempapplyCollectDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsUstdtempapplyCollectDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByPersionAlias">申购人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="attribute05" name="attribute05"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.attribute05}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersionAlias"
                               name="createdByPersionAlias"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.createdByPersionAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-user"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               name="createdByDeptAlias"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.createdByDeptAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByTel">申请人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.createdByTel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.deviceName}'/>"/>
                </td>


            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceCategory">设备类别:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title=""
                                  isNull="true" lookupCode="DEVICE_CATEGORY"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.deviceCategory}'/>
                </td>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="financialEstimate">经费概算:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="financialEstimate" id="financialEstimate"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.financialEstimate}'/>"
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
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="financialResources">经费来源:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources"
                                  title="" isNull="true" lookupCode="FINANCIAL_RESOURCES"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.financialResources}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="belongProject">所属项目:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="belongProject" id="belongProject"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.belongProject}'/>"/>
                </td>

            </tr>






            <tr>



                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="replyName">批复名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="replyName" id="replyName"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.replyName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="approvalFormNumber">立项单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="approvalFormNumber" id="approvalFormNumber"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.approvalFormNumber}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word; display:none">
                    <label for="headerId">主表id:</label></th>
                <td width="15%" style="display: none">
                    <input class="form-control input-sm" type="text" name="headerId" id="headerId"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.headerId}'/>"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar"
         class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                       title="保存" id="assetsUstdtempapplyCollect_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsUstdtempapplyCollect_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/assets/device/assetsustdtempapplycollect/js/AssetsUstdtempapplyCollect.js"></script>
<script type="text/javascript">
    function closeForm() {
        var closewindow = window.parent.document.getElementsByClassName("layui-layer-ico layui-layer-close layui-layer-close1");
        closewindow[0].click();
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
        //限制保存按钮多次点击
        $('#assetsUstdtempapplyCollect_saveForm').addClass('disabled');
        save($('#form'), "eidt");
    }

    $(document).ready(function () {
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
        });

       // parent.assetsUstdtempapplyCollect.formValidate($('#form'));
        //保存按钮绑定事件
        $('#assetsUstdtempapplyCollect_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsUstdtempapplyCollect_closeForm').bind('click', function () {
            closeForm();
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
        $('#createdByPersionAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'attribute05', textFiled: 'createdByPersionAlias'});
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


        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>