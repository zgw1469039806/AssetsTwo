<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<body>
	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysJobHistory_button_return"
				permissionDes="返回">
				<a id="sysJobHistory_return" href="javascript:void(0)"
					class="btn btn-default form-tool-btn btn-sm" role="button"
					title="返回"> 返回</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysJobHistory_button_delete"
				permissionDes="清除数据">
				<a id="sysJobHistory_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="清除数据"><i class="fa fa-trash-o"></i> 清除数据</a>
			</sec:accesscontrollist>
		</div>
	</div>
	<table id="sysJobHistoryjqGrid"></table>
	<div id="jqHistoryGridPager"></div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
var sysJobHistory;
/**
 * 格式化结束状态
 */
function formatterEndStatus(cellvalue, options, rowObject){
	var endStatus = "";
	if(cellvalue == 'S'){
		endStatus = "成功";
	}else if(cellvalue == 'F'){
		endStatus = "失败";
	}
	return endStatus;
}

$(document).ready(function() {
	var dataGridColModel = [ {
		label : 'id',
		name : 'id',
		key : true,
		width : 75,
		hidden : true
	}, {
		label : '关联的定时任务的主键',
		name : 'jobId',
		sortable:false,
		width : 150,
		hidden:true
	}, {
		label : '开始时间',
        sortable:false,
		name : 'startDate',
		width : 100
	}, {
		label : '结束时间',
		name : 'endDate',
		sortable:false,
		width : 100
	}, {
		label : '结束状态',
		name : 'endStatus',
		sortable:false,
		width : 100,
		formatter:formatterEndStatus
	}, {
		label : '信息',
		name : 'message',
		sortable:false,
		width : 350
	} ];
 $("#sysJobHistoryjqGrid").jqGrid({
		url : 'sysJobHistoryController/operation/getSysJobHistorysByPage',
		mtype : 'POST',
		postData : {
			jobId : '${jobId}',
		},
		datatype : "json",
		colModel : dataGridColModel,
     	height : $(window).height() - 124 ,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
     	scrollOffset : 20,
		rowNum : 20,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		userDataOnFooter : true,
		multiselect : true,
		pagerpos : 'left',
		styleUI : 'Bootstrap',
		hasTabExport:false,
		hasColSet:false,
		viewrecords : true,
		multiboxonly : true,
		sortname: 'startDate',
		sortorder: 'DESC',  
		sortable:true,
		autowidth : true,
		shrinkToFit : true,
		responsive : true,
		pager:"#jqHistoryGridPager"
	});
	//删除按钮绑定事件
	$('#sysJobHistory_del').bind('click', function() {
		var rows = $("#sysJobHistoryjqGrid").jqGrid('getGridParam', 'selarrrow');
		var ids = [];
		var l = rows.length;
		if (l > 0) {
			layer.confirm('确定要删除选中的数据吗?', {
				icon : 2,
				title : "提示",
				area : [ '400px', '' ]
			}, function(index) {
				for (; l--;) {
					ids.push(rows[l]);
				}
				avicAjax.ajax({
					url : 'sysJobHistoryController/operation/delete',
					data : JSON.stringify(ids),
					contentType : 'application/json',
					type : 'post',
					dataType : 'json',
					success : function(r) {
						if (r.flag == "success") {
							$("#sysJobHistoryjqGrid").jqGrid('setGridParam', {
								datatype : 'json',
								postData : {}
							}).trigger("reloadGrid");
						} else {
							layer.alert('删除失败！' + r.error, {
								icon : 2,
								area : [ '400px', '' ],
								closeBtn : 0,
								btn: ['关闭'],
								title:"提示"
							});
						}
					}
				});
				layer.close(index);
			});
		} else {
			layer.alert('请选择要删除的数据！', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0,
				btn: ['关闭'],
				title:"提示"
			});
		}
	});
	//返回
	$('#sysJobHistory_return').bind('click',function(){
		parent.closeHistoryDialog();
	});
	
});
</script>
</html>