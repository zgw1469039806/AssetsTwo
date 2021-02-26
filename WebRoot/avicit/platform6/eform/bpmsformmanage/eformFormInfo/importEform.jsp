<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>上传xml</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='uploadForm' method="post" enctype="multipart/form-data" style="margin: 20px;">
        <input type="file" id="xmlFile" name="xmlFile" accept="text/xml" />
        <input type="hidden" id="eformComponentId" name="eformComponentId" />
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm btn-point" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="closeForm">取消</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
<script type="text/javascript">
    document.ready = function () {
        $("#eformComponentId").val(parent.eformComponent.selectedEformComponentId);

        $('#saveForm').bind('click', function () {
            var _this = this;
            if ($("#xmlFile").val() == "") {
                layer.msg('请添加要导入的XML文件！', {icon: 7});
            }
            else {
                $(_this).addClass("disabled");
                $("#uploadForm").ajaxSubmit({
                    type : 'POST',
                    url : 'platform/eform/bpmsManageController/importEformXml',
                    dataType : 'text',
                    success : function(response) {
                        response = $.parseJSON(response);

                        if(response.status == "OK") {
                            var formInfo = parent.$('#' + parent.eformFormInfo.formInfoDiv).find("#" + response.data.id);
                            formInfo.remove();
                            parent.eformFormInfo.setFormInfo(response.data);

                            if(response.type == "insert") {
                                parent.layer.msg('新增导入表单XML成功！', {icon: 1});
                            }
                            if(response.type == "update") {
                                parent.layer.msg('覆盖导入表单XML成功！', {icon: 1});
                            }

                            parent.eformFormInfo.closeDialog("upload");
                        }
                        else if(response.status == "EXIST") {
                            layer.confirm('表单XML已存在，是否新建导入?', {
                                icon : 7,
                                title : "请确认：",
                                area : [ '400px', '' ]
                            },function(index){
                                importFormXml(index);
                            },function(index){
                                $("#saveForm").removeClass("disabled");
                                layer.close(index);

                            });
                            // layer.msg('表单XML已存在，不允许重复导入！', {icon: 2});
                        }
                        else if(response.status == "ERROR") {
                            layer.msg('表单XML格式错误！', {icon: 2});
                            $(_this).removeClass("disabled");
                        }
                        else if(response.status == "TYPE_CHANGE") {
                            layer.msg('该表单已存在，不允许更换分类模块导入！', {icon: 2});
                            $(_this).removeClass("disabled");
                        }
                        else {
                            layer.msg('导入表单XML失败！', {icon: 2});
                            $(_this).removeClass("disabled");
                        }

                    }
                });
            }
        });
        $('#closeForm').bind('click', function () {
            parent.eformFormInfo.closeDialog("upload");
        });
    };

    function importFormXml(index){

        $("#uploadForm").ajaxSubmit({
            type : 'POST',
            url : 'platform/eform/bpmsManageController/importEformXmlNew',
            dataType : 'text',
            success : function(response) {
                response = $.parseJSON(response);
                if(response.status == "OK") {
                    var tb = parent.$('#' + parent.eformFormInfo.componentDiv).find("#" + response.data.id);
                    tb.remove();
                    parent.eformFormInfo.setFormInfo(response.data);

                    if(response.type == "insert") {
                        parent.layer.msg('新增导入表单XML成功！', {icon: 1});
                    }
                    if(response.type == "update") {
                        parent.layer.msg('覆盖导入表单XML成功！', {icon: 1});
                    }

                    parent.eformFormInfo.closeDialog("upload");
                }else if(response.status == "ERROR") {
                    layer.msg('表单XML格式错误！', {icon: 2});
                    $("#saveForm").removeClass("disabled");
                }
                else if(response.status == "TYPE_CHANGE") {
                    layer.msg('该表单已存在，不允许更换分类导入！', {icon: 2});
                    $("#saveForm").removeClass("disabled");
                }
                else {
                    layer.msg('导入表单XML失败！', {icon: 2});
                    $("#saveForm").removeClass("disabled");
                }
                layer.close(index);
            }
        });
    }
</script>
</body>
</html>
