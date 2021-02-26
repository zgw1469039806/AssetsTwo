<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
	String importlibs = "common,tree,table";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据权限授权</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<link rel="stylesheet" type="text/css" href="avicit/platform6/console/authorization/css/auth.css"/>
<%--<link rel="stylesheet" type="text/css" href="avicit/platform6/console/sysdatapermissions/plugins/select2/css/select2.css"/>--%>
<link rel="stylesheet" type="text/css" href="static/h5/select2/select2.css"/>
<style type="text/css">
	.sysdatapermissionTips{
		float: left;
	    width: 16px;
	    height: 16px;
	    background-image: url(static/images/platform/common/tips.png);
	    margin-right: 3px;
	    margin-top: 1px;
	}
</style>
</head>
<body class="easyui-layout" fit="true" style="overflow:hidden;">

	<div data-options="region:'west',title:'角色选择',split:false,border:true,collapsible:false" style="width:400px;overflow-x: hidden;">
		<div id="tableToolbarR" class="toolbar">
			<div class="toolbar-right" style="margin-right: 10px;">
				<div class="input-group form-tool-search">
					<input type="text" name="keyWord" id="keyWordRole" style="width:240px;" class="form-control input-sm" placeholder="角色名称">
					<label id="keyWordRoleL" class="icon icon-search form-tool-searchicon"></label>
				</div>
			</div>
		</div>
		<table id="jqGridRole"></table>
		<div id="jqGridPagerR"></div>
	</div>
	
	<div id="center" data-options="region:'center',title:'模块选择',split:false,border:true">
		<div id="tableToolbarGroup" class="toolbar">
			<div class="toolbar-left">
				<div class="input-group form-tool-search">
					<input type="text" name="txt" id="txt" style="width:240px;" class="form-control input-sm" placeholder="请输入菜单名称" />
					<label id="searchbtn" class="icon icon-search form-tool-searchicon"></label>
				</div>
			</div>
		</div>
		<div id="mdiv" style="overflow:auto;">
			<ul id="menuTree" class="ztree"></ul>
		</div>
	</div>
	
	<div data-options="region:'east',title:'规则授权',split:false,border:true,collapsible:false" style="width:700px;">
		<div id="methodDiv">
			<form id='methodForm'>
				<input type="hidden" name="id" id="id" />
				<table class="form_commonTable">
					<tr>
						<td colspan="4">
							<ol class="breadcrumb"
								style="margin-bottom: 0px; font-size: 12px; font-weight: bold;background-color: #EFEFEF;">
								<li><a href="javascript:void(0);">表信息</a></li>
							</ol>
						</td>
					</tr>
					<tr>
						<th width="10%"><label for="type">类型:</label></th>
						<td width="23%" colspan="3">
							<label class="radio-inline">
								<input type="radio" name="type" value="0" disabled="disabled"/>普通模块
							</label>
							<label class="radio-inline">
								<input type="radio" name="type" value="1" disabled="disabled"/>电子表单
							</label>
							<label class="radio-inline">
								<input type="radio" name="type" value="2" disabled="disabled"/>选择页
							</label>
						</td>
					</tr>
					
					<tr class="selectTr" style="display: none;">
						<th width="10%"><label for="selectType">选择页面类型:</label></th>
						<td width="23%" colspan="3">
							<label class="radio-inline">
								<input disabled="disabled" type="radio" name="selectType" value="0" />平台自定义选择页
							</label>
							<label class="radio-inline">
								<input disabled="disabled" type="radio" name="selectType" value="1" />电子表单数据字典
							</label>
							<label class="radio-inline">
								<input disabled="disabled" type="radio" name="selectType" value="2" />自定义选择页
							</label>
						</td>
					</tr>
					<tr class="selectTr" style="display: none;">
						<th width="10%"><label for="selectId">选择页唯一标识:</label></th>
						<td width="23%">
							<input disabled="disabled" class="form-control input-sm" type="text" name="selectId" id="selectId"/>
						</td>
						<th width="10%"><label>标识符说明:</label></th>
						<td width="23%">
							<input disabled="disabled"  class="form-control input-sm" type="text" id="selectRemarks" />
						</td>
					</tr>
					
					<tr class="selectCustomTr" style="display: none;">
						<th width="10%"><label>选择页Mapper名称:</label></th>
						<td width="23%">
							<input disabled="disabled" class="form-control input-sm" type="text" id="selectMapperName" />
						</td>
						<th width="10%"><label>选择页执行方法名称:</label></th>
						<td width="23%">
							<input disabled="disabled" class="form-control input-sm" type="text" id="selectMethodName" />
						</td>
					</tr>
					
					<tr class="defaultAndEformTr">
						<th width="10%"><label for="tableName">表名称:</label></th>
						<td width="23%">
							<input class="form-control input-sm" type="text" name="tableName" id="tableName" disabled="disabled"/>
						</td>
						<th width="10%"><label for="tableRemarks">表说明:</label></th>
						<td width="23%"><input class="form-control input-sm" type="text" name="tableRemarks" id="tableRemarks" disabled="disabled"/></td>
					</tr>
					<tr class="EformTr" style="display: none;">
						<th width="10%"><label for="viewCode">视图编码:</label></th>
						<td width="23%">
							<input disabled="disabled" class="form-control input-sm" type="text" name="viewCode" id="viewCode" />
						</td>
						<th width="10%"><label for="viewName">视图名称:</label></th>
						<td width="23%"><input disabled="disabled" class="form-control input-sm" type="text" name="viewName" id="viewName" /></td>
					</tr>
					
					<tr class="defaultTr">
						<th width="10%"><label for="mapperName">mapper名称:</label></th>
						<td width="23%">
							<input class="form-control input-sm" type="text" name="mapperName" id="mapperName" disabled="disabled"/>
						</td>
						<th width="10%"><label for="mapperRemarks">mapper说明:</label></th>
						<td width="23%"><input class="form-control input-sm" type="text" name="mapperRemarks" id="mapperRemarks" disabled="disabled"/></td>
					</tr>
					<tr class="defaultTr">
						<th width="10%"><label for="method">执行方法:</label></th>
						<td width="23%" colspan="3">
							<select class="js-example-basic-multiple" id="method" name="method" multiple="multiple" style="width: 100%" disabled="disabled"></select>
						</td>
					</tr>
					<tr class="defaultTr">
						<th width="10%"><label for="methodRemarks">方法说明:</label></th>
						<td width="23%" colspan="3">
							<textarea class="form-control input-sm" name="methodRemarks" id="methodRemarks" rows="3" disabled="disabled"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="4" >
							<ol class="breadcrumb"
								style="margin-bottom: 0px; font-size: 12px; font-weight: bold;background-color: #EFEFEF;">
								<li><a href="javascript:void(0);">规则信息</a></li>
							</ol>
						</td>
					</tr>
					<tr>
						<th width="10%">权限规则:</th>
						<td width="23%" colspan="3">
							<div class="input-group-sm" id="ruleList"></div>
						</td>
					</tr>
					<tr>
						<th width="10%">
							<label><div class="sysdatapermissionTips"></div>过滤公式:</label>
						</th>
						<td width="23%" colspan="3">
							<textarea class="form-control input-sm" name="formula" id="formula" rows="3"></textarea>
						</td>
					</tr>
					<tr>
						<th width="10%">过滤条件:</th>
						<td width="23%" colspan="3">
							<textarea class="form-control input-sm" readonly="readonly" id="filterCondition" rows="2"></textarea>
						</td>
					</tr>
					<tr>
						<th width="10%">过滤条件sql:</th>
						<td width="23%" colspan="3">
							<textarea class="form-control input-sm" readonly="readonly" id="filterConditionSql" rows="3"></textarea>
						</td>
					</tr>
				</table>
			</form>
			<div data-options="region:'south',border:false" style="text-align: right;margin-right: 26px;">
				<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="sysDataPermissionsAuth_saveForm">保存</a>
				<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="清空" id="sysDataPermissionsAuth_closeForm">清空</a>
			</div>
		</div>
	</div>    
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<script type="text/javascript" src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsauth/js/listObj.js?v=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsauth/js/authMenu.js?v=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsauth/js/SysDataPermisAuth.js?v=<%=System.currentTimeMillis()%>"></script>
<%--<script type="text/javascript" src="avicit/platform6/console/sysdatapermissions/plugins/select2/js/select2.js"></script>--%>
<script type="text/javascript" src="static/h5/select2/select2.js"></script>

<script type="text/javascript">
	var listRole,menuTree,appId='${appId}';
	var roleId="";
	var methodId="";
	var authId="";
	var authMap;
	
	var clickRow=function(rid,type){
		roleId = rid;
		$('#mdiv').height($('#center').height()-85);
		initFormData();
	};
	
	$(function(){
		var dataGridColModel =  [
			{ label: 'id', name: 'id', key: true, hidden:true },
			{ label: '角色名称', name: 'roleName', width: 100,sortable:false,align:'center'},
			{ label: '角色描述', name: 'roleDesc', width: 80,sortable:false,align:'center' }
		];
		listRole = new ListObj('jqGridRole','${urlRole}/R','searchDialog','R','keyWordRole',["roleName"],dataGridColModel,appId);
		listRole.setOnClick(clickRow);
		
		menuTree = new MenuTree('menuTree','${urlMenu}/console/${params}','','txt','searchbtn');
		menuTree.setOnSelect(function(node){
			var menuId=node.id;
			if(undefined != node.menuType){
				if(node.menuType == "method"){ // 点击了模块
					methodId = menuId;
					initFormData();
				}
			}
		}).init();
	
		$("#method").select2({});
		
		// 清空form
		$("#sysDataPermissionsAuth_closeForm").bind('click',function(){
			initFormData();
		});
		
		// 保存表单
		$("#sysDataPermissionsAuth_saveForm").bind('click',function(){
			if(methodId == ""){
				layer.alert('请选择一个模块！', {
					icon: 7,
					area: ['400px', ''],
					closeBtn: 0
				});
				return false;
			}
			
			// 校验公式
			if(!analysisFormula($("#formula").val())){
				return false;
			}
			
			var ruleIds = "";
			$.each($("input[name='ruleCheckbox']:checked"), function (index, data) {
				ruleIds += $(data).val()+",";
			});
			var formData = {
				"id":authId,
				"methodId": methodId,
				"roleId": roleId,
				"formula": $("#formula").val(),
				"ruleIds": ruleIds.substr(0,ruleIds.lastIndexOf(","))
			};

			// 保存权限
			avicAjax.ajax({
				 url:"platform6/msystem/sysdatapermissions/sysdatapermissionsauth/sysDataPermissionsAuthController/operation/save",
				 data : {data :JSON.stringify(formData)},
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success"){
						 initFormData();
						 layer.msg('保存成功');
					 }else{
						 layer.alert('保存失败,请联系管理员!', {
								  icon: 7,
								  area: ['400px', ''], // 宽高
								  closeBtn: 0,
								  btn: ['关闭'],
					              title:"提示"
								}
						 );
					 } 
				 }
			 });
		});
		
		$('#formula').bind('valuechange', function(e, previous){
			if("" != methodId && "" != roleId){
				var oldVal = previous;
				var newVal = $(this).val();
				
				analysisFormula(newVal);				
			}
		});  
				
		var tipsIndex;
		$(".sysdatapermissionTips").mouseover(function(){
			var message = "请按如下规则编辑条件组合<br/><span style='color: #42d442;'>( 1 and 2 ) or ( 3 and 4 ) √</span><br/>1.有and和or必须加括号<br/><span style='color: #ff0000;'>1 and 2 or 3 and 4 ×</span><br/>2.一个括号里不能同时出现and和or<br/><span style='color: red;'>(1 and 2 or 3) and 4 ×</span><br/>3.不允许出现不存在的编号<br/><span style='color: red;'>1 and 2 and 3 and 4 and 5 ×</span><br/>4.括号都是成对出现的<br/><span style='color: red;'>(1 and 2 and 3 and 4 ×</span><br/>5.标识符，括号，运算符之间应带有空格<br/><span style='color: red;'>(1or2or3) ×</span>";
			tipsIndex= layer.tips(message, $(this), {
			  tips: [1, '#3595CC'],
			  time: 0,
			  area: ['240px', 'auto']
			});
		}).mouseout(function(){
			layer.close(tipsIndex);
		});
	});
		
	// 查看规则详情
	var subDetailIndex;
	function ruleDetail(id){
		subDetailIndex = layer.open({
		    type: 2,
		    area: ['90%', '90%'],
		    title: '规则详情',
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
	        maxmin: false, //开启最大化最小化按钮
		    content: 'platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/subDetail/'+id+"?pid="+methodId
		}); 
	}
	function closeSubDetailDialog(){
		layer.close(subDetailIndex);
	}
</script>
</html>