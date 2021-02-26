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
		 <div class="input-group form-tool-search">
     		<input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaCollections_button_add" permissionDes="搜索">
			  	<a id="" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="搜索"><i></i> 搜索</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaCollections_button_add" permissionDes="结果中搜索">
		  		<a id="" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="结果中搜索"><i></i> 结果中搜索</a>
			</sec:accesscontrollist>
   		</div>
   		<div>
   			<input type="checkbox" name="" id="datasource">全部
   			<input type="checkbox" name="datasource">数据源1
   			<input type="checkbox" name="datasource">数据源2
   			<input type="checkbox" name="datasource">数据源3
   		</div>
   		<div>
   			<label>关键词：</label>
   			<input type="checkbox" name="" id="keyword">全选
   			<input type="checkbox" name="keyword">萨德
   			<input type="checkbox" name="keyword">乐天
   			<input type="checkbox" name="keyword">韩国
   			<input type="checkbox" name="keyword">选举
   		<hr>
   			<label>分类：</label>
   				<a id="" href="javascript:void(0)" role="button" title="选择"><i></i> 选择</a>
   		<hr>
   			<label>时间：</label>
   			<a id="" href="javascript:void(0)" role="button" title="今天"><i></i> 今天</a>
   			<a id="" href="javascript:void(0)" role="button" title="昨天"><i></i> 昨天</a>
   			<a id="" href="javascript:void(0)" role="button" title="7天"><i></i> 7天</a>
   			<a id="" href="javascript:void(0)" role="button" title="30天"><i></i> 30天</a>
   			<a id="" href="javascript:void(0)" role="button" title="自定义"><i></i> 自定义</a>
   		<hr>
   		</div>
   		<div class="toolbar-left">
   			<a id="" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i></i> 删除</a>
   			<a id="" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="批量删除"><i></i> 批量删除</a>
   		</div>
	</div>
	<div>
	 	<div class="row" style="height: 500px; width: 700px;margin-left: 30px;margin-top: 320px;">
              		<div style="height: 465px; width: 666px;margin-left: 16px;margin-top: 18px;">
              			<div style="height: 20px; width: 300px;margin-left: 0px;margin-top: 5px;">已为你搜到**条记录</div>
              			<div style="height: 20px; width: 300px;margin-left: 540px;margin-top: -21px;">排序
              				<a href="">匹配度&darr;</a>
              				<a href="">时间&darr;</a>
              			</div>
              			<table>
              				<tr>
              					<td><input type="checkbox" id="collectiondata"></td>
              					<td>全选</td>
              				</tr>
              				<tr>
              					<td><input type="checkbox" name="collectiondata"></td>
              					<td>
		              					<a href="">
					              			<div>反之萨德入韩！中国走了一步妙棋。刚宣布一事直击美国软肋！【手机互联网星空】</div>
					              			<div>作者：晨曦；图片来自网络 山姆大叔最喜欢当“搅屎棍”，最拿手的好戏就是在别人家门口制造事端，然后渔翁得利。就在美国部署萨德反倒系统。发射架等部分装备抵达韩国之际，美国国务17日在韩国接受采访时......</div>
					              			<div>2017 -03-21   新闻 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;来源：百度  </div>
				              			</a>
				              		</div>
              					</td>
              				</tr>
              				<tr>
              					<td><input type="checkbox" name="collectiondata" value="" ></td>
              					<td>
		              					<a href="">
					              			<div>反之萨德入韩！中国走了一步妙棋。刚宣布一事直击美国软肋！【手机互联网星空】</div>
					              			<div>作者：晨曦；图片来自网络 山姆大叔最喜欢当“搅屎棍”，最拿手的好戏就是在别人家门口制造事端，然后渔翁得利。就在美国部署萨德反倒系统。发射架等部分装备抵达韩国之际，美国国务17日在韩国接受采访时......</div>
					              			<div>2017 -03-21   新闻 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;来源：百度  </div>
				              			</a>
				              		</div>
              					</td>
              				</tr>
              				<tr>
              					<td><input type="checkbox" name="collectiondata"></td>
              					<td>
		              					<a href="">
					              			<div>反之萨德入韩！中国走了一步妙棋。刚宣布一事直击美国软肋！【手机互联网星空】</div>
					              			<div>作者：晨曦；图片来自网络 山姆大叔最喜欢当“搅屎棍”，最拿手的好戏就是在别人家门口制造事端，然后渔翁得利。就在美国部署萨德反倒系统。发射架等部分装备抵达韩国之际，美国国务17日在韩国接受采访时......</div>
					              			<div>2017 -03-21   新闻 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;来源：百度  </div>
				              			</a>
				              		</div>
              					</td>
              				</tr>
	              		</table>
              		</div>
              	</div>
</div>
</div>	


				
<!-- <table id="mdaCollectionsjqGrid"></table>
<div id="jqGridPager"></div> -->
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/mda/mdacollections/js/MdaCollections.js" type="text/javascript"></script>
<script type="text/javascript">
var mdaCollections;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mdaCollections.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="mdaCollections.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
		
$(document).ready(function () {
	 var dataGridColModel =  [
	{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
	,{ label: '索引库名称', name: 'name', width: 150}
	,{ label: '创建时间', name: 'createtime', width: 150,formatter:format}
	,{ label: '启用时间', name: 'enabletime', width: 150,formatter:format}
	,{ label: '停用时间', name: 'disabletime', width: 150,formatter:format}
	,{ label: '状态', name: 'status', width: 150}
	];
	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("name");
    searchTips.push("索引库名称");
	$('#keyWord').attr('placeholder','请输入'+searchTips[0]+'或'+searchTips[1]);
	mdaCollections= new MdaCollections('mdaCollectionsjqGrid','${url}','searchDialog','form','keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#mdaCollections_insert').bind('click', function(){
		mdaCollections.insert();
	});
	//编辑按钮绑定事件
	$('#mdaCollections_modify').bind('click', function(){
		mdaCollections.modify();
	});
	//索引数据管理按钮绑定事件
	$('#mdaCollections_manage').bind('click', function(){
		mdaCollections.manage();
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
	
	
	
	
	
	
	/* 数据源 */
	$("#datasource").click(function(){
		 $('input[name="datasource"]').prop("checked",this.checked); 
	});
	
	 $("input[name='datasource']").click(function() {
		 var $subs = $("input[name='datasource']");
		 $("#datasource").prop("checked" , $subs.length == $subs.filter(":checked").length ? true :false);
	});
	/* 索引数据 */
	$("#collectiondata").click(function(){
		 $('input[name="collectiondata"]').prop("checked",this.checked); 
	});
	
	 $("input[name='collectiondata']").click(function() {
		 var $subs = $("input[name='collectiondata']");
		 $("#collectiondata").prop("checked" , $subs.length == $subs.filter(":checked").length ? true :false);
	});
	/* 分类 */
	$("#keyword").click(function(){
		 $('input[name="keyword"]').prop("checked",this.checked); 
	});
	
	
	
	
																																																																																																																																		
});




</script>
</html>