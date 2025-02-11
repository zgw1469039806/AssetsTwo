<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,tree,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "ttt/bpmcatalog/bpmCatalogController/toBpmCatalogManage" -->
<title>结束流程实例</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<link rel="stylesheet" href="avicit/platform6/bpmreform/bpmmonitor/css/style.css"/>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
}

.ztree-submenu {
	border: 1px solid #959595;
	position: fixed !important;
	background: #FFF !important;
	z-index: 1;
}

.ztree-submenu:before {
	position: absolute;
	width: 36px;
	height: 100%;
	left: 0;
	top: 0;
	background-color: #e7e8e8;
	z-index: 1;
	display: block;
	content: ' ';
}

.ztree-submenu a {
	color: #454545;
	font-size: 14px;
	border: 0;
	background: none;
	line-height: 14px;
	padding: 8px 15px 8px 45px;
	z-index: 2;
}

.ztree-submenu a:hover {
	background-color: #cbeef5;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div style="border-top-style: hidden;"
		data-options="region:'west',split:true,width:fixwidth(.3),onResize:function(a){$('#demoSubUser').setGridWidth(a);$(window).trigger('resize');}">
		<div class="row" style="margin: 5px;">

			<div>
				<ul id="treeDemo" class="ztree"></ul>
			</div>
		</div>
	</div>
	<div
		data-options="region:'center',onResize:function(a){$('#demoMainDept').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_bpmProcinst" class="toolbar">
			<div class="toolbar-left">
				
				<sec:accesscontrollist hasPermission="3"
					domainObject="bpmProcinst_button_del" permissionDes="删除">
					<a id="bpmProcinst_button_del" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="删除"><i class="icon icon-delete"></i> 删除</a>
				</sec:accesscontrollist>				
				
			</div>
			<div class="toolbar-right">
				<div class="input-group-btn form-tool-searchbtn">
					<a id="bpmProcinst_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div>
		</div>
		<table id="bpmProcinst"></table>
		<div id="bpmProcinstPager"></div>
	</div>
</body>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
	<form id="formSub">
		<input type="hidden" name="deptid" id="deptid" />
		<table class="form_commonTable">
			
			<tr>
				<th width="15%">开始时间：</th>
				<td width="30%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="startDateBegin" id="startDateBegin" /><span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="15%">结束时间：</th>
				<td width="30%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="startDateEnd" id="startDateEnd" /><span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>

			</tr>

		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmmonitor/js/BpmCatalogTree.js"
	type="text/javascript"></script>
<script src="avicit/platform6/bpmreform/bpmmonitor/js/BpmProcinst.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
    var baseurl = '<%=request.getContextPath()%>';
	var bpmCatalog;
	var bpmProcException;
	function getViewButtons(cellvalue, options, rowObject) {
		//return '<img src="static/images/platform/bpm/client/images/trackTask.gif" style="cursor:pointer" '
		 //      +'onclick="javascript:window.lookExceptionInfo(\''+rowObject.dbid_+'\')"/>';
		return '<a href="javascript:void(0)" title="异常信息查看" class="iconfont icon-simulation" onClick="javascript:window.lookExceptionInfo(\''+rowObject.dbid_+'\')"></a>';
	}

	function bpm_operator_refresh(){
		bpmCatalog.clickNode();
	}
	
	/**
	 * 查看异常信息
	 */
    function lookExceptionInfo(dbid_) {
        var url = baseurl + "/bpm/processAnalysisAction/getProcessExceptionById.json?dbId=" + dbid_;
        $.ajax({
            url: url,
            type: "POST",
            dataType: "JSON",
            success: function (result) {
                layer.open({
                    type: 1,
                    title: '异常详细信息',
                    skin: 'bs-modal',
                    area: ['80%', '80%'],
                    maxmin: false,
                    content: '<div>'+result.rows.exception_+'</div>'
                });
            }
        });
    }
	
	
	$(document).ready(function() {
		
		var bpmProcinstGridColModel = [
			{
				label : 'dbid_',
				name : 'dbid_',
				key : true,
				hidden : true
			}
			, {
				label : '流程名称',
				name : 'pdname_',
				width : 80,
				sortable : false				
			}
			, {
				label : '异常节点ID',
				name : 'instanceid_',
				width : 40,
				align : 'left',
				sortable : false
			}
			, {
				label : '异常节点名称',
				name : 'activityname_',
				width : 60,
				align : 'left',
				sortable : false
			}						
			, {
				label : '操作人姓名',
				name : 'username_',
				width : 40,
				align : 'left',
				sortable : false
			}
			, {
				label : '操作人部门',
				name : 'deptname_',
				width : 50,
				align : 'left',
				sortable : false
			}
			, {
				label : '异常产生时间',
				name : 'time_',
				width : 50,
				align : 'left',
				editor : 'text',
				sortable : false,
				formatter : function(value, rec) {
					var endateMi = value;
					if (endateMi == undefined) {
						return '';
					}
					var newDate = new Date(endateMi);
					return newDate.format("yyyy-MM-dd hh:mm:ss");
				}
			}
			, {
				label : '查看异常信息',
				name : 'view',
				width : 30,
				align : 'center',
				sortable : false,
				formatter : getViewButtons
			}
		];

		var url1 = "bpm/monitor/getProcessExceptionListByPage";
		bpmCatalog = new BpmCatalogTree('treeDemo', 'bpm/monitor/getFlowModelTree?console=true', '', '', '',
			function(pid, nodeType,pdId) {
				bpmProcException = new BpmProcinst('bpmProcinst', url1, "formSub", bpmProcinstGridColModel, 'searchDialogSub', pid, nodeType, '', '',pdId);
			},
			function(pid, nodeType,pdId) {
				bpmProcException.reLoad(pid, nodeType,pdId);
			}
		);

		//打开高级查询
		$('#bpmProcinst_searchAll').bind('click', function() {
			bpmProcException.openSearchForm(this, $('#bpmProcinst'));
		});
		
		//删除按钮绑定事件
		$('#bpmProcinst_button_del').bind('click', function() {
			bpmProcException.delException();
		});		

	
        $('#bpmProcinst_button_query').bind('click',function(){
        	bpmProcException.searchData();
        })
        
        $('#bpmProcinst_button_reset').bind('click',function(){
        	bpmProcException.clearData();
        })
		
	});
</script>
</html>