<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree,table";
%>

<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>电子表单管理</title>

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
	
	.icon_active{
		color:#337ab7 !important;
	}
	
	.cicon{
		color: #cccccc;
	}

</style>
<body>
<div class="easyui-layout shownorth" fit=true>
    <div data-options="region:'north',split:false" style="height:50px;overflow:visible">
        <div class="toolbar" style="margin-bottom:6px;">
            <div class="toolbar-left">
            <div class="dropdown">
                <a class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu" aria-expanded="false"><i class="icon icon-fenleiguanli"></i> 分类管理<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
                    <li role="presentation"> <a id="addDbTableType" href="javascript:void(0);" title="添加分类"> 添加分类</a></li>
                    <li role="separator" class="divider"></li>
                    <li role="presentation"> <a id="editDbTableType" href="javascript:void(0);"  title="编辑分类"> 编辑分类</a></li>
                    <li role="separator" class="divider"></li>
                    <li role="presentation"> <a id="deleteDbTableType" href="javascript:void(0);"  title="删除分类"> 删除分类</a></li>
                </ul>
            </div>

            <a id="addDbTable" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm btn-point"
               role="button" title="添加表模型"><i class="icon icon-add"></i> 添加表模型</a>
           <a id="commonColSet" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm" role="button" title="常用字段设置"><i class="icon icon-cont"></i> 常用字段设置</a>
            <div class="dropdown">
				<a class="btn btn-primary form-tool-btn btn-sm" role="button" href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu" aria-expanded="false"><i class="icon icon-daoru"></i> 导入表模型<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
                    <li role="presentation"> <a id="importDbTable" href="javascript:void(0);" title="导入本地表模型">导入本地表模型</a></li>
                    <li role="separator" class="divider"></li>
                    <li role="presentation"> <a id="importOutDbTable" href="javascript:void(0);"  title="导入外部表模型">导入外部表模型</a></li>
                </ul>
			</div>

            <a id="importDbXml" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm" role="button" title="导入存储模型"><i class="icon icon-daoru"></i> 导入存储模型</a>
                <!-- <a id="importDbTable" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                role="button" title="导入表模型"><i class="icon icon-daoru"></i> 导入表模型</a> -->

        <!--         <div class="input-group input-group-sm" style="position: absolute; top: 8px; right: 90px; width: 300px;">
                    <input class="form-control" placeholder="回车查询" type="text" id="searchInput">
                    <span class="input-group-btn">
                        <button id="searchBtn" class="btn btn-default" type="button">
                            <span class="glyphicon glyphicon-search"></span>
                        </button>
		            </span>
                </div> -->
            </div>
           <div class="toolbar-right" style="padding-right:10px;">
                    <a href="javascript:void(0)" onClick="changeShowType(1)" title="卡片展示" style="text-decoration:none;" class="cicon icon_active" id="kpicon">
		         <i class="iconfont icon-changyong" style="font-size:18px;"></i></a>&nbsp;
                    <a href="javascript:void(0)" onClick="changeShowType(2)" title="列表展示" style="text-decoration:none;" class="cicon" id="lbicon">
		      <i class="iconfont icon-menu" style="font-size:18px;"></i></a>
                </div>
        </div>
    </div>

    <div data-options="region:'west',split:true" style="width:250px;">
        <!-- 存储模型分类树 -->
        <ul id="dbTableTypeTreeUL" class="ztree">
        </ul>
    </div>

    <div data-options="region:'center'">
    	<div id="kp" style="display: block;">
            <div class="layui-layer-title" style="padding-right: 10px;">
                <span>表模型</span>
                <span style="float: right;">
                    <i class="iconfont icon-shujuku eform-item-group" style="color: rgb(0, 153, 204);"></i><span class="signs-title">已创建</span>
                    <i class="iconfont icon-shujuku eform-item-group"></i><span class="signs-title">未创建</span>
                </span>
            </div>
            <!-- 表模型 -->
            <div id="componentDiv">
            </div>

        <div id="searchArea" style="display: none">
            <div class="layui-layer-title" style="padding-right: 10px;">
                <span>表模型查询</span>
                <span style="float: right;">
                    <i class="iconfont icon-shujuku eform-item-group" style="color: rgb(0, 153, 204);"></i><span class="signs-title">已创建</span>
                    <i class="iconfont icon-shujuku eform-item-group"></i><span class="signs-title">未创建</span>
                </span>
            </div>
            <!-- 表模型 -->
            <div id="searchDbDiv">
            </div>
        </div>
        </div>
        <div id="lb" style="display:none;">
            <div class="layui-layer-title" style="padding-right: 10px;">
                <span>表模型</span>
            </div>
    	   <div id="toolbar_componentModel" class="toolbar">
			<div class="toolbar-right">
				<div id="commonSearch" class="input-group form-tool-search">
					<input type="text" name="componentModel_keyWord"
						id="componentModel_keyWord"
						class="form-control input-sm" placeholder="请输入表英文名称或者表中文名称"> <label
						id="componentModel_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="componentModel_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div>
		</div>
		<table id="componentModel"></table>
		<div id="componentModelPager"></div>
    	</div>
    </div>
</div>

<div id="searchDialogSub" style="overflow: auto;display: none">
	<form id="formSub">
		<table class="form_commonTable" >
			<tr>
				<th width="18%">表英文名称：</th>
				<td width="30%"><input title="表英文名称"
					class="form-control input-sm" type="text" name="tableName"
					id="tableName" /></td>
				
				<th width="15%">表中文名称：</th>
				<td width="30%">
					<input title="表中文名称"
					class="form-control input-sm" type="text" name="tableComments"
					id="tableComments" /></td>
				</td>				
			</tr>
			<tr>	
				<th width="15%">是否创建：</th>
				<td width="30%">
					<select name="tableIsCreated" id="tableIsCreated" class="form-control">
						<option value="">请选择</option>
						<option value="N">未创建</option>
						<option value="Y">已创建</option>
					</select>
				</td>

                <th width="15%">存储模型类型：</th>
                <td width="30%">
                    <select name="dbType" id="dbType" class="form-control">
                        <option value="">请选择</option>
                        <option value="1">数据表</option>
                        <option value="2">视图</option>
                        <option value="3">系统表</option>
                    </select>
                </td>

			</tr>

		</table>
	</form>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="static/js/platform/pan/download.js"></script>
<script src="avicit/platform6/db/dbtabletype/js/common.js"></script>
<script src="avicit/platform6/db/dbtabletype/js/DbTableTypeTree.js"></script>
<script src="avicit/platform6/db/dbtabletype/js/DbTableType.js"></script>
<script src="avicit/platform6/db/dbtabletype/js/DbTable.js"></script>
<script src="avicit/platform6/db/dbtabletype/js/DbTableSearch.js"></script>
<script src="avicit/platform6/db/dbtabletype/js/DbTableModel.js"></script>

<script type="text/javascript">
	var showType = "1";
    var dbTableTypeTree;
    var dbTableType;
    var dbTable;
    var dbTableSearch;
    var eformComponentModel;

    function changeShowType(type){
    	$(".cicon").removeClass("icon_active");
		//卡片方式
		if("1"==type){
			$("#kp").show();
			$("#lb").hide();
			showType = "1";
			$("#kpicon").addClass("icon_active");
		}else if("2"==type){//列表方式
			$("#kp").hide();
			$("#lb").show();
			showType = "2";
			$("#lbicon").addClass("icon_active");
		}
		dbTableTypeTree.clickNode();
		
		
	}
    
    $(document).ready(function () {
        dbTableSearch = new DbTableSearch("searchArea", "searchDbDiv");
        dbTable = new DbTable("componentArea", "componentDiv");
        dbTableType = new EformType();
        dbTableTypeTree = new EformTypeTree("dbTableTypeTreeUL");

        //分类事件
        $("#addDbTableType").click(function () {
            dbTableType.add();
        });
        $("#editDbTableType").click(function () {
            dbTableType.edit();
        });
        $("#deleteDbTableType").click(function () {
            dbTableType.deleteType();
        });
        $("#importDbTable").click(function () {
            dbTableType.importTable();
        });
        //导入外部表模型
        $("#importOutDbTable").click(function () {
            dbTableType.importOutTable();
        });

        
        //模块事件
        $("#addDbTable").click(function () {
            dbTable.add();
        });
        //模块事件
        $("#commonColSet").click(function () {
            dbTable.commonColSet();
        });

        //导入存储模型xml
        $("#importDbXml").click(function() {
            dbTable.importDbXml();
        });

        //绑定搜索事件
        $("#searchInput").on('keyup',function(e){
            if(e.keyCode == 13){
                dbTableSearch.searchDbTable($("#searchInput").val());
            }
        });
        $("#searchBtn").click(function () {
            dbTableSearch.searchDbTable($("#searchInput").val());
        });
        
        $('#componentModel_searchAll').bind('click', function() {
        	eformComponentModel.openSearchForm(this, $('#flowModel'));
  		});
  		//关键字段查询按钮绑定事件
  		$('#componentModel_searchPart').bind('click', function() {
  			eformComponentModel.searchByKeyWord();
  		});
    });
</script>
</body>
</html>