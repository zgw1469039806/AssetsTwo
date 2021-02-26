<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ExprConfig/vtree/css/vtree.css">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class=" easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <div>
        <form id='form'>
            <table class="form_commonTable" border="0">
                <tr>
                    <th width="7%" style="word-break: break-all; word-warp: break-word;"><label for="fieldAttr">字段:</label></th>
                    <td width="25%">
                        <select class="form-control input-sm"  name="fieldAttr" id="fieldAttr" title="" onChange="changeField()">
                            <option value="">&nbsp;&nbsp;&nbsp;请选择</option>
                        </select>
                    </td>
                    <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="oper">操作符:</label></th>
                    <td width="15%">
                        <select class="form-control input-sm" name="oper" id="oper" title="">
                            <option value="">请选择</option>

                        </select>

                    </td>
                    <th width="13%" style="word-break: break-all; word-warp: break-word;">
                        <label for="theValue">值:</label>
                        <input type="checkbox"  value="option1" name="varia" id="varia" onclick="selectVarType(this);">变量</input>
                    </th>
                    <td width="20%">
                        <div id="compareValueDiv">
                            <input title="输入多个值时请用 @@@进行分割" class="form-control input-sm" type="text" name="compareValue" id="compareValue" />
                            <input type="hidden" name="compareValueName" id="compareValueName"/>
                        </div>
                        <div  name="compareDiv" id="compareDiv" style="display: none">
                            <select class="form-control input-sm"  name="compareAttr" id="compareAttr" onChange="selectCompareAttr()">
                            	<option value="">&nbsp;&nbsp;&nbsp;请选择</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th width="7%" style="word-break: break-all; word-warp: break-word;">
                       <label id="spanActivityName" for="activityName" style="display:none;">节点:</label>
                    </th>
                    <td width="25%">
                        <input type="hidden" name="activityId" id="activityId"/>
                        <input type="text" name="activityName" id="activityName" onClick="selectActivity(1)" readonly style="display:none;"/>
                    </td>
                    <th width="10%">
                    </th>
                    <td width="15%">
                    </td>
                    <th width="13%" style="word-break: break-all; word-warp: break-word;">
                    	<label id="spanValueActivityName" for="valueActivityName" style="display:none;">节点:</label>
                    </th>
                    <td width="25%">
                    	<input type="hidden" name="valueActivityId" id="valueActivityId"/>
                        <input type="text" name="valueActivityName" id="valueActivityName" onClick="selectActivity()" readonly style="display:none;"/>
                    </td>
                </tr>
            </table>

        </form>
    </div>
    <div style="margin-left: 40px">
			<button class="btn btn-default form-tool-btn btn-sm" id="configBtn" name="configBtn" style="width:100px;left:50px" onclick="setCellConfig()">设&nbsp;值</button>
        <%--<button class="btn btn-default form-tool-btn btn-sm" id="compute" name="compute" style="width:100px;left:50px" >计算表达式</button>--%>
    </div>
    <div style="margin-left: 20px">
        <%--<button class="getResult">获取json</button>--%>
        <%--<button class="setJsontest">给“用户名等于张三”设置新json</button>--%>
        <div class="vTree" style="margin:5px auto 0;border:1px solid #000">
        </div>
    </div>
    <div id="resDiv" hidden="true">
        <div id="computeLine" hidden="true"></div>
        <div id="longJson" hidden="true">藏起来</div>
    </div>
</div>

</body>

<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>

</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ExprConfig/vtree/js/jquery.vtree.js"></script>
<script>
    var selCellId = null;//记录选中的树节点
    var newCellId = null;//记录新建的树节点
    var needChildFlag = false;//标记逻辑节点需要子节点
    var isConfigUpdate = '';
    var process;
    var secretList;//密级
    //初始化数据
    testData2 = {
        "id": "root-0-0",
        "pId": "",
        "type": "1",
        "fieldId": "AND",
        "fieldName": "AND",
        "fieldType": "3",
        "fieldShowType": "",
        "tableName": "",
        "compareType": "",
        "compareTypeName": "",
        "compareValue": "",
        "compareValueName": "",
        "dataId": "a111",
        "dataSourceId": "dataSourceId66",
        "formId": "formId66",
        "mainTableName": "mainTableName66",
        "compareValueFieldName":"",
        "compareValueFieldDataType":""
    };

    function selectCompareAttr(){
    	var value = $("#compareAttr option:selected").val();
    	//某一节点处理人，某人节点处理人所属部门、角色、群组、岗位 弹出流程节点选择框
        if(value=='somePerfomer' || value=='somePerfomerDept'
            || value=='somePerfomerRole' || value=='somePerfomerGroup'
                || value=='somePerfomerPosition'){
            $("#spanValueActivityName").show();
            $("#valueActivityName").show();
        }else{
            $("#spanValueActivityName").hide();
			$("#valueActivityName").hide();
			$("#valueActivityName").val("");
			$("#valueActivityId").val("");
        }
    }

    function selectActivity(isField){
    	layer.open({
            type:  2,
            area: [ "400px",  "350px"],
            title: "流程节点选择框",
            skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
            shade:   0.3,
            maxmin: false, //开启最大化最小化按钮
            content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ExprConfig/TaskNodeSelect.jsp",
            btn: ['确定', '关闭'],
            yes: function(index, layero){
                var iframeWin = layero.find('iframe')[0].contentWindow;
                if(flowUtils.notNull(iframeWin.stepId, iframeWin.stepName)){
                    if(isField==1){
                    	$("#activityId").val(iframeWin.stepId);
                    	$("#activityName").val(iframeWin.stepName);
                    }else{
                    	$("#valueActivityId").val(iframeWin.stepId);
                    	$("#valueActivityName").val(iframeWin.stepName);
                    }

                    layer.close(index);
                }else {
                    flowUtils.warning("请先选择数据")
                }
            }
        });
    }

    function changeField() {
        //需要和操作符进行二级联动
        var isSubTab = $("#fieldAttr option:selected").attr("subFlag");
        var isSpecType = $("#fieldAttr option:selected").attr("fieldShowType");
        var fieldDataType = $("#fieldAttr option:selected").attr("fieldDataType");
        var colType = $("#fieldAttr option:selected").attr("colType");
        if(colType==undefined){
        	colType = "";
        }
        if (typeof isSubTab == "undefined") {
            //选主表 流程变量和常量时
            //保证不重复添加
            $("#oper").empty();
            //添加子元素
            if (isSpecType == 'user-box' || isSpecType == 'user'
                || isSpecType == 'dept-box' || isSpecType == 'dept'
                || isSpecType == 'position-box' || isSpecType == 'position'
                || isSpecType == 'role-box' || isSpecType == 'role'
                || isSpecType == 'group-box' || isSpecType == 'group'
                || isSpecType == 'org-box' || isSpecType == 'org'
                || isSpecType == 'waorg-box'){
                $("#oper").append("<option value=\"\">请选择</option>\n" +
                    "                                <option value=\"eq\">等于</option>\n" +
                    "                                <option value=\"noteq\">不等于</option>\n" +
                    "                                <option value=\"in\">属于</option>\n" +
                    "                                <option value=\"notin\">不属于</option>\n");
                    //+"                                <option value=\"like\">包含</option>\n");
            }else if(isSpecType == 'number-box' || isSpecType == 'number'
                ||isSpecType == 'date-box' || isSpecType == 'date'){
                $("#oper").append("<option value=\"\">请选择</option>\n" +
                    "                                <option value=\"gt\">大于</option>\n" +
                    "                                <option value=\"gteq\">大于等于</option>\n" +
                    "                                <option value=\"lt\">小于</option>\n" +
                    "                                <option value=\"lteq\">小于等于</option>\n" +
                    "                                <option value=\"eq\">等于</option>\n" +
                    "                                <option value=\"noteq\">不等于</option>\n");
            }else if(isSpecType == 'select-box' || isSpecType == 'select'
                || isSpecType == 'secret-box' || isSpecType == 'secret'){
                $("#oper").append("<option value=\"\">请选择</option>\n" +
                    "                                <option value=\"gt\">大于</option>\n" +
                    "                                <option value=\"gteq\">大于等于</option>\n" +
                    "                                <option value=\"lt\">小于</option>\n" +
                    "                                <option value=\"lteq\">小于等于</option>\n" +
                    "                                <option value=\"eq\">等于</option>\n" +
                    "                                <option value=\"noteq\">不等于</option>\n" +
                    "                                <option value=\"in\">属于</option>\n" +
                    "                                <option value=\"notin\">不属于</option>\n"+
                    "                                <option value=\"like\">包含</option>\n");
            }else if(colType.toLowerCase()=='string'
            	|| colType.toLowerCase()=='varchar2'){
            	$("#oper").append("<option value=\"\">请选择</option>\n" +
                        "                                <option value=\"eq\">等于</option>\n" +
                        "                                <option value=\"noteq\">不等于</option>\n" +
                        "                                <option value=\"in\">属于</option>\n" +
                        "                                <option value=\"notin\">不属于</option>\n"+
                        "                                <option value=\"like\">包含</option>\n"+
                        "                                <option value=\"notlike\">不包含</option>\n");
            }else{
                $("#oper").append("<option value=\"\">请选择</option>\n" +
                    "                                <option value=\"gt\">大于</option>\n" +
                    "                                <option value=\"gteq\">大于等于</option>\n" +
                    "                                <option value=\"lt\">小于</option>\n" +
                    "                                <option value=\"lteq\">小于等于</option>\n" +
                    "                                <option value=\"eq\">等于</option>\n" +
                    "                                <option value=\"noteq\">不等于</option>\n" +
                    "                                <option value=\"in\">属于</option>\n" +
                    "                                <option value=\"notin\">不属于</option>\n" +
                    "                                <option value=\"like\">包含</option>\n");
            }

        } else if (isSubTab == "true") {
            //选子表字段时
            //保证不重复添加
            $("#oper").empty();
            //添加子元素
            if (isSpecType == 'user-box' || isSpecType == 'user'
                || isSpecType == 'dept-box' || isSpecType == 'dept'
                || isSpecType == 'position-box' || isSpecType == 'position'
                || isSpecType == 'role-box' || isSpecType == 'role'
                || isSpecType == 'group-box' || isSpecType == 'group'
                || isSpecType == 'org-box' || isSpecType == 'org'
                || isSpecType == 'waorg-box'){
                $("#oper").append("<option value=\"\">请选择</option>\n" +
                    "                                <option value=\"allin\">全部属于</option>\n" +
                    "                                <option value=\"allnotin\">全部不属于</option>\n" +
                    "                                <option value=\"partin\">部分属于</option>\n" +
                    "                                <option value=\"partnotin\">部分不属于</option>\n");
            }else if(isSpecType == 'number-box' || isSpecType == 'number'
                ||isSpecType == 'date-box' || isSpecType == 'date'){
                $("#oper").append("<option value=\"\">请选择</option>\n" +
                    "                                <option value=\"allgt\">全部大于</option>\n" +
                    "                                <option value=\"allgteq\">全部大于等于</option>\n" +
                    "                                <option value=\"alllt\">全部小于</option>\n" +
                    "                                <option value=\"alllteq\">全部小于等于</option>\n" +
                    "                                <option value=\"alleq\">全部等于</option>\n" +
                    "                                <option value=\"allnoteq\">全部不等于</option>\n" +
                    "                                <option value=\"partgt\">部分大于</option>\n" +
                    "                                <option value=\"partgteq\">部分大于等于</option>\n" +
                    "                                <option value=\"partlt\">部分小于</option>\n" +
                    "                                <option value=\"partlteq\">部分小于等于</option>\n" +
                    "                                <option value=\"parteq\">部分等于</option>\n" +
                    "                                <option value=\"partnoteq\">部分不等于</option>\n");
            }else if(isSpecType == 'select-box' || isSpecType == 'select'
                || isSpecType == 'secret-box' || isSpecType == 'secret'){
                $("#oper").append("<option value=\"\">请选择</option>\n" +
                    "                                <option value=\"allgt\">全部大于</option>\n" +
                    "                                <option value=\"allgteq\">全部大于等于</option>\n" +
                    "                                <option value=\"alllt\">全部小于</option>\n" +
                    "                                <option value=\"alllteq\">全部小于等于</option>\n" +
                    "                                <option value=\"alleq\">全部等于</option>\n" +
                    "                                <option value=\"allnoteq\">全部不等于</option>\n" +
                    "                                <option value=\"allin\">全部属于</option>\n" +
                    "                                <option value=\"allnotin\">全部不属于</option>\n" +
                    "                                <option value=\"alllike\">全部包含</option>\n" +
                    "                                <option value=\"partgt\">部分大于</option>\n" +
                    "                                <option value=\"partgteq\">部分大于等于</option>\n" +
                    "                                <option value=\"partlt\">部分小于</option>\n" +
                    "                                <option value=\"partlteq\">部分小于等于</option>\n" +
                    "                                <option value=\"parteq\">部分等于</option>\n" +
                    "                                <option value=\"partnoteq\">部分不等于</option>\n" +
                    "                                <option value=\"partin\">部分属于</option>\n" +
                    "                                <option value=\"partnotin\">部分不属于</option>\n" +
                    "                                <option value=\"partlike\">部分包含</option>");
            }else if(colType.toLowerCase()=='string'
            	|| colType.toLowerCase()=='varchar2'){
            	$("#oper").append("<option value=\"\">请选择</option>\n" +

                        "                                <option value=\"allin\">全部属于</option>\n" +
                        "                                <option value=\"allnotin\">全部不属于</option>\n" +
                        "                                <option value=\"alllike\">全部包含</option>\n" +
                        "                                <option value=\"partin\">部分属于</option>\n" +
                        "                                <option value=\"partnotin\">部分不属于</option>\n" +
                        "                                <option value=\"partlike\">部分包含</option>");
            }else{
                $("#oper").append("<option value=\"\">请选择</option>\n" +
                    "                                <option value=\"allgt\">全部大于</option>\n" +
                    "                                <option value=\"allgteq\">全部大于等于</option>\n" +
                    "                                <option value=\"alllt\">全部小于</option>\n" +
                    "                                <option value=\"alllteq\">全部小于等于</option>\n" +
                    "                                <option value=\"alleq\">全部等于</option>\n" +
                    "                                <option value=\"allnoteq\">全部不等于</option>\n" +
                    "                                <option value=\"allin\">全部属于</option>\n" +
                    "                                <option value=\"allnotin\">全部不属于</option>\n" +
                    "                                <option value=\"alllike\">全部包含</option>\n" +
                    "                                <option value=\"partgt\">部分大于</option>\n" +
                    "                                <option value=\"partgteq\">部分大于等于</option>\n" +
                    "                                <option value=\"partlt\">部分小于</option>\n" +
                    "                                <option value=\"partlteq\">部分小于等于</option>\n" +
                    "                                <option value=\"parteq\">部分等于</option>\n" +
                    "                                <option value=\"partnoteq\">部分不等于</option>\n" +
                    "                                <option value=\"partin\">部分属于</option>\n" +
                    "                                <option value=\"partnotin\">部分不属于</option>\n" +
                    "                                <option value=\"partlike\">部分包含</option>");
            }
        }

        var value = $('#fieldAttr').val();
        if (value != '') {
            var fieldType = $('#fieldAttr option:selected').attr('fieldType');
            if (fieldType == '1' || fieldType == '2' || fieldType == '3' || fieldType == '4') {
                var fieldShowType = $('#fieldAttr option:selected').attr('fieldShowType');
                var html = '';
                $('#varia').prop("checked", false);
                $("#compareValueDiv").removeAttr("style");
                $("#compareDiv").css('display','none');
                //选人
                if (fieldShowType == 'user-box' || fieldShowType == 'user') {
                    html = '<div class="input-group  input-group-sm" id="inputDiv">'
                        + ' <input type="hidden" id="compareValue" name="compareValue">'
                        + ' <input class="form-control" placeholder="请选择用户" type="text"'
                        + ' id="compareValueName" name="compareValueName" readonly>'
                        + ' <span class="input-group-addon" id="userbtn">'
                        + ' <i	class="glyphicon glyphicon-user"></i>'
                        + ' </span>'
                        + ' </div>';
                    $("#compareValueDiv").html(html);
                    $('#compareValueName').on('focus', function (e) {
                        new H5CommonSelect({
                            type: 'userSelect',
                            idFiled: 'compareValue',
                            textFiled: 'compareValueName',
                            viewScope: 'all',
                            selectModel: 'multi'
                        });
                    });

                    $("#compareValueName").parent().find(".input-group-addon").unbind("click.auto").bind("click.auto",function(){
                        $(this).parent().find('input[type="text"]').trigger('focus');
    				});

                } else if (fieldShowType == 'dept-box' || fieldShowType == 'dept') {//选部门
                    html = '<div class="input-group  input-group-sm" id="inputDiv">'
                        + ' <input type="hidden" id="compareValue" name="compareValue">'
                        + ' <input class="form-control" placeholder="请选择部门" type="text" id="compareValueName" name="compareValueName" readonly>'
                        + ' <span class="input-group-addon" id="deptbtn">'
                        + ' <i	class="glyphicon glyphicon-equalizer"></i>'
                        + ' </span>'
                        + ' </div>';
                    $("#compareValueDiv").html(html);
                    $('#compareValueName').on('focus', function (e) {
                        new H5CommonSelect({
                            type: 'deptSelect',
                            idFiled: 'compareValue',
                            textFiled: 'compareValueName',
                            viewScope: 'all',
                            selectModel: 'multi'
                        });
                    });

                    $("#compareValueName").parent().find(".input-group-addon").unbind("click.auto").bind("click.auto",function(){
                        $(this).parent().find('input[type="text"]').trigger('focus');
    				});
                }else if (fieldShowType == 'org-box' || fieldShowType == 'org') {//选组织
                    html = '<div class="input-group  input-group-sm" id="inputDiv">'
                        + ' <input type="hidden" id="compareValue" name="compareValue">'
                        + ' <input class="form-control" placeholder="请选择组织" type="text" id="compareValueName" name="compareValueName" readonly>'
                        + ' <span class="input-group-addon" id="orgbtn">'
                        + ' <i	class="glyphicon glyphicon-equalizer"></i>'
                        + ' </span>'
                        + ' </div>';
                    $("#compareValueDiv").html(html);
                    $('#compareValueName').on('focus', function (e) {
                        new H5CommonSelect({
                            type: 'orgSelect',
                            idFiled: 'compareValue',
                            textFiled: 'compareValueName',
                            viewScope: 'all',
                            selectModel: 'multi'
                        });
                    });

                    $("#compareValueName").parent().find(".input-group-addon").unbind("click.auto").bind("click.auto",function(){
                        $(this).parent().find('input[type="text"]').trigger('focus');
                    });
                } else if (fieldShowType == 'waorg-box') {//网安自定义（选组织）
                    html = '<div class="input-group  input-group-sm" id="inputDiv">'
                        + ' <input type="hidden" id="compareValue" name="compareValue">'
                        + ' <input class="form-control" placeholder="请选择组织" type="text" id="compareValueName" name="compareValueName" readonly>'
                        + ' <span class="input-group-addon" id="orgbtn">'
                        + ' <i	class="glyphicon glyphicon-equalizer"></i>'
                        + ' </span>'
                        + ' </div>';
                    $("#compareValueDiv").html(html);
                    $('#compareValueName').on('focus', function (e) {
                        new H5CommonSelect({
                            type: 'orgSelect',
                            idFiled: 'compareValue',
                            textFiled: 'compareValueName',
                            viewScope: '',
                            selectModel: 'multi'
                        });
                    });

                    $("#compareValueName").parent().find(".input-group-addon").unbind("click.auto").bind("click.auto",function(){
                        $(this).parent().find('input[type="text"]').trigger('focus');
                    });
                } else if (fieldShowType == 'position-box' || fieldShowType == 'position') {//选岗位
                    html = '<div class="input-group  input-group-sm" id="inputDiv">'
                        + ' <input type="hidden" id="compareValue" name="compareValue">'
                        + ' <input class="form-control" placeholder="请选择岗位" type="text" id="compareValueName" name="compareValueName" readonly>'
                        + ' <span class="input-group-addon" id="deptbtn">'
                        + ' <i	class="glyphicon glyphicon-equalizer"></i>'
                        + ' </span>'
                        + ' </div>';
                    $("#compareValueDiv").html(html);
                    $('#compareValueName').on('focus', function (e) {
                        new H5CommonSelect({
                            type: 'positionSelect',
                            idFiled: 'compareValue',
                            textFiled: 'compareValueName',
                            viewScope: 'all',
                            selectModel: 'multi'
                        });
                    });

                    $("#compareValueName").parent().find(".input-group-addon").unbind("click.auto").bind("click.auto",function(){
                        $(this).parent().find('input[type="text"]').trigger('focus');
    				});

                } else if (fieldShowType == 'role-box' || fieldShowType == 'role') {//选角色
                    html = '<div class="input-group  input-group-sm" id="inputDiv">'
                        + ' <input type="hidden" id="compareValue" name="compareValue">'
                        + ' <input class="form-control" placeholder="请选择角色" type="text" id="compareValueName" name="compareValueName" readonly>'
                        + ' <span class="input-group-addon" id="deptbtn">'
                        + ' <i	class="glyphicon glyphicon-equalizer"></i>'
                        + ' </span>'
                        + ' </div>';
                    $("#compareValueDiv").html(html);
                    $('#compareValueName').on('focus', function (e) {
                        new H5CommonSelect({
                            type: 'roleSelect',
                            idFiled: 'compareValue',
                            textFiled: 'compareValueName',
                            viewScope: 'all',
                            selectModel: 'multi'
                        });
                    });
                    $("#compareValueName").parent().find(".input-group-addon").unbind("click.auto").bind("click.auto",function(){
                        $(this).parent().find('input[type="text"]').trigger('focus');
    				});
                } else if (fieldShowType == 'group-box' || fieldShowType == 'group') {//选群组
                    html = '<div class="input-group  input-group-sm" id="inputDiv">'
                        + ' <input type="hidden" id="compareValue" name="compareValue">'
                        + ' <input class="form-control" placeholder="请选择群组" type="text" id="compareValueName" name="compareValueName" readonly>'
                        + ' <span class="input-group-addon" id="deptbtn">'
                        + ' <i	class="glyphicon glyphicon-equalizer"></i>'
                        + ' </span>'
                        + ' </div>';
                    $("#compareValueDiv").html(html);
                    $('#compareValueName').on('focus', function (e) {
                        new H5CommonSelect({
                            type: 'groupSelect',
                            idFiled: 'compareValue',
                            textFiled: 'compareValueName',
                            viewScope: 'all',
                            selectModel: 'multi'
                        });
                    });
                    $("#compareValueName").parent().find(".input-group-addon").unbind("click.auto").bind("click.auto",function(){
                        $(this).parent().find('input[type="text"]').trigger('focus');
    				});
                } else if (fieldShowType == 'date-box' || fieldShowType == 'date') {//日期
                    html = '<div class="input-group input-group-sm" id="inputDiv">'
                        + ' <input class="form-control date-picker" type="text"' + ' name="compareValueName" id="compareValueName" readonly/>'
                        + ' <span	class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>';
                    +' </div>';
                    $("#compareValueDiv").html(html);
                    $('.date-picker').datepicker({
                        beforeShow: function () {
                            setTimeout(function () {
                                $('#ui-datepicker-div').css("z-index", 99999999);
                            }, 100);
                        },
                        onClose: function () {
                            $("#compareValue").removeClass("av-hold");
                        }
                    });
                }else if (fieldShowType == 'radio-box' || fieldShowType == 'radio'
                    || fieldShowType == 'select-box' || fieldShowType == 'select'
                    || fieldShowType == 'check-box' || fieldShowType == 'check') {//下拉
                    var selectedoption =  $('#fieldAttr option:selected').attr("selectedoption");
                    var selectedvalues =  $('#fieldAttr option:selected').attr("selectedvalues");

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
                    $("#compareValueDiv").html(html);
                }else if(fieldShowType == 'secret-box' || fieldShowType == 'secret'){
                    var options = "";
                    if(flowUtils.notNull(secretList)){
                        for(var i = 0; i< secretList.length;i++){
                            options += "<option value='"+secretList[i].lookupCode+"' >"+secretList[i].lookupName+"</option>";
                        }
                    }
                    html = '<select class="form-control input-sm" id="compareValue" name="compareValue">'
                        + options
                        +' </select>';
                    $("#compareValueDiv").html(html);
                }else {
                    html = '<div class="input-group  input-group-sm" id="inputDiv">'
                        + ' <input type="hidden" id="compareValueName" name="compareValueName">'
                        + ' <input class="form-control"  type="text"'
                        + ' id="compareValue" name="compareValue" title="输入多个值时请用 @@@进行分割">'
                        + ' </div>';
                    $("#compareValueDiv").html(html);
                }

                //某一节点处理人，某人节点处理人所属部门、角色、群组、岗位 弹出流程节点选择框
                if(value=='somePerfomer' || value=='somePerfomerDept'
                    || value=='somePerfomerRole' || value=='somePerfomerGroup'
                        || value=='somePerfomerPosition'){
                    $("#spanActivityName").show();
                    $("#activityName").show();
                }else{
                    $("#spanActivityName").hide();
					$("#activityName").hide();
                }

                //初始化值的节点选择
                $("#spanValueActivityName").hide();
                $("#valueActivityName").hide();
                $("#valueActivityName").val("");
                $("#valueActivityId").val("");
            }
        }

    };




    function disableInput() {
        $("#fieldAttr").prop('disabled', 'true');
        $("#oper").prop('disabled', 'true');
        $("#varia").prop('disabled', 'true');
        $("#compareValue").prop('disabled', 'true');
        $("#compareValueName").prop('disabled', 'true');
    };

    function enableInput() {
        $("#fieldAttr").prop('disabled', '');
        $("#oper").prop('disabled', '');
        $("#varia").prop('disabled', '');
        $("#compareValue").prop('disabled', '');
        $("#compareValueName").prop('disabled', '');
    };

    function selectVarType(obj){
        if(obj.id == "varia" && obj.checked == true){
            $('#compareAttr').val("请选择");
            //$("#compareValue").css('display','inline');
            $("#compareValueDiv").css('display','none');
            $("#compareDiv").removeAttr("style");
        }else if(obj.id == "varia" && obj.checked == false){
            //$("#compareValue").css('display','none');
            $("#compareValueDiv").removeAttr("style");
            $("#compareDiv").css('display','none');
            $("#spanValueActivityName").hide();
            $("#valueActivityName").hide();
        }
    };

    $(function () {
        var parentId = decodeURIComponent(flowUtils.getUrlQuery("id"));
        var parentObj = parent.$("#" + parentId).data("data-object");
        if (parentObj == null) {
            return;
        }
        //var process = null;
        if (parentObj != null) {
            process = parentObj.process;
        }
        var jsonStr = parent.$("#" + parentObj.domId).attr("longjson");
        var isExprConfigUpdate = parent.$("#" + parentObj.domId).parent().find("[name='isExprConfigUpdate']").val();
        isConfigUpdate = isExprConfigUpdate;
        if (jsonStr != null && jsonStr != '' && typeof jsonStr != "undefined"
            && isExprConfigUpdate=='1') {
            InitTree($.parseJSON(jsonStr.trim()));
            parent.$("#" + parentObj.domId).parent().find("[name='isExprConfigUpdate']").val("");
        }
        else {
            InitTree(testData2);
        }
        var processFlag = parentObj.processFlag;
        if (process) {
            if (!processFlag) {
                if (parent.$("#" + process.id + " table[name='table-flow-variable']").find("input[name='dataValue']").length > 0) {
                    //$("#fieldAttr").append("<option value=''>---流程变量----</option>");
                    $("#fieldAttr").append("<optgroup label='" + "流程变量" + "'></optgroup>");
                    $("#compareAttr").append("<optgroup label='" + "流程变量" + "'></optgroup>");
                }
                parent.$("#" + process.id + " table[name='table-flow-variable']").find("input[name='dataValue']").each(function () {
                    var processVar = JSON.parse($(this).val());
                    $("#fieldAttr").append("<option value='" + processVar.name + "' style='padding-left: 20px'"
                        + " type='3'"
                        + " formId='" + parentObj.globalformid + "'"
                        + " fieldType='1'"
                        + " fieldId='" + processVar.name + "'"
                        + " fieldName='" + processVar.alias + "'"
                        + " colType='" + processVar.type + "'"
                        + ">&nbsp;&nbsp;&nbsp;" + processVar.alias + "(" + processVar.name + ")" + "</option>");

                    $("#compareAttr").append("<option value='" + processVar.name + "' style='padding-left: 20px'"
                        + " type='3'"
                        + " formId='" + parentObj.globalformid + "'"
                        + " compareValueFieldId='" + processVar.name + "'"
                        + " compareValueFieldName='" + processVar.alias + "'"
                        + " compareValueFieldDataType='" + processVar.type + "'"
                        + " compareValueFieldType='1'"
                        + ">&nbsp;&nbsp;&nbsp;" + processVar.alias + "(" + processVar.name + ")" + "</option>");

                });
            }
        }
        if (!processFlag) {
            //$("#fieldAttr").append("<option value=''>---流程常量----</option>");
            $("#fieldAttr").append("<optgroup label='" + "流程常量" + "'></optgroup>");
            $("#compareAttr").append("<optgroup label='" + "流程常量" + "'></optgroup>");
            $("#fieldAttr").append("<option value='currPerfomer' "
                + " type='3'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='currPerfomer'"
                + " fieldName='" + "当前节点处理人" + "'"
                + " fieldShowType='user'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;当前节点处理人</option>");
            $("#fieldAttr").append("<option value='currPerfomerDept' "
                + " type='3'"
                + " subFlag='true'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='currPerfomerDept'"
                + " fieldName='" + "当前节点处理人所属部门" + "'"
                + " fieldShowType='dept'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;当前节点处理人所属部门</option>");
            $("#fieldAttr").append("<option value='currPerfomerRole' "
                + " type='3'"
                + " subFlag='true'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='currPerfomerRole'"
                + " fieldName='" + "当前节点处理人所属角色" + "'"
                + " fieldShowType='role'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;当前节点处理人所属角色</option>");
            $("#fieldAttr").append("<option value='currPerfomerGroup' "
                + " type='3'"
                + " subFlag='true'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='currPerfomerGroup'"
                + " fieldName='" + "当前节点处理人所属群组" + "'"
                + " fieldShowType='group'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;当前节点处理人所属群组</option>");
            $("#fieldAttr").append("<option value='currPerfomerPosition' "
                + " type='3'"
                + " subFlag='true'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='currPerfomerPosition'"
                + " fieldName='" + "当前节点处理人所属岗位" + "'"
                + " fieldShowType='position'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;当前节点处理人所属岗位</option>");
            $("#fieldAttr").append("<option value='starter' "
                + " type='3'"
                + " fieldType='4'"
                + " fieldId='starter'"
                + " fieldName='" + "拟稿人" + "'"
                + " fieldShowType='user'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;拟稿人</option>");
            $("#fieldAttr").append("<option value='starterDept' "
                + " type='3'"
                + " subFlag='true'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='starterDept'"
                + " fieldName='" + "拟稿人所属部门" + "'"
                + " fieldShowType='dept'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;拟稿人所属部门</option>");
            $("#fieldAttr").append("<option value='starterRole' "
                + " type='3'"
                + " subFlag='true'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='starterRole'"
                + " fieldName='" + "拟稿人所属角色" + "'"
                + " fieldShowType='role'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;拟稿人所属角色</option>");
            $("#fieldAttr").append("<option value='starterGroup' "
                + " type='3'"
                + " subFlag='true'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='starterGroup'"
                + " fieldName='" + "拟稿人所属群组" + "'"
                + " fieldShowType='group'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;拟稿人所属群组</option>");
            $("#fieldAttr").append("<option value='starterPosition' "
                + " type='3'"
                + " subFlag='true'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='starterPosition'"
                + " fieldName='" + "拟稿人所属岗位" + "'"
                + " fieldShowType='position'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;拟稿人所属岗位</option>");

            $("#fieldAttr").append("<option value='somePerfomer' "
                    + " type='3'"
                    + " subFlag='true'"
                    + " formId='" + parentObj.globalformid + "'"
                    + " fieldType='4'"
                    + " fieldId='somePerfomer'"
                    + " fieldName='" + "某一节点处理人" + "'"
                    + " fieldShowType='user'"
                    + " colType='string'"
                    + ">&nbsp;&nbsp;&nbsp;某一节点处理人</option>");
            $("#fieldAttr").append("<option value='somePerfomerDept' "
                + " type='3'"
                + " subFlag='true'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='somePerfomerDept'"
                + " fieldName='" + "某一节点处理人所属部门" + "'"
                + " fieldShowType='dept'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;某一节点处理人所属部门</option>");
            $("#fieldAttr").append("<option value='somePerfomerRole' "
                + " type='3'"
                + " subFlag='true'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='somePerfomerRole'"
                + " fieldName='" + "某一节点处理人所属角色" + "'"
                + " fieldShowType='role'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;某一节点处理人所属角色</option>");
            $("#fieldAttr").append("<option value='somePerfomerGroup' "
                + " type='3'"
                + " subFlag='true'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='somePerfomerGroup'"
                + " fieldName='" + "某一节点处理人所属群组" + "'"
                + " fieldShowType='group'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;某一节点处理人所属群组</option>");
            $("#fieldAttr").append("<option value='somePerfomerPosition' "
                + " type='3'"
                + " subFlag='true'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " fieldId='somePerfomerPosition'"
                + " fieldName='" + "某一节点处理人所属岗位" + "'"
                + " fieldShowType='position'"
                + " colType='string'"
                + ">&nbsp;&nbsp;&nbsp;某一节点处理人所属岗位</option>");

            $("#compareAttr").append("<option value='currPerfomer' "
                + " type='3'"
                + " formId='" + parentObj.globalformid + "'"
                + " fieldType='4'"
                + " compareValueFieldId='currPerfomer'"
                + " compareValueFieldName='" + "当前节点处理人" + "'"
                + " fieldShowType='user'"
                + " colType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;当前节点处理人</option>");
            $("#compareAttr").append("<option value='currPerfomerDept' "
                + " type='3'"
                + " formId='" + parentObj.globalformid + "'"
                + " compareValueFieldId='currPerfomerDept'"
                + " compareValueFieldName='" + "当前节点处理人所属部门" + "'"
                + " fieldShowType='dept'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;当前节点处理人所属部门</option>");
            $("#compareAttr").append("<option value='currPerfomerRole' "
                + " type='3'"
                + " formId='" + parentObj.globalformid + "'"
                + " compareValueFieldId='currPerfomerRole'"
                + " compareValueFieldName='" + "当前节点处理人所属角色" + "'"
                + " fieldShowType='role'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;当前节点处理人所属角色</option>");
            $("#compareAttr").append("<option value='currPerfomerGroup' "
                + " type='3'"
                + " formId='" + parentObj.globalformid + "'"
                + " compareValueFieldId='currPerfomerGroup'"
                + " compareValueFieldName='" + "当前节点处理人所属群组" + "'"
                + " fieldShowType='group'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;当前节点处理人所属群组</option>");
            $("#compareAttr").append("<option value='currPerfomerPosition' "
                + " type='3'"
                + " formId='" + parentObj.globalformid + "'"
                + " compareValueFieldId='currPerfomerPosition'"
                + " compareValueFieldName='" + "当前节点处理人所属岗位" + "'"
                + " fieldShowType='position'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;当前节点处理人所属岗位</option>");
            $("#compareAttr").append("<option value='starter' "
                + " type='3'"
                + " compareValueFieldId='starter'"
                + " compareValueFieldName='" + "拟稿人" + "'"
                + " fieldShowType='user'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;拟稿人</option>");
            $("#compareAttr").append("<option value='starterDept' "
                + " type='3'"
                + " compareValueFieldId='starterDept'"
                + " compareValueFieldName='" + "拟稿人所属部门" + "'"
                + " fieldShowType='dept'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;拟稿人所属部门</option>");
            $("#compareAttr").append("<option value='starterRole' "
                + " type='3'"
                + " compareValueFieldId='starterRole'"
                + " compareValueFieldName='" + "拟稿人所属角色" + "'"
                + " fieldShowType='role'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;拟稿人所属角色</option>");
            $("#compareAttr").append("<option value='starterGroup' "
                + " type='3'"
                + " compareValueFieldId='starterGroup'"
                + " compareValueFieldName='" + "拟稿人所属群组" + "'"
                + " fieldShowType='group'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;拟稿人所属群组</option>");
            $("#compareAttr").append("<option value='starterPosition' "
                + " type='3'"
                + " compareValueFieldId='starterPosition'"
                + " compareValueFieldName='" + "拟稿人所属岗位" + "'"
                + " fieldShowType='position'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;拟稿人所属岗位</option>");
            $("#compareAttr").append("<option value='somePerfomer' "
                    + " type='3'"
                    + " compareValueFieldId='somePerfomer'"
                    + " compareValueFieldName='" + "某一节点处理人" + "'"
                    + " fieldShowType='user'"
                    + " compareValueFieldDataType='string'"
                    + " compareValueFieldType='4'"
                    + ">&nbsp;&nbsp;&nbsp;某一节点处理人</option>");
            $("#compareAttr").append("<option value='somePerfomerDept' "
                + " type='3'"
                + " compareValueFieldId='somePerfomerDept'"
                + " compareValueFieldName='" + "某一节点处理人所属部门" + "'"
                + " fieldShowType='dept'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;某一节点处理人所属部门</option>");
            $("#compareAttr").append("<option value='somePerfomerRole' "
                + " type='3'"
                + " compareValueFieldId='somePerfomerRole'"
                + " compareValueFieldName='" + "某一节点处理人所属角色" + "'"
                + " fieldShowType='role'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;某一节点处理人所属角色</option>");
            $("#compareAttr").append("<option value='somePerfomerGroup' "
                + " type='3'"
                + " compareValueFieldId='somePerfomerGroup'"
                + " compareValueFieldName='" + "某一节点处理人所属群组" + "'"
                + " fieldShowType='group'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;某一节点处理人所属群组</option>");
            $("#compareAttr").append("<option value='somePerfomerPosition' "
                + " type='3'"
                + " compareValueFieldId='somePerfomerPosition'"
                + " compareValueFieldName='" + "某一节点处理人所属岗位" + "'"
                + " fieldShowType='position'"
                + " compareValueFieldDataType='string'"
                + " compareValueFieldType='4'"
                + ">&nbsp;&nbsp;&nbsp;某一节点处理人所属岗位</option>");
        }
        parentObj.form = $("#form");
        parentObj.res = $("#computeLine");
        parentObj.longRes = $("#longJson");
        if (parentObj.globalformid == undefined || parentObj.globalformid == null || parentObj.globalformid == '') {
            layer.msg("流程关联表单为空！");
            return;
        }
        avicAjax.ajax({
            url: "bpm/designer/getProcessFormFieldsForVar",
            data: "globalformid=" + parentObj.globalformid,
            type: "post",
            dataType: "json",
            success: function (backData) {
                if (backData.fields == '') {
                    layer.msg("未查询到流程关联表单的字段！");
                } else {
                    console.log(backData);
                    var formFields = JSON.parse(backData.fields);
                    secretList = backData.secretList;
                    if (formFields.length > 0) {
                        //$("#fieldAttr").append("<option value=''>---主表字段----</option>");
                        $("#fieldAttr").append("<optgroup label='" + "主表字段" + "'></optgroup>");
                        $("#compareAttr").append("<optgroup label='" + "主表字段" + "'></optgroup>");
                    }
                    for (var i = 0; i < formFields.length; i++) {
                        var tableName = backData.tableName;
                        //外部表字段表名加@区分
                        if(formFields[i].domdataId){
                            tableName = "@"+formFields[i].tableName;
                        }
                        var options = "<option value='" + formFields[i].colName + "' "
                        + " type='3'"
                        + " colType='" + formFields[i].colType + "'"
                        + " fieldType='2'"
                        + " fieldId='" + formFields[i].colName + "'"
                        + " fieldName='" + formFields[i].colLabel + "'"
                        + " tableName='" + tableName + "'"
                        + " formId='" + parentObj.globalformid + "'"
                        + " dataSourceId='" + backData.dataSourceId + "'";
                        if(formFields[i].hasOwnProperty("selectedoption")){
                            options += " selectedoption='" + formFields[i].selectedoption + "'"
                            + " selectedvalues='" + formFields[i].selectedvalues + "'";
                        }
                        options +=  " fieldShowType='" + formFields[i].domType + "'>&nbsp;&nbsp;&nbsp;" + formFields[i].colLabel + "(" + formFields[i].colName + ")" + "</option>";
                        $("#fieldAttr").append(options);
                        $("#compareAttr").append("<option value='" + formFields[i].colName + "' "
                            + " type='3'"
                            + " compareValueFieldDataType='" + formFields[i].colType + "'"
                            + " compareValueFieldId='" + formFields[i].colName + "'"
                            + " compareValueFieldName='" + formFields[i].colLabel + "'"
                            + " compareValueTableName='" + tableName + "'"
                            + " formId='" + parentObj.globalformid + "'"
                            + " dataSourceId='" + backData.dataSourceId + "'"
                            + " compareValueFieldType='2'"
                            + " fieldShowType='" + formFields[i].domType + "'>&nbsp;&nbsp;&nbsp;" + formFields[i].colLabel + "(" + formFields[i].colName + ")" + "</option>");
                    }
                    if (!parentObj.processFlag) {
                        //处理关联子表的字段
                        var subMap = backData.subFieldsMap;
                        var key = null;//子表名称
                        var value = null;//子表字段内容
                        if (subMap != null && subMap != '') {
                            for (var entry in subMap) {
                                //key = entry;
                                key = "子表字段" + "(" + entry + ")";
                                value = subMap[entry];
                                if (value != null && value != '') {
                                    var subFormFields = JSON.parse(value);
                                    if (subFormFields.length > 0) {
                                        $("#fieldAttr").append("<optgroup label='" + key + "'></optgroup>");
                                        //$("#fieldAttr").append("<option value=''>---"+key+"----</option>");
                                    }
                                    for (var j = 0; j < subFormFields.length; j++) {
                                        var options = "<option value='" + subFormFields[j].colName + "' "
                                            + " subFlag='true'"
                                            + " colType='" + subFormFields[j].colType + "'"
                                            + " type='3'"
                                            + " fieldType='3'"
                                            + " fieldId='" + subFormFields[j].colName + "'"
                                            + " fieldName='" + subFormFields[j].colLabel + "'"
                                            + " tableName='" + entry + "'"
                                            + " formId='" + parentObj.globalformid + "'"
                                            + " mainTableName='" + backData.tableName + "'"
                                            + " dataSourceId='" + backData.dataSourceId + "'";
                                            if(subFormFields[j].hasOwnProperty("selectedoption")){
                                                options += " selectedoption='" + subFormFields[j].selectedoption + "'"
                                                    + " selectedvalues='" + subFormFields[j].selectedvalues + "'";
                                            }
                                        options += " fieldShowType='" + subFormFields[j].elementType + "'>&nbsp;&nbsp;&nbsp;" + subFormFields[j].colLabel + "(" + subFormFields[j].colName + ")" + "</option>";
                                        $("#fieldAttr").append(options);
                                    }
                                }

                            }
                        }
                    }

                    setFormboxField(backData);
                }
            }
        });

        $("form").validate({
            rules: {
                theValue: {
                    required: true
                },
                fieldAttr: {
                    required: true
                },
                activityName:{
                	required: true
                },
                valueActivityName:{
                	required: true
                },
                oper:{
					required:true
                }
            }
        });
        disableInput();
        //disableLogicInput();

    });


    function setFormboxField(backData,tableNames,fks){
        tableNames = tableNames || [];
        fks = fks || [];
        var formboxMapList = backData.formBoxs;
        if (formboxMapList != null && formboxMapList != undefined && formboxMapList.length>0){
            for (var i=0;i<formboxMapList.length;i++){
                var formbox = formboxMapList[i];

                $("#fieldAttr").append("<optgroup label='" + formbox.formname + "'></optgroup>");
                $("#compareAttr").append("<optgroup label='" + formbox.formname + "'></optgroup>");
                var formboxMap = formbox.formField.modelMap;
                var formFields = JSON.parse(formboxMap.fields);
                tableNames.push(formboxMap.tableName);
                fks.push(formbox.fkcol);
                for (var i = 0; i < formFields.length; i++) {
                    $("#fieldAttr").append("<option value='" + formFields[i].colName + "' "
                        + " type='3'"
                        + " colType='" + formFields[i].colType + "'"
                        + " fieldType='5'"
                        + " fieldId='" + formFields[i].colName + "'"
                        + " fieldName='" + formFields[i].colLabel + "'"
                        + " tableName='" + formboxMap.tableName + "'"
                        + " formId='" + formbox.formid + "'"
                        + " hisTable='" + tableNames.join(",") + "'"
                        + " hisFk='" + fks.join(",") + "'"
                        + " dataSourceId='" + formboxMap.dataSourceId + "'"
                        + " fieldShowType='" + formFields[i].domType + "'>&nbsp;&nbsp;&nbsp;" + formFields[i].colLabel + "(" + formFields[i].colName + ")" + "</option>");

                    $("#compareAttr").append("<option value='" + formFields[i].colName + "' "
                        + " type='3'"
                        + " compareValueFieldDataType='" + formFields[i].colType + "'"
                        + " compareValueFieldId='" + formFields[i].colName + "'"
                        + " compareValueFieldName='" + formFields[i].colLabel + "'"
                        + " compareValueTableName='" + formboxMap.tableName + "'"
                        + " formId='" + formbox.formid + "'"
                        + " hisTable='" + tableNames.join(",") + "'"
                        + " hisFk='" + fks.join(",") + "'"
                        + " dataSourceId='" + formboxMap.dataSourceId + "'"
                        + " compareValueFieldType='5'"
                        + " fieldShowType='" + formFields[i].domType + "'>&nbsp;&nbsp;&nbsp;" + formFields[i].colLabel + "(" + formFields[i].colName + ")" + "</option>");
                }
                setFormboxField(formboxMap,tableNames,fks);
            }
        }
    }

    function setCellConfig() {
        if (!selCellId) {
            layer.alert("请先选择操作对象", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
            return;
        }
        var cell = "#" + selCellId;//选中的树节点
        var cellType = $('.vTree').vtree.getJson($(cell)).type;//1:and 2:or 3:表达式

        //表达式节点
        if ("3" == cellType) {
            var fieldType = $("#fieldAttr option:selected").attr("fieldType");//1:流程变量 2：主表字段 3：子表字段 4：流程常量
            if (fieldType == null || fieldType == '' || typeof fieldType == "undefined") {
                layer.alert("请先选择字段", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                return;
            }else{
                var selectedFiledId = $("#fieldAttr option:selected").val();
				if(fieldType=='4' && (selectedFiledId=='somePerfomer' || selectedFiledId=='somePerfomerDept'
                    || selectedFiledId=='somePerfomerRole' || selectedFiledId=='somePerfomerGroup'
                        || selectedFiledId=='somePerfomerPosition')){
					var selectedActivityId = $("#activityId").val();
					if(selectedActivityId==null || selectedActivityId=='undefined' || selectedActivityId==''){
						layer.alert("请先选择节点", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
		                return;
				    }
			    }
            }

            //操作符
            var theOper = $("#oper").val();
            if (theOper == null || theOper == '' || typeof theOper == "undefined") {
                layer.alert("请选择操作符", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                return;
            }
            //获取设置的值
            var indexSel = $("#fieldAttr").get(0).selectedIndex;
            //比较值是否是变量
            var isVaria = $("#varia").prop('checked');
            //隐藏域id
            var dataId = decodeURIComponent(flowUtils.getUrlQuery("id"));
            //子表字段和主表字段
            if ("2" == fieldType || "3" == fieldType || "5" == fieldType) {
                var type = $("#fieldAttr option:selected").attr("type");
                var fieldType = $("#fieldAttr option:selected").attr("fieldType");
                var fieldId = $("#fieldAttr option:selected").attr("fieldId");
                var fieldName = $("#fieldAttr option:selected").attr("fieldName");
                var tableName = $("#fieldAttr option:selected").attr("tableName");
                var dataSourceId = $("#fieldAttr option:selected").attr("dataSourceId");
                var mainTableName = $("#fieldAttr option:selected").attr("mainTableName");
                var formId = $("#fieldAttr option:selected").attr("formId");
                var fieldShowType = $("#fieldAttr option:selected").attr("fieldShowType");
                var colType = $("#fieldAttr option:selected").attr("colType");
                var hisTable = $("#fieldAttr option:selected").attr("hisTable");
                var hisFk = $("#fieldAttr option:selected").attr("hisFk");

                //比较符号
                var compareType = $("#oper option:selected").val();
                var compareTypeName = $("#oper option:selected").text();
                //比较值不是变量时
                if(!isVaria){
                    var compareValue = $("#compareValue").val();
                    var compareValueName = $("#compareValueName").val();
                    if (fieldShowType == 'radio-box' || fieldShowType == 'radio'
                        || fieldShowType == 'select-box' || fieldShowType == 'select'
                        || fieldShowType == 'check-box' || fieldShowType == 'check'){
                        compareValueName = $("#compareValue option:selected").text();
                    }
                    if($("#compareValueName") && $("#compareValueName").attr("type")=='hidden'){
                        compareValueName = compareValue;
                    }
                    //赋值前验证
                    if (colType == null || colType == '' || typeof colType == "undefined"
                        || (compareType == null || compareType == '')
                        || ((compareValue == null || compareValue == '') && (compareValueName == null || compareValueName == ''))) {
                        layer.alert("请先选择赋值参数", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                        return;
                    }
                    if ((compareValueName == null || compareValueName == '') && (compareValue != '' || compareValue != null)) {
                        compareValueName = compareValue;
                    }
                    if ((compareValue == null || compareValue == '') && (compareValueName != '' || compareValueName != null)) {
                        compareValue = compareValueName;
                    }
                    /**
                    if ("string" == colType || "VARCHAR2" == colType || "DATE" == colType) {
                        //compareValueName = "'"+compareValueName+"'";
                        if ("DATE" == colType) {
                            if (compareValue.length < 12) {
                                compareValue = compareValue + " 00:00:00:00";
                            }
                        }
                    }*/
                    //将多选情况的value字符串的所有;替换为@@@
                    if (fieldShowType == 'user-box' || fieldShowType == 'user'
                        || fieldShowType == 'dept-box' || fieldShowType == 'dept'
                        || fieldShowType == 'position-box' || fieldShowType == 'position'
                        || fieldShowType == 'role-box' || fieldShowType == 'role'
                        || fieldShowType == 'group-box' || fieldShowType == 'group'
                        || fieldShowType == 'org-box' || fieldShowType == 'org'
                        || fieldShowType == 'waorg-box') {
                        compareValue = replaceMark(compareValue);
                    }
                }else{
                    var compareValueFieldType = $("#compareAttr option:selected").attr("compareValueFieldType");
                    var compareValueFieldId = $("#compareAttr option:selected").attr("compareValueFieldId");
                    var compareValueFieldName = $("#compareAttr option:selected").attr("compareValueFieldName");
                    var compareValueFieldDataType = $("#compareAttr option:selected").attr("compareValueFieldDataType");
                    var compareValueTableName = $("#compareAttr option:selected").attr("compareValueTableName");
                    //验证
                    if (compareValueFieldType == null || compareValueFieldType == '' || typeof compareValueFieldType == "undefined") {
                        layer.alert("请先选择比较值", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                        return;
                    }
                }
                compareTypeName = " " + compareTypeName + " ";
                if (selCellId != null) {
                    $("#oper").prop('disabled', 'true');
                    $("#compareValue").prop('disabled', 'true');
                    $('.vTree').vtree.setJson($(cell), {
                        "type": type,
                        "fieldId": fieldId, "fieldName": fieldName,
                        "fieldType": fieldType, "tableName": tableName,
                        "dataSourceId": dataSourceId, "fieldShowType": fieldShowType,
                        "mainTableName": mainTableName, "formId": formId,
                        "compareType": compareType, "compareTypeName": compareTypeName,
                        "compareValue": "", "compareValueName": "",
                        "compareValueFieldType": "", "compareValueFieldId": "",
                        "compareValueFieldName":"","compareValueFieldDataType":"",
                        "compareValueTableName":"","hisTable":hisTable,"hisFk":hisFk,
                        "dataId":dataId,"fieldDataType":colType});
                    if(!isVaria){
                        $('.vTree').vtree.setJson($(cell), {
                            "compareValue": compareValue, "compareValueName": compareValueName});
                        $(cell).find(".txt").text(fieldName + compareTypeName + compareValueName);
                        $('.vTree').vtree.refresh();
                    }else{

                    	var valueActivityId = "";
                        var valueActivityName = "";
                        if(compareValueFieldType=='4' && (compareValueFieldId=='somePerfomer' || compareValueFieldId=='somePerfomerDept'
                            || compareValueFieldId=='somePerfomerRole' || compareValueFieldId=='somePerfomerGroup'
                                || compareValueFieldId=='somePerfomerPosition')){
                        	 valueActivityId = $("#valueActivityId").val();
                        	 if(valueActivityId==null || valueActivityId=='undefined' || valueActivityId==''){
         						layer.alert("请先选择节点", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
         		                return;
         				     }
                             valueActivityName = $("#valueActivityName").val();
                             if(compareValueFieldId=='somePerfomer'){
                            	 compareValueFieldName = valueActivityName+"节点处理人";
                             }else if(compareValueFieldId=='somePerfomerDept'){
                            	 compareValueFieldName = valueActivityName+"节点处理人所属部门";
                             }else if(compareValueFieldId=='somePerfomerRole'){
                            	 compareValueFieldName = valueActivityName+"节点处理人所属角色";
                             }else if(compareValueFieldId=='somePerfomerGroup'){
                            	 compareValueFieldName = valueActivityName+"节点处理人所属群组";
                             }else if(compareValueFieldId=='somePerfomerPosition'){
                            	 compareValueFieldName = valueActivityName+"节点处理人所属岗位";
                             }
                        }

                        $('.vTree').vtree.setJson($(cell), {
                            "compareValueFieldType": compareValueFieldType, "compareValueFieldId": compareValueFieldId,
                            "compareValueFieldName": compareValueFieldName, "compareValueFieldDataType": compareValueFieldDataType,
                            "compareValueTableName": compareValueTableName,"valueActivityId":valueActivityId,
                            "valueActivityName":valueActivityName});
                        $(cell).find(".txt").text(fieldName + compareTypeName + compareValueFieldName);
                        $('.vTree').vtree.refresh();
                    }

                    $(cell).removeClass("on");
                    /*console.log("设置后的值如下（主表和子表字段）：");
                    console.log($('.vTree').vtree.getJson($(cell)));*/

                }
            }
            //流程变量和流程常量
            else if ("1" == fieldType || "4" == fieldType) {
                var type2 = $("#fieldAttr option:selected").attr("type");
                var fieldType2 = $("#fieldAttr option:selected").attr("fieldType");
                var fieldId2 = $("#fieldAttr option:selected").attr("fieldId");
                var fieldName2 = $("#fieldAttr option:selected").attr("fieldName");
                var formId2 = $("#fieldAttr option:selected").attr("formId");
                var fieldShowType2 = $("#fieldAttr option:selected").attr("fieldShowType");
                var colType2 = $("#fieldAttr option:selected").attr("colType");

                var activityId2 = "";
                var activityName2 = "";
                if(fieldType=='4' && (fieldId2=='somePerfomer' || fieldId2=='somePerfomerDept'
                    || fieldId2=='somePerfomerRole' || fieldId2=='somePerfomerGroup'
                        || fieldId2=='somePerfomerPosition')){
                	activityId2 = $("#activityId").val();
                	activityName2 =$("#activityName").val();
                	if(fieldId2=='somePerfomer'){
                		fieldName2 = activityName2+"节点处理人";
                    }else if(fieldId2=='somePerfomerDept'){
                    	fieldName2 = activityName2+"节点处理人所属部门";
                    }else if(fieldId2=='somePerfomerRole'){
                    	fieldName2 = activityName2+"节点处理人所属角色";
                    }else if(fieldId2=='somePerfomerGroup'){
                    	fieldName2 = activityName2+"节点处理人所属群组";
                    }else if(fieldId2=='somePerfomerPosition'){
                    	fieldName2 = activityName2+"节点处理人所属岗位";
                    }
                }
                //比较符号
                var compareType2 = $("#oper option:selected").val();
                var compareTypeName2 = $("#oper option:selected").text();

                //比较值不是变量时
                if(!isVaria) {
                    var compareValue2 = $("#compareValue").val();
                    var compareValueName2 = $("#compareValueName").val();
                    //赋值前验证
                    if (colType2 == null || colType2 == '' || typeof colType2 == "undefined"
                        || (compareType2 == null || compareType2 == '')
                        || ((compareValue2 == null || compareValue2 == '') && (compareValueName2 == null || compareValueName2 == ''))) {
                        layer.alert("请先选择赋值参数", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                        return;
                    }
                    if($("#compareValueName") && $("#compareValueName").attr("type")=='hidden'){
                        compareValueName2 = compareValue2;
                    }
                    if ((compareValueName2 == null || compareValueName2 == '') && (compareValue2 != '' || compareValue2 != null)) {
                        compareValueName2 = compareValue2;
                    }
                    if ((compareValue2 == null || compareValue2 == '') && (compareValueName2 != '' || compareValueName2 != null)) {
                        compareValue2 = compareValueName2;
                    }
                  //将多选情况的value字符串的所有;替换为@@@
                    if (fieldShowType2 == 'user-box' || fieldShowType2 == 'user'
                        || fieldShowType2 == 'dept-box' || fieldShowType2 == 'dept'
                        || fieldShowType2 == 'position-box' || fieldShowType2 == 'position'
                        || fieldShowType2 == 'role-box' || fieldShowType2 == 'role'
                        || fieldShowType2 == 'group-box' || fieldShowType2 == 'group'
                        || fieldShowType2 == 'org-box' || fieldShowType2 == 'org'
                        || fieldShowType2 == 'waorg-box') {
                        compareValue2 = replaceMark(compareValue2);
                    }else{
                    	compareValueName2 = compareValue2;
                    }
                }else{
                    var compareValueFieldType2 = $("#compareAttr option:selected").attr("compareValueFieldType");
                    var compareValueFieldId2 = $("#compareAttr option:selected").attr("compareValueFieldId");
                    var compareValueFieldName2 = $("#compareAttr option:selected").attr("compareValueFieldName");
                    var compareValueFieldDataType2 = $("#compareAttr option:selected").attr("compareValueFieldDataType");
                    var compareValueTableName2 = $("#compareAttr option:selected").attr("compareValueTableName");
                    if (compareValueFieldType2 == null || compareValueFieldType2 == '' || typeof compareValueFieldType2 == "undefined") {
                        layer.alert("请先选择比较值", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                        return;
                    }
                }
                compareTypeName2 = " " + compareTypeName2 + " ";
                if (selCellId != null) {
                    $("#oper").prop('disabled', 'true');
                    $("#compareValue").prop('disabled', 'true');
                    $('.vTree').vtree.setJson($(cell), {
                        "type": type2,
                        "fieldId": fieldId2, "fieldType": fieldType2, "fieldName": fieldName2,
                        "activityId":activityId2,"activityName":activityName2,
                        "compareType": compareType2, "compareTypeName": compareTypeName2,
                        "compareValue": "", "compareValueName": "",
                        "compareValueFieldType": "", "compareValueFieldId": "",
                        "compareValueFieldName":"","compareValueFieldDataType":"",
                        "compareValueTableName":"",
                        "dataId":dataId,"fieldDataType":colType2});
                    if(!isVaria){
                        $('.vTree').vtree.setJson($(cell), {
                            "compareValue": compareValue2, "compareValueName": compareValueName2});
                        $(cell).find(".txt").text(fieldName2 + compareTypeName2 + compareValueName2);
                        $('.vTree').vtree.refresh();
                    }else{
                    	var valueActivityId = "";
                        var valueActivityName = "";
                        if(compareValueFieldType2=='4' && (compareValueFieldId2=='somePerfomer' || compareValueFieldId2=='somePerfomerDept'
                            || compareValueFieldId2=='somePerfomerRole' || compareValueFieldId2=='somePerfomerGroup'
                                || compareValueFieldId2=='somePerfomerPosition')){
                        	 valueActivityId = $("#valueActivityId").val();
                        	 if(valueActivityId==null || valueActivityId=='undefined' || valueActivityId==''){
          						layer.alert("请先选择节点", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
          		                return;
          				     }
                             valueActivityName = $("#valueActivityName").val();
                             if(compareValueFieldId2=='somePerfomer'){
                            	 compareValueFieldName2 = valueActivityName+"节点处理人";
                             }else if(compareValueFieldId2=='somePerfomerDept'){
                            	 compareValueFieldName2 = valueActivityName+"节点处理人所属部门";
                             }else if(compareValueFieldId2=='somePerfomerRole'){
                            	 compareValueFieldName2 = valueActivityName+"节点处理人所属角色";
                             }else if(compareValueFieldId2=='somePerfomerGroup'){
                            	 compareValueFieldName2 = valueActivityName+"节点处理人所属群组";
                             }else if(compareValueFieldId2=='somePerfomerPosition'){
                            	 compareValueFieldName2 = valueActivityName+"节点处理人所属岗位";
                             }
                        }
                        $('.vTree').vtree.setJson($(cell), {
                            "compareValueFieldType": compareValueFieldType2, "compareValueFieldId": compareValueFieldId2,
                            "compareValueFieldName": compareValueFieldName2, "compareValueFieldDataType": compareValueFieldDataType2,
                            "compareValueTableName": compareValueTableName2,"valueActivityId":valueActivityId,
                            "valueActivityName":valueActivityName});
                        $(cell).find(".txt").text(fieldName2 + compareTypeName2 + compareValueFieldName2);
                        $('.vTree').vtree.refresh();

                    }
                    $(cell).removeClass("on");
                    /*console.log("设置后的值如下（流程变量和常量）：");
                    console.log($('.vTree').vtree.getJson($(cell)));*/
                }
            }
            disableInput();
        }

        if (selCellId == newCellId) {
            $('.vTree').vtree.option.added = true;
            //var cue33 = $('.vTree').vtree.option.added;
            newCellId = null;
        }
        selCellId = null;

    };

    function InitTree(jsonTree) {
        $('.vTree').vtree({
            data: jsonTree,
            added: true,
            iptEvent: function ($this) {
                disableInput();
                //disableLogicInput();
                //树节点样式改为选中状态
                if (selCellId != null) {
                    $("#" + selCellId).removeClass("on");
                }
                selCellId = $('.vTree').vtree.getJson($this).id;
                $("#" + selCellId).addClass("on");
                if ($('.vTree').vtree.getJson($this).type == "3") {
                    //选中表达式节点
                    enableInput();
                    //被比较值的类型
                    var theCompfieldtype = $('.vTree').vtree.getJson($this).compareValueFieldType;
                    //被比较值的数据类型
                    var theCompDataType = $('.vTree').vtree.getJson($this).compareValueFieldDataType;
                    var theCompVal = $('.vTree').vtree.getJson($this).compareValueFieldName;
                    //获取比较值
                    var curFieldId = $('.vTree').vtree.getJson($this).fieldId;
                    var curFieldName = $('.vTree').vtree.getJson($this).fieldName;
                    var curActivityId = $('.vTree').vtree.getJson($this).activityId;
                    var curActivityName = $('.vTree').vtree.getJson($this).activityName;
                    var curtableId = $('.vTree').vtree.getJson($this).tableName;
                    var curFieldType =  $('.vTree').vtree.getJson($this).fieldType;
                    set_field_select_checked("fieldAttr",curFieldId,curFieldName,curtableId,curFieldType,curActivityId,curActivityName);
                    changeField();//匹配操作符
                    //获取操作符
                    var curSep = $('.vTree').vtree.getJson($this).compareType;
                    $("#oper").val(curSep.trim());
                    set_oper_select_checked("oper",curSep.trim());

                    if (theCompfieldtype != "" && typeof theCompfieldtype != 'undefined'){
                        //用户输入的值,
                        $("#compareValue").val("");
                        $('#varia').prop("checked",true);
                        var checkBtn = document.getElementById("varia");
                        selectVarType(checkBtn);
                        //获取被比较值
                        var curComId = $('.vTree').vtree.getJson($this).compareValueFieldId;
                        var curComtableId = $('.vTree').vtree.getJson($this).compareValueTableName;
                        var valueActivityId = $('.vTree').vtree.getJson($this).valueActivityId;
                        var valueActivityName = $('.vTree').vtree.getJson($this).valueActivityName;
                        set_compareAttr_select_checked("compareAttr",curComId,theCompVal,curComtableId,theCompfieldtype,valueActivityId,valueActivityName);
                    }else {
                        //设置被比较值
                        var compareValueName333 = $('.vTree').vtree.getJson($this).compareValueName;
                        var compareValue333 = $('.vTree').vtree.getJson($this).compareValue;
                        if("undefined"!=compareValueName333){
                        	$("#compareValueName").val(compareValueName333);
                        }
                        if("undefined"!=compareValueName333){
                        	$("#compareValue").val(compareValue333);
                        }
                    }
                }
                //console.log($('.vTree').vtree.getJson($this));
            },
            //添加节点成功后的回调函数
            addEvent: function ($this, id) {
                //选择新建节点的类型（逻辑节点或表达式节点）
                //console.log(id);
                needChildFlag = false;
                if (id != null) {
                    var newCell = "#" + id;//新建的树节点
                    if ($('.vTree').vtree.getJson($this).type == "1") {
                        $('.vTree').vtree.setJson($(newCell), {
                            "fieldId":"AND", "fieldName":"AND"});
                    } else if ($('.vTree').vtree.getJson($this).type == "2") {
                        $('.vTree').vtree.setJson($(newCell), {
                            "fieldId":"OR", "fieldName":"OR"});
                    }
                    if ($('.vTree').vtree.getJson($(newCell)).type == "3") {
                        $("#" + id).parent().addClass("nochild");

                        $('.vTree').vtree.option.added = false;
                        newCellId = id;
                    }
                }
            },
            delEvent: function ($this, id, childdata) {
                needChildFlag = false;
                var idArry = [];
                if (childdata != '[]') {
                    idArry = computeChildList(childdata, null);
                    idArry.add(id);
                    //如果新增节点被删除了，则可以继续添加
                    for (var j = idArry.length - 1; j >= 0; j--) {
                        if (newCellId == idArry[j]) {
                            $('.vTree').vtree.option.added = true;
                            newCellId = null;
                        }
                    }
                }
            },
            addedEvt: function ($this) {
            	flowUtils.warning("不能创建，请先对节点赋值");
                //layer.alert("不能创建，请先对节点赋值", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
            },
            swEvent: function ($this) {
                var theCell = "#" + $('.vTree').vtree.getJson($this).id;//选中的树节点
                if ($('.vTree').vtree.getJson($this).type == "1") {
                    $('.vTree').vtree.setJson($(theCell), {
                        "fieldId":"AND", "fieldName":"AND"});
                } else if ($('.vTree').vtree.getJson($this).type == "2") {
                    $('.vTree').vtree.setJson($(theCell), {
                        "fieldId":"OR", "fieldName":"OR"});
                }
            }
        });
    };


    /**
     * compareAttr select控件选中
     * @param selectId select的id值
     * @param checkValue 选中option的值
     */
    function set_compareAttr_select_checked(selectId, checkId,checkValue,checkTableId,checkCompfieldtype,valueActivityId,valueActivityName){
        var select = document.getElementById(selectId);

        for (var i = 0; i < select.options.length; i++){
            var compareValueFieldType = select.options[i].attributes.comparevaluefieldtype;
            var _compareFieldType = null;
            if(typeof compareValueFieldType !='undefined'){
            	_compareFieldType = compareValueFieldType.nodeValue;
            }
            if(checkTableId == "" || typeof checkTableId == 'undefined'){
                var valN = select.options[i].attributes.comparevaluefieldname;
                var valNam = null;
                if(typeof valN != 'undefined'){valNam = select.options[i].attributes.comparevaluefieldname.nodeValue}
                //if (select.options[i].value == checkId && valNam == checkValue){
                if (select.options[i].value == checkId && _compareFieldType == checkCompfieldtype){
                    select.options[i].selected = true;
                    break;
                }
            }else{
                var valForm = select.options[i].attributes.comparevaluetablename;
                var valFormId = null;
                if(typeof valForm != 'undefined'){valFormId = select.options[i].attributes.comparevaluetablename.nodeValue}
                if (select.options[i].value == checkId && valFormId == checkTableId && _compareFieldType == checkCompfieldtype){
                    select.options[i].selected = true;
                    break;
                }
            }

        }
        if(valueActivityName!=null && valueActivityName!='undefined' && valueActivityName!=''){
			$("#valueActivityId").val(valueActivityId);
			$("#valueActivityName").val(valueActivityName);
			$("#valueActivityName").show();
			$("#spanValueActivityName").show();
        }
    };

    //递归计算树的结果表达式
    function computeRes(nodeData) {
        var res = null;
        if (nodeData.type == "3") {
            //表达式节点
            if(nodeData.compareValueName !="" && nodeData.compareValueName !=null) {
                return "(" + nodeData.fieldName + " " + nodeData.compareTypeName + " " + nodeData.compareValueName + ")";
            }else{
                return "(" + nodeData.fieldName + " " + nodeData.compareTypeName + " " + nodeData.compareValueFieldName + ")";
            }
        } else if (nodeData.type == "1" || nodeData.type == "2") {
            //逻辑节点
            var sep = null;
            if ("1" == nodeData.type) {
                sep = "&&";
            } else if ("2" == nodeData.type) {
                sep = "||";
            }
            if (typeof nodeData.children != "undefined" && nodeData.children.length != 0) {
                for (var i = 0; i < nodeData.children.length; i++) {
                    if (res == null) {
                        res = computeRes(nodeData.children[i]);
                    } else {
                        var temp = computeRes(nodeData.children[i]);
                        if (temp != null && temp != '')
                            res = "(" + res + sep + temp + ")";
                    }
                }
            } else {
                //假如逻辑节点不含子节点，直接报错
                needChildFlag = true;
            }
            return res;
        }
    };

    //递归获取被删除树的list
    function computeChildList(nodeData, newNodeId) {
        var resList = [];
        //碰到被删除json里有newNodeId就标记并返回
        if (typeof nodeData != "undefined") {
            for (var i = 0; i < nodeData.length; i++) {
                resList.add(nodeData[i].id);
                var temp = computeChildList(nodeData[i].children, newNodeId);
                //合并两个数组
                for (var j = temp.length - 1; j >= 0; j--) {
                    resList.unshift(temp[i]);
                }
            }
        }
        return resList;
    };
    //判断当前弹出页面能否提交
    function newTest() {
        var res = $('.vTree').vtree.getResult();
        var jsonStr = JSON.stringify(res);       //转为JSON字符串
        if (jsonStr == '' || jsonStr == null) {
            layer.alert("请先检查配置树是否正确", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
            return false;
        } else if (newCellId != null) {
            layer.alert("请先给新增树节点赋值", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
            return false;
        }

        //重新计算表达式结果
        if (newCellId != null) {
            layer.alert("不能计算表达式，有节点未完成赋值", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
            return;
        }
        var res = $('.vTree').vtree.getResult();
        var jsonStr = JSON.stringify(res);       //转为JSON字符串
        if (res != null && res != '') {
            var redd = computeRes(res);
            $("#computeLine").text(redd);
            $("#longJson").text(jsonStr);
            if (needChildFlag) {
                layer.alert("'AND(OR)'缺少表达式", {icon: 1, shadeClose: false, time: 60 * 1000, shade: [0.8, '#393D49']});
                return;
            }
        }
        return true;
    };

    /* 将字符串中的所有;替换为@@@ */
    function replaceMark(str) {
        if (str != null && str != '' && typeof str != 'undefined') {
            var reg = new RegExp(';', "g")
            var newstr = str.replace(reg, '@@@');
            return newstr;
        }
        return str;
    };

    /**
     * 设置fieldattr select控件选中
     * @param selectId select的id值
     * @param checkValue 选中option的值
     */
    function set_field_select_checked(selectId, checkId,checkValue,checkTableId,fieldType,activityId,activityName){
        var select = document.getElementById(selectId);

        for (var i = 0; i < select.options.length; i++){
            var _fieldTypeNode = select.options[i].attributes.fieldtype;
            var _fieldType = null;
            if(typeof _fieldTypeNode !='undefined'){
            	_fieldType = _fieldTypeNode.nodeValue;
            }
            if(fieldType == "1" || fieldType == "4"){
                var valN = select.options[i].attributes.fieldname;
                var valNam = null;
                if(typeof valN != 'undefined'){valNam = select.options[i].attributes.fieldname.nodeValue}
                //if (select.options[i].value == checkId && valNam == checkValue && _fieldType==fieldType){
                if (select.options[i].value == checkId && _fieldType==fieldType){
                    select.options[i].selected = true;
                    if(activityId!='undefined' && activityId!=null && activityId!=''){
                    	if(select.options[i].value=='somePerfomer'
                        	|| select.options[i].value=='somePerfomerDept'
                            || select.options[i].value=='somePerfomerRole'
                            || select.options[i].value=='somePerfomerGroup'
                            || select.options[i].value=='somePerfomerPosition'){
                            $("#activityId").val(activityId);
                            $("#activityName").val(activityName);
                        }
                    }
                    break;
                }
            }else{
                var valForm = select.options[i].attributes.tableName;
                var valFormId = null;
                if(typeof valForm != 'undefined'){valFormId = select.options[i].attributes.tableName.nodeValue}
                if (select.options[i].value == checkId && valFormId == checkTableId){
                    select.options[i].selected = true;
                    break;
                }
            }

        }
    };

    /**
     * 设置sep select控件选中
     * @param selectId select的id值
     * @param checkValue 选中option的值
     */
    function set_oper_select_checked(selectId, checkId){
        var select = document.getElementById(selectId);
        for (var i = 0; i < select.options.length; i++){
            if (select.options[i].value == checkId){
                select.options[i].selected = true;
                break;
            }
        }
    };

</script>
</body>
</html>
