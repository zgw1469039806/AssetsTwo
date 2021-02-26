<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String importlibs = "common,table,form";
%>

<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsustdregisterproc/assetsUstdregisterProcController/toAssetsUstdregisterProcManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdregisterProc_button_add" permissionDes="添加">
				<a id="assetsUstdregisterProc_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加
				</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdregisterProc_button_edit" permissionDes="编辑">
				<a id="assetsUstdregisterProc_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑" style="display:none;">
					<i class="fa fa-file-text-o"></i> 编辑
				</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdregisterProc_button_delete" permissionDes="删除">
				<a id="assetsUstdregisterProc_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
				   role="button" title="删除" style="display:none;">
					<i class="fa fa-trash-o"></i> 删除
				</a>
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
				<input type="text" name="assetsUstdregisterProc_keyWord" id="assetsUstdregisterProc_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
				<label id="assetsUstdregisterProc_searchPart" class="icon icon-search form-tool-searchicon"></label>
			</div>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="assetsUstdregisterProc_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" style="display:none;">
					高级查询 <span class="caret"></span>
				</a>
			</div>
			<!-- 页面右上角视图切换框——开始 -->
			<div class="input-group form-tool-search" style="width:130px;">
				<input type="text" name="tableViewSelect" id="tableViewSelect" style="width:120px;" class="form-control input-sm" readonly value="${viewList.get(0)}">
			</div>
			<!-- 页面右上角视图切换框——结束 -->
		</div>
	</div>
	<table id="assetsUstdregisterProc"></table>
	<div id="jqGridPager"></div>
</body>

<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">非标立项编号:</th>
                <td width="15%">
                    <input title="非标立项编号" class="form-control input-sm" type="text" name="registerNo" id="registerNo"/>
                </td>

                <th width="10%">申请人部门:</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-equalizer"></i>
						</span>
                    </div>
                </td>

                <th width="10%">申请人电话:</th>
                <td width="15%">
                    <input title="申请人电话" class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"/>
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
					<div class="input-group  input-group-sm">
						<input type="hidden"  id="deviceCategory" name="deviceCategory" types="selectCategory">
						<input class="form-control" placeholder="请选择类别" type="text" id="deviceCategoryNames" name="deviceCategoryNames" types="selectCategory" lookupCode="NationalStandard" readonly>
						<span class="input-group-addon">
							<i class="glyphicon glyphicon-equalizer"></i>
						</span>
					</div>
                </td>

                <th width="10%">技术负责人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="techIncharge" name="techIncharge">
                        <input class="form-control" placeholder="请选择用户" type="text" id="techInchargeAlias" name="techInchargeAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
                    </div>
                </td>
                <th width="10%">项目主管:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="projectDirector" name="projectDirector">
                        <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias" name="projectDirectorAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">台/套:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="singleOrSet" name="singleOrSet" types="selectLookup">
						<input class="form-control" placeholder="台/套" type="text" id="singleOrSetNames" name="singleOrSetNames" types="selectLookup" lookupCode="SINGLE_OR_SET" readonly>
					</div>
                </td>
                <th width="10%">台(套)数:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="setCount" id="setCount" data-min="0" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
                <th width="10%">预算单价:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="budgetPrice" id="budgetPrice" data-min="0.001" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
                <th width="10%">经费概算:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="financialEstimate" id="financialEstimate" data-min="0.001" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">经费来源:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="financialResources" name="financialResources" types="selectLookup">
						<input class="form-control" placeholder="经费来源" type="text" id="financialResourcesNames" name="financialResourcesNames" types="selectLookup" lookupCode="FINANCIAL_RESOURCES" readonly>
					</div>
                </td>
                <th width="10%">所属项目:</th>
                <td width="15%">
                    <input title="所属项目" class="form-control input-sm" type="text" name="belongProject" id="belongProject"/>
                </td>
                <th width="10%">项目序号:</th>
                <td width="15%">
                    <input title="项目序号" class="form-control input-sm" type="text" name="projectNo" id="projectNo"/>
                </td>
                <th width="10%">简易/大型设备:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="simpleOrLarge" name="simpleOrLarge" types="selectLookup">
						<input class="form-control" placeholder="简易/大型设备" type="text" id="simpleOrLargeNames" name="simpleOrLargeNames" types="selectLookup" lookupCode="SIMPLE_LARGE_SCALE" readonly>
					</div>
                </td>
            </tr>
            <tr>
                <th width="10%">安装地点:</th>
                <td width="15%">
                    <input title="安装地点" class="form-control input-sm" type="text" name="installPosition" id="installPosition"/>
                </td>
                <th width="10%">安装设备楼层承重能否满足:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="isSatisfyBearing" name="isSatisfyBearing" types="selectLookup">
						<input class="form-control" placeholder="安装设备楼层承重能否满足" type="text" id="isSatisfyBearingNames" name="isSatisfyBearingNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
                <th width="10%">设备是否有室外机:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="hasOutdoorUnit" name="hasOutdoorUnit" types="selectLookup">
						<input class="form-control" placeholder="设备是否有室外机" type="text" id="hasOutdoorUnitNames" name="hasOutdoorUnitNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
                <th width="10%">所安装位置是否允许安装室外机:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="isAllowOutdoorunit" name="isAllowOutdoorunit" types="selectLookup">
						<input class="form-control" placeholder="所安装位置是否允许安装室外机" type="text" id="isAllowOutdoorunitNames" name="isAllowOutdoorunitNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
            </tr>
            <tr>
                <th width="10%">所安装位置是否具备设置地基条件:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="hasFoundation" name="hasFoundation" types="selectLookup">
						<input class="form-control" placeholder="所安装位置是否具备设置地基条件" type="text" id="hasFoundationNames" name="hasFoundationNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
                <th width="10%">使用电压:</th>
                <td width="15%">
                    <input title="使用电压" class="form-control input-sm" type="text" name="useVoltage" id="useVoltage"/>
                </td>
                <th width="10%">安装位置是否具备电压条件:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="hasVoltageCondition" name="hasVoltageCondition" types="selectLookup">
						<input class="form-control" placeholder="安装位置是否具备电压条件" type="text" id="hasVoltageConditionNames" name="hasVoltageConditionNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
                <th width="10%">是否有温湿度要求:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="hasHumidityNeed" name="hasHumidityNeed" types="selectLookup">
						<input class="form-control" placeholder="是否有温湿度要求" type="text" id="hasHumidityNeedNames" name="hasHumidityNeedNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
            </tr>
            <tr>
                <th width="10%">温湿度要求:</th>
                <td width="15%">
                    <input title="温湿度要求" class="form-control input-sm" type="text" name="humidityNeed" id="humidityNeed"/>
                </td>
                <th width="10%">是否有洁净度要求:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="hasCleanlinessNeed" name="hasCleanlinessNeed" types="selectLookup">
						<input class="form-control" placeholder="是否有洁净度要求" type="text" id="hasCleanlinessNeedNames" name="hasCleanlinessNeedNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
                <th width="10%">净度要求:</th>
                <td width="15%">
                    <input title="净度要求" class="form-control input-sm" type="text" name="cleanlinessNeed" id="cleanlinessNeed"/>
                </td>
                <th width="10%">是否有用水要求:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="hasWaterNeed" name="hasWaterNeed" types="selectLookup">
						<input class="form-control" placeholder="是否有用水要求" type="text" id="hasWaterNeedNames" name="hasWaterNeedNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
            </tr>
            <tr>
                <th width="10%">用水要求:</th>
                <td width="15%">
                    <input title="用水要求" class="form-control input-sm" type="text" name="waterNeed" id="waterNeed"/>
                </td>
                <th width="10%">是否有用气要求:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="hasGasNeed" name="hasGasNeed" types="selectLookup">
						<input class="form-control" placeholder="是否有用气要求" type="text" id="hasGasNeedNames" name="hasGasNeedNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
                <th width="10%">用气要求:</th>
                <td width="15%">
                    <input title="用气要求" class="form-control input-sm" type="text" name="gasNeed" id="gasNeed"/>
                </td>
                <th width="10%">是否有气体排放要求:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="hasLetNeed" name="hasLetNeed" types="selectLookup">
						<input class="form-control" placeholder="是否有气体排放要求" type="text" id="hasLetNeedNames" name="hasLetNeedNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
            </tr>
            <tr>
                <th width="10%">气体排放要求:</th>
                <td width="15%">
                    <input title="气体排放要求" class="form-control input-sm" type="text" name="letNeed" id="letNeed"/>
                </td>
                <th width="10%">是否有其他特殊要求:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="hasOtherNeed" name="hasOtherNeed" types="selectLookup">
						<input class="form-control" placeholder="是否有其他特殊要求" type="text" id="hasOtherNeedNames" name="hasOtherNeedNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
                <th width="10%">其他特殊要求:</th>
                <td width="15%">
                    <input title="其他特殊要求" class="form-control input-sm" type="text" name="otherNeed" id="otherNeed"/>
                </td>
                <th width="10%">以上需求条件在拟安装地点是否都已具备:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="hasAboveConditions" name="hasAboveConditions" types="selectLookup">
						<input class="form-control" placeholder="以上需求条件在拟安装地点是否都已具备" type="text" id="hasAboveConditionsNames" name="hasAboveConditionsNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
            </tr>
            <tr>
                <th width="10%">条件不具备补充说明:</th>
                <td width="15%">
                    <input title="条件不具备补充说明" class="form-control input-sm" type="text" name="supplementaryNotes" id="supplementaryNotes"/>
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
<script src="avicit/assets/device/assetsustdregisterproc/js/AssetsUstdregisterProc.js" type="text/javascript"></script>

<!-- 视图的js -->
<script src="avicit/assets/device/usertablemodel/js/UserTableModel.js" type="text/javascript"></script>

<script type="text/javascript">
    var assetsUstdregisterProc;
    var dataGridColModel;

	var userTableModel = new UserTableModel();//新增视图处理
	var toolBar;//新增工具栏变量

	var searchNames = new Array();
	var searchTips = new Array();

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsUstdregisterProc.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsUstdregisterProc.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

	/*视图管理模块函数——开始*/
	//切换列表视图
	function switchView(viewName){
		var paramList = [];
		paramList.push('AssetsUstdregisterProc');
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
					$.jgrid.gridUnload('assetsUstdregisterProc');
					assetsUstdregisterProc = new AssetsUstdregisterProc('assetsUstdregisterProc', '${url}', 'searchDialog', 'form', 'assetsUstdregisterProc_keyWord', searchNames, dataGridColModel);

					//添加表头搜索
					AddHeaderSearch(dataGridColModel, 'assetsUstdregisterProc', assetsUstdregisterProc);

					//添加表头拖拽
					toolBar = document.getElementById('tableToolbar');
					BuildDrag('assetsUstdregisterProc', '${url}', 'searchDialog', 'form', 'assetsUstdregisterProc_keyWord', searchNames, dataGridColModel, assetsUstdregisterProc, toolBar);

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
		userTableModel.modify('AssetsUstdregisterProc', viewName);
	}

	//删除视图
	function delView(viewName) {
		var trEle = event.target.parentNode.parentNode;
		userTableModel.del('AssetsUstdregisterProc', viewName, trEle);
	}

	//创建新视图
	function addView(){
		userTableModel.insert('AssetsUstdregisterProc');
	}
	/*视图管理模块函数——结束*/

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsUstdregisterProc.reLoad();
    };
    $(document).ready(function () {
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

        searchNames.push("registerNo");
        searchTips.push("非标立项编号");

        searchNames.push("deviceName");
        searchTips.push("设备名称");

        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsUstdregisterProc_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);

        assetsUstdregisterProc = new AssetsUstdregisterProc('assetsUstdregisterProc', '${url}', 'searchDialog', 'form', 'assetsUstdregisterProc_keyWord', searchNames, dataGridColModel);

		//添加表头搜索
		AddHeaderSearch(dataGridColModel, 'assetsUstdregisterProc', assetsUstdregisterProc);

		//添加表头拖拽
		toolBar = document.getElementById('tableToolbar');
		BuildDrag('assetsUstdregisterProc', '${url}', 'searchDialog', 'form', 'assetsUstdregisterProc_keyWord', searchNames, dataGridColModel, assetsUstdregisterProc, toolBar);

		//视图切换弹框绑定事件
		$('#tableViewSelect').bind('click', function(){
			assetsUstdregisterProc.openSelectView(this,140,200);
		});

        //添加按钮绑定事件
        $('#assetsUstdregisterProc_insert').bind('click', function () {
            assetsUstdregisterProc.insert();
        });

        //编辑按钮绑定事件
        $('#assetsUstdregisterProc_modify').bind('click', function () {
            assetsUstdregisterProc.modify();
        });

        //删除按钮绑定事件
        $('#assetsUstdregisterProc_del').bind('click', function () {
            assetsUstdregisterProc.del();
        });

        //查询按钮绑定事件
        $('#assetsUstdregisterProc_searchPart').bind('click', function () {
            assetsUstdregisterProc.searchByKeyWord();
        });

        //打开高级查询框
        $('#assetsUstdregisterProc_searchAll').bind('click', function () {
            assetsUstdregisterProc.openSearchForm(this, 800, 400);
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsUstdregisterProc.initWorkFlow($(this).val());
        });

        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias',selectModel:'multi'});
            this.blur();
            nullInput(e);
        });

        $('#techInchargeAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'techIncharge', textFiled: 'techInchargeAlias',selectModel:'multi'});
            this.blur();
            nullInput(e);
        });

        $('#projectDirectorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'projectDirector', textFiled: 'projectDirectorAlias',selectModel:'multi'});
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