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
<!-- ControllerPath = "jobquar/sysjobvariables/sysJobVariablesController/toSysJobVariablesManage" -->
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
				domainObject="formdialog_sysJobVariables_button_add"
				permissionDes="添加">
				<a id="sysJobVariables_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysJobVariables_button_del"
				permissionDes="删除">
				<a id="sysJobVariables_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
		</div>
	</div>
	<table id="sysJobVariablesjqGrid"></table>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
$(document).ready(
		function() {
			var dataGridVariablesColModel = [ {
				label : 'id',
				name : 'id',
				key : true,
				width : 75,
				hidden : true
			}, {
				label : '参数名称',
				name : 'name',
				width : 150,
				editable : true
			},{
				label : '数据类型key',
				name : 'dataType',
				width : 75,
				hidden:true
			},{
				label : '数据类型',
				name : 'dataTypeName',
				width : 150,
				editable : true,
				edittype : "custom",
				editoptions : {
					custom_element : selectElem,
					custom_value : selectValue,
					forId : 'dataType',
					value : {"1":"字符串","2":"整型","3":"长整型","4":"浮点型","5":"日期类型"}
				}
			}, {
				label : '参数值',
				name : 'value',
				width : 150,
				editable : true
			}];
			$("#sysJobVariablesjqGrid").jqGrid({
		        colModel: dataGridVariablesColModel,//表格列的属性
		        height:255- 39-38,//初始化表格高度
		        width:260,
		        scrollOffset: 20, //设置垂直滚动条宽度
		        rowNum: 20,//每页条数
		        rowList:[200,100,50,30,20,10],//每页条数可选列表
		        altRows:true,//斑马线
		        pagerpos:'left',//分页栏位置
		        styleUI : 'Bootstrap', //Bootstrap风格
				viewrecords: true, //是否要显示总记录数
				multiselect: true,//可多选
				autowidth: true,//列宽度自适应
				responsive:true,//开启自适应
		        cellEdit:true,
		        cellsubmit: 'clientArray'
		    });
			//添加按钮绑定事件
			$('#sysJobVariables_insert').bind('click', function() {
				insertSysJobVariables();
			});
			//删除按钮绑定事件
			$('#sysJobVariables_del').bind('click', function() {
				delSysJobVariables();
			});
		});
	 /**
	 * 添加页面
	 */
	var newRowIndex = 0;
	var newRowStart = "new_row";
	function insertSysJobVariables(){
		$("#sysJobVariablesjqGrid").jqGrid('endEditCell');
		var newRowId = newRowStart + newRowIndex;
		var parameters = {
			rowID : newRowId,
			initdata : {},
			position :"first",
			useDefValues : true,
			useFormatter : true,
			addRowParams : {extraparam:{}}
		}
		$("#sysJobVariablesjqGrid").jqGrid('addRow', parameters);
		newRowIndex++;  
	};
	/**
	 * 删除
	 */
	 function  delSysJobVariables(){
		var rows = $("#sysJobVariablesjqGrid").jqGrid('getGridParam','selarrrow');
		var l =rows.length;
		if(l > 0){
			layer.confirm('确定要删除选中的数据吗?', {icon: 3, title:"提示", area: ['400px', '']}, function(index){
				for(;l--;){
					$("#sysJobVariablesjqGrid").jqGrid('delRowData',rows[l]);
				}
				layer.close(index);
			});   
		}else{
			layer.alert('请选择要删除的数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
				  title:"提示"
				}
			);
		}
	};
</script>
</html>