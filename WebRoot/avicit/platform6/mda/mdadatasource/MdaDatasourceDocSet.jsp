<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%
	String importlibs = "common,form";
%>
<% 
String datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()); 
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
		<form id='form'>
			<input type="hidden" name="sourceId" value="${id}"/> 
            <input type="hidden" id="itemId_id" name="itemId" value="${id}"/>
            <input type="hidden" id="FS_type_id" name="FS_type" value="${mdaDoccrawlconfigDTO.fstype}"/>
			<input type="hidden" name="type" value="doc"/> 
			<table class="form_commonTable">
				<tr >
					<th width="10%"><label for="name">文件系统类型:</label></th>
					<td width="10%" colspan="3">
					<select onchange="selectFSType();" id = 'docType_id' name="docType" style="width: 80px; height: 35px; min-height: 35px;">
                        <option value="ftp" <c:if test="${mdaDoccrawlconfigDTO.fstype == 'ftp' }">selected="selected"</c:if>>ftp file</option>
						<option value="local" <c:if test="${mdaDoccrawlconfigDTO.fstype == 'local' }">selected="selected"</c:if>>local file</option>
					</select>
					</td>
				</tr>
				<tr class='FTP_CLASS'>
					<th width="10%"><label for="name">文件系统地址（IP）:</label></th>
					<td width="39%"><input title="文件系统地址（IP）" id = 'docFSIP_id'
						class="form-control input-sm " type="text" value="${mdaDoccrawlconfigDTO.fsIp}"  name="docFSIP"  />
					</td>
				</tr>
				<tr class='FTP_CLASS'>
					<th width="10%"><label for="name">文件系统端口（port）:</label></th>
					<td width="39%">
					<input title="文件系统端口（port）" id = 'docPort_id'
						class="form-control input-sm " type="text" value="${mdaDoccrawlconfigDTO.docport}"  name="docPort"  />
					</td>
				</tr>
				<tr class='FTP_CLASS'>
					<th width="10%"><label for="name">用户名:</label></th>
					<td width="39%"><input title="用户名"  id = 'docUserName_id'
						class="form-control input-sm " type="text" value="${mdaDoccrawlconfigDTO.loginuser}" name="docUserName"  />
					</td>
				</tr>
				<tr class='FTP_CLASS'>
					<th width="10%"><label for="name">密码:</label></th>
					<td width="39%"><input title="登录" id = 'docUserPWD_id'
						class="form-control input-sm " type="text" value="${mdaDoccrawlconfigDTO.loginpassword}"  name="docUserPWD"  />
					<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm " role="button" title="测试FTP连接" id="test_FTP" >测试FTP连接</a>
					</td>
				</tr>
				<tr class='FTP_CLASS'>
					<th width="10%"><label for="name">FTP服务器采集路径:</label></th>
					<td colspan="2">
					
						<textarea id="docFTPAddr_id" rows="2" name="docFTPAddr" cols="100" style="color: #BEBEBE;" id="textarea1" placeholder="FTP服务器文件采集路径" ><c:if test="${!empty mdaDoccrawlconfigDTO.docaddr }">${mdaDoccrawlconfigDTO.docaddr}</c:if></textarea>
					</td>
				</tr>
				<tr class='LOCAL_CLASS'>
					<th width="10%"><label for="name">本地文件采集路径:</label></th>
					<td colspan="2">
						<textarea id="docAddr_id" rows="2" name="docAddr" cols="100" style="color: #BEBEBE;" id="textarea1" placeholder="请输入本地文件采集路径" ><c:if test="${!empty mdaDoccrawlconfigDTO.docaddr }">${mdaDoccrawlconfigDTO.docaddr}</c:if></textarea>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="name">要采集的关键词:</label></th>
					<td colspan="2">
					<textarea rows="3" name="docKeyWords" cols="100" style="color: #BEBEBE;" id="textarea3" placeholder="多个请用逗号分割" ><c:if test="${!empty mdaDoccrawlconfigDTO.keywords }">${mdaDoccrawlconfigDTO.keywords}</c:if></textarea>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="name">要过滤的关键词:</label></th>
					<td colspan="2">
						<textarea rows="3" name="docFilterWords" cols="100" style="color: #BEBEBE;" id="textarea4"  placeholder="多个请用逗号分割"><c:if test="${!empty mdaDoccrawlconfigDTO.filterwords }">${mdaDoccrawlconfigDTO.filterwords }</c:if></textarea>
					</td>
				</tr>
			  <tr>
		        <th width="10%"><label for="name">文件采集类型:</label></th>
		        <td width="39%">
		         <input type="hidden" name="docSaveType"  id="docSaveType_id"/>
		         <!-- 判断crawlfiletype是否为空 -->
		        <%--  <c:if test="${!empty mdaDoccrawlconfigDTO.crawlfiletype }">
		          <c:forEach var="docType" items="${docTypeArr}"  >
                      <span class="docSaveType_class">
		          		<c:forEach var="filetype" items="${mdaDoccrawlconfigDTO.crawlfiletype}"  >
		          		<c:if test="${filetype ==docType}">
		        			<input type="checkbox" name="Type" checked="checked" value="${docType}" >&nbsp;${docType}
		          		</c:if>
		         		</c:forEach>
		         		<c:if test="${filetype !=docType}">
		        			<input type="checkbox" name="Type"  value="${docType}" >&nbsp;${docType}
		          		</c:if>
					</span> 
		         </c:forEach>
		         <c:if test="${empty mdaDoccrawlconfigDTO.crawlfiletype }">
		         </c:if>
		         </c:if> --%>
		         <!-- 为空  -->
		          <c:if test="${empty mdaDoccrawlconfigDTO.crawlfiletype }">
		           <c:forEach var="docType" items="${docTypeArr}"  >
                      <span class="docSaveType_class">
		        		<input type="checkbox" name="Type" checked="checked" value="${docType}" >&nbsp;${docType}
					</span> 
		         </c:forEach>
		         </c:if>
		           <c:if test="${not empty mdaDoccrawlconfigDTO.crawlfiletype }">
		             <c:forEach var="docType" items="${selectedTypeArr}"  >
                      <span class="docSaveType_class">
		        		<input type="checkbox" name="Type" checked="checked" value="${docType}" >&nbsp;${docType}
					</span> 
			         </c:forEach>
			           <c:forEach var="docType" items="${unSelectedTypeArr}"  >
	                      <span class="docSaveType_class">
			        		<input type="checkbox" name="Type"  value="${docType}" >&nbsp;${docType}
						</span> 
			         </c:forEach>
		         </c:if>
		        </td>
		      </tr>
				<%-- 
				<tr>
					<th width="10%"><label for="name">采集频率:</label></th>
					
					<td width="10%" colspan="3">
					
					<select name="docRate"
						style="width: 80px; height: 35px; min-height: 35px;">
							<option value="1" <c:if test="${mdaDoccrawlconfigDTO.crawlrate eq 1 }">selected="selected"</c:if>>1</option>
							<option value="2" <c:if test="${mdaDoccrawlconfigDTO.crawlrate eq 2 }">selected="selected"</c:if>>2</option>
							<option value="3" <c:if test="${mdaDoccrawlconfigDTO.crawlrate eq 3 }">selected="selected"</c:if>>3</option>
							<option value="4" <c:if test="${mdaDoccrawlconfigDTO.crawlrate eq 4 }">selected="selected"</c:if>>4</option>
					</select> 
				<!-- 	
					<select style="width: 80px; height: 35px; min-height: 35px;">
							<option value="2">天／次</option>
					</select> -->
					&nbsp;&nbsp;&nbsp; <label for="name">采集深度:</label> 
					<select
						style="width: 80px; height: 35px; min-height: 35px;" name="docdepth">
							<option value="1" <c:if test="${mdaDoccrawlconfigDTO.crawldepth eq 1 }">selected="selected"</c:if>>1</option>
							<option value="2" <c:if test="${mdaDoccrawlconfigDTO.crawldepth eq 2 }">selected="selected"</c:if>>2</option>
							<option value="3" <c:if test="${mdaDoccrawlconfigDTO.crawldepth eq 3 }">selected="selected"</c:if>>3</option>
							<option value="4" <c:if test="${mdaDoccrawlconfigDTO.crawldepth eq 4 }">selected="selected"</c:if>>4</option>
					</select></td>

				</tr> --%>
			
				<tr>
					<th width="10%"><label for="name">时间范围:</label></th>
					<td width="10%" colspan="3">
					<span>
						<input  type="radio"  <c:if test="${empty modifytimeMap.docStartTime}">checked="checked"</c:if> name='radio' value="notime" >
							不限
					</span> 
					<span class="noneclass">&nbsp;&nbsp;&nbsp;
						<input type="radio" name='radio' <c:if test="${not empty modifytimeMap.docStartTime}">checked="checked"</c:if>  id="selectedId" value="time"> 
						规定范围 
						<i>&nbsp;&nbsp;&nbsp;&nbsp;开始:&nbsp;
							<input class=" date-picker" type="text" name="docCrawlStartTime" id="docCrawlStartTime" 
							<c:if test="${not empty modifytimeMap.docStartTime }">value="${modifytimeMap.docStartTime}"</c:if>
							<c:if test="${empty modifytimeMap.docStartTime }">value="<%=datetime %>"</c:if>
							  />
								 -- &nbsp;&nbsp;结束:&nbsp;
							<input class=" date-picker" type="text" name="docCrawlEndTime" id="docCrawlEndTime" 
							<c:if test="${not empty modifytimeMap.docEndTime }">value="${modifytimeMap.docEndTime}"</c:if>
							<c:if test="${empty modifytimeMap.docEndTime }">value="<%=datetime %>"</c:if>
							 />
						</i>
					</span>
					<input type="hidden" id="modifytime_id" value="${modifytimeMap.docStartTime}"" />
					</td>
				</tr>
			<tr>
		        <th width="10%"><label for="name">存储为中间文件:</label></th>
		        <td width="10%" colspan="3">
		              <input type="hidden" name="saveType" id="saveType_id"/>
		        <!-- 	<span class="saveType_class">
		        		<input id="saveToDB_id" type="checkbox" value="db"  >
		        		<a href="javascript:void(0)"  onclick="filesToDB();">数据库</a>
					</span>  -->
					<span class="saveType_class">&nbsp;&nbsp;&nbsp;
						<input id="saveToJSON_id" type="checkbox" value="doc" >
						<a href="javascript:void(0)" onclick="filesToDOC();">中间文档</a>
					</span>
		       <%--    	<span>&nbsp;&nbsp;&nbsp;
		          		<input type="checkbox" value="3" <c:if test="${bean.savetype eq 3 }">checked="checked"</c:if> name='radio' >
		          		<a href="javascript:void(0)" onclick="filesToSolr();">存到索引库</a>
		 		   </span> --%>
		        </td>
		      </tr>
				<tr>
					<th width="10%"><label for="name">更新方式:</label></th>
					<td width="10%" colspan="3">
					<select
						style="width: 80px; height: 35px; min-height: 35px;" name="docUpdateType">
							<option value="1" <c:if test="${mdaDoccrawlconfigDTO.updatemode eq 1 }">selected="selected"</c:if>>全量采集</option>
							<option value="2" <c:if test="${mdaDoccrawlconfigDTO.updatemode eq 2 }">selected="selected"</c:if> >增量采集</option>
					</select></td>

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
		type="text/javascript">
	</script>
	<script type="text/javascript">
	//========非空校验=======
	function checkForm(){
		//=======获取文档系统类型====
		var FS_type =$('#docType_id').val();
		if(FS_type == 'ftp'){
			//=====文档系统类型==
			var docType = $('#docType_id').val();
			//=====FTP===IP===
			var docFSIP = $('#docFSIP_id').val();
			//=====FTP===port===
			var docPort = $('#docPort_id').val();
			//=====FTP===用户名===
			var docUserName = $('#docUserName_id').val();
			//=====FTP===用户密码===
			var docUserPWD = $('#docUserPWD_id').val();
			 if(docType == ''){
				 layer.alert('请选择文档系统类型！', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					});
				 return false;
			 }
			 if(docFSIP == ''){
				 layer.alert('请填写FTP服务器IP地址！', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					});
				 return false;
			 }
			 if(docPort == ''){
				 layer.alert('请填写FTP服务器端口！', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					});
				 return false;
			 }
			 if(docUserName == ''){
				 layer.alert('请填写FTP服务器用户名！', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					});
				 return false;
			 }
			 if(docUserPWD == ''){
				 layer.alert('请填写FTP服务器用户密码！', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					});
				 return false;
			 }
		}else if(FS_type == 'local'){
			var docAddr = $('#docAddr_id').val();
			 if(docAddr == ''){
				 layer.alert('请填写本地文件所在路径！', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					});
				 return false;
			 }
		}
		 return true;
	}
	 //测试FTP按钮绑定事件
    $('#test_FTP').bind('click',
            function() {
   	 //如果校验通过再执行
   	 if(checkForm()){
   	 var form=$("#form");
  	     var _data=serializeObject(form);
   	    $.ajax({
   	      url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/crawl/testftp",
   	      data : _data,
   	      type : 'post',
   	      success : function(data){
   	    	  console.log(data);
				 layer.msg(data.desc);
			 }
		 });
   	 }
     });
	
	
	</script>
	<script type="text/javascript">
	//文档采集时间范围
	function selectDOCTime(){
		  var val=$('input:radio[name="radio"]:checked').val();
		  if(val == "notime"){
			 //alert('===不限制时间==='); 
			 $('#docCrawlStartTime').val('')
			 $('#docCrawlEndTime').val('');
		  }else if(val == "time"){
			//  alert('===限制时间==='); 
		  }
	/* 	//========文档采集开始时间点==========
		var docCrawlStartTime = $('#docCrawlStartTime').val();
		//========文档采集结束时间点==========
		var docCrawlEndTime = $('#docCrawlEndTime').val(); */
	}
	
	 //选择文件系统类型
	function selectFSType(){
		 var docType = $('#docType_id').val();
		 if(docType == 'ftp'){
				$('.LOCAL_CLASS').hide();
				$('.FTP_CLASS').show();
			}
			if(docType == 'local'){
				$('.FTP_CLASS').hide();
				$('.LOCAL_CLASS').show();
			}
	}
	 
	//选择文档爬取类型
	function selectDocCrawlType(){
		 var doctypes = $('.docSaveType_class input:checked');
		 
		 var doctypeArr =  [];
		 doctypes.each(function (i) {
			// dbtype = dbtypes.eq(i).attr("dbtype");//属性值
			 var doctype = doctypes.eq(i).val();
			 doctypeArr.push(doctype);
	      });
		//alert(dbtype);
		 $('#docSaveType_id').val(doctypeArr.toString());
		/*  var s = $('#docSaveType_id').val();
		alert("========="+s); */
	}
	
	
	
	$(function() {
		var FS_type =$('#FS_type_id').val();
		if(FS_type == 'ftp'||FS_type ==''){
			$('.LOCAL_CLASS').hide();
		}
		if(FS_type == 'local'){
			$('.FTP_CLASS').hide();
		}
		var saveType = "${mdaDoccrawlconfigDTO.storemethod}";
		var saveTypeArr = saveType.split(",");
		for(var i=0;i<saveTypeArr.length;i++){
		 if(saveTypeArr[i]== 'db'){
		  $('#saveToDB_id').attr("checked","checked");
		 }else if(saveTypeArr[i]== 'doc'){
		  $('#saveToJSON_id').attr("checked","checked");
		 }
		}
		$('#docCrawlStartTime').datetimepicker({  
            defaultDate: "<%=datetime %>",  
            dateFormat: "yy-mm-dd",  
            showSecond: true,  
            timeFormat: 'HH:mm:ss',  
            stepHour: 1,  
            stepMinute: 1,  
            stepSecond: 1,
            beforeShow: function() {
                setTimeout(function(){
                    $('.ui-datepicker').css('z-index', 99999999999999);
                }, 0);
            }
        });
		
        $('#docCrawlEndTime').datetimepicker({  
            defaultDate: "<%=datetime %>",  
            dateFormat: "yy-mm-dd",  
            showSecond: true,  
            timeFormat: 'HH:mm:ss',  
            stepHour: 1,  
            stepMinute: 1,  
            stepSecond: 1,
            beforeShow: function() {
                setTimeout(function(){
	                $('.ui-datepicker').css('z-index', 99999999999999);
	            }, 0);
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
		    content: 'platform/platform6/mda/mdadatasource/mdaDatasourceController/toSetFieldSavePath/doc/'+id 
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
		//alert("======aaaaaaaa==="+ $('#saveType_id').val());
	}
		
	
	
	</script>
	<script type="text/javascript">
		$(function() {
			var modifytime =$('#modifytime_id').val();
			//alert("====modifytime===="+modifytime);
			if(modifytime == ''){
				$("#selectedId").parent().find("i").hide();
			}
		})
			$("input[type='radio']").click(function(){
				var _flag = $('#selectedId:checked').val();
				if (_flag) {
					$("#selectedId").parent().find("i").show();
				} else {
					$("#selectedId").parent().find("i").hide();
				}
			})
			var saveType = "${mdaDatabasecrawlconfigDTO.storemethod}";
			  var saveTypeArr = saveType.split(",");
			  for(var i=0;i<saveTypeArr.length;i++){
				  if(saveTypeArr[i]== 'db'){
					  $('#saveToDB_id').attr("checked","checked");
				  }else if(saveTypeArr[i]== 'doc'){
					  $('#saveToJSON_id').attr("checked","checked");
				  }
			  }
			
			
		
		/* function valuereset(obj,type){ */
			/* $("textarea").focus(function(){
			var _text = $(this).val();
				if(_text=='多个请用逗号分割'){
						$(this).val("");
						$(this).removeAttr("style");
				}
			})
			$("textarea").blur(function(){
				var _text = $(this).val();
				if(_text.length==0){
					$(this).val("多个请用逗号分割");
					$(this).attr("style","color: #BEBEBE;");
				}
			}) */
			
			

		function closeForm() {
			parent.mdaCrawlitems.closeDialog("insert");
		}
		
		function openk(){
			 var _id = "111";
			 this.insertIndex = layer.open({
			    type: 2,
			    area: ['100%', '100%'],
			    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		        maxmin: false, //开启最大化最小化按钮
			    content: 'platform/platform6/mda/mdadatasource/mdaDatasourceController/set/Set/'+_id 
			}); 
		}
		function saveForm() {
			 selectSaveType();
			 selectDOCTime();
			   if(!checkForm()){
			    	 return false;
			     }
			 var FS_type =$('#FS_type_id').val();
				if(FS_type == 'ftp'){
					$('#docAddr_id').val("");
				}
				if(FS_type == 'local'){
					$('#docFTPAddr_id').val("");
				}
		  
			var form=$("#form");
			var _data=serializeObject(form);
			
			$.ajax({
				 url:"platform/platform6/mda/mdadatasource/mdaDatasourceController/operation/saveSet/doc",
				 data : _data,
				 type : 'post',
				 success : function(r){
					//字符串拆分,获取ID
					 var arr = new Array();
					 arr = r.split(":");
					 
					 if (arr[0] == "success"){
						// parent.openc(2);
						 parent.openNext('doc',arr[1]);
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
		$(document)
				.ready(
						function() {
							$('.date-picker').datepicker();
							$('.time-picker')
									.datetimepicker(
											{
												oneLine : true,//单行显示时分秒
												closeText : '确定',//关闭按钮文案
												showButtonPanel : true,//是否展示功能按钮面板
												showSecond : false,//是否可以选择秒，默认否
												beforeShow : function(
														selectedDate) {
													if ($('#' + selectedDate.id)
															.val() == "") {
														$(this).datetimepicker(
																"setDate",
																new Date());
														$('#' + selectedDate.id)
																.val('');
													}
													setTimeout(function(){
											            $('.ui-datepicker').css('z-index', 99999999999999);
											        }, 0);
												}
											});

							parent.mdaCrawlitems.formValidate($('#form'));
							//保存按钮绑定事件
							$('#mdaCrawlitems_saveForm').bind('click',
									function() {
									selectDocCrawlType();
									saveForm();
									});
							//返回按钮绑定事件
							$('#mdaCrawlitems_closeForm').bind('click',
									function() {
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
							/* ztree树加载 */
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
							/* 	var treeNodes = [
								                 {"id":1, "pId":0, "name":"test1"},
								                 {"id":11, "pId":1, "name":"test11"},
								                 {"id":12, "pId":1, "name":"test12"},
								                 {"id":111, "pId":11, "name":"test111"}
								             ]; */

							$('#classifyidsAlias')
									.focus(
											function() {
												$("#crawlitem_classify").css(
														"display", "block");
												$
														.ajax({
															url : "platform6/mda/mdadatasource/mdaDatasourceController/getZtree",
															type : "POST",
															success : function(
																	retVal) {
																$.fn.zTree
																		.init(
																				$("#crawlitem_classify"),
																				setting,
																				retVal);
															}
														});
											});
							function zTreeOnClick(event, treeId, treeNode) {
								/* 	alert(treeNode.tId + ", " + treeNode.name); */

								var treeObj = $.fn.zTree
										.getZTreeObj("crawlitem_classify");
								/* 单击展开节点 */
								treeObj.expandNode(treeNode);
								var sNodes = treeObj.getSelectedNodes();
								if (sNodes.length > 0) {
									var isParent = sNodes[0].isParent;
									if (isParent == false) {
										$("#classifyidsAlias").val(
												treeNode.name)
										$("#crawlitem_classify").css("display",
												"none");
									}
								}
								/* $("#classifyidsAlias").val(treeNode.name) */
							}
							;

							/* $("body").click( function(){
								$("#_ztree").css("display","none");
							 });  */

							/* 	$(document).click(function(){
								    $("#_ztree").hide();
								});
								$("#_ztree").click(function(){
									$("#_ztree").css("display","block");
								}); */
						});
	</script>
</body>
</html>