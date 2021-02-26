<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
    String singleSelect = request.getParameter("singleSelect"); // 是否单选参数（true-单选,flae-多选）
    if("undefined".equals(singleSelect) || "".equals(singleSelect) || !"false".equals(singleSelect)){ // 如果不传或者传false以外的值时默认单选
        singleSelect = "true";
    }
    String requestType = request.getParameter("requestType"); // 页面调用字段识别，用于一个页面有多个相同弹出页面时使用
    if("undefined".equals(requestType) || "".equals(requestType)){
        requestType = "productModelSelect";
    }
    String callBackFn = request.getParameter("callBackFn"); // 回调函数名称
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/dynusdassetsntc/dynUsdassetsNtcController/toDynUsdassetsNtcManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<style>
    tbody tr {
        text-align: center;
    }
</style>
<body class="easyui-layout" fit="true">
<div id="panelnorth"
     data-options="region:'north',height:fixheight(1),onResize:function(a){$('#dynUsdassetsNtc').setGridWidth(a);$('#dynUsdassetsNtc').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
    <div id="toolbar_dynUsdassetsNtc" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3"
                                   domainObject="formdialog_cspBdProductModel_button_add"
                                   permissionDes="提交">
                <a id="cspBdProductModel_commit" href="javascript:void(0)"
                   class="btn btn-primary form-tool-btn btn-sm" role="button"
                   title="提交"><i class="fa fa-plus"></i>提交</a>
            </sec:accesscontrollist>
        </div>
        <div class="toolbar-right">
            <select id="workFlowSelect"
                    class="form-control input-sm workflow-select">
                <option value="all" selected="selected">全部</option>
                <option value="start">拟稿中</option>
                <option value="active">流转中</option>
                <option value="ended">已完成</option>
            </select>
            <div class="input-group form-tool-search" style="width:125px">
                <input type="text" name="dynUsdassetsNtc_keyWord" id="dynUsdassetsNtc_keyWord" style="width:125px;"
                       class="form-control input-sm" placeholder="请输入查询条件">
                <label id="dynUsdassetsNtc_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="dynUsdassetsNtc_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
                    <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="dynUsdassetsNtc"></table>
    <div id="dynUsdassetsNtcPager"></div>
</div>

</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">申请人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="author" name="author">
                        <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" name="authorAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">年度:</th>
                <td width="15%">
                    <input title="年度" class="form-control input-sm" type="text" name="applyYear" id="applyYear"/>
                </td>
                <th width="10%">部门上报截至日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="deptDeadlineBegin"
                               id="deptDeadlineBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">部门上报截至日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="deptDeadlineEnd"
                               id="deptDeadlineEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">发布日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedateBegin"
                               id="releasedateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">发布日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedateEnd" id="releasedateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">电话:</th>
                <td width="15%">
                    <input title="电话" class="form-control input-sm" type="text" name="telephone" id="telephone"/>
                </td>
                <th width="10%">发布人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="dept" name="dept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" name="deptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">备注:</th>
                <td width="15%">
                    <input title="备注" class="form-control input-sm" type="text" name="formRemarks" id="formRemarks"/>
                </td>
                <th width="10%">标题:</th>
                <td width="15%">
                    <input title="标题" class="form-control input-sm" type="text" name="formTitle" id="formTitle"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script src="avicit/assets/device/dynusdassetsntc/js/DynUsdassetsNtcSelect.js" type="text/javascript"></script>
<script src="avicit/assets/device/dynusdassetsntc/js/AssetsUstdtempapplyCollect.js" type="text/javascript"></script>
<script src="avicit/assets/device/dynusdassetsntc/js/AssetsUstdCollectCm.js" type="text/javascript"></script>
<script type="text/javascript">
    var dynUsdassetsNtc;
    var singleSelect = '<%=singleSelect%>';
    var requestType = '<%=requestType%>';
    var callBackFn = '<%=callBackFn%>';

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="dynUsdassetsNtc.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="dynUsdassetsNtc.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        dynUsdassetsNtc.reLoad();
    };

    $(document).ready(function () {
        var searchMainNames = new Array();
        var searchMainTips = new Array();
        searchMainNames.push("formTitle");
        searchMainTips.push("标题");
        searchMainNames.push("applyYear");
        searchMainTips.push("年度");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#dynUsdassetsNtc_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#dynUsdassetsNtc_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);
        var searchSubNames = new Array();
        var searchSubTips = new Array();
        searchSubNames.push("stdId");
        searchSubTips.push("申购单号");
        searchSubNames.push("createdByDept");
        searchSubTips.push("申请人部门");
        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
        $('#assetsUstdtempapplyCollect_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        $('#assetsUstdtempapplyCollect_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);
        $('#assetsUstdCollectCm_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        $('#assetsUstdCollectCm_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);
        var dynUsdassetsNtcGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '标题', name: 'formTitle', width: 300}
            , {label: '年度', name: 'applyYear', width: 150}
            , {label: '发布人', name: 'authorAlias', width: 150, formatter: formatValue}
            , {label: '发布人部门', name: 'deptAlias', width: 150}
            , {label: '发布日期', name: 'releasedate', width: 150, formatter: format}
            , {label: '部门上报截至日期', name: 'deptDeadline', width: 150, formatter: format}
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            , {label: '流程状态', name: 'businessstate_', width: 150}
        ];


        dynUsdassetsNtc = new DynUsdassetsNtc('dynUsdassetsNtc', '${url}', 'form', dynUsdassetsNtcGridColModel, 'searchDialog',
            function (pid) {
                },
            function (pid) {
            },
            searchMainNames,
            "dynUsdassetsNtc_keyWord");
        //主表操作
        //添加按钮绑定事件
        $('#dynUsdassetsNtc_insert').bind('click', function () {
            dynUsdassetsNtc.insert();
        });
        //编辑按钮绑定事件
        $('#dynUsdassetsNtc_modify').bind('click', function () {
            dynUsdassetsNtc.modify();
        });
        //删除按钮绑定事件
        $('#dynUsdassetsNtc_del').bind('click', function () {
            dynUsdassetsNtc.del();
        });
        //打开高级查询框
        $('#dynUsdassetsNtc_searchAll').bind('click', function () {
            dynUsdassetsNtc.openSearchForm(this, $('#dynUsdassetsNtc'));
        });
        //关键字段查询按钮绑定事件
        $('#dynUsdassetsNtc_searchPart').bind('click', function () {
            dynUsdassetsNtc.searchByKeyWord();
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            dynUsdassetsNtc.initWorkFlow($(this).val());
        });

        $('#cspBdProductModel_commit').bind('click',
            function() {
                dynUsdassetsNtc.submit();
            });

    });

</script>
</html>