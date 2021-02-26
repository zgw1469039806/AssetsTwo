<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "mdaDatasourceEasyUIController/operation/sub/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<script type="text/javascript">
	//access数据库
	function selectAccessType(){
		selectDBType();
		 var dbType = $('#dbType_id').val();
		 if(dbType == 'access'){
				$('.noAccess_CLASS').hide();
				$('.Access_CLASS').show();
			}
		if(dbType == 'mysql' ||dbType == 'oracle'||dbType == 'sqlserver' ){
				$('.Access_CLASS').hide();
				$('.noAccess_CLASS').show();
			}
		}
	//选择更新类型
	function selectUpdateType(){
		var dbUpdateType = $('#dbUpdateType_id').val();
		 //=========全量==========
		if(dbUpdateType == 'all'){
			 //======隐藏增量时间戳=========
				$('.dbTimeStamp_class').hide();
			 //======清空增量时间戳=========
				$('#dbTimeStamp_id').val('');
		}
		if(dbUpdateType == 'add'){
				$('.dbTimeStamp_class').show();
			}
	}
	
	$(function() {
		var dbUpdateType = $('#dbUpdateType_id').val();
		 //=========全量==========
		 if(dbUpdateType == 'all'){
			 //======隐藏增量时间戳=========
				$('.dbTimeStamp_class').hide();
			    //======清空增量时间戳=========
				$('#dbTimeStamp_id').val('');
		 }
		 if(dbUpdateType == 'add'){
				$('.dbTimeStamp_class').show();
		 }
		 var saveType = "${mdaDatabasecrawlconfigDTO.storemethod}";
		 var saveTypeArr = saveType.split(",");
		 for(var i=0;i<saveTypeArr.length;i++){
			  if(saveTypeArr[i]== 'db'){
				  $('#saveToDB_id').attr("checked","checked");
			  }else if(saveTypeArr[i]== 'doc'){
				  $('#saveToJSON_id').attr("checked","checked");
			  }
		  }
		  selectDBType();
		  var dbType = $('#dbType_id').val();
		  if(dbType == 'access'){
				$('.noAccess_CLASS').hide();
				$('.Access_CLASS').show();
		  }
		  if(dbType == 'mysql' ||dbType == 'oracle'||dbType == 'sqlserver' ){
				$('.Access_CLASS').hide();
				$('.noAccess_CLASS').show();
		  }
		  //测试连接按钮绑定事件
		     $('#test_connection').bind('click',
		             function() {
		    	 selectDBType();
		    	 //如果校验通过再执行
		    	 if(checkForm()){
		    	 var form=$("#form");
		   	     var _data=serializeObject(form);
		    	    $.ajax({
		    	      url:"platform/mdaDatasourceEasyUIController/operation/crawl/testconnection/crawlDB",
		    	      data : _data,
		    	      type : 'post',
		    	      success : function(data){
						 $.messager.show({
								title : '提示',
								msg : data.desc,
								timeout : 3000,
								showType : 'slide'
							});
					 }
					});
		    	 }
		     });
		   //测试SQL按钮绑定事件
		     $('#test_SQL').bind('click',
		             function() {
		    	 selectDBType();
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
		    	      url:"platform/mdaDatasourceEasyUIController/operation/crawl/testsql",
		    	      data : _data,
		    	      type : 'post',
		    	      success : function(data){
		    	    	  console.log(data);
						 $.messager.show({
								title : '提示',
								msg : data.desc,
								timeout : 3000,
								showType : 'slide'
							});
					 }
				 });
		    	    
		    	 }
		      });
	});
	//刷新当前页面
	function refresh(){
		   window.location.reload();
	}  
	var layerDB,layerDOC,layerSolr;
	//关闭弹窗
	function closeLayer(){
		 layerDB.dialog('close', true);
		 layerDOC.dialog('close', true);
		 layerSolr.dialog('close', true);
	}
	//中间文件存入数据库配置
	function filesToDB(){
		var id = $('#itemId_id').val();
		//弹窗
		layerDB = new CommonDialog("insert", "700", "400", 'platform/mdaDatasourceEasyUIController/toSetFieldSavePath/db/'+id, "设置", false, true, false);
		layerDB.show();
	} 
	//中间文件存为JSON中间文件
	function filesToDOC(){
		var id = $('#itemId_id').val();
		//弹窗
		layerDOC = new CommonDialog("insert", "700", "400", 'platform/mdaDatasourceEasyUIController/toSetFieldSavePath/dbdoc/'+id, "设置", false, true, false);
		layerDOC.show();
	} 
	//中间文件存入数据库配置
	function filesToSolr(){
		var id = $('#itemId_id').val();
		//弹窗
		layerSolr = new CommonDialog("insert", "700", "400", 'platform/mdaDatasourceEasyUIController/toSetFieldSavePath/solr/'+id, "设置", false, true, false);
		layerSolr.show();
	} 
	//选择中间文件存储类型
	function selectSaveType(){
		 var savetypes = $('.saveType_class input:checked');
		 var savetypeArr = [];
		 savetypes.each(function (i) {
			 var  savetype = savetypes.eq(i).val();
			//放进数组里
			 savetypeArr.push(savetype);
	      });
		//alert(dbtype);
		 $('#saveType_id').val(savetypeArr.toString());
	}
	function closWinDB(){
		layerDB.close();
	}
	function closWinDOC(){
		layerDOC.close();
	}
		
	//选择数据库类型
	function selectDBType(){
		 var dbtypes = $('.dbType_class input:checked');
		 
		 var dbtype = '';
		 dbtypes.each(function (i) {
			 dbtype = dbtypes.eq(i).val();
	      });
		 $('#dbType_id').val(dbtype);
	}
	//选择数据库当前爬取所需的字段为索引字段
	function selectDBFieldToSolrIndex(){
		//所有的数据库字段
		var DBFields = $('.field_class input:checked');
		//零时容器
		 var DBFieldArr  = [];
		 DBFields.each(function (i) {
			 //获取每一个数据库字段
			var DBField = DBFields.eq(i).val();
			//放进数组里
			 DBFieldArr.push(DBField);
	     });
		//alert("----------"+DBFieldArr.toString());
		 //将值放入表单
		 $('#dbFields_id').val(DBFieldArr.toString());
	//	 alert("==="+ $('#dbFields_id').val());
		
	}
	//表单校验
	function checkForm(){
		//登录用户
		 var loginuser = $("#dbUserName_id").val();
		 //登录密码
		 var loginpassword = $("#dbUserPWD_id").val();
		 //数据库类型
		 var databasetype = $("#dbType_id").val();
		 //数据库IP
		 var serverip = $("#dbServerIP_id").val();
		 //数据库端口
		 var serverport = $("#dbServerPort_id").val();
		 //数据库名称
		 var databasename = $("#dbServerName_id").val();
		 var dbType = $('#dbType_id').val();
		 if(dbType == 'mysql' ||dbType == 'oracle'||dbType == 'sqlserver' ){
			 if(loginuser == ''){
				 $.messager.alert('提示','请填写数据库用户名！','info');
				 return false;
			 }
			 if(loginpassword == ''){
				 $.messager.alert('提示','请填写数据库登录密码！','info');
				 return false;
			 }
			}
		 if(databasetype == ''){
			 $.messager.alert('提示','请填写数据库类型！','info');
			 return false;
		 }
		 if(serverip == ''){
			 $.messager.alert('提示','请填写数据库IP！','info');
			 return false;
		 }
		 if(dbType == 'mysql' ||dbType == 'oracle'||dbType == 'sqlserver' ){
			 if(serverport == ''){
				 $.messager.alert('提示','请填写数据库端口！','info');
				 return false;
			 }
		 }
		 if(databasename == ''){
			 $.messager.alert('提示','请填写数据库名称！','info');
			 return false;
		 }
		 //校验通过
		 return true;
	}
	
	
    
     function closeForm() {
    	    parent.mdaCrawlitems.closeDialog("insert");
     }
	
   	function saveForm() {
   		  selectSaveType();
   		  selectDBFieldToSolrIndex();
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
   		          //parent.openc(3);
   		          parent.openNext('db',arr[1]);
   		          //parent.closWinc();
   		       $.messager.show({
					title : '提示',
					msg : '保存成功！',
					timeout : 3000,
					showType : 'slide'
				});
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
   	//=============保存Access数据库=============
   	function saveAccessForm() {
   		  selectSaveType();
   		  selectDBFieldToSolrIndex();
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
	   		       $.messager.show({
						title : '提示',
						msg : '保存成功！',
						timeout : 3000,
						showType : 'slide'
					});
   		          parent.closWinc();
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
   	$(document).ready(function() {
           //保存按钮绑定事件
           $('#mdaCrawlitems_saveForm').bind('click',function() {
            	 selectDBType();
            	 if(checkForm()){
	                  saveForm();
            	 }
           });
           //返回按钮绑定事件
           $('#mdaCrawlitems_closeForm').bind('click',function() {
                     closeForm();
           });
           $('#lastcrawluseridAlias').on('focus', function(e) {
              new H5CommonSelect({
                type : 'userSelect',
                idFiled : 'lastcrawluserid',
                textFiled : 'lastcrawluseridAlias'
              });
              this.blur();
           });
           var setting = {
             data : {
               simpleData : {
                 enable : true,
               }
             },
             callback : {
               onClick : zTreeOnClick
             }
           };
           $('#classifyidsAlias').focus(function() {
                   $("#crawlitem_classify").css("display", "block");
                   $.ajax({
                            url : "mdaDatasourceEasyUIController/getZtree",
                            type : "POST",
                            success : function(retVal) {
                              $.fn.zTree.init(
                                   $("#crawlitem_classify"),
                                   setting,
                                   retVal);
                            }
                  });
            });
           function zTreeOnClick(event, treeId, treeNode) {
              var treeObj = $.fn.zTree.getZTreeObj("crawlitem_classify");
              /* 单击展开节点 */
              treeObj.expandNode(treeNode);
              var sNodes = treeObj.getSelectedNodes();
              if (sNodes.length > 0) {
                	var isParent = sNodes[0].isParent;
	                if (isParent == false) {
	                  $("#classifyidsAlias").val(treeNode.name)
	                  $("#crawlitem_classify").css("display","none");
	                }
              }
           };
   	});
</script>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="sourceId" value="${id}"/>
    <input type="hidden" id="itemId_id" name="itemId" value="${id}"/>
    <input type="hidden" name="type" value="db"/>
    <table class="form_commonTable">
     <tr>
        <th width="10%"><label for="name"><i class="required">*</i>采集数据库类型:</label></th>
        <td width="39%">
         <input type="hidden" name="dbType" id="dbType_id"/>
        	<span class="dbType_class">
        		<input onchange="selectAccessType();" type="radio" name="Type"  value="mysql"  <c:if test="${mdaDatabasecrawlconfigDTO.dbtype == 'mysql' }">checked="checked"</c:if>   >mysql
			</span> 
			<span class="dbType_class">&nbsp;&nbsp;&nbsp;
				<input onchange="selectAccessType();" type="radio" name="Type"  value="oracle"  <c:if test="${mdaDatabasecrawlconfigDTO.dbtype == 'oracle'  }">checked="checked"</c:if> >oracle
			</span>
          	<span class="dbType_class">&nbsp;&nbsp;&nbsp;
          		<input onchange="selectAccessType();" type="radio" name="Type" value="sqlserver" <c:if test="${mdaDatabasecrawlconfigDTO.dbtype == 'sqlserver'  }">checked="checked"</c:if>  >sqlserver
 		   </span>
          	<span class="dbType_class">&nbsp;&nbsp;&nbsp;
          		<input onchange="selectAccessType();" type="radio" name="Type" value="access" <c:if test="${mdaDatabasecrawlconfigDTO.dbtype == 'access'  }">checked="checked"</c:if>  >access
 		   </span>
        </td>
        <tr>
        <th width="10%">
        <label  for="name"><i class="required">*</i>远程服务器IP地址:</label>
        </th>
        <td width="39%">
        	<input id="dbServerIP_id" title="远程服务器IP地址:"
                   class="inputbox easyui-validatebox" type="text" value="${mdaDatabasecrawlconfigDTO.serverip }" name="dbServerIP" />
        </td>
      </tr>
      <tr class='noAccess_CLASS'>
        <th width="12%"><label for="name"><i class="required">*</i>远程服务器port:</label></th>
        <td width="37%">
        	<input id="dbServerPort_id" title="远程服务器port:"
                               class="inputbox easyui-validatebox" value="${mdaDatabasecrawlconfigDTO.serverport }" type="text" name="dbServerPort" id="name" />
        </td>
      </tr>
        <tr >
        <th width="10%"><label for="name"><i class="required">*</i>数据库实例名:</label>
        </th>
        <td width="39%">
        	<input id="dbServerName_id" title="数据库名:"
                               class="inputbox easyui-validatebox" value="${mdaDatabasecrawlconfigDTO.servername }" type="text" name="dbServerName"  />
        </td>
      </tr>
      <tr class='noAccess_CLASS'>
        <th width="10%"><label for="name"><i class="required">*</i>数据库用户名:</label></th>
        <td width="39%">
        	<input id="dbUserName_id" title="数据库用户名:"
                               class="inputbox easyui-validatebox" type="text" value="${mdaDatabasecrawlconfigDTO.loginuser }"  name="dbUserName"  />
        </td>
      </tr>
      <tr class='noAccess_CLASS'>
        <th width="10%"><label for="name"><i class="required">*</i>数据库密码:</label></th>
        <td width="39%">
        	<input id="dbUserPWD_id" title="数据库密码:"
                               class="inputbox easyui-validatebox" type="text" value="${mdaDatabasecrawlconfigDTO.loginpassword }" name="dbUserPWD"  />
         <a href="javascript:void(0)" class="easyui-linkbutton primary-btn" role="button" title="测试连接" id="test_connection" >测试连接</a>
        </td>
      </tr>
<!--       <tr> -->
<!--         <th width="10%"><label for="name">URL:</label></th> -->
<!--         <td width="39%"> -->
<%--         	<input title="URL:" class="form-control input-sm" value="${mdaDatabasecrawlconfigDTO.dburl }" type="text"  name="dbURL"  /> --%>
<!--         </td> -->
<!--       </tr> -->
      <tr>
        <th width="10%"><label for="name"><i class="required">*</i>采集 select sql:</label></th>
        <td colspan="2">
          <textarea  id="dbSelectSQL_id" rows="3" name="dbSelectSQL" cols="100" style="color: #BEBEBE;" id="textarea2" ><c:if test="${!empty mdaDatabasecrawlconfigDTO.selectsql }">${mdaDatabasecrawlconfigDTO.selectsql}</c:if></textarea>
        <a href="javascript:void(0)" class="easyui-linkbutton primary-btn" role="button" title="测试sql" id="test_SQL" >测试sql</a>
        </td>
      </tr>
       <tr>
        <th width="10%"><label for="name"><i class="required">*</i>更新方式:</label></th>
        <td width="10%" colspan="3">
       <!--  <input type="hidden" name="dbUpdateType" value="1" id="dbUpdateType_id"/> -->
	        <select id="dbUpdateType_id"  onchange="selectUpdateType();"  style="width: 80px; height: 35px; min-height: 35px;" >
		          <option value="all" <c:if test="${empty mdaDatabasecrawlconfigDTO.updatemode }">selected="selected"</c:if>>全量更新</option>
		          <option value="add" <c:if test="${!empty mdaDatabasecrawlconfigDTO.updatemode }">selected="selected"</c:if>>增量更新</option>
	        </select>
        </td>
      </tr>
      <tr class="dbTimeStamp_class">
        <td width="49%"  colspan="2">
        	<font color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;该字段为日期类型，例如：LAST_UPDATE_DATE 对应value格式：2017-11-01 16:39:48(2017-11-01 亦可)</font>
        </td>
      </tr>
      <tr class="dbTimeStamp_class">
        <th width="10%"><label for="name">请配置增量字段:</label></th>
        <td width="39%">
        	
        	<input id="dbTimeStamp_id" title="请配置增量字段"
                               class="inputbox easyui-validatebox" value="${mdaDatabasecrawlconfigDTO.updatemode }" type="text" name="dbTimeStamp"  />
        </td>
      </tr>
        <tr>
        <th width="10%"><label for="name"><i class="required">*</i>中间文件存储方式:</label></th>
        <td width="10%" colspan="3">
              <input type="hidden" name="saveType" id="saveType_id"/>
        	<span class="saveType_class">
        		<input id="saveToDB_id" type="checkbox" value="db"  >
        		<a href="javascript:void(0)"  onclick="filesToDB();">数据库</a>
			</span> 
			<span class="saveType_class">&nbsp;&nbsp;&nbsp;
				<input id="saveToJSON_id" type="checkbox"  value="doc" >
				<a href="javascript:void(0)" onclick="filesToDOC();">Json文档</a>
			</span>
          <%-- 	<span>&nbsp;&nbsp;&nbsp;
          		<input type="checkbox" value="3" <c:if test="${bean.savetype eq 3 }">checked="checked"</c:if> name='radio' >
          		<a href="javascript:void(0)" onclick="filesToSolr();">存到索引库</a>
 		   </span> --%>
        </td>
      </tr>
      <tr>
        <th width="10%"><label for="classifyids"></label></th>
        <td width="39%">
          <div>
            <ul id="crawlitem_classify" class="ztree"></ul>
          </div>
        </td>
        <th width="10%"><label for="status"></label></th>
        <td></td>

      </tr>
    </table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="下一步" id="mdaCrawlitems_saveForm"
						class="easyui-linkbutton primary-btn">下一步</a> </td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>