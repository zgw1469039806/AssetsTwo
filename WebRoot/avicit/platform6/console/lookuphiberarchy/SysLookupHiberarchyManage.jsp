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
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div data-options="region:'west',split:true"
			style="width: 300px; padding: 0px; overflow: auto;">
			<div class="row" style="margin: 5px;">
				<div>
					<ul id="_ztree" class="ztree"></ul>
				</div>
			</div>
		</div>
		<div data-options="region:'center'">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'north'" style="height: 43px;">
					<div id="tableToolbar" class="toolbar">
						<div class="toolbar-left">
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_demoSingletree_save_"
								permissionDes="保存">
								<a href="javascript:;" id="sysLookupHiberarchy_save"
									class="btn btn-primary form-tool-btn typeb btn-sm" title="保存"><i
									class="icon icon-save"></i> 保存</a>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_demoSingletree_insert_"
								permissionDes="添加平级节点">
								<a href="javascript:;" id="sysLookupHiberarchy_insert"
									class="btn btn-primary form-tool-btn btn-sm" title="添加平级节点"><i
									class="fa fa-plus"></i> 添加平级节点</a>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_demoSingletree_insertsub_"
								permissionDes="添加子节点">
								<a href="javascript:;" id="sysLookupHiberarchy_insertSub"
									class="btn btn-primary form-tool-btn btn-sm" title="添加子节点"><i
									class="fa fa-plus"></i> 添加子节点</a>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_demoSingletree_del_" permissionDes="删除">
								<a href="javascript:;" id="sysLookupHiberarchy_del"
									class="btn btn-primary form-tool-btn btn-sm" title="删除"><i
									class="fa fa-trash-o"></i> 删除</a>
							</sec:accesscontrollist>
						</div>
					</div>
				</div>
				<div data-options="region:'center',split:true">
					<form id='form'>
						<input type="hidden" name="id" id="id" /> 
						<input type="hidden" name="version" id="version" /> 
						<input type="hidden" name="parentId" id="parentId" />
						<table class="form_commonTable" width="100%">
							<tr>
								<th width="10%"><label for="lookupType" id="hidelookuptype">系统代码类型:</label></th>
								<td width="80%"><input class="form-control input-sm"
									type="text" name="lookupType" id="lookupType" />
							     </td>
							     <%--<td><a href="javascript:;" id="sysLookupHiberarchy_ceshi"--%>
									<%--class="btn btn-primary form-tool-btn typeb btn-sm" title="测试">测试</a></td>--%>
							</tr>
							<tr>
								<th width="10%"><label for="systemFlag">使用级别:</label></th>
								<td width="88%"><select  class="form-control input-sm"name="systemFlag" id="systemFlag">
								        <option value="0">公共使用</option>
								        <option value="1">私有使用</option>
										</select>
								</td>
							</tr>
							<tr>
								<th width="10%"><label for="validFlag">有效标识:</label></th>
								<td width="88%"><select  class="form-control input-sm"name="validFlag" id="validFlag">
								        <option value="1">有效</option>
								        <option value="0">无效</option>
										</select>
								</td>
							</tr>
							<tr>
								<th width="10%"><label for="sysLanguageCode">多语言 :</label></th>
								<td width="88%"><input class="form-control input-sm"
									type="text" name="sysLanguageCode" id="sysLanguageCode" disabled="disabled" /></td>
							</tr>
							<tr>
								<th width="10%"><label for="typeValue">系统代码名称:</label></th>
								<td width="88%"><input class="form-control input-sm"
									type="text" name="typeValue" id="typeValue" /></td>
							</tr>
							<tr>
								<th width="10%"><label for="typeKey">系统代码值:</label></th>
								<td width="88%"><input class="form-control input-sm"
									type="text" name="typeKey" id="typeKey" /></td>
							</tr>
							<tr>
								<th width="10%"><label for="orderBy">排序:</label></th>
								<td width="88%">
									<div class="input-group input-group-sm spinner"
										data-trigger="spinner">
										<input class="form-control" type="text" name="orderBy"
											id="orderBy" data-min="0" data-max="999999999999"
											data-step="1" data-precision="0"> <span
											class="input-group-addon"> <a href="javascript:;"
											class="spin-up" data-spin="up"><i
												class="glyphicon glyphicon-triangle-top"></i></a> <a
											href="javascript:;" class="spin-down" data-spin="down"><i
												class="glyphicon glyphicon-triangle-bottom"></i></a>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<th width="10%"><label for="remark">备注:</label></th>
								<td width="88%"><textarea class="form-control input-sm"
										rows="3" name="remark" id="remark"></textarea></td>
							</tr>
							<tr>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<!-- 模块js -->
	<script src="avicit/platform6/console/lookuphiberarchy/js/SysLookupHiberarchy.js" type="text/javascript"></script>
	<script type="text/javascript">
	var sysLookupHiberarchy;
	$(document).ready(function(){
		sysLookupHiberarchy = new SysLookupHiberarchy('_ztree','${url}','form','txt','searchbtn');
	    sysLookupHiberarchy.init();
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
        $('#sysLookupHiberarchy_save').bind('click', function(){
        	sysLookupHiberarchy.save();
        });
	    $('#sysLookupHiberarchy_insert').bind('click',function(){
	    	sysLookupHiberarchy.insert();
	    });
	    $('#sysLookupHiberarchy_insertSub').bind('click',function(){
	    	sysLookupHiberarchy.insertSub();
	    });
	    $('#sysLookupHiberarchy_del').bind('click',function(){
	    	sysLookupHiberarchy.del();
	    });
		sysLookupHiberarchy.formvaliad(); //form表单校验
		// $('#sysLookupHiberarchy_ceshi').bind('click',function(){
		//     var lookupType = $('#lookupType').val();
		//     sysLookupHiberarchy.test(lookupType);
		// });
	});
</script>
</body>
</html>