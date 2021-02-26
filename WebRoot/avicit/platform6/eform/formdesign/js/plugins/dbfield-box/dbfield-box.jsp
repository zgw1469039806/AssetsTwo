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
                <table><tr><td>
                    <div class="form-group">
                        <label class="control-label">页面元素ID：</label>
                        <input type="text" name="domId" id="domId" class="input-medium" value="" style="width:100%">
                    </div>
					</td></tr>
					<tr><td>
					<div class="form-group">
    					<label class="control-label">元素title：</label>
    					<input type="text" name="title" id="title" class="input-medium" value="" style="width:100%">
					</div>
					</td></tr>
                    <%--2.添加当前元素特定"基本属性"--%>
                    <tr><td>
                    <div class="form-group">
                        <label class="control-label">存储模型：</label>
                        <div class="input-group">
	                        <input type="text" name="db_tableName" id="db_tableName" class="input-medium" onfocus=this.blur()  style="width:100%">
	                        <input type="hidden" id="db_tableId" name="db_tableId">
	                        <span id="span_tableName" class="input-group-addon">
	                                <i class="fa fa-table"></i>
	                        </span>
                        </div>
                    </div>
                    </td></tr>
					<tr><td>
                    <div class="form-group">
                        <label class="control-label">列名称：</label>
                        <div class="input-group">
	                        <input type="text" name="db_colName" id="db_colName" class="input-medium" readonly="readonly" style="width:100%">
	                        <span id="span_colName" class="input-group-addon">
	                                <i class="fa fa-table"></i>
	                        </span>
                        </div>
                    </div>
                    </td></tr>
					<tr><td>
                    <div class="form-group">
                        <label class="control-label">外键：</label>
                        <div class="input-group">
	                        <input type="text" name="db_fk" id="db_fk" class="input-medium" readonly="readonly" style="width:100%">
	                        <span id="span_fk" class="input-group-addon">
	                                <i class="fa fa-table"></i>
	                        </span>
                        </div>
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

<script>
    $("#domId").val(GenNonDuplicateID()).trigger("keyup");

    function bindDbColName(tableId) {
        $("#db_colName").unbind("click");
        $("#db_colName").click(function () {
            var selectDbColumnName = new SelectDbColumnName(tableId);
            selectDbColumnName.init(function (data) {
                $("#db_colName").val(data.colName).trigger("keyup");
//                $("#colLabel").val(data.colComments).trigger("keyup");
            });
        });
    }

    function bindDbFk(tableId) {
        $("#db_fk").unbind("click");
        $("#db_fk").click(function () {
            var selectDbColumnName = new SelectDbColumnName(tableId);
            selectDbColumnName.init(function (data) {
                $("#db_fk").val(data.colName).trigger("keyup");
            });
        });
    }
</script>