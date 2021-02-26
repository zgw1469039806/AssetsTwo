<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
  <title>数据库设置</title>
  <base href="<%=ViewUtil.getRequestPath(request)%>">
  <jsp:include
          page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs" />
  </jsp:include>
</head>
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
                               class="form-control input-sm " type="text" value="${mdaDatabasecrawlconfigDTO.serverip }" name="dbServerIP" />
        </td>
      </tr>
      <tr class='noAccess_CLASS'>
        <th width="10%"><label for="name"><i class="required">*</i>远程服务器port:</label></th>
        <td width="39%">
        	<input id="dbServerPort_id" title="远程服务器port:"
                               class="form-control input-sm " value="${mdaDatabasecrawlconfigDTO.serverport }" type="text" name="dbServerPort" id="name" />
        </td>
      </tr>
        <tr >
        <th width="10%"><label for="name"><i class="required">*</i>数据库实例名:</label>
        </th>
        <td width="39%">
        	<input id="dbServerName_id" title="数据库名:"
                               class="form-control input-sm " value="${mdaDatabasecrawlconfigDTO.servername }" type="text" name="dbServerName"  />
        </td>
      </tr>
      <tr class='noAccess_CLASS'>
        <th width="10%"><label for="name"><i class="required">*</i>数据库用户名:</label></th>
        <td width="39%">
        	<input id="dbUserName_id" title="数据库用户名:"
                               class="form-control input-sm " type="text" value="${mdaDatabasecrawlconfigDTO.loginuser }"  name="dbUserName"  />
        </td>
      </tr>
      <tr class='noAccess_CLASS'>
        <th width="10%"><label for="name"><i class="required">*</i>数据库密码:</label></th>
        <td width="39%">
        	<input id="dbUserPWD_id" title="数据库密码:"
                               class="form-control input-sm " type="text" value="${mdaDatabasecrawlconfigDTO.loginpassword }" name="dbUserPWD"  />
         <a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="测试连接" id="test_connection" >测试连接</a>
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
        <a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm " role="button" title="测试sql" id="test_SQL" >测试sql</a>
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
                               class="form-control input-sm " value="${mdaDatabasecrawlconfigDTO.updatemode }" type="text" name="dbTimeStamp"  />
        </td>
      </tr>
<!--        <tr > -->
<!-- 	        <th width="10%"  ><label for="name" id="field_name_id" style="display:none">请选择索引字段:</label></th> -->
<!-- 	        <td width="39%"  > -->
<!-- 	        <input type="hidden" name="dbFields" id="dbFields_id"/> -->
<!-- 	        	<table> -->
<!-- 	        		<tr id="fields_id" > -->
<!-- 	        		</tr> -->
<!-- 	        	</table> -->
<!-- 	        </td> -->
<!--        </tr> -->
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
    <table class="tableForm"
           style="border: 0; cellspacing: 1; width: 100%">
      <tr>
        <td width="50%" style="padding-right: 4%;" align="right"><a
                href="javascript:void(0)"
                class="btn btn-primary form-tool-btn btn-sm" role="button"
                title="下一步" id="mdaCrawlitems_saveForm" >下一步</a></td>
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
});
//刷新当前页面
function refresh(){
	   window.location.reload();
	}  
var layerDB,layerDOC,layerSolr;
//关闭弹窗
function closeLayer(){
	 layer.close(layerDB); 
	 layer.close(layerDOC); 
	 layer.close(layerSolr); 
}
//中间文件存入数据库配置
function filesToDB(){
	var id = $('#itemId_id').val();
	//弹窗
	layerDB = layer.open({
	    type: 2,
	    area: ['50%', '74%'],
	    title: '设置',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform/platform6/mda/mdadatasource/mdaDatasourceController/toSetFieldSavePath/db/'+id 
	});
} 
//中间文件存为JSON中间文件
function filesToDOC(){
	var id = $('#itemId_id').val();
	//弹窗
	layerDOC = layer.open({
	    type: 2,
	    area: ['50%', '70%'],
	    title: '设置',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform/platform6/mda/mdadatasource/mdaDatasourceController/toSetFieldSavePath/dbdoc/'+id 
	});
} 
//中间文件存入数据库配置
function filesToSolr(){
	var id = $('#itemId_id').val();
	//弹窗
	layerSolr = layer.open({
	    type: 2,
	    area: ['50%', '70%'],
	    title: '设置',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform/platform6/mda/mdadatasource/mdaDatasourceController/toSetFieldSavePath/solr/'+id 
	});
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
	// var s = $('#dbType_id').val();
	//alert("========="+s);
}
	
	
//选择数据库类型
function selectDBType(){
	 var dbtypes = $('.dbType_class input:checked');
	 
	 var dbtype = '';
	 dbtypes.each(function (i) {
		// dbtype = dbtypes.eq(i).attr("dbtype");//属性值
		 dbtype = dbtypes.eq(i).val();
      });
	//alert(dbtype);
	 $('#dbType_id').val(dbtype);
	// var s = $('#dbType_id').val();
	//alert("========="+s);
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
	 /* var jsondata = {
			"loginuser":loginuser,
			"loginpassword":loginpassword,
			"databasetype":databasetype,
			"serverip":serverip,
			"serverport":serverport,
			"databasename":databasename
	} */
	 var dbType = $('#dbType_id').val();
	 if(dbType == 'mysql' ||dbType == 'oracle'||dbType == 'sqlserver' ){
		 if(loginuser == ''){
			 layer.alert('请填写数据库用户名！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				});
			 return false;
		 }
		 if(loginpassword == ''){
			 layer.alert('请填写数据库登录密码！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				});
			 return false;
		 }
		}
	 if(databasetype == ''){
		 layer.alert('请填写数据库类型！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			});
		 return false;
	 }
	 if(serverip == ''){
		 layer.alert('请填写数据库IP！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			});
		 return false;
	 }
	 if(dbType == 'mysql' ||dbType == 'oracle'||dbType == 'sqlserver' ){
		 if(serverport == ''){
			 layer.alert('请填写数据库端口！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				});
			 return false;
		 }
	 }
	 if(databasename == ''){
		 layer.alert('请填写数据库名称！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			});
		 return false;
	 }
	 //校验通过
	 return true;
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
    	      url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/crawl/testconnection/crawlDB",
    	      data : _data,
    	      type : 'post',
    	      success : function(data){
				 layer.msg(data.desc);
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
    		 layer.alert('请填写数据库查询语句！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				});
    		 return false;
    	 }
    	 
    	 var form=$("#form");
   	     var _data=serializeObject(form);
    	    $.ajax({
    	      url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/crawl/testsql",
    	      data : _data,
    	      type : 'post',
    	      success : function(data){
    	    	  console.log(data);
				 layer.msg(data.desc);
				 
// 				 $('#field_name_id').css("display","block");
// 				//该list,是后台查询出来的当前字段的集合是JOSN对象数组
// 				 //var list = eval('('+data.data+')');
// 				list = data.data;
// 				 console.log(list);
// 				 //开始拼串
// 				//获取当前DOM对象，准备进行JS动态拼接生成HTML fields_id
//                  var tr =  $("#fields_id");
//                  //var TR =  $("#fields_tr_id");
//                  //清除当前节点下的所有子节点
//                    $("td").remove(".fields_class");
//                 //HTML拼接起点
//                  var str = '';
//                  //迭代开始
// 	               $.each(list,function(i,field){
// 	            	  str+='<td class="fields_class">';
// 	                  str+='<input  title="'+field+'" value="'+field+'" type="checkbox" checked="checked"  />'+field+" ";
// 	                  str+='</td>';
// 	               });
//     	         tr.after(str);
//     	       //  $("#fields_tr_id").css('display','block');
//     	       //拼串保存
//     	        selectDBFieldToSolrIndex();
			 }
		 });
    	    
    	 }
      });
 </script>
<script type="text/javascript">
  function closeForm() {
    parent.mdaCrawlitems.closeDialog("insert");
  }

function saveForm() {
	  selectSaveType();
	  selectDBFieldToSolrIndex();
    var form=$("#form");
    var _data=serializeObject(form);

    $.ajax({
      url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/saveSet/db",
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
//=============保存Access数据库=============
function saveAccessForm() {
	  selectSaveType();
	  selectDBFieldToSolrIndex();
    var form=$("#form");
    var _data=serializeObject(form);

    $.ajax({
      url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/saveSet/db",
      data : _data,
      type : 'post',
      success : function(r){
    	//字符串拆分,获取ID
		 var arr = new Array();
		 arr = r.split(":");
	        if (arr[0]  == "success"){
	          //parent.openc(3);
	          //parent.openNext('db',arr[1]);
	          layer.msg('保存成功！');
	          parent.closWinc();
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
  $(document).ready(function() {
            $('.date-picker').datepicker();
            $('.time-picker').datetimepicker({
                      oneLine : true,//单行显示时分秒
                      closeText : '确定',//关闭按钮文案
                      showButtonPanel : true,//是否展示功能按钮面板
                      showSecond : false,//是否可以选择秒，默认否
                      beforeShow : function(selectedDate) {
	                        if ($('#' + selectedDate.id).val() == "") {
	                          $(this).datetimepicker("setDate",new Date());
	                          $('#' + selectedDate.id).val('');
	                        }
                      }
             });
            parent.mdaCrawlitems.formValidate($('#form'));
            //保存按钮绑定事件
            $('#mdaCrawlitems_saveForm').bind('click',function() {
            	//====选择数据库类型==========
	            	 selectDBType();
	            	/*  var dbType = $('#dbType_id').val();
	        		 if(dbType == 'access'){
	        			 saveAccessForm();
	        		 }else{
		            	 if(checkForm()){
			                  saveForm();
		            	 }
	        		 } */
	        		 //TODO 还需要对配置信息做测试===========
	            	 //如果校验通过再执行
	            	 if(checkForm()){
	            	 //数据库查询语句
	            	 var selectsql = $("#dbSelectSQL_id").val();
	            	 if(selectsql == ''){
	            		 layer.alert('请填写数据库查询语句！', {
	        				  icon: 7,
	        				  area: ['400px', ''], //宽高
	        				  closeBtn: 0
	        				});
	            		 return false;
	            	 }
	            	 var form=$("#form");
	           	     var _data=serializeObject(form);
	            	    $.ajax({
	            	      url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/crawl/testsql",
	            	      data : _data,
	            	      type : 'post',
	            	      success : function(data){
	            	    	  console.log(data);
	            	    	  //========测试通过======
	            	    	  if(data.code =='OK'){
	            	    		  saveForm();
	            	    	  }else{
	        					 layer.msg('请检查数据库配置信息！');
	            	    	  }
	        				 
	        			 }
	        		    });
	            	    
	            	 }
	        			 
	        		//=========非空校验=======
		            	// if(checkForm()){
			             //     saveForm();
		            	// }
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
            $('.date-picker').on('keydown', nullInput);
            $('.time-picker').on('keydown', nullInput);
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
            $('#classifyidsAlias').focus(
                    function() {
                      $("#crawlitem_classify").css(
                              "display", "block");
                      $.ajax({
                                url : "platform6/mda/mdadatasource/mdaDatasourceController/getZtree",
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
</body>
</html>