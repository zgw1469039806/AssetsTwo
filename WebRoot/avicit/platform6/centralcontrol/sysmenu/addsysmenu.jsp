<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加菜单</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<style type="text/css">
.fieldset{
	color: #444;
	line-height:20px;
	width: 95%;
	display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form' class='form'> 
		<input type="hidden" name='id' id='id' value=''/>
		<input type="hidden" name='tlId' id='tlId' value=''/>
		<table class="form_commonTable">
			<tr>
				<th width="20%"><span class="remind">*</span>菜单名称:</th>
                <td width="80%">
                    <input title="菜单名称" class="easyui-validatebox" data-options="required:true,validType:'maxLength[100]'" type="text" name="name" id="name" />
                </td>
			</tr>
			<tr>
				<th width="20%"><span class="remind">*</span>菜单代码:</th>
                <td width="80%">
                    <input title="菜单代码" class="easyui-validatebox" data-options="required:true,validType:'maxLength[100]'" type="text" name="code" id="code" />
                </td>
			</tr>
			<tr>
				<th width="20%">图标引用地址:</th>
                <td width="80%">
                    <input title="图标引用地址" class="easyui-validatebox" data-options="width:518,editable:false,panelHeight:150" type="text" name="image" id="image" />
                </td>
			</tr>
			<tr>
				<th width="20%">菜单路径:</th>
                <td width="80%">
                    <input title="菜单路径" class="easyui-validatebox" type="text" name="url" id="url" />
                </td>
			</tr>
			<tr>
				<th width="20%">排序编号:</th>
                <td width="80%">
                    <input title="排序编号" class="easyui-numberbox" data-options="min:0,precision:0" type="text" name="orderBy" id="orderBy" />
                </td>
			</tr>
			<tr>
				<th>菜单组:</th>
                <td>
                    <pt6:syslookup name="menuGroup" isNull="false" lookupCode="PLATFORM_MENU_GROUP" dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"></pt6:syslookup>
                </td>
			</tr>
			<tr>
				<th>bootstrap图标:</th>
				<td>
					<input title="bootstrap图标" class="easyui-validatebox" editable="false" type="text" name="iconClass" id="iconClass" onclick="chooseIcon();"/>
				</td>
			</tr>
			<tr>
				<th>菜单类型:</th>
				<td>
					<span class="block-box"><input type="radio" title="功能菜单" class="radiobox" name="type" id="type1" value="1" checked/><span class="radiobox-text"><label for="type1">功能菜单</label></span></span>
					<span class="block-box"><input type="radio" title="门户小页" class="radiobox" name="type" id="type2" value="2" /><span class="radiobox-text"><label for="type2">门户小页</label></span></span>
				</td>
			</tr>
			<tr>
				<th>菜单状态:</th>
				<td>
					<span class="block-box"><input type="radio" title="启用" class="radiobox" name="status" id="status1" value="1" checked/><span class="radiobox-text"><label for="status1">启用</label></span></span>
					<span class="block-box"><input type="radio" title="禁用" class="radiobox" name="status" id="status2" value="0" /><span class="radiobox-text"><label for="status1">禁用</label></span></span>
				</td>
			</tr>
			<tr>
				<th>是否Robbin:</th>
				<td>
					<span class="block-box"><input type="radio" title="是" class="radiobox" name="isRobbin" id="isRobbin1" value="1" checked/><span class="radiobox-text"><label for="status1">是</label></span></span>
					<span class="block-box"><input type="radio" title="否" class="radiobox" name="isRobbin" id="isRobbin2" value="0" /><span class="radiobox-text"><label for="status1">否</label></span></span>
				</td>
			</tr>
			<tr>
				<th>菜单视图:</th>
				<td>
					<input title="菜单视图文件路径" class="easyui-validatebox" type="text" name="menuView" id="menuView" />
				</td>
			</tr>
			<tr>
				<th>菜单描述:</th>
				<td>
					<textarea title='菜单描述' class="textareabox" rows="3" cols="1" name="comments" id="comments" ></textarea>
				</td>
			</tr>
		</table>
		<fieldset id='fieldset' class="fieldset">
			<legend>门户小页</legend>
			<table class="form_commonTable">
			<tr>
				<th width="20%">滚动条:</th>
				<td width="80%">
					<span class="block-box"><input type="radio" title="有" class="radiobox" name="scroll" id="scroll1" value="1" /><span class="radiobox-text"><label for="scroll1">有</label></span></span>
					<span class="block-box"><input type="radio" title="无" class="radiobox" name="scroll" id="scroll2" value="0" checked/><span class="radiobox-text"><label for="scroll2">无</label></span></span>
				</td>
			</tr >
			<tr>
				<th>关闭按钮:</th>
				<td>
					<span class="block-box"><input type="radio" title="有" class="radiobox" name="isclose" id="closeble1" value="1" /><span class="radiobox-text"><label for="closeble1">有</label></span></span>
					<span class="block-box"><input type="radio" title="无" class="radiobox" name="isclose" id="closeble2" value="0" checked/><span class="radiobox-text"><label for="closeble2">无</label></span></span>
				</td>
			</tr>
			<tr>
				<th>是否显示标题:</th>
				<td>
					<span class="block-box"><input type="radio" title="显示" class="radiobox" name="isShowTitle" id="titleble1" value="1" checked/><span class="radiobox-text"><label for="titleble1">显示</label></span></span>
					<span class="block-box"><input type="radio" title="隐藏" class="radiobox" name="isShowTitle" id="titleble2" value="0" /><span class="radiobox-text"><label for="titleble2">隐藏</label></span></span>
				</td>
			</tr>
			<tr>
				<th>其它链接地址:</th>
				<td>
					<input title="其它链接地址" class="easyui-validatebox" type="text" name="moreurl" id="moreurl" />
				</td>
			</tr>
			<tr>
				<th>高度:</th>
				<td>
					<input title="高度" class="easyui-numberbox" data-options="min:0,precision:0" type="text" name="height" id="height" />
				</td>
			</tr>
			<tr>
				<th>刷新频率:</th>
				<td>
					<input title="刷新频率" class="easyui-numberbox" data-options="min:0,precision:0" type="text" name="refresh" id="refresh" />
				</td>
			</tr>
			<tr>
				<th>样式:</th>
				<td>
					<textarea title='菜单描述' class="textareabox" rows="3" cols="1" name="css" id="css" ></textarea>
				</td>
			</tr>
		</table>
		</fieldset>
	</form>
	</div>
	<div data-options="region:'south',border:false" style="height:40px;">
    	<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
            <table class="tableForm" border="0" cellspacing="1" width='100%'>
                <tr>
                    <td align="right">
                       <a title="保存" id="saveButton" class="easyui-linkbutton primary-btn" onclick="saveForm();" href="javascript:void(0);">保存</a>
                       <a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a>
                   </td>
                </tr>
            </table>
        </div>
    </div>
	<script type="text/javascript">
		var path,temp;
		function getOffset(evt) {
			var target = evt.target;
			if (target.offsetLeft == undefined) {
				target = target.parentNode;
			}
			var pageCoord = getPageCoord(target);
			var eventCoord = {
				x : window.pageXOffset + evt.clientX,
				y : window.pageYOffset + evt.clientY
			};
			var offset = {
				offsetX : eventCoord.x - pageCoord.x,
				offsetY : eventCoord.y - pageCoord.y
			};
			return offset;
		}
	
		function getPageCoord(element) {
			var coord = {
				x : 0,
				y : 0
			};
			while (element) {
				coord.x += element.offsetLeft;
				coord.y += element.offsetTop;
				element = element.offsetParent;
			}
			return coord;
		}
		function setIconIndex(event, target) {
			var offset = event;
			if (!offset.offsetX) {
				offset = getOffset(event);
			}
			var offsetX = floorNumber(offset.offsetX, 20);
			var offsetY = floorNumber(offset.offsetY, 20);
	
			var iconPath = "static/images/platform/sysmenu/icons.gif -" + offsetX + "px -"
					+ offsetY + "px";
			temp =iconPath;
		}
	
		function floorNumber(num, divisor) {
			return Math.floor(num / divisor) * divisor;
		}
	
		function setDivLocation(id, x, y) {
			var css = document.getElementById(id).style;
			css.left = x + "px";
			css.top = y + "px";
		}
		
		function hidePanel(){
			$('#image').combobox('setValue', temp);
		}
		function formatItem(){
			var s='<img src="static/images/platform/sysmenu/icons.gif" onClick="setIconIndex(event, \'selectIcon\')"/>';
			return s;
		}
		$(function(){
			$('#image').combobox({    
				valueField: 'id',
				textField: 'text',
				data: [{    
				    "id":1,    
				    "text":''   
				}],
				formatter: formatItem,
				onHidePanel:hidePanel
			}).combobox('unselect',1);
			
			$('#type1').change(function(){
				$('#fieldset').css('display','none');
			});
			$('#type2').change(function(){
				$('#fieldset').css('display','block');
			});
		});
		//选择bootstrap图标
		function chooseIcon(){
			var url = 'avicit/platform6/modules/system/newdash/dashborad/aceiconselect.jsp';
			var dlg = new CommonDialog("icondlg","800","500",url,"图标选择",false,true,false);
			dlg.show();
		};
		//选择图标回调，供子页面使用
		function setIconClass(iconClass){
			$("#iconClass").val(iconClass);
		};
		function closeDlg(id){
			$("#" + id).dialog('close');
		};
		function closeForm(){
			parent.sysMenu.closeDialog("#insert");
		}
		function saveForm(){
			var name =$('#name').val();
			if(name.length ===  0){
				alert("菜单名称不能为空！");
				return;
			}
			if(name.length >50){
				alert("菜单名称不能超过50个字！");
				return;
			}
			var code = $('#code').val();
			if(code.length ===  0){
				alert("菜单代码不能为空！");
				return;
			}
			if(code.length >50){
				alert("菜单代码不能超过50个字符！");
				return;
			}
			var order =$('#orderBy').val();
			if(order>65535){
				alert("排序号不能超过65535");
				$('#orderBy').numberbox('setValue', 5000);
				return;
			}
			parent.sysMenu.save(serializeObject($('#form')),'${url}','#insert','${id}');
		}
	</script>
</body>
</html>