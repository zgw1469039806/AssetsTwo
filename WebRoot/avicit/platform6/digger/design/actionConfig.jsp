<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>行为配置</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
<%--    <input type="hidden" id="id" name="id" value="${diggerType.id}">--%>
<%--            <input type="hidden" id="parentId" name="parentId" value="${diggerType.parentId}">--%>

            <table class="form_commonTable" style="border:1px;">
                <tr style="height:48px;">
                    <th width="20%" style="word-break: break-all; word-warp: break-word;">
                        <label for="openway">打开方式：</label>
                    </th>
                    <td colspan="2" width="80%">
                        <select id="openway" name="openway" style="width:100%"  class="form-control input-sm">
                            <option value='0'>窗口</option>
                            <option value='1'>新建浏览器tab页</option>
                            <option value='2'>新建本框架tab页</option>
                         </select>
                    </td>
                </tr>
                <tr style="height:48px;">
                    <th width="20%" style="word-break: break-all; word-warp: break-word;">
                        <label for="targetType">行为目标类型：</label>
                    </th>
                    <td colspan="2" width="80%">
                        <select id="targetType" name="targetType" onchange="gradeChange()" style="width:100%"  class='form-control input-sm'>
                            <option value='0'>表单</option>
                            <option value='1'>报表</option>
                            <option value='2'>视图</option>
                        </select>
                    </td>
                </tr>
<%--                <tr>--%>
<%--                    <th width="20%" style="word-break: break-all; word-warp: break-word;">--%>
<%--                        <label for="behaviourtarget">行为目标：</label>--%>
<%--                    </th>--%>
<%--                    <td colspan="2" width="80%">--%>
<%--                        <input title="行为目标" class="form-control input-sm" type="text" style="width: 99%;" type="text"--%>
<%--                                                   name="behaviourtarget" id="behaviourtarget" value=""/>--%>
<%--                    </td>--%>
<%--                <tr style="height:48px;" id="bo_datasource">--%>
<%--                    <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="behaviourtarget">行为目标(<font color='red'>*</font>):</label></th>--%>
<%--                    <td width="90%">--%>
<%--                        <div class="input-group">--%>
<%--                            <input type="text" id="sssss" class="form-control" placeholder="请选择行为目标.."  value="${datasourceFormDisplayName}">--%>
<%--                            <input type="hidden" id="behaviourtarget" name="behaviourtarget" class="form-control" value="${diggerurl}" placeholder="请选择行为目标...">--%>
<%--                            <span class="input-group-btn">--%>
<%--                       <button class="btn btn-default" type="button" onClick='selectForm1();return false;'><i class="glyphicon glyphicon-search" id="saveBut" title=""></i></button>--%>
<%--                     </span>--%>
<%--                        </div>--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--                 --%>
                <tr style="height:48px;">
                    <th width="20%" style="word-break: break-all; word-warp: break-word;"><label for="behaviourtarget">行为目标(<font color='red'>*</font>):</label></th>
                    <td width="80%">
                    <div class="input-group">
                        <input type="hidden" id="behaviourtarget" name="behaviourtarget">
                        <input type="text" class="form-control" placeholder="请选择行为目标" id ="behaviourtarget2" name="behaviourtarget2">
                        <span class="input-group-addon btn btn-default" data-toggle="dropdown">
                                 <span class="glyphicon glyphicon-search" onclick="search()"></span>
                            </span>
                        <div class="dropdown-menu dropdown-menu-right" style="width: 100%" data-stopPropagation="true">

                            <div class="easyui-layout" id="frameA" fit=true>
                                <div class="row" style="margin: 3px;">
                                    <%-- 树搜索 --%>
                                    <input type="hidden" id="searchStatus" value="0"><%-- 搜索状态：0未搜索、1已搜索 --%>
                                    <div class="input-group  input-group-sm">
                                        <input class="form-control" placeholder="回车查询" type="text" id="searchTreeInput">
                                        <span class="input-group-btn">
                                            <button id="searchTreeBtn" class="btn btn-default" type="button" >
                                                <span class="glyphicon glyphicon-search" ></span>
                                            </button>
                                        </span>
                                    </div>

                                    <!-- 电子表单分类树 -->
                                    <ul id="eformTypeTreeUL0" class="ztree" style="height: 205px; overflow-y: auto;">
                                    </ul>
                                    <!-- 电子表单分类树 -->
<%--                                    <ul id="eformTypeTreeUL1" class="ztree" style="height: 205px; overflow-y: auto;">--%>
<%--                                    </ul>--%>
<%--                                    <!-- 电子表单分类树 -->--%>
<%--                                    <ul id="eformTypeTreeUL2" class="ztree" style="height: 205px; overflow-y: auto;">--%>
<%--                                    </ul>--%>
                                </div>
                            </div>
                            <%--<a class="dropdown-item" href="#" id="collectionFile" name="">收藏</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item deleteFile" href="#" flag="folder" name="">删除</a>--%>
                        </div>

                    </div>
                    </td>
                </tr>

<%--                <tr>--%>
<%--                    <th width="20%" style="word-break: break-all; word-warp: break-word;">--%>
<%--                        &nbsp;--%>
<%--                    </th>--%>
<%--                    <td colspan="2" width="80%">--%>
<%--                       --提示：行为目标允许配置为：--%>
<%--                              1，表单模型的表单；--%>
<%--                              2，报表模型的报表；--%>
<%--                              3，表单模型的用户视图；--%>
<%--                    </td>--%>
<%--                </tr>--%>
                <tr>
                    <th width="20%" style="word-break: break-all; word-warp: break-word;">
                        <label for="flagmytarget">是否自定义行为目标：</label>
                    </th>
                    <td  width="80%">
                        <input type='checkbox' id='flagmytarget' name='flagmytarget'>
                    </td>
                </tr>
            </table>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
<script src="avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.js"></script>
<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js"></script>

<script type="text/javascript">
    var eformTypeTree;
    //默认表单
    var asyncUrl="platform/eform/bpmsManageController/getPublishEformByEformType?isBpm=N&formsType=eform";
    var ajaxUrl="platform/eform/bpmsManageController/getPublishEformByEformType";
    var dataparam="id=-1&isBpm=N&formsType=eform";

    document.ready = function () {
    	$.validator.addMethod("integer", function (value, element) {
    	    var tel = /^-?\d+$/g;  //正、负 整数 + 0
    	    return this.optional(element) || (tel.test(value));
    	}, "请输入整数");

        $("#MySetting").dropdown("toggle");
        gradeChange();//初始化
    };

     // function saveForm(){
     //        //parent.eformType.formValidate($('#editForm'));
     //        parent.diggerType.subEdit($("#editForm"));
     //    }
     //    function closeForm(){
     //       parent.diggerType.closeDialog("edit");
     //    }
        function getFormConfig() {
            var config = {
                mytarget: $('#mytarget').val(),
                behaviourtarget: $('#behaviourtarget').val(),
                behaviourtarget2: $('#behaviourtarget2').val(),
                openway: $('#openway').val(),
                targetType: $('#targetType').val()
            };
            return config;
        }
        function setFormConfig(obj) {
            $('#mytarget').val(obj["mytarget"]);
            $('#behaviourtarget').val(obj["behaviourtarget"]);
            $('#behaviourtarget2').val(obj["behaviourtarget2"]);
            $('#openway').val(obj["openway"]);
            $('#targetType').val(obj["targetType"]);

        }
    var setting = {
        async: {
            enable: true,
            url: asyncUrl,//异步请求树子节点url
            autoParam: ["id"]//父节点id

        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdkey: "pId"
            }
        },
        view: {
            fontCss: setFontCssBySearch
        },
        callback: {
            //节点点击事件
            onClick: function (event, treeId, treeNode) {
                if (treeNode.type == "form") {
                    var val=$("#targetType").val();
                    if(val==0){
                        //表单id
                        $("#behaviourtarget").val(treeNode.attribute.id);
                    }
                    if(val==1){
                        $("#behaviourtarget").val(treeNode.attribute.id);
                    }
                    if(val==2){
                        //视图code
                        $("#behaviourtarget").val(treeNode.attribute.viewCode);
                    }

                 $("#behaviourtarget2").val(treeNode.name);
                }
            },
            asyncSuccess: function (event, treeId, treeNode, msg) {
                console.log(msg);
            },
            asyncError: function (event, treeId, treeNode, msg) {
                console.log(msg);

            }
        }
    };
        var selectPublishEform = new SelectPublishEform("behaviourtarget", "sssss", null, "N", "eform");
        selectPublishEform.init(function(data){});

        function search(){
            $.ajax({
                url: ajaxUrl,
                data: dataparam,
                type: "post",
                async: false,
                dataType: "json",
                success: function (backData) {
                    var zNodes = backData;
                    eformTypeTree = $.fn.zTree.init($("#eformTypeTreeUL0"), setting, zNodes);
                 }
            });
        }
    function setFontCssBySearch(treeId, treeNode) {
        if ($("#searchStatus").val() == "1" && treeNode.type == "form") {
            return {color:"red"};
        }
    }

    $("#frameA").on("click",function (e) {
        e.stopPropagation();
    })
    // function filter(treeId, parentNode, childNodes) {
    //     for (var i = 0; i < childNodes.Rows.length; i++) {
    //         childNodes.Rows[0]['open'] = true;
    //         childNodes.Rows[i]['id'] = i;
    //         childNodes.Rows[i]['pId'] = 0;
    //         childNodes.Rows[i]['name'] = childNodes.Rows[i]['DeviceID'];
    //     }
    //     return childNodes.Rows;
    // }
    function gradeChange(){
            //0表单，1.报表 2.视图
        var opt=$("#targetType").find("option:selected").val();
        if(opt==0){
            asyncUrl="platform/eform/bpmsManageController/getPublishEformByEformType?isBpm=N&formsType=eform";
            setting.async.url=asyncUrl;
            ajaxUrl="platform/eform/bpmsManageController/getPublishEformByEformType";
            dataparam="id=-1&isBpm=N&formsType=eform";

        }
        if(opt==1){
            asyncUrl="";
            ajaxUrl="";

        }
        if(opt==2){
            asyncUrl="platform/eform/bpmsManageController/getPublishViewByEformType?isBpm=N&formsType=view";
            setting.async.url=asyncUrl;
            ajaxUrl="platform/eform/bpmsManageController/getPublishViewByEformType";
            dataparam="id=-1&isBpm=N&formsType=view";

        }
    }
</script>
</body>
</html>
