<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div region="north" border="false">
	<div id="toolbar" style="height:20px;overflow: hidden;">
		<div style="padding:-3 3 0 2px;">
			双击具体的函数名称
		</div>
	</div>
</div>
<div data-options="region:'center',onResize:function(a){$('#beanMethod').setGridWidth(a);$(window).trigger('resize');}" border="false">
	<table id="beanName"></table>
</div>
<div data-options="region:'east',split:true,width:fixwidth(.4),onResize:function(a){$('#beanMethod').setGridWidth(a);$(window).trigger('resize');}" style="border-right: 0;border-bottom: 0;border-top: 0;">
	<table id="beanMethod"></table>
</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
    var BeanNameStr; 
	$(document).ready(function() {
		var datagridBeanColModel = [{
			label : 'Bean名称',
			name : 'name',
			width : 150
		}];
		var datagridBeanMethodColModel = [ {
			label : '函数名',
			name : 'name',
			width : 150
		}];
		$("#beanName").jqGrid({
			url : 'platform/beanMethodSelectorsController/loadBeans.json',
			mtype : 'POST',
			datatype : "json",
			colModel : datagridBeanColModel,
			height : $(window).height()-75,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
			scrollOffset : 10,
			rowNum : 20,
			rowList : [ 200, 100, 50, 30, 20, 10 ],
			altRows : true,
			userDataOnFooter : true,
			pagerpos : 'left',
			styleUI : 'Bootstrap',
			viewrecords : true,
			multiboxonly : true,
			autowidth : true,
			rownumbers:true,
			shrinkToFit : true,
			responsive : true,
			onSelectRow : function(rowid) {
				var data = $(this).jqGrid('getRowData', rowid);
				BeanNameStr= data.name;
				$("#beanMethod").jqGrid('setGridParam', {
					datatype : 'json',
					postData : {beanName:data.name}
				}).trigger("reloadGrid");
			}
		});
		$("#beanMethod").jqGrid({
			url : 'platform/beanMethodSelectorsController/loadMethods.json',
			postData : {
				pid :BeanNameStr
			},
			mtype : 'POST',
			datatype : "json",
			colModel : datagridBeanMethodColModel,
			height : $(window).height()-75,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
			scrollOffset : 10, //设置垂直滚动条宽度
			rowNum : 20,
			rownumbers:true,
			rowList : [ 200, 100, 50, 30, 20, 10 ],
			altRows : true,
			autowidth : true,
			pagerpos : 'left',
			styleUI : 'Bootstrap',
			viewrecords : true, //
			shrinkToFit : true,
			responsive : true,//开启自适应
			ondblClickRow:selectBeanMethod
		});
	});
/**
 * 双击选择函数
 */
function selectBeanMethod(rowIndex, rowid){
	var rowData = $(this).jqGrid('getRowData', rowid);
	var result = BeanNameStr + "#" + rowData.name;
	parent.closeSelectBeanDialog(result);
}
</script>
</html>
