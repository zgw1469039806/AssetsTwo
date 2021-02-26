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
	<!-- ControllerPath = "avicit/platform6/mobileportal/portalprogram/controller/NewPortalProgramController/toPortalProgramManage" -->
	<title>管理</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include
			page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div
		data-options="region:'center',onResize:function(a){$('#portalProgram').setGridWidth(a);$(window).trigger('resize');}">
	<div id="toolbar_portalProgram" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3"
								   domainObject="formdialog_portalProgram_button_add"
								   permissionDes="主表添加">
				<a id="portalProgram_insert" href="javascript:void(0)"
				   class="btn btn-default form-tool-btn btn-sm" role="button"
				   title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
								   domainObject="formdialog_portalProgram_button_edit"
								   permissionDes="主表编辑">
				<a id="portalProgram_modify" href="javascript:void(0)"
				   class="btn btn-default form-tool-btn btn-sm" role="button"
				   title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
								   domainObject="formdialog_portalProgram_button_delete"
								   permissionDes="主表删除">
				<a id="portalProgram_del" href="javascript:void(0)"
				   class="btn btn-default form-tool-btn btn-sm" role="button"
				   title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
								   domainObject="formdialog_portalProgram_button_delete"
								   permissionDes="启用应用程序状态">
				<a id="programState_start" href="javascript:void(0)"
				   class="btn btn-default form-tool-btn btn-sm" role="button"
				   title="启用">启用</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
								   domainObject="formdialog_portalProgram_button_delete"
								   permissionDes="禁用应用程序状态">
				<a id="programState_stop" href="javascript:void(0)"
				   class="btn btn-default form-tool-btn btn-sm" role="button"
				   title="禁用">禁用</a>
			</sec:accesscontrollist>
		</div>
		<!-- <div class="toolbar-right">
            <div class="input-group form-tool-search" style="width: 125px">
                <input type="text" name="portalProgram_keyWord"
                    id="portalProgram_keyWord" style="width: 125px;"
                    class="form-control input-sm" placeholder="请输入查询条件"> <label
                    id="portalProgram_searchPart"
                    class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="portalProgram_searchAll" href="javascript:void(0)"
                    class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
                    <span class="caret"></span>
                </a>
            </div>
        </div> -->
	</div>
	<table id="portalProgram"></table>
	<div id="portalProgramPager"></div>
</div>
<div
		data-options="region:'south',split:true,height:fixheight(.5),onResize:function(a){$('#portalProgramVersion').setGridWidth(a);$(window).trigger('resize');}">
	<div id="toolbar_portalProgramVersion" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3"
								   domainObject="formdialog_portalProgramVersion_button_add"
								   permissionDes="子表添加">
				<a id="portalProgramVersion_insert" href="javascript:void(0)"
				   class="btn btn-default form-tool-btn btn-sm" role="button"
				   title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
								   domainObject="formdialog_portalProgramVersion_button_edit"
								   permissionDes="子表编辑">
				<a id="portalProgramVersion_modify" href="javascript:void(0)"
				   class="btn btn-default form-tool-btn btn-sm" role="button"
				   title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
								   domainObject="formdialog_portalProgramVersion_button_delete"
								   permissionDes="子表删除">
				<a id="portalProgramVersion_del" href="javascript:void(0)"
				   class="btn btn-default form-tool-btn btn-sm" role="button"
				   title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
								   domainObject="formdialog_portalProgram_button_delete"
								   permissionDes="启用版本状态">
				<a id="programVersionState_start" href="javascript:void(0)"
				   class="btn btn-default form-tool-btn btn-sm" role="button"
				   title="启用">启用</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
								   domainObject="formdialog_portalProgram_button_delete"
								   permissionDes="禁用版本状态">
				<a id="programVersionState_stop" href="javascript:void(0)"
				   class="btn btn-default form-tool-btn btn-sm" role="button"
				   title="禁用">禁用</a>
			</sec:accesscontrollist>
		</div>
		<!-- <div class="toolbar-right">
            <div class="input-group form-tool-search" style="width: 125px">
                <input type="text" name="portalProgramVersion_keyWord"
                    id="portalProgramVersion_keyWord" style="width: 125px;"
                    class="form-control input-sm" placeholder="请输入查询条件"> <label
                    id="portalProgramVersion_searchPart"
                    class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="portalProgramVersion_searchAll" href="javascript:void(0)"
                    class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
                    <span class="caret"></span>
                </a>
            </div>
        </div> -->
	</div>
	<table id="portalProgramVersion"></table>
	<div id="portalProgramVersionPager"></div>
</div>
</body>
<!-- 主表高级查询 -->
<!-- <div id="searchDialog" style="overflow: auto; display: none">
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
</div> -->
<!-- 子表高级查询 -->
<!-- <div id="searchDialogSub" style="overflow: auto; display: none">
	<form id="formSub">
		<input type="hidden" name="deptid" id="deptid" />
		<table class="form_commonTable">
			<tr>
				<th width="10%">版本名称:</th>
				<td width="39%"><input title="版本名称"
					class="form-control input-sm" type="text" name="programVersionName"
					id="programVersionName" /></td>
				<th width="10%">入口地址:</th>
				<td width="39%"><input title="入口地址"
					class="form-control input-sm" type="text"
					name="programVersionEntrance" id="programVersionEntrance" /></td>
			</tr>
			<tr>
				<th width="10%">打开方式:</th>
				<td width="39%"><input title="打开方式"
					class="form-control input-sm" type="text"
					name="programVersionOpenMode" id="programVersionOpenMode" /></td>
				<th width="10%">STATE配置文件:</th>
				<td width="39%"><input title="STATE配置文件"
					class="form-control input-sm" type="text"
					name="programVersionManifest" id="programVersionManifest" /></td>
			</tr>
			<tr>
				<th width="10%">包名称:</th>
				<td width="39%"><input title="包名称"
					class="form-control input-sm" type="text"
					name="programVersionModuleName" id="programVersionModuleName" /></td>
				<th width="10%">依赖包:</th>
				<td width="39%"><input title="依赖包"
					class="form-control input-sm" type="text"
					name="programVersionDependance" id="programVersionDependance" /></td>
			</tr>
			<tr>
				<th width="10%">版本地址:</th>
				<td width="39%"><input title="版本地址"
					class="form-control input-sm" type="text" name="programVersionUrl"
					id="programVersionUrl" /></td>
				<th width="10%">版本描述:</th>
				<td width="39%"><input title="版本描述"
					class="form-control input-sm" type="text" name="programVersionDesc"
					id="programVersionDesc" /></td>
			</tr>
			<tr>
				<th width="10%">版本状态:</th>
				<td width="39%"><input title="版本状态"
					class="form-control input-sm" type="text"
					name="programVersionState" id="programVersionState" /></td>
				<th width="10%">是否最新版本:</th>
				<td width="39%"><input title="是否最新版本"
					class="form-control input-sm" type="text"
					name="programVersionIsNew" id="programVersionIsNew" /></td>
			</tr>
			<tr>
				<th width="10%">消息处理:</th>
				<td width="39%"><input title="消息处理"
					class="form-control input-sm" type="text"
					name="programVersionMsgHandling" id="programVersionMsgHandling" />
				</td>
				<th width="10%">网关地址:</th>
				<td width="39%"><input title="网关地址"
					class="form-control input-sm" type="text"
					name="programVersionGateWay" id="programVersionGateWay" /></td>
			</tr>
			<tr>
				<th width="10%">是否VPN:</th>
				<td width="39%"><input title="是否VPN"
					class="form-control input-sm" type="text" name="programVersionVpn"
					id="programVersionVpn" /></td>
			</tr>
		</table>
	</form>
</div> -->
<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/mobileportal/portalprogram/js/PortalProgram.js"
		type="text/javascript"></script>
<script src="avicit/platform6/mobileportal/portalprogram/js/PortalProgramVersion.js"
		type="text/javascript"></script>
<script type="text/javascript">
    var portalProgram;
    var portalProgramVersion;
    function formatState(cellvalue, options, rowObject) {
        var thisState = rowObject.programState;
        if(thisState =="0"){
            return '启用';
        }else{
            return '禁用';
        }
    }
    function formatSubVpn(cellvalue, options, rowObject) {
        var thisVpn = rowObject.programVersionVpn;
        if(thisVpn =="0"){
            return '是';
        }else{
            return '否';
        }
    }
    function formatSubState(cellvalue, options, rowObject) {
        var thisState = rowObject.programVersionState;
        if(thisState =="0"){
            return '启用';
        }else{
            return '禁用';
        }
    }

    function formatOpenMode(cellvalue, options, rowObject) {
        var thisMode = rowObject.programVersionOpenMode;
        if(thisMode =="0"){
            return 'modal';
        }else if(thisMode =="1"){
            return 'state';
        }else{
            return 'api-modal';
        }
    }

    function formatSubIsNew(cellvalue, options, rowObject) {
        var thisIsNew = rowObject.programVersionIsNew;
        if(thisIsNew =="0"){
            return '是';
        }else{
            return '否';
        }
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
            searchSubNames.push("programVersionName");
            searchSubTips.push("版本名称");
            searchSubNames.push("programId");
            searchSubTips.push("服务外键");
            var searchSubC = searchSubTips.length == 2 ? '或'
                + searchSubTips[1] : "";
            $('#portalProgramVersion_keyWord').attr('placeholder',
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
                width : 150,

            }, {
                label : '应用代码',
                name : 'programCode',
                width : 150
            }, {
                label : '应用图标地址',
                name : 'programImg',
                width : 250
            }, {
                label : '责任人',
                name : 'programResponsiblesAlias',
                width : 150
            }, {
                label : '应用程序描述',
                name : 'programDesc',
                width : 150,
                hidden : true
            }, {
                label : '应用程序状态',
                name : 'programState',
                formatter:formatState,
                width : 50,
            } ];
            var portalProgramVersionGridColModel = [ {
                label : 'id',
                name : 'id',
                key : true,
                width : 75,
                hidden : true
            }, {
                label : '版本名称',
                name : 'programVersionName',
                width : 150
            }, {
                label : '服务外键',
                name : 'programId',
                width : 150,
                hidden : true
            }, {
                label : '入口地址',
                name : 'programVersionEntrance',
                width : 150
            }, {
                label : '打开方式',
                name : 'programVersionOpenMode',
                formatter : formatOpenMode,
                width : 150
            }, {
                label : 'STATE配置文件',
                name : 'programVersionManifest',
                width : 150
            }, {
                label : '包名称',
                name : 'programVersionModuleName',
                width : 150
            }, {
                label : '依赖包',
                name : 'programVersionDependance',
                width : 150
            }, {
                label : '版本地址',
                name : 'programVersionUrl',
                width : 150
            }, {
                label : '版本描述',
                name : 'programVersionDesc',
                width : 150,
                hidden : true
            }, {
                label : '是否最新版本',
                name : 'programVersionIsNew',
                formatter:formatSubIsNew,
                width : 150
            }, {
                label : '消息处理',
                name : 'programVersionMsgHandling',
                width : 150
            }, {
                label : '网关地址',
                name : 'programVersionGateWay',
                width : 150
            }, {
                label : '是否VPN',
                name : 'programVersionVpn',
                formatter:formatSubVpn,
                width : 150
            }, {
                label : '版本状态',
                name : 'programVersionState',
                formatter:formatSubState,
                width : 150
            } ];

            portalProgram = new PortalProgram('portalProgram', '${url}',
                'form', portalProgramGridColModel, 'searchDialog',
                function(pid) {
                    portalProgramVersion = new PortalProgramVersion(
                        'portalProgramVersion', '${surl}',
                        "formSub",
                        portalProgramVersionGridColModel,
                        'searchDialogSub', pid, searchSubNames,
                        "portalProgramVersion_keyWord");
                }, function(pid) {
                    portalProgramVersion.reLoad(pid);
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
            /* $('#portalProgram_searchAll').bind('click', function() {
                portalProgram.openSearchForm(this, $('#portalProgram'));
            }); */
            //关键字段查询按钮绑定事件
            /* $('#portalProgram_searchPart').bind('click', function() {
                portalProgram.searchByKeyWord();
            }); */
            //禁用按钮绑定事件
            $('#programState_stop').bind('click', function() {
                portalProgram.stop();
            });
            //启用按钮绑定事件
            $('#programState_start').bind('click', function() {
                portalProgram.start();
            });

            //子表操作
            //添加按钮绑定事件
            $('#portalProgramVersion_insert').bind('click', function() {
                portalProgramVersion.insert();
            });
            //编辑按钮绑定事件
            $('#portalProgramVersion_modify').bind('click', function() {
                portalProgramVersion.modify();
            });
            //删除按钮绑定事件
            $('#portalProgramVersion_del').bind('click', function() {
                portalProgramVersion.del();
            });
            //打开高级查询
            /* 	$('#portalProgramVersion_searchAll').bind(
                        'click',
                        function() {
                            portalProgramVersion.openSearchForm(this,
                                    $('#portalProgramVersion'));
                        }); */
            //关键字段查询按钮绑定事件
            /* $('#portalProgramVersion_searchPart').bind('click', function() {
                portalProgramVersion.searchByKeyWord();
            }); */

            //禁用按钮绑定事件
            $('#programVersionState_stop').bind('click', function() {
                portalProgramVersion.stop();
            });
            //启用按钮绑定事件
            $('#programVersionState_start').bind('click', function() {
                portalProgramVersion.start();
            });
        });
</script>
</html>