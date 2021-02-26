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
        <input type="hidden" id="dbTableTypeId" name="dbTableTypeId" />
        <input type="hidden" id="submittableName" name="tableName" />
        <input type="hidden" id="submittableComments" name="tableComments" />
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn typeb btn-sm" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="closeForm">取消</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div id="reTableName">
    <form id='form'>
        <table class="form_commonTable">
            <tr>
                <th width="18%" style="word-break: break-all; word-warp: break-word;">
                    <label for="tableName">表英文名称：</label>
                </th>
                <td width="32%">
                    <input title="表英文名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="tableName" id="tableName"/>
                </td>
                <th width="18%" style="word-break: break-all; word-warp: break-word;">
                    <label for="tableComments">表中文名称：</label>
                </th>
                <td width="32%">
                    <input title="表中文名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="tableComments" id="tableComments"/>
                </td>
            </tr>
        </table>
    </form>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
<script type="text/javascript">
    document.ready = function () {
        $.validator.addMethod("english", function(value, element) {
            var chrnum = /^[^\u4e00-\u9fa5]*$/;
            return this.optional(element) || (chrnum.test(value));
        }, "不能输入汉字");




        $("#dbTableTypeId").val(parent.dbTableTypeTree.selectedNodeId);

        $('#saveForm').bind('click', function () {
            if ($("#xmlFile").val() == "") {
                layer.msg('请添加要导入的XML文件！', {icon: 7});
            }
            else {
                $("#saveForm").addClass("disabled");
                $("#uploadForm").ajaxSubmit({
                    type : 'POST',
                    url : 'platform/eform/bpmsManageController/importDbXml',
                    dataType : 'text',
                    success : function(response) {
                        response = $.parseJSON(response);

                        if(response.status == "OK") {
                            var tb = parent.$('#' + parent.dbTable.componentDiv).find("#" + response.data.id);
                            tb.remove();
                            parent.dbTable.setComponent(response.data);

                            if(response.type == "insert") {
                                if (parent.eformComponentModel !=null && parent.eformComponentModel!="undefined")
                                    parent.eformComponentModel.reLoad(parent.dbTableTypeTree.selectedNodeId);
                                parent.layer.msg('新增导入存储模型XML成功！', {icon: 1});
                            }
                            if(response.type == "update") {
                                if (parent.eformComponentModel !=null && parent.eformComponentModel!="undefined")
                                    parent.eformComponentModel.reLoad(parent.dbTableTypeTree.selectedNodeId);
                                parent.layer.msg('覆盖导入存储模型XML成功！', {icon: 1});
                            }

                            parent.dbTable.closeDialog("upload");
                        }
                        else if(response.status == "EXIST") {
                            layer.confirm('存储模型XML已存在，是否继续导入?', {
                                icon : 7,
                                title : "请确认：",
                                area : [ '400px', '' ]
                            },function(index){
                                layer.close(index);
                                formValidate($('#form'));
                                layer.open({
                                    type: 1,
                                    skin: 'bs-modal',
                                    area: ['100%', '100%'],
                                    maxmin: false,
                                    content: $("#reTableName"),
                                    btn: ['确定','取消'],
                                    yes: function(index, layero){
                                        importDbXml(index);
                                    },
                                    no: function(index, layero){
                                        layero.close(index);
                                    }
                                });
                            },function(index){
                                $("#saveForm").removeClass("disabled");
                                layer.close(index);
                            });
                        }
                        else if(response.status == "ERROR") {
                            layer.msg('存储模型XML格式错误！', {icon: 2});
                            $("#saveForm").removeClass("disabled");
                        }
                        else if(response.status == "TYPE_CHANGE") {
                            layer.msg('该存储模型已存在，不允许更换分类导入！', {icon: 2});
                            $("#saveForm").removeClass("disabled");
                        }
                        else {
                            layer.msg('导入存储模型XML失败！'+response.error, {icon: 2});
                            $("#saveForm").removeClass("disabled");
                        }
                    }
                });
            }
        });
        $('#closeForm').bind('click', function () {
            parent.dbTable.closeDialog("upload");
        });
    };

    function importDbXml(index){
        var form = $("#form");
        var isValidate = form.validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }

        var btn0= $(".layui-layer-btn .layui-layer-btn0");
        btn0.addClass("btn").addClass("disabled");

        var tableName = $('#tableName').val();
        var patt1 = /^[0-9]/;
        if(tableName.charAt(0).match(patt1)){
            layer.msg('表英文名称不能以数字开头！', {icon: 2});
            $("#saveForm").removeClass("disabled");
            btn0.addClass("btn").removeClass("disabled");
            return;
        }

        $("#submittableName").val($("#tableName").val());
        $("#submittableComments").val($("#tableComments").val());
        $("#uploadForm").ajaxSubmit({
            type : 'POST',
            url : 'platform/eform/bpmsManageController/importDbXmlNew',
            dataType : 'text',
            success : function(response) {
                response = $.parseJSON(response);
                if(response.status == "OK") {
                    var tb = parent.$('#' + parent.dbTable.componentDiv).find("#" + response.data.id);
                    tb.remove();
                    parent.dbTable.setComponent(response.data);

                    if(response.type == "insert") {
                        if (parent.eformComponentModel !=null && parent.eformComponentModel!="undefined")
                            parent.eformComponentModel.reLoad(parent.dbTableTypeTree.selectedNodeId);
                        parent.layer.msg('新增导入存储模型XML成功！', {icon: 1});
                    }
                    if(response.type == "update") {
                        if (parent.eformComponentModel !=null && parent.eformComponentModel!="undefined")
                            parent.eformComponentModel.reLoad(parent.dbTableTypeTree.selectedNodeId);
                        parent.layer.msg('覆盖导入存储模型XML成功！', {icon: 1});
                    }

                    parent.dbTable.closeDialog("upload");
                    layer.close(index);
                }else if(response.status == "ERROR") {
                    layer.msg('存储模型XML格式错误！', {icon: 2});
                    $("#saveForm").removeClass("disabled");
                    layer.close(index);
                }
                else if(response.status == "TYPE_CHANGE") {
                    layer.msg('该存储模型已存在，不允许更换分类导入！', {icon: 2});
                    $("#saveForm").removeClass("disabled");
                    layer.close(index);
                }else if(response.status == "EXIST"){
                    layer.msg('表名已存在，请重新输入表英文名称！', {icon: 2});
                    $("#saveForm").removeClass("disabled");
                }
                else {
                    layer.msg('导入存储模型XML失败！', {icon: 2});
                    $("#saveForm").removeClass("disabled");
                    layer.close(index);
                }

            }
        });
    }

    function formValidate(form){
        form.validate({
            rules: {
                tableName:{
                    english : true,
                    required: true
                },
                tableComments:{
                    required: true,
                    maxlength: 50
                }
            }
        });
    }
</script>
</body>
</html>
