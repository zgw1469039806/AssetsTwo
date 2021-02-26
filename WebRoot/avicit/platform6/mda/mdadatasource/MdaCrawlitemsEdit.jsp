<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<!-- ControllerPath = "platform6/mda/mdadatasource/mdaDatasourceController/operation/Edit/id" -->
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" value='<c:out  value='${mdaCrawlitemsDTO.id}'/>'/>
			<input type="hidden" name="version" value='<c:out  value='${mdaCrawlitemsDTO.version}'/>'/>
			<input type="hidden" name="datasrcid" value='<c:out  value='${mdaCrawlitemsDTO.datasrcid}'/>'/>
			<input type="hidden" id='old_classifyids_id' name="old_classifyids" value='${mdaCrawlitemsDTO.classifyids}'/>
				 <table class="form_commonTable">
				<tr>
																						  																					  						     						  												  												  												  												  												  												  												  												  													    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="name"><i class="required">*</i>数据源配置项:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm required" style="color:black;" type="text" name="name"  id="name" value='<c:out  value='${mdaCrawlitemsDTO.name}'/>'/>
																	   </td>
																																								   							  						     						  												  												  													    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createtime">创建时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control " type="text" name="createtime" readonly="readonly" id="createtime" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaCrawlitemsDTO.createtime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   							  						     						  												  													    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="lastmodifytime">最后修改时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control " type="text" name="lastmodifytime" readonly="readonly" id="lastmodifytime" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaCrawlitemsDTO.lastmodifytime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   							  						     						  												  													    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="lasttimecrawl">最后爬取时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control " type="text" name="lasttimecrawl" readonly="readonly" id="lasttimecrawl" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaCrawlitemsDTO.lasttimecrawl}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   							  						     						  												  													    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="lastcrawluseridAlias">最后爬取用户:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="lastcrawluserid" name="lastcrawluserid" value='<c:out  value='${mdaCrawlitemsDTO.lastcrawluserid}'/>'>
									      <input class="form-control" placeholder="请选择用户" type="text" id="lastcrawluseridAlias" name="lastcrawluseridAlias" value='<c:out  value='${mdaCrawlitemsDTO.lastcrawluseridAlias}'/>'>
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-user"></i>
									      </span>
								    	</div>
																	   </td>
																																								   							  						     						  												  													    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="itemtype">采集类型:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm"  name="itemtype" id="itemtype" title="" isNull="true" lookupCode="MDA_ITEMTYPE" defaultValue='${mdaCrawlitemsDTO.itemtype}'/>
								    								   </td>
																			</tr>
										<tr>
																																								   							  						     						  												  													    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="classifyids">分类:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" readonly="readonly" type="text" name="classifyids"  id="classifyids" value='<c:out  value='${mdaCrawlitemsDTO.classifyids}'/>'/>
																	   </td>
																																								   							  						     						  												  													    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="status">状态:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="status" id="status" title="" isNull="true" lookupCode="MDA_STATUS" defaultValue='${mdaCrawlitemsDTO.status}'/>
								    								   </td>
																			</tr>
										<tr>
											<th width="10%">
						    						  	<label for="classifyids"></label></th>
											<td width="39%">
												<div>    
													<ul id="crawlitem_classify" class="ztree"></ul> 
												</div> 
											</td>
											<th width="10%">
						    						  	<label for="status"></label></th>
											<td></td>
													
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
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存" id="mdaCrawlitems_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="mdaCrawlitems_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.core-3.5.min.js" ></script>
	<script type="text/javascript">
		function closeForm(){
			parent.mdaCrawlitems.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	          $("#datasrcid").val(parent.mdaCrawlitems.pid);
			  parent.mdaCrawlitems.save($('#form'),"eidt");
		}
	
		document.ready = function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.mdaCrawlitems.formValidate($('#form'));
			//保存按钮绑定事件
			$('#mdaCrawlitems_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#mdaCrawlitems_closeForm').bind('click', function(){
				closeForm();
			});
			
			$('#lastcrawluseridAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'lastcrawluserid',textFiled:'lastcrawluseridAlias'});
					    this.blur();
					}); 
																																																																						
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
			//分类
			var setting = { 
	                data : {  
	                    
	                    simpleData : {  
	                        enable : true,  
	                    	}  
	                	}, 
	                	callback: {
	                		onClick: zTreeOnClick
	                	}
           		 }; 
		/* 	var treeNodes = [
			                 {"id":1, "pId":0, "name":"test1"},
			                 {"id":11, "pId":1, "name":"test11"},
			                 {"id":12, "pId":1, "name":"test12"},
			                 {"id":111, "pId":11, "name":"test111"}
			             ]; */
			             
		/* $('#classifyids').focus(function(){
			 $("#crawlitem_classify").css("display","block");
			  $.ajax({
					url:"platform6/mda/mdadatasource/mdaDatasourceController/getZtree",
					type:"POST",
					success:function(retVal){
						$.fn.zTree.init($("#crawlitem_classify"), setting, retVal);
					}
			  });
		}); */
		function zTreeOnClick(event, treeId, treeNode) {
		/* 	alert(treeNode.tId + ", " + treeNode.name); */
			
			var treeObj = $.fn.zTree.getZTreeObj("crawlitem_classify");
			/* 单击展开节点 */
			treeObj.expandNode(treeNode);
			var sNodes = treeObj.getSelectedNodes();
			if (sNodes.length > 0) {
				var isParent = sNodes[0].isParent;
				if(isParent==false){
					$("#classifyids").val(treeNode.name)
					$("#crawlitem_classify").css("display","none");
				}
			}
		    /* $("#classifyidsAlias").val(treeNode.name) */
		};
		
		/* $("body").click( function(){
			$("#_ztree").css("display","none");
		 });  */ 
		 
	/* 	$(document).click(function(){
		    $("#_ztree").hide();
		});
		$("#_ztree").click(function(){
			$("#_ztree").css("display","block");
		}); */
		};
	</script>
</body>
</html>