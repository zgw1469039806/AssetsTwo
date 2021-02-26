<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<link href="static/h5/jquery-select2/3.4/select2.min.css" rel="stylesheet" />
<script src="static/h5/jquery-select2/3.4/select2.min.js"></script>

<form class="form">
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
                <table>
                	<tr><td>
                    <div class="form-group">
                    	<table>
                        <tr><label class="control-label">子表类型：</label></tr>
                        <tr>
                            <td><label>
                                <input name="subTableType" type="radio" class="ace" value="0">
                                <span class="lbl">自定义</span>
                            </label></td>
                            <td><label>
                                <input name="subTableType" type="radio" class="ace" value="1">
                                <span class="lbl">数据源</span>
                            </label></td>
                       </tr></table>
                    </div>
                    </td></tr>
					<tr><td>
                    <div class="form-group">
                        <label class="control-label">子表名称：</label>
                        <input type="text" name="subTableName" id="subTableName" class="input-medium" style="width:99%">
                    </div>
                    </td></tr>
                    <tr><td>
                	<div class="form-group">
    					<label class="control-label">元素title</label>
    					<input type="text" name="title" id="title" class="input-medium" value="">
					</div>
					</td></tr>
					<tr><td>
                    <div class="form-group" style="display: none;">
                        <label class="control-label">子表外键：</label>
                        <%--<input type="text" name="fkColName" id="fkColName" class="input-medium">--%>
                        <select name="fkColName" id="fkColName" class="input-medium">
                        </select>
                    </div>
                    </td></tr>
                    <tr><td>
                        <div class="form-group">
                            <table>
                                <tr>
                                    <label class="control-label">子表高度：</label></tr>
                                <tr><td>
                                    <label>
                                        <input name="heighttype" type="radio" class="ace" value="0" checked>
                                        <span class="lbl">固定</span>
                                    </label></td>
                                    <td style="padding-left: 30px;">
                                        <label>
                                            <input name="heighttype" type="radio" class="ace" value="1">
                                            <span class="lbl">自动</span>
                                        </label></td>
                                </tr></table>
                        </div>
                        <div class="form-group" id="heightarea">
                            <label class="control-label">高度</label>
                            <input type="text" name="height" id="height" class="input-medium" value="150">
                        </div>
                        <div class="form-group" id="maxheightarea" style="display: none;">
                            <label class="control-label">最大高度</label>
                            <input type="text" name="maxheight" id="maxheight" class="input-medium" value="150">
                        </div>
                    </td></tr>
                    <tr><td>
                        <div class="form-group" id="required">
                            <label>
                                <input name="required" type="checkbox" class="ace" value="Y">
                                <span class="lbl">&nbsp;必填</span>
                            </label>
                        </div>
                    </td></tr>
                    <tr><td>
                    <div class="form-group" id="showRowNum">
                        <label>
                            <input name="showRowNum" type="checkbox" class="ace" value="Y">
                            <span class="lbl">&nbsp;显示序号</span>
                        </label>
                    </div>
					</td></tr>
                    <tr><td>
                        <div class="form-group" id="showCheckbox">
                            <label>
                                <input name="showCheckbox" type="checkbox" checked="checked" class="ace" value="Y">
                                <span class="lbl">&nbsp;显示复选框</span>
                            </label>
                        </div>
                    </td></tr>
					<%--<tr><td>
                        <input name="hideInsertChk" id="hideInsertChk" type="hidden">
                        <input name="hideDeleteChk" id="hideDeleteChk" type="hidden">
                        <input name="importChk" id="importChk" type="hidden">
                        <input type="hidden" name="templetCode" id="templetCode">
                        <input name="exportChk" id="exportChk" type="hidden">
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
                        <input name="dicChk" id="dicChk" type="hidden">
                        <input type="hidden" name="dictionaryList" id="dictionaryList">
                        <input type="hidden" name="dicBtnName" id="dicBtnName">
					</td></tr>--%>
                    <tr><td>
                    <div class="form-group" id="colFit">
                        <label>
                            <input name="colFit" type="checkbox" class="ace" value="Y" checked="checked" style="width:99%">
                            <span class="lbl">&nbsp;列宽自适应</span>
                        </label>
                    </div>
                    </td></tr>
                    <tr><td>
                    <div class="form-group">
                        <label>
                            <input name="pagerChk" id="pagerChk" type="checkbox" class="ace" value="Y">
                            <span class="lbl">&nbsp;启用分页</span>
                        </label>
                    </div>
                    <div id = "pagerInfo" style="display:none">
                        <div class="form-group">
                            <label class="control-label">页数量选项：</label>
                            <input type="text" id="rowList" name="rowList" value="[20, 50, 100, 200, 500]" isnull="false" class="input-medium" style="width:99%" placeholder="页数量选项">
                        </div>
                        <div class="form-group">
                            <label class="control-label">默认页数量：</label>
                            <input type="number" id="rowNum" name="rowNum" value="20" isnull="false" class="input-medium" style="width:99%" placeholder="默认页数量">
                        </div>
                    </div>

                    </td></tr>
                    <tr><td>
                    <div class="form-group">
                        <label class="control-label">字段编辑：<a title="字段编辑" id="addcol"><i
                                class="fa fa-fw fa-lg fa-pencil-square-o"></i></a></label>
                        <input type="hidden" name="colList" id="colList" class="input-medium" style="width:99%">
                        <ul id="colArea" class="item-list">
                        </ul>
                    </div>
                    </td></tr>
                    <tr><td>
                        <div class="form-group">
                            <label class="control-label">按钮编辑：<a title="按钮编辑" id="addbutton"><i
                                    class="fa fa-fw fa-lg fa-pencil-square-o"></i></a></label>
                            <input type="hidden" name="buttonList" id="buttonList" class="input-medium" style="width:99%">
                            <ul id="fkbuttonArea" class="item-list">
                            </ul>
                        </div>
                    </td></tr>
                    <tr><td>
                        <div class="form-group">
                            <label class="control-label">设置多级表头：<a title="设置多级表头" id="addheadercol"><i
                                    class="fa fa-fw fa-lg fa-pencil-square-o"></i></a></label>
                            <input type="hidden" name="headerColList" id="headerColList" class="input-medium" style="width:99%">
                            <ul id="headerColArea" class="item-list">
                            </ul>
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
                        <jsp:param value="init，click,changekeyup,blur,focus,before" name="except"/>
                    </jsp:include>
                    <%--2.添加当前元素特定"事件属性"--%>
                        <tr><td>
                            <div class="form-group">
                                <label class="control-label">加载完成事件：</label>
                                <textarea name="loadCompleteEvent" id="loadComplete" style="width: 100%;"></textarea>
                            </div>
                        </td></tr>
                        <%--<tr><td>
                            <div class="form-group">
                                <label class="control-label">行点击事件：</label>
                                <span id="onSelectRowSpan" class="help-button" data-rel="popover" data-trigger="hover" data-placement="left"
                                      data-original-title="提示" data-content="在只有行点击事件没有单元格点击事件时触发。参数：rowid、status">?</span>
                                </span>
                                <textarea name="onSelectRowEvent" id="onSelectRow" style="width: 100%;"></textarea>
                            </div>
                        </td></tr>--%>
                        <tr><td>
                            <div class="form-group">
                                <label class="control-label">单元格点击事件：</label>
                                <span id="onCellSelectSpan" class="help-button" data-rel="popover" data-trigger="hover" data-placement="left"
                                      data-original-title="提示" data-content="触发此方法时行点击事件失效。参数：rowid、iCol、cellcontent、e">?</span>
                                </span>
                                <textarea name="onCellSelectEvent" id="onCellSelect" style="width: 100%;"></textarea>
                            </div>
                        </td></tr>
                </div>
            </div>
        </div>
    </div>
</form>

<script>
var baseUrl = "<%=ViewUtil.getRequestPath(request)%>"
</script>