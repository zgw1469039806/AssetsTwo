<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
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
<body class="easyui-layout"  fit="true">
<input  id="tableId"  value="${table.id}"   type="hidden"  />
<input  id="subtableId"  value="${subtable.id}"   type="hidden"  />
<input  id="subfk"  value="${table.subColumnName}"   type="hidden"  />
<div data-options="region:'center',split:true,border:false" style="padding:0px;overflow:hidden;">
	<!-- LIST表单 start-->
	<table id="dg"  class="easyui-datagrid"  
	
	data-options="onLoadSuccess:cellTip,fit:true,toolbar:'#toolbar',pagination:true,rownumbers:true,fitColumns:true,singleSelect:true,checkOnSelect:true,selectOnCheck:false,autoRowHeight:false,striped:true,url:'platform/eform/cbbCRUDClient/list?tableId=${table.id}'">
	
		<thead>
			<tr>
				<th data-options="field:'ID', halign:'center',checkbox:true" width="50">id</th>
				<c:forEach items="${tabColumns}"   var="item"  >
						<c:choose>
						   <c:when test="${item.colType== 'DATE'}">  
						   				<c:if test="${item.attribute03== '1'}">
						   						<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100"    formatter="Common.TimeFormatter" >${item.colLabel}</th>
						   				</c:if>
						   				<c:if test="${item.attribute03== '2'}">
						   						<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100"    formatter="Common.DateFormatter" >${item.colLabel}</th>
						   				</c:if>
						   </c:when>
						   <c:otherwise> 
						   				<c:if test="${item.attribute01== null}">
						   						<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100">${item.colLabel}</th>
						   				</c:if>
						   				<c:if test="${item.attribute01!= null}">
						   						<th data-options="field:'${item.colName}Value',required:true,align:'center'"  width="100"   >${item.colLabel}</th>
						   				</c:if>
						   </c:otherwise>
						</c:choose>
				</c:forEach>
				<c:forEach items="${detailColumns}"   var="item"  >
						<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100"  formatter="Common.detailFormatter">${item.colLabel}</th>
				</c:forEach>
			</tr>
		</thead>
	</table>
	<!-- CRUD工具栏 -->
	<div id="toolbar">
		<table>
		<tr>
		<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${table.tableName}_add" permissionDes="添加">
				<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newObj()">添加</a></td>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${table.tableName}_edit" permissionDes="编辑">
				<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editObj()">编辑</a></td>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${table.tableName}_del" permissionDes="删除">
				<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteObj()">删除</a></td>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${table.tableName}_search" permissionDes="查询">
				<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryObj('${table.id}','dg')">查询</a></td>
		</sec:accesscontrollist>
		<c:forEach items="${customButtons}"   var="item"  varStatus="status">
	    					<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" onclick="customClick('${item.tableId}','${item.isPage}','${item.buttonUrl}')"  id=''>${item.buttonName}</a></td>
	    </c:forEach>
		
		</tr>
		</table>
	</div>
	<!-- LIST表单 end-->
</div>
	
	
<div data-options="region:'east',split:true,border:false" style="width:550px;background:#f5fafe;">
		<table id="dgsub"  class="easyui-datagrid"   
		data-options="onLoadSuccess:cellTip,fit:true,toolbar:'#toolbarsub',pagination:false,rownumbers:true,fitColumns:true,singleSelect:true,checkOnSelect:true,selectOnCheck:false,autoRowHeight:false,striped:true">
					
					<thead>
						<tr>
							<th data-options="field:'ID', halign:'center',checkbox:true" width="50">id</th>
							<c:forEach items="${subtabColumns}"   var="item"  >
									<c:choose>
									   <c:when test="${item.colType== 'DATE'}">  
									   		<c:if test="${item.attribute03== '1'}">
						   						<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100"    formatter="Common.TimeFormatter" >${item.colLabel}</th>
						   				</c:if>
						   				<c:if test="${item.attribute03== '2'}">
						   						<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100"    formatter="Common.DateFormatter" >${item.colLabel}</th>
						   				</c:if>
									   </c:when>
									   <c:otherwise> 
									   				<c:if test="${item.attribute01== null}">
									   						<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100">${item.colLabel}</th>
									   				</c:if>
									   				<c:if test="${item.attribute01!= null}">
									   						<th data-options="field:'${item.colName}Value',required:true,align:'center'"  width="100"   >${item.colLabel}</th>
									   				</c:if>
									   </c:otherwise>
									</c:choose>
							</c:forEach>
							
							<c:forEach items="${detailColumns}"   var="item"  >
								<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100"  formatter="Common.subdetailFormatter">${item.colLabel}</th>
							</c:forEach>
							
						</tr>
					</thead>
		</table>
				<!-- CRUD工具栏 -->
		<div id="toolbarsub">
					<table>
					<tr>
					<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${subtable.tableName}_add" permissionDes="添加">
							<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="subnewObj()">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${subtable.tableName}_edit" permissionDes="编辑">
							<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="subeditObj()">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${subtable.tableName}_del" permissionDes="删除">
							<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="subdeleteObj()">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${subtable.tableName}_search" permissionDes="查询">
							<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="subqueryObj('${subtable.id}','dgsub')">查询</a></td>
				    </sec:accesscontrollist>
				    <c:forEach items="${subcustomButtons}"   var="item"  varStatus="status">
	    					<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" onclick="customClick('${item.tableId}','${item.isPage}','${item.buttonUrl}')"  id=''>${item.buttonName}</a></td>
	    			</c:forEach>
					</tr>
					</table>
		</div>
</div>
	
	<!-- button js event -->
	<script type="text/javascript">
		var baseurl = '<%=request.getContextPath()%>';
		var url;
		
		function beforeEvent(){
			${deleteButton.preJs}
		}

		function afterEvent(){
			${deleteButton.postJs}
		}
		
		function beforeSubEvent(){
			${subDeleteButton.preJs}
		}

		function afterSubEvent(){
			${subDeleteButton.postJs}
		}
		
		function cellTip(data){
			$('#dg').datagrid('doCellTip',   
			{   
				onlyShowInterrupt:true,   
				position:'bottom',
				tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
			});
		}
		
		function cellTipsub(data){
			$('#dgsub').datagrid('doCellTip',   
			{   
				onlyShowInterrupt:true,   
				position:'bottom',
				tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
			});
		}
		
		function queryObj(tableId,datagrid) {
			url = 'platform/eform/formlayout/search?tableId='+tableId+"&datagrid="+datagrid;
			var  dlg = new CommonDialog("search","600","450",url,"查询",false,true,false);
			dlg.show();
		}
		
		function subqueryObj(tableId,datagrid) {
			var row=$('#dg').datagrid('getSelected');
    		if(row){
    			var id=row.ID;
    			var subtableId=$('#subtableId').val();
    			url = 'platform/eform/formlayout/search?tableId='+tableId+"&datagrid="+datagrid+"&colName=${table.subColumnName}&colValue="+id;
    			var  dlg = new CommonDialog("search","600","250",url,"查询",false,true,false);
    			dlg.show();
    		}else{
    			$.messager.show({
					 title : '提示',
					 msg : '请选择主表信息！'
				});
    		}
		}
		
		function newObj() {
			var tableId=$('#tableId').val();
			url = 'platform/eform/cbbCRUDClient/add?version='+encodeURI("${version}")+'&tableId='+tableId;
			var  dlg = new CommonDialog("insert","680","400",url,"添加",false,true,false,null,true);
			dlg.show();
		}
		
		function editObj() {
			var tableId=$('#tableId').val();
			var row = $('#dg').datagrid('getSelected');
				if (row) {
					url = 'platform/eform/cbbCRUDClient/get?version='+encodeURI("${version}")+'&id=' + row.ID+'&tableId='+tableId;
					var  dlg = new CommonDialog("update","680","400",url,"编辑",false,true,false,null,true);
					dlg.show();
				}else{
					$.messager.show({
						 title : '提示',
						 msg : '请选择数据！'
					});
				}
		}
		
		function deleteObj() {
			if (beforeEvent()==false){
				return false;
			}
			url='platform/eform/cbbCRUDClient/delete.json';
			var row = $('#dg').datagrid('getSelected');
			var myDatagrid=$('#dg');
			var rows = myDatagrid.datagrid('getChecked');
			var ids = [];
			var l =rows.length;
			for(;l--;){
				ids.push(rows[l].ID);
		 	}
			var tableId=$('#tableId').val();
			if (row) {
				$.messager.confirm('',
						'子表数据将同时被删除，确认删除吗?',
						function(r) {
							if (r) {
								$.post(url, {
									id : JSON.stringify(ids),
									tableId : tableId
								}, function(result) {
									if (result.success) {
										$.messager.show({
											title : '提示',
											msg : '删除成功！'
										});
										afterEvent();
										$('#dgsub').datagrid({
											data: []
										});
										$('#dg').datagrid('reload');
									} else {
										$.messager.show({
											title : 'Error',
											msg : result.errorMsg
										});
									}
								}, 'json');
							}
				});
			}else{
				$.messager.show({
					 title : '提示',
					 msg : '请选择数据！'
				});
			}
		}
		
		function subnewObj() {
			var subtableId=$('#subtableId').val();
			var tableId=$('#tableId').val();
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				url = 'platform/eform/cbbCRUDClient/add?version='+encodeURI("${subversion}")+'&tableId='+subtableId+'&ptableId='+tableId+'&fkvalue='+row.ID;
				var  dlg = new CommonDialog("insert","680","400",url,"添加",false,true,false,null,true);
				dlg.show();
			}else{
				$.messager.show({
					 title : '提示',
					 msg : '请选择主表信息！'
				});
			}
		}
		
		function subeditObj() {
			var subtableId=$('#subtableId').val();
			var tableId=$('#tableId').val();
			var myDatagrid=$('#dgsub');
			var rows = myDatagrid.datagrid('getChecked');
			var ids = [];
			var l =rows.length;
			if(l>1){
				$.messager.show({
					title : '错误',
					msg : '请选择一条数据编辑!'
				});
			}else{
					var row = $('#dgsub').datagrid('getSelected');
					if (row) {
						url = 'platform/eform/cbbCRUDClient/get?version='+encodeURI("${subversion}")+'&id=' + row.ID+'&tableId='+subtableId+'&ptableId='+tableId;
						var  dlg = new CommonDialog("update","680","400",url,"编辑",false,true,false,null,true);
						dlg.show();
					}else{
						$.messager.show({
							 title : '提示',
							 msg : '请选择数据！'
						});
					}
			}
		}
		
		function subdeleteObj() {
			beforeSubEvent();
			url='platform/eform/cbbCRUDClient/delete.json';
			//var row = $('#dgsub').datagrid('getSelected');
			var subtableId=$('#subtableId').val();
			var myDatagrid=$('#dgsub');
			var rows = myDatagrid.datagrid('getChecked');
			var ids = [];
			var l =rows.length;
			
			if (l>0) {
				for(;l--;){
					ids.push(rows[l].ID);
			 	}
				$.messager.confirm('',
						'确认删除吗?',
						function(r) {
							if (r) {
								$.post(url, {
									id : JSON.stringify(ids),
									tableId : subtableId
								}, function(result) {
									if (result.success) {
										$.messager.show({
											title : '提示',
											msg : '删除成功！'
										});
										afterSubEvent();
										var row=$('#dg').datagrid('getSelected');
						        		if(row){
						        			var id=row.ID;
						        			var subtableId=$('#subtableId').val();
						        			url = 'platform/eform/cbbCRUDClient/list.html?'+'${table.subColumnName}'+'='+id;
						    				$.post(url, {
						    					tableId : subtableId
						    				}, function(result) {
						    					$('#dgsub').datagrid('loadData',result);
						    				}, 'json');
						        		}
										
									} else {
										$.messager.show({
											title : 'Error',
											msg : result.errorMsg
										});
									}
								}, 'json');
							}
				});
			}else{
				$.messager.show({
					 title : '提示',
					 msg : '请选择数据！'
				});
			}
		}
		
		
		function subdetailObj(rowId) {
			var tableId=$('#subtableId').val();
			url = 'platform/eform/cbbCRUDClient/detail?version='+encodeURI("${version}")+'&id=' + rowId+'&tableId='+tableId;
			var  dlg = new CommonDialog("update","680","400",url,"详细",false,true,false,null,true);
			dlg.show();
		}
		
		
		function detailObj(rowId) {
			var tableId=$('#tableId').val();
			url = 'platform/eform/cbbCRUDClient/detail?version='+encodeURI("${version}")+'&id=' + rowId+'&tableId='+tableId;
			var  dlg = new CommonDialog("update","680","400",url,"详细",false,true,false,null,true);
			dlg.show();
		}
		
		
		
		function dlg_close(id){
				$('#'+id).dialog('close');
				$.messager.show({
					 title : '提示',
					 msg : '保存成功！'
				});
		}
		
		function dlg_close_only(id){
			$('#'+id).dialog('close');
		}
		
		
		function dg_reload(id){
			$('#'+id).datagrid('reload'); 
		}
		
		function dg_loaddata(id,results){
			$('#'+id).datagrid('loadData',results); 
		}
		
		function customClick(table_id,is_page,custom_url){
			var rows = $('#dg').datagrid('getChecked');
			
			if (rows.length>0) {
					var ids = [];
					var l =rows.length;
					for(;l--;){
						ids.push(rows[l].ID);
			 		}
			
				if(is_page=='Y'){
					custom_url=custom_url+"?ids="+ids+"&tableId="+table_id;
					var  dlg = new CommonDialog("update","680","400",custom_url,"选择窗口",false,true,false);
					dlg.show();
				}else{
					$.post(custom_url, {ids : JSON.stringify(ids),tableId : table_id}, function(result) {
							if (result.success) {
								$.messager.show({
											title : '提示',
											msg : '操作成功！'
								});
								$('#dg').datagrid('reload');
							} else {
								$.messager.show({
											title : 'Error',
											msg : result.errorMsg
								});
							}
					}, 'json');
				}
					
			}else{
					$.messager.show({
						 title : '提示',
						 msg : '请选择数据！'
					});
			}
			
		}
		
		
		function dgsub_reload(){
			var row=$('#dg').datagrid('getSelected');
    		if(row){
    			var id=row.ID;
    			var subtableId=$('#subtableId').val();
    			url = 'platform/eform/cbbCRUDClient/list.html?'+'${table.subColumnName}'+'='+id;
				$.post(url, {
					tableId : subtableId
				}, function(result) {
					$('#dgsub').datagrid('loadData',result);
				}, 'json');
    		}
		}
		
		
		var Common = {
				TimeFormatter: function (value, rec, index) {
					if(value==null){
						return '';
					}else{
						var now = new Date(value);
				    	var year=now.getUTCFullYear(); 
				    	var month=now.getMonth()+1+""; 
				    	if(month.length==1)month="0"+month;
				    	var date=now.getDate()+""; 
				    	if(date.length==1)date="0"+date;
				    	var hour=now.getHours()+""; 
				    	if(hour.length==1)hour="0"+hour;
				    	var minute=now.getUTCMinutes()+""; 
				    	if(minute.length==1)minute="0"+minute;
				    	var second=now.getUTCSeconds()+""; 
				    	if(second.length==1)second="0"+second;
				    	return year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second; 
					}
			    },
				
				
			    DateFormatter: function (value, rec, index) {
			    	if(value==null){
						return '';
					}else{
						var now = new Date(value);
				    	var year=now.getUTCFullYear(); 
				    	var month=now.getMonth()+1+""; 
				    	if(month.length==1){month="0"+month;}
				    	var date=now.getDate()+""; 
				    	if(date.length==1){date="0"+date;}
				    	return year+"-"+month+"-"+date; 
					}
			    },
		
				LookUpFormatter: function (value, rec, index){
					//return Platform6.fn.lookup.formatLookupType(value, demoBusinessTrip.traffic);
				},
				
				detailFormatter: function(value,rowData,rowIndex){
					return "<span class='icon-tip' onclick='javascript: detailObj(\""+ rowData.ID +"\");'></span>";
				},
				
				subdetailFormatter: function(value,rowData,rowIndex){
					return "<span class='icon-tip' onclick='javascript: subdetailObj(\""+ rowData.ID +"\");'></span>";
				}
				
			};
		
		$(function(){
			
			
			
		});
		
		
		$('#dg').datagrid({
        	onClickRow:function(index,data)
        	{
        		var row=$('#dg').datagrid('getSelected');
        		if(row){
        			var id=row.ID;
        			var subtableId=$('#subtableId').val();
        			url = 'platform/eform/cbbCRUDClient/list.html?'+'${table.subColumnName}'+'='+id;
    				$.post(url, {
    					tableId : subtableId
    				}, function(result) {
    					$('#dgsub').datagrid('loadData',result);
    				}, 'json');
        		}
        	}
        })
		
		
	</script>
</body>
</html>