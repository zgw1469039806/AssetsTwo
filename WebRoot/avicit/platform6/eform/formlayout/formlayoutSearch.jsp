<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
<script src="avicit/platform6/eform/formdefine/js/eformValidate.js"></script>
<script src="avicit/platform6/eform/formdefine/js/eformCustomDialog.js"></script>

	<!-- button js event -->
	<script type="text/javascript">
		var baseurl = '<%=request.getContextPath()%>';
		var url = 'platform/eform/cbbCRUDClient/list?tableId=${table.id}&bpmState='+parent.$("#bpmState",window.parent.document).val()+'&bpmType='+$("#bpmType",window.parent.document).val();
		
		
		
		function searchObj(datagrid){
			var json = serializeObject($("#searchfm"));

			parent.searchData(url,json);
			
		/* 	$('#searchfm').form('submit', {
				url : url,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(result) {
						var results=$.parseJSON(result);
						parent.dg_loaddata(datagrid,results);
						parent.dlg_close_only('search');
				}
			}); */
		}
		
		function clearObj(){
			$('#searchfm').form('clear');
		}
		
		$(function(){
			
			<c:forEach items="${selectColumns}"   var="item"  >
					var ${item.colName}CommonSelector = new CommonSelector("${item.colRuleName}","${item.colRuleName}SelectCommonDialog","${item.colName}","${item.colName}Name");
					${item.colName}CommonSelector.init();  
			</c:forEach>
			
			<c:forEach items="${customColumns}"   var="item"  >
					var ${item.colName}Custom = new CustomDialog("${item.colName}","${item.customPath}");
					${item.colName}Custom.init();
			</c:forEach>
			
			clearObj();
			
		});
	</script>

</head>
<body class="easyui-layout"  fit="true">
<div data-options="region:'center',split:true,border:false">
<!-- SEARCH表单 start-->
			<form id="searchfm" method="post">
			<input name="${colName}"  value="${colValue}"   type="hidden">
	    		<table class="form_commonTable">
	    		<c:forEach items="${searchColumns}"   var="item"  varStatus="status">
	    		
	    		<c:if test="${status.index%2==0}" >
             		<tr>
        		 </c:if>
	    		
	    			<c:choose>
						   <c:when test="${item.colType== 'DATE'}">  
						   		<td width="10%">${item.colLabel}:</td> 
						   		<td width="40%"><input name="${item.colName}" type='text'   <c:if test="${item.attribute03  == '1'}">class="easyui-datetimebox"</c:if><c:if test="${item.attribute03  == '2'}">class="easyui-datebox"</c:if>></input></td>
						   </c:when>
						   <c:otherwise> 
						   				
						   				<c:if test="${item.attribute01== null  and item.colRuleName!=null}">
						   						<td width="10%">${item.colLabel}:</td> 
						   						<td width="40%">
						   								<input id="${item.colName}"  name="${item.colName}"  class="easyui-textbox"   type="hidden"></input>
						   								<div class=""><input class="easyui-validatebox"  name="${item.colName}Name"   id="${item.colName}Name"  readOnly="readOnly" ></input></div>
						   						</td>
						   				</c:if>
						   				
						   				<c:if test="${item.attribute01== null  and item.colRuleName== null }">
						   						<td width="10%">${item.colLabel}:</td> 
						   						<td width="40%"><input name="${item.colName}"   class="easyui-validatebox"   type='text'  ></input></td>
						   				</c:if>
						   				
						   				<c:if test="${item.attribute01!= null}">
						   						<td width="10%">${item.colLabel}:</td> 
						   						<td width="40%">
								   						<select name="${item.colName}" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
																		<c:forEach items="${item.sysLookupList}"   var="itemlookup"  >
																				<option value="${itemlookup.lookupCode}">${itemlookup.lookupName}</option>
																		</c:forEach>
														</select>
						   						</td>
						   				</c:if>
						   </c:otherwise>
						</c:choose>
						
				<c:if test="${status.index%2==1}" >
             		</tr>
        		 </c:if>

				<c:if test="${status.index%2==0  and  status.last==true}" >
             		</tr>
        		 </c:if>
						
	    		</c:forEach>
	    		</table>
	    	</form>
	    	
	    		<div data-options="region:'south',border:false" style="height:40px;">
				<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
				<table class="tableForm" border="0" cellspacing="1" width='100%'>
                <tr>
                    <td align="right">
                    <a class="easyui-linkbutton primary-btn"  plain="false" onclick="searchObj('${datagrid}');" >查询</a>
	    			<a class="easyui-linkbutton" plain="false" onclick="clearObj();" href="javascript:void(0);" >清空</a>
	    			<a class="easyui-linkbutton" plain="false" onclick="javascript:parent.dlg_close_only('search')" >返回</a>
	    			</td>
                </tr>
            </table>
        	    </div>
				</div>	
</div>
</body>
</html>