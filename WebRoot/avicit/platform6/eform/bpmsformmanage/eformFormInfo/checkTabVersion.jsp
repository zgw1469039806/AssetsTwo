<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree,table";
%>

<html>

<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>查看预设版本号</title>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css" />
    <link rel="stylesheet" href="avicit/platform6/eform/bpmsformmanage/css/style.css" />
    <link rel="stylesheet" href="avicit/platform6/eform/bpmsformmanage/css/tabs.css" />
</head>

<body class="easyui-layout" fit="true" style="overflow-y: auto;">
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
    <div data-options="region:'center',split:true,border:false" style="padding: 8px 0;">
                        <table id="formViewModel"></table>
                        <div id="formViewModelPager"></div>
    </div>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
    <script src="static/js/platform/pan/download.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformType.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformComponent.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformFormInfo.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/EformFormSearch.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/bpmsFormInfo/js/BpmsFormInfo.js"></script>
    <script src="avicit/platform6/eform/bpmsformmanage/js/tabs.js"></script>
    <script type="text/javascript">

    var baseUrl = '<%=ViewUtil.getRequestPath(request)%>';

    $(document).ready(function() {
    	var module = 
    			[{
					label : 'id',
					name : 'id',
					key : true,
					hidden : true
				},{
					label : '版本号',
					name : 'attribute08',
					width : 101,
					align : 'center',
					sortable : true,
					formatter:getformviewEdit
				},{
					label : '是否当前版本',
					name : 'ynCurrent',
					width : 330,
					align : 'center',
					sortable : true
				},{
					label : '操作',
					name : 'opt',
					width : 350,
					align : 'left',
					sortable : false,
					formatter:getformviewButtons
				}];
    		$("#formViewModel").jqGrid({
    			url : "platform/eform/bpmsManageController/checkTabVersion",
    		        datatype: "json",
    		        postData: {eformFormInfoId:"${param.eformFormInfoId}"},
    		        styleUI: 'Bootstrap',//设置jqgrid的全局样式为bootstrap样式 
    		        colModel: module,
    		        viewrecords: true,
    		        height: window.innerHeight - 90,
                    width:$(window).width()-10,//宽度必须指定，使用autoweidth导致主子表是后面的表格横向滚动条有问题
    		        scrollOffset : 10, //设置垂直滚动条宽度
    				//rowNum : 10,
    				//rowList : [ 200, 100, 50, 30, 20, 10 ],
    		        rownumbers: true, 
    		        rownumWidth: 25, 
    		        autowidth:false,
    		        multiselect: false,
    		        pager: "#formViewModelPager",
    		        jsonReader : {
    		            
    		        },
    		        prmNames : {
    		            
    		        },
    		        gridComplete:function(){
    		            //隐藏grid底部滚动条
    		            //$("#formViewModel").closest(".ui-jqgrid-bdiv").css({ "overflow-x" : "hidden" }); 
    		        }
    		    });
    });
    
    function getformviewButtons(cellvalue, options, rowObject) {
    	if(rowObject.ynCurrent == "是"){
    		return '  <a href="javascript:void(0)" class="glyphicon glyphicon-link"'
    		+'   title="重新生成页面" onClick="doCreate(\''+rowObject.attribute08+'\')"></a>&nbsp;&nbsp;'
    		+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
    		+'   title="删除版本" onClick="deleteVersion('+JSON.stringify(rowObject).replaceAll("\"","\'")+')"></a>'; 
    	}else{
    		return '<a href="javascript:void(0)" class="glyphicon glyphicon-wrench"'
    		+'  title="置为当前版本" onClick="setCurrentVersion(\''+rowObject.attribute08+'\')"></a>&nbsp;&nbsp;'
    		+'  <a href="javascript:void(0)" class="glyphicon glyphicon-link"'
    		+'   title="重新生成页面" onClick="doCreate(\''+rowObject.attribute08+'\')"></a>&nbsp;&nbsp;'
    		+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
    		+'   title="删除版本" onClick="deleteVersion('+JSON.stringify(rowObject).replaceAll("\"","\'")+')"></a>'; 
    	}
    }
    
    function getformviewEdit(cellvalue, options, rowObject){
    	return '<a href="javascript:void(0)" '
		+'  title="名称" onClick="openDesigner(\''+rowObject.attribute08+'\')">'+cellvalue+'</a>';
    }
    
    function openDesigner(version){
        var id = "${param.eformFormInfoId}";
        parent.eformFormInfo.openDesigner(id,version);
    }
    //置当前版本
    function setCurrentVersion(version){
    	//手动请求根节点数据
        $.ajax({
            url: "platform/eform/bpmsManageController/setCurrentVersion",
            data: {eformFormInfoId:"${param.eformFormInfoId}",version:version},
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
            	if(backData.result == '1'){
            		if(backData.data != null){
                        var formInfo = $('#formInfoDiv', window.parent.document).find("#${param.eformFormInfoId}");
                        formInfo.remove();
                        parent.reloadEformFormInfo(backData.data);//刷新父页面信息
            		}
            		layer.msg('操作成功！',{icon: 1});
            	}else {
                    layer.msg('操作失败！',{icon: 2});
                }
            	gridReload();
            }
        });
    }
    
    function gridReload(){
    	var searchdata = {
   			eformFormInfoId:"${param.eformFormInfoId}"
    	};
    	$("#formViewModel").jqGrid('setGridParam', {
    		datatype : 'json',
    		postData : searchdata
    	}).trigger("reloadGrid");
    }
    
    //重新生成页面
    function doCreate(version){
		layer.confirm('确定要重新生成页面吗？',{
			icon : 3,
			title : '提示',
			closeBtn : 0 ,
			area: ['400px', '']
		},function(index){
			layer.close(index);
			avicAjax.ajax({
	            url: "platform/eform/bpmsManageController/doCreateJsp",
	            data: {id:"${param.eformFormInfoId}",version:version},
	            type: "post",
	            async: true,
	            dataType: "json",
	            success: function (backData) {
	                if (backData.result == "1") {
	                    layer.msg('操作成功！', {icon: 1});
	                }else {
	                    layer.msg('操作失败！'+backData.msg, {icon: 2});
	                }
	            }
	        });
		});
	}
    
    //删除版本信息
    function deleteVersion(row){
    	if(row.ynCurrent === "是"){
            layer.msg('当前版本不能删除！', {icon: 2});
    	}else{
    		layer.confirm('确定要删除此版本吗？',{
    			icon : 3,
    			title : '提示',
    			closeBtn : 0 ,
    			area: ['400px', '']
    		},function(index){
    			layer.close(index);
    			avicAjax.ajax({
    	            url: "platform/eform/bpmsManageController/deleteVersion",
    	            data: {id:row.id},
    	            type: "post",
    	            async: true,
    	            dataType: "json",
    	            success: function (backData) {
    	                if (backData.result == "1") {
    	                    layer.msg('操作成功！', {icon: 1});
    	                	gridReload();
    	                }else {
    	                    layer.msg('操作失败！'+backData.msg, {icon: 2});
    	                }
    	            }
    	        });
    		});
    	}
    }
    </script>
</body>

</html>