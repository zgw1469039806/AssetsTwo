<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,tree,form";
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<!-- ControllerPath = "assets/device/classifydata/classifyDataController/toClassifyDataManage" -->
	<title>分类选择</title>

	<base href="<%=ViewUtil.getRequestPath(request)%>">

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>

	<!-----------------------------------------zTree需要引入的css------------------------------------------->
	<link type="text/css" rel="stylesheet" href="static/css/zTree_v3/zTreeStyle/zTreeStyle.css">

	<!-----------------------------------------zTree需要引入的js------------------------------------------->
	<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="static/js/zTree_v3/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="static/js/zTree_v3/jquery.ztree.exhide.js"></script>
	<script type="text/javascript" src="static/js/zTree_v3/jquery.ztree.exedit.js"></script>
	<script type="text/javascript" src="static/js/zTree_v3/jquery.ztree.excheck.js"></script>
	<script type="text/javascript" src="static/js/zTree_v3/fuzzysearch.js"></script>

	<!-- 切换卡 样式 -->
	<link href="avicit/platform6/switch_card/yyui.css" rel="stylesheet" type="text/css">
</head>

<body>
<!-- 页面主体 -->
<div class="easyui-layout" fit="true" >
	<div  class="easyui-layout" style="height:100%;width:100%" >
		<div data-options="region:'north',border:'0px',split:false" style="height:40px;width:100%">
			<div class="input-group  input-group-sm" style="width:100%">
				<input class="form-control" placeholder="回车查询" type="text" id="classifyKey" name="classifyKey">
				<span class="input-group-btn">
					<button id="searchbtn" class="btn btn-default ztree-search" type="button"><span class="glyphicon glyphicon-search"></span></button>
				  </span>
			</div>
		</div>
		<ul id="classifyTree" class="ztree" style='width:300px; margin-top:40px; height:805px;'></ul>
	</div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<!-- 模块js -->
<script src="avicit/assets/device/classifydata/js/ClassifyData.js" type="text/javascript"></script>

<script type="text/javascript">
	var url = 'platform/assets/device/classifydata/classifyDataController';
	var classifyData;

	//获取树节点信息
	var zNodes;

	var selectModel = null;
	var categoryId = null;
	var categoryName = null;
	var defaultLoadCategoryId = null;

	//初始化表格参数
	function init(o) {
		selectModel = o.selectModel;
		categoryId = o.categoryId;
		categoryName = o.categoryName;
		defaultLoadCategoryId = o.defaultLoadCategoryId;
		currentCategory = o.currentCategory;
		appSelectType = o.appSelectType;
		callBack = o.callBack;
		setPropertys = o.setPropertys;

		if(!appSelectType){
			$(".appSelectType").hide();
		}

        avicAjax.ajax({
            url: url + '/getClassifyTree',
            data: {belongCategory : currentCategory},
            type : 'post',
            dataType : 'json',
            success : function(result){
                if (result.flag == "success"){
                    zNodes = JSON.parse(result.classifyJson);
                    classifyData = new ClassifyData(zNodes, 'classifyTree', '${url}', 'classifyForm', currentCategory, 'classifyKey', selectModel);

                    //设置默认选中节点
                    if(defaultLoadCategoryId != undefined && defaultLoadCategoryId != null &&defaultLoadCategoryId != ''){
                        var array = defaultLoadCategoryId.split(",");//逗号是分隔符
                        var treeObj = $.fn.zTree.getZTreeObj("classifyTree");

                        for(i=0; i<array.length; i++){
                            var node = treeObj.getNodeByParam("id", array[i]);//根据ID找到该节点
                            treeObj.checkNode(node, true, true);
                        }
                    }
                }
                else{
                    layer.alert('分类树获取失败：' + result.msg, {
                            icon: 7,
                            area: ['400px', ''],
                            closeBtn: 0,
                            btn: ['关闭'],
                            title:"提示"
                        }
                    );
                }
            }
        });
	};

	//回填数据
	function getCategoryList() {
		var categoryIds = "";
		var categoryNames = "";

		//获取当前勾选的节点
		var treeObj = $.fn.zTree.getZTreeObj("classifyTree");
		var selectNodes = treeObj.getCheckedNodes(true);

		for ( var i = 0; i < selectNodes.length; i++) {
			var rowData= selectNodes[i];
			categoryIds = categoryIds + rowData.id + ",";
			categoryNames = categoryNames + rowData.name + ",";
		}

		//截掉末尾的字符','
		categoryIds = categoryIds.substring(0, categoryIds.length - 1);
		categoryNames = categoryNames.substring(0, categoryNames.length - 1);

		return {
			categoryIds : categoryIds,
			categoryNames : categoryNames
		};
	};
</script>
</body>
</html>