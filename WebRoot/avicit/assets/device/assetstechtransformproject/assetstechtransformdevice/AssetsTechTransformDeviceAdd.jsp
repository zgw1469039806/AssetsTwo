<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetstechtransformdevice/assetsTechTransformDeviceController/operation/Add/null" -->
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<style type="text/css">
    th {
        text-align: left;
    }
    .form_commonTable{
        border-spacing: 0;
    }
    .form_commonTable tr.commonTableTr th {
        text-align: left;
        background-color: rgba(228, 228, 228, 1);
        border-bottom: 2px solid #ffffff;
        padding: 0 5px;
    }
</style>

<body class="easyui-layout" fit="true">
    <div data-options="region:'center',split:true,border:false">
        <form id='form'>
            <input type="hidden" name="id"/>
            <input type="hidden" name="projectId" id="projectId"/>
            <input type="hidden" name="parentId"  id="parentId" />

            <table class="form_commonTable">
                <tr class="commonTableTr">
                    <th width="10%">
                        <label for="deviceName">设备名称:</label></th>
                    <td width="15%">
                        <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                    </td>

                    <th width="10%">
                        <label for="isEntity">是否为实体:</label></th>
                    <td width="15%">
                        <pt6:h5select css_class="form-control input-sm" name="isEntity" id="isEntity" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                    </td>

                    <th width="10%">
                        <label for="nation">国别:</label></th>
                    <td width="15%">
                        <input class="form-control input-sm" type="text" name="nation" id="nation"/>
                    </td>

                    <th width="10%">
                        <label for="singleOrSet">单位（台/套）:</label></th>
                    <td width="15%">
                        <pt6:h5select css_class="form-control input-sm" name="singleOrSet" id="singleOrSet" isNull="true" lookupCode="SINGLE_OR_SET"/>
                    </td>
                </tr>

                <tr class="commonTableTr">
                    <th width="10%">
                        <label for="unitPrice">单价:</label></th>
                    <td width="15%">
                        <div class="input-group input-group-sm spinner" data-trigger="spinner">
                            <input class="form-control" type="text" name="unitPrice" id="unitPrice" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                                   data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3" onchange="inputChange()">
                            <span class="input-group-addon">
                                <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
                                <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
                            </span>
                        </div>
                    </td>

                    <th width="10%">
                        <label for="amount">数量:</label></th>
                    <td width="15%">
                        <div class="input-group input-group-sm spinner" data-trigger="spinner">
                            <input class="form-control" type="text" name="amount" id="amount" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                                   data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0" onchange="inputChange()">
                            <span class="input-group-addon">
                                <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
                                <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
                            </span>
                        </div>
                    </td>

                    <th width="10%">
                        <label for="total">合计:</label></th>
                    <td width="15%">
                        <div class="input-group input-group-sm spinner" data-trigger="spinner">
                            <input class="form-control" type="text" name="total" id="total" readonly>
                        </div>
                    </td>

                    <th width="10%">
                        <label for="foreignExchange">外汇:</label></th>
                    <td width="15%">
                        <div class="input-group input-group-sm spinner" data-trigger="spinner">
                            <input class="form-control" type="text" name="foreignExchange" id="foreignExchange" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                                   data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                            <span class="input-group-addon">
                                <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
                                <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
                            </span>
                        </div>
                    </td>
                </tr>

                <tr class="commonTableTr">
                    <th width="10%">
                        <label for="technicalRequirement">主要技术（性能）指标或规格要求:</label></th>
                    <td width="90%" colspan="7">
                        <textarea class="form-control input-sm" rows="3" name="technicalRequirement" id="technicalRequirement"></textarea>
                    </td>
                </tr>

                <tr class="commonTableTr">
                    <th width="10%">
                        <label for="biddingSituation">招标情况:</label></th>
                    <td width="90%" colspan="7">
                        <textarea class="form-control input-sm" rows="3" name="biddingSituation" id="biddingSituation"></textarea>
                    </td>
                </tr>

                <tr class="commonTableTr">
                    <th width="10%">
                        <label for="remarks">备注:</label></th>
                    <td width="90%" colspan="7">
                        <textarea class="form-control input-sm" rows="3" name="remarks" id="remarks"></textarea>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'south',border:false" style="height: 60px;">
        <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
            <table class="tableForm" style="border:0;cellspacing:1;width:100%">
                <tr>
                    <td width="50%" style="padding-right:4%;" align="right">
                        <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                           title="保存" id="assetsTechTransformDevice_saveForm">保存</a>
                        <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                           id="assetsTechTransformDevice_closeForm">返回</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

    <script type="text/javascript">
        function closeForm() {
            parent.assetsTechTransformDevice.closeDialog("insert");
        }

        function saveForm() {
            var isValidate = $("#form").validate();
            if (!isValidate.checkForm()) {
                isValidate.showErrors();
                $(isValidate.errorList[0].element).focus();
                return false;
            }
            //限制保存按钮多次点击
            $('#assetsTechTransformDevice_saveForm').addClass('disabled').unbind("click");
            parent.assetsTechTransformDevice.save($('#form'), "insert");
        }

        //监控单价和数量输入框的变化
        function inputChange(){
            var unitPrice = document.getElementById('unitPrice').value;
            var amount = document.getElementById('amount').value;

            if(((unitPrice != null) && (unitPrice != undefined) && (unitPrice != "")) && ((amount != null) && (amount != undefined) && (amount != ""))){
                document.getElementById('total').value = unitPrice*amount;
            }
        }

        $(document).ready(function () {
            document.getElementById('projectId').value = '${projectId}';
            document.getElementById('parentId').value = '${parentId}';

            $('.date-picker').datepicker();
            $('.time-picker').datetimepicker({
                oneLine: true,//单行显示时分秒
                closeText: '确定',//关闭按钮文案
                showButtonPanel: true,//是否展示功能按钮面板
                showSecond: false,//是否可以选择秒，默认否
                beforeShow: function (selectedDate) {
                    if ($('#' + selectedDate.id).val() == "") {
                        $(this).datetimepicker("setDate", new Date());
                        $('#' + selectedDate.id).val('');
                    }
                }
            });

            parent.assetsTechTransformDevice.formValidate($('#form'));

            //保存按钮绑定事件
            $('#assetsTechTransformDevice_saveForm').bind('click', function () {
                saveForm();
            });

            //返回按钮绑定事件
            $('#assetsTechTransformDevice_closeForm').bind('click', function () {
                closeForm();
            });

            $('.date-picker').on('keydown', nullInput);
            $('.time-picker').on('keydown', nullInput);
        });
    </script>
</body>
</html>