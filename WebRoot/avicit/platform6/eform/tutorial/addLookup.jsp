<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>单位列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>

</head>
<body>
<body class="easyui-layout"  fit="true">
<div data-options="region:'north',split:false,title:''" style="height: 80px; padding:0px;">	
			
			<div style="TEXT-ALIGN: center; ">
				<form id="searchLookupForm">
				<table style=" MARGIN-RIGHT: auto; MARGIN-LEFT: auto;">
					<tr>
						<th width="10%">设备名称:</th>
						<td width="40%"><input class="easyui-validatebox"
							style="width: 151px;" type="text" name="sbmc" /></td>
						<th width="10%">设备编号:</th>
						<td width="40%"><input class="easyui-validatebox"
							style="width: 151px;" type="text" name="sbbh" /></td>
					</tr>
					<tr>
				</table>
			</form>
		    </div>	
		    
		    <div style="TEXT-ALIGN: center; ">
		    
		    	<div  id="searchBtns" style=" MARGIN-RIGHT: auto; MARGIN-LEFT: auto;">
		    		<a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchData();" href="javascript:void(0);">查询</a>
		    		<a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="clearData();" href="javascript:void(0);">清空</a>
		    		
		    	</div>
	    	</div>
	    </div>
<div data-options="region:'center',split:true,border:false" style="overflow:hidden;">	
		<table id="tablelookup" class="easyui-datagrid"  fit="true"  pagination="true" rownumbers="true" fitColumns="true" singleSelect="true" autoRowHeight="false" striped="true" url="platform/eform/tutorial/demoequip/DemoEquipController/operation/getDemoEquipsByPage.json"      data-options="onLoadSuccess:cellTip"> 
								<thead>
										<tr> 
								        	<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
								    		<th data-options="field:'sbmc',align:'center'" width="220">设备名称</th>
								        	<th data-options="field:'sbbh',align:'center'" width="220">设备编号</th>
								        </tr>
									</thead>
		</table>
		
</div>


<!-- button js event -->
	<script type="text/javascript">
		var baseurl = '<%=request.getContextPath()%>';
		var url;
		
		function cellTip(data){
			
			$('#tablelookup').datagrid('doCellTip',   
			{   
				onlyShowInterrupt:true,   
				position:'bottom',
				tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
			}); 
			
		};
		
		
		function searchData(){
			$("#tablelookup").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
			$("#tablelookup").datagrid('load',{ param : JSON.stringify(serializeObject($("#searchLookupForm")))});
		}
		
		function clearData(){
			$("#searchLookupForm").find('input').val('');
			$("#tablelookup").datagrid('reload',{});
		};
		
		$(document).ready(function(){ 
			$('#searchLookup').find('input').on('keyup',function(e){
				if(e.keyCode == 13){
					searchData();
				}
			});
		});
		
		//回调函数
		function commitData(){
			var res = {};
			var row=$('#tablelookup').datagrid('getChecked');
			var name = "";
			var value = "";
			for (var i=0,len=row.length;i<len;i++){
				if (len-1 == i){
					name += row[i].sbmc;
					value += row[i].sbbh;
				}else{
					name += row[i].sbmc+",";
					value += row[i].sbbh + ",";
				}
			}
			res.name = name;
			res.value = value;
			return res;
		}
		
	</script>
</body>
</html>