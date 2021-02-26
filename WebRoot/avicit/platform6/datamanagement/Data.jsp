<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,tree,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>菜单数据授权</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<link rel="stylesheet" type="text/css" href="avicit/platform6/console/authorization/css/auth.css"/>
</head>
<body class="easyui-layout" fit="true" style="overflow: hidden;">
	<div data-options="region:'west',split:false,border:true,collapsible:false" id="west" style="width: 350px;">
			<div id="tableToolbarM" class="toolbar">
				<div class="toolbar-left">
						<div class="input-group  input-group-sm">
							<input  class="form-control" placeholder="输入名称查询" type="text" id="txt" name="txt">
							<span class="input-group-btn">
								<button id="searchbtn" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
							</span>
						</div>
				</div>
			</div>
			<div  id='mdiv' style="overflow:auto;">
				<ul id="consoleMenu" class="ztree"></ul>
			</div>
	</div>
	<div data-options="region:'center',title:'菜单权限',split:false,border:true">
		<div data-options="region:'north',split:false,border:false">
			<table width=100%>
			<tr>
				<td width="80"><div id="sqlLabel">资源过滤前置SQL</div></td>
				<td>
					<div style="position: relative; padding-right: 5px; height: 78px">
						<textarea
							style="position: relative; overflow-y: hidden; width: 100%; height: 90%;resize: none;"
							id="sql" readonly="readonly" ></textarea>
					</div>
				</td>
			</tr>
		</table>
		<div id="toolbarImportResult">
			<table>
				<tr>
					<td><a class="btn btn-primary form-tool-btn btn-sm"
						plain="true" onclick="initResourceList();"
						href="javascript:void(0);"><i
							class="glyphicon glyphicon-refresh"></i>刷新资源</a></td>
					<td><a class="btn btn-primary form-tool-btn btn-sm"
						onclick="saveResource();" href="javascript:void(0);"><i
							class="glyphicon glyphicon-ok"></i>保存</a></td>
					<td><a class="btn btn-primary form-tool-btn btn-sm"
						onclick="deleteResource();" href="javascript:void(0);"><i
							class="icon icon-delete"></i>删除</a></td>
					<td id="secret"><input id="secretCheck" type="checkbox" name="secretCheck"/></td>
					<td id="secretLable" valign="middle"><span>是否密级控制</span></td>
				</tr>
			</table>
		</div>
			<table id="firstjqGrid"></table>
		</div>
		<div data-options="region:'south',split:false,border:false">
			<table id="secondjqGrid"></table>
		</div>
	</div>
	
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/console/menu/js/MenuTree.js" ></script>
<script src="avicit/platform6/datamanagement/js/Data.js" type="text/javascript"></script>
<script  type="text/javascript">
var menuTree,pId,firstList,secondList,ppId,a=true,i=3;

	var fristTable = function() {
			if (!firstList) {
				var DatazGridColModel = [
										  {label : 'id',name : 'id',key : true,width : 75,hidden : true}
										, {label : '菜单名称',name : 'menuname',width : 150,align : "center"}
										, {label : '权限资源标识',name : 'datagrid',width : 150,align : "center"}
										, {label : '请求路径',name : 'dataset',width : 150,align : "center",hidden : true}
										, {label : 'DataGrid标识',name : 'metadata',width : 100,align : "center"}
										, {label : '权限状态',name : 'status',width : 100,align : "center",formatter:formatValue}
										, {label : '前置sql',name : 'spl',width : 150,hidden : true}
										, {label : 'status',name : 'status',width : 150,hidden : true}
										, {label : 'haveSecret',name :'haveSecret',width : 150,hidden : true}
										, {label : 'isSecret',name :'isSecret',width : 150,hidden : true}
										, {label: 'version', name: 'version',width: 75 ,align:'center',hidden : true}
									];
						var url = "platform/PermissionTreeController/listResource.json";
						firstList = new Data('firstjqGrid', url,DatazGridColModel, pId);
						firstList.setOnSelect(function(ppId) {
							secondTable(ppId);
						});
						firstList.setOnSelect1(function(ppId) {
							var rowObject = $('#firstjqGrid').jqGrid('getRowData', ppId);
							show(rowObject);
						});
			}else{
				firstList.loadByAppId(pId);
			}
	};
 	 
	var secondTable = function(ppId) {
		if(!secondList){
			var dataGridColModel =  [
									  { label: 'id', name: 'id', key: true, width: 75,hidden:true }
		                            ,{ label: '权限粒度', name: 'type', width: 75, hidden:true }
		                       	    ,{ label: '权限粒度', name: 'typeName',width: 50,align:'center',required:true}
		                            ,{ label: '角色', name: 'accessRoleName',width: 75 ,align:'center'}
		                            ,{ label: '部门', name: 'accessDeptName',width: 75,align:'center'}
		                            ,{ label: '用户', name: 'accessUserName',width: 75,align:'center'}
		                            ,{ label: '群组', name: 'accessGroupName',width: 75 ,align:'center'}
		                            ,{ label: '岗位', name: 'accessPositionName',width: 75 ,align:'center'}
		                            ,{ label: 'deptId', name: 'accessDept',width: 75 ,align:'center',hidden:true}
		                            ,{ label: 'roleId', name: 'accessRole',width: 75 ,align:'center',hidden:true}
		                            ,{ label: 'userId', name: 'accessUser',width: 75 ,align:'center',hidden:true}
		                            ,{ label: 'groupId', name: 'accessGroup',width: 75 ,align:'center',hidden:true}
		                            ,{ label: 'positionId', name: 'accessPosition',width: 75 ,align:'center',hidden:true}
		                            ,{ label: 'sql', name: 'presql',width: 75 ,align:'center',hidden : true}
		                            ,{ label: 'version', name: 'version',width: 75 ,align:'center',hidden : true}
		                      	];
			var url1 = 'platform/PermissionTreeController/listAccess.json';
			secondList = new Data('secondjqGrid', url1,
						dataGridColModel, ppId);
		}else{
			secondList.loadByAppId(ppId);
		}
	};
	
	function show(rowObject) {
		$('#sql').attr("readonly", false).val(rowObject.sql);
		if (rowObject.haveSecret == 0) {
			$('#secret').hide();
			$('#secretLable').hide();
		} else {
			$('#secret').show();
			$('#secretLable').show();
			if (rowObject.isSecret == 1) {
				$('#secretCheck').attr("checked", true);
			}
		}
	};
	function formatValue(cellvalue, options, rowObject) {
		return cellvalue === '0' ? '有效' : '无效';
	};

	$(function() {
		$('#mdiv').height(document.documentElement.clientHeight - 50);
		//菜单树初始化
		menuTree = new MenuTree('consoleMenu', '${url}', '', 'txt', 'searchbtn');

		menuTree.setOnSelect(function(treeNode) {
			pId = treeNode.id;//菜单ID
			fristTable();
			if(a){
				secondTable(1);
				a=false;
			}
		}).init();

	});
//删除按钮
	function deleteResource() {
		var rows = $('#firstjqGrid').jqGrid('getGridParam', 'selarrrow');
		var ids = [];
		var l = rows.length;
		if(l > 0){
			layer.confirm('确认要删除选中的数据吗?', {
				icon : 3,
				title : "提示",
				area : [ '400px', '' ]
			},function(index) {
				for (; l--;) {
					ids.push(rows[l]);
				}
				avicAjax.ajax({
					url : 'platform/PermissionResourceController/deleteResource',
					data : {
						ids : ids.join(',')
					},
					type : 'post',
					dataType : 'json',
					success : function(r) {
						if (r.flag == "success") {
							fristTable({
								id : ''
							});
					}else{
						layer.alert('删除失败！', {
							icon : 7,
							area : [ '400px', '' ],
							closeBtn : 0,
							btn : [ '关闭' ],
							title : "提示"
						});
					}}
				})
				layer.close(index);
			})           
		}else{
			layer.alert('请选择要删除的数据！', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0,
				btn : [ '关闭' ],
				title : "提示"
			});
		}
	};
	//刷新缓存
	function initResourceList() {
		var treeObj = $.fn.zTree.getZTreeObj("consoleMenu");
		var node = treeObj.getSelectedNodes();
	 	if (node) {
			if (node[0].id === '1'||node[0].id ==='2') {
				layer.msg("请不要选择菜单跟节点！");
				return false;
			}
			layer.confirm('您确定要刷新当前权限资源?', {
				icon : 3,
				title : "提示",
				area : [ '400px', '' ]
			},function(b) {
				if(b){
					$.ajax({
						url : 'platform/PermissionTreeController/refreshResource',
						data : {
							id : node[0].id
						},
						type : 'post',
						dataType : 'json',
						success : function(r) {
							if (r.flag === "success") {
								fristTable({
									id : ''
								});
								layer.msg('刷新成功！');
							}else{
								layer.alert('刷新失败！'+r.msg, {
									icon : 7,
									area : [ '400px', '' ],
									closeBtn : 0,
									btn : [ '关闭' ],
									title : "提示"
								});
							}
						}
					})
					layer.close(b);
				}
			})
		} else {
			layer.msg("请选择一菜单！");
		} 
	};
	//保存按钮
	function saveResource() {
		var totalSql = $('#sql').val();
		if (!checkSQL(totalSql)) {
			return false;
		}
		var id = $('#firstjqGrid').jqGrid('getGridParam', 'selarrrow');
		var selectRow = $('#firstjqGrid').jqGrid('getRowData', id);
		var rows = JSON.stringify(selectRow);
		var accessRows = $('#secondjqGrid').jqGrid('getRowData');
		var accessData = JSON.stringify(accessRows);

		var sqlvalue = document.getElementById("sql").value;
		$.ajax({
			url : 'platform/PermissionResourceController/saveResource',
			data : {
				rows : rows,
				accessdata : accessData,
				presql : sqlvalue,
				secret : document.getElementById('secretCheck').checked
			},
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.result == 0) {
					fristTable({
						id : id
					});
					layer.msg('保存成功！');
				} else {
					layer.alert('保存失败！'+r.error, {
						icon : 7,
						area : [ '400px', '' ],
						closeBtn : 0,
						btn : [ '关闭' ],
						title : "提示"
					});
				}
			}
		});
	}
	var isOk = '';
	//验证SQL语句
	function checkSQL(sql) {
		var result = true;
		$.ajax({
			async : false,
			url : 'platform/PermissionResourceController/check',
			data : {
				sql : sql
			},
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag === 'success') {
					result = true;
					$('#sql').tooltip('destroy');
					if (isOk) {
						clearInterval(isOk);
						$('#sqlLabel').removeClass('error');
					}
				} else {
					result = false;
					layer.msg(r.msg);
				}
			}
		});
		return result;
	};
</script>
</html>