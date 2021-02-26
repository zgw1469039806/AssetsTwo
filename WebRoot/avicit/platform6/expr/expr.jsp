<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
	String skin = "skyblue";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>web流程设计器</title>
<link rel="stylesheet" href="<%=basePath%>static/js/platform/designer_simple/dhtmlx/codebase/dhtmlx.css">
<script>
	//全局变量
	var _basePath = "<%=basePath%>";
</script>
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap-theme.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.css" />
<link rel="stylesheet" type="text/css" href="static/h5/singleLayOut/themes/easyui-bootstrap.css">
<link rel="stylesheet" type="text/css" href="static/h5/layer-v2.3/layer/skin/layer.css">

<!-- <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/> -->

<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro.css"/>

<script type="text/javascript" src="static/js/platform/component/common/json2.js"></script>
<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="static/h5/bootstrap/3.3.4/js/bootstrap.js"></script>
<script type="text/javascript" src="static/h5/common-ext/avic.ajax.js"></script>
<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>


<style>
html,body {
	width: 100%;
	height: 100%;
	margin: 0px;
	overflow: hidden;
}
textarea{
	width:100%;
	margin:2px;
	border:1px solid #6497e9;
}
.expressionDisplay{
	width:97%;
	border:1px solid #6497e9;
	height:165px;
	position: absolute;
	background-color: #ffffff;
	box-shadow:3px 3px 2px #a5c7fe;
	-moz-box-shadow:3px 3px 2px #a5c7fe;
	-webkit-box-shadow:3px 3px 2px #a5c7fe;
	border-bottom-left-radius:5px;
	border-bottom-right-radius:5px;
	margin-left:2px;
	margin-top:-6px;
	display:none;
	overflow: auto;
}

.variableDisplay{
	width:97%;
	border:1px solid #6497e9;
	height:165px;
	position: absolute;
	background-color: #ffffff;
	box-shadow:3px 3px 2px #a5c7fe;
	-moz-box-shadow:3px 3px 2px #a5c7fe;
	-webkit-box-shadow:3px 3px 2px #a5c7fe;
	border-bottom-left-radius:5px;
	border-bottom-right-radius:5px;
	margin-left:2px;
	margin-top:-6px;
	display:none;
	overflow: auto;
}
.ztree li span.button.icon_ico_docu{
	margin-right:2px; 
	background: url(static/images/platform/common/function.gif) no-repeat scroll 0 0 transparent; 
	vertical-align:top; 
	*vertical-align:middle
}  
</style>
<script type="text/javascript">
	var zTreeObj;
	var setting = {
			check: {enable: false},
			callback : {
				beforeExpand : function(treeId, node){
					zTreeObj.setting.async.url = "bpm/business/getExprTreeJsonData"
				},
				onClick : function(event, treeId, node){
					$("#edit").insertAtCaret(node.name);
					$(".expressionDisplay").hide();
				}
			},
			data : {
				simpleData : {
					enable : true
				},
				showTitle : true,
				key : {
					title : 'title'
				}
			},
			async: {
				enable: true,
				type: "post",
				url:"bpm/business/getExprTreeJsonData",
				autoParam: ["id"],
				dataType: 'json'
			}
	};
	var zNodes = [{
			name:"expr表达式", 
			id:"root",
			isParent:true,
			open:true,
			attributes : {
				nodeType : 'group'
			}
		}];
	$(document).ready(function(){
		var processId = "${processId}";
		if(processId){
			parent.$("#" + processId + " table[name='table-flow-variable']").find("input[name='dataValue']").each(function () {
				var processVar = JSON.parse($(this).val());
				var $li = $("<li>"+processVar.alias+"</li>");
				$li.attr("varId",processVar.name);
				$li.attr("varName",processVar.alias);
				$li.on("click",function(){
					$("#edit").insertAtCaret("\{"+$(this).attr("varId")+"\}");
					$(".variableDisplay").hide();
				});
				$("#variableList").append($li);

			});
			var globalformid = parent.$('#' + processId).find('#guan_lian_biao_dan').val();
			avicAjax.ajax({
				url: "bpm/designer/getProcessFormFieldsForVar",
				data:{
					globalformid:globalformid,
					isVar:'1'
				},
				type: "post",
				dataType: "json",
				success: function (backData) {
					if (backData.fields == '') {

					} else {
						var formFields = JSON.parse(backData.fields);
						for (var i = 0; i < formFields.length; i++) {
							var $li = $("<li>"+formFields[i].colLabel+"</li>");
							$li.attr("varId",formFields[i].colName);
							$li.attr("varName",formFields[i].colLabel);
							$li.on("click",function(){
								$("#edit").insertAtCaret("\{"+$(this).attr("varId")+"\}");
								$(".variableDisplay").hide();
							});
							$("#variableList").append($li);
						}
					}
				}
			});
		}

	   zTreeObj = $.fn.zTree.init($("#exprTree"), setting, zNodes);
	   
	   $("#edit").keyup(function(event){
		  if(event.keyCode == 50){
			  $(".variableDisplay").hide();
			  $(".expressionDisplay").show(function(){
				  //显示时，展开树节点
				  expandAll();
			  });
		  }else if(event.keyCode == 51){
			   $(".expressionDisplay").hide();
			   $(".variableDisplay").show();
		  }
	   });
	});
	//展开所有节点
	function expandAll() {
		var zTree = $.fn.zTree.getZTreeObj("exprTree");
		zTree.expandNode(zTree.getNodes()[0], true, false, false);
		setTimeout(function(){
			var nodes = zTree.getNodes()[0].children;
			for(var i = 0 ; i < nodes.length ; i++){
				zTree.expandNode(nodes[i], true, false, false);
			}
		}, 500);
	}
	function getValue(){
		return $("#edit").val();
	}
	(function($) {  
	    $.fn.extend({  
	        insertAtCaret: function(myValue) {  
	            var $t = $(this)[0];
	              //ie  
	            if (document.selection) {  
	                this.focus();  
	                sel = document.selection.createRange();  
	                sel.text = myValue;  
	                this.focus();  
	            } else if ($t.selectionStart || $t.selectionStart == "0") {  // !ie
	                var startPos = $t.selectionStart;  
	                var endPos = $t.selectionEnd;  
	                var scrollTop = $t.scrollTop; 
	                if($t.value.length > 0 && $t.value.substring(startPos - 1, startPos) == '@'){
	                	$t.value = $t.value.substring(0, startPos - 1) + myValue + $t.value.substring(endPos, $t.value.length);  
	                } else {
	                	$t.value = $t.value.substring(0, startPos) + myValue + $t.value.substring(endPos, $t.value.length);  
	                }
	                this.focus();  
	                $t.selectionStart = startPos + myValue.length;  
	                $t.selectionEnd = startPos + myValue.length;  
	                $t.scrollTop = scrollTop;  
	            } else {  
	                this.value += myValue;  
	                this.focus();  
	            }  
	        }  
	    });
	})(jQuery);  
</script>
</head>
<body>
	<div style="width:97%;">
		<textarea rows="4" id="edit">${value}</textarea>
	</div>
	<div class="expressionDisplay">
		<ul id="exprTree" class="ztree"></ul>
	</div>
	<div class="variableDisplay">
		<ul id="variableList"></ul>
	</div>
	<div style="width:97%;">
		<span style="color:gray;font-size: 10px;">&nbsp;&nbsp;--支持平台内部的rule表达式组合,如:@{userName},获取当前用户名称；或者，rule表达式与任何字符进行拼装,如:@{userName}在@{date}提交的任务申请.</span>
		<br/>
		<span style="color:gray;font-size: 10px;">&nbsp;&nbsp;--支持流程变量,如:\#{Data_1}.</span>
		<br/>
		<span style="color:gray;font-size: 10px;">&nbsp;&nbsp;--提示:在微软中文输入法下,若@或#无法激活表达式下拉菜单,请切换到英文模式下操作.</span>
	</div>
</body>
</html>
