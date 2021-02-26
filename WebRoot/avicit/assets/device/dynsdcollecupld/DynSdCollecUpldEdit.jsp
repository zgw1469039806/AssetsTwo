<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/dynsdcollecupld/dynSdCollecUpldController/operation/Edit/id" -->
    <title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${dynSdCollecUpldDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${dynSdCollecUpldDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="authorAlias">上报人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="author" name="author"
                               value="<c:out  value='${dynSdCollecUpldDTO.author}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" name="authorAlias"
                               value="<c:out  value='${dynSdCollecUpldDTO.authorAlias}'/>">
                        <span class="input-group-addon">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="releasedate">上报日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedate" id="releasedate"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${dynSdCollecUpldDTO.releasedate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deptAlias">上报单位:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="dept" name="dept" value="<c:out  value='${dynSdCollecUpldDTO.dept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" name="deptAlias"
                               value="<c:out  value='${dynSdCollecUpldDTO.deptAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="tel">电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="tel" id="tel"
                           value="<c:out  value='${dynSdCollecUpldDTO.tel}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="collectSelect">关联征集单:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="collectSelect" id="collectSelect"
                           value="<c:out  value='${dynSdCollecUpldDTO.collectSelect}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="collectYear">年度:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="collectYear" id="collectYear"
                           value="<c:out  value='${dynSdCollecUpldDTO.collectYear}'/>"/>
                </td>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="3">
                    <div id="attachment"></div>
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
                       title="保存" id="dynSdCollecUpld_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="dynSdCollecUpld_closeForm">返回</a>
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
        parent.dynSdCollecUpld.closeDialog(window.name);
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
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
        $('#dynSdCollecUpld_saveForm').addClass('disabled');
        parent.dynSdCollecUpld.save($('#form'), window.name, callback);
    }

    //附件操作
    function callback(id) {
        var files = $('#attachment').uploaderExt('getUploadFiles');
        if (files == 0) {
            closeForm();
        } else {
            $("#id").val(id);
            $('#attachment').uploaderExt('doUpload', id);
        }
    }//上传附件完成后操作
    function afterUploadEvent() {
        closeForm();
    }

    /**
     * 加载完后初始化
     */
    $(document).ready(function () {
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
        });
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${dynSdCollecUpldDTO.id}',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: afterUploadEvent
        });
        //绑定表单验证规则
        parent.dynSdCollecUpld.formValidate($('#form'));
        //保存按钮绑定事件
        $('#dynSdCollecUpld_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#dynSdCollecUpld_closeForm').bind('click', function () {
            closeForm();
        });

        $('#authorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'author', textFiled: 'authorAlias'});
            this.blur();
            nullInput(e);
        });
        $('#deptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'dept', textFiled: 'deptAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>