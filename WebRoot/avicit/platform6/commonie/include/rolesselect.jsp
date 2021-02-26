<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<!DOCTYPE html>
<html>
<head>
<title>角色选择</title>
<base href="<%=ViewUtil.getRequestPath(request) %>"></base>
<jsp:include
	page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
</head>
<body class=" easyui-layout" fit="true">
	<div id="tools" class="datagrid-toolbar">
		<table width="99%">
			<tr>
				<td  width="230px">
					<div class="ext-selector-div">
						<label>组织:</label> <input
							class="easyui-validatebox ext-selector-input" name="orgAlias" id="orgAlias" title="请选择组织" placeholder="请选择组织">
							 <input type="hidden" name="orgid" id="orgid"> 
							 <span class="ext-input-right-icon icon-lookup" id="orgIcon"></span>
					</div>
				</td>
				<td  width="230px">
					<div class="ext-selector-div">
						<label>应用:</label> <input
							class="easyui-validatebox ext-selector-input" name="appAlias" id="appAlias" title="请选择应用" placeholder="请选择应用"> 
							<input type="hidden" name="appid" id="appid">
							<span class="ext-input-right-icon icon-lookup" id="appIcon"></span>
					</div>
				</td>
				<td width="110px"></td>
				<td  width="160px">
						<div class="ext-selector-div">
							<input class="easyui-validatebox ext-selector-input"
								name="keyWord" id="keyWord" title="请输入角色名称查询"
								placeholder="请输入角色名称查询"> <span
								class="ext-input-right-icon icon-search"></span>
						</div>
				</td>
			</tr>
		</table>
	</div>
	<div data-options="region:'center'">
		<table style="display: none;" id="tableRole"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				toolbar:'#tools',
				autoRowHeight: false,
				idField :'id',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				onDblClickRow : ondblClickRow,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">主键</th>
					<th data-options="field:'roleName',align:'center'" width="220">角色名称</th>
					<th data-options="field:'desc',align:'center'" width="220">角色描述</th>
					<th data-options="field:'orgIdentity', halign:'center',hidden:true"
						width="220">组织应用ID</th>
				</tr>
			</thead>
		</table>
	</div>
</body>

<script>
	var selectModel = null;
	var roleid = null;
	var roleName = null;
	var callBack=null;
	var viewScope = null;
	var orgIdentity = null;
	var defaultOrgId = null;
	var appSelectType = null;
	var setPropertys = null;
	var appId = null;
	var orgId = null;
	//初始化表格参数
	function init(o) {
		viewScope = o.viewScope;
		defaultOrgId = o.defaultOrgId;
		selectModel = o.selectModel;
		orgIdentity = o.orgIdentity;
		appSelectType = o.appSelectType;
		var rolesids = o.roleids;
		roleid = o.roleid;
		roleName = o.roleName;
		callBack=o.callBack;
		setPropertys = o.setPropertys;
		
		if(!appSelectType){
			$(".appSelectType").hide();
		}
		var mult;
		if (selectModel == "single") {
			mult = true;

		} else if (selectModel == "multi") {
			mult = false;

		}
		if($('#orgAlias').val() == null || $('#orgAlias').val() == "" || $('#orgAlias').val() == "所属组织"){
			avicAjax.ajax({
				 url:"h5/view/common/select/SelectController/searchOrgName",
				 data : {
					 	"viewScope" : viewScope,
					 	"defaultOrgId" : defaultOrgId
					 },
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success"){
						  $('#orgid').val(r.orgId);
						 $('#orgAlias').val(r.orgName);
						 
						 $('#tableRole').datagrid({
								url : 'h5/view/common/select/SelectController/getInitRoleInfo',
								queryParams : {viewScope : r.viewScope,defaultOrgId : defaultOrgId, appSelectType: appSelectType, appId: appId},
								onLoadSuccess : function() {
									if (rolesids) {
										var role = rolesids.split(';');
										for ( var o = 0; o < role.length; o++) {
											var id = role[o];
											var index = $(this).datagrid("getRowIndex", id);
											if(index != "-1"){
											  $(this).datagrid("checkRow",index);
											}
										}
									}
								}
							});
						//单选隐藏checkbox
						if (selectModel == "single") {
							$('#tableRole').datagrid('hideColumn', 'id');
						};
						//回车查询
						$('#keyWord').on('keydown',function(e){
							if(e.keyCode == '13'){
								onSeach();
							}
						});
					 }else{
						 layer.alert('查询所属组织失败！' + r.error, {
							  icon: 7,
							  area: ['400px', ''], //宽高
							  closeBtn: 0,
							  btn: ['关闭'],
							  title:"提示"
							}
						);
					 } 
				 }
			 });
		}

	};

	function ondblClickRow() {
		if (selectModel == "single") {
			var ret = {};
			var rowDatas = $('#tableRole').datagrid('getChecked');
			ret.roleids = rowDatas[0].id;
			ret.roleNames = rowDatas[0].roleName;
			ret.roleType = rowDatas[0].roleType;
			ret.orgIdentitys = rowDatas[0].orgIdentity;
			ret.rowdatas = rowDatas;
			setPropertys(ret);
			var rowIndex = Number(${param.rowIndex});
			if(callBack!=null && callBack!='undefined'){
				if(typeof(callBack) === 'function'){
		 			callBack(ret,rowIndex);
		 		}
			}
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			parent.layer.close(index);
		}
	} //双击事件
	//双击
	/* function GetJqGridRowValue(jgrid, code) {
		var KeyValue = "";
		var rowDatas = $('#tableRole').datagrid('getChecked');
		if (rowDatas != "") {
			var len = rowDatas.length;
			for ( var i = 0; i < len; i++) {
				KeyValue += rowDatas[i].[code] + ";";
			}
			KeyValue = KeyValue.substr(0, KeyValue.length - 1);
		} else {
			 var rowData = $(jgrid).jqGrid('getRowData',      //暂注释
					$(jgrid).jqGrid('getGridParam', 'selrow'));
			KeyValue = rowData[code]; 
		}
		return KeyValue;
	} */
	// 	单选
	function onSelectRow() {
		var rolelist = $('#tableRole').datagrid('getChecked');
		if (selectModel == "single" && rolelist.length > 1) {
			layer.alert("单选，请选择一条数据!");
			//$(this).trigger("reloadGrid");                   //暂注释
			//$(this).jqGrid("setSelection", rolelist[0]);
			
			return false;
		}
	};
	//关键字段查询
	function onSeach() {
		var searchdata = {search_text: $('#keyWord').val()==$('#keyWord').attr("placeholder") ? "" :  $('#keyWord').val(),"orgId":$('#orgid').val(),"appId":$('#appid').val()};
		$('#tableRole').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
		$('#tableRole').datagrid('reload',searchdata);
	};
	//查询按钮绑定事件
	 $('.icon-search').bind('click', function() {    //暂注释
		onSeach();
	}); 
	//回填数据
	function getRoleList() {
		var roleids = "";
		var roleNames = "";
		var roleType = "";
		var rowdatas = [];
		var orgIdentitys = "";
		var roleidlist = $('#tableRole').datagrid('getChecked');
		for ( var i = 0; i < roleidlist.length; i++) {
			var rowData = roleidlist[i];
			roleids = roleids + rowData.id + ";";
			roleNames = roleNames + rowData.roleName + ";";
			orgIdentitys = orgIdentitys + rowData.orgIdentity + ";";
			roleType = rowData.roleType;
			rowdatas.push(rowData);
		}
		roleids = roleids.substring(0, roleids.length - 1);
		roleNames = roleNames.substring(0, roleNames.length - 1);
		orgIdentitys = orgIdentitys.substring(0, orgIdentitys.length - 1);
		
		return {
			roleids : roleids,
			roleNames : roleNames,
			orgIdentitys: orgIdentitys,
			roleType:roleType,
			rowdatas:rowdatas
		};

	};
	//重载
	function reLoad(orgId,appId){
		var searchdata = {orgId:orgId,appId:appId};
		$('#tableRole').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
		$('#tableRole').datagrid('reload',searchdata);
	}
	//回调函数
	function searchOrgByOrgId(datas){
		reLoad(datas.id,$('#appid').val());
	}
	function searchAppByAppId(datas){
		reLoad($('#orgid').val(),datas.id);
	}
	
	function opnOrgSelect(that){
		new EasyuiCommonPopSelect({
			idFiled:'orgid',
			textFiled:'orgAlias',
			divid:'orgAlias',
			type : 'orgSelect',
			viewScope : viewScope,
			defaultOrgId : defaultOrgId,
			contentWidth : '300',
			callBack : function(datas){return searchOrgByOrgId(datas);}
		});
		that.blur();
	}
	
	function opnAppSelect(that){
		new EasyuiCommonPopSelect({
			idFiled:'appid',
			textFiled:'appAlias',
			divid:'appAlias',
			type : 'appSelect',
			appSelectType:appSelectType,
			contentWidth : '300',
			callBack : function(datas){return searchAppByAppId(datas);}
		});
		that.blur();
	}

	
	$(document).ready(function () {
		$('#orgAlias').on('focus',function(){
			opnOrgSelect($('#orgAlias'));
		}); 
		
		$('#appAlias').on('focus',function(){
			opnAppSelect($('#appAlias'));
		}); 
		
		$('#orgIcon').on('click',function(){
			opnOrgSelect($('#orgAlias'));
		});
		$('#appIcon').on('click',function(){
			opnAppSelect($('#appAlias'));
		});
	});
</script>

</body>
</html>
