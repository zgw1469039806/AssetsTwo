<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>

	<div id="comprehensiveTabControl" class="easyui-tabs" data-options="fit:true">
		<%--------------------------部门 --------------------------------%>
		<div title="部门" id="tabDept" data-options="iconCls:'icon-dept',fit:true">
			<div id="toolbarDept" style="display: block;">
				<table class="tableForm"  width='100%'>
					<tr>
						<td style="width: 200px; padding-top: 4px;"><input id="searchDept" class="easyui-searchbox" style="width: 200px"
							data-options="prompt:'关键字查询',searcher:searchDept" /></td>
						<td>
						<td>
						<input id="deptId" style="display:none"></input>
							<input id="deptName" style="display:none"></input>
						<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="mySelectDept();"
							href="javascript:void(0);">添加</a> 	
						<a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="deleteAuthority();" href="javascript:void(0);">删除</a>
							</td>
					</tr>
				</table>
			</div>

			<table id="dgDept" class="easyui-datagrid" 
				data-options="
			fit: true,
			fitColumns: true,
			autoRowHeight: false,
			toolbar:'#toolbarDept',
			idField :'id',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			pagination:true,
			pageSize:dataOptions.pageSize,
			pageList:dataOptions.pageList,
			striped:true,
			loadMsg:'数据加载中,请稍候',">
				<thead>
					<tr>
						<th data-options="field:'check', align:'center',checkbox:true"></th>
						<th data-options="field:'deptName', align:'center'" width="220">部门名称</th>
						<th data-options="field:'deptCode', align:'center'" width="220">部门编号</th>
						<th data-options="field:'createdBy', align:'center'" width="220">创建人</th>
						<th data-options="field:'creationDate', align:'center'" width="220">创建时间</th>
					</tr>
				</thead>
			</table>
		</div>
		<%--------------------------人员 --------------------------------%>
		<div title="人员" id="tabUser" data-options="iconCls:'icon-user',fit:true">
			<div id="toolbarUser" style="display: block;">
				<table class="tableForm"  width='100%'>
					<tr>
						<td style="width: 200px; padding-top: 4px;"><input id="searchUser" class="easyui-searchbox" style="width: 200px"
							data-options="prompt:'关键字查询',searcher:searchUser" /></td>
						<td>
						<td>
						<input type="hidden" id="userId">
							<input type="hidden" id="userName">
						<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="insertUser();"
							href="javascript:void(0);">添加</a> 	
						<a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="deleteAuthority();" href="javascript:void(0);">删除</a>
							</td>
					</tr>
				</table>
			</div>

			<table id="dgUser" class="easyui-datagrid" 
				data-options="
			fit: true,
			fitColumns: true,
			autoRowHeight: false,
			toolbar:'#toolbarUser',
			idField :'id',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			pagination:true,
			pageSize:dataOptions.pageSize,
			pageList:dataOptions.pageList,
			striped:true,
			loadMsg:'数据加载中,请稍候',">
				<thead>
					<tr>
						<th data-options="field:'check', align:'center',checkbox:true"></th>
						<th data-options="field:'username', align:'center'" width="220">姓名</th>
						<th data-options="field:'userCode', align:'center'" width="220">人员编号</th>
						<th data-options="field:'loginName', align:'center'" width="220">登录名</th>
						<th data-options="field:'deptName', align:'center'" width="220">部门</th>
					</tr>
				</thead>
			</table>
		</div>
		<%--------------------------角色 --------------------------------%>
		<div title="角色" id="tabRole" data-options="iconCls:'icon-role',fit:true">
			<div id="toolbarRole" style="display: block;">
				<table class="tableForm"  width='100%'>
					<tr>
						<td style="width: 200px; padding-top: 4px;"><input id="searchRole" class="easyui-searchbox" style="width: 200px"
							data-options="prompt:'关键字查询',searcher:searchRole" /></td>
						<td>
						<td>
						<input type="hidden" id="selectRoleId">
							<input type="hidden" id="selectRoleName">
						<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="insertRole();"
							href="javascript:void(0);">添加</a> 	
						<a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="deleteAuthority();" href="javascript:void(0);">删除</a>
							</td>
					</tr>
				</table>
			</div>

			<table id="dgRole" class="easyui-datagrid"
				data-options="
			fit: true,
			fitColumns: true,
			autoRowHeight: false,
			toolbar:'#toolbarRole',
			idField :'id',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			pagination:true,
			pageSize:dataOptions.pageSize,
			pageList:dataOptions.pageList,
			striped:true,
			loadMsg:'数据加载中,请稍候',">
				<thead>
					<tr>
						<th data-options="field:'check', align:'center',checkbox:true"></th>
						<th data-options="field:'roleName', align:'center'" width="220">角色名称</th>
						<th data-options="field:'roleCode', align:'center'" width="220">角色编号</th>
						<th data-options="field:'roleDesc', align:'center'" width="220">角色描述</th>
						<th data-options="field:'createdBy', align:'center'" width="220">创建人</th>
					</tr>
				</thead>
			</table>
		</div>
		
	</div>
<script type="text/javascript" src="avicit/phoneproject/programauthoritymanage/programrelation/js/ProgramRelation.js">
</script>