<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>编辑</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='editForm'>
        <input type="hidden" id="dbid" name="dbid" value="${flowType.id}">
        <input type="hidden" id="parentId" name="parentId" value="${flowType.parentId}">
        <input type="hidden" id="code" name="code" value="${flowType.code}">

        <table class="form_commonTable">
            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="name">名称：</label>
                </th>
                <td width="35%">
                    <input title="名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="name" id="name" value="${flowType.name}"/>
                </td>
                <%-- <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="code">代码：</label>
                </th>
                <td width="35%">
                    <input title="代码" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="code" id="code" value="${flowType.code}"/>
                </td> --%>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="orderBy">排序：</label>
                </th>
                <td width="35%">
                    <input title="排序" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="orderBy" id="orderBy" value="${flowType.orderBy}"/>
                </td>
            </tr>
            <tr>                
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="remark">描述：</label>
                </th>
                <td width="35%" colspan="3">
                    <textarea title="描述" class="form-control input-sm" style="width: 99%;" rows="3"
                           name="remark" id="remark">${flowType.remark}</textarea>
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
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn typeb btn-sm" role="button" title="保存"
                       id="saveForm"><span  aria-hidden="true">保存</span></a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="closeForm"><span
                             aria-hidden="true">取消</span></a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmdeploy/js/common.js"></script>

<script type="text/javascript">
    document.ready = function () {
    	jQuery.validator.addMethod("integer", function (value, element) {

    	    var tel = /^-?\d+$/g;  //正、负 整数 + 0

    	    return this.optional(element) || (tel.test(value));

    	}, "请输入整数"); 
    	
        parent.flowType.formValidate($('#editForm'));
        $('#saveForm').bind('click', function () {
            parent.flowType.subEdit($("#editForm"), $("#name").val());
        });
        $('#closeForm').bind('click', function () {
            parent.flowType.closeDialog("edit");
        });
    };
</script>
</body>
</html>
