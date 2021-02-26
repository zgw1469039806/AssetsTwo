<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>单位列表</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="" name="111"/>
    </jsp:include>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
        <jsp:param value="" name="111"/>
    </jsp:include>
    <script src="avicit/platform6/eform/formdefine/js/eformCustomDialog.js"></script>
    <script src="avicit/platform6/eform/formdefine/js/eformUpload.js" type="text/javascript"></script>
    <script src="avicit/platform6/autocode/js/AutoCode.js" ></script>
    <script src="static/js/platform/eform/common.js"></script>
    <script src="static/js/platform/eform/jqgridValidate.js"></script>
    <script src="static/h5/common-ext/h5-common-after.js"></script>
    <!-- 富文本的js与css -->
    <script src="static/h5/kindeditor/kindeditor-all-min.js"></script>
    <link rel="stylesheet" href="static/h5/kindeditor/themes/default/default.css" />
    <script src="static/h5/kindeditor/lang/zh-CN.js"></script>
    <style>
        input,select,textarea{

            outline-color: invert !important;
            outline-style: none !important;
            outline-width: 0px !important;
            border: none !important;
            border-style: none !important;
            text-shadow: none !important;
            -webkit-appearance: none !important;
            -webkit-user-select: text !important;
            outline-color: transparent !important;
            box-shadow: none !important;
            background-color: transparent !important;

        }
        textarea{
            overflow:hidden !important;
            resize:none !important;
        }
        .mce-content-body{
            width:210mm !important;
            margin:0 auto;
        }
    </style>

    <script type="text/javascript">
        var globalUploadNumTemp = 0;
        var tableName = "EFORM_TYPE";
        var entryId = "";
        var eformInfoId;
        if(parent.printEditor === null ||parent.printEditor === undefined){
            eformInfoId = parent.eformInfoId;
        }else{
            eformInfoId = parent.printEditor.eformFormInfoId
        }
        $.ajax({
            url:'print/sysPrintDesignerController/preview.json',
            data : {tableContent: parent.showContent,forminfoId:eformInfoId,style:parent.eformInfoStyle},
            type : 'post',
            dataType : 'json',
            success : function(r){
                if(r.flag ==  "success"){
                    if (parent.tinymceContentStyle){
                        loadLinkTag( "avicit/platform6/formprint/printdesign/css/tinymce-content/"+parent.tinymceContentStyle+".css");
                    }
                    $("#fm").html(r.layout);

                    /* 输入框图标点击触发获取焦点 */
                    $('.form_commonTable,.form_commonTable1').each(function(){
                        $(this).find(".input-group-addon").unbind("click.auto").bind("click.auto",function(){
                            $(this).parent().find('input[type="text"]').trigger('focus');
                        });
                    });
                    eval(r.script);
                }else{
                    $("#fm").html(r.error);
                }
            }
        });

        function loadScriptTag(url){
            var script = document.createElement("script");
            script.type = "text/javascript";
            script.src = url;
            document.getElementsByTagName("head")[0].appendChild(script);
        }

        function loadLinkTag(url){
            var link = document.createElement("link");
            link.type = "text/css";
            link.rel = "stylesheet";
            link.href = url;
            document.getElementsByTagName("head")[0].appendChild(link);
        }

        //附件上传完后执行
        function afterUploadEvent(){
            globalUploadNumTemp++;
        }

        //附件上传失败后执行
        function uploadError(file, reason){
        }
    </script>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id="fm" method="post" novalidate style="padding: 10px 80px;" onkeydown="if(event.keyCode==13){return event.srcElement.tagName=='TEXTAREA'?true:false;}">
    </form>
</div>

<div data-options="region:'south',border:false" style="height: 100px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="92%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="返回" id="closeForm">返回</a>
                </td>
                <td width="8%" align="right">
                </td>
            </tr>
        </table>
        <div style="height:50px;"></div>
    </div>
</div>

<div id="addUserPhotoDialog" style="overflow: auto;display: none">
    <form action="" method="post"
          id="uploadForm" enctype="multipart/form-data" style="margin-top: 20px;">
        <table width="100%" border="0">
            <tbody>
            <tr>
                <td width="10%" nowrap>选择本地图片文件</td>
                <td width="90%" align="left"><input type="file"
                                                    style="width:90%" id="photo" name="photo"></td>
            </tr>
            </tbody>
        </table>
        <input type="hidden" id="photo_eformId"
               name="photo_eformId" value="${jq}${nId}">
    </form>
</div>

<script type="text/javascript">
    var id = "123";
    var idmap = "{}";
    var session = $.parseJSON("${session}");
    document.ready = function () {
        $('#closeForm').bind('click', function () {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        });
    };

    var pageParams = {
        formData: {},
        session:session
    };
</script>
</body>
</html>
