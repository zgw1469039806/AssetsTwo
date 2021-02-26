<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%
	String importlibs = "common,form,fileupload";
	String templateCode  = request.getParameter("templateCode");

%>
<!DOCTYPE html>
<HTML>
<head>
<!-- ControllerPath = "demo/demoreception/demoReceptionController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<style>
.input-file {
	display: inline-block;
	position: relative;
	overflow: hidden;
	text-align: center;
	width: auto;
	background-color: #2c7;
	border: solid 1px #ddd;
	border-radius: 4px;
	padding: 5px 10px;
	font-size: 12px;
	font-weight: normal;
	line-height: 18px;
	color: #fff;
	text-decoration: none;
}

.input-file input[type="file"] {
	position: absolute;
	top: 10px;
    left: 330px;
	font-size: 14px;
	background-color: #fff;
	transform: translate(-300px, 0px) scale(4);
	height: 10px;
	width: 24px;
	opacity: 0;
	filter: alpha(opacity = 0);
	z-index:200;
}
.tip{
display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    overflow: hidden;
    width: 450px;
    height: 35px;
}

#upload{
	color: #fff!important;
	margin-top: 16px;
}

#downExcelTemplate{
	margin-top: 16px;
}
</style>

<body class="easyui-layout">
	<div style="padding: 20px">
			<table width="460px" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100px"><form id="uploadform" action="platform6/imp/common/importController/importExcelData" target="uploadmsg" method="post" enctype="multipart/form-data">
						<a class="input-file input-fileup btn-point"  href="javascirpt:;" onclick="$('#uploadfile').trigger('click');return false;">
							+ 选择文件
						</a><input size="100" type="file" name="uploadfile" id="uploadfile" style="    position: absolute;
								top: 20px;
								left: 20px;
								cursor: pointer;
								opacity: 0;
								width: 82.45px;
								height: 30px;
								filter: alpha(opacity:0);
								z-index: 999;
							}" >
					<input type="hidden" id="templateCode" name="templateCode" value="<%=templateCode%>">
					<input type="hidden" id="userExtdata" name="userExtdata" value="">
					</form>
					<iframe name="uploadmsg" id="uploadmsg" style="display:none"></iframe>
					</td>
					<td colspan="3" width="360px">
						<div class="showFileName1"></div>
						<div class="fileerrorTip1"></div>
					</td>
				</tr>
				<tr>
					<td colspan="4"><div class="content" style="height: 35px;"></div></td>
				</tr>
				<tr>
					<td style="width: 100px"></td>
					<td style="width: 180px"></td>
					<td style="width: 80px"><a id="upload" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
						title="导入"><i class="icon icon-daoru"></i> 导入</a></td>
					<td  style="width: 100px"><a id="downExcelTemplate" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="下载模板"><i class="glyphicon glyphicon-download"></i> 下载模板</a></td>
				</tr>
			</table>
		<div>
			<jsp:include
				page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
				<jsp:param value="<%=importlibs%>" name="importlibs" />
			</jsp:include>
			<script>
			
	var haserr = true;
	document.ready = function() {
		var templateCode="<%=templateCode%>";
		$("#downExcelTemplate").bind( 'click', function(){
			$.ajax({
				type : 'POST',
				dataType : 'JSON',
				url : 'platform6/imp/common/importController/getExcelInfo',
				data : {
					'templateCode' : templateCode
				},
				success : function(r) {
					if(r.map != null){
						if(r.map.FORMTABLE==0){
							r.map.FORMTABLE='';
						}
						//下载功能实现
						downloadFile(r.map.FILEDID,r.map.FORMID,r.map.FORMTABLE,true);
					}else{
						layer.alert('未找到模板，请检查配置！', {
							icon : 7,
							area : [ '400px', '' ],
							closeBtn : 0,
							btn : [ '关闭' ],
							title : "提示"
						});
					}
				}
			});
		});
		 //$(".input-fileup").on("change","#uploadfile",function(){
		$("#uploadfile").on("change",function(){

             var filePath=$(this).val();
             if(filePath.indexOf("xls")!=-1 || filePath.indexOf("XLS")!=-1||filePath.indexOf("xlsx")!=-1 || filePath.indexOf("XLSX")!=-1){
                 $(".fileerrorTip1").html("").hide();
                 var arr=filePath.split('\\');
                 var fileName=arr[arr.length-1];
                 $(".showFileName1").html(fileName);
                 haserr = false;
             }else{
                 $(".showFileName1").html("");
                 $(".fileerrorTip1").html("您上传文件类型有误！").show();
                 haserr = true;
                 return false
             }
         });
		var d_click = true; // 防止多次点击
		
		self.afertImport = function(data){
			var r =data;
			 if(r.flag="success"){
        		 if(r.code == "0"){
        		 	 if(r.insertNum == undefined){
						 r.insertNum = 0;
					 }

        			 if(r.errorFile){
	        			 $(".content").empty();
                         $(".content").append("<p class='tip' style='color:red' title='导入出现错误，插入"+r.insertNum+"/"+r.totalNum+"条数据'>导入出现错误，插入"+r.insertNum+"/"+r.totalNum+"条数据。<a href='platform6/imp/common/importController/downloadErrorExcelFile?fileName="+r.errorFile+"'  class='errorTip'>下载错误信息</a></p>");

					 }else{
	        			 $(".content").empty();
                         $(".content").append("<p class='tip' style='color:green' title='导入成功，共处理"+r.insertNum+"/"+r.totalNum+"条数据'>导入成功，共处理"+r.insertNum+"/"+r.totalNum+"条数据</p>");
                     }
	        		 if(typeof(parent.afterImport) == 'function'){
	        			 parent.afterImport();
	        		 } 
        		 }else{
        			 $(".content").empty();
        			 $(".content").append("<p class='tip' style='color:red' title='导入失败," + r.msg +  "'>导入失败," + r.msg + "</p>");
        		 }
        	 }
        	 d_click = true;
		}
		
		//点击上传
		$("#upload").click(function () {
			if(d_click){
				d_click = false;
				var filePath = $("#uploadfile").val();  
				if(filePath !=null && "" != filePath  && typeof(filePath) != "undefined"){
					if(haserr){
						$(".fileerrorTip1").html("您上传文件类型有误！").show();
						d_click = true;
						return false;
					}
					$("#userExtdata").val(parent.userExtdata);
					var uploadform = document.getElementById('uploadform');
					uploadform.submit();
				 }else{
					 layer.msg('请选择上传文件！');
					 d_click = true;
				 }
			 }
		});	 
	}
	function downloadFile(fileId,formId,formTable,save_type){
		window.location.href = "<%=ViewUtil.getRequestPath(request)%>/platform/swfUploadController/doDownload?fileuploadBusinessId="+formId+"&fileuploadBusinessTableName="+formTable+"&fileuploadIsSaveToDatabase="+save_type+"&encryption&fileId="+fileId;
	}
	
	
	</script>
</body>
</html>