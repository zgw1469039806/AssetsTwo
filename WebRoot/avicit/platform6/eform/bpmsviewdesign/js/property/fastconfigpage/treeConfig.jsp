<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<head>
<!-- ControllerPath = "demo/demoreception/demoReceptionController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<form>

	<table class="form_commonTable">
		<tr>
			<th width="15%"><label><i class="required">*</i>数据源</label></th>
			<td width="34%">
				<input type="text" id="dbname" name="dbname"
					   class="form-control input-sm" placeholder="数据源" readonly>
				<input type="hidden" id="tablename" name="tablename" class="form-control input-sm">
				<input type="hidden" id="dbid" name="dbid" class="form-control input-sm">
			</td>
			<th width="15%"><label><i class="required">*</i>树名称</label></th>
			<td width="34%"><input type="text" id="name" name="name"
								   class="form-control input-sm" placeholder="树名称"></td>
		</tr>
		<tr>
			<th width="15%"><i class="required">*</i><label>父ID</label></th>

			<td width="34%"><select id="pid" name="pid"
									class="form-control input-sm col-select"></select>
			</td>
			<th width="15%"><i class="required">*</i><label>节点ID</label></th>
			<td width="34%"><select id="nodeid" name="nodeid"
									class="form-control input-sm col-select"></select></td>
		</tr>
		<tr>
			<th width="15%"><i class="required">*</i><label>节点名称</label></th>

			<td width="34%"><select id="nodename" name="nodename"
									class="form-control input-sm col-select"></select>
			</td>
			<th width="15%"><label><i class="required">*</i>默认排序规则</label></th>
			<td width="34%">
				<div class="input-group input-group-sm" style="display: flex ;width:100%">
					<select id="orderBy" name="orderBy" class="form-control input-sm col-select"  style="width:75%;">
						<input type="hidden" name="orderByName" id="orderByName">
						<input type="hidden" name="orderByColType" id="orderByColType">
					</select>
					<select id="sorttype" name="sorttype" class="form-control input-sm"  style="width:25%;">
						<option value="asc">asc</option>
						<option value="desc">desc</option>
					</select>
				</div></td>
		</tr>
		<tr>
			<th width="15%"><label><i class="required">*</i>根节点值</label></th>
			<td width="34%"><input type="text" id="root" name="root" value="-1"
								   class="form-control input-sm" placeholder="根节点值"></td>
			<th width="15%"><label><i class="required">*</i>展开层数</label></th>
			<td width="34%"><input type="text" id="level" name="level" value="2"
								   class="form-control input-sm" placeholder="展开层数"></td>
		</tr>
		<tr>
			<th width="15%"><label>显示查询区域</label></th>
			<td width="83%" colspan="3"><input name="isquery" id="isquery" type="checkbox" class="ace" value="Y"></td>
		</tr>
		<tr>
			<th width="15%"><label>树右键菜单</label></th>
			<td width="83%" colspan="3">
				<div class="input-group input-group-sm" style="display: flex ;width:100%">
				&nbsp;添加&nbsp;<input name="addBtn" id="addBtn" type="checkbox" class="ace" value="Y">
			<i class="required addArea">*</i><input type="text" id="addFormName" name="addFormName"  style="width:25%;" readonly="readonly"
												   class="form-control input-sm addArea" placeholder="添加表单名称">
					<input type="hidden" name="addFormId" id="addFormId">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编辑&nbsp;<input name="editBtn" id="editBtn" type="checkbox" class="ace" value="Y">
			<i class="required editArea">*</i><input type="text" id="editFormName" name="editFormName"  style="width:25%;" readonly="readonly"
																 class="form-control input-sm editArea" placeholder="编辑表单名称">
					<input type="hidden" name="editFormId" id="editFormId">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;删除&nbsp;<input name="delBtn" id="delBtn" type="checkbox" class="ace" value="Y">
				</div>
			</td>
		</tr>

	</table>
</form>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
<script src="avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.js"></script>
<script src="avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.js"></script>
	<script type="text/javascript">
		var colList = null;
		$(".addArea").hide();
		$(".editArea").hide();

		function selectDbCallBack(id, name, tablename) {
			$("#name").val("树模型(" + name + ")");
			$("#tablename").val(tablename);
			avicAjax.ajax({
				url: 'platform/eform/eformViewInfoController/getDbCol/' + id,
				contentType: "application/xml; charset=utf-8",
				type: 'post',
				dataType: 'json',
				async: true,
				success: function (r) {
					if (r != null) {
						colList = $.parseJSON(r.data);
						var $colDom = $(".col-select");
						$colDom.each(function () {
							$(this).empty();
							for (var i = 0; i < colList.length; i++) {
								var $option = $('<option value="' + colList[i].colName + '">' + colList[i].colName + '</option>');
								$(this).append($option);
							}
						});
					}
					$("#dbname").trigger("change");
					$("#orderBy").trigger("change");
				}
			});
		}

		function getNodes(){
		    var returnNode = new Array();
			var treeId = "tree" + parent.uuid();
            returnNode.push({
                "id": treeId,
                "name": $("#name").val(),
                "type": "tree",
                "parentId": "root",
                "attribute": {
                    "dbid": $("#dbid").val(),
                    "dbname": $("#dbname").val(),
                    "event_init_beforeAsync": "",
                    "event_init_onClick": "",
                    "event_init_onCollapse": "",
                    "event_init_onDblClick": "",
                    "event_init_onExpand": "",
                    "evt": "",
                    "id": treeId,
                    "isorgfilter": "Y",
                    "isquery": $("#isquery").is(':checked') ? "Y" : "N",
                    "level": $("#level").val(),
                    "name": $("#name").val(),
                    "nodeid": $("#nodeid").val(),
                    "nodename": $("#nodename").val(),
                    "pid": $("#pid").val(),
                    "root": $("#root").val(),
                    "tablename": $("#tablename").val()
                }
            });
            var treeOrderId = treeId + "treeOrder";
            returnNode.push({
                "id": treeOrderId,
				"name": "树排序",
                "type": "treeOrder",
                "parentId": treeId,
                "attribute": {
                    "id": treeOrderId,
                    "name": "树排序",
                },
            });
            var ColOrderId = "treeColOrder" + parent.uuid();
            returnNode.push({
                "id": ColOrderId,
				"name": $("#orderByName").val(),
                "type": "treeColOrder",
                "parentId": treeOrderId,
                "attribute": {
                    "id": ColOrderId,
                    "colType": $("#orderByColType").val(),
                    "columnName": $("#orderBy").val(),
                    "name": $("#orderByName").val(),
                    "orderindex": "1",
                    "sorttype": $("#sorttype").val(),
                },
            });
			if($("#addBtn").is(':checked') || $("#editBtn").is(':checked') || $("#delBtn").is(':checked')){
                var treeToolId = treeId + "treeTool";
                returnNode.push({
                    "id": treeToolId,
					"name": "右键菜单区域",
                    "type": "treeTool",
                    "parentId": treeId,
                    "attribute": {
                        "id": treeToolId,
                        "name": "右键菜单区域",
                    },
                });
				if($("#addBtn").is(':checked')){
                    var addBtnId = "treeButton" + parent.uuid();
                    returnNode.push({
                        "id": addBtnId,
                        "name": "添加",
                        "type": "treeButton",
                        "parentId": treeToolId,
                        "attribute": {
                            "id": addBtnId,
                            "event_after_bt_click": "",
                            "event_before_bt_click": "",
                            "event_reg_bt_click": "",
                            "formid": $("#addFormId").val(),
                            "formname": $("#addFormName").val(),
                            "formpara": "",
                            "formparaname": "",
                            "formparatype": "",
                            "icon": "glyphicon glyphicon-plus",
                            "name": "添加",
                            "type": "add",
                            "unicode": "",
                        },
                    });
				}
				if($("#editBtn").is(':checked')){
                    var eidtBtnId = "treeButton" + parent.uuid();
                    returnNode.push({
                        "id": eidtBtnId,
                        "name": "编辑",
                        "type": "treeButton",
                        "parentId": treeToolId,
                        "attribute": {
                            "id": eidtBtnId,
                            "event_after_bt_click": "",
                            "event_before_bt_click": "",
                            "event_reg_bt_click": "",
                            "formid": $("#editFormId").val(),
                            "formname": $("#editFormName").val(),
                            "formpara": "",
                            "formparaname": "",
                            "formparatype": "",
                            "icon": "glyphicon glyphicon-edit",
                            "name": "编辑",
                            "type": "edit",
                            "unicode": "",
                        },
                    });
				}
				if($("#delBtn").is(':checked')){
                    var delBtnId = "treeButton" + parent.uuid();
                    returnNode.push({
                        "id": delBtnId,
                        "name": "删除",
                        "type": "treeButton",
                        "parentId": treeToolId,
                        "attribute": {
                            "id": delBtnId,
                            "event_after_bt_click": "",
                            "event_before_bt_click": "",
                            "event_reg_bt_click": "",
                            "formid": "",
                            "formname": "",
                            "formpara": "",
                            "formparaname": "",
                            "formparatype": "",
                            "icon": "glyphicon glyphicon-trash",
                            "name": "删除",
                            "type": "delete",
                            "unicode": "",
                        },
                    });
				}
			}
			return returnNode;
		}
		function isValidate(){
			if($.trim($("#name").val())==""){
				layer.msg('树名称不可为空，请检查！', {icon: 7});
				return false;
			}else if($.trim($("#dbname").val())=="" || $.trim($("#tablename").val())=="" || $.trim($("#dbid").val())==""){
				layer.msg('数据源不可为空，请检查！', {icon: 7});
				return false;
			}else if($.trim($("#pid").val())==""){
				layer.msg('父ID称不可为空，请检查！', {icon: 7});
				return false;
			}else if($.trim($("#nodeid").val())==""){
				layer.msg('节点ID不可为空，请检查！', {icon: 7});
				return false;
			}else if($.trim($("#root").val())==""){
				layer.msg('根节点值不可为空，请检查！', {icon: 7});
				return false;
			}else if($.trim($("#level").val())==""){
				layer.msg('展开层数不可为空，请检查！', {icon: 7});
				return false;
			}else if($.trim($("#orderBy").val())=="" || $.trim($("#orderByColType").val())=="" || $.trim($("#orderByName").val())==""){
				layer.msg('默认排序规则不可为空，请检查！', {icon: 7});
				return false;
			}else if($("#addBtn").is(':checked') && ($.trim($("#addFormName").val())=="" || $.trim($("#addFormId").val())=="")){
				layer.msg('添加表单名称不可为空，请检查！', {icon: 7});
				return false;
			}else if($("#editBtn").is(':checked') && ($.trim($("#editFormName").val())=="" || $.trim($("#editFormId").val())=="")){
				layer.msg('编辑表单名称不可为空，请检查！', {icon: 7});
				return false;
			}
			return true;
		}

		//修改默认排序规则时所需其他信息
		function refreshElseCol(){
				for (var i = 0; i < colList.length; i++) {
					if(colList[i].colName == $("#orderBy").val()){
						$("#orderByName").val(colList[i].colComments);
						$("#orderByColType").val(colList[i].colType);
						break;
					}
				}
		}
		// 加载完后初始化
		$(document).ready(function() {

			var selectCreatedDbTable = new SelectCreatedDbTable("dbid", "dbname", "", "-1","-1");
			selectCreatedDbTable.init();

			var selectPublishEform = new SelectPublishEform("addFormId", "addFormName", null, "N", "eform");
			selectPublishEform.init(function() {
			});
			var selectPublishEform = new SelectPublishEform("editFormId", "editFormName", null, "N", "eform");
			selectPublishEform.init(function() {
			});

			$("form").find("input[type='checkbox'],select").on("change", function () {
				var name = this.name;
				if (name == "addBtn") {
					if($(this).is(':checked')){
						$(".addArea").show();
					}else{
						$(".addArea").hide();
						$("#addFormName").val("");
						$("#addFormId").val("");
					}
				}else if (name == "editBtn") {
					if ($(this).is(':checked')) {
						$(".editArea").show();
					} else {
						$(".editArea").hide();
						$("#addFormName").val("");
						$("#addFormId").val("");
					}
				}else if(name=="orderBy"){
					refreshElseCol();
				}
			});
		});
	</script>
</body>
</html>