<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" value="<c:out value='${dynElectDTO.id}'/>" />
			<input type="hidden" name="version" value="<c:out  value='${dynElectDTO.version}'/>"/>
			<table class="form_commonTable">
				<tr>
					<th width="15%">
						<label for="name">选举名称:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="name"  id="name" value="<c:out value='${dynElectDTO.name}'/>">
   					</td>
					<th width="15%">
						<label for="status">状态:</label></th>
					<td width="34%">
						<pt6:h5select css_class="form-control input-sm" name="status" id="status" title="" isNull="false" lookupCode="elect_status" defaultValue="${dynElectDTO.status}" />
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="agreeRuleNum">可赞成数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="agreeRuleNum" id="agreeRuleNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.agreeRuleNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="shouldInvestNum">应投数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="shouldInvestNum" id="shouldInvestNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.shouldInvestNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="sceneNum">实到数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="sceneNum" id="sceneNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.sceneNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="roundNum">轮数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="roundNum" id="roundNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.roundNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>

				</tr>
				<tr>
					<th width="15%">
						<label for="scanPlan">方案:</label></th>
					<td width="34%">
						<pt6:h5select css_class="form-control input-sm" name="scanPlan" id="scanPlan" title="" defaultValue="${dynElectDTO.scanPlan}" isNull="false" lookupCode="SCAN_PLAN" />
					</td>
					<th width="15%">
						<label for="groupId">活动标识:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="groupId" value="<c:out value='${dynElectDTO.groupId}'/>" id="groupId" />
					</td>
				</tr>
				<tr>
					<th width="15%">
						<label for="isShowPersons">是否显示人员信息:</label></th>
					<td width="34%">
						<pt6:h5radio css_class="radio-inline"  name="isShowPersons"  title=""  defaultValue="${dynElectDTO.isShowPersons}" canUse="0" lookupCode="SHOW_OR_HIDE" />
					</td>
					<th width="15%">
						<label for="isShowVoteNum">是否显示票数:</label></th>
					<td width="34%">
						<pt6:h5radio css_class="radio-inline"  name="isShowVoteNum"  title=""  defaultValue="${dynElectDTO.isShowVoteNum}" canUse="0" lookupCode="SHOW_OR_HIDE" />
					</td>
				</tr>
				<tr>
					<th width="15%">
						<label for="isShowRanking">是否显示排名:</label></th>
					<td width="34%">
						<pt6:h5radio css_class="radio-inline"  name="isShowRanking"  title=""  defaultValue="${dynElectDTO.isShowRanking}" canUse="0" lookupCode="SHOW_OR_HIDE" />
					</td>
				</tr>
				<tr>
					<th>
						<label for="ruleDesc">规则描述:</label></th>
					<td colspan="3">
						<textarea class="form-control input-sm" rows="3" style="resize:none" name="ruleDesc" id="ruleDesc"><c:out value='${dynElectDTO.ruleDesc}'/></textarea> 
   					</td>
				</tr>
<%--    			<tr>--%>
<%--					<th>--%>
<%--						<label for="att01">备用字段1:</label></th>--%>
<%--					<td>--%>
<%--						<input class="form-control input-sm" type="text" name="att01"  id="att01" value="<c:out value='${dynElectDTO.att01}'/>">--%>
<%--   					</td>--%>
<%--					<th>--%>
<%--						<label for="att02">备用字段2:</label></th>--%>
<%--					<td>--%>
<%--						<input class="form-control input-sm" type="text" name="att02"  id="att02" value="<c:out value='${dynElectDTO.att02}'/>">--%>
<%--   					</td>--%>
<%--				</tr>--%>
<%--    			<tr>--%>
<%--					<th>--%>
<%--						<label for="att03">备用字段3:</label></th>--%>
<%--					<td>--%>
<%--						<input class="form-control input-sm" type="text" name="att03"  id="att03" value="<c:out value='${dynElectDTO.att03}'/>">--%>
<%--   					</td>--%>
<%--					<th>--%>
<%--						<label for="att04">备用字段4:</label></th>--%>
<%--					<td>--%>
<%--						<input class="form-control input-sm" type="text" name="att04"  id="att04" value="<c:out value='${dynElectDTO.att04}'/>">--%>
<%--   					</td>--%>
<%--				</tr>--%>
<%--    			<tr>--%>
<%--					<th>--%>
<%--						<label for="att05">备用字段5:</label></th>--%>
<%--					<td>--%>
<%--						<input class="form-control input-sm" type="text" name="att05"  id="att05" value="<c:out value='${dynElectDTO.att05}'/>">--%>
<%--   					</td>--%>
<%--					<th>--%>
<%--						<label for="att07">备用字段7:</label></th>--%>
<%--					<td>--%>
<%--						<div class="input-group input-group-sm spinner" data-trigger="spinner">--%>
<%--							<input  class="form-control"  type="text" name="att07" id="att07" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.att07}'/>">--%>
<%--							<span class="input-group-addon">--%>
<%--								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>--%>
<%--								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>--%>
<%--							</span>--%>
<%--						</div>--%>
<%--					</td>--%>
<%--				</tr>--%>
<%--    			<tr>--%>
<%--					<th>--%>
<%--						<label for="att08">备用字段8:</label></th>--%>
<%--					<td>--%>
<%--						<div class="input-group input-group-sm spinner" data-trigger="spinner">--%>
<%--							<input  class="form-control"  type="text" name="att08" id="att08" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.att08}'/>">--%>
<%--							<span class="input-group-addon">--%>
<%--								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>--%>
<%--								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>--%>
<%--							</span>--%>
<%--						</div>--%>
<%--   					</td>--%>
<%--					<th>--%>
<%--						<label for="att09">备用字段9:</label></th>--%>
<%--					<td>--%>
<%--						<div class="input-group input-group-sm spinner" data-trigger="spinner">--%>
<%--							<input  class="form-control"  type="text" name="att09" id="att09" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.att09}'/>">--%>
<%--							<span class="input-group-addon">--%>
<%--								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>--%>
<%--								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>--%>
<%--							</span>--%>
<%--						</div>--%>
<%--					</td>--%>
<%--				</tr>--%>
<%--    			<tr>--%>
<%--					<th>--%>
<%--						<label for="att10">备用字段10:</label></th>--%>
<%--					<td>--%>
<%--						<div class="input-group input-group-sm spinner" data-trigger="spinner">--%>
<%--							<input  class="form-control"  type="text" name="att10" id="att10" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.att10}'/>">--%>
<%--							<span class="input-group-addon">--%>
<%--								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>--%>
<%--								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>--%>
<%--							</span>--%>
<%--						</div>--%>
<%--   					</td>--%>
<%--				</tr>--%>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="dynElect_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="dynElect_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		//初始化时间控件
		function initDateSelect(){
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
				beforeShow: function(selectedDate) {
					if($('#'+selectedDate.id).val()==""){
						$(this).datetimepicker("setDate", new Date());
						$('#'+selectedDate.id).val('');
					}
				}
			});
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		}
		
		function closeForm(){
			parent.dynElect.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
  		 	$('#dynElect_saveForm').addClass('disabled').unbind("click");	
			parent.dynElect.save($('#form'),"edit");
		}

        //清空日期值
        function clearCommonSelectValue(element) {
            $(element).siblings("input").val("");
        }

		$(document).ready(function () {
			var status=$("#status").val();
			//已开始的选举活动，禁止修改活动方案
			if("1"==status){
				//select的禁用方法
				$("#scanPlan").attr("disabled","disabled");
			}
			initDateSelect();
			parent.dynElect.formValidate($('#form'));
			//保存按钮绑定事件
			$('#dynElect_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#dynElect_closeForm').bind('click', function(){
				closeForm();
			});
			
		});
	</script>
</body>
</html>
