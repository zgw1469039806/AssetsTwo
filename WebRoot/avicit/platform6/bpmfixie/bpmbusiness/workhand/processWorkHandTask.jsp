<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的流程</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include
	page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
	<table id="WorkHandTasklist"></table>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar" class="foot-formopera">
			<table class="tableForm" style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)" style="margin-right: 10px;"
						class="easyui-linkbutton primary-btn" role="button" title="拿回"
						id="saveForm">拿回</a> <a title="返回" id="returnButton"
						class="easyui-linkbutton" onclick="closeForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
</body>
<script type="text/javascript"
	src="avicit/platform6/bpmfixie/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
     $("#WorkHandTasklist").datagrid({
    	 url: 'platform/bpm/clientbpmWorkHandAction/getWorkHandTask',
         mtype: 'POST',
         datatype: "json",
         columns:[[    
                  {field:'dbid', title : 'id', checkbox:true, width : 75},    
                  {field:'taskTitle', title : '标题', width : 150,align:"center"},    
                  {field:'processDefName', title : '流程名称', width : 200,align:"center"},  
                  {field:'taskSendUser', title : '发送人', width : 150,align:"center"},
                  {field:'taskSendDept', title : '发送部门', width : 150,align:"center"},
                  {field:'assigneeName', title : '处理人', width : 150,align:"center"},
                  {field:'assignee', title : '', width : 100,align:"center",hidden : true},
                  {field:'processInstanceId', title : '', width : 100,align:"center",hidden : true}
              ]],
              height:$(window).height()-60,
              toolbar:false,
              fitColumns:true
    }); 
  //返回按钮绑定事件
   function closeForm() {
    	parent.entrustGrid.closeDialog(window.name); 
	}
  //拿回按钮绑定事件
    $('#saveForm').on('click', function(){
    	var selectedRowIds = $("#WorkHandTasklist").datagrid('getChecked');
        var data = "";
        if (selectedRowIds != "") {
            var len = selectedRowIds.length;
            for ( var i = 0; i < len; i++) {
                var rowData = selectedRowIds[i];
                data += rowData["dbid"]+"@@"+rowData["assignee"]+"@@"+rowData["processInstanceId"]+","
            }
            data = data.substr(0, data.length - 1);
        } else {
            flowUtils.error("请选择要拿回的记录！");
            return;
		}
        parent.entrustGrid.fetchAction(data);
    });
</script>
</html>