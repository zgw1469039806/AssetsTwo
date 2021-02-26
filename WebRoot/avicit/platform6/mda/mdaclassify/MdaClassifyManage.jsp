<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
 String importlibs = "common,tree,form";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/mda/mdaclassify/mdaClassifyController/toMdaClassifyManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div class="easyui-layout" fit="true" >
		<div data-options="region:'west',split:true" style="width:300px;padding:0px;overflow:auto;">
			<div class="row" style="margin: 5px;">
				<div class="input-group  input-group-sm">
			      <input  class="form-control" placeholder="回车查询" type="text" id="txt" name="txt">
			      <span class="input-group-btn">
			        <button id="searchbtn" class="btn btn-default ztree-search" type="button"><span class="glyphicon glyphicon-search"></span></button>
			      </span>
			    </div>
				<div>
					<ul id="_ztree" class="ztree"></ul>
				</div>
			</div>
		</div>
		<div data-options="region:'center',title:'操作'">
		   <div class="easyui-layout" data-options="fit:true">
		     <div data-options="region:'north'" style="height:40px;">
			    <div id="tableToolbar" class="toolbar">
					<div class="toolbar-left">
					    <sec:accesscontrollist hasPermission="3" domainObject="formdialog_demoSingletree_save_" permissionDes="保存">
					        <a href="javascript:;" id="mdaClassify_save" class="btn btn-primary form-tool-btn typeb btn-sm"  title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_demoSingletree_insert_" permissionDes="添加平级节点">
							<a href="javascript:;" id="mdaClassify_insert" class="btn btn-primary form-tool-btn btn-sm"  title="添加平级节点" ><i class="fa fa-plus"></i> 添加平级节点</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_demoSingletree_insertsub_" permissionDes="添加子节点">
							<a href="javascript:;" id="mdaClassify_insertSub" class="btn btn-primary form-tool-btn btn-sm"  title="添加子节点" ><i class="fa fa-plus"></i> 添加子节点</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_demoSingletree_del_" permissionDes="删除">
							<a href="javascript:;" id="mdaClassify_del" class="btn btn-primary form-tool-btn btn-sm"  title="删除"><i class="fa fa-trash-o"></i> 删除</a>
						</sec:accesscontrollist>
					</div>	
				</div>
			</div>  
			<div data-options="region:'center',split:true">
				<form id='form'> 
					<input type="hidden" name="id" id="id"/>
				    <input type="hidden" name="version" id="version"/>
				    <input type="hidden" name="parentId" id="parentId"/>
					<table class="form_commonTable" width="100%">
						<tr>
																																		 									 									 									 									 									 									 									 									 																	 													<th width="10%">
						    						  	<label for="name">名称:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="name"  id="name" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="status">状态:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="status" id="status" title="" isNull="true" lookupCode="MDA_STATUS" />
						    						   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="time">时间:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="time" id="time" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																														   									 							</tr>
					</table>
			  </form>
			</div>
          </div>
	  </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 模块js -->
<script src="avicit/platform6/mda/mdaclassify/js/MdaClassify.js" type="text/javascript"></script>
<script type="text/javascript">
	var mdaClassify;
	$(document).ready(function(){
		mdaClassify = new MdaClassify('_ztree','${url}','form','txt','searchbtn');
	    mdaClassify.init();
		$('.date-picker').datepicker();
		$('.time-picker').datetimepicker({
		    closeText:'确定',//关闭按钮文案
			oneLine:true,//单行显示时分秒
			showButtonPanel:true,//是否展示功能按钮面板
			showSecond:false,//是否可以选择秒，默认否
			beforeShow: function(selectedDate) {
				if($('#'+selectedDate.id).val()==""){
					$(this).datetimepicker("setDate", new Date());
					$('#'+selectedDate.id).val('');
				}
			}
		});
		//禁止用户手动输入时间绑定事件
		$('.date-picker').on('keydown',nullInput);
		$('.time-picker').on('keydown',nullInput);
		                                                                                                                                                                                                                                                                                                                                                                                                                                        		//按钮绑定事件
        $('#mdaClassify_save').bind('click', function(){
        	mdaClassify.save();
        });
	    $('#mdaClassify_insert').bind('click',function(){
	    	mdaClassify.insert();
	    });
	    $('#mdaClassify_insertSub').bind('click',function(){
	    	mdaClassify.insertSub();
	    });
	    $('#mdaClassify_del').bind('click',function(){
	    	mdaClassify.del();
	    });
		mdaClassify.formvaliad(); //form表单校验
	});
</script>
</body>
</html>