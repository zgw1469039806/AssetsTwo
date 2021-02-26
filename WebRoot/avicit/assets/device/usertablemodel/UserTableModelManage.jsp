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
    <!-- ControllerPath = "assets/device/usertablemodel/userTableModelController/toUserTableModelManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_userTableModel_button_add" permissionDes="添加">
				<a id="userTableModel_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加">
					<i class="fa fa-plus"></i> 批量添加系统视图
				</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_userTableModel_button_delete" permissionDes="删除">
				<a id="userTableModel_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
				   role="button" title="删除">
					<i class="fa fa-trash-o"></i> 删除
				</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="userTableModel_keyWord" id="userTableModel_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
				<label id="userTableModel_searchPart" class="icon icon-search form-tool-searchicon"></label>
			</div>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="userTableModel_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">
					高级查询<span class="caret"></span>
				</a>
			</div>
		</div>
	</div>
	<table id="userTableModel"></table>
	<div id="jqGridPager"></div>
</body>

<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th width="10%">用户ID:</th>
                <td width="15%">
                    <input title="用户ID" class="form-control input-sm" type="text" name="userId" id="userId"/>
                </td>

                <th width="10%">字段名称:</th>
                <td width="15%">
                    <input title="字段名称" class="form-control input-sm" type="text" name="fieldName" id="fieldName"/>
                </td>

                <th width="10%">字段标识:</th>
                <td width="15%">
                    <input title="字段标识" class="form-control input-sm" type="text" name="fieldIdentify" id="fieldIdentify"/>
                </td>

                <th width="10%">字段描述:</th>
                <td width="15%">
                    <input title="字段描述" class="form-control input-sm" type="text" name="fieldModel" id="fieldModel"/>
                </td>
            </tr>
            <tr>
                <th width="10%">排序号:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="sn" id="sn" data-min="0" data-max="9999999999" data-step="1" data-precision="0">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>

                <th width="10%">所属表:</th>
                <td width="15%">
                    <input title="所属表" class="form-control input-sm" type="text" name="belongTable" id="belongTable"/>
                </td>

                <th width="10%">视图名称:</th>
                <td width="15%">
                    <input title="视图名称" class="form-control input-sm" type="text" name="viewName" id="viewName"/>
                </td>

				<th width="10%">是否可用:</th>
				<td width="15%">
					<pt6:h5select css_class="form-control input-sm" name="isValid" id="isValid" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
				</td>
            </tr>
        </table>
    </form>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script src="avicit/assets/device/usertablemodel/js/UserTableModel2.js" type="text/javascript"></script>

<script type="text/javascript">
    var userTableModel;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="userTableModel.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="userTableModel.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '用户ID', name: 'userId', width: 150, formatter: formatValue}
            , {label: '字段名称', name: 'fieldName', width: 150}
            , {label: '字段标识', name: 'fieldIdentify', width: 150}
            , {label: '字段描述', name: 'fieldModel', width: 300}
            , {label: '排序号', name: 'sn', width: 150}
            , {label: '所属表', name: 'belongTable', width: 150}
            , {label: '视图名称', name: 'viewName', width: 150}
			, {label: '是否可以', name: 'isVaid', width: 150}
        ];
        var searchNames = new Array();
        var searchTips = new Array();

        searchNames.push("fieldIdentify");
        searchTips.push("字段标识");

        searchNames.push("fieldName");
        searchTips.push("字段名称");

        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#userTableModel_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);

        userTableModel = new UserTableModel('userTableModel', '${url}', 'searchDialog', 'form', 'userTableModel_keyWord', searchNames, dataGridColModel);

        //添加按钮绑定事件
        $('#userTableModel_insert').bind('click', function () {
            userTableModel.batchInsert();
        });

        //编辑按钮绑定事件
        $('#userTableModel_modify').bind('click', function () {
            userTableModel.modify();
        });

        //删除按钮绑定事件
        $('#userTableModel_del').bind('click', function () {
            userTableModel.del();
        });

        //查询按钮绑定事件
        $('#userTableModel_searchPart').bind('click', function () {
            userTableModel.searchByKeyWord();
        });

        //打开高级查询框
        $('#userTableModel_searchAll').bind('click', function () {
            userTableModel.openSearchForm(this);
        });

    });

</script>
</html>