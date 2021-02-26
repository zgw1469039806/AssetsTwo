<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工作移交</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
</head>
<script type="text/javascript">
	var baseurl = '<%=ViewUtil.getRequestPath(request) %>';
	/**
	 * 
	 */
	function checkBeforeDoWorkhand() {
		var usd = new UserSelectDialog("workhandDialog", "900", "500", "avicit/platform6/bpmclient/workhand/workhandAdd.jsp", "工作移交");
		var buttons = [ {
			text : "提交",
			id : "saveFormIns",
			handler : function() {
				var frmId = $("#workhandDialog iframe").attr("id");
				var frm = document.getElementById(frmId).contentWindow;
				var receptUserName = frm.$("#receptUserName").val();
				var handEffectiveDate = frm.$("#handEffectiveDate").datebox("getValue");
				var backDate = frm.$("#backDate").datebox("getValue");
				if (receptUserName == "" || handEffectiveDate == "" || backDate == "") {
					$.messager.alert("提示", "默认接受人、生效日期、返回日期不能为空！");
					return;
				}
				if(handEffectiveDate > backDate){
					$.messager.alert("提示", "返回日期不能在生效日期之前！");
					 return;
				 }
				var dataVo = frm.$("#workhandForm").serializeArray();
				var dataJson = frm.convertToJson(dataVo);
				dataVo = JSON.stringify(dataJson);
				
				var modules = [];
				var modelflg = false;
				frm.$("#modules").find("tr").each(function(i, n){
					var modelId = $(n).find("input[name='modelId']").val();
					var userId = $(n).find("input[name='userId']").val();
					if(modelId != "" && userId != ""){
						var o = {modelId:modelId, userId:userId};
						modules.push(o);
					}else if((modelId == "") != (userId == "")){
						modelflg = true;
					}
				});
				if(modelflg){
					$.messager.alert("提示", "按模块移交信息填写不完整！");
					return;
				}
				$.ajax({
					type : "POST",
					data : {
						dataVo : dataVo,
						modules : JSON.stringify(modules)
					},
					async : false,//同步请求，防止连续点击按钮
					url : "platform/bpm/clientbpmWorkHandAction/doWorkHand",
					dataType : "json",
					success : function(r) {
						if (r.error) {
							$.messager.alert("提示", r.error);
						}else{
							$("#workhandlist").datagrid("reload");
							usd.close();
							$.messager.show({
								title : "提示",
								msg : "添加成功！"
							});
						}
					}
				});
			}
		} ];
		usd.createButtonsInDialog(buttons);
		usd.show();
	}

	/**
	 * 
	 */
	function checkBeforeCancelWorkhand() {
		var row = $("#workhandlist").datagrid("getSelected");
		if(row == null || row.validFlag == "0"){
			$.messager.alert("提示", "请选择一条有效的工作移交项进行注销！");
			return;
		}
		$.messager.confirm("操作提示", "确定注销这条数据？", function (data) {
            if (data) {
            	$.ajax({
        			type : "POST",
        			data : {
        				id : row.id
        			},
        			async : false,//同步请求，防止连续点击按钮
        			url : "platform/bpm/clientbpmWorkHandAction/cancelWorkHand",
        			dataType : "json",
        			success : function(r) {
        				if (r.error) {
        					$.messager.alert("提示", r.error);
        				}else{
        					$("#workhandlist").datagrid("reload");
        					$.messager.show({
        						title : "提示",
        						msg : "注销成功！"
        					});
        				}
        			}
        		});
            }
        });
	}
	/**
	 * 
	 */
	function myBackWorkhand() {
		var usd = new UserSelectDialog("cancelWorkhandDialog", "700", "450", "avicit/platform6/bpmclient/workhand/processWorkHandTask.jsp", "拿回工作移交待办");
		var buttons = [ {
			text : "确定",
			id : "cancelHandIns",
			handler : function() {
				var frmId = $("#cancelWorkhandDialog iframe").attr("id");
				var frm = document.getElementById(frmId).contentWindow;
				var rows = frm.$("#WorkHandTasklist").datagrid("getChecked");
				var deleteRowArr = [];
				if (rows.length > 0) {
					for (var i = 0; i < rows.length; i++) {
						deleteRowArr.push(rows[i].dbid + "@@" + rows[i].assignee + "@@" + rows[i].processInstanceId);
					}
				}else{
					$.messager.alert("提示", "没有选择任何数据！");
					return;
				}
				$.ajax({
					type : "POST",
					data : {
						deleteRows : deleteRowArr.join(',')
					},
					async : false,//同步请求，防止连续点击按钮
					url : "platform/bpm/clientbpmWorkHandAction/deleteSysWorkHandPass",
					dataType : "json",
					success : function(r) {
						if (r.error) {
							$.messager.alert("提示", r.error);
						}else{
							usd.close();
							$.messager.show({
								title : "提示",
								msg : "操作成功！"
							});
						}
					}
				});
			}
		} ];
		usd.createButtonsInDialog(buttons);
		usd.show();
	}
	
	function showWorkhand(){
		var row = $("#workhandlist").datagrid("getSelected");
		if(row == null){
			$.messager.alert("提示", "请选择一条工作移交项！");
			return;
		}
		var usd = new UserSelectDialog("showWorkhand", "900", "400", "platform/bpm/clientbpmWorkHandAction/showWorkhand?id=" + row.id, "工作移交");
		usd.show();
	}
	
	/**
	 *选择人员及部门
	 */
	function selectUserDept() {
		var usd = new UserSelectDialog('innerAddressDialog', 800, 600, getPath2() + '/platform/user/bpmSelectUserAction/userSelectCommon?isMultiple=true', '选择人员部门');
		var buttons = [ {
			text : '确定',
			id : 'processSubimt',
			handler : function() {
				var frmId = $('#innerAddressDialog iframe').attr('id');
				var frm = document.getElementById(frmId).contentWindow;
				var resultDatas = frm.getSelectedResultDataJson();
				var frmResultId = $('#workhandDialog iframe').attr('id');
				var frmResult = document.getElementById(frmResultId).contentWindow;
				if (resultDatas.length > 1) {
					alert("只能选择一位接受人！");
					return;
				}
				for (var i = 0; i < resultDatas.length; i++) {
					var resultData = resultDatas[i];
					frmResult.$("#receptUserId").val(resultData.userId);
					frmResult.$("#receptUserName").val(resultData.userName);
					frmResult.$("#receptDeptId").val(resultData.deptId);
					frmResult.$("#receptDeptName").val(resultData.deptName);
				}
				usd.close();
			}
		} ];
		usd.createButtonsInDialog(buttons);
		usd.show();
	}
	//查询
	function searchFun() {
		var queryParams = {
				filter_EQ_validFlag : $('#filter_EQ_validFlag').combobox('getValue'),
				filter_LE_handEffectiveDate : $('#filter_LE_handEffectiveDate').datetimebox('getValue'),
				filter_GE_handEffectiveDate : $('#filter_GE_handEffectiveDate').datetimebox('getValue')
		};
		$("#workhandlist").datagrid("uncheckAll").datagrid("unselectAll").datagrid("clearSelections");
		$("#workhandlist").datagrid("load", queryParams);
	}
	function clearFun() {
		$('#searchForm input').val('');
		$('#searchForm select').val('');
	}
</script>
<body class="easyui-layout" fit="true">
	<div data-options="region:'north',split:false,border:false"
		style="height:70px">
		<fieldset>
			<legend>查询条件</legend>
			<table class="tableForm" id="searchForm">
				<tr>
					<td>生效日期(起)</td>
					<td style="width:170px"><input name="filter_GE_handEffectiveDate" id="filter_GE_handEffectiveDate" class="easyui-datebox" editable="false" style="width: 150px;" /></td>
					<td>生效日期(止)</td>
					<td style="width:170px"><input name="filter_LE_handEffectiveDate" id="filter_LE_handEffectiveDate" class="easyui-datebox" editable="false" style="width: 150px;" /></td>
					<td>是否有效</td>
					<td style="width:170px">
						<select name="filter_EQ_validFlag" id="filter_EQ_validFlag" class="easyui-combobox" style="width: 156px;">
							<option value=""></option>
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>
					</td>
					<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchFun();" href="javascript:void(0);">查询</a><a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="clearFun();" href="javascript:void(0);">清空</a></td>
				</tr>
			</table>
		</fieldset>
	</div>
	<div data-options="region:'center',split:false,border:false">
		<table id="workhandlist" class="easyui-datagrid"
			data-options="fit: true,
						url:'platform/bpm/clientbpmWorkHandAction/getSysWorkHandListByPage.json',
						queryParams:{filter_EQ_workOwnerId : ''},
						sortName: 'handEffectiveDate',
						toolbar:'#myToolbar',
						sortOrder: 'desc',
						border: false,
						rownumbers: true,
						animate: true,
						fitColumns: true,
						autoRowHeight: false,
						idField :'id',
						singleSelect: true,
						pagination:true,
						pageSize:dataOptions.pageSize,
						pageList:dataOptions.pageList,
						striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', hidden:true">id</th>
					<th data-options="field:'workOwnerName',align:'left',sortable:true" width="25">移交人</th>
					<th data-options="field:'workOwnerDeptName',align:'left',sortable:true" width="25">移交部门</th>
					<th data-options="field:'receptUserName',align:'left',sortable:true" width="25">接受人</th>
					<th data-options="field:'receptDeptName',align:'left',sortable:true" width="25">接受人部门</th>
					<th data-options="field:'handReason',align:'left',sortable:true" width="80">移交原因</th>
					<th data-options="field:'handEffectiveDate',align:'left',sortable:true,formatter:formatDate" width="25">生效日期</th>
					<th data-options="field:'backDate',align:'left',sortable:true,formatter:formatDate" width="25">预计返回日期</th>
					<th data-options="field:'handDate',align:'left',sortable:true,formatter:formatDate" width="25">登记日期</th>
					<th data-options="field:'validFlag',align:'left',sortable:true,formatter:formatValidFlag" width="15">是否有效</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="myToolbar" class="datagrid-toolbar">
		<table>
			<tr>
				<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="checkBeforeDoWorkhand();" href="javascript:void(0);">添加工作移交</a></td>
				<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="checkBeforeCancelWorkhand();" href="javascript:void(0);">注销工作移交</a></td>
				<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="myBackWorkhand();" href="javascript:void(0);">拿回已移交的待办</a></td>
				<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="showWorkhand();" href="javascript:void(0);">详细信息</a></td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
		function formatDate(value, rec) {
			var newDate = new Date(value);
			return newDate.Format("yyyy-MM-dd");
		}
		function formatValidFlag(value, rec) {
			if (value == '1') {
				return "有效";
			} else {
				return "无效";
			}
		}
	</script>
</body>
</html>