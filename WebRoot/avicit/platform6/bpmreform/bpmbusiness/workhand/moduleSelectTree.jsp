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
<title>业务目录</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

	<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
	<link rel="stylesheet" href="static/h5/skin/iconfont/iconfont.css"/>
	<link rel="stylesheet" href="avicit/platform6/bpmreform/bpmdeploy/css/style.css"/>

	<style>

		.target-selector-form {
			display:inline-block;
			width: 100%;
			min-height: 30px;
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
			height: 175px;
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
			word-break:break-all;
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


		#moduleSelectTree{
			height: 210px;
		}
		#platform-bpmselect-flow-selected{
			height: 175px;
			overflow-x: hidden;
			overflow: auto;
		}
	</style>


</head>

<body>
<div class="container-fluid">
	<div class="row">
		<div class="col-xs-4" style="border-right: 1px solid #d4d4d4;width:260px;height:210px;overflow: auto;">
			<ul id="moduleSelectTree" class="ztree"></ul>
		</div>
		<div class="col-xs-4" style="height: 100%;border-right: 1px solid #d4d4d4;">
			<table style="width: 100%; height: 100%" border="0">
				<thead></thead>
				<tbody>
				<tr height="35px">
					<td align="left" valign="bottom" style="border-bottom: 1px solid #dddddd;font-weight:bold;">
						<span class="" aria-hidden="true" style="cursor: pointer;" >候选流程</span>
					</td>
				</tr>
				<tr>
					<td style="background-color: #ffffff" valign="top" align="left">
						<div id="platform-bpmselect-candidateview" >
							<%--<div class="target-selector-form "  id="402882015d3149ae015d315e975a0233_user_402882015d3149ae015d315e975a0233" onclick="javascript:void(0)">
								<div class="flowname">邓苏</div>
							</div>--%>

						</div>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<div class="col-xs-4">
			<table style="width: 100%; height: 100%" border="0">
				<thead></thead>
				<tbody>
				<tr height="35px">
				    <td align="left" valign="bottom" style="border-bottom: 1px solid #dddddd;font-weight:bold;">
				   		 已选流程
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
<script src="avicit/platform6/bpmreform/bpmbusiness/workhand/js/BpmModuleView.js" type="text/javascript"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
	var isShowParent = decodeURIComponent(flowUtils.getUrlQuery("isShowParent"));
	// 选择节点视图
	var template = '<div class="target-selector-form"  id="#id#" type="#type#">'
        + '<div class="flowname">#flowname#</div>'
        + '<div class="remove"> <a href="javascript:void(0)" onclick="remove(this)"><span class="glyphicon glyphicon-remove"></span></a>'
        + '</div> </div>';
	var bpmModuleView = new BpmModuleView({
		id:"platform-bpmselect-flow-selected",
		template: template
	})

    var treeNodeObj;
    var setting = {
        check: {
            enable: false,
            chkStyle: "checkbox",
            chkboxType: { "Y": "ps", "N": "ps" }
        },
        async: {
            enable: true,
            url: "bpm/deploy/getFlowTypeTree",//异步请求树子节点url
            autoParam: ["id"]//父节点id
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdkey: "pId"
            }
        },
        callback: {
            //节点点击事件
            onClick: function (event, treeId, treeNode) {
            	$("#platform-bpmselect-candidateview").empty();
            	if('1'==isShowParent && !('-1'==treeNode.id)){
            		var div1 = '<div class="target-selector-form" type="0" id="'+treeNode.id+'" onclick="selectFlow(this)">'
                        + '<div class="flowname">'+treeNode.name+'(分类)</div>'
                        + '</div>';
            		$("#platform-bpmselect-candidateview").append(div1);
                }
                $.ajax({
                    url: "bpm/deploy/getDeployedFlowFileLastVer",
                    data: "selectedNodeId=" + treeNode.id,
                    type: "post",
                    async: false,
                    dataType: "json",
                    success: function (backData) {
                        var isPdId = flowUtils.getUrlQuery("isPdId");
                        //已发布流程
                        var deployedList = backData.deployedList;
						var template = '<div class="target-selector-form" type="1" id="#data#" onclick="selectFlow(this)">'
                            + '<div class="flowname">#flowname#</div>'
                            + '</div>';
//                        已经发布流程
                        for (var i = 0; i < deployedList.length; i++) {
                            //console.log(deployedList[i]);
                            var data = deployedList[i];
							var tmp = null;
                            if(isPdId == "true"){
								tmp = template.replace(/#data#/g, data.pdId).replace(/#flowname#/g, data.name);
							}else {
								tmp = template.replace(/#data#/g, data.key).replace(/#flowname#/g, data.name);
							}
                            $("#platform-bpmselect-candidateview").append(tmp);
                        }
                    }
                });
            }
        }
    };

    //手动请求根节点数据
    $.ajax({
        url: "bpm/deploy/getFlowTypeTree",
        data: "id=root",
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            treeNodeObj =   $.fn.zTree.init($("#moduleSelectTree" ), setting, backData);
        }
    });

  	function  removeAll() {
        bpmModuleView.removeAll();
    }

	function selectFlow(obj) {
        bpmModuleView.addObject(obj.id,$(obj).find(".flowname").text().trim(),$(obj).attr("type"),isShowParent);
	}

	function remove(obj) {
        bpmModuleView.remove($(obj).parent().parent().attr("id"));
	}

</script>

</html>

