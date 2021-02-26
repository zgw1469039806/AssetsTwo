<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,tree,form,table";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>意见配置选择页</title>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style>
.target-selector-form {
	/* display:inline-block;*/
	width: 100%;
	height: 30px;
	padding: 6px 12px;
	font-size: 12px;
	line-height: 1.42857143;
	color: #555;
	background-color: #fff;
	border-bottom: 1px dotted #ccc;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
	-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
.target-selector-form:HOVER {
	background-color: #eeeeee;
}
#platform-bpmselect-candidateview {
	width: 100%;
	height: 300px;
	overflow: auto;
	overflow-x: hidden;
}
label {
	display: inline-block;
	max-width: 100%;
	margin-bottom: 5px;
	font-weight: 100;
}
.target-selector-form .flowname {
	width: 90%;
	float: left;
	text-align: left;
}
.target-selector-form .remove {
	width: 10%;
	float: left;
	text-align: right;
}
.target-selector-form  span {
	display: none;
	cursor: pointer;
}
.target-selector-form:hover  span {
	display: inline-block;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3">
				<ul id="flowTree" class="ztree"></ul>
			</div>
			<div class="col-sm-5" style="border-left: 1px solid #d4d4d4; border-right: 1px solid #d4d4d4;">
				<table id='ideaTable'></table>
			</div>
			<div class="col-sm-4" style="">
				<table style="width: 100%; height: 100%" border="0">
					<tbody>
						<tr height="35px">
							<td align="right" valign="bottom" style="border-bottom: 1px solid #dddddd"><span class="glyphicon glyphicon-trash" aria-hidden="true" style="cursor: pointer;" onclick="removeAll(); return false;"></span>&nbsp;</td>
						</tr>
						<tr>
							<td style="background-color: #ffffff" valign="top" align="left">
								<div id="platform-bpmselect-flow-selected"></div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript" src="avicit/platform6/bpmreform/forthird/IdeaSelectedView.js"></script>
	<script type="text/javascript">
		// 选择节点视图
		var template = '<div class="target-selector-form"  id="#id#">'
	        + '<div class="flowname">#flowname#</div>'
	        + '<div class="remove"> <a href="javascript:void(0)" onclick="remove(this)"><span class="glyphicon glyphicon-remove"></span></a>'
	        + '</div> </div>';
		var ideaSelectedView = new IdeaSelectedView({
			id:"platform-bpmselect-flow-selected",
			template: template
		});
		var treeNodeObj;
		var setting = {
			data : {
				simpleData : {
					enable : true,
					idKey : "id",
					pIdkey : "pId"
				}
			},
			callback : {
				//节点点击事件
				onClick : function(event, treeId, treeNode) {
					$("#ideaTable").setGridParam({
				    	postData:{id : treeNode.id}
				    }).trigger("reloadGrid");
				}
			}
		};
		$(function() {
			$.ajax({
				url : "platform/bpm/business/getIdeaStyleFlowList",
				data : {
					formcode : '<%=request.getParameter("formcode")%>'
				},
				type : "POST",
				dataType : "JSON",
				success : function(result) {
					treeNodeObj = $.fn.zTree.init($("#flowTree"), setting, result);
				}
			});
            setTimeout(function(){
                $("#ideaTable").jqGrid({
                    url : "platform/bpm/business/getIdeaStyleList",
                    datatype : "json",
                    mtype : "POST",
                    colModel : [ {
                        name : 'id',
                        key : true,
                        hidden : true
                    }, {
                        label : '名称',
                        name : 'title',
                        align : 'center'
                    }, {
                        label : '代码',
                        name : 'code',
                        align : 'center'
                    }, {
                        label : '节点',
                        name : 'activityName',
                        align : 'center'
                    } ],
                    height : 320,
                    altRows : true,
                    styleUI : 'Bootstrap',
                    autowidth : true,
                    onCellSelect : function(rowid, iCol, cellcontent, e) {
                        var nodes = treeNodeObj.getSelectedNodes();
                        var data = $("#ideaTable").jqGrid('getRowData',rowid);
                        var _id = nodes[0].id + "@" + data.code;
                        var _text = nodes[0].name+"("+ data.title + ")";
                        ideaSelectedView.removeStartWith(nodes[0].id + "@");
                        ideaSelectedView.addObject(_id, _text);
                    }
                });
			},500);
		});

		function getSelectedData() {
			return ideaSelectedView.getSelectedFlow();
		}

		function removeAll() {
			ideaSelectedView.removeAll();
		}

		function remove(obj) {
			ideaSelectedView.remove($(obj).parent().parent().attr("id"));
		}
	</script>
</body>
</html>
