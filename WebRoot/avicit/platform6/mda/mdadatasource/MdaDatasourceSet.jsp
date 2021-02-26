<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/mda/mdadatasource/mdaDatasourceController/operation/sub/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="sourceId" value="${id}"/>
			 <input type="hidden" id="itemId_id" name="itemId" value="${id}"/>
			<input type="hidden" name="type" value="web"/> 
			<table class="form_commonTable">
				<tr>
				
					<th width="10%"><label for="name">登录url:</label></th>
					<td width="39%"><input title="登录url:"
						class="form-control input-sm" type="text" value="${mdaWebcrawlconfigDTO.loginurl }"  name="loginUrl" id="name" />
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="name">用户名xpath:</label></th>
					<td width="39%"><input title="用户名xpath:"
						class="form-control input-sm" type="text" value="${mdaWebcrawlconfigDTO.loginuser }" name="userNameXpath" id="name" />
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="name">密码xpath:</label></th>
					<td width="39%"><input title="密码xpath:"
						class="form-control input-sm" type="text" value="${mdaWebcrawlconfigDTO.loginpassword }" name="passXpath" id="name" />
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="name">登录按钮:</label></th>
					<td width="39%"><input title="登录按钮:"
						class="form-control input-sm" value="${mdaWebcrawlconfigDTO.loginbutton }" type="text" name="loginButton" id="name" />
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="name">要爬取的网站域名:</label></th>
					<td colspan="2">
					 <textarea rows="5" name="domainName" cols="100" style="color: #BEBEBE;" id="textarea1" ><c:if test="${!empty mdaWebcrawlconfigDTO.websites }">${mdaWebcrawlconfigDTO.websites}</c:if><c:if test="${empty mdaWebcrawlconfigDTO.websites }">多个请用逗号分割</c:if></textarea></td>
				</tr>
				<tr>
					<th width="10%"><label for="name">要采集的关键词:</label></th>
					<td colspan="2">
					   <textarea rows="3" name="keyWords" cols="100" style="color: #BEBEBE;" id="textarea2" ><c:if test="${!empty mdaWebcrawlconfigDTO.keywords }">${mdaWebcrawlconfigDTO.keywords}</c:if><c:if test="${empty mdaWebcrawlconfigDTO.keywords }">多个请用逗号分割</c:if></textarea>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="name">要过滤的关键词:</label></th>
					<td colspan="2">
					  <textarea rows="3" name="filterWords" cols="100" style="color: #BEBEBE;" id="textarea3" ><c:if test="${!empty mdaWebcrawlconfigDTO.filterwords }">${mdaWebcrawlconfigDTO.filterwords }</c:if><c:if test="${empty mdaWebcrawlconfigDTO.filterwords }">多个请用逗号分割</c:if></textarea>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="name">采集频率:</label></th>
					
					<td width="10%" colspan="3"><select name="rate"
						style="width: 80px; height: 35px; min-height: 35px;">
							<option value="1" <c:if test="${mdaWebcrawlconfigDTO.crawlrate eq 1 }">selected="selected"</c:if>>1</option>
							<option value="2" <c:if test="${mdaWebcrawlconfigDTO.crawlrate eq 2 }">selected="selected"</c:if>>2</option>
							<option value="3" <c:if test="${mdaWebcrawlconfigDTO.crawlrate eq 3 }">selected="selected"</c:if>>3</option>
							<option value="4" <c:if test="${mdaWebcrawlconfigDTO.crawlrate eq 4 }">selected="selected"</c:if>>4</option>
					</select> <select style="width: 80px; height: 35px; min-height: 35px;">
							<option value="2">天／次</option>
					</select>&nbsp;&nbsp;&nbsp; <label for="name">采集深度:</label> <select
						style="width: 80px; height: 35px; min-height: 35px;" name="depth">
							<option value="1" <c:if test="${mdaWebcrawlconfigDTO.crawldepth eq 1 }">selected="selected"</c:if>>1</option>
							<option value="2" <c:if test="${mdaWebcrawlconfigDTO.crawldepth eq 2 }">selected="selected"</c:if>>2</option>
							<option value="3" <c:if test="${mdaWebcrawlconfigDTO.crawldepth eq 3 }">selected="selected"</c:if>>3</option>
							<option value="4" <c:if test="${mdaWebcrawlconfigDTO.crawldepth eq 4 }">selected="selected"</c:if>>4</option>
					</select></td>

				</tr>
				<tr>
					<th width="10%"><label for="name">时间范围:</label></th>
					<td width="10%" colspan="3"><span><input type="radio"
							checked="checked" name='radio' >
							不限</span> <span class="noneclass">&nbsp;&nbsp;&nbsp;<input
							type="radio" name='radio' id="selectedId"
							> 规定范围 <i>&nbsp;&nbsp;&nbsp;&nbsp;开始:<input
								title="数据源配置名称" style="width: 150px;" type="text" name="name"
								id="name" /> -- &nbsp;&nbsp;结束:<input style="width: 150px;"
								type="text" name="name" id="name1" /></i>
					</span></td>

				</tr>
				<tr>
					<th width="10%"><label for="name">更新方式:</label></th>
					<td width="10%" colspan="3"><select
						style="width: 80px; height: 35px; min-height: 35px;" name="way">
							<option value="1">全量更新</option>
							<option value="2">增量更新</option>
					</select></td>

				</tr>


				<tr>
					<th width="10%"><label for="classifyids"></label></th>
					<td width="39%">
						<div>
							<ul id="crawlitem_classify" class="ztree"></ul>
						</div>
					</td>
					<th width="10%"><label for="status"></label></th>
					<td></td>

				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="下一步" id="mdaCrawlitems_saveForm" >下一步</a></td>
				</tr>
			</table>
		</div>
	</div>

	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript"
		src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
	<script src="avicit/platform6/mda/mdaclassify/js/MdaClassify.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		$(function() {
			$("#selectedId").parent().find("i").hide();
		})
			$("input[type='radio']").click(function(){
				var _flag = $('#selectedId:checked').val();
				if (_flag) {
					$("#selectedId").parent().find("i").show();
				} else {
					$("#selectedId").parent().find("i").hide();
				}
			})
		
		/* function valuereset(obj,type){ */
			$("textarea").focus(function(){
			var _text = $(this).val();
				if(_text=='多个请用逗号分割'){
						$(this).val("");
						$(this).removeAttr("style");
				}
			})
			$("textarea").blur(function(){
				var _text = $(this).val();
				if(_text.length==0){
					$(this).val("多个请用逗号分割");
					$(this).attr("style","color: #BEBEBE;");
				}
			})
			
			

		function closeForm() {
			parent.mdaCrawlitems.closeDialog("insert");
		}
		
		function openk(){
			 var _id = "111";
			 this.insertIndex = layer.open({
			    type: 2,
			    area: ['100%', '100%'],
			    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		        maxmin: false, //开启最大化最小化按钮
			    content: 'platform/platform6/mda/mdadatasource/mdaDatasourceController/set/Set/'+_id 
			}); 
		}
		function saveForm() {
			var form=$("#form");
			var _data=serializeObject(form);
			
			$.ajax({
				 url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/saveSet/web",
				 data : _data,
				 type : 'post',
				 success : function(r){
					 //字符串拆分,获取ID
					 var arr = new Array();
					 arr = r.split(":");
					 //alert("============="+arr[1]);
					 if (arr[0] == "success"){
						// parent.openc(1);
						 parent.openNext('web',arr[1]);
						 layer.msg('保存成功！');
					 }else{
						 layer.alert('保存失败！' + r.error,{
							  icon: 7,
							  area: ['400px', ''], //宽高
							  closeBtn: 0
						    }
				         );
					 } 
				 }
			 });
		}
		$(document)
				.ready(
						function() {
							$('.date-picker').datepicker();
							$('.time-picker')
									.datetimepicker(
											{
												oneLine : true,//单行显示时分秒
												closeText : '确定',//关闭按钮文案
												showButtonPanel : true,//是否展示功能按钮面板
												showSecond : false,//是否可以选择秒，默认否
												beforeShow : function(
														selectedDate) {
													if ($('#' + selectedDate.id)
															.val() == "") {
														$(this).datetimepicker(
																"setDate",
																new Date());
														$('#' + selectedDate.id)
																.val('');
													}
												}
											});

							parent.mdaCrawlitems.formValidate($('#form'));
							//保存按钮绑定事件
							$('#mdaCrawlitems_saveForm').bind('click',
									function() {
										saveForm();
									});
							//返回按钮绑定事件
							$('#mdaCrawlitems_closeForm').bind('click',
									function() {
										closeForm();
									});

							$('#lastcrawluseridAlias').on('focus', function(e) {
								new H5CommonSelect({
									type : 'userSelect',
									idFiled : 'lastcrawluserid',
									textFiled : 'lastcrawluseridAlias'
								});
								this.blur();
							});
							$('.date-picker').on('keydown', nullInput);
							$('.time-picker').on('keydown', nullInput);

							var setting = {
								data : {

									simpleData : {
										enable : true,
									}
								},
								callback : {
									onClick : zTreeOnClick
								}
							};
							/* 	var treeNodes = [
								                 {"id":1, "pId":0, "name":"test1"},
								                 {"id":11, "pId":1, "name":"test11"},
								                 {"id":12, "pId":1, "name":"test12"},
								                 {"id":111, "pId":11, "name":"test111"}
								             ]; */

							$('#classifyidsAlias')
									.focus(
											function() {
												$("#crawlitem_classify").css(
														"display", "block");
												$
														.ajax({
															url : "platform6/mda/mdadatasource/mdaDatasourceController/getZtree",
															type : "POST",
															success : function(
																	retVal) {
																$.fn.zTree
																		.init(
																				$("#crawlitem_classify"),
																				setting,
																				retVal);
															}
														});
											});
							function zTreeOnClick(event, treeId, treeNode) {
								/* 	alert(treeNode.tId + ", " + treeNode.name); */

								var treeObj = $.fn.zTree
										.getZTreeObj("crawlitem_classify");
								/* 单击展开节点 */
								treeObj.expandNode(treeNode);
								var sNodes = treeObj.getSelectedNodes();
								if (sNodes.length > 0) {
									var isParent = sNodes[0].isParent;
									if (isParent == false) {
										$("#classifyidsAlias").val(
												treeNode.name)
										$("#crawlitem_classify").css("display",
												"none");
									}
								}
								/* $("#classifyidsAlias").val(treeNode.name) */
							}
							;

							/* $("body").click( function(){
								$("#_ztree").css("display","none");
							 });  */

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