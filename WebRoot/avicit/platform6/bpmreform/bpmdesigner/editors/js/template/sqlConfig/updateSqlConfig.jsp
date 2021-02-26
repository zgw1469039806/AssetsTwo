<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>配置更新语句</title>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
</head>
<body>
    <form id='SQLConfig'>

        <table class="form_commonTable">
            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formName">UPDATE</label>
                </th>
                <td width="35%">
                    <div class="input-group input-group-sm">
                        <input type="hidden" id="tableId" name="tableId">
                        <input title="数据源" placeholder="请选择数据源" class="form-control input-sm" type="text"
                               id="tableName" required="true" readonly/>
                        <span class="input-group-addon" id="dataSourceBtn"><i class="glyphicon glyphicon-menu-hamburger"></i></span>
                    </div>
                </td>

            </tr>

            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formCode">SET</label>
                </th>
                <td width="35%">
                    <div class="input-group input-group-sm">
                        <input type="hidden" id="columnIdA" name="columnIdA">
                        <input title="数据源" placeholder="请选择字段" class="form-control input-sm" type="text"
                               id="columnNameA" required="true" readonly/>
                        <span class="input-group-addon" id="dataSourceBtn"><i class="glyphicon glyphicon-menu-hamburger"></i></span>
                    </div>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formName"> = </label>
                </th>
                <td width="35%">
                    <input title="值" class="form-control input-sm"  style="width: 99%;" type="text"
                           name="formNameA" id="formNameA" required="true"/>
                </td>
            </tr>
            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="isBpm">WHERE</label>
                </th>
                <td width="35%">
                    <div class="input-group input-group-sm">
                        <input type="hidden" id="columnIdB" name="columnIdB">
                        <input title="数据源" placeholder="请选择字段" class="form-control input-sm" type="text"
                               id="columnNameB" required="true" readonly/>
                        <span class="input-group-addon" id="dataSourceBtn"><i class="glyphicon glyphicon-menu-hamburger"></i></span>
                    </div>
                </td>

                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="dataSourceName"> = </label>
                </th>
                <td width="35%">
                    <input title="值" class="form-control input-sm"  style="width: 99%;" type="text"
                           name="formNameB" id="formNameB"
                           required="true"/>
                </td>
            </tr>

        </table>
    </form>


<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>

<script>
    var tabName = null;
    function getSqlString(){
        var dbTable = tabName;/*$("#tableId").val();*/
        var columnNameA = $("#columnNameA").val();
        var columnValA = $("#formNameA").val().trim();
        var columnNameB = $("#columnNameB").val();
        var columnValB = $("#formNameB").val().trim();
        if(flowUtils.notNull(dbTable) && flowUtils.notNull(columnNameA) && flowUtils.notNull(columnValA)
            && flowUtils.notNull(columnNameB) && flowUtils.notNull(columnValB)){
            var res = "UPDATE "+ dbTable+" SET "+columnNameA+" = "+"'"+columnValA+"'"+" WHERE "+columnNameB+" = "+columnValB;
            return res;
        }else {
            return "";
        }
    };

    //注册选字段动作
    function bindDbColumeName(tableSourceId,inputName) {
        $("#"+inputName).unbind("click");
        $("#"+inputName).click(function () {
            var selectDbcolumeNameB = new SelectDbColumnName(tableSourceId);
            selectDbcolumeNameB.init(function (data) {
                $("#"+inputName).val(data.colName).trigger("keyup");
            });

        });
        
    };
    //綁定选字段的回调
    function selectClmCB(souceId) {
        if(souceId.id != null && souceId.id != "" && typeof souceId != "undefined"){
            bindDbColumeName(souceId.id,"columnNameA");
            bindDbColumeName(souceId.id,"columnNameB");

            //更新表的英文名称
            tabName = souceId.tablename;
            $("#tableName").val(tabName);
        }
    };
    //验证form必填项
    function checkRe() {
        var isValidate = $("#SQLConfig").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
        var formNameA = $("#formNameA").val();
        if(formNameA.indexOf("'") !== -1 || formNameA.indexOf("\"") !== -1 || formNameA.indexOf("\\") !== -1 || formNameA.indexOf("&") !== -1) {
            //layer.msg('输入字段不能含有特殊字符！', {icon: 7});
            return "inputErr";
        }
        var formNameB = $("#formNameB").val();
        if(formNameB.indexOf("'") !== -1 || formNameB.indexOf("\"") !== -1 || formNameB.indexOf("\\") !== -1 || formNameB.indexOf("&") !== -1) {
            //layer.msg('输入字段不能含有特殊字符！', {icon: 7});
            return "inputErr";
        }
        return"ok"
    };
    var selectDBTable;
    $(function() {
        selectDBTable = new SelectCreatedDbTable("tableId","tableName");
        selectDBTable.init(selectClmCB);

    });
</script>
</body>
<script type="text/javascript" src="avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.js"></script>
<script type="text/javascript" src="avicit/platform6/eform/formdesign/select/selectDbColumnName/selectDbColumnName.js"></script>
</html>
