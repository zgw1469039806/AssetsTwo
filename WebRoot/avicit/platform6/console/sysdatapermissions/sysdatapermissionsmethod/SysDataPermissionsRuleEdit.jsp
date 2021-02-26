<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/select2/select2.css"/>
<style type="text/css">
	.sysdatapermissionTips{
		float: left;
	    width: 16px;
	    height: 16px;
	    background-image: url(static/images/platform/common/tips.png);
	    margin-right: 3px;
	    margin-top: 7px;
	}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<h3 style="text-align: center; font-weight: 600;">编辑规则</h3>
		<form id='form'>
			<input type="hidden" name="id" value="<c:out  value='${sysDataPermissionsRuleDTO.id}'/>" /> 
			<input type="hidden" name="version" value="<c:out  value='${sysDataPermissionsRuleDTO.version}'/>" />
			<input type="hidden" name="methodId" value="<c:out  value='${sysDataPermissionsRuleDTO.methodId}'/>" />
			<input type="hidden" id="dialogId" />
			<input type="hidden" id="dialogName" />
			
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="ruleName">规则名称:</label></th>
					<td width="23%"><input class="form-control input-sm"
						type="text" name="ruleName" id="ruleName"
						value="<c:out  value='${sysDataPermissionsRuleDTO.ruleName}'/>" />
					</td>
					
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="ruleRemarks">规则描述:</label></th>
					<td width="23%"><input class="form-control input-sm"
						type="text" name="ruleRemarks" id="ruleRemarks"
						value="<c:out  value='${sysDataPermissionsRuleDTO.ruleRemarks}'/>" />
					</td>
					
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="orderBy">排序号:</label></th>
					<td width="23%">
						<div class="input-group input-group-sm spinner"
							data-trigger="spinner">
							<input class="form-control" type="text" name="orderBy"
								id="orderBy"
								value="<c:out  value='${sysDataPermissionsRuleDTO.orderBy}'/>"
								data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
								data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1"
								data-precision="0"> <span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i
									class="glyphicon glyphicon-triangle-top"></i></a> <a
								href="javascript:;" class="spin-down" data-spin="down"><i
									class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>
				</tr>
				
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="matchSymbol">相邻规则匹配符:</label></th>
					<td width="23%">
						<label class="radio-inline">
							<input type="radio" name="matchSymbol" id="matchSymbol0" value="0"/>或（or）
						</label>
						<label class="radio-inline">
							<input type="radio" name="matchSymbol" id="matchSymbol1" value="1"/>且（and）
						</label>
					</td>
					
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="state">状态:</label></th>
					<td width="23%">
						<label class="radio-inline">
							<input type="radio" name="state" id="state0" value="0"/>有效
						</label>
						<label class="radio-inline">
							<input type="radio" name="state" id="state1" value="1"/>无效
						</label>
					</td>
					
					<th width="10%"><label>原sql预览:</label></th>
					<td width="23%">
						<select id="showOldSqlSelect" class="form-control input-sm">${selectHtml }</select>
					</td>
				</tr>
				
				<tr>
					<th width="10%"><label>规则类型:</label></th>
					<td colspan="3">
						<label class="radio-inline">
							<input type="radio" name="ruleType" id="ruleType0" value="0" />配置字段
						</label>
						<label class="radio-inline">
							<input type="radio" name="ruleType" id="ruleType1" value="1" />配置自定义类
						</label>
					</td>
					<th width="10%"></th>
					<td width="23%" rowspan="4" id="textareaHtmlTd">${textareaHtml }</td>
				</tr>
				
				<tr class="columnTr">
					<th width="10%"><label for="columnName">字段:</label></th>
					<td width="23%" colspan="3" style="padding-left: 0px;">
						<table style="width: 100%;">
							<tr>
								<td style="width: 40%;">
									<select class="js-example-basic-multiple" id="columnName" name="columnName" style="width: 100%;">${selectColumnHtml }</select>
								</td>
								<td style="width: 10%;">
									<select class="js-example-basic-multiple" id="columnSymbol" name="columnSymbol" style="width: 100%;">
										<option value="=">等于</option>
										<option value="!=">不等于</option>
										<option value="in">包含</option>
										<option value="exists">存在</option>
										<option value="not exists">不存在</option>
										<option value="is null">为空</option>
										<option value="is not null">非空</option>
										<option value=">">大于</option>
										<option value=">=">大于等于</option>
										<option value="<">小于</option>
										<option value="<=">小于等于</option>
									</select>
								</td>
								<td style="width: 30%;">
									<div class="sysdatapermissionTips"></div>
									<select class="js-example-basic-multiple" id="columnType" name="columnType" style="width: 80%;">
										<option value="">输入值</option>
										<option value="loginUserId">登录人ID</option>
										<option value="loginDeptId">登录人部门ID</option>
										<option value="loginOrgId">登录人组织ID</option>
										<option value="loginUserSecretLevel">登录人密级</option>
										<option value="appId">应用标识</option>
									</select>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr class="columnTr">
					<th width="10%"><label for="filterConditionSql">过滤条件SQL:</label></th>
					<td width="23%" colspan="3">
						<textarea class="form-control input-sm" name="filterConditionSql" id="filterConditionSql" rows="5">${sysDataPermissionsRuleDTO.filterConditionSql}</textarea>
					</td>
				</tr>
				<tr class="columnTr">
					<th width="10%"><label for="filterCondition">过滤条件:</label></th>
					<td width="23%" colspan="3">
						<textarea class="form-control input-sm" name="filterCondition" id="filterCondition" rows="5">${sysDataPermissionsRuleDTO.filterCondition}</textarea>
					</td>
				</tr>
				
				<tr class="classTr" style="display: none;">
					<th width="10%">类+方法路径:</th>
					<td width="23%" colspan="3">
						自定义方法实现规则：可以是任意类中的方法，方法名称自定义无要求，方法必须存在一个形参Map，可从Map中获得登录人ID等信息，方法返回值必须为String。 <a onclick="example();" href="javascript:void(0);">查看示例</a>
						<textarea class="form-control input-sm" name="columnValue" id="columnValue" rows="3">${sysDataPermissionsRuleDTO.columnValue}</textarea>
					</td>
				</tr>
				<tr class="classTr" style="display: none;">
					<th width="10%">模拟调用自定义方法:</th>
					<td width="23%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="simulationUser" name="simulationUser">
							<input class="form-control" placeholder="请选择模拟用户" type="text" id="simulationUserAlias" name="simulationUserAlias">
							<span class="input-group-addon"> <i
								class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
					<td>
						<a class="btn btn-primary form-tool-btn btn-sm" role="button" onclick="simulationSql();" href="javascript:void(0);" style="margin: 0px;">模拟</a>
					</td>
				</tr>
				<tr class="classTr" style="display: none;height: 37%;">
					<th width="10%"></th>
					<td width="23%" colspan="3">
						<textarea class="form-control input-sm" id="customSql" rows="6" disabled="disabled"></textarea>
					</td>
				</tr>

			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
						title="保存" id="sysDataPermissionsRule_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="sysDataPermissionsRule_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	
	<script type="text/javascript" src="static/h5/select2/select2.js"></script>
	<script type="text/javascript" src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/js/symbol.js?v=<%=System.currentTimeMillis() %>"></script>
	
	<script type="text/javascript">
		function closeForm() {
			parent.sysDataPermissionsRule.closeDialog("edit");
		}
		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}
			
			var ruleTypeVal = $("input[name='ruleType']:checked").val();
			if(ruleTypeVal == "0"){ // 配置字段
				var filterConditionSql = $("#filterConditionSql").val();
				var filterCondition = $("#filterCondition").val();
				if("" == filterConditionSql){
					layer.msg("请填写过滤条件SQL");
					return false;
				}
				if("" == filterCondition){
					layer.msg("请填写过滤条件");
					return false;
				}
				$("#columnValue").val("");
			} else if(ruleTypeVal == "1"){ // 配置类
				var columnValue = $("#columnValue").val();
				if("" == columnValue){
					layer.msg("请配置自定义类+方法名称");
					return false;
				}
				$("#filterConditionSql").val("");
				$("#filterCondition").val("");
			}
			
			$("#methodId").val(parent.sysDataPermissionsRule.pid);
			//限制保存按钮多次点击
			$('#sysDataPermissionsRule_saveForm').addClass('disabled').unbind(
					"click");
			parent.sysDataPermissionsRule.save($('#form'), "eidt");
		}
		function init(){
			var matchSymbolVal = '${sysDataPermissionsRuleDTO.matchSymbol}';
			if(matchSymbolVal == "0"){
				$("#matchSymbol0").attr("checked",true);
			} else {
				$("#matchSymbol1").attr("checked",true);
			}

			var stateVal = '${sysDataPermissionsRuleDTO.state}';
			if(stateVal == "0"){
				$("#state0").attr("checked",true);
			} else {
				$("#state1").attr("checked",true);
			}
			
			var columnValue = '${sysDataPermissionsRuleDTO.columnValue}';
			if(columnValue == ""){
				$("#ruleType0").attr("checked",true);
				$(".columnTr").show();
				$(".classTr").hide();
			} else {
				$("#ruleType1").attr("checked",true);
				$(".columnTr").hide();
				$(".classTr").show();
			}
		}
		function example(){
			layer.open({
	            type: 2,
	            title: "自定义方法示例",
	            skin: 'layui-layer-rim',
	            area: ['70%', '80%'],
	            content: 'avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/example.jsp',
	            btn: ['返回'],
	            success: function (layero, index) {
	            }
	        });
		}
		
		function simulationSql(){
			var columnValue = $("#columnValue").val();
			var simulationUser = $("#simulationUser").val();
			
			if("" == columnValue){
				layer.msg("请填写方法路径",{icon: 2});
				return false;
			}
			if("" == simulationUser){
				layer.msg("请选择需要模拟的用户",{icon: 2});
				return false;
			}
			
			avicAjax.ajax({
				url:"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/simulationSql",
				data : {className:columnValue,simulationUser:simulationUser,pid:parent.sysDataPermissionsRule.pid},
				type : 'get',
				dataType : 'json',
				success : function(r){
					if (r.flag == "success"){
						$("#customSql").val(r.sql);
					} else {
						layer.alert("调用时出现异常：" + r.error);
					}
				}
			});
			return false;
		}

		document.ready = function() {
			$("#columnName").select2({});
			$("#columnSymbol").select2({});
			$("#columnType").select2({});

			parent.sysDataPermissionsRule.formValidate($('#form'));
			//保存按钮绑定事件
			$('#sysDataPermissionsRule_saveForm').bind('click', function() {
				saveForm();
			});
			//返回按钮绑定事件
			$('#sysDataPermissionsRule_closeForm').bind('click', function() {
				closeForm();
			});
			// sql预览
			$("#showOldSqlSelect").on("change",function(){
				$("#textareaHtmlTd").find("textarea").css("display","none");
				$("#" + this.value).show();
			});
			// 规则类型
			$("input[name='ruleType']").on("click",function(){
				var selectVal = this.value;
				if(selectVal == "0"){ // 配置字段
					$(".columnTr").show();
					$(".classTr").hide();
					$("#columnValue").val("");
				} else if(selectVal == "1"){ // 配置自定义类
					$(".columnTr").hide();
					$(".classTr").show();
					$("#filterConditionSql").val("");
					$("#filterCondition").val("");
				}
			});
			
			// 列名下拉框
			$("#columnName").on("change",function(){
				symbolDialogSql();
			});
			
			// 列匹配规则下拉框
			$("#columnSymbol").on("change",function(){
				symbolDialogSql();
			});
			
			$("#columnName").val('${sysDataPermissionsRuleDTO.columnName}').select2();
			$("#columnSymbol").val('${sysDataPermissionsRuleDTO.columnSymbol}').select2();
			$("#columnType").val('${sysDataPermissionsRuleDTO.columnType}').select2();

			init();
			
			// 列匹配规则下拉框
			$("#columnType").on("change",function(){
				$("#dialogId").val("");
				$("#dialogName").val("");
				
				var columnType = $("#columnType").val();
				if("text" == columnType){
					$("#columnValue").show();
					symbolSql();
				} else {
					$("#columnValue").hide();
					symbolSql();
				}
			});
			
			$(".sysdatapermissionTips").mouseover(function(){
				var message="<span style='color:red;'>注：使用变量时大括号左右两侧不能带有空格，且注意大小写。</span><br/>目前可使用的变量包含：<br/>#"+
							"{t}：解析时将替换成主表别名/表名<br/>#"+
							"{loginUserId}：解析时将替换成当前登录人ID<br/>#"+
							"{loginDeptId}：解析时将替换成当前登录人部门ID<br/>#"+
							"{loginOrgId}：解析时将替换成当前用户登录的组织ID<br/>#"+
							"{loginUserSecretLevel}：解析时将替换成当前登录人密级<br/>#"+
							"{appId}：解析时将替换成当前应用ID";
				tipsIndex= layer.tips(message, $(this), {
					  tips: [1, '#3595CC'],
					  time: 0,
					  area: ['360px', 'auto']
				});
			}).mouseout(function(){
				layer.close(tipsIndex);
			});
			
			// 选人
			$('#simulationUserAlias').on('focus', function(e) {
				new H5CommonSelect({
					type : 'userSelect',
					idFiled : 'simulationUser',
					textFiled : 'simulationUserAlias'
				});
				this.blur();
				nullInput(e);
			});
		};
	</script>
</body>
</html>