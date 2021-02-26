<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/dynassetsreconst/dynAssetsReconstController/toDynAssetsReconstManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div id="panelnorth"
     data-options="region:'north',height:fixheight(1),onResize:function(a){$('#dynAssetsReconst').setGridWidth(a);$('#dynAssetsReconst').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
    <div id="toolbar_dynAssetsReconst" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynAssetsReconst_button_add"
                                   permissionDes="添加">
                <a id="dynAssetsReconst_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynAssetsReconst_button_edit"
                                   permissionDes="编辑">
                <a id="dynAssetsReconst_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   style="display:none;" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynAssetsReconst_button_delete"
                                   permissionDes="删除">
                <a id="dynAssetsReconst_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   style="display:none;" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
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
                <input type="text" name="dynAssetsReconst_keyWord" id="dynAssetsReconst_keyWord" style="width:125px;"
                       class="form-control input-sm" placeholder="请输入查询条件">
                <label id="dynAssetsReconst_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="dynAssetsReconst_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button">高级查询 <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="dynAssetsReconst"></table>
    <div id="dynAssetsReconstPager"></div>
</div>

</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">上报人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="author" name="author">
                        <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" name="authorAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">上报日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedateBegin"
                               id="releasedateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上报日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedateEnd" id="releasedateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上报单位:</th>
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
                <th width="10%">电话:</th>
                <td width="15%">
                    <input title="电话" class="form-control input-sm" type="text" name="tel" id="tel"/>
                </td>
                <th width="10%">年度:</th>
                <td width="15%">
                    <input title="年度" class="form-control input-sm" type="text" name="collectYear" id="collectYear"/>
                </td>
                <th width="10%">关联征集单:</th>
                <td width="15%">
                    <input title="关联征集单" class="form-control input-sm" type="text" name="collectSelect"
                           id="collectSelect"/>
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
<script src="avicit/assets/device/dynassetsreconst/js/DynAssetsReconst.js" type="text/javascript"></script>

<script type="text/javascript">
    var dynAssetsReconst;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="dynAssetsReconst.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="dynAssetsReconst.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        dynAssetsReconst.reLoad();
    };

    $(document).ready(function () {
        var searchMainNames = new Array();
        var searchMainTips = new Array();
        searchMainNames.push("tel");
        searchMainTips.push("电话");
        searchMainNames.push("collectYear");
        searchMainTips.push("年度");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#dynAssetsReconst_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#dynAssetsReconst_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);
        var searchSubNames = new Array();
        var searchSubTips = new Array();
		searchSubNames.push("reconstructionIdR");
        searchSubNames.push("reconstructionId");
        searchSubTips.push("改造申请单号");
        searchSubNames.push("formState");
		searchSubNames.push("formStateR");
        searchSubTips.push("单据状态");
        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";

        var dynAssetsReconstGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '上报人', name: 'authorAlias', width: 150, formatter: formatValue}
            , {label: '上报日期', name: 'releasedate', width: 150, formatter: format}
            , {label: '上报单位', name: 'deptAlias', width: 150}
            , {label: '电话', name: 'tel', width: 150}
            , {label: '年度', name: 'collectYear', width: 150}
            , {label: '关联征集单', name: 'collectSelect', width: 150}
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            , {label: '流程状态', name: 'businessstate_', width: 150}
        ];

        dynAssetsReconst = new DynAssetsReconst('dynAssetsReconst', '${url}', 'form', dynAssetsReconstGridColModel, 'searchDialog',

            searchMainNames,
            "dynAssetsReconst_keyWord");
        //主表操作
        //添加按钮绑定事件
        $('#dynAssetsReconst_insert').bind('click', function () {
            dynAssetsReconst.insert();
        });
        //编辑按钮绑定事件
        $('#dynAssetsReconst_modify').bind('click', function () {
            dynAssetsReconst.modify();
        });
        //删除按钮绑定事件
        $('#dynAssetsReconst_del').bind('click', function () {
            dynAssetsReconst.del();
        });
        //打开高级查询框
        $('#dynAssetsReconst_searchAll').bind('click', function () {
            dynAssetsReconst.openSearchForm(this, $('#dynAssetsReconst'));
        });
        //关键字段查询按钮绑定事件
        $('#dynAssetsReconst_searchPart').bind('click', function () {
            dynAssetsReconst.searchByKeyWord();
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            dynAssetsReconst.initWorkFlow($(this).val());
        });
        //子表操作
        //打开高级查询
        $('#assetsReconstructionCheck_searchAll').bind('click', function () {
            assetsReconstructionCheck.openSearchForm(this, $('#assetsReconstructionCheck'));
        });
		//打开高级查询
		$('#assetsReconstructionR_searchAll').bind(
				'click',
				function() {
					assetsReconstructionR.openSearchForm(this,
							$('#assetsReconstructionR'));
				});
        //关键字段查询按钮绑定事件
        $('#assetsReconstructionCheck_searchPart').bind('click', function () {
            assetsReconstructionCheck.searchByKeyWord();
        });
		//关键字段查询按钮绑定事件
		$('#assetsReconstructionR_searchPart').bind('click',
				function() {
					assetsReconstructionR.searchByKeyWord();
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

        $('#createdByDeptAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDeptSub', textFiled: 'createdByDeptAliasSub'});
            this.blur();
            nullInput(e);
        });
        $('#ownerDeptAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDeptSub', textFiled: 'ownerDeptAliasSub'});
            this.blur();
            nullInput(e);
        });
        $('#ownerIdAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerIdSub', textFiled: 'ownerIdAliasSub'});
            this.blur();
            nullInput(e);
        });


    });

</script>
</html>