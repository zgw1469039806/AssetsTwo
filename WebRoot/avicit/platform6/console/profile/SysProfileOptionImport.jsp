<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>导入系统参数配置</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <a id="import" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" onclick="doImport();"     href="javascript:void(0);" title="导入"><i class="icon icon-daoru"></i>导入</a>
        <a id="result" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" onclick="showResult();" href="javascript:void(0);" title="查看导入结果"><i class="icon icon-Eye"></i>查看导入结果</a>

    </div>
    <form  role="form"  id='uploadForm' method="post" enctype="multipart/form-data"  style="padding-top:20px;" >
        <div class="form-group">
        </div>
        <div class="form-group">
            <label for="profileFile">导入的文件</label>
            <input type = "file" id = 'profileFile' name = 'profileFile' accept=".xml" />
        </div>
    </form>
</div>


</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
<script>
    $(function() {
        $("#profileFile").blur(function(e) {
            enableImport = true;
        });
    });

    var needReload = false;
    var enableImport = true; // 避免重复点击导入多次导入
    function showResult(){

        showIndex = layer.open({
            type: 2,
            area: ['100%', '100%'],
            title: '查看导入结果',
            skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
            maxmin: false, //开启最大化最小化按钮
            content: 'platform/excelImportResult/toManagernew'
        });
    }

    function doImport() {
        if(!enableImport){
            return false;
        }
        enableImport = false;

        if($("#profileFile").val() == ""){
            layer.msg("请添加要导入的文件！", {icon: 0});
            enableImport = true;
            return false;
        } else {
            var pathFileName = $("#profileFile").val();
            var fileExt = pathFileName.substring(pathFileName.lastIndexOf("."), pathFileName.length).toLowerCase();
            if(fileExt != '.xml'){
                layer.msg("请选择正确的文件！", {icon: 0});
                enableImport = true;
                return false;
            }
            $("#uploadForm").ajaxSubmit({
                type: "POST",
                url: '${url}'  + "import",
                dataType : 'text',
                success: function (response) {
                    response = $.parseJSON(response);
                    if (response.flag == 'success') {
                        layer.msg(response.msg, {icon: 1})
                        needReload = true;
                    } else {
                        layer.msg(response.msg, {icon: 0})
                    }
                    enableImport = true;
                }
            })
        }
    }
</script>

</html>
