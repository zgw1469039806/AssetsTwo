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
                    <%--<jsp:include page="../attr-jsp/base-attr.jsp"/>--%>
                <table>
                	<tr><td>
                    <div class="form-group" style="width:99%">
                        <label class="control-label">页面元素ID：</label>
                        <input type="text" name="domId" id="domId" class="input-medium" value="" style="width:100%">
                    </div>
					</td></tr>
					<tr><td>
					<div class="form-group" style="width:99%">
    					<label class="control-label">元素title：</label>
    					<input type="text" name="title" id="title" class="input-medium" value="" style="width:100%">
					</div>
					</td></tr>
                    <%--2.添加当前元素特定"基本属性"--%>
                    <tr><td>
                    <div class="form-group">
                    	<table>
                        <tr><label class="control-label">显示所有意见：</label></tr>
                        <tr><td>
                        <label>
                            <input name="bpmopinionShowAll" type="radio" class="ace" value="Y" checked>
                            <span class="lbl">是</span>
                        </label></td>
                        <td><label style="padding-left: 10px;">
                            <input name="bpmopinionShowAll" type="radio" class="ace" value="N">
                            <span class="lbl">否</span>
                        </label></td>
                        </tr></table>
                    </div>
					</td></tr>
					<tr><td>
                    <div class="form-group" id="bpmopinionDiv" style="display: none;">
                        <label class="control-label">流程意见：</label>
                        <input type="hidden" name="bpmopinionIds" id="bpmopinionIds" class="input-medium">
                        <input type="text" name="bpmopinionTexts" id="bpmopinionTexts" class="input-medium" readonly>
                    </div>
					</td></tr>
					<tr><td>
                    <div class="form-group" id="drawClassDiv" style="width:99%">
                        <label class="control-label">自定义实现类：</label>
                        <input type="text" name="drawClass" id="drawClass" class="input-medium" style="width:100%">
                    </div>
					</td></tr></table>
                        <%--1.添加公共"基本属性"--%>
                        <jsp:include page="../attr-jsp/base-attr.jsp">
                            <jsp:param value="unique,column,required,readonly,bpm" name="except"/>
                        </jsp:include>
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

<link rel="stylesheet" type="text/css" href="static/h5/jqGrid-5.2.0/css/ui.jqgrid-bootstrap.css" />
<script type="text/javascript" src="static/h5/jqGrid-5.2.0/js/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="static/h5/jqGrid-5.2.0/js/jquery.jqGrid.custom.js"></script>

<script src="avicit/platform6/bpmreform/forthird/BpmIdeaStyleSelect.js"></script>
<script>
    $("#domId").val(GenNonDuplicateID()).trigger("keyup");

    $('input[type=radio][name=bpmopinionShowAll]').unbind("change");
    $('input[type=radio][name=bpmopinionShowAll]').change(function () {
        if(this.value == "Y") {
            $("#bpmopinionDiv").css("display", "none");

            $("#bpmopinionIds").val("").trigger("keyup");
            $("#bpmopinionTexts").val("").trigger("keyup");
        }
        else {
            $("#bpmopinionDiv").css("display", "");
        }
    });

    $("#bpmopinionTexts").css("cursor", "pointer");
    $("#bpmopinionTexts").unbind("click");
    $("#bpmopinionTexts").click(function () {
        var bpmIdeaStyleSelect = new BpmIdeaStyleSelect(formCode);
        bpmIdeaStyleSelect.show(function (data) {
            $("#bpmopinionIds").val(data.ids).trigger("keyup");
            $("#bpmopinionTexts").val(data.texts).trigger("keyup");
        }, $("#bpmopinionIds").val(), $("#bpmopinionTexts").val());
    });
</script>