<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree,form,table";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>流程模板管理</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
    <link rel="stylesheet" href="avicit/platform6/bpmreform/bpmdeploy/css/style.css"/>
    <script type="text/javascript">
    	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
    </script>
    <style>
		.shownorth .layout-panel-north {
			overflow:visible!important;
		}

		.cicon{
			color: #cccccc;
		}
		.icon_active{
			color:#337ab7;
		}
	</style>
</head>

<body>

<div class="easyui-layout shownorth" fit=true>
	<div data-options="region:'north',split:false" style="height:43px;overflow:visible;">
		<div class="toolbar">
		   <div class="toolbar-left">
				<div class="dropdown">
					<a class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
					href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu" aria-expanded="false"><i class="icon icon-fenleiguanli"></i> 分类管理<span class="caret"></span></a>
					   <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="text-align:left;min-width:120px;">
							  <li role="presentation"><a id="addFlowType" href="javascript:void(0);" title="添加">添加分类</a></li>
							  <li role="separator" class="divider"></li>
							  <li role="presentation"><a id="editFlowType" href="javascript:void(0);" title="编辑">编辑分类</a></li>
							  <li role="separator" class="divider"></li>
							  <li role="presentation"><a id="deleteFlowType" href="javascript:void(0);" title="删除">删除分类</a></li>
						 </ul>
				</div>
			    <a id="addFlowComponent" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-point btn-sm"
			                role="button" title="新建流程"><i class="icon icon-add"></i> 新建流程</a>
                <a id="uploadNewFlow" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
			                role="button" title="导入新增"><i class="icon icon-daoru"></i> 导入新增</a>
			    <a id="clearCache" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
			                role="button" title="刷新缓存"><i class="icon icon-shuaxin"></i> 刷新缓存</a>
			    <a id="buttonManage" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
			                role="button" title="流程按钮管理"><i class="icon icon-link"></i> 流程按钮管理</a>
			   <a id="eventManage" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
				  role="button" title="流程事件管理"><i class="icon icon-link"></i> 流程事件管理</a>
			   <div id="cardShowDiv" style="margin: 0;padding: 0;display:inline-block;font-size:14px; height: 28px!important;">
				   &nbsp;&nbsp;显示停用模板&nbsp;&nbsp;<input type="checkbox" id="isShowStopModel" style="height: 12px!important;"/>
				   &nbsp;&nbsp;显示条数：<input type="text" id="limitCount" value="50" width="30"/>
				   <a id="refresh" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
					  role="button" title="刷新"><i class="glyphicon glyphicon-refresh"></i> 刷新</a>
			  </div>
		   </div>
		   <div class="toolbar-right" style="padding-right:10px;padding-top:4px;">
		      <a  href="javascript:void(0)"  onClick="changeShowType(1)" title="卡片展示" style="text-decoration:none;" class="cicon icon_active" id="kpicon">
		         <i class="iconfont icon-changyong" style="font-size:18px;"></i></a>&nbsp;
		     <a  href="javascript:void(0)"  onClick="changeShowType(2)" title="列表展示" style="text-decoration:none;" class="cicon" id="lbicon">
		      <i class="iconfont icon-menu" style="font-size:18px;"></i></a>

		   </div>
		</div>
	</div>
    <div data-options="region:'west',split:true" style="width:300px;">
        <!-- 电子表单分类树 -->
        <ul id="flowTypeTreeUL" class="ztree">
        </ul>
    </div>
    <div data-options="region:'center'" style="overflow:auto;">
    	<div id="kp" style="display: block;">
	    	<div class="layui-layer-title" style="padding-right:10px;">已发布流程
	         <span style="float:right;">
	          &nbsp;<i class="icon iconfont icon-liucheng" style="color: rgb(15, 157, 88);"></i><span class="signs-title">&nbsp;启用</span>
	          <i class="icon iconfont icon-liucheng" style="color: rgb(170, 187, 175);"></i><span class="signs-title">&nbsp;停用</span>
	         </span>
	          </div>
	         <!-- 已发布流程 -->
	         <div id="deployedFlow">
	         </div>

	         <div class="layui-layer-title">未发布流程</div>
	         <!-- 未发布流程 -->
	         <div id="unDeployedFlow">
	         </div>
    	</div>
    	<div id="lb" style="display:none;">
    	   <div id="toolbar_flowModel" class="toolbar">
			<div class="toolbar-right">
				<div id="commonSearch" class="input-group form-tool-search">
					<input type="text" name="flowModel_keyWord"
						id="flowModel_keyWord"
						class="form-control input-sm" placeholder="请输入流程名称"> <label
						id="flowModel_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="flowModel_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div>
		</div>
		<table id="flowModel"></table>
		<div id="flowModelPager"></div>
    	</div>

     </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmdeploy/js/common.js"></script>
<script src="avicit/platform6/bpmreform/bpmdeploy/js/FlowTypeTree.js"></script>
<script src="avicit/platform6/bpmreform/bpmdeploy/js/FlowType.js"></script>
<script src="avicit/platform6/bpmreform/bpmdeploy/js/FlowComponent.js"></script>
<script src="avicit/platform6/bpmreform/bpmdeploy/js/FlowModel.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
    var flowTypeTree;
    var flowType;
    var deployedFlow;
    var unDeployedFlow;
    var flowModel;
    var showType='1';

    $(document).ready(function () {
        deployedFlow = new FlowComponent("deployedFlow","2");
        unDeployedFlow = new FlowComponent("unDeployedFlow","1");
        flowType = new FlowType();
        flowTypeTree = new FlowTypeTree("flowTypeTreeUL");

		$("#clearCache").click(function () {
			avicAjax.ajax({
				url : "platform/bpm/bpmPublishAction/reloadProcessDefinition",
				data : {
				},
				type : "POST",
				dataType : "JSON",
				success : function(result) {
					flowUtils.success("刷新完成");
				}
			});
        });
        $("#buttonManage").click(function(){
        	layer.open({
      	      type: 2,
      	      title: '流程按钮管理',
      	      skin: 'bs-modal',
      	      area: ['100%', '100%'],
      	      maxmin: false,
      	      content:"bpm/bpmButtonExtController/toBpmButtonExtManage"
      	      //content: "avicit/platform6/bpmreform/bpmdeploy/BpmButtonExtManage.jsp"
      	  });
        });
		$("#eventManage").click(function(){
			layer.open({
				type: 2,
				title: '流程事件管理',
				skin: 'bs-modal',
				area: ['100%', '100%'],
				maxmin: false,
				//content:"bpm/bpmconsole/eventManageAction/index"
				content:"bpm/bpmEventController/toBpmEventManage"
			});
		});

        $("#addFlowType").click(function () {
            flowType.add();
        });
        $("#editFlowType").click(function () {
            flowType.edit();
        });
        $("#deleteFlowType").click(function () {
            flowType.del();
        });

        $("#addFlowComponent").click(function () {
            unDeployedFlow.add();
        });
        $("#uploadNewFlow").click(function () {
        	deployedFlow.uploadNewFlow();
        });


        //打开高级查询
  		$('#flowModel_searchAll').bind('click', function() {
  			flowModel.openSearchForm(this, $('#flowModel'));
  		});
  		//关键字段查询按钮绑定事件
  		$('#flowModel_searchPart').bind('click', function() {
  			flowModel.searchByKeyWord();
  		});
  		$('#refresh').bind('click',function(){
			flowTypeTree.clickNode();
		});

  		$('#isShowStopModel').bind('click',function(){
			flowTypeTree.clickNode();
		});
    });
    //设计器保存后刷新当前节点
    window.bpm_operator_refresh = function(){
    	flowTypeTree.clickNode();
	};

	function getOptButtons(cellvalue, options, rowObject) {
        //未发布
		if(rowObject.type=='1'){
			return '<a href="javascript:void(0)" class="iconfont icon-fabu"'
			+'  title="发布" onClick="deploy(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
			+'   title="删除" onClick="deleteUnDeployed(\''+rowObject.id+'\',\''+rowObject.key+'\',\''+rowObject.pdId+'\',\''+rowObject.deployId+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-transfer" title="切换目录"'
			+' onClick="changeCatalog(\''+rowObject.id+'\',\''+rowObject.key+'-1\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-copy"  title="复制" '
			+' onClick="fileCopy(\''+rowObject.id+'\',\''+rowObject.type+'\',\''+rowObject.pdId+'\',\''+rowObject.deployId+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-download"  title="导出" '
			+' onClick="fileDown(\''+rowObject.id+'\',\''+rowObject.type+'\',\''+rowObject.pdId+'\',\''+rowObject.deployId+'\',\''+rowObject.name+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-upload"  title="导入覆盖" '
			+' onClick="fileUpload(\''+rowObject.id+'\',\''+rowObject.type+'\')"></a>&nbsp;&nbsp;'
            +'  <a href="javascript:void(0)" class="glyphicon glyphicon-share"  title="共享到其他组织" '
            +' onClick="share(\''+rowObject.key+'\')"></a>&nbsp;&nbsp;';
		}else{
			var html =  '<a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
			+'   title="删除" onClick="deleteDeployed(\''+rowObject.id+'\',\''+rowObject.pdId+'\',\''+rowObject.deployId+'\',\''+rowObject.key+'\')"></a>&nbsp;&nbsp;';
			if (rowObject.state == 'active') {
				html+='  <a href="javascript:void(0)" class="glyphicon glyphicon-pause" title="停用模板"'
				html+=' onClick="suspendedTemplate(\''+rowObject.deployId+'\')"></a>&nbsp;&nbsp;'
			} else if (rowObject.state == 'suspended') {
				html+='  <a href="javascript:void(0)" class="glyphicon glyphicon-play-circle" title="启用模板"'
				html+=' onClick="startProcessTemplate(\''+rowObject.deployId+'\')"></a>&nbsp;&nbsp;'
			}
			html+='  <a href="javascript:void(0)" class="glyphicon glyphicon-transfer" title="切换目录"'
			html+=' onClick="changeCatalog(\''+rowObject.id+'\',\''+rowObject.key+'-1\')"></a>&nbsp;&nbsp;'
			html+='  <a href="javascript:void(0)" class="glyphicon glyphicon-copy"  title="复制" '
			html+=' onClick="fileCopy(\''+rowObject.id+'\',\''+rowObject.type+'\',\''+rowObject.pdId+'\',\''+rowObject.deployId+'\')"></a>&nbsp;&nbsp;'
			html+='  <a href="javascript:void(0)" class="glyphicon glyphicon-download"  title="导出" '
			html+=' onClick="fileDown(\''+rowObject.id+'\',\''+rowObject.type+'\',\''+rowObject.pdId+'\',\''+rowObject.deployId+'\',\''+rowObject.name+'\')"></a>&nbsp;&nbsp;'
			html+='  <a href="javascript:void(0)" class="glyphicon glyphicon-upload"  title="导入覆盖" '
			html+=' onClick="fileUpload(\''+rowObject.id+'\',\''+rowObject.type+'\')"></a>&nbsp;&nbsp;'
			html+='  <a href="javascript:void(0)" class="glyphicon glyphicon-user"  title="权限设置" '
			html+=' onClick="setPermission(\''+rowObject.deployId+'\',\''+rowObject.permissionId+'\')"></a>&nbsp;&nbsp;'
			html+='  <a href="javascript:void(0)" class="glyphicon glyphicon-sort-by-attributes"  title="排序设置" '
			html+=' onClick="setOrder(\''+rowObject.deployId+'\',\''+rowObject.order+'\')"></a>&nbsp;&nbsp;'
			if(rowObject.forbidManualStart && rowObject.forbidManualStart == "1") {
				html+='  <a href="javascript:void(0)" class="glyphicon glyphicon-ok-circle" title="允许手工发起流程"'
				html+=' onClick="permitManualStart(\''+rowObject.deployId+'\')"></a>&nbsp;&nbsp;'
			}else{
				html+='  <a href="javascript:void(0)" class="glyphicon glyphicon-ban-circle" title="禁止手工发起流程"'
				html+=' onClick="forbidManualStart(\''+rowObject.deployId+'\')"></a>&nbsp;&nbsp;'
			}
			html+='  <a href="javascript:void(0)" class="glyphicon glyphicon-share"  title="共享到其他组织" '
			html+=' onClick="share(\''+rowObject.key+'\')"></a>';
			return html;
		}

	}

	function getEdit(cellvalue, options, rowObject){
		return '<a href="javascript:void(0)" '
		+'  title="'+cellvalue+'" onClick="doEdit(\''+rowObject.id+'\',\''+rowObject.type+'\',\''+rowObject.pdId+'\',\''+rowObject.deployId+'\',\''+rowObject.name+'\')">'+rowObject.name+'</a>';
	}

	function doEdit(id,type,pdId,deployId,name){
		deployedFlow.edit(id, type, pdId, deployId, name);
	}

	function deploy(id){
		unDeployedFlow.deploy(id);
	}

	function deleteUnDeployed(eformComponentId,key,processDefId,deploymentId){
		unDeployedFlow.deleteUnDeployed(eformComponentId, key, processDefId, deploymentId);
	}

	function deleteDeployed(eformComponentId,processDefId,deploymentId,key) {
		deployedFlow.deleteDeployed(eformComponentId, processDefId, deploymentId,key);
	}

	function changeCatalog(nodeId,processDefId){
		unDeployedFlow.changeCatalog(nodeId,processDefId);
	}

	function fileCopy(id, type, pdId, deployId){
		unDeployedFlow.fileCopy(id, type, pdId, deployId);
	}

	function fileDown(id, type, pdId, deployId, flowName){
		unDeployedFlow.fileDown(id, type, pdId, deployId, flowName);
	}

	function fileUpload(id, type){
		unDeployedFlow.fileUpload(id, type);
	}

	function suspendedTemplate(deploymentId){
		deployedFlow.suspendedTemplate(deploymentId);
	}

	function startProcessTemplate(deploymentId){
		deployedFlow.startProcessTemplate(deploymentId);
	}

	function setPermission(deploymentId, permissionId){
		deployedFlow.setPermission(deploymentId, permissionId)
	}
	function setOrder(deploymentId, order){
		deployedFlow.setOrder(deploymentId, order)
	}
	function share(key){
		deployedFlow.share(key)
	}

	function permitManualStart(deploymentId){
		deployedFlow.permitManualStart(deploymentId);
	}

	function forbidManualStart(deploymentId){
		deployedFlow.forbidManualStart(deploymentId);
	}

	//切换卡片方式或列表方式
	function changeShowType(type){
		$(".cicon").removeClass("icon_active");
		//卡片方式
		if("1"==type){
			$("#kp").show();
			$("#lb").hide();
			showType = "1";
			$("#kpicon").addClass("icon_active");
		}else if("2"==type){//列表方式
			$("#kp").hide();
			$("#lb").show();
			showType = "2";
			$("#lbicon").addClass("icon_active");

			//$(window).trigger('resize');
			//$("#lb").css("width",$(document).innerWidth()-250);
			//setTimeout(function(){

			//});
		}

		flowTypeTree.clickNode();

	}
</script>
</body>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
	<form id="formSub">
		<table class="form_commonTable" >
			<tr>
				<th width="18%">流程定义key：</th>
				<td width="30%"><input title="流程定义key"
					class="form-control input-sm" type="text" name="key"
					id="key" />
				</td>

				<th width="15%">流程定义ID：</th>
				<td width="30%">
					<input title="流程定义ID"
					class="form-control input-sm" type="text" name="pdId"
					id="pdId" />
				</td>
			</tr>
			<tr>
				<th width="15%">是否发布：</th>
				<td width="30%">
					<select name="type" id="type" class="easyui-combobox form-control input-sm">
						<option value="">请选择</option>
						<option value="1">未发布</option>
						<option value="2">已发布</option>
					</select>
				</td>
				<th width="15%">流程状态：</th>
				<td width="30%">
					<select name="state" id="state" class="easyui-combobox form-control input-sm">
						<option value="">请选择</option>
						<option value="active">启用</option>
						<option value="suspended">停用</option>
					</select>
				</td>

			</tr>
			<tr>
				<th width="15%">流程名称：</th>
				<td width="30%">
					<input title="流程名称"
						   class="form-control input-sm" type="text" name="name"
						   id="name" />
				</td>
				<th width="15%">&nbsp;</th>
				<td width="30%">
					&nbsp;
				</td>

			</tr>

		</table>
	</form>
</div>
</html>
