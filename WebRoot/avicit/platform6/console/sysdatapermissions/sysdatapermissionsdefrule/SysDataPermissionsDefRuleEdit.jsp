<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <title>编辑</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
<%--	<link rel="stylesheet" type="text/css" href="avicit/platform6/console/sysdatapermissions/plugins/select2/css/select2.css"/>--%>
<%--	<link rel="stylesheet" type="text/css" href="avicit/platform6/console/sysdatapermissions/plugins/zTreeStyle/metro.css"/>--%>
	<link rel="stylesheet" type="text/css" href="static/h5/select2/select2.css"/>
	<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro.css"/>
	<style type="text/css">
		.expressionDisplay{
			width: 25%;
			border:1px solid #6497e9;
			height:165px;
			position: absolute;
			background-color: #ffffff;
			box-shadow:3px 3px 2px #a5c7fe;
			-moz-box-shadow:3px 3px 2px #a5c7fe;
			-webkit-box-shadow:3px 3px 2px #a5c7fe;
			border-bottom-left-radius:5px;
			border-bottom-right-radius:5px;
			margin-left:2px;
			display:none;
			overflow: auto;
		}
		.ztree li span.button.icon_ico_docu{
			margin-right:2px;
			background: url(static/images/platform/common/function.gif) no-repeat scroll 0 0 transparent;
			vertical-align:top;
			*vertical-align:middle
		}
		.sysdatapermissionTips,.sysdatapermissionTips2{
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
	<h3 style="text-align: center; font-weight: 600;">编辑默认规则</h3>
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${sysDataPermissionsDefRuleDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${sysDataPermissionsDefRuleDTO.id}'/>"/>
        <table class="form_commonTable">
			<tr>
				<th width="10%"><label for="ruleName">规则名称:</label></th>
				<td width="23%"><input class="form-control input-sm"
									   type="text" name="ruleName" id="ruleName" value="<c:out  value='${sysDataPermissionsDefRuleDTO.ruleName}'/>" /></td>

				<th width="10%"><label for="orderBy">排序号:</label></th>
				<td width="23%">
					<div class="input-group input-group-sm spinner"
						 data-trigger="spinner">
						<input class="form-control" type="text" name="orderBy"
							   value="<c:out  value='${sysDataPermissionsDefRuleDTO.orderBy}'/>"
							   id="orderBy" data-min="-<%=Math.pow(10, 12) - Math.pow(10, -0)%>"
							   data-max="<%=Math.pow(10, 12) - Math.pow(10, -0)%>" data-step="1"
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
				<th width="10%"><label for="ruleRemarks">规则描述:</label></th>
				<td width="23%" colspan="3">
					<textarea rows="3" class="form-control input-sm" name="ruleRemarks" id="ruleRemarks">${sysDataPermissionsDefRuleDTO.ruleRemarks}</textarea>
				</td>
			</tr>
			<tr>
				<th width="10%"><label for="matchSymbol">相邻规则匹配符:</label></th>
				<td width="23%">
					<label class="radio-inline">
						<input type="radio" id="matchSymbol0" name="matchSymbol" value="0" />或（or）&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id="matchSymbol1"name="matchSymbol" value="1" />且（and）
					</label>
				</td>
				<th width="10%"><label for="status">状态:</label></th>
				<td width="23%">
					<label class="radio-inline">
						<input type="radio" id="state0" name="state" value="0" />有效&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id="state1" name="state" value="1" />无效
					</label>
				</td>
			</tr>
			<tr>
				<th width="10%"><label for="columnName">字段:</label></th>
				<td width="23%" colspan="3" style="padding-left: 0px;">
					<table>
						<tr>
							<td>
								<div class="sysdatapermissionTips2"></div>
								<select class="js-example-basic-multiple" id="columnName" name="columnName" style="width: 200px">
									<option value="CREATED_BY">CREATED_BY（创建人）</option>
									<option value="DEPT_ID">DEPT_ID（部门）</option>
									<option value="ORG_IDENTITY">ORG_IDENTITY（组织）</option>
									<option value="SECRET_LEVEL">SECRET_LEVEL（密级）</option>
									<option value=''>其他（其他表字段）</option>
								</select>
							</td>
							<td>
								<select class="js-example-basic-multiple" id="columnSymbol" name="columnSymbol" style="width: 100px">
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
							<td>
								<div class="sysdatapermissionTips"></div>
								<select class="js-example-basic-multiple" id="columnType" name="columnType" style="width: 100px;">
									<option value="loginUserId">登录人ID</option>
									<option value="loginDeptId">登录人部门ID</option>
									<option value="loginOrgId">登录人组织ID</option>
									<option value="loginUserSecretLevel">登录人密级</option>
									<option value="appId">应用标识</option>
									<option value="">输入值</option>
								</select>
							</td>
							<td style="padding: 0px;width: 263px;">
								<input class="form-control input-sm" type="text" name="columnValue" id="columnValue" style="padding: 5px 12px;display: none;"
									value="<c:out  value='${sysDataPermissionsDefRuleDTO.columnValue}'/>" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<th width="10%"><label for="filterConditionSql">过滤条件SQL:</label></th>
				<td width="23%" colspan="3">
					<textarea class="form-control input-sm" name="filterConditionSql" id="filterConditionSql" rows="3">${sysDataPermissionsDefRuleDTO.filterConditionSql}</textarea>
				</td>
			</tr>
			<tr>
				<th width="10%"><label for="filterCondition">过滤条件:</label></th>
				<td width="23%" colspan="3">
					<textarea class="form-control input-sm" name="filterCondition" id="filterCondition" rows="2">${sysDataPermissionsDefRuleDTO.filterCondition}</textarea>
				</td>
			</tr>
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar"
         class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                       title="保存" id="sysDataPermissionsDefRule_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="sysDataPermissionsDefRule_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<%--<script type="text/javascript" src="avicit/platform6/console/sysdatapermissions/plugins/select2/js/select2.js"></script>--%>
<script type="text/javascript" src="static/h5/select2/select2.js"></script>
<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsdefrule/js/symbol.js?v=<%=System.currentTimeMillis() %>"></script>

<script type="text/javascript">
	$(document).ready(function () {
		$("#columnName").select2({});
		$("#columnSymbol").select2({});
		$("#columnType").select2({});

		parent.sysDataPermissionsDefRule.formValidate($('#form'));
		//保存按钮绑定事件
		$('#sysDataPermissionsDefRule_saveForm').bind('click', function () {
			saveForm();
		});
		//返回按钮绑定事件
		$('#sysDataPermissionsDefRule_closeForm').bind('click', function () {
			closeForm();
		});

		$("#columnName").val('${sysDataPermissionsDefRuleDTO.columnName}').select2();
		$("#columnSymbol").val('${sysDataPermissionsDefRuleDTO.columnSymbol}').select2();
		$("#columnType").val('${sysDataPermissionsDefRuleDTO.columnType}').select2();

		var matchSymbolVal = '${sysDataPermissionsDefRuleDTO.matchSymbol}';
		if(matchSymbolVal == "0"){
			$("#matchSymbol0").attr("checked",true);
		} else {
			$("#matchSymbol1").attr("checked",true);
		}

		var stateVal = '${sysDataPermissionsDefRuleDTO.state}';
		if(stateVal == "0"){
			$("#state0").attr("checked",true);
		} else {
			$("#state1").attr("checked",true);
		}
		
		var tipsIndex;
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
		
		$(".sysdatapermissionTips2").mouseover(function(){
			var message="要求对应的业务表中存在该字段";
			tipsIndex= layer.tips(message, $(this), {
				  tips: [1, '#3595CC'],
				  time: 0
			});
		}).mouseout(function(){
			layer.close(tipsIndex);
		});
	});

    function closeForm() {
        parent.sysDataPermissionsDefRule.closeDialog("edit");
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
        //限制保存按钮多次点击
        $('#sysDataPermissionsDefRule_saveForm').addClass('disabled').unbind("click");
        parent.sysDataPermissionsDefRule.save($('#form'), "eidt");
    }
</script>
</body>
</html>