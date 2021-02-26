<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdevicemcheckproc/assetsDeviceMcheckProcController/toAssetsDeviceMcheckProcManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
 <div id="tableToolbar" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceMcheckProc_button_add"
                                   permissionDes="添加">
                <a id="assetsDeviceMcheckProc_insert" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i>
                    添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceMcheckProc_button_edit"
                                   permissionDes="编辑">
                <a id="assetsDeviceMcheckProc_modify" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="编辑"><i
                        class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceMcheckProc_button_delete"
                                   permissionDes="删除">
                <a id="assetsDeviceMcheckProc_del" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="删除"><i
                        class="fa fa-trash-o"></i> 删除</a>
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
                <input type="text" name="assetsDeviceMcheckProc_keyWord" id="assetsDeviceMcheckProc_keyWord"
                       style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsDeviceMcheckProc_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn" style="display: none">
                <a id="assetsDeviceMcheckProc_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button">高级查询 <span class="caret"></span></a>
            </div>
            <!-- 页面右上角视图切换框——开始 -->
            <div class="input-group form-tool-search" style="width:130px;">
                <input type="text" name="tableViewSelect" id="tableViewSelect" style="width:120px;" class="form-control input-sm" readonly value="${viewList.get(index)}">
            </div>
            <!-- 页面右上角视图切换框——结束 -->

        </div>
    </div>
    <table id="assetsDeviceMcheckProc"></table>
    <div id="assetsDeviceMcheckProcPager"></div>


</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">年度保养单号:</th>
                <td width="15%">
                    <input title="年度保养单号" class="form-control input-sm" type="text" name="maintainCode"
                           id="maintainCode"/>
                </td>
                <th width="10%">计划名称:</th>
                <td width="15%">
                    <input title="计划名称" class="form-control input-sm" type="text" name="planName" id="planName"/>
                </td>
                <th width="10%">年度保养数量:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="maintainNumber" id="maintainNumber"
                               data-min="-<%=Math.pow(10,11)-Math.pow(10,-0)%>"
                               data-max="<%=Math.pow(10,11)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">生成时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="generateDateBegin"
                               id="generateDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">生成时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="generateDateEnd"
                               id="generateDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">实施部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="implementationDepartment" name="implementationDepartment">
                        <input class="form-control" placeholder="请选择部门" type="text" id="implementationDepartmentAlias"
                               name="implementationDepartmentAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">计划生成人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="generateBy" name="generateBy">
                        <input class="form-control" placeholder="请选择用户" type="text" id="generateByAlias"
                               name="generateByAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">年度保养开始时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextMaintainStartDateBegin"
                               id="nextMaintainStartDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">年度保养开始时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextMaintainStartDateEnd"
                               id="nextMaintainStartDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">年度保养结束时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextMaintainEndDateBegin"
                               id="nextMaintainEndDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">年度保养结束时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextMaintainEndDateEnd"
                               id="nextMaintainEndDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">附件:</th>
                <td width="15%">
                    <input title="附件" class="form-control input-sm" type="text" name="attachment" id="attachment"/>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
    </form>
</div>
<!-- 视图选择弹框——开始 -->
<div id="selectViewDialog" style="overflow: auto;display: none">
    <table class="ui-jqgrid-btable ui-common-table table table-bordered" style="width: 140px;">
        <tbody id="selectViewTbody">
        <c:forEach var="index" begin="0" end="${viewList.size()-1}" step="1">
            <c:if test="${viewList.get(index) != '系统默认视图'}">
                <tr>
                    <td role="gridcell" onclick="switchView('${viewList.get(index)}')" title="${viewList.get(index)}">
                            ${viewList.get(index)}
                    </td>
                    <td>
                        <i class="fa fa-file-text-o" onclick="editView('${viewList.get(index)}')" title="编辑视图"></i>
                        <i class="fa fa-trash-o" onclick="delView('${viewList.get(index)}')" title="删除视图"></i>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
        <tr>
            <td role="gridcell" onclick="addView()" title="创建新视图">
                创建新视图
            </td>
            <td>
                <i class="fa fa-plus" onclick="addView()" title="创建视图"></i>
            </td>
        </tr>
        <tr>
            <td colspan="2" role="gridcell" onclick="switchView('系统默认视图')" title="系统默认视图">
                系统默认视图
            </td>
        </tr>
        </tbody>
    </table>
</div>
<!-- 视图选择弹框——结束 -->


<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script src="avicit/assets/device/assetsdevicemcheckproc/js/AssetsDeviceMcheckProc.js" type="text/javascript"></script>
<script src="avicit/assets/device/usertablemodel/js/UserTableModel.js" type="text/javascript"></script>
<script type="text/javascript">
    var assetsDeviceMcheckProc;
    var dataGridColModel;
    var userTableModel=new UserTableModel();//新增视图处理
    var toolbar;//新增工具栏变量
    var searchMainNames = new Array();
    var searchMainTips = new Array();

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsDeviceMcheckProc.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsDeviceMcheckProc.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }
    /*视图管理模块函数——开始*/
    //切换列表视图
    function switchView(viewName){
        var paramList = [];
        paramList.push('AssetsDeviceMcheckProc');
        paramList.push(viewName);

        $.ajax({
            url : "assets/device/usertablemodel/userTableModelController/operation/get",
            data : JSON.stringify(paramList),
            contentType : 'application/json',
            type : 'post',
            dataType : 'json',
            success : function(r){
                if (r.flag == "success"){
                    dataGridColModel = r.dataGridColModelJson;
                    dataGridColModel = JSON.parse(dataGridColModel);

                    for(i=0; i<dataGridColModel.length; i++){
                        if(dataGridColModel[i].formatter != undefined){
                            if(dataGridColModel[i].formatter.indexOf('formatValue') > -1){
                                dataGridColModel[i].formatter = formatValue;
                            }
                            else if(dataGridColModel[i].formatter.indexOf('format') > -1){
                                dataGridColModel[i].formatter = format;
                            }
                        }
                    }

                    //清除列表后刷新
                    $.jgrid.gridUnload('assetsDeviceMcheckProc');
                    assetsDeviceMcheckProc = new AssetsDeviceMcheckProc('assetsDeviceMcheckProc', '${url}', 'form', dataGridColModel, 'searchDialog',
                        function (pid) {
                            //assetsDeviceRcheckPlan = new AssetsDeviceRcheckPlan('assetsDeviceRcheckPlan', '${surl}', "formSub", assetsDeviceRcheckPlanGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsDeviceRcheckPlan_keyWord");
                        },
                        function (pid) {
                            //assetsDeviceRcheckPlan.reLoad(pid);
                        },
                        searchMainNames,
                        "assetsDeviceMcheckProc_keyWord");

                    //添加表头搜索
                    AddHeaderSearch(dataGridColModel, 'assetsDeviceMcheckProc', assetsDeviceMcheckProc);

                    //添加表头拖拽
                    BuildDrag('assetsDeviceMcheckProc', '${url}', 'searchDialog', 'form', 'assetsDeviceMcheckProc_keyWord', dataGridColModel, searchMainNames, assetsDeviceMcheckProc, toolBar);

                    document.getElementById('tableViewSelect').value = viewName;
                }else{
                    layer.alert('视图切换失败,请联系管理员：'+r.message, {
                            icon: 7,
                            area: ['400px', ''], //宽高
                            closeBtn: 0,
                            btn: ['关闭'],
                            title:"提示"
                        }
                    );
                }
            }
        });
    }

    //编辑视图
    function editView(viewName) {
        userTableModel.modify('AssetsDeviceMcheckProc', viewName);
    }

    //删除视图
    function delView(viewName) {
        var trEle = event.target.parentNode.parentNode;
        userTableModel.del('AssetsDeviceMcheckProc', viewName, trEle);
    }

    //创建新视图
    function addView(){
        userTableModel.insert('AssetsDeviceMcheckProc');
    }
    /*视图管理模块函数——结束*/

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsDeviceMcheckProc.reLoad();
    };

    $(document).ready(function () {

        //获取表头字段配置
        dataGridColModel = ${dataGridColModelJson};
        for(i=0; i<dataGridColModel.length; i++){
            for(i=0; i<dataGridColModel.length; i++){
                if(dataGridColModel[i].formatter != undefined){
                    if(dataGridColModel[i].formatter.indexOf('formatValue') > -1){
                        dataGridColModel[i].formatter = formatValue;
                    }
                    else if(dataGridColModel[i].formatter.indexOf('format') > -1){
                        dataGridColModel[i].formatter = format;
                    }
                }
            }
        }

        searchMainNames.push("maintainCode");
        searchMainTips.push("年度保养单号");
        searchMainNames.push("planName");
        searchMainTips.push("计划名称");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#assetsDeviceMcheckProc_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#assetsDeviceMcheckProc_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);


        // var dataGridColModel = [
        //     {label: 'id', name: 'id', key: true, width: 75, hidden: true}
        //     , {label: '年度保养单号', name: 'maintainCode', width: 150, formatter: formatValue}
        //     , {label: '计划名称', name: 'planName', width: 150}
        //     , {label: '年度保养数量', name: 'maintainNumber', width: 150}
        //     , {label: '生成时间', name: 'generateDate', width: 150, formatter: format}
        //     , {label: '实施部门', name: 'implementationDepartmentAlias', width: 150}
        //     , {label: '计划生成人', name: 'generateByAlias', width: 150}
        //     , {label: '年度保养开始时间', name: 'nextMaintainStartDate', width: 150, formatter: format}
        //     , {label: '年度保养结束时间', name: 'nextMaintainEndDate', width: 150, formatter: format}
        //     , {label: '附件', name: 'attachment', width: 150, hidden: true}
        //     , {label: '流程当前步骤', name: 'activityalias_', width: 150}
        //     , {label: '流程状态', name: 'businessstate_', width: 150}
        // ];


        assetsDeviceMcheckProc = new AssetsDeviceMcheckProc('assetsDeviceMcheckProc', '${url}', 'form', dataGridColModel, 'searchDialog',
            function (pid) {
               // assetsDeviceMcheckPlan = new AssetsDeviceMcheckPlan('assetsDeviceMcheckPlan', '${surl}', "formSub", assetsDeviceMcheckPlanGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsDeviceMcheckPlan_keyWord");
            },
            function (pid) {
                //assetsDeviceMcheckPlan.reLoad(pid);
            },
            searchMainNames,
            "assetsDeviceMcheckProc_keyWord");

        //添加表头搜索
        AddHeaderSearch(dataGridColModel, 'assetsDeviceMcheckProc', assetsDeviceMcheckProc);

        //添加表头拖拽
        toolBar = document.getElementById('tableToolbar');

        BuildDrag('assetsDeviceMcheckProc', '${url}', 'searchDialog', 'form', 'assetsDeviceMcheckProc_keyWord', dataGridColModel, searchMainNames, assetsDeviceMcheckProc, toolBar);

        //主表操作
        //添加按钮绑定事件
        $('#assetsDeviceMcheckProc_insert').bind('click', function () {
            assetsDeviceMcheckProc.insert();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceMcheckProc_modify').bind('click', function () {
            assetsDeviceMcheckProc.modify();
        });
        //删除按钮绑定事件
        $('#assetsDeviceMcheckProc_del').bind('click', function () {
            assetsDeviceMcheckProc.del();
        });
        //打开高级查询框
        $('#assetsDeviceMcheckProc_searchAll').bind('click', function () {
            assetsDeviceMcheckProc.openSearchForm(this, $('#assetsDeviceMcheckProc'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsDeviceMcheckProc_searchPart').bind('click', function () {
            assetsDeviceMcheckProc.searchByKeyWord();
        });
//视图切换弹框绑定事件
        $('#tableViewSelect').bind('click', function(){
            assetsDeviceMcheckProc.openSelectView(this,140,200);
        });
        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsDeviceMcheckProc.initWorkFlow($(this).val());
        });


        $('#implementationDepartmentAlias').on('focus', function (e) {
            new H5CommonSelect({
                type: 'deptSelect',
                idFiled: 'implementationDepartment',
                textFiled: 'implementationDepartmentAlias'
            });
            this.blur();
            nullInput(e);
        });
        $('#generateByAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'generateBy', textFiled: 'generateByAlias'});
            this.blur();
            nullInput(e);
        });

        $('#ownerIdAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerIdSub', textFiled: 'ownerIdAliasSub'});
            this.blur();
            nullInput(e);
        });

        $('#ownerDeptAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDeptSub', textFiled: 'ownerDeptAliasSub'});
            this.blur();
            nullInput(e);
        });

    });

</script>
</html>