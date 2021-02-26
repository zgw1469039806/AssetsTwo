<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html lang="en">
<%
	String importlibs = "common,form,fileupload";
%>
<head>
<meta charset="UTF-8">
<title>候选人</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

<link href="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/theme.css" rel="stylesheet">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect.js"></script>
	
</head>

<body>
<div class="container">
 				 <div class="form-group" style='padding-top: 5px;' id="aaasssdddfffggg">
                                        <label for="input-human-task-candidate" class="col-xs-3 control-label form-process-properties-label">候选人:</label>
                                        <div class="col-xs-9 form-process-properties-value" id="candidate-container">
                                          <input type="hidden"  id="candidate-data-field" name="candidate-data-field">
                                            <textarea  class="form-control" id="candidate-text-field" rows="3" name="candidate-text-field" placeholder="请选择用户"></textarea>
                                        </div>
                                    </div>
                                    
                                      <div class="row">
                                        <div class="col-xs-3 col-xs-offset-8 button-fix button-margin-left-fix">
                                            <button type="button" class="btn btn-primary" name="btn-add-candidate">添加</button>
                                        </div>
                                    </div>
                                    </div>
</body>


<script type="text/javascript">
$("button[name=btn-add-candidate]").on("click",function(){
    var option = {type:'userSelect', userSelectContainer :'candidate-container' ,dataField:'candidate-data-field',textField:'candidate-text-field',topId:"aaasssdddfffggg"};
   var candidateSelect = new UserSelect(option);
});
</script>

</html>

