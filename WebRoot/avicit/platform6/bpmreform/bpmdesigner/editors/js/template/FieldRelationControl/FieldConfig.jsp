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

        .table {
            width: 100%;
            max-width: 100%;
            margin-bottom: 7px;
        }

        .form_commonTable label {
            margin: 0px;
            vertical-align:middle;
        }
        label {
            display: inline-block;
            max-width: 100%;
            margin-bottom: 5px;
            font-weight: 700;
            vertical-align: middle;
        }
    </style>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <div >
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        控制条件
                    </h3>
                </div>
                <div class="panel-body">
                    <table class="ui-jqgrid-htable ui-common-table table table-bordered" width="80%" border="0"  id="conditionTable">
                        <thead>
                            <tr>
                                <th width="25%">控制字段</th>
                                <th width="20%">操作符</th>
                                <th width="40%">值</th>
                                <th width="15%">
                                    <a id="addCondition" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                                                   role="button" title="增加条件"><i class="icon icon-add"></i> 增加</a>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <label style="color:red;">&nbsp;&nbsp;注：1、多个控制条件之间是与的关系&nbsp;&nbsp;2、操作符为区间时，取值范围为闭区间</label>
                </div>
            </div>
            <br>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        被控制字段
                    </h3>
                </div>
                <div class="panel-body">
                    <table class="ui-jqgrid-htable ui-common-table table table-bordered" border="1" id="beControledFieldTable">
                        <thead>
                            <tr>
                                <th width="25%" style="word-break: break-all; word-warp: break-word;">被控制字段</th>
                                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                                    <input type="checkbox"   value=""  id="allAccessibility" onChange="checkAllAccessibility(this)"/>&nbsp;可显示
                                </th>
                                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                                    <input type="checkbox"   value=""  id="allOperability" onChange="checkAllOperability(this)"/>&nbsp;可编辑
                                </th>
                                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                                    <input type="checkbox"   value=""  id="allRequired" onChange="checkAllRequired(this)"/>&nbsp;必填
                                </th>
                                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                                    <input type="checkbox"   value=""  id="allHideRow" onChange="checkAllHideRow(this)"/>&nbsp;隐藏行
                                </th>
                                <th width="15%">
                                    <a id="addBeControledField" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                                       role="button" title="增加被控制字段"><i class="icon icon-add"></i> 增加</a>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>

                    </table>
                </div>
            </div>


        </div>
    </form>
</div>
<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
    var formFields;
    var tableId;
    var oldConfigObj;
    var secretList;
    var allElements;
    var _rowId = 1;

    function checkAllAccessibility(obj){
        if($(obj).is(':checked')){
            $(obj).parentsUntil("table").parent().find("input[name='accessibility']").prop("checked",true);
            $(obj).parentsUntil("table").parent().find("input[name='hideRow']").prop("checked",false);
            $("#allHideRow").prop("checked",false);
        }else{
            $(obj).parentsUntil("table").parent().find("input[name='accessibility']").prop("checked",false);
        }
    }

    function checkAllOperability(obj){
        if($(obj).is(':checked')){
            $(obj).parentsUntil("table").parent().find("input[name='operability']").prop("checked",true);
            $(obj).parentsUntil("table").parent().find("input[name='accessibility']").prop("checked",true);
            $(obj).parentsUntil("table").parent().find("input[name='hideRow']").prop("checked",false);
            $("#allHideRow").prop("checked",false);
        }else{
            $(obj).parentsUntil("table").parent().find("input[name='operability']").prop("checked",false);
        }
    }

    function checkAllRequired(obj){
        if($(obj).is(':checked')){
            $(obj).parentsUntil("table").parent().find("input[name='required']").prop("checked",true);
            $(obj).parentsUntil("table").parent().find("input[name='operability']").prop("checked",true);
            $(obj).parentsUntil("table").parent().find("input[name='accessibility']").prop("checked",true);
            $(obj).parentsUntil("table").parent().find("input[name='hideRow']").prop("checked",false);
            $("#allHideRow").prop("checked",false);
        }else{
            $(obj).parentsUntil("table").parent().find("input[name='required']").prop("checked",false);
        }
    }

    function checkAllHideRow(obj){
        if($(obj).is(':checked')){
            $(obj).parentsUntil("table").parent().find("input[name='hideRow']").prop("checked",true);
            $(obj).parentsUntil("table").parent().find("input[name='accessibility']").prop("checked",false);
            $(obj).parentsUntil("table").parent().find("input[name='required']").prop("checked",false);
            $(obj).parentsUntil("table").parent().find("input[name='operability']").prop("checked",false);
            $("#allAccessibility").prop("checked",false);
            $("#allOperability").prop("checked",false);
            $("#allRequired").prop("checked",false);
        }else{
            $(obj).parentsUntil("table").parent().find("input[name='hideRow']").prop("checked",false);
        }
    }

    function initEditData(oldConfigObj){
        var conditonValues = oldConfigObj.conditonValues;
        if(conditonValues && conditonValues.length){
            for(var i=0;i<conditonValues.length;i++){
                addCondition(conditonValues[i]);
            }
        }
        var beControledFields = oldConfigObj.beControledFields;
        if(beControledFields && beControledFields.length){
            for(var j=0;j<beControledFields.length;j++){
                addBeControledField(beControledFields[j]);
            }
        }

    }

    /**
     * 增加控制条件
     */
    function addCondition(oldConditon){
        _rowId++;
        var $tr = $('<tr rowId="'+_rowId+'"></tr>');
        var $td1 = $('<td width="20%">\n' +
            '                        <select class="form-control input-sm"  name="controlField" title="" onChange="changeControlField(this)">\n' +
            '                            <option value="">&nbsp;&nbsp;&nbsp;请选择</option>\n' +
            '                        </select>\n' +
            '                    </td>');
        var controlFieldObj = $td1.find("select[name='controlField']");
        initControlField(controlFieldObj);
        if(flowUtils.notNull(oldConditon)){
            controlFieldObj.val(oldConditon.controlTag);
        }

        var $td2 = $('<td width="15%" id="operTd">\n' +
            '                        <select class="form-control input-sm" name="oper" title="">\n' +
            '                            <option value="">请选择</option>\n' +
            '\n' +
            '                        </select>\n' +
            '\n' +
            '                    </td>');
        var $td3 = $('<td id="valueTd">\n' +
            '                        <div id="compareValueDiv">\n' +
            '                            <input title="输入多个值时请用 @@@进行分割" class="form-control input-sm" type="text" name="compareValue" id="compareValue" />\n' +
            '                            <input type="hidden" name="compareValueName" id="compareValueName"/>\n' +
            '                        </div>\n' +
            '                    </td>');
        var $td4 = $('<td>\n' +
            '                       <a href=\'javascript:void(0)\' name=\'deleteData\' title=\'删除\'> <i class=\'iconfont icon-delete\'></i></a>\n' +
            '                    </td>');
        $td4.find("a[name='deleteData']").off("click").on("click",function() {
            $(this).parent().parent().remove();
        });
        $tr.append($td1);
        $tr.append($td2);
        $tr.append($td3);
        $tr.append($td4);
        $("#conditionTable tbody").append($tr);
        changeControlField(controlFieldObj,oldConditon);
    }
    /**
     * 增加被控制字段
     */
    function addBeControledField(oldBeControledField){
        var $tr = $('<tr></tr>');
        var $td1 = $('<td>\n' +
            '                                    <select class="form-control input-sm"  name="beControledField" id="beControledField" title=""  onChange="changeBeControledField(this)">\n' +
            '                                        <option value="">&nbsp;&nbsp;&nbsp;请选择</option>\n' +
            '                                    </select>\n' +
            '                                </td>');
        var beControlFieldObj = $td1.find("select[name='beControledField']");
        initBeControlField(beControlFieldObj);

        var $td2 = $('<td>\n' +
            '                                    <label class="checkbox-parent-label">\n' +
            '                                        <input type="checkbox"   value="" name="accessibility" id="accessibility" onChange="changeAccessibility(this)"/>&nbsp;可显示\n' +
            '                                    </label>\n' +
            '                                </td>');

        var $td3 = $('<td>\n' +
            '                                    <label class="checkbox-parent-label" id="operabilityLabel">\n' +
            '                                        <input type="checkbox"   value="" name="operability" id="operability" onChange="changeOperability(this)"/>&nbsp;可编辑\n' +
            '                                    </label>\n' +
            '                                </td>');
        var $td4 = $('<td>\n' +
            '                                    <label class="checkbox-parent-label" id="requiredLabel">\n' +
            '                                        <input type="checkbox"   value="" name="required" id="required" onChange="changeRequired(this)"/>&nbsp;必填\n' +
            '                                    </label>\n' +
            '                                </td>');
        var $td5 = $('<td>\n' +
            '                                    <label class="checkbox-parent-label">\n' +
            '                                        <input type="checkbox"   value="" name="hideRow" id="hideRow" onChange="changeHideRow(this)"/>&nbsp;隐藏行\n' +
            '                                    </label>\n' +
            '                                </td>');
        var $td6 = $('<td>\n' +
            '                       <a href=\'javascript:void(0)\' name=\'deleteData\' title=\'删除\'> <i class=\'iconfont icon-delete\'></i></a>\n' +
            '                    </td>');
        $td6.find("a[name='deleteData']").off("click").on("click",function() {
            $(this).parent().parent().remove();
        });
        $tr.append($td1);
        $tr.append($td2);
        $tr.append($td3);
        $tr.append($td4);
        $tr.append($td5);
        $tr.append($td6);
        $("#beControledFieldTable tbody").append($tr);
        if(flowUtils.notNull(oldBeControledField)){
            beControlFieldObj.val(oldBeControledField.tag);
            if(oldBeControledField.accessibility=='1'){
                $tr.find("input[name='accessibility']").prop("checked",true);
            }
            if(oldBeControledField.hideRow=='1'){
                $tr.find("input[name='hideRow']").prop("checked",true);
            }
            if(oldBeControledField.operability=='1'){
                $tr.find("input[name='operability']").prop("checked",true);
            }
            if(oldBeControledField.required=='1'){
                $tr.find("input[name='required']").prop("checked",true);
            }
            changeBeControledField($tr.find("select[name='beControledField']"));
        }

    }

    $(document).ready(function() {
        var parentId = decodeURIComponent(flowUtils.getUrlQuery("dataDomId"));
        var parentObj = parent.$("#"+parentId).data("data-object");
        formFields = parentObj.formFields;
        allElements = parentObj.allElements;
        subFieldsMap = parentObj.subFieldsMap;
        secretList = parentObj.secretList;
        tableId = parentObj.tableId;
        if(flowUtils.notNull(formFields)){
            for(var i=0;i<formFields.length;i++){
                $("#controlField").append("<option value='" + formFields[i].colName + "' "
                    + " colType='" + formFields[i].colType + "'"
                    + " colName='" + formFields[i].colName + "'"
                    + " colLabel='" + formFields[i].colLabel + "'"
                    + " selectedoption='" + formFields[i].selectedoption + "'"
                    + " selectedvalues='" + formFields[i].selectedvalues + "'"
                    + " elementType='"+ formFields[i].elementType + "'"
                    + " domId='"+ formFields[i].domId + "'"
                    + " domType='" + formFields[i].domType + "'>" + formFields[i].colLabel + "(" + formFields[i].colName + ")" + "</option>");
            }
            if(flowUtils.notNull(allElements)){
                for(var i=0;i<allElements.length;i++){
                    $("#beControledField").append("<option value='" + allElements[i].colName + "' "
                        + " colType='" + allElements[i].colType + "'"
                        + " colName='" + allElements[i].colName + "'"
                        + " colLabel='" + allElements[i].colLabel + "'"
                        + " elementType='"+ allElements[i].elementType + "'"
                        + " domId='"+ allElements[i].domId + "'"
                        + " domType='" + allElements[i].domType + "'>" + allElements[i].colLabel + "(" + allElements[i].colName + ")" + "</option>");
                }
            }
            //处理关联子表的字段

            var key = null;//子表名称
            var value = null;//子表字段内容
            if (flowUtils.notNull(subFieldsMap)) {
                for (var entry in subFieldsMap) {
                    //key = entry;
                    key = "子表字段" + "(" + entry + ")";
                    value = subFieldsMap[entry];
                    if (flowUtils.notNull(value)) {
                        var subFormFields = JSON.parse(value);
                        if (subFormFields.length > 0) {
                            $("#beControledField").append("<optgroup label='" + key + "'></optgroup>");
                        }
                        for (var j = 0; j < subFormFields.length; j++) {
                            $("#beControledField").append("<option value='" +entry+"__"+subFormFields[j].colName + "' "
                                + " colType='" + subFormFields[j].colType + "'"
                                + " colName='" + entry + "__" +subFormFields[j].colName + "'"
                                + " colLabel='" + subFormFields[j].colLabel + "'"
                                + " selectedoption='" + subFormFields[j].selectedoption + "'"
                                + " selectedvalues='" + subFormFields[j].selectedvalues + "'"
                                + " elementType='eform_subtable_bpm_auth'"
                                + " domId='"+ subFormFields[j].domId + "'"
                                + " domType='" + subFormFields[j].domType + "'>" + subFormFields[j].colLabel + "(" + subFormFields[j].colName + ")" + "</option>");
                        }
                    }

                }
            }
            var update = flowUtils.getUrlQuery("update");
            if(update=='1'){
                oldConfigObj = parent.$("#"+parentId).data("configObj");
                if(flowUtils.notNull(oldConfigObj)){
                    initEditData(oldConfigObj);
                }
            }
        }

        $("#addCondition").on("click",function(){
            addCondition();
        });

        $("#addBeControledField").on("click",function(){
            addBeControledField();
        });

    });

    /**
     * 初始化控制字段
     */
    function initControlField(controlFieldObj){
        if(flowUtils.notNull(formFields)){
            for(var i=0;i<formFields.length;i++){
                controlFieldObj.append("<option value='" + formFields[i].colName + "' "
                    + " colType='" + formFields[i].colType + "'"
                    + " colName='" + formFields[i].colName + "'"
                    + " colLabel='" + formFields[i].colLabel + "'"
                    + " selectedoption='" + formFields[i].selectedoption + "'"
                    + " selectedvalues='" + formFields[i].selectedvalues + "'"
                    + " elementType='"+ formFields[i].elementType + "'"
                    + " domId='"+ formFields[i].domId + "'"
                    + " domType='" + formFields[i].domType + "'>" + formFields[i].colLabel + "(" + formFields[i].colName + ")" + "</option>");
            }
        }
    }

    /**
     * 初始化被控制字段
     */
    function initBeControlField(beControlFieldObj){
        if(flowUtils.notNull(allElements)){
            for(var i=0;i<allElements.length;i++){
                beControlFieldObj.append("<option value='" + allElements[i].colName + "' "
                    + " colType='" + allElements[i].colType + "'"
                    + " colName='" + allElements[i].colName + "'"
                    + " colLabel='" + allElements[i].colLabel + "'"
                    + " elementType='"+ allElements[i].elementType + "'"
                    + " domId='"+ allElements[i].domId + "'"
                    + " domType='" + allElements[i].domType + "'>" + allElements[i].colLabel + "(" + allElements[i].colName + ")" + "</option>");
            }
        }

        //处理关联子表的字段

        var key = null;//子表名称
        var value = null;//子表字段内容
        if (flowUtils.notNull(subFieldsMap)) {
            for (var entry in subFieldsMap) {
                //key = entry;
                key = "子表字段" + "(" + entry + ")";
                value = subFieldsMap[entry];
                if (flowUtils.notNull(value)) {
                    var subFormFields = JSON.parse(value);
                    if (subFormFields.length > 0) {
                        beControlFieldObj.append("<optgroup label='" + key + "'></optgroup>");
                    }
                    for (var j = 0; j < subFormFields.length; j++) {
                        beControlFieldObj.append("<option value='" +entry+"__"+subFormFields[j].colName + "' "
                            + " colType='" + subFormFields[j].colType + "'"
                            + " colName='" + entry + "__" +subFormFields[j].colName + "'"
                            + " colLabel='" + subFormFields[j].colLabel + "'"
                            + " selectedoption='" + subFormFields[j].selectedoption + "'"
                            + " selectedvalues='" + subFormFields[j].selectedvalues + "'"
                            + " elementType='eform_subtable_bpm_auth'"
                            + " domId='"+ subFormFields[j].domId + "'"
                            + " domType='" + subFormFields[j].domType + "'>" + subFormFields[j].colLabel + "(" + subFormFields[j].colName + ")" + "</option>");
                    }
                }

            }
        }
    }

    function changeOperability(obj){
        if($(obj).is(':checked')){
            $(obj).parentsUntil("tr").parent().find("#accessibility").prop("checked",true);
            $(obj).parentsUntil("tr").parent().find("#hideRow").prop("checked",false);
        }else{
            if( $(obj).parentsUntil("tr").parent().find("#required").is(':checked')){
                layer.alert("已配置必填，不能取消编辑！", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                $(obj).prop("checked",true);
            }
        }
    }

    function changeRequired(obj){
        if($(obj).is(':checked')){
            $(obj).parentsUntil("tr").parent().find("#accessibility").prop("checked",true);
            $(obj).parentsUntil("tr").parent().find("#operability").prop("checked",true);
            $(obj).parentsUntil("tr").parent().find("#hideRow").prop("checked",false);
        }
    }

    function changeAccessibility(obj){
        if($(obj).is(':checked')){
            $(obj).parentsUntil("tr").parent().find("#hideRow").prop("checked",false);
        }else{
            if($(obj).parentsUntil("tr").parent().find("#operability").is(':checked') || $(obj).parentsUntil("tr").parent().find("#required").is(':checked')){
                layer.alert("已配置可编辑或必填，不能隐藏！", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                $(obj).prop("checked",true);
            }
        }
    }

    function changeHideRow(obj){
        if($(obj).is(':checked')){
            $(obj).parentsUntil("tr").parent().find("#accessibility").prop("checked",false);
            $(obj).parentsUntil("tr").parent().find("#operability").prop("checked",false);
            $(obj).parentsUntil("tr").parent().find("#required").prop("checked",false);
            /*$(obj).parentsUntil("tr").parent().find("#accessibility").attr("disabled",true);
            $(obj).parentsUntil("tr").parent().find("#operability").attr("disabled",true);
            $(obj).parentsUntil("tr").parent().find("#required").attr("disabled",true);*/
        }
        /*else{
            $(obj).parentsUntil("tr").parent().find("#accessibility").attr("disabled",false);
            $(obj).parentsUntil("tr").parent().find("#operability").attr("disabled",false);
            $(obj).parentsUntil("tr").parent().find("#required").attr("disabled",false);
        }*/
    }

    function valid(){
        var controlFieldArr = $("select[name='controlField']");
        if(controlFieldArr && controlFieldArr.length){
            for(var i=0;i<controlFieldArr.length;i++){
                if(controlFieldArr[i].value==''){
                    controlFieldArr[i].focus();
                    layer.alert("请选择控制字段！", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                    return false;
                }
            }
        }else{
            layer.alert("请选择控制字段！", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
            return false;
        }
        var operArr = $("select[name='oper']");
        if(operArr && operArr.length){
            for(var i=0;i<operArr.length;i++){
                if(operArr[i].value==''){
                    operArr[i].focus();
                    layer.alert("请选择操作符！", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                    return false;
                }else if(operArr[i].value=='between'){
                    var beginValue = $(operArr[i]).parentsUntil("tr").parent().find("input[name='beginValue']").val();
                    var endValue = $(operArr[i]).parentsUntil("tr").parent().find("input[name='endValue']").val();
                    if(flowUtils.notNull(beginValue) || flowUtils.notNull(endValue)){
                        if(flowUtils.notNull(beginValue) && flowUtils.notNull(endValue)){
                            var controlField = $(operArr[i]).parentsUntil("tr").parent().find("select[name='controlField']");
                            var controlFieldSelected = controlField.find("option:selected");
                            var domType = controlFieldSelected.attr("domType");
                            if(domType=='number-box' || domType=='number'){
                                if(Number(beginValue)>Number(endValue)){
                                    layer.alert("区间起始值不能大于截止值！", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                                    return false;
                                }
                            }else{
                                if(beginValue>endValue){
                                    layer.alert("区间起始值不能大于截止值！", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                                    return false;
                                }
                            }

                        }
                    }else{
                        layer.alert("请选择区间值！", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                        return false;
                    }
                }

            }
        }else{
            layer.alert("请选择操作符！", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
            return false;
        }

        var beControledFieldArr = $("select[name='beControledField']");
        if(beControledFieldArr && beControledFieldArr.length){
            for(var i=0;i<beControledFieldArr.length;i++){
                if(beControledFieldArr[i].value==''){
                    beControledFieldArr[i].focus();
                    layer.alert("请选择被控制字段！", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                    return false;
                }
            }
        }else{
            layer.alert("请选择被控制字段！", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
            return false;
        }
        return true;
    }

    function getConditonValues(){
        var conditionArr = [];
        $("#conditionTable tbody").find("tr").each(function(){
            var controlField = $(this).find("select[name='controlField']");
            var controlFieldSelected = controlField.find("option:selected");
            var controlTag = controlField.val();
            var controlTagName = controlFieldSelected.attr("colLabel");
            var controlElementType = controlFieldSelected.attr("elementType");
            var controlDomId = controlFieldSelected.attr("domId");
            var controlDomType = controlFieldSelected.attr("domType");
            var oper = $(this).find("select[name='oper']").val();
            var operName = $(this).find("select[name='oper']").find("option:selected").text();
            var compareValue = $(this).find("#compareValue").val();
            var compareValueName = $(this).find("#compareValueName").val();
            var beginValue = "";
            var endValue = "";
            if(undefined==compareValueName || compareValueName ==''){
                compareValueName=compareValue;
            }
            if($(this).find("#compareValue").attr("type") == 'text'){
                compareValueName=compareValue;
            }
            /**
             * 下拉框
             */
            if(controlDomType == 'radio-box' || controlDomType == 'radio'
                || controlDomType == 'select-box' || controlDomType == 'select'){
                compareValueName = $(this).find("#compareValue option:selected").text();
            }

            /**
             * 密级控件
             */
            if(controlDomType == 'secret-box'){
                compareValueName = $(this).find("#compareValue option:selected").text();
            }

            /**
             * 复选框
             */
            if(controlDomType == 'check-box' || controlDomType == 'check'){
                compareValue = "";
                compareValueName = "";
                var checkboxs = $(this).find("input[type=checkbox][name=compareValue]:checked");
                if(checkboxs && checkboxs.length){
                    for(var i=0;i<checkboxs.length;i++){
                        if(i==(checkboxs.length-1)){
                            compareValue += $(checkboxs[i]).val();
                            compareValueName += $(checkboxs[i]).attr("valueName");
                        }else{
                            compareValue += $(checkboxs[i]).val()+"@@@";
                            compareValueName += $(checkboxs[i]).attr("valueName");
                        }
                    }
                }
            }

            if (controlDomType == 'user-box' || controlDomType == 'user'
                || controlDomType == 'dept-box' || controlDomType == 'dept'
                || controlDomType == 'position-box' || controlDomType == 'position'
                || controlDomType == 'role-box' || controlDomType == 'role'
                || controlDomType == 'group-box' || controlDomType == 'group'
                || controlDomType == 'org-box' || controlDomType == 'org'
                || controlDomType == 'waorg-box') {
                compareValue = replaceMark(compareValue);
            }
            //日期
            if (controlDomType == 'date-box' || controlDomType == 'date'){
                beginValue = $(this).find("input[name='beginValue']").val();
                endValue = $(this).find("input[name='endValue']").val();
                compareValue = beginValue + "@@@" + endValue;
                if(flowUtils.notNull(beginValue) && flowUtils.notNull(endValue)){
                    compareValueName = beginValue + " 至 " + endValue;
                }else if(flowUtils.notNull(beginValue)){
                    compareValueName = "大于等于 " + beginValue;
                }else if(flowUtils.notNull(beginValue)){
                    compareValueName = "小于等于 " + endValue;
                }
            }
            //数字
            if(controlDomType == 'number-box' || controlDomType == 'number'){
                beginValue = $(this).find("input[name='beginValue']").val();
                endValue = $(this).find("input[name='endValue']").val();
                compareValue = beginValue + "@@@" + endValue;
                if(flowUtils.notNull(beginValue) && flowUtils.notNull(endValue)){
                    compareValueName = beginValue + " 至 " + endValue;
                }else if(flowUtils.notNull(beginValue)){
                    compareValueName = "大于等于 " + beginValue;
                }else if(flowUtils.notNull(beginValue)){
                    compareValueName = "小于等于 " + endValue;
                }
            }

            var conditonName = controlTagName+" "+operName+" "+compareValueName;
            var conditonObj = {};
            conditonObj.controlTag = controlTag;
            conditonObj.controlTagName = controlTagName;
            conditonObj.controlElementType = controlElementType;
            conditonObj.controlDomId = controlDomId;
            conditonObj.controlDomType = controlDomType;
            conditonObj.oper = oper;
            conditonObj.operName = operName;
            conditonObj.compareValue = compareValue;
            conditonObj.compareValueName = compareValueName;
            conditonObj.conditonName = conditonName;
            conditionArr.push(conditonObj);
        });
        return conditionArr;
    }

    function getBeControledFields(){
        var beControledFields = [];
        $("#beControledFieldTable tbody>tr").each(function(){
            var beControledFieldObj = {};
            var beControledFieldSelected = $(this).find("select[name='beControledField'] option:selected");
            var tag = flowUtils.notNull(beControledFieldSelected.attr("domId"))?beControledFieldSelected.attr("domId"):beControledFieldSelected.val();
            var tagName = beControledFieldSelected.attr("colLabel");
            var elementType = beControledFieldSelected.attr("elementType");
            var domId = beControledFieldSelected.attr("domId");
            var domType = beControledFieldSelected.attr("domType");
            var accessibility = $(this).find("#accessibility").get(0).checked?"1":"0";
            var operability = $(this).find("#operability").get(0).checked?"1":"0";
            var required = $(this).find("#required").get(0).checked?"1":"0";
            var hideRow = $(this).find("#hideRow").get(0).checked?"1":"0";
            beControledFieldObj.tag = tag;
            beControledFieldObj.tagName = tagName;
            beControledFieldObj.elementType = elementType;
            beControledFieldObj.domId = domId;
            beControledFieldObj.domType = domType;
            beControledFieldObj.accessibility = accessibility;
            beControledFieldObj.operability = operability;
            beControledFieldObj.required = required;
            beControledFieldObj.hideRow = hideRow;
            beControledFields.push(beControledFieldObj);
        });
        return beControledFields;
    }

    function getConfigValue(){
        var conditonValues = getConditonValues();
        var beControledFields = getBeControledFields();
        var configValue = {
            conditonValues:conditonValues,
            beControledFields:beControledFields
        };
        return configValue;
    }

    /* 将字符串中的所有;替换为@@@ */
    function replaceMark(str) {
        if (str != null && str != '' && typeof str != 'undefined') {
            var reg = new RegExp(';', "g")
            var newstr = str.replace(reg, '@@@');
            return newstr;
        }
        return str;
    };

    function changeBeControledField(obj){
        var elementType = $(obj).find("option:selected").attr("elementType");
        //子表字段
        if(elementType == "eform_subtable_bpm_auth"){
            $(obj).parentsUntil("tr").parent().find("#hideRow").attr("disabled",true);
            $(obj).parentsUntil("tr").parent().find("#hideRow").prop("checked",false);
        }else {
            $(obj).parentsUntil("tr").parent().find("#hideRow").attr("disabled",false);
        }
        //子表、流程意见、图片
        if(elementType == "datatable"
            || elementType == "bpmopinion-box"
            //|| elementType == "photo-box"
        ){
            $(obj).parentsUntil("tr").parent().find("#operabilityLabel").hide();
            $(obj).parentsUntil("tr").parent().find("#requiredLabel").hide();
        }else{
            $(obj).parentsUntil("tr").parent().find("#operabilityLabel").show();
            $(obj).parentsUntil("tr").parent().find("#requiredLabel").show();
        }

    }

    function changeControlField(obj,oldConditon){
        var rowId = $(obj).parentsUntil("tr").parent().attr("rowId");
        var selectOption = $(obj).find("option:selected");
        var domType = selectOption.attr('domType');
        var colType = selectOption.attr("colType");
        if (colType == undefined) {
            colType = "";
        }
        var oper = $(obj).parentsUntil("tr").parent().find("select[name='oper']");
        oper.empty();
        //添加子元素
        if (domType == 'user-box' || domType == 'user'
            || domType == 'dept-box' || domType == 'dept'
            || domType == 'position-box' || domType == 'position'
            || domType == 'role-box' || domType == 'role'
            || domType == 'group-box' || domType == 'group'
            || domType == 'org-box' || domType == 'org'
            || domType == 'waorg-box'){
            oper.append("<option value=\"\">请选择</option>\n" +
                "                                <option value=\"eq\">等于</option>\n" +
                "                                <option value=\"noteq\">不等于</option>\n" +
                "                                <option value=\"in\">属于</option>\n" +
                "                                <option value=\"notin\">不属于</option>\n");
            //+"                                <option value=\"like\">包含</option>\n");
        }else if (domType == 'check-box' || domType == 'check') {//复选框
            oper.append("<option value=\"\">请选择</option>\n" +
                "                                <option value=\"allin\">全部属于</option>\n" +
                "                                <option value=\"allnotin\">全部不属于</option>\n" +
                "                                <option value=\"partin\">部分属于</option>\n" +
                "                                <option value=\"partnotin\">部分不属于</option>\n");
        }else if(domType == 'number-box' || domType == 'number'){
            oper.append("<option value=\"between\">区间</option>\n");
        }else if(domType == 'date-box' || domType == 'date'){
            oper.append("<option value=\"between\">区间</option>\n");
        }else if(colType.toLowerCase()=='string'
            || colType.toLowerCase()=='varchar2'){

            oper.append("<option value=\"\">请选择</option>\n" +
                "                                <option value=\"eq\">等于</option>\n" +
                "                                <option value=\"noteq\">不等于</option>\n" +
                "                                <option value=\"in\">属于</option>\n" +
                "                                <option value=\"notin\">不属于</option>\n"+
                "                                <option value=\"like\">包含</option>\n"+
                "                                <option value=\"notlike\">不包含</option>\n");

        }else{
            oper.append("<option value=\"\">请选择</option>\n" +
                "                                <option value=\"eq\">等于</option>\n" +
                "                                <option value=\"noteq\">不等于</option>\n" +
                "                                <option value=\"in\">属于</option>\n" +
                "                                <option value=\"notin\">不属于</option>\n" +
                "                                <option value=\"like\">包含</option>\n"+
                "                                <option value=\"notlike\">不包含</option>\n");
        }

        var html = '';
        var compareValueDivObj = $(obj).parentsUntil("tr").parent().find("#compareValueDiv");
        compareValueDivObj.removeAttr("style");
        //选人
        if (domType == 'user-box' || domType == 'user') {
            html = '<div class="input-group  input-group-sm" id="inputDiv">'
                + ' <input type="hidden" id="compareValue" name="compareValue">'
                + ' <input class="form-control" placeholder="请选择用户" type="text"'
                + ' id="compareValueName" name="compareValueName" readonly>'
                + ' <span class="input-group-addon" id="userbtn">'
                + ' <i	class="glyphicon glyphicon-user"></i>'
                + ' </span>'
                + ' </div>';
            compareValueDivObj.html(html);
            compareValueDivObj.find('#compareValueName').on('focus', function (e) {
                new H5CommonSelect({
                    type: 'userSelect',
                    //idFiled: 'compareValue',
                    //textFiled: 'compareValueName',
                    viewScope: 'currentOrg',
                    selectModel: 'multi',
                    callBack:function(obj){
                        compareValueDivObj.find("#compareValue").val(obj.userids);
                        compareValueDivObj.find("#compareValueName").val(obj.usernames);
                    }
                });
            });

            compareValueDivObj.find('#compareValueName').parent().find(".input-group-addon").unbind("click.auto").bind("click.auto", function () {
                $(this).parent().find('input[type="text"]').trigger('focus');
            });

        } else if (domType == 'dept-box' || domType == 'dept') {//选部门
            html = '<div class="input-group  input-group-sm" id="inputDiv">'
                + ' <input type="hidden" id="compareValue" name="compareValue">'
                + ' <input class="form-control" placeholder="请选择部门" type="text" id="compareValueName" name="compareValueName" readonly>'
                + ' <span class="input-group-addon" id="deptbtn">'
                + ' <i	class="glyphicon glyphicon-equalizer"></i>'
                + ' </span>'
                + ' </div>';
            compareValueDivObj.html(html);
            compareValueDivObj.find('#compareValueName').on('focus', function (e) {
                new H5CommonSelect({
                    type: 'deptSelect',
                    //idFiled: 'compareValue',
                    //textFiled: 'compareValueName',
                    viewScope: 'currentOrg',
                    selectModel: 'multi',
                    callBack:function(obj){
                        compareValueDivObj.find("#compareValue").val(obj.deptids);
                        compareValueDivObj.find("#compareValueName").val(obj.deptnames);
                    }
                });
            });

            compareValueDivObj.find('#compareValueName').parent().find(".input-group-addon").unbind("click.auto").bind("click.auto", function () {
                $(this).parent().find('input[type="text"]').trigger('focus');
            });

        } else if (domType == 'position-box' || domType == 'position') {//选岗位
            html = '<div class="input-group  input-group-sm" id="inputDiv">'
                + ' <input type="hidden" id="compareValue" name="compareValue">'
                + ' <input class="form-control" placeholder="请选择岗位" type="text" id="compareValueName" name="compareValueName" readonly>'
                + ' <span class="input-group-addon" id="deptbtn">'
                + ' <i	class="glyphicon glyphicon-equalizer"></i>'
                + ' </span>'
                + ' </div>';
            compareValueDivObj.html(html);
            compareValueDivObj.find('#compareValueName').on('focus', function (e) {
                new H5CommonSelect({
                    type: 'positionSelect',
                    //idFiled: 'compareValue',
                    //textFiled: 'compareValueName',
                    viewScope: 'currentOrg',
                    selectModel: 'multi',
                    callBack:function(obj){
                        compareValueDivObj.find("#compareValue").val(obj.positionids);
                        compareValueDivObj.find("#compareValueName").val(obj.positionNames);
                    }
                });
            });

            compareValueDivObj.find('#compareValueName').parent().find(".input-group-addon").unbind("click.auto").bind("click.auto", function () {
                $(this).parent().find('input[type="text"]').trigger('focus');
            });
        } else if (domType == 'role-box' || domType == 'role') {//选角色
            html = '<div class="input-group  input-group-sm" id="inputDiv">'
                + ' <input type="hidden" id="compareValue" name="compareValue">'
                + ' <input class="form-control" placeholder="请选择角色" type="text" id="compareValueName" name="compareValueName" readonly>'
                + ' <span class="input-group-addon" id="deptbtn">'
                + ' <i	class="glyphicon glyphicon-equalizer"></i>'
                + ' </span>'
                + ' </div>';
            compareValueDivObj.html(html);
            compareValueDivObj.find('#compareValueName').on('focus', function (e) {
                new H5CommonSelect({
                    type: 'roleSelect',
                    //idFiled: 'compareValue',
                    //textFiled: 'compareValueName',
                    viewScope: 'currentOrg',
                    selectModel: 'multi',
                    callBack:function(obj){
                        compareValueDivObj.find("#compareValue").val(obj.roleids);
                        compareValueDivObj.find("#compareValueName").val(obj.roleNames);
                    }
                });
            });
            compareValueDivObj.find('#compareValueName').parent().find(".input-group-addon").unbind("click.auto").bind("click.auto", function () {
                $(this).parent().find('input[type="text"]').trigger('focus');
            });
        } else if (domType == 'group-box' || domType == 'group') {//选群组
            html = '<div class="input-group  input-group-sm" id="inputDiv">'
                + ' <input type="hidden" id="compareValue" name="compareValue">'
                + ' <input class="form-control" placeholder="请选择群组" type="text" id="compareValueName" name="compareValueName" readonly>'
                + ' <span class="input-group-addon" id="deptbtn">'
                + ' <i	class="glyphicon glyphicon-equalizer"></i>'
                + ' </span>'
                + ' </div>';
            compareValueDivObj.html(html);
            compareValueDivObj.find('#compareValueName').on('focus', function (e) {
                new H5CommonSelect({
                    type: 'groupSelect',
                    //idFiled: 'compareValue',
                    //textFiled: 'compareValueName',
                    viewScope: 'currentOrg',
                    selectModel: 'multi',
                    callBack:function(obj){
                        compareValueDivObj.find("#compareValue").val(obj.groupids);
                        compareValueDivObj.find("#compareValueName").val(obj.groupNames);
                    }
                });
            });
            compareValueDivObj.find('#compareValueName').parent().find(".input-group-addon").unbind("click.auto").bind("click.auto", function () {
                $(this).parent().find('input[type="text"]').trigger('focus');
            });
        } else if (domType == 'org-box' || domType == 'org') {//选组织
            html = '<div class="input-group  input-group-sm" id="inputDiv">'
                + ' <input type="hidden" id="compareValue" name="compareValue">'
                + ' <input class="form-control" placeholder="请选择组织" type="text" id="compareValueName" name="compareValueName" readonly>'
                + ' <span class="input-group-addon" id="orgbtn">'
                + ' <i	class="glyphicon glyphicon-equalizer"></i>'
                + ' </span>'
                + ' </div>';
            compareValueDivObj.html(html);
            compareValueDivObj.find('#compareValueName').on('focus', function (e) {
                new H5CommonSelect({
                    type: 'orgSelect',
                    //idFiled: 'compareValue',
                    //textFiled: 'compareValueName',
                    viewScope: 'currentOrg',
                    selectModel: 'multi',
                    callBack:function(obj){
                        compareValueDivObj.find("#compareValue").val(obj.orgids);
                        compareValueDivObj.find("#compareValueName").val(obj.orgnames);
                    }
                });
            });
            compareValueDivObj.find('#compareValueName').parent().find(".input-group-addon").unbind("click.auto").bind("click.auto",function(){
                $(this).parent().find('input[type="text"]').trigger('focus');
            });
        } else if (domType == 'waorg-box' || domType == 'waorg-box') {//网安自定义（选组织）
            html = '<div class="input-group  input-group-sm" id="inputDiv">'
                + ' <input type="hidden" id="compareValue" name="compareValue">'
                + ' <input class="form-control" placeholder="请选择组织" type="text" id="compareValueName" name="compareValueName" readonly>'
                + ' <span class="input-group-addon" id="orgbtn">'
                + ' <i	class="glyphicon glyphicon-equalizer"></i>'
                + ' </span>'
                + ' </div>';
            compareValueDivObj.html(html);
            compareValueDivObj.find('#compareValueName').on('focus', function (e) {
                new H5CommonSelect({
                    type: 'orgSelect',
                    //idFiled: 'compareValue',
                    //textFiled: 'compareValueName',
                    viewScope: 'currentOrg',
                    selectModel: 'multi',
                    callBack:function(obj){
                        compareValueDivObj.find("#compareValue").val(obj.orgids);
                        compareValueDivObj.find("#compareValueName").val(obj.orgnames);
                    }
                });
            });

            compareValueDivObj.find('#compareValueName').parent().find(".input-group-addon").unbind("click.auto").bind("click.auto",function(){
                $(this).parent().find('input[type="text"]').trigger('focus');
            });
        }else if (domType == 'date-box' || domType == 'date') {//日期
            var beginValue = "";
            var endValue = "";
            var selectedValue = oldConditon?oldConditon.compareValue:"";
            if(flowUtils.notNull(selectedValue)){
                var selectedAttr = selectedValue.split("@@@");
                beginValue = selectedAttr[0];
                endValue = selectedAttr[1];
            }
            html = '';
            html += '<label style="width:45%;">';
            html += '<div class="input-group input-group-sm">';
            html +=  ' <input class="form-control datetime-picker" value="'+beginValue+'" type="text"' + ' name="beginValue" id="beginValue_'+rowId+'" readonly/>';
            html +=  ' <span	class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>';
            html += ' </div>';
            html += '</label>';
            html += '<label>';
            html +='至';
            html += '</label>';
            html += '<label style="width:45%;">';
            html += '<div class="input-group input-group-sm">';
            html += ' <input class="form-control datetime-picker" value="'+endValue+'" type="text"' + ' name="endValue" id="endValue_'+rowId+'" readonly/>';
            html += ' <span	class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>';
            html += ' </div>';
            html += '</label>';
            compareValueDivObj.html(html);
            compareValueDivObj.attr("style","display-inline;");
            compareValueDivObj.find('.date-picker').datepicker();
            compareValueDivObj.find('.datetime-picker').datetimepicker({
                oneLine:true,//单行显示时分秒
                closeText:'确定',//关闭按钮文案
                showButtonPanel:true,//是否展示功能按钮面板
                showSecond:false,//是否可以选择秒，默认否
            });
            compareValueDivObj.find('.date-picker').on('keydown',nullInput);
            compareValueDivObj.find('.time-picker').on('keydown', nullInput);

        }else if (domType == 'number-box' || domType == 'number') {//数字
            var beginValue = "0";
            var endValue = "0";
            var selectedValue = oldConditon?oldConditon.compareValue:"";
            if(flowUtils.notNull(selectedValue)){
                var selectedAttr = selectedValue.split("@@@");
                beginValue = selectedAttr[0];
                endValue = selectedAttr[1];
            }
            html = '<label style="width:45%;"><div class="input-group input-group-sm spinner" data-trigger="spinner">'
                + ' <input type="text" class="form-control" value="'+beginValue+'" name="beginValue" id="beginValue"  data-min="-99999999999999999999" data-max="99999999999999999999" data-hascommafy="" data-step="1" data-precision="0" maxlength="20" />'
                + ' <span	class="input-group-addon number-box-act">'
                + '<a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>'
                + '<a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a></span>'
                +' </div></label>';
            html += '<label>至</label>';
            html += '<label style="width:45%;"><div class="input-group input-group-sm spinner" data-trigger="spinner">'
                + ' <input type="text" class="form-control" value="'+endValue+'" name="endValue" id="endValue"  data-min="-99999999999999999999" data-max="99999999999999999999" data-hascommafy="" data-step="1" data-precision="0" maxlength="20" />'
                + ' <span	class="input-group-addon number-box-act">'
                + '<a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>'
                + '<a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a></span>'
                +' </div></label>';
            compareValueDivObj.html(html);
            compareValueDivObj.find('#beginValue').parent('[data-trigger="spinner"]').spinner();
            compareValueDivObj.find('.number-box-act').click(function(event) {
                compareValueDivObj.find('#beginValue').trigger('click');
            });
            compareValueDivObj.find('#endValue').parent('[data-trigger="spinner"]').spinner();
            compareValueDivObj.find('.number-box-act').click(function(event) {
                compareValueDivObj.find('#endValue').trigger('click');
            });
            compareValueDivObj.attr("style","display-inline;");
        } else if (domType == 'radio-box' || domType == 'radio'
            || domType == 'select-box' || domType == 'select') {//下拉
            var selectedoption =  selectOption.attr("selectedoption");
            var selectedvalues =  selectOption.attr("selectedvalues");
            var options = "";
            if(selectedoption != null && selectedoption !=undefined){
                if(selectedoption.lastIndexOf(",")==(selectedoption.length-1)){
                    selectedoption = selectedoption.substring(0,selectedoption.length-1);
                }
                var selectedoptionArray = selectedoption.split(",");
                var selectedvaluesArray = selectedvalues.split(",");
                for(var i = 0; i< selectedoptionArray.length;i++){
                    options += "<option value='"+selectedvaluesArray[i]+"' >"+selectedoptionArray[i]+"</option>";
                }
            }
            html = '<select class="form-control input-sm" id="compareValue" name="compareValue">'
                + options
                +' </select>';
            compareValueDivObj.html(html);

        }else if (domType == 'check-box' || domType == 'check') {//复选框
            var selectedoption =  selectOption.attr("selectedoption");
            var selectedvalues =  selectOption.attr("selectedvalues");

            var selectedValue = oldConditon?oldConditon.compareValue:"";
            var selectedAttr = [];
            if(selectedValue!=undefined && selectedValue!=null && selectedValue!=""){
                selectedAttr = selectedValue.split("@@@");
            }
            var html = "";
            if(selectedoption != null && selectedoption !=undefined){
                if(selectedoption.lastIndexOf(",")==(selectedoption.length-1)){
                    selectedoption = selectedoption.substring(0,selectedoption.length-1);
                }
                var selectedoptionArray = selectedoption.split(",");
                var selectedvaluesArray = selectedvalues.split(",");
                for(var i = 0; i< selectedoptionArray.length;i++){
                    var checkedStr = "";
                    if(selectedAttr && selectedAttr.length){
                        for(var j=0;j<selectedAttr.length;j++){
                            if(selectedvaluesArray[i] == selectedAttr[j]){
                                checkedStr = "checked";
                                break;
                            }
                        }
                    }
                    html+="<input type='checkbox' "+checkedStr+"   value='"+selectedvaluesArray[i]+"' valueName='"+selectedoptionArray[i]+"' name='compareValue'>&nbsp;"+selectedoptionArray[i];
                }
            }
            compareValueDivObj.html(html);
        }else if(domType == 'secret-box' || domType == 'secret'){
            var options = "";
            for(var i = 0; i< secretList.length;i++){
                options += "<option value='"+secretList[i].lookupCode+"' >"+secretList[i].lookupName+"</option>";
            }
            html = '<select class="form-control input-sm" id="compareValue" name="compareValue">'
                + options
                +' </select>';
            compareValueDivObj.html(html);
        }else {
            html = '<div class="input-group  input-group-sm" id="inputDiv">'
                + ' <input type="hidden" id="compareValueName" name="compareValueName">'
                + ' <input class="form-control"  type="text"'
                + ' id="compareValue" name="compareValue" title="输入多个值时请用 @@@进行分割">'
                + ' </div>';
            compareValueDivObj.html(html);

        }
        if(flowUtils.notNull(oldConditon)){
            oper.val(oldConditon.oper);
            if(!(domType == "check-box" || domType == "check"
                || domType == 'number-box' || domType == 'number'
                || domType == 'date-box' || domType == 'date')){
                compareValueDivObj.find('#compareValue').val(oldConditon.compareValue);
                compareValueDivObj.find('#compareValueName').val(oldConditon.compareValueName);
            }
        }
    }
</script>
</body>
</html>