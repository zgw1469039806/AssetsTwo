<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input class="form-control input-sm" type="hidden"  type="text" id="handDate" name="handDate" readonly>
			<input type="hidden" name="id" />
			<input type="hidden" name="validFlag" id="validFlag" value="1">
			<table class="form_commonTable">
				<tr>
					<th width="12%"
						style="word-break: break-all; word-warp: break-word;">委托人:</th>
					<td width="37%">
						<input name="workOwnerId" id="workOwnerId"  style="display:none;" value="">
                    	<input type="text" name="workOwnerName" id="workOwnerName" class="easyui-validatebox" readonly="readonly" value="">
					</td>
					<th width="12%"
						style="word-break: break-all; word-warp: break-word;">委托人部门:</th>
					<td width="37%">
						<input name="workOwnerDeptId" id="workOwnerDeptId" style="display:none;" value="">
                    	<input title="委托人部门" class="easyui-validatebox" type="text" name="workOwnerDeptName" id="workOwnerDeptName" readonly value=""/>
					</td>
				</tr>
				<tr>
					<th width="12%"
						style="word-break: break-all; word-warp: break-word;"><span class="remind">*</span>默认受托人:</th>
					<td width="37%">
					<div class="ext-selector-div" style="width: 100%;">
							<input class="easyui-validatebox ext-selector-input" 
								type="text" title="姓名" placeholder="请选择用户" title="请选择用户"
								name="receptUserName" data-options="required:true" id="receptUserName" readonly/>
							<input name="receptUserId" id="receptUserId" style="display:none;">
							<span class="ext-input-right-icon icon-all-file ext-input-right-icon-from"></span>
					</div>
					</td>

					<th width="12%"
						style="word-break: break-all; word-warp: break-word;"><span class="remind">*</span>受托人部门:</th>
					<td width="37%">
						<input name="receptDeptId" id="receptDeptId" style="display:none;">
						<input type="text" class="easyui-validatebox" name="receptDeptName" id="receptDeptName" readonly>
					</td>
				</tr>
				<tr>

					<th width="12%"
						style="word-break: break-all; word-warp: break-word;"><span class="remind">*</span>起始日期:</th>
					<td width="37%"><input title="起始日期" class="easyui-datebox"
						editable="false" style="width: 99%;" type="text"
						name="handEffectiveDate" id="handEffectiveDate"  data-options="required:true"/></td>

					<th width="12%"
						style="word-break: break-all; word-warp: break-word;"><span class="remind">*</span>截止时间:</th>
					<td width="37%"><input title="截止时间" class="easyui-datebox"
						editable="false" style="width: 99%;" type="text"
						name="backDate" id="backDate" data-options="required:true"/></td>
				</tr>
				<tr>

					<th width="12%"
						style="word-break: break-all; word-warp: break-word;">委托已有待办事宜:</th>
					<td width="39%">
					 	<input type="checkbox" id="handAcceptedTask" name="handAcceptedTask" value="1" checked/>
                	</td>
					<th width="12%"
						style="word-break: break-all; word-warp: break-word;">到期后自动注销:</th>
					<td width="39%">
					 	<input type="checkbox" id="expireAutoCancel" name="expireAutoCancel" value="1" checked />
                	</td>
				</tr>
				<tr>

					<th width="12%"
						style="word-break: break-all; word-warp: break-word;">委托原因:</th>
					<td width="37%">
						<input type="text" class="easyui-validatebox" name="handReason" id="handReason">
					</td>
				</tr>
				<tr>
					<th width="12%"
							style="word-break: break-all; word-warp: break-word;">自定义委托:</th>
					<td width="84%" colspan="3" >
						<div style="display: table-cell;vertical-align: middle;hieght:33px;"> <input type="checkbox" id="customWorkhand" name="customWorkhand">  (注:配置特定流程的委托人)</div>
					</td>
				</tr>
			</table>
		</form>
	<form id="moduleForm">
	<table class="form_commonTable" style="display:none;" id="customTable">
		<tr>
			<td colspan="5">
				<div style="float: right;">
					<a class="easyui-linkbutton" iconCls="icon-add"  href="javascript:void(0);" id="addModule">添加</a>
				</div>
			</td>
		</tr>
	</table>
	</form>
	
<div id="template" style="display:none;">
	<table>
	<tr>
		<th width="10%" style="word-break: break-all; word-wrap: break-word;"><label>委托范围:</label></th>
		<td width="36%">
				<div class="ext-selector-div" style="width: 100%;">
							<input class="easyui-validatebox ext-selector-input myflowclass" 
								type="text" placeholder="请选择流程" title="请选择流程"
								name="moduleName" data-options="required:true" readonly/>
							<input name="moduleId" style="display:none;">
							<span class="ext-input-right-icon icon-all-file ext-input-right-icon-from"></span>
					</div>
			</td>
		<th width="10%" style="word-break: break-all; word-warp: break-word;"><label>受托人:</label></th>
		<td width="36%">
				<div class="ext-selector-div" style="width: 100%;">
						<input class="easyui-validatebox ext-selector-input myuserclass" 
								type="text" placeholder="请选择用户" title="请选择用户"
								name="myWorkHandText" data-options="required:true" readonly/>
						<input name="myWorkHandId" style="display:none;">
						<span class="ext-input-right-icon icon-all-file ext-input-right-icon-from"></span>
				</div>
			</td>
		<td width="10%">
			<div style="float: right;">
				<a class="easyui-linkbutton moduleDelete" iconCls="icon-remove" href="javascript:void(0);">删除</a>
			</div>
		</td>
	</tr>
	</table>
</div>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
				  	<td width="50%" align="right">
						<a title="保存" id="saveButton" class="easyui-linkbutton primary-btn" href="javascript:void(0);">保存</a> 
						<a title="返回" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a>
				  	</td>
				</tr>
			</table>
		</div>
	</div>
</body>
<script type="text/javascript"
	src="avicit/platform6/bpmfixie/bpmcommon/flowUtils.js"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowButtons.js"></script>
<script type="text/javascript" 
	src="avicit/platform6/bpmfixie/bpmbusiness/workhand/js/BpmModuleSelect_easyui.js"></script>
<script type="text/javascript">
    document.ready = function () {
    //选人1		
	$("#receptUserName").on('click', function(e) {
			new EasyuiCommonSelect({
				type : 'userSelect',
				idFiled : 'receptUserId',
				textFiled : 'receptUserName',
				callBack : function(data) {
					$("#receptDeptName").val(data.userdeptnames);
					$("#receptDeptId").val(data.userdeptids);
				},
				viewScope : 'currentOrg'
			});
			this.blur();
		});
		//inputPlaceHolder();	
		
 		 $.ajax({
			url : "platform/bpm/clientbpmWorkHandAction/addWorkHand",
			type : 'post',
			dataType : 'json',
			success : function(d) {
				var workHandVo = d.workHand;
				$("#workOwnerId").val(workHandVo.workOwnerId);
				$("#workOwnerName").val(workHandVo.workOwnerName);
				$("#workOwnerDeptId").val(workHandVo.workOwnerDeptId);
				$("#workOwnerDeptName").val(workHandVo.workOwnerDeptName);
				$("#receptUserId").val(workHandVo.receptUserId);
				$("#receptDeptId").val(workHandVo.receptDeptId);
				$("#receptUserName").val(workHandVo.receptUserName);
				$("#receptDeptName").val(workHandVo.receptDeptName);
				$("#handDate").val((new Date()).format("yyyy-MM-dd"));
			}
		});
		$("#customWorkhand").on('click', function() {
            if(this.checked == true) {
            	$("#customTable").show();
               	$("#addModule").trigger("click");
			   }  else {
                $("#customTable").hide();
                $("#customTable tr").slice(1).remove();
			   }
			}); 
		$("#addModule").on('click',function(){
            var id = flowUtils.guid();
			var temp = $("#template").find("tr").eq(0).clone(true, true);
			temp.find("input[name='moduleName']").attr("id", "moduleName" + id);
			temp.find("input[name='moduleId']").attr("id", "moduleId" + id);
			temp.find("input[name='myWorkHandText']").attr("id", "myWorkHandText" + id);
			temp.find("input[name='myWorkHandId']").attr("id", "myWorkHandId" + id);
			temp.appendTo($("#customTable"));
		});
   //保存按钮绑定事件 
	$('#saveButton').on('click', function() {
			var validateFlag = $("#form").form('validate');
			if (validateFlag == false) {
				return;
			} 
			// 校验是否选择了流程
			if ($("#customTable:hidden").length == 0) {
				var flag = false;
				if ($("#customTable").find("tr:gt(0)").length <= 0) {
					flowUtils.warning("您还没有添加流程委托范围");
					return;
				}
				$("#customTable").find("input").each(function() {
					if ($(this).val() == "") {
						flag = true;
						return false;
					}
				});
				if (flag) {
					flowUtils.warning("您还没有选择流程委托范围");
					return;
				}
			}
			parent.entrustGrid.save($("#form"), $("#moduleForm"));
		});
	};
	
	$(".moduleDelete").on('click', function() {
		$(this).parent().parent().parent().remove();
	});
	
	$(".myuserclass").on('click', function() {
		var that = $(this);
		new EasyuiCommonSelect({
			type : 'userSelect',
			idFiled : that.next().attr("id"),
			textFiled : that.attr("id"),
			viewScope : 'currentOrg'
		});
		this.blur();
	});
	$(".myflowclass").on('click', function() {
		var that = $(this);
		new BpmModuleSelect(that.next().attr("id"), that.attr("id"), function(data){
			that.next().val(data.ids);
			that.val(data.texts);
		}, true);
		this.blur();
	});
	
	//返回按钮绑定事件
	function closeForm() {
		parent.entrustGrid.closeDialog(window.name);
	}
</script>
</html>