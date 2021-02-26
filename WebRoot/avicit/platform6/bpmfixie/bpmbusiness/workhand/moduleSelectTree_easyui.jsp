<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>业务目录</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro-ie6.css" />

<style>
	.target-selector-form {
		/* display:inline-block;*/
		width: 100%;
		height: 27px;
		padding: 2px 3px;
		font-size: 13px;
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

	.target-selector-form .flowname:hover{
		background-color: #eeeeee;
	}

	#platform-bpmselect-candidateview{
		width: 100%;
		height: 310px;
		overflow: auto;
		overflow-x: hidden;
	}
	#platform-bpmselect-flow-selected{
		width: 100%;
		height: 310px;
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

	.target-selector-form span {
		display: none;
		cursor: pointer;
	}
	.target-selector-form .flowname:hover span{
		display: inline-block; zoom:1;
	}
	.target-selector-form .flowname:hover span input{
		background-color: #eeeeee;
	}

</style>
</head>

<body class="easyui-layout" data-options="fit:true,border:false" style="visibility: visible;">
	<!-- 1 流程模型库  -->
	<div data-options="region:'west'" 
	style="width: 280px; height: 100%; border-right: 3px solid #ffffff2c; background-color: #ffffff; overflow:hidden;">
		<ul id="moduleSelectTree" class="ztree" style="width: 260px; height: 100%;"></ul>
	</div>

	<!-- 2 候选流程 -->
	<div data-options="region:'center'" style="width: 260px; height: 100%;border-right: 3px solid #ffffff2c; overflow:hidden;">
		<table style="width:100%; height:83%;" border="0">

				<tr height="20px">
					<td align="left" valign="bottom" style="border-bottom: 1px solid #dddddd;font-weight:bold;">
						<span class="" style="cursor: pointer;"><h4>&nbsp;&nbsp;候选流程</h4></span>
					</td>
				</tr>

				<tr>
					<td style="background-color: #ffffff" valign="top" align="left">
						<div id="platform-bpmselect-candidateview" >
							
						</div>
					</td>
				</tr>
		</table>
	</div>

	<!-- 3 已选流程 -->
	<div data-options="region:'east'" style="width: 260px; height: 100%;border-right: 3px solid #ffffff2c; overflow:hidden;">
		<table style="width: 100%;" border="0">
			
			<tr height="20px">
				<td align="left" valign="bottom" style="width:230px; border-bottom: 1px solid #dddddd; font-weight:bold;">
					<span class="" style="cursor: pointer;"><h4>&nbsp;&nbsp;已选流程</h4></span>
			    </td>
				<td align="right" valign="center" style="border-bottom: 1px solid #dddddd;">
					<span style="cursor: pointer;" onclick="removeAll(); return false;">
					<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" iconCls="icon-trash"><span style="display:none"></span></a>
					</span>
				</td>
			</tr>
			<tr>
				<td style="background-color: #ffffff" valign="top" align="left" colspan="2">
					<div id="platform-bpmselect-flow-selected">	
									
					</div>
				</td>
			</tr>
		</table>
	</div> 
	</div>
</body>

<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js"></script>
<script src="avicit/platform6/bpmfixie/bpmbusiness/workhand/js/BpmModuleView_easyui.js" type="text/javascript"></script>
<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmcommon/flowUtils.js"></script>

<script type="text/javascript">
	// 选择节点视图
	var template = '<div class="target-selector-form" style="width: 95%;" id="#id#">'
		+ '<a href="javascript:void(0)" hidefocus="true" class="flowname" style="width:96%; height:100%; line-height:35px; text-decoration:none; color: rgb(0,0,0); cursor: default;">'
		+ '<span style="display: inline; float:left; cursor: default;">#flowname#</span>'
		+ '<span style="float:right; font-weight:bold;" onclick="remove(this)">'
		+ '<input hidefocus="true" type="button" style="color:#0000CD; font-size: 16px; border:0px; height:27px; cursor: pointer; position:relative; font-weight:bold;" value="X"></input>'
		+ '</span>'
		+ '</a>'
        + '</div>';
	var bpmModuleView = new BpmModuleView({
		id:"platform-bpmselect-flow-selected",
		template: template
	});

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
                $.ajax({
                    url: "bpm/deploy/getDeployedFlowFileLastVer",
                    data: "selectedNodeId=" + treeNode.id,
                    type: "post",
                    async: false,
					dataType: "json",
					error: function () { // 请求失败返回提示  
						layer.alert("获取失败",{
							icon: 0,
							title: ""
						});  
					},
                    success: function (backData) {
                        $("#platform-bpmselect-candidateview").empty();
                        // 已发布流程
                        var deployedList = backData.deployedList;
						var template = '<div class="target-selector-form" id="#data#" onclick="selectFlow(this);">'
                            + '<a href="javascript:void(0)" hidefocus="true" class="flowname" style="height:100%; line-height:35px; width:91%; text-decoration:none; color: rgb(0,0,0); cursor: default;">#flowname#</a>'
                            + '</div>';
                        // 已经发布流程
                        for (var i = 0; i < deployedList.length; i++) {
                            //console.log(deployedList[i]);
                            var data = deployedList[i];
                            var tmp = template.replace(/#data#/g, data.key).replace(/#flowname#/g, data.name);
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
        error: function () { // 请求失败返回提示  
        	layer.alert("获取失败",{
				icon: 0,
				title: ""
			});  
        },
        success: function (backData) {
            treeNodeObj = $.fn.zTree.init($("#moduleSelectTree" ), setting, backData);
        }
	});

  	function  removeAll() {
        bpmModuleView.removeAll();
    }

	function selectFlow(obj) {
        bpmModuleView.addObject(obj.id,$(obj).find(".flowname").text().trim());
	}

	function remove(obj) {
        bpmModuleView.remove($(obj).parent().parent().attr("id"));
	}
</script>

</html>