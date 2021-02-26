<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
</script>
<title>修改委托</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
	<form id='form' enctype="multipart/form-data">
	    <input type="hidden" name="id" value="${workHand.id}">
		<table class="form_commonTable">
			<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="workOwnerName">委托人:</label></th>
				<td width="39%">
				    <input name="workOwnerId" id="workOwnerId" style="display:none;" value="${workHand.workOwnerId}">
                    <input type="text" class="form-control input-sm" name="workOwnerName" id="workOwnerName" readonly="readonly" value="${workHand.workOwnerName}">
                </td>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="workOwnerDeptName">委托人部门:</label></th>
				<td width="39%">
					<input name="workOwnerDeptId" id="workOwnerDeptId" style="display:none;" value="${workHand.workOwnerDeptId }">
                    <input type="text" class="form-control input-sm" name="workOwnerDeptName" id="workOwnerDeptName" readonly="readonly" value="${workHand.workOwnerDeptName }">
                </td>
			</tr>
			<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="receptUserName">默认受托人:</label></th>
				<td width="39%">
                    <div class="input-group  input-group-sm">
                        <input name="receptUserId" id="receptUserId" style="display:none;" value="${workHand.receptUserId }">
                        <input class="form-control" placeholder="请选择默认接受人" type="text" id="receptUserName" name="receptUserName" readonly value="${workHand.receptUserName }">
                        <span class="input-group-btn">
							        <button class="btn btn-default" type="button" id="btnReceptUserName" >
                                        <span class="glyphicon glyphicon-equalizer"></span>
                                    </button>
                        </span>
                    </div>
                </td>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="receptDeptName">受托人部门:</label></th>
				<td width="39%">
                        <input name="receptDeptId" id="receptDeptId" style="display:none;" value="${workHand.receptDeptId }">
						<input type="text" class="form-control" name="receptDeptName" id="receptDeptName" readonly value="${workHand.receptDeptName }">
				</td>
			</tr>
			<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="handEffectiveDate">起始日期:</label></th>
				<td width="39%" >
					<div class="input-group  input-group-sm">
                        <input class="form-control date-picker" type="text" name="handEffectiveDate" id="handEffectiveDate" readonly value="${workHand.handEffectiveDateStr }"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="backDate">截止日期:</label></th>
				<td width="39%" >
                    <div class="input-group  input-group-sm">
                        <input class="form-control date-picker" type="text" name="backDate" id="backDate" readonly value="${workHand.backDateStr }"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
				</td>
			</tr>
			<tr>
                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="handAcceptedTask">委托已有待办事宜:</label></th>
                <td width="39%">
					 <input type="checkbox" class="form-control input-sm" id="handAcceptedTask" name="handAcceptedTask" value="1" <c:if test="${workHand.handAcceptedTask=='1'}">checked="checked"</c:if>/>
                </td>
                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="expireAutoCancel">到期后自动注销:</label></th>
                <td width="39%">
					 <input type="checkbox" class="form-control input-sm" id="expireAutoCancel" name="expireAutoCancel" value="1" <c:if test="${workHand.expireAutoCancel=='1'}">checked="checked"</c:if> />
					 
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="handReason">委托原因:</label></th>
                <td width="84%" colspan="3">
                    <input type="text" class="form-control input-sm" id="handReason" name="handReason" value="${workHand.handReason }" >
                </td>
            </tr>	
            <tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="customWorkhand">自定义委托:</label></th>
				<td width="84%" colspan="3" >
					<div style="display: table-cell;vertical-align: middle;hieght:33px;"> <input type="checkbox" id="customWorkhand" name="customWorkhand">  (注:配置特定流程的委托人)</div>
				</td>
			</tr>		
		</table>
	</form>
	<form id="moduleForm">
	<c:set var="idNum" value="0"></c:set>
	<table class="form_commonTable hidden" id="customTable">
		<tr>
			<td colspan="5">
				<div style="float: right;">
				<a id="addModule" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="icon icon-add"></i> 添加</a>
				</div>
			</td>

		</tr>
		<c:if test="${modelList!=null && modelList.size()>0}">
			<c:forEach var="item" items="${modelList }">
			<c:set var="idNum" value="${idNum+1}"></c:set>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="moduleName${idNum}">委托范围:</label></th>
					<td width="39%">
						<input name="moduleId"  id="moduleId${idNum}"  style="display:none;" value="${item.modelId }">
						<input name="workHandType"  id="workHandType${idNum}"  style="display:none;" value="${item.workHandType }">
						<input class="form-control input-sm" type="text" name="moduleName"  id="moduleName${idNum}" readonly="readonly" value="${item.modelName }">
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="myWorkHandText1">受托人:</label></th>
					<td width="39%">
						<input name="myWorkHandId"   id="myWorkHandId${idNum}"  style="display:none;" value="${item.receptUserId }">
						<input title="委托人" class="form-control input-sm" type="text" name="myWorkHandText" id="myWorkHandText${idNum}" readonly value="${item.receptUserName }"/>
					</td>
					<td width="10%">
						<a name="moduleDelete" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
					</td>
				</tr>
		   </c:forEach>
		</c:if>
		<c:if test="${modelList==null || modelList.size()<1}">
		<tr>
			<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="moduleName1">委托范围:</label></th>
			<td width="39%">
				<input name="moduleId"  id="moduleId1"  style="display:none;" value="">
				<input name="workHandType"  id="workHandType1"  style="display:none;" value="">
				<input class="form-control input-sm" type="text" name="moduleName"  id="moduleName1" readonly="readonly" value="">
			</td>
			<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="myWorkHandText1">受托人:</label></th>
			<td width="39%">
				<input name="myWorkHandId"   id="myWorkHandId1"  style="display:none;" value="">
				<input title="委托人" class="form-control input-sm" type="text" name="myWorkHandText" id="myWorkHandText1" readonly value=""/>
			</td>
			<td width="10%">
				<a name="moduleDelete" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
			</td>
		</tr>
		</c:if>
		

	</table>
	</form>
	
</div>

<div id="template" class="hidden">
	<table>
	<tr>
		<th width="10%" style="word-break: break-all; word-wrap: break-word;"><label for="moduleName#id#">委托范围:</label></th>
		<td width="39%">
			<input name="moduleId"  id="moduleId#id#" style="display:none;" value="">
			<input name="workHandType"  id="workHandType#id#" style="display:none;" value="">
			<input class="form-control input-sm" type="text" name="moduleName"  id="moduleName#id#" readonly="readonly" value="">
		</td>
		<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="myWorkHandText#id#">受托人:</label></th>
		<td width="39%">
			<input name="myWorkHandId"   id="myWorkHandId#id#"  style="display:none;" value="">
			<input title="委托人" class="form-control input-sm" type="text" name="myWorkHandText" id="myWorkHandText#id#" readonly value=""/>
		</td>
		<td width="10%">
			<a name="moduleDelete" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
		</td>
	</tr>
	</table>
</div>
</body>
<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/workhand/js/BpmModuleSelect.js" type="text/javascript"></script>
<style type="text/css">
    .error{
        background:#FFF7FA
        border:1px solid #CE7979
        color:#F00
    }
</style>
<script type="text/javascript">
	var id = ${idNum};
    $(document).ready(function () {  
        var hasExt = '${hasExt}';
        if(hasExt=='1'){
			$("#customWorkhand").attr("checked",true);
			$("#customTable").removeClass("hidden");
        }
    	$("#btnReceptUserName").on('click', function() {
            new H5CommonSelect({type:'userSelect', idFiled:'receptUserId',textFiled:'receptUserName',callBack:function(data){
                $("#receptDeptName").val(data.userdeptnames);
                $("#receptDeptId").val(data.userdeptids);
                //console.log(data);
            },viewScope : 'currentOrg'});
        });

        $('.date-picker').datepicker();

        $("#customWorkhand").on('click', function() {
           if(this.checked == true) {
               $("#customTable").removeClass("hidden");
		   }  else {
               $("#customTable").addClass("hidden");
		   }
		});

        new BpmModuleSelect("moduleId1","moduleName1", function(data){
            $("#moduleId1").val(data.ids);
            $("#moduleName1").val(data.texts);
            $("#workHandType1").val(data.types);
        },"1", $("#moduleId1"), $("#moduleName1"), $("#workHandType1"));

		$("#addModule").on('click',function(){
            //var id = Math.ceil(Math.random() * 1000000);
            id++;
			var html = $("#template").children("table").clone().html().replace(/#id#/g, id)
			$("#customTable").append(html);

			new BpmModuleSelect("moduleId"+id,"moduleName"+id, function(data){
                $("#moduleId"+id).val(data.ids);
                $("#moduleName"+id).val(data.texts);
                $("#workHandType"+id).val(data.types);
			},"1", $("#moduleId"+id), $("#moduleName"+id), $("#workHandType"+id));
            reloadEvent();
		});

        reloadEvent();
    });

    function reloadEvent() {

        $("input[name='myWorkHandText']").off('click').on('click', function() {
            var that = $(this);
           // console.log(that.prev().attr("id"));
           // console.log(that.attr("id"));
            new H5CommonSelect({type:'userSelect', idFiled:that.prev().attr("id"),textFiled:that.attr("id"),callBack:function(data){
//                    $("#receptDeptName").val(data.userdeptnames);
//                    $("#receptDeptId").val(data.userdeptids);
              //  console.log(data);
            },viewScope : 'currentOrg'});
        });

        $("a[name='moduleDelete']").off('click').on('click',function(){
            $(this).parent().parent().remove();
        });
	}
    
</script>

</html>