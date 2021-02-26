<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>单位列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false" style="padding:0px;height:0;overflow:hidden;">

		<div class="easyui-tabs"
			data-options="fit:true,plain:true,tabPosition:'top',toolPosition:'right'"
			style="padding: 0 0 1px">
			<div title="SQL监控">
				<table id="dgsql" class="easyui-datagrid"
					url="platform/sqlog/list.json"
					data-options=" 
	 fit:true, 
	 toolbar:'#toolbarsql' ,
	 pagination:false,
	 rownumbers:true, 
	 fitColumns:true,
	 singleSelect:true,
	 autoRowHeight:false,
	 striped:true">
					<thead>
						<tr>
							<th data-options="field:'execSql',required:true,align:'left'"
								width="100">SQL语句</th>
							<th data-options="field:'execTime',required:true,align:'center'"
								width="10">执行时间(ms)</th>
							<th data-options="field:'countSql',required:true,align:'center'"
								width="10">执行次数</th>
						</tr>
					</thead>
				</table>
				<!-- CRUD工具栏 -->
				<div id="toolbarsql">
					<table>
						<tr>
							<td><select class="easyui-combobox" name="log_time"
								id="log_time"
								data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
									<option value="1">最近1小时</option>
									<option value="12">最近12小时</option>
									<option value="24">今天</option>
									<option value="168">最近7天</option>
							</select></td>
							<td><select class="easyui-combobox" name="show_num"
								id="show_num"
								data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="30">30</option>
									<option value="40">40</option>
									<option value="50">50</option>
							</select></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" plain="true" onclick="querySql()">查询</a></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" plain="true" onclick="exportClientSql()">导出excel</a></td>
						</tr>
					</table>
				</div>
			</div>
			<div title="SQL统计">
				<table id="dgsqlcount" class="easyui-datagrid"
					url="platform/sqlog/count.json"
					data-options=" 
	 fit:true, 
	 toolbar:'#toolbarsqlcount' ,
	 pagination:false,
	 rownumbers:true, 
	 fitColumns:true,
	 singleSelect:false,
	 autoRowHeight:false,
	 striped:true">
					<thead>
						<tr>
							<th data-options="field:'execSql',required:true,align:'left'"
								width="100">SQL语句</th>
							<th data-options="field:'execTime',required:true,align:'left'"
								width="10">执行次数</th>
						</tr>
					</thead>
				</table>
				<!-- CRUD工具栏 -->
				<div id="toolbarsqlcount">
					<table>
						<tr>
							<td><select class="easyui-combobox" name="log_time"
								id="log_time"
								data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
									<option value="1">最近1小时</option>
									<option value="12">最近12小时</option>
									<option value="24">今天</option>
									<option value="168">最近7天</option>
							</select></td>
							<td><select class="easyui-combobox" name="show_num"
								id="show_num"
								data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="30">30</option>
									<option value="40">40</option>
									<option value="50">50</option>
							</select></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" plain="true" onclick="querySqlcount()">查询</a></td>
						</tr>
					</table>
				</div>
			</div>
			<div title="方法监控">
				<table id="dgmethod" class="easyui-datagrid"
					url="platform/methodlog/list.json"
					data-options=" 
	 fit:true, 
	 toolbar:'#toolbarmethod' ,
	 pagination:false,
	 rownumbers:true, 
	 fitColumns:true,
	 singleSelect:true,
	 autoRowHeight:false,
	 striped:true">
					<thead>
						<tr>
							<th data-options="field:'execMethod',required:true,align:'left'"
								width="100">方法名称</th>
							<th data-options="field:'execTime',required:true,align:'center'"
								width="10">执行时间(ms)</th>
							<th
								data-options="field:'countMethod',required:true,align:'center'"
								width="10">执行次数</th>
						</tr>
					</thead>
				</table>
				<!-- CRUD工具栏 -->
				<div id="toolbarmethod">
					<table>
						<tr>
							<td><select class="easyui-combobox" name="log_time"
								id="log_time"
								data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
									<option value="1">最近1小时</option>
									<option value="12">最近12小时</option>
									<option value="24">今天</option>
									<option value="168">最近7天</option>
							</select></td>
							<td><select class="easyui-combobox" name="show_num"
								id="show_num"
								data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="30">30</option>
									<option value="40">40</option>
									<option value="50">50</option>
							</select></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" plain="true" onclick="queryMethod()">查询</a></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" plain="true" onclick="exportClientMethod()">导出excel</a></td>
						</tr>
					</table>
				</div>

			</div>
			<div title="方法统计">
				<table id="dgmethodcount" class="easyui-datagrid"
					url="platform/methodlog/count.json"
					data-options=" 
	 fit:true, 
	 toolbar:'#toolbarmethodcount' ,
	 pagination:false,
	 rownumbers:true, 
	 fitColumns:true,
	 singleSelect:false,
	 autoRowHeight:false,
	 striped:true">
					<thead>
						<tr>
							<th data-options="field:'execMethod',required:true,align:'left'"
								width="100">方法名称</th>
							<th data-options="field:'execTime',required:true,align:'left'"
								width="10">执行次数</th>
						</tr>
					</thead>
				</table>
				<!-- CRUD工具栏 -->
				<div id="toolbarmethodcount">
					<table>
						<tr>
							<td><select class="easyui-combobox" name="log_time"
								id="log_time"
								data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
									<option value="1">最近1小时</option>
									<option value="12">最近12小时</option>
									<option value="24">今天</option>
									<option value="168">最近7天</option>
							</select></td>
							<td><select class="easyui-combobox" name="show_num"
								id="show_num"
								data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="30">30</option>
									<option value="40">40</option>
									<option value="50">50</option>
							</select></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" plain="true" onclick="queryMethodcount()">查询</a></td>
						</tr>
					</table>
				</div>
			</div>

			<div title="初始化表">
				<table>
					<tr>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="" plain="true" onclick="init_table()">初始化表</a></td>
					</tr>
				</table>
			</div>

		</div>
	</div>
	
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>	
<script type="text/javascript">
		var baseurl = '<%=request.getContextPath()%>';
		var url;
		
		function querySql() {
			var log_time=$('#log_time').combobox('getValue');
			var show_num=$('#show_num').combobox('getValue');
			url = 'platform/sqlog/list.json';
			$.post(url, {
				log_time:log_time,
				show_num:show_num
			}, function(result) {
				$('#dgsql').datagrid('loadData',result);
			}, 'json');
		}
		
		
		function exportClientSql(){
			$.messager.confirm('确认','是否确认导出Excel文件?',function(r) {
		        if (r) {
		            //封装参数
		            var columnFieldsOptions = getGridColumnFieldsOptions('dgsql');
		            var dataGridFields = JSON.stringify(columnFieldsOptions[0]);
		            var rows = $('#dgsql').datagrid('getRows');
		            var datas = JSON.stringify(rows);
		            var myParams = {
		                dataGridFields: dataGridFields,//表头信息集合
		                datas: datas,//数据集
		                unContainFields:'',
		                hasRowNum : false,//默认为Y:代表第一列为序号
		                sheetName: 'sheet1',//如果该参数为空，默认为导出的Excel文件名
		                fileName: 'SQL日志导出数据'+ new Date().format("yyyy-MM-dd")//导出的Excel文件名
		            };
		            var url = "platform/sqlog/exportClient";
		            var ep = new exportData("xlsExport","xlsExport",myParams,url);
		            ep.excuteExport();
		        }
		       });
		};
		
		
		
		
		function querySqlcount() {
			var log_time=$('#log_time').combobox('getValue');
			var show_num=$('#show_num').combobox('getValue');
			url = 'platform/sqlog/count.json';
			$.post(url, {
				log_time:log_time,
				show_num:show_num
			}, function(result) {
				$('#dgsqlcount').datagrid('loadData',result);
			}, 'json');
		}
		
		
		
		
		
		function queryMethod() {
			var log_time=$('#log_time').combobox('getValue');
			var show_num=$('#show_num').combobox('getValue');
			url = 'platform/methodlog/list.json';
			$.post(url, {
				log_time:log_time,
				show_num:show_num
			}, function(result) {
				$('#dgmethod').datagrid('loadData',result);
			}, 'json');
		}
		
		
		function exportClientMethod(){
			$.messager.confirm('确认','是否确认导出Excel文件?',function(r) {
		        if (r) {
		            //封装参数
		            var columnFieldsOptions = getGridColumnFieldsOptions('dgmethodcount');
		            var dataGridFields = JSON.stringify(columnFieldsOptions[0]);
		            var rows = $('#dgmethodcount').datagrid('getRows');
		            var datas = JSON.stringify(rows);
		            var myParams = {
		                dataGridFields: dataGridFields,//表头信息集合
		                datas: datas,//数据集
		                unContainFields:'',
		                hasRowNum : false,//默认为Y:代表第一列为序号
		                sheetName: 'sheet1',//如果该参数为空，默认为导出的Excel文件名
		                fileName: '方法日志导出数据'+ new Date().format("yyyy-MM-dd")//导出的Excel文件名
		            };
		            var url = "platform/methodlog/exportClient";
		            var ep = new exportData("xlsExport","xlsExport",myParams,url);
		            ep.excuteExport();
		        }
		       });
		};
		
		
		
		
		
		
		function queryMethodcount() {
			var log_time=$('#log_time').combobox('getValue');
			var show_num=$('#show_num').combobox('getValue');
			url = 'platform/methodlog/count.json';
			$.post(url, {
				log_time:log_time,
				show_num:show_num
			}, function(result) {
				$('#dgmethodcount').datagrid('loadData',result);
			}, 'json');
		}
		
		
		
		
		
		function init_table() {
			url = 'platform/sqlog/init.json';
			$.post(url, {
			}, function(result) {
				
			}, 'json');
		}
		
	</script>	
	
	
	
</body>
</html>