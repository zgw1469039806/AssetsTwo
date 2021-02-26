<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">

</script>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_add" permissionDes="添加">
	  	<a id="consoleUser_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="icon icon-add"></i> 添加</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_edit" permissionDes="编辑">
		<a id="consoleUser_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="icon icon-edit"></i> 编辑</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_delete" permissionDes="删除">
		<a id="consoleUser_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_passwordmgr" permissionDes="密码管理">
		<div class="dropdown">
				<a class="btn btn-primary form-tool-btn btn-sm" role="button"  href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu">密码管理 <span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
					<!-- role = "presentation"表示陈述 -->
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_resetPassword" permissionDes="重置密码">
					<li role="presentation"><a href="javascript:void(0);" onclick="resetPassword();">重置密码</a></li>
					<li role="separator" class="divider"></li>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_changePassword" permissionDes="修改密码">
					<li role="presentation"><a href="javascript:void(0);" onclick="changePassword('<%=ViewUtil.getRequestPath(request)%>');">修改密码</a></li>
					<li role="separator" class="divider"></li>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_resetAllPassword" permissionDes="密码全部重置">
					<li role="presentation"><a href="javascript:void(0);" onclick="resetAllPassword();">密码全部重置</a></li>
					</sec:accesscontrollist>
					
				</ul>
		</div>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_userStatus" permissionDes="用户状态设置">
  		<div class="dropdown">
				<a class="btn btn-primary form-tool-btn btn-sm" role="button"  href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu">用户状态设置<span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
					<!-- role = "presentation"表示陈述 -->
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_doUnLockSysUser" permissionDes="解锁">
					<li role="presentation"><a href="javascript:void(0);" onclick="doUnLockSysUser();">解锁</a></li>
					<li role="separator" class="divider"></li>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_toLockLog" permissionDes="用户锁定日志">
					<li role="presentation"><a href="javascript:void(0);" onclick="toLockLog();" >用户锁定日志</a></li>
					<li role="separator" class="divider"></li>
					</sec:accesscontrollist>
					<li role="presentation"><a href="javascript:void(0);" onclick="setValidFlag();" >有无效设置</a></li>
				</ul>
		</div>
		</sec:accesscontrollist>



        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_toolbar_tool" permissionDes="工具">
  		<div class="dropdown">
				<a class="btn btn-primary form-tool-btn btn-sm" role="button"  href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu">工具<span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
					<!-- role = "presentation"表示陈述 -->
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_importUser" permissionDes="导入用户">
					<li role="presentation"><a href="javascript:void(0);" onclick="importUser();">导入用户</a></li>
					<li role="separator" class="divider"></li>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_exportClientData" permissionDes="导出客户端">
					<li role="presentation"><a href="javascript:void(0);" onclick="exportClientData();">EXCEL导出（当前页）</a></li>
					<li role="separator" class="divider"></li>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_exportServerData" permissionDes="导出服务端">
					<li role="presentation"><a href="javascript:void(0);" onclick="exportServerData();">EXCEL导出（所有页）</a></li>
					<li role="separator" class="divider"></li>
					</sec:accesscontrollist>
					<%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_changeDept" permissionDes="移动部门">
					<li role="presentation"><a href="javascript:void(0);" onclick="batchMoveDept('<%=ViewUtil.getRequestPath(request)%>');";>移动部门</a></li>
					<li role="separator" class="divider"></li>
					</sec:accesscontrollist>--%>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_changeTodo" permissionDes="移交待办">
					<li role="presentation"><a href="javascript:void(0);" onclick="doworkhand();">移交待办</a></li>
					<li role="separator" class="divider"></li>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_showauth" permissionDes="查看权限">
					<li role="presentation"><a href="javascript:void(0);" onclick="showPermisstionMenu('<%=ViewUtil.getRequestPath(request)%>');">查看权限</a></li>
                    <li role="separator" class="divider"></li>
					</sec:accesscontrollist>
					<li id="activationPassword" style="display:none" role="presentation"><a href="javascript:void(0);" onclick="activationPassword();">激活密码</a></li>
				</ul>
			</div>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_toolbar_jianzhi" permissionDes="兼职信息">
			<div class="dropdown">
				<a class="btn btn-primary form-tool-btn btn-sm" role="button"  href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu">兼职信息<span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_havePartDept" permissionDes="兼职部门">
					<li role="presentation"><a href="javascript:void(0);" onclick="havePartDept();" >兼职部门</a></li>
					<li role="separator" class="divider"></li>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_org_secret" permissionDes="组织密级">
					<li role="presentation"><a href="javascript:void(0);" onclick="doOrgSecret();"  >组织密级</a></li>
					<li role="separator" class="divider"></li>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleUser_button_havePartRole" permissionDes="角色列表">
					<li role="presentation"><a href="javascript:void(0);" onclick="havePartRole();" >角色列表</a></li>
					</sec:accesscontrollist>
				</ul>
			</div>
	
        </sec:accesscontrollist>

	
	</div>
	
    <div class="toolbar-right">
    	<div class="input-group form-tool-search" style="width: 180px">
		<input type="text" name="sysUser_keyWord"
						id="sysUser_keyWord"
						class="form-control input-sm" placeholder="请输入查询条件"> 
		<label id="sysUser_searchPart" class="icon icon-search form-tool-searchicon"></label>
		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="consoleUser_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>
<table id="jqGrid" datapermission='jqCcSysUser'></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id='form' style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th>用户编号:</th>
				<td><input title="用户编号" class="form-control input-sm" type="text" name="no" id="no" /></td>
				
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="loginName">登录名:</label></th>
				<td width="39%"><input title="登录名" class="form-control input-sm" type="text" name="loginName" id="loginName" /></td>
			</tr>
			<tr>
				<th>用户姓名:</th>
				<td><input title="用户姓名" class="form-control input-sm" type="text" name="name" id="name" /></td>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="title">职称:</label></th>
					<td width="39%" >
						<pt6:h5select css_class="form-control input-sm" name="title" id="title" title="" isNull="true" lookupCode="PLATFORM_USER_TITLE" />
				</td>
			</tr>
			<tr>
				<th>手机:</th>
				<td><input title="电话" class="form-control input-sm" type="text" name="mobile" id="mobile" /></td>
				<th>密级:</th>
				<td >
					<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="密级" isNull="true" lookupCode="PLATFORM_USER_SECRET_LEVEL" />
				</td>
			</tr>
			<tr>
				<th>邮箱地址:</th>
				<td><input title="邮箱地址" class="form-control input-sm" type="text" name="email" id="email" /></td>
				
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="consoleType">前后台:</label></th>
					<td width="39%" >
						<pt6:h5select css_class="form-control input-sm" name="consoleType" id="title" title="" isNull="true" lookupCode="PLATFORM_CONSOLE" />
				</td>
			</tr>
			
			
			
			<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="status">状态:</label></th>
							<td width="39%">
							
						<select id="status" name="status" class="form-control input-sm" title="status">
						
								<option value=""   selected="selected">无</option>
								<option value="1" >有效</option>
								<option value="3">无效</option>
								<option value="0">未锁定</option>
								<option value="lock">已锁定</option>
						
						</select>
					</td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="positionbtn">选择岗位:</label></th>
							<td width="39%" >
								<div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="positionId" name="positionId" value=''>
							      <input class="form-control" placeholder="请选择岗位" type="text" id="applyPositionidAlias" name="applyPositionidAlias" >
							      <span class="input-group-btn">
							        <button class="btn btn-default" type="button" id="positionbtn" ><span class="glyphicon glyphicon-equalizer"></span></button>
							      </span>
						        </div>
							</td>
				</tr>
				
					
				</tr>
			
		</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/bs3centralcontrol/user/js/consoleUser.js" type="text/javascript"></script> 
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script type="text/javascript">



var consoleUser;
function formatStatus(cellvalue, options, rowObject) {

	if(rowObject.userLocked!="0"){
		return "<img src='avicit/platform6/console/user/images/lock.png' title='锁定'>";
	}
	if(rowObject.status=="1"){
		return "<img src='avicit/platform6/console/user/images/state.png' title='有效用户'>";
	}else{
		return "<img src='avicit/platform6/console/user/images/unstate.png' title='无效用户'>";
	}
	
}
  
function formatLevel(cellvalue, options, rowObject) {
	if(cellvalue=="1"){
		return '非涉密人员';
	}else if(cellvalue=="1"){
		return '涉密人员';
	}else{
		return '涉密人员';
	}
	
}
  
function formatSex(cellvalue, options, rowObject) {
	if(rowObject.sex=="1"){
		return "<img src='avicit/platform6/console/user/images/man.png' title='男'>";
	}else{
		return "<img src='avicit/platform6/console/user/images/woman.png' title='女'>";
	}
}

function formatDept(cellvalue, options, rowObject) {
	if(cellvalue=="1"){
		return "<img src='avicit/platform6/console/user/images/status.png' title='是'>";
	}else{
		return "";
	}
}

function formatConsole(cellvalue, options, rowObject) {
	
	if(cellvalue=="1"){
		return "<font color=\"#1d953f\">"+ "前台用户"+ "</font>";
	}else{
		return "<font color=\"#f26522\">"+ "后台用户"+ "</font>";
	}
}

function formatOrg(cellvalue, options, rowObject) {
    var orgNameTemp = '';
    $.ajax({
        url: 'platform/console/user/getOrgNameByid',
        data: {orgId: cellvalue},
        async: false,
        type: 'post',
        dataType: 'text',
        success: function (orgName) {
            orgNameTemp = orgName;
        }
    });
    return orgNameTemp;
}

function loadUserData(treeNode){

	var searchdata = {param:JSON.stringify(treeNode)};
	$('#jqGrid').jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
	
}
function loadUserDataRoot(){

	$('#jqGrid').jqGrid('setGridParam',{postData: ''}).trigger("reloadGrid");
	
}
$(document).ready(function () {
	
	var isNotSafeManager = parent.isNotSafeManager;
	if(isNotSafeManager=="false"){
		$('#activationPassword').show();
	}
	
	var searchUserMainNames = [];
	var searchUserMainTips = [];
	searchUserMainNames.push("name");
 	searchUserMainTips.push("用户名");
 	searchUserMainNames.push("loginName");
 	searchUserMainTips.push("登录名");
	$('#sysUser_keyWord').attr('placeholder','输入'+searchUserMainTips[0]+'或'+searchUserMainTips[1] + '查询');
	
	


	var dataGridColModel =  [
      { label: 'id', name: 'id', key: true, width: 75, hidden:true }

        ,{ label: '状态', name: 'status11', width: 100,align:'center',formatter:formatStatus}
        ,{ label: '状态', name: 'status', hidden:true}
        ,{ label: '锁定状态', name: 'userLocked', hidden:true}
        ,{ label: '用户姓名', name: 'name', sortable : false,width: 150 ,align:'center'}
        ,{ label: '登录名', name: 'loginName', sortable : false,width: 150,align:'center'}
        ,{ label: '密级类型', name: 'secretLevel', sortable : false,width: 150,align:'center',formatter:formatLevel}
        ,{ label: '性别', name: 'sex11', width: 100 ,sortable : false,align:'center',formatter:formatSex}
        ,{ label: '性别', name: 'sex', width: 100 ,sortable : false,hidden:true}
        ,{ label: '手机', name: 'mobile', sortable : false,width: 150,align:'center' }
        ,{ label: '办公电话', name: 'officeTel',sortable : false, width: 150 ,align:'center'}
        ,{ label: '邮件', name: 'email', width: 200 ,sortable : false,align:'center'}
        ,{ label: '用户类型', name: 'consoleType', width: 150 ,sortable : false,align:'center',formatter:formatConsole}
        ,{ label: '部门', name: 'deptName', width: 150 ,sortable : false,align:'center'}
        ,{ label: '部门id', name: 'deptId', hidden:true}
        ,{ label: '岗位', name: 'positionName', width: 150 ,sortable : false,align:'center'}
        ,{ label: '是否主部门', name: 'isChiefDept',hidden:true},
        {
            label: '组织',
            name: 'orgIdentityName',
            width: 150,
            align:'center'

        },
        {
            label: 'orgIdentityId',
            name: 'orgIdentityId',
            width: 150,
            hidden: true

        },
		{
			label: 'sanyuan',
			name: 'sanyuan',
			width: 150,
			hidden: true

		}
	];
	consoleUser = new ConsoleUser('jqGrid','<%=ViewUtil.getRequestPath(request)%>'+'${'cc/cuser'}','searchDialog','form','sysUser_keyWord',searchUserMainNames,dataGridColModel);
	//添加按钮绑定事件
	$('#consoleUser_insert').bind('click', function(){
		consoleUser.insert();
	});
	$('#sysUser_searchPart').bind('click', function(){
		consoleUser.searchByKeyWord();
	});
	//编辑按钮绑定事件
	$('#consoleUser_modify').bind('click', function(){
		consoleUser.modify();
	});
	//删除按钮绑定事件
	$('#consoleUser_del').bind('click', function(){  
		consoleUser.del();
	});
	//查询按钮绑定事件
	$('#consoleUser_searchPart').bind('click', function(){
		consoleUser.searchByKeyWord();
	});
	//打开高级查询框
	$('#consoleUser_searchAll').bind('click',function(){
		consoleUser.openSearchForm(this);
	});
	 $('#rolebtn').on('click',function(){
		    new H5CommonSelect({type:'roleSelect', idFiled:'roleId',textFiled:'applyRoleidAlias'});
	});
	
	 $('#positionbtn').on('click',function(){
		    	new H5CommonSelect({type:'positionSelect', idFiled:'positionId',textFiled:'applyPositionidAlias'});
	});
		//用户无效设置
	$('#consoleUser_status').bind('click',function(){
		setValidFlag();
	});

    $('#consoleUser_org_secret').bind('click',function(){
        consoleUser.setOrgSecret();
    });
	
	
	

	$('#applyUseridAlias').on('keydown',function(e){
		if(e.keyCode != '13'){
			e.returnValue=false;
			return false;
		}
		new H5CommonSelect({type:'userSelect', idFiled:'applyUserid',textFiled:'applyUseridAlias'});//增加     selectModel: 'multi'参数,可变换为的多选
	}); 
	$('#userbtn').on('click',function(){
		new H5CommonSelect({type:'userSelect', idFiled:'applyUserid',textFiled:'applyUseridAlias'});//增加     selectModel: 'multi'参数,可变换为的多选
	});
	$('#applyDeptidAlias').on('keydown',function(e){
		if(e.keyCode != '13'){
			e.returnValue=false;
			return false;
		}
		new H5CommonSelect({type:'deptSelect', idFiled:'applyDeptid',textFiled:'applyDeptidAlias'});
	});
    $('#deptbtn').on('click',function(){
    	new H5CommonSelect({type:'deptSelect', idFiled:'applyDeptid',textFiled:'applyDeptidAlias'});
	});
	

});

/**
 * 查看兼职部门信息
 */
function havePartDept(){
 	
 	var rows = $('#jqGrid').jqGrid('getGridParam','selarrrow');
	if(rows.length == 0){
		layer.alert('请选择数据！');
		return false;
	}else if(rows.length > 1){
		
		layer.alert('请选择一条数据！');
		return false;
	}
    var rowData = $('#jqGrid').jqGrid('getRowData', rows[0]);
	if(rowData.sanyuan == "true"){
		parent.layer.alert('三员用户不允许操作！',{
					icon: 7,
					title:'提示',
					area: ['400px', ''], //宽高
					closeBtn: 0
				}
		);
		return false;
	}
    if(!checkChiefDept(rowData)){
        parent.layer.alert('选择的用户【' + rowData.name + '】数据是兼职信息，不允许设置，请重新选择！',{
                icon: 7,
                title:'提示',
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }
	deptIndex = layer.open({
	    type: 2,
	    area: ['80%', '95%'],
	    title: '兼职部门'+'【'+ rowData.name +'】',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform/console/user/toDeptList?id='+rows[0]
	});   
		
}

function doOrgSecret() {
    consoleUser.setOrgSecret();
}
/**
 * 查看兼职部门信息
 */
function havePartRole(){
 	
 	var rows = $('#jqGrid').jqGrid('getGridParam','selarrrow');
	if(rows.length == 0){
		layer.alert('请选择数据！');
		return false;
	}else if(rows.length > 1){
		
		layer.alert('请选择一条数据！');
		return false;
	}
    var rowData = $('#jqGrid').jqGrid('getRowData', rows[0]);
	if(rowData.sanyuan == "true"){
		parent.layer.alert('三员用户不允许操作！',{
					icon: 7,
					title:'提示',
					area: ['400px', ''], //宽高
					closeBtn: 0
				}
		);
		return false;
	}
    if(!checkChiefDept(rowData)){
        parent.layer.alert('选择的用户【' + rowData.name + '】数据是兼职信息，不允许设置，请重新选择！',{
                icon: 7,
                title:'提示',
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }
	deptIndex = layer.open({
	    type: 2,
	    area: ['80%', '95%'],
	    title: '角色列表'+'【'+rowData.name+'】',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform/cc/crole/toRoleList?id='+rows[0]
	});   
		
}
/**
 * 工作移交
 */
function doworkhand(){
	var rows = $('#jqGrid').jqGrid('getGridParam', 'selarrrow');
		if (rows.length == 0) {
			layer.alert('请选择数据！');
			return false;
		} else if (rows.length > 1) {
			layer.alert('请选择一条数据！');
			return false;
		}
    var rowData = $('#jqGrid').jqGrid('getRowData', rows[0]);
	if(rowData.sanyuan == "true"){
		parent.layer.alert('三员用户不允许操作！',{
					icon: 7,
					title:'提示',
					area: ['400px', ''], //宽高
					closeBtn: 0
				}
		);
		return false;
	}
    if(!checkChiefDept(rowData)){
        parent.layer.alert('选择的用户【' + rowData.name + '】数据是兼职信息，不允许移交待办，请重新选择！',{
                icon: 7,
                title:'提示',
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }
		new H5CommonSelect({
			type : 'userSelect',
			idFiled : '',
			textFiled : '',
			viewScope : 'currentOrg',
			callBack : function(user) {
				if (user.userids == "") {
					layer.alert("请选择一名用户！");
					return false;
				}
				if (user.userids == rows[0]) {
					layer.alert('不能移交给所选用户自己！');
					return false;
				}
                parent.layer.confirm('移交后无法撤销，请确认是否继续！',
                    {
                        title : '提示',
                        icon : 3,
                        closeBtn:0,
                        area: ['400px', ''],
                        btn: ['移交','取消']
                    },
                    function(index){
                        avicAjax.ajax({
                            url : 'platform/bpm/clientbpmWorkHandAction/transferAllTask',
                            data : {
                                fromUserId : rows[0],
                                toUserId : user.userids
                            },
                            type : 'post',
                            dataType : 'json',
                            success : function(r) {
                                if (r.result == true) {
                                    layer.msg("移交成功！");
                                } else {
                                    layer.alert("移交过程出错！");
                                }
                            }
                        });
					}
				);
			}
		});
	}
</script>
</html>