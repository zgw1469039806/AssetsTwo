<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";	
%>
<html>
<head>
<title>系统列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#form1{
  margin-top:55px;
}
.layui-layer-btn .layui-layer-btn0 {
    border-color: #4898d5;
    background-color: #2fad95!important; 
    color: #fff;
}
</style>
</head>

<body class="easyui-layout"  fit="true">
<div data-options="region:'north',split:false,border:false" style="height: 45px;margin-right:20px">
	<span></br></span>
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span>方式：</span> 
    <label class="radio-inline">
      <input type="radio"  value="1" class="merchantzc_radio" checked name="changeType">转换  
    </label>
    <label class="radio-inline">
      <input type="radio"  value="0" class="merchantzc_radio" name="changeType">绑定
    </label>
</div>
<div id="change" data-options="region:'center',split:true,border:false">
	<form id='form' enctype="multipart/form-data" action="<c:url value='/bpmSam/bpmn2jbpm/operation/conversion'/>" method="post">
		<table class="form_commonTable" width="70%">
			<input type="hidden" id="changeSign" name="changeSign">
			<tr>
				<th width="15%" style="word-break: break-all; word-warp: break-word;"><label for="wordBody">BPMN文件:</label></th>
				<td width="55%">
					<input type="file" class="file" name="wordBody" id="wordBody" onchange="execute()"/>
				</td>
			</tr>
			<tr>
				<th style="word-break: break-all; word-warp: break-word;"><label for="bpmName">流程名称:</label></th>
				<td>
					<input title="" class="form-control input-sm" type="text" name="bpmName" id="bpmName" />
				</td>
			</tr>
			<tr>
				<th  style="word-break: break-all; word-warp: break-word;"><label for="bpmType">模型分类:</label></th>
				<td >
					<input type="hidden" id="epcId" name="epcId">
					<input type="hidden" id="formId" name="formId">
   					<input type="text" id="bpmType" name="bpmType" placeholder="请选择模型分类" class="form-control" readonly>
				</td>
			</tr>
			<tr>
				<th style="word-break: break-all; word-warp: break-word;"><label for="desc">描述:</label></th>
				<td>
					<textarea title="" class="form-control input-sm" name="desc" id="desc" style="height:80px"></textarea>
				</td>
			</tr>
		</table>
	</form>
</div>
<div id="changeButton" data-options="region:'south',border:false" style="height: 60px;">
	<div id="toolbar"
		class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
		<table class="tableForm" style="border:0;cellspacing:1;width:100%">
			<tr>
				<td width="50%" style="padding-right:4%;" align="right">
					<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" onclick="sure()" role="button" title="确定" id="demoSingle_saveForm">确定</a>
					<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="closeForm">取消</a>
				</td>
			</tr>
		</table>
	</div>
</div>

<div id="binding" data-options="region:'center',split:true,border:false">
	<form id='form1' enctype="multipart/form-data" action="<c:url value='/bpmSam/bpmn2jbpm/operation/binding'/>" method="post">
		<table class="form_commonTable" width="70%">
			<tr>
				<th width="15%" style="word-break: break-all; word-warp: break-word;"><label for="wordBody2">BPMN文件:</label></th>
				<td width="55%">
					<input type="file" class="file" name="wordBody2" id="wordBody2" onchange="execute()"/>
				</td>
			</tr>
			<tr>
				<th><label for="bpmModel">绑定流程:</label></th>
				<td>
					<input type="hidden" id="bdbpmName" name="bdbpmName">
					<input type="hidden" id="bdepcId" name="bdepcId">
					<input type="hidden" id="bdformId" name="bdformId">
					<input type="text" id="bpmModel" name="bpmModel" placeholder="请选择模型" class="form-control" readonly>
				</td>
			</tr>
		</table>
	</form>
</div>

<!-- button js event -->
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmSam/selectFlowType/selectFlowType.js"></script>
<script src="avicit/platform6/bpmSam/selectFlowModel/selectFlowModel.js"></script>
<script type="text/javascript"  src="avicit/platform6/bpmSam/jquery-form.js"></script>
<script type="text/javascript">
	var selectFolwType = new SelectFolwType("formId", "bpmType");
	selectFolwType.init();
	var selectFolwModel = new SelectFolwModel("bdformId", "bpmModel");
	selectFolwModel.init();
	var avicAjaxLoading2;
	var changeTypeValue = "";
  	//控件校验   规则：表单字段name与rules对象保持一致
    formValidate = function(form) {
    	form.validate({
    		rules : {
    			wordBody : {
    				required : true
    			},
    			bpmName : {
    				required : true,
    				maxlength : 100
    			},
    			bpmType : {
    				required : true,
    				maxlength : 100
    			}
    		}
    	});
    }
  	//绑定表单校验
  	formValidate2 = function(form1) {
    	form1.validate({
    		rules : {
    			wordBody2 : {
    				required : true
    			},
    			bpmModel : {
    				required : true,
    				maxlength : 100
    			}
    		}
    	});
    }
  	
    //保存表单
    function saveDb() {
    	var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
    	parent.searchIndex.save($('#form'),"add");
	}
    //返回按钮绑定事件
	$('#closeForm').bind('click', function(){
		closeForm();
	});
	function closeForm(){
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}
	//进行转换
	var bpmnNameOrig = "";
	var ajax_option={
				success : function(r) {
					layer.close(avicAjaxLoading2);
					if (r) {
						//删除redis中的epcname和epcid
						$.ajax({
							  type:'get',
							  async: false,
							  url: 'bpmSam/bpmn2jbpm/operation/delCookies',
							  dataType:'text',
							  success: function(e){
								  
							  },
							  error: function(){
									
							  }
						 });
						//layer.alert('转换成功!');
						parent.layer.alert('转换成功！', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0
						});
						parent.layer.close(parent.layer.getFrameIndex(window.name));
						
					} else {
						parent.layer.alert("转换失败！", {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0
						});
					}
				}
		};
	var ajax_option2={
			success : function(r) {
				layer.close(avicAjaxLoading2);
				if (r) {
					//删除redis中的epcname和epcid
					$.ajax({
						  type:'get',
						  async: false,
						  url: 'bpmSam/bpmn2jbpm/operation/delCookies',
						  dataType:'text',
						  success: function(e){
							  
						  },
						  error: function(){
								
						  }
					 });
					//layer.alert('转换成功!');
					parent.layer.alert('绑定成功！', {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0
					});
					parent.layer.close(parent.layer.getFrameIndex(window.name));
					
				} else {
					parent.layer.alert("绑定失败！", {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0
					});
				}
			}
	};
		var ajax_option_BpmnName={
				success : function(r) {
					if (r) {
						$("#bpmName").val(r);
						$("#bdbpmName").val(r);
						bpmnNameOrig = r;
					} else {
						layer.alert("解析失败！", {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0
						});
					}
				}
		};
		//根据changeTypeValue判断执行转换或者绑定操作
		function sure(){
			if(changeTypeValue == "1"){
				changing();
			}else{
				//绑定操作
				binding();
			}
		}
		//执行转换操作
		function changing(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			if(document.getElementById("wordBody").value != ''){
				//判断ARIS流程名称和cookie里的目录名称是否一致,可用ajax请求 "${param.epcId}"
				$.ajax({
						  type:'get',
						  async: false,
						  url: 'bpmSam/bpmn2jbpm/operation/getCookiesName',
						  dataType:'text',
						  success: function(r){
							  //如果redis获取的bpmnName和解析获取的原始bpmnNameOrig相等则执行转换
							   if(r==bpmnNameOrig){ 
									if(checkfiletype('wordBody')){
										$("#epcId").val("${param.epcId}");
										avicAjaxLoading2 = layer.load(2,{shade: [0.2, '#000'],scrollbar: false});
										$("#changeSign").val("change");
										$("#form").ajaxSubmit(ajax_option);
									}
								 }else{
									layer.alert('请选择与所选ARIS目录对应的BPMN流程文件！' , {
										icon : 7,
										area : [ '400px', '' ], //宽高
										closeBtn : 0
									});
								} 
						  },
						  error: function(){
								
						  }
					 });
				
			} else {
				layer.alert('请选择文件!');
				return;
			}
		}
		//执行绑定操作
		function binding(){
			var isValidate2 = $("#form1").validate();
	        if (!isValidate2.checkForm()) {
	            isValidate2.showErrors();
	            return false;
	        }
			if(document.getElementById("wordBody2").value != ''){
				//判断ARIS流程名称和cookie里的目录名称是否一致,可用ajax请求 "${param.epcId}"
				$.ajax({
						  type:'get',
						  async: false,
						  url: 'bpmSam/bpmn2jbpm/operation/getCookiesName',
						  dataType:'text',
						  success: function(r){
							  //如果redis获取的bpmnName和解析获取的原始bpmnNameOrig相等则执行转换
							  if(r==bpmnNameOrig){
									if(checkfiletype('wordBody2')){
										$("#bdepcId").val("${param.epcId}");
										avicAjaxLoading2 = layer.load(2,{shade: [0.2, '#000'],scrollbar: false});
										$("#form1").ajaxSubmit(ajax_option2);
									}
								 }else{
									layer.alert('请选择与所选ARIS目录对应的BPMN流程文件！' , {
										icon : 7,
										area : [ '400px', '' ], //宽高
										closeBtn : 0
									});
								} 
						  },
						  error: function(){
								
						  }
					 });
				
			} else {
				layer.alert('请选择文件!');
				return;
			}
		}
		
		function execute(){
			if(document.getElementById("wordBody").value != ''){
				if(checkfiletype('wordBody')){
					$("#form").ajaxSubmit(ajax_option_BpmnName);
				}
			}else if(document.getElementById("wordBody2").value != ''){
				if(checkfiletype('wordBody2')){
					$("#form1").ajaxSubmit(ajax_option_BpmnName);
				}
			}else {
				layer.alert('请选择上传的模板文件!', {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0
				});
				return;
			}
		}
		//检查上传类型
		function checkfiletype(id){
		    var fileName = document.getElementById(id).value;
		    //设置文件类型数组
		    var extArray =[".xml",".bpmn"];
		   	//获取文件名称
		   	while (fileName.indexOf("//") != -1)
		    	fileName = fileName.slice(fileName.indexOf("//") + 1);
		       	//获取文件扩展名
		       	var ext = fileName.slice(fileName.indexOf(".")).toLowerCase();
		   		//遍历文件类型
		       	var count = extArray.length;
		   		for (;count--;){
		     		if (extArray[count] == ext){ 
		       			return true;
		     		}
		   		}  
		   		//layer.alert('只能上传下列类型的文件: '  + extArray.join(" "),'error');
		   		layer.alert('错误！只能转换下列类型的文件: '+ extArray.join(" "), {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0
				});
		   return false;  
		}
		$(document).ready(function () {
			formValidate($('#form'));
			formValidate2($('#form1'));
			//radio切换
			changeTypeValue = $('input[name="changeType"]:checked ').val();  
	        if(changeTypeValue == 0){  
	            $("#change").hide();
	            $("#binding").show();
	        }  
	        if(changeTypeValue == 1){  
	        	$("#binding").hide();
	            $("#change").show();
	        }  
	        $(".merchantzc_radio").click(function(){  
	            changeTypeValue = $('input[name="changeType"]:checked ').val();  
	            if(changeTypeValue == 0){  
	                $("#change").hide();
	                $("#binding").show();
	            }  
	            if(changeTypeValue == 1){  
	            	$("#binding").hide();
	                $("#change").show();
	            }  
	        })
		});
	
</script>
	
	
</body>
</html>