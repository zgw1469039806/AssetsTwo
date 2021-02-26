<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,form,fileupload";
    String formId  = request.getParameter("formId"); // 业务数据ID
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/assetsattachment/assetsAttachmentController/operation/Edit/id" -->
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
        <input type="hidden" name="version" value="<c:out  value='${assetsAttachmentDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsAttachmentDTO.id}'/>"/>
        <table class="form_commonTable">
            <%--<tr>--%>
                <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                    <%--<label for="assetsAttName">附件名称:</label></th>--%>
                <%--<td width="39%">--%>
                    <%--<input class="form-control input-sm" type="text" name="assetsAttName" id="assetsAttName"--%>
                           <%--value="<c:out  value='${assetsAttachmentDTO.assetsAttName}'/>"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=2 * 2 - 1%>">
                    <div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
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
                    <%--<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"--%>
                       <%--title="保存" id="assetsAttachment_saveForm">保存</a>--%>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsAttachment_closeForm">返回</a>
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
        parent.assetsAttachment.closeDialog(window.name);
    }

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
        $('#assetsAttachment_saveForm').addClass('disabled').unbind("click");
        parent.assetsAttachment.save($('#form'), window.name, callback);
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
            beforeShow: function (selectedDate) {
                if ($('#' + selectedDate.id).val() == "") {
                    $(this).datetimepicker("setDate", new Date());
                    $('#' + selectedDate.id).val('');
                }
            }
        });
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '<%=formId%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: afterUploadEvent,
            allowAdd:false,     //禁止添加附件
            allowUpload:false,  //禁止上传附件
            allowDelete:false,  //禁止删除附件
            collapsible:false,
            elementId:''
        });
        //绑定表单验证规则
        // parent.assetsAttachment.formValidate($('#form'));

        //保存按钮绑定事件
        $('#assetsAttachment_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsAttachment_closeForm').bind('click', function () {
            // closeForm();
            closeDialog();  //关闭对话框函数
        });


        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);

    });

    /* 关闭弹窗 */
    function closeDialog(){
        var index = parent.layer.getFrameIndex(window.name);    //获取窗口索引
        parent.layer.close(index);  // 关闭layer
    }

    /* 页面加载完成后调用 */
    window.onload=function (ev) {
       setTimeout(function () {
           var fileCount = $(".uploader-file-more").size(); //获取附件的数量
           if (fileCount < 1) {     //如果附件数量小于1，则提示消息，并关闭窗口
               parent.layer.msg("无附件！");    //父页面弹出消息，几秒后自动消失，如果不加parent则下面函数执行时会无法显示消息框
               closeDialog();       //调用上面的关闭弹窗函数
           }
       },500)
    }
</script>
</body>
</html>