<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "shujushouquan/sysdbsubject/sysDbSubjectController/operation/Edit/id" -->
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form' autocomplete="off">
			<input type="hidden" name="id"
				value="<c:out  value='${sysDbEntityDTO.id}'/>" /> <input
				type="hidden" name="version"
				value="<c:out  value='${sysDbEntityDTO.version}'/>" /> <input
				type="hidden" name="subjectid" id="subjectid"
				value="<c:out  value='${sysDbEntityDTO.subjectid}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="15%"><label for="identity">类型:</label></th>
					<td width="85%">
					<label class="radio-inline">
						<input type="radio" name="identity" value="0" checked="checked" />通用模块&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="identity" value="1" />电子表单模块
					</label>
					</td>
				</tr>
				<tr>
					<th style="word-break: break-all; word-warp: break-word;"><label
						for="tableName">表名称:</label></th>
					<td>
						<div class="input-group input-group-sm">
						<input class="form-control input-sm"
							type="text" name="tableName" id="tableName" value="<c:out  value='${sysDbEntityDTO.tableName}'/>"/>
			                <span class="input-group-addon" id="dataSourceBtn"><i class="glyphicon glyphicon-th-list"></i></span>
			            </div>
					</td>
				</tr>
				<tr>
					<th 
						style="word-break: break-all; word-warp: break-word;"><label
						for="tableComments">表描述:</label></th>
					<td><input class="form-control input-sm"
						type="text" name="tableComments" id="tableComments"
						value="<c:out  value='${sysDbEntityDTO.tableComments}'/>" /></td>
				</tr>
				<tr>
					<th 
						style="word-break: break-all; word-warp: break-word;"><label
						for="mapperForTab">表对应mapper.xml:</label></th>
					<td><input class="form-control input-sm"
						type="text" name="mapperForTab" id="mapperForTab"
						value="<c:out  value='${sysDbEntityDTO.mapperForTab}'/>" /></td>
				</tr>
				<tr>
					<th 
						style="word-break: break-all; word-warp: break-word;"><label
						for="exemethods">执行方法:</label></th>
					<td><input class="form-control input-sm"
						type="text" name="exemethods" id="exemethods"
						value="<c:out  value='${sysDbEntityDTO.exemethods}'/>" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="保存" id="sysDbEntity_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="sysDbEntity_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script src="avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.js"></script>
	<script type="text/javascript">
		function closeForm() {
			parent.sysDbEntity.closeDialog("edit");
		}
		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}
			$("#subjectid").val(parent.sysDbEntity.pid);
			//限制保存按钮多次点击
			$('#sysDbEntity_saveForm').addClass('disabled');
			parent.sysDbEntity.save($('#form'), "eidt");
		}

		$(document).ready(function() {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine : true,//单行显示时分秒
				closeText : '确定',//关闭按钮文案
				showButtonPanel : true,//是否展示功能按钮面板
				showSecond : false,//是否可以选择秒，默认否
			});

			parent.sysDbEntity.formValidate($('#form'));
			//保存按钮绑定事件
			$('#sysDbEntity_saveForm').bind('click', function() {
				saveForm();
			});
			//返回按钮绑定事件
			$('#sysDbEntity_closeForm').bind('click', function() {
				closeForm();
			});

			$('input[type=radio][name=identity]').change(function() {
	        	$("#tableName").val("");
	        	$("#tableComments").val("");
	        	$("#mapperForTab").val("");
	        	$("#exemethods").val("");
		    });
			
			var mapperValue="<c:out  value='${sysDbEntityDTO.mapperForTab}'/>";
			if(mapperValue == "ViewMapper.xml"){
				$("input[name='identity']:eq(1)").attr("checked",'checked'); 
			}
			
			var selectCreatedDbTable = null;
			$('#dataSourceBtn').bind('click', function() {
				var val = $('input:radio[name="identity"]:checked').val();
				if(val == "0"){
					layer.open({
						type : 2,
						area : [ '70%', '70%' ],
						title : '请选择数据表',
						skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
						shade : 0.3,
						maxmin : false, //开启最大化最小化按钮
						content : 'avicit/platform6/console/imp/sysimptemplate/SelectDataTable.jsp',
						btn : [ '确定', '关闭' ],
						yes : function(index, layero) {
							var iframeWin = layero.find('iframe')[0].contentWindow;//子页面的窗口对象
							var $childrenBody = layer.getChildFrame('body',index);//子页面的body元素
							var $jqGridTable = $childrenBody.find("#testCurrencyjqGrid");
	
							//从子页面向主页面传递参数
							var id = $jqGridTable.jqGrid('getGridParam', 'selrow');
							if (id) {
								var data = $jqGridTable.jqGrid("getRowData", id);
								$("#tableName").val(data['TABLE_NAME']);
								$("#tableComments").val(data['COMMENTS']);
							}
							layer.close(index);
						},
						cancel : function(index, layero) {
							layer.close(index);
						},
						success : function(layero, index) {
							var iframeWin = layero.find('iframe')[0].contentWindow;
							iframeWin.init({
								callbcak : function (data){
									$("#tableName").val(data['TABLE_NAME']);
									$("#tableComments").val(data['COMMENTS']);
									layer.close(index);
								}
							});
						}
					});
					$("#mapperForTab").val("");
				}else if(val == "1"){
					if(selectCreatedDbTable == null){
						selectCreatedDbTable = new SelectCreatedDbTable("tableComments","tableName","");
			        	selectCreatedDbTable.init(function(data){
			        		$("#tableName").val(data.tablename);
			        		$("#tableComments").val(data.name);
			        	});
			        }else{
			        	$("#tableName").click();
			        }
			        $("#mapperForTab").val("ViewMapper.xml");
				}
				$("#tableName").blur();
			});
			
			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
		});
	</script>
</body>
</html>