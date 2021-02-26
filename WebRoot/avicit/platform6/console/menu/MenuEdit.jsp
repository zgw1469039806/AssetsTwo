<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
			<input type="hidden" name="parentId"  value='${menu.parentId}' />
			<input type="hidden" name="id"  value='${menu.id}' />
			<input type="hidden" name="version"  value='${menu.version}' />
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuName">菜单名称:</label></th>
					<td width="39%">
		                <input class="form-control input-sm" type="text" name="menuName" id="menuName" value='<c:out  value='${menu.menuName}'/>'/>
					</td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuCode">菜单编码:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="menuCode" id="menuCode"  value='<c:out  value='${menu.menuCode}'/>'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuUrl">菜单URL:</label></th>
					<td width="39%"><input type="text" class="form-control input-sm" rows="3" title="菜单URL" name="menuUrl" id="menuUrl" value='<c:out  value='${menu.menuUrl}'/>' /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuOrder">菜单排序:</label></th>
					<td width="39%">
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
					   <input title="" type="text" class="form-control" name="menuOrder" id="menuOrder"  data-min="0" data-max="1000" data-step="1" data-precision="0" value='${menu.menuOrder}'>
					   <span class="input-group-addon">
					      <a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>
					      <a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a>
					   </span>
					</div>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuStatus">菜单状态:</label></th>
					<td width="39%">
						<label class="radio-inline"> <input name="menuStatus" title="启用" type="radio" value="1" <c:if test="${menu.menuStatus eq 1}">checked</c:if>>启用</label>
						<label class="radio-inline"> <input name="menuStatus" title="禁用" type="radio" value="0" <c:if test="${menu.menuStatus eq 0}">checked</c:if>>禁用</label>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="isShow">首页展示:</label></th>
					<td width="39%">
						<label class="radio-inline"> <input name="isShow" title="显示" type="radio" value="0" <c:if test="${menu.isShow eq 0}">checked</c:if>>显示</label>
						<label class="radio-inline"> <input name="isShow" title="隐藏" type="radio" value="1" <c:if test="${menu.isShow eq 1}">checked</c:if>>隐藏</label>
					</td>
				</tr>

                <tr>
                    <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="openType">打开方式:</label></th>
                    <td width="39%">
                        <select id="openType" name="openType" class="form-control input-sm" title= "打开方式">
                            <option value="_mainframe" <c:if test="${menu.openType eq '_mainframe'}">selected="selected"</c:if>>mainframe</option>
                            <%--<c:if test="${type eq 1}">--%>
                            <option value="_blank" <c:if test="${menu.openType eq '_blank'}">selected="selected"</c:if>>blank</option>
                            <option value="_self" <c:if test="${menu.openType eq '_self'}">selected="selected"</c:if>>self</option>
                            <option value="_top" <c:if test="${menu.openType eq '_top'}">selected="selected"</c:if>>top</option>
                            <%--</c:if>--%>
                        </select>

                    </td>
                    
                    <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuIcon">菜单图标:</label></th>
                    <td width="39%">
                        <div id="iconselect" class="input-group input-group-sm avicselect">
							<input type="text" class="form-control" name="menuIcon" id="menuIcon" value='${menu.menuIcon}' readonly="readonly">
							<span class="input-group-addon avicselect-act"><i class="glyphicon glyphicon-list"></i></span>
						</div>
                    </td>
                </tr>
				<%--修改父菜单开始--%>
				<%--后台菜单无需标记和失效时间控件
					type=1 前台
					type=0 后台
				--%>
		<c:if test="${type eq '1'}">
				<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuMark">菜单标记:</label></th>
                    <td width="39%">
                        <pt6:h5select css_class="form-control input-sm" name="menuMark" id="menuMark" title="" isNull="true" lookupCode="PLATFORM_MENU_MARK" defaultValue='${menu.menuMark}'/>
                    </td>
				<th width="10%" style="word-break: break-all; word-warp: break-word;">失效时间:</th>
					<td width="39%">
						<div class="input-group input-group-sm">
		                	<input class="form-control date-picker" type="text" name="markEndDate" id="markEndDate" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${menu.markEndDate}"/>'/>
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							<span class="input-group-addon" id="clearOutFactoryDate" onclick="clearCommonSelectValue(this)">
							<i class="fa fa-close"></i>
							</span>
		              	</div>
					</td>
				</tr>
		</c:if>
				<%--修改父菜单结束--%>
				<tr>
                    <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="movemenu">父级菜单:</label></th>
					<td width="39%">
					<div id="movemenuselect" class="input-group input-group-sm avicselect">
						<input type="hidden" class="form-control" name="movemenu" id="movemenu"  >
						<input type="text" class="form-control" name="movemenuName" id="movemenuName"  value='${menu.movemenuName}' readonly="readonly">
						<span class="input-group-addon avicselect-act"><i class="glyphicon glyphicon-list"></i></span>
					</div>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuView">视图地址:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="menuView" id="menuView" value='${menu.menuView}'/></td>
				</tr>

				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="menuDes">描述:</label></th>
					<td width="39%" colspan="3"><textarea class="form-control input-sm" rows="3" title="描述" name="menuDes" id="menuDes">${menu.menuDes}</textarea></td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
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
	var lay_select_menu;
       // var temp ='${menu.menuName}';
      /*  console.info($('#menuName'));
        $('#menuName').val(temp);*/

		function closeForm(){
			parent.menuList.closeDialog("update");
		};
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.menuList.save($('#form'),"update");
		};
		// 使用span标签通用的删除平级节点中的input文本输入框里的值
		function clearCommonSelectValue(element) {
			$(element).siblings("input").val("");
		}
		$(function(){
			parent.menuList.formValidate($('#form'));
			//保存按钮绑定事件
			$('#demoSingle_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#demoSingle_closeForm').bind('click', function(){
				closeForm();
			});

			//父级菜单字段赋值
			var selectId = parent.menuTree._selectNode.id;
			$("#movemenu").val(selectId);

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
// 				        	 var frameId=document.getElementById('selectIcon').getElementsByTagName("iframe")[0].id;
// 				        	 $('#'+frameId)[0].contentWindow.$("#bootstrapIcon").hide();
                             parent.redrawTreePseudoEl();
				        },
				        yes: function(index, layero) {
				        	 setIconInfo("");
				        }
				    });
			});
			//打开修改父级菜单对话框
			$("#movemenuselect").bind("click", function() {
				 var url = "avicit/platform6/console/menu/menuselect.jsp";
				 lay_select_menu =  layer.open({
				        type : 2,
				        title: '父级菜单选择',
				        skin: 'index-model-noborder',
				        move :'.simple-movetab',
				        area: ['30%', '60%'],
				        content : url,
				        success:function(){
				        	  //选择父节点树页面加载完成后，会修改树节点图标，IE8下样式无法重绘导致图标丢失
				        	parent.redrawTreePseudoEl();
				        }
				    });
			});

			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
		
		
		function setIconInfo(data) {
			$("#menuIcon").val(data.icon);
			layer.close(lay_select_icon);
			$("#menuIcon").change();
		}

	//设置父级菜单
	function setParentMenu(data) {
		$("#movemenu").val(data.id);
		$("#movemenuName").val(data.text);
		//设置parentId,如果父级菜单字段有修改时才修改
		$("input[name='parentId']").val(data.id);
	    layer.close(lay_select_menu);
	}

	document.ready = function () {
		$(".date-picker").datepicker({
			minDate: 0
			});
		$('.date-picker').datepicker({yearRange:"c-100:c+10"});
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
		}
	</script>
</body>
</html>