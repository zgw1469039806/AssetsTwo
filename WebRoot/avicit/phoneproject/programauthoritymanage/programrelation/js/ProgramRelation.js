$(function(){
	//关系标签页的选中事件
	$("#comprehensiveTabControl").tabs({
        onSelect:function(title,index){
          if(index==0){
        	  tabIndex=0;
        	  $("#dgDept").datagrid("unselectAll").datagrid("uncheckAll");
              loadDeptRelation(programId);
          }else if(index==1){
        	  tabIndex=1;
        	  $("#dgUser").datagrid("unselectAll").datagrid("uncheckAll");
              loadUserRelation(programId);
          }else{
        	  tabIndex=2;
        	  $("#dgRole").datagrid("unselectAll").datagrid("uncheckAll");
              loadRoleRelation(programId);
          }
        }
      });
});

/**
 * 选择部门
 * @date 2017-3-2上午10:23:31
 * @author yupengfei
 */
function mySelectDept(){
	var deptSelector = new CommonSelector("dept","deptSelectCommonDialog","deptId","deptName",null,null,null,false,null,null,600,400);
	deptSelector.init(false,"selectDeptCallBack",'n');
}

/**
 * 选择用户
 * @date 2017-3-2上午10:23:40
 * @author yupengfei
 */
function insertUser(){
	var comSelector = new CommonSelector("user","userSelectCommonDialog","userId","userName",null,null,null,false,null,null,600,400);
	comSelector.init(false,'selectUserCallBack','n');
}

/**
 * 选择角色
 * @date 2017-3-2上午10:23:48
 * @author yupengfei
 */
function insertRole(){
	var roleSelector = new CommonSelector("role","roleSelectCommonDialog","selectRoleId","selectRoleName",null,null,null,false,null,null,600,400);
	roleSelector.init(false,'selectRoleCallBack','n');
}

/**
 * 用于选择部门/人员/角色后向关系表传参
 * @param proRalaObjectId 部门/人员/角色id
 * @param proRalaType 关系类型
 * @date 2017-3-2上午10:24:17
 * @author yupengfei
 */
function Relation(proRalaObjectId,proRalaType){
	this.programId=programId;
	this.proRalaType=proRalaType;
	this.proRalaObjectId=proRalaObjectId;
};

/**
 * 选择部门后回调
 * @param data 选中的部门数据
 * @date 2017-3-2上午10:25:01
 * @author yupengfei
 */
function selectDeptCallBack(data){
	var relations=[];
	for(var i=0;i<data.length;i++){
		relations.push(new Relation(data[i].deptId,"1"));
	} 
	$.ajax({
		url:"platform/phoneproject/programmanage/portalprogram/PortalProgramManageController/addAuthority",
		type:"post",
		data:JSON.stringify(relations),
		contentType:'application/json;charset=utf-8',
		dataType : 'json',
		success:function(result){
			loadRelationData(tabIndex);
		}
	});
}

/**
 * 选择用户后回调
 * @param data 选中的用户数据
 * @date 2017-3-2上午10:25:19
 * @author yupengfei
 */
function selectUserCallBack(data){
	var relations=[];
	for(var i=0;i<data.length;i++){
		relations.push(new Relation(data[i].userId,"2"));
	} 
	$.ajax({
		url:"platform/phoneproject/programmanage/portalprogram/PortalProgramManageController/addAuthority",
		type:"post",
		data:JSON.stringify(relations),
		contentType:'application/json;charset=utf-8',
		dataType : 'json',
		success:function(result){
			loadRelationData(tabIndex);
		}
	});
}

/**
 * 选择角色后回调
 * @param data 选中的角色数据
 * @date 2017-3-2上午10:25:34
 * @author yupengfei
 */
function selectRoleCallBack(data){
	var relations=[];
	for(var i=0;i<data.length;i++){
		relations.push(new Relation(data[i].id,"3"));
	} 
	$.ajax({
		url:"platform/phoneproject/programmanage/portalprogram/PortalProgramManageController/addAuthority",
		type:"post",
		data:JSON.stringify(relations),
		contentType:'application/json;charset=utf-8',
		dataType : 'json',
		success:function(result){
			loadRelationData(tabIndex);
		}
	});
}

/**
 * 删除权限
 * @date 2017-3-2上午10:25:46
 * @author yupengfei
 */
function deleteAuthority(){
	var rows;
	if(tabIndex==0){
		rows=$("#dgDept").datagrid('getChecked');
	}else if(tabIndex==1){
		rows=$("#dgUser").datagrid('getChecked');
	}else{
		rows=$("#dgRole").datagrid('getChecked');
	}
	var ids=[];
	var l =rows.length;
	if(l > 0){
	  $.messager.confirm('请确认','您确定要删除当前所选的数据？',function(b){
		 if(b){
			 for(;l--;){
				 ids.push(rows[l].id);
			 }
			 $.ajax({
				 url:"platform/phoneproject/programmanage/portalprogram/PortalProgramManageController/deleteAuthority",
				 data:JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 loadRelationData(tabIndex);
						 $.messager.show({
							 title : '提示',
							 msg : '删除成功！'
						});
					}else{
						$.messager.show({
							 title : '提示',
							 msg : r.error
						});
					}
				 }
			 });
		 } 
	  });
	}else{
	  $.messager.alert('提示','请选择要删除的记录！','warning');
	}
} 

/**
 * 按部门查询权限
 * @param value 部门页下搜索框的值
 * @date 2017-3-2上午10:26:02
 * @author yupengfei
 */
function searchDept(value){
	var param={deptName:value,deptCode:value,programId:programId,proRalaType:1};
	$("#dgDept").datagrid('load',{ param : JSON.stringify(param)});
}

/**
 * 按用户查询权限
 * @param value 用户页下搜索框的值
 * @date 2017-3-2上午10:27:03
 * @author yupengfei
 */
function searchUser(value){
	var param={username:value,loginName:value,programId:programId,proRalaType:2};
	$("#dgUser").datagrid('load',{ param : JSON.stringify(param)});
}

/**
 * 按角色查询权限
 * @param value 角色页下搜索框的值
 * @date 2017-3-2上午10:27:23
 * @author yupengfei
 */
function searchRole(value){
	var param={roleName:value,roleCode:value,programId:programId,proRalaType:3};
	$("#dgRole").datagrid('load',{ param : JSON.stringify(param)});
}

/**
 * 加载部门权限信息
 * @param programId 应用id
 * @date 2017-3-2上午10:27:45
 * @author yupengfei
 */
function loadDeptRelation(programId){
	var param={programId:programId,proRalaType:"1"};
	$("#dgDept").datagrid({
		url:"platform/phoneproject/programmanage/portalprogram/PortalProgramManageController/findDeptRelationByPage",
		queryParams:{param:JSON.stringify(param)}
	});
	$("#dgDept").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
}

/**
 * 加载用户权限信息
 * @param programId 应用id
 * @date 2017-3-2上午10:27:57
 * @author yupengfei
 */
function loadUserRelation(programId){
	var param={programId:programId,proRalaType:"2"};
	$("#dgUser").datagrid({
		url:"platform/phoneproject/programmanage/portalprogram/PortalProgramManageController/findUserRelationByPage",
		queryParams:{param:JSON.stringify(param)}
	});
	$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
}

/**
 * 加载角色权限信息
 * @param programId 应用id
 * @date 2017-3-2上午10:28:10
 * @author yupengfei
 */
function loadRoleRelation(programId){
	var param={programId:programId,proRalaType:"3"};
	$("#dgRole").datagrid({
		url:"platform/phoneproject/programmanage/portalprogram/PortalProgramManageController/findRoleRelationByPage",
		queryParams:{param:JSON.stringify(param)}
	});
	$("#dgRole").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
}