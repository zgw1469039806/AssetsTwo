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
<style>
.layout-panel-center{
	height:136px!important
}
.layout-panel-south{
    top:138px!important
}
</style>
<head>
<!-- ControllerPath = "test/demo/syssearchevent/sysSearchEventController/toSysSearchEventManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:true">
		<table class="form_commonTable">
				<tr>
					<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysSearchEvent_button_save"
					permissionDes="保存">
					<a id="sysSearchEvent_save" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="保存"><i class="fa fa-file-text-o"></i> 注册</a>
					</sec:accesscontrollist>
				</tr>
		</table>
		<form id='formconfig'>
			<input class="form-control input-sm" type="hidden" name="infoid" id="infoid" /></td>
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="classname">JAVA类名:</label></th>
					<td colspan="3" width="39%"><input class="form-control input-sm"
						type="text" name="classname" id="classname" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="eventtype">事件类型:</label></th>
					<td colspan="3" width="39%">
						<select class="form-control" name="eventtype" id="eventtype" title="" isNull="true">
							<option value = "query">_QUERY_EVENT_检索查询事件</option>
							<option value = "response">_RESPONSE_EVENT_检索结果返回事件</option>
							<option value = "formatUrl">_FORMATURL_EVENT_自定义展示URL事件</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',split:true,border:true">
	    <div class="easyui-layout" fit="true">
			<table id="sysSearchEventjqGrid"></table>
			<div id="jqGridPager"></div>
	    </div>
	</div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">CLASSNAME:</th>
				<td width="39%"><input title="CLASSNAME"
					class="form-control input-sm" type="text" name="classname"
					id="classname" /></td>
				<th width="10%">EVENTTYPE:</th>
				<td width="39%">
					<select class="form-control" name="eventtype" id="eventtype" title="" isNull="true">
						<option value = "query">_QUERY_EVENT_检索查询事件</option>
						<option value = "response">_RESPONSE_EVENT_检索结果返回事件</option>
						<option value = "formatUrl">_FORMATURL_EVENT_自定义展示URL事件</option>
					</select>
				</td>
			</tr>
			<tr>
				<th width="10%">INFOID:</th>
				<td width="39%"><input title="INFOID"
					class="form-control input-sm" type="text" name="infoid" id="infoid" />
				</td>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/modules/system/fulltextsearch/js/SearchEvent.js"
	type="text/javascript"></script>
<script type="text/javascript">
	//后台获取的通用代码数据
	var sysSearchEvent;
	function buttonFormat(cellvalue, options, rowObject){
		return '<button type="button" onclick="remove(\'' + cellvalue + '\');">卸载</button>';
	};
	function remove(id){
		var ids = [];
		layer.confirm('确认要卸载此类吗?',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
			ids.push(id);
			avicAjax.ajax({
				url:'searchevent/searchEventController/operation/delete',
				data:	JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r){
					if (r.flag == "success") {
						sysSearchEvent.reLoad($('#infoid').val());
					}else{
						layer.alert('删除失败！' + r.error, {
							  icon: 7,
							  area: ['400px', ''],
							  closeBtn: 0,
							  btn: ['关闭'],
		                      title:"提示"
							});
					}
				 }
			});
			layer.close(index);
		});   
	};
	$(document).ready(function() {
			var ids = [];
			ids.push("${param.infoId}");
			avicAjax.ajax({
				url : 'searchindex/searchIndexController/operation/' + 'listColumns',
				data : JSON.stringify(ids),
				contentType : 'application/json',
				async:false,
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if(r.flag=="figure"){
						$('#sysSearchEvent_save').addClass('disabled');	
						layer.alert('请先保存基本信息，再进行事件配置！', {
							icon : 7,
							area : [ '400px', '' ], // 宽高
							closeBtn : 0,
							btn : [ '关闭' ],
							title : "提示"
						});
					}else if(r.flag=="noIndex"){
						$('#sysSearchEvent_save').addClass('disabled');	
						layer.alert('磁盘类型不需要事件配置！', {
							icon : 7,
							area : [ '400px', '' ], // 宽高
							closeBtn : 0,
							btn : [ '关闭' ],
							title : "提示"
						});
					}
				}
			});
			var dataGridColModel = [  {
				label : 'JAVA类名',
				name : 'classname',
				width : 150,
				editable : false
			}, {
				label : '事件类型',
				name : 'eventtype',
				width : 150,
				editable : false
			}, {
				label : 'INFOID',
				name : 'infoid',
				width : 150,
				editable : false,
				hidden : true
			}, {
				label : '搜索类型code',
				name : 'searchTypeCode',
				width : 150,
				editable : false,
				hidden : true
			}, {
				label : '操作',
				name : 'id',
				width : 150,
				key : true,
				editable : false,
				formatter : buttonFormat
			} ];
			var searchNames = new Array();
			var searchTips = new Array();
			searchNames.push("classname");
			searchTips.push("CLASSNAME");
			searchNames.push("eventtype");
			searchTips.push("EVENTTYPE");
			var searchC = searchTips.length == 2 ? '或'
					+ searchTips[1] : "";
			$('#sysSearchEvent_keyWord').attr('placeholder',
					'请输入' + searchTips[0] + searchC);
			sysSearchEvent = new SysSearchEvent(
					'sysSearchEventjqGrid', 'searchevent/searchEventController/operation/',
					'searchDialog', 'form',
					'sysSearchEvent_keyWord', searchNames,
					dataGridColModel,"${param.infoId}");
			$('#infoid').val("${param.infoId}");
			sysSearchEvent.formValidate($('#formconfig'));
			//隐藏页面元素
			$('#t_sysSearchEventjqGrid').hide();
			//添加按钮绑定事件
			$('#sysSearchEvent_insert').bind('click', function() {
				sysSearchEvent.insert();
			});
			//删除按钮绑定事件
			$('#sysSearchEvent_del').bind('click', function() {
				sysSearchEvent.del();
			});
			//保存按钮绑定事件
			$('#sysSearchEvent_save').bind('click', function() {
				sysSearchEvent.save();
			});
			//查询按钮绑定事件
			$('#sysSearchEvent_searchPart').bind('click',
					function() {
						sysSearchEvent.searchByKeyWord();
					});
			//打开高级查询框
			$('#sysSearchEvent_searchAll').bind('click',
					function() {
						sysSearchEvent.openSearchForm(this);
					});
			//回车键查询
			$('#sysSearchEvent_keyWord').on('keydown', function(e) {
				if (e.keyCode == 13) {
					sysSearchEvent.searchByKeyWord();
				}
			});

});
</script>
</html>