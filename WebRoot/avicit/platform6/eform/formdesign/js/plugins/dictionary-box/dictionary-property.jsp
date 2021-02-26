<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
    String importlibs = "common,table,form";
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
	String skin = "skyblue"; 
%>
<!DOCTYPE html>
<html>
<head>
    <title>JS文件扩展</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <link rel="stylesheet" href="<%=basePath%>static/js/platform/designer_simple/dhtmlx/codebase/dhtmlx.css">

    
    <link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap.css"/>
	<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap-theme.css"/>
	<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.css" />
	<link rel="stylesheet" type="text/css" href="static/h5/singleLayOut/themes/easyui-bootstrap.css">
	<!-- <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/> -->
	    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/theme.css"/>
    
    <link rel="stylesheet" type="text/css" href="avicit/platform6/eform/bpmsformmanage/css/tabs.css"/>
    
    
    
	<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro.css"/>
	<jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
	<jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
    <script type="text/javascript" src="avicit/platform6/eform/formdesign/js/plugins/dictionary-box/DataTree.js" ></script>
    <script src="avicit/platform6/modules/system/connectcenter/js/ConnectTypeTree.js"></script>
    <script>
	var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
	var isMain = "${param.isMain}";
	var selectType = "${param.selectType}";
	</script>
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
		width:71%;
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
	
	
	.ztree li span.button.add{margin-right:2px;background-position:-144px 0;vertical-align:top;*vertical-align:middle}
	
	.dataSelectDiv{
	width: 72%;
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
 
 
	</style>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false" style="padding: 8px 0;">
    <input id="tableId" value="DYN_HY_01" type="hidden"/>
        <div class="twoTabNav" style="height: 100%">
             <!-- 标签主体Start -->
             <!-- bootstrap风格 -->
             <ul class="nav nav-tabs">
                 <li class="active" id="eformTab">
                     <a href="javascript:void(0)">基本配置</a>
                 </li>
                 <li id="noEformTab">
                     <a href="javascript:void(0)">关系映射</a>
                 </li>
                 <li id="detailTab">
                     <a href="javascript:void(0)">详细页面配置</a>
                 </li>
             </ul>
             <ul class="tab-cont" style="height: 90%">
                <li style="height: 100%" id="eformCont">
                    <div class="demoCont">
                    	<form id='form'>
                        <table border="0" class="form_commonTable1">
							  <tbody>
							   <tr>
							    <td style="width:20%; text-align: right;"><i class='required'>*</i>每页行数：</td>
							    <td style="width:30%;" >
								     <div class="input-group input-group-sm spinner" data-trigger="spinner">
								     <input type="text" class="form-control" id="rowCount" required name="rowCount" data-min="1" data-max="1000" data-precision="0" title="rowCount" maxlength="10">
								      <!-- <input type="text" name="rowCount" id="rowCount" value="10"  class="form-control input-sm"> -->
								     	<span class="input-group-addon number-box-act"> <a href="javascript:" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a> <a href="javascript:" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a> </span>
								     </div> 
							    </td>
							    <td>

							    </td>
							    <td>
							    	<label class="control-label"  id="isMutiDiv">
			                            <input name="isMuti" id="isMuti" type="checkbox"  class="ace" value="Y">
			                            <span class="lbl">&nbsp;多选</span>
			                        </label>
			                        <label class="control-label"  id="waitSelectDiv">
			                            <input name="waitSelect" id="waitSelect" type="checkbox"  class="ace" value="Y">
			                            <span class="lbl">&nbsp;支持待选</span>
			                        </label>
							    </td>
							   </tr>
							   <tr>
							   	 <td style="width:20%; text-align: right;"><i class='required'>*</i>数据源：</td>
							   	 <td style="width:50%;" >
							   	 	<div class="input-group" style="width: 100%;"> 
											<input type="hidden" class="form-control input-sm" id="dataCombox" name="dataCombox" />
											<input type="hidden" class="form-control input-sm" id="dataComboxType" name="dataComboxType" />
											<input type="text" class="form-control input-sm" id="dataComboxText" name="dataComboxText" /> 
											<div class="input-group-addon" id="dataComboxButton"><i class="glyphicon glyphicon-triangle-bottom"></i></div>
									 </div>
									 <div class="dataSelectDiv">
										<ul id="consoleData" class="ztree"></ul>
									 </div>
							     </td>
							     <td>
							    	
							    	</td>
							    	<td>
							     	<a id="jslist_checK" href="javascript:void(0)"
								                       class="btn btn-primary form-tool-btn btn-sm" role="button"
								                       title="检测SQL"><i class="fa fa-check"></i> 检测SQL</a>
							     </td>
							   </tr>
							   <tr>
							   	 <td style="width:20%; text-align: right;"><i class='required'>*</i>查询语句：</td>
							   	 <td style="width:30%;" colspan="3">
							        <div class="input-group-sm">
							            <textarea rows=4  name="queryStatement"  id="queryStatement" required  style="width: 100%;" ></textarea>
							        </div> 
							        <div class="expressionDisplay">
										<ul id="exprTree" class="ztree"></ul>
									</div>
									<div style="width:97%;"><span style="color:gray;font-size: 10px;">&nbsp;&nbsp;--支持平台内部的rule表达式组合,如:@{userName},获取当前用户名称；</br>&nbsp;&nbsp;--请遵循SQL语法，请对表达式加单引号.</span></div>
							     </td>
							     
							   </tr>
							   <tr>
			          		   		<td style="width:20%; text-align: right;">加载完成JS脚本：</td>
								   	 <td style="width:30%;" colspan="3">
								        <div class="input-group-sm">
								            <textarea rows=3  name="jsSuccess"  id="jsSuccess"  style="width: 100%;" ></textarea>
								        </div>
								     </td>
			          		   </tr>
							   <tr>
			          		   		<td style="width:20%; text-align: right;">录入前JS脚本：</td>
								   	 <td style="width:30%;" colspan="3">
								        <div class="input-group-sm">
								            <textarea rows=3  name="jsBefore"  id="jsBefore"  style="width: 100%;" ></textarea>
								        </div> 
								     </td>
			          		   </tr>
			          		   <tr>
			          		   		<td style="width:20%; text-align: right;">录入后JS脚本：</td>
								   	 <td style="width:30%;" colspan="3">
								        <div class="input-group-sm">
								            <textarea rows=3  name="jsAfter"  id="jsAfter"  style="width: 100%;" ></textarea>
								        </div> 
								     </td>
			          		   </tr>
							  </tbody>
							 </table>
						</form>
                    </div>
                </li>
                <li style="height: 100%" id="noEformCont">
                    <div class="demoCont" class="">
			          	<table  style="table-layout: fixed;margin: 0;width: 100%; height: 100px;">
			          		<tr id="tabletr">
				    			<td style="width:85%;" colspan="4"> 
				    				<table style="table-layout: fixed;margin: 0;width: 100%;">
								      <tbody>
								       <tr>
								        <td>
								            <div id="tableToolbar" class="tollbar">
								                <div>
								                    <a id="jslist_insert" href="javascript:void(0)"
								                       class="btn btn-primary form-tool-btn btn-sm" role="button"
								                       title="添加"><i class="fa fa-plus"></i> 添加</a>
								                    <a id="jslist_del" href="javascript:void(0)"
								                       class="btn btn-primary form-tool-btn btn-sm" role="button"
								                       title="删除"><i class="fa fa-trash-o"></i> 删除</a>
								                </div>
								            </div>
								          <table id="propertytable"></table>
								           </td>
								       </tr>
								      </tbody>
								     </table>
				    			</td>
				    		   </tr>
			          	</table>
			          
                    </div>
                </li>
                <li style="height: 100%" id="detailCont">
                    <div class="demoCont" class="">
                    	<form id='form1'>
			          	<table border="0" class="form_commonTable1">
							  <tbody>
								   <tr>
								    <td style="width:20%; text-align: right;"><i class='required'>*</i>是否配置详情：</td>
								    <td style="width:30%;" >
									     <select class="form-control input-sm" id="inputChk" name="inputChk" title="是否配置详情">
				                        		<option value="N">否</option>
				                        		<option value="Y">是</option>
				                        	</select>
								    </td>
								    <td colspan="2">

								    </td>
								   </tr>
							  		<tr id="inputDetailDiv">
								    <td style="width:20%; text-align: right;"><i class='required'>*</i>是否输入详情：</td>
								    <td style="width:30%;" >
									     <select class="form-control input-sm" id="inputDetail" name="inputDetail" title="是否配置详情" onchange="onChangeInputDetail(this)">
				                        		<option value="N">否</option>
				                        		<option value="Y">是</option>
				                        	</select>
								    </td>
								    <td style="width:20%; text-align: right;"><i class='required'>*</i>关联字段：</td>
								    <td style="width:30%;" >
				                       	 <select class="form-control input-sm" name="detail" id="detail" style="width:100%">
		                        		 </select>
								    </td>
								   </tr>
								   <tr id="detailpageDiv">
								    <td style="width:20%; text-align: right;"><i class='required'>*</i>详情页面：</td>
								    <td style="width:30%;" colspan="3">
				                       	 <input type="hidden" name="detailpagefileId" id="detailpagefileId"/>
								    	 <input type="text" class="form-control input-sm" id="detailpagefileName" name="detailpagefileName"   readonly="readonly" title="字段_1" maxlength="50" onclick="clickDdetailPagefile()">
								    	 <textarea class="form-control input-sm " style=" display: none;" rows="2" id="detailpagePath"  name="detailpagePath" title="字段_6" maxlength="4000"></textarea>
								    </td>
								   </tr>
							  </tbody>
							 </table>
			          	</form>
                    </div>
                </li>
            </ul>
             
        </div>

</div>

<script src="static/js/platform/eform/common.js"></script>
<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
<script type="text/javascript" src="static/js/platform/eform/jqgridValidate.js"></script>
<script type="text/javascript" src="avicit/platform6/eform/formdesign/js/plugins/dictionary-box/dictionary-property.js"></script>
<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js"></script>
<script>
var eformValidate = false;
var noEformValidate = false;
var detailValidate = false;
var zTreeObj;
var dataJsonList;
var initFirstFlag = true;


$(document).ready(function () {
	$("#eformTab").removeClass('active');
    $("#eformCont").removeClass('active');
    $("#noEformTab").addClass('active');
    $("#noEformCont").addClass('active');

    /*
    if(selectType == "2"){
    	$("#selectMutiDiv").show();
    }else{
    	$("#selectMutiDiv").hide();
    }
    */
    //setTimeout(function () { $('#eformTab').trigger("click"); }, 1000);
    
    zTreeObj = $.fn.zTree.init($("#exprTree"), setting, zNodes);
	//var newNode = { id:"fieldId", pId:"1", name: "testnewNode1" };
	//刘炎昆增加，视图传参为2，不展示主表字段参数
	if (isMain != 2) {
		var rootNode = zTreeObj.getNodeByTId("1");
		var formFieldNode = zTreeObj.addNodes(rootNode, {id: "formFieldNode", parentid: rootNode.id, name: "主表单变量"});
		//
		var nameJson = {};
		var doms = parent.editorUtil.getMainTableDomAttr();
		for (var dom in doms) {
			if (dom != "clone") {
				zTreeObj.addNodes(formFieldNode[0], {
					id: "doms[dom].colName",
					parentid: formFieldNode[0].id,
					name: "field{" + doms[dom].colName + "}",
					iconSkin: "icon"
				});
			}
		}
	}

	   $("#queryStatement").keyup(function(event){
		  if(event.keyCode == 50){
			  $(".expressionDisplay").show(function(){
				  //显示时，展开树节点
				  expandAll();
			  });
		  }
	   });
    $("#queryStatement").click(function(){
        $(".expressionDisplay").hide();
	});
	   
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
    
    $("#dataComboxText").click(function(){
		$(".dataSelectDiv").toggle();
	});
	$("#dataComboxButton").click(function(){
		$(".dataSelectDiv").toggle();
	});
  //菜单树初始化
    //connectTypeTree = new ConnectTypeTree("consoleData");
	var dataTree = new DataTree('consoleData','eform/plugin/getDataTree','','txt');

	dataTree.setOnSelect(function(treeNode) {
			if(treeNode.nodeType == "" || treeNode.nodeType == undefined){
				return false;
			}
			pId=treeNode.id;
			if(pId == 2){
				return;
			}
			$("#dataCombox").val(treeNode.id);
			$("#dataComboxText").val(treeNode.text);//("<option value='" + treeNode.id + "' selected>" + treeNode.text + "</option>");
			$("#dataComboxType").val(treeNode.nodeType);
			$(".dataSelectDiv").hide();
		}).init();
});



var setting = {
		check: {enable: false},
		callback : {
			beforeExpand : function(treeId, node){
				zTreeObj.setting.async.url = "bpm/business/getExprTreeJsonData"
			},
			onClick : function(event, treeId, node){
				$("#queryStatement").insertAtCaret(node.name);
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
	return $("#queryStatement").val();
}


function getPar($this){
    if(!$this) return false;
    if($this.parents().hasClass('tab-cont')){
        return getPar($this.parents('.tab-cont:last'));
    }else if($this.parent().hasClass('nav-tabs')){
        return $this.parent();
    }
    return $this.parent().find('>.nav-tabs');
}
function setHeight($this){
    var par = getPar($this);
    if(!par) return false;
    var fH = par.parent().height();
    var fcont = $this.parent().siblings('.tab-cont');

    par.parent().find('.tab-cont').removeAttr('style');
    fcont.height(fH - (fcont.offset().top - par.offset().top));
}

$('.nav-tabs>li').on('click',function(){
    var that = $(this);

	if(that.context.id == "detailTab"){
		initDetailSelect();
	}

    //切换标签
    that.addClass('active')
        .siblings('li')
        .removeClass('active')
        .parent('.nav-tabs')
        .siblings('.tab-cont')
        .find('>li:eq('+that.index()+')')
        .addClass('active')
        .siblings('li')
        .removeClass('active'); 
    // 设置高度
  	//  setHeight($(this));
}); 
</script>

</body>

</html>