<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/mda/mdadatabasecrawlconfig/mdaDatabasecrawlconfigController/operation/Edit/id" -->
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value='<c:out  value='${mdaDatabasecrawlconfigDTO.version}'/>'/>
															<input type="hidden" name="id" value='<c:out  value='${mdaDatabasecrawlconfigDTO.id}'/>'/>
																																																																																																																																																																																																																																																																																																																															 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="crawlitemsid">CRAWLITEMSID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="crawlitemsid"  id="crawlitemsid" value='<c:out  value='${mdaDatabasecrawlconfigDTO.crawlitemsid}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="taskname">TASKNAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="taskname"  id="taskname" value='<c:out  value='${mdaDatabasecrawlconfigDTO.taskname}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="modifytime">MODIFYTIME:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="modifytime" id="modifytime" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaDatabasecrawlconfigDTO.modifytime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="lasttimecrawl">LASTTIMECRAWL:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="lasttimecrawl" id="lasttimecrawl" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaDatabasecrawlconfigDTO.lasttimecrawl}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="updatemode">UPDATEMODE:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="updatemode"  id="updatemode" value='<c:out  value='${mdaDatabasecrawlconfigDTO.updatemode}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="serverip">SERVERIP:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="serverip"  id="serverip" value='<c:out  value='${mdaDatabasecrawlconfigDTO.serverip}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="serverport">SERVERPORT:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="serverport" id="serverport" value='<c:out  value='${mdaDatabasecrawlconfigDTO.serverport}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>	
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="loginuser">LOGINUSER:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="loginuser"  id="loginuser" value='<c:out  value='${mdaDatabasecrawlconfigDTO.loginuser}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="loginpassword">LOGINPASSWORD:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="loginpassword"  id="loginpassword" value='<c:out  value='${mdaDatabasecrawlconfigDTO.loginpassword}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="databasename">DATABASENAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="databasename"  id="databasename" value='<c:out  value='${mdaDatabasecrawlconfigDTO.databasename}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="databasetype">DATABASETYPE:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="databasetype"  id="databasetype" value='<c:out  value='${mdaDatabasecrawlconfigDTO.databasetype}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="selectsql">SELECTSQL:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="selectsql"  id="selectsql" value='<c:out  value='${mdaDatabasecrawlconfigDTO.selectsql}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="crawlrate">CRAWLRATE:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="crawlrate" id="crawlrate" value='<c:out  value='${mdaDatabasecrawlconfigDTO.crawlrate}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>	
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="indexcolumns">INDEXCOLUMNS:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="indexcolumns"  id="indexcolumns" value='<c:out  value='${mdaDatabasecrawlconfigDTO.indexcolumns}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="storemethod">STOREMETHOD:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="storemethod"  id="storemethod" value='<c:out  value='${mdaDatabasecrawlconfigDTO.storemethod}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="databaseip">DATABASEIP:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="databaseip"  id="databaseip" value='<c:out  value='${mdaDatabasecrawlconfigDTO.databaseip}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="databaseport">DATABASEPORT:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="databaseport" id="databaseport" value='<c:out  value='${mdaDatabasecrawlconfigDTO.databaseport}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>	
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="username">USERNAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="username"  id="username" value='<c:out  value='${mdaDatabasecrawlconfigDTO.username}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="password">PASSWORD:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="password"  id="password" value='<c:out  value='${mdaDatabasecrawlconfigDTO.password}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="servername">SERVERNAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="servername"  id="servername" value='<c:out  value='${mdaDatabasecrawlconfigDTO.servername}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="tablename">TABLENAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="tablename"  id="tablename" value='<c:out  value='${mdaDatabasecrawlconfigDTO.tablename}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="docname">DOCNAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="docname"  id="docname" value='<c:out  value='${mdaDatabasecrawlconfigDTO.docname}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="collections">COLLECTIONS:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="collections"  id="collections" value='<c:out  value='${mdaDatabasecrawlconfigDTO.collections}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="status">STATUS:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="status"  id="status" value='<c:out  value='${mdaDatabasecrawlconfigDTO.status}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="itemid">ITEMID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="itemid"  id="itemid" value='<c:out  value='${mdaDatabasecrawlconfigDTO.itemid}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="dbtype">中间数据数据库类型:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="dbtype"  id="dbtype" value='<c:out  value='${mdaDatabasecrawlconfigDTO.dbtype}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="dburl">数据库配置URL:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="dburl"  id="dburl" value='<c:out  value='${mdaDatabasecrawlconfigDTO.dburl}'/>'/>
																	   </td>
																																								   													 						</tr>
					</table>
			</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="mdaDatabasecrawlconfig_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="mdaDatabasecrawlconfig_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
			function closeForm(){
			parent.mdaDatabasecrawlconfig.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.mdaDatabasecrawlconfig.save($('#form'),"eidt");
		}
	
		$(document).ready(function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.mdaDatabasecrawlconfig.formValidate($('#form'));
			//保存按钮绑定事件
			$('#mdaDatabasecrawlconfig_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#mdaDatabasecrawlconfig_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																						
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>