<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "sysprint/sysPrintController/operation/Add/null" -->
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" id="resourceId" name="resourceId" />
        <input type="hidden" id="printType" name="printType" value="1"/>
        <table class="form_commonTable">
            <tr>

                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="printTempName">模板名称：</label>
                </th>
                <td width="35%">
                    <input title="模板名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="printTempName" id="printTempName"/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="printTempCode">模板编码：</label>
                </th>
                <td width="35%">
                    <input title="模板编码" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="printTempCode" id="printTempCode"/>
                </td>

            </tr>
            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="EformVersion">引用表单设计：</label>
                </th>
                <td width="35%">
                    <%--<input title="版本" class="form-control input-sm" type="text" style="width: 99%;" type="text"--%>
                           <%--name="EformVersion" id="EformVersion" value="V1"/>--%>
                    <select class="form-control input-sm" id = 'EformVersion'style="width: 99%;"/>
                </td>
            </tr>
            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="remark">描述：</label>
                </th>
                <td colspan="3" width="85%">
                    <textarea title="描述" rows="3" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                              name="remark" id="remark"></textarea>
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
                       title="保存" id="sysPrint_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="sysPrint_closeForm">返回</a>
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
        parent.sysPrint.closeDialog("insert");
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
        //限制保存按钮多次点击
        $('#sysPrint_saveForm').addClass('disabled').unbind("click");
        parent.sysPrint.save($('#form'), "insert");
    }

    $(document).ready(function () {
        $.validator.addMethod("printTempCode", function (value, element) {
            var tel = /^[a-zA-Z0-9_]{1,}$/;
            return this.optional(element) || (tel.test(value));
        }, "编码格式只能是字母、数字、下划线的组合");

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

        parent.sysPrint.formValidate($('#form'));
        //保存按钮绑定事件
        $('#sysPrint_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#sysPrint_closeForm').bind('click', function () {
            closeForm();
        });


        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);

        avicAjax.ajax({
            url: parent.baseUrl + 'platform/eform/bpmsManageController/checkTabVersion',
            data:{eformFormInfoId:parent.sysPrint._resourceId},
            type : 'post',
            dataType : 'json',
            success : function(r){
                var rows= r.rows;
                $select = $('#EformVersion');
                for(var i=0; i < rows.length; i++){
                    var value = rows[i].attribute08;
                    var text = value;
                    if(rows[i].ynCurrent == '是'){
                        text = text + '(当前版本)';
                        $select.append($('<option>',{value:value, text:text}).attr("selected",true));
                        continue;
                    }
                    $select.append($('<option>',{value:value, text:text}));
                }

            }
        })
    });
</script>
</body>
</html>