<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
    <style>
        .table>tbody>tr>td,
        .table>tbody>tr>th
        {
            padding: 0px;
            line-height: 1.42857143;
            vertical-align: middle;
            text-align:center;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <div class="form-group" >
        <div class="toolbar">
            <div class="toolbar-right">
                <button class="btn btn-default form-tool-btn btn-sm form-buttion-fix" style="align:right;" name="btn-add" >添加</button>
                <input type="hidden" name="fieldConfigDataDom" id="fieldConfigDataDom">
            </div>
        </div>
    </div>
    <div >
        <table class="table table-hover table-bordered table-fix" border="1" name="fieldConfigTable" id="fieldConfigTable">
            <thead>
            <tr>
                <td style="width: 11%;white-space: pre-wrap;"><span>控制条件</span></td>
                <td style="width: 12%;white-space: pre-wrap;"><span>被控制字段</span></td>
                <td style="width: 13%;white-space: pre-wrap;"><span>操作</span> </td>
            </tr>
            </thead>
            <tbody id="fieldConfigTableBody">
            </tbody>
        </table>
        <label style="color:red;">&nbsp;&nbsp;注：多组控制之间是或的关系</label>
    </div>
</div>
<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/FieldRelationControl/FieldConfig.js"></script>
<script type="text/javascript">
    var formFields;
    var subFieldsMap;
    var process;
    var fieldConfig;
    var oldConfigValues = [];
    var secretList;
    var allElements;
    $(document).ready(function() {
        var parentId = decodeURIComponent(flowUtils.getUrlQuery("dataDomId"));
        var parentObj = parent.$("#"+parentId).data("data-object");
        process = parentObj.process;
        var formId = parentObj.formId;

        var oldConfigValuesJson = parent.$("#"+parentId).val();
        if(oldConfigValuesJson!=''){
            oldConfigValues = JSON.parse(oldConfigValuesJson);
        }
        ;
        avicAjax.ajax({
            //url: "platform/bpm/designer/getProcessFormFieldsForVar",
            url: "platform/bpm/designer/getAllFormElements",
            data: "globalformid=" + formId,
            type: "post",
            dataType: "json",
            success: function (backData) {
                formFields = JSON.parse(backData.fields);
                allElements = JSON.parse(backData.allElements);
                subFieldsMap = backData.subFieldsMap;
                secretList = backData.secretList;
                fieldConfig = new FieldConfig({dataDomId:"fieldConfigDataDom",callback:function(data){
                    },tableId:"fieldConfigTableBody",formFields:formFields,allElements:allElements,subFieldsMap:subFieldsMap,buttonId:"btn-add",secretList:secretList});
                var _table = $("#fieldConfigTableBody");
                _table.empty();

                if(oldConfigValues && oldConfigValues.length){
                    for(var i=0;i<oldConfigValues.length;i++){
                        var _tr = fieldConfig.getTableTr(oldConfigValues[i]);
                        _table.append(_tr);
                    }
                }

            }
        });
    });

    function getAllConfigValue(){
        var allConfigValue = [];
        $("#fieldConfigTableBody tr").each(function(){
            var dataStr = $(this).find("td").eq(0).find("input[name='fieldConfigValue']").val();
            if(flowUtils.notNull(dataStr)){
                var dataObj = JSON.parse(dataStr);
                allConfigValue.push(dataObj);
            }
        });
        return allConfigValue;
    }

</script>
</body>
</html>