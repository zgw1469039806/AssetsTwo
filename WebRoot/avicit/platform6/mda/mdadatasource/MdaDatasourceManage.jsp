<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%-- <%  
String M = session.getAttribute("CURRENT_LOGINUSER")
%>  --%> 
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/mda/mdadatasource/mdaDatasourceController/toMdaDatasourceManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div
		data-options="region:'center',onResize:function(a){$('#demoMainDept').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_mdaDatasource" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mdaDatasource_button_add"
					permissionDes="主表添加">
					<a id="mdaDatasource_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mdaDatasource_button_edit"
					permissionDes="主表编辑">
					<a id="mdaDatasource_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mdaDatasource_button_delete"
					permissionDes="主表删除">
					<a id="mdaDatasource_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 125px">
					<input type="text" name="mdaDatasource_keyWord"
						id="mdaDatasource_keyWord" style="width: 125px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="mdaDatasource_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="mdaDatasource_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div>
		</div>
		<table id="mdaDatasource"></table>
		<div id="mdaDatasourcePager"></div>
	</div>
	<div
		data-options="region:'east',split:true,width:fixwidth(.5),onResize:function(a){$('#demoSubUser').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_mdaCrawlitems" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mdaCrawlitems_button_add"
					permissionDes="子表添加">
					<a id="mdaCrawlitems_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mdaCrawlitems_button_edit"
					permissionDes="子表编辑">
					<a id="mdaCrawlitems_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mdaCrawlitems_button_delete"
					permissionDes="子表删除">
					<a id="mdaCrawlitems_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mdaCrawlitems_button_set"
					permissionDes="配置">
					<a id="mdaCrawlitems_set" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="配置"><i class="fa a-file-text-o"></i> 配置</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mdaCrawlitems_button_stop"
					permissionDes="配置">
					<a id="mdaCrawlitems_stop" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="停止任务"><i class="fa a-file-text-o"></i>停止任务</a>
				</sec:accesscontrollist>
			</div>
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 125px">
					<input type="text" name="mdaCrawlitems_keyWord"
						id="mdaCrawlitems_keyWord" style="width: 125px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="mdaCrawlitems_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="mdaCrawlitems_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div>
		</div>
		<table id="mdaCrawlitems"></table>
		<div id="mdaCrawlitemsPager"></div>
	</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form">
		<table class="form_commonTable">
			<tr>
				<th width="10%">数据源名称:</th>
				<td width="39%"><input title="数据源名称"
					class="form-control input-sm" type="text" name="name" id="name" />
				</td>
				<th width="10%">用户:</th>
				<td width="39%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="userid" name="userid"> <input 
							class="form-control" placeholder="请选择用户" type="text"
							id="useridAlias" name="useridAlias"> <span
							class="input-group-addon"> <i
							class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">创建时间(从):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="createtimeBegin" id="createtimeBegin" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%">创建时间(至):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="createtimeEnd" id="createtimeEnd" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">最后修改时间(从):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="lastmodifytimeBegin" id="lastmodifytimeBegin" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%">最后修改时间(至):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="lastmodifytimeEnd" id="lastmodifytimeEnd" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">状态:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="status" id="status" title="状态" isNull="true"
						lookupCode="MDA_STATUS" /></td>
			</tr>
		</table>
	</form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto; display: none">
	<form id="formSub">
		<input type="hidden" name="deptid" id="deptid" />
		<table class="form_commonTable">
			<tr>
				<th width="10%">数据源配置名称:</th>
				<td width="39%"><input title="数据源配置名称"
					class="form-control input-sm" type="text" name="name" id="name" />
				</td>
				<th width="10%">创建时间(从):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="createtimeBegin" id="createtimeBegin" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">创建时间(至):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="createtimeEnd" id="createtimeEnd" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%">最后修改时间(从):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="lastmodifytimeBegin" id="lastmodifytimeBegin" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">最后修改时间(至):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="lastmodifytimeEnd" id="lastmodifytimeEnd" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%">最后采集时间(从):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="lasttimecrawlBegin" id="lasttimecrawlBegin" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">最后采集时间(至):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="lasttimecrawlEnd" id="lasttimecrawlEnd" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%">最后采集用户:</th>
				<td width="39%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="lastcrawluserid" name="lastcrawluserid">
						<input class="form-control" placeholder="请选择用户" type="text"
							id="lastcrawluseridAlias" name="lastcrawluseridAlias"> <span
							class="input-group-addon"> <i
							class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">采集类型:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="itemtype" id="itemtype" title="采集类型" isNull="true"
						lookupCode="MDA_ITEMTYPE" /></td>
				<th width="10%">分类:</th>
				<td width="39%"><input title="分类" class="form-control input-sm"
					type="text" name="classifyids" id="classifyids" /></td>
			</tr>
			<tr>
				<th width="10%">状态:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="status" id="status" title="状态" isNull="true"
						lookupCode="MDA_STATUS" /></td>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/mda/mdadatasource/js/MdaDatasource.js"
	type="text/javascript"></script>
<script src="avicit/platform6/mda/mdadatasource/js/MdaCrawlitems.js"
	type="text/javascript"></script>
<script type="text/javascript">

function refresh(){
   window.location.reload();
}

	var mdaDatasource;
	var mdaCrawlitems,insertIndex;
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mdaDatasource.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="mdaDatasource.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}
	function openNext(type,tmpID){
		var num = $("#mdaCrawlitems").find("tr[role='row']").find("input[type='checkbox']:checked").size();
		 if(num==0){
			 layer.alert('请选择一条数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		 );
		 return false;
		 }
		 if(num>1){
			 layer.alert('只能选择一条数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		 );
		 return false;
		 }
		 layer.close(insertIndex); 
		 var _id = $("#mdaCrawlitems").find("tr[role='row']").find("input[type='checkbox']:checked").parent().parent().attr("id")
		 insertIndex = layer.open({
			    type: 2,
			    area: ['100%', '100%'],
			    title: '设置',
			    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		        maxmin: false, //开启最大化最小化按钮
			    content: 'platform/platform6/mda/mdadatasource/mdaDatasourceController/setTow/'+tmpID+'/'+type+'/'+_id 
			});
	}
	
	
	function openc(type){
		var num = $("#mdaCrawlitems").find("tr[role='row']").find("input[type='checkbox']:checked").size();
		 if(num==0){
			 layer.alert('请选择一条数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		 );
		 return false;
		 }
		 if(num>1){
			 layer.alert('只能选择一条数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		 );
		 return false;
		 }
		 layer.close(insertIndex); 
		 var _id = $("#mdaCrawlitems").find("tr[role='row']").find("input[type='checkbox']:checked").parent().parent().attr("id")
		 insertIndex = layer.open({
			    type: 2,
			    area: ['100%', '100%'],
			    title: '设置',
			    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		        maxmin: false, //开启最大化最小化按钮
			    content: 'platform/platform6/mda/mdadatasource/mdaDatasourceController/setTow/'+type+'/'+_id 
			});
	}
	
	function toStopTask(){
		var num = $("#mdaCrawlitems").find("tr[role='row']").find("input[type='checkbox']:checked").size();
		 if(num==0){
			 layer.alert('请选择一条数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		 );
		 return false;
		 }
		 if(num>1){
			 layer.alert('只能选择一条数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		 );
		 return false;
		 }
		 layer.close(insertIndex); 
		 var _id = $("#mdaCrawlitems").find("tr[role='row']").find("input[type='checkbox']:checked").parent().parent().attr("id");
		// alert('=========停止任务==_id==='+_id);
		 $.ajax({
			 url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/crawl/toStopTask/"+_id ,
			 type : 'post',
			 success : function(r){
				 if (r == "ok"){
					 layer.alert('停止成功！' ,{
						  icon: 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0
					    }, function(){
					    	refresh();
				        }
					 );
				 }else if(r == "err"){
					 layer.alert('停止失败！' ,{
						  icon: 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0
					    }, function(){
					    	refresh();
				        }
			         );
				 }else if(r == "none"){
					 layer.alert('当前任务未运行，无需停止！' ,{
						  icon: 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0
					    }, function(){
					    	refresh();
				        }
			         );
				 } else{
					 layer.alert('程序异常！' ,{
						  icon: 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0
					    }, function(){
					    	refresh();
				        }
			         );
				 } 
			 }
		 });
	}
	
	function closWinc(){
		 layer.close(insertIndex); 
		 mdaCrawlitems.reLoad();
	}
	function upFun(){
		 var num = $("#mdaCrawlitems").find("tr[role='row']").find("input[type='checkbox']:checked").size();
		 if(num==0){
			 layer.alert('请选择一条数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		 );
		 return false;
		 }
		 if(num>1){
			 layer.alert('只能选择一条数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		 );
		
		 return false;
		 }
		 var $obj=$("#mdaCrawlitems").find("tr[role='row']").find("input[type='checkbox']:checked").parent().parent();
		 var _id = $obj.attr("id");
		 var _type='web';
		 var _typeValue=$obj.find("td[aria-describedby='mdaCrawlitems_itemtype']").text();
		 var _itemID=$obj.find("td[aria-describedby='mdaCrawlitems_id']").text();
		// alert('=====ssssssss===='+_id);
		 if(_typeValue=='文档'){
			 _type='doc';
		 }
		if(_typeValue=='数据库'){
			_type='db';
		}
		
		   insertIndex = layer.open({
		    type: 2,
		    area: ['100%', '100%'],
		    title: '设置',
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
	        maxmin: false, //开启最大化最小化按钮
		    content: 'platform/platform6/mda/mdadatasource/mdaDatasourceController/set/'+_type+'/'+_id
		}); 
	}
	
	//开始爬取数据
	 function crawlFlag(crawlflag,crawlItemID,type) {
		 if(crawlflag == 'config'||crawlflag == 'ok'||crawlflag == 'err'){
				//执行中
				$("#btn"+crawlItemID).attr("src","static/images/platform/mda/crawl_btn/btn_ing.png");
				//不能触发爬取操作
				//$("#btn"+crawlItemID).removeAttr("onclick"); 
					//alert("开始====：type："+type);
					//alert("开始====：当前采集项ID："+crawlItemID);
					$.ajax({
						 url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/crawl/"+crawlItemID,
						 type : 'post',
						 success : function(r){
							 if (r == "ok"){
								 layer.alert('执行成功！' ,{
									  icon: 7,
									  area: ['400px', ''], //宽高
									  closeBtn: 0
								    }, function(){
								    	refresh();
							        }
								 );
								 //爬取成功，重新至于开始爬取，准备下一次爬取
								  $("#btn"+crawlItemID).attr("src","static/images/platform/mda/crawl_btn/btn_start.png");
								 //刷新当前页面
								// refresh();
							 }else{
								 layer.alert('执行失败！' ,{
									  icon: 7,
									  area: ['400px', ''], //宽高
									  closeBtn: 0
								    }, function(){
								    	refresh();
							        }
						         );
								 //爬取失败，重新至于开始爬取，准备下一次爬取
								 $("#btn"+crawlItemID).attr("src","static/images/platform/mda/crawl_btn/btn_start.png");
								 //刷新当前页面
								// refresh();
							 } 
						 }
					 });
			}else{
				layer.alert('未配置，请先配置采集任务！' ,{
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
				    }
		         );
			} 
	    }
   
	$(document).ready(
			function() {
				var searchMainNames = new Array();
				var searchMainTips = new Array();
				searchMainNames.push("name");
				searchMainTips.push("数据源名称");
				$('#mdaDatasource_keyWord').attr('placeholder',
						'请输入' + searchMainTips[0] + '或' + searchMainTips[1]);
				var searchSubNames = new Array();
				var searchSubTips = new Array();
				searchSubNames.push("name");
				searchSubTips.push("数据源配置名称");
				searchSubNames.push("classifyids");
				searchSubTips.push("分类");
				$('#mdaCrawlitems_keyWord').attr('placeholder',
						'请输入' + searchSubTips[0] + '或' + searchSubTips[1]);
				var mdaDatasourceGridColModel = [{
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '数据源名称',
					name : 'name',
					width : 150
				}, {
					label : '用户',
					name : 'useridAlias',
					width : 150
				}, {
					label : '创建时间',
					name : 'createtime',
					width : 150,
					formatter : format
				}, {
					label : '最后修改时间',
					name : 'lastmodifytime',
					width : 150,
					formatter : format
				}, {
					label : '状态',
					name : 'status',
					width : 150,
					formatter: function (cellvalue, options, rowObject) {
								 if(cellvalue == '启用'){
								  return "有效";
								 }else
								 if(cellvalue == '停用'){
									  return "无效";
								}
						  	}
				} ];
				var mdaCrawlitemsGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '数据源配置名称',
					name : 'name',
					width : 150
				}, {
					label : '创建时间',
					name : 'createtime',
					width : 150,
					formatter : format
				}, {
					label : '最后修改时间',
					name : 'lastmodifytime',
					width : 150,
					formatter : format
				}, {
					label : '最后采集时间',
					name : 'lasttimecrawl',
					width : 150,
					formatter : format
				}, {
					label : '最后采集用户',
					name : 'lastcrawluseridAlias',
					width : 150
				}, {
					label : '采集类型',
					name : 'itemtype',
					width : 150
				}, {
					label : '分类',
					name : 'classifyids',
					width : 150
				}, {
					label : '状态',
					name : 'status',
					width : 150
				}, {
					label : '操作',
					name : 'crawlflag',
					width : 100,
					formatter: function (cellvalue, options, rowObject) {
					  return "<img id='btn"+ rowObject.id +"' onclick='crawlFlag(\"" + rowObject.crawlflag +"\",\"" + rowObject.id +"\",\"" + rowObject.itemtype +"\")'   src='static/images/platform/mda/crawl_btn/btn_start.png'/>";     
					/*    
					  if(cellvalue == '2'){
					  }
					  if(cellvalue == '0'){
					  return "<img id='btn"+ rowObject.id +"' onclick='crawlFlag(\"" + rowObject.id +"\")'   src='static/images/crawl_btn/btn_ing.png'/>";               
					  }
					  if(cellvalue == '1'){
					  return "<img id='btn"+ rowObject.id +"' onclick='crawlFlag(\"" + rowObject.id +"\")'   src='static/images/crawl_btn/btn_stop.png'/>";               
					  }  */
					}
				} ];
				
				
				

				mdaDatasource = new MdaDatasource('mdaDatasource', '${url}',
						'form', mdaDatasourceGridColModel, 'searchDialog',
						function(pid) {
							mdaCrawlitems = new MdaCrawlitems('mdaCrawlitems',
									'${surl}', "formSub",
									mdaCrawlitemsGridColModel,
									'searchDialogSub', pid, searchSubNames,
									"mdaCrawlitems_keyWord");
						}, function(pid) {
							mdaCrawlitems.reLoad(pid);
						}, searchMainNames, "mdaDatasource_keyWord");
				
				
				
				
				//主表操作
				//停止所有任务
				$('#mdaCrawlitems_stop').bind('click', function() {
					toStopTask();
				});
				//添加按钮绑定事件
				$('#mdaDatasource_insert').bind('click', function() {
					mdaDatasource.insert();
				});
				//编辑按钮绑定事件
				$('#mdaDatasource_modify').bind('click', function() {
					mdaDatasource.modify();
				});
				//删除按钮绑定事件
				$('#mdaDatasource_del').bind('click', function() {
					mdaDatasource.del();
				});
				//打开高级查询框
				$('#mdaDatasource_searchAll').bind('click', function() {
					mdaDatasource.openSearchForm(this, $('#mdaDatasource'));
				});
				//关键字段查询按钮绑定事件
				$('#mdaDatasource_searchPart').bind('click', function() {
					mdaDatasource.searchByKeyWord();
				});
				//子表操作
				//添加按钮绑定事件
				$('#mdaCrawlitems_insert').bind('click', function() {
					mdaCrawlitems.insert();
				});
				//编辑按钮绑定事件
				$('#mdaCrawlitems_modify').bind('click', function() {
					mdaCrawlitems.modify();
				});
				//删除按钮绑定事件
				$('#mdaCrawlitems_del').bind('click', function() {
					mdaCrawlitems.del();
				});
				
				//设置
				$('#mdaCrawlitems_set').bind('click', function() {
					upFun();
				});
				//打开高级查询
				$('#mdaCrawlitems_searchAll').bind('click', function() {
					mdaCrawlitems.openSearchForm(this, $('#mdaCrawlitems'));
				});
				//关键字段查询按钮绑定事件
				$('#mdaCrawlitems_searchPart').bind('click', function() {
					mdaCrawlitems.searchByKeyWord();
				});

				$('#useridAlias').on('focus', function(e) {
					new H5CommonSelect({
						type : 'userSelect',
						idFiled : 'userid',
						textFiled : 'useridAlias'
					});
					this.blur();
				});

				$('#lastcrawluseridAlias').on('focus', function(e) {
					new H5CommonSelect({
						type : 'userSelect',
						idFiled : 'lastcrawluserid',
						textFiled : 'lastcrawluseridAlias'
					});
					this.blur();
				});

			});
</script>
</html>