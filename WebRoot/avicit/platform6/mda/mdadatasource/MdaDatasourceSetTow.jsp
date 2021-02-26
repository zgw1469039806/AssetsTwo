<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
                                <td style="border: 1px solid gray;"><input  class="form-control input-sm" type="text" value="${field.fieldname }"  style="width: 100%;"  name="indexFieldNameList"  /></td>
                                <td style="border: 1px solid gray;"><input  class="form-control input-sm" type="text" value="${field.fieldvalue }"  style="width: 100%;"  name="indexFieldValueList"  /></td>
                                <td style="border: 1px solid gray;">
			                     <a id="mdaDatasource_add" onclick="appendFun(this)"
			                        class="btn btn-default form-tool-btn btn-sm" role="button"
			                        title="新增"><i class="fa fa-plus"></i> 新增</a> 
			                     <a id="mdaDatasource_del" onclick="delFun(this)"
			                        class="btn btn-default form-tool-btn btn-sm" role="button"
			                        title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			                    </td>
                            </tr>
                           </c:forEach>
                          </c:if>
                          <c:if test="${empty indexFields }">
                          <tr class="data">
                               <td style="border: 1px solid gray;"><input  class="form-control input-sm" type="text"  style="width: 100%;"  name="indexFieldNameList"  /></td>
                               <td style="border: 1px solid gray;"><input  class="form-control input-sm" type="text"  style="width: 100%;"  name="indexFieldValueList"  /></td>
                                <td style="border: 1px solid gray;">
                                 <a id="mdaDatasource_add" onclick="appendFun(this)"
                                    class="btn btn-default form-tool-btn btn-sm" role="button"
                                    title="新增"><i class="fa fa-plus"></i> 新增</a> 
                                 <a id="mdaDatasource_del" onclick="delFun(this)"
                                    class="btn btn-default form-tool-btn btn-sm" role="button"
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
                                <td style="border: 1px solid gray;"><input  class="form-control input-sm" type="text" value="${field.fieldname }"  style="width: 100%;"  name="parseFieldNameList"  /></td>
                                <td style="border: 1px solid gray;"><input  class="form-control input-sm" type="text" value="${field.fieldvalue }"  style="width: 100%;"  name="parseFieldValueList"  /></td>
                                <td style="border: 1px solid gray;">
                                 <a id="mdaDatasource_add" onclick="appendFun(this)"
                                    class="btn btn-default form-tool-btn btn-sm" role="button"
                                    title="新增"><i class="fa fa-plus"></i> 新增</a> 
                                 <a id="mdaDatasource_del" onclick="delFun(this)"
                                    class="btn btn-default form-tool-btn btn-sm" role="button"
                                    title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                                </td>
                              </tr>
                           </c:forEach>
                          </c:if>
                          <c:if test="${empty parseFields }">
                            <c:if test="${!empty fieldsArr }">
				             	<c:forEach items="${fieldsArr }" var="field">
					             <tr class="data">
					                 <td style="border: 1px solid gray;"><input readonly="readonly" value="${field}"  class="form-control input-sm " type="text"  style="width: 100%;"  name="parseFieldNameList"  /></td>
					                 <td style="border: 1px solid gray;"><input  class="form-control input-sm " type="text"  style="width: 100%;"  name="parseFieldValueList"  /></td>
					             </tr>
				               </c:forEach>
				             </c:if>
				             
			               <!--  <tr class="data">
			                 <td style="border: 1px solid gray;"><input readonly="readonly" value="TITLE"  class="form-control input-sm " type="text"  style="width: 100%;"  name="parseFieldNameList"  /></td>
			                 <td style="border: 1px solid gray;"><input  class="form-control input-sm " type="text"  style="width: 100%;"  name="parseFieldValueList"  /></td>
			                  <td style="border: 1px solid gray;">
			                    <span><i class="required">*</i>内容标题</span>
			                  </td>
			             </tr>
			             <tr class="data">
			                 <td style="border: 1px solid gray;"><input readonly="readonly" value="CRAWLEDATE"  class="form-control input-sm " type="text"  style="width: 100%;"  name="parseFieldNameList"  /></td>
			                 <td style="border: 1px solid gray;">
			                 <input  class="form-control input-sm "   value="Date.parse(new Date())" type="text"  style="width: 100%;"  name="parseFieldValueList"  />
			                 
			                 </td>
			                  <td style="border: 1px solid gray;">
			                     <span><i class="required">*</i>爬取时间</span>
			                  </td>
			            </tr>
			             <tr class="data">
			                 <td style="border: 1px solid gray;"><input  readonly="readonly" value="URL" class="form-control input-sm " type="text"  style="width: 100%;"  name="parseFieldNameList"  /></td>
			                 <td style="border: 1px solid gray;"><input  class="form-control input-sm " type="text"  style="width: 100%;"  name="parseFieldValueList"  /></td>
			                  <td style="border: 1px solid gray;">
			                  <span><i class="required">*</i>自定义URL</span>
			                  </td>
			            </tr> -->
                           <tr class="data">
                               <td style="border: 1px solid gray;"><input  class="form-control input-sm" type="text"  style="width: 100%;"  name="parseFieldNameList"  /></td>
                               <td style="border: 1px solid gray;"><input  class="form-control input-sm" type="text"  style="width: 100%;"  name="parseFieldValueList"  /></td>
                                <td style="border: 1px solid gray;">
                                 <a id="mdaDatasource_add" onclick="appendFun(this)"
                                    class="btn btn-default form-tool-btn btn-sm" role="button"
                                    title="新增"><i class="fa fa-plus"></i> 新增</a> 
                                 <a id="mdaDatasource_del" onclick="delFun(this)"
                                    class="btn btn-default form-tool-btn btn-sm" role="button"
                                    title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                                </td>
                          </tr>
                          </c:if>
					   </table>
					 </td>
				</tr>
				
			<%-- 	<tr>
					<th width="10%"><label for="name">存储方式:</label></th>
					
					<td width="10%" colspan="3"><span><input type="radio" value="1"  <c:if test="${bean.savetype eq 1 }">checked="checked"</c:if>
							checked="checked" name='radio' onclick="showDivFun(this)">
							数据库</span> <span class="noneclass">&nbsp;&nbsp;&nbsp;<input
							type="radio" name='radio' value="2"  <c:if test="${bean.savetype eq 2 }">checked="checked"</c:if>
							onclick="showDivFun(this)"> 文档 </span>
							<span>&nbsp;&nbsp;&nbsp;</span>
							<input type="radio" value="3" <c:if test="${bean.savetype eq 3 }">checked="checked"</c:if>
							 name='radio' onclick="showDivFun(this)">
							存到索引库</span>
					</span></td>

				</tr> --%>
				<tr>
					

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
					<td width="50%" style="padding-right: 4%;" align="right">
					<a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="上一步"  onclick="parent.upFun();" >上一步</a>
					<a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="完成" id="mdaCrawlitems_saveForm" >完成</a></td>
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
			//alert("${tmpID}");
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
                layer.msg('不能删除了！');
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
                    layer.alert('字段名不能为空',{
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                      }
                   );
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
                     layer.alert('字段值不能为空',{
                         icon: 7,
                         area: ['400px', ''], //宽高
                         closeBtn: 0
                       }
                    );
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
                     layer.alert('字段名不能为空',{
                         icon: 7,
                         area: ['400px', ''], //宽高
                         closeBtn: 0
                       }
                    );
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
                     layer.alert('字段值不能为空',{
                         icon: 7,
                         area: ['400px', ''], //宽高
                         closeBtn: 0
                       }
                    );
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
				 url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/saveSetTow/web/${tmpID}",
				 data : {"savetype":_saveType,"sourceId":sourceId,
					 "indexFieldNameList":indexFieldNameList,"indexFieldValueList":indexFieldValueList,
                     "parseFieldNameList":parseFieldNameList,"parseFieldValueList":parseFieldValueList},
				 type : 'post',
				 success : function(r){
					 if (r == "success"){
						 parent.closWinc();
						 layer.msg('保存成功！');
					 }else if(r.lastIndexOf("js_error",0) === 0){
                         layer.alert('保存失败,JS语法有误！' + r,{
                             icon: 7,
                             area: ['400px', ''], //宽高
                             closeBtn: 0
                           }
                        );
                    }else{
						 layer.alert('保存失败！' + r,{
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