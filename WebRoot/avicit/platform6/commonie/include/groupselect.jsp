<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<!DOCTYPE html>
<html>
<head>
<title>群组选择</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include
	page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
</head>
<body class=" easyui-layout" fit="true">
	<div id="tools" class="datagrid-toolbar">
		<table width="99%">
			<tr>
				<td width="230px">
					<div class="ext-selector-div">
						<label>组织:</label> <input
							class="easyui-validatebox ext-selector-input" name="orgAlias"
							id="orgAlias" title="请选择组织" placeholder="请选择组织"> <input
							type="hidden" name="orgid" id="orgid"> <span
							class="ext-input-right-icon icon-lookup"
							id="orgIcon"></span>
					</div>
				</td>
				<!-- <td width="230px">
					<div class="ext-selector-div">
						<label>应用:</label> <input
							class="easyui-validatebox ext-selector-input" name="appAlias"
							id="appAlias" title="请选择应用" placeholder="请选择应用"> <input
							type="hidden" name="appid" id="appid"> <span
							class="ext-input-right-icon icon-lookup" id="appIcon"></span>
					</div>
				</td> -->
				<td width="230px">
						
				</td>
				<td width="110px"></td>
				<td width="160px">
					<div class="ext-selector-div">
						<input class="easyui-validatebox ext-selector-input"
							name="keyWord" id="keyWord" title="请输入群组名称查询"
							placeholder="请输入群组名称查询"> <span
							class="ext-input-right-icon icon-search"></span>
					</div>
				</td>
				</td>
			</tr>
		</table>
	</div>
	<div data-options="region:'center'">
		<table style="display: none;" id="tableGroup"
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
					<th data-options="field:'groupName',align:'center'" width="220">群组名称</th>
					<th data-options="field:'groupDesc',align:'center'" width="220">群组描述</th>
					<th data-options="field:'orgIdentity', halign:'center',hidden:true"
						width="220">组织应用ID</th>
				</tr>
			</thead>
		</table>
	</div>
</body>

<script>
	var selectModel = null;
	var groupid = null;
	var groupName = null;
	var orgIdentity = null;
	var callBack=null;
	var viewScope = null;
	var defaultOrgId = null;
	var appSelectType = null;
	var setPropertys = null;
	var appId = null;
	var orgId = null;
	//初始化表格参数
	function init(o) {
		selectModel = o.selectModel;
		var groupids = o.groupids;
		groupid = o.groupid;
		groupName = o.groupName;
		orgIdentity = o.orgIdentity;
		viewScope = o.viewScope;
		defaultOrgId = o.defaultOrgId;
		appSelectType = o.appSelectType;
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
		
		if($('#orgAlias').val() == null || $('#orgAlias').val() == ""|| $('#orgAlias').val() == "所属组织"){
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
						 
						 $('#tableGroup').datagrid({
								url : 'h5/view/common/select/SelectController/getInitGroupInfo',
								queryParams : {viewScope : 'currentOrg',defaultOrgId : defaultOrgId},
								onLoadSuccess : function() {
									if (groupids) {
										var pos = groupids.split(';');
										for ( var o = 0; o < pos.length; o++) {
											var id = pos[o];
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
								$('#tableGroup').datagrid('hideColumn', 'id');
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
			var rowDatas = $('#tableGroup').datagrid('getChecked');
			ret.groupids = rowDatas[0].id;
			ret.groupNames = rowDatas[0].groupName;
			ret.orgIdentity = rowDatas[0].orgIdentity;
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
	}
	//双击
	/* function GetJqGridRowValue(jgrid, code) {
		var KeyValue = "";
		var selectedRowIds = $(jgrid).jqGrid("getGridParam", "selarrrow");
		if (selectedRowIds != "") {
			var len = selectedRowIds.length;
			for ( var i = 0; i < len; i++) {
				var rowData = $(jgrid).jqGrid('getRowData', selectedRowIds[i]);
				KeyValue += rowData[code] + ";";
			}
			KeyValue = KeyValue.substr(0, KeyValue.length - 1);
		} else {
			var rowData = $(jgrid).jqGrid('getRowData',
					$(jgrid).jqGrid('getGridParam', 'selrow'));
			KeyValue = rowData[code];
		}
		return KeyValue;
	} */
	//验证单选
	function onSelectRow() {
		var rows = $('#tableGroup').datagrid('getChecked');
		if(rows.length !== 1){
			layer.alert("单选，请选择一条数据!");
			return false;
		}
	}
	//关键字段查询
	function onSeach() {
		var searchdata = {search_text: $('#keyWord').val()==$('#keyWord').attr("placeholder") ? "" :  $('#keyWord').val(),"orgId":$('#orgid').val(),"appId":$('#appid').val()};
		$('#tableGroup').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
		$('#tableGroup').datagrid('reload',searchdata);
	};
	//查询按钮绑定事件
	$('.icon-search').bind('click', function() {
		onSeach();
	});
	//回填数据
	function getGroupList() {
		var groupids = "";
		var groupNames = "";
		var orgIdentitys = ""
		var rowdatas = [];
		var groupidlist = $('#tableGroup').datagrid('getChecked');
		
		for ( var i = 0; i < groupidlist.length; i++) {
			var rowData= groupidlist[i];
			rowdatas.push(rowData);
			groupids = groupids + rowData.id + ";";
			groupNames = groupNames + rowData.groupName + ";";
			orgIdentitys = orgIdentitys + rowData.orgIdentity + ";";
		}
		groupids = groupids.substring(0, groupids.length - 1);
		groupNames = groupNames.substring(0, groupNames.length - 1);
		orgIdentitys = orgIdentitys.substring(0, orgIdentitys.length - 1);

		return {
			groupids : groupids,
			groupNames : groupNames,
			orgIdentitys: orgIdentitys,
			rowdatas:rowdatas
		};
	};
	//重载
	function reLoad(orgId,appId){
		var searchdata = {orgId:orgId,appId:appId};
		$('#tableGroup').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
		$('#tableGroup').datagrid('reload',searchdata);
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
