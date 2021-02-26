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
        <input type="hidden" id="id" name="id" value="${dbTable.id}">
        <input type="hidden" id="dbTableTypeId" name="dbTableTypeId" value="${dbTable.tableType}">
        <input type="hidden" id=tableIsCreated name="tableIsCreated" value="${dbTable.tableIsCreated}">
        <input type="hidden" id="dataSourceId" name="dataSourceId" value="${dataSourceId}">

        <table class="form_commonTable">
            <tr>
                <th width="18%" style="word-break: break-all; word-warp: break-word;">
                    <label for="tableName" id="tablenamelabel">表英文名称：DYN_</label>
                </th>
                <td width="32%">
                    <input title="表英文名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="tableName" id="tableName"  value="${tableName}"/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="tableComments">表中文名称：</label>
                </th>
                <td width="35%">
                    <input title="表中文名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="tableComments" id="tableComments" value="${dbTable.tableComments}"/>
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
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn typeb btn-sm" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="closeForm">取消</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/db/dbtabletype/js/common.js"></script>

<script type="text/javascript">
var isCreated = "${dbTable.tableIsCreated}";
    document.ready = function () {
    	$.validator.addMethod("english", function(value, element) {
            var chrnum = /^[^\u4e00-\u9fa5]*$/;
            return this.optional(element) || (chrnum.test(value));
        }, "不能输入汉字");
        parent.dbTable.formValidate($('#editForm'));
        $('#saveForm').bind('click', function () {
            parent.dbTable.subEdit($("#editForm"));
        });
        $('#closeForm').bind('click', function () {
            parent.dbTable.closeDialog("edit");
        });
        $("#tableName").on("keyup",function(){
        	var val = $(this).val().toUpperCase();
        	$(this).val(val); 
        });
        if (isCreated == "Y"){
        	$("#tablenamelabel").html("表英文名称：");
        	$("#tableName").attr("readonly","readonly");
        }
    };
</script>
</body>
</html>
