<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<HEAD>
<TITLE> ZTREE DEMO - Standard Data </TITLE>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- ControllerPath = "demo/demoreception/demoReceptionController/operation/Add/null" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="version" value='<c:out  value='${demoReceptionDTO.version}'/>' /> 
			<input type="hidden" name="id" value='<c:out  value='${demoSingleDTO.id}'/>'/>
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请日期:</th>
					<td width="39%">
						<div class="input-group input-group-sm">
		                	<input class="form-control date-picker" type="text" name="applyDate" id="applyDate" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${demoSingleDTO.applyDate}"/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	</div>
					</td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;">地点:</th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="place" id="place" readonly="readonly" value='<c:out value='${demoSingleDTO.place}'/>'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">来宾人数:</th>
					<td width="39%">
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
						  <input title="红酒 数量（瓶）" type="text" class="form-control" name="guestNum" id="guestNum" readonly="readonly" value='<c:out  value='${demoSingleDTO.guestNum}'/>'  data-min="0" data-max="999999999999" data-step="1" data-precision="0">
						  <span class="input-group-addon">
						    <a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>
						    <a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a>
						  </span>
						</div>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"> 接待时间:</th>
					<td width="39%">
						接待日期 : 
						<div class="input-group input-group-sm">
		                	<input class="form-control date-picker" type="text" name="receptionDate" id="receptionDate" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${demoSingleDTO.receptionDate}"/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	</div>
						开始时间:
						<div class="input-group input-group-sm">
			                <input class="form-control time-picker"  type="text" name="receptionStime" id="receptionStime" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${demoSingleDTO.receptionStime}"/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
			            </div>
						结束时间 :
						<div class="input-group input-group-sm">
			                <input class="form-control time-picker"  type="text" name="receptionEtime" id="receptionEtime" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${demoSingleDTO.receptionEtime}"/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
			            </div> 
					 </td>
				</tr>
				<tr>
					<th width="10%"style="word-break: break-all; word-warp: break-word;">接待要求</th>
					<td width="39%" colspan="3"  data-type="checkbox" data-length="255">
						<pt6:h5checkbox css_class="checkbox-inline" name="cigaretteRequire" title="接待要求 1：会议室 2：电脑 3：投影仪" canUse="0" lookupCode="CIGARETTE_REQUIRE" defaultValue='${demoSingleDTO.cigaretteRequire}'/>
					</td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">香烟:</th>
					<td width="39%">
						软中华 数量（包）:
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
						  <input title="软中华 数量（包）" type="text" class="form-control" name="cigaretteRzh" id="cigaretteRzh" readonly="readonly" value='<c:out  value='${demoSingleDTO.cigaretteRzh}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
						  <span class="input-group-addon">
						    <a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>
						    <a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a>
						  </span>
						</div>
						硬中华 数量（包）:
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
						  <input title="硬中华 数量（包）" type="text" class="form-control" name="cigaretteYzh" id="cigaretteYzh" readonly="readonly" value='<c:out  value='${demoSingleDTO.cigaretteYzh}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
						  <span class="input-group-addon">
						    <a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>
						    <a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a>
						  </span>
						</div>
						其他 数量（包）:
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
						  <input title="其他 数量（包）" type="text" class="form-control" name="cigaretteQt" id="cigaretteQt" readonly="readonly" value='<c:out  value='${demoSingleDTO.cigaretteQt}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
						  <span class="input-group-addon">
						    <a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>
						    <a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a>
						  </span>
						</div>
					</td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">酒水:</th>
					<td width="39%">
						红酒 数量（瓶）:
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
						  <input title="红酒 数量（瓶）" type="text" class="form-control" name="wine" id="wine" readonly="readonly" value='<c:out  value='${demoSingleDTO.wine}'/>'  data-min="0" data-max="999999999999" data-step="1" data-precision="0">
						  <span class="input-group-addon">
						    <a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>
						    <a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a>
						  </span>
						 </div>
						白酒 数量（瓶）:
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
						  <input title="红酒 数量（瓶）" type="text" class="form-control" name="liquor" id="liquor" readonly="readonly" value='<c:out  value='${demoSingleDTO.liquor}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
						  <span class="input-group-addon">
						    <a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>
						    <a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a>
						  </span>
						 </div>
						其他 数量（瓶）:
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
						  <input title="红酒 数量（瓶）" type="text" class="form-control" name="otherDrink" id="otherDrink" readonly="readonly" value='<c:out  value='${demoSingleDTO.otherDrink}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
						  <span class="input-group-addon">
						    <a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>
						    <a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a>
						  </span>
						 </div>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">用餐:</th>
					<td width="39%">
						<input title="用餐" class="form-control input-sm" type="text" name="dinner" id="dinner" readonly="readonly" value='<c:out value='${demoSingleDTO.dinner}'/>' />
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">住宿费:</th>
					<td width="39%" >
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
						  <input title="住宿费" type="text" class="form-control" name="hotel" id="hotel" readonly="readonly" value='<c:out  value='${demoSingleDTO.hotel}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
						  <span class="input-group-addon">
						    <a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>
						    <a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a>
						  </span>
						 </div>
					</td>
				</tr>
				<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;">其他:</th>
					<td width="39%" colspan="3"><textarea class="form-control input-sm" rows="3" title="其他" readonly="readonly" name="remark" id="remark">${demoSingleDTO.remark}</textarea></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">部门类型:</th>
					<td width="39%"  colspan="3">
						<pt6:h5select css_class="form-control input-sm" name="deptType" id="deptType" title="部门类型" isNull="true" lookupCode="DEPT_TYPE"  defaultValue='${demoSingleDTO.deptType}'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">满意度调查</th>
					<td width="39%"  colspan="3">
						<pt6:h5radio css_class="radio-inline"  name="satisfactionSurvey" title="满意度调查 1：十分满意 2:满意" canUse="0" lookupCode="SATISFACTION_SURVEY"  defaultValue='${demoSingleDTO.satisfactionSurvey}'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">选人框</th>
					<td width="39%">
						<div class="input-group  input-group-sm">
						   	  <input type="hidden"  id="applyUserid" name="applyUserid" value='<c:out  value='${demoSingleDTO.applyUserid}'/>'>
						      <input class="form-control" placeholder="请选择用户" type="text" id="applyUseridAlias" name="applyUseridAlias" readonly="readonly" value='<c:out  value='${demoSingleDTO.applyUseridAlias}'/>'>
						      <span class="input-group-btn">
						        <button class="btn btn-default" type="button" id="userbtn" ><span class="glyphicon glyphicon-user"></span></button>
							 </span>
				    	</div>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">选部门</th>
					<td width="39%" >
						<div class="input-group  input-group-sm">
					   	  <input type="hidden"  id="applyDeptid" name="applyDeptid" value='<c:out  value='${demoSingleDTO.applyDeptid}'/>'>
					      <input class="form-control" placeholder="请选择部门" type="text" id="applyDeptidAlias" name="applyDeptidAlias" readonly="readonly" value='<c:out  value='${demoSingleDTO.applyDeptidAlias}'/>'>
					      <span class="input-group-btn">
					        <button class="btn btn-default" type="button" id="deptbtn" ><span class="glyphicon glyphicon-equalizer"></span></button>
					      </span>
				        </div>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">

		var applyDate = (format('${demoSingleDTO.applyDate}'));
		var receptionDate = (format('${demoSingleDTO.receptionDate}'));
		document.ready = function () {
			$('.date-picker').datepicker();
			
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false//是否可以选择秒，默认否
			});

			parent.demoSingle.formValidate($('#form'));
			
			$('#applyUseridAlias').on('keydown',function(e){
				if(e.keyCode != '13'){
					e.returnValue=false;
					return false;
				}
				new H5CommonSelect({type:'userSelect', idFiled:'applyUserid',textFiled:'applyUseridAlias'});
			}); 
			$('#userbtn').on('click',function(){
				new H5CommonSelect({type:'userSelect', idFiled:'applyUserid',textFiled:'applyUseridAlias'});
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
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		};
	</script>
</body>
</html>