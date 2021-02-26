<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form class="form">
    <input type="hidden" name="elementType" id="elementType" value="text">
    <input type="hidden" name="marcoType" id="marcoType" value="">
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
                        <jsp:param value="readonly" name="except"/>
                    </jsp:include>

                    <%--2.添加当前元素特定"基本属性"--%>
                    <div class="form-group" style="display: none">
                        <label class="control-label">字段长度：</label>
                        <input type="text" name="colLength" id="colLength" value="1000" class="input-medium">
                    </div>
                    <div class="form-group" style="width:99%">
                    <table style="width:99%"><tr>
                        <td><label class="control-label">宏：</label></td>
                        <td><select name="marco" id="marco" style="width:100%">
                            <optgroup label="日期时间" id="date_time" style="font-weight: 900;"></optgroup>
                            <optgroup label="用户组织" id="org_user" style="font-weight: 900;"></optgroup>
                            <optgroup label="流程" id="workflow" style="font-weight: 900;"></optgroup>
                            <optgroup label="其它" id="other" style="font-weight: 900;"></optgroup>
                        </select></td>
                    </tr></table>
                    </div>
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
                    <jsp:include page="../attr-jsp/event-attr.jsp"/>

                    <%--2.添加当前元素特定"事件属性"--%>
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
