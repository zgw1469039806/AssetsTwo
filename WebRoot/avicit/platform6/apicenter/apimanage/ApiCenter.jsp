<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/monitor/apicenter/monitorapiinfo/monitorApiInfoController/toMonitorApiInfoManage" -->
<title>API中心管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style>
.ui-jqgrid {
margin-top:10px
}
</style>

</head>
<body>
	<div id="tableToolbar" class="toolbar"  style=" position: absolute;top: 0px;">
		<div class="toolbar-left">
			<div class="input-group form-tool-search">
				<input type="text" name="monitorApiInfo_keyWord" id="monitorApiInfo_keyWord" style="width: 240px;" class="form-control input-sm" placeholder="请输入查询条件"> <label
					id="monitorApiInfo_searchPart" class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
		<div class="toolbar-right">
			<span style="height: 33px; line-height: 33px;font-size: 14px;float:left">排序：</span>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="monitorApiInfo_searchAll" href="javascript:void(0)"
				class="btn btn-defaul btn-sm" role="button" title="全部">全部
			</a>
			<a id="monitorApiInfo_searchAll" href="javascript:void(0)"
				class="btn btn-defaul btn-sm" role="button" title="全部">最新
			</a>
			<a id="monitorApiInfo_searchAll" href="javascript:void(0)"
				class="btn btn-defaul btn-sm" role="button" title="全部">最热
			</a>
			</div>
		</div>
	</div>
	<table id="monitorApiInfojqGrid"></table>
	<div id="jqGridPager"></div>


<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/apicenter/apimanage/js/ApiManagerInfo.js" type="text/javascript"></script>
<script type="text/javascript">
	var monitorApiInfo;
	function formatValue(cellvalue, options, rowObject) {
	debugger;
		return '<a target="_self" href="avicit/platform6/apicenter/apimanage/ApiService.jsp?businessDomain=' + rowObject.businessDomain + '&deptName=' + rowObject.deptName + '">' + cellvalue + '</a>';
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="monitorApiInfo.detail(' + rowObject.id + ');">' + thisDate + '</a>';
	}

	$(document).ready(
		function() {
			var dataGridColModel = [ {
				label : 'id',
				name : 'id',
				key : true,
				width : 75,
				hidden : true
			}, {
				label : '业务域',
				name : 'businessDomain',
				width : 150,
				formatter : formatValue
			}, {
				label : '责任部门',
				name : 'deptName',
				width : 150,
				hidden : true
			}, {
				label : '应用名称',
				name : 'appName',
				width : 150
				
			}, {
				label : '应用编码',
				name : 'appCode',
				width : 150,
				hidden : true
			}, {
				label : '应用描述',
				name : 'appDesc',
				width : 150,
				hidden : true
			}, {
				label : '应用版本',
				name : 'appVersion',
				width : 150
			}, {
				label : '服务编码',
				name : 'serviceCode',
				width : 150,
				hidden : true
			}, {
				label : '服务描述',
				name : 'serviceDesc',
				width : 150
			}, {
				label : 'API名称',
				name : 'apiName',
				width : 150,
				hidden : true
			}, {
				label : 'API地址',
				name : 'apiServiceUri',
				width : 150,
				hidden : true
			}, {
				label : 'API描述',
				name : 'apiDesc',
				width : 150,
				hidden : true
			}, {
				label : 'API版本',
				name : 'apiVersion',
				width : 150,
				hidden : true
			}, {
				label : 'API请求方法',
				name : 'apiRequestMethod',
				width : 150,
				hidden : true
			}, {
				label : 'API请求参数',
				name : 'apiRequestParam',
				width : 150,
				hidden : true
			}, {
				label : 'API请求头',
				name : 'apiRequestHeader',
				width : 150,
				hidden : true
			},{
				label : 'API返回格式',
				name : 'apiReturnFormat',
				width : 150,
				hidden : true
			}, {
				label : 'API返回参数',
				name : 'apiReturnParam',
				width : 150,
				hidden : true
			},  {
				label : 'API错误码',
				name : 'apiErrorInfo',
				width : 150,
				hidden : true
			}, {
				label : '技术支持',
				name : 'techSupport',
				width : 150,
				hidden : true
			}];
			$("#monitorApiInfojqGrid").jqGrid({
				url :  'monitor/apicenter/monitorApiInfoController/operation/getMonitorApiInfosByPage.json',
				mtype : 'POST',
				datatype : "json",
				toolbar : [ true, 'top' ],
				colModel : dataGridColModel,
				height : $(window).height() - 120,
				scrollOffset : 20, // 设置垂直滚动条宽度
				rowNum : 20,
				rowList : [ 200, 100, 50, 30, 20, 10 ],
				altRows : true,
				userDataOnFooter : true,
				pagerpos : 'left',
				loadComplete : function() {
					$("#monitorApiInfojqGrid").jqGrid('getColumnByUserIdAndTableName');
				},
				styleUI : 'Bootstrap',
				viewrecords : true,
				multiselect : true,
				autowidth : true,
				shrinkToFit : true,
				responsive : true,// 开启自适应
				pager : "#jqGridPager"
			});
			var searchNames = new Array();
			var searchTips = new Array();
			searchNames.push("businessDomain");
			searchTips.push("业务域");
			searchNames.push("deptName");
			searchTips.push("责任部门");
			var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
			$('#monitorApiInfo_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
			//添加按钮绑定事件
			$('#monitorApiInfo_insert').bind('click', function() {
				monitorApiInfo.insert();
			});
			//编辑按钮绑定事件
			$('#monitorApiInfo_modify').bind('click', function() {
				monitorApiInfo.modify();
			});
			//删除按钮绑定事件
			$('#monitorApiInfo_del').bind('click', function() {
				monitorApiInfo.del();
			});
			//查询按钮绑定事件
			$('#monitorApiInfo_searchPart').bind('click',
					function() {
						monitorApiInfo.searchByKeyWord();
					});
			//打开高级查询框
			$('#monitorApiInfo_searchAll').bind('click',
					function() {
						monitorApiInfo.openSearchForm(this);
					});

		});
</script>
</body>
</html>