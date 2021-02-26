<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,table";
%>

<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>选择表</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body>
<div class="easyui-layout" fit=true>
    <div data-options="region:'center',split:true,border:false">
        <div id="tableListDiv">
            <div id="tableToolbar" class="toolbar">
                <div class="toolbar-right">
                    <div class="input-group form-tool-search">
                        <input type="text" name="table_keyWord"
                               id="table_keyWord" style="width: 240px;"
                               class="form-control input-sm" placeholder="请输入表名查询">
                        <label id="table_searchPart" class="icon icon-search form-tool-searchicon"></label>
                    </div>
                </div>
            </div>

            <table id='tableListTable'></table>
            <%--<div id="tableList_jqGridPager"></div>--%>
        </div>
    </div>

    <div data-options="region:'south',border:false" style="height: 40px;">
        <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
            <table class="tableForm" style="border:0;cellspacing:1;width:100%">
                <tr>
                    <td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
                        <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                           title="确定" id="table_saveForm">确定</a>
                        <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button"
                           title="关闭" id="table_closeForm">关闭</a>
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
    var selectedTableId = "";
    var selectedTableName = "";
    var colModelTable = [{
        key: true,
        label: 'id',
        name: 'id',
        hidden: true
    }, {
        label: '表名称',
        name: 'tableName',
        width: 40,
        sortable: false,
        align: 'center'
    }, {
        label: '表描述',
        name: 'tableComment',
        width: 50,
        sortable: false,
        align: 'center'
    }];
    var tableListTable = $("#tableListTable").jqGrid({
        url: 'platform/sysautocode/sysAutoCodeManageController/tableList',
        mtype: 'POST',
        datatype: "json",
        colModel: colModelTable,
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
        //pager: "#tableList_jqGridPager",
        onSelectRow: function (rowid) {
            var rowData = $(this).jqGrid('getRowData', rowid);
            selectedTableId = rowData.id;
            selectedTableName = rowData.tableName;
        },
        ondblClickRow:function(rowid,iRow,iCol,e){//双击
			var rowData = $(this).jqGrid('getRowData', rowid);
			selectedTableColumnId = rowData.id;
	        selectedTableColumnName = rowData.columnName;
			
	        parent.$("#${param.fieldId}").val(selectedTableId);
	        parent.$("#${param.fieldName}").val(selectedTableName);

	        var dataObject = parent.$("#${param.fieldId}").data("data-object");

	        if (dataObject != undefined && dataObject != null) {
	            var data = {
	                id: selectedTableId,
	                name: selectedTableName
	            };
	            dataObject.postFunction(data);
	        }

	        var index = parent.layer.getFrameIndex(window.name); //得到当前iframe层的索引
	        parent.layer.close(index);
		}
    });

    function searchByKeyWord() {
        var tableName = $("#table_keyWord").val() == $("#table_keyWord").attr("placeholder") ? "" : $("#table_keyWord").val();

        var data = {
            tableName: tableName
        };

        $("#tableListTable").jqGrid('setGridParam', {
            datatype: 'json',
            postData: data
        }).trigger("reloadGrid");
    }

    $("#table_keyWord").on('keydown', function (e) {
        if (e.keyCode == '13') {
            searchByKeyWord();
        }
    });
    $("#table_searchPart").on('click', function (e) {
        searchByKeyWord();
    });


    $('#table_saveForm').bind('click', function () {
        if (selectedTableId == "" || selectedTableName == "") {
            layer.alert('请选择表！', {icon: 7});
            return;
        }

        var dataObject;

        parent.$("#${param.fieldId}").val(selectedTableId);
        parent.$("#${param.fieldName}").val(selectedTableName);

        dataObject = parent.$("#${param.fieldId}").data("data-object");

        if (dataObject != undefined && dataObject != null) {
            var data = {
                id: selectedTableId,
                name: selectedTableName
            };
            dataObject.postFunction(data);
        }

        var index = parent.layer.getFrameIndex(window.name); //得到当前iframe层的索引
        parent.layer.close(index);
    });
    //返回按钮绑定事件
    $('#table_closeForm').bind('click', function () {
        var index = parent.layer.getFrameIndex(window.name); //得到当前iframe层的索引
        parent.layer.close(index);
    });
</script>
</body>
</html>