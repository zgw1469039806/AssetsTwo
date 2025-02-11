<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.api.session.SessionHelper"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>单位列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="static/css/platform/aceadmin/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="static/css/platform/aceadmin/css/font-awesome.min.css"/>

    <link rel="stylesheet" href="static/css/platform/eform/jquery-ui.min.css"/>


<link rel="stylesheet" href="avicit/platform6/eform/formdesign/css/subtable.css"/>

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
<script src="static/js/platform/eform/mydialog.js"></script>
<script src="static/js/platform/eform/selectarea.js"></script>
<script src="static/js/platform/eform/subdatatable.js"></script>
<%--选通用代码--%>
<script src="static/h5/common-ext/window-ext.js"></script>
<script src="static/h5/avicSelectBar/compent/lookupTypeSelect/lookupTypeSelect.js"></script>
<link href="static/h5/jquery-select2/3.4/select2.min.css" rel="stylesheet" />
<script src="static/h5/jquery-select2/3.4/select2.min.js"></script>
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
</style>
</head>
<body>
<div class="item-list-wrap">
					<div class="title">明细项<span id="item_add" style="float:right;color:rgb(90, 172, 35);"><i class="fa fa-fw fa-lg fa-plus"></i></span></div>
					<ul id="list_area" class="content-wrap" style="visibility: visible; outline: none;"></ul>
					<div class="empty-tip">
						点击添加新项按钮添加新的明细项
					</div>
				</div>

				<div class="property-list-wrap">
					<div class="title">属性</div>
						<ul class="content-wrap" style="visibility: visible;">
						<form id="property_form">
						<input type="hidden"  name="attribute01" id="attribute01">
						<input type="hidden"  name="colType" id="colType">
						<input type="hidden" name="linkageResultType" id="linkageResultType"/>
                    	<input type="hidden" name="linkageColumnid" id="linkageColumnid"/>
                    	<input type="hidden" name="linkagePara" id="linkagePara"/>
						<input type="hidden" name="linkageImpl" id="linkageImpl">

						<input type="hidden" name="calculateValue" id="calculateValue">
						<input type="hidden" name="calculateCol" id="calculateCol">
						<input type="hidden" name="calculateText" id="calculateText">

						<input type="hidden" name="rowCount" id="rowCount"/>
                    	<input type="hidden" name="queryStatement" id="queryStatement"/>
						<input type="hidden" name="dictionaryPara" id="dictionaryPara">
						<input type="hidden" class="form-control input-sm" id="dataCombox" name="dataCombox" />
						<input type="hidden" class="form-control input-sm" id="dataComboxType" name="dataComboxType" />
						<input type="hidden" class="form-control input-sm" id="dataComboxText" name="dataComboxText" />
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
							<li class="property-list">
								<span class="property-title">字段名称：</span>
								<input type="text" name="colName">
							</li>
							<li class="property-list">
								<span class="property-title">字段描述：</span>
								<input type="text" class="item-name" name="colLabel">
							</li>
							<li class="property-list ">
								<span class="property-title">控件类型：</span>
								<select name="elementType" id="elementType">
									<optgroup label="基础控件">
										<option value="text">文本</option>
										<option value="date">日期</option>
										<option value="number">数字</option>
										<option value="select">下拉框</option>
									</optgroup>
									<optgroup label="高级控件">
										<%--<option value="calculate">计算控件</option>--%>
										<option value="currency">货币</option>
										<option value="dictionary">数据字典</option>
										<option value="user">选用户</option>
										<option value="org">选组织</option>
										<option value="dept">选部门</option>
										<option value="role">选角色</option>
										<option value="group">选群组</option>
										<option value="position">选岗位</option>
										<option value="linkage">联动控件</option>
									</optgroup>

								</select>
							</li>
							<li class="property-list" id="redundanceDiv">
								<span class="property-title">是否冗余：</span>
								<input type="checkbox" name="redundance" value="Y" class="item-width">
							</li>
							<li class="property-list" id="redundanceColNameDiv">
								<span class="property-title">冗余字段名称：</span>
								<%--<input type="text" class="item-name" name="redundanceColName" id="redundanceColName">--%>

								<select id="redundanceColName" name="redundanceColName" isnull="false">
									<option value=""></option>
								</select>
							</li>
							<li class="property-list notRedundance">
								<span class="property-title">是否虚字段：</span>
								<input type="checkbox" name="colIsVir" value="Y" class="item-width">
							</li>
							<li class="property-list" id="userdefinedclassDiv">
								<span class="property-title">转换类路径：</span>
								<select id="userdefinedclass" name="userdefinedclass" isnull="false">
								</select>
							</li>
							<li id="hidden_attr_area" class="property-list" style="display:none">
							</li>
							<ul	id="hiddem_attr_mult" style="display:none">
							</ul>
							<li class="property-list" id="formatValidateDiv">
								<span class="property-title">格式校验：</span>
								<select id="formatValidate" name="formatValidate" isnull="false">
									<option value=""></option>
									<option value="email">邮箱</option>
									<option value="phone">手机</option>
									<option value="idcard">身份证</option>
									<option value="zipcode">邮编</option>
								</select>
							</li>
							<li class="property-list" id="colLength">
								<span class="property-title">字段长度：</span>
								<input type="text" name="colLength" class="item-width">
							</li>
							<li class="property-list">
								<span class="property-title">是否必填：</span>
								<input type="checkbox" name="colIsMust" value="Y" class="item-width">
								<span class="notRedundanc" style="margin-left:30px;">是否显示：</span>
								<input class="notRedundanc" type="checkbox" name="colIsVisible" value="Y" checked="true" style="margin-left:30px;">
							</li>
							<li class="property-list">
								<span class="property-title">是否可编辑：</span>
								<input type="checkbox" name="colIsEdit" value="Y" checked="true"  class="item-width">
							</li>
							<li class="property-list notRedundance" id="colIsAlign">
								<span class="property-title">对齐方式：</span>
								<input name="colIsAlign" type="radio" class="ace" value="left" checked><span>左对齐</span>&nbsp&nbsp
								<input name="colIsAlign" type="radio" class="ace" value="center"><span>居中对齐</span>&nbsp&nbsp
								<input name="colIsAlign" type="radio" class="ace" value="right"><span>右对齐</span>
							</li>
							<li class="property-list" id="searchPart">
								<span class="property-title">基本查询：</span>
								<input type="checkbox" name="searchPart" value="Y" class="item-width">
							</li>
							<li class="property-list notRedundance" id="searchAll">
								<span class="property-title">高级查询：</span>
								<input type="checkbox" name="searchAll" value="Y" class="item-width">
							</li>
							<li class="property-list notRedundanceUser" id="defaultDeptId">
								<span class="property-title">关联部门：</span>
								<select  name="defaultDeptId"></select>
							</li>
							<li class="property-list notRedundance" id="chuantou">
								<span class="property-title">是否穿透：</span>
								<input type="checkbox" name="chuantou" value="Y" class="item-width">
							</li>
							<div id="chuantouurldiv" style="
									border: solid 1px;
									padding: 5px;
									margin: 0 10px;
									display: none;
								">
								<li class="property-list" >
									<span class="property-title">穿透页面URL：</span>
									<input type="text" name="chuantouurl" class="item-width">
								</li>
								<li class="property-list" >
									<span class="property-title">宽：</span>
									<input type="text" name="chuantouwidth" class="item-width" style="width:25%">
									<span>高：</span>
									<input type="text" name="chuantouheight" class="item-width" style="width:25%">
								</li>
							</div>
							<li class="property-list notRedundance" id="colWidth">
								<span class="property-title">宽度：</span>
								<input type="text" name="width" class="item-width" value="20">
							</li>

                            <li class="property-list notRedundance" id="sorttypeDiv">
                                <span class="property-title">排序类型：</span>
                                <select id="sorttype" name="sorttype" isnull="false">
                                    <option value=""></option>
                                    <option value="asc">asc</option>
                                    <option value="desc">desc</option>
                                </select>
                            </li>
                            <li class="property-list notRedundance" id="orderindexDiv">
                                <span class="property-title">数据排序：</span>
                                <div>
									<input type="text" name="orderindex" id="orderindex" class="item-width">
								</div>
                            </li>


							<li id="hidden_attr_sata" style="display: none">
							</li>
							<li class="notRedundance" id = 'formatDiv' style="width:90%;padding-left:10px;float: left;">
								<span style="height: 30px;padding-top:5px;display: inline-block" >
									子表列自定义格式化：
									<span id="formatSpan" class="help-button" data-rel="popover" data-trigger="hover" data-placement="left"
										  data-original-title="提示" data-content="参数：cellvalue、options,、rowObject 如： if(cellvalue == 1){return '<span style='font-color:red'>'+ cellvalue +'</span>';} else {return '<span style='font-color:gray'>'+ cellvalue +'</span>';}">?</span>
								</span>
								<textarea rows=3  name="formatEvent"  id="formatEvent"  style="width: 100%;"></textarea>
							</li>
							<li class="notRedundance" id = 'unformatDiv' style="width:90%;padding-left:10px;float: left;">
								<span style="height: 30px;padding-top:5px;display: inline-block" >
									子表列自定义反格式化：
									<span id="unformatSpan" class="help-button" data-rel="popover" data-trigger="hover" data-placement="left"
										  data-original-title="提示" data-content="用于在编辑或保存时，将已经格式化的值还原。参数：cellvalue、options 如： cellvalue.replace('$','');">?</span>
								</span>
								<textarea rows=3  name="unformatEvent"  id="unformatEvent"  style="width: 100%;"></textarea>
							</li>
							<li id = 'callB' class="hidden notRedundance" style="width:90%;padding-left:10px;float: left;">
								<span style="height: 30px;padding-top:5px;display: inline-block" >
									选择框回调事件：
									<span id="callSpan" class="help-button" data-rel="popover" data-trigger="hover" data-placement="left"
										  data-original-title="提示"

									>?</span>
									</span>
								<textarea rows=3  name="onCallbackEvent"  id="onCallbackEvent"  style="width: 100%;"></textarea>
							</li>
							<li id = 'onchangeDiv' style="width:90%;padding-left:10px;float: left;">
								<span style="height: 30px;padding-top:5px;display: inline-block" >
									onChange事件：
									<span id="changeSpan" class="help-button" data-rel="popover" data-trigger="hover" data-placement="left"
										  data-original-title="提示"

									>?</span>
								</span>
								<textarea rows=3  name="onChangeEvent"  id="onChangeEvent"  style="width: 100%;"></textarea>
							</li>

					</form>
						</ul>
					<div class="empty-tip">
						请选择左边的子表字段
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

    function colunFormatEventEdit(_this, title) {
        layer.open({
            type: 1,
            title: title,
            skin: 'layui-layer-rim',
            area: ['70%', '80%'],
            content: '<textarea id="colunFormatEventEditTextarea" style="width: 100%; height: 98%;">' + _this.value + '</textarea>',
            btn: ['确认', '取消'],
            yes: function (index) {
                $(_this).val($("#colunFormatEventEditTextarea").val()).trigger("keyup");
                update(curId);
                layer.close(index);
            }
        });
    }

    $(document).ready(function() {
    	setCallB($("#elementType").val());
    	$("#elementType").bind("change",function(){
            var value = $(this).val();
            setCallB(value);
        });
    	var colFit = parent.$("input[name='colFit']")[0].checked;
    	if(!colFit){
            $("#colWidth").attr("style","display:block");
		}
    });

 	function setCallB(value){
		switch (value) {
			case "user":
				$("#callSpan").attr("data-content", "参数：user 选中的人员对象");
				break;
			case "org":
				$("#callSpan").attr("data-content", "参数：org 选中的组织对象");
				break;
			case "dept":
				$("#callSpan").attr("data-content", "参数：dept 选中的部门对象");
				break;
			case "role":
				$("#callSpan").attr("data-content", "参数：role 选中的角色对象");
				break;
			case "group":
				$("#callSpan").attr("data-content", "参数：group 选中的群组对象");
				break;
			case "position":
				$("#callSpan").attr("data-content", "参数：position 选中的岗位对象");
				break;
			case "text":
				$("#changeSpan").attr("data-content", "参数：_this 控件对象，e 事件对象");
				break;
			case "number":
				$("#changeSpan").attr("data-content", "参数：_this 控件对象，e 事件对象");
				break;
			case "currency":
				$("#changeSpan").attr("data-content", "参数：_this 控件对象，e 事件对象");
				break;
			case "select":
				$("#changeSpan").attr("data-content", "参数：e 事件对象");
				break;
			case "linkage":
				$("#changeSpan").attr("data-content", "参数：e 事件对象");
				break;
			case "date":
				$("#changeSpan").attr("data-content", "参数：value 所选日期值,e 事件对象");
				break;
		}
		if (value != 'user' && value != 'dept' && value != 'role'
				&& value != 'group' && value != 'position'&& value != 'org') {
			$("#callB").addClass("hidden");
		} else {
			$("#callB").removeClass("hidden");
		}
	}
	var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
	 $('[data-rel=popover]').popover({container:'body'});
		$("#onCallbackEvent").click(function () {
		    var _this = this;
		    eventEdit(_this, '选择框回调事件');
		});
    $("#onChangeEvent").click(function () {
        var _this = this;
        colFormatEventEdit(_this, 'onChange事件');

    });
    $("#formatEvent").click(function () {
        var _this = this;
        colFormatEventEdit(_this, '子表列自定义格式化');

    });
    $("#unformatEvent").click(function () {
        var _this = this;
        colunFormatEventEdit(_this, '子表列自定义反格式化');

    });
</script>