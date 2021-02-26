<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<% 
String datetime=new SimpleDateFormat("yyyy-MM-dd").format(new Date()); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "mdaDatasourceEasyUIController/operation/sub/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<script type="text/javascript">
	$(function() {
		$(".timeRange").hide();
		$("input[type='radio']").click(function(){
			var _flag = $('#selectedId:checked').val();
			if (_flag) {
				$(".timeRange").show();
			} else {
				$(".timeRange").hide();
			}
		})
	})

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
		 this.insertIndex = new CommonDialog("insert", "1200", "600", 'platform/mdaDatasourceEasyUIController/set/Set/'+_id, "设置", false, true, false);
		 this.insertIndex.show();
	}
	function saveForm() {
		var form=$("#form");
		var _data=serializeObject(form);
		$.ajax({
			 url:"platform/mdaDatasourceEasyUIController/operation/saveSet/web",
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
					 $.messager.alert('提示','保存成功！','info');
				 }else{
					 $.messager.show({
							title : '提示',
							msg : '保存失败！' + r.error,
							timeout : 3000,
							showType : 'slide'
						});
				 } 
			 }
		 });
	}
	$(document).ready(function() {
		//保存按钮绑定事件
		$('#mdaCrawlitems_saveForm').bind('click',function() {
				saveForm();
		});
		//返回按钮绑定事件
		$('#mdaCrawlitems_closeForm').bind('click',function() {
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
		$('#classifyidsAlias').focus(function() {
				$("#crawlitem_classify").css(
						"display", "block");
				$.ajax({
						url : "mdaDatasourceEasyUIController/getZtree",
						type : "POST",
						success : function(retVal) {
							$.fn.zTree.init($("#crawlitem_classify"),setting,retVal);
						}
				});
		});
		function zTreeOnClick(event, treeId, treeNode) {
			var treeObj = $.fn.zTree.getZTreeObj("crawlitem_classify");
			/* 单击展开节点 */
			treeObj.expandNode(treeNode);
			var sNodes = treeObj.getSelectedNodes();
			if (sNodes.length > 0) {
				var isParent = sNodes[0].isParent;
				if (isParent == false) {
					$("#classifyidsAlias").val(treeNode.name)
					$("#crawlitem_classify").css("display","none");
				}
			}
		};
	});
</script>
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
						class="inputbox easyui-validatebox" type="text" value="${mdaWebcrawlconfigDTO.loginurl }"  name="loginUrl" id="name" />
					</td>
				</tr>
				<tr>
					<th width="12%"><label for="name">用户名xpath:</label></th>
					<td width="37%"><input title="用户名xpath:"
						class="inputbox easyui-validatebox" type="text" value="${mdaWebcrawlconfigDTO.loginuser }" name="userNameXpath" id="name" />
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="name">密码xpath:</label></th>
					<td width="39%"><input title="密码xpath:"
						class="inputbox easyui-validatebox" type="text" value="${mdaWebcrawlconfigDTO.loginpassword }" name="passXpath" id="name" />
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="name">登录按钮:</label></th>
					<td width="39%"><input title="登录按钮:"
						class="inputbox easyui-validatebox" value="${mdaWebcrawlconfigDTO.loginbutton }" type="text" name="loginButton" id="name" />
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
					<td width="10%">
						<table >
						   <tr>
						     <td style="width:200px;"><span> <input type="radio"
									checked="checked" name='radio' value="notime"/> 不限
							     </span>
							     <span class="noneclass"><input
									type="radio" name='radio' id="selectedId" value="time"/>规定范围</span>
							 </td>
							 <td style="width:50px;" class="timeRange">
							 		<label for="docCrawlStartTime">开始:</label>
							 </td>
						     <td class="timeRange">
						           <input class="easyui-datebox" type="text" name="docCrawlStartTime" style=""
										id="docCrawlStartTime" value="<%=datetime %>"/>
						     </td >
						     <td style="width:50px;" class="timeRange">
							 		<label for="docCrawlEndTime">结束:</label>
							 </td>
						     <td class="timeRange">
									 <input class="easyui-datebox" type="text" style=""
										name="docCrawlEndTime" id="docCrawlEndTime" value="<%=datetime %>" style="width:100px;"/>
						     </td>
						     
						   </tr>
						
						</table>
					</td>

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
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="下一步" id="mdaCrawlitems_saveForm"
						class="easyui-linkbutton primary-btn">下一步</a> </td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>