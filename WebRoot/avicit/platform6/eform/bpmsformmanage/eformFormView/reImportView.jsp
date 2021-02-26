<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>上传xml</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='uploadForm' method="post" enctype="multipart/form-data" style="margin: 20px;">
        <input type="file" id="xmlFile" name="xmlFile" accept="text/xml" />
        <input type="hidden" id="formId" name="formId" value="${param.formId}" />
        <input type="hidden" id="currentVersion" name="currentVersion" value="${param.currentVersion}" />
        <input type="hidden" id="eformComponentId" name="eformComponentId" value="${param.eformComponentId}" />
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="closeForm">取消</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
<script type="text/javascript">
    document.ready = function () {

        $('#saveForm').bind('click', function () {
            if ($("#xmlFile").val() == "") {
                layer.msg('请添加要导入的XML文件！', {icon: 7});
            }
            else {
                $("#uploadForm").ajaxSubmit({
                    type : 'POST',
                    url : 'platform/eform/bpmsManageController/reImportViewXml',
                    dataType : 'text',
                    success : function(response) {
                        response = $.parseJSON(response);

                        if(response.status == "OK") {
                            var tb = parent.$('#' + parent.eformFormView.formViewDiv).find("#" + response.data.id);
                            tb.remove();
                            parent.eformFormView.setViewInfo(response.data);

                            parent.layer.msg('覆盖导入表单XML成功！', {icon: 1});

                            parent.eformFormView.closeDialog("upload");
                        }
                        else {
                            layer.msg(response.status, {icon: 2});
                            $("#saveForm").removeClass("disabled");
                        }
                        layer.close(index);
                    }
                });
            }
        });
        $('#closeForm').bind('click', function () {
            parent.eformFormView.closeDialog("upload");
        });
    };
</script>
</body>
</html>
