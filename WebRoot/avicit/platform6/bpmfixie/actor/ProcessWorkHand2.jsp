<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>AVICIT WORKFLOW 选人</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
<style type="text/css">
.check_no {
    width: 13px;
    height: 13px;
    background: url(static/images/platform/bpm/images/check_no.gif) no-repeat scroll 0 0 transparent;
    cursor: pointer;
}
.check_yes {
    width: 13px;
    height: 13px;
    background: url(static/images/platform/bpm/images/check_yes.gif) no-repeat scroll 0 0 transparent;
    cursor: pointer;
}
/*提示框背景颜色和字体颜色修改*/
.layui-layer-tips .layui-layer-content{
	background-color: #FAFAFA !important;
	color: #333;
}
.layui-layer-tips i.layui-layer-TipsB, .layui-layer-tips i.layui-layer-TipsT{
	border-right-color: #FAFAFA !important;
}
</style>
<script type="text/javascript">
var workhandJson = ${workhandJson};

var abc = [{"beginUserId":"402888125c1ecdec015c1f72e1f70081","beginUserName":"李aaaaaaaaaaaaa东","beginDeptId":null,"beginDeptName":"财aaaa务部","middleUserId":null,"middleUserName":null,"endUserId":"402888f95c34ec31015c3500b2840089","endUserName":"马六","endDeptId":"8a58ab4d4c2141fd014c217cdc5102b6","endDeptName":"研发中心","isBeginUser":true,"isEndUser":false}];
</script>
</head>
<body>
	<table id="workHandGird" data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				singleSelect: false,
				checkOnSelect: true,
				selectOnCheck: false,
				striped:true">
					<thead>
						<tr>
							<th data-options="field:'isBeginUser', hidden:true,formatter: function(value,row,index){return false;}"></th>
							<th data-options="field:'beginUserId', hidden:true"></th>
							<th data-options="field:'a', halign:'center', width:100,checkbox:true"></th>
							<th data-options="field:'beginUserName', halign:'center', width:100">委托人</th>
							<th data-options="field:'beginDeptId', hidden:true"></th>
							<th data-options="field:'beginDeptName', width:150">委托人部门</th>
							<th data-options="field:'isEndUser', hidden:true,formatter: function(value,row,index){return true;}"></th>
							<th data-options="field:'endUserId', hidden:true"></th>
							<th data-options="field:'endUserName', width:100">受托人</th>
							<th data-options="field:'endDeptId', hidden:true"></th>
							<th data-options="field:'endDeptName', width:150">受托人部门</th>
						</tr>
					</thead>
				</table>
</body>
<script type="text/javascript">
var workHandGird;
$(document).ready(function () {
	workHandGird = $("#workHandGird").datagrid({
	    data : workhandJson,
		onLoadSuccess : function(data) {
			var rows = data.rows;
			var $tr = $("#workHandGird").find("tbody tr");
			var j = 0;
			$tr.each(function(i){
				if(i>0){
					var obj = rows[j];
					var beginUserName = obj.beginUserName;
					var endUserName = obj.endUserName;
					var $this = $(this);
					$this.on("mouseover",function(e){
	    				layer.tips("选中后【" + beginUserName + "】的待办工作将委托给【 " + endUserName + "】",this,{
	        				tips:3
	        			});
					});
					j++;
				}
			});
		}
	});
});
function getWorkhandSelectedUsers(){
	var selectedData = $("#workHandGird").datagrid('getChecked');
	return selectedData;
}
</script>
</html>
