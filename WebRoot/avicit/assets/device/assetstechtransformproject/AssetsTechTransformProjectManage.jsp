<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetstechtransformproject/assetsTechTransformProjectController/toAssetsTechTransformProjectManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

	<!-- 切换卡 样式 -->
	<link href="avicit/platform6/switch_card/yyui.css" rel="stylesheet" type="text/css">
</head>

<body class="easyui-layout" fit="true">
    <%--页面主体——技改项目表头工具栏及表--%>
	<div id="panelnorth" data-options="region:'north',height:fixheight(.5),onResize:function(a){$('#assetsTechTransformProject').setGridWidth(a);$('#assetsTechTransformProject').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
		<div id="toolbar_assetsTechTransformProject" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformProject_button_add" permissionDes="添加">
					<a id="assetsTechTransformProject_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="添加">
						<i class="fa fa-plus"></i>添加
					</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformProject_button_edit" permissionDes="编辑">
					<a id="assetsTechTransformProject_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="编辑">
						<i class="fa fa-file-text-o"></i> 编辑
					</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformProject_button_delete" permissionDes="删除">
					<a id="assetsTechTransformProject_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="删除">
						<i class="fa fa-trash-o"></i> 删除
					</a>
				</sec:accesscontrollist>
			</div>
            <div class="contextMenu" style="display: none;" id="commonContextMenuForm">
                <ul>
                    <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformProject_button_right_add" permissionDes="右键添加">
                    <li id="F_item_add">添加</li>
                    </sec:accesscontrollist>
                    <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformProject_button_right_edit" permissionDes="右键编辑">
                    <li id="F_item_edit">编辑</li>
                    </sec:accesscontrollist>
                    <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformProject_button_right_delete" permissionDes="右键删除">
                    <li id="F_item_del">删除</li>
                    </sec:accesscontrollist>
                </ul>
            </div>
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width:125px">
					<input type="text" name="assetsTechTransformProject_keyWord" id="assetsTechTransformProject_keyWord" style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
					<label id="assetsTechTransformProject_searchPart" class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="assetsTechTransformProject_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">
						高级查询 <span class="caret"></span>
					</a>
				</div>
			</div>
		</div>
		<table id="assetsTechTransformProject"></table>
		<div id="assetsTechTransformProjectPager"></div>
	</div>

    <%--页面主体——技改项目设备、团队模块--%>
	<div id="centerpanel" style="height: 200px;" data-options="region:'center',split:true,onResize:function(a){$('#assetsTechTransformDevice').setGridWidth(a); $('#assetsTechTransformDevice').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
		<div class="yyui_tab" style="width:100%; position:absolute;">
			<ul>
				<li class="yyui_tab_title_this" onclick="switchTab('deviceTab')">项目设备</li>
				<li class="yyui_tab_title" onclick="switchTab('teamTab')">项目团队</li>
			</ul>

            <%--技改项目设备表头工具栏及表--%>
			<div class="yyui_tab_content_this" style="overflow-y:scroll; width:100%;">
				<div id="tableToolbarDevice" class="toolbar" style="padding:0px; margin:0px; width:100%;">
					<div class="toolbar-left">
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformDevice_button_add" permissionDes="添加同级设备">
							<a id="assetsTechTransformDevice_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加同级设备">
								<i class="fa fa-plus"></i> 添加同级设备
							</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformDevice_button_add" permissionDes="添加子设备">
							<a id="assetsTechTransformDevice_insertSub" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加子设备">
								<i class="fa fa-plus"></i> 添加子设备
							</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformDevice_button_edit" permissionDes="编辑">
							<a id="assetsTechTransformDevice_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑">
								<i class="fa fa-file-text-o"></i> 编辑
							</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformDevice_button_delete" permissionDes="删除">
							<a id="assetsTechTransformDevice_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除">
								<i class="fa fa-trash-o"></i> 删除
							</a>
						</sec:accesscontrollist>
					</div>
					<div class="toolbar-right">
						<div class="input-group form-tool-search">
							<input type="text" name="assetsTechTransformDevice_keyWord" id="assetsTechTransformDevice_keyWord" style="width: 240px;" class="form-control input-sm" placeholder="请输入查询条件">
							<label id="assetsTechTransformDevice_searchPart" class="icon icon-search form-tool-searchicon"></label>
						</div>
						<div class="input-group-btn form-tool-searchbtn">
							<a id="assetsTechTransformDevice_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">
								高级查询 <span class="caret"></span>
							</a>
						</div>
					</div>
				</div>
				<table id="assetsTechTransformDevicejqGrid"></table>
			</div>

            <%--技改项目团队表头工具栏及表--%>
			<div class="yyui_tab_content" style="overflow-y:scroll; width:100%;">
                <div id="tableToolbarTeam" class="toolbar" style="padding:0px; margin:0px; width:100%;">
                    <div class="toolbar-left">
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformPerson_button_add" permissionDes="添加">
                            <a id="assetsTechTransformPerson_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加">
                                <i class="fa fa-plus"></i> 添加
                            </a>
                        </sec:accesscontrollist>
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformPerson_button_edit" permissionDes="编辑">
                            <a id="assetsTechTransformPerson_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑">
                                <i class="fa fa-file-text-o"></i> 编辑
                            </a>
                        </sec:accesscontrollist>
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTechTransformPerson_button_delete" permissionDes="删除">
                            <a id="assetsTechTransformPerson_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除">
                                <i class="fa fa-trash-o"></i> 删除
                            </a>
                        </sec:accesscontrollist>
                    </div>
                    <div class="toolbar-right">
                        <div class="input-group form-tool-search">
                            <input type="text" name="assetsTechTransformPerson_keyWord" id="assetsTechTransformPerson_keyWord" style="width: 240px;" class="form-control input-sm" placeholder="请输入查询条件">
                            <label id="assetsTechTransformPerson_searchPart" class="icon icon-search form-tool-searchicon"></label>
                        </div>
                        <div class="input-group-btn form-tool-searchbtn">
                            <a id="assetsTechTransformPerson_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">
                                高级查询 <span class="caret"></span>
                            </a>
                        </div>
                    </div>
                </div>
                <table id="assetsTechTransformPersonjqGrid"></table>
                <div id="jqGridPager"></div>
			</div>
		</div>
	</div>
</body>

<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">项目序号:</th>
                <td width="15%">
                    <input title="项目序号" class="form-control input-sm" type="text" name="projectNo" id="projectNo"/>
                </td>

                <th width="10%">技改项目名称:</th>
                <td width="15%">
                    <input title="技改项目名称" class="form-control input-sm" type="text" name="ttProjectName" id="ttProjectName"/>
                </td>

                <th width="10%">批复名称:</th>
                <td width="15%">
                    <input title="批复名称" class="form-control input-sm" type="text" name="replyName" id="replyName"/>
                </td>

                <th width="10%">主管总师:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="chiefEngineer" name="chiefEngineer">
                        <input class="form-control" placeholder="请选择用户" type="text" id="chiefEngineerAlias" name="chiefEngineerAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
                    </div>
                </td>
            </tr>

            <tr>
                <th width="10%">项目主管:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="projectDirector" name="projectDirector">
                        <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias" name="projectDirectorAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
                    </div>
                </td>

                <th width="10%">备注:</th>
                <td width="15%">
                    <input title="备注" class="form-control input-sm" type="text" name="remarks" id="remarks"/>
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 设备高级查询 -->
<div id="searchDialogDevice" style="overflow: auto;display: none">
    <form id="formDevice">
        <table class="form_commonTable">
            <tr>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
					<input type="hidden" name="projectId"  id="projectId" />
                </td>
                <th width="10%">是否为实体:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isEntity" id="isEntity" title="是否为实体" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">主要技术（性能）指标或规格要求:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="主要技术（性能）指标或规格要求" name="technicalRequirement" id="technicalRequirement"></textarea>
                </td>
                <th width="10%">国别:</th>
                <td width="15%">
                    <input title="国别" class="form-control input-sm" type="text" name="nation" id="nation"/>
                </td>
            </tr>
            <tr>
                <th width="10%">单位（台/套）:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="singleOrSet" id="singleOrSet" title="单位（台/套）" isNull="true" lookupCode="SINGLE_OR_SET"/>
                </td>
                <th width="10%">单价:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice"
                            data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                            data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
                <th width="10%">数量:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="amount" id="amount"
                            data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                            data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
                <th width="10%">合计:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="total" id="total"
                            data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                            data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">外汇:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="foreignExchange" id="foreignExchange"
                            data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                            data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
                <th width="10%">招标情况:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="招标情况" name="biddingSituation" id="biddingSituation"></textarea>
                </td>
                <th width="10%">备注:</th>
                <td width="15%">
                    <input title="备注" class="form-control input-sm" type="text" name="remarks" id="remarksDevice"/>
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 团队高级查询 -->
<div id="searchDialogTeam" style="overflow: auto; display: none">
    <form id="formTeam" style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th width="10%">技改项目:</th>
                <td width="15%">
                    <input title="技改项目" class="form-control input-sm" type="text" name="projectId" id="projectId1" />
                </td>

                <th width="10%">项目角色:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="projectRole" id="projectRole" title="项目角色" isNull="true" lookupCode="PROJECT_ROLE" />
                </td>

                <th width="10%">姓名:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userName" name="userName">
                        <input class="form-control" placeholder="请选择用户" type="text" id="userNameAlias" name="userNameAlias">
                        <span class="input-group-addon"> <i class="glyphicon glyphicon-user"></i></span>
                    </div>
                </td>

                <th width="10%">用户ID:</th>
                <td width="15%">
                    <input title="用户ID" class="form-control input-sm" type="text" name="userId" id="userId" />
                </td>
            </tr>
            <tr>
                <th width="10%">性别:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="sex" id="sex" title="性别" isNull="true" lookupCode="PLATFORM_SEX" />
                </td>

                <th width="10%">部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userDepartment" name="userDepartment">
                        <input class="form-control" placeholder="请选择部门" type="text" id="userDepartmentAlias" name="userDepartmentAlias">
                        <span class="input-group-addon"> <i class="glyphicon glyphicon-equalizer"></i></span>
                    </div>
                </td>

                <th width="10%">职称:</th>
                <td width="15%"><pt6:h5select css_class="form-control input-sm" name="userTitle" id="userTitle" title="职称" isNull="true" lookupCode="PLATFORM_USER_TITLE" /></td>

                <th width="10%">手机:</th>
                <td width="15%">
                    <input title="手机" class="form-control input-sm" type="text" name="mobileNumber" id="mobileNumber" />
                </td>
            </tr>
            <tr>
                <th width="10%">办公电话:</th>
                <td width="15%">
                    <input title="办公电话" class="form-control input-sm" type="text" name="officePhone" id="officePhone" />
                </td>
                <th width="10%">备注:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="备注" name="remarks" id="remarksTeam"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<!-- 列表的js -->
<script src="avicit/assets/device/assetstechtransformproject/js/AssetsTechTransformProject.js" type="text/javascript"></script>
<script src="avicit/assets/device/assetstechtransformproject/assetstechtransformdevice/js/AssetsTechTransformDevice.js" type="text/javascript"></script>
<script src="avicit/assets/device/assetstechtransformproject/assetstechtransformperson/js/AssetsTechTransformPerson.js" type="text/javascript"></script>

<!-- 切换卡的js -->
<script src="avicit/platform6/switch_card/yyui.js"></script>



<script type="text/javascript">
    var assetsTechTransformProject;
    var assetsTechTransformDevice;
    var assetsTechTransformPerson;
    var currentTab = 'deviceTab';

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsTechTransformProject.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsTechTransformProject.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //切换卡切换
    function switchTab(tabId){
        if(currentTab != tabId){
            currentTab = tabId;

            var projectId = $("#assetsTechTransformProject").jqGrid("getGridParam","selrow");

            if((projectId != null) && (projectId != undefined)){
                if(currentTab == 'deviceTab'){
                    document.getElementById('projectId').value = projectId;
                    assetsTechTransformDevice.searchData();
                }
                if(currentTab == 'teamTab'){
                    document.getElementById('projectId1').value = projectId;
                    assetsTechTransformPerson.searchData();
                }
            }
        }
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsTechTransformProject.reLoad();
    };

    $(document).ready(function () {
    	/*技改项目列表初始化——开始*/
        var searchMainNames = new Array();
        var searchMainTips = new Array();

        searchMainNames.push("ttProjectName");
        searchMainTips.push("技改项目名称");

        searchMainNames.push("remarks");
        searchMainTips.push("备注");

        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#assetsTechTransformProject_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#assetsTechTransformProject_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);

		var assetsTechTransformProjectGridColModel = [
			  {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '项目序号', name: 'projectNo', width: 100}
			, {label: '技改项目名称', name: 'ttProjectName', width: 150, formatter: formatValue}
            , {label: '批复名称', name: 'replyName', width: 150}
			, {label: '主管总师', name: 'chiefEngineerAlias', width: 150}
			, {label: '项目主管', name: 'projectDirectorAlias', width: 150}
			, {label: '备注', name: 'remarks', width: 250}
		];

		assetsTechTransformProject = new AssetsTechTransformProject('assetsTechTransformProject', '${url}', 'form', assetsTechTransformProjectGridColModel,
				'searchDialog', searchMainNames, "assetsTechTransformProject_keyWord");
		/*技改项目列表初始化——结束*/

        /*技改项目设备初始化——开始*/
        var searchDeviceNames = new Array();
        var searchDeviceTips = new Array();

		searchDeviceNames.push("deviceName");
		searchDeviceTips.push("设备名称");

		searchDeviceNames.push("technicalRequirement");
		searchDeviceTips.push("主要技术（性能）指标或规格要求");

        var searchDeviceC = searchDeviceTips.length == 2 ? '或' + searchDeviceTips[1] : "";
        $('#assetsTechTransformDevice_keyWord').attr('placeholder', '请输入' + searchDeviceTips[0] + searchDeviceC);
        $('#assetsTechTransformDevice_keyWord').attr('title', '请输入' + searchDeviceTips[0] + searchDeviceC);

        var assetsTechTransformDeviceGridColModel = [
              {label: 'id', name: 'id', key: true, width: 75, hidden: true}
			, {label: '序号', name: 'pointNo', width: 75}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '是否为实体', name: 'isEntityName', width: 150}
            , {label: '主要技术（性能）指标或规格要求', name: 'technicalRequirement', width: 150}
            , {label: '国别', name: 'nation', width: 150}
            , {label: '单位（台/套）', name: 'singleOrSetName', width: 150}
            , {label: '单价', name: 'unitPrice', width: 150}
            , {label: '数量', name: 'amount', width: 150}
            , {label: '合计', name: 'total', width: 150}
            , {label: '外汇', name: 'foreignExchange', width: 150}
            , {label: '招标情况', name: 'biddingSituation', width: 150}
            , {label: '备注', name: 'remarks', width: 150}
            , {label: '父节点ID', name: 'parentId', width: 150, hidden: true}
        ];
		assetsTechTransformDevice = new AssetsTechTransformDevice('assetsTechTransformDevicejqGrid', '${urlDevice}', 'searchDialogDevice', 'formDevice',
				'assetsTechTransformDevice_keyWord', searchDeviceNames, assetsTechTransformDeviceGridColModel);

		/*技改项目设备初始化——结束*/

        /*技改项目团队初始——开始*/
        var assetsTechTransformPersonDataGridColModel =  [
             { label: 'id', name: 'id', key: true, width: 75, hidden:true}
            ,{ label: '技改项目', name: 'projectId', width: 150,formatter:formatValue, hidden:true}
            ,{ label: '项目角色', name: 'projectRole', width: 150}
            ,{ label: '姓名', name: 'userNameAlias', width: 150}
            ,{ label: '用户ID', name: 'userId', width: 150, hidden:true}
            ,{ label: '性别', name: 'sex', width: 150}
            ,{ label: '部门', name: 'userDepartmentAlias', width: 150}
            ,{ label: '职称', name: 'userTitle', width: 150}
            ,{ label: '手机', name: 'mobileNumber', width: 150}
            ,{ label: '办公电话', name: 'officePhone', width: 150}
            ,{ label: '备注', name: 'remarks', width: 150}
        ];

        var searchNamesTeam = new Array();
        var searchTipsTeam = new Array();

        searchNamesTeam.push("projectRole");
        searchTipsTeam.push("项目角色");

        searchNamesTeam.push("userId");
        searchTipsTeam.push("用户ID");

        var searchCTeam = searchTipsTeam.length==2?'或' + searchTipsTeam[1] : "";
        $('#assetsTechTransformPerson_keyWord').attr('placeholder','请输入' + searchTipsTeam[0] + searchCTeam);

        assetsTechTransformPerson= new AssetsTechTransformPerson('assetsTechTransformPersonjqGrid', '${urlTeam}', 'searchDialogTeam', 'formTeam',
            'assetsTechTransformPerson_keyWord', searchNamesTeam, assetsTechTransformPersonDataGridColModel);
        /*技改项目团队初始——结束*/


		/*技改项目表操作——开始*/
        $('#assetsTechTransformProject_insert').bind('click', function () {	//添加按钮绑定事件
            assetsTechTransformProject.insert();
        });

        $('#assetsTechTransformProject_modify').bind('click', function () {	//编辑按钮绑定事件
            assetsTechTransformProject.modify();
        });

        $('#assetsTechTransformProject_del').bind('click', function () {	//删除按钮绑定事件
            assetsTechTransformProject.del();
        });

        $('#assetsTechTransformProject_searchAll').bind('click', function () {	//打开高级查询框
            assetsTechTransformProject.openSearchForm(this, $('#assetsTechTransformProject'));
        });

        $('#assetsTechTransformProject_searchPart').bind('click', function () {	//关键字段查询按钮绑定事件
            assetsTechTransformProject.searchByKeyWord();
        });

        $('#chiefEngineerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'chiefEngineer', textFiled: 'chiefEngineerAlias'});
            this.blur();
            nullInput(e);
        });

        $('#projectDirectorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'projectDirector', textFiled: 'projectDirectorAlias'});
            this.blur();
            nullInput(e);
        });
		/*技改项目表操作——结束*/

        /*技改项目设备表操作——开始*/
		$('#assetsTechTransformDevice_insert').bind('click', function(){	//添加同级设备
			var projectRows = $('#assetsTechTransformProject').jqGrid('getGridParam','selarrrow');
			var projectId;
			if((projectRows == null) || (projectRows == undefined) || (projectRows.length == 0)){
				layer.msg('请先选择需要添加设备的技改项目！');
				return;
			}
			else if(projectRows.length > 1){
				layer.msg('同时只能为一个技改项目添加设备！');
				return;
			}
			projectId = projectRows[0];

			var deviceId = $("#assetsTechTransformDevicejqGrid").jqGrid("getGridParam","selrow");
			var parentId = 'null';
			if((deviceId == null) || (deviceId == undefined)){
				layer.msg('请先选择同级设备！');
			}
			else{
				var rowData = jQuery("#assetsTechTransformDevicejqGrid").jqGrid("getRowData", deviceId);
				parentId = rowData.parentId;
			}

			assetsTechTransformDevice.insert(projectId, parentId);
		});

		$('#assetsTechTransformDevice_insertSub').bind('click', function(){	//添加子级设备
			var projectRows = $('#assetsTechTransformProject').jqGrid('getGridParam','selarrrow');
			var projectId;
			if((projectRows == null) || (projectRows == undefined) || (projectRows.length == 0)){
				layer.msg('请先选择需要添加设备的技改项目！');
				return;
			}
			else if(projectRows.length > 1){
				layer.msg('同时只能为一个技改项目添加设备！');
				return;
			}
			projectId = projectRows[0];

			var deviceId = $("#assetsTechTransformDevicejqGrid").jqGrid("getGridParam","selrow");
			var parentId = 'null';
			if((deviceId == null) || (deviceId == undefined)){
				layer.msg('请先选择父级设备！');
				return;
			}
			else{
				parentId = deviceId;
			}

			assetsTechTransformDevice.insert(projectId, parentId);
		});

		$('#assetsTechTransformDevice_modify').bind('click', function(){	//编辑按钮绑定事件
            var deviceId = $("#assetsTechTransformDevicejqGrid").jqGrid("getGridParam","selrow");
            if((deviceId == null) || (deviceId == undefined)){
                layer.msg('请先选择要编辑的设备！');
                return;
            }
			assetsTechTransformDevice.modify(deviceId);
		});

		$('#assetsTechTransformDevice_del').bind('click', function(){	//删除按钮绑定事件
			assetsTechTransformDevice.del();
		});

		$('#assetsTechTransformDevice_searchPart').bind('click', function(){//查询按钮绑定事件
			assetsTechTransformDevice.searchByKeyWord();
		});

		$('#assetsTechTransformDevice_searchAll').bind('click', function(){//打开高级查询框
			assetsTechTransformDevice.openSearchForm(this);
		});
		/*技改项目设备表操作——结束*/

        /*技改项目团队表操作——开始*/
        $('#assetsTechTransformPerson_insert').bind('click', function(){    //添加按钮绑定事件
            var projectRows = $('#assetsTechTransformProject').jqGrid('getGridParam','selarrrow');
            var projectId;
            if((projectRows == null) || (projectRows == undefined) || (projectRows.length == 0)){
                layer.msg('请先选择需要添加团队成员的技改项目！');
                return;
            }
            else if(projectRows.length > 1){
                layer.msg('同时只能为一个技改项目添加团队成员！');
                return;
            }

            projectId = projectRows[0];
            assetsTechTransformPerson.insert(projectId);
        });

        $('#assetsTechTransformPerson_modify').bind('click', function(){    //编辑按钮绑定事件
            assetsTechTransformPerson.modify();
        });

        $('#assetsTechTransformPerson_del').bind('click', function(){   //删除按钮绑定事件
            assetsTechTransformPerson.del();
        });

        $('#assetsTechTransformPerson_searchPart').bind('click', function(){    //查询按钮绑定事件
            assetsTechTransformPerson.searchByKeyWord();
        });

        $('#assetsTechTransformPerson_searchAll').bind('click', function(){//打开高级查询框
            assetsTechTransformPerson.openSearchForm(this);
        });

        $('#userNameAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'userName', textFiled: 'userNameAlias'});
            this.blur();
            nullInput(e);
        });

        $('#userDepartmentAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'userDepartment', textFiled: 'userDepartmentAlias'});
            this.blur();
            nullInput(e);
        });
        /*技改项目团队表操作——结束*/
    });

	window.onload = function(){
		document.getElementById('projectId').value = 'kong';
		assetsTechTransformDevice.searchData();

        document.getElementById('projectId1').value = 'kong';
        assetsTechTransformPerson.searchData();

		var deviceTab = document.getElementById('assetsTechTransformDevicejqGrid').parentNode.parentNode;
		deviceTab.style.height = '190px';
		deviceTab.style.overflowY = 'scroll';

		//技改项目列表行点击事件监控
		$('#assetsTechTransformProject').bind('click', function () {
			var projectId = $("#assetsTechTransformProject").jqGrid("getGridParam","selrow");

			if((projectId != null) && (projectId != undefined)){
			    if(currentTab == 'deviceTab'){
                    document.getElementById('projectId').value = projectId;
                    assetsTechTransformDevice.searchData();
                }
                if(currentTab == 'teamTab'){
                    document.getElementById('projectId1').value = projectId;
                    assetsTechTransformPerson.searchData();
                }
			}
		});
	}
</script>
<script  src="static/js/assets/ContextMenu_jquery.js" type="text/javascript"></script>
<script  src="static/js/assets/ContextMenu.js" type="text/javascript"></script>
</html>