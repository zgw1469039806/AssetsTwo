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
    		<div class="row" style="width:350px;margin-left: 5px;" >
					<div class="input-group  input-group-sm">
				      <input  class="form-control" placeholder="请输入关键字。。。" type="text" name="keyWord" id="keyWord">
				      <span class="input-group-btn">
				        <button class="btn btn-default ztree-search" id="mdaCollections_searchPart"  type="button" ><span class="glyphicon glyphicon-search"><font style="margin:5px;" >搜索一下</font></font></font></span></button>
				      </span>
				    </div>
			</div>
    </div>
    <div class="toolbar-left" style="margin-left: 25px;">
	 <sec:accesscontrollist hasPermission="3"  domainObject="formdialog_mdaCollections_button_edit" permissionDes="清空索引库">
	<a  id="mdaCollections_delall" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="清空索引库">清空索引库</a>
	</sec:accesscontrollist>
	 <sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaCollections_button_add" permissionDes="加载中间数据">
	<a id="mdaCollections_addjsondata" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="加载中间数据"><i class="fa fa-plus"></i>加载中间数据</a>
	</sec:accesscontrollist>
	 <sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaCollections_button_delete" permissionDes="删除数据">
	<a id="mdaCollections_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除数据"><i class="fa fa-trash-o"></i>删除数据</a>
	</sec:accesscontrollist>
	</div>
</div>					
<table id="mdaCollectionsjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/mda/mdacollections/js/MdaCollections.js" type="text/javascript"></script>
<script type="text/javascript">
function sleep(numberMillis) { 
	var now = new Date(); 
	var exitTime = now.getTime() + numberMillis; 
	while (true) {
		now = new Date();
		if (now.getTime() > exitTime) 
			return; 
		} 
	}
//清空索引库
function cleanSolrCore() {
	//alert('==============='+solrcoreName);
		$.ajax({
			 url:"platform6/mda/mdacollections/mdaCollectionsController/operation/solr/clean",
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
	    title: '索引数据详情',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮    //======================toSolrCoreManage/'+solrcoreID+"."（这个点很重要，不要去掉）
	   content: 'platform6/mda/mdacollections/mdaCollectionsController/toSolrCoreManage/'+solrcoreID+"."
	}); 
}	

//进入索引数据管理按钮绑定事件
function doJump4URL(URL) {
	layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '自定义URL跳转',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: URL
	   // content: 'http://www.baidu.com/'
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
		
		
var insertIndex;
function closWinc(){
	 layer.close(insertIndex); 
}
		
$(document).ready(function () {
	
	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("keyWord");
    searchTips.push("索引库名称");
	//$('#keyWord').attr('placeholder','请输入'+searchTips[0]+'或'+searchTips[1]);
	var dataGridColModel =  [
								{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
								,{ label: '标题', name: 'title', width: 150}
								,{ label: '摘要', name: 'content', width: 150}
								,{ label: '数据源', name: 'solrDataSourceName', width: 150}
								,{ label: '分类', name: 'solrDataClassify', width: 150}
								,{ label: '创建时间', name: 'crawledate', width: 150}
								//,{ label: '爬取人', name: 'enabletime', width: 150,formatter:format}
							  	,{ label: 'URL', name: 'url', width: 150,
							  		formatter: function (cellvalue, options, rowObject) {
							  			return "<a  href='javascript:void(0);' onclick='doJump4URL(\"" + cellvalue +"\")'  title='"+cellvalue+"'>"+cellvalue+"</a>";
									}
							  	}
						  		/* ,{ label: '状态', name: 'status', width: 150,
					  			formatter: function (cellvalue, options, rowObject) {
									   if(cellvalue == '启用'){
									  return "<img id='btn"+ rowObject.id +"' onclick='solrcoreFlag(\"" + rowObject.id +"\")'   src='static/images/solr_btn/core_on.png'/>";               
									  } 
									  if(cellvalue == '停用'){
									  return "<img id='btn"+ rowObject.id +"' onclick='solrcoreFlag(\"" + rowObject.id +"\")'   src='static/images/solr_btn/core_off.png'/>";               
									  }  
									}
						  		} */
						  		, {
									label : '操作',
									name : '',
									width : 100,
									formatter: function (cellvalue, options, rowObject) {
									  return "<a  href='javascript:solrconfigFlag(\"" + rowObject.id +"\")' style='color: white;' class='btn btn-primary form-tool-btn btn-sm' role='button' title='查看详情'>查看详情</a>";     
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
	//============加载Json中间文件==========
	$('#mdaCollections_addjsondata').bind('click', function(){
		insertIndex = layer.open({
		    type: 2,
		    area: ['100%', '100%'],
		    title: '加载中间文件',
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
	        maxmin: false, //开启最大化最小化按钮
		    content: 'platform6/mda/mdacollections/mdaCollectionsController/toMdaCollectionsManage/addJsondata'
		}); 
	});
	//清空索引库
	$('#mdaCollections_delall').bind('click', function(){
		layer.confirm('您确定要清空索引库？', {
			  area: ['400px', ''], //宽高
			  btn: ['确定','取消'] //按钮
			}, function(){
			   cleanSolrCore();
			});
	//	mdaCollections.modify();
	});
	$('#mdaCollections_modify').bind('click', function(){
		//cleanSolrCore();
	//	mdaCollections.modify();
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