<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "exam/portalprogram/portalProgramController/toPortalProgramManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style type="text/css">
#t_programRalationR, #t_programRalationD, #t_programRalationU {
	display: none
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div
		data-options="region:'center',onResize:function(a){$('#portalProgram').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_portalProgram" class="toolbar">

			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 125px">
					<input type="text" name="portalProgram_keyWord"
						id="portalProgram_keyWord" style="width: 125px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="portalProgram_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<!-- 				<div class="input-group-btn form-tool-searchbtn">
					<a id="portalProgram_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div> -->
			</div>
		</div>
		<table id="portalProgram"></table>
		<div id="portalProgramPager"></div>
	</div>
	<div
		data-options="region:'east',split:true,width:fixwidth(.5),onResize:function(a){$('#programRalation').setGridWidth(a);$(window).trigger('resize');}">
		<ul id="myTab" class="nav nav-tabs">
			<li class="active"><a rel='R' href="#role" id="bottonR"
				data-toggle="tab">角色</a></li>
			<li><a rel='U' href="#user" id="bottonU" data-toggle="tab">用户</a></li>
			<li><a rel='D' href="#dept" id="bottonD" data-toggle="tab">部门</a></li>
		</ul>
		<div id="toolbar_programRalation" class="tab-content">
			<div class="tab-pane fade in active" id="role">
				<div id="tableToolbarR" class="toolbar">
					<div class="toolbar-left">
						<a id="addR" href="javascript:void(0)"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="添加角色"><i class="icon icon-add"></i>添加</a> <a id="delR"
							href="javascript:void(0)"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="删除角色授权"><i class="icon icon-delete"></i>删除</a>
					</div>
					<!-- <div class="toolbar-right">
						<div class="input-group form-tool-search">
							<input type="text" name="keyWord" id="keyWordR"
								style="width: 240px;" class="form-control input-sm"
								placeholder="输入名称查询"> <label id="keyWordLableR"
								class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div> -->
				</div>
				<table id="programRalationR"></table>
				<div id="programRalationRPager"></div>

			</div>

			<div class="tab-pane fade" id="user">
				<div id="tableToolbarU" class="toolbar">
					<div class="toolbar-left">
						<a id="addU" href="javascript:void(0)"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="添加用户"><i class="icon icon-add"></i>添加</a> <a id="delU"
							href="javascript:void(0)"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="删除用户授权"><i class="icon icon-delete"></i>删除</a>
					</div>
					<!-- <div class="toolbar-right">
						<div class="input-group form-tool-search">
							<input type="text" name="keyWord" id="keyWordU"
								style="width: 240px;" class="form-control input-sm"
								placeholder="名称"> <label id="keyWordLableU"
								class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div> -->
				</div>
				<table id="programRalationU"></table>
				<div id="programRalationUPager"></div>

			</div>

			<div class="tab-pane fade" id="dept">
				<div id="tableToolbarD" class="toolbar">
					<div class="toolbar-left">
						<a id="addD" href="javascript:void(0)"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="添加部门"><i class="icon icon-add"></i>添加</a> <a id="delD"
							href="javascript:void(0)"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="删除部门授权"><i class="icon icon-delete"></i>删除</a>
					</div>
					<!-- <div class="toolbar-right">
						<div class="input-group form-tool-search">
							<input type="text" name="keyWord" id="keyWordD"
								style="width: 240px;" class="form-control input-sm"
								placeholder="名称"> <label id="keyWordLableD"
								class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div> -->
				</div>
				<table id="programRalationD"></table>
				<div id="programRalationDPager"></div>

			</div>
		</div>
	</div>
	<div>
		<form id='formRalation'>
			<input type="hidden" name="id" /> <input type="hidden"
				name="programId" id="programId" /> <input type="hidden"
				name="proRalaType" id="proRalaType" /> <input type="hidden"
				name="proRalaObjectId" id="proRalaObjectId" />
		</form>
	</div>
</body>
<!-- <!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form">
		<table class="form_commonTable">
			<tr>
				<th width="10%">应用名称:</th>
				<td width="39%"><input title="应用名称"
					class="form-control input-sm" type="text" name="programName"
					id="programName" /></td>
				<th width="10%">应用代码:</th>
				<td width="39%"><input title="应用代码"
					class="form-control input-sm" type="text" name="programCode"
					id="programCode" /></td>
			</tr>
			<tr>
				<th width="10%">应用图标上传:</th>
				<td width="39%"><input title="应用图标上传"
					class="form-control input-sm" type="text" name="programImg"
					id="programImg" /></td>
				<th width="10%">负责人（多选）:</th>
				<td width="39%"><input title="负责人（多选）"
					class="form-control input-sm" type="text"
					name="programResponsibles" id="programResponsibles" /></td>
			</tr>
			<tr>
				<th width="10%">应用程序描述:</th>
				<td width="39%"><input title="应用程序描述"
					class="form-control input-sm" type="text" name="programDesc"
					id="programDesc" /></td>
				<th width="10%">应用程序状态:</th>
				<td width="39%"><input title="应用程序状态"
					class="form-control input-sm" type="text" name="programState"
					id="programState" /></td>
			</tr>
			<tr>
			</tr>
		</table>
	</form>
</div>
<!-- 子表高级查询
<div id="selectR" style="overflow: auto; display: none">
	<div id="searchBarR" class="toolbar">
		<div class="toolbar-right" style="margin-right: 10px;">
			<div class="input-group form-tool-search">
				<input type="text" name="keyWord" id="keyWordRole"
					style="width: 240px;" class="form-control input-sm"
					placeholder="角色名称"> <label id="keyWordRoleL"
					class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
	</div>
	<table id="jqGridRole"></table>
	<div id="jqGridPagerR"></div>
</div>
<div id="selectU" style="overflow: auto; display: none">
	<div id="searchBarU" class="toolbar">
		<div class="toolbar-right" style="margin-right: 10px;">
			<div class="input-group form-tool-search">
				<input type="text" name="keyWord" id="keyWordUser"
					style="width: 240px;" class="form-control input-sm"
					placeholder="名称"> <label id="keyWordUserL"
					class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
	</div>
	<table id="jqGridUser"></table>
	<div id="jqGridPagerU"></div>
</div>
<div id="selectD" style="overflow: auto; display: none">
	<div class="input-group  input-group-sm">
		<input class="form-control" placeholder="回车查询" type="text"
			id="searchDeptVal" name="txt"> <span class="input-group-btn">
			<button id="searchDept" class="btn btn-default" type="button">
				<span class="glyphicon glyphicon-search"></span>
			</button>
		</span>
	</div>
	<div>
		<ul id="deptTree" class="ztree"></ul>
	</div>
</div> -->
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script
	src="avicit/platform6/mobileportal/programauthoritymanage/js/PortalProgram.js"
	type="text/javascript"></script>
<script
	src="avicit/platform6/mobileportal/programauthoritymanage/js/ProgramRalation.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var portalProgram;
	var programRalation;
	var targetType = '3', userList, roleList, deptList;
	var outpid = "";

	function formatState(cellvalue, options, rowObject) {
		var thisState = rowObject.programState;
		if(thisState =="0"){
			return '启用';
		}else{
			return '禁用';
		}
	}
	/* 	function formatValue(cellvalue, options, rowObject) {
	 return '<a href="javascript:void(0);" onclick="portalProgram.detail(\''
	 + rowObject.id + '\');">' + cellvalue + '</a>';
	 }
	 function formatDateForHref(cellvalue, options, rowObject) {
	 var thisDate = format(cellvalue);
	 return '<a href="javascript:void(0);" onclick="portalProgram.detail(\''
	 + rowObject.id + '\');">' + thisDate + '</a>';
	 } */
	//更改子表对应类型
	function type(tp) {
		targetType = tp;
		clickMenu();
	}

	$(document).ready(
			function() {
				var searchMainNames = new Array();
				var searchMainTips = new Array();
				searchMainNames.push("programName");
				searchMainTips.push("应用名称");
				searchMainNames.push("programCode");
				searchMainTips.push("应用代码");
				var searchMainC = searchMainTips.length == 2 ? '或'
						+ searchMainTips[1] : "";
				$('#portalProgram_keyWord').attr('placeholder',
						'请输入' + searchMainTips[0] + searchMainC);

				var searchSubNames = new Array();
				var searchSubTips = new Array();
				searchSubNames.push("proRalaType");
				searchSubTips.push("PRO_RALA_TYPE");
				searchSubNames.push("proRalaObjectId");
				searchSubTips.push("PRO_RALA_OBJECT_ID");
				var searchSubC = searchSubTips.length == 2 ? '或'
						+ searchSubTips[1] : "";
				$('#programRalation_keyWord').attr('placeholder',
						'请输入' + searchSubTips[0] + searchSubC);

				var portalProgramGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '应用名称',
					name : 'programName',
					width : 150
				//formatter : formatValue
				}, {
					label : '应用代码',
					name : 'programCode',
					width : 150
				}/* , {
					label : '应用图标上传',
					name : 'programImg',
					width : 150,
					hidden : true
				}, {
					label : '负责人（多选）',
					name : 'programResponsiblesAlias',
					width : 150,
					hidden : true
				}, {
					label : '应用程序描述',
					name : 'programDesc',
					width : 150,
					hidden : true
				}*/, {
					label : '应用程序状态',
					name : 'programState',
					formatter : formatState,
					width : 150
				} ];
				/* var programRalationGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : 'PRO_RALA_TYPE',
					name : 'proRalaType',
					width : 150
				}, {
					label : 'PRO_RALA_OBJECT_ID',
					name : 'proRalaObjectId',
					width : 150
				}, {
					label : 'PROGRAM__ID',
					name : 'programId',
					width : 150
				} ];
				 */
				portalProgram = new PortalProgram('portalProgram', '${ssurl}',
						'form', portalProgramGridColModel, 'searchDialog',
						function(pid) {
							var pid = pid;
							if (outpid == "") {
								outpid = pid;
							} else {
								outpid = outpid;
							}

							clickMenu = function() {
								switch (targetType) {
								case '3': {
									if (!roleList) {
										var programRalationGridColModelR = [ {
											label : 'id',
											name : 'id',
											key : true,
											width : 75,
											hidden : true
										}, {
											label : '角色名称',
											name : 'attribute01',
											width : 160,
											sortable : false,
											align : 'center'
										}, {
											label : '角色编号',
											name : 'attribute02',
											width : 160,
											sortable : false,
											align : 'center'
										}, {
											label : '角色描述',
											name : 'attribute03',
											width : 180,
											sortable : false,
											align : 'center'
										}, {
											label : '创建人',
											name : 'createdBy',
											width : 100,
											sortable : false,
											align : 'center'
										} ];
										programRalationR = new ProgramRalation(
												'programRalationR',
												'${sssurl}', '3',
												programRalationGridColModelR,
												'searchDialogSub', outpid,
												searchSubNames,
												"programRalation_keyWord");
										break;
									}
									programRalationR.reLoad(pid)

									break;
								}

								case '2': {
									if (!userList) {
										var programRalationGridColModelU = [ {
											label : 'id',
											name : 'id',
											key : true,
											width : 75,
											hidden : true
										}, {
											label : '姓名',
											name : 'attribute01',
											width : 162	,
											sortable : false,
											align : 'center'
										}, {
											label : '人员编号',
											name : 'attribute02',
											width : 162,
											sortable : false,
											align : 'center'
										}, {
											label : '登录名',
											name : 'attribute03',
											width : 162,
											sortable : false,
											align : 'center'
										}, {
											label : '部门',
											name : 'attribute04',
											width : 158,
											sortable : false,
											align : 'center'
										} ];
										programRalationU = new ProgramRalation(
												'programRalationU',
												'${sssurl}', '2',
												programRalationGridColModelU,
												'searchDialogSub', outpid,
												searchSubNames,
												"programRalation_keyWord");
										break;
									}
									programRalationU.reLoad(pid)

									break;
								}
								case '1': {
									if (!deptList) {
										var programRalationGridColModelD = [ {
											label : 'id',
											name : 'id',
											key : true,
											width : 75,
											hidden : true
										}, {
											label : '部门名称',
											name : 'attribute01',
											width : 162,
											sortable : false,
											align : 'center'
										}, {
											label : '部门编号',
											name : 'attribute02',
											width : 162,
											sortable : false,
											align : 'center'
										}, {
											label : '创建人',
											name : 'createdBy',
											width : 162,
											sortable : false,
											align : 'center'
										}, {
											label : '创建时间',
											name : 'attribute03',
											width : 162,
											sortable : false,
											align : 'center'
										} ];
										programRalationD = new ProgramRalation(
												'programRalationD',
												'${sssurl}', '1',
												programRalationGridColModelD,
												'searchDialogSub', outpid,
												searchSubNames,
												"programRalation_keyWord");
										break;
									}
									programRalationD.reLoad(pid)
									break;
								}
								default: {
								}

								}
							}
							clickMenu();
							/* programRalation = new ProgramRalation(
									'programRalation', '${sssurl}', "formSub",
									programRalationGridColModel,
									'searchDialogSub', pid, searchSubNames,
									"programRalation_keyWord"); */
						}, function(pid) {

							outpid = pid;
							if (typeof programRalationR.deptList != "undefined") {
								programRalationR.reLoad(pid);
							}
							if (typeof programRalationU.deptList != "undefined") {
								programRalationU.reLoad(pid);
							}
							if (typeof programRalationD.deptList != "undefined") {
								programRalationD.reLoad(pid);
							}
						}, searchMainNames, "portalProgram_keyWord");

				//主表操作
				//添加按钮绑定事件
				$('#portalProgram_insert').bind('click', function() {
					portalProgram.insert();
				});
				//编辑按钮绑定事件
				$('#portalProgram_modify').bind('click', function() {
					portalProgram.modify();
				});
				//删除按钮绑定事件
				$('#portalProgram_del').bind('click', function() {
					portalProgram.del();
				});
				//打开高级查询框
				$('#portalProgram_searchAll').bind('click', function() {
					portalProgram.openSearchForm(this, $('#portalProgram'));
				});
				//关键字段查询按钮绑定事件
				$('#portalProgram_searchPart').bind('click', function() {
					portalProgram.searchByKeyWord();
				});
				//子表操作
				//添加按钮绑定事件
				$('#programRalation_insert').bind('click', function() {
					programRalation.insert();
				});
				//编辑按钮绑定事件
				$('#programRalation_modify').bind('click', function() {
					programRalation.modify();
				});

				//角色按钮绑定事件
				$('#bottonR').bind('click', function() {
					type('3');
				});
				//用户按钮绑定事件
				$('#bottonU').bind('click', function() {
					type('2');
				});
				//部门按钮绑定事件
				$('#bottonD').bind('click', function() {
					type('1');
				});
				//打开高级查询
				$('#programRalation_searchAll').bind(
						'click',
						function() {
							programRalation.openSearchForm(this,
									$('#programRalation'));
						});
				//关键字段查询按钮绑定事件
				$('#programRalation_searchPart').bind('click', function() {
					programRalation.searchByKeyWord();
				});

				//角色
				$('#addR').bind(
						'click',
						function(e) {
							new H5CommonSelect({
								type : 'roleSelect',
								selectModel : 'multi',
								idFiled : 'programResponsibles',
								textFiled : '',
								viewScope : 'currentOrg',
								callBack : function(programResponsibles) {
									var roleids = programResponsibles.roleids;
									programRalationR.save($('#formRalation'),
											roleids, '3');
								}
							});
						});

				$('#addU').bind(
						'click',
						function(e) {
							new H5CommonSelect({
								type : 'userSelect',
								selectModel : 'multi',
								idFiled : 'programResponsibles',
								textFiled : '',
								viewScope : 'currentOrg',
								callBack : function(programResponsibles) {
									var userids = programResponsibles.userids;
									programRalationU.save($('#formRalation'),
											userids, '2');
								}
							});
						});

				$('#addD').bind(
						'click',
						function(e) {
							new H5CommonSelect({
								type : 'deptSelect',
								selectModel : 'multi',
								idFiled : 'programResponsibles',
								textFiled : '',
								viewScope : 'currentOrg',
								callBack : function(programResponsibles) {
									var deptids = programResponsibles.deptids;
									programRalationD.save($('#formRalation'),
											deptids, '1');
								}
							});
						});
				//删除按钮绑定事件
				$('#delR').bind('click', function() {
					programRalationR.del();
				});
				$('#delU').bind('click', function() {
					programRalationU.del();
				});
				$('#delD').bind('click', function() {
					programRalationD.del();
				});
			});
</script>
</html>