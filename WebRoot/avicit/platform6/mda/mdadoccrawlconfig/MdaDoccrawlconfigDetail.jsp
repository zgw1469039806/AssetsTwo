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
<!-- ControllerPath = "platform6/mda/mdadoccrawlconfig/mdaDoccrawlconfigController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value='<c:out  value='${mdaDoccrawlconfigDTO.version}'/>'/>
															<input type="hidden" name="id" value='<c:out  value='${mdaDoccrawlconfigDTO.id}'/>'/>
																																																																																																																																																																																																																																																																																																																																																																																					 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="crawlitemsid">CRAWLITEMSID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="crawlitemsid"  id="crawlitemsid" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.crawlitemsid}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="taskname">TASKNAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="taskname"  id="taskname" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.taskname}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="modifytime">MODIFYTIME:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="modifytime" id="modifytime" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaDoccrawlconfigDTO.modifytime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="lasttimecrawl">LASTTIMECRAWL:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="lasttimecrawl" id="lasttimecrawl" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaDoccrawlconfigDTO.lasttimecrawl}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="updatemode">UPDATEMODE:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="updatemode"  id="updatemode" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.updatemode}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="docaddr">DOCADDR:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="docaddr"  id="docaddr" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.docaddr}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="docport">DOCPORT:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="docport" id="docport" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.docport}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>	
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="loginuser">LOGINUSER:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="loginuser"  id="loginuser" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.loginuser}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="loginpassword">LOGINPASSWORD:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="loginpassword"  id="loginpassword" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.loginpassword}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="fstype">FSTYPE:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="fstype"  id="fstype" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.fstype}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="crawlrate">CRAWLRATE:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="crawlrate" id="crawlrate" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.crawlrate}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>	
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="crawldepth">CRAWLDEPTH:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="crawldepth" id="crawldepth" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.crawldepth}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>	
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="filebegnumberime">FILEBEGNUMBERIME:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="filebegnumberime" id="filebegnumberime" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaDoccrawlconfigDTO.filebegnumberime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="fileendtime">FILEENDTIME:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="fileendtime" id="fileendtime" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaDoccrawlconfigDTO.fileendtime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="copyfile">COPYFILE:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="copyfile"  id="copyfile" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.copyfile}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="crawlfiletype">CRAWLFILETYPE:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="crawlfiletype"  id="crawlfiletype" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.crawlfiletype}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="parsecolumns">PARSECOLUMNS:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="parsecolumns"  id="parsecolumns" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.parsecolumns}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="indexcolumns">INDEXCOLUMNS:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="indexcolumns"  id="indexcolumns" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.indexcolumns}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="storemethod">STOREMETHOD:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="storemethod"  id="storemethod" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.storemethod}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="serverip">SERVERIP:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="serverip"  id="serverip" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.serverip}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="serverport">SERVERPORT:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="serverport" id="serverport" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.serverport}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>	
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="username">USERNAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="username"  id="username" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.username}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="password">PASSWORD:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="password"  id="password" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.password}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="databasename">DATABASENAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="databasename"  id="databasename" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.databasename}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="tablename">TABLENAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="tablename"  id="tablename" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.tablename}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="docname">DOCNAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="docname"  id="docname" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.docname}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="collections">COLLECTIONS:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="collections"  id="collections" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.collections}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="status">STATUS:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="status"  id="status" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.status}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="keywords">关键字:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="keywords"  id="keywords" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.keywords}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="filterwords">过滤关键字:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="filterwords"  id="filterwords" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.filterwords}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="itemid">ITEMID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="itemid"  id="itemid" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.itemid}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="fsIp">文件系统服务器IP:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="fsIp"  id="fsIp" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.fsIp}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="midSaveDir">中间文件保存路径:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="midSaveDir"  id="midSaveDir" readonly="readonly" value='<c:out  value='${mdaDoccrawlconfigDTO.midSaveDir}'/>'/>
																	   </td>
																																								   													 						</tr>
					</table>
			</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		document.ready = function () {
		parent.mdaDoccrawlconfig.formValidate($('#form'));
	};
	//form控件禁用
	setFormDisabled();
	$(document).keydown(function(event){  
		event.returnValue = false;
		return false;
	});  
	</script>
</body>
</html>