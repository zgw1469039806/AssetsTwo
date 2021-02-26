<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,tree,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "rowdataauthorization/sysDbSubjectController/toSysDbSubjectManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style type="text/css">
div#rMenu {
	position: absolute;
	visibility: hidden;
	top: 0;
	background-color: #555;
	text-align: left;
	padding: 2px;
}

div#rMenu a {
	cursor: pointer;
	list-style: none outside none;
}

.ztree-submenu {
	border: 1px solid #959595;
	position: fixed !important;
	background: #FFF !important;
	z-index: 5;
}

.ztree-submenu:before {
	position: absolute;
	width: 36px;
	height: 100%;
	left: 0;
	top: 0;
	background-color: #e7e8e8;
	z-index: 5;
	display: block;
	content: ' ';
}

.ztree-submenu a {
	color: #454545;
	font-size: 14px;
	border: 0;
	background: none;
	line-height: 14px;
	padding: 8px 15px 8px 45px;
	z-index: 5;
}

.ztree-submenu a:hover {
	background-color: #cbeef5;
}
</style>
</head>

<body class="easyui-layout">
    <div data-options="region:'west',split:true" style="width:250px">
    <div class="row" style="margin: 5px;">
			<div class="input-group  input-group-sm">
				<input class="form-control" placeholder="请输入名称查询" type="text" id="txt"
					name="txt"> <span class="input-group-btn">
					<button id="searchbtns" class="btn btn-default ztree-search"
						type="button">
						<span class="glyphicon glyphicon-search"></span>
					</button>
				</span>
			</div>
			<!-- 快捷菜单start -->
			<div id="rMenu" class="ztree-submenu">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_singleTreeListWs_button_add_sub"
					permissionDes="添加子节点">
					<a id="sysDbSubject_insertsub" href="javascript:void(0)"
						class="list-group-item" style="padding-left: 10px;"><i class="icon icon-add"></i><i style="padding-left: 15px;">添加子节点</i></a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_singleTreeListWs_button_edit"
					permissionDes="树编辑">
					<a id="sysDbSubject_modify" href="javascript:void(0)"
						class="list-group-item" style="padding-left: 10px;"><i class="icon icon-edit"></i><i style="padding-left: 15px;">编辑节点</i></a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_singleTreeListWs_button_delete"
					permissionDes="树删除">
					<a id="sysDbSubject_del" href="javascript:void(0)"
						class="list-group-item" style="padding-left: 10px;"><i class="icon icon-delete"></i><i style="padding-left: 15px;">删除</i></a>
				</sec:accesscontrollist>
			</div>
			<!-- 快捷菜单end -->
			<div>
				<ul id="treeDemo" class="ztree"></ul>
			</div>
		</div>
    </div>
    <div data-options="region:'center'">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',split:true" style="height:310px">
				<div style="font-size: 20px; display: none">授权选择</div>
				<ul id="myTab" class="nav nav-tabs" style="width: 80%; border-bottom: none">
					<li class="active"><a rel="iframe1" href="#role" data-toggle="tab" id="tab1" val="1">角色</a></li>
					<li><a rel="iframe2" href="#dep" data-toggle="tab" id="tab2" val="2">部门</a></li>
					<li><a rel="iframe3" href="#group" data-toggle="tab" id="tab5" val="3">群组</a></li>
					<li><a rel="iframe4" href="#posit" data-toggle="tab" id="tab4" val="4">岗位</a></li>
					<li><a rel="iframe5" href="#user" data-toggle="tab" id="tab3" val="5">用户</a></li>
					<li><a rel="iframe6" href="#org" data-toggle="tab" id="tab6" val="6">组织</a></li>
				</ul>
				<div id="myTabContent" class="tab-content" style="width: 100%; border: 0;overflow: auto;">
					<div class="tab-pane fade in active" id="role" tyle="width: 100%; border: 0; overflow: auto;">
						<iframe id="iframe1" name="iframe1" val="1" src="avicit/platform6/console/rowdataauthorization/sysdbsubject/role.jsp" scrolling="no" frameborder="0" style="width: 100%; border: 0;height: 260px"></iframe>
					</div>
					<div class="tab-pane fade" id="dep" style="width: 100%; border: 0; overflow: auto;">
						<iframe id="iframe2" name="iframe2" val="2" src="" scrolling="no" frameborder="0" style="width: 100%; border: 0;height: 260px"></iframe>
					</div>
					<div class="tab-pane fade" id="group"
						style="width: 100%; border: 0; overflow: auto;">
						<iframe id="iframe3" name="iframe3" val="3" src="" scrolling="no"
							frameborder="0" style="width: 100%; border: 0;height: 260px"></iframe>
					</div>
					<div class="tab-pane fade" id="posit" style="width: 100%; border: 0; overflow: auto;">
						<iframe id="iframe4" name="iframe4" src="" val="4" scrolling="no"
							frameborder="0" style="width: 100%; border: 0;height: 260px"></iframe>
					</div>
					<div class="tab-pane fade" id="user" style="width: 100%; border: 0;">
						<iframe id="iframe5" name="iframe5" val="5" src="" scrolling="no" frameborder="0" style="width: 100%; border: 0;height: 260px"></iframe>
					</div>
					<div class="tab-pane fade" id="org" style="width: 100%; border: 0;">
						<iframe id="iframe6" name="iframe6" val="6" src="" scrolling="no" frameborder="0" style="width: 100%; border: 0;height: 260px"></iframe>
					</div>
				</div>
			</div>
			<div data-options="region:'center',onResize:function(a){$('#jqGrid').setGridWidth(a);$(window).trigger('resize');}">
			<div id="toolbar_sysDbEntity" class="toolbar">
				<div class="toolbar-left">
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysDbEntity_button_add"
						permissionDes="子表添加">
						<a id="sysDbEntity_insert" href="javascript:void(0)"
							class="btn btn-default form-tool-btn btn-sm btn-point" role="button"
							title="添加"><i class="fa fa-plus"></i> 添加</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysDbEntity_button_edit"
						permissionDes="子表编辑">
						<a id="sysDbEntity_modify" href="javascript:void(0)"
							class="btn btn-default form-tool-btn btn-sm" role="button"
							title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysDbEntity_button_delete"
						permissionDes="子表删除">
						<a id="sysDbEntity_del" href="javascript:void(0)"
							class="btn btn-default form-tool-btn btn-sm" role="button"
							title="删除"><i class="fa fa-trash-o"></i> 删除</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysDbRelationship_button_save"
						permissionDes="子表保存">
						<a id="sysDbrelationshipSave" href="javascript:void(0)"
							class="btn btn-default form-tool-btn btn-sm" role="button"
							title="保存"><i class="fa fa-save"></i> 保存</a>
					</sec:accesscontrollist>
				</div>
				<div class="toolbar-right">
					<div class="input-group form-tool-search">
						<input type="text" name="sysDbEntity_keyWord"
							id="sysDbEntity_keyWord" style="width: 240px;"
							class="form-control input-sm" placeholder="请输入查询条件"> <label
							id="sysDbEntity_searchPart"
							class="icon icon-search form-tool-searchicon"></label>
					</div>
					<div class="input-group-btn form-tool-searchbtn">
						<a id="sysDbEntity_searchAll" href="javascript:void(0)"
							class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
							<span class="caret"></span>
						</a>
					</div>
				</div>
			</div>
			<table id="sysDbEntity"></table>
			<div id="sysDbEntityPager"></div>
			</div>
		</div>
    </div>
</body>

<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto; display: none">
	<form id="formSub">
		<input type="hidden" name="deptid" id="deptid" />
		<table class="form_commonTable">
			<tr>
				<th width="25%">表名称:</th>
				<td width="74%"><input title="表名称"
					class="form-control input-sm" type="text" name="tableName"
					id="tableName" /></td>
			</tr>
			<tr>
				<th width="25%">表描述:</th>
				<td width="74%"><input title="表描述"
					class="form-control input-sm" type="text" name="tableComments"
					id="tableComments" /></td>
			</tr>
			<tr>
				<th width="25%">表对应mapper.xml:</th>
				<td width="74%"><input title="表对应mapper.xml"
					class="form-control input-sm" type="text" name="mapperForTab"
					id="mapperForTab" /></td>
			</tr>
			<tr>
				<th width="25%">执行方法:</th>
				<td width="74%"><input title="执行方法"
					class="form-control input-sm" type="text" name="exemethods"
					id="exemethods" /></td>
			</tr>
			<tr>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/console/rowdataauthorization/sysdbsubject/js/SysDbSubject.js" type="text/javascript"></script>
<script src="avicit/platform6/console/rowdataauthorization/sysdbsubject/js/SysDbEntity.js" type="text/javascript"></script>
<script type="text/javascript">
	var sysDbSubject;
	var sysDbEntity;
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="sysDbEntity.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function unformatValue(cellvalue, options, rowObject) {
		return cellvalue;
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="sysDbEntity.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}

	 function orgElem(value, options) {
		var rowId = options.rowId;
		var forId = options.forId;
		var v_isShowVoid = options.isShowVoid;
		var v_viewScope = options.viewScope;
		var v_defaultOrgId = options.defaultOrgId;
		var rowData = $(this).jqGrid('getRowData', rowId);
		var elem = $('<div id = "orgselect" class="input-group input-group-sm">'
				+ '<input type="hidden" id="cellRowId" value="'+ rowId +'">'
				+ '<input type="hidden" id="cellForId" value="'+ forId +'">'
				+ '<input type="hidden" id="cellUserid" value="'+ rowData[forId] +'">'
				+ '<input class="form-control" placeholder="请选择组织" type="text" id="cellUseridAlias" value="'+ value +'">'
				+ '<span class="input-group-addon">'
				+ '<i class="glyphicon glyphicon-user"></i>' + '</span>'
				+ '</div>');
		var inputFocusFunction = function(){
		    $('#cellUseridAlias').focus();
	    };
		elem.find('#cellUseridAlias, .input-group-addon').on('click',
				function(e) {
					var id = this.parentElement.id;
					new H5OrgSelect({
						idFiled:'cellUserid',
						textFiled:'cellUseridAlias',
						divid: id,
						//selectModel:'multi',
						//type : 'orgSelect',
						type : 'groupSelect',
						contentWidth : '300'
					});
				    this.blur();
				    nullInput(e);
					
			});
			new H5OrgSelect({
				idFiled:'cellUserid',
				textFiled:'cellUseridAlias',
				divid: this.id,
				//selectModel:'multi',
				//type : 'orgSelect',
				type : 'groupSelect',
				contentWidth : '300'
			});
			return elem[0];
	};


	function orgValue(elem, operation, value) {
		if (operation === 'get') {
			var rowId = $(elem).find('#cellRowId').val();
			var forId = $(elem).find('#cellForId').val();
			var userId = $(elem).find('#cellUserid').val();
			var rowData = {};
			rowData[forId] = userId;
			$(this).jqGrid('setRowData', rowId, rowData);
			//return $(elem).find('#cellUseridAlias').val();
			if($(elem).find('#cellUseridAlias').val()===undefined){
				return "";
			}else{		
				return $(elem).find('#cellUseridAlias').val();
			}
		} else if (operation === 'set') {
			$(elem).find('#cellUseridAlias').val(value);
		}
	};
	//自己的数据
	function pream1Box(cellvalue, options, rowObject){
		if(rowObject.pream1 == "1"){
			return '<div style="position:relative"><input type="checkbox" class="pream1"  style="position:absolute;top:75%;left:40%" checked="checked"></div>';
		}else {
			return '<div style="position:relative"><input type="checkbox" class="pream1"  style="position:absolute;top:75%;left:40%" ></div>';
		}
	}
	//获取自己数据是否选中的值
	function unpream1Box(cellvalue, options, rowObject){
		var chooseId = "#" + options.rowId + " "+".pream1";
		if($($(chooseId)[0]).is(":checked")){
			return "1";
		}else{
			return "0";}	
	}	  
	//自己部门数据
	function pream2Box(cellvalue, options, rowObject){
		if(rowObject.pream2 == "1"){
			return '<div style="position:relative"><input type="checkbox" class="pream2" style="position:absolute;top:75%;left:40%" checked="checked"></div>';
		}else {
			return '<div style="position:relative"><input type="checkbox" class="pream2" style="position:absolute;top:75%;left:40%" ></div>';
		}
	}
	//获取自己部门数据是否选中
	function unpream2Box(cellvalue, options, rowObject){
		var chooseId = "#" + options.rowId + " "+".pream2";
		if($($(chooseId)[0]).is(":checked")){
			return "1";
		}else{
			return "0";}	
	}
    //自己组织数据
    function pream10Box(cellvalue, options, rowObject){
        if(rowObject.pream10 == "1"){
            return '<div style="position:relative"><input type="checkbox" class="pream10" style="position:absolute;top:75%;left:40%" checked="checked"></div>';
        }else {
            return '<div style="position:relative"><input type="checkbox" class="pream10" style="position:absolute;top:75%;left:40%" ></div>';
        }
    }
    //获取自己数据是否选中
    function unpream10Box(cellvalue, options, rowObject){
        var chooseId = "#" + options.rowId + " "+".pream10";
        if($($(chooseId)[0]).is(":checked")){
            return "1";
        }else{
            return "0";}
    }
    //自己组织数据
    function pream11Box(cellvalue, options, rowObject){
        if(rowObject.pream11 == "1"){
            return '<div style="position:relative"><input type="checkbox" class="pream11" style="position:absolute;top:75%;left:40%" checked="checked"></div>';
        }else {
            return '<div style="position:relative"><input type="checkbox" class="pream11" style="position:absolute;top:75%;left:40%" ></div>';
        }
    }
    //获取自己组织数据是否选中
    function unpream11Box(cellvalue, options, rowObject){
        var chooseId = "#" + options.rowId + " "+".pream11";
        if($($(chooseId)[0]).is(":checked")){
            return "1";
        }else{
            return "0";}
    }
	//应用数据密级权限
	function pream9Box(cellvalue, options, rowObject){
		if(rowObject.pream9 == "1"){
			return '<div style="position:relative"><input type="checkbox" class="pream9"   style="position:absolute;top:75%;left:40%" checked="checked"></div>';
		}else {
			return '<div style="position:relative"><input type="checkbox" class="pream9"  style="position:absolute;top:75%;left:40%" ></div>';
		}
	}
	//应用数据密级权限
	function unpream9Box(cellvalue, options, rowObject){
		var chooseId = "#" + options.rowId + " "+".pream9";
		if($($(chooseId)[0]).is(":checked")){
			return "1";
		}else{
			return "0";}	
	}	 
    function formatSearch(cellvalue, options, rowObject){
      return '<a href="javascript:void(0);" onclick="sysDbEntity.detailRela(\''
				+ rowObject.id + '\');">查看</a>';
    }
 
	
    var pId="";
    var type="";
    var typeId="";
	$(document).ready(function() {
		var searchSubNames = new Array();
		var searchSubTips = new Array();
		searchSubNames.push("tableName");
		searchSubTips.push("表名称");
		searchSubNames.push("tableComments");
		searchSubTips.push("表描述");
		var searchSubC = searchSubTips.length == 2 ? '或'
				+ searchSubTips[1] : "";
		$('#sysDbEntity_keyWord').attr('placeholder',
				'请输入' + searchSubTips[0] + searchSubC);
		var sysDbEntityGridColModel = [ {label : 'id',name : 'id',key : true,width : 75,hidden : true}, 
		                                {label : '表名称',name : 'tableName',width : 150,formatter : formatValue,unformat:unformatValue},
		                                {label : '表描述',name : 'tableComments',width : 150,formatter : formatValue,unformat:unformatValue},
		                                {label : '表对应mapper.xml',name : 'mapperForTab',width : 150,hidden : true}, 
		                                {label : '应用ID',name : 'sysApplicationId',width : 150,hidden : true},
		                                {label : '组织',name : 'orgIdentity',width : 150,hidden : true},
		                                {label : 'mapper.xml方法id',name : 'exemethods',width : 150,hidden : true},
		                                {label : '分类ID',name : 'subjectid',width : 150,hidden : true},
		                                {label : '创建者数据',name : 'pream1',width : 150,formatter:pream1Box,unformat:unpream1Box}, 
										{label : '部门数据 ',name : 'pream2',width : 150,formatter:pream2Box,unformat:unpream2Box},
            							{label : '组织数据 ',name : 'pream10',width : 150,formatter:pream10Box,unformat:unpream10Box},
            							{label : '组织应用数据 ',name : 'pream11',width : 150,formatter:pream11Box,unformat:unpream11Box},
            							{label : '下级部门数据 ',name : 'pream3',width : 150,editable:true, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:0,max:9,step:1,precision:0}},
										{label : '上级部门数据',name : 'pream4',width : 150, editable:true, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:0,max:9,step:1,precision:0}},
										{label : '指定组织的数据id',name : 'pream5',width : 75,hidden : true,editable : true},
										{label : '指定组织的数据',name : 'pream5Alias',width : 150,hidden : true,editable : true,edittype : "custom",editoptions : {custom_element : orgElem,custom_value : orgValue,forId : 'pream5' }}, 
										{label : '指定部门数据',name : 'pream6Alias',width : 150,editable : true,edittype : 'custom',editoptions : {custom_element : deptElem,custom_value : deptValue,forId : 'pream6',selectModel : 'multi'}}, 
										{label : '指定部门的数据id',name : 'pream6',width : 75,hidden : true,editable : true},
										{label : '指定用户数据',name : 'pream7Alias',width : 150,editable : true,edittype : 'custom',editoptions : {custom_element : userElem,custom_value : userValue,forId : 'pream7',selectModel : 'multi'}}, 
										{label : '指定用户的数据id',name : 'pream7',width : 75,hidden : true,editable : true}, 
										{label : '自定义扩展',name : 'pream8',width : 150,editable : true,edittype : 'text'},
										{label : '密级权限控制',name : 'pream9',width : 150,formatter:pream9Box,unformat:unpream9Box},
										{label : '执行顺序号 ',name : 'weight',width : 150,editable:true, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:0,max:99,step:1,precision:0}},
										{label : '权限明细信息',name : 'ce',width : 150,formatter:formatSearch,align:'center'}
		                                ];

		sysDbSubject = new SysDbSubject('treeDemo', '${url}',
				"form", "txt", 'searchbtns', function(pid) {
					sysDbEntity = new SysDbEntity(
							'sysDbEntity', '${surl}',
							"formSub", sysDbEntityGridColModel,
							'searchDialogSub', pid,
							searchSubNames,
							"sysDbEntity_keyWord");
				}, function(pid) {
					pId=pid;
					sysDbEntity.reLoad(pid,type,typeId);
				});
		//主表操作
		//添加平级节点按钮绑定事件
		$('#sysDbSubject_insert').bind('click', function() {
			hideRMenu();
			sysDbSubject.insert();
		});
		//添加子节点按钮绑定事件
		$('#sysDbSubject_insertsub').bind('click', function() {
			hideRMenu();
			sysDbSubject.insertSub();
		});
		//编辑按钮绑定事件
		$('#sysDbSubject_modify').bind('click', function() {
			hideRMenu();
			sysDbSubject.modify();
		});
		//删除按钮绑定事件
		$('#sysDbSubject_del').bind('click', function() {
			hideRMenu();
			sysDbSubject.del();
		});

		//子表操作
		//添加按钮绑定事件
		$('#sysDbEntity_insert').bind('click', function() {
			sysDbEntity.insert();
		});
		//编辑按钮绑定事件
		$('#sysDbEntity_modify').bind('click', function() {
			sysDbEntity.modify();
		});
		//删除按钮绑定事件
		$('#sysDbEntity_del').bind('click', function() {
			sysDbEntity.del();
		});
		//保存按钮绑定事件
		$('#sysDbrelationshipSave').bind('click', function() {
			sysDbEntity.dbRelationshipSave();
		});
		//打开高级查询
		$('#sysDbEntity_searchAll').bind('click',function() {
			sysDbEntity.openSearchForm(this,$('#sysDbEntity'));
		});
		//关键字段查询按钮绑定事件
		$('#sysDbEntity_searchPart').bind('click', function() {
			sysDbEntity.searchByKeyWord();
		});
		
	});
	
	$(function(){
		var ifrm={
				  'iframe1':'avicit/platform6/console/rowdataauthorization/sysdbsubject/role.jsp',
				  'iframe2':'avicit/platform6/console/rowdataauthorization/sysdbsubject/dep.jsp',
				  'iframe3':'avicit/platform6/console/rowdataauthorization/sysdbsubject/group.jsp',
				  'iframe4':'avicit/platform6/console/rowdataauthorization/sysdbsubject/positions.jsp',
				  'iframe5':'avicit/platform6/console/rowdataauthorization/sysdbsubject/users.jsp',
			      'iframe6':'avicit/platform6/console/rowdataauthorization/sysdbsubject/org.jsp'};


		$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
			
		  	if(!$('#'+e.target.rel).attr('src')){
		  		$('#'+e.target.rel).attr('src',ifrm[e.target.rel]);
		  	}else{
			  	if(window.frames[e.target.rel].bpm_operator_refresh){
			  		window.frames[e.target.rel].bpm_operator_refresh();
				 }
			  	}
		  	var type = $("#myTabContent .active").children().attr("val");
		  	sysDbEntity.reLoad(pId,type,typeId);
		 });
	})
</script>
</html>