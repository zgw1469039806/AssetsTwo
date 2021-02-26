<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.api.session.SessionHelper"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>按钮编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="static/css/platform/aceadmin/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="static/css/platform/aceadmin/css/font-awesome.min.css"/>

    <link rel="stylesheet" href="static/css/platform/eform/jquery-ui.min.css"/>


<link rel="stylesheet" href="avicit/platform6/eform/formdesign/css/subtable.css"/>
	<script>
		var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
		var tableName = "${param.tablename}";

	</script>

<!-- basic scripts -->
<!--[if !IE]> -->
<script src="static/js/platform/aceadmin/jquery.min.js"></script>
<!-- <![endif]-->
<!--[if IE]>
<script src="static/js/platform/aceadmin/jquery1x.min.js"></script>
<![endif]-->
<script src="static/js/platform/aceadmin/bootstrap.min.js"></script>
<script src="static/js/platform/eform/jquery-ui.min.js"></script>
<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
<script src="static/js/platform/eform/common.js"></script>

<script src="avicit/platform6/eform/formdesign/js/plugins/datatable/selectbuttonumn.js"></script>
<style type="text/css">
.help-button {
	display: inline-block;
	height: 22px;
	width: 22px;
	/*line-height: 22px;*/
	text-align: center;
	padding: 0;
	background-color: #65bcda;
	color: #FFF;
	font-size: 12px;
	font-weight: bold;
	cursor: default;
	/*margin-left: 4px;*/
	border-radius: 100%;
	border-color: #FFF;
	border: 2px solid #FFF;
	-webkit-box-shadow: 0px 1px 0px 1px rgba(0, 0, 0, 0.2);
	box-shadow: 0px 1px 0px 1px rgba(0, 0, 0, 0.2);
}

.help-button:hover {
	background-color: #65bcda;
	text-shadow: none;
}
html,body{
    height: 100%;
    width: 100%;
}
select[readonly] {
	background: #eee;
	cursor: no-drop;
}

select[readonly] option {
	display: none;
}
</style>
</head>
<body>
<div class="item-list-wrap">
					<div class="title">按钮<span id="item_add" style="float:right;color:rgb(90, 172, 35);"><i class="fa fa-fw fa-lg fa-plus"></i></span></div>
					<ul id="list_area" class="content-wrap" style="visibility: visible; outline: none;"></ul>
					<div class="empty-tip">
						点击添加新项按钮添加新的按钮
					</div>
				</div>

				<div class="property-list-wrap">
					<div class="title">属性</div>
					
						<ul class="content-wrap" style="visibility: visible;">
						<form id="property_form">
							<li class="property-list">
								<span class="property-title">按钮id：</span>
								<input type="text" name="iconId" id="iconId">
							</li>
							<li class="property-list">
								<span class="property-title">按钮名称：</span>
								<input type="text" class="item-name" name="iconName" id="iconName">
							</li>
							<li class="property-list">
								<span class="property-title">按钮类型：</span>
								<select id="buttonType" name="buttonType" isnull="false" readonly>
									<option value="custom">自定义</option>
									<option value="insert">添加</option>
									<option value="export">导出</option>
									<option value="import">导入</option>
									<option value="delete">删除</option>
									<option value="dictionary">参考录入</option>
								</select>
							</li>
							<li class="property-list">
								<span class="property-title">是否显示：</span>
								<input type="checkbox" name="colIsVisible" id="colIsVisible" value="Y">
							</li>
							<li class="property-list" id="buttonIconLi">

								<span class="property-title">图标：</span>
								<input type="text" id="buttonIcon" class="iconBtn" name ="buttonIcon" readonly="readonly"/>
								<a title="图标" class="iconBtn" id="iconBtn"><i
										class="fa fa-fw fa-lg fa-pencil-square-o"></i></a>
							</li>
							<div id="specialAttributes">
								<li id = 'buttonclickDiv' style="width:90%;padding-left:10px;float: left;" class="property-list custom_button">
									<span class="property-title">按钮点击事件：</span>
									<textarea rows=3  name="buttonclick" id="buttonclick"  style="width: 100%;"></textarea>
								</li>
								<li class="property-list import_button">
									<span class="property-title">导入模板编码：</span>
									<input type="text" class="item-name" name="templetCode" id="templetCode">
								</li>
								<li class="property-list delete_button">
									<span class="property-title">事件扩展类</span>
									<select id="event_delete_java" name="event_delete_java" isnull="false" title="事件扩展"></select>
								</li>
								<li class="property-list dictionary_button">
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
									<span class="property-title">参考录入配置</span>
									<a title="参考录入配置" id="propertyBtn">
										<i class="fa fa-fw fa-lg fa-pencil-square-o"></i>
									</a>
									<input type="hidden" name="dictionaryList" id="dictionaryList" class="input-medium" value="">
									<ul id="dictionaryArea" class="item-list"></ul>
								</li>
							</div>

					</form>
						</ul>
					<div class="empty-tip">
						请选择左边的按钮
					</div>
				</div>

</body>
</html>
<script>
    function eventEdit(_this, title) {
        layer.open({
            type: 1,
            title: title,
            skin: 'layui-layer-rim',
            area: ['70%', '80%'],
            content: '<textarea id="eventEditTextarea" style="width: 100%; height: 98%;">' + _this.value + '</textarea>',
            btn: ['确认', '取消'],
            yes: function (index) {
                $(_this).val($("#eventEditTextarea").val()).trigger("keyup");
                update(curId);
                layer.close(index);
            }
        });
    }

    function colFormatEventEdit(_this, title) {
        layer.open({
            type: 1,
            title: title,
            skin: 'layui-layer-rim',
            area: ['70%', '80%'],
            content: '<textarea id="colFormatEventEditTextarea" style="width: 100%; height: 98%;">' + _this.value + '</textarea>',
            btn: ['确认', '取消'],
            yes: function (index) {
                $(_this).val($("#colFormatEventEditTextarea").val()).trigger("keyup");
                update(curId);
                layer.close(index);
            }
        });
    }
    $(document).ready(function() {
    	var colFit = parent.$("input[name='colFit']")[0].checked;
    	if(!colFit){
            $("#colWidth").attr("style","display:block");
		}
    });
	 $('[data-rel=popover]').popover({container:'body'});

    $("#buttonclick").click(function () {
        var _this = this;
        colFormatEventEdit(_this, '按钮点击事件');

    });
</script>