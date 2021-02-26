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
<!-- ControllerPath = "platform/avicit/elect/dynNumPlate/dynNumPlateController/toDynNumPlateManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynNumPlate_button_add" permissionDes="添加">
	  		<a id="dynNumPlate_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynNumPlate_button_edit" permissionDes="编辑">
			<a id="dynNumPlate_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynNumPlate_button_delete" permissionDes="删除">
			<a id="dynNumPlate_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
		</sec:accesscontrollist>
	</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="dynNumPlate_keyWord" id="dynNumPlate_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="dynNumPlate_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="dynNumPlate_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="dynNumPlatejqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">
					<label for="num">号码:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="num"  id="num" />
				</td>
				<th width="10%">
					<label for="status">状态:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="status"  id="status" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="loginStatus">登录状态:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="loginStatus"  id="loginStatus" />
				</td>
				<%--<th>
					<label for="att01">备用字段1:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="att01"  id="att01" />
				</td>--%>
			</tr>
			<%--<tr>
				<th>
					<label for="att02">备用字段2:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="att02"  id="att02" />
				</td>
				<th>
					<label for="att03">备用字段3:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="att03"  id="att03" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="att04">备用字段4:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="att04"  id="att04" />
				</td>
				<th>
					<label for="att05">备用字段5:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="att05"  id="att05" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="att06">备用字段6:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="att06" id="att06" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="att07">备用字段7:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="att07" id="att07" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="att08">备用字段8:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="att08" id="att08" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="att09">备用字段9:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="att09" id="att09" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="att10">备用字段10:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="att10" id="att10" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>--%>
    	</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/elect/dynnumplate/js/DynNumPlate.js?v=${jsversion}" type="text/javascript"></script>
<script type="text/javascript">
var dynNumPlate;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="dynNumPlate.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatStatus(cellvalue, options, rowObject) {
	if("0"==cellvalue){
		return '无效';
	}else{
		return '有效';
	}
}
function formatLoginStatus(cellvalue, options, rowObject) {
	if("0"==cellvalue){
		return '未登录';
	}else{
		return '已登录';
	}
}
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="dynNumPlate.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//清空日期值
function clearCommonSelectValue(element) {
	$(element).siblings("input").val("");
}
		
$(document).ready(function () {
	var dataGridColModel =  [
		{ label : 'id', name : 'id', key : true, width : 75, hidden : true},
		{ label : '号码', name : 'num',formatter:formatValue,width: 150},
		{ label : '状态', name : 'status',formatter:formatStatus,width: 150},
		{ label : '登录状态', name : 'loginStatus',formatter:formatLoginStatus,width: 150},
		/*{ label : '备用字段1', name : 'att01',width: 150},
		{ label : '备用字段2', name : 'att02',width: 150},
		{ label : '备用字段3', name : 'att03',width: 150},
		{ label : '备用字段4', name : 'att04',width: 150},
		{ label : '备用字段5', name : 'att05',width: 150},
		{ label : '备用字段6', name : 'att06',width: 150},
		{ label : '备用字段7', name : 'att07',width: 150},
		{ label : '备用字段8', name : 'att08',width: 150},
		{ label : '备用字段9', name : 'att09',width: 150},
		{ label : '备用字段10', name : 'att10', width: 150}*/
	];

	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("num");
	searchTips.push("号码");
	searchNames.push("status");
	searchTips.push("状态");
	var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
	$('#dynNumPlate_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	
	dynNumPlate= new DynNumPlate('dynNumPlatejqGrid','${url}','searchDialog','form','dynNumPlate_keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#dynNumPlate_insert').bind('click', function(){
		dynNumPlate.insert();
	});
	//编辑按钮绑定事件
	$('#dynNumPlate_modify').bind('click', function(){
		dynNumPlate.modify();
	});
	//删除按钮绑定事件
	$('#dynNumPlate_del').bind('click', function(){  
		dynNumPlate.del();
	});
	//查询按钮绑定事件
	$('#dynNumPlate_searchPart').bind('click', function(){
		dynNumPlate.searchByKeyWord();
	});
	//打开高级查询框
	$('#dynNumPlate_searchAll').bind('click', function(){
		dynNumPlate.openSearchForm(this);
	});			
});

</script>
</html>
