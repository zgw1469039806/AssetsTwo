<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>导入用户</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">

</script>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
	  	<a id="consoleUser_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" onclick="downLoadTemplater();" href="javascript:void(0);" title="模板下载"><i class="icon icon-download"></i>模板下载</a>
		<a id="consoleUser_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" onclick="uploadExcel();" href="javascript:void(0);" title="导入"><i class="icon icon-daoru"></i>导入</a>
		<a id="consoleUser_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" onclick="showResult();" href="javascript:void(0);" title="查看导入结果"><i class="icon icon-Eye"></i>查看导入结果</a>
		
	</div>
	<form id="importExcel" style="padding-top:10px;" action="">
			<input type=hidden id="id" name ="id" value="${excelFileId}"/>
	</form>
		
<form role="form" id="uploadExcelform" style="padding-top:20px;" enctype="multipart/form-data" method="post">
  <div class="form-group">
    
   
  </div>
  <div class="form-group">
    <label for="inputfile">导入的文件</label>
    <input type="file" name="impExcelFile" id="impExcelFile">
  </div>
</form>

</div>
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
<script type="text/javascript">


	$(function(){ 
	
	
		 var uploadExcelOptions = {   
            type: 'POST',  
           	url: 'platform/excelImportController/uploadExcel/${excelFileId}',
            success:function(r){
            	canImport=true;
            	importExcel();
            	//layer.msg('上传成功');
            },    
            dataType: 'json',  
            error : function(xhr, status, err) {  
            	//layer.msg('上传成功');            
              canImport=true;
              importExcel();
            }  
        };   
        
        
        
         $("#uploadExcelform").submit(function(){   
            $(this).ajaxSubmit(uploadExcelOptions);   
            return false;   
        });  
	
	
	});
	var canImport;
	//查看导入结果
	function showResult(){
		
		showIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '查看导入结果',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform/excelImportResult/toManagernew' 
	});   
	}
	//关闭导入结果查看对话框
	function closeDataResult(){
		$("#importDataResult").dialog('close');
	}
	
	function back(){
		var f = parent&&parent.closeImportData;
		if(typeof(f)!=='undefined'){
			f();
		}
	}
	function downLoadTemplater(){
		var url = 'platform/excelImportController/templateDown?fileName=${fileName}.${ext}';
		var t = new DownLoad4URL('iframe','form',null,url);
		t.downLoad();
	}
	function importExcel(){
		if(canImport){
			
			avicAjax.ajax({
				url : '${path}',
				data : {datas : JSON.stringify(serializeObject($('#importExcel'))),extPara:'${extParam}'},
				async :true,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == "success") {
						layer.msg(result.msg);
					}else {
						var msg ='操作失败！';
						if(result.error){
							msg += '原因：'+result.error;
						}
						layer.alert('重置失败！' + r.msg,{
					  		icon: 7,
					  		area: ['400px', ''], //宽高
					  		closeBtn: 0
				    		}
		         		);
					}
				}
			});
			return;	
		}
		layer.msg('请先上传导入文件再导入！');
	}
	/*上传到服务器  */
function uploadExcel(){
    if(document.getElementById("impExcelFile").value != ''){
      if(checkfiletype('impExcelFile')){
        $('#uploadExcelform').submit();
        
    } else {
      layer.msg('请选择正确的模板文件！');
      return;
    }
  }else {
      layer.msg('请选择要上传的文件！');
      return;
}
}
	//检查上传类型
	function checkfiletype(id){
	    var fileName = document.getElementById(id).value;
	    //设置文件类型数组
	    var extArray =[".xls",".xlsx"];
	   	//获取文件名称
	   	while (fileName.indexOf("//") != -1)
	    	fileName = fileName.slice(fileName.indexOf("//") + 1);
	       	//获取文件扩展名
	       	var ext = fileName.slice(fileName.indexOf(".")).toLowerCase();
	   		//遍历文件类型
	       	var count = extArray.length;
	   		for (;count--;){
	     		if (extArray[count] == ext){ 
	       			return true;
	     		}
	   		}  
	   		
	   return false;  
	}
	
	/**
	 * 模拟ajax导出
	 * 无弹出框,post提交无参数限制
	 * @param iframeId
	 * @param formId
	 * @param headData
	 */
	 function DownLoad4URL(iframeId,formId,headData,actionUrl){
		 //设置是否显示遮罩Iframe
		 if(typeof(iframeId)!=='string'&&iframeId.trim()!==''){
			 throw new Error("iframeId不能为空！");
		 }
		 
		//设置是否显示遮罩Iframe
		if(typeof(formId)!=='string'&&formId.trim()!==''){
			throw new Error("formId不能为空！");
		}
		this.iframeName = "_iframe_" + iframeId;
		this.formName = "_form_" + formId;
		this.doc = document;//缓存全局对象，提高效率
		this.createDom.call(this,headData,actionUrl);
	};
	DownLoad4URL.prototype.downLoad=function(){
		this.doc.getElementById(this.formName).submit();
	};
	DownLoad4URL.prototype.createDom=function(headData,url){
		if(jQuery("#" + this.iframeName).length == 0){
			var exportIframe = this.doc.createElement("iframe"); 
			exportIframe.id = this.iframeName; 
			exportIframe.name = this.iframeName; 
			exportIframe.style.display = 'none'; 
			this.doc.body.appendChild(exportIframe); 
			//创建form 
			var exportForm = this.doc.createElement("form"); 
			exportForm.method = 'post'; 
			exportForm.action = url; 
			exportForm.name = this.formName; 
			exportForm.id = this.formName;
			exportForm.target = this.iframeName;
			this.doc.body.appendChild(exportForm); 
			if(headData&&typeof(headData)==='object'){
				for (var key in headData){
				 var headInput = this.doc.createElement("input"); 
				 headInput.setAttribute("name",key); 
				 headInput.setAttribute("type","text"); 
				 if(typeof(headData[key])=='string'){
					 headInput.setAttribute("value",headData[key]);
				 }else{
					 var jsonStr=JSON.stringify(headData[key]);
					 headInput.setAttribute("value",jsonStr);
				 }
				 exportForm.appendChild(headInput); 
				}
			}
		}
	};
</script>	
</html>