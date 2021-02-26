<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,table";
%>
<!DOCTYPE html>
<HTML>
<head>
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" href="avicit/platform6/eform/bpmsformmanage/css/style.css"/>
</head>

<body class="easyui-layout" fit="true">
<div id="complayout" style="height:90%; overflow:scroll"></div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>

<script type="text/javascript">
    document.ready = function () {
    	var comps = parent.engine.getCompList();
    	for(var i = 0; i < comps.length; i++){
    		var componentName = comps[i].name;
    		if(componentName.length > 7){
    			componentName = componentName.substring(0, 7)+"...";
    		}
    		if(comps[i].type == "table" ||  comps[i].type == "tree" ||  comps[i].type == "form" || comps[i].type == "iframe" || comps[i].type == "treeGrid" || comps[i].type == "dataList"){
	    		var comp = "<div class=\"eform-item\" id=\"" + comps[i].id + "\" data-type=\"" + comps[i].type + "\">" + 
		    	"<div class=\"eform-item-title\"><i class=\"glyphicon glyphicon-th eform-item-form " + comps[i].type + "\" style=\"color: rgb(15, 157, 88);\"></i></div>" + 
		    	"<div class=\"eform-item-bottom\"><span class=\"eform-item-bottom-name\" title=\"" + comps[i].name + "\">" + componentName + "</span></div></div>";
		    	$("#complayout").append(comp);
    		}
	    }

    	$(".eform-item").click(function(){
    		var obj = {};
    		obj.id = $(this).attr("id");
    		obj.name = $(this).find(".eform-item-bottom-name").html();
    		obj.type = $(this).data("type");
    		parent.viewEditor.drawCom(obj);
    		parent.viewEditor.closeDialog("add");
    	});
    };
</script>
</body>
<style>
 .eform-item-bottom-name {
    width: 99%;
    font-size: 14px;
    display: inline-block;
    text-align: center;
    border-bottom-left-radius: 3px;
    overflow: hidden;
}
</style>
</html>
