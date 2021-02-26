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
<!-- ControllerPath = "platform/avicit/elect/dynElect/dynElectController/toDynElectManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',onResize:function(a){$('#dynElectJqGrid').setGridHeight($(window).height()/2-115);$(window).trigger('resize');}">
		<div id="dynElectTableToolbar" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynElect_button_add" permissionDes="添加">
			  		<a id="dynElect_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynElect_button_edit" permissionDes="编辑">
					<a id="dynElect_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynElect_button_delete" permissionDes="删除">
					<a id="dynElect_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
		    <div class="toolbar-right">
			    <div class="input-group form-tool-search">
		     		<input type="text" name="dynElect_keyWord" id="dynElect_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
		     		<label id="dynElect_searchPart" class="icon icon-search form-tool-searchicon"></label>
		   		</div>
		   		<div class="input-group-btn form-tool-searchbtn">
		   			<a id="dynElect_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
		   		</div>
		    </div>
		</div>					
		<table id="dynElectJqGrid"></table>
		<div id="dynElectJqGridPager"></div>
	</div>
	<div data-options="region:'south',split:true,height:fixheight(.5),onResize:function(a){$('#dynElectPersonJqGrid').setGridHeight($(window).height()/2-120);$(window).trigger('resize');}">
		<div id="dynElectPersonTableToolbar" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynElectPerson_button_add" permissionDes="添加">
			  		<a id="dynElectPerson_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynElectPerson_button_edit" permissionDes="编辑">
					<a id="dynElectPerson_modify" href="javascript:void(0)" style="display:none;" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynElectPerson_button_delete" permissionDes="删除">
					<a id="dynElectPerson_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
		    <div class="toolbar-right">
			    <div class="input-group form-tool-search">
		     		<input type="text" name="dynElectPerson_keyWord" id="dynElectPerson_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
		     		<label id="dynElectPerson_searchPart" class="icon icon-search form-tool-searchicon"></label>
		   		</div>
		   		<div class="input-group-btn form-tool-searchbtn">
		   			<a id="dynElectPerson_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
		   		</div>
		    </div>
		</div>					
		<table id="dynElectPersonJqGrid"></table>
		<div id="dynElectPersonJqGridPager"></div>
	</div>
</body>

<!-- 主表高级查询begin -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">
					<label for="name">选举名称:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="name"  id="name" />
				</td>
				<th width="10%">
					<label for="status">状态:</label>
				</th>
				<td width="39%">
					<pt6:h5select css_class="form-control input-sm" name="status" id="status" title="" isNull="true" lookupCode="elect_status" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="agreeRuleNum">可赞成数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="agreeRuleNum" id="agreeRuleNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="shouldInvestNum">应投数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="shouldInvestNum" id="shouldInvestNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="sceneNum">实到数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="sceneNum" id="sceneNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="loginNum">登陆数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="loginNum" id="loginNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="actualInvestNum">实投数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="actualInvestNum" id="actualInvestNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="ruleDesc">规则描述:</label>
				</th>
				<td>
					<textarea class="form-control input-sm" rows="3" style="resize:none" name="ruleDesc" id="ruleDesc"></textarea> 
				</td>
			</tr>
<%--			<tr>--%>
<%--				<th>--%>
<%--					<label for="att01">备用字段1:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att01"  id="att01" />--%>
<%--				</td>--%>
<%--				<th>--%>
<%--					<label for="att02">备用字段2:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att02"  id="att02" />--%>
<%--				</td>--%>
<%--			</tr>--%>
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
			<tr>
<%--				<th>--%>
<%--					<label for="att05">备用字段5:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att05"  id="att05" />--%>
<%--				</td>--%>
				<th>
					<label for="roundNum">轮数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="roundNum" id="roundNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">
					<label for="isShowPersons">是否显示人员信息:</label>
				</th>
				<td width="39%">
					<pt6:h5select css_class="form-control input-sm" name="isShowPersons" id="isShowPersons" title="" isNull="true" lookupCode="SHOW_OR_HIDE" />
				</td>
				<th width="10%">
					<label for="isShowVoteNum">是否显示票数:</label>
				</th>
				<td width="39%">
					<pt6:h5select css_class="form-control input-sm" name="isShowVoteNum" id="isShowVoteNum" title="" isNull="true" lookupCode="SHOW_OR_HIDE" />
				</td>
			</tr>
			<tr>
				<th width="10%">
					<label for="isShowRanking">是否显示排名:</label>
				</th>
				<td width="39%">
					<pt6:h5select css_class="form-control input-sm" name="isShowRanking" id="isShowRanking" title="" isNull="true" lookupCode="SHOW_OR_HIDE" />
				</td>
				<th width="10%">
					<label for="scanPlan">方案:</label></th>
				<td width="39%">
					<pt6:h5select css_class="form-control input-sm" name="scanPlan" id="scanPlan" title="" isNull="true" lookupCode="SCAN_PLAN" />
				</td>
			</tr>
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
<!-- 主表高级查询end -->

<!-- 子表高级查询begin -->
<div id="dynElectPersonSearchDialog" style="overflow: auto;display: none">
	<form id="dynElectPersonForm" style="padding: 10px;">
	<input type="hidden" name="electId" id="electId" />
		<table class="form_commonTable">
			<tr>
				<th width="10%">
					<label for="electName">选举名称:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="electName"  id="electName" />
				</td>
				<th width="10%">
					<label for="personId">候选人id:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="personId"  id="personId" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="personName">候选人名称:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="personName"  id="personName" />
				</td>
				<th>
					<label for="ifMark">是否加星:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="ifMark"  id="ifMark" />
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
					<label for="major">专业:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="major"  id="major" />
				</td>
<%--				<th>--%>
<%--					<label for="ruleDesc">规则描述:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="ruleDesc"  id="ruleDesc" />--%>
<%--				</td>--%>
			</tr>
			<tr>
<%--				<th>--%>
<%--					<label for="att06">轮数:</label>--%>
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
			</tr>
<%--			<tr>--%>
<%--				<th>--%>
<%--					<label for="att01">备用字段1:</label>--%>
<%--				</th>--%>
<%--				<td>--%>
<%--					<input class="form-control input-sm" type="text" name="att01"  id="att01" />--%>
<%--				</td>--%>
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
<!-- 子表高级查询end -->
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/elect/dynelect/js/DynElect.js?v=${jsversion}" type="text/javascript"></script>
<script src="avicit/elect/dynelectperson/js/DynElectPerson.js?v=${jsversion}" type="text/javascript"></script>
<script type="text/javascript">
var dynElect;
var dynElectPerson;
function formatValueDynElectPerson(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="dynElectPerson.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatIsShow(cellvalue, options, rowObject) {
	if(cellvalue==1){
		return '显示';
	}else{
		return '隐藏';
	}
}
function formatScanPlan(cellvalue, options, rowObject) {
	if(cellvalue==1){
		return '多个二维码';
	}else if(cellvalue==2){
		return '单个二维码';
	}else {
		return "";
	}
}
function formatDateForHrefDynElectPerson(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="dynElectPerson.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="dynElect.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="dynElect.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}

$(document).ready(function () {
	var dynElectPersonDataGridColModel =  [
		{ label : 'id', name : 'id', key : true, width : 75, hidden : true},
		{ label : '选举名称', name : 'electName',formatter:formatValueDynElectPerson,width: 150},
		{ label : '规则描述', name : 'ruleDesc',width: 150},
		{ label : '候选人id', name : 'personId',width: 150},
		{ label : '候选人名称', name : 'personName',width: 150},
		{ label : '候选人部门', name : 'personDeptName',width: 150},
		{ label : '专业', name : 'major', width: 150},
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
		// { label : '备用字段10', name : 'att10',width: 150},
	];

	var dataGridColModel =  [
		{ label : 'id', name : 'id', key : true, width : 75, hidden : true},
		{ label : '选举名称', name : 'name',formatter:formatValue,width: 150},
		{ label : '状态', name : 'statusName',width: 150},
		{ label : '可赞成数', name : 'agreeRuleNum',width: 150},
		{ label : '应投数', name : 'shouldInvestNum',width: 150},
		{ label : '实到数', name : 'sceneNum',width: 150},
		{ label : '登陆数', name : 'loginNum',width: 150},
		{ label : '实投数', name : 'actualInvestNum',width: 150},
		{ label : '规则描述', name : 'ruleDesc',width: 150},
		{ label : '轮数', name : 'roundNum',width: 150},
		{ label : '活动标识', name : 'groupId',width: 150},
		{ label : '是否显示人员信息', name : 'isShowPersons',formatter:formatIsShow,width: 150},
		{ label : '是否显示票数', name : 'isShowVoteNum',formatter:formatIsShow,width: 150},
		{ label : '是否显示排名', name : 'isShowRanking',formatter:formatIsShow,width: 150},
		{ label : '方案', name : 'scanPlan',formatter:formatScanPlan,width: 150},
	];

	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("name");
	searchTips.push("选举名称");
	searchNames.push("att01");
	searchTips.push("备用字段1");
	var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
	$('#dynElect_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	var dynElectPersonSearchNames = new Array();
	var dynElectPersonSearchTips = new Array();
	dynElectPersonSearchNames.push("electName");
	dynElectPersonSearchTips.push("选举名称");
	dynElectPersonSearchNames.push("personId");
	dynElectPersonSearchTips.push("候选人id");
	var dynElectPersonSearchC = dynElectPersonSearchTips.length == 2 ? '或' + dynElectPersonSearchTips[1] : "";
	$('#dynElectPerson_keyWord').attr('placeholder','请输入' + dynElectPersonSearchTips[0] + dynElectPersonSearchC);
	//添加按钮绑定事件
	$('#dynElectPerson_insert').bind('click', function(){
		dynElectPerson.insert(dynElect.getSelectID());
	});
	//编辑按钮绑定事件
	$('#dynElectPerson_modify').bind('click', function(){
		dynElectPerson.modify();
	});
	//删除按钮绑定事件
	$('#dynElectPerson_del').bind('click', function(){  
		dynElectPerson.del();
	});
	//查询按钮绑定事件
	$('#dynElectPerson_searchPart').bind('click', function(){
		dynElectPerson.searchByKeyWord();
	});
	//打开高级查询框
	$('#dynElectPerson_searchAll').bind('click', function(){
		dynElectPerson.openSearchForm(this);
	});			
	//实例化主表对象
	dynElect = new DynElect('dynElectJqGrid','${url}','searchDialog','form','dynElect_keyWord',searchNames,dataGridColModel);
	dynElect.setOnLoadSuccess(function(pid) {
		if(dynElectPerson == null){
			dynElectPerson = new DynElectPerson('dynElectPersonJqGrid','${dynElectPersonUrl}','dynElectPersonSearchDialog','dynElectPersonForm','dynElectPerson_keyWord',dynElectPersonSearchNames,dynElectPersonDataGridColModel,pid);
		}
	});
	dynElect.setOnSelectRow(function(pid) {
		dynElectPerson.loadByPid(pid);
	});
	//添加按钮绑定事件
	$('#dynElect_insert').bind('click', function(){
		dynElect.insert();
	});
	//编辑按钮绑定事件
	$('#dynElect_modify').bind('click', function(){
		dynElect.modify();
	});
	//删除按钮绑定事件
	$('#dynElect_del').bind('click', function(){  
		dynElect.del();
	});
	//查询按钮绑定事件
	$('#dynElect_searchPart').bind('click', function(){
		dynElect.searchByKeyWord();
	});
	//打开高级查询框
	$('#dynElect_searchAll').bind('click', function(){
		dynElect.openSearchForm(this);
	});			

});

</script>
</html>
