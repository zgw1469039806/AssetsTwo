<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree,table";
%>

<!DOCTYPE html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>cc(connect center)</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
    <link rel="stylesheet" href="avicit/platform6/db/dbtabletype/css/style.css"/>
</head>
<style>
	.shownorth .layout-panel-north {
		overflow:visible!important;
	}
	/* a{
		color: #cccccc;
	} */
	.ztree{
		overflow-x:hidden;
	}
</style>
<body>
<div class="easyui-layout shownorth" fit=true>
    <div data-options="region:'north',split:true" style="height:50px;overflow:visible">
	    	<div class="toolbar">
	    		<div class="toolbar-left">
	    			<div class="dropdown">
	                    <a class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu" aria-expanded="false"><i class="icon icon-fenleiguanli"></i>  分类管理<span class="caret"></span></a>
	                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="text-align:left;min-width:120px;">
	                         <li role="presentation"> <a id="addConnectType" href="javascript:void(0);" title="添加分类"><%--<i class="icon icon-add"></i>--%> 添加分类</a></li>
	                         <li role="separator" class="divider"></li>
	                         <li role="presentation"> <a id="editConnectType" href="javascript:void(0);" title="编辑分类"><%--<i class="icon icon-edit"></i> --%>编辑分类</a></li>
	                         <li role="separator" class="divider"></li>
	                         <li role="presentation"> <a id="deleteConnectType" href="javascript:void(0);" title="删除分类"><%--<i class="icon icon-delete"></i>--%> 删除分类</a></li>
	                    </ul>
	                </div>
	                <a id="addConnect" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="icon icon-add"></i> 添加</a>
	                <a id="editConnect" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="icon icon-edit"></i> 编辑</a>
	                <a id="deleteConnect" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
    			</div>
	    	</div>
    	</div>

	<div data-options="region:'west',split:true" style="width:255px;">
	    <!-- 数据源分类树 -->
	    <ul id="connectTypeTreeUL" class="ztree">
	    </ul>
	</div>

    <div data-options="region:'center'">
        <div id="lb" style="">
    	   <div id="toolbar_componentModel" class="toolbar">
				<div class="toolbar-right">
					<div id="commonSearch" class="input-group form-tool-search">
						<input type="text" name="DBModel_keyWord"
							id="DBModel_keyWord"
							class="form-control input-sm" placeholder="请输入名称查询"> <label
							id="DBModel_searchPart"
							class="icon icon-search form-tool-searchicon"></label>
					</div>
					<div class="input-group-btn form-tool-searchbtn">
						<a id="DBModel_searchAll" href="javascript:void(0)"
							class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
							<span class="caret"></span>
						</a>
					</div>
				</div>
			</div>
			<table id="dataBaseModel"></table>
			<div id="dataBaseModelPager"></div>
    	</div>
    	<div id="ws" style="">
    		<div id="toolbar_componentModel_ws" class="toolbar">
				<div class="toolbar-right">
					<div id="commonSearch_ws" class="input-group form-tool-search">
						<input type="text" name="WSModel_keyWord"
							id="WSModel_keyWord"
							class="form-control input-sm" placeholder="请输入名称查询"> <label
							id="WSModel_searchPart"
							class="icon icon-search form-tool-searchicon"></label>
					</div>
					<div class="input-group-btn form-tool-searchbtn">
						<a id="WSModel_searchAll" href="javascript:void(0)"
							class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
							<span class="caret"></span>
						</a>
					</div>
				</div>
			</div>
			<table id="soapWebservicejqGrid"></table>
			<div id="jqGridPager"></div>
    	</div>
    	<div id="rest" style="">
    		<div id="toolbar_componentModel_ws" class="toolbar">
				<div class="toolbar-right">
					<div id="commonSearch_ws" class="input-group form-tool-search">
						<input type="text" name="RestModel_keyWord"
							id="RestModel_keyWord"
							class="form-control input-sm" placeholder="请输入名称查询"> <label
							id="RestModel_searchPart"
							class="icon icon-search form-tool-searchicon"></label>
					</div>
					<div class="input-group-btn form-tool-searchbtn">
						<a id="RestModel_searchAll" href="javascript:void(0)"
							class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
							<span class="caret"></span>
						</a>
					</div>
				</div>
			</div>
			<table id="restjqGrid"></table>
			<div id="restjqGridPager"></div>
    	</div>
    	<div id="servlet" style="">
    		<div id="toolbar_componentModel_ws" class="toolbar">
				<div class="toolbar-right">
					<div id="commonSearch_ws" class="input-group form-tool-search">
						<input type="text" name="ServletModel_keyWord"
							id="ServletModel_keyWord"
							class="form-control input-sm" placeholder="请输入名称查询"> <label
							id="ServletModel_searchPart"
							class="icon icon-search form-tool-searchicon"></label>
					</div>
					<div class="input-group-btn form-tool-searchbtn">
						<a id="ServletModel_searchAll" href="javascript:void(0)"
							class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
							<span class="caret"></span>
						</a>
					</div>
				</div>
			</div>
			<table id="servletjqGrid"></table>
			<div id="servletjqGridPager"></div>
    	</div>
    </div>
</div>

<div id="searchDialogSubDB" style="overflow: auto;display: none">
	<form id="formSub">
		<table class="form_commonTable" >
			<tr>
				<th width="18%">标识：</th>
				<td width="30%">
					<input title="标识"
					class="form-control input-sm" type="text" name="id"
					id="id" /></td>
				</td>
				<th width="15%">名称：</th>
				<td width="30%"><input title="名称"
					class="form-control input-sm" type="text" name="name"
					id="name" /></td>				
			</tr>
			<tr>
				<th width="15%">使用状态：</th>
				<td width="30%">
					<select name="isUsed" id="isUsed" class="easyui-combobox form-control input-sm" style="">
						<option value="">请选择</option>
						<option value="0">停用</option>
						<option value="1">启用</option>
					</select>
				</td>
			</tr>
		</table>
	</form>
</div>

<div id="searchDialogSubWS" style="overflow: auto;display: none">
	<form id="formSubWs">
		<table class="form_commonTable" >
			<tr>
				<th width="18%">标识：</th>
				<td width="30%">
					<input title="标识"
					class="form-control input-sm" type="text" name="id"
					id="id" /></td>
				</td>
				<th width="15%">名称：</th>
				<td width="30%"><input title="名称"
					class="form-control input-sm" type="text" name="name"
					id="name" /></td>				
			</tr>
			
		</table>
	</form>
</div>

<div id="searchDialogSubRest" style="overflow: auto;display: none">
	<form id="formSubRest">
		<table class="form_commonTable" >
			<tr>
				<th width="18%">标识：</th>
				<td width="30%">
					<input title="标识"
					class="form-control input-sm" type="text" name="id"
					id="id" /></td>
				</td>
				<th width="15%">名称：</th>
				<td width="30%"><input title="名称"
					class="form-control input-sm" type="text" name="name"
					id="name" /></td>				
			</tr>
		</table>
	</form>
</div>

<div id="searchDialogSubServlet" style="overflow: auto;display: none">
	<form id="formSubServlet">
		<table class="form_commonTable" >
			<tr>
				<th width="18%">标识：</th>
				<td width="30%">
					<input title="标识"
					class="form-control input-sm" type="text" name="id"
					id="id" /></td>
				</td>
				<th width="15%">名称：</th>
				<td width="30%"><input title="名称"
					class="form-control input-sm" type="text" name="name"
					id="name" /></td>				
			</tr>
		</table>
	</form>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/db/dbtabletype/js/common.js"></script>
<script src="avicit/platform6/modules/system/connectcenter/js/ConnectTypeTree.js"></script>
<script src="avicit/platform6/modules/system/connectcenter/js/ConnectType.js"></script>
<script src="avicit/platform6/modules/system/connectcenter/js/Connect.js"></script>
<script src="avicit/platform6/modules/system/connectcenter/database/js/DataBase.js"></script>
<script src="avicit/platform6/modules/system/connectcenter/database/js/DataBaseModel.js"></script>
<script src="avicit/platform6/db/dbtabletype/js/DbTableSearch.js"></script>
<script src="avicit/platform6/modules/system/connectcenter/soapwebservice/js/SoapWebservice.js"></script>
<script src="avicit/platform6/modules/system/connectcenter/restful/js/RestFul.js"></script>
<script src="avicit/platform6/modules/system/connectcenter/servlet/js/Servlet.js"></script>

<script type="text/javascript">
	var showType = "2";
	var moduleType = "1";
	var connectTypeTree;
	var connectType;
	var dataBase;
    var dataBaseModel;
    var soapwebservice;
    var restful;
    
    var servlet;
    
    $(document).ready(function () {
    	//dataBase = new DataBase("dataBaseArea","DataBaseDiv");
    	//其余连接方式的JS对象在点击树节点时创建：ConnectTypeTree
    	connect = new Connect();
    	connectType = new ConnectType();
    	connectTypeTree = new ConnectTypeTree("connectTypeTreeUL");

    	//分类事件
        $("#addConnectType").click(function() {
            connectType.addData();
        });
        $("#editConnectType").click(function() {
            connectType.editData();
        });
        $("#deleteConnectType").click(function() {
            connectType.deleteData();
        });
        
      	//数据源事件
        $("#addConnect").click(function() {
            connect.addData();
        });
        $("#editConnect").click(function() {
        	connect.editData("");
        });
        $("#deleteConnect").click(function() {
        	connect.deleteData();
        });
        
		$('#DBModel_searchAll').bind('click', function() {
			dataBaseModel.openSearchForm(this, $('#flowModel'));
		});
		$('#WSModel_searchAll').bind('click', function() {
			soapwebservice.openSearchForm(this, $('#soapWebservicejqGrid'));
		});
		$('#RestModel_searchAll').bind('click', function() {
			restful.openSearchForm(this, $('#restjqGrid'));
		});
		$('#ServletModel_searchAll').bind('click', function() {
			servlet.openSearchForm(this, $('#servletjqGrid'));
		});
		//关键字段查询按钮绑定事件
		$('#DBModel_searchPart').bind('click', function() {
			dataBaseModel.searchByKeyWord();
		});
		//关键字段查询按钮绑定事件
		$('#WSModel_searchPart').bind('click', function() {
			soapwebservice.searchByKeyWord();
		});
		//关键字段查询按钮绑定事件
		$('#RestModel_searchPart').bind('click', function() {
			restful.searchByKeyWord();
		});
		//关键字段查询按钮绑定事件
		$('#ServletModel_searchPart').bind('click', function() {
			servlet.searchByKeyWord();
		});
    });
</script>
</body>
</html>