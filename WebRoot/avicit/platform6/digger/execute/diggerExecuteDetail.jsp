<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,table";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>详情数据</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='addForm'>
        <input type="hidden" id="parentId" name="parentId" value="${parentId}">
        <table id="diggerExecuteDetailGrid"></table>
      </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:closeForm();" class="btn btn-default form-tool-btn btn-sm" role="button" title="关闭" id="closeForm">关闭</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="static/js/platform/component/common/json2.js" type="text/javascript"></script>
<script src="avicit/platform6/digger/execute/js/DiggerExecuteDetailGrid.js"></script>
<script type="text/javascript">
    var detailGridColModelJson = ${detailGridColModelJson};
    function closeForm(){
        parent.layer.close(parent.layer.index);
    }
    var diggerExecuteDetailGridModel = new Array();
    for(var i = 0 ; i < detailGridColModelJson.length ; i++){
        var detailGridColModel = detailGridColModelJson[i];
        if(detailGridColModel.fieldTitle){
            var obj = new Object();
            obj.label = detailGridColModel.fieldTitle;
            obj.name = detailGridColModel.fieldName;
            diggerExecuteDetailGridModel.push(obj);
        }
    }

     var diggerExecuteDetailGrid;
     $(function() {
        var condition = parent.getCondition();
        diggerExecuteDetailGrid = new DiggerExecuteDetailGrid('diggerExecuteDetailGrid','${url}',diggerExecuteDetailGridModel,'${diggerId}','${paramName}','${seriesName}',escape(condition));
      });
</script>
</body>
</html>
