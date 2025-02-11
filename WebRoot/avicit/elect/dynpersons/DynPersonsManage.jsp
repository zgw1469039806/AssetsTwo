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
<!-- ControllerPath = "platform/avicit/elect/dynPersons/dynPersonsController/toDynPersonsManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynPersons_button_add" permissionDes="添加">
	  		<a id="dynPersons_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynPersons_button_edit" permissionDes="编辑">
			<a id="dynPersons_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynPersons_button_delete" permissionDes="删除">
			<a id="dynPersons_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
		</sec:accesscontrollist>
	</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="dynPersons_keyWord" id="dynPersons_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="dynPersons_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="dynPersons_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="dynPersonsjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">
					<label for="no">序号:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="no"  id="no" />
				</td>
				<th width="10%">
					<label for="name">姓名:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="name"  id="name" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="deptName">部门名称:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="deptName"  id="deptName" />
				</td>
				<th>
					<label for="major">专业:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="major"  id="major" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="status">状态:</label>
				</th>
				<td>
					<pt6:h5select css_class="form-control input-sm" name="status" id="status" title="" isNull="true" lookupCode="candidate_status" />
				</td>
				<th>
					<label for="turnNum">中选轮次:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="turnNum" id="turnNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="ifMark">是否加星:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="ifMark"  id="ifMark" />
				</td>
<%--				<th>--%>
<%--					<label for="att01">备用字段1:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att01"  id="att01" />--%>
<%--				</td>--%>
			</tr>
<%--			<tr>--%>
<%--				<th>--%>
<%--					<label for="att02">备用字段2:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att02"  id="att02" />--%>
<%--				</td>--%>
<%--				<th>--%>
<%--					<label for="att03">备用字段3:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att03"  id="att03" />--%>
<%--				</td>--%>
<%--			</tr>--%>
<%--			<tr>--%>
<%--				<th>--%>
<%--					<label for="att04">备用字段4:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att04"  id="att04" />--%>
<%--				</td>--%>
<%--				<th>--%>
<%--					<label for="att05">备用字段5:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att05"  id="att05" />--%>
<%--				</td>--%>
<%--			</tr>--%>
<%--			<tr>--%>
<%--				<th>--%>
<%--					<label for="att06">备用字段6:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<div class="input-group input-group-sm spinner" data-trigger="spinner">--%>
<%--						<input  class="form-control"  type="text" name="att06" id="att06" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">--%>
<%--						<span class="input-group-addon">--%>
<%--							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>--%>
<%--							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>--%>
<%--						</span>--%>
<%--					</div>--%>
<%--				</td>--%>
<%--				<th>--%>
<%--					<label for="att07">备用字段7:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<div class="input-group input-group-sm spinner" data-trigger="spinner">--%>
<%--						<input  class="form-control"  type="text" name="att07" id="att07" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">--%>
<%--						<span class="input-group-addon">--%>
<%--							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>--%>
<%--							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>--%>
<%--						</span>--%>
<%--					</div>--%>
<%--				</td>--%>
<%--			</tr>--%>
<%--			<tr>--%>
<%--				<th>--%>
<%--					<label for="att08">备用字段8:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<div class="input-group input-group-sm spinner" data-trigger="spinner">--%>
<%--						<input  class="form-control"  type="text" name="att08" id="att08" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">--%>
<%--						<span class="input-group-addon">--%>
<%--							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>--%>
<%--							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>--%>
<%--						</span>--%>
<%--					</div>--%>
<%--				</td>--%>
<%--				<th>--%>
<%--					<label for="att09">备用字段9:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<div class="input-group input-group-sm spinner" data-trigger="spinner">--%>
<%--						<input  class="form-control"  type="text" name="att09" id="att09" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">--%>
<%--						<span class="input-group-addon">--%>
<%--							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>--%>
<%--							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>--%>
<%--						</span>--%>
<%--					</div>--%>
<%--				</td>--%>
<%--			</tr>--%>
<%--			<tr>--%>
<%--				<th>--%>
<%--					<label for="att10">备用字段10:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<div class="input-group input-group-sm spinner" data-trigger="spinner">--%>
<%--						<input  class="form-control"  type="text" name="att10" id="att10" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">--%>
<%--						<span class="input-group-addon">--%>
<%--							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>--%>
<%--							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>--%>
<%--						</span>--%>
<%--					</div>--%>
<%--				</td>--%>
<%--			</tr>--%>
    	</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/elect/dynpersons/js/DynPersons.js?v=${jsversion}" type="text/javascript"></script>
<script type="text/javascript">
var dynPersons;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="dynPersons.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="dynPersons.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//清空日期值
function clearCommonSelectValue(element) {
	$(element).siblings("input").val("");
}
		
$(document).ready(function () {
	var dataGridColModel =  [
		{ label : 'id', name : 'id', key : true, width : 75, hidden : true},
		{ label : '序号', name : 'no',formatter:formatValue,width: 150},
		{ label : '姓名', name : 'name',width: 150},
		{ label : '部门名称', name : 'deptName',width: 150},
		{ label : '专业', name : 'major',width: 150},
		{ label : '状态', name : 'statusName',width: 150},
		{ label : '中选轮次', name : 'turnNum',width: 150},
		{ label : '是否加星', name : 'ifMark',width: 150},
		// { label : '备用字段1', name : 'att01',width: 150},
		// { label : '备用字段2', name : 'att02',width: 150},
		// { label : '备用字段3', name : 'att03',width: 150},
		// { label : '备用字段4', name : 'att04',width: 150},
		// { label : '备用字段5', name : 'att05',width: 150},
		// { label : '备用字段6', name : 'att06',width: 150},
		// { label : '备用字段7', name : 'att07',width: 150},
		// { label : '备用字段8', name : 'att08',width: 150},
		// { label : '备用字段9', name : 'att09',width: 150},
		// { label : '备用字段10', name : 'att10', width: 150}
	];

	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("no");
	searchTips.push("序号");
	searchNames.push("name");
	searchTips.push("姓名");
	var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
	$('#dynPersons_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	
	dynPersons= new DynPersons('dynPersonsjqGrid','${url}','searchDialog','form','dynPersons_keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#dynPersons_insert').bind('click', function(){
		dynPersons.insert();
	});
	//编辑按钮绑定事件
	$('#dynPersons_modify').bind('click', function(){
		dynPersons.modify();
	});
	//删除按钮绑定事件
	$('#dynPersons_del').bind('click', function(){  
		dynPersons.del();
	});
	//查询按钮绑定事件
	$('#dynPersons_searchPart').bind('click', function(){
		dynPersons.searchByKeyWord();
	});
	//打开高级查询框
	$('#dynPersons_searchAll').bind('click', function(){
		dynPersons.openSearchForm(this);
	});			
});

</script>
</html>
