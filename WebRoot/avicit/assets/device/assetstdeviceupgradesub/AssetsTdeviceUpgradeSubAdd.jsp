<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,fileupload";
    String comId = request.getParameter("comId");
    String unifiedId = request.getParameter("unifiedId");
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<head>
    <!-- ControllerPath = "demo/demoreception/demoReceptionController/operation/Add/null" -->
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="softwareName">软件名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareName" id="softwareName"/>
                </td>
                <th width="10%">
                    <label for="softwareBasicName">软件简称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareBasicName" id="softwareBasicName"/>
                </td>
                <th width="10%">
                    <label for="softwareId">CSCI标识:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareId" id="softwareId"/>
                </td>
                <th width="10%">
                    <label for="softwareCode">软件代号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareCode" id="softwareCode"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="softwareVersion">原软件版本:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareVersion" id="softwareVersion"/>
                </td>
                <th width="10%">
                    <label for="softwareVersionNew">升级软件版本:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareVersionNew" id="softwareVersionNew"/>
                </td>
                <th width="10%">
                    <label for="softwareReleaseNum">软件发布号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareReleaseNum" id="softwareReleaseNum"/>
                </td>
                <th width="10%">
                    <label for="softwarePeriod">研制阶段:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="softwarePeriod" id="softwarePeriod" title=""
                                  isNull="true" lookupCode="DEVELOPMENT_PERIOD"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="softwareCodeSize">代码规模:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="softwareCodeSize" id="softwareCodeSize"
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
                        <input type="hidden" id="softwareLeader" name="softwareLeader">
                        <input class="form-control" placeholder="请选择用户" type="text" id="softwareLeaderAlias"
                               name="softwareLeaderAlias">
                        <span class="input-group-addon" id="userbtn">
                              <i class="glyphicon glyphicon-user"></i>
                          </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="softwareLanguage">编码语言:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareLanguage" id="softwareLanguage"/>
                </td>
                <th width="10%">
                    <label for="softwareRunEnvironment">运行环境:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareRunEnvironment"
                           id="softwareRunEnvironment"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="softwareDevEnvironment">开发环境:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareDevEnvironment"
                           id="softwareDevEnvironment"/>
                </td>
            </tr>
            <%--<tr>--%>
                <%--<th width="10%">--%>
                    <%--<label for="remarks">备注:</label></th>--%>
                <%--<td width="90%" colspan="7">--%>
                    <%--<textarea class="form-control input-sm" rows="5" name="remarks" id="remarks"></textarea>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <th width="10%">
                    <label for="upgradeInfo">升级说明:</label></th>
                <td width="90%" colspan="7">
                    <textarea class="form-control input-sm" rows="5" name="upgradeInfo" id="upgradeInfo"></textarea>
                </td>
            </tr>
            <tr>

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
                    <input class="form-control input-sm" type="text" name="tdeviceForeign" id="tdeviceForeign" value="<%=comId%>"/>
                </td>

                <th width="10%">
                    <label for="attachementName">附件名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="attachementName" id="attachementName"/>
                </td>
                <th width="10%">
                    <label for="attachementUrl">附件地址:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="attachementUrl" id="attachementUrl" />
                </td>
            </tr>
            <tr style="display: none">
                <th width="10%">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
                <th width="10%">
                    <label for="tdeviceSoftwareId" >软件台账ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="tdeviceSoftwareId" id="tdeviceSoftwareId" style="display: block;"/>
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
<%--<script src="avicit/assets/device/assetstdeviceupgradesub/js/uploader-ext.js" type="text/javascript"></script>--%>

<script type="text/javascript">
    $("#softwareName").on("click",function () {
        var unifiedId = "<%=unifiedId%>";
        var param =  JSON.stringify({unifiedId:unifiedId}); /* 筛选设备统一编号 */
        openProductModelLayer("callBackFn",param);
    })
    // 关闭Dialog
    function closeForm() {
        parent.assetsTdeviceUpgradeSub.closeDialog('insert');
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

    }

    //上传附件
    function callback(id) {
        var files = $('#attachment').uploaderExt('getUploadFiles');
        if (files == 0) {
            // closeForm();



        } else {
            $("#id").val(id);
            $('#attachment').uploaderExt('doUpload', id);
        }
    }

    //附件上传完后执行
    function afterUpload() {
        parent['callBackFnSoftware']();
        // $("#layui-layer-close1").click();
        // parent.assetsTdeviceUpgradeSub.closeDialog('insert');
    }

    /* 关闭弹窗 */
    function closeDialog(){
        var index = parent.layer.getFrameIndex(window.name);    //获取窗口索引
        parent.layer.close(index);  // 关闭layer
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
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: afterUpload
        });



        //保存按钮绑定事件
        $('#saveButton').bind('click', function () {
            save($('#form'));
            layer.load();
           //console.log(window.parent.parent.document.getElementById('DEVICE_NAME').value);
           //  $("#bpm_save",window.parent.document).click();
            var fileCount = $(".uploader-file-more").size();
            if(fileCount <= 0){
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


</script>
</body>
</html>