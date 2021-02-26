<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
  <!-- ControllerPath = "platform6/mda/mdadatasource/mdaDatasourceController/operation/sub/Add/null" -->
  <title>添加</title>
  <base href="<%=ViewUtil.getRequestPath(request)%>">
  <jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
  <jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
  <script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
<!-- 表单开始 -->
  <form id='form'>
   <input type="hidden" name="sourceId" value="${id}"/>
    <input type="hidden" id="itemId_id" name="itemId" value="${id}"/>
  	<table class="form_commonTable">
  	<tr>
  		 <th width="10%"><label for="name">数据库类型：</label></th>
  			<td width="39%">
	  			<input type="hidden" name="dbDatabasetype" id="dbDatabasetype_id"/>
	        	<span class="dbType_class">
	        		<input type="radio" name="Type"  value="mysql"  <c:if test="${mdaDatabasecrawlconfigDTO.databasetype == 'mysql' }">checked="checked"</c:if>   >mysql
				</span> 
				<span class="dbType_class">&nbsp;&nbsp;&nbsp;
					<input type="radio" name="Type"  value="oracle"  <c:if test="${mdaDatabasecrawlconfigDTO.databasetype == 'oracle'  }">checked="checked"</c:if> >oracle
				</span>
	          	<span class="dbType_class">&nbsp;&nbsp;&nbsp;
	          		<input type="radio" name="Type" value="sqlserver" <c:if test="${mdaDatabasecrawlconfigDTO.databasetype == 'sqlserver'  }">checked="checked"</c:if>  >sqlserver
	 		   </span>
  			</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据库IP地址：</label></th>
  			<td width="39%">
  				<input id="dbIP_id" title="数据库IP地址:"
                               class="inputbox easyui-validatebox" type="text" value="${mdaDatabasecrawlconfigDTO.databaseip }" name="dbIP" />
        	</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据库端口：</label></th>
  			<td width="39%">
  				<input id="dbPort_id" title="数据库端口:"
                               class="inputbox easyui-validatebox" value="${mdaDatabasecrawlconfigDTO.databaseport }" type="text" name="dbPort" id="name" />
        	</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据库实例名称：</label></th>
  			<td width="39%">
  				<input id="dbName_id" title="数据库名:"
                               class="inputbox easyui-validatebox" value="${mdaDatabasecrawlconfigDTO.databasename}" type="text" name="dbName"  />
  			</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">存储表名：</label></th>
  			<td width="39%">
  				<input id="dbTableName_id" title="存储表名:"
                               class="inputbox easyui-validatebox" value="${mdaDatabasecrawlconfigDTO.tablename}" type="text" name="dbTableName"  />
  			</td>
  		</tr>
  		<tr>
  		    <th width="10%"><label for="name">数据库用户名:</label></th>
  			<td width="39%">
  			<input id="dbUsername_id" title="用户名:"
                               class="inputbox easyui-validatebox" type="text" value="${mdaDatabasecrawlconfigDTO.username }"  name="dbUsername"  />
  			</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据库密码：</label></th>
  			<td width="39%">
  			<input id="dbPrassword_id" title="用户名xpath:"
                               class="inputbox easyui-validatebox" type="text" value="${mdaDatabasecrawlconfigDTO.password }" name="dbPrassword"  />
  		 <a href="javascript:void(0)" class="easyui-linkbutton primary-btn" role="button" title="测试连接" id="test_connection" >测试连接</a>
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
          <a href="javascript:void(0)" class="easyui-linkbutton primary-btn" role="button" title="保存配置" id="mdaCrawlitems_saveForm" >保存配置</a>
        </td>
      </tr>
    </table>
  </div>
</div>

<script type="text/javascript"
        src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
<script src="avicit/platform6/mda_easyui/mdaclassify/js/MdaClassify.js"
        type="text/javascript"></script>
<script type="text/javascript">
//测试连接按钮绑定事件
$('#test_connection').bind('click',
        function() {
	 selectDBType();
	 //如果校验通过再执行
	 if(checkForm()){
	 var form=$("#form");
	     var _data=serializeObject(form);
	    $.ajax({
	      url:"platform/mdaDatasourceEasyUIController/operation/crawl/testconnection/saveDB",
	      data : _data,
	      type : 'post',
	      success : function(data){
			 $.messager.alert('提示',data.desc,'info');
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
		 $.messager.alert('提示','请填写数据库用户名！','info');
		 return false;
	 }
	 if(dbPrassword == ''){
		 $.messager.alert('提示','请填写数据库登录密码！','info');
		 return false;
	 }
	 if(dbDatabasetype == ''){
		 $.messager.alert('提示','请填写数据库类型！','info');
		 return false;
	 }
	 if(dbIP == ''){
		 $.messager.alert('提示','请填写数据库IP！','info');
		 return false;
	 }
	 if(dbPort == ''){
		 $.messager.alert('提示','请填写数据库端口！','info');
		 return false;
	 }
	 if(dbTableName == ''){
		 $.messager.alert('提示','请填写数据库表名！','info');
		 return false;
	 }
	 if(dbName == ''){
		 $.messager.alert('提示','请填写数据库名称！','info');
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
//保存按钮绑定事件
$('#mdaCrawlitems_saveForm').bind('click',
        function() {
			 selectDBType();
			//TODO 还需要对配置信息做测试===========
        	 //如果校验通过再执行
        	 if(checkForm()){
        	 //数据库查询语句
        	 var selectsql = $("#dbSelectSQL_id").val();
        	 if(selectsql == ''){
        		 $.messager.alert('提示','请填写数据库查询语句！','info');
        		 return false;
        	 }
        	 var form=$("#form");
       	     var _data=serializeObject(form);
        	    $.ajax({
        	      url:"platform/mdaDatasourceEasyUIController/operation/crawl/testconnection/saveDB",
        	      data : _data,
        	      type : 'post',
        	      success : function(data){
        	    	  console.log(data);
        	    	  //========测试通过======
        	    	  if(data.code =='OK'){
        	    		  saveForm();
        	    	  }else{
        	    		 $.messager.alert('提示','请检查数据库配置信息！','info');
        	    	  }
    				 
    			 }
    		    });
        	 }
        });
 //提交表单
function saveForm() {
    var form=$("#form");
    var _data=serializeObject(form);
    $.ajax({
      url:"platform/mdaDatasourceEasyUIController/operation/saveSet/db",
      data : _data,
      type : 'post',
      success : function(r){
    	//字符串拆分,获取ID
	 	var arr = new Array();
	 	arr = r.split(":");
        if (arr[0]  == "success"){
        	 parent.closWinDB();
        	 $.messager.alert('提示','保存成功！','info');
        }else{
        	 $.messager.show({
					title : '提示',
					msg : '保存失败！' + r.error,
					timeout : 3000,
					showType : 'slide'
				});
        }
      }
    });
  }

</script>
</body>
</html>