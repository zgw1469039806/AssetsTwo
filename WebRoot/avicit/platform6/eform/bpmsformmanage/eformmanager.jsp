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
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css" />
    <link rel="stylesheet" href="avicit/platform6/eform/bpmsformmanage/css/style.css" />
    <link rel="stylesheet" href="avicit/platform6/eform/bpmsformmanage/css/tabs.css" />
</head>

<body>
    <style>
    .shownorth .layout-panel-north {
        overflow: visible!important;
    }
    .cicon{
		color: #cccccc;
	}
	
	.icon_active{
		color:#337ab7;
	}
    
    </style>
    <div class="easyui-layout shownorth" fit=true>
        <div data-options="region:'north',split:false" style="height:43px;overflow:visible">
            <div class="toolbar">
                <div class="toolbar-left">
                    <div class="dropdown">
                        <a class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" href="javascript:void(0);" data-toggle="dropdown" id="eformtypedropdownMenu" aria-expanded="false"><i class="icon icon-fenleiguanli"></i> 分类管理<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="text-align:left;min-width:120px;">
                            <li role="presentation"> <a id="addEformType" href="javascript:void(0);" title="添加分类"><%--<i class="icon icon-add"></i>--%> 添加分类</a></li>
                            <li role="separator" class="divider"></li>
                            <li role="presentation"> <a id="editEformType" href="javascript:void(0);" title="编辑分类"><%--<i class="icon icon-edit"></i> --%>编辑分类</a></li>
                            <li role="separator" class="divider"></li>
                            <li role="presentation"> <a id="deleteEformType" href="javascript:void(0);" title="删除分类"><%--<i class="icon icon-delete"></i>--%> 删除分类</a></li>
                        </ul>
                    </div>
                    <a id="addEformComponent" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm btn-point" role="button" title="添加模块"><i class="icon icon-add"></i> 添加模块</a>
                    <div class="dropdown">
                        <a class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" href="javascript:void(0);" data-toggle="dropdown" id="eformdropdownMenu" aria-expanded="false"><i class="icon icon-add"></i> 添加表单<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
                            <li role="presentation"> <a id="addEformFormInfo" href="javascript:void(0);" title="添加电子表单"><%--<i class="icon icon-add"></i> --%>添加电子表单</a></li>
                            <li role="separator" class="divider"></li>
                            <li role="presentation"> <a id="addBpmsFormInfo" href="javascript:void(0);" title="添加非电子表单"><%--<i class="icon icon-add"></i> --%>添加非电子表单</a></li>
                        </ul>
                    </div>
                    <a id="addEformViewInfo" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm btn-point" role="button" title="添加视图"><i class="icon icon-add"></i> 添加视图</a>
                    <div class="dropdown">
                        <a class="btn btn-primary form-tool-btn btn-sm" role="button" href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu" aria-expanded="false"><i class="glyphicon glyphicon-upload"></i> 批量生成<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
                            <li role="presentation"> <a id="createall" href="javascript:void(0);" title="批量生成发布表单"><%--<i class="icon icon-add"></i> --%>批量生成发布表单</a></li>
                            <li role="separator" class="divider"></li>
                            <li role="presentation"> <a id="createallView" href="javascript:void(0);" title="批量生成发布视图"><%--<i class="icon icon-add"></i> --%>批量生成发布视图</a></li>
                        </ul>
                    </div>
                    <!-- <a id="createall" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm" role="button" title="批量生成发布表单"><i class="glyphicon glyphicon-upload"></i> 批量生成发布表单</a>
                    <a id="createallView" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm" role="button" title="批量生成发布视图"><i class="glyphicon glyphicon-upload"></i> 批量生成发布视图</a> -->
                    <a id="importEformXml" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm" role="button" title="导入表单"><i class="icon icon-daoru"></i> 导入表单</a>
                    <a id="importViewXml" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm" role="button" title="导入视图"><i class="icon icon-daoru"></i> 导入视图</a>
                    <a id="formChart" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm" role="button" title="表单统计"><i class="icon icon-cont"></i> 表单统计</a>
                    <a id="eformClassConfig" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm" role="button" title="自定义类"><i class="icon icon-edit"></i> 自定义类</a>
                    <div class="input-group form-tool-search" style="width:200px;float:right">
                        <input type="text" id="searchInput" class="form-control input-sm" placeholder="请输入表单名称或视图名称">
                        <label id="searchBtn" class="icon icon-search form-tool-searchicon"></label>
                    </div>
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
            <!-- 电子表单分类树 -->
            <ul id="eformTypeTreeUL" class="ztree">
            </ul>
        </div>
        <div data-options="region:'center'">
            <div id="kp" style="display: block;height:100%;">
                <div class="componentArea" style="display: none;height:100%;">
                    <div class="layui-layer-title">模块</div>
                    <!-- 电子表单模块 -->
                    <div id="componentDiv" style="height: 90%">
                    </div>
                </div>
                <div class="formArea" style="display: none;height:100%;">
                    <div class="twoTabNav" style="height: 100%">
                        <!-- 标签主体Start -->
                        <!-- bootstrap风格 -->
                        <ul class="nav nav-tabs">
                            <li class="active eformTab">
                                <a href="javascript:void(0)">电子表单</a>
                            </li>
                            <li class="noEformTab">
                                <a href="javascript:void(0)">非电子表单</a>
                            </li>
                        </ul>
                        <ul class="tab-cont" style="height: 90%">
                            <li style="height: 100%" class="eformCont">
                                <div class="demoCont">
                                    <div class="layui-layer-title" style="padding-right: 10px;">
                                        <span>表单</span>
                                        <span style="float: right;">
                                    <i class="glyphicon glyphicon-th eform-item-form" style="color: rgb(255, 153, 0);"></i><span class="signs-title">未发布</span>
                                        <i class="glyphicon glyphicon-th eform-item-form" style="color: rgb(15, 157, 88);"></i><span class="signs-title">启用</span>
                                        <i class="glyphicon glyphicon-th eform-item-form" style="color: rgb(170, 187, 175);"></i><span class="signs-title">停用</span>
                                        </span>
                                    </div>
                                    <!-- 模块下表单 -->
                                    <div id="formInfoDiv">
                                    </div>
                                    <div class="layui-layer-title" style="padding-right: 10px;">
                                        <span>视图</span>
                                        <span style="float: right;">
                                    <i class="glyphicon glyphicon-list eform-item-form" style="color: rgb(255, 153, 0);"></i><span class="signs-title">未发布</span>
                                        <i class="glyphicon glyphicon-list eform-item-form" style="color: rgb(15, 157, 88);"></i><span class="signs-title">启用</span>
                                        <i class="glyphicon glyphicon-list eform-item-form" style="color: rgb(170, 187, 175);"></i><span class="signs-title">停用</span>
                                        </span>
                                    </div>
                                    <!-- 模块下视图 -->
                                    <div id="formViewDiv">
                                    </div>
                                </div>
                            </li>
                            <li style="height: 100%" class="noEformCont">
                                <div class="demoCont" class="">
                                    <div id="bpmsFormViewDiv" style="padding:10px;">
                                    </div>
                                </div>
                            </li>
                        </ul>
                        <!-- 标签主体End -->
                    </div>
                </div>
                <div id="searchArea" style="display: none">
                    <div class="layui-layer-title" style="padding-right: 10px;">
                        <span>表单查询</span>
                        <span style="float: right;">
                    <i class="glyphicon glyphicon-th eform-item-form" style="color: rgb(255, 153, 0);"></i><span class="signs-title">未发布</span>
                        <i class="glyphicon glyphicon-th eform-item-form" style="color: rgb(15, 157, 88);"></i><span class="signs-title">启用</span>
                        <i class="glyphicon glyphicon-th eform-item-form" style="color: rgb(170, 187, 175);"></i><span class="signs-title">停用</span>
                        </span>
                    </div>
                    <!-- 模块下表单 -->
                    <div id="searchFormInfoDiv">
                    </div>
                    <div class="layui-layer-title" style="padding-right: 10px;">
                        <span>视图查询</span>
                        <span style="float: right;">
                    <i class="glyphicon glyphicon-list eform-item-form" style="color: rgb(255, 153, 0);"></i><span class="signs-title">未发布</span>
                        <i class="glyphicon glyphicon-list eform-item-form" style="color: rgb(15, 157, 88);"></i><span class="signs-title">启用</span>
                        <i class="glyphicon glyphicon-list eform-item-form" style="color: rgb(170, 187, 175);"></i><span class="signs-title">停用</span>
                        </span>
                    </div>
                    <!-- 模块下视图 -->
                    <div id="searchFormViewDiv">
                    </div>
                </div>
            </div>
            <div id="lb" style="display:none;">
                <div class="componentArea" style="display: none;height:100%;">
                    <div class="layui-layer-title">模块</div>
                    <!-- 电子表单模块 -->
                    <div id="toolbar_componentModel" class="toolbar">
                        <div class="toolbar-right">
                            <div id="commonSearch" class="input-group form-tool-search">
                                <input type="text" name="componentModel_keyWord" id="componentModel_keyWord" class="form-control input-sm" placeholder="请输入模块名称">
                                <label id="componentModel_searchPart" class="icon icon-search form-tool-searchicon" style="cursor:hand"></label>
                            </div>
                        </div>
                    </div>
                    <table id="componentModel"></table>
                    <div id="componentModelPager"></div>
                </div>
                <div class="formArea" style="display: none;height:100%;">

                    <div class="twoTabNav" style="height: 100%">
                        <!-- 标签主体Start -->
                        <!-- bootstrap风格 -->
                        <ul class="nav nav-tabs">
                            <li class="active eformTab">
                                <a href="javascript:void(0)">电子表单</a>
                            </li>
                            <li class="noEformTab">
                                <a href="javascript:void(0)">非电子表单</a>
                            </li>
                        </ul>
                        <ul class="tab-cont" style="height: 90%">
                            <li style="height: 100%" class="eformCont">
                                <div class="demoCont">

                                    <div id="toolbar_formViewModel" class="toolbar">
                                        <div class="toolbar-right">
                                            <div id="commonSearch" class="input-group form-tool-search">
                                                <input type="text" name="formViewModel_keyWord" id="formViewModel_keyWord" class="form-control input-sm" placeholder="请输入名称">
                                                <label id="formViewModel_searchPart" class="icon icon-search form-tool-searchicon" style="cursor:hand"></label>
                                            </div>
                                            <div class="input-group-btn form-tool-searchbtn">
                                                <a id="formViewModel_searchAll" href="javascript:void(0)"
                                                   class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
                                                    <span class="caret"></span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <table id="formViewModel"></table>
                                    <div id="formViewModelPager"></div>
                                </div>
                            </li>
                            <li style="height: 100%" class="noEformCont">
                                <div class="demoCont" class="">
                                    <div id="toolbar_bpmFormModel" class="toolbar">
                                        <div class="toolbar-right">
                                            <div id="bpmcommonSearch" class="input-group form-tool-search">
                                                <input type="text" name="formViewModel_keyWord" id="bpmFormModel_keyWord" class="form-control input-sm" placeholder="请输入名称">
                                                <label id="bpmFormModel_searchPart" class="icon icon-search form-tool-searchicon" style="cursor:hand"></label>
                                            </div>
                                            <div class="input-group-btn form-tool-searchbtn">
                                                <a id="bpmFormModel_searchAll" href="javascript:void(0)"
                                                   class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
                                                    <span class="caret"></span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <table id="bpmFormModel"></table>
                                    <div id="bpmFormModelPager"></div>
                                </div>
                            </li>
                        </ul>
                        <!-- 标签主体End -->
                    </div>


                </div>
            </div>
        </div>
    </div>
    <div id="searchDialogSub" style="overflow: auto;display: none">
	<form id="formSub">
		<table class="form_commonTable" >
			<tr>
				<th width="18%">名称：</th>
				<td width="30%"><input title="名称"
					class="form-control input-sm" type="text" name="name"
					id="name" /></td>
				
				<th width="15%">编码：</th>
				<td width="30%">
					<input title="编码"
					class="form-control input-sm" type="text" name="code"
					id="code" /></td>
				</td>				
			</tr>
			<tr>	
				<th width="15%">发布状态：</th>
				<td width="30%">
					<select name="publishStatus" id="publishStatus" class="easyui-combobox form-control input-sm" style="">
						<option value="">请选择</option>
						<option value="0">未发布</option>
						<option value="1">已发布</option>
					</select>
				</td>
				
				<th width="15%">启用状态：</th>
				<td width="30%">
					<select name="enabled" id="enabled" class="easyui-combobox form-control input-sm" style="">
						<option value="">请选择</option>
						<option value="N">停用</option>
						<option value="Y">启用</option>
					</select>
				</td>

			</tr>
			<tr>
				<th width="15%">类型：</th>
				<td width="30%">
					<select name="type" id="type" class="easyui-combobox form-control input-sm" style="">
						<option value="">请选择</option>
						<option value="bpmform">流程表单</option>
						<option value="form">普通表单</option>
						<option value="view">视图</option>
					</select>
				</td>
			</tr>

		</table>
	</form>
</div>

    <div id="searchBpmForm" style="overflow: auto;display: none">
        <form id="bpmFormSub">
            <table class="form_commonTable" >
                <tr>
                    <th width="18%">名称：</th>
                    <td width="30%"><input title="名称"
                                           class="form-control input-sm" type="text" name="formName"
                                           id="formName" /></td>

                    <th width="15%">编码：</th>
                    <td width="30%">
                        <input title="编码"
                               class="form-control input-sm" type="text" name="formCode"
                               id="formCode" /></td>
                    </td>
                </tr>
                <tr>
                    <th width="15%">URL：</th>
                    <td width="30%">
                        <input title="URL"
                               class="form-control input-sm" type="text" name="formUrl"
                               id="formUrl" /></td>
                    </td>

                    <th width="15%">表单类型：</th>
                    <td width="30%">
                        <select name="isProxy" id="isProxy" class="easyui-combobox form-control input-sm" style="">
                            <option value="">请选择</option>
                            <option value="Y">外部表单</option>
                            <option value="N" selected>内部表单</option>
                        </select>
                    </td>

                </tr>

            </table>
        </form>
    </div>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
    <script src="static/js/platform/pan/download.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformTypeTree.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformType.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformComponent.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformFormInfo.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformFormView.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformFormSearch.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/bpmsFormInfo/js/BpmsFormInfo.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/tabs.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformComponentModel.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformClassConfig.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformFormViewModel.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/bpmsFormInfo/js/BpmsFormInfoModel.js"></script>

    <script type="text/javascript">
    var showType = "1";
    var moduleType = "1";
    var eformTypeTree;
    var eformType;
    var eformComponent;
    var eformClassConfig;
    var eformFormInfo;
    var eformFormView;
    var eformFormSearch;
    var bpmsFormInfo;
    var eformComponentModel;
    var eformFormViewModel;
    var bpmsformInfoModel;
    var baseUrl = '<%=ViewUtil.getRequestPath(request)%>';

    function changeShowType(type) {
    	$(".cicon").removeClass("icon_active");
        //卡片方式
        if ("1" == type) {
            $("#kp").show();
            $("#lb").hide();
            showType = "1";
            $("#kpicon").addClass("icon_active");
        } else if ("2" == type) { //列表方式
            $("#kp").hide();
            $("#lb").show();
            showType = "2";
            $("#lbicon").addClass("icon_active");
        }
        var fullsearchvalue = $("#searchInput").val();
        if (fullsearchvalue != null && fullsearchvalue != undefined && fullsearchvalue != ""){
            eformFormSearch.searchEform($("#searchInput").val());
        }else {

            if (moduleType == "1") { //加载模块
                eformTypeTree.clickNode();
            } else if (moduleType == "2") { //加载表单
                eformComponent.clickTitle();
            }
        }


    }

    $(document).ready(function() {
        eformFormSearch = new EformFormSearch("formArea", "formInfoDiv", "formViewDiv");
        eformFormView = new EformFormView("formArea", "formViewDiv");
        eformFormInfo = new EformFormInfo("formArea", "formInfoDiv");
        eformComponent = new EformComponent("componentArea", "componentDiv");
        eformType = new EformType();
        eformTypeTree = new EformTypeTree("eformTypeTreeUL");
        eformClassConfig = new EformClassConfig();
        bpmsFormInfo = new BpmsFormInfo("formArea", "bpmsFormViewDiv");

        //分类事件
        $("#addEformType").click(function() {
            eformType.addData();
        });
        $("#editEformType").click(function() {
            eformType.editData();
        });
        $("#deleteEformType").click(function() {
            eformType.deleteData();
        });

        //模块事件
        $("#addEformComponent").click(function() {
            eformComponent.addData();
        });

        //表单事件
        $("#addEformFormInfo").click(function() {
            $(".noEformTab").removeClass('active');
            $(".noEformCont").removeClass('active');
            $(".eformTab").addClass('active');
            $(".eformCont").addClass('active');

            eformFormInfo.addData();
        });

        //批量生成页面
        $("#createall").click(function() {
            eformFormInfo.doAllCreate();
        });
        //批量生成页面-视图
        $("#createallView").click(function() {
            eformFormView.doAllCreate();
        });

        //导入表单xml
        $("#importEformXml").click(function() {
            eformFormInfo.importEformXml();
        });
        
        //导入视图
        $("#importViewXml").click(function(){
        	eformFormView.importViewXml();
        });

        //电子表单统计
        $("#formChart").click(function(){
            eformFormView.formChart();
        });

        //自定义类维护
        $("#eformClassConfig").click(function(){
            eformClassConfig.toEformClassConfig();
        });
        //试图事件
        $("#addEformViewInfo").click(function() {
            eformFormView.addData();
        });

        // 流程表单事件
        $("#addBpmsFormInfo").click(function() {
            $(".eformTab").removeClass('active');
            $(".eformCont").removeClass('active');
            $(".noEformTab").addClass('active');
            $(".noEformCont").addClass('active');

            bpmsFormInfo.addData();
        });

        //绑定搜索事件
        $("#searchInput").on('keyup', function(e) {
            if (e.keyCode == 13) {
                eformFormSearch.searchEform($("#searchInput").val());
            }
        });
        $("#searchBtn").click(function() {
            eformFormSearch.searchEform($("#searchInput").val());
        });
      
        $('#componentModel_searchPart').bind('click', function() {
        	eformComponentModel.searchByKeyWord();
  		});
        $('#formViewModel_searchPart').bind('click', function() {
        	eformFormViewModel.searchByKeyWord();
  		});
  		//关键字段查询按钮绑定事件
  		$('#bpmFormModel_searchPart').bind('click', function() {
            bpmsformInfoModel.searchByKeyWord();
  		});
  		$('#formViewModel_searchAll').bind('click', function() {
  			eformFormViewModel.openSearchForm(this, $('#flowModel'));
  		});
        $('#bpmFormModel_searchAll').bind('click', function() {
            bpmsformInfoModel.openSearchForm(this);
        });

    });

    //刷新表单单个图标(EformFormInfo)
    function reloadEformFormInfo(data){
        eformFormInfo.setFormInfo(data);
    }
    //刷新视图单个图标(EformFormView)
    function reloadEformFormView(data){
        eformFormView.setViewInfo(data);
    }
    </script>
</body>

</html>