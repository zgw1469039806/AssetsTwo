<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
  String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
  <!-- ControllerPath = "platform6/mda/mdadatasource/mdaDatasourceController/operation/sub/Add/null" -->
  <title>添加</title>
  <base href="<%=ViewUtil.getRequestPath(request)%>">
  <jsp:include
          page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs" />
  </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
<!-- 表单开始 -->
  <form id='form'>
   <input type="hidden" name="sourceId" value="${id}"/>
    <input type="hidden" id="itemId_id" name="itemId" value="${id}"/>
  	<table class="form_commonTable">
  		<tr>
  		    <th width="10%"><label for="name">中间文件保存目录（不能存在中文）:</label></th>
  			<td width="39%">
  			<input id="fielPath_id" type="text" name="dbDocpath"  title="中间文件保存目录:"
                               class="form-control input-sm"  value="${empty jsonDOC.JsonPath?dfJsonDOC:jsonDOC.JsonPath}"   placeholder="例如：C:\filepath_1\filepath_2"  />
  			<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="检测路径是否存在" id="check_filepath" >检测路径是否存在</a>
  			<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="创建新路径" id="create_filepath" >创建新路径</a>
  			</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">中间文件保存名称：</label></th>
  			<td width="39%">
  			<input id="fielName_id" title="请填写中间文件保存名称:"
                               class="form-control input-sm" type="text" value="${jsonDOC.JsonName}" name="dbDocName"  />
  			</td>
  		</tr>
  	
  	</table>
  </form>
 <!-- 表单结束 -->
 
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
  <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
    <table class="tableForm" style="border: 0; cellspacing: 1; width: 100%">
      <tr>
        <td width="50%" style="padding-right: 4%;" align="right">
          <a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存配置" id="mdaCrawlitems_saveForm" >保存配置</a>
        </td>
      </tr>
    </table>
  </div>
</div>

<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
  <jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript"
        src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
<script src="avicit/platform6/mda/mdaclassify/js/MdaClassify.js"
        type="text/javascript"></script>
<script type="text/javascript">

//监测路径是否存在绑定事件
$('#check_filepath').bind('click',
        function() {
	 //如果校验通过再执行
	 var form=$("#form");
	     var _data=serializeObject(form);
	    $.ajax({
	      url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/crawl/testdocexist",
	      data : _data,
	      type : 'post',
	      success : function(data){
	    	  if(data){
	    		  layer.msg("保存路径存在，可以保存！");
	    	  }else{
	    		  layer.msg("保存路径不存在，请重新输入！");
	    	  }
			 
		 }
		});
});
//测试连接按钮绑定事件
$('#create_filepath').bind('click',
        function() {
	 //如果校验通过再执行
	 var form=$("#form");
	     var _data=serializeObject(form);
	    $.ajax({
	      url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/crawl/createJsonDir",
	      data : _data,
	      type : 'post',
	      success : function(data){
	    	  if(data){
	    		  layer.msg("创建新路径成功，可以保存！");
	    	  }else{
	    		  layer.msg("创建新路径失败，请检查操作！");
	    	  }
			 
		 }
		});
});




//表单校验
function checkForm(){
	//登录用户
	 var fielPath = $("#fielPath_id").val();
	 //登录密码
	 var fielName = $("#fielName_id").val();
	 if(fielPath == ''){
		 layer.alert('请填写文件保存路径！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			});
		 return false;
	 }
	 if(fielName == ''){
		 layer.alert('请填写文件保存名称！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			});
		 return false;
	 }
	 
	 
	 //校验通过
	 return true;
}
//保存按钮绑定事件
$('#mdaCrawlitems_saveForm').bind('click',
        function() {
			if(checkForm()){
				 var form=$("#form");
			     var _data=serializeObject(form);
			    $.ajax({
			      url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/crawl/testdocexist",
			      data : _data,
			      type : 'post',
			      success : function(data){
			    	  if(data){
			    		  layer.msg("保存路径存在，可以保存！");
			    		  saveForm();
			    	  }else{
			    		  layer.msg("保存路径不存在，请重新输入！");
			    	  }
				 }
				});
			 }
        });
 //提交表单
function saveForm() {
    var form=$("#form");
    var _data=serializeObject(form);
   // var _data={"itemId":itemId,"fielPath":fielPath,"fielName":fielName};

    $.ajax({
      url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/saveSet/db",
      data : _data,
      type : 'post',
      success : function(r){
    	//字符串拆分,获取ID
	 var arr = new Array();
	 arr = r.split(":");
        if (arr[0]  == "success"){
        	 parent.closeLayer();
          layer.msg('保存成功！');
        }else{
          layer.alert('保存失败！' + r.error,{
                    icon: 7,
                    area: ['400px', ''], //宽高
                    closeBtn: 0
                  }
          );
        }
      }
    });
  }


</script>
</body>
</html>