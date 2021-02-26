<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<link href="static/h5/jquery-select2/3.4/select2.min.css" rel="stylesheet" />
<script src="static/h5/jquery-select2/3.4/select2.min.js"></script>

<form class="form">
    <input type="hidden" name="elementType" id="elementType" value="text">
    <div class="accordion-style1 panel-group" id="accordion">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"
                       href="#collapse1">
                        <i data-icon-show="ace-icon fa fa-angle-right" data-icon-hide="ace-icon fa fa-angle-down"
                           class="bigger-110 ace-icon fa fa-angle-down"></i>
                        元素基本属性
                    </a>
                </h4>
            </div>
            <div id="collapse1" class="panel-collapse collapse in">
                <div class="panel-body">
                    <%--1.添加公共"基本属性"--%>
                    <jsp:include page="../attr-jsp/base-attr.jsp"/>
			<table>
				<tr><td>
                    <%--2.添加当前元素特定"基本属性"--%>
                    <div class="form-group" style="display: none">
                        <label class="control-label">字段长度：</label>
                        <input type="text" name="colLength" id="colLength" value="50" class="input-medium">
                    </div>
                </td></tr>
                <tr><td>
                    <div class="form-group" style="width:99%">
                        <label class="control-label">默认值：</label>
                        <input type="text" name="defaultValue" id="defaultValue" class="input-medium" style="width:100%">
                    </div>
                 </td></tr>
                <tr><td>
                    <input type="hidden" name="rowCount" id="rowCount"/>
                    <input type="hidden" name="dataCombox" id="dataCombox"/>
                     <input type="hidden" name="dataComboxType" id="dataComboxType"/>
                    <input type="hidden" name="dataComboxText" id="dataComboxText"/>
                    <input type="hidden" name="queryStatement" id="queryStatement"/>
					<input type="hidden" name="dictionaryPara" id="dictionaryPara">
					<input type="hidden" name="jsSuccess" id="jsSuccess"/>
					<input type="hidden" name="jsBefore" id="jsBefore"/>
					<input type="hidden" name="jsAfter" id="jsAfter">

					<input type="hidden" name="isMuti" id="isMuti">
					<input type="hidden" name="waitSelect" id="waitSelect">
					<input type="hidden" name="inputChk" id="inputChk">
					<input type="hidden" name="inputDetail" id="inputDetail">
					<input type="hidden" name="detail" id="detail">
					<input type="hidden" name="detailpagefileId" id="detailpagefileId">
					<input type="hidden" name="detailpagePath" id="detailpagePath">
					<input type="hidden" name="detailpagefileName" id="detailpagefileName">
				</td></tr>
                <tr><td>
                    <div class="form-group" style="width:99%">
                        <label class="control-label">数据字典配置：<a title="数据字典配置" id="propertyBtn"><i
                                class="fa fa-fw fa-lg fa-pencil-square-o"></i></a></label>
                        <input type="hidden" name="colList" id="colList" class="input-medium">
                        <ul id="colArea" class="item-list">
                        </ul>
                    </div>
                </td></tr></table>
                </div>
            </div>
        </div>
    
	    <div class="panel panel-default">
	            <div class="panel-heading">
	                <h4 class="panel-title">
	                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"
	                       href="#collapse_css">
	                        <i data-icon-show="ace-icon fa fa-angle-right" data-icon-hide="ace-icon fa fa-angle-down"
	                           class="bigger-110 ace-icon fa fa-angle-right"></i>
	                       css扩展属性
	                    </a>
	                </h4>
	            </div>
	            <div id="collapse_css" class="panel-collapse collapse">
	                <div class="panel-body">
	                    <%--1.添加css扩展"--%>
	                    <jsp:include page="../attr-jsp/css-attr.jsp"/>
	                </div>
	            </div>
	       </div>
        
    </div>
</form>

<script>
var baseUrl = "<%=ViewUtil.getRequestPath(request)%>"
</script>