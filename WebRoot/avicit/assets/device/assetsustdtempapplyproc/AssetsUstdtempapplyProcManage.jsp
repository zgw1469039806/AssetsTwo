<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
	<!-- ControllerPath = "assets/device/assetsustdtempapplyproc/assetsUstdtempapplyProcController/toAssetsUstdtempapplyProcManage" -->
	<title>管理</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempapplyProc_button_add" permissionDes="添加">
			<a id="assetsUstdtempapplyProc_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempapplyProc_button_edit" permissionDes="编辑">
			<a id="assetsUstdtempapplyProc_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑" style="display:none;"><i class="fa fa-file-text-o"></i> 编辑</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempapplyProc_button_delete" permissionDes="删除">
			<a id="assetsUstdtempapplyProc_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除" style="display:none;"><i class="fa fa-trash-o"></i> 删除</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempapplyProc_button_search" permissionDes="搜索">
			<a id="assetsUstdtempapplyProc_search" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="搜索"><i class="fa fa-trash-o"></i> 搜索</a>
		</sec:accesscontrollist>
	</div>
	<div class="toolbar-right">
		<select id="workFlowSelect" class="form-control input-sm workflow-select">
			<option value="all" selected="selected">全部</option>
			<option value="start">拟稿中</option>
			<option value="active">流转中</option>
			<option value="ended">已完成</option>
		</select>
		<div class="input-group form-tool-search">
			<input type="text" name="assetsUstdtempapplyProc_keyWord" id="assetsUstdtempapplyProc_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
			<label id="assetsUstdtempapplyProc_searchPart" class="icon icon-search form-tool-searchicon"></label>
		</div>

        <%--隐藏高级查询打开操作——修改--%>
		<div class="input-group-btn form-tool-searchbtn" style="display: none;">
			<a id="assetsUstdtempapplyProc_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" style="width:100px;" role="button" >高级查询 <span class="caret"></span></a>
		</div>

		<!-- 页面右上角视图切换框——开始 -->
		<div class="input-group form-tool-search" style="width:130px;">
			<input type="text" name="tableViewSelect" id="tableViewSelect" style="width:120px;" class="form-control input-sm" readonly value="${viewList.get(0)}">
		</div>
		<!-- 页面右上角视图切换框——结束 -->
	</div>
</div>
<table id="assetsUstdtempapplyProc"></table>
<div id="jqGridPager"></div>
</body>

<!-- 高级查询 -->
<div id="searchDialog" style="overflow:auto; display:none; z-index:90;">
	<form id="form" style="padding: 10px;">
		<input type="hidden" id="bpmState" name="bpmState" value="all">
		<table class="form_commonTable">
			<tr>
				<th width="10%">申购单号:</th>
				<td width="15%">
					<input title="申购单号" class="form-control input-sm" type="text" name="subscribeNo" id="subscribeNo"/>
				</td>
				<th width="10%">申请人:</th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="applyBy" name="applyBy">
						<input class="form-control" placeholder="请选择用户" type="text" id="applyByAlias" name="applyByAlias">
						<span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
				<th width="10%">申请人部门:</th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="applyByDept" name="applyByDept">
						<input class="form-control" placeholder="请选择部门" type="text" id="applyByDeptAlias" name="applyByDeptAlias">
						<span class="input-group-addon">
							<i class="glyphicon glyphicon-equalizer"></i>
						</span>
					</div>
				</td>
				<th width="10%">单据状态:</th>
				<td width="15%">
					<input title="单据状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
				</td>
			</tr>
			<tr>
				<th width="10%">设备名称:</th>
				<td width="15%">
					<input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
				</td>
				<th width="10%">设备类别:</th>
				<td width="15%">
                    <%--修改--%>
					<div class="input-group  input-group-sm">
                        <input type="hidden"  id="deviceCategory" name="deviceCategory" types="selectCategory">
                        <input class="form-control" placeholder="请选择类别" type="text" id="deviceCategoryNames" name="deviceCategoryNames" types="selectCategory" lookupCode="NationalStandard" readonly>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-equalizer"></i></span>
                    </div>
				</td>
				<th width="10%">承制单位:</th>
				<td width="15%">
					<input title="承制单位" class="form-control input-sm" type="text" name="manufactureUnit" id="manufactureUnit"/>
				</td>
				<th width="10%">课题代号:</th>
				<td width="15%">
					<input title="课题代号" class="form-control input-sm" type="text" name="subjectCode" id="subjectCode"/>
				</td>
			</tr>
			<tr>
				<th width="10%">主管机关:</th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden"  id="competentAuthority" name="competentAuthority">
						<input class="form-control" placeholder="请选择部门" type="text" id="competentAuthorityAlias" name="competentAuthorityAlias" >
						<span class="input-group-addon" >
							<i class="glyphicon glyphicon-equalizer"></i>
						</span>
					</div>
				</td>
				<th width="10%">型号主管:</th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden"  id="modelDirector" name="modelDirector">
						<input class="form-control" placeholder="请选择用户" type="text" id="modelDirectorAlias" name="modelDirectorAlias" >
						<span class="input-group-addon" >
							<i class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
				<th width="10%">主管所领导:</th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden"  id="competentLeader" name="competentLeader">
						<input class="form-control" placeholder="请选择用户" type="text" id="competentLeaderAlias" name="competentLeaderAlias" >
						<span class="input-group-addon" >
							<i class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
				<th width="10%">申购理由及用途:</th>
				<td width="15%">
					<input title="申购理由及用途" class="form-control input-sm" type="text" name="applyReasonPurpose" id="applyReasonPurpose"/>
				</td>
			</tr>
			<tr>
				<th width="10%">原有设备的情况:</th>
				<td width="15%">
					<input title="原有设备的情况" class="form-control input-sm" type="text" name="orignEquipSituation" id="orignEquipSituation"/>
				</td>
				<th width="10%">使用效率情况:</th>
				<td width="15%">
					<input title="使用效率情况" class="form-control input-sm" type="text" name="efficiencySituation" id="efficiencySituation"/>
				</td>
				<th width="10%">研制内容:</th>
				<td width="15%">
					<input title="研制内容" class="form-control input-sm" type="text" name="developmentContent" id="developmentContent"/>
				</td>
				<th width="10%">技术指标:</th>
				<td width="15%">
					<input title="技术指标" class="form-control input-sm" type="text" name="technicalIndex" id="technicalIndex"/>
				</td>
			</tr>
			<tr>
				<th width="10%">研制周期:</th>
				<td width="15%">
					<input title="研制周期" class="form-control input-sm" type="text" name="developmentCycle" id="developmentCycle"/>
				</td>
				<th width="10%">是否需要安装:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="isNeedInstall" name="isNeedInstall" types="selectLookup">
						<input class="form-control" placeholder="是否需要安装" type="text" id="isNeedInstallNames" name="isNeedInstallNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
				<th width="10%">安装地点ID:</th>
				<td width="15%">
					<input title="安装地点ID" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
				</td>
				<th width="10%">使用电压:</th>
				<td width="15%">
					<input title="使用电压" class="form-control input-sm" type="text" name="serviceVoltage" id="serviceVoltage"/>
				</td>
			</tr>
			<tr>
				<th width="10%">是否对温湿度有要求:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="isHumidityNeed" name="isHumidityNeed" types="selectLookup">
						<input class="form-control" placeholder="是否对温湿度有要求" type="text" id="isHumidityNeedNames" name="isHumidityNeedNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
				<th width="10%">温湿度要求:</th>
				<td width="15%">
					<input title="温湿度要求" class="form-control input-sm" type="text" name="humidityNeed" id="humidityNeed"/>
				</td>
				<th width="10%">是否有用水要求:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="isWaterNeed" name="isWaterNeed" types="selectLookup">
						<input class="form-control" placeholder="是否有用水要求" type="text" id="isWaterNeedNames" name="isWaterNeedNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
				<th width="10%">用水要求:</th>
				<td width="15%">
					<input title="用水要求" class="form-control input-sm" type="text" name="waterNeed" id="waterNeed"/>
				</td>
			</tr>
			<tr>
				<th width="10%">是否有用气要求:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="isGasNeed" name="isGasNeed" types="selectLookup">
						<input class="form-control" placeholder="是否有用气要求" type="text" id="isGasNeedNames" name="isWaterNeedNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
				<th width="10%">用气要求:</th>
				<td width="15%">
					<input title="用气要求" class="form-control input-sm" type="text" name="gasNeed" id="gasNeed"/>
				</td>
				<th width="10%">是否有气体排放:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="isLet" name="isLet" types="selectLookup">
						<input class="form-control" placeholder="是否有气体排放" type="text" id="isLetNames" name="isLetNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
				<th width="10%">气体排放要求:</th>
				<td width="15%">
					<input title="气体排放要求" class="form-control input-sm" type="text" name="letNeed" id="letNeed"/>
				</td>
			</tr>
			<tr>
				<th width="10%">是否有其他特殊要求:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="isOtherNeed" name="isOtherNeed" types="selectLookup">
						<input class="form-control" placeholder="是否有其他特殊要求" type="text" id="isOtherNeedNames" name="isOtherNeedNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
				<th width="10%">其他特殊要求:</th>
				<td width="15%">
					<input title="其他特殊要求" class="form-control input-sm" type="text" name="otherNeed" id="otherNeed"/>
				</td>
				<th width="10%">以上需求条件在拟安装地点是否都已具备:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="isAboveConditions" name="isAboveConditions" types="selectLookup">
						<input class="form-control" placeholder="以上需求条件在拟安装地点是否都已具备" type="text" id="isAboveConditionsNames" name="isAboveConditionsNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
				<th width="10%">是否计量:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="isMetering" name="isMetering" types="selectLookup">
						<input class="form-control" placeholder="是否计量" type="text" id="isMeteringNames" name="isMeteringNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">计量要求:</th>
				<td width="15%">
					<input title="计量要求" class="form-control input-sm" type="text" name="meteringRequirement" id="meteringRequirement"/>
				</td>
				<th width="10%">经费概算:</th>
				<td width="15%">
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="financialEstimate" id="financialEstimate" data-min="0.001" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th width="10%">经费来源:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="financialResources" name="financialResources" types="selectLookup">
						<input class="form-control" placeholder="是否计量" type="text" id="financialResourcesNames" name="financialResourcesNames" types="selectLookup" lookupCode="FINANCIAL_RESOURCES" readonly>
					</div>
				</td>
				<th width="10%">所属项目:</th>
				<td width="15%">
					<input title="所属项目" class="form-control input-sm" type="text" name="belongProject" id="belongProject"/>
				</td>
			</tr>
			<tr>
				<th width="10%">项目序号:</th>
				<td width="15%">
					<input title="项目序号" class="form-control input-sm" type="text" name="projectNo" id="projectNo"/>
				</td>
				<th width="10%">批复名称:</th>
				<td width="15%">
					<input title="批复名称" class="form-control input-sm" type="text" name="replyName" id="replyName"/>
				</td>
				<th width="10%">立项单号:</th>
				<td width="15%">
					<input title="立项单号" class="form-control input-sm" type="text" name="approvalFormNumber" id="approvalFormNumber"/>
				</td>
				<th width="10%">是否测试设备:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="isTestDevice" name="isTestDevice" types="selectLookup">
						<input class="form-control" placeholder="是否测试设备" type="text" id="isTestDeviceNames" name="isTestDeviceNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">主管设备所领导:</th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden"  id="competentDeviceLeader" name="competentDeviceLeader">
						<input class="form-control" placeholder="请选择用户" type="text" id="competentDeviceLeaderAlias" name="competentDeviceLeaderAlias" >
						<span class="input-group-addon" >
							<i class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>

<!-- 视图选择弹框——开始 -->
<div id="selectViewDialog" style="overflow: auto;display: none">
	<table class="ui-jqgrid-btable ui-common-table table table-bordered" style="width: 140px;">
		<tbody id="selectViewTbody">
			<c:forEach var="index" begin="0" end="${viewList.size()-1}" step="1">
				<c:if test="${viewList.get(index) != '系统默认视图'}">
					<tr>
						<td role="gridcell" onclick="switchView('${viewList.get(index)}')" title="${viewList.get(index)}">
								${viewList.get(index)}
						</td>
						<td>
							<i class="fa fa-file-text-o" onclick="editView('${viewList.get(index)}')" title="编辑视图"></i>
							<i class="fa fa-trash-o" onclick="delView('${viewList.get(index)}')" title="删除视图"></i>
						</td>
					</tr>
				</c:if>
			</c:forEach>
			<tr>
				<td role="gridcell" onclick="addView()" title="创建新视图">
					创建新视图
				</td>
				<td>
					<i class="fa fa-plus" onclick="addView()" title="创建视图"></i>
				</td>
			</tr>
			<tr>
				<td colspan="2" role="gridcell" onclick="switchView('系统默认视图')" title="系统默认视图">
					系统默认视图
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- 视图选择弹框——结束 -->

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>

<!-- 业务的js -->
<script src="avicit/assets/device/assetsustdtempapplyproc/js/AssetsUstdtempapplyProc.js" type="text/javascript"></script>

<!-- 视图的js -->
<script src="avicit/assets/device/usertablemodel/js/UserTableModel.js" type="text/javascript"></script>

<script type="text/javascript">
	var assetsUstdtempapplyProc;
	var dataGridColModel;

	var userTableModel = new UserTableModel();//新增视图处理
	var toolBar;//新增工具栏变量

	var searchNames = new Array();
	var searchTips = new Array();

	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="assetsUstdtempapplyProc.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
	}

	function formatDateForHref(cellvalue, options, rowObject){
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="assetsUstdtempapplyProc.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
	}

	/*视图管理模块函数——开始*/
	//切换列表视图
	function switchView(viewName){
		var paramList = [];
		paramList.push('AssetsUstdtempapplyProc');
		paramList.push(viewName);

		$.ajax({
			url : "assets/device/usertablemodel/userTableModelController/operation/get",
			data : JSON.stringify(paramList),
			contentType : 'application/json',
			type : 'post',
			dataType : 'json',
			success : function(r){
				if (r.flag == "success"){
					dataGridColModel = r.dataGridColModelJson;
					dataGridColModel = JSON.parse(dataGridColModel);

					for(i=0; i<dataGridColModel.length; i++){
						if(dataGridColModel[i].formatter != undefined){
							if(dataGridColModel[i].formatter.indexOf('formatValue') > -1){
								dataGridColModel[i].formatter = formatValue;
							}
							else if(dataGridColModel[i].formatter.indexOf('format') > -1){
								dataGridColModel[i].formatter = format;
							}
						}
					}

					//清除列表后刷新
					$.jgrid.gridUnload('assetsUstdtempapplyProc');
					assetsUstdtempapplyProc = new AssetsUstdtempapplyProc('assetsUstdtempapplyProc','${url}','searchDialog','form','assetsUstdtempapplyProc_keyWord',searchNames,dataGridColModel);

					//添加表头搜索
					AddHeaderSearch(dataGridColModel, 'assetsUstdtempapplyProc', assetsUstdtempapplyProc);

					//添加表头拖拽
					BuildDrag('assetsUstdtempapplyProc', '${url}', 'searchDialog', 'form', 'assetsUstdtempapplyProc_keyWord', dataGridColModel, searchNames, assetsUstdtempapplyProc, toolBar);

					document.getElementById('tableViewSelect').value = viewName;
				}else{
					layer.alert('视图切换失败,请联系管理员：'+r.message, {
								icon: 7,
								area: ['400px', ''], //宽高
								closeBtn: 0,
								btn: ['关闭'],
								title:"提示"
							}
					);
				}
			}
		});
	}

	//编辑视图
	function editView(viewName) {
		userTableModel.modify('AssetsUstdtempapplyProc', viewName);
	}

	//删除视图
	function delView(viewName) {
		var trEle = event.target.parentNode.parentNode;
		userTableModel.del('AssetsUstdtempapplyProc', viewName, trEle);
	}

	//创建新视图
	function addView(){
		userTableModel.insert('AssetsUstdtempapplyProc');
	}
	/*视图管理模块函数——结束*/

	//刷新本页面
	window.bpm_operator_refresh = function(){
		assetsUstdtempapplyProc.reLoad();
	};

	//页面初始化
	$(document).ready(function () {
		//获取表头字段配置
		dataGridColModel = ${dataGridColModelJson};
		for(i=0; i<dataGridColModel.length; i++){
			if(dataGridColModel[i].formatter != undefined){
				if(dataGridColModel[i].formatter.indexOf('formatValue') > -1){
					dataGridColModel[i].formatter = formatValue;
				}
				else if(dataGridColModel[i].formatter.indexOf('format') > -1){
					dataGridColModel[i].formatter = format;
				}
			}
		}

		searchNames.push("subscribeNo");
		searchTips.push("申购单号");

		searchNames.push("createdByTel");
		searchTips.push("申请人电话");

		var searchC = searchTips.length==2?'或' + searchTips[1] : "";
		$('#assetsUstdtempapplyProc_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);

		assetsUstdtempapplyProc = new AssetsUstdtempapplyProc('assetsUstdtempapplyProc','${url}','searchDialog','form','assetsUstdtempapplyProc_keyWord',searchNames,dataGridColModel);

		//添加表头搜索
		AddHeaderSearch(dataGridColModel, 'assetsUstdtempapplyProc', assetsUstdtempapplyProc);

		//添加表头拖拽
		toolBar = document.getElementById('tableToolbar');
		BuildDrag('assetsUstdtempapplyProc', '${url}', 'searchDialog', 'form', 'assetsUstdtempapplyProc_keyWord', dataGridColModel, searchNames, assetsUstdtempapplyProc, toolBar);

		//添加按钮绑定事件
		$('#assetsUstdtempapplyProc_insert').bind('click', function(){
			assetsUstdtempapplyProc.insert();
		});

		//编辑按钮绑定事件
		$('#assetsUstdtempapplyProc_modify').bind('click', function(){
			assetsUstdtempapplyProc.modify();
		});

		//删除按钮绑定事件
		$('#assetsUstdtempapplyProc_del').bind('click', function(){
			assetsUstdtempapplyProc.del();
		});

		//查询按钮绑定事件
		$('#assetsUstdtempapplyProc_searchPart').bind('click', function(){
			assetsUstdtempapplyProc.searchByKeyWord();
		});

		//打开高级查询框
		$('#assetsUstdtempapplyProc_searchAll').bind('click', function(){
			assetsUstdtempapplyProc.openSearchForm(this,800,400);
		});

		//左侧查询按钮绑定事件
		$('#assetsUstdtempapplyProc_search').bind('click', function(){
			assetsUstdtempapplyProc.searchData(dataGridColModel);
		});

		//视图切换弹框绑定事件
		$('#tableViewSelect').bind('click', function(){
			assetsUstdtempapplyProc.openSelectView(this,140,200);
		});

		//根据流程状态加载数据
		$('#workFlowSelect').bind('change',function(){
			assetsUstdtempapplyProc.initWorkFlow($(this).val());
		});

		//申请人选择弹框事件
		$('#applyByAlias').on('focus',function(e){
			new H5CommonSelect({type:'userSelect', idFiled:'applyBy',textFiled:'applyByAlias',selectModel:'multi'});
			this.blur();
			nullInput(e);
		});

		//申请人部门选择弹框事件
		$('#applyByDeptAlias').on('focus',function(e){
			new H5CommonSelect({type:'deptSelect', idFiled:'applyByDept',textFiled:'applyByDeptAlias',selectModel:'multi'});
			this.blur();
			nullInput(e);
		});

		//主管机关选择弹框事件
		$('#competentAuthorityAlias').on('focus',function(e){
			new H5CommonSelect({type:'deptSelect', idFiled:'competentAuthority',textFiled:'competentAuthorityAlias',selectModel:'multi'});
			this.blur();
			nullInput(e);
		});

		//型号主管选择弹框事件
		$('#modelDirectorAlias').on('focus',function(e){
			new H5CommonSelect({type:'userSelect', idFiled:'modelDirector',textFiled:'modelDirectorAlias',selectModel:'multi'});
			this.blur();
			nullInput(e);
		});

		//主管所领导选择弹框事件
		$('#competentLeaderAlias').on('focus',function(e){
			new H5CommonSelect({type:'userSelect', idFiled:'competentLeader',textFiled:'competentLeaderAlias',selectModel:'multi'});
			this.blur();
			nullInput(e);
		});

		//主管设备所领导选择弹框事件
		$('#competentDeviceLeaderAlias').on('focus',function(e){
			new H5CommonSelect({type:'userSelect', idFiled:'competentDeviceLeader',textFiled:'competentDeviceLeaderAlias',selectModel:'multi'});
			this.blur();
			nullInput(e);
		});

        //设备分类选择弹框事件
        $('#deviceCategoryNames').on('focus',function(e){
            //获取当前已选中的分类
            var defaultLoadCategoryId = $('#deviceCategory').val();

            new H5CommonSelect({type:'categorySelect', idFiled:'deviceCategory',textFiled:'deviceCategoryNames',selectModel:'multi',currentCategory:'NationalStandard',defaultLoadCategoryId:defaultLoadCategoryId});
            this.blur();
            nullInput(e);
        });
	});
</script>
</html>