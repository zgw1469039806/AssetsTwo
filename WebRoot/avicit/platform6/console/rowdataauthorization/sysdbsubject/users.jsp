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
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
</script>
</head>
<body class=" easyui-layout" fit="true">
<div data-options="region:'center',onResize:function(a){$('#jqGrid').setGridWidth(a);$(window).trigger('resize');}">
    <div id="tableToolbar" class="toolbar">
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="keyWord" id="keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="输入用户名或登录名查询"> <label
					id="Role_searchPart" onclick="userSeach()" class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
  </div>
<table id="jqGrid"></table>
<div id="jqGridPager"></div>
</div>
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script type="text/javascript">
var consoleUser;
$(document).ready(function () {
	var dataGridColModel =  [
      { label: 'id', name: 'id', key: true, width: 75, hidden:true }
 	  ,{ label: '状态', name: 'status11', width: 100,hidden:true}
  	  ,{ label: '状态', name: 'status', hidden:true}
  	  ,{ label: '锁定状态', name: 'userLocked', hidden:true}
      ,{ label: '用户姓名', name: 'name', width: 200,sortable: false }
      ,{ label: '登录名', name: 'loginName', width: 200,sortable: false}
      ,{ label: '密级', name: 'secretLevel', width: 150,hidden:true}
      ,{ label: '性别', name: 'sex11', width: 100 ,hidden:true}
      ,{ label: '性别', name: 'sex', width: 100 ,hidden:true}
      ,{ label: '手机', name: 'mobile', width: 200,hidden:true }
      ,{ label: '办公电话', name: 'officeTel', width: 150 ,hidden:true}
      ,{ label: '邮件', name: 'email', width: 250 ,hidden:true}
      ,{ label: '用户类型', name: 'consoleType', width: 150 ,hidden:true}
      ,{ label: '部门', name: 'deptName', width: 150 ,sortable: false }
      ,{ label: '岗位', name: 'positionName', width: 150 ,sortable: false}
	];
	consoleUser = new ConsoleUser('jqGrid','<%=ViewUtil.getRequestPath(request)%>'+'${'console/user'}','searchDialog','form','sysUser_keyWord','',dataGridColModel);
});
function ConsoleUser(datagrid,url,searchD,form,keyWordId,searchNames,dataGridColModel){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
	this._datagridId="#"+datagrid;
	this._jqgridToolbar="#t_"+datagrid;
	this._doc = document;
	this._formId="#"+form;
	this._searchDialogId ="#"+searchD;
	this._keyWordId="#"+keyWordId;
	this._searchNames = searchNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
//初始化操作
ConsoleUser.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: this.getUrl()+'/operation/getSysUsersByPage.json',
        mtype: 'POST',
        datatype: "json",
        colModel: this.dataGridColModel,
        height:  $(window).height()-130,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum:10,
        rowList:[200,100,50,20,10],
        altRows:true,
        userDataOnFooter : true,
		hasTabExport:false,
		hasColSet:false,
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, //
		multiselect: true,
		autowidth: true,
		responsive:true,//开启自适应
		multiboxonly : true,
		shrinkToFit: true,
        pager: "#jqGridPager",
        multiboxonly : true,
		onSelectRow : onSelectRow//js方法
    });
    //回车查询
	$('#keyWord').on('keydown',function(e){
		if(e.keyCode == '13'){
			userSeach();
		}
	});
	$("#jqGrid").jqGrid('hideCol', 'cb');
};
function onSelectRow() {
	var type_id = $("#jqGrid").jqGrid('getGridParam','selarrrow');
	var rowData = $("#jqGrid").jqGrid('getRowData',type_id[0]);
	var choseType=$("#myTabContent .active",parent.document).children().attr("val");
	var pid=parent.pId;
	
	parent.sysDbEntity.reLoad(pid,choseType,type_id[0]);
	
}; 
//关键字段查询
function userSeach() {
	var keyWord = $("#keyWord").val();
	if(keyWord=="输入用户名或登录名查询"){
		keyWord='';
	}
	var searchdata = {};
	if(keyWord==''){
		 searchdata = {
		     keyWord : null,
		}
	}else{
		var names = ["name", "loginName"];
		var param = {};
		for ( var i in names) {
			var name = names[i];
			param[name] = keyWord;
		}
	 	searchdata = {
			keyWord : JSON.stringify(param)
		}
	}
	$('#jqGrid').jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
}; 



</script>
</html>