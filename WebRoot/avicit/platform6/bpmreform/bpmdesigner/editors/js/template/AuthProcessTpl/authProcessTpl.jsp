<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>函数输入框</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="container">
<form>
    <div class="form-group ">
        <label class="col-xs-3 control-label form-process-properties-label">事件选择</label>
        <div class="col-xs-9 form-process-properties-value">
            <select class="form-control col-xs-12" name="precessingSelect">
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="function-name"><i class="required">*</i>函数名称:</label>
        <input name="function-name" id="function-name" class="form-control"/>
    </div>
    <div class="form-group">
        <label for="function"><i class="required">*</i>函数:</label>
        <input name="function" id="function" class="form-control"/>
    </div>
</form>
<div class="pull-right">
    <button name="confirmButtion" type="button" class="btn btn-default form-tool-btn btn-sm ">确定</button>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引

    $(function () {
        var pid = flowUtils.getUrlQuery("id");
        var pname = flowUtils.getUrlQuery("name");
        var className = flowUtils.getUrlQuery("className");

        $("button[name='confirmButtion']").on('click', function () {
            var text = "";
            if ($("#function").val().trim() != "" && $("#function-name").val().trim() != "") {
                text = $("#function-name").val() + "【" + $("#function").val() + "】";
            }
            parent.addProcessAuth(pid, className, pname, text);
            parent.layer.close(index);
        });

        var processingVal = parent.getProcessAuth(pid, className, pname);
        if (flowUtils.notNull(processingVal)) {
            var postAlias = $.trim(processingVal.split("【")[0]);
            var postName = $.trim(processingVal.split("【")[1]).replace("】", "");
            $("#function-name").val(postAlias);
            $("#function").val(postName)
        }

        $.ajax({
            type : "POST",
            url : "platform/bpm/bpmconsole/eventManageAction/getEventListForDesigner",
            data : {
                type : "流程动作监听"
            },
            dataType : "json",
            success : function(result) {
                $("select[name = 'precessingSelect']").each(function (i, n) {
                    $(result).each(function (j, m) {
                        var option = $("<option value='"+m.value+"'>"+m.text+"</option>");
                        $(n).append(option);
                    });
                });
            }
        });

        $("select[name = 'precessingSelect']").change(function () {
            var value = $(this).val();
            var _self = $(this);
            $(_self).parents(".form-group").siblings().find("#function-name").val("");
            $(_self).parents(".form-group").siblings().find("#function").val("");
            if (value != "") {
                $.ajax({
                    type : "POST",
                    url : "platform/bpm/bpmconsole/eventManageAction/getEventInfoForDesigner",
                    data : {
                        id : value
                    },
                    dataType : "json",
                    success : function(result) {
                        var bpmClass = result.bpmClass;
                        if (bpmClass) {
                            $(_self).parents(".form-group").siblings().find("#function-name").val(bpmClass.name);
                            $(_self).parents(".form-group").siblings().find("#function").val(bpmClass.path);
                        }
                    }
                });
            }
        });
    });
</script>
</body>
</html>

