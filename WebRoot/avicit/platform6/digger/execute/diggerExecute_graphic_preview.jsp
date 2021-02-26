<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>${diggerName} - 运行</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <style type="text/css">
        .sp {
            width: 60px;
            border-left: 1px solid #666666;
            border-right: 1px solid #666666;
            padding-left: 25px;
            background-color: #ffffff;
        }
    </style>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
    <script type="text/javascript">
        var isAdmin ='true';
        var viewScopeType='';
        if(isAdmin=="true"){
        	viewScopeType = 'currentOrg';
        }else{
        	viewScopeType = 'allowAcross';
        }
    </script>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='queryForm'>
        <table class="form_commonTable" id="condition" style="display: ${displayConditionArea}">
            <tr>
                <td width="80%" style="word-break: break-all; word-warp: break-word;">
                   <table class="form_commonTable">
                       ${queryCondition}
                   </table>
                </td>
                <td width="20%">
<%--                    <input title="名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"--%>
<%--                          name="name" id="name"/>--%>
                    <table>
                        <tr><td valign="bottom">
                            <a href="javascript:execute();" class="btn btn-default form-tool-btn btn-sm" role="button" title="保存" id="execute">查询</a>
                            <a href="javascript:rest();" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="rest">重置</a>
                        </td></tr>
                    </table>
                </td>
            </tr>

        </table>

        <table name="AWS_LINE_TAB" id="AWS_LINE_TAB" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
                <tr bgcolor="#666666">
                    <td height="2" id="ext-gen16"></td>
                    <td height="2" id="ext-gen12"></td>
                </tr>
                <tr bgcolor="#e1e5e6">
                    <td width="30%" height="8" id="ext-gen15"></td>
                    <td width="70%" height="8" id="ext-gen11">
                        <div class="sp">
                            <a href="#" onclick="resizeWindows();return false;" ><i class="caret" style="color: #000"></i></a>
                        </div>
                    </td>
                </tr>
                <tr bgcolor="#666666">
                    <td height="1"></td>
                    <td height="1"></td>
                </tr>
            </tbody>
        </table>
        <div id="container" style="height: 400px"></div>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">

                </td>
            </tr>
        </table>
    </div>
</div>
<div id="exportDataDialog" style="display:none;">
    <table style="margin:20px 0 0 50px">
        <tr>
            <td> <label ><input type='radio' name='exportType' value='pdf' checked /> <image src='static/images/platform/common/file/pdf.jpg'/>PDF</label></td>
        </tr>
        <tr>
            <td><label><input type='radio' name='exportType' value='excel' /> <image src='static/images/platform/common/file/excel.jpg'/>EXCEL</label></td>
        </tr>
    </table>
</div>
<form id="chartForm" style="display:none">
    <input id="imageValue" name="base64Info" type="text" maxlength="50000"/>
    <input id="exportTypeValue" name="exportTypeValue" type="text" />
    <input id="diggerId" name="diggerId" type="hidden" value="${diggerId}" />
</form>
    <script type="text/javascript" src="static/h5/echarts/dist/echarts.min.js"></script>
    <script type="text/javascript" src="static/h5/echarts/dist/echarts-gl.min.js"></script>
    <script type="text/javascript" src="static/h5/echarts/dist/ecStat.min.js"></script>
    <script type="text/javascript" src="static/h5/echarts/dist/dataTool.min.js"></script>
    <script type="text/javascript" src="static/h5/echarts/dist/dataTool.min.js"></script>
    <script src="avicit/platform6/digger/execute/js/DiggerExecute.js"></script>
    <script src="static/js/platform/component/common/json2.js" type="text/javascript"></script>
<script type="text/javascript">
    var dom = document.getElementById("container");
    var myChart = echarts.init(dom);
    var app = {};

    var myExport = {
        "show": true,
        "title": "导出",
        "type": "png",
        "readOnly": null,
        "lang": ["点击导出"],
        "lineStyle": null,
        "textStyle": null,
        "icon": "image://data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAQCAYAAAAmlE46AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyBpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNSBXaW5kb3dzIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjIxNTdGNzFDNURDOTExRUE5MDcyRUI3NTk4NzZCQjJGIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjIxNTdGNzFENURDOTExRUE5MDcyRUI3NTk4NzZCQjJGIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MjE1N0Y3MUE1REM5MTFFQTkwNzJFQjc1OTg3NkJCMkYiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MjE1N0Y3MUI1REM5MTFFQTkwNzJFQjc1OTg3NkJCMkYiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz6jUzNdAAAAz0lEQVR42mL4//8/AwxPmdz//9Gjh/+RxXBhJgYomDplwn92Dg4GWVk5RgYiABOyppSUDKI0gQDjnNkz/l+8eJ5BVFSMKA2srKwMoWERDCyqamoM58+fZdA3MGRQVVUjqHHRwvlgmsXOzpGRn1/gP9BmBmFhYQZraztG/Day/If7UV/fkDElNYNhxfKlDEePHvpPVOB8+fL5P7JmQjbCNZ46dYLhwIG9cM3EhirTnTu3GcgBTAxkgpGgkYWLk4th+bLFIExUxEtISIJpgAADAFqDXtW+T6AlAAAAAElFTkSuQmCC",
        "onclick": function(){
             dataExportEvent();
        }
    };

    $(window).resize(function() {
        for(var i = 0; i < charts.length; i++) {
            charts[i].resize();
        }
    });

    $(function(){
        $($("#container > div")[0]).css("width","100%");//设置图表所在div中的div宽度
        $($("#container > canvas")[0]).css("width", "100%");//设置图表的div宽度
        myChart.resize();
    });
    function getCondition(){
         var form =  $('#queryForm');
         var formSerializeValue = form.serialize();
         var condition = convertFormSerializeValueToJson(formSerializeValue);
         return condition;
    }
    var autoExec = ${autoExec};
    $(function(){
        if(autoExec == 1){//自动执行查询
            execute();
        }
    });

    function execute(){
         //alert(getCondition());
         var paramData = "condition=" + getCondition() + '&diggerId=${diggerId}';
         $.ajax({
             url: "digger/diggerExecuteController/getDisplayResult",
             data: paramData,
             type: "post",
             dataType: "json",
             success: function (data) {
                 var option =  data.option;
                 if (option && typeof option === "object") {
                     //option.toolbox.feature.myExport = myExport;//设置导出
                     myChart.setOption(option, true);
                 }
             }
         });
         return false;
    }
    myChart.on('click', function(params) {
         var paramData = 'diggerId=${diggerId}&paramName=' + params.name + '&seriesName=' + params.seriesName;
    	 layer.open({
                type: 2,
                title: '详情',
                closeBtn : 0,
                skin: 'bs-modal',
                area: ['40%', '40%'],
                maxmin: false,
                content: "platform/digger/diggerExecuteController/getDisplayDetail?" + paramData
          });
    });
    function rest(){
        document.getElementById("queryForm").reset();
    }
    function dataExportEvent(){
        layer.open({
          type: 1,
          title: '导出',
          closeBtn: 0,
          skin: 'bs-modal',
          area: ['30%', '25%'],
          content: $("#exportDataDialog"),
          btn: ['导出', '取消'],
          yes: function(){
              //处理逻辑
              var picBase64Info = myChart.getDataURL();//获取echarts图的base64编码，为png格式
              var exportType = $('input[name="exportType"]:checked').val();
              var chartExportUrl = 'platform/digger/diggerExecuteController/export';
              $('#chartForm').find('input[name="base64Info"]').val(picBase64Info);//将编码赋值给输入框
              $('#chartForm').find('input[name="exportTypeValue"]').val(exportType);//将导出类型值赋值给输入框
              $('#chartForm').attr('action',chartExportUrl).attr('method', 'post');//设置提交到的url地址
              $('#chartForm').submit();
              layer.closeAll();
          }
          ,btn2: function(){
              layer.closeAll();
           }
        });
    }
    function resizeWindows(){

    }

</script>
</body>
</html>
