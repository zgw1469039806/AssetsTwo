<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
	String nodeId = "\'"+request.getParameter("nodeId")+"\'";
	String nodeType = "\'"+request.getParameter("nodeType")+"\'";
	String pdId = "\'"+request.getParameter("pdId")+"\'";
%>
<!DOCTYPE html>
<html>
<head>
<title>我的草稿</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<style type="text/css">
body {
	margin: 0;
	padding: 0;
}

.form-input-task {
    width: 100px;
    position: relative;
    display: inline-block!important;
}


</style>
</head>
<body>

<div id="toolbar_bpmProcInst" class="toolbar">
	<div class="toolbar-left">       
			<a id="bpmProcinst_button_del" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
				title="删除"> 删除</a>
	</div>
	<div class="toolbar-right">
	   	<div id="queryTypeDiv" class="input-group form-input-task">
	   	    <input type="hidden" name="acceptDateBegin" id="acceptDateBegin">
	   	    <input type="hidden" name="acceptDateEnd" id="acceptDateEnd">
		    <select name="queryType" id="queryType" 
				class="easyui-combobox form-control input-sm" onChange="selectSearchType(this)">
					<option value="title">标题</option>
					<option value="startDate">申请日期</option>
			</select>
		</div>
		<div id="commonSearch" class="input-group form-tool-search" >
			<input type="text" name="bpmProcInst_keyWord"
				id="bpmProcInst_keyWord" style="width:240px;"
				class="form-control input-sm" placeholder="请输入查询条件"> <label
				id="bpmProcInst_searchPart"
				class="icon icon-search form-tool-searchicon"></label>
		</div>		
		<div class="input-group-btn form-tool-searchbtn">
			<a id="bpmProcInst_searchAll" href="javascript:void(0)"
				class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
				<span class="caret"></span>
			</a>
		</div>
	</div>
</div>
<table id="bpmProcInst"></table>
<div id="bpmProcInstPager"></div>

</body>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
	<form id="formSub">
		<input type="hidden" name="deptid" id="deptid" />
		<table class="form_commonTable" >
			<tr>
				<th width="18%">标题：</th>
				<td width="30%"><input title="标题："
					class="form-control input-sm" type="text" name="title"
					id="title" /></td>
				<th width="15%">申请人：</th>
				<td width="30%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="userId" name="userId">
						<input class="form-control" placeholder="请选择用户" type="text"
							id="receptUserName" name="receptUserName"> <span
							class="input-group-addon" id="userbtn"> <i
							class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
				
			</tr>
			<tr>
				<th width="15%">申请日期</th>
				<td width="30%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="startDateBegin" id="startDateBegin" /><span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="15%" align="center" style="text-align:center">至</th>
				<td width="30%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="startDateEnd" id="startDateEnd" /><span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				
				<th width="15%">申请部门：</th>
				<td width="30%">
					<div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="deptId" name="deptId">
							      <input class="form-control" placeholder="请选择部门" type="text" id="applyDeptidAlias" name="applyDeptidAlias" >
							      <span	class="input-group-addon" id="deptbtn"> 
							      	<i class="glyphicon glyphicon-equalizer"></i>
								 </span>
						        </div>
				</td>
				<th width="15%"></th>
				<td width="30%">					
				</td>
			</tr>
			<!-- 
			<tr>
				<th width="15%">流程状态：</th>
				<td width="30%">
					<select name="businessState" id="businessState" class="easyui-combobox form-control input-sm" style="width:150px;">
						<option value="">请选择</option>
						<option value="start">拟稿中</option>
						<option value="active">流转中</option>
						<option value="ended">已完成</option>
					</select>
				</td>
				<th></th>
				<td></td>
				
			</tr>
			 -->

		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmprocess/js/BpmProcInst.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>

<script type="text/javascript">
	var bpmCatalog;
	var bpmProcInst;
	var nodeId = <%=nodeId%>;
	var nodeType = <%=nodeType%>;
	var pdId = <%=pdId%>;
	
	function selectSearchType(obj){
		var selectVal = obj.options[obj.selectedIndex].value;
		if('title'==selectVal){
			$("#commonSearch").html('<input type="text" name="bpmProcInst_keyWord"  id="bpmProcInst_keyWord" class="form-control input-sm" placeholder="请输入标题"   onkeydown="if(event.keyCode==13){queryByKeyWord();}"> <label id="bpmProcInst_searchPart" class="icon icon-search form-tool-searchicon" onClick="queryByKeyWord()"></label>');
		}else if('priority'==selectVal){
			$("#commonSearch").html('<select name="priority" id="priority" class="easyui-combobox form-control input-sm" style="width:150px;" onChange="queryByPriority(this)"><option value="0">一般</option><option value="1">紧急</option><option value="2">特急</option></select>');
		}else if('startDate'==selectVal){
			var cumtomHtml = '<div class="dropdown">'
		        +'<a id="queryStartDateName" class="btn btn-primary form-tool-btn btn-sm form-control" role="button" style="text-align:center;align:center;width:120px;" href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu">时间不限 <span class="caret"></span></a>'
		        +'<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="text-align:center;align:center;"width:120px;">'
		        +'  <li role="presentation"><a href="javascript:void(0)" onClick="queryByStartDate(\'\')">时间不限</a></li>'
		        +'  <li role="presentation"><a href="javascript:void(0)" onClick="queryByStartDate(\'today\')">今天</a></li>'
		        +'  <li role="presentation"><a href="javascript:void(0)" onClick="queryByStartDate(\'threeDay\')">近三天</a></li>'
		        +'  <li role="presentation"><a href="javascript:void(0)" onClick="queryByStartDate(\'oneWeek\')">近一周</a></li>'
		        +'  <li role="presentation"><a href="javascript:void(0)" onClick="queryByStartDate(\'oneMonth\')">近一月</a></li>'
		        +'  <li role="presentation" class="divider"></li>'
		        +'  <li role="presentation" ><a data-stopPropagation="true">自定义</a></li>'
		        +'  <li role="presentation" style="align:center;font-size:12px;" data-stopPropagation="true">'
		        +'	&nbsp;从&nbsp;<input class="date-picker" style="width:100px;font-size:12px;border: 1px solid #E5E5E5;" type="text" '
				+'	name="customDateBegin" id="customDateBegin" onClick="onSelectCustomDate()"/>'
		       // +'  <span	class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>'
		        +'  </li>'
		        +'	<li role="presentation" style="align:center;font-size:12px;" data-stopPropagation="true">'
		        +'	&nbsp;至&nbsp;<input class="date-picker" style="width:100px;font-size:12px;border: 1px solid #E5E5E5;" type="text"'
				+'	name="customDateEnd" id="customDateEnd" onClick="onSelectCustomDate()"/>'
		       // +'  <span	class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>'
		        +'  </li>'
				+'  <li role="presentation"><a href="javascript:void(0)" onClick="queryByCustomDate()">确定</a></li>'
		        +'</ul>'
		        +'</div>';
			$("#commonSearch").html(cumtomHtml);
			$("ul.dropdown-menu").on("click", "[data-stopPropagation]", function(e) {  
			        e.stopPropagation();  
			    });  
			$('.date-picker').datepicker({
				beforeShow : function() {
					setTimeout(function() {
						$('#ui-datepicker-div').css("z-index", 99999999);
					}, 100);
				},
				endDate : new Date(),
				onClose:function(){
					$("#queryStartDateName").removeClass("av-hold");
				}
			});
		}
	}

	function onSelectCustomDate(){
		$("#queryStartDateName").removeClass("av-hold");
		$("#queryStartDateName").addClass("av-hold");
	}
	
	function queryByKeyWord(){
		bpmProcInst.searchByKeyWord();
	}
	
	function queryByStartDate(selectDay){
		$("#queryStartDateName").removeClass("av-hold");
		var strFormat = "yyyy-MM-dd";
		var curDate=new Date()
		var strCurDate = curDate.format(strFormat);
		var strDateBegin;
		var strDateEnd = strCurDate;
		var selectDayName;
		//今天
		if(selectDay=='today'){
			strDateBegin = strCurDate;		
			selectDayName = "今天";
		}else if(selectDay=='threeDay'){//近三天
			var beginDate = curDate.addDay(-2);
			strDateBegin = beginDate.format(strFormat);
			selectDayName = "近三天";
			
		}else if (selectDay=='oneWeek'){//近一周
			var beginDate = curDate.addDay(-6);
			strDateBegin = beginDate.format(strFormat);
			selectDayName = "近一周";
			
		}else if(selectDay=='oneMonth'){//近一月
			var beginDate = curDate.addMonth(-1).addDay(1);
			strDateBegin = beginDate.format(strFormat);
			selectDayName = "近一月";
		}else if(selectDay==''){
			selectDayName = "时间不限";
		}
		$("#queryStartDateName").html(selectDayName+' <span class="caret"></span>');
		bpmProcInst.searchByStartDate(strDateBegin,strDateEnd);
		
	}
	
	function queryByCustomDate(){
		$("#queryStartDateName").removeClass("av-hold");
		var customDateBegin;
		var customDateEnd;
		if($("#customDateBegin").val()=='' && $("#customDateEnd").val()=='' ){
			layer.alert('请选择日期！', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0
				}
			);
			$("#queryStartDateName").addClass("av-hold");
			return;
		}
		if($("#customDateBegin").val()!=''){
			customDateBegin = $("#customDateBegin").val();
		}
		if($("#customDateEnd").val()!=''){
			customDateEnd = $("#customDateEnd").val();
		}
		
		if($("#customDateBegin").val()!='' && $("#customDateEnd").val()!='' 
				&& $("#customDateEnd").val()<$("#customDateBegin").val()){
			$("#queryStartDateName").addClass("av-hold");
			layer.alert('开始日期不能大于结束日期！', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0
				}
			);
			return;
		}
		$("#queryStartDateName").html("自定义"+' <span class="caret"></span>');
		bpmProcInst.searchByStartDate(customDateBegin,customDateEnd);
	}
	
	function queryByPriority(obj){
		var selectVal = obj.options[obj.selectedIndex].value;
		bpmProcInst.searchByPriority(selectVal);
		
	}
	
	function getTraceButtons(cellvalue, options, rowObject){
		//return '<a id="bpmProcInst_trace" href="javascript:void(0)" class="glyphicon glyphicon-search flow-icon-big"'
		//+'  title="流程跟踪" onClick="processTrace(\''+rowObject.entryid+'\')"> </a>';		
		if(cellvalue==undefined || cellvalue==''){
			cellvalue=rowObject.procDefName;
			if(cellvalue==undefined || cellvalue==''){
				cellvalue="无";
			}
		}
		return '<a href="javascript:void(0)" onClick="parent.parent.loadEastAndSouth(\''+rowObject.dbId+'\')">'+cellvalue+'</a>';
	}
	
	function formatPriority(cellvalue, options, rowObject){
		if(cellvalue == "2"){
			return '<img align="center" src="static/images/platform/bpm/client/images/highest.gif"/>';
		}else if(cellvalue == "1"){
			return '<img align="center" src="static/images/platform/bpm/client/images/high.gif"/>';
		}else{
			return '<img align="center" src="static/images/platform/bpm/client/images/normal.gif"/>';
		}
	}
	
	function formatTaskOpt(cellvalue, options, rowObject){
		var processInstance = "'"+rowObject.processInstance+"'";
		var executionId = "'"+rowObject.executionId+"'";
		var dbid = "'"+rowObject.dbid+"'";
		var businessId = "'"+rowObject.businessId+"'";
		var url = "'"+rowObject.formResourceName+"'";
		var title = "'"+rowObject.title+"'";
		var taskType = "'"+rowObject.taskType+"'";
		return '<a href="javascript:window.executeTask('+processInstance+','+executionId+','+dbid+','+businessId+','+url+','+title+','+taskType+')">'+'办理'+'</a>';
	}
	
	function executeTask(entryId, executionId, taskId, formId, url, title,taskType) {
		flowUtils.executeTask(entryId,executionId,taskId,formId,url,title,taskType);
	}
	
	function processTrace(entryid){
		bpmProcInst.processTrace(entryid);
	}
	
	function bpm_operator_refresh(){
		bpmProcInst.reLoad(nodeId, nodeType, pdId);
	}
	
	
	$(document).ready(function() {
		var searchSubNames = new Array();
		var searchSubTips = new Array();
		searchSubNames.push("title");
		searchSubTips.push("标题");
		$('#bpmProcInst_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
		var bpmProcInstGridColModel = [
			{
				label : 'dbId',
				name : 'dbId',
				key : true,
				hidden : true
			}
			,{
				label : 'executionId',
				name : 'executionId',
				hidden : true
			}
			, {
				label : '标题',
				name : 'title',
				align : 'left',
				sortable : true,
				formatter : getTraceButtons
			}
			, {
				label : '申请日期',
				name : 'startDate',
				width : 140,
				fixed : true,
				align : 'center',
				sortable : true,
				formatter : function(value, rec) {
					var startdateMi = value;
					if (startdateMi == undefined) {
						return '';
					}
					var newDate = new Date(startdateMi);
					return newDate.format("yyyy-MM-dd hh:mm:ss");
				}
			}			
			, {
				label : '状态',
				name : 'businessState',
				width : 60,
				fixed : true,
				align : 'center',
				sortable : true,
				formatter : function(cellvalue, options, rowObject) {
					if (cellvalue == 'start') {
						return '拟稿中';
					} else if (cellvalue == 'active') {
						return '流转中';
					} else if (cellvalue == 'ended') {
						return '已完成';
					}else{
						return cellvalue;
					}

				}
			}
			, {
				label : '发送人',
				name : 'taskSendUser',
				width : 80,
				fixed : true,
				align : 'left',
				sortable : false
			}
		];

		var url = "bpm/process/searchHistProcessByPage?type=0";
		bpmProcInst = new BpmProcInst('bpmProcInst', url, "formSub", bpmProcInstGridColModel, 'searchDialogSub', nodeId, nodeType, searchSubNames, "bpmProcInst_keyWord",pdId,'tab1','我的草稿');

	
		
		//打开高级查询
		$('#bpmProcInst_searchAll').bind('click', function() {
			bpmProcInst.openSearchForm(this, $('#bpmProcInst'));
			
		});
		//关键字段查询按钮绑定事件
		$('#bpmProcInst_searchPart').bind('click', function() {
			bpmProcInst.searchByKeyWord();
			
		});
		
		$('#bpmProcinst_button_del').bind('click', function() {
			bpmProcInst.del();
		});
		
		$('#receptUserName').on('focus', function(e) {
			new H5CommonSelect({
				type : 'userSelect',
				idFiled : 'userId',
				textFiled : 'receptUserName',
				viewScope : 'currentOrg'
			});
		});
		
		$('#applyDeptidAlias').on('focus',function(){
	    	new H5CommonSelect({type:'deptSelect', idFiled:'deptId',textFiled:'applyDeptidAlias',viewScope : 'currentOrg'});
		});

	});
	

</script>
</html>