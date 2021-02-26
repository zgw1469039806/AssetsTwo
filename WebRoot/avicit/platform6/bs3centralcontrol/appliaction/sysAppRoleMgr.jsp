<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统应用授权</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">


<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <a id="appListSave" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="保存"><i class="icon icon-save"></i> 保存</a>

    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="输入角色名称">
            <label id="searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
    </div>
</div>
<table id="jqGrid"></table>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
	<%--<div region="center" border="false" style="height:0px;padding:0px;overflow:hidden;">
		<div id="toolbarSysApp">
			<td><a class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="sysApp.save();" href="javascript:void(0);">保存</a></td>
			<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="sysApp.openSearchForm();" href="javascript:void(0);">查询</a></td>
		</div>
		<table id="sysAppList"
			data-options=" 
						fit: true,
						border: false,
						rownumbers: true,
						animate: true,
						collapsible: false,
						fitColumns: true,
						autoRowHeight: false,
						toolbar:'#toolbarSysApp',
						singleSelect: true,
						checkOnSelect: true,
						selectOnCheck: false,
						striped:true">
			<thead>
				<tr>
					<th data-options="field:'sysappId',required:true,hidden:true,align:'center'" width="120">应用标识</th>
					<th data-options="field:'sysroleId',required:true,hidden:true,align:'center'" editor="{type:'text'}" width="120">可访问角色ID</th>
					<th data-options="field:'sysappName',align:'left'" width="120">应用名称</th>
					<th data-options="field:'sysroleName',align:'center',styler:styleCell"  editor="{type:'text'}" width="220">可访问角色</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="searchDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" style="width: 600px;height:200px;display: none;">
		<form id="form1">
    		<table style="padding-top: 10px;">
    			<tr>
    				<td>应用名称:</td>
    				<td><input class="easyui-validatebox" type="text" name="sysappName"/></td>
    				<td>角色名称:</td>
    				<td><input class="easyui-validatebox" type="text" name="sysroleName"/></td>
    			</tr>
    		</table>
    	</form>
    	<div id="searchBtns">
    		<a class="easyui-linkbutton" plain="false" onclick="sysApp.searchData();" href="javascript:void(0);">查询</a>
    		<a class="easyui-linkbutton"  plain="false" onclick="sysApp.clearData();" href="javascript:void(0);">清空</a>
    		<a class="easyui-linkbutton" plain="false" onclick="sysApp.hideSearchForm();" href="javascript:void(0);">返回</a>
    	</div>
  </div>--%>
<script src="avicit/platform6/bs3centralcontrol/appliaction/js/AppAuthList.js" type="text/javascript"></script>
<script type="text/javascript">
    var sysApp;
    $(function(){

        var dataGridColModel =  [
            { name: 'sysappId', key: true,  hidden:true },
            { label: '应用名称', name: 'sysappName', width: 60 ,align:'center'},
            { label: '可访问角色', name: 'sysroleName', width: 180,align:'left'},
            { name: 'isChanged',  hidden:true },
            { name: 'sysroleId',  hidden:true }
        ];
        sysApp = new RudgpObj('jqGrid','${url}',dataGridColModel);
    });

    $('#appListSave').bind('click',function(){
        sysApp.save();
    });
</script>
</body>
</html>