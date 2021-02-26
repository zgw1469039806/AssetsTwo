<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetstechtransformperson/assetsTechTransformPersonController/operation/Edit/id" -->
    <title>编辑</title>
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
        <input type="hidden" name="version" value="<c:out  value='${assetsTechTransformPersonDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsTechTransformPersonDTO.id}'/>"/>
		<input type="hidden" name="projectId" id="projectId" value="<c:out  value='${assetsTechTransformPersonDTO.projectId}'/>"/>

        <table class="form_commonTable">
            <tr class="commonTableTr">
				<th width="10%" style="word-break:break-all;word-warp:break-word;">
					<label for="userName">姓名:</label></th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" name="userId" id="userId" value="<c:out  value='${assetsTechTransformPersonDTO.userId}'/>"/>
						<input class="form-control" placeholder="请选择用户" type="text" id="userName" name="userName" value="<c:out  value='${assetsTechTransformPersonDTO.userName}'/>">
						<span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="projectRole">项目角色:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="projectRole" id="projectRole" title="" isNull="true" lookupCode="PROJECT_ROLE" defaultValue='${assetsTechTransformPersonDTO.projectRole}'/>
                </td>

				<th width="10%" style="word-break:break-all;word-warp:break-word;">
					<label for="sex">性别:</label></th>
				<td width="15%">
					<pt6:h5select css_class="form-control input-sm" name="sex" id="sex" title="" isNull="true" lookupCode="PLATFORM_SEX" defaultValue='${assetsTechTransformPersonDTO.sex}'/>
				</td>

				<th width="10%" style="word-break:break-all;word-warp:break-word;">
					<label for="userDepartmentAlias">部门:</label></th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="userDepartment" name="userDepartment" value="<c:out  value='${assetsTechTransformPersonDTO.userDepartment}'/>">
						<input class="form-control" placeholder="请选择部门" type="text" id="userDepartmentAlias" name="userDepartmentAlias" value="<c:out  value='${assetsTechTransformPersonDTO.userDepartmentAlias}'/>">
						<span class="input-group-addon">
							<i class="glyphicon glyphicon-equalizer"></i>
						</span>
					</div>
				</td>
            </tr>

            <tr class="commonTableTr">
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="userTitle">职称:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="userTitle" id="userTitle" title="" isNull="true" lookupCode="PLATFORM_USER_TITLE" defaultValue='${assetsTechTransformPersonDTO.userTitle}'/>
                </td>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="mobileNumber">手机:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="mobileNumber" id="mobileNumber" value="<c:out  value='${assetsTechTransformPersonDTO.mobileNumber}'/>"/>
                </td>

				<th width="10%" style="word-break:break-all;word-warp:break-word;">
					<label for="officePhone">办公电话:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="officePhone" id="officePhone" value="<c:out  value='${assetsTechTransformPersonDTO.officePhone}'/>"/>
				</td>

				<td width="10%"></td><td width="15%"></td>
            </tr>

            <tr class="commonTableTr">
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="remarks">备注:</label></th>
                <td width="90%" colspan="7">
                    <textarea class="form-control input-sm" rows="3" name="remarks" id="remarks"><c:out value='${assetsTechTransformPersonDTO.remarks}'/></textarea>
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
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                       title="保存" id="assetsTechTransformPerson_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsTechTransformPerson_closeForm">返回</a>
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
        parent.assetsTechTransformPerson.closeDialog("edit");
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }
        //限制保存按钮多次点击
        $('#assetsTechTransformPerson_saveForm').addClass('disabled').unbind("click");
        parent.assetsTechTransformPerson.save($('#form'), "eidt");
    }

    $(document).ready(function () {
		$("#sex").attr("disabled", "disabled");
		$("#userTitle").attr("disabled", "disabled");

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

        parent.assetsTechTransformPerson.formValidate($('#form'));

        //保存按钮绑定事件
        $('#assetsTechTransformPerson_saveForm').bind('click', function () {
            saveForm();
        });

        //返回按钮绑定事件
        $('#assetsTechTransformPerson_closeForm').bind('click', function () {
            closeForm();
        });

        $('#userName').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'userId', textFiled: 'userName'});
            this.blur();
            nullInput(e);
        });

		$('#userName').on('blur', function (e) {
			var userId = document.getElementById('userId').value;

			if((userId != null) && (userId != undefined) && (userId != '')){
				$.ajax({
					url: parent.assetsTechTransformPerson.getUrl() + "userInfo",
					data: userId,
					contentType: 'application/json',
					type: 'post',
					dataType: 'json',
					success: function (r) {
						if (r.flag == "success") {
							if((r.userDto.sex != null) && (r.userDto.sex != undefined)){
								$("#sex").val(r.userDto.sex);   //设置性别的Value值为r.userDto.sex的项选中
							}

							if((r.userDto.deptName != null) && (r.userDto.deptName != undefined)){
								$("#userDepartmentAlias").val(r.userDto.deptName);   //设置b部门名称
								$("#userDepartment").val(r.userDto.deptId);   //设置部门id
							}

							if((r.userDto.title != null) && (r.userDto.title != undefined)){
								$("#userTitle").val(r.userDto.title);   //设置职称的Value值为r.userDto.title的项选中
							}

							if((r.userDto.mobile != null) && (r.userDto.mobile != undefined)){
								$("#mobileNumber").val(r.userDto.mobile);   //设置手机
							}

							if((r.userDto.mobile != null) && (r.userDto.mobile != undefined)){
								$("#officePhone").val(r.userDto.officeTel);   //设置办公电话
							}
						} else {
							layer.alert('用户信息获取失败,请联系管理员!', {
										icon: 7,
										area: ['400px', ''], //宽高
										closeBtn: 0,
										btn: ['关闭'],
										title: "提示"
									}
							);
						}
					}
				});
			}
		});

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>