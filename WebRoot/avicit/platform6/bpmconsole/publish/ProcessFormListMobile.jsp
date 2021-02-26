<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
	String processDefId = request.getParameter("processDefId");
	String type = request.getParameter("type");
%>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
</head>
<script type="text/javascript">
var baseurl = '<%=request.getContextPath()%>';
var processDefId  = '<%=processDefId%>';
var type = '<%= type %>';

var hideIndexs = new Array();
var proxyValue = [{ "value": "N", "text": "否" }, { "value": "Y", "text": "是" }];
function typeformatter(value, rowData, rowIndex) {
    if (value == 0) {
        return;
    }
 
    for (var i = 0; i < proxyValue.length; i++) {
        if (proxyValue[i].value == value) {
            return proxyValue[i].text;
        }
    }
}
$(function(){
    $('#ss').searchbox({
        width: 200,
        searcher: function (value) {
            hideIndexs.length = 0;
            $("#processForm").datagrid('reload');
            if (value == "请输入查询内容") {
                value = "";
            }
            //停止datagrid的编辑.
            endEdit();
            var rows = $("#processForm").datagrid("getRows");
            var cols = $("#processForm").datagrid("options").columns[0];
            for (var i = rows.length - 1; i >= 0; i--) {
                var row = rows[i];
                var isMatch = false;
                for (var j = 0; j < cols.length; j++) {

                    var pValue = row[cols[j].field];
                    if (pValue == undefined) {
                        continue;
                    }
                    if (pValue.toString().indexOf(value) >= 0) {
                        isMatch = true;
                        break;
                    }
                }
                if (!isMatch){
                	hideIndexs.push(i);
                	$("#processForm").datagrid("refreshRow", i);
                }
            }
        },
        prompt: "请输入查询内容"
    });
	
	$('#processForm').datagrid({
		url: 'platform/bpm/bpmPublishAction/getProcessForms.json?ifMobile=yes',
		width: '100%',
        nowrap: true,
        rowStyler: function(index,row){
        	if(hideIndexs.length>0){
        		for(var i=0;i<hideIndexs.length;i++){
        			var temp = hideIndexs[i];
        			if(temp==index){
        				return "display:none";
        			}
        		}
        	}
    	},
        autoRowHeight: false,
        singleSelect:<%= "global".equals(type)?"false":"true" %>,
	    checkOnSelect:true,
	    selectOnCheck:true,
        striped: true,
        collapsible:true,
        remoteSort: false,
        pagination:false,
        rownumbers:true,
        onClickCell:onClickCell,
        columns:[[
				  {field:'id',hidden:true},
				  {field:'nodeId',hidden:true},
				  {field:'processDefId',title:'操作',hidden:true},
				  {field:'op',title:'操作',width:20,align:'left',checkbox:true},
				  {field:'formCode',title:'表单编码',width:130,rowspan:2},
				  {field:'formName',title:'表单名称',width:170,rowspan:2},
                  {field:'formUrlMobile',title:'移动表单URL',width:420},
                  /*{field:'formType',title:'表单类型',width:70,rowspan:2},*/
//                  {field:'proxyPage',title:'是否代理',width:60, align: 'center',formatter: typeformatter, editor: { type: 'combobox', options: { data: proxyValue, valueField: "value", textField: "text",editable:false,onSelect:endEdit}}}
              ]]
});
});
function onClickCell(rowIndex, field, value){
				if('proxyPage' == field){
				    $("#processForm").datagrid('selectRow', rowIndex).datagrid('beginEdit', rowIndex);
				}else{
					endEdit();
				}
			    return value;
		}
		function endEdit() {
        var rows = $("#processForm").datagrid("getRows");
        for (var i = 0; i < rows.length; i++) {
            $("#processForm").datagrid("endEdit", i);
        }
    }
function getSelectedResultDataJson(){
	var datas = $('#processForm').datagrid('getSelections');
	if (datas == null || datas=='' || datas == 'null') {
		$.messager.alert("操作提示", "请选择记录！","info"); 
		return;
	}else{
		if(processDefId!=null && processDefId!='' && processDefId!='undefinded'){
			datas.processDefId=processDefId;
		}
		return datas;
	}
	
}
function backChecked(obj) {
	easyuiUnMask();
	if (obj != null && obj.success == true) {
		$.messager.show({
			title : '提示',
			msg : "操作成功！"
		});
		$('#processForm').datagrid('reload');	
	} else {
		$.messager.show({
			title : '提示',
			msg : "操作失败！"
		});
	}
}
</script>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',title:''" style="padding:5px;">
	<input id="ss"></input>  
	<table id="processForm"></table>
</div>  

</body>
</html>