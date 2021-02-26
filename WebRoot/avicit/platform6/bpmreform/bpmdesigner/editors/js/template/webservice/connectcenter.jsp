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
</head>
<style>
	.shownorth .layout-panel-north {
		overflow:visible!important;
	}
	a{
		color: #cccccc;
	}
	.ztree{
		overflow-x:hidden;
	}
</style>
<body>
<div class="easyui-layout shownorth" fit=true>
	<div data-options="region:'west',split:true" style="width:255px;">
	    <!-- 数据源分类树 -->
	    <ul id="connectTypeTreeUL" class="ztree">
	    </ul>
	</div>

    <div data-options="region:'center'">
    	<div id="ws" style="display:none;">
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
			<div id="soapWebservicejqGridPager"></div>
    	</div>
    	<div id="rest" style="display:none;">
    		<div id="toolbar_componentModel_rest" class="toolbar">
				<div class="toolbar-right">
					<div id="commonSearch_rest" class="input-group form-tool-search">
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
    	<div id="servlet" style="display:none;">
    		<div id="toolbar_componentModel_servlet" class="toolbar">
				<div class="toolbar-right">
					<div id="commonSearch_servlet" class="input-group form-tool-search">
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
<script src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/webservice/js/ConnectTypeTree.js"></script>
<script src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/webservice/soapwebservice/js/SoapWebservice.js"></script>
<script src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/webservice/restful/js/RestFul.js"></script>
<script src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/webservice/servlet/js/Servlet.js"></script>

<script type="text/javascript">
    var TypeId = "";
	var connectTypeTree;
    var soapwebservice;
    var restful;
    var servlet;
    
    $(document).ready(function () {
    	connectTypeTree = new ConnectTypeTree("connectTypeTreeUL");
		$('#WSModel_searchAll').bind('click', function() {
			soapwebservice.openSearchForm(this, $('#soapWebservicejqGrid'));
		});
		$('#RestModel_searchAll').bind('click', function() {
			restful.openSearchForm(this, $('#restjqGrid'));
		});
		$('#ServletModel_searchAll').bind('click', function() {
			restful.openSearchForm(this, $('#servletjqGrid'));
		});
		//关键字段查询按钮绑定事件
		$('#WSModel_searchPart').bind('click', function() {
			soapwebservice.searchByKeyWord();
		});
		//关键字段查询按钮绑定事件
		$('#RestModel_searchPart').bind('click', function() {
			restful.searchByKeyWord();
		});
		$('#ServletModel_searchPart').bind('click', function() {
			servlet.searchByKeyWord();
		});
    });

    function getServiceType(){
    	if(TypeId==""){
        	layer.alert('请选择数据！', {
    			icon : 7,
    			area : [ '400px', '' ], //宽高
    			closeBtn : 0
    		});
    		return null;
        }

    	if(TypeId=="7"){
        	return "restful";
        }else if(TypeId=="8"){
            return "ws";
        }else if(TypeId=="6"){
            return "servlet";
        }
    }

    function getSelectRow(){
        if(TypeId==""){
        	layer.alert('请选择数据！', {
    			icon : 7,
    			area : [ '400px', '' ], //宽高
    			closeBtn : 0
    		});
    		return null;
        }
        if(TypeId=="7"){
        	if(restful==undefined){
            	layer.alert('请选择数据！', {
        			icon : 7,
        			area : [ '400px', '' ], //宽高
        			closeBtn : 0
        		});
        		return null;
             }
        	return restful.getSelectRow();
        }else if(TypeId=="8"){
        	if(soapwebservice==undefined){
            	layer.alert('请选择数据！', {
        			icon : 7,
        			area : [ '400px', '' ], //宽高
        			closeBtn : 0
        		});
        		return null;
             }
        	return soapwebservice.getSelectRow();
        }else if(TypeId=="6"){
        	if(servlet==undefined){
            	layer.alert('请选择数据！', {
        			icon : 7,
        			area : [ '400px', '' ], //宽高
        			closeBtn : 0
        		});
        		return null;
             }
        	return servlet.getSelectRow();
        }
    }
</script>
</body>
</html>