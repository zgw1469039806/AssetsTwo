<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "train/form/sysautocode/sysAutoCodeController/operation/Add/null" -->
<title>流程委托</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
	<form id='form' enctype="multipart/form-data">
		<input class="form-control input-sm" type="hidden"  type="text" id="handDate" name="handDate" readonly>
		<input type="hidden" name="validFlag" id="validFlag" value="1">
		<table class="form_commonTable">
			<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="workOwnerName">委托人:</label></th>
				<td width="39%">
                    <input name="workOwnerId" id="workOwnerId" style="display:none;" value="">
                    <input class="form-control input-sm" type="text" name="workOwnerName" id="workOwnerName" readonly="readonly" value="">
                </td>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="workOwnerDeptName">委托人部门:</label></th>
				<td width="39%">
                    <input name="workOwnerDeptId" id="workOwnerDeptId" style="display:none;" value="">
                    <input title="委托人部门" class="form-control input-sm" type="text" name="workOwnerDeptName" id="workOwnerDeptName" readonly value=""/>
                </td>
			</tr>
			<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="receptUserName">默认受托人:</label></th>
				<td width="39%">
                    <div class="input-group  input-group-sm">
                        <input name="receptUserId" id="receptUserId" style="display:none;">
                        <input class="form-control" placeholder="请选择默认接受人" type="text" id="receptUserName" name="receptUserName" readonly>
                        <span class="input-group-btn">
							        <button class="btn btn-default" type="button" id="btnReceptUserName" >
                                        <span class="glyphicon glyphicon-equalizer"></span>
                                    </button>
                        </span>
                    </div>
                </td>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="receptDeptName">受托人部门:</label></th>
				<td width="39%">
                        <input name="receptDeptId" id="receptDeptId" style="display:none;">
						<input type="text" class="form-control" name="receptDeptName" id="receptDeptName" readonly>
				</td>
			</tr>
			<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="handEffectiveDate">起始日期:</label></th>
				<td width="39%" >
					<div class="input-group  input-group-sm">
                        <input class="form-control date-picker" type="text" name="handEffectiveDate" id="handEffectiveDate" readonly/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="backDate">截止日期:</label></th>
				<td width="39%" >
                    <div class="input-group  input-group-sm">
                        <input class="form-control date-picker" type="text" name="backDate" id="backDate" readonly/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
				</td>
			</tr>

			<%--<tr>--%>
				<%--<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="handDate">登记日期:</label></th>--%>
                <%--<td width="39%" >--%>
                        <%--<input class="form-control input-sm" type="text"  type="text" id="handDate" name="handDate"--%>
                              <%--readonly>--%>
				<%--</td>--%>
				<%--<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="validFlag">是否有效:</label></th>--%>
				<%--<td width="35%"  >--%>
					<%--<select class="form-control input-sm"  name="validFlag" id="validFlag" title="">--%>
						<%--<option value="1">有效</option>--%>
						<%--<option value="0">无效</option>--%>
					<%--</select>--%>
				<%--</td>--%>
			<%--</tr>--%>
			<tr>
                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="handAcceptedTask">委托已有待办事宜:</label></th>
                <td width="39%">
					 <input type="checkbox" id="handAcceptedTask" name="handAcceptedTask" value="1" checked/>
                </td>
                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="expireAutoCancel">到期后自动注销:</label></th>
                <td width="39%">
					 <input type="checkbox" id="expireAutoCancel" name="expireAutoCancel" value="1" checked />
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="handReason">委托原因:</label></th>
                <td width="84%" colspan="3">
                    <input class="form-control input-sm"  type="text" id="handReason" name="handReason" >
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
	<table class="form_commonTable hidden" id="customTable">
		<tr>
			<td colspan="5">
				<div style="float: right;">
				<a id="addModule" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="icon icon-add"></i> 添加</a>
				</div>
			</td>

		</tr>

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

<%--<div data-options="region:'south',border:false" style="height: 40px;">
	<div id="toolbar"
		 class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
		<table class="tableForm" style="border:0;cellspacing:1;width:100%">
			<tr>
				<td width="50%" style="padding-right:4%;" align="right">
					<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="saveForm">保存</a>
					<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="closeForm">返回</a>
				</td>
			</tr>
		</table>
	</div>
</div>--%>



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
    $(document).ready(function () {
        //返回按钮绑定事件
        /*$('#closeForm').on('click', function(){
            parent.workDelegate.closeDialog(window.name);
        });*/

        // 如果是详情页面，则去掉保存按钮
        var act = flowUtils.getUrlQuery("act");
        if(act) {
             var workHandVo = parent.workDelegate.getDetail();
             //console.log(workHandVo);
            $("#workOwnerId").val(workHandVo.workOwnerId);
            $("#workOwnerName").val(workHandVo.workOwnerNeame);
            $("#workOwnerDeptId").val(workHandVo.workOwnerDeptId);
            $("#workOwnerDeptName").val(workHandVo.workOwnerDeptName);
            $("#receptUserId").val(workHandVo.receptUserId);
            $("#receptDeptId").val(workHandVo.receptDeptId);
            $("#receptUserName").val(workHandVo.receptUserName);
            $("#receptDeptName").val(workHandVo.receptDeptName);
            $("#handEffectiveDate").val(workHandVo.handEffectiveDate);
            $("#handReason").val(workHandVo.handReason);
            $("#backDate").val(workHandVo.receptDeptName);
            $("#handDate").val(workHandVo.handDate);
            /*$("#saveForm").remove();*/
            $("#handReason").attr("readonly","readonly");
        } else {
            parent.workDelegate.formValidate($("#form"));
            //保存按钮绑定事件
            /*$('#saveForm').on('click', function(){
                var isValidate = $("#form").validate();
                if (!isValidate.checkForm()) {
                    isValidate.showErrors();
                    return false;
                }
                // 校验是否选择了流程
				if(!$("#customTable").hasClass("hidden")) {
					var flag = false;
					if( $("#customTable").find("tr:gt(0)").length <= 0) {
                        layer.msg("您还没有添加流程委托范围");
                        return ;
					}

					$("#customTable").find("input").each(function(){
						if($(this).val() == "") {
						    flag = true;
						    return false;
						}
					});
					if(flag) {
					    layer.msg("您还没有选择流程委托范围");
					    return ;
					}
				}
                parent.workDelegate.save($("#form"),$("#moduleForm"));
            });*/

            $("#btnReceptUserName").on('click', function() {
                new H5CommonSelect({type:'userSelect', idFiled:'receptUserId',textFiled:'receptUserName',callBack:function(data){
                    $("#receptDeptName").val(data.userdeptnames);
                    $("#receptDeptId").val(data.userdeptids);
                    //console.log(data);
                },viewScope : 'currentOrg'});
            });

            $('.date-picker').datepicker();
            $.ajax({
                url  : "platform/bpm/clientbpmWorkHandAction/addWorkHand",
                type : 'post',
                dataType : 'json',
                success : function(d){
                    var workHandVo = d.workHand;
                    $("#workOwnerId").val(workHandVo.workOwnerId);
                    $("#workOwnerName").val(workHandVo.workOwnerName);
                    $("#workOwnerDeptId").val(workHandVo.workOwnerDeptId);
                    $("#workOwnerDeptName").val(workHandVo.workOwnerDeptName);
                    $("#receptUserId").val(workHandVo.receptUserId);
                    $("#receptDeptId").val(workHandVo.receptDeptId);
                    $("#receptUserName").val(workHandVo.receptUserName);
                    $("#receptDeptName").val(workHandVo.receptDeptName);
                    $("#handDate").val((new Date()).format("yyyy-MM-dd"));
                }
            });

            $("#customWorkhand").on('click', function() {
               if(this.checked == true) {
                   $("#customTable").removeClass("hidden");
			   }  else {
                   $("#customTable").addClass("hidden");
                   $("#customTable").find("input").val("");
			   }
			});

            new BpmModuleSelect("moduleId1","moduleName1", function(data){
                $("#moduleId1").val(data.ids);
                $("#moduleName1").val(data.texts);
                $("#workHandType1").val(data.types);
            },"1", $("#moduleId1"), $("#moduleName1"), $("#workHandType1"));

			$("#addModule").on('click',function(){
                var id = Math.ceil(Math.random() * 1000000);
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
        }
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