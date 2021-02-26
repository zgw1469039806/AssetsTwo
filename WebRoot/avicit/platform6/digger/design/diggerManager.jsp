<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree,table";
%>

<html>

<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>报表管理</title>
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
        <div data-options="region:'north',split:false" style="height:50px;overflow:visible">
            <div class="toolbar">
                <div class="toolbar-left">
                    <div class="dropdown">
                        <a class="btn btn-primary form-tool-btn btn-sm" role="button" href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu" aria-expanded="false"><i class="icon icon-fenleiguanli"></i> 分类管理<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="text-align:left;min-width:120px;">
                            <li role="presentation"> <a id="addDiggerType" href="javascript:void(0);" title="添加分类"><%--<i class="icon icon-add"></i>--%> 添加分类</a></li>
                            <li role="separator" class="divider"></li>
                            <li role="presentation"> <a id="editDiggerType" href="javascript:void(0);" title="编辑分类"><%--<i class="icon icon-edit"></i> --%>编辑分类</a></li>
                            <li role="separator" class="divider"></li>
                            <li role="presentation"> <a id="deleteDiggerType" href="javascript:void(0);" title="删除分类"><%--<i class="icon icon-delete"></i>--%> 删除分类</a></li>
                        </ul>
                    </div>
                    <a id="addDiggerComponent" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm" role="button" title="添加模块"><i class="icon icon-add"></i> 添加模块</a>
                    <a id="addDiggerFormInfo" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-sm" role="button" title="添加报表"><i class="icon icon-add"></i> 添加报表</a>

                    <!--   <div class="input-group input-group-sm" style="position: absolute; top: 8px; right: 90px; width: 300px;">
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
            <!-- 分类树 -->
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
                                    <div class="demoCont">
                                        <!-- 模块下表单 -->
                                        <div id="formInfoDiv">
                                        </div>

                                    </div>
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
				<td width="30%"><input title="名称" class="form-control input-sm" type="text" name="name" id="name" /></td>
				
				<th width="15%">编码：</th>
				<td width="30%">
					<input title="编码" class="form-control input-sm" type="text" name="code" id="code" /></td>
				</td>
			</tr>
		</table>
	</form>
</div>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
    <script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
    <script src="avicit/platform6/digger/design/js/DiggerTypeTree.js"></script>
    <script src="avicit/platform6/digger/design/js/DiggerType.js"></script>
    <script src="avicit/platform6/digger/design/js/DiggerComponent.js"></script>
    <script src="avicit/platform6/digger/design/js/DiggerFormViewModel.js"></script>
    <script src="avicit/platform6/digger/design/js/DiggerFormInfo.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/tabs.js"></script>
    <script src="avicit/platform6/digger/design/js/DiggerComponentModel.js"></script>

    <script type="text/javascript">
    var showType = "1";
    var moduleType = "1";
    var diggerTypeTree;
    var diggerType;
    var diggerComponent;
    var eformClassConfig;
    var diggerFormInfo;
    var eformFormView;
    var eformFormSearch;
    var bpmsFormInfo;
    var diggerComponentModel;
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

        if (moduleType == "1") { //加载模块
            diggerTypeTree.clickNode();
        } else if (moduleType == "2") { //加载表单
            diggerComponent.clickTitle();
        }


    }

    $(document).ready(function() {
       // eformFormSearch = new EformFormSearch("searchArea", "searchFormInfoDiv", "searchFormViewDiv");
        //eformFormView = new EformFormView("formArea", "formViewDiv");
        diggerFormInfo = new DiggerFormInfo("formArea", "formInfoDiv");
        diggerComponent = new DiggerComponent("componentArea", "componentDiv");
        diggerType = new DiggerType();
        diggerTypeTree = new DiggerTypeTree("eformTypeTreeUL");
       // bpmsFormInfo = new BpmsFormInfo("formArea", "bpmsFormViewDiv");

        //分类事件
        $("#addDiggerType").click(function() {
            diggerType.addData();
        });
        $("#editDiggerType").click(function() {
            diggerType.editData();
        });
        $("#deleteDiggerType").click(function() {
            diggerType.deleteData();
        });

        //模块事件
        $("#addDiggerComponent").click(function() {
            diggerComponent.addData();
        });

        //表单事件
        $("#addDiggerFormInfo").click(function() {
            $(".noEformTab").removeClass('active');
            $(".noEformCont").removeClass('active');
            $(".eformTab").addClass('active');
            $(".eformCont").addClass('active');

            diggerFormInfo.addData();
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
        	diggerComponentModel.searchByKeyWord();
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