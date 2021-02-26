<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<% 
String importlibs = "common,form";
%>
<% 
String datetime=new SimpleDateFormat("yyyy-MM-dd").format(new Date()); 
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/mda/mdadatasource/mdaDatasourceController/operation/sub/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" />
			<input type="hidden" name="datasrcid" id="datasrcid"/>
			<input type="hidden" name="crawlflag" id="crawlflag" value="2"/>
			<table class="form_commonTable">
				<tr>
											<th width="10%"><label for="name"><i class="required">*</i>采集任务:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm required" style="color:black;" type="text" name="name"  id="name" />
													   </td>
										<th width="10%">
						    						  	<label for="createtime">创建时间:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="createtime" id="createtime" value="<%=datetime %>" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        <input class="form-control date-picker"  type="hidden" name="lastmodifytime" id="lastmodifytime" value="<%=datetime %>" />
		              	        </div>
													   </td>
				</tr>
								<!-- <tr>
																														    					   									 								<th width="10%">
						    						  	<label for="lastmodifytime">最后修改时间:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="lastmodifytime" id="lastmodifytime" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																														    					   									 																				<th width="10%">
						    						  	<label for="lasttimecrawl">最后爬取时间:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="lasttimecrawl" id="lasttimecrawl" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
															</tr> id="lastcrawluseridAlias" -->
								<tr>
																														<th width="10%">
						    						    <label for="lastcrawluseridAlias">创建用户:</label></th>
						    							<td width="39%">
															 <div class="input-group  input-group-sm">
															   	  <input type="hidden"  id="lastcrawluserid" name="lastcrawluserid" value="${CURRENT_LOGINUSER.id }">
															      <input readonly="readonly" class="form-control" placeholder="请选择用户" type="text"  name="lastcrawluseridAlias" value="${CURRENT_LOGINUSER.no }">
															      <span class="input-group-addon">
															        <i class="glyphicon glyphicon-user"></i>
															      </span>
															  </div>
													   </td>
													<th width="10%">
						    						  	<label for="itemtype">采集类型:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="itemtype" id="itemtype" title="" isNull="true" lookupCode="MDA_ITEMTYPE" />
						    						   </td>
															</tr>
											<tr>
														<th width="10%">
						    						  	<label for="classifyids">分类:</label></th>
						    							<td width="39%">
														    <div class="input-group  input-group-sm">
															   	  <input type="hidden"  id="classifyids">
															      <input class="form-control" placeholder="请选择分类" type="text"  id="classifyidsAlias" name="classifyids">
															      <span class="input-group-addon">
															        <i class="glyphicon glyphicon-user"></i>
															      </span>
															  </div>
													   </td>
														<th width="10%">
						    						  	<label for="status">状态:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="status" id="status" title="" isNull="true" lookupCode="MDA_STATUS" defaultValue="1" />
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
	<script src="avicit/platform6/mda/mdaclassify/js/MdaClassify.js" type="text/javascript"></script>
	<script type="text/javascript">
			function closeForm(){
			parent.mdaCrawlitems.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	           $("#datasrcid").val(parent.mdaCrawlitems.pid);
			  parent.mdaCrawlitems.save($('#form'),"insert");
		}
		$(document).ready(function () {
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
				             
			$('#classifyidsAlias').focus(function(){
				 $("#crawlitem_classify").css("display","block");
				  $.ajax({
						url:"platform6/mda/mdadatasource/mdaDatasourceController/getZtree",
						type:"POST",
						success:function(retVal){
							$.fn.zTree.init($("#crawlitem_classify"), setting, retVal);
						}
				  });
			});
				             
			  $('#classifyidsAlias').blur(function(){
				var v = $('#classifyidsAlias').val();
				if(v == ''){
					 layer.alert('请选择采集任务分类！', {
						  icon: 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0
						});
					 return false;
				}else{
				   $("#crawlitem_classify").css("display","none");
				}
			});  
			function zTreeOnClick(event, treeId, treeNode) {
			/* 	alert(treeNode.tId + ", " + treeNode.name); */
				
				var treeObj = $.fn.zTree.getZTreeObj("crawlitem_classify");
				/* 单击展开节点 */
				treeObj.expandNode(treeNode);
				var sNodes = treeObj.getSelectedNodes();
				if (sNodes.length > 0) {
					var isParent = sNodes[0].isParent;
					if(isParent==false){
						$("#classifyidsAlias").val(treeNode.name)
						$("#crawlitem_classify").css("display","none");
					}
				}
			    /* $("#classifyidsAlias").val(treeNode.name) */
			};
			
			 $("body").click( function(){
				//$("#_ztree").css("display","none");
    		 });  
    		 
		/* 	$(document).click(function(){
			    $("#_ztree").hide();
			});
			$("#_ztree").click(function(){
				$("#_ztree").css("display","block");
			}); */
		});
	</script>
</body>
</html>