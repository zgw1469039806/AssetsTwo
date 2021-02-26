<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>

<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="avicit/platform6/migrate/migratetask/css/style.css">
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'north',border:false" style="height: 65px">
		<div class="ystep" id="taskStep"></div>
	</div>
	<div data-options="region:'center',border:false">
		<form id='taskForm'  role="form" class="">
			<input type="hidden" name="id" id="id" value="${task.id}"/>
			<input type="hidden" name="lastUpdateDateString" id="lastUpdateDateString" value="${task.lastUpdateDateString}"/>
			<div id="step1">
				<div id="selectTitle" class="list-select">
					<div class="list-title">
                        <table class="form_commonTable">
                            <tr>
                                <th width="20%" style="white-space:nowrap;"><label for="name"><i class="required">*</i>任务名称</label></th>
                                <td width="80%">
                                    <input class="form-control input-sm" type="text" name="name" id="name" title="任务名称" data-placement="right" value="${task.name}" data-placement="right"/>
                                </td>
                            </tr>
                        </table>
					</div>
					<div class="list-body">
                        <div class="item-div left-div">
                            <span><i class="fa fa-square" aria-hidden="true"></i>  待选模块</span>
                            <ul class="item-box left-box">
                                <!-- 左边框初始化待选项 -->
                                <c:forEach items="${modelList}" var="model" varStatus="status">
                                    <li class="item" data-id="${model.id}">
                                        <a>
                                            <i <c:if test='${model.modelType == "1"}'>class="fa fa-file-text"</c:if> <c:if test='${model.modelType == "2"}'>class="fa fa-file"</c:if>></i>
                                            <span title="${model.modelName}">${model.modelName}</span>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
						<div class="center-box">
                            <a id="addOne" href="javascript:void(0)" class="btn btn-sm btn-primary form-tool-btn add-one" role="button" title="添加选中项"><i class="icon icon-Last"></i></a>
                            <a id="addAll" href="javascript:void(0)" class="btn btn-sm btn-primary form-tool-btn add-all" role="button" title="添加全部"><i class="icon icon-nextpage"></i></a>
                            <a id="removeOne" href="javascript:void(0)" class="btn btn-sm btn-primary form-tool-btn remove-one" role="button" title="移除选中项"><i class="icon icon-first"></i></a>
                            <a id="removeAll" href="javascript:void(0)" class="btn btn-sm btn-primary form-tool-btn remove-all" role="button" title="移除全部"><i class="icon icon-Previouspage"></i></a>
						</div>
                        <div class="item-div right-div">
                            <span><i class="fa fa-check-square" aria-hidden="true"></i>  已选模块</span>
                            <ul class="item-box right-box" data-placement="right">
                                <!-- 右边框存放已选项 -->
                                <c:forEach items="${taskModelList}" var="taskModel" varStatus="status">
                                    <li class="item" data-id="${taskModel.id}">
                                        <a>
                                            <i class="iconfont icon-file"></i>
                                            <span title="${taskModel.modelName}">${taskModel.modelName}</span>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
					</div>
				</div>
			</div>

            <%--step2--%>
            <div id="step2">
                <div class="data-source">
                    <input type="hidden" name="dbId" />
                    <table class="form_commonTable">
                        <tr>
                            <th width="20%" style="white-space:nowrap;"><label for="dbId"><i class="required">*</i>目标数据库</label></th>
                            <td width="80%">
                                <select class="form-control input-sm" id="dbId" name="dbId" title="目标数据库" data-placement="right" data-placement="right">
                                    <option value=""></option>
                                    <c:forEach items="${dbList}" var="db" varStatus="status">
                                        <option value="${db.id}" <c:if test="${task.dbId == db.id}">selected</c:if>>${db.dbName}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr class="data-source-display" style="white-space:nowrap;">
                            <th width="20%"><label for="dbType">数据库类型</label></th>
                            <td width="80%">
                                <span id="dbType"></span>
                            </td>
                        </tr>
                        <tr class="data-source-display" style="white-space:nowrap;">
                            <th width="20%"><label for="dbIp">数据库地址</label></th>
                            <td width="80%">
                                <span id="dbIp"></span>
                            </td>
                        </tr>
                        <tr class="data-source-display" style="white-space:nowrap;">
                            <th width="20%"><label for="dbPort">数据库地址</label></th>
                            <td width="80%">
                                <span id="dbPort"></span>
                            </td>
                        </tr>
                        <tr class="data-source-display" style="white-space:nowrap;">
                            <th width="20%"><label for="dbUser">用户名</label></th>
                            <td width="80%">
                                <span id="dbUser"></span>
                            </td>
                        </tr>
                        <tr class="data-source-display">
                            <th width="20%"></th>
                            <td width="80%">
                                <a id="testConnect" href="javascript:void(0)" class="btn btn-sm btn-primary form-tool-btn add-one" role="button" title="测试连接">测试连接</a>
                            </td>
                        </tr>
                    </table>

                </div>
            </div>

            <%--step3--%>
            <div id="step3">
                <div class="setting-rule">
                    <table class="form_commonTable">
                        <tr>
                            <th width="20%" style="white-space:nowrap;"><label for="dataDate"><i class="required">*</i>数据起止时间</label></th>
                            <td width="80%">
                                <div style="overflow: hidden;white-space:nowrap;" class="dataStartEndDate" data-placement="right">
                                    <div class="input-group input-group-sm" style="float:left; width: 45%;">
                                        <input class="form-control date-picker" type="text" name="dataStartDate" id="dataStartDate" readonly value="${task.dataStartDateDisplay}"/>
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    </div>
                                    <div style="float:left;padding:0px 3%;">至</div>
                                    <div class="input-group input-group-sm" style="float:left; width: 45%;">
                                        <input class="form-control date-picker" type="text" name="dataEndDate" id="dataEndDate" readonly value="${task.dataEndDateDisplay}" />
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr class="data-source-display">
                            <th width="20%" style="white-space:nowrap;"><label for="execType"><i class="required">*</i>迁移类型</label></th>
                            <td width="80%">
                                <label class="radio-inline">
                                    <input class="form-control" type="radio" name="execType" value="1" id="execTypeAuto" title="自动" <c:if test="${empty task || task.execType == '1'}">checked</c:if>>自动
                                </label>
                                <label class="radio-inline">
                                    <input class="form-control" type="radio" name="execType" value="2" id="execTypeManual" title="手动" <c:if test="${task.execType == '2'}">checked</c:if>>手动
                                </label>
                            </td>
                        </tr>
                        <tr id="execDateTr">
                            <th width="20%" style="white-space:nowrap;"><label for="execDate">迁移时间</label></th>
                            <td width="80%">
                                <div class="input-group input-group-sm" data-placement="right">
                                    <input class="form-control time-picker" type="text" name="execDate" id="execDate" readonly value="${task.execDateDisplay}" />
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <%--step4--%>
            <div id="step4">

                <div class="confirm-rule">
                    <div class="migrate-content">
                        <h3>数据开始迁移</h3>
                    </div>
                    <div class="database">
                        <div class="source">
                            <div class="databaseModel">
                                <div class="cylinder"></div>
                                <div class="ovals"></div>
                                <div class="content">源数据库</div>
                                <div class="process-bar"></div>
                                <div class="triangle"></div>
                            </div>
                        </div>
                        <div class="target">
                            <div class="databaseModel">
                                <div class="cylinder"></div>
                                <div class="ovals"></div>
                                <div class="content">目标数据库</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 45px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera" style="height: 45px;">
            <table class="tableForm" style="border: 0; cellspacing: 1; width: 97%; margin:0px 20px">
				<tr>
                    <td style="height: 38px; width:20%;white-space:nowrap;" align="right">
                        <a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="上一步" id="sysMigrateTask_prev">上一步</a>
                        <a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="下一步" id="sysMigrateTask_next">下一步</a>
                        <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="sysMigrateTask_concel">取消</a></td>
                    </td>
                </tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>

	<script src="avicit/platform6/migrate/migratetask/js/common.js" type="text/javascript"></script>
	<script type="text/javascript">

		$(document).ready(function () {
            parent.sysMigrateTask.validateTaskOnChangeResult = true;

            //$('.date-picker').datepicker();
            $('.time-picker').datetimepicker({
                oneLine:true,//单行显示时分秒
                closeText:'确定',//关闭按钮文案
                showButtonPanel:true,//是否展示功能按钮面板
                showSecond:false,//是否可以选择秒，默认否
                beforeShow: function(selectedDate) {
                    if($('#'+selectedDate.id).val()==""){
                        $(this).datetimepicker("setDate", new Date());
                        //$('#'+selectedDate.id).val('');
                    }
                }
            });

            $("#dataStartDate").datepicker({
                onClose: function(selectedDate) {
                    $("#dataEndDate").datepicker("option", "minDate", selectedDate);
                }
            });
            $("#dataEndDate").datepicker({
                onClose: function(selectedDate) {
                    $("#dataStartDate").datepicker("option", "maxDate", selectedDate);
                }
            });


            //l流程步骤初始化
            $(".ystep").loadStep({steps: ["模块选择","目标库选择","规则配置","确认"]});

            //step1 数据源选择
            //模块列表的初始化
            $("#selectTitle").initModelList();

            //隐藏 step2 step3 stpe 4
            $("#step2").hide();
            $("#step3").hide();
            $("#step4").hide();

			//下一步按钮绑定事件
			$('#sysMigrateTask_next').off('click').on('click', function(){
                parent.sysMigrateTask.bindNextButton($("#taskForm"), $(".ystep"), $('#sysMigrateTask_next'), $('#sysMigrateTask_prev'), window.name);

			});
            // 添加初始样式，预防show()将display设置为inline
            $('#sysMigrateTask_prev').css('display', 'inline-block');
			//上一步按钮绑定事件
            $('#sysMigrateTask_prev').hide();
			$('#sysMigrateTask_prev').off('click').on('click', function(){
                parent.sysMigrateTask.bindPrevButton($("#taskForm"), $(".ystep"), $('#sysMigrateTask_next'), $('#sysMigrateTask_prev'), window.name);

			});

            $('#sysMigrateTask_concel').off('click').on('click', function(){
                parent.sysMigrateTask.closeDialog(window.name);
            });

			//数据源邦定onchange事件
            $('#dbId').off('change').on('change', function(event){
                parent.sysMigrateTask.validateTaskOnChange(event);
                parent.sysMigrateTask.displayDataSource(event);
            });

            //触发数据源的change事件
            if(parent.sysMigrateTask.isNotEmpty($("#id").val()) ){
                $('#dbId').trigger("change");
            }

            //当手动执行的时候，迁移时间不显示
            if($('input[type="radio"][id^="execType"][value="2"]').is(':checked')){
                $("#execDateTr").hide();
            }

            //执行类型绑定change事件
            $('input[type="radio"][id^="execType"]').off('change').on('change', function(event){
                if($(event.target).is('[value="2"]:checked')){
                    $("#execDate").attr("data-execdate",$("#execDate").val());
                    $("#execDate").val("");
                    $("#execDateTr").hide();
                }else{
                    $("#execDate").val($("#execDate").attr("data-execdate"));
                    $("#execDateTr").show();
                }

            });

            //输入框绑定change事件
            $("#name,#dataStartDate,#dataEndDate,#execDate").off("change").on('change', function(event){
                parent.sysMigrateTask.validateTaskOnChange(event);

            });
																																																																																																																																																																																													
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>