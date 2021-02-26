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
<jsp:param value="common,table,form,fileupload,tree" name="importlibs"/>
</jsp:include>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="common,table,form,fileupload,tree" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ui-1.9.2.custom/css/base/jquery-ui-1.9.2.custom.css"/>
    <link rel="stylesheet" type="text/css" href="static/css/platform/eform/eformcss.min.css" />
    <link rel="stylesheet" href="avicit/platform6/eform/bpmsviewdesign/css/view.css"/>
    <script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
    <script src="avicit/platform6/eform/formdefine/js/eformCustomDialog.js"></script>
    <script src="avicit/platform6/eform/formdefine/js/eformUpload.js" type="text/javascript"></script>
    <script src="avicit/platform6/autocode/js/AutoCode.js" ></script>
    <script src="static/js/platform/eform/common.js"></script>
    <script src="static/js/platform/eform/jqgridValidate.js"></script>
    <script src="static/h5/common-ext/h5-common-after.js"></script>
    <script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
    <script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
    <script src="static/h5/jqGrid-5.2.0/plugins/jquery.contextmenu.js" ></script>
<!-- 富文本的js与css -->
    <script src="static/h5/kindeditor/kindeditor-all-min.js"></script>
    <script src="static/h5/kindeditor/lang/zh-CN.js"></script>
    <script src="static/js/platform/eform/eformTab.js"></script>
    <script src="static/h5/select2/select2.js"></script>

<script type="text/javascript">
var globalUploadNumTemp = 0;
var tableName = "EFORM_TYPE";
var entryId = "";
var attachBpmInfo = {

    delOrAdd : [],
    editSecret:[]
}
$.ajax({
	 url:'platform/eform/bpmsClient/preview.json',
	 data : {tableContent: parent.showContent,forminfoId:parent.formEditor.eformFormInfoId,style:parent.eformInfoStyle},
	 type : 'post',
	 dataType : 'json',
	 success : function(r){
		if(r.flag ==  "success"){
			if (parent.tinymceContentStyle){
				loadLinkTag( "avicit/platform6/eform/formdesign/css/tinymce-content/"+parent.tinymceContentStyle+".css");
			}
			$("#fm").html(r.layout);
            if (parent.formContentJs!=""){
                $.each(parent.formContentJs.split(","),function(index,obj){ //加载自定义js
                    loadScriptTag(obj);
                })
            }
            if (parent.formContentUrlCss!=""){
            $.each(parent.formContentUrlCss.split(","),function(index,obj){ //加载自定义css
                loadLinkTag(obj);
            })

        }
			/* 输入框图标点击触发获取焦点 */
            $('.form_commonTable,.form_commonTable1').each(function(){
                $(this).find(".input-group-addon").unbind("click.auto").bind("click.auto",function(){
                    $(this).parent().find('input[type="text"]').trigger('focus');
                });
            });
            eval(r.script);
            $('.easyui-layout').layout();
            $(".eform-form-tab").each(function(){
                eformTabReload(this);
                setTabMenu(this);
            });
            setTimeout(function(){window.eformtab();},200);

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
	<form id="fm" method="post" novalidate style="padding: 10px 80px;" onkeydown="if(event.keyCode==13){return (event.srcElement.tagName=='TEXTAREA'||event.srcElement.className.indexOf('ui-pg-input')>-1)?true:false;}">
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

<div class="contextMenu" id="eform-tab-menu">
    <ul>
        <li id="eform-refresh">刷新</li>
    </ul>
</div>

<script type="text/javascript">
	var id = "123";
	var idmap = "{}";
    var filterParams={};
	var session = $.parseJSON("${session}");
    document.ready = function () {
        $('#closeForm').bind('click', function () {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        });
    };

    var pageParams = {
        formData: {},
        session:session,
        urlParam:{}
    };
</script>
</body>
</html>
