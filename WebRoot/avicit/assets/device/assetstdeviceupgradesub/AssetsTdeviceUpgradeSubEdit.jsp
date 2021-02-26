<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<head>
    <title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- ControllerPath = "demo/demoreception/demoReceptionController/operation/Add/id" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsTdeviceUpgradeSubDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsTdeviceUpgradeSubDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="softwareName">软件名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareName" id="softwareName"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareName}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwareBasicName">软件简称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareBasicName" id="softwareBasicName"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareBasicName}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwareId">CSCI标识:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareId" id="softwareId"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareId}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwareCode">软件代号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareCode" id="softwareCode"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareCode}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="softwareVersion">原软件版本:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareVersion" id="softwareVersion"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareVersion}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwareVersionNew">升级软件版本:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareVersionNew" id="softwareVersionNew"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareVersionNew}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwareReleaseNum">软件发布号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareReleaseNum" id="softwareReleaseNum"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareReleaseNum}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwarePeriod">研制阶段:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="softwarePeriod" id="softwarePeriod" title=""
                                  isNull="true" lookupCode="DEVELOPMENT_PERIOD"
                                  defaultValue='${assetsTdeviceUpgradeSubDTO.softwarePeriod}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="softwareCodeSize">代码规模:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="softwareCodeSize" id="softwareCodeSize"
                               value="<c:out  value='${assetsTdeviceUpgradeSubDTO.softwareCodeSize}'/>"
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
                <th width="10%">
                    <label for="softwareLeaderAlias">软件负责人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="softwareLeader" name="softwareLeader"
                               value="<c:out  value='${assetsTdeviceUpgradeSubDTO.softwareLeader}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="softwareLeaderAlias"
                               name="softwareLeaderAlias"
                               value="<c:out  value='${assetsTdeviceUpgradeSubDTO.softwareLeaderAlias}'/>">
                        <span class="input-group-addon">
                            <i class="glyphicon glyphicon-user"></i>
                          </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="softwareLanguage">编码语言:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareLanguage" id="softwareLanguage"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareLanguage}'/>"/>
                </td>
                <th width="10%">
                    <label for="softwareRunEnvironment">运行环境:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareRunEnvironment"
                           id="softwareRunEnvironment"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareRunEnvironment}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="softwareDevEnvironment">开发环境:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareDevEnvironment"
                           id="softwareDevEnvironment"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.softwareDevEnvironment}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="upgradeInfo">升级说明:</label></th>
                <td width="90%"  colspan="7">
                    <textarea class="form-control input-sm" rows="5" name="upgradeInfo"
                              id="upgradeInfo">${assetsTdeviceUpgradeSubDTO.upgradeInfo}</textarea>
                </td>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=4 * 2 - 1%>">
                    <div id="attachment"></div>
                </td>
            </tr>
            <tr style="display: none">
                <th width="10%">
                    <label for="tdeviceForeign">子表外键:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="tdeviceForeign" id="tdeviceForeign"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.tdeviceForeign}'/>"/>
                </td>
                <th width="10%">
                    <label for="attachementUrl">附件地址:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="attachementUrl" id="attachementUrl"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.attachementUrl}'/>"/>
                </td>
                <th width="10%">
                    <label for="attachementName">附件名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="attachementName" id="attachementName"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.attachementName}'/>"/>
                </td>
            </tr>

            <tr style="display: none">
                <th width="10%">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.unifiedId}'/>"/>
                </td>
                <th width="10%">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.deviceName}'/>"/>
                </td>
                <th width="10%">
                    <label for="tdeviceSoftwareId">软件台账ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="tdeviceSoftwareId" id="tdeviceSoftwareId"
                           value="<c:out value='${assetsTdeviceUpgradeSubDTO.tdeviceSoftwareId}'/>"/>
                </td>
                <th width="10%">
                    <label for="remarks">备注:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" name="remarks"
                              id="remarks">${assetsTdeviceUpgradeSubDTO.remarks}</textarea>
                </td>
            </tr>
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height:60px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0);" title="保存" id="saveButton"
                       class="btn btn-primary form-tool-btn typeb btn-sm">保存</a>
                    <a href="javascript:void(0);" title="返回" id="returnButton"
                       class="btn btn-grey form-tool-btn btn-sm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/device/assetstdeviceupgradesub/js/AssetsTdeviceUpgradeSub.js" type="text/javascript"></script>

<script type="text/javascript">
    window.files = true;

    // 关闭Dialog
    function closeForm() {
        console.log(parent.assetsTdeviceUpgradeSub);
        // parent.assetsTdeviceUpgradeSub.closeDialog('edit');
    }

    // 保存表单
    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }

        //验证附件密级
        var files = $('#attachment').uploaderExt('getUploadFiles');
        for (var i = 0; i < files.length; i++) {
            var name = files[i].name;
            var secretLevel = files[i].secretLevel;
            //这里验证密级
        }
        //限制保存按钮多次点击
        // $('#saveButton').addClass('disabled').unbind("click");
        // parent.assetsTdeviceUpgradeSub.save($('#form'), callback);
    }

    //上传附件
    function callback(id) {
        window.files = false;
        var files = $('#attachment').uploaderExt('getUploadFiles'); //新增的附件的数量
        if (files == 0) {   //没有新增附件
            parent['callBackReload'](); //调用父页面js中的函数 callBackReload，刷新父页面的子表
            /* 关闭当前窗口 */
            var xEle = window.parent.document.getElementsByClassName('layui-layer-ico layui-layer-close layui-layer-close1');
            xEle[0].click();
        } else {
            $("#id").val(id);
            $('#attachment').uploaderExt('doUpload', id);
        }
    }

    //附件上传完后执行
    function afterUpload() {
        debugger;

        var xEle = window.parent.document.getElementsByClassName('layui-layer-ico layui-layer-close layui-layer-close1');
        xEle[0].click();
        // parent['callBackFnSoftware']();
        // parent.assetsTdeviceUpgradeSub.closeDialog('edit');
    }

    // 加载完后初始化
    $(document).ready(function () {
        //初始化日期控件
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
        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);

        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsTdeviceUpgradeSubDTO.id}',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: afterUpload
        });

        /* 关闭弹窗 */
        function closeDialog(){
            var index = parent.layer.getFrameIndex(window.name);    //获取窗口索引
            parent.layer.close(index);  // 关闭layer
        }

        //绑定表单验证规则
        // parent.assetsTdeviceUpgradeSub.formValidate($('#form'));

        //保存按钮绑定事件
        $('#saveButton').bind('click', function () {
            // saveForm();
            save($('#form'));
            layer.load();
            // console.log(window.parent.parent.document.getElementById('DEVICE_NAME').value);
            // $("#bpm_save",window.parent.document).click();

            if(window.files){
                parent['callBackReload'](); //调用js中的函数 callBackReload
                closeDialog();
                // var xEle = window.parent.document.getElementsByClassName('layui-layer-ico layui-layer-close layui-layer-close1');
                // xEle[0].click();
            }
        });

        //返回按钮绑定事件
        $('#returnButton').bind('click', function () {
            // closeForm();
            console.log(window.parent.parent.document.getElementById('DEVICE_NAME').value);
            closeDialog();
            // var xEle = window.parent.document.getElementsByClassName('layui-layer-ico layui-layer-close layui-layer-close1');
            // xEle[0].click();
        });

        $('#softwareLeaderAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'softwareLeader', textFiled: 'softwareLeaderAlias'});
            this.blur();
            nullInput(e);
        });

    });
// window.onload=function (ev) {
//    setTimeout(function () {
//        //定义一个变量
//        debugger;
//        var files = 0;
//        // document.cookie="files="+files;
//        //获取当前附件数量
//        var oldFiles = $(".uploader-file-more").size();
//        //当附件删除的时候记录一下
//        // $(".uploader-file-infos-delete").bind("click",function () {
//        //     $(".layui-layer-btn0").bind("click",function () {
//        //         var newFiles = $(".uploader-file-more").size();
//        //         if(newFiles<oldFiles){
//        //             files = newFiles;
//        //
//        //         }
//        //     })
//        //
//        // });
//        sessionStorage.setItem("files",files);
//    },500)
// }
</script>
</body>
</html>