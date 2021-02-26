<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <title>表单自定义按钮管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <a id="button_insert" href="javascript:void(0)"
           class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
           title="添加"><i class="icon icon-add"></i> 添加</a>

        <a id="button_save" href="javascript:void(0)"
           class="btn btn-primary form-tool-btn btn-sm" role="button"
           title="保存"><i class="icon icon-save"></i> 保存</a>

        <a id="button_del" href="javascript:void(0)"
           class="btn btn-primary form-tool-btn btn-sm" role="button"
           title="删除"><i class="icon icon-delete"></i> 删除</a>
    </div>

    <div class="toolbar-right">
        <div class="input-group-btn form-tool-searchbtn">
            <a id="searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button"
               title="高级查询">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="eformClassConfigGrid"></table>
<div id="eformClassConfigPager"></div>
</body>

<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id='form' style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th>名称:</th>
                <td><input title="名称" class="form-control input-sm" type="text" name="className" id="className"/></td>

                <th width="10%" style="word-break: break-all; word-warp: break-word;">
                    <label for="classPath">路径:</label></th>
                <td width="39%"><input title="路径" class="form-control input-sm" type="text" name="classPath"id="classPath"/></td>
            </tr>
            <tr>
                <th>类型:</th>
                <%--<td><input title="类型" class="form-control input-sm" type="text" name="classType" id="classType"/></td>--%>
                <td width="39%">
                <pt6:h5select css_class="form-control input-sm" name="classType" id="classType" title="" isNull="true" lookupCode="PLATFORM_EFORM_CLASS_CONFIG" />
                </td>
            </tr>

        </table>
    </form>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/eformClassConfig/editEformClassConfig.js"></script>
<script type="text/javascript">
    var editEformClassConfig;//,fundrop={};
    var dataGridColModel = [
        {
            label: 'id',
            name: 'id',
            width: 75,
            key: true,
            hidden: true
        },
        {
            label: '名称',
            name: 'className',
            editable: true,
            edittype: "text",
            width: 100
        },
        {
            label: '<span class="remind">*</span>路径',
            name: 'classPath',
            width: 150,
            editable: true,
            edittype: 'text'
        },
        {
            label: '<span class="remind">*</span>类型',
            name: 'classType',
            width: 100,
            editable: true,
            formatter: "select",
            edittype: "select",
            editoptions: {value :getEformClassConfigSelect()}
        },
        {
            label: '详细描述',
            name: 'classDesc',
            width: 150,
            editable: true,
            edittype: 'text'
        }];


    function getEformClassConfigSelect(){
        var json = "";
        avicAjax.ajax({
            url : 'platform/eform/bpmsClient/getSysLookup.json',
            data: {lookupCode : "PLATFORM_EFORM_CLASS_CONFIG"},
            type: 'post',
            dataType: 'json',
            async:false,
            success: function (r) {
                if (r != null) {
                    var list = r.rows;
                    var len = list.length;
                    for (var i = 0; i < list.length; i++) {
                        if (i != len - 1) {
                            json += list[i].lookupCode + ":" + list[i].lookupName + ";";
                        } else {
                            json += list[i].lookupCode + ":" + list[i].lookupName;// 这里是option里面的 value:label
                        }
                    }
                }
            }
        });
        return json;
    }


    editEformClassConfig = new EditEformClassConfig('eformClassConfigGrid', 'platform/eform/bpmsManageController/', 'searchDialog', 'form', '', '', dataGridColModel);

    //添加按钮绑定事件
    $('#button_insert').bind('click', function () {
        editEformClassConfig.insert();
    });
    //删除按钮绑定事件
    $('#button_del').bind('click', function () {
        editEformClassConfig.del();
    });
    //保存按钮绑定事件
    $('#button_save').bind('click', function () {
        editEformClassConfig.save();
    });

    //打开高级查询框
    $('#searchAll').bind('click', function () {
        editEformClassConfig.openSearchForm(this);
    });

</script>
</html>