<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "demo/assetstechtransformproject/assetsTechTransformProjectController/operation/Add/null" -->
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<style type="text/css">
	th {
		text-align: left;
	}
	.form_commonTable{
		border-spacing: 0;
	}
	.form_commonTable tr.commonTableTr th {
		text-align: left;
		background-color: rgba(228, 228, 228, 1);
		border-bottom: 2px solid #ffffff;
		padding: 0 5px;
	}
</style>

<body class="easyui-layout" fit="true">
    <div data-options="region:'center',split:true,border:false">
        <form id='form'>
            <input type="hidden" name="id"/>
            <table class="form_commonTable">
                <tr class="commonTableTr">
                    <th width="18%">
                        <label for="projectNo">项目序号:</label></th>
                    <td width="30%">
                        <input class="form-control input-sm" type="text" name="projectNo" id="projectNo"/>
                    </td>

                    <td width="4%"></td>

                    <th width="18%">
                        <label for="ttProjectName">技改项目名称:</label></th>
                    <td width="30%">
                        <input class="form-control input-sm" type="text" name="ttProjectName" id="ttProjectName"/>
                    </td>
                </tr>

                <tr class="commonTableTr">
                    <th width="18%">
                        <label for="replyName">批复名称:</label></th>
                    <td width="30%">
                        <input class="form-control input-sm" type="text" name="replyName" id="replyName"/>
                    </td>

                    <td width="4%"></td>
                    <th width="18%">
                        <label for="chiefEngineerAlias">主管总师:</label></th>
                    <td width="30%">
                        <div class="input-group  input-group-sm">
                            <input type="hidden" id="chiefEngineer" name="chiefEngineer">
                            <input class="form-control" placeholder="请选择用户" type="text" id="chiefEngineerAlias" name="chiefEngineerAlias" required>
                            <span class="input-group-addon">
                                <i class="glyphicon glyphicon-user"></i>
                            </span>
                        </div>
                    </td>
                </tr>

                <tr class="commonTableTr">
                    <th width="18%">
                        <label for="projectDirectorAlias">项目主管:</label></th>
                    <td width="30%">
                        <div class="input-group  input-group-sm">
                            <input type="hidden" id="projectDirector" name="projectDirector">
                            <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias" name="projectDirectorAlias" required>
                            <span class="input-group-addon">
                                <i class="glyphicon glyphicon-user"></i>
                            </span>
                        </div>
                    </td>

                    <td width="4%"></td><td width="18%"></td><td width="30%"></td>
                </tr>
                <tr class="commonTableTr">
                    <th width="18%" style="vertical-align: top;">
                        <label for="remarks" style="margin-top: 5px;">备注:</label></th>
                    <td width="82%" colspan="4">
                        <textarea class="form-control input-sm" rows="3" name="remarks" id="remarks"></textarea>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'south',border:false" style="height: 60px;">
        <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
            <table class="tableForm" style="border:0;cellspacing:1;width:100%">
                <tr>
                    <td width="50%" style="padding-right:4%;" align="right">
                        <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="assetsTechTransformProject_saveForm">保存</a>
                        <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="assetsTechTransformProject_closeForm">返回</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

    <script type="text/javascript">
        function closeForm() {
            parent.assetsTechTransformProject.closeDialog("insert");
        }

        function saveForm() {
            var isValidate = $("#form").validate();
            if (!isValidate.checkForm()) {
                isValidate.showErrors();
                $(isValidate.errorList[0].element).focus();
                return false;
            }
            //限制保存按钮多次点击
            $('#assetsTechTransformProject_saveForm').addClass('disabled').unbind("click");
            parent.assetsTechTransformProject.save($('#form'), "insert");
        }

        $(document).ready(function () {
            $('.date-picker').datepicker();
            $('.time-picker').datetimepicker({
                oneLine: true,//单行显示时分秒
                closeText: '确定',//关闭按钮文案
                showButtonPanel: true,//是否展示功能按钮面板
                showSecond: false,//是否可以选择秒，默认否
                beforeShow: function (selectedDate) {
                    if ($('#' + selectedDate.id).val() == "") {
                        $(this).datetimepicker("setDate", new Date());
                        $('#' + selectedDate.id).val('');
                    }
                }
            });

            parent.assetsTechTransformProject.formValidate($('#form'));

            //保存按钮绑定事件
            $('#assetsTechTransformProject_saveForm').bind('click', function () {
                saveForm();
            });

            //返回按钮绑定事件
            $('#assetsTechTransformProject_closeForm').bind('click', function () {
                closeForm();
            });

            $('#chiefEngineerAlias').on('focus', function (e) {
                new H5CommonSelect({type: 'userSelect', idFiled: 'chiefEngineer', textFiled: 'chiefEngineerAlias'});
                this.blur();
                nullInput(e);
            });
            $('#projectDirectorAlias').on('focus', function (e) {
                new H5CommonSelect({type: 'userSelect', idFiled: 'projectDirector', textFiled: 'projectDirectorAlias'});
                this.blur();
                nullInput(e);
            });

            $('.date-picker').on('keydown', nullInput);
            $('.time-picker').on('keydown', nullInput);
        });
    </script>
</body>
</html>