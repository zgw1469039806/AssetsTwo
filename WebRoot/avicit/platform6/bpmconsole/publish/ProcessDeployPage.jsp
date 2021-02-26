<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<%
	String deploymentId = request.getParameter("deploymentId");
	String processDefId = request.getParameter("processDefId");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程配置页面</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>

<script type="text/javascript">
var deploymentId = '<%=deploymentId%>';
var processDefId = '<%=processDefId%>';
var baseurl = '<%=request.getContextPath()%>';
var oldTaskDiv=null;
var globeTaskId = '';
//加载流程信息
function loadProcessImage(obj){
	ajaxRequest(
			"POST",
			"deploymentId=" + deploymentId + "&processDefId=" + processDefId + "&formType=" + obj,
			"platform/bpm/bpmPublishAction/getProcessImageCoordinate",
			"json", "draw");

    ajaxRequest(
            "POST",
            "deploymentId=" + deploymentId + "&processDefId=" + processDefId + "&formType=" + obj,
            "platform/bpm/bpmPublishAction/getProcessImageCoordinate",
            "json", "drawMobile");
}
function draw(obj){
	//画流程图
	$("#bpmImageDiv").html(obj.image);
	//初始化节点配置任务
	$('#pdActivityName').combobox('loadData',obj.data);
}
function drawMobile(obj){
    $('#pdActivityNameMobile').combobox('loadData',obj.data);
}
$(function() {
$('#processNodes').tabs({
			onSelect : function(title, index) {
				if (index == 1) {
					loadData2();
				}
			}
		});
});
//初始化数据
function loadData(){
	loadProcessImage();
	globalProcessForm();
}
function loadData2(){
	var dataGridHeight = $(".easyui-layout").height()-75; 
	var lastIndex;
	$('#processForm').datagrid({
		toolbar:[{
            id:'btnadd',
            text:'添加',
            iconCls:'icon-add',
            handler:function(){
            	if(globeTaskId=='' || globeTaskId == null || globeTaskId==undefined){
            		$.messager.alert("操作提示", "请选择要导入资源的流程节点！","info"); 
            	}
                $('#processForm').datagrid('appendRow',{
                	pdActivityName:globeTaskId,
                	pdId:processDefId,
                	tag:'',
                	tagName:'',
                	accessibility:'1',
                	operability:'1'
                });
                lastIndex = $('#processForm').datagrid('getRows').length-1;
				$('#processForm').datagrid('selectRow', lastIndex);
				$('#processForm').datagrid('beginEdit', lastIndex);
        	}
        },'-',{
		    text:'保存',
		    iconCls:'icon-save',
		    handler:function(){
		    	endEdit();
		    	if($('#processForm').datagrid('getChanges').length){
		    		var updated = $('#processForm').datagrid('getChanges','updated');
		    		var inserted = $('#processForm').datagrid('getChanges','inserted');
		    		var deleted = $('#processForm').datagrid('getChanges','deleted');
		    		var effectRow = new Object();  
                    if (inserted.length) {  
                        effectRow["inserted"] = JSON.stringify(inserted);  
                    }  
                    if (deleted.length) {  
                        effectRow["deleted"] = JSON.stringify(deleted);  
                    }  
                    if (updated.length) {  
                        effectRow["updated"] = JSON.stringify(updated);  
                    }  
                    $.post("platform/bpm/bpmPublishAction/saveProcessNodeComponent.json?formCode="+$('#pdGlobalFormName').combobox('getText'), effectRow, function(rsp) {
                        if(rsp.flag=='success'){  
                        	$.messager.show({
    		    				title : '提示',
    		    				msg : "操作成功！"
    		    			}); 
                            $('#processForm').datagrid('acceptChanges');  
                        }  
                    }, "JSON").error(function() {  
                    	$.messager.show({
		    				title : '提示',
		    				msg : "操作失败！"
		    			});  
                    });  
		    	}
		    }
		}
        ,'-',{
		    text:'导入资源',
		    iconCls:'icon-redo',
		    handler:function(){
		    	if(globeTaskId=='' || globeTaskId == null || globeTaskId==undefined){
		    		$.messager.alert("操作提示", "请选择要导入资源的流程节点！","info"); 
		    		return;
		    	}
		    	inputUrl(globeTaskId,processDefId);
		    }
		}
        ,'-',{
		    text:'删除',
		    iconCls:'icon-remove',
		    handler:function(){
		    	var rows =$('#processForm').datagrid('getSelections');  
		    	if (rows == null || rows=='') {
					$.messager.alert("操作提示", "请您选择一条记录！","info"); 
					return;
				}
				for ( var i = 0; i < rows.length; i++) {
					var row = rows[i];
					if (row) {  
	                    var rowIndex = $('#processForm').datagrid('getRowIndex', row);  
	                    $('#processForm').datagrid('deleteRow', rowIndex);  
	                }  
				}
                
		    }
		}],
		url: 'platform/bpm/bpmPublishAction/findComponentFromUrl.json?pdActivityName=' + globeTaskId + '&pdId=' + processDefId+'&formCode=' + $('#pdGlobalFormName').combobox('getText'),
	    nowrap: true,
	    autoRowHeight: false,
	    fitColumns : true,
	    striped: true,
	    fit:true,
	    singleSelect:false,
	    checkOnSelect:true,
	    collapsible:true,
	    remoteSort: false,
	    onBeforeLoad:function(){
			$(this).datagrid('rejectChanges');
		},
		onClickRow:function(rowIndex){
			if(lastIndex==0 && rowIndex==0){
				$('#processForm').datagrid('beginEdit', rowIndex);
			}
			if (lastIndex != rowIndex){
				$('#processForm').datagrid('endEdit', lastIndex);
				$('#processForm').datagrid('beginEdit', rowIndex);
			}
			lastIndex = rowIndex;
		},
	    pagination:false,
	    rownumbers:true,
	    sortName:"creationDate",
	    sortOrder:"asc",
	    columns:[[
	              {field:'creationDate', hidden:true},
				  {field:'id',hidden:true},
				  {field:'pdActivityName',hidden:true},
				  {field:'pdId',hidden:true},
				  {field:'op',title:'操作',width:25,align:'left',checkbox:true},
	              {field:'tag',title:'控件',width:200,editor:{type:'text'}},
	              {field:'tagName',title:'名称',width:260,rowspan:2,editor:{type:'text',required:true}},
	              {field:'accessibility',title:'读',width:80,rowspan:2,
	            	  editor:{type:'combobox',options:{data:[{'value':'1','text':'是'},{'value':'0','text':'否'}],height:20}},
	            	  formatter:function(value,rec){
		            		var temp = rec.accessibility;
		            		if(temp==1){
		            			return '是';
		            		}else{
		            			return '否';
		            		}
	            	  }
	              },
	              {field:'operability',title:'写',width:80,rowspan:2,
	              	editor:{type:'combobox',options:{data:[{'value':'1','text':'是'},{'value':'0','text':'否'}]}},
	              	formatter:function(value,rec){
	            		var temp = rec.operability;
	            		if(temp==1){
	            			return '是';
	            		}else{
	            			return '否';
	            		}
            	  }
	              }
	          ]]
	});
	function endEdit(){
		var rows = $('#processForm').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			$('#processForm').datagrid('endEdit',i);
		}
	}
}
function inputUrl(nodeId,processDefId){
	var url = getPath2() + "/avicit/platform6/bpmconsole/publish/InputFormUrl.jsp";
	url += '?nodeId=' + nodeId +  '&processDefId=' + processDefId;
	var usd = new UserSelectDialog("inputuri", "500", "170",encodeURI(url), "请输入要导入的URL");
	var buttons = [{
		text : '确定',
		id : 'processSubimt',
		//iconCls : 'icon-submit',
		handler : function() {
		var actValue = $('#pdActivityName').combobox('getValue');
    			if(actValue=='请选择...' || ''==actValue || actValue=='undefined' || actValue==null){
    				$.messager.alert("操作提示", "请选择节点名称！","info"); 
    				return false;
    			}
    			var formValue = $('#pdGlobalFormName').combobox('getValue');
    			if(formValue=='请选择...' || ''==formValue || formValue=='undefined' || formValue==null){
    				$.messager.alert("操作提示", "请选择所属全局表单！","info"); 
    				return false;
    			}
			var frmId = $('#inputuri iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var formUrl = frm.submits();
			if(formUrl!='' && formUrl!='undefined' && formUrl!=null){
				easyuiMask();
				ajaxRequest(
						"POST",
						"formUrl=" + formUrl + "&pdId=" + processDefId + "&pdActivityName=" + nodeId+ "&formCode="+$("#pdGlobalFormName").combobox("getText"),
						"platform/bpm/bpmPublishAction/findComponentFromUrl",
						"json", "backUrl");
				usd.close();
			}
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
}
var usd;
//选择流程表单 nodeId节点id processDefId流程定义id,type：global,activity,start
function selectForm(type){
	var url = getPath2() + "/avicit/platform6/bpmconsole/publish/ProcessFormList.jsp";
	url += '?processDefId=' + processDefId+"&type="+type;
	usd = new UserSelectDialog("lcbdxzk", "800", "500",encodeURI(url), "流程表单选择框");
	var buttons = [{
		text : '确定',
		id : 'processSubimt',
		//iconCls : 'icon-submit',
		handler : function() {
			var frmId = $('#lcbdxzk iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var resultDatas = frm.getSelectedResultDataJson();

			if (resultDatas == null) {
				return;
			}

			if(type=='global'){
				/**
				$("#globalForm").form('load',
					{formCode:resultDatas.formCode,formUrl:resultDatas.formUrl,formName:resultDatas.formName,proxyPage:'N',formId:resultDatas.id,pdId:resultDatas.processDefId
				});**/
					var formInfos = "";
					for(var i=0;i<resultDatas.length;i++){
						formInfos += resultDatas[i]["id"]+"#"+resultDatas[i]["proxyPage"]+"@";
					}
					frm.endEdit()
					saveGlobalForms(formInfos);
			}
			if(type=='activity'){
				$("#activityForm").form('load',
					{formUrl:resultDatas[0].formUrl,proxyPage:'N',formId:resultDatas[0].id
				});
			}
			if(type=='start'){
				$("#startForm").form('load',
					{formCode:resultDatas[0].formCode,formUrl:resultDatas[0].formUrl,formName:resultDatas[0].formName,proxyPage:'N',formId:resultDatas[0].id,pdId:resultDatas[0].processDefId
				});
			}
			usd.close();
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
}

function selectFormMobile(type){
	var url = getPath2() + "/avicit/platform6/bpmconsole/publish/ProcessFormListMobile.jsp";
	url += '?processDefId=' + processDefId+"&type="+type;
	usd = new UserSelectDialog("lcbdxzk_mobile", "800", "500",encodeURI(url), "流程表单选择框");
	var buttons = [{
		text : '确定',
		id : 'processSubimtMobile',
		//iconCls : 'icon-submit',
		handler : function() {
			var frmId = $('#lcbdxzk_mobile iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var resultDatas = frm.getSelectedResultDataJson();

			if (resultDatas == null) {
				return;
			}

			if(type=='global'){
				/**
				 $("#globalForm").form('load',
				 {formCode:resultDatas.formCode,formUrl:resultDatas.formUrl,formName:resultDatas.formName,proxyPage:'N',formId:resultDatas.id,pdId:resultDatas.processDefId
             });**/
				var formInfos = "";
				for(var i=0;i<resultDatas.length;i++){
					formInfos += resultDatas[i]["id"]+"#"+resultDatas[i]["proxyPage"]+"@";
				}
				frm.endEdit()
				saveGlobalFormsMobile(formInfos);
			}
			if(type=='activity'){
				$("#activityFormMobile").form('load',
						{formUrl:resultDatas[0].formUrlMobile,formIdMobile:resultDatas[0].id
						});
			}
			if(type=='start'){
				$("#startForm").form('load',
						{formCode:resultDatas[0].formCode,formUrl:resultDatas[0].formUrlMobile,formName:resultDatas[0].formName,formIdMobile:resultDatas[0].id,pdId:resultDatas[0].processDefId
						});
			}
			usd.close();
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
}

function refreshDg(obj){
	usd.close();
	usd = null;
}

function backChecked(obj) {
	easyuiUnMask();
	globalProcessForm();
	if (obj != null && obj.flag=='success') {
		$.messager.show({
			title : '提示',
			msg : "操作成功！"
		});
	}else{
		$.messager.show({
			title : '提示',
			msg : "操作失败！"
		}); 
	}
}
function backUrl(obj) {
	easyuiUnMask();
	if (obj != null && obj.flag=='success') {
		$('#processForm').datagrid('reload');
		$.messager.show({
			title : '提示',
			msg : "导入成功！"
		});
	}else if (obj != null && obj.flag=='zero') {
		$('#processForm').datagrid('reload');
		$.messager.show({
			title : '提示',
			msg : "没有找到资源！"
		});
	}else{
		$.messager.show({
			title : '提示',
			msg : "操作失败！"
		}); 
	}
}
//全局 开始表单初始化
function globalProcessForm(){
	var globalUrl = 'platform/bpm/bpmPublishAction/getProcessDeployForm.json?type=global&pdId=' + processDefId + "&random=" + Math.random()*100 + "&pcOrMobile=0";
	$('#dgGlobalFormSetting').datagrid({
		url:globalUrl,
		onLoadSuccess:setActivityCombox
	});

	var globalUrlMobile = 'platform/bpm/bpmPublishAction/getProcessDeployForm.json?type=global&pdId=' + processDefId + "&random=" + Math.random()*100 + "&pcOrMobile=1";
	$('#dgGlobalFormSettingMobile').datagrid({
		url:globalUrlMobile,
		onLoadSuccess:setActivityComboxMobile
	});
}
function setActivityCombox(){
	$('#pdGlobalFormName').combobox('loadData',$('#dgGlobalFormSetting').datagrid("getRows"));
}
function setActivityComboxMobile(){
	$('#pdGlobalFormNameMobile').combobox('loadData',$('#dgGlobalFormSettingMobile').datagrid("getRows"));
}
//节点表单权限处理
function activityProcessForm(actValue){
	if(actValue=='act'){
		actValue = $('#pdActivityName').combobox('getValue');
	}
	$('#pdActivityName').combobox('setValue',actValue);
	var actFormCode = $('#pdGlobalFormName').combobox('getValue');
	document.getElementById("formId").value="";
	document.getElementById("formUrl").value="";
	document.getElementById("remark").value="";
	if(actValue!=null && actValue!='' && actFormCode!='请选择...' && actFormCode!=''){
		var tempUrl = 'platform/bpm/bpmPublishAction/getProcessDeployForm.json?type=activity&pdId=' + processDefId + '&pdActivityName=' + actValue+'&actFormCode='+actFormCode + "&pcOrMobile=0";
		tempUrl += "&random=" + Math.random()*100;
		$('#activityForm').form('load',tempUrl);
	}else{

	}
	loadData2();
}
function activityProcessFormMobile(actValue){
    if(actValue=='act'){
        actValue = $('#pdActivityNameMobile').combobox('getValue');
    }
    $('#pdActivityNameMobile').combobox('setValue',actValue);
    var actFormCode = $('#pdGlobalFormNameMobile').combobox('getValue');
    document.getElementById("formId").value="";
    document.getElementById("formUrlMobile").value="";
    if(actValue!=null && actValue!='' && actFormCode!='请选择...' && actFormCode!=''){
        var tempUrl = 'platform/bpm/bpmPublishAction/getProcessDeployForm.json?type=activity&pdId=' + processDefId + '&pdActivityName=' + actValue+'&actFormCode='+actFormCode + "&pcOrMobile=1";
        tempUrl += "&random=" + Math.random()*100;
        $('#activityFormMobile').form('load',tempUrl);
    }
}
//节点表单权限配置
//by xb 流程ui点击事件  onclick="deployProcessNodeAccess(this,'task1','8a58cd7356e3342f0156e364e734006e-1','task1')"
function deployProcessNodeAccess(myself,nodeId,processDefId,nodeName){
	if(oldTaskDiv && oldTaskDiv!=null && oldTaskDiv!=undefined ){
		oldTaskDiv.style.filter="Alpha(Opacity=0)";
		oldTaskDiv.style.opacity = 0;
	}
	myself.style.filter="Alpha(Opacity=100)";
	myself.style.opacity = 1;
	oldTaskDiv=myself;
	globeTaskId = nodeId;
	activityProcessForm(nodeId);
    activityProcessFormMobile(nodeId);
}

function saveGlobalForms(formInfos) {
	document.getElementById("formId").value=formInfos;
	$('#globalForm').form('submit', {   
  		url:"platform/bpm/bpmPublishAction/saveProcessDeployForm?type=global&pdId=" + processDefId + "&pcOrMobile=0",
   		onSubmit: function(){   
   			return $("#globalForm").form('validate');
  			},   
   		success:function(data){ 
   			globalProcessForm();
   			$.messager.show({
   				title : '提示',
   				msg : "操作成功！"
   			}); 
   		}   
	});
}
function saveGlobalFormsMobile(formInfos) {
	document.getElementById("formId").value=formInfos;
	$('#globalForm').form('submit', {
		url:"platform/bpm/bpmPublishAction/saveProcessDeployForm?type=global&pdId=" + processDefId + "&pcOrMobile=1",
		onSubmit: function(){
			return $("#globalForm").form('validate');
		},
		success:function(data){
			globalProcessForm();
			$.messager.show({
				title : '提示',
				msg : "操作成功！"
			});
		}
	});
}

//初始化按钮信息
$(function(){
	$('#btnSubmitActivity').bind('click',
			function() {
				$('#activityForm').form('submit', {   
		   			url:'platform/bpm/bpmPublishAction/saveProcessDeployForm?type=activity&pdId=' + processDefId+'&formId=' + $('#pdGlobalFormName').combobox('getValue')+'&formCode=' + $('#pdGlobalFormName').combobox('getText') + "&pcOrMobile=0",
		    		onSubmit: function(){   
		    			//alert($('#pdGlobalFormName').combobox('getValue')+"   "+ $('#pdGlobalFormName').combobox('getText'))
		    			var actValue = $('#pdActivityName').combobox('getValue');
		    			if(actValue=='请选择...' || ''==actValue || actValue=='undefined' || actValue==null){
		    				$.messager.alert("操作提示", "请选择节点名称！","info"); 
		    				return false;
		    			}
		    			var formValue = $('#pdGlobalFormName').combobox('getValue');
		    			if(formValue=='请选择...' || ''==formValue || formValue=='undefined' || formValue==null){
		    				$.messager.alert("操作提示", "请选择所属全局表单！","info"); 
		    				return false;
		    			}
		    			return $("#activityForm").form('validate');
		   			},
		    		success:function(data){   
		    			activityProcessForm('act');
		    			$.messager.show({
		    				title : '提示',
		    				msg : "操作成功！"
		    			});
		    		}
			});  
	});
	$('#btnSubmitActivityMobile').bind('click',
			function() {
				$('#activityFormMobile').form('submit', {
					url:'platform/bpm/bpmPublishAction/saveProcessDeployForm?type=activity&pdId=' + processDefId+'&formId=' + $('#pdGlobalFormNameMobile').combobox('getValue')+'&formCode=' + $('#pdGlobalFormNameMobile').combobox('getText') + "&pcOrMobile=1",
					onSubmit: function(){
						var actValue = $('#pdActivityNameMobile').combobox('getValue');
						if(actValue=='请选择...' || ''==actValue || actValue=='undefined' || actValue==null){
							$.messager.alert("操作提示", "请选择节点名称！","info");
							return false;
						}
						var formValue = $('#pdGlobalFormNameMobile').combobox('getValue');
						if(formValue=='请选择...' || ''==formValue || formValue=='undefined' || formValue==null){
							$.messager.alert("操作提示", "请选择所属全局表单！","info");
							return false;
						}
						return $("#activityFormMobile").form('validate');
					},
					success:function(data){
						activityProcessFormMobile('act');
						$.messager.show({
							title : '提示',
							msg : "操作成功！"
						});
					}
				});
			});

	$('#btnSubmitStart').bind('click',
			function() {
				$('#startForm').form('submit', {   
		   			url:'platform/bpm/bpmPublishAction/saveProcessDeployForm?type=start&pdId=' + processDefId,   
		    		onSubmit: function(){   
		    			return $("#startForm").form('validate');
		   			},   
		    		success:function(data){   
		    			globalProcessForm();
		    			$.messager.show({
		    				title : '提示',
		    				msg : "操作成功！"
		    			});
		    		}   
				});  
	});

	$('#btnDelete').bind('click',
			function() {
			
				//var tempId = $("#globalForm").form()[0].id.value;不用id删除了，用pdid跟表单类型一起删
				var formIds = "";
				var datas = $('#dgGlobalFormSetting').datagrid('getChecked');
				if(datas.length == 0){
					$.messager.alert("操作提示", "没有选中数据！","info"); 
					return;
				}
				for(var i=0;i<datas.length;i++){
					formIds +=datas[i]["formId"]+"@";
				}
				if(processDefId!=null && processDefId != '' && processDefId != 'undefined'){
					$.messager.confirm("操作提示", "您确认要删除吗?", function(data) {
						if (data) {
							easyuiMask();
							ajaxRequest(
									"POST",
									"type=global&pdId=" + processDefId+"&formIds="+formIds+"&pcOrMobile=0",
									"platform/bpm/bpmPublishAction/deleteProcessDeployForm",
									"json", "backChecked");
						}
					});
				}
	});
	$('#btnDeleteMobile').bind('click',
			function() {

				//var tempId = $("#globalForm").form()[0].id.value;不用id删除了，用pdid跟表单类型一起删
				var formIds = "";
				var datas = $('#dgGlobalFormSettingMobile').datagrid('getChecked');
				if(datas.length == 0){
					$.messager.alert("操作提示", "没有选中数据！","info"); 
					return;
				}
				for(var i=0;i<datas.length;i++){
					formIds +=datas[i]["formId"]+"@";
				}
				if(processDefId!=null && processDefId != '' && processDefId != 'undefined'){
					$.messager.confirm("操作提示", "您确认要删除吗?", function(data) {
						if (data) {
							easyuiMask();
							ajaxRequest(
									"POST",
									"type=global&pdId=" + processDefId+"&formIds="+formIds+"&pcOrMobile=1",
									"platform/bpm/bpmPublishAction/deleteProcessDeployForm",
									"json", "backChecked");
						}
					});
				}
			});


	$('#btnDeleteAct').bind('click',
			function() {
				//var tempId = $("#activityForm").form()[0].id.value;
//				var tempId = $("#activityForm").form()[0].pdId.value;
                var tempId = processDefId;
                var actValue = $('#pdActivityName').combobox('getValue');
				if(tempId!=null && tempId != '' && tempId != 'undefined'){
					$.messager.confirm("操作提示", "您确认要删除吗?", function(data) {
						if (data) {
							easyuiMask();
							ajaxRequest(
									"POST",
									"type=activity&pdId=" + tempId+"&formIds=" + $("#pdGlobalFormName").combobox("getValue")+"&actValue=" + actValue +"&pcOrMobile=0",
									"platform/bpm/bpmPublishAction/deleteProcessDeployForm",
									"json", "backChecked");
							document.getElementById("formId").value="";
							document.getElementById("formUrl").value="";
							document.getElementById("remark").value="";
						}
					});
				}
	});
	$('#btnDeleteActMobile').bind('click',
			function() {
//				var tempId = $("#activityFormMobile").form()[0].pdId.value;
                var tempId = processDefId;
                var actValue = $('#pdActivityNameMobile').combobox('getValue');
				if(tempId!=null && tempId != '' && tempId != 'undefined'){
					$.messager.confirm("操作提示", "您确认要删除吗?", function(data) {
						if (data) {
							easyuiMask();
							ajaxRequest(
									"POST",
									"type=activity&pdId=" + tempId+"&formIds=" + $("#pdGlobalFormNameMobile").combobox("getValue")+"&actValue=" + actValue +"&pcOrMobile=1",
									"platform/bpm/bpmPublishAction/deleteProcessDeployForm",
									"json", "backChecked");
							document.getElementById("formId").value="";
							document.getElementById("formUrlMobile").value="";
//							document.getElementById("remark").value="";
						}
					});
				}
			});

	$('#btnDeleteStart').bind('click',
			function() {
				//var tempId = $("#startForm").form()[0].id.value;
				var tempId = $("#startForm").form()[0].pdId.value;
				if(tempId!=null && tempId != '' && tempId != 'undefined'){
					$.messager.confirm("操作提示", "您确认要删除吗?", function(data) {
						if (data) {
							easyuiMask();
							ajaxRequest(
									"POST",
									"type=start&pdId=" + tempId,
									"platform/bpm/bpmPublishAction/deleteProcessDeployForm",
									"json", "backChecked");
						}
					});
				}
	});
	$('#btnSelectForm').bind('click',
			function() {
				selectForm('global');
	});
	$('#btnSelectFormMobile').bind('click',
			function() {
				selectFormMobile('global');
	});
	$('#btnSelectStartForm').bind('click',
			function() {
				selectForm('start');
	});  
	$('#btnSelectFormAct').bind('click',
			function() {
				selectForm('activity');
	});
	$('#btnSelectFormActMobile').bind('click',
			function() {
				selectFormMobile('activity');
	});

	//当选中节点是触发
	$('#pdActivityName').combobox({
		onSelect:function(){
			activityProcessForm('act');
		}
	});
	$('#pdGlobalFormName').combobox({
		onSelect:function(){
			activityProcessForm('act');
		}
	});

    $('#pdActivityNameMobile').combobox({
        onSelect:function(){
            activityProcessFormMobile('act');
        }
    });
    $('#pdGlobalFormNameMobile').combobox({
        onSelect:function(){
            activityProcessFormMobile('act');
        }
    });
}); 
var proxyValue = [{ "value": "N", "text": "否" }, { "value": "Y", "text": "是" }];
function typeformatter(value, rowData, rowIndex) {
    if (value == 0) {
        return;
    }
    for (var i = 0; i < proxyValue.length; i++) {
        if (proxyValue[i].value == value) {
            return proxyValue[i].text;
        }
    }
}
function setAuth(formId){
	var url = getPath2() + "/avicit/platform6/bpmconsole/publish/ProcessAuthManage.jsp";
	url += '?processDefId=' + processDefId+'&formId='+formId;
	var usd = new UserSelectDialog("lcbdxzk", "700", "500",encodeURI(url), "权限配置");
	usd.show();
}
function changeActCombox(rowIndex, rowData){
	$('#pdGlobalFormName').combobox('setValue',rowData["formId"]);
	activityProcessForm('act');
}
function changeActComboxMobile(rowIndex, rowData){
    $('#pdGlobalFormNameMobile').combobox('setValue',rowData["formId"]);
    activityProcessFormMobile('act');
}
function formateHref(value,row,inde){
	return "<a href='javascript:void(0);' onclick='setAuth(\""+value+"\");'>配置权限</a>";
}
</script>
</head>
<body class="easyui-layout" fit="true"  onload="loadData()">
    <div data-options="region:'west',title:'流程表单节点配置',split:true"
		style="width:580px; overflow: auto;">
		<div id="bpmImageDiv"></div>
	</div>
    <div data-options="region:'center'">
		<div class="easyui-tabs" data-options="fit:true">
			<div title="PC端表单配置">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north',split:true,title:'全局表单配置'" style="height:210px">
						<form id="globalForm" method="post" action="">
							<input type="hidden" name="pdId" id="pdId" />
							<input type="hidden" name="id" id="id" />
							<input type="hidden" name="formId" id="formId" />
                            <%--<input type="hidden" name="formIdMobile" id="formIdMobile" />--%>
						</form>
						<div id="toolbarGlobalFormSetting" class="datagrid-toolbar">
							<table>
								<tr>
									<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true"
										   id="btnSelectForm"  href="javascript:void(0);">添加</a>
									</td>
									<td><a class="easyui-linkbutton" plain="true"
										   iconCls="icon-remove" id="btnDelete" href="javascript:void(0);">删除</a>
									</td>
								</tr>
							</table>
						</div>
						<table id="dgGlobalFormSetting"
							   data-options="
								fit: true,
								border: false,
								rownumbers: true,
								animate: true,
								collapsible: false,
								fitColumns: true,
								autoRowHeight: false,
								toolbar:'#toolbarGlobalFormSetting',
								idField :'id',
								singleSelect: true,
								checkOnSelect: true,
								selectOnCheck: false,
								onSelect:changeActCombox,
								pagination:false,
								striped:true">
							<thead>
							<tr>
								<th data-options="field:'id', halign:'center',checkbox:true"  width="100">主键</th>
								<th data-options="field:'formCode', halign:'center'"  width="100">表单代码</th>
								<th data-options="field:'formUrl', halign:'center'"  width="200">PC表单URL</th>
								<%--<th data-options="field:'formUrlMobile', halign:'center'"  width="200">移动表单URL</th>--%>
								<th data-options="field:'proxyPage', halign:'center', formatter: typeformatter"  width="50">是否代理</th>
							</tr>
							</thead>
						</table>

					</div>
					<div data-options="region:'center',title:'节点表单和权限配置'">
						<form id="activityForm" method="post" action=""
							  style="height: auto; display: block;">
							<div style="margin:8px;">
							<table class="form_commonTable">
            		<tr>
            			<td style="width:100px;">
            				当前全局表单：
            			</td>
            			<td>
            				<input class="easyui-combobox" id="pdGlobalFormName"  name="pdGlobalFormName" value='请选择...' valueField="formId" editable="false" required="true"  textField="formCode" />
            			</td>
            			<td style="width:100px;">
            				当前节点名称：
            			</td>
            			<td>
            				<input class="easyui-combobox" id="pdActivityName" name="pdActivityName" value='请选择...' valueField="actId"  editable="false" required="true"  textField="alias" />
            			</td>
            		</tr>
            		</table>
							</div>

							<fieldset style="height:auto;">
								<legend>当前节点表单配置</legend>
<%--								<input type="hidden" name="pdId" id="pdId" />
								<input type="hidden" name="id" id="id" />
								<input type="hidden" name="formId" id="formId" />--%>
								<table>
									<tr>
										<td width='90px'>表单URL</td>
										<td colspan=3><input class="easyui-validatebox" type="text"
															 name="formUrl" id="formUrl" required="true" style="width:460px;" />
										</td>
										<td align='left' ><a id="btnSelectFormAct"
															 class="easyui-linkbutton">选择..</a></td>
									</tr>
									<tr>
										<td width='90px'>Url参数:</td>
										<!-- required="true"  -->
										<td colspan=3><input type="text" name="remark" id="remark"
															 style="width:460px;" class="easyui-validatebox"/>
										</td>
									</tr>
									<tr>
										<td width='90px'>是否代理：</td>
										<td colspan="4"><select id="proxyPage"
																class="easyui-combobox" name="proxyPage" style="width:50px;">
											<option value="N">否</option>
											<option value="Y">是</option>
										</select></td>
									</tr>
									<tr>
										<td colspan=5 align='center'><a id="btnSubmitActivity"
																		class="easyui-linkbutton">保存</a> <a id="btnDeleteAct"
																											class="easyui-linkbutton">删除</a></td>
									</tr>
								</table>
							</fieldset>
						</form>
						<fieldset style="height:400px;">
							<legend>当前节点权限配置</legend>
							<table id="processForm"></table>
						</fieldset>

					</div>
				</div>
			</div>

			<div title="移动端表单配置">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north',split:true,title:'全局表单配置'" style="height:210px">
						<div id="toolbarGlobalFormSettingMobile" class="datagrid-toolbar">
							<table>
								<tr>
									<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true"
										   id="btnSelectFormMobile"  href="javascript:void(0);">添加</a>
									</td>
									<td><a class="easyui-linkbutton" plain="true"
										   iconCls="icon-remove" id="btnDeleteMobile" href="javascript:void(0);">删除</a>
									</td>
								</tr>
							</table>
						</div>
						<table id="dgGlobalFormSettingMobile"
							   data-options="
								fit: true,
								border: false,
								rownumbers: true,
								animate: true,
								collapsible: false,
								fitColumns: true,
								autoRowHeight: false,
								toolbar:'#toolbarGlobalFormSettingMobile',
								idField :'id',
								singleSelect: true,
								checkOnSelect: true,
								selectOnCheck: false,
								onSelect:changeActComboxMobile,
								pagination:false,
								striped:true">
							<thead>
							<tr>
								<th data-options="field:'id', halign:'center',checkbox:true"  width="100">主键</th>
								<th data-options="field:'formCode', halign:'center'"  width="100">表单代码</th>
								<%--<th data-options="field:'formUrl', halign:'center'"  width="200">PC表单URL</th>--%>
								<th data-options="field:'formUrl', halign:'center'"  width="400">移动表单URL</th>
							</tr>
							</thead>
						</table>

					</div>
					<div data-options="region:'center',title:'节点表单'">
						<form id="activityFormMobile" method="post" action=""
							  style="height: auto; display: block;">
							<div style="margin:8px;">
							<table class="form_commonTable">
            		<tr>
            			<td style="width:100px;">
            				当前全局表单：
            			</td>
            			<td>
            				<input class="easyui-combobox" id="pdGlobalFormNameMobile"  name="pdGlobalFormName" value='请选择...' valueField="formId" editable="false" required="true"  textField="formCode" />
            			</td>
            			<td style="width:100px;">
            				当前节点名称：
            			</td>
            			<td>
            				<input class="easyui-combobox" id="pdActivityNameMobile" name="pdActivityName" value='请选择...' valueField="actId"  editable="false" required="true"  textField="alias" />
            			</td>
            		</tr>
            		</table>
								
							</div>

							<fieldset style="height:auto;">
								<legend>当前节点表单配置</legend>
<%--								<input type="hidden" name="pdId" id="pdId" />
								<input type="hidden" name="id" id="id" />
								<input type="hidden" name="formId" id="formId" />--%>
								<table>
									<tr>
										<td width='90px'>移动表单URL</td>
										<td colspan=3><input class="easyui-validatebox" type="text"
															 name="formUrl" id="formUrlMobile" required="true" style="width:460px;" />
										</td>
										<td align='left' ><a id="btnSelectFormActMobile"
															 class="easyui-linkbutton">选择..</a></td>
									</tr>
									<tr>
										<td colspan=5 align='center'><a id="btnSubmitActivityMobile"
																		class="easyui-linkbutton">保存</a> <a id="btnDeleteActMobile"
																											class="easyui-linkbutton">删除</a></td>
									</tr>
								</table>
							</fieldset>
						</form>
					</div>
				</div>
			</div>
		</div>
    </div>   
</body>  
</html>