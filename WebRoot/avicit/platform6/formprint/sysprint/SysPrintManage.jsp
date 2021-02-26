<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "sysprint/sysPrintController/toSysPrintManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysPrint_button_add" permissionDes="添加">
            <a id="sysPrint_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
               title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysPrint_button_edit" permissionDes="编辑">
            <a id="sysPrint_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button"
               title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysPrint_button_delete" permissionDes="删除">
            <a id="sysPrint_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button"
               title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
    </div>

</div>
<table id="sysPrintjqGrid"></table>
<div id="jqGridPager"></div>
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/formprint/sysprint/js/SysPrint.js" type="text/javascript"></script>
<script type="text/javascript">
    var sysPrint;
    var baseUrl = '<%=ViewUtil.getRequestPath(request)%>';


    function getDesignPage(cellvalue, options, rowObject){
        return '<a href="javascript:void(0)"  onClick="openDesignPage(\''+rowObject.id+'\');">'+cellvalue+'</a>';
    }

    function openDesignPage(id){
        window.open(baseUrl+'platform/print/sysPrintDesignerController/toDesigner?' +
            'printId='+id , '_blank');
    }

    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}

            , {label: '模板名称', name: 'printTempName', width: 150, formatter:getDesignPage}
            , {label: '模板编码', name: 'printTempCode', width: 150}
            , {label: '描述', name: 'remark', width: 150}

        ];
        sysPrint = new SysPrint('sysPrintjqGrid', '${url}', dataGridColModel,'${resourceId}');
        //添加按钮绑定事件
        $('#sysPrint_insert').bind('click', function () {
            sysPrint.insert();
        });
        //编辑按钮绑定事件
        $('#sysPrint_modify').bind('click', function () {
            sysPrint.modify();
        });
        //删除按钮绑定事件
        $('#sysPrint_del').bind('click', function () {
            sysPrint.del();
        });


    });

</script>
</html>