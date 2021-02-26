<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<% 
String importlibs = "common,table,form";	
%>
<%
String datatime = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
String datetime = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); 
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/mda/mdacollections/mdaCollectionsController/operation/Add/null" -->
<title>加载Json中间文件</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<%-- <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include> --%>

<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/sfn/SelfDefiningQuery.js"
	type="text/javascript"></script>
<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
			<table class="form_commonTable" style="width: 98%;">
				<tr>
					<th width="40%">
						选择中间文件类型：
					</th>
					 <td>
						<select onchange="selectDataType();" id = 'DataType_id'  style="width: 170px; height: 35px; min-height: 35px;">
	                        <option value="JsonData" selected="selected">Json文档</option>
							<option value="DBData" >数据库</option>
						</select>
					 </td>
				</tr>
	 <form id='dbform' >
				<tr  class="DBData_class">
					<th width="20%">
						配置数据库信息：
					</th>
					 <td>
<table class="form_commonTable">
<tr>
  		 <th width="10%"><label for="name">数据库类型：</label></th>
  			<td width="39%">
	  			<input type="hidden" name="dbDatabasetype" id="dbDatabasetype_id"/>
				<span class="dbType_class">
					<input type="radio" name="Type"  value="oracle"  checked="checked" >oracle
				</span>
	        	<span class="dbType_class">&nbsp;&nbsp;&nbsp;
	        		<input type="radio" name="Type"  value="mysql"  >mysql
				</span> 
	          	<span class="dbType_class">&nbsp;&nbsp;&nbsp;
	          		<input type="radio" name="Type" value="sqlserver"   >sqlserver
	 		   </span>
  			</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据库IP地址：</label></th>
  			<td width="39%">
  				<input id="dbIP_id" title="数据库IP地址:"
                               class="form-control input-sm" type="text" value="" name="dbIP" />
        	</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据库端口：</label></th>
  			<td width="39%">
  				<input id="dbPort_id" title="数据库端口:"
                               class="form-control input-sm" value="" type="text" name="dbPort" id="name" />
        	</td>
  		</tr>
  		<tr>
  		 <th width="12%"><label for="name">数据库实例名称：</label></th>
  			<td width="39%">
  				<input id="dbName_id" title="数据库名:"
                               class="form-control input-sm" value="" type="text" name="dbName"  />
  			</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据表名：</label></th>
  			<td width="39%">
  				<input id="dbTableName_id" title="数据表名:"
                               class="form-control input-sm" value="" type="text" name="dbTableName"  />
  			</td>
  		</tr>
  		
  		<tr>
  		    <th width="10%"><label for="name">数据库用户名：</label></th>
  			<td width="39%">
  			<input id="dbUsername_id" title="用户名:"
                               class="form-control input-sm" type="text" value=""  name="dbUsername"  />
  			</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据库密码：</label></th>
  			<td width="39%">
  			<input id="dbPrassword_id" title="用户名xpath:"
                               class="form-control input-sm" type="text" value="" name="dbPrassword"  />
  			<a href="javascript:void(0)" class="easyui-linkbutton" title="测试连接" id="test_connection" >测试连接</a>
  			</td>
  		</tr>
  		
  	
 </table>
					 </td>
				</tr>
	  </form>
	  <form id='jsonform'  action="${url}/solr/uploadJsonData" method="post"   enctype="multipart/form-data" >
				<tr  class="JsonData_class">
					<th>
						选择中间Json文件:
					</th>
					 <td>
					 	<input type="file" name="uploadFile" />
					 </td>
				</tr>
			</table>
		</form>
		<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton primary-btn" role="button" title="保存" id="mdaCollections_saveForm">开始上传</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" role="button" title="返回" id="mdaCollections_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
<%-- 	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include> --%>
	<script type="text/javascript">
	//测试连接按钮绑定事件
	$('#test_connection').bind('click',
	        function() {
		 selectDBType();
		 //如果校验通过再执行
		 if(checkForm()){
		 var form=$("#dbform");
		     var _data=serializeObject(form);
		    $.ajax({
		      url:"platform/mdaDatasourceEasyUIController/operation/crawl/testconnection/saveDB",
		      data : _data,
		      type : 'post',
		      success : function(data){
				 $.messager.show({
					 title : '提示',
					 msg : data.desc
				});
			 }
			});
		 }
	});
	//表单校验
	function checkForm(){
		//登录用户
		 var dbUsername = $("#dbUsername_id").val();
		 //登录密码
		 var dbPrassword = $("#dbPrassword_id").val();
		 //数据库类型
		 var dbDatabasetype = $("#dbDatabasetype_id").val();
		 //数据库IP
		 var dbIP = $("#dbIP_id").val();
		 //数据库端口
		 var dbPort = $("#dbPort_id").val();
		 //数据库表名
		 var dbTableName = $("#dbTableName_id").val();
		 //数据库名称
		 var dbName = $("#dbName_id").val();
		 /* var jsondata = {
				"loginuser":loginuser,
				"loginpassword":loginpassword,
				"databasetype":databasetype,
				"serverip":serverip,
				"serverport":serverport,
				"databasename":databasename
		} */
		 if(dbUsername == ''){
			$.messager.alert('提示','请填写数据库用户名！','warning');
			 return false;
		 }
		 if(dbPrassword == ''){
			$.messager.alert('提示','请填写数据库登录密码！','warning');
			 return false;
		 }
		 if(dbDatabasetype == ''){
			$.messager.alert('提示','请填写数据库类型！','warning');
			 return false;
		 }
		 if(dbIP == ''){
			$.messager.alert('提示','请填写数据库IP！','warning');
			 return false;
		 }
		 if(dbPort == ''){
			 $.messager.alert('提示','请填写数据库端口！','warning');
			 return false;
		 }
		 if(dbTableName == ''){
			 $.messager.alert('提示','请填写数据库表名！','warning');
			 return false;
		 }
		 if(dbName == ''){
			$.messager.alert('提示','请填写数据库名称！','warning');
			 return false;
		 }
		 //校验通过
		 return true;
	}
	//选择数据库类型
	function selectDBType(){
		 var dbtypes = $('.dbType_class input:checked');
		 var dbtype = '';
		 dbtypes.each(function (i) {
			// dbtype = dbtypes.eq(i).attr("dbtype");//属性值
			 dbtype = dbtypes.eq(i).val();
	      });
		 $('#dbDatabasetype_id').val(dbtype);
	}
	
	
	
	
	 //选择文件系统类型
	function selectDataType(){
		 var DataType = $('#DataType_id').val();
		 if(DataType == 'DBData'){
				$('.JsonData_class').hide();
				$('.DBData_class').show();
			}
			if(DataType == 'JsonData'){
				$('.DBData_class').hide();
				$('.JsonData_class').show();
			}
	}
	function closeForm(){
		parent.mdaCollections.closeDialog("#addjson");
	}

	//===============上传DB数据====================		
	//提交表单
	function saveForm() {
	    var form=$("#dbform");
	    var _data=serializeObject(form);
	    $.ajax({
	      url:"platform6/mda/mdacollections/mdaCollectionsEasyUIController/operation/solr/uploadDBData",
	      data : _data,
	      type : 'post',
	      success : function(data){
	        if (data  == "ok"){
	          $.messager.show({
					 title : '提示',
					 msg : '加载成功！'
				});
	        }else{
	          $.messager.show({
					 title : '提示',
					 msg : '加载失败！'
				});
	        }
	      }
	    });
	  }

	/* function saveJsonForm(){
		$('#hidden_frame').load(function(){
		    var text=$(this).contents().find("body").text();
		       // 根据后台返回值处理结果
		    var j=$.parseJSON(text);
		        alert('导入成功==============='+j);
		    if(j.status!=0) {
		        alert(j.msg);
		    } else {
		        alert('导入成功');
		        //location.href='BookResourceList.jsp'
		    }
		});
	} */
	
	
	
	//===============上传Json文件====================
		/* function saveForm(){
			 var form=$("#jsonform");
	   	     var _data=serializeObject(form);
		   	  $.ajax({
	    	      url:"platform6/mda/mdacollections/mdaCollectionsController/operation/solr/uploadJsonData",
	    	      data : _data,
	    	      type : 'post',
	    	      success : function(data){
	    	    	  if(data == 'ok'){
	    	     		 layer.alert('加载成功！', {
	    	 				  icon: 7,
	    	 				  area: ['400px', ''], //宽高
	    	 				  closeBtn: 0
	    	 				});
	    	     	 }else if(data == 'err'){
	    	     		 layer.alert('加载成功！', {
	    	 				  icon: 7,
	    	 				  area: ['400px', ''], //宽高
	    	 				  closeBtn: 0
	    	 				});
	    	      	}
	    	      }
			 });
		} */
	
	
	
	
		$(document).ready(function () {
			$('.DBData_class').hide();
			//保存按钮绑定事件
			$('#mdaCollections_saveForm').bind('click', function(){
				 var DataType = $('#DataType_id').val();
				 if(DataType == 'DBData'){
						saveForm();
					}
					if(DataType == 'JsonData'){
						alert('=====Json====');
						$("#jsonform").submit();
						//saveJsonForm();
					}
			}); 
			//返回按钮绑定事件
			$('#mdaCollections_closeForm').bind('click', function(){
				closeForm();
			});
		});
	</script>
</body>
</html>