<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>菜单同步</title>
    <base href="<%=ViewUtil.getRequestPath(request) %>">
    <link href="static/css/platform/sysdept/icon.css" type="text/css"
          rel="stylesheet">
    <jsp:include
            page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<body  class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='addForm'>
        <table class="form_commonTable">
            <tr>
                <th width="8%" style="word-break: break-all; word-warp: break-word;">
                    <label>源组织：</label>
                </th>
                <td width="25%">
                    <input id="orgIdFrom" name="orgIdFrom" >
                </td>
                <%--<td width="25%">--%>
                    <%--<select class="form-control input-sm" id="orgIdFrom">--%>
                        <%--${orgListFrom}--%>
                    <%--</select>--%>
                <%--</td>--%>

                <th width="8%" style="word-break: break-all; word-warp: break-word;">
                    <label>目标组织：</label>
                </th>
                <td width="25%">
                    <input id = "orgIdTo"  name="orgIdTo">
                    <%--<select class="form-control input-sm" id="orgIdTo">--%>
                        <%--${orgListTo}--%>
                    <%--</select>--%>
                </td>

                <th width="8%" style="word-break: break-all; word-warp: break-word;">
                    <label>操作日志：</label>
                </th>
                <td width="25%" rowspan="3">
                    <div id="syncLog">
                    </div>
                </td>
            </tr>

            <tr>
                <th width="8%" style="word-break: break-all; word-warp: break-word;">
                    <label>菜单类型：</label>
                </th>
                <td width="25%" colspan="3">
                    <input id = "menuType" class="easyui-combobox" data-options="
                            valueField: 'code',
                            textField:'type' ,
                            editable : false,
                            panelHeight : 'auto',
                            onSelect:function(record){
                                updateMenuInfo('all');
                            },
                            data: [ { type: '门户小页', code: 'menuPortlet','selected':true},
                                    { type: '门户首页配置', code: 'indexPortlet' }]" />
                </td>
            </tr>

            <tr>
                <th width="8%" style="word-break: break-all; word-warp: break-word;">
                    <label>源组织菜单：</label>
                </th>
                <td width="25%">
                    <div id="orgFromMenu">
                        <table id = "orgFromTable"></table>
                    </div>
                </td>

                <th width="8%" style="word-break: break-all; word-warp: break-word;">
                    <label>目标组织菜单：</label>
                </th>
                <td width="25%">
                    <div id="orgToMenu">
                        <table id = "orgToTable"></table>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>

<div data-options="region:'south',border:false" style="height: 40px;">
    <div  align="right">
        <div style="padding-right:4%;">
            <button id="doSyncOrgMenu" onclick="syncOrgInfo();">开始同步</button>
        </div>
    </div>
    <%--<div id="toolbar"--%>
         <%--class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">--%>
        <%--<table class="tableForm" style="border:0;cellspacing:1;width:100%">--%>
            <%--<tr>--%>
                <%--<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">--%>
                    <%--<a href="javascript:void(0)" style="margin-right:10px;"--%>
                       <%--class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="doSyncOrgMenu">开始同步</a>--%>
                <%--</td>--%>
            <%--</tr>--%>
        <%--</table>--%>
    <%--</div>--%>
</div>

</body>
</html>
<%
// String appId = request.getParameter("appId");
Object admin =session.getAttribute(AfterLoginSessionProcess.SESSION_IS_ADMIN);
%>
<script>
    <%--var appId = "<%=appId%>";--%>
    var admin= "<%=admin%>";

    $("#orgFromMenu").css("height", $(window).height() - 160);
    $("#orgFromMenu").css("overflow", "auto");
    // $("#orgFromMenu").css("border", "1px solid #d3d3d3");

    $("#orgToMenu").css("height", $(window).height() - 175);
    $("#orgToMenu").css("overflow", "auto");
    // $("#orgToMenu").css("border", "1px solid #d3d3d3");

    $("#syncLog").css("height", $(window).height() - 100);
    $("#syncLog").css("overflow", "auto");
    $("#syncLog").css("border", "1px solid #d3d3d3");


    $(function() {
        // 获取组织列表
        var fromCombo = $("#orgIdFrom").combobox({
            valueField : 'id',
            textField : 'name',
            editable : false,
            panelHeight : "auto",
            onSelect:function(record){
                // 更新显示的菜单项
                updateMenuInfo('from');
            },
        });

        var toCombo = $("#orgIdTo").combobox({
            valueField : 'id',
            textField : 'name',
            editable : false,
            panelHeight : "auto",
            onSelect:function (record) {
                updateMenuInfo('to');
            }

        });
        //初始化页面内容
        $.ajax({
            url : 'platform/sysuser/getOrgListByUserId.json',
            type : 'get',
            dataType : 'json',
            success : function(r) {
                if (r && r.flag == 0) {
                    fromCombo.combobox('loadData', r.orglist);
                    fromCombo.combobox('setValue', r.currentOrgId);

                    toCombo.combobox('loadData', r.orglist);
                    toCombo.combobox('setValue', r.currentOrgId);
                }

                // initOrgMenuInfo("orgFromTable", getSyncData().orgIdFrom,getSyncData().menuType);
                initOrgInfoFrom(getSyncData().orgIdFrom,getSyncData().menuType);
                // initOrgMenuInfo("orgToTable", getSyncData().orgIdTo,getSyncData().menuType);
                initOrgInfoTo(getSyncData().orgIdTo,getSyncData().menuType);

            }
        });


    });
    function updateMenuInfo(area) {
        var menuType = getSyncData().menuType;
        if(area == 'from' || area == 'all'){
            updateOrgMenuInfo("orgFromTable", getSyncData().orgIdFrom, menuType);
        }
        if(area == 'to' || area == 'all'){
            updateOrgMenuInfo("orgToTable", getSyncData().orgIdTo, menuType);
        }

    }

    /**
     * 获取组织的门户小页
     */
    // function initOrgMenuInfo(tableId,orgId, menutype) {
    //     $('#'+tableId).datagrid({
    //         url:'platform/IndexPortalController/getOrgPortlets',
    //         method: 'POST',
    //         fit: true,
    //         fitColumns:false,
    //         queryParams: {
    //             isAdmin: admin,
    //             orgId: orgId,
    //             menuType: menutype
    //         },
    //         columns:[[
    //             {field:'portletId',checkbox:true},
    //             {field:'title',title:'门户小页', resizable:true}
    //         ]]
    //     });
    //
    // }

    function initOrgInfoFrom(orgId, menutype) {
        $('#orgFromTable').datagrid({
            url:'platform/IndexPortalController/getOrgPortlets',
            method: 'POST',
            fit: true,
            fitColumns:true,
            queryParams: {
                isAdmin: admin,
                orgId: orgId,
                menuType: menutype
            },
            columns:[[
                {field:'portletId',checkbox:true},
                {field:'title',title:'门户小页',width:400, resizable:true}
            ]]
        });

    }

    function initOrgInfoTo(orgId, menutype) {
        $('#orgToTable').datagrid({
            url:'platform/IndexPortalController/getOrgPortlets',
            method: 'POST',
            fit: true,
            fitColumns:true,
            queryParams: {
                isAdmin: admin,
                orgId: orgId,
                menuType: menutype
            },
            columns:[[
                {field:'title',title:'门户小页',width:400, resizable:true}
            ]]
        });

    }

    // 修改select后重新发送数据
    function updateOrgMenuInfo(tableId,orgId, menutype) {
        $('#'+tableId).datagrid('load',{
            isAdmin: admin,
            orgId: orgId,
            menuType: menutype
        })
    }
    // 同步按钮响应
    function syncOrgInfo() {
        // 如果from和to执行同一个组织，跳过复制操作
        if($('#orgIdFrom').combobox('getValue') == $('#orgIdTo').combobox('getValue')){
            $.messager.show({
                title:'提示',
                msg:'请选择不同的组织！'
            });
            return;
        }
        // 对于配置同步，同步会清除目标组织的配置信息，弹出确认窗口
        var menuType = $("#menuType").combobox('getValue');
        if(menuType == 'indexPortlet' && $('#orgToTable').datagrid('getRows').length > 0){
            $.messager.confirm('确认','同步门户配置将清除目标组织的原有设置，是否继续',function(r) {
                if (r) {
                    doSync();;
                }
            });
        }else{
            doSync();
        }
    }

    // 同步请求
    function doSync(){
        var syncData = getSyncData();
        var orgIdFrom = syncData.orgIdFrom;
        var orgIdTo = syncData.orgIdTo;
        var menuType = syncData.menuType;

        var rows = $("#orgFromTable").datagrid("getSelections");
        var ids = [];
        for(var i=0; i < rows.length; i++){
            ids.push(rows[i].portletId);
        }
        var menuIds=  ids.join(",");

        if(menuIds==null || menuIds == ""){
            $.messager.show({
                title:'提示',
                msg:'请选择需要同步的门户小页！'
            });
            return;
        }

        $.ajax({
            url:'platform/IndexPortalController/syncOrgPortlets',
            data:{
                orgIdFrom: orgIdFrom,
                orgIdTo: orgIdTo,
                menuType: menuType,
                menuIds: menuIds
            },
            type: 'post',
            dataType: 'json',
            success: function (result){
                $("#syncLog").empty();
                var log = result.synclog;
                log = log.replace(/\n/g,"<br>"); ;
                $("#syncLog").html(log);
                if(result.syncflag == 'success'){

                    updateMenuInfo('to');
                    if(result.cacheflag == 'success'){
                        $.messager.show({
                            title:'提示',
                            msg:result.count+'项同步成功'
                        });
                    }else {
                        $.messager.show({
                            title:'提示',
                            msg:result.count+'项同步成功，请在菜单管理中手动刷新缓存'
                        });
                    }

                }else{
                    $.messager.show({
                        title:'提示',
                        msg:'同步失败，请查看页面右侧日志'
                    });
                }

            }
        })
    }
    // 获取选择要同步的数据
    function getSyncData() {
        // 一下值应该是id
        var orgIdFrom = $('#orgIdFrom').combobox('getValue');
        var orgIdTo = $('#orgIdTo').combobox('getValue');
        var menuType = $("#menuType").combobox('getValue');

        var data = {
            orgIdFrom: orgIdFrom,
            orgIdTo: orgIdTo,
            menuType: menuType,
        };

        return data;
    }

</script>