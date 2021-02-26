<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form";
    String callBackFnList = request.getParameter("callBackFnList");
    request.getParameter("callBackFnList");// 回调函数名称
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetssdequipcollect/assetsSdequipCollectController/operation/Edit/id" -->
    <title>编辑</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsSdequipCollectDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsSdequipCollectDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByPersionAlias">申购人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPersion" name="createdByPersion"
                               value="<c:out  value='${assetsSdequipCollectDTO.createdByPersion}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersionAlias"
                               name="createdByPersionAlias"
                               value="<c:out  value='${assetsSdequipCollectDTO.createdByPersionAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-user"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByDeptAlias">申购部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<c:out  value='${assetsSdequipCollectDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               name="createdByDeptAlias"
                               value="<c:out  value='${assetsSdequipCollectDTO.createdByDeptAlias}'/>">
                        <span class="input-group-addon">
							                 <i class="glyphicon glyphicon-equalizer"></i>
							              </span>
                    </div>
                </td>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           value="<c:out  value='${assetsSdequipCollectDTO.deviceName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceCategory">设备类别:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title=""
                                  isNull="true" lookupCode="DEVICE_CATEGORY"
                                  defaultValue='${assetsSdequipCollectDTO.deviceCategory}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="financialResources">经费来源</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="financialResources"
                                  id="financialResources" title="" isNull="true"
                                  lookupCode="FINANCIAL_RESOURCES"  defaultValue='${assetsSdequipCollectDTO.deviceType}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceModel">设备型号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"
                           value="<c:out  value='${assetsSdequipCollectDTO.deviceModel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceType">设备类型:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceType" id="deviceType" title=""
                                  isNull="true" lookupCode="DEVICE_TYPE"
                                  defaultValue='${assetsSdequipCollectDTO.deviceType}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceSpec">设备规格:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"
                           value="<c:out  value='${assetsSdequipCollectDTO.deviceSpec}'/>"/>
                </td>

            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="referencePlant">参考厂家:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="referencePlant" id="referencePlant"
                           value="<c:out  value='${assetsSdequipCollectDTO.referencePlant}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceNum">台（套）数:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="deviceNum" id="deviceNum"
                               value="<c:out  value='${assetsSdequipCollectDTO.deviceNum}'/>"
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
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="unitPrice">单价(元):</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice"
                               value="<c:out  value='${assetsSdequipCollectDTO.unitPrice}'/>"
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
                    <label for="totalPrice">总金额（元）:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalPrice" id="totalPrice"
                               value="<c:out  value='${assetsSdequipCollectDTO.totalPrice}'/>"
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
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar"
         class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存"
                       id="assetsSdequipCollect_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsSdequipCollect_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/device/dynsdcollecmain/js/AssetsSdequipCollect.js" type="text/javascript"></script>
<script type="text/javascript">
    function closeForm() {
        parent.assetsSdequipCollect.closeDialog("edit");
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
        //限制保存按钮多次点击
        $('#assetsSdequipCollect_saveForm').addClass('disabled');
        parent.assetsSdequipCollect.save($('#form'), "eidt");
    }

    document.ready = function () {
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
        });

        parent.assetsSdequipCollect.formValidate($('#form'));
        //保存按钮绑定事件
        $('#assetsSdequipCollect_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        /* $('#assetsSdequipCollect_closeForm').bind('click', function () {
             closeForm();
         });*/

        $('#createdByPersionAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'createdByPersion', textFiled: 'createdByPersionAlias'});
            this.blur();
            nullInput(e);
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
        $('#examineApproveEngineerAlias').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'examineApproveEngineer',
                textFiled: 'examineApproveEngineerAlias'
            });
            this.blur();
            nullInput(e);
        });
        $('#professionalAuditorAlias').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'professionalAuditor',
                textFiled: 'professionalAuditorAlias'
            });
            this.blur();
            nullInput(e);
        });
        $('#competentLeaderAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'competentLeader', textFiled: 'competentLeaderAlias'});
            this.blur();
            nullInput(e);
        });


        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    };




    $("#assetsSdequipCollect_closeForm").bind("click", function () {
        var closewindow = window.parent.document.getElementsByClassName("layui-layer-ico layui-layer-close layui-layer-close1");
        closewindow[0].click();
    });

    $("#assetsSdequipCollect_saveForm").on("click", function () {
        debugger;
        save($('#form'), "edit");
        parent["callBackFnList"]();
    })
</script>
</body>
</html>