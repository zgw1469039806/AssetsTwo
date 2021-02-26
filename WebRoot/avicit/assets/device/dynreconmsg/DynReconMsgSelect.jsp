<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/dynreconmsg/dynReconMsgController/toDynReconMsgManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynReconMsg_button_submit" permissionDes="提交">
            <a id="dynReconMsg_submit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="提交"><i class="fa fa-plus"></i> 提交</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynReconMsg_button_edit" permissionDes="编辑">
            <a id="dynReconMsg_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="编辑" style="display:none;"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynReconMsg_button_delete" permissionDes="删除">
            <a id="dynReconMsg_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button"
               title="删除" style="display:none;"><i class="fa fa-trash-o"></i> 删除</a>
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
            <input type="text" name="dynReconMsg_keyWord" id="dynReconMsg_keyWord" style="width:240px;"
                   class="form-control input-sm" placeholder="请输入查询条件">
            <label id="dynReconMsg_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="dynReconMsg_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
                <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="dynReconMsgjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">年度:</th>
                <td width="15%">
                    <input title="年度" class="form-control input-sm" type="text" name="applyYear" id="applyYear"/>
                </td>
                <th width="10%">字段_1:</th>
                <td width="15%">
                    <input title="字段_1" class="form-control input-sm" type="text" name="author" id="author"/>
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
<!-- 业务的js -->
<script src="avicit/assets/device/dynreconmsg/js/DynReconMsgSelect.js" type="text/javascript"></script>
<script type="text/javascript">
    var dynReconMsg;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="dynReconMsg.detail(\'' + rowObject. id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="dynReconMsg.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        dynReconMsg.reLoad();
    };
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '年度', name: 'applyYear', width: 150, }
            , {label: '字段_1', name: 'author', width: 150,hidden: true}
            , {label: '发布日期', name: 'releasedate', width: 150, formatter: format}
            , {label: '部门上报截至日期', name: 'deptDeadline', width: 150, formatter: format}
            , {label: '电话', name: 'telephone', width: 150}
            , {label: '发布人部门', name: 'deptAlias', width: 150}
            , {label: '备注', name: 'formRemarks', width: 150}
            , {label: '标题', name: 'formTitle', width: 150}
            <sec:accesscontrollist hasPermission="3" domainObject="dynReconMsg_table_activityalias" permissionDes="流程当前步骤">
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="dynReconMsg_table_businessstate" permissionDes="流程状态">
            , {label: '流程状态', name: 'businessstate_', width: 150}
            </sec:accesscontrollist>
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("applyYear");
        searchTips.push("年度");
        searchNames.push("telephone");
        searchTips.push("电话");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#dynReconMsg_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        dynReconMsg = new DynReconMsg('dynReconMsgjqGrid', '${url}', 'searchDialog', 'form', 'dynReconMsg_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#dynReconMsg_submit').bind('click', function () {
            dynReconMsg.submit();
        });
        //编辑按钮绑定事件
        $('#dynReconMsg_modify').bind('click', function () {
            dynReconMsg.modify();
        });
        //删除按钮绑定事件
        $('#dynReconMsg_del').bind('click', function () {
            dynReconMsg.del();
        });
        //查询按钮绑定事件
        $('#dynReconMsg_searchPart').bind('click', function () {
            dynReconMsg.searchByKeyWord();
        });
        //打开高级查询框
        $('#dynReconMsg_searchAll').bind('click', function () {
            dynReconMsg.openSearchForm(this, 800, 400);
        });
        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            dynReconMsg.initWorkFlow($(this).val());
        });
        $('#deptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'dept', textFiled: 'deptAlias'});
            this.blur();
            nullInput(e);
        });

    });

</script>
</html>