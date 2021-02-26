<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
                    <jsp:include page="../attr-jsp/base-attr.jsp">
                    	<jsp:param value="unique" name="except"/>
					</jsp:include>
			<table>
				<tr><td>
                    <%--2.添加当前元素特定"基本属性"--%>
                    <div class="form-group" style="display: none">
                        <label class="control-label">字段长度：</label>
                        <input type="text" name="colLength" id="colLength" value="50" class="input-medium">
                    </div>
                </td></tr>
                <tr><td>
					<div class="form-group">
						<table><tr>
						<td><label class="control-label">弹窗大小：</label></td></tr>
						<tr><td><label>
					        <input name="ynMax" type="radio" class="ace" value="max"  checked>
					        <span class="lbl">最大化</span>
					    </label></td>
					    <td><label style="padding-left: 10px;">
					        <input name="ynMax" type="radio" class="ace" value="setting" >
					        <span class="lbl">设置</span>
					    </label></td>
					    </tr></table>
					</div>
				</td></tr>
				<tr><td>
                    <div class="form-group" style="width:99%">
                        <label class="control-label">宽：</label><input type="text" name="width" id="width" class="input-medium" style="width:31%"><label class="control-label">高：</label><input type="text" name="height" id="height" class="input-medium" style="width:31%">
                    </div>
                </td></tr>
                <tr><td>
                    <div class="form-group" style="width:99%">
                        <label class="control-label">URL地址：</label>
                        <input type="text" name="urlAddress" id="urlAddress" class="input-medium" style="width:100%">
                    </div>
                </td></tr>
                <tr><td>
                    <div class="form-group" style="width:99%">
                        <label class="control-label">转化类名称：</label>
                        <%--<input type="text" name="userdefinedclass" id="userdefinedclass" class="input-medium" style="width:100%">--%>
                        <select id="userdefinedclass" name="userdefinedclass" isnull="false" class="form-control input-sm">	</select>
                    </div>
                </td></tr>
             </table>
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"
                       href="#collapse3">
                        <i data-icon-show="ace-icon fa fa-angle-right" data-icon-hide="ace-icon fa fa-angle-down"
                           class="bigger-110 ace-icon fa fa-angle-right"></i>
                        元素事件属性
                    </a>
                </h4>
            </div>
            <div id="collapse3" class="panel-collapse collapse">
                <div class="panel-body">
                    <%--1.添加公共"事件属性"--%>
                    <jsp:include page="../attr-jsp/event-attr.jsp">
                    	<jsp:param value="change" name="except"/>
                    </jsp:include>

                    <%--2.添加当前元素特定"事件属性"--%>
                    <div class="form-group">
                        <label class="control-label">
                            地址选择回调事件：
                            <span class="help-button" data-rel="popover" data-trigger="hover" data-placement="left"
                                  data-original-title="提示"
                                  data-content="参数：jsonData-用户选择的回填数据"
                            >?</span>
                        </label>
                        <textarea name="onCallbackEvent" id="onCallbackEvent" style="width: 100%;"></textarea>
                    </div>
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