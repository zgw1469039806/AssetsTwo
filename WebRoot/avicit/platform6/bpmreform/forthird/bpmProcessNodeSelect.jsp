<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "tree,common,form";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>流程节点</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

	<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
	<link rel="stylesheet" href="static/h5/skin/iconfont/iconfont.css"/>
	<link rel="stylesheet" href="avicit/platform6/bpmreform/bpmdeploy/css/style.css"/>

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

		#platform-bpmselect-candidateview{
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
		.target-selector-form .flowname{
			width: 90%;
			float:left;
			text-align: left;

		}

		.target-selector-form .remove{
			width: 10%;
			float:left;
			text-align: right;
		}
		.target-selector-form  span {
			display:none;
			cursor: pointer;
		}
		.target-selector-form:hover  span {display:inline-block;}


	</style>


</head>

<body>
<div class="container-fluid">
	<div class="row">
		<div class="col-xs-5" style="border-right: 1px solid #d4d4d4;">
			<ul id="processNodeTree" class="ztree"></ul>
		</div>
		<div class="col-xs-7">
			<table style="width: 100%; height: 100%" border="0">
				<thead></thead>
				<tbody>
				<tr height="35px">
				    <td align="left" valign="bottom" style="border-bottom: 1px solid #dddddd;font-weight:bold;">
				   		 已选节点
				    </td>
					<td align="right" valign="bottom" style="border-bottom: 1px solid #dddddd">
						<span class="glyphicon glyphicon-trash" aria-hidden="true" style="cursor: pointer;" onclick="removeAll(); return false;"></span>&nbsp;
					</td>
				</tr>
				<tr>
					<td style="background-color: #ffffff" valign="top" align="left" colspan="2">
						<div id="platform-bpmselect-flow-selected">
  							<%--<div class="target-selector-form "  id="402882015d3149ae015d315e975a0233_user_402882015d3149ae015d315e975a0233" >
								<div class="flowname">邓苏</div>
								<div class="remove">
									<a href="javascript:void(0)">
										<span class="glyphicon glyphicon-remove"></span>
									</a>
								</div>
							</div>--%>

						</div>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmreform/forthird/BpmProcessNodeSelect.js" type="text/javascript"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
	// 选择节点视图
	var template = '<div class="target-selector-form"  id="#id#">'
        + '<div class="flowname">#flowname#</div>'
        + '<div class="remove"> <a href="javascript:void(0)" onclick="remove(this)"><span class="glyphicon glyphicon-remove"></span></a>'
        + '</div> </div>';
	var bpmModuleView = new BpmModuleView({
		id:"platform-bpmselect-flow-selected",
		template: template
	})

    var treeNodeObj;
    var setting = {
   		view: {
   			selectedMulti: false
   		},
        check: {
        	autoCheckTrigger:true,
			enable: true
        },
        async: {
            enable: true,
            url: "bpm/deploy/getProcessNodeTree",//异步请求树子节点url
            autoParam: ["id","nodeType"]//父节点id
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdkey: "pId"
            }
        },
        callback: {
        	onAsyncError:  function(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown){ layer.alert(XMLHttpRequest);},
            //节点点击事件
            onClick: function (event, treeId, treeNode) {
            	if(treeNode.nodeType=='processNode'){
                	selectFlow(treeNode);
                }
            },
			onCheck: function (event, treeId, treeNode) {
                if(treeNode.nodeType=='processNode'){
                	if(treeNode.checked){
                		selectFlow(treeNode);
                    }else{
                    	remove(treeNode);
                    }
                	
                }
			}
        }
    };

    //手动请求根节点数据
    $.ajax({
        url: "bpm/deploy/getProcessNodeTree",
        data: "id=root",
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            treeNodeObj =   $.fn.zTree.init($("#processNodeTree" ), setting, backData);
        }
    });

  	function  removeAll() {
        bpmModuleView.removeAll();
    }

	function selectFlow(obj) {
        bpmModuleView.addObject(obj.id,obj.name);
	}

	function remove(obj) {
        bpmModuleView.remove(obj.id);
	}

</script>

</html>

