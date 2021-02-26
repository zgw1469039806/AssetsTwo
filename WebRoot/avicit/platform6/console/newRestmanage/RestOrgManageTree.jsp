<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
    String importlibs = "common,tree,form,table";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>服务授权管理</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
    <link rel="stylesheet" href="avicit/platform6/console/newRestmanage/css/style.css"/>

	<style>
		td, th{
			box-sizing: unset;
		}
	</style>
</head>

<body>
<div class="easyui-layout" fit=true>
    <div data-options="region:'north'" style="height:50px;">
        <div class="toolbar">
            <div class="toolbar-left">
                <a id="restResourceManage_insert" href="javascript:;" class="btn btn-default form-tool-btn btn-sm btn-point"
                   role="button" title="添加服务"><i class="icon icon-add"></i> 添加</a>
                <a id="restResourceManage_modify" href="javascript:;" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="编辑服务"><i class="icon icon-edit"></i> 编辑</a>
                <a id="restResourceManage_del" href="javascript:;" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="删除服务"><i class="icon icon-delete"></i> 删除</a>
                <a id="restResourceManage_save" href="javascript:;" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="保存"><i class="icon icon-save"></i> 保存</a>
            </div>
            <div class="toolbar-right">
			    <div class="input-group form-tool-search">
		     		<input type="text" name="restResourceManage_KeyWord" id="restResourceManage_KeyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入URL地址查询">
		     		<label id="restResourceManage_searchPart" class="icon icon-search form-tool-searchicon"></label>
		   		</div>
		   		<div class="input-group-btn form-tool-searchbtn">
					<a id="restResourceManage_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
		    </div>
        </div>
    </div>

    <div data-options="region:'west',split:true" style="width:250px;">
        <!--正文模板分类树 -->
        <ul id="restOrgManageTreeUL" class="ztree">
        </ul>
    </div>

    <div id= "east1" data-options="region:'center'" style="width:1100px;overflow-x:hidden;">
    	<div class="layui-layer-title">服务资源列表</div>
       <table id="restResourceManage"></table>
       <div id="jqGridPager"></div>
    </div>
</div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%"><label for="restUrl">URL地址:</label></th>
				<td width="39%"><input class="form-control input-sm"
					type="text" name="restUrl" id="restUrl" /></td>
				<th width="10%"><label for="urlDesc">地址描述:</label></th>
				<td width="39%"><input class="form-control input-sm"
					type="text" name="urlDesc" id="urlDesc" /></td>
			</tr>
			<tr>
				<th width="10%"><label for="systemId">所属系统:</label></th>
				<td width="39%">
					<select class="form-control" name="systemId" id="systemId" title="" isNull="true" />
				</td>
				<th width="10%"><label for="status">状态:</label></th>
				<td width="39%"><select class="form-control" name="status" id="status">
					<option ></option>
					<option value="1">有效</option>
					<option value="0">无效</option>
				</select></td>
			</tr>
		</table>
	</form>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/console/newRestmanage/js/common.js"></script>
<script src="avicit/platform6/console/newRestmanage/js/RestOrgManageTree.js"></script>
<script src="avicit/platform6/console/newRestmanage/js/RestResourceManage.js"></script>
<script type="text/javascript">
    var restOrgManageTree;
    var restResourceManage;

    $(document).ready(function () {
    	$.ajax({  
            url: 'platform/platfrom6/newrestmanage/controller/resteasyOrgController/operation/listAll',  
            data : {
			 	id : ""
			},
		    type : 'post',
            dataType: "json",  
            success: function (data) {  
            	$("#orgId").append("<option ></option>");
                $.each(data, function (index, units) {  
                    $("#orgId").append("<option value="+units.id+">" + units.orgName + "</option>");  
                });
            },  

            error: function (XMLHttpRequest, textStatus, errorThrown) {  
                alert("error");  
            }  
        });
		$.ajax({  
            url: 'platform/platform6/newrestmanage/controller/resteasySystemController/operation/listAll',  
            data : {
			 	id : "${resteasyResourcesDTO.orgId}"
			},
		    type : 'post',
            dataType: "json",  
            success: function (data) {  
            	$("#systemId").append("<option></option>");  
                $.each(data, function (index, units) {  
                    $("#systemId").append("<option value="+units.id+">" + units.systemName + "</option>");  
                });
            },  

            error: function (XMLHttpRequest, textStatus, errorThrown) {  
                alert("error");  
            }  
        });
        //正文模板模块
        function formatStatus(cellvalue, options, rowObject) {
			if (cellvalue =="1"){    
		        return '有效';    
		    } else {    
		        return '无效';    
		    }  
		}
       
        var dataGridColModel = [{
			label : 'id',
			name : 'id',
			key : true,
			hidden : true
		}, {
			label : 'URL地址',
			name : 'restUrl',
			width : 150
		}, {
			label : '地址描述',
			name : 'urlDesc',
			width : 150
		},  {
			label : '所属系统',
			name : 'systemName',
			width : 150
		},{
			label : '所属系统id',
			name : 'systemId',
			hidden : true
		},{
			label : '状态 ',
			name : 'status',
			width : 150,
			formatter:formatStatus
		} ];
		var searchNames = new Array();
		var searchTips = new Array();
		searchNames.push("restUrl");
		searchTips.push("URL地址");
		$('#keyWord').attr('placeholder',
				'请输入' + searchTips[0] );
	    restOrgManageTree = new RestOrgManageTree("restOrgManageTreeUL",function(initId){
	    	restResourceManage = new RestResourceManage('restResourceManage',
					'', 'searchDialog', 'form', 'restResourceManage_KeyWord',
					searchNames,dataGridColModel,initId);
	    });
		//添加按钮绑定事件
		$('#restResourceManage_insert').bind('click', function() {
			restResourceManage.insert(restOrgManageTree.selectedNodeId);
		});
		//编辑按钮绑定事件
		$('#restResourceManage_modify').bind('click', function() {
			restResourceManage.modify();
		});
		//删除按钮绑定事件
		$('#restResourceManage_del').bind('click', function() {
			restResourceManage.del();
		});
		//保存按钮绑定事件
		$('#restResourceManage_save').bind('click', function() {
			restResourceManage.saveConfig();
		});
		//查询按钮绑定事件
		$('#restResourceManage_searchPart').bind('click', function() {
			restResourceManage.searchByKeyWord();
		});
		//打开高级查询框
		$('#restResourceManage_searchAll').bind('click', function() {
			restResourceManage.openSearchForm(this);
		});
		$("#t_restResourceManage").css("display", "none");
    });
	function closeDialog(){
		layer.close(openDialog);
	};
	
</script>

</html>