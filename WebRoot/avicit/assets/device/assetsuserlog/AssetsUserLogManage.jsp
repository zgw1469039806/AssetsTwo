<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<link href="/static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">

<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsuserlog/assetsUserLogController/toAssetsUserLogManage" -->
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
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceReuse_button_add" permissionDes="Excel导出(客户端)">
            <a id="excel_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
               role="button" title="Excel导出(客户端)"><i class="fa fa-plus"></i> Excel导出(当前页)</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceReuse_button_add" permissionDes="Excel导出(客户端)">
            <a id="excel_insert_all" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
               role="button" title="Excel导出(客户端)" onclick="exportAll()"><i class="fa fa-plus"></i> Excel导出(全部页)</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <%--<div class="input-group form-tool-search">
            <input type="text" name="assetsUserLog_keyWord" id="assetsUserLog_keyWord" style="width:240px;"
                   class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsUserLog_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>--%>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsUserLog_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
                <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsUserLogjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <table class="form_commonTable">
            <%--<tr>

                <th width="10%">操作用户姓名 :</th>
                <td width="39%">
                    <input title="操作用户姓名    " class="form-control input-sm" type="text" name="userName" id="userName"/>
                </td>
				<th width="10%">操作用户部门名称:</th>
				<td width="39%">
					<input title="操作用户部门名称" class="form-control input-sm" type="text" name="deptName" id="deptName"/>
				</td>
            </tr>--%>
           <%-- <tr>
				  <th width="10%">操作用户ID :</th>
                <td width="39%">
                    <input title="操作用户ID  " class="form-control input-sm" type="text" name="userid" id="userid"/>
                </td>
                <th width="10%">操作用户部门ID :</th>
                <td width="39%">
                    <input title="操作用户部门ID " class="form-control input-sm" type="text" name="deptid" id="deptid"/>
                </td>

            </tr>--%>
            <tr>
                <th width="10%">操作时间 (从):</th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="timeBegin" id="timeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">操作时间 (至):</th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="timeEnd" id="timeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">操作IP :</th>
                <td width="39%">
                    <input title="操作IP   " class="form-control input-sm" type="text" name="ip" id="ip"/>
                </td>
                <th width="10%">操作类型:</th>
                <td width="39%">
                    <input title="操作类型" class="form-control input-sm" type="text" name="opType" id="opType"/>
                </td>
            </tr>
            <tr>
                <th width="10%">模块名称 :</th>
                <td width="39%">
                    <input title="模块名称  " class="form-control input-sm" type="text" name="moduleName" id="moduleName"/>
                </td>
				<th width="10%">设备名称 :</th>
				<td width="39%">
					<input title="设备名称 " class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
				</td>
                <%--<th width="10%">模块ID :</th>
                <td width="39%">
                    <input title="模块ID  " class="form-control input-sm" type="text" name="moduleId" id="moduleId"/>
                </td>--%>
            </tr>
            <%--<tr>

                <th width="10%">设备ID :</th>
                <td width="39%">
                    <input title="设备ID " class="form-control input-sm" type="text" name="deviceid" id="deviceid"/>
                </td>
            </tr>--%>
            <tr>
                <th width="10%">日志内容:</th>
                <td width="39%">
                    <input title="日志内容" class="form-control input-sm" type="text" name="logContent" id="logContent"/>
                </td>
                <th width="10%">操作结果 :</th>
                <td width="39%">
                    <input title="操作结果 " class="form-control input-sm" type="text" name="opResult" id="opResult"/>
                </td>
            </tr>
            <tr>
               <%-- <th width="10%">密级:</th>
                <td width="39%">
                    <input title="密级" class="form-control input-sm" type="text" name="secretLevel" id="secretLevel"/>
                </td>--%>
                <th width="10%">业务来源:</th>
                <td width="39%">
                    <input title="业务来源（流程名称）" class="form-control input-sm" type="text" name="source" id="source"/>
                </td>
                   <th width="10%">统一编号:</th>
                   <td width="39%">
                       <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                   </td>
            </tr>
            <%--<tr>
                <th width="10%">业务来源的ID （流程名称的ID） :</th>
                <td width="39%">
                    <input title="业务来源的ID （流程名称的ID）  " class="form-control input-sm" type="text" name="sourceid"
                           id="sourceid"/>
                </td>
                <th width="10%">履历卡:</th>
                <td width="39%">
                    <input title="履历卡" class="form-control input-sm" type="text" name="formid" id="formid"/>
                </td>
            </tr>--%>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<%--<jsp:include page="/avicit/assets/device/assetsdeviceaccount/AssetsDeviceAccountManage.jsp">--%>
    <%--<jsp:param value="<%=importlibs%>" name="importlibs"/>--%>
<%--</jsp:include>--%>
<script src="avicit/assets/device/assetsuserlog/js/AssetsUserLog.js" type="text/javascript"></script>
<script src="static/js/platform/index/js/jQuery/jQuery-easyui-1.2.6/jquery.easyui.min.js" type="text/javascript"></script>
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script src="avicit/platform6/bs3centralcontrol/appliaction/js/AppList.js" type="text/javascript"></script>
<script type="text/javascript" src="avicit/platform6/console/consolelog/js/conlog.js" ></script>



<script type="text/javascript">
    var assetsUserLog;
    $("#excel_insert").on("click",function () {
       $("#exportExcel_jqGridPager").click();
    });

    function formatValue(cellvalue, options, rowObject) {
        if (rowObject.source==null||rowObject.source==""){
            return '<a href="javascript:void(0);" onclick="openProductModelLayer(\'' + rowObject.formid + '\')">' + cellvalue + '</a>';
        }else{
            return '<a href="javascript:void(0);" onclick="openTest(\'' + rowObject.formid + '\')">' + cellvalue + '</a>';
        }
    }


    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format1(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsUserLog.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    function format1(time){
        if(time){
            if (typeof(time)=="string") {
                time = time.replace(/\-/g, "\/");
            }
            var datetime = new Date(time);
            var year = datetime.getFullYear();
            var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
            var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
            var hour = datetime.getHours()< 10 ? "0" + datetime.getHours() : datetime.getHours();
            var minute = datetime.getMinutes()< 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
            var second = datetime.getSeconds()< 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
            return year + "-" + month + "-" + date +" "+ hour + ":" + minute + ":" + second;
        }
        return '';
    }


    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            //, {label: '操作用户ID  ', name: 'userid', width: 150, formatter: formatValue}
            , {label: '发起人    ', name: 'userName', width: 85 }
            //, {label: '操作用户部门ID ', name: 'deptid', width: 150}
            , {label: '发起人部门', name: 'deptName', width: 150}
            , {label: '操作时间  ', name: 'lastUpdateDate', width: 130, formatter: format1}
            , {label: '操作IP   ', name: 'lastUpdateIp', width: 110}
            , {label: '操作类型', name: 'opType', width: 65}
            , {label: '模块名称  ', name: 'moduleName', width: 100}
            //, {label: '模块ID  ', name: 'moduleId', width: 150}
            , {label: '设备名称 ', name: 'deviceName', width:100}
           // , {label: '设备ID ', name: 'deviceid', width: 150}
            , {label: '统一编号', name: 'unifiedId', width: 90}
            , {label: '日志内容', name: 'logContent', width: 430}
           // , {label: '操作结果 ', name: 'opResut', width: 75}
           // , {label: '密级', name: 'secretLevel', width: 75}
            , {label: '业务来源', name: 'source', width: 100}
            //, {label: '业务来源的ID （流程名称的ID）  ', name: 'sourceid', width: 150}
            , {label: '详情', name: 'attribute01', width: 90,formatter: formatValue}


        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("userid");
        searchTips.push("操作用户ID  ");
        searchNames.push("userName");
        searchTips.push("操作用户姓名    ");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsUserLog_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsUserLog = new AssetsUserLog('assetsUserLogjqGrid', '${url}', 'searchDialog', 'form', 'assetsUserLog_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsUserLog_insert').bind('click', function () {
            assetsUserLog.insert();
        });
        //编辑按钮绑定事件
        $('#assetsUserLog_modify').bind('click', function () {
            assetsUserLog.modify();
        });
        //删除按钮绑定事件
        $('#assetsUserLog_del').bind('click', function () {
            assetsUserLog.del();
        });
        //查询按钮绑定事件
        $('#assetsUserLog_searchPart').bind('click', function () {
            assetsUserLog.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsUserLog_searchAll').bind('click', function () {
            assetsUserLog.openSearchForm(this);
        });

    });

    function openTest(id) {
        console.log(id);
       // debugger;
        flowUtils.detail(id);
    }

    function openProductModelLayer (url){
        this.openIndex = layer.open({
            type: 2,
            area: ['100%', '100%'],
            title: '台账信息',
            skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
            maxmin: false, //开启最大化最小化按钮
            content: "/assets/platform/assets/device/assetsdeviceaccount/assetsDeviceAccountController/operation/Detail/"+url

        });
    };

    /**
     * 导出日志(服务端数据)
     */

</script>
</html>