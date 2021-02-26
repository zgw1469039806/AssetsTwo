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
                            <jsp:param value="column,required,unique,unique,bpm,readonly" name="except"/>
                        </jsp:include>
                    <%--2.添加当前元素特定"基本属性"--%>
                <table>
                    <tr><td>
                        <div class="form-group">
                            <label class="control-label">页面元素ID：</label>
                            <input type="text" name="domId" id="domId" class="input-medium" value="" style="width:100%">
                        </div>
                        <div class="form-group">
                            <label class="control-label">图标名称：</label>
                            <input type="text" name="buttonName" id="buttonName" class="input-medium" value="" style="width:100%">
                        </div>
                    </td></tr>
                    <tr>
                        <td>
                            <input type="hidden" id="buttonIcon" name ="buttonIcon"/>

                            <div class="form-group">
                                <label class="control-label">图标：<a title="图标" class="propertyBtn" id="propertyBtn"><i
                                        class="fa fa-fw fa-lg fa-pencil-square-o"></i></a></label>
                                <ul id="colArea" class="item-list">
                                </ul>
                                <span id="buttonPreview" class="propertyBtn" style="display: block;cursor: pointer;"></span>
                            </div>
                        </td>
                    </tr>
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
                        <jsp:param value="init,change,keyup,blur,focus,before" name="except"/>
                        </jsp:include>

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
<script>
    function setIconInfo(obj){
        $("#propertyBtn").hide();
        $("#buttonPreview").empty();
        $("#buttonIcon").val("<span class = '"+obj.icon+"'></span>");
        $("#buttonPreview").append("<span class ='"+obj.icon+"'></span><span style='float:right' onclick='$(\"#buttonPreview\").empty();$(\"#buttonIcon\").val(\"\");$(\"#propertyBtn\").show();$(\"#buttonIcon\").trigger(\"keyup\");event.stopPropagation();'>x</span>");
        $("#buttonIcon").trigger("keyup");
        layer.close(iconlayer);
    }
</script>