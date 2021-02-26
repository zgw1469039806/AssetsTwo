<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap-fixie8-fonticon.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap-theme.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.css" />
<link rel="stylesheet" type="text/css" href="static/h5/singleLayOut/themes/easyui-bootstrap.css">
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro.css"/>

<script type="text/javascript" src="static/js/platform/component/common/json2.js"></script>
<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="static/h5/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<script type="text/javascript" src="avicit/platform6/console/menu/js/MenuTree.js" ></script>


<style type="text/css">
 .menuSelectDiv{
	width: 48%;
    border: 1px solid #7b9dd4;
    height: 165px;
    position: absolute;
    background-color: #ffffff;
    box-shadow: 3px 3px 2px #a5c7fe;
    -moz-box-shadow: 3px 3px 2px #a5c7fe;
    -webkit-box-shadow: 3px 3px 2px #a5c7fe;
    border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
    margin-left: 2px;
    margin-top: 1px;
    display: none;
    overflow: auto;
    z-index:9999999999;
 }

 tr{
 	height: 50px;
 }
</style>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false" style="margin-left: 15%;">
    <table class="form_commonTable">

		<tr id="publicTypeDiv">
			<th width="20%" style="word-break: break-all; word-warp: break-word;"><label for="publicType">发布方式:</label></th>
			<td width="70%">
				<div class="input-group" style="width: 100%;">
					<label class="radio-inline" title=""> <input name="publicType" title="" type="radio" value="0">发布视图状态</label><label
						class="radio-inline" title=""> <input name="publicType" title="" type="radio" value="1" checked="checked">发布到菜单</label>
				</div>
			</td>
		</tr>
		<tr class="toMenu">
			<th width="20%" style="word-break: break-all; word-warp: break-word;" nowrap="nowrap" align="right">
				<label for="viewName">菜单目录：</label>
			</th>
			<td width="70%">
				<div class="input-group" style="width: 100%;"> 
						<input type="hidden" class="form-control input-sm" id="menuCombox" name="menuCombox" />
						 <input type="text" class="form-control input-sm" id="menuComboxText" name="menuComboxText" />
						 <div class="input-group-addon" id="menuComboxButton"><i class="glyphicon glyphicon-triangle-bottom"></i></div>
				 </div>
				 <div class="menuSelectDiv">
					<ul id="consoleMenu" class="ztree"></ul>
				 </div>
			</td>
		</tr>
		<tr class="toMenu">
			<th width="20%" style="word-break: break-all; word-warp: break-word;" align="right">
				<label for="viewDesc">编码：</label>
			</th>
			<td width="70%">
				<input class="form-control input-sm" type="text" name="viewCode" id="viewCode" title="编码" readonly value="${viewCode}"/>
			</td>
		</tr>
		<tr class="toMenu">
			<th width="20%" style="word-break: break-all; word-warp: break-word;" align="right">
				<label for="viewDesc">名称：</label>
			</th>
			<td width="70%">
				<input class="form-control input-sm" type="text" name="viewName" id="viewName" title="名称" value="${viewName}"/>
			</td>
		</tr>
		<tr class="toMenu">
             <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="openType">打开方式:</label></th>
             <td width="70%">
                 <select id="openType" name="openType" class="form-control input-sm" title= "打开方式">
                     <option value="_mainframe" >mainframe</option>
                     <option value="_blank">blank</option>
	                     <option value="_self" >self</option>
	                     <option value="_top" >top</option>
                 </select>
             </td>
         </tr>
	</table>
	 <input type="hidden" id="id" name="id" value="${id}">
	 <input type="hidden" id="menuParentId" name="menuParentId">
	 <input type="hidden" id="currentApplicationAndOrg" name="currentApplicationAndOrg" value="${currentApplicationAndOrg}">
</div>

<script type="text/javascript">
$(document).ready(function(){
    var type = "${type}";
    if(type=="menu"){
        $("#publicTypeDiv").hide();
    }
	$("#menuComboxText").click(function(){
		$(".menuSelectDiv").toggle();
	});
	$("#menuComboxButton").click(function(){
		$(".menuSelectDiv").toggle();
	});
    $(":radio[name=publicType]").change(function(){
        var publicType = this.value;

        if (publicType == "0"){
            $(".toMenu").hide();
        }else{
            $(".toMenu").show();
        }
    });
	//菜单树初始化
	var menuTree = new MenuTree('consoleMenu','console/menu/console/' + getCurrentApplicationAndOrg(),'','txt');
	menuTree.setOnSelect(function(treeNode) {
			pId=treeNode.id;
			if(pId == 2){
				return;
			}
			$("#menuCombox").val(treeNode.id);
			$("#menuComboxText").val(treeNode.text);//("<option value='" + treeNode.id + "' selected>" + treeNode.text + "</option>");
			$(".menuSelectDiv").hide();
		}).init();
});
function getPublicType(){
    return $("input[name='publicType']:checked").val();
}
function getSelectMenu(){
	return $("#menuCombox").val();
}
function getViewName(){
	return $("#viewName").val();
}
function getViewId(){
	return $("#id").val();
}
function getViewCode(){
	return $("#viewCode").val();
}
function getOpenType(){
	return $("#openType").val();
}
function getCurrentApplicationAndOrg(){
	return $("#currentApplicationAndOrg").val();
}
function getUrl(){
	var url = "platform/eform/bpmsCRUDClient/toViewJsp/" + getViewCode();
	return url;
}
</script>
</body>
</html>
