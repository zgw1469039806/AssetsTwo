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
        <input type="hidden" id="diggercomponentid" name="diggercomponentid" value="${diggercomponentid}">

        <table class="form_commonTable">
            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="diggername">名称：</label>
                </th>
                <td width="35%">
                    <input title="名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="diggername" id="diggername"/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="diggercode">编码：</label>
                </th>
                <td width="35%">
                    <input title="编码" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="diggercode" id="diggercode"/>
                </td>
            </tr>

            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                     <label for="diggertype">类型：</label>
                 </th>
                 <td width="35%">
                     <label><input type='radio'  name='diggertype' value='2' checked>普通</label>&nbsp;&nbsp;
                     <label><input type='radio'  name='diggertype' value='0' >统计</label>&nbsp;&nbsp;
                     <label><input type='radio'  name='diggertype' value='3' >交叉</label>&nbsp;&nbsp;
                     <label><input type='radio' name='diggertype' value='1' >图表</label>

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
                    <label for="diggerDesc">描述：</label>
                </th>
                <td width="39%" colspan='3'>
                    <textarea style='width:100%;' id='diggerDesc' name='diggerDesc'></textarea>
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
<script src="avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.js"></script>

<script type="text/javascript">
    document.ready = function () {
        var fixie = "${fixie}";
        if ("1" == fixie){
            $("#formStyle option[value='easyui']").attr("selected","selected");
        }
    	$.validator.addMethod("integer", function (value, element) {
    	    var tel = /^-?\d+$/g;  //正、负 整数 + 0
    	    return this.optional(element) || (tel.test(value));
    	}, "请输入整数");
    	$.validator.addMethod("codeFormat", function (value, element) {
    	    var tel = /^[a-zA-Z0-9_]{1,}$/;
    	    return this.optional(element) || (tel.test(value));
    	}, "编码格式只能是字母、数字、下划线的组合");

        selectCreatedDbTable = new SelectCreatedDbTable("dataSourceId","dataSourceName", "dataSourceBtn");
        selectCreatedDbTable.init();

        // $("#eformComponentId").val(parent.eformComponent.selectedEformComponentId);

        // var componenData = {"eformComponentId": parent.eformComponent.selectedEformComponentId}
        // var paramData = "param="+JSON.stringify(componenData);
        // $.ajax({
        //     url: "platform/eform/bpmsManageController/getNewEformFormInfoNb",
        //     data: paramData,
        //     type: "post",
        //     dataType: "json",
        //     success: function (r) {
        //         $("#orderBy").val(r.number);
        //     }
        // });

        parent.diggerFormInfo.formValidate($('#addForm'));
    };

     function saveForm(){
            //parent.eformType.formValidate($('#addForm'));
           parent.diggerFormInfo.subAdd($("#addForm"));
        }
    function closeForm(){
       parent.diggerFormInfo.closeDialog("add");
    }
</script>
</body>
</html>
