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
<!-- ControllerPath = "platform6/mda/mdawebcrawlconfig/mdaWebcrawlconfigController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value='<c:out  value='${mdaWebcrawlconfigDTO.version}'/>'/>
															<input type="hidden" name="id" value='<c:out  value='${mdaWebcrawlconfigDTO.id}'/>'/>
																																																																																																																																																																																																																																																																																																																																																										 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="crawlitemsid">CRAWLITEMSID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="crawlitemsid"  id="crawlitemsid" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.crawlitemsid}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="taskname">TASKNAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="taskname"  id="taskname" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.taskname}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="modifytime">MODIFYTIME:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="modifytime" id="modifytime" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaWebcrawlconfigDTO.modifytime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="lasttimecrawl">LASTTIMECRAWL:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="lasttimecrawl" id="lasttimecrawl" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaWebcrawlconfigDTO.lasttimecrawl}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="websites">WEBSITES:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="websites"  id="websites" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.websites}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="loginurl">LOGINURL:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="loginurl"  id="loginurl" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.loginurl}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="loginport">LOGINPORT:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="loginport" id="loginport" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.loginport}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>	
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="loginuser">LOGINUSER:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="loginuser"  id="loginuser" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.loginuser}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="loginpassword">LOGINPASSWORD:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="loginpassword"  id="loginpassword" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.loginpassword}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="loginbutton">LOGINBUTTON:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="loginbutton"  id="loginbutton" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.loginbutton}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="crawlrate">CRAWLRATE:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="crawlrate" id="crawlrate" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.crawlrate}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
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
										  <input  class="form-control"  type="text" name="crawldepth" id="crawldepth" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.crawldepth}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>	
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="pagebegnumbetime">PAGEBEGNUMBETIME:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="pagebegnumbetime" id="pagebegnumbetime" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaWebcrawlconfigDTO.pagebegnumbetime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="pageendtime">PAGEENDTIME:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="pageendtime" id="pageendtime" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaWebcrawlconfigDTO.pageendtime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="updatemode">UPDATEMODE:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="updatemode"  id="updatemode" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.updatemode}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="parsecolumns">PARSECOLUMNS:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="parsecolumns"  id="parsecolumns" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.parsecolumns}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="indexcolumns">INDEXCOLUMNS:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="indexcolumns"  id="indexcolumns" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.indexcolumns}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="storemethod">STOREMETHOD:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="storemethod"  id="storemethod" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.storemethod}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="serverip">SERVERIP:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="serverip"  id="serverip" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.serverip}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="serverport">SERVERPORT:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="serverport" id="serverport" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.serverport}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>	
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="username">USERNAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="username"  id="username" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.username}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="password">PASSWORD:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="password"  id="password" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.password}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="databasename">DATABASENAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="databasename"  id="databasename" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.databasename}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="tablename">TABLENAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="tablename"  id="tablename" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.tablename}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="docname">DOCNAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="docname"  id="docname" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.docname}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="collections">COLLECTIONS:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="collections"  id="collections" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.collections}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="status">STATUS:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="status"  id="status" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.status}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="keywords">关键字:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="keywords"  id="keywords" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.keywords}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="filterwords">过滤字段:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="filterwords"  id="filterwords" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.filterwords}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="itemid">ITEMID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="itemid"  id="itemid" readonly="readonly" value='<c:out  value='${mdaWebcrawlconfigDTO.itemid}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 						</tr>
					</table>
			</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		document.ready = function () {
		parent.mdaWebcrawlconfig.formValidate($('#form'));
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