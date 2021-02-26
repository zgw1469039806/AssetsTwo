<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,table";
%>

<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>选择表字段</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body>
<div class="easyui-layout" fit=true>
    <div data-options="region:'center',split:true,border:false">
        <div id="tableColumnListDiv">
            <div id="tableColumnToolbar" class="toolbar">
                <div class="toolbar-right">
                    <div class="input-group form-tool-search">
                        <input type="text" name="tableColumn_keyWord"
                               id="tableColumn_keyWord" style="width: 240px;"
                               class="form-control input-sm" placeholder="请输入表字段名查询">
                        <label id="tableColumn_searchPart" class="icon icon-search form-tool-searchicon"></label>
                    </div>
                </div>
            </div>

            <table id='tableColumnListTable'></table>
            <%--<div id="tableColumnList_jqGridPager"></div>--%>
        </div>
    </div>

    <div data-options="region:'south',border:false" style="height: 40px;">
        <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
            <table class="tableColumnForm" style="border:0;cellspacing:1;width:100%">
                <tr>
                    <td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
                        <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                           title="确定" id="tableColumn_saveForm">确定</a>
                        <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button"
                           title="关闭" id="tableColumn_closeForm">关闭</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script type="text/javascript">
    var selectedTableColumnId = "";
    var selectedTableColumnName = "";
    var colModelTableColumn = [{
        key: true,
        label: 'id',
        name: 'id',
        hidden: true
    }, {
        label: '表字段名称',
        name: 'columnName',
        width: 40,
        /* sortableColumn: false, */
        sortable: false,
        align: 'center'
    }, {
        label: '表字段描述',
        name: 'columnComment',
        width: 50,
        /* sortableColumn: false, */
        sortable: false,
        align: 'center'
    }];
    var tableColumnListTable = $("#tableColumnListTable").jqGrid({
        url: 'platform/sysautocode/sysAutoCodeManageController/tableColumnList?tableName=${param.tableName}',
        mtype: 'POST',
        datatype: "json",
        colModel: colModelTableColumn,
        height: $(window).height() - 120,
        // scrollOffset: 20,
        rowNum: 10000,
        //rowList: [200, 100, 50, 30, 15],
        //pagerpos: 'left',
        altRows: true,
        styleUI: 'Bootstrap',
        // viewrecords: true,
        multiselect: false,
        autowidth: true,
        hasColSet: false,
        hasTabExport: false,
        responsive: true,
        //pager: "#tableColumnList_jqGridPager",
        onSelectRow: function (rowid) {
            var rowData = $(this).jqGrid('getRowData', rowid);
            selectedTableColumnId = rowData.id;
            selectedTableColumnName = rowData.columnName;
        },
        ondblClickRow:function(rowid,iRow,iCol,e){//双击
			var rowData = $(this).jqGrid('getRowData', rowid);
			selectedTableColumnId = rowData.id;
	        selectedTableColumnName = rowData.columnName;
			
			parent.$("#${param.fieldId}").val(selectedTableColumnId);
		    parent.$("#${param.fieldName}").val(selectedTableColumnName);

		    var dataObject = parent.$("#${param.fieldId}").data("data-object");
		    if (dataObject != undefined && dataObject != null) {
	            var data = {
	                id: selectedTableColumnId,
	                name: selectedTableColumnName
	            };
	            dataObject.postFunction(data);
		    }

		    var index = parent.layer.getFrameIndex(window.name); //得到当前iframe层的索引
		    parent.layer.close(index);
		}
    });

    function searchByKeyWord() {
        var tableColumnName = $("#tableColumn_keyWord").val() == $("#tableColumn_keyWord").attr("placeholder") ? "" : $("#tableColumn_keyWord").val();

        var data = {
            tableColumnName: tableColumnName
        };

        $("#tableColumnListTable").jqGrid('setGridParam', {
            datatype: 'json',
            postData: data
        }).trigger("reloadGrid");
    }

    $("#tableColumn_keyWord").on('keydown', function (e) {
        if (e.keyCode == '13') {
            searchByKeyWord();
        }
    });
    $("#tableColumn_searchPart").on('click', function (e) {
        searchByKeyWord();
    });


    $('#tableColumn_saveForm').bind('click', function () {
        if (selectedTableColumnId == "" || selectedTableColumnName == "") {
            layer.alert('请选择表字段！', {icon: 7});
            return;
        }

        var dataObject;

        parent.$("#${param.fieldId}").val(selectedTableColumnId);
        parent.$("#${param.fieldName}").val(selectedTableColumnName);

        dataObject = parent.$("#${param.fieldId}").data("data-object");

        if (dataObject != undefined && dataObject != null) {
            var data = {
                id: selectedTableColumnId,
                name: selectedTableColumnName
            };
            dataObject.postFunction(data);
        }

        var index = parent.layer.getFrameIndex(window.name); //得到当前iframe层的索引
        parent.layer.close(index);
    });
    //返回按钮绑定事件
    $('#tableColumn_closeForm').bind('click', function () {
        var index = parent.layer.getFrameIndex(window.name); //得到当前iframe层的索引
        parent.layer.close(index);
    });
</script>
</body>
</html>