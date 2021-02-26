<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>单位列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
    <jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/webuploader-0.1.5/dist/webuploader.css"/>
    <link rel="stylesheet" type="text/css" href="static/h5/uploader-ext/uploader-ext.css"/>

    <style type="text/css">
        .my-content-body table {
            width: 0 !important;
            margin: 0 !important;
        }
        .my-content-body table td{
			padding: 0px !important;
			height: 25px !important;
        }
        div.datagrid-cell{
			word-break:break-all !important;
			word-wrap:break-word !important;
			white-space:pre-wrap !important;
		}
    </style>

    <script type="text/javascript" src="static/h5/webuploader-0.1.5/dist/webuploader.js"></script>
    <script type="text/javascript" src="static/h5/uploader-ext/uploader-ext.js"></script>
    <script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
    <script type="text/javascript" src="avicit/platform6/autocode/js/AutoCodeIe.js"></script>
    <script src="avicit/platform6/eform/formdefine/js/eformValidate.js"></script>
    <script src="static/js/platform/component/common/CommonDialog.js"></script>
    <script src="avicit/platform6/eform/formdefine/js/eformCustomDialog.js"></script>
    <script src="avicit/platform6/eform/formdefine/js/eformUpload.js" type="text/javascript"></script>
    <script src="static/js/platform/eform/common.js" type="text/javascript"></script>
    <script src="static/js/platform/component/common/editDatagridExpend.js"	type="text/javascript"></script>
    <!-- 富文本的js与css -->
	<script src="static/h5/kindeditor/kindeditor-all-min.js"></script>
	<link rel="stylesheet" href="static/h5/kindeditor/themes/default/default.css" />
	<script src="static/h5/kindeditor/lang/zh-CN.js"></script> 
    
<script type="text/javascript">
    var globalUploadNumTemp = 0;
    var evalg = eval;
$.ajax({
	 url:'platform/eform/bpmsClient/preview.json',
	 data : {tableContent: parent.showContent,forminfoId:parent.formEditor.eformFormInfoId,style:parent.eformInfoStyle},
	 type : 'post',
	 dataType : 'json',
	 success : function(r){
		if(r.flag == "success"){
			if (parent.tinymceContentStyle){
				loadLinkTag( "avicit/platform6/eform/formdesign/css/tinymce-content/"+parent.tinymceContentStyle+".css");
			}
			$("#fm").html(r.layout);
            $.parser.parse($("#fm"));
            // loadScriptTag("static/js/platform/component/jQuery/jquery-easyui-1.3.5/jquery.easyui.min.js");
			eval(r.script);
			evalg(r.subscript);
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
	<form id="fm" method="post" novalidate style="padding: 10px 80px;"  onkeydown="if(event.keyCode==13){return event.srcElement.tagName=='TEXTAREA'?true:false;}">
	</form>
</div>

<div data-options="region:'south',border:false" style="height:100px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend ">
        <table class="tableForm" border="0" cellspacing="1" width='100%'>
            <tr >
                <td width="92%" align="right">
                    <a title="返回" id="returnButton" class="easyui-linkbutton" href="javascript:void(0);">返回</a>
                </td>
                 <td width="8%" align="right">
                </td>
        </table>
        <div style="height:50px;"></div>
</div>

<script type="text/javascript">
    function formateDate(value){
        if(value){
            return new Date(value).format("yyyy-MM-dd");
        }
        return '';
    }
    function formateDateTime(value){
        if(value){
            return new Date(value).format("yyyy-MM-dd hh:mm:ss");
        }
        return '';
    }

    var id = "123";
    var idmap = "{}";
    var session = $.parseJSON("${session}");
    document.ready = function () {
        $('#returnButton').bind('click', function () {
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
