<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>切换目录</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
</head>

<body>
<div class="easyui-layout" fit=true>
    <div data-options="region:'center',split:true,border:false">
        <ul id="directoryTree" class="ztree">
        </ul>
    </div>

    <div data-options="region:'south',border:false" style="height: 40px;">
        <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
            <table class="tableForm" style="border:0;cellspacing:1;width:100%">
                <tr>
                    <td width="50%" align="right">
                        <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="取消" id="closeForm"><span
                                class="glyphicon glyphicon-share-alt" aria-hidden="true">取消</span></a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>


<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script type="text/javascript">
    document.ready = function () {
        var setting = {
            async: {
                enable: true,
                url: "platform/eform/bpmsManageController/getEformTypeAndComponentTree",//异步请求树子节点url
                autoParam: ["id"]//父节点id
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "id",
                    pIdkey: "pId"
                }
            },
            callback: {
                onClick: function (event, treeId, treeNode) {
                    var id = treeNode.id;
                    var name = treeNode.name;
                    var type = treeNode.type;

                    if(type === "component") {
                        if(parent.eformComponent.selectedEformComponentId === id) {
                            layer.msg('不能切换到当前模块！',{
                                icon: 2,
                                area: ['250px', ''],
                                closeBtn: 0
                            });
                        }
                        else {
                            layer.confirm('确定要将电子表单移动到 '+name+' 模块下吗？', {
                            		icon : 3,
                            		title : '提示',
                            		closeBtn : 0 ,
                            		area: ['400px', '']
                            }, function (index) {
                                $.ajax({
                                    url: "platform/eform/bpmsManageController/changeFormDirectory",
                                    data: {
                                        eformFormInfoId: "${param.eformFormInfoId}",
                                        componentId: id
                                    },
                                    type: "post",
                                    async: false,
                                    dataType: "json",
                                    success: function (backData) {
                                        if (backData.flag == "OK") {
                                            parent.layer.msg('操作成功！',{
                                                icon: 1,
                                                area: ['200px', ''],
                                                closeBtn: 0
                                            });

                                            var formInfo = parent.$('#' + parent.eformFormInfo.formInfoDiv).find("#${param.eformFormInfoId}");
                                            formInfo.remove();
                                            if(parent.eformFormViewModel) {
                                                parent.eformFormViewModel.reLoad();
                                            }
                                           
                                            parent.eformFormInfo.closeDialog("changeDirectory");
                                        }
                                        else {
                                            layer.msg('操作失败！',{
                                                icon: 2,
                                                area: ['200px', ''],
                                                closeBtn: 0
                                            });
                                        }
                                    }
                                });
                            });
                        }
                    }
                }
            }
        };
        //手动请求根节点数据
        $.ajax({
            url: "platform/eform/bpmsManageController/getEformTypeAndComponentTree",
            data: "id=-1",
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                var zNodes = backData;
                $.fn.zTree.init($("#directoryTree"), setting, zNodes);
            }
        });

        $('#closeForm').bind('click', function() {
            parent.eformFormInfo.closeDialog("changeDirectory");
        });
    };
</script>
</body>
</html>
