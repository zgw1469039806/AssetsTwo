<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='addForm'>
        <input type="hidden" id="componentId" name="componentId">

        <table class="form_commonTable">
            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formName">名称：</label>
                </th>
                <td width="35%">
                    <input title="名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="formName" id="formName"/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formCode">编码：</label>
                </th>
                <td width="35%">
                    <input title="编码" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="formCode" id="formCode"/>
                </td>
            </tr>

            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formUrl">URL：</label>
                </th>
                <td width="35%">
                    <input title="URL" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="formUrl" id="formUrl"/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="isProxy">表单类型：</label>
                </th>
                <td width="35%">
                    <select id="isProxy" name="isProxy" class="form-control">
                        <option value="Y">外部表单</option>
                        <option value="N" selected>内部表单</option>
                    </select>
                </td>
            </tr>
            <tr>
            	<th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="attribute01">视图地址：</label>
                </th>
                <td width="35%">
                    <input title="视图地址" class="form-control input-sm" type="text" style="width: 99%;" name="attribute01" id="attribute01"/>
                </td>
                <td colspan=2 width="50%">
                    <span>如果URL为controller地址，需要填写对应的JSP地址；如果是JSP地址，可不填写</span>
                </td>
            </tr>
            <tr class="hidden">
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formType">表单类别：</label>
                </th>
                <td width="35%">
                    <input title="formType" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="formType" id="formType" value="uri"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm btn-point" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
<script type="text/javascript">

    document.ready = function () {
        $("#componentId").val(parent.eformComponent.selectedEformComponentId);
        parent.bpmsFormInfo.formValidate($('#addForm'));
        $('#saveForm').bind('click', function () {
            parent.bpmsFormInfo.subAdd($("#addForm"));
        });
        $('#closeForm').bind('click', function () {
            parent.bpmsFormInfo.closeDialog(window.name);
        });
    };
</script>
</body>
</html>
