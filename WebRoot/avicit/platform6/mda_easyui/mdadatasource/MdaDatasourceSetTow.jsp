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
<script src="avicit/platform6/mda/mdaclassify/js/MdaClassify.js"
	type="text/javascript">
</script>
</head>
<script type="text/javascript">
	$(function() {
		$("#selectedId").parent().find("i").hide();
	})
	function showDivFun() {
		var _flag = $('#selectedId:checked').val();
		if (_flag) {
			$("#selectedId").parent().find("i").show();
		} else {
			$("#selectedId").parent().find("i").hide();
		}
	}
	function appendFun(ele){
		var _html = $(ele).closest('tr').clone();
		_html.find("input").val("");
		$(ele).closest('tr').after(_html);
	}
	function delFun(ele){
		var _num = $(ele).closest('table').find('tr').size();
		if(_num > 2){
		    $(ele).closest('tr').remove();
		}else{
	        $.messager.alert('提示','不能删除了！','info');
	    }
	}
	
	function valuereset(obj,type){
		var _text = $(obj).val();
		if(type==1){
			if(_text=='多个请用逗号分割'){
				$(obj).val("");
				$(obj).removeAttr("style");
			}
		}else{
			if(_text.length==0){
				$(obj).val("多个请用逗号分割");
				$(obj).attr("style","color: gray;");
			}
		}
	}

	function closeForm() {
		parent.mdaCrawlitems.closeDialog("insert");
	}
	function saveForm() {
		var form=$("#form");
	
	    var dataok = true;
	
	    var indexFieldNameList = [];
	    $("input[name='indexFieldNameList']").each(function(){
	        var _value=$(this).val();
	        if(_value.length > 0) {
	           indexFieldNameList.push(_value);
	        }else {
	        	$.messager.alert('提示','字段名不能为空！','info');
	           dataok = false;
	           return;
	        }
	    });
	    var indexFieldValueList = [];
	    $("input[name='indexFieldValueList']").each(function(){
	        var _value=$(this).val();
	        if(_value.length > 0) {
	            indexFieldValueList.push(_value);
	         }else {
	        	 $.messager.alert('提示','字段值不能为空！','info');
	             dataok = false;
	             return;
	         }
	    });
	    var parseFieldNameList = [];
	    $("input[name='parseFieldNameList']").each(function(){
	        var _value=$(this).val();
	        if(_value.length > 0) {
	            parseFieldNameList.push(_value);
	         }else {
	        	 $.messager.alert('提示','字段名不能为空！','info');
	             dataok = false;
	             return;
	         }
	    });
	    var parseFieldValueList = [];
	    $("input[name='parseFieldValueList']").each(function(){
	        var _value=$(this).val();
	        if(_value.length > 0) {
	            parseFieldValueList.push(_value);
	         }else {
	        	 $.messager.alert('提示','字段值不能为空！','info');
	             dataok = false;
	             return;
	         }
	    });
	    if(!dataok) {
	    	return;
	    }
		var _saveType=$('input[name="radio"]:checked').val();
		var sourceId=$("#sourceId").val();
		$.ajax({
			 url:"platform/mdaDatasourceEasyUIController/operation/saveSetTow/web/${tmpID}",
			 data : {"savetype":_saveType,"sourceId":sourceId,
				 "indexFieldNameList":indexFieldNameList,"indexFieldValueList":indexFieldValueList,
	             "parseFieldNameList":parseFieldNameList,"parseFieldValueList":parseFieldValueList},
			 type : 'post',
			 success : function(r){
				 if (r == "success"){
					 parent.closWinc();
					 $.messager.alert('提示','保存成功！','info');
				 }else if(r.lastIndexOf("js_error",0) === 0){
					 $.messager.show({
							title : '提示',
							msg : '保存失败,JS语法有误！' + r,
							timeout : 3000,
							showType : 'slide'
						});
	            }else{
	            	 $.messager.show({
							title : '提示',
							msg : '保存失败！' + r,
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
				$("#crawlitem_classify").css("display", "block");
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
			<input type="hidden" name="sourceId" id="sourceId" value="${id}"/> 
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="name">解析字段:</label></th>
					<td colspan="2">
					   <table class="form_commonTable" id="commontable1" style="height: 100%;">
					    <tr>
					       <th width="10%" style="border: 1px solid gray;text-align: center;"><label for="name">字段名:</label></th>
					       <th width="10%" style="border: 1px solid gray;text-align: center;"><label for="name">xpath:</label></th>
					       <th width="10%" style="border: 1px solid gray;text-align: center;"><label for="name">操作:</label></th>
					    </tr>
					    
                          <c:if test="${!empty indexFields }">
                            <c:forEach items="${indexFields}" var="field">
                            <tr class="data">
                                <td style="border: 1px solid gray;"><input  class="inputbox easyui-validatebox" type="text" value="${field.fieldname }"  style="width: 100%;"  name="indexFieldNameList"  /></td>
                                <td style="border: 1px solid gray;"><input  class="inputbox easyui-validatebox" type="text" value="${field.fieldvalue }"  style="width: 100%;"  name="indexFieldValueList"  /></td>
                                <td style="border: 1px solid gray;">
			                     <a id="mdaDatasource_add" onclick="appendFun(this)"
			                        class="easyui-linkbutton primary-btn" role="button"
			                        title="新增"><i class="fa fa-plus"></i> 新增</a> 
			                     <a id="mdaDatasource_del" onclick="delFun(this)"
			                        class="easyui-linkbutton primary-btn" role="button"
			                        title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			                    </td>
                            </tr>
                           </c:forEach>
                          </c:if>
                          <c:if test="${empty indexFields }">
                          <tr class="data">
                               <td style="border: 1px solid gray;"><input  class="inputbox easyui-validatebox" type="text"  style="width: 100%;"  name="indexFieldNameList"  /></td>
                               <td style="border: 1px solid gray;"><input  class="inputbox easyui-validatebox" type="text"  style="width: 100%;"  name="indexFieldValueList"  /></td>
                                <td style="border: 1px solid gray;">
                                 <a id="mdaDatasource_add" onclick="appendFun(this)"
                                    class="easyui-linkbutton primary-btn" role="button"
                                    title="新增"><i class="fa fa-plus"></i> 新增</a> 
                                 <a id="mdaDatasource_del" onclick="delFun(this)"
                                    class="easyui-linkbutton primary-btn" role="button"
                                    title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                                </td>
                          </tr>
                          </c:if>
					   </table>
					 </td>
				</tr>
					<th width="10%"><label for="name">索引字段:</label></th>
					<td colspan="2">
					   <table class="form_commonTable" id="commontable2" style="height: 100%;">
					    <tr>
					       <th width="10%" style="border: 1px solid gray;text-align: center;"><label for="name">字段名:</label></th>
					       <th width="10%" style="border: 1px solid gray;text-align: center;"><label for="name">JS处理规则:</label></th>
					       <th width="10%" style="border: 1px solid gray;text-align: center;"><label for="name">操作:</label></th>
					    </tr>
                           <c:if test="${!empty parseFields }">
                            <c:forEach items="${parseFields }" var="field">
                            <tr class="data">
                                <td style="border: 1px solid gray;"><input  class="inputbox easyui-validatebox" type="text" value="${field.fieldname }"  style="width: 100%;"  name="parseFieldNameList"  /></td>
                                <td style="border: 1px solid gray;"><input  class="inputbox easyui-validatebox" type="text" value="${field.fieldvalue }"  style="width: 100%;"  name="parseFieldValueList"  /></td>
                                <td style="border: 1px solid gray;">
                                 <a id="mdaDatasource_add" onclick="appendFun(this)"
                                    class="easyui-linkbutton primary-btn" role="button"
                                    title="新增"><i class="fa fa-plus"></i> 新增</a> 
                                 <a id="mdaDatasource_del" onclick="delFun(this)"
                                    class="easyui-linkbutton primary-btn" role="button"
                                    title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                                </td>
                              </tr>
                           </c:forEach>
                          </c:if>
                          <c:if test="${empty parseFields }">
                            <c:if test="${!empty fieldsArr }">
				             	<c:forEach items="${fieldsArr }" var="field">
					             <tr class="data">
					                 <td style="border: 1px solid gray;"><input readonly="readonly" value="${field}"  class="inputbox easyui-validatebox " type="text"  style="width: 100%;"  name="parseFieldNameList"  /></td>
					                 <td style="border: 1px solid gray;"><input  class="inputbox easyui-validatebox " type="text"  style="width: 100%;"  name="parseFieldValueList"  /></td>
					             </tr>
				               </c:forEach>
				             </c:if>
                           <tr class="data">
                               <td style="border: 1px solid gray;"><input  class="inputbox easyui-validatebox" type="text"  style="width: 100%;"  name="parseFieldNameList"  /></td>
                               <td style="border: 1px solid gray;"><input  class="inputbox easyui-validatebox" type="text"  style="width: 100%;"  name="parseFieldValueList"  /></td>
                                <td style="border: 1px solid gray;">
                                 <a id="mdaDatasource_add" onclick="appendFun(this)"
                                    class="easyui-linkbutton primary-btn" role="button"
                                    title="新增"><i class="fa fa-plus"></i> 新增</a> 
                                 <a id="mdaDatasource_del" onclick="delFun(this)"
                                    class="easyui-linkbutton primary-btn" role="button"
                                    title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                                </td>
                          </tr>
                          </c:if>
					   </table>
					 </td>
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
					<td width="50%" align="right"><a title="上一步"
						class="easyui-linkbutton primary-btn" onclick="parent.upFun();"
						href="javascript:void(0);">上一步</a> <a title="完成" id="mdaCrawlitems_saveForm"
						class="easyui-linkbutton primary-btn"
						href="javascript:void(0);">完成</a></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>