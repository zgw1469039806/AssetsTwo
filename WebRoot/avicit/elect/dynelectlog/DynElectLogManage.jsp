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
<!-- ControllerPath = "platform/avicit/elect/dynElectLog/dynElectLogController/toDynElectLogManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynElectLog_button_add" permissionDes="添加">
	  		<a id="dynElectLog_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynElectLog_button_edit" permissionDes="编辑">
			<a id="dynElectLog_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynElectLog_button_delete" permissionDes="删除">
			<a id="dynElectLog_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
		</sec:accesscontrollist>
	</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="dynElectLog_keyWord" id="dynElectLog_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="dynElectLog_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="dynElectLog_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="dynElectLogjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">
					<label for="electId">选举表id:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="electId"  id="electId" />
				</td>
				<th width="10%">
					<label for="electName">选举名称:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="electName"  id="electName" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="ruleDesc">规则描述:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="ruleDesc"  id="ruleDesc" />
				</td>
				<th>
					<label for="numPlate">号码牌:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="numPlate"  id="numPlate" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="personId">候选人id:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="personId"  id="personId" />
				</td>
				<th>
					<label for="personName">候选人姓名:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="personName"  id="personName" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="personDeptName">候选人部门:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="personDeptName"  id="personDeptName" />
				</td>
				<th>
					<label for="att01">候选人专业:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="att01"  id="att01" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="agreeNum">赞成数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="agreeNum" id="agreeNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="unagreeNum">反对数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="unagreeNum" id="unagreeNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="giveupNum">弃权数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="giveupNum" id="giveupNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="submitDateBegin">提交时间起:</label>
				</th>
				<td>
					<div class="input-group input-group-sm">
						<input class="form-control time-picker" type="text" name="submitDateBegin" id="submitDateBegin" />
						<span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
						<span class="input-group-addon"  onclick="clearCommonSelectValue(this)"><i class="fa fa-close"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="submitDateEnd">提交时间止:</label>
				</th>
				<td>
					<div class="input-group input-group-sm">
						<input class="form-control time-picker" type="text" name="submitDateEnd" id="submitDateEnd" />
						<span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
						<span class="input-group-addon"  onclick="clearCommonSelectValue(this)"><i class="fa fa-close"></i></span>
					</div>
				</td>
<%--				<th>--%>
<%--					<label for="att02">备用字段2:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att02"  id="att02" />--%>
<%--				</td>--%>
			</tr>
<%--			<tr>--%>
<%--				<th>--%>
<%--					<label for="att03">备用字段3:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att03"  id="att03" />--%>
<%--				</td>--%>
<%--				<th>--%>
<%--					<label for="att04">备用字段4:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att04"  id="att04" />--%>
<%--				</td>--%>
<%--			</tr>--%>
<%--			<tr>--%>
<%--				<th>--%>
<%--					<label for="att05">备用字段5:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att05"  id="att05" />--%>
<%--				</td>--%>
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
<%--			</tr>--%>
<%--			<tr>--%>
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
<%--			</tr>--%>
<%--			<tr>--%>
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
<script src="avicit/elect/dynelectlog/js/DynElectLog.js?v=${jsversion}" type="text/javascript"></script>
<script type="text/javascript">
var dynElectLog;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="dynElectLog.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="dynElectLog.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//清空日期值
function clearCommonSelectValue(element) {
	$(element).siblings("input").val("");
}
		
$(document).ready(function () {
	var dataGridColModel =  [
		{ label : 'id', name : 'id', key : true, width : 75, hidden : true},
		{ label : '选举表id', name : 'electId',formatter:formatValue,width: 150},
		{ label : '选举名称', name : 'electName',width: 150},
		{ label : '规则描述', name : 'ruleDesc',width: 150},
		{ label : '号码牌', name : 'numPlate',width: 150},
		{ label : '候选人id', name : 'personId',width: 150},
		{ label : '候选人姓名', name : 'personName',width: 150},
		{ label : '候选人部门', name : 'personDeptName',width: 150},
		{ label : '候选人专业', name : 'att01',width: 150},
		{ label : '赞成数', name : 'agreeNum',width: 150},
		{ label : '反对数', name : 'unagreeNum',width: 150},
		{ label : '弃权数', name : 'giveupNum',width: 150},
		{ label : '提交时间', name : 'submitDate',width: 150},
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
	searchNames.push("electId");
	searchTips.push("选举表id");
	searchNames.push("electName");
	searchTips.push("选举名称");
	var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
	$('#dynElectLog_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	
	dynElectLog= new DynElectLog('dynElectLogjqGrid','${url}','searchDialog','form','dynElectLog_keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#dynElectLog_insert').bind('click', function(){
		dynElectLog.insert();
	});
	//编辑按钮绑定事件
	$('#dynElectLog_modify').bind('click', function(){
		dynElectLog.modify();
	});
	//删除按钮绑定事件
	$('#dynElectLog_del').bind('click', function(){  
		dynElectLog.del();
	});
	//查询按钮绑定事件
	$('#dynElectLog_searchPart').bind('click', function(){
		dynElectLog.searchByKeyWord();
	});
	//打开高级查询框
	$('#dynElectLog_searchAll').bind('click', function(){
		dynElectLog.openSearchForm(this);
	});			
});

</script>
</html>
