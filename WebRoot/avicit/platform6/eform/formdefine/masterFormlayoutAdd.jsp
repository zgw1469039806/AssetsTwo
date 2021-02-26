<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>单位列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
<script src="avicit/platform6/eform/formdefine/js/eformValidate.js"></script>
<script src="avicit/platform6/eform/formdefine/js/eformCustomDialog.js"></script>
<script src="avicit/platform6/eform/formdefine/js/eformUpload.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true" style="visibility:hidden;">
<div data-options="region:'center',split:true,border:false">
	<!-- ADD表单 start-->
	
	    <input  id="tableId"  value="${table.id}"   type="hidden"  />
		<form id="fm" method="post" novalidate>
		<input  id="comId"  value="${comId}" name="comId"   type="hidden" />
		    ${fkvalue}
			${layout}
		</form>
		
		<c:if test="${table.tableIsUpload== 'Y'}">
		<div>
			<jsp:include page="/avicit/platform6/modules/system/swfupload/swfEditInclude.jsp">
				<jsp:param name="file_size_limit" value="5000MB" />
				<jsp:param name="file_types" value="*.*" />
				<jsp:param name="file_upload_limit" value="10" />
				<jsp:param name="save_type" value="true" /> 
				<jsp:param name="form_id" value="" />
				<jsp:param name="form_code" value="${table.tableName}" />
				<jsp:param name="allowAdd" value="true" />
				<jsp:param name="allowDel" value="true" />
				<jsp:param name="cleanOnExit" value="true" />
				<jsp:param name="hiddenUploadBtn" value="true" />
				<jsp:param name="secret_level" value="PLATFORM_FILE_SECRET_LEVEL" />
			</jsp:include>
			</div>
		</c:if>
			</div>
			<div data-options="region:'south',border:false" style="height:40px;">
			<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td width="50%" align="right">
						<c:if test="${table.tableIsUpload== 'N'}">
								<a href="javascript:void(0)" class="easyui-linkbutton primary-btn"  onclick="saveObj()" >保存</a>
						</c:if>
						<c:if test="${table.tableIsUpload== 'Y'}">
								<a href="javascript:void(0)" class="easyui-linkbutton primary-btn"  onclick="saveAch(callback)" >保存</a>
						</c:if>
						<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:parent.dlg_close_only('insert')" >返回</a>
					</td>
				</tr>
			</table>
		</div>
		</div>
	<!-- ADD表单 end-->

	
	<!-- button js event -->
	<script type="text/javascript">
		var baseurl = '<%=request.getContextPath()%>';
		var url;
		
		function beforeEvent(){
			${saveButton.preJs}
		}

		function afterEvent(){
			${saveButton.postJs}
		}
		
		function getLength(str) {
		    var realLength = 0, len = str.length, charCode = -1;
		    for (var i = 0; i < len; i++) {
		        charCode = str.charCodeAt(i);
		        if (charCode >= 0 && charCode <= 128) realLength += 1;
		        else realLength += 3;
		    }
		    return realLength;
		};
		
		function saveAch(callback){
			if (beforeEvent()==false){
				return false;
			}
			
			var formdata = serializeObject($('#fm'));
			<c:forEach items="${formColumns}"   var="item"  >
			<c:if test="${item.colIsMust == 'Y'  && item.elementType != 'image'}">
				if (!formdata.${item.colName}){
					$.messager.alert('提示',"${item.colLabel}为必填字段，请检查！",'warning');
					return;
				}
			</c:if>
			<c:if test="${item.elementType == 'textarea'}">
			if (getLength(formdata.${item.colName}) > ${item.colLength}){
				$.messager.alert('提示',"${item.colLabel}内容长度超过${item.colLength}，请检查！",'warning');
				return;
			}
		</c:if>
		</c:forEach>
		if($("input[name='SECRETLEVEL']").length > 0 && typeof($("input[name='SECRETLEVEL']").val()) == "string"){
			if (typeof(validateSecritLevel) == "function")
				if(!validateSecritLevel($("input[name='SECRETLEVEL']").val())){
			 		return false;
			 	}
		}
			var tableId=$('#tableId').val();
			url = 'platform/eform/cbbCRUDClient/add?version='+encodeURI("${version}")+'&tableId='+tableId;
			$('#fm').form('submit', {
				url : url,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.success) {
						if(typeof(callback)=="function"){
							callback(result.id);
						}
					} else {
						$.messager.show({
							title : 'Error',
							msg : result.msg
						});
					}
				}
			});
		}
		
		function callback(id){
			var flag = upload(id);
			if (!flag){
				afterEvent();
				parent.dgsub_reload();
				parent.dlg_close('insert');
				$.messager.show({
					 title : '提示',
					 msg : '保存成功！'
				});
			}
		}
		
		function afterUploadEvent(){
			afterEvent();
			$.messager.show({
				 title : '提示',
				 msg : '保存成功！'
			});
			parent.dgsub_reload();
			parent.dlg_close('insert');
		}
		
		
		function saveObj() {
			if (beforeEvent()==false){
				return false;
			}
			
			var formdata = serializeObject($('#fm'));
			<c:forEach items="${formColumns}"   var="item"  >
			<c:if test="${item.colIsMust == 'Y' && item.elementType != 'image'}">
				if (!formdata.${item.colName}){
					$.messager.alert('提示',"${item.colLabel}为必填字段，请检查！",'warning');
					return;
				}
			</c:if>
			<c:if test="${item.elementType == 'textarea'}">
			if (getLength(formdata.${item.colName}) > ${item.colLength}){
				$.messager.alert('提示',"${item.colLabel}内容长度超过${item.colLength}，请检查！",'warning');
				return;
			}
		</c:if>
		</c:forEach>
		
		
			var tableId=$('#tableId').val();
			url = 'platform/eform/cbbCRUDClient/add?version='+encodeURI("${version}")+'&tableId='+tableId;
			$('#fm').form('submit', {
				url : url,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.success) {
						afterEvent();
						parent.dgsub_reload();
						parent.dlg_close('insert');
					} else {
						$.messager.show({
							title : '错误',
							msg : result.msg
						});
					}
				}
			});
		}
		
		function choosePhoto(colId,id,colName){
			id = "${comId}";
			var url = "platform/eform/image/upload/manage?colId="+colId+"&id="+id+"&colName="+colName;
			var  dlg = new CommonDialog("eformupload","600","200",url,"上传",false,true,false);
			dlg.show();
		}

		function closeDialog(id){
			$("#"+id).dialog('close');
		}
		
		var Common = {
			    DateFormatter: function (value, rec, index) {
			        if (value == undefined) {
			            return "";
			        }
			        return new Date(value).format("yyyy-MM-dd hh:mm:ss");
			    },
		
				LookUpFormatter: function (value, rec, index){
					//return Platform6.fn.lookup.formatLookupType(value, demoBusinessTrip.traffic);
				}
			};
		
		$(function(){
			document.body.style.visibility = 'visible';
			$.extend($.fn.validatebox.defaults.rules, {
			    isRC: {
			        validator: function (value, param) {
			        	  var chk_value =[];    
			        	  $('input[name='+param[0]+']:checked').each(function(){    
			        	   chk_value.push($(this).val());    
			        	  });    
			        	  if(chk_value.length==0){
			        		  return false;
			        	  } else{
			        		  return true;
			        	  }
			        },
			        message: '该输入项为必输项'
			    },
			
			length: {
	          	 validator: function (value, param) {
	        	 var len=value.replace(/[^\x00-\xff]/g, '...').length;
	        	 return len>=param[0]&&len<=param[1];
	        },
	           message: '输入内容长度必须介于{0}和{1}之间'
	    	}
			    
			});
			
			<c:forEach items="${autocodeColumns}"   var="item"  >
				<c:set var="colName" value="${item.colName}"></c:set>
				var ${item.colName}AutoCode = new CustomDialog("${item.colName}","${item.colAutocode}");
				${item.colName}AutoCode.initAutoCode();
				$("[name='${item.colName}']").val("${autoCode[colName]}");
			</c:forEach>
			
			<c:forEach items="${selectColumns}"   var="item"  >
					var ${item.colName}CommonSelector = new CommonSelector("${item.colRuleName}","${item.colRuleName}SelectCommonDialog","${item.colName}","${item.colName}Name",null,null,null,parseInt("${item.colCommonselectCount}"));
					${item.colName}CommonSelector.init();  
			</c:forEach>
			
			<c:forEach items="${customColumns}"   var="item"  >
					var ${item.colName}Custom = new CustomDialog("${item.colName}","${item.customPath}");
					${item.colName}Custom.init();
			</c:forEach>
			
			var results=$.parseJSON('${result}');
			$('#fm').form('load', results);
			
		});
		
	</script>
</body>
</html>