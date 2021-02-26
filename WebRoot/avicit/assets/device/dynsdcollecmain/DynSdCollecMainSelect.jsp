<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <!-- ControllerPath = "assets/device/dynsdcollecmain/dynSdCollecMainController/toDynSdCollecMainManage" -->
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
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3"
                               domainObject="formdialog_cspBdProductModel_button_add"
                               permissionDes="提交">
            <a id="cspBdProductModel_insert" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button"
               title="提交"><i class="fa fa-plus"></i>提交</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <select id="workFlowSelect" class="form-control input-sm workflow-select">
            <option value="all" selected="selected">全部</option>
            <option value="start">拟稿中</option>
            <option value="active">流转中</option>
            <option value="ended">已完成</option>
        </select>
        <div class="input-group form-tool-search">
            <input type="text" name="dynSdCollecMain_keyWord" id="dynSdCollecMain_keyWord" style="width:240px;"
                   class="form-control input-sm" placeholder="请输入查询条件">
            <label id="dynSdCollecMain_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="dynSdCollecMain_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button"
               title="高级查询">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="dynSdCollecMainjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">发布人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="author" name="author">
                        <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" name="authorAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
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
            </tr>
            <tr>
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
                <th width="10%">备注:</th>
                <td width="15%">
                    <input title="备注" class="form-control input-sm" type="text" name="formRemarks" id="formRemarks"/>
                </td>
                <th width="10%">标题:</th>
                <td width="15%">
                    <input title="标题" class="form-control input-sm" type="text" name="formTitle" id="formTitle"/>
                </td>
                <th width="10%">年度:</th>
                <td width="15%">
                    <input title="年度" class="form-control input-sm" type="text" name="applyYear" id="applyYear"/>
                </td>
            </tr>
            <tr>
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
                <th width="10%">个人上报截至日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="personDeadlineBegin"
                               id="personDeadlineBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">个人上报截至日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="personDeadlineEnd"
                               id="personDeadlineEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
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
<!-- 业务的js -->
<script src="avicit/assets/device/dynsdcollecmain/js/DynSdCollecMainSelect.js" type="text/javascript"></script>
<script type="text/javascript">
    var dynSdCollecMain;
    var singleSelect = '<%=singleSelect%>';
    var requestType = '<%=requestType%>';
    var callBackFn = '<%=callBackFn%>';

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="dynSdCollecMain.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="dynSdCollecMain.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        dynSdCollecMain.reLoad();
    };
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '标题', name: 'formTitle', width: 150}
            , {label: '发布日期', name: 'releasedate', width: 150,formatter: format}
            <%--, {label: '电话', name: 'telephone', width: 150}--%>
            , {label: '发布人部门', name: 'deptAlias', width: 150}
           /* , {label: '备注', name: 'formRemarks', width: 150}*/
            , {label: '年度', name: 'applyYear', width: 150}
            , {label: '部门上报截至日期', name: 'deptDeadline', width: 150, formatter: format}
            <sec:accesscontrollist hasPermission="3" domainObject="dynSdCollecMain_table_activityalias" permissionDes="流程当前步骤">
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="dynSdCollecMain_table_businessstate" permissionDes="流程状态">
            , {label: '流程状态', name: 'businessstate_', width: 150}
            </sec:accesscontrollist>
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("telephone");
        searchTips.push("电话");
        searchNames.push("formRemarks");
        searchTips.push("备注");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#dynSdCollecMain_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        dynSdCollecMain = new DynSdCollecMain('dynSdCollecMainjqGrid', '${url}', 'searchDialog', 'form', 'dynSdCollecMain_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#dynSdCollecMain_insert').bind('click', function () {
            dynSdCollecMain.insert();
            //flowUtils.openOnDialog('platform/bpm/business/start?defineId=40285f81732d777901732ddc8e82073c-1','标准设备年度申购征集');
        });
        //编辑按钮绑定事件
        $('#dynSdCollecMain_modify').bind('click', function () {
            dynSdCollecMain.modify();
        });
        //删除按钮绑定事件
        $('#dynSdCollecMain_del').bind('click', function () {
            dynSdCollecMain.del();
        });
        //查询按钮绑定事件
        $('#dynSdCollecMain_searchPart').bind('click', function () {
            dynSdCollecMain.searchByKeyWord();
        });
        //打开高级查询框
        $('#dynSdCollecMain_searchAll').bind('click', function () {
            dynSdCollecMain.openSearchForm(this, 800, 400);
        });
        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            dynSdCollecMain.initWorkFlow($(this).val());
        });
        $('#authorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'author', textFiled: 'authorAlias'});
            this.blur();
            nullInput(e);
        });
        $('#deptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'dept', textFiled: 'deptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#cspBdProductModel_insert').bind('click',
            function() {
                dynSdCollecMain.submit();
            });

    });

</script>
</html>