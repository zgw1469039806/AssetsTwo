<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
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
        <input type="hidden" id="diggerTypeId" name="diggerTypeId" value="${diggerTypeId}">

        <table class="form_commonTable">
            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="componentName">名称：</label>
                </th>
                <td width="35%">
                    <input title="名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="componentName" id="componentName"/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="orderBy">排序：</label>
                </th>
                <td width="35%">
                    <input title="排序" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="orderBy" id="orderBy"/>
                </td>
            </tr>

            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="componentDesc">描述：</label>
                </th>
                <td colspan="3" width="85%">
                    <textarea title="描述" rows="3" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="componentDesc" id="componentDesc"></textarea>
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
                    <a href="javascript:saveForm();" class="btn btn-default form-tool-btn btn-sm" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:closeForm();" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="closeForm">取消</a>
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
    function saveForm(){
        parent.diggerComponent.subAdd($("#addForm"));
    }

    function closeForm(){
         parent.diggerComponent.closeDialog("add");
    }
    $(function(){
        
        $.validator.addMethod("integer", function (value, element) {
            var tel = /^-?\d+$/g;  //正、负 整数 + 0
            return this.optional(element) || (tel.test(value));
        }, "请输入整数");
        //此处暂时注释掉
        // $("#eformTypeId").val(parent.eformTypeTree.selectedNodeId);

        // var typeData = {"diggerTypeId": parent.diggerTypeTree.selectedNodeId}
        // var paramData = "param="+JSON.stringify(typeData);
        //添加
        parent.diggerComponent.formValidate($('#addForm'));
    });
</script>
</body>
</html>
