<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>选择导出数据类型</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap.css"/>
</head>
<body>
<form id='selectType' style="margin:40px;" >
    <div class="radio">
        <label>
            <input type="radio"   id = "excel" name = "exportType" value="excel" checked/>
            Excel
        </label>
    </div >
    <div class="radio" >
        <label>
            <input type="radio"  id = "pdf" name = "exportType"  value="pdf" />
            PDF
        </label>
    </div>
    <div class='select'>
        <select id ="direction"  name = "paperSetting" class="form-control" style="display: none">
            <option value="portrait">纵向</option>
            <option value="landscape">横向</option>
        </select>
    </div>
</form>

<script src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.js" type="text/javascript"></script>
<script type="text/javascript">
    document.ready = function () {

        $('input:radio').change(function(){
            if ($("input[name='exportType']:checked").val() == "pdf"){
                $('#direction').show();
            }else{
                $('#direction').hide();
            }
        });
    };
</script>
</body>
</html>
