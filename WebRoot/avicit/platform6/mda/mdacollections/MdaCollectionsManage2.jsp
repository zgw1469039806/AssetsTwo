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
<!-- ControllerPath = "platform6/mda/mdacollections/mdaCollectionsController/toMdaCollectionsManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaCollections_button_add" permissionDes="添加">
  	<a id="mdaCollections_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaCollections_button_edit" permissionDes="编辑">
	<a id="mdaCollections_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
	</sec:accesscontrollist>
	 <sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaCollections_button_delete" permissionDes="删除">
	<a id="mdaCollections_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
	</sec:accesscontrollist>
		</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="mdaCollections_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="mdaCollections_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="mdaCollectionsjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
    	   <table class="form_commonTable">
			    <tr>
					<th width="10%">索引库名称:</th>
					<td width="39%">
	    		    <input title="索引库名称" class="form-control input-sm" type="text" name="name" id="name" />
	    			</td>
					<th width="10%">创建时间(从):</th>
    				<td width="39%">
    						<div class="input-group input-group-sm">
								<input class="form-control date-picker" type="text" name="createtimeBegin" id="createtimeBegin" />
									<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							</div>
    				</td>
				</tr>
				<tr>
					<th width="10%">创建时间(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="createtimeEnd" id="createtimeEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   <th width="10%">启用时间(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="enabletimeBegin" id="enabletimeBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
																				 </tr>
										 <tr>
									        									<th width="10%">启用时间(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="enabletimeEnd" id="enabletimeEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   						   						   																							  						   							 									<th width="10%">停用时间(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="disabletimeBegin" id="disabletimeBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
																				 </tr>
										 <tr>
									        									<th width="10%">停用时间(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="disabletimeEnd" id="disabletimeEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   						   						   																							  						   							 								<th width="10%">状态:</th>
																		 <td width="39%">
                                     <pt6:h5select css_class="form-control input-sm" name="status" id="status" title="状态" isNull="true" lookupCode="MDA_STATUS" />
                                     </td>
                                     																	</tr>
									<tr>
															 						   						   						   														 </tr>
    	</table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/mda/mdacollections/js/MdaCollections.js" type="text/javascript"></script>
<script type="text/javascript">
function refresh(){
	   window.location.reload();
	}

var mdaCollections;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mdaCollections.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="mdaCollections.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
		
//进入索引数据管理按钮绑定事件
function solrconfigFlag(solrcoreID) {
	layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '索引数据管理',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform6/mda/mdacollections/mdaCollectionsController/toSolrCoreManage/'+solrcoreID
	}); 
}	
//启用/禁用索引库
function solrcoreFlag(solrcoreID,type) {
	
		$.ajax({
			 url:"platform6/mda/mdacollections/mdaCollectionsController/operation/solr/"+solrcoreID,
			 type : 'post',
			 success : function(r){
				 if (r == "success"){
					 layer.alert('执行成功！' ,{
						  icon: 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0
					    }, function(){
					    	refresh();
				        }
					 );
				 }else{
					 layer.alert('执行失败！' ,{
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
		
		
		
		
$(document).ready(function () {
	
	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("name");
    searchTips.push("索引库名称");
	$('#keyWord').attr('placeholder','请输入'+searchTips[0]+'或'+searchTips[1]);
	var dataGridColModel =  [
								{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
								,{ label: '索引库名称', name: 'collectionName', width: 150}
								,{ label: '创建时间', name: 'createtime', width: 150,formatter:format}
								,{ label: '启用时间', name: 'enabletime', width: 150,formatter:format}
							  	,{ label: '停用时间', name: 'disabletime', width: 150,formatter:format}
						  		,{ label: '状态', name: 'status', width: 150,
					  			formatter: function (cellvalue, options, rowObject) {
									   if(cellvalue == '启用'){
									  return "<img id='btn"+ rowObject.id +"' onclick='solrcoreFlag(\"" + rowObject.id +"\")'   src='static/images/solr_btn/core_on.png'/>";               
									  } 
									  if(cellvalue == '停用'){
									  return "<img id='btn"+ rowObject.id +"' onclick='solrcoreFlag(\"" + rowObject.id +"\")'   src='static/images/solr_btn/core_off.png'/>";               
									  }  
									}
						  		}, {
									label : '操作',
									name : '',
									width : 100,
									formatter: function (cellvalue, options, rowObject) {
									  return "<a  href='javascript:solrconfigFlag(\"" + rowObject.id +"\")' style='color: white;' class='btn btn-primary form-tool-btn btn-sm' role='button' title='进入索引数据管理'>进入索引数据管理</a>";     
									}
								}
							 ];
	mdaCollections= new MdaCollections('mdaCollectionsjqGrid','${url}',
			'searchDialog',
			'form',
			'keyWord',
			searchNames,
			dataGridColModel);
	
	
	//添加按钮绑定事件
	$('#mdaCollections_insert').bind('click', function(){
		mdaCollections.insert();
	});
	//编辑按钮绑定事件
	$('#mdaCollections_modify').bind('click', function(){
		mdaCollections.modify();
	});
	//删除按钮绑定事件
	$('#mdaCollections_del').bind('click', function(){  
		mdaCollections.del();
	});
	//查询按钮绑定事件
	$('#mdaCollections_searchPart').bind('click', function(){
		mdaCollections.searchByKeyWord();
	});
	//打开高级查询框
	$('#mdaCollections_searchAll').bind('click', function(){
		mdaCollections.openSearchForm(this);
	});
																																																																																																																																		
});

</script>
</html>