<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>候选人</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link href="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/theme.css" rel="stylesheet">
<link href="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect.css" rel="stylesheet">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelectView.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/CommonSelectTree.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
</head>

<body>
        <div class="container-fluid">
            <div class="candidate-choose-box"
                style="min-height: 230px; border-color: azure;">
                    <div class="col-sm-5">
                         <table class="table table-hover" id="taskNode">
						  	<thead>
						  		<tr>
						  		<td>步骤号</td>
						  		<td>步骤名</td>
						  		</tr>
						  		<tr></tr>
						  	</thead>
						  	<tbody>
						  		
						  	</tbody>
						  	
						</table>
                    </div>
              </div>
              <%--<div class="pull-right">
              	 <button name="chooseDeptButtion" type="button" class="btn btn-default form-tool-btn btn-sm " disabled="disabled">确定</button>
              </div>--%>
        </div>
</body>
<script type="text/javascript">
var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
var stepId = "";
var stepName = "";
$(function(){
	/*var pid = flowUtils.getUrlQuery("id");
	var pname = flowUtils.getUrlQuery("name");*/
	var $table = $("#taskNode tbody");
	createTable($table);
	function createTable(obj) {
		if(parent.process && parent.process.designerEditor) {
			var values = parent.process.designerEditor.myCellMap.values();
			$.each(values, function(i, n){
				if(n.tagName == "task"){
					var html = "<tr><td>"+n.alias+"</td>";
					html += "<td>"+n.name+"</td></tr>";
					obj.append(html);
				} 
			});
			obj.find("tr").on("click",function() {
				$("button[name='chooseDeptButtion']").removeAttr("disabled");
				$(this).siblings().removeClass("active");
				$(this).addClass("active");
                stepName = $.trim($(this).children("td:eq(0)").text());
                stepId= $.trim($(this).children("td:eq(1)").text());
			});
		}
	}
	
	/*$("button[name='chooseDeptButtion']").on('click',function(){
		parent.addStepNodeInfoUserSelectView(pid,pname,stepId,stepName);
		parent.layer.close(index);
	});*/
});
</script>
</html>

