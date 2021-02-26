<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
	String importlibs = "common,tree,form";	
	//String userIds = (String)request.getParameter("userIds");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>移动部门</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<script type="text/javascript">

	document.body.onload = function(){
	 	if (navigator.userAgent.indexOf('MSIE') >= 0) {
            if (CollectGarbage) {
                CollectGarbage(); //IE 特有 释放内存
            }
        }

	}
	if (!Array.prototype.indexOf) {
	    Array.prototype.indexOf = function(elt /*, from*/ ) {
	        var len = this.length >>> 0;
	        var from = Number(arguments[1]) || 0;
	        from = (from < 0) ?
	            Math.ceil(from) :
	            Math.floor(from);
	        if (from < 0)
	            from += len;
	        for (; from < len; from++) {
	            if (from in this &&
	                this[from] === elt)
	                return from;
	        }
	        return -1;
	    };
	}
</script>
</head>
<body>
<div class="easyui-layout" fit="true" >
		<div data-options="region:'center',split:true" style="width:300px;padding:0px;overflow:auto;">
			<div class="row" style="margin: 5px;">
				<div class="input-group  input-group-sm">
			      <input  class="form-control" placeholder="输入名称查询" type="text" id="txt" name="txt">
			      <span class="input-group-btn">
			        <button id="searchbtn" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
			      </span>
			    </div>
				<div>
					<ul id="treeDemo" class="ztree"></ul>
				</div>
			</div>
		</div>
		<div data-options="region:'south',border:false" style="height: 50px;">
			<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-top:0%;" align="center">
						<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" id="consoleSelectDept_saveForm">移动</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"id="consoleSelectDept_closeForm">返回</a>
					</td>
				</tr>
			</table>
			</div>
		</div>
	</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 模块js -->
<script type="text/javascript" src="avicit/platform6/console/user/js/OrgTree.js" ></script>
<script type="text/javascript">
var modifyIndex;
var orgtree;
$(function(){     
	orgtree = new OrgTree('treeDemo','${'console/dept'}','form','txt','searchbtn');
    orgtree.init();
    var userframe = $('iframe#iframeUserList', window.parent.document)[0].contentWindow;
	$('#consoleSelectDept_saveForm').bind('click', function(){
		var deptId = orgtree._selectNode.id;
		if(deptId !== null){
			if(orgtree._selectNode.nodeType=="org"){
				layer.msg('请选择部门！');
				return false;
			}
			
			userframe.saveBatchMoveDept(deptId);
		}
	}); 
	//返回按钮绑定事件
	$('#consoleSelectDept_closeForm').bind('click', function(){
		userframe.closeSelectDeptDilog();
	});

});

</script>

</body>
</html>