<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工作移交</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
	<%
		String importlibs = "common,table,form";
	%>
	<jsp:include
			page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
</head>
<body>
<table id="WorkHandTasklist"></table>
<div data-options="region:'south',border:false" style="height: 40px;">
	<div id="toolbar"
		 class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
		<table class="tableForm" style="border:0;cellspacing:1;width:100%">
			<tr>
				<td width="50%" style="padding-right:4%;" align="right">
					<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="拿回" id="saveForm">拿回</a>
					<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="closeForm">返回</a>
				</td>
			</tr>
		</table>
	</div>
</div>
</body>
<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script >
    $("#WorkHandTasklist").jqGrid({
        url: 'platform/bpm/clientbpmWorkHandAction/getWorkHandTask',
        postData:"",
        mtype: 'POST',
        datatype: "json",
//        toolbar: [true,'top'],
        colModel: [

            {label : 'id', name : 'dbid', key : true, width : 75,hidden : true},
            {label : '标题', name : 'taskTitle', width : 150,align:"center",sortable : false},
            {label : '流程名称', name : 'processDefName', width : 150,align:"center",sortable : false},
            {label : '发送人', name : 'taskSendUser', width : 150,align:"center",sortable : false},
            {label : '发送部门', name : 'taskSendDept', width : 150,align:"center",sortable : false},
            {label : '处理人', name : 'assigneeName', width : 150,align:"center",sortable : false},
            {label : '', name : 'assignee', width : 150,align:"center",hidden : true},
            {label : '', name : 'processInstanceId', width : 150,align:"center",hidden : true},
        ],
        height:$(window).height()-120,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20	,
        //rownumbers: true,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        //userDataOnFooter: true,
        pagerpos:'left',
        loadonce: true,
        // loadComplete:function(){
        // 	$(this).jqGrid('getColumnByUserIdAndTableName');
        // },
        styleUI : 'Bootstrap',
        multiselect: true,
        //multiboxonly : true,
        autowidth: true,
        shrinkToFit: true,
        responsive:true,//开启自适应
    });

    //返回按钮绑定事件
    $('#closeForm').on('click', function(){
        parent.workDelegate.closeDialog(window.name);
    });

    $('#saveForm').on('click', function(){
        var selectedRowIds = $("#WorkHandTasklist").getGridParam("selarrrow");
        var data = "";
        if (selectedRowIds != "") {
            var len = selectedRowIds.length;
            for ( var i = 0; i < len; i++) {
                var rowData = $("#WorkHandTasklist").getRowData(selectedRowIds[i]);
                data += rowData["dbid"]+"@@"+rowData["assignee"]+"@@"+rowData["processInstanceId"]+","
            }
            data = data.substr(0, data.length - 1);
        } else {
            flowUtils.error("请选择要拿回的记录！");
            return;
		}
        parent.workDelegate.fetchAction(data);
        parent.workDelegate.closeDialog(window.name);
    });



</script>
</html>