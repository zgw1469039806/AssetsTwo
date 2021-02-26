<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>

	<table id="jslistjqGrid"></table>
</body>

<script tpye="text/javascript">





    function initModuleJqgrid(type){
        var dataGridColModel =  [
            { label: '菜单名称', name: 'menuName', width: 100,sortable:false,align:'center'},
            { label: '菜单编码', name: 'menuCode', width: 80,sortable:false,align:'center' },
            { label: '菜单路径', name: 'menuUrl', width: 250,sortable:false ,align:'left'}
        ];

        $("#jslistjqGrid").jqGrid({
            url: "",
            mtype: 'POST',
            datatype: "json",
            toolbar: [false,'top'],//启用toolbar
            colModel: dataGridColModel,//表格列的属性
            height:$(window).height() - 100,//初始化表格高度
            scrollOffset: 20, //设置垂直滚动条宽度
            altRows:true,//斑马线
            styleUI : 'Bootstrap', //Bootstrap风格
            viewrecords: true, //是否要显示总记录数
            autowidth: true,//列宽度自适应
            responsive:true,//开启自适应
            cellEdit:true,
            cellsubmit: 'clientArray'
        });

        var r;
        if (type == 0){
            r = parent.eformmenu;
		}else{
            r = parent.cformmenu;
		}
        if(r!=null && r!=undefined){
            for(var i=0;i<r.length;i++){
                $("#jslistjqGrid").jqGrid("addRowData",i+1,r[i]);
            }
        }
	}


	//JS字符串转换为Json
	function toJson(eformJsList){
		return $.parseJSON(eformJsList);
	}
	 
</script>
</html>