<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>编辑</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='editForm'>
        <input type="hidden" id="id" name="id" value="${eformFormInfo.id}">
        <input type="hidden" id="eformComponentId" name="eformComponentId" value="${eformFormInfo.eformComponentId}">

        <table class="form_commonTable">
            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formName">名称：</label>
                </th>
                <td width="35%">
                    <input title="名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="formName" id="formName" value="${eformFormInfo.formName}"/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formCode">编码：</label>
                </th>
                <td width="35%">
                    <input title="编码" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="formCode" id="formCode" value="${eformFormInfo.formCode}"/>
                </td>
            </tr>

            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="orderBy">排序：</label>
                </th>
                <td width="35%">
                    <input title="排序" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="orderBy" id="orderBy" value="${eformFormInfo.orderBy}"/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formStyle">样式：</label>
                </th>
                <td width="35%">
                    <select id="formStyle" name="formStyle" class="form-control">
                        <%--<option value="easyui" <c:if test="${eformFormInfo.formStyle == 'easyui'}">selected</c:if>>EasyUI</option>--%>
                        <option value="bootstrap" <c:if test="${eformFormInfo.formStyle == 'bootstrap'}">selected</c:if>>Bootstrap</option>
                    </select>
                </td>
            </tr>

            <tr>
            <th width="15%" style="word-break: break-all; word-warp: break-word;">
				                    <label for="isBpm">是否流程表单</label>
				                </th>
				                <td width="35%">
									<label class="radio-inline">
										<input type="radio" name="isBpm" value="Y"  <c:if test="${eformFormInfo.isBpm == 'Y'}">checked</c:if>>是
									</label>
									<label class="radio-inline">
										<input type="radio" name="isBpm" value="N"  <c:if test="${eformFormInfo.isBpm == 'N'}">checked</c:if>>否
									</label>
				                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="dataSourceName">数据源：</label>
                </th>
                <td width="35%">
                    <div class="input-group input-group-sm">
                        <input type="hidden" id="dataSourceId" name="dataSourceId" value="${eformFormInfo.dataSourceId}">
                        <input title="数据源" placeholder="请选择数据源" class="form-control input-sm" type="text"
                               id="dataSourceName" readonly value="${dataSourceName}"/>
                        <span class="input-group-addon" id="dataSourceBtn"><i class="glyphicon glyphicon-menu-hamburger"></i></span>
                    </div>
                </td>
            </tr>

            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="userName">所属人员：</label>
                </th>
                <td width="35%">
                    <div class="input-group input-group-sm " style="width:100%;">
                        <input type="hidden" id="userId" name="userId" title="所属人员" value="${eformFormInfo.userId}">
                        <input type="text" class="form-control" id="userName" name="userName" style="" title="所属人员" value="${userName}">
                        <span class="input-group-addon user-box-act" id="userButton"> <i class="glyphicon glyphicon-user"></i> </span>
                    </div>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="deptName">所属部门：</label>
                </th>
                <td width="35%">
                    <div class="input-group input-group-sm ">
                        <input type="hidden" id="deptId" name="deptId" title="所属部门" value="${eformFormInfo.deptId}">
                        <input type="text" class="form-control" style="" id="deptName" name="deptName" title="所属部门" value="${deptName}">
                        <span class="input-group-addon dept-box-act" id="deptButton"> <i class="glyphicon glyphicon-equalizer"></i> </span>
                    </div>
                </td>
            </tr>

            <tr style="display: none;">
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="tableIsUpload">附件：</label>
                </th>
                <td width="35%">
                    <select id="tableIsUpload" name="tableIsUpload" class="form-control">
                        <option value="Y" <c:if test="${eformFormInfo.tableIsUpload == 'Y'}">selected</c:if>>是</option>
                        <option value="N" <c:if test="${eformFormInfo.tableIsUpload == 'N'}">selected</c:if>>否</option>
                    </select>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    &nbsp;
                </th>
                <td width="35%">
                    &nbsp;
                </td>
            </tr>
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn typeb btn-sm" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
<script src="avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.js"></script>

<script type="text/javascript">
    document.ready = function () {
    	$.validator.addMethod("integer", function (value, element) {
    	    var tel = /^-?\d+$/g;  //正、负 整数 + 0
    	    return this.optional(element) || (tel.test(value));
    	}, "请输入整数");
        $.validator.addMethod("codeFormat", function (value, element) {
            var tel = /^[a-zA-Z0-9_]{1,}$/;
            return this.optional(element) || (tel.test(value));
        }, "编码格式只能是字母、数字、下划线的组合");

        //如果该表单已经设计，则不能编辑数据源
        var haveDesigned = "${haveDesigned}";
        if(haveDesigned != "Y") {
            selectCreatedDbTable = new SelectCreatedDbTable("dataSourceId","dataSourceName", "dataSourceBtn");
            selectCreatedDbTable.init();
        }

        parent.eformFormInfo.formValidate($('#editForm'));
        $('#saveForm').bind('click', function () {
            parent.eformFormInfo.subEdit($("#editForm"), "${eformFormInfo.formCode}");
        });
        $('#closeForm').bind('click', function () {
            parent.eformFormInfo.closeDialog("edit");
        });

        $('#deptName').on('focus',function(e){
            var secretLevelValue = '';
            new H5CommonSelect({secretLevel:secretLevelValue,type:'deptSelect', idFiled:'deptId',textFiled:'deptName',viewScope:'currentOrg',selectModel:'single'
                ,hidTab:[]
            });
            this.blur();
        });

        $('#userName').on('focus',function(e){
            var secretLevelValue = '';
            new H5CommonSelect({secretLevel:secretLevelValue,type:'userSelect', idFiled:'userId',textFiled:'userName',viewScope:'currentOrg',selectModel:'single'
                ,hidTab:[], callBack:function(user){$('#deptId').val(user.userdeptids);$('#deptName').val(user.userdeptnames);}
            });
            this.blur();
        });
    };
</script>
</body>
</html>
