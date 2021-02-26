<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,form";	
%>
<!DOCTYPE html>
<HTML>
<head>
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuName">小页名称:</label></th>
					<td width="39%">
		                <input class="form-control input-sm" type="text" name="menuName" id="menuName" />
					</td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuCode">小页编码:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="menuCode" id="menuCode"/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuUrl">小页URL:</label></th>
					<td width="39%"><input type="text" class="form-control input-sm" rows="3" title="小页URL" name="menuUrl" id="menuUrl"></input></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuOrder">小页排序:</label></th>
					<td width="39%"><div class="input-group input-group-sm spinner" data-trigger="spinner">
					   <input title="" type="text" class="form-control" name="menuOrder" id="menuOrder"  data-min="0" data-max="1000" data-step="1" data-precision="0">
					   <span class="input-group-addon">
					      <a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>
					      <a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a>
					   </span>
					</div></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="moreUrl">跳转地址:</label></th>
					<td width="39%"><input type="text" class="form-control input-sm" rows="3" title="跳转地址" name="moreUrl" id="moreUrl"></input></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="refresh">刷新频率:</label></th>
					<td width="39%"  nowrap="nowrap"><input type="number" class="form-control input-sm" style="width: 88%;display:inherit;" rows="3" title="刷新频率" name="refresh" id="refresh" value="0"></input><span>--单位：分</span></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="css">小页样式:</label></th>
					<td width="39%">
		                <input class="form-control input-sm" type="text" name="css" id="css" />
					</td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="height">小页高度:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="height" id="height"/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuStatus">小页状态:</label></th>
					<td width="39%">
						<label class="radio-inline"> <input name="menuStatus" title="启用" type="radio" value="1" checked>启用</label>
						<label class="radio-inline"> <input name="menuStatus" title="禁用" type="radio" value="0">禁用</label>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="showTitle">显示标题:</label></th>
					<td width="39%">
						<label class="radio-inline"> <input name="showTitle" title="显示" type="radio" value="1" checked>显示</label>
						<label class="radio-inline"> <input name="showTitle" title="隐藏" type="radio" value="0">隐藏</label>
					</td>
				</tr>
				
				<tr style="display: none">
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="isCLose">能否关闭:</label></th>
					<td width="39%">
						<label class="radio-inline"> <input name="isClose" title="允许" type="radio" value="1">允许</label>
						<label class="radio-inline"> <input name="isClose" title="禁止" type="radio" value="0" checked>禁止</label>
					</td>

					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="isDrag">能否拖拽:</label></th>
					<td width="39%">
						<label class="radio-inline"> <input name="isDrag" title="允许" type="radio" value="1">允许</label>
						<label class="radio-inline"> <input name="isDrag" title="禁止" type="radio" value="0" checked>禁止</label>
					</td>
				</tr>
				
				<%--<tr>
					 <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuIcon">菜单图标:</label></th>
                    <td width="39%">
                        <div id="iconselect" class="input-group input-group-sm avicselect">
							<input type="text" class="form-control" name="menuIcon" id="menuIcon" readonly="readonly">
							<span class="input-group-addon avicselect-act"><i class="glyphicon glyphicon-list"></i></span>
						</div>
                    </td>
				</tr>--%>
				
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuView">视图地址:</label></th>
					<td width="39%" colspan="3"><input class="form-control input-sm" type="text" name="menuView" id="menuView"/></td>
				</tr>

				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuDes">描述:</label></th>
					<td width="39%" colspan="3"><textarea class="form-control input-sm" rows="3" title="描述" name="menuDes" id="menuDes"></textarea></td>
				</tr>
					
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
						<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="demoSingle_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="demoSingle_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		function closeForm(){
			parent.menuPortal.closeDialog("insert");
		};
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.menuPortal.save($('#form'),"insert");
		};
		$(function(){
			parent.menuPortal.formValidate($('#form'));
			//保存按钮绑定事件
			$('#demoSingle_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#demoSingle_closeForm').bind('click', function(){
				closeForm();
			});
			
			$("#iconselect").bind("click", function() {
				     var url = "static/h5/selectIcon/index.html";
					 lay_select_icon =  layer.open({
						    id:"selectIcon",
					        type : 2,
					        title: '图标选择',
					        skin: 'index-model-noborder',
					        move :'.simple-movetab',
					        area: ['800px', '420px'],
					        content : url,
					        btn: ['清空图标'],
					        success:function(){
// 					        	 var frameId=document.getElementById('selectIcon').getElementsByTagName("iframe")[0].id;
// 					        	 $('#'+frameId)[0].contentWindow.$("#bootstrapIcon").hide();
					        },
					        yes: function(index, layero) {
					        	 setIconInfo("");
					        }
					    });
			});
			
		});
		
		function setIconInfo(data) {
			$("#menuIcon").val(data.icon);
			layer.close(lay_select_icon);
			$("#menuIcon").change();
		}
	</script>
</body>
</html>