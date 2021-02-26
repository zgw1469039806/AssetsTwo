<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
<script src="static/js/platform/bpm/client/js/ToolBar.js" type="text/javascript"></script>
<script src="avicit/platform6/eform/formdefine/js/eformValidate.js"></script>
<script src="avicit/platform6/eform/formdefine/js/eformCustomDialog.js"></script>

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
		
		function cusbeforeEvent(buttonCode){
			<c:forEach items="${customButtons}"   var="item"  >
				if (buttonCode == "${item.buttonCode}"){
					${item.preJs}
				}
			</c:forEach>
		}

		function cusafterEvent(buttonCode,result){
			<c:forEach items="${customButtons}"   var="item"  >
			if (buttonCode == "${item.buttonCode}"){
				${item.postJs}
			}
		</c:forEach>
		}
		
		function cellTip(data){
			
			$('#dg').datagrid('doCellTip',   
			{   
				onlyShowInterrupt:true,   
				position:'bottom',
				tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
			}); 
		};
		
		
		function queryObj(datagrid) {
			var tableId=$('#tableId').val();
			url = 'platform/eform/formlayout/search?tableId='+tableId+"&datagrid="+datagrid;
			var  dlg = new CommonDialog("search","600","450",url,"查询",false,true,false);
			dlg.show();
		}
		
		function searchObj(){
			$('#searchfm').form('submit', {
				url : url,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(result) {
						var results=$.parseJSON(result);
						$('#dg').datagrid('loadData',results); 
				}
			});
		}
		
		function initWorkFlow(status, owner){
			/* if(owner=='my'&&(status=='active'||status=='ended'||status=='all')){
				$("#edit_button").css('display','none');
				$("#del_button").css('display','none');
			}else{
				$("#edit_button").css('display','block');
				$("#del_button").css('display','block');
			} */
			var tableId=$('#tableId').val();
			url = 'platform/eform/cbbCRUDClient/list?tableId='+tableId+"&bpmState="+status+"&bpmType="+owner;
			$('#dg').datagrid({
				url:url
			});
			setBpmMenuState(status,owner);
			$('#bpmState').val(status);
			$('#bpmType').val(owner);
			searchObj();
		}
		
		function newObj() {
			var tableId=$('#tableId').val();
			url = 'platform/eform/cbbCRUDClient/add?version='+encodeURI("${version}")+'&tableId='+tableId;
			var  dlg = new CommonDialog("insert","680","400",url,"添加",false,true,false,null,true);
			dlg.show();
		}
		
		function searchData(url,searchData){
			$("#dg").datagrid("options").url=url;
			$('#dg').datagrid('load',searchData);
			$("#dg").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
			dlg_close_only('search');
		}
		
		function editObj() {
			var tableId=$('#tableId').val();
			
			var myDatagrid=$('#dg');
			var rows = myDatagrid.datagrid('getChecked');
			var ids = [];
			var l =rows.length;
			if(l>1){
				$.messager.show({
					title : '错误',
					msg : '请选择一条数据编辑!'
				});
			}else{
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
		}
		
		function deleteObj() {
			if (beforeEvent()==false){
				return false;
			}
			url='platform/eform/cbbCRUDClient/delete.json';
			//var row = $('#dg').datagrid('getSelected');
			var tableId=$('#tableId').val();
			
			var myDatagrid=$('#dg');
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
									tableId : tableId
								}, function(result) {
									if (result.success) {
										$.messager.show({
											title : '提示',
											msg : '删除成功！'
										});
										afterEvent();
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
		
		function bpmObj(rowId) {
			var tableId=$('#tableId').val();
			url = 'platform/eform/cbbCRUDClient/bpm?version='+encodeURI("${version}")+'&id=' + rowId+'&tableId='+tableId;
			
			if(typeof(top.addTab) != 'undefined'){
				top.addTab('流程', url);
			}else{
				window.open(url);
			}
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
		
		function bpm_operator_refresh(){
			$('#dg').datagrid('reload'); 
		}
		
		function customClick(table_id,is_page,custom_url,code){
			cusbeforeEvent(code);
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
					cusafterEvent(code);
				}else{
					$.post(custom_url, {datas : JSON.stringify(rows),tableId : table_id}, function(result) {
						
							if (!result.errorMsg) {
								$.messager.show({
											title : '提示',
											msg : '操作成功！'
								});
								cusafterEvent(code,result);
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
				
				StateFormatter: function (value, rec, index){
					if (value=="active") {
						return "流转中";
					} else if (value=="ended") {
						return "结束";
					} else if (value=="start") {
						return "草稿";
					}
				},
			    
			    BpmFormatter: function(value,rowData,rowIndex){
					return "<span class='icon-edit' onclick='javascript: bpmObj(\""+ rowData.ID +"\");'></span>";
				},
				
				detailFormatter: function(value,rowData,rowIndex){
					return "<span class='icon-tip' onclick='javascript: detailObj(\""+ rowData.ID +"\");'></span>";
				}
				
			};
		
		$(function(){
			<c:if test="${table.tableIsBpm== 'Y'}">
				$("#tool_del_td").hide();
			</c:if>
		});
	</script>

</head>
<body class="easyui-layout"  fit="true">
<input  id="tableId"  value="${table.id}"   type="hidden"  />
<input type="hidden" name="bpmState"  id="bpmState" value="all"></input>
<input type="hidden" name="bpmType"  id="bpmType" value="my"></input>
<div data-options="region:'center',split:true,border:false" style="padding:0px;height:0;overflow:hidden;">
	<!-- LIST表单 start-->
	<table id="dg"  class="easyui-datagrid"  data-options="onLoadSuccess:cellTip,fit:true,toolbar:'#toolbar',pagination:true,rownumbers:true,fitColumns:true,singleSelect:true,checkOnSelect:true,selectOnCheck:false,autoRowHeight:false,striped:true,url:'platform/eform/cbbCRUDClient/list?tableId=${table.id}'">
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
				<c:forEach items="${activityColumns}"   var="item"  >
						<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100"  >${item.colLabel}</th>
				</c:forEach>
				<c:forEach items="${stateColumns}"   var="item"  >
						<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100"  formatter="Common.StateFormatter">${item.colLabel}</th>
				</c:forEach>
				<c:forEach items="${bpmColumns}"   var="item"  >
						<th data-options="field:'_bpm',required:true,align:'center'"  width="100"  formatter="Common.BpmFormatter">${item.colLabel}</th>
				</c:forEach>
			</tr>
		</thead>
	</table>
	<!-- CRUD工具栏 -->
	<div id="toolbar">
		<table>
		<tr>
		<c:if test="${table.tableIsBpm== 'Y'}">
		<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${table.tableName}_bpmAll" permissionDes="全部文件">
					<td width="105px;">
						<a href="javascript:void(0);" id="allMenu" name="bpm_all_menu" class='easyui-menubutton' data-options="menu:'#allmm',iconCls:'icon-all-file'">全部文件</a>
						<div id="allmm" style="width:105px;">
							<div id='all_start' name="bpm_all_start" onclick="initWorkFlow('start','all')">拟稿中</div>
							<div id='all_active' name="bpm_all_active" onclick="initWorkFlow('active','all')">流转中</div>
							<div id='all_ended' name="bpm_all_ended" onclick="initWorkFlow('ended','all')">已完成</div>
							<div id='all_all' name="bpm_all_all" onclick="initWorkFlow('all','all')">全部文件</div>
						</div>
					</td>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${table.tableName}_bpmMyFile" permissionDes="我的全部">
					<td width="105px;">
						<a href="javascript:void(0);" id="myMenu" name="bpm_my_menu" class='easyui-menubutton' data-options="menu:'#mymm',iconCls:'icon-my-file'">我的全部</a>
						<div id="mymm" style="width:105px;">
							<div id='my_start' name="bpm_my_start"  onclick="initWorkFlow('start','my')">我的拟稿</div>
							<div id='my_active' name="bpm_my_active" onclick="initWorkFlow('active','my')">我的流转</div>
							<div id='my_ended' name="bpm_my_ended" onclick="initWorkFlow('ended','my')">我的完成</div>
							<div id='my_all' name="bpm_my_all" onclick="initWorkFlow('all','my')">我的全部</div>
						</div>
					</td>
		</sec:accesscontrollist>
		</c:if>
		<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${table.tableName}_add" permissionDes="添加">
				    <td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newObj()">添加</a></td>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${table.tableName}_edit" permissionDes="编辑">
				<c:if test="${table.tableIsBpm== 'Y'}">
				    		<td id="tool_edit_td"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editObj()"   id='edit_button' >编辑</a></td>
				</c:if>
				<c:if test="${table.tableIsBpm== 'N'}">
							<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editObj()"   id='edit_button'   >编辑</a></td>
				</c:if>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${table.tableName}_del" permissionDes="删除">
				    <c:if test="${table.tableIsBpm== 'Y'}">
				    		<td id="tool_del_td"><a href="javascript:void(0)" class="easyui-linkbutton"  iconCls="icon-remove" plain="true" onclick="deleteObj()"  id='del_button'>删除</a></td>
				  </c:if>
					<c:if test="${table.tableIsBpm== 'N'}">
							<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteObj()"  id='del_button'   >删除</a></td>
					</c:if>
				    
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="eform_toolbar_${table.tableName}_search" permissionDes="查询">
				     <td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryObj('dg')">查询</a></td>
		</sec:accesscontrollist>
					<c:forEach items="${customButtons}"   var="item"  varStatus="status">
	    					<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="${item.buttonIcon}"  plain="true" onclick="customClick('${item.tableId}','${item.isPage}','${item.buttonUrl}','${item.buttonCode}')"  id=''>${item.buttonName}</a></td>
	    			</c:forEach>
		</tr>
		</table>
	</div>
	
	<div id="searchdlg" class="easyui-dialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"  style="width: 600px;height:250px; visible: hidden" title="搜索" closed="true" >
		<form id="searchfm" method="post">
		</form>
	</div>
	
</div>


	<!-- LIST表单 end-->
</body>
</html>