<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门用户管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
var path="<%=ViewUtil.getRequestPath(request)%>";
var currTreeNode,$tree;
var deptCode = "";
$(function(){ 
	$("#WORK_CALENDAR_ID").datebox({ disabled: true });
	$tree=$("#deptTree");
	initForSearch();
});

function myOnBeforeExpand(row){
	$("#deptTree").tree("options").url = "platform/sysdept/sysDeptController/getChildOrgDeptByIdAndOrgId.json?type="+row.attributes.type;
	return true;
};


/**
 * 部门树单击事件
 */
function deptTreeOnClickRow(row){
	currTreeNode=row;
	if(row.attributes.type=="dept"){
		$("#btEditDept").linkbutton('enable');
		$("#btDeleteDept").linkbutton('enable');
		$("#btLanguage").linkbutton('enable');
		$('#moveDept').linkbutton('enable');
		deptCode = row.attributes.DEPT_CODE;
	}else{
		clearDeptForm();
		setFormReadOnly(true);
		setOperationEnable(false);
		$('#moveDept').linkbutton('disable');
	}
	if (row.attributes.VALID_FLAG == "0"){
		$("#btAddDept").linkbutton('disable');
	}else{
		$("#btAddDept").linkbutton('enable');
	}
	loadSelectTabInfo(null);
}


/**
 * 清空部门表单
 */
function clearDeptForm(){
	$('#deptEditForm').form('load',{
		ID:'',
		ORG_ID:'',
		PARENT_DEPT_ID:'',
		DEPT_CODE:'',
		DEPT_NAME:'',
		DEPT_ALIAS:'',
		PARENT_DEPT_NAME:'',
		POST:'',
		TEL:'',
		FAX:'',
		EMAIL:'',
		WORK_CALENDAR_ID:'',
		ORDER_BY:'',
		ATTRIBUTE_08:'',
		DEPT_PLACE:'',
		DEPT_TYPE:'',
		ATTRIBUTE_09:'',
		VALID_FLAG:'',
		DEPT_DESC:''
		});
};

/**
 * 加载部门信息
 */
function loadDeptInfo(deptId){
	$.ajax({
        cache:false,
        type: "POST",
        url:'platform/sysdept/sysDeptController/getDeptById.json?id='+deptId,
        dataType:"json",
        data:{id:deptId},
        error: function(request) {
        	$.messager.alert('提示','操作失败，服务请求状态:'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
        },
        success: function(data) {
			if(data.result==0&&data.sysDept){
				$('#deptEditForm').form('load',data.sysDept);
			}else{
				$.messager.alert('提示',data.msg,'warning');
			}
        }
    });
};

/**懒加载tab页Iframe**/
function loadSelectTabInfo(title){
	
	if(!title){
		var tb = $('#deptUserTab').tabs('getSelected');
		var tabOptions=tb.panel('options');
		title=tabOptions.title;
	}
	
	if(title=="部门基本信息"){
		if(!currTreeNode||currTreeNode.attributes.type!="dept") return;
		loadDeptInfo(currTreeNode.id);
	}else if(title=="用户列表"){
		if(currTreeNode){
			var oldUrl=$("#iframeUserList").attr("src");
			if(oldUrl==""){
				var newUrl=path+"/avicit/platform6/modules/system/sysdept/sysuserList.jsp?id="+currTreeNode.id+"&type="+currTreeNode.attributes.type+"&name="+encodeURI(currTreeNode.text);
				$("#iframeUserList").attr("src",newUrl);
			}else{
				//函数调用
				var frm = document.getElementById("iframeUserList").contentWindow;
				frm.loadUserData(currTreeNode.id,currTreeNode.attributes.type,encodeURI(currTreeNode.text));
			}
		}else{
			var oldUrl=$("#iframeUserList").attr("src");
			if(oldUrl==""){
				var newUrl=path+"/avicit/platform6/modules/system/sysdept/sysuserList.jsp";
				$("#iframeUserList").attr("src",newUrl);
			}
		}
	}
};


/**
 *查询
**/
function initForSearch(){
 $('#searchWord').searchbox({
	 	width: 200,
        searcher: function (value) {
        	var path="platform/sysdept/sysDeptController/searchDept.json";
        	if(value==null||value==""){
        		path="platform/sysdept/sysDeptController/getChildOrgDeptByIdAndOrgId.json";
        	}
        	$.ajax({
                cache:false,
                type: "POST",
                url:path,
                dataType:"json",
                data:{search_text:value},
                async: false,
                error: function(request) {
                	alert('操作失败，服务请求状态:'+request.status+' '+request.statusText+' 请检查服务是否可用！');
                },
                success: function(data) {
					if(data.result==0){
						$('#deptEditForm')[0].reset();
						setFormReadOnly(true);
						setOperationEnable(false);
						$('#deptTree').tree('loadData',data.data);
					}else{
						$.messager.alert('提示',data.msg,'warning');
					}
                }
            });
        },
        prompt: "请输入部门名称！"
    });
};


/**
 * 设置表单是否只读
 */
function setFormReadOnly(isReadOnly){
	
	if(!isReadOnly){
		var selectNode = $('#deptTree').tree('getSelected');	
		if(!selectNode){
			$.messager.alert('提示',"请选择部门！",'warning');
		}
		
		$("form input[name!='PARENT_DEPT_NAME']").attr("disabled",false);
		//$("form input[name='DEPT_CODE']").attr("disabled",true);
		$('form textarea').attr("disabled",false);
		$("#WORK_CALENDAR_ID").datebox({ disabled: false,editable:false });
		$("#btSaveDept").linkbutton('enable');
	}else{
		$("form input[name!='PARENT_DEPT_NAME']").attr("disabled",true);
		//$("form input[name='DEPT_CODE']").attr("disabled",true);
		$("#WORK_CALENDAR_ID").datebox({ disabled: true,editable:true });
		$('form textarea').attr("disabled",true);
	}
};

/**
 * 设置操作 
 */
function setOperationEnable(isEnable){
	
	if(isEnable){
		$("#btEditDept").linkbutton('enable');
		$("#btSaveDept").linkbutton('enable');
		$("#btDeleteDept").linkbutton('enable');		
	}else{
		$("#btEditDept").linkbutton('disable');
		$("#btSaveDept").linkbutton('disable');
		$("#btDeleteDept").linkbutton('disable');
		$("#btLanguage").linkbutton('disable');
	}
};


/**
 * 刷新当前节点
 */
function updateCurrentNode(data){
	
	var selectNode = $('#deptTree').tree('getSelected');
	$('#deptTree').tree('update',{
		target: selectNode.target,
		text:data.DEPT_NAME,
		id:data.ID,
		attributes:data
	});
	
	$.messager.show({
		title : '提示',
		msg : '操作成功。',
		timeout:2000,  
        showType:'slide'  
	});
}

/**
 * 添加子节点
 */
function addChildNode(data){
	var selectNode = $('#deptTree').tree('getSelected');
	
	$('#deptTree').tree('append',{
		parent: selectNode.target,
		data:[
		      {
		    	text:data.DEPT_NAME,
		  		id:data.ID,
		  		attributes:data,
		  		iconCls:'icon-dept'
		      }
		     ]
	});
	
	var newNode = $('#deptTree').tree('find',data.ID);
	$('#deptTree').tree('select',newNode.target);
	$('#deptEditForm').form('load',data);
	currTreeNode=newNode;
	$.messager.show({
		title : '提示',
		msg : '操作成功。',
		timeout:2000,  
        showType:'slide'  
	});
}


/**
 * 刷新子节点
 */
function flushChildNodes(){
	var node = $('#deptTree').tree('getSelected');
	if(node){
		$("#deptTree").tree('reload',node.target);  //重新加载targer的子节点
	}
}

/**
 * 保存部门
 */
function saveDept(){
	$("form input[name='DEPT_CODE']").removeAttr("disabled");
	var vResult=$('#deptEditForm').form('validate');
	if(!vResult) return false;
	if (deptCode != $("#DEPT_CODE").val()){
		 $.messager.confirm('请确认','更改部门代码可能导致数据同步及相关数据操作出现问题，是否继续？',
					function(b){
					if(b){
	
	$.ajax({
        cache:false,
        type: "POST",
        url:'platform/sysdept/sysDeptController/saveDept',
        dataType:"json",
        data:$('#deptEditForm').serialize(),
        error: function(request) {
        	$.messager.alert('提示','操作失败，服务请求状态:'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
        },
        success: function(data) {
			if(data.result==0){
				if(data.opType=="update"){
					updateCurrentNode(data.sysDept);	
				}else if(data.opType="insert"){
					addChildNode(data.sysDept);
				}
			}else{
				$.messager.alert('提示',data.msg,'warning');
			}
        }
    });
	$("form input[name='DEPT_CODE']").attr("disabled",true);
					}
		 });
	 }else{
		 $.ajax({
		        cache:false,
		        type: "POST",
		        url:'platform/sysdept/sysDeptController/saveDept',
		        dataType:"json",
		        data:$('#deptEditForm').serialize(),
		        error: function(request) {
		        	$.messager.alert('提示','操作失败，服务请求状态:'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
		        },
		        success: function(data) {
					if(data.result==0){
						if(data.opType=="update"){
							updateCurrentNode(data.sysDept);	
						}else if(data.opType="insert"){
							addChildNode(data.sysDept);
						}
					}else{
						$.messager.alert('提示',data.msg,'warning');
					}
		        }
		    });
			$("form input[name='DEPT_CODE']").attr("disabled",true); 
	 }
}

/**
 * 添加部门
 */
function addDept(){
	
	var selectNode = $('#deptTree').tree('getSelected');
	if(!selectNode||selectNode.id=="root"){
		$.messager.alert('提示',"请选择组织或部门！",'warning');
		return;
	}
	
	clearDeptForm();
	
	var parentName;
	var parentId;
	var orgId;
	if(selectNode.attributes.type=="dept"){
		parentId=selectNode.id;
		parentName=selectNode.attributes.DEPT_NAME;
		orgId=selectNode.attributes.ORG_ID;
	}else if(selectNode.attributes.type=="org"){
		parentName=selectNode.attributes.ORG_NAME;
		parentId="-1";
		orgId=selectNode.id;
	}else{
		parentName=selectNode.text;
	}
	
	$('#deptEditForm').form('load',{
		PARENT_DEPT_ID:parentId,
		PARENT_DEPT_NAME:parentName,
		DEPT_TYPE:'1',
		VALID_FLAG:'1',
		ATTRIBUTE_09:'0',
		PARENT_TYPE:selectNode.attributes.type,
		ORG_ID:orgId
		});
	
	setFormReadOnly(false);
	$("form input[name='DEPT_CODE']").attr("disabled",false);
	setOperationEnable(true);
	
	$("#DEPT_CODE:focus");
	
	flushChildNodes();
}

function onTabSelect(title,index){
	loadSelectTabInfo(title);
}

/**
 * 删除部门
 */
function deleteDept(){
	
	var selectNode = $('#deptTree').tree('getSelected');
	if(!selectNode||selectNode.attributes.type!="dept"){
		$.messager.alert('提示',"请选择要删除的部门！",'warning');
		return;
	}
	
	$.messager.confirm('请确认','您确定要删除当前所选的数据？',function(b){
		if(b){
			$.ajax({
		        cache:false,
		        type: "POST",
		        url:'platform/sysdept/sysDeptController/deleteDept.json',
		        dataType:"json",
		        data:{id:selectNode.id},
		        error: function(request) {
		        	$.messager.alert('提示','操作失败，服务请求状态:'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
		        },
		        success: function(data) {
					if(data.result==0){
						var parentNode=$('#deptTree').tree('getParent',selectNode.target);
						if(parentNode){
							$('#deptTree').tree('reload',parentNode.target);
							$('#deptTree').tree('select',parentNode.target);
							deptTreeOnClickRow(parentNode);
						}else{
							alert("数据错误,该部门没有父节点");
						}
						
						$.messager.show({
							title : '提示',
							msg : '操作成功！',
							timeout:2000,  
					        showType:'slide'  
						});
					}else{
						$.messager.alert('提示',data.msg,'warning');
					}
		        }
		    });
		 } 
	  });
	
	
	
}

function formatterTree(node){
	if (node.attributes.s == '1'){
		return "<a style='color:#fff;font-weight:normal;background:#3399ff;padding:0 4px;'>"+node.text+"</a>";
	}
	if(node.attributes.VALID_FLAG ==='0' && node.attributes.VALID_FLAG){
		return '<a style="color:red;font-weight:normal;">' + node.text + '</a>';
	}else if(node.attributes.IS_MUL_ORG ==='Y' && node.attributes.IS_MUL_ORG){
		return '<a style="color:#009f49;font-weight:bold;">' + node.text + '</a>';
	}else{//正常的
		return node.text;
	}
	
};

var _defaultOpenRoot_flg = false;
function defaultOpenRoot(node, data){
	if(_defaultOpenRoot_flg){
		return;
	}
	$("#deptTree").tree("expandAll");
	_defaultOpenRoot_flg = true;
}
var moveDept=function(){
	new CommonDialog("moveDeptDlg","300","400",'platform/sysdept/move/view/'+currTreeNode.id,"移动部门到",false,true,false).show();
};
var closeMove=function(){
	$('#moveDeptDlg').dialog('close');
};
</script>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'west',split:true,title:''" style="width:250px;padding:0px;">
	 <div id="toolbar" class="datagrid-toolbar">
	 	<table width="100%">
	 		<tr>
	 			<td width="100%"><input  type="text"  name="searchWord" id="searchWord"></input></td>
	 		</tr>
	 	</table>
	 </div>
	<ul id="deptTree" class="easyui-tree" data-options="
			onLoadSuccess:defaultOpenRoot,
			url:'platform/sysdept/sysDeptController/getChildOrgDeptByIdAndOrgId.json',
			loadFilter: function(data){
	            if (data.data){	
	                return data.data;
	            } else {
	                return data;
	            }
       		},
       		lines:true,
       		dataType:'json',
       		animate:true,
       		onBeforeExpand:myOnBeforeExpand,
       		onClick:deptTreeOnClickRow,
       		formatter:formatterTree">数据加载中...</ul>
</div>
<div data-options="region:'center',split:true,title:''">
	<div id="deptUserTab" class="easyui-tabs" data-options="fit:true,plain:true,tabPosition:'top',toolPosition:'right',onSelect:onTabSelect">
		<div id="tabDept" iconCls="icon-dept" title="部门基本信息">
			<div id="toolbar" class="datagrid-toolbar">
				<sec:accesscontrollist   hasPermission="3" domainObject="pmTaskInfo_tabPower_button_btAddDept" permissionDes="添加部门">
					<a id="btAddDept"  class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addDept();" href="javascript:void(0);">添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist   hasPermission="3" domainObject="pmTaskInfo_tabPower_button_btEditDept" permissionDes="编辑部门">
					<a id="btEditDept"  class="easyui-linkbutton" iconCls="icon-edit" disabled="disabled" plain="true" onclick="setFormReadOnly(false);" href="javascript:void(0);">编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist   hasPermission="3" domainObject="pmTaskInfo_tabPower_button_btSaveDept" permissionDes="保存部门">
					<a id="btSaveDept"  class="easyui-linkbutton" iconCls="icon-save" disabled="disabled" plain="true" onclick="saveDept();" href="javascript:void(0);">保存</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist   hasPermission="3" domainObject="pmTaskInfo_tabPower_button_btDeleteDept" permissionDes="删除部门">
					<a id="btDeleteDept" class="easyui-linkbutton" iconCls="icon-remove" disabled="disabled" plain="true" onclick="deleteDept();" href="javascript:void(0);">删除</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysdept_tabPower_button_btMoveDept" permissionDes="删除部门">
					<a id="moveDept" disabled=true onclick="moveDept();" class="easyui-linkbutton" iconCls="icon-menu-transfer" plain="true" href="javascript:void(0);">移动部门</a>
				</sec:accesscontrollist>
				
			</div>
			
			<form id="deptEditForm" name="deptEditForm" method="post">
				<input type="hidden"  name="ORG_ID" id="ORG_ID"></input>
				<input type="hidden"  name="ID" id="ID"></input>
				<input type="hidden"  name="PARENT_DEPT_ID" id="PARENT_DEPT_ID"></input>
				<input type="hidden"  name="PARENT_TYPE" id="PARENT_TYPE"></input>
				<table class="form_commonTable">
				<tr>
					<sec:accesscontrollist hasPermission="3" domainObject="system_sysdept_deptEditForm_DEPT_CODE" permissionDes="部门代码">
						<th width="15%"><span class="remind">*</span>部门代码:</th>
						<td width="35%"><input class="easyui-validatebox" disabled="disabled"  data-options="required:true,validType:length[0,100]" type="text" name="DEPT_CODE" id="DEPT_CODE" ></input></td>
					</sec:accesscontrollist>
					
					<sec:accesscontrollist hasPermission="3" domainObject="system_sysdept_deptEditForm_DEPT_NAME" permissionDes="部门名称">
						<th width="15%"><span class="remind">*</span>部门名称:</th>
						<td width="35%"><input class="easyui-validatebox" disabled="disabled"  data-options="required:true" type="text" name="DEPT_NAME" id="DEPT_NAME" ></input></td>
					</sec:accesscontrollist>
				</tr>
				<tr>
					<sec:accesscontrollist hasPermission="3" domainObject="system_sysdept_deptEditForm_DEPT_ALIAS" permissionDes="部门别名">
						<th>部门别名:</th>
						<td><input class="easyui-validatebox" disabled="disabled" type="text" name="DEPT_ALIAS" id="DEPT_ALIAS" ></input></td>
					</sec:accesscontrollist>
					
					<sec:accesscontrollist hasPermission="3" domainObject="system_sysdept_deptEditForm_PARENT_DEPT_NAME" permissionDes="上级部门">
						<th>上级部门:</th>
						<td><input class="easyui-validatebox" disabled="disabled" type="text" name="PARENT_DEPT_NAME" id="PARENT_DEPT_NAME" ></input></td>
					</sec:accesscontrollist>
				</tr>
				<tr>
					<sec:accesscontrollist hasPermission="3" domainObject="system_sysdept_deptEditForm_POST" permissionDes="邮编">
						<th>邮编:</th>
						<td><input class="easyui-validatebox" disabled="disabled" type="text" name="POST" id="POST" ></input></td>
					</sec:accesscontrollist>
					
					<sec:accesscontrollist hasPermission="3" domainObject="system_sysdept_deptEditForm_TEL" permissionDes="电话">
						<th>电话:</th>
						<td><input class="easyui-validatebox" disabled="disabled" type="text" name="TEL" id="TEL" ></input></td>
					</sec:accesscontrollist>
				</tr>
				<tr>	
					<sec:accesscontrollist hasPermission="3" domainObject="system_sysdept_deptEditForm_FAX" permissionDes="传真">
						<th>传真:</th>
						<td><input class="easyui-validatebox" disabled="disabled" type="text" name="FAX" id="FAX" ></input></td>
					</sec:accesscontrollist>
					
					<sec:accesscontrollist hasPermission="3" domainObject="pmproject_pmProjectForm_editForm_EMAIL" permissionDes="邮件">
						<th>邮件:</th>
						<td><input class="easyui-validatebox" disabled="disabled" data-options="validType:'email'" type="text" name="EMAIL" id="EMAIL" ></input></td>
					</sec:accesscontrollist>
				</tr>	
				<tr>
					<sec:accesscontrollist hasPermission="3" domainObject="pmproject_pmProjectForm_editForm_WORK_CALENDAR_ID" permissionDes="工作日历">
						<th>工作日历:</th>						
						<td><input class="easyui-datebox easyui-validatebox" type="text" name="WORK_CALENDAR_ID" id="WORK_CALENDAR_ID" ></input></td>
					</sec:accesscontrollist>
					
					<sec:accesscontrollist hasPermission="3" domainObject="pmproject_pmProjectForm_editForm_ORDER_BY" permissionDes="排序编号">
						<th>排序编号:</th>
						<td><input class="easyui-numberbox" disabled="disabled" data-options="max:9999999999" type="text" name="ORDER_BY" id="ORDER_BY" ></input></td>
					</sec:accesscontrollist>
				</tr>
					
				<tr>
					<sec:accesscontrollist hasPermission="3" domainObject="pmproject_pmProjectForm_editForm_DEPT_PLACE" permissionDes="工作地点">
						<th>工作地点:</th>
						<td><input class="easyui-validatebox" disabled="disabled"  type="text"  name="DEPT_PLACE" id="DEPT_PLACE" ></input></td>
					</sec:accesscontrollist>
					
					<sec:accesscontrollist hasPermission="3" domainObject="pmproject_pmProjectForm_editForm_DEPT_TYPE" permissionDes="部门类型">
						<th><span class="remind">*</span>部门类型:</th>
						<td>
							<c:forEach items="${lookUpdeptType}" var="data">
									<input type="radio" name="DEPT_TYPE" disabled="disabled" id="DEPT_TYPE" value="${data.lookupCode}" style="width: 20px"/>${data.lookupName}
							</c:forEach>
						</td>
					</sec:accesscontrollist>
				</tr>
				<tr>
					<sec:accesscontrollist hasPermission="3" domainObject="pmproject_pmProjectForm_editForm_VALID_FLAG" permissionDes="状态">
						<th><span class="remind">*</span>状态:</th>
						<td>
							<c:forEach items="${lookUpValidFlag}" var="data">
								<input type="radio" name="VALID_FLAG" disabled="disabled" id="VALID_FLAG" value="${data.lookupCode}" style="width: 20px"/>${data.lookupName}
							</c:forEach>
						</td>
					</sec:accesscontrollist>
				</tr>
				<tr>	
					<sec:accesscontrollist hasPermission="3" domainObject="pmproject_pmProjectForm_editForm_DEPT_DESC" permissionDes="描述">
						<th>描述:</th>
						<td colspan="3">
							<textarea style="height:60px;width: 90%" disabled="disabled"  name="DEPT_DESC" id="DEPT_DESC"></textarea>
						</td>
					</sec:accesscontrollist>
				</tr>
				<tr>
					<td style="text-align:right"><span class="icon-tip"></span></td>
					<td><span class="icon-org"></span>代表组织 &nbsp;<span class="icon-dept"></span>代表部门</td>
					</div>
				</tr>
				</table>
			</form>
		</div>
		<div id="tabUserList" iconCls="icon-org-user" title="用户列表">
			<iframe id="iframeUserList" name="iframeUserList" scrolling="no" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
		</div>
	</div>
</div>
</body>
</html>