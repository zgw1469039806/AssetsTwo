<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";

    String isRightFrame = request.getParameter("isRightFrame"); //菜单路径参数是否测试设备isRightFrame

%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/lab/assetslaborder/assetsLabOrderController/toAssetsLabOrderManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsLabOrder_button_add" permissionDes="添加">
            <a id="assetsLabOrder_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsLabOrder_button_edit"
                               permissionDes="编辑">
            <a id="assetsLabOrder_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="编辑" style="display:none;"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsLabOrder_button_delete"
                               permissionDes="删除">
            <a id="assetsLabOrder_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="删除" style="display:none;"><i class="fa fa-trash-o"></i> 删除</a>
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
            <input type="text" name="assetsLabOrder_keyWord" id="assetsLabOrder_keyWord" style="width:240px;"
                   class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsLabOrder_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsLabOrder_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
                <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsLabOrderjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">预约单号:</th>
                <td width="15%">
                    <input title="预约单号" class="form-control input-sm" type="text" name="orderNumber" id="orderNumber"/>
                </td>
                <th width="10%">申请人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="applyId" name="applyId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="applyIdAlias"
                               name="applyIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">申请部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="applyDept" name="applyDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="applyDeptAlias"
                               name="applyDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">联系电话:</th>
                <td width="15%">
                    <input title="联系电话" class="form-control input-sm" type="text" name="telephone" id="telephone"/>
                </td>
            </tr>
            <tr>
                <th width="10%">试件名称:</th>
                <td width="15%">
                    <input title="试件名称" class="form-control input-sm" type="text" name="tdeviceName" id="tdeviceName"/>
                </td>
                <th width="10%">试件代号:</th>
                <td width="15%">
                    <input title="试件代号" class="form-control input-sm" type="text" name="tdeviceCode" id="tdeviceCode"/>
                </td>
                <th width="10%">试件型号:</th>
                <td width="15%">
                    <input title="试件型号" class="form-control input-sm" type="text" name="tdeviceModel"
                           id="tdeviceModel"/>
                </td>
                <th width="10%">试件编号:</th>
                <td width="15%">
                    <input title="试件编号" class="form-control input-sm" type="text" name="tdeviceNum" id="tdeviceNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">所属机型:</th>
                <td width="15%">
                    <input title="所属机型" class="form-control input-sm" type="text" name="belongModel" id="belongModel"/>
                </td>
                <th width="10%">试验类型:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="testType" id="testType" title="试验类型"
                                  isNull="true" lookupCode="TEST_TYPE"/>
                </td>
                <th width="10%">试验性质:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="testNature" id="testNature" title="试验性质"
                                  isNull="true" lookupCode="TEST_NATURE"/>
                </td>
                <th width="10%">试验条件:</th>
                <td width="15%">
                    <input title="试验条件" class="form-control input-sm" type="text" name="testCondition"
                           id="testCondition"/>
                </td>
            </tr>
            <tr>
                <th width="10%">配套工装:</th>
                <td width="15%">
                    <input title="配套工装" class="form-control input-sm" type="text" name="supportTool" id="supportTool"/>
                </td>
                <th width="10%">预约开始时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="orderStartTimeBegin"
                               id="orderStartTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">预约开始时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="orderStartTimeEnd"
                               id="orderStartTimeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">预约结束时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="orderFinishTimeBegin"
                               id="orderFinishTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">预约结束时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="orderFinishTimeEnd"
                               id="orderFinishTimeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">实验设备ID:</th>
                <td width="15%">
                    <input title="实验设备ID" class="form-control input-sm" type="text" name="labDeviceId"
                           id="labDeviceId"/>
                </td>
                <th width="10%">实验设备统一编号:</th>
                <td width="15%">
                    <input title="实验设备统一编号" class="form-control input-sm" type="text" name="labDeviceUid"
                           id="labDeviceUid"/>
                </td>
                <th width="10%">实验设备名称:</th>
                <td width="15%">
                    <input title="实验设备名称" class="form-control input-sm" type="text" name="labDeviceName"
                           id="labDeviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">审核开始时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="approvalStartTimeBegin"
                               id="approvalStartTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">审核开始时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="approvalStartTimeEnd"
                               id="approvalStartTimeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">审核结束时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="approvalFinishTimeBegin"
                               id="approvalFinishTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">审核结束时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="approvalFinishTimeEnd"
                               id="approvalFinishTimeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">实际开始时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="actualStartTimeBegin"
                               id="actualStartTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">实际开始时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="actualStartTimeEnd"
                               id="actualStartTimeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">实际结束时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="actualFinishTimeBegin"
                               id="actualFinishTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">实际结束时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="actualFinishTimeEnd"
                               id="actualFinishTimeEnd"/>
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
<script src="avicit/assets/lab/assetslaborder/js/AssetsLabOrder.js" type="text/javascript"></script>
<script type="text/javascript">
    var assetsLabOrder;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsLabOrder.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsLabOrder.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsLabOrder.reLoad();
    };
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '预约单号', name: 'orderNumber', width: 160, formatter:formatValue}
            , {label: '申请人', name: 'applyIdAlias', width: 150}
            // , {label: '申请部门', name: 'applyDeptAlias', width: 150}
            , {label: '联系电话', name: 'telephone', width: 150}
            , {label: '试件名称', name: 'tdeviceName', width: 150}
            // , {label: '试件代号', name: 'tdeviceCode', width: 150}
            // , {label: '试件型号', name: 'tdeviceModel', width: 150}
            // , {label: '试件编号', name: 'tdeviceNum', width: 150}
            // , {label: '所属机型', name: 'belongModel', width: 150}
            // , {label: '试验类型', name: 'testType', width: 150}
            // , {label: '试验性质', name: 'testNature', width: 150}
            // , {label: '试验条件', name: 'testCondition', width: 150}
            // , {label: '配套工装', name: 'supportTool', width: 150}
            , {label: '预约开始时间', name: 'orderStartTime', width: 160, formatter: formatDateTimeNoSecond}
            , {label: '预约结束时间', name: 'orderFinishTime', width: 160, formatter: formatDateTimeNoSecond}
            // , {label: '实验设备ID', name: 'labDeviceId', width: 150}
            , {label: '实验设备统一编号', name: 'labDeviceUid', width: 160}
            , {label: '实验设备名称', name: 'labDeviceName', width: 160}
            , {label: '审核开始时间', name: 'approvalStartTime', width: 160, formatter: formatDateTimeNoSecond}
            , {label: '审核结束时间', name: 'approvalFinishTime', width: 160, formatter: formatDateTimeNoSecond}
            , {label: '实际开始时间', name: 'actualStartTime', width: 160, formatter: formatDateTimeNoSecond}
            , {label: '实际结束时间', name: 'actualFinishTime', width: 160, formatter: formatDateTimeNoSecond}
            <sec:accesscontrollist hasPermission="3" domainObject="assetsLabOrder_table_activityalias" permissionDes="流程当前步骤">
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="assetsLabOrder_table_businessstate" permissionDes="流程状态">
            , {label: '流程状态', name: 'businessstate_', width: 150}
            </sec:accesscontrollist>
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("orderNumber");
        searchTips.push("预约单号");
        searchNames.push("telephone");
        searchTips.push("联系电话");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsLabOrder_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsLabOrder = new AssetsLabOrder('assetsLabOrderjqGrid', '${url}', 'searchDialog', 'form', 'assetsLabOrder_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsLabOrder_insert').bind('click', function () {
            assetsLabOrder.insert();
        });
        //编辑按钮绑定事件
        $('#assetsLabOrder_modify').bind('click', function () {
            assetsLabOrder.modify();
        });
        //删除按钮绑定事件
        $('#assetsLabOrder_del').bind('click', function () {
            assetsLabOrder.del();
        });
        //查询按钮绑定事件
        $('#assetsLabOrder_searchPart').bind('click', function () {
            assetsLabOrder.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsLabOrder_searchAll').bind('click', function () {
            assetsLabOrder.openSearchForm(this, 800, 400);
        });
        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsLabOrder.initWorkFlow($(this).val());
        });
        $('#applyIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'applyId', textFiled: 'applyIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#applyDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'applyDept', textFiled: 'applyDeptAlias'});
            this.blur();
            nullInput(e);
        });


        //判断是否为右侧iframe
        var isRightFrame = '<%=isRightFrame%>';

        /*
        判断是否为实验室设备的弹出选择页
        * */
        var labSelectParam;
        var isLabDeviceSelectPage = "false";
        labSelectParam = sessionStorage.getItem("labSelectParam");
        if(labSelectParam != null){
            isLabDeviceSelectPage = JSON.parse(labSelectParam).isLabDeviceSelectPage;
        }
        if(isLabDeviceSelectPage == "true" || isRightFrame == "Y"){
            //申请人不显示
            $("#assetsLabOrderjqGrid").setGridParam().hideCol("applyIdAlias");
            //联系电话不显示
            $("#assetsLabOrderjqGrid").setGridParam().hideCol("telephone");
            //试件名称不显示
            $("#assetsLabOrderjqGrid").setGridParam().hideCol("tdeviceName");
            //实验设备统一编号不显示
            $("#assetsLabOrderjqGrid").setGridParam().hideCol("labDeviceUid");
            //实验设备名称不显示
            $("#assetsLabOrderjqGrid").setGridParam().hideCol("labDeviceName");
            //流程当前步骤不显示
            $("#assetsLabOrderjqGrid").setGridParam().hideCol("activityalias_");
            //流程状态不显示
            $("#assetsLabOrderjqGrid").setGridParam().hideCol("businessstate_");
        }
        else{

        }

        if(sessionStorage.getItem("labSelectParam")!=""){
            //sessionStorage.removeItem("labSelectParam");
        }


    });

</script>
</html>