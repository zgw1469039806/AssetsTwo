<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.api.session.SessionHelper"%>

<%@ page import="avicit.platform6.api.sysshirolog.utils.SecurityUtil"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";	
String username = SessionHelper.getLoginName(request);
Boolean isAdmin = SecurityUtil.isAdministrator(username);
%>
<!DOCTYPE html>
<html>
<head>
<title>兼职部门列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_deptlist_button_add"
				permissionDes="添加">
				<a id="deptlist_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_deptlist_button_del"
				permissionDes="删除">
				<a id="deptlist_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_deptlist_button_save"
				permissionDes="保存">
				<a id="deptlist_save" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
			</sec:accesscontrollist>
		</div>
		
	</div>
	<table id="deptlistjqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/console/user/js/deptlist.js" type="text/javascript"></script>
<script type="text/javascript">

var isAdmin ="<%=isAdmin%>";

function formatValid(cellvalue, options, rowObject) {
	if(cellvalue=="1"||cellvalue=="有效"){
		return "有效";
	}else{
		return "无效";
	}
}

function formatDept(cellvalue, options, rowObject) {
	if(cellvalue=="1"){
		return "是";
	}else{
		return "否";
	}
}

function formatManager(cellvalue, options, rowObject) {
	
	if(cellvalue=="1"){
		return "是";
	}else{
		return "否";
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

	var deptlist;
	$(document).ready(
					function() {
						var dataGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 75,
							hidden : true
						}, {
							label : 'deptId',
							name : 'deptId',
							width : 150,
							editable : true,
							hidden : true
							
						}, {
							label : '部门名称',
							name : 'deptName',
							width : 150,
							editable : true,
							sortable: false,
							edittype : 'custom',
							
							editoptions : {
								custom_element : deptcustomElem,
								custom_value : deptcustomValue,
								forId : 'deptId'
							}
						}, {
							label : '岗位ID',
							name : 'positionId',
							width : 75,
							hidden : true,
							editable : true
						}, {
							label : '岗位名称',
							name : 'positionName',
							width : 150,
							editable : true,
							sortable: false,
							edittype : 'custom',
							editoptions : {
								custom_element : positioncustomElem,
								custom_value : positioncustomValue,
								forId : 'positionId'
							}
							
						}, {
							label : '部门有效标识',
							name : 'validFlag',
							width : 150,
							sortable: false,
							formatter:formatValid,
							editoptions:{
							
							defaultValue:'1',
							NullIfEmpty:true
								
							
							}
							
						}, /*{
							label : '主部门',
							name : 'isChiefDept',
							width : 150,
							editable : true,
							formatter:formatDept,
							edittype : 'select',
							editoptions:{value:{0:'否',1:'是'}}
							
							
						},*/ {
							label : '是否主管',
							name : 'isManager',
							width : 150,
							sortable: false,
							editable : true,
							formatter:formatManager,
							edittype : 'select',
							editoptions:{value:{0:'否',1:'是'}}
						},
                            {
                                label: '所属组织',
                                name: 'orgIdentity',
                                width: 150,
								sortable: false,

                                formatter: formatOrg

                            },
                            {
                                label: 'orgIdentityId',
                                name: 'orgIdentityId',
                                width: 150,
                                hidden: true

                            }
						 ];
						
						
						deptlist = new DeptList('deptlistjqGrid', 'platform/console/user/getMapDept?id='+'${id}',dataGridColModel,'${id}');
						//添加按钮绑定事件
						$('#deptlist_insert').bind('click', function() {
							deptlist.insert();
						});
						//删除按钮绑定事件
						$('#deptlist_del').bind('click', function() {
							deptlist.del();
						});
						//保存按钮绑定事件
						$('#deptlist_save').bind('click', function() {
							$('a#deptlist_save').attr("disabled","disabled");
							deptlist.save();
							setTimeout(function(){ $('a#deptlist_save').removeAttr("disabled"); }, 1000);

						});


					});

</script>
</html>