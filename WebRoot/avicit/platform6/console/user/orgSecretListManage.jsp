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
    <title>组织密级列表</title>
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
                               domainObject="formdialog_orgSecretList_button_add"
                               permissionDes="添加">
            <a id="orgSecretList_insert" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
               title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3"
                               domainObject="formdialog_orgSecretList_button_del"
                               permissionDes="删除">
            <a id="orgSecretList_del" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button"
               title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3"
                               domainObject="formdialog_orgSecretList_button_save"
                               permissionDes="保存">
            <a id="orgSecretList_save" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button"
               title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
        </sec:accesscontrollist>
    </div>

</div>
<table id="orgSecretListjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/console/user/js/orgSecretList.js" type="text/javascript"></script>
<script type="text/javascript">
    var isAdmin = "<%=isAdmin%>";
    var viewScopeType = '';
    if (isAdmin == "true") {
        viewScopeType = 'all';
    } else {
        viewScopeType = 'allowAcross';
    }

    var orgSecretList;
    $(document).ready(
        function () {
            var dataGridColModel = [
                {
                    key: true,
                    label: 'id',
                    name: 'id',
                    width: 75,
                    hidden: true
                },
                /*{
                    label: '组织ID',
                    name: 'orgId',
                    width: 75,
                    hidden: true
                },
                {
                    label: '组织名称',
                    name: 'orgName',
                    sortable: false,
                    width: 150,
                    align: 'center',
                    editable: true,
                    edittype: 'custom',
                    editoptions: {
                        custom_element: orgElem,
                        custom_value: orgValue,
                        forId: 'orgId',
                        viewScope: 'currentOrg'
                    }
                },*/
                {
                    label: '多组织应用ID',
                    name: 'orgId',
                    width: 75,
                    hidden: true
                },
                {
                    label: '多组织应用',
                    name: 'orgName',
                    width: 150,
                    editable: true,
                    sortable: false,
                    edittype: 'select',
                    editoptions: {
                        value: JSON.parse('${multiOrgList}'),
                        dataEvents: [
                            {
                                type: 'focus',
                                fn: function (e) {
                                    var rowId = $(this).parent().parent().attr("id");
                                    var value = $(this).val();
                                    $("#orgSecretListjqGrid").jqGrid('setCell', rowId, 'orgId', value);
                                }
                            },
                            {
                                type: 'change',
                                fn: function (e) {
                                    var rowId = $(this).parent().parent().attr("id");
                                    var value = $(this).val();
                                    $("#orgSecretListjqGrid").jqGrid('setCell', rowId, 'orgId', value);
                                }
                            }
                        ]
                    }
                },
                {
                    label: '密级CODE',
                    name: 'secretLevel',
                    width: 75,
                    hidden: true
                },
                {
                    label: '密级',
                    name: 'secretLevelName',
                    width: 150,
                    editable: true,
                    sortable: false,
                    edittype: 'select',
                    editoptions: {
                        value: JSON.parse('${secretList}'),
                        dataEvents: [
                            {
                                type: 'focus',
                                fn: function (e) {
                                    var rowId = $(this).parent().parent().attr("id");
                                    var value = $(this).val();
                                    $("#orgSecretListjqGrid").jqGrid('setCell', rowId, 'secretLevel', value);
                                }
                            },
                            {
                                type: 'change',
                                fn: function (e) {
                                    var rowId = $(this).parent().parent().attr("id");
                                    var value = $(this).val();
                                    $("#orgSecretListjqGrid").jqGrid('setCell', rowId, 'secretLevel', value);
                                }
                            }
                        ]
                    }
                }
            ];


            orgSecretList = new OrgSecretList('orgSecretListjqGrid', 'platform/console/user/getUserOrgSecret?id=' + '${id}', dataGridColModel, '${id}');
            //添加按钮绑定事件
            $('#orgSecretList_insert').bind('click', function () {
                orgSecretList.insert();
            });
            //删除按钮绑定事件
            $('#orgSecretList_del').bind('click', function () {
                orgSecretList.del();
            });
            //保存按钮绑定事件
            $('#orgSecretList_save').bind('click', function () {
                orgSecretList.save();
            });
        });
</script>
</html>