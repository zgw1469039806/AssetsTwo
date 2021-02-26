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
<!-- ControllerPath = "platform/avicit/cadreselect/dynTemItem/dynTemItemController/toDynTemItemManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynTemItem_button_add" permissionDes="添加">
	  		<a id="dynTemItem_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynTemItem_button_edit" permissionDes="编辑">
			<a id="dynTemItem_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynTemItem_button_delete" permissionDes="删除">
			<a id="dynTemItem_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
		</sec:accesscontrollist>
	</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="dynTemItem_keyWord" id="dynTemItem_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="dynTemItem_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="dynTemItem_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="dynTemItemjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">
					<label for="temId">模板表ID:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="temId"  id="temId" />
				</td>
				<th width="10%">
					<label for="tiUserName">候选人姓名:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="tiUserName"  id="tiUserName" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="tiUserDept">候选人部门:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="tiUserDept"  id="tiUserDept" />
				</td>
				<th>
					<label for="tiOpinion">候选人意见:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="tiOpinion" id="tiOpinion" data-min="-9999999999999999999999" data-max="9999999999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="tiShouldInvestNum">应投数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="tiShouldInvestNum" id="tiShouldInvestNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="tiActualInvestNum">实投数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="tiActualInvestNum" id="tiActualInvestNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="tiLoginNum">登陆数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="tiLoginNum" id="tiLoginNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="tiSceneNum">实到数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="tiSceneNum" id="tiSceneNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="tiStartDate起">开始时间起:</label>
				</th>
				<td>
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text" name="tiStartDateBegin" id="tiStartDateBegin" />
						<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						<span class="input-group-addon"  onclick="clearCommonSelectValue(this)"><i class="fa fa-close"></i></span>
					</div>
				</td>
				<th>
					<label for="tiStartDate止">开始时间止:</label>
				</th>
				<td>
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text" name="tiStartDateEnd" id="tiStartDateEnd" />
						<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						<span class="input-group-addon"  onclick="clearCommonSelectValue(this)"><i class="fa fa-close"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="tiEndDate起">结束时间起:</label>
				</th>
				<td>
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text" name="tiEndDateBegin" id="tiEndDateBegin" />
						<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						<span class="input-group-addon"  onclick="clearCommonSelectValue(this)"><i class="fa fa-close"></i></span>
					</div>
				</td>
				<th>
					<label for="tiEndDate止">结束时间止:</label>
				</th>
				<td>
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text" name="tiEndDateEnd" id="tiEndDateEnd" />
						<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						<span class="input-group-addon"  onclick="clearCommonSelectValue(this)"><i class="fa fa-close"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="tiState">0-使用中 1-暂停 2-删除:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="tiState" id="tiState" data-min="-9999999999999999999999" data-max="9999999999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="tiText">表格JSON:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="tiText"  id="tiText" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="tiUserSex">0- 女 1-男:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="tiUserSex" id="tiUserSex" data-min="-9999999999999999999999" data-max="9999999999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="tiUserPost">职务:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="tiUserPost"  id="tiUserPost" />
				</td>
			</tr>
    	</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/cadreselect/dyntemitem/js/DynTemItem.js?v=${jsversion}" type="text/javascript"></script>
<script type="text/javascript">
var dynTemItem;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="dynTemItem.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="dynTemItem.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//清空日期值
function clearCommonSelectValue(element) {
	$(element).siblings("input").val("");
}
		
$(document).ready(function () {
	var dataGridColModel =  [
		{ label : 'id', name : 'id', key : true, width : 75, hidden : true},
		{ label : '模板表ID', name : 'temId',formatter:formatValue,width: 150},
		{ label : '候选人姓名', name : 'tiUserName',width: 150},
		{ label : '候选人部门', name : 'tiUserDept',width: 150},
		{ label : '候选人意见', name : 'tiOpinion',width: 150},
		{ label : '应投数', name : 'tiShouldInvestNum',width: 150},
		{ label : '实投数', name : 'tiActualInvestNum',width: 150},
		{ label : '登陆数', name : 'tiLoginNum',width: 150},
		{ label : '实到数', name : 'tiSceneNum',width: 150},
		{ label : '开始时间', name : 'tiStartDate', formatter : format,width: 150},
		{ label : '结束时间', name : 'tiEndDate', formatter : format,width: 150},
		{ label : '0-使用中 1-暂停 2-删除', name : 'tiState',width: 150},
		{ label : '表格JSON', name : 'tiText',width: 150},
		{ label : '0- 女 1-男', name : 'tiUserSex',width: 150},
		{ label : '职务', name : 'tiUserPost', width: 150}
	];

	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("temId");
	searchTips.push("模板表ID");
	searchNames.push("tiUserName");
	searchTips.push("候选人姓名");
	var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
	$('#dynTemItem_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	
	dynTemItem= new DynTemItem('dynTemItemjqGrid','${url}','searchDialog','form','dynTemItem_keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#dynTemItem_insert').bind('click', function(){
		dynTemItem.insert();
	});
	//编辑按钮绑定事件
	$('#dynTemItem_modify').bind('click', function(){
		dynTemItem.modify();
	});
	//删除按钮绑定事件
	$('#dynTemItem_del').bind('click', function(){  
		dynTemItem.del();
	});
	//查询按钮绑定事件
	$('#dynTemItem_searchPart').bind('click', function(){
		dynTemItem.searchByKeyWord();
	});
	//打开高级查询框
	$('#dynTemItem_searchAll').bind('click', function(){
		dynTemItem.openSearchForm(this);
	});			
});

</script>
</html>
