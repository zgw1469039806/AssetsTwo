<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
	<head>
		<!-- ControllerPath = "assets/device/documentpackage/documentPackageController/toDocumentPackageManage" -->
		<title>管理</title>
		<base href="<%=ViewUtil.getRequestPath(request)%>">
		<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
			<jsp:param value="<%=importlibs%>" name="importlibs"/>
		</jsp:include>
	</head>

	<body class="easyui-layout" fit="true">
		<!-- 主表 -->
		<div id="panelnorth"
			 data-options="region:'north',onResize:function(a){$('#documentPackage').setGridWidth(a);$('#documentPackage').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
			<div id="toolbar_documentPackage" class="toolbar">
				<div class="toolbar-left">
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_documentPackage_button_add" permissionDes="主表添加">
						<a id="documentPackage_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="添加">
							<i class="fa fa-plus"></i> 添加
						</a>
					</sec:accesscontrollist>
				</div>
				<div class="toolbar-right">
					<div class="input-group form-tool-search" style="width:125px">
						<input type="text" name="documentPackage_keyWord" id="documentPackage_keyWord" style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
						<label id="documentPackage_searchPart" class="icon icon-search form-tool-searchicon"></label>
					</div>
					<div class="input-group-btn form-tool-searchbtn">
						<a id="documentPackage_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">
							高级查询<span class="caret"></span>
						</a>
					</div>
				</div>
			</div>
			<table id="documentPackage"></table>
			<div id="documentPackagePager"></div>
		</div>

		<!-- 子表 -->
		<div id="centerpanel"
			 data-options="region:'center',split:true,onResize:function(a){$('#document').setGridWidth(a); $('#document').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
			<div id="toolbar_documentItem" class="toolbar">
				<div class="toolbar-left">
					<a id="documentItem_relate" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="关联">
						<i class="fa fa-plus"></i>关联
					</a>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_documentItem_button_add" permissionDes="子表添加">
						<a id="documentItem_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="添加">
							<i class="fa fa-plus"></i> 添加
						</a>
					</sec:accesscontrollist>
				</div>
				<div class="toolbar-right">
					<div class="input-group form-tool-search" style="width:125px">
						<input type="text" name="documentItem_keyWord" id="documentItem_keyWord" style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
						<label id="documentItem_searchPart" class="icon icon-search form-tool-searchicon"></label>
					</div>
					<div class="input-group-btn form-tool-searchbtn" style="display:none;">
						<a id="documentItem_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">
							高级查询<span class="caret"></span>
						</a>
					</div>

					<!-- 页面右上角视图切换框-->
					<div class="input-group form-tool-search" style="width:130px;">
						<input type="text" name="tableViewSelect" id="tableViewSelect" style="width:120px;" class="form-control input-sm" readonly value="${documentViewList.get(0)}">
					</div>
				</div>
			</div>
			<table id="documentItem"></table>
			<div id="documentItemPager"></div>
		</div>
	</body>

	<!-- 主表高级查询 -->
	<div id="searchDialog" style="overflow: auto;display: none">
		<form id="form">
			<table class="form_commonTable">
				<tr>
					<th width="10%">文档包名称:</th>
					<td width="15%">
						<input title="文档包名称" class="form-control input-sm" type="text" name="packageName" id="packageName"/>
					</td>
					<th width="10%">创建人:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="createdBy" name="createdBy">
							<input class="form-control" placeholder="请选择用户" type="text" id="createdByAlias" name="createdByAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
					<th width="10%">创建部门:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="createdByDept" name="createdByDept">
							<input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias">
							<span class="input-group-addon">
							<i class="glyphicon glyphicon-equalizer"></i>
						</span>
						</div>
					</td>
					<th width="10%">文档包描述:</th>
					<td width="15%">
						<input title="文档包描述" class="form-control input-sm" type="text" name="packageDescribe" id="packageDescribe"/>
					</td>
				</tr>
				<tr>
					<th width="10%">创建时间(从):</th>
					<td width="15%">
						<div class="input-group input-group-sm">
							<input class="form-control date-picker" type="text" name="creationDateBegin" id="creationDateBegin"/>
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
					<th width="10%">创建时间(至):</th>
					<td width="15%">
						<div class="input-group input-group-sm">
							<input class="form-control date-picker" type="text" name="creationDateEnd" id="creationDateEnd"/>
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<!-- 子表高级查询 -->
	<div id="searchDialogSub" style="overflow: auto;display: none">
		<form id="formSub">
			<input type="hidden" name="deptid" id="deptid"/>
			<table class="form_commonTable">
				<tr>
					<th width="10%">创建部门:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="createdByDeptSub" name="createdByDept">
							<input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAliasSub" name="createdByDeptAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-equalizer"></i>
							</span>
						</div>
					</td>
					<th width="10%">文档名称:</th>
					<td width="15%">
						<input title="文档名称" class="form-control input-sm" type="text" name="documentName" id="documentName"/>
					</td>
					<th width="10%">文档类型:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden"  id="documentType" name="documentType" types="selectLookup">
							<input class="form-control" placeholder="请选择文档类型" type="text" id="documentTypeNames" name="documentTypeNames"  types="selectLookup" lookupCode="PLATFORM_FILE_TYPE" readonly>
						</div>
					</td>
					<th width="10%">文档分类:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden"  id="documentCategory" name="documentCategory" types="selectLookup">
							<input class="form-control" placeholder="请选择文档分类" type="text" id="documentCategoryNames" name="documentCategoryNames"  types="selectLookup" lookupCode="PLATFORM_FILE_CATEGORY" readonly>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%">生命阶段:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden"  id="lifeStage" name="lifeStage" types="selectLookup">
							<input class="form-control" placeholder="请选择生命阶段" type="text" id="lifeStageNames" name="lifeStageNames"  types="selectLookup" lookupCode="PLATFORM_FILE_LIFE_STAGE" readonly>
						</div>
					</td>
					<th width="10%">作者:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="documentAuthor" name="documentAuthor">
							<input class="form-control" placeholder="请选择用户" type="text" id="documentAuthorAlias" name="documentAuthorAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
					<th width="10%">作者所在部门:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="authorDept" name="authorDept">
							<input class="form-control" placeholder="请选择部门" type="text" id="authorDeptAlias" name="authorDeptAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-equalizer"></i>
							</span>
						</div>
					</td>
					<th width="10%">关键字:</th>
					<td width="15%">
						<input title="关键字" class="form-control input-sm" type="text" name="keyWord" id="keyWord"/>
					</td>
				</tr>
				<tr>
					<th width="10%">文档版本:</th>
					<td width="15%">
						<input title="文档版本" class="form-control input-sm" type="text" name="currentVersion" id="currentVersion"/>
					</td>
					<th width="10%">更新前版本:</th>
					<td width="15%">
						<input title="更新前版本" class="form-control input-sm" type="text" name="lastVersion" id="lastVersion"/>
					</td>
					<th width="10%">文档状态:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden"  id="documentState" name="documentState" types="selectLookup">
							<input class="form-control" placeholder="请选择文档状态" type="text" id="documentStateNames" name="documentStateNames"  types="selectLookup" lookupCode="PLATFORM_FILE_STATE" readonly>
						</div>
					</td>
					<th width="10%">语言类别:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden"  id="languageCategory" name="languageCategory" types="selectLookup">
							<input class="form-control" placeholder="请选择语言类别" type="text" id="languageCategoryNames" name="languageCategoryNames"  types="selectLookup" lookupCode="PLATFORM_LANGUAGE_CATEGORY" readonly>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%">文档密级:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden"  id="secretLevel" name="secretLevel" types="selectLookup">
							<input class="form-control" placeholder="请选择文档密级" type="text" id="secretLevelNames" name="secretLevelNames"  types="selectLookup" lookupCode="SECRET_LEVEL" readonly>
						</div>
					</td>
					<th width="10%">文档摘要:</th>
					<td width="15%">
						<textarea class="form-control input-sm" rows="3" title="文档摘要" name="documentAbstract" id="documentAbstract"></textarea>
					</td>
					<th width="10%">文档描述:</th>
					<td width="15%">
						<textarea class="form-control input-sm" rows="3" title="文档描述" name="documentDescribe" id="documentDescribe"></textarea>
					</td>
					<th width="10%">责任人:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="personLiable" name="personLiable">
							<input class="form-control" placeholder="请选择用户" type="text" id="personLiableAlias" name="personLiableAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%">参与人:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="participants" name="participants">
							<input class="form-control" placeholder="请选择用户" type="text" id="participantsAlias" name="participantsAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
					<th width="10%">更新人:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="documentUpdateBy" name="documentUpdateBy">
							<input class="form-control" placeholder="请选择用户" type="text" id="documentUpdateByAlias" name="documentUpdateByAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
					<th width="10%">更新时间(从):</th>
					<td width="15%">

					</td>
					<th width="10%">更新时间(至):</th>
					<td width="15%">
						<div class="input-group input-group-sm">
							<input class="form-control date-picker" type="text" name="documentUpdateDateEnd" id="documentUpdateDateEnd"/>
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%">所属项目:</th>
					<td width="15%">
						<input title="所属项目" class="form-control input-sm" type="text" name="belongProject" id="belongProject"/>
					</td>
					<th width="10%">文档仓库目录:</th>
					<td width="15%">
						<input title="文档仓库目录" class="form-control input-sm" type="text" name="warehouseCatelog" id="warehouseCatelog"/>
					</td>
					<th width="10%">知悉范围:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="knowScope" name="knowScope">
							<input class="form-control" placeholder="请选择群组" type="text" id="knowScopeAlias" name="knowScopeAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-equalizer"></i>
							</span>
						</div>
					</td>
					<th width="10%">文档标签:</th>
					<td width="15%">
						<input title="文档标签" class="form-control input-sm" type="text" name="documentLabel" id="documentLabel"/>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<!-- 视图选择弹框——开始 -->
	<div id="selectViewDialog" style="overflow: auto;display: none">
		<table class="ui-jqgrid-btable ui-common-table table table-bordered" style="width: 140px;">
			<tbody id="selectViewTbody">
			<c:forEach var="index" begin="0" end="${documentViewList.size()-1}" step="1">
				<c:if test="${documentViewList.get(index) != '系统默认视图'}">
					<tr>
						<td role="gridcell" onclick="switchView('${documentViewList.get(index)}')" title="${documentViewList.get(index)}">
								${documentViewList.get(index)}
						</td>
						<td>
							<i class="fa fa-file-text-o" onclick="editView('${documentViewList.get(index)}')" title="编辑视图"></i>
							<i class="fa fa-trash-o" onclick="delView('${documentViewList.get(index)}')" title="删除视图"></i>
						</td>
					</tr>
				</c:if>
			</c:forEach>
			<tr>
				<td role="gridcell" onclick="addView()" title="创建新视图">
					创建新视图
				</td>
				<td>
					<i class="fa fa-plus" onclick="addView()" title="创建视图"></i>
				</td>
			</tr>
			<tr>
				<td colspan="2" role="gridcell" onclick="switchView('系统默认视图')" title="系统默认视图">
					系统默认视图
				</td>
			</tr>
			</tbody>
		</table>
	</div>

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>

	<script src="avicit/assets/device/documentpackage/js/DocumentPackage.js" type="text/javascript"></script>
	<script src="avicit/assets/device/documentpackage/documentitem/js/DocumentItem.js" type="text/javascript"></script>

	<!-- 视图业务的js -->
	<script src="avicit/assets/device/usertablemodel/js/UserTableModel.js" type="text/javascript"></script>

	<script type="text/javascript">
		var userTableModel = new UserTableModel();//新增视图处理

		var documentPackage;
		var documentPackageGridColModel;
		var packageToolBar = document.getElementById('toolbar_documentPackage');
		var searchPackageNames = new Array();
		var searchPackageTips = new Array();

		var documentItem;
		var documentItemGridColModel;
		var itemToolBar = document.getElementById('toolbar_documentItem');
		var searchSubNames = new Array();
		var searchSubTips = new Array();

		function formatValue(cellvalue, options, rowObject) {
			return '<a href="javascript:void(0);" onclick="documentItem.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
		}

		/*视图管理模块函数——开始*/
		//切换列表视图
		function switchView(viewName){
			var paramList = [];
			paramList.push('DocumentItem');
			paramList.push(viewName);

			$.ajax({
				url : "assets/device/usertablemodel/userTableModelController/operation/get",
				data : JSON.stringify(paramList),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r){
					if (r.flag == "success"){
						documentItemGridColModel = r.dataGridColModelJson;
						documentItemGridColModel = JSON.parse(documentItemGridColModel);

						for(i=0; i<documentItemGridColModel.length; i++){
							if(documentItemGridColModel[i].formatter != undefined){
								if(documentItemGridColModel[i].formatter.indexOf('formatValue') > -1){
									documentItemGridColModel[i].formatter = formatValue;
								}
								else if(documentItemGridColModel[i].formatter.indexOf('format') > -1){
									documentItemGridColModel[i].formatter = format;
								}
							}
						}

						console.log(documentItemGridColModel);
						//清除列表后刷新
						var thePid = documentItem.pid;
						$.jgrid.gridUnload('documentItem');
						documentItem = new DocumentItem('documentItem', '${surl}', "formSub", documentItemGridColModel, 'searchDialogSub', thePid, searchSubNames, "documentItem_keyWord");

						SubAddHeaderSearch(documentItemGridColModel, 'documentItem', documentItem);	//添加表头搜索
						SubBuildDrag('documentItem', '${surl}', "formSub", documentItemGridColModel, 'searchDialogSub', thePid, searchSubNames, "documentItem_keyWord", documentItem, itemToolBar);//添加表头拖拽

						document.getElementById('tableViewSelect').value = viewName;
					}else{
						layer.alert('视图切换失败,请联系管理员：'+r.message, {
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

		//编辑视图
		function editView(viewName) {
			userTableModel.modify('DocumentItem', viewName);
		}

		//删除视图
		function delView(viewName) {
			var trEle = event.target.parentNode.parentNode;
			userTableModel.del('DocumentItem', viewName, trEle);
		}

		//创建新视图
		function addView(){
			userTableModel.insert('DocumentItem');
		}
		/*视图管理模块函数——结束*/

		$(document).ready(function () {
			/*主表参数配置——开始*/
			searchPackageNames.push("createdByDept");
			searchPackageTips.push("创建部门");

			searchPackageNames.push("packageName");
			searchPackageTips.push("文档包名称");

			var searchMainC = searchPackageTips.length == 2 ? '或' + searchPackageTips[1] : "";
			$('#documentPackage_keyWord').attr('placeholder', '请输入' + searchPackageTips[0] + searchMainC);

			documentPackageGridColModel = ${packageModelJson};
			for(i=0; i<documentPackageGridColModel.length; i++){
				if(documentPackageGridColModel[i].formatter != undefined){
					if(documentPackageGridColModel[i].formatter.indexOf('formatValue') > -1){
						documentPackageGridColModel[i].formatter = formatValue;
					}
					else if(documentPackageGridColModel[i].formatter.indexOf('format') > -1){
						documentPackageGridColModel[i].formatter = format;
					}
				}
			}
			/*主表参数配置——结束*/

			/*子表参数配置——开始*/
			searchSubNames.push("documentName");
			searchSubTips.push("文档名称");

			searchSubNames.push("keyWord");
			searchSubTips.push("关键字");

			var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
			$('#documentItem_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);

			documentItemGridColModel = ${documentModelJson};
			for(i=0; i<documentItemGridColModel.length; i++){
				if(documentItemGridColModel[i].formatter != undefined){
					if(documentItemGridColModel[i].formatter.indexOf('formatValue') > -1){
						documentItemGridColModel[i].formatter = formatValue;
					}
					else if(documentItemGridColModel[i].formatter.indexOf('format') > -1){
						documentItemGridColModel[i].formatter = format;
					}
				}
			}
			/*子表参数配置——结束*/

			documentPackage = new DocumentPackage('documentPackage', '${url}', 'form', documentPackageGridColModel, 'searchDialog',
				function (pid) {
					documentItem = new DocumentItem('documentItem', '${surl}', "formSub", documentItemGridColModel, 'searchDialogSub', pid, searchSubNames, "documentItem_keyWord");

					SubAddHeaderSearch(documentItemGridColModel, 'documentItem', documentItem);	//添加表头搜索
					SubBuildDrag('documentItem', '${surl}', "formSub", documentItemGridColModel, 'searchDialogSub', pid, searchSubNames, "documentItem_keyWord", documentItem, itemToolBar);//添加表头拖拽
				},
				function (pid) {
					documentItem.reLoad(pid);
				},
				searchPackageNames,
				"documentPackage_keyWord");

			AddHeaderSearch(documentPackageGridColModel, 'documentPackage', documentPackage);	//添加表头搜索
			BuildDrag('documentPackage', '${url}', 'form', documentPackageGridColModel, 'searchDialog', searchPackageNames, "documentPackage_keyWord", documentPackage, packageToolBar);//添加表头拖拽

			/*主表操作——开始*/
			$('#documentPackage_insert').bind('click', function () {	//添加按钮绑定事件
				documentPackage.insert();
			});

			$('#documentPackage_modify').bind('click', function () {	//编辑按钮绑定事件
				documentPackage.modify();
			});

			$('#documentPackage_del').bind('click', function () {	//删除按钮绑定事件
				documentPackage.del();
			});

			$('#documentPackage_search').bind('click', function(){	//左侧查询按钮绑定事件
				documentPackage.searchData(documentPackageGridColModel);
			});

			$('#documentPackage_searchAll').bind('click', function () {	//打开高级查询框
				documentPackage.openSearchForm(this, $('#documentPackage'));
			});

			$('#documentPackage_searchPart').bind('click', function () {	//关键字段查询按钮绑定事件
				documentPackage.searchByKeyWord();
			});

			$('#createdByAlias').on('focus', function (e) {	//文档包创建人绑定事件
				new H5CommonSelect({type: 'userSelect', idFiled: 'createdBy', textFiled: 'createdByAlias'});
				this.blur();
				nullInput(e);
			});

			$('#createdByDeptAlias').on('focus', function (e) {	//文档包创建人部门绑定事件
				new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
				this.blur();
				nullInput(e);
			});
			/*主表操作——结束*/

			/*子表操作——开始*/
			$('#documentItem_relate').bind('click', function () { //关联文档
				debugger;
				var documentRows = $('#documentItem').jqGrid('getGridParam','selarrrow');
				if((documentRows == undefined) || (documentRows == null) || (projectRows.length == 0)){
					layer.msg('请先选择需要关联的文档！');
					return;
				}

				parent.procDetail.relateDocument(documentRows);
			});

			$('#tableViewSelect').bind('click', function(){		//视图切换弹框绑定事件
				documentItem.openSelectView(this,140,200);
			});

			$('#documentItem_insert').bind('click', function () {	//添加按钮绑定事件
				documentItem.insert(documentPackage.getSelectID());
			});

			$('#documentItem_modify').bind('click', function () {	//编辑按钮绑定事件
				documentItem.modify();
			});

			$('#documentItem_del').bind('click', function () {	//删除按钮绑定事件
				documentItem.del();
			});

			$('#documentItem_search').bind('click', function(){	//左侧查询按钮绑定事件
				documentItem.searchData(documentItemGridColModel);
			});

			$('#documentItem_searchAll').bind('click', function () {	//打开高级查询
				documentItem.openSearchForm(this, $('#documentItem'));
			});

			$('#documentItem_searchPart').bind('click', function () {	//关键字段查询按钮绑定事件
				documentItem.searchByKeyWord();
			});

			$('#createdByDeptAliasSub').on('focus', function (e) {	//文档创建部门绑定事件
				new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDeptSub', textFiled: 'createdByDeptAliasSub'});
				this.blur();
				nullInput(e);
			});

			$('#documentAuthorAliasSub').on('focus', function (e) {	//文档作者绑定事件
				new H5CommonSelect({type: 'userSelect', idFiled: 'documentAuthor', textFiled: 'documentAuthorAlias'});
				this.blur();
				nullInput(e);
			});

			$('#authorDeptAliasSub').on('focus', function (e) {	//文档作者部门绑定事件
				new H5CommonSelect({type: 'deptSelect', idFiled: 'authorDept', textFiled: 'authorDeptAlias'});
				this.blur();
				nullInput(e);
			});

			$('#personLiableAliasSub').on('focus', function (e) {	//文档责任人绑定事件
				new H5CommonSelect({type: 'userSelect', idFiled: 'personLiable', textFiled: 'personLiableAlias'});
				this.blur();
				nullInput(e);
			});

			$('#participantsAliasSub').on('focus', function (e) {	//文档参与人绑定事件
				new H5CommonSelect({type: 'userSelect', idFiled: 'participants', textFiled: 'participantsAlias'});
				this.blur();
				nullInput(e);
			});

			$('#documentUpdateByAliasSub').on('focus', function (e) {	//文档更新人绑定事件
				new H5CommonSelect({type: 'userSelect',idFiled: 'documentUpdateBy',textFiled: 'documentUpdateByAlias'});
				this.blur();
				nullInput(e);
			});

			$('#knowScopeAliasSub').on('focus', function (e) {	//文档知悉范围绑定事件
				new H5CommonSelect({type: 'groupSelect', idFiled: 'knowScope', textFiled: 'knowScopeAlias'});
				this.blur();
				nullInput(e);
			});
		});
	</script>
</html>