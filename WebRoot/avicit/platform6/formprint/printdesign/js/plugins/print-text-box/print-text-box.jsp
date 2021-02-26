<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form class="form">
    <input type="hidden" name="elementType" id="elementType" value="text">
    <div class="accordion-style1 panel-group" id="accordion">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"
                       href="#collapse1">
                        <i data-icon-show="ace-icon fa fa-angle-right" data-icon-hide="ace-icon fa fa-angle-down"
                           class="bigger-110 ace-icon fa fa-angle-down"></i>
                        元素基本属性
                    </a>
                </h4>
            </div>
            <div id="collapse1" class="panel-collapse collapse in">
                <div class="panel-body">
                    <%--1.添加公共"基本属性"--%>
                    <jsp:include page="../attr-jsp/base-attr.jsp"/>

                    <%--2.添加当前元素特定"基本属性"--%>
                    <table>
                        <tr><td>
                            <div class="form-group" style="width:99%">
                                <label class="control-label">行数：</label>
                                <input type="text" name="rows" id="rows" class="input-medium" style="width:100%" defaultValue="1">
                            </div>
                        </td></tr>
                        <tr><td>
                            <div class="form-group" style="width:99%">
                                <table style="width:100%">
                                    <tr>
                                    <td><label class="control-label" >格式化方式：</label></td>
                                    <td><select name="colformat" id="colformat" onchange="changeMode()" style="width:100%">
                                        <option value="">请选择</option>
                                        <option value="user-box">用户</option>
                                        <option value="dept-box">部门</option>
                                        <option value="role-box">角色</option>
                                        <option value="group-box">群组</option>
                                        <option value="position-box">岗位</option>
                                        <option value="org-box">组织</option>
                                        <option value="date-box">日期</option>
                                        <option value="number-box">数字</option>
                                        <option value="currency-box">货币</option>
                                        <option value="secret-box">密级</option>
                                        <option value="custom-select-box">自定下拉</option>
                                        <option value="lookup">键值/通用代码</option>
                                        <option value="userdefined">自定义转换</option>
                                    </select></td>
                                </tr>

                                </table>
                            </div>
                        </td>
                        </tr>
                        <tr><td>
                            <div class="form-group" id="dateFormatDiv" style="width:99%;display: none">
                                <label class="control-label">日期格式：</label>
                                <select name="attribute03" id="attribute03" style="width:100%">
                                    <option value="2">Y-m-d</option>
                                    <option value="1">Y-m-d H:i</option>
                                </select>
                            </div>
                        </td>
                        </tr>
                        <tr><td>
                            <div class="form-group" id="numberFormatDiv" style="width:99%;display: none">
                                <label class="control-label">小数位数：</label>
                                <input type="text" name="attribute02" id="attribute02" value="0" class="input-medium" style="width:99%">
                            </div>
                        </td></tr>
                        <tr><td>
                        <div class="form-group"  id="currencyFormatDiv" style="width:99%;display: none">
                            <table style="width:100%"><tr>
                                <td><label class="control-label">币种：</label></td>
                                <td>
                                    <select id="selectCurrency" name="selectCurrency" style="width:100%">
                                        <option value="￥">￥-人民币</option>
                                        <option value="$">$-美元</option>
                                        <option value="€">€-欧元</option>
                                        <option value="￡">￡-英镑</option>
                                    </select>
                                </td></tr></table>
                        </div>
                        </td></tr>
                        <tr><td>
                            <div class="form-group" id="customFormatDiv" style="width:99%;display: none">
                                <label for="customCode">自定下拉编码：</label>
                                <input type="text" name="customCode" id="customCode" style="width:100%">
                            </div>
                        </td></tr>
                        <tr><td>
                        <div class="form-group" id="lookupFormatDiv" style="width:99%;display: none">
                            <label class="control-label">键值区域：</label>
                            <div id="selectarea">
                            </div>
                        </div>
                        </td></tr>
                        <tr><td>
                            <div class="form-group" id="defineFormatDiv" style="width:99%;display: none">
                                <label class="control-label">转化类路径：</label>
                                <input type="text" name="userdefinedclass" id="userdefinedclass" style="width:100%">
                            </div>
                        </td></tr>
                    </table>
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"
                       href="#collapse3">
                        <i data-icon-show="ace-icon fa fa-angle-right" data-icon-hide="ace-icon fa fa-angle-down"
                           class="bigger-110 ace-icon fa fa-angle-right"></i>
                        元素事件属性
                    </a>
                </h4>
            </div>
            <div id="collapse3" class="panel-collapse collapse">
                <div class="panel-body">
                    <%--1.添加公共"事件属性"--%>
                    <jsp:include page="../attr-jsp/event-attr.jsp"/>

                    <%--2.添加当前元素特定"事件属性"--%>
                </div>
            </div>
        </div>
        
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"
                       href="#collapse_css">
                        <i data-icon-show="ace-icon fa fa-angle-right" data-icon-hide="ace-icon fa fa-angle-down"
                           class="bigger-110 ace-icon fa fa-angle-right"></i>
                       css扩展属性
                    </a>
                </h4>
            </div>
            <div id="collapse_css" class="panel-collapse collapse">
                <div class="panel-body">
                    <%--1.添加css扩展"--%>
                    <jsp:include page="../attr-jsp/css-attr.jsp"/>
                </div>
            </div>
        </div>
        
    </div>
</form>

<script>
    function changeMode() {
        var mode = $('#colformat').val();
        switch (mode) {
            case "date-box":
                $("#dateFormatDiv").css("display","block");
                $("#numberFormatDiv").css("display","none");
                $("#currencyFormatDiv").css("display","none");
                $("#customFormatDiv").css("display","none");
                $("#lookupFormatDiv").css("display","none");
                $("#defineFormatDiv").css("display","none");
                break;
            case "number-box":
                $("#numberFormatDiv").css("display","block");
                $("#dateFormatDiv").css("display","none");
                $("#currencyFormatDiv").css("display","none");
                $("#customFormatDiv").css("display","none");
                $("#lookupFormatDiv").css("display","none");
                $("#defineFormatDiv").css("display","none");
                break;
            case "currency-box":
                $("#currencyFormatDiv").css("display","block");
                $("#dateFormatDiv").css("display","none");
                $("#numberFormatDiv").css("display","none");
                $("#customFormatDiv").css("display","none");
                $("#lookupFormatDiv").css("display","none");
                $("#defineFormatDiv").css("display","none");
                break;
            case "custom-select-box":
                $("#customFormatDiv").css("display","block");
                $("#dateFormatDiv").css("display","none");
                $("#numberFormatDiv").css("display","none");
                $("#currencyFormatDiv").css("display","none");
                $("#lookupFormatDiv").css("display","none");
                $("#defineFormatDiv").css("display","none");
                break;
            case "lookup":
                $("#lookupFormatDiv").css("display","block");
                $("#dateFormatDiv").css("display","none");
                $("#numberFormatDiv").css("display","none");
                $("#currencyFormatDiv").css("display","none");
                $("#customFormatDiv").css("display","none");
                $("#defineFormatDiv").css("display","none");
                break;
            case "userdefined":
                $("#defineFormatDiv").css("display","block");
                $("#dateFormatDiv").css("display","none");
                $("#numberFormatDiv").css("display","none");
                $("#currencyFormatDiv").css("display","none");
                $("#customFormatDiv").css("display","none");
                $("#lookupFormatDiv").css("display","none");
                break;
            default:
                $("#dateFormatDiv").css("display","none");
                $("#numberFormatDiv").css("display","none");
                $("#currencyFormatDiv").css("display","none");
                $("#customFormatDiv").css("display","none");
                $("#lookupFormatDiv").css("display","none");
                $("#defineFormatDiv").css("display","none");
                break;
        }
    }
</script>