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
    <!-- ControllerPath = "assets/lab/assetslabaccount/assetsLabAccountController/toAssetsLabAccountManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsLabAccount_button_add"--%>
                               <%--permissionDes="添加">--%>
            <%--<a id="assetsLabAccount_insert" href="javascript:;" class="btn btn-primary form-tool-btn btn-sm"--%>
               <%--role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>--%>
        <%--</sec:accesscontrollist>--%>
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsLabAccount_button_edit"--%>
                               <%--permissionDes="编辑">--%>
            <%--<a id="assetsLabAccount_modify" href="javascript:;" class="btn btn-primary form-tool-btn btn-sm"--%>
               <%--role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>--%>
        <%--</sec:accesscontrollist>--%>
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsLabAccount_button_delete"--%>
                               <%--permissionDes="删除">--%>
            <%--<a id="assetsLabAccount_del" href="javascript:;" class="btn btn-primary form-tool-btn btn-sm" role="button"--%>
               <%--title="删除"><i class="fa fa-trash-o"></i> 删除</a>--%>
        <%--</sec:accesscontrollist>--%>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsLabAccount_keyWord" id="assetsLabAccount_keyWord" style="width:240px;"
                   class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsLabAccount_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsLabAccount_searchAll" href="javascript:;" class="btn btn-defaul btn-sm" role="button">高级查询
                <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsLabAccountjqGrid"></table>
<div  id="jqGridPager"></div>
<div id="main_frame"
     style='width: 100%;height: 400px ; background-color:#FFFFFF; float:left; margin-left:5px; margin-top:5px;'>
    <!-- 列表页下方Tab页begin -->
    <div class="eform-tab" style="margin-left: 0%; margin-top: 10px;width: 100%;height: 100%" contenteditable="false" >
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation active"
                contenteditable="false"><a href="#LabDevice" aria-controls="LabDevice" role="tab"
                                           data-toggle="tab">实验室设备</a>
            </li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false">
                <a
                        href="#LabDetail" aria-controls="LabDetail" role="tab" data-toggle="tab">实验室详情</a></li>
        </ul>
        <div class="tab-content" style="margin-left: 0px; width: 100%;height: 100%"  >
            <div role="tabpanel" class="tab-pane active" contenteditable="false" id="LabDevice" style="width: 100%;height: 100% ">
                <iframe name="labDeviceIframe"  id="labDeviceIframe" src="assets/lab/assetslabdevice/assetsLabDeviceController/toAssetsLabDeviceManage" frameborder="0" align="left" width="100%" height="100%" scrolling="auto">
                </iframe>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="LabDetail"
                 style="height: 100%; min-height: 40px; width: 90%">
            </div>

        </div>
    </div>
    <!-- 列表页下方Tab页end -->
</div>


</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th width="10%">实验室名称:</th>
                <td width="15%">
                    <input title="实验室名称" class="form-control input-sm" type="text" name="labName" id="labName"/>
                </td>
                <th width="10%">实验室简称:</th>
                <td width="15%">
                    <input title="实验室简称" class="form-control input-sm" type="text" name="labNameShort"
                           id="labNameShort"/>
                </td>
                <th width="10%">实验室编号:</th>
                <td width="15%">
                    <input title="实验室编号" class="form-control input-sm" type="text" name="labNum" id="labNum"/>
                </td>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">资产编号:</th>
                <td width="15%">
                    <input title="资产编号" class="form-control input-sm" type="text" name="assetId" id="assetId"/>
                </td>
                <th width="10%">专业类别:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="majorCategory" id="majorCategory" title="专业类别"
                                  isNull="true" lookupCode="MAJOR_TYPE"/>
                </td>
                <th width="10%">实验室位置:</th>
                <td width="15%">
                    <input title="实验室位置" class="form-control input-sm" type="text" name="labPosition" id="labPosition"/>
                </td>
                <th width="10%">实验室设备数量:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="labDeviceCount" id="labDeviceCount"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">实验室介绍:</th>
                <td width="15%">
                    <input title="实验室介绍" class="form-control input-sm" type="text" name="labInfo" id="labInfo"/>
                </td>
                <th width="10%">实验室管理部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="manageDept" name="manageDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="manageDeptAlias"
                               name="manageDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">实验室管理员:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="managerId" name="managerId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="managerIdAlias"
                               name="managerIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">实验室创建日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateBegin"
                               id="createdDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">实验室创建日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateEnd" id="createdDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/lab/assetslabaccount/js/AssetsLabAccountSelect.js" type="text/javascript"></script>
<script type="text/javascript">
    var assetsLabAccount;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsLabAccount.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsLabAccount.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '序号', name: 'attribute01', width: 50}
            , {label: '实验室名称', name: 'labName', width: 150}
            , {label: '实验室简称', name: 'labNameShort', width: 150}
            , {label: '实验室编号', name: 'labNum', width: 150}
            // , {label: '统一编号', name: 'unifiedId', width: 150}
            // , {label: '资产编号', name: 'assetId', width: 150}
            , {label: '专业类别', name: 'majorCategory', width: 150}
            , {label: '实验室位置', name: 'labPosition', width: 150}
            // , {label: '实验室设备数量', name: 'labDeviceCount', width: 150}
            // , {label: '实验室介绍', name: 'labInfo', width: 150}
            , {label: '实验室管理部门', name: 'manageDeptAlias', width: 150}
            , {label: '实验室管理员', name: 'managerIdAlias', width: 150}
            // , {label: '实验室创建日期', name: 'createdDate', width: 150, formatter: format}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("labName");
        searchTips.push("实验室名称");
        searchNames.push("labNameShort");
        searchTips.push("实验室简称");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsLabAccount_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsLabAccount = new AssetsLabAccount('assetsLabAccountjqGrid', '${url}', 'searchDialog', 'form', 'assetsLabAccount_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsLabAccount_insert').bind('click', function () {
            assetsLabAccount.insert();
        });
        //编辑按钮绑定事件
        $('#assetsLabAccount_modify').bind('click', function () {
            assetsLabAccount.modify();
        });
        //删除按钮绑定事件
        $('#assetsLabAccount_del').bind('click', function () {
            assetsLabAccount.del();
        });
        //查询按钮绑定事件
        $('#assetsLabAccount_searchPart').bind('click', function () {
            assetsLabAccount.searchByKeyWord();
        });
        //查询框回车事件
        $('#assetsLabAccount_keyWord').bind('keyup', function (e) {
            if (e.keyCode == 13) {
                assetsLabAccount.searchByKeyWord();
            }
        });
        //打开高级查询框
        $('#assetsLabAccount_searchAll').bind('click', function () {
            assetsLabAccount.openSearchForm(this);
        });
        $('#manageDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'manageDept', textFiled: 'manageDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#managerIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'managerId', textFiled: 'managerIdAlias'});
            this.blur();
            nullInput(e);
        });

    });

</script>
</html>