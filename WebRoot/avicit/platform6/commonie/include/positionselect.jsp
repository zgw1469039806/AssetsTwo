<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<html>
<head>
<title>选择岗位</title>
<base href="<%=ViewUtil.getRequestPath(request) %>"></base>
<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
		<div id="tools" class="datagrid-toolbar">
				<table width="99%">
					<tr>
						<td width="210px">

								<div class="ext-selector-div">
									<label>组织:</label>
									<input class="easyui-validatebox ext-selector-input" name="orgAlias" id="orgAlias" title="请选择组织"  placeholder="请选择组织">	
									<input type="hidden"  name="orgid" id="orgid">
									<span class="ext-input-right-icon icon-lookup"></span>
								</div>
						</td>
						<td width="310px">
						
						</td>
						<td width="160px">
								<div class="ext-selector-div">
									<input class="easyui-validatebox ext-selector-input"  name="keyWord" id="keyWord" title="请输入岗位名称查询"  placeholder="请输入岗位名称查询">
									<span class="ext-input-right-icon icon-search"></span>
								</div>

						</td>
					</tr>
				</table>
		</div>
	<div data-options="region:'center'">
		<table style="display:none;" id="tablePosition"
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
					<th data-options="field:'id', halign:'center',checkbox:true" width="220">主键</th>
					<th data-options="field:'positionName',align:'center'" width="220">岗位名称</th>
					<th data-options="field:'positionDesc',align:'center'" width="220">岗位描述</th>
					<th data-options="field:'orgIdentity', halign:'center',hidden:true" width="220">组织应用ID</th>
				</tr>
			</thead>
		</table>

	</div>
</body>

<script>
	var selectModel = null;
	var prositionName = null;
	var prositionid = null;
	var orgIdentity = null;
	var callBack=null;
	var viewScope = null;
	var defaultOrgId = null;
	var setPropertys = null; 
	//初始化表格参数
	function init(o) {
		viewScope = o.viewScope;
		defaultOrgId = o.defaultOrgId;
		selectModel = o.selectModel;
		var positionids = o.positionids;
		prositionid = o.prositionid;
		prositionName = o.prositionName;
		orgIdentity = o.orgIdentity;
		callBack=o.callBack;
		setPropertys = o.setPropertys;
		
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
						 
						 $('#tablePosition').datagrid({
								url : 'h5/view/common/select/SelectController/getInitPositionInfo',
								queryParams : {viewScope : 'currentOrg',defaultOrgId : defaultOrgId},
								onLoadSuccess : function() {
									if (positionids) {
										var pos = positionids.split(';');
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
								$('#tablePosition').datagrid('hideColumn', 'id');
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
	

	//验证单选
	function onSelectRow() {
		var rows = $('#tablePosition').datagrid('getChecked');
		if(rows.length !== 1){
			layer.alert("单选，请选择一条数据!");
			return false;
		}
	}

	function ondblClickRow() {
		if (selectModel == "single") {
			var ret = {};
			var rowDatas = $('#tablePosition').datagrid('getChecked');
			ret.positionids = rowDatas[0].id;
			ret.positionNames = rowDatas[0].positionName;
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
	//关键字段查询
	function onSeach() {
		var searchdata = {search_text: $('#keyWord').val()==$('#keyWord').attr("placeholder") ? "" :  $('#keyWord').val(),"orgId":$('#orgid').val()};
		$('#tablePosition').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
		$('#tablePosition').datagrid('reload',searchdata);
	};

	//查询按钮绑定事件
	$('.icon-search').bind('click', function() {
		onSeach();
	});
	//回填数据
	function getPositionList() {
		var positionids = "";
		var positionNames = "";
		var orgIdentitys = ""
		var rowdatas = [];
		var positionidlist = $('#tablePosition').datagrid('getChecked');
		for ( var i = 0; i < positionidlist.length; i++) {
			var rowData= positionidlist[i];
			rowdatas.push(rowData);
			positionids = positionids + rowData.id + ";";
			positionNames = positionNames + rowData.positionName + ";";
			orgIdentitys = orgIdentitys + rowData.orgIdentity + ";";
		}
		positionids = positionids.substring(0, positionids.length - 1);
		positionNames = positionNames.substring(0, positionNames.length - 1);
		orgIdentitys = orgIdentitys.substring(0, orgIdentitys.length - 1);
		return {
			positionids : positionids,
			positionNames : positionNames,
			orgIdentitys: orgIdentitys,
			rowdatas:rowdatas
		};
	};
	//重载
	function reLoad(orgId){
		var searchdata = {orgId:orgId};
		$('#tablePosition').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
		$('#tablePosition').datagrid('reload',searchdata);
	}
	//回调函数
	function searchOrgByOrgId(datas){
		reLoad(datas.id);
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
	
	$(document).ready(function () {
		$('#orgAlias').on('focus',function(){
			opnOrgSelect($('#orgAlias'));
		}); 
		
		$('.icon-lookup').on('click',function(){
			opnOrgSelect($('#orgAlias'));
		}); 
	});
</script>
</html>
