<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.api.session.SessionHelper" %>
<%@ page import="avicit.platform6.api.sysshirolog.utils.SecurityUtil" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
    String username = SessionHelper.getLoginName(request);
    Boolean isAdmin = SecurityUtil.isAdministrator(username);
%>
<!DOCTYPE html>
<html>
<head>
    <title>角色列表</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3"
                               domainObject="formdialog_rolelist_button_add"
                               permissionDes="添加">
            <a id="rolelist_insert" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
               title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3"
                               domainObject="formdialog_rolelist_button_del"
                               permissionDes="删除">
            <a id="rolelist_del" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button"
               title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3"
                               domainObject="formdialog_rolelist_button_save"
                               permissionDes="保存">
            <a id="rolelist_save" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button"
               title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
        </sec:accesscontrollist>
    </div>

</div>
<table id="rolelistjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/console/user/js/rolelist.js" type="text/javascript"></script>
<script type="text/javascript">
    var isAdmin = "<%=isAdmin%>";
    var viewScopeType = '';
    if (isAdmin == "true") {
        viewScopeType = '';
    } else {
        viewScopeType = 'currentOrg';
    }

    function formatStatus(cellvalue, options, rowObject) {

        if (cellvalue == "1") {
            return "有效";
        } else {
            return "无效";
        }
    }

    function formatOrg(cellvalue, options, rowObject) {
        var orgNameTemp = '';
        $.ajax({
            url: 'platform/console/user/getOrgNameByid',
            data: {orgId: cellvalue},
            async: false,
            type: 'post',
            dataType: 'text',
            success: function (orgName) {
                orgNameTemp = orgName;
            }
        });
        return orgNameTemp;
    }

    function formatRoleType(cellvalue, options, rowObject) {

        if (cellvalue == "1") {
            return "用户类型";
        } else if (cellvalue == "0") {
            return "系统类型";
        } else {
            return "";
        }
    }

    var rolelist;
    $(document).ready(
        function () {
            var dataGridColModel = [{
                key: true,
                label: 'id',
                name: 'id',
                width: 75,
                hidden: true
            }, {
                label: 'sysRoleId',
                name: 'sysRoleId',
                width: 70,

                hidden: true

            }, {
                label: '角色名称',
                name: 'roleName',
                width: 150,
                sortable: false,
                editable: true,
                edittype: 'custom',
                editoptions: {
                    custom_element: roleElem,
                    custom_value: roleValue,
                    forId: 'sysRoleId',
                    viewScope: viewScopeType,
                    callBack: function (role) {
                        var currentRowId = rolelist.currentRowId;

                        var rowData = $('#rolelistjqGrid').jqGrid('getRowData', currentRowId);
                        rowData.sysRoleId = role.roleids;
                        rowData.roleTypeId = role.roleType;
                        rowData.roleType = role.roleType;
                        rowData.orgIdentityId = role.orgIdentitys;
                        rowData.orgIdentity = role.orgIdentitys;
                        rowData.validFlag = "1";
                        rowData.validFlagId = "1";

                        var roleName = $(rowData.roleName);
                        roleName.find('#cellRoleidAlias').attr('value', role.roleNames);
                        rowData.roleName = roleName.outerHTML;

                        $('#rolelistjqGrid').jqGrid('setRowData', currentRowId, rowData);
                    }
                }

            }, {
                label: '角色类型ID',
                name: 'roleTypeId',
                width: 150,
                hidden: true

            }, {
                label: '角色类型',
                name: 'roleType',
                width: 150,
                sortable: false,
                formatter: formatRoleType

            }, {
                label: '角色标识ID',
                name: 'validFlagId',
                width: 150,
                hidden: true
            }, {
                label: '角色标识',
                name: 'validFlag',
                width: 150,
                sortable: false,
                formatter: formatStatus


            },
                {
                    label: '部门ID',
                    name: 'sysDeptId',
                    width: 150,
                    hidden: true
                },
                {
                    label: '关联部门',
                    name: 'sysDeptName',
                    width: 150,
                    sortable: false,
                    editable: true,
                    edittype: 'custom',
                    editoptions: {
                        custom_element: deptElem,
                        custom_value: deptValue,
                        forId: 'sysDeptId',
                        viewScope: viewScopeType
                    }
                },
                {
                    label: '所属组织',
                    name: 'orgIdentity',
                    width: 150,
                    sortable: false,

                    formatter: formatOrg

                },
                {
                    label: 'orgIdentityId',
                    name: 'orgIdentityId',
                    width: 150,
                    hidden: true

                }
            ];


            rolelist = new Rolelist('rolelistjqGrid', 'platform/console/user/getMapUserRole?id=' + '${id}', dataGridColModel, '${id}');
            //添加按钮绑定事件
            $('#rolelist_insert').bind('click', function () {
                rolelist.insert();
            });
            //删除按钮绑定事件
            $('#rolelist_del').bind('click', function () {
                rolelist.del();
            });
            //保存按钮绑定事件
            $('#rolelist_save').bind('click', function () {
                rolelist.save();
            });


        });
</script>
</html>