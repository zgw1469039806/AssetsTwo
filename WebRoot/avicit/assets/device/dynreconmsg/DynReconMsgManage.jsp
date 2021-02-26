<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/dynreconmsg/dynReconMsgController/toDynReconMsgManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div id="panelnorth"
     data-options="region:'north',height:fixheight(.5),onResize:function(a){$('#dynReconMsg').setGridWidth(a);$('#dynReconMsg').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
    <div id="toolbar_dynReconMsg" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynReconMsg_button_add"
                                   permissionDes="添加">
                <a id="dynReconMsg_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynReconMsg_button_edit"
                                   permissionDes="编辑">
                <a id="dynReconMsg_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   style="display:none;" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynReconMsg_button_delete"
                                   permissionDes="删除">
                <a id="dynReconMsg_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                   style="display:none;" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
            </sec:accesscontrollist>
        </div>
        <div class="toolbar-right">
            <select id="workFlowSelect"
                    class="form-control input-sm workflow-select">
                <option value="all" selected="selected">全部</option>
                <option value="start">拟稿中</option>
                <option value="active">流转中</option>
                <option value="ended">已完成</option>
            </select>
            <div class="input-group form-tool-search" style="width:125px">
                <input type="text" name="dynReconMsg_keyWord" id="dynReconMsg_keyWord" style="width:125px;"
                       class="form-control input-sm" placeholder="请输入查询条件">
                <label id="dynReconMsg_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="dynReconMsg_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
                    <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="dynReconMsg"></table>
    <div id="dynReconMsgPager"></div>
</div>
<div id="centerpanel"
     data-options="region:'center',split:true,onResize:function(a){$('#assetsReconstructionCheck').setGridWidth(a); $('#assetsReconstructionCheck').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
	<div class="eform-tab" style="border: 1px dashed #BBB;" contenteditable="false">
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" onclick="$(window).trigger('resize');" class="presentation active" contenteditable="false"><a href="#1d4749d5-8b1d-41ae-963e-d23e85dac9c4" aria-controls="1d4749d5-8b1d-41ae-963e-d23e85dac9c4" role="tab" data-toggle="tab">上报列表</a></li>
			<li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#9a51bc51-0436-4fd6-9868-60795cdac745" aria-controls="9a51bc51-0436-4fd6-9868-60795cdac745" role="tab" data-toggle="tab">下发列表</a></li>
		</ul>
		<div class="tab-content" style="height: 100%; min-height: 40px;">
			<div role="tabpanel" class="tab-pane active" contenteditable="false" id="1d4749d5-8b1d-41ae-963e-d23e85dac9c4" style="height: 100%; min-height: 40px;">
				<div id="toolbar_assetsReconstructionCheck" class="toolbar">
                    <div class="toolbar-left">
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynReconMsg_button_exp"
                                               permissionDes="导出">
                            <a id="dynReconMsg_expdp" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                               role="button" title="导出"><i class="fa fa-plus"></i> 导出</a>
                        </sec:accesscontrollist>
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynReconMsg_button_edit"
                                               permissionDes="编辑">
                            <a id="dynReconMsg_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                               style="display:none;" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
                        </sec:accesscontrollist>
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynReconMsg_button_delete"
                                               permissionDes="删除">
                            <a id="dynReconMsg_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                               style="display:none;" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                        </sec:accesscontrollist>
                    </div>
					<div class="toolbar-right">
						<div class="input-group form-tool-search" style="width:125px">
							<input type="text" name="assetsReconstructionCheck_keyWord" id="assetsReconstructionCheck_keyWord"
								   style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
							<label id="assetsReconstructionCheck_searchPart" class="icon icon-search form-tool-searchicon"></label>
						</div>
						<div class="input-group-btn form-tool-searchbtn">
							<a id="assetsReconstructionCheck_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
							   role="button">高级查询 <span class="caret"></span></a>
						</div>
					</div>
				</div>
				<table id="assetsReconstructionCheck"></table>
				<div id="assetsReconstructionCheckPager"></div>
			</div>
			<div role="tabpanel" class="tab-pane" contenteditable="false" id="9a51bc51-0436-4fd6-9868-60795cdac745" style="height: 100%; min-height: 40px;">
				<div id="toolbar_assetsReconstructionR" class="toolbar">
                    <div class="toolbar-left">
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynReconMsg_button_imp"
                                               permissionDes="导入">
                            <a id="dynReconMsg_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                               role="button" title="导入"><i class="fa fa-plus"></i> 导入</a>
                        </sec:accesscontrollist>
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynReconMsg_button_edit"
                                               permissionDes="编辑">
                            <a id="dynReconMsg_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                               style="display:none;" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
                        </sec:accesscontrollist>
                        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynReconMsg_button_delete"
                                               permissionDes="删除">
                            <a id="dynReconMsg_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
                               style="display:none;" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                        </sec:accesscontrollist>
                    </div>

                    <div class="toolbar-right">
						<div class="input-group form-tool-search" style="width:125px">
							<input type="text" name="assetsReconstructionR_keyWord" id="assetsReconstructionR_keyWord" style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
							<label id="assetsReconstructionR_searchPart" class="icon icon-search form-tool-searchicon"></label>
						</div>
						<div class="input-group-btn form-tool-searchbtn">
							<a id="assetsReconstructionR_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
						</div>
					</div>
				</div>
				<table id="assetsReconstructionR"></table>
				<div id="assetsReconstructionRPager"></div>
			</div>
		</div>
	</div>

</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">年度:</th>
                <td width="15%">
                    <input title="年度" class="form-control input-sm" type="text" name="applyYear" id="applyYear"/>
                </td>
                <th width="10%">字段_1:</th>
                <td width="15%">
                    <input title="字段_1" class="form-control input-sm" type="text" name="author" id="author"/>
                </td>
                <th width="10%">发布日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedateBegin"
                               id="releasedateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">发布日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedateEnd" id="releasedateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">部门上报截至日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="deptDeadlineBegin"
                               id="deptDeadlineBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">部门上报截至日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="deptDeadlineEnd"
                               id="deptDeadlineEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">电话:</th>
                <td width="15%">
                    <input title="电话" class="form-control input-sm" type="text" name="telephone" id="telephone"/>
                </td>
                <th width="10%">发布人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="dept" name="dept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" name="deptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">备注:</th>
                <td width="15%">
                    <input title="备注" class="form-control input-sm" type="text" name="formRemarks" id="formRemarks"/>
                </td>
                <th width="10%">标题:</th>
                <td width="15%">
                    <input title="标题" class="form-control input-sm" type="text" name="formTitle" id="formTitle"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 子表1高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
    <form id="formSub">
        <table class="form_commonTable">
            <tr>
                <th width="10%">改造申请单号:</th>
                <td width="15%">
                    <input title="改造申请单号" class="form-control input-sm" type="text" name="reconstructionId"
                           id="reconstructionId"/>
                </td>
                <th width="10%">申请人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDeptSub" name="createdByDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAliasSub"
                               name="createdByDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">单据状态:</th>
                <td width="15%">
                    <input title="单据状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
                </td>
                <th width="10%">责任部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDeptSub" name="ownerDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAliasSub"
                               name="ownerDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">责任人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerIdSub" name="ownerId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAliasSub"
                               name="ownerIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">责任人联系方式:</th>
                <td width="15%">
                    <input title="责任人联系方式" class="form-control input-sm" type="text" name="ownerTel" id="ownerTel"/>
                </td>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
                <th width="10%">密级:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="密级"
                                  isNull="true" lookupCode="SECRET_LEVEL"/>
                </td>
            </tr>
            <tr>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">设备型号:</th>
                <td width="15%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
                <th width="10%">设备规格:</th>
                <td width="15%">
                    <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>
                <th width="10%">生产厂家:</th>
                <td width="15%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId"
                           id="manufacturerId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">立卡时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="likaDateBegin" id="likaDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">立卡时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="likaDateEnd" id="likaDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">设备原值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="originalValue" id="originalValue"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">现有结构性能指标:</th>
                <td width="15%">
                    <input title="现有结构性能指标" class="form-control input-sm" type="text" name="existingPerformance"
                           id="existingPerformance"/>
                </td>
            </tr>
            <tr>
                <th width="10%">改造理由:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="改造理由" name="reformingReason"
                              id="reformingReason"></textarea>
                </td>
                <th width="10%">改造后结构性能指标:</th>
                <td width="15%">
                    <input title="改造后结构性能指标" class="form-control input-sm" type="text" name="afterPerformance"
                           id="afterPerformance"/>
                </td>
                <th width="10%">改造途径:</th>
                <td width="15%">
                    <input title="改造途径" class="form-control input-sm" type="text" name="transformWay"
                           id="transformWay"/>
                </td>
                <th width="10%">经费预算:</th>
                <td width="15%">
                    <input title="经费预算" class="form-control input-sm" type="text" name="budget" id="budget"/>
                </td>
            </tr>
            <tr>
                <th width="10%">净值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netValue" id="netValue"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">设备类别:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory"
                                  title="设备类别" isNull="true" lookupCode="DEVICE_CATEGORY"/>
                </td>
                <th width="10%">申请人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPersonSub" name="createdByPerson">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAliasSub"
                               name="createdByPersonAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 子表2高级查询 -->
<div id="searchDialogSub2" style="overflow: auto;display: none">
	<form id="formSub2">
		<table class="form_commonTable">
			<tr>
				<th width="10%">改造申请单号:</th>
				<td width="15%">
					<input title="改造申请单号" class="form-control input-sm" type="text" name="reconstructionIdR" id="reconstructionIdR" />
				</td>
				<th width="10%">申请人部门:</th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden"  id="createdByDeptRSub" name="createdByDeptR">
						<input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptRAliasSub" name="createdByDeptRAlias" >
						<span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
					</div>
				</td>
				<th width="10%">单据状态:</th>
				<td width="15%">
					<input title="单据状态" class="form-control input-sm" type="text" name="formStateR" id="formStateR" />
				</td>
				<th width="10%">责任部门:</th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden"  id="ownerDeptRSub" name="ownerDeptR">
						<input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptRAliasSub" name="ownerDeptRAlias" >
						<span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">责任人:</th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden"  id="ownerIdRSub" name="ownerIdR">
						<input class="form-control" placeholder="请选择用户" type="text" id="ownerIdRAliasSub" name="ownerIdRAlias" >
						<span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
					</div>
				</td>
				<th width="10%">责任人联系方式:</th>
				<td width="15%">
					<input title="责任人联系方式" class="form-control input-sm" type="text" name="ownerTelR" id="ownerTelR" />
				</td>
				<th width="10%">设备名称:</th>
				<td width="15%">
					<input title="设备名称" class="form-control input-sm" type="text" name="deviceNameR" id="deviceNameR" />
				</td>
				<th width="10%">密级:</th>
				<td width="15%">
					<input title="密级" class="form-control input-sm" type="text" name="secretLevelR" id="secretLevelR" />
				</td>
			</tr>
			<tr>
				<th width="10%">统一编号:</th>
				<td width="15%">
					<input title="统一编号" class="form-control input-sm" type="text" name="unifiedIdR" id="unifiedIdR" />
				</td>
				<th width="10%">设备型号:</th>
				<td width="15%">
					<input title="设备型号" class="form-control input-sm" type="text" name="deviceModelR" id="deviceModelR" />
				</td>
				<th width="10%">设备规格:</th>
				<td width="15%">
					<input title="设备规格" class="form-control input-sm" type="text" name="deviceSpecR" id="deviceSpecR" />
				</td>
				<th width="10%">生产厂家:</th>
				<td width="15%">
					<input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerIdR" id="manufacturerIdR" />
				</td>
			</tr>
			<tr>
				<th width="10%">立卡时间(从):</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text" name="likaDateRBegin" id="likaDateRBegin" />
						<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%">立卡时间(至):</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text" name="likaDateREnd" id="likaDateREnd" />
						<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%">设备原值:</th>
				<td width="15%">
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="originalValueR" id="originalValueR"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
						<span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
					</div>
				</td>
				<th width="10%">现有结构性能指标:</th>
				<td width="15%">
					<input title="现有结构性能指标" class="form-control input-sm" type="text" name="existingPerformanceR" id="existingPerformanceR" />
				</td>
			</tr>
			<tr>
				<th width="10%">改造理由:</th>
				<td width="15%">
					<input title="改造理由" class="form-control input-sm" type="text" name="reformingReasonR" id="reformingReasonR" />
				</td>
				<th width="10%">改造后结构性能指标:</th>
				<td width="15%">
					<input title="改造后结构性能指标" class="form-control input-sm" type="text" name="afterPerformanceR" id="afterPerformanceR" />
				</td>
				<th width="10%">改造途径:</th>
				<td width="15%">
					<input title="改造途径" class="form-control input-sm" type="text" name="transformWayR" id="transformWayR" />
				</td>
				<th width="10%">经费预算:</th>
				<td width="15%">
					<input title="经费预算" class="form-control input-sm" type="text" name="budgetR" id="budgetR" />
				</td>
			</tr>
			<tr>
				<th width="10%">净值:</th>
				<td width="15%">
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="netValueR" id="netValueR"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
						<span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
					</div>
				</td>
				<th width="10%">设备类别:</th>
				<td width="15%">
					<input title="设备类别" class="form-control input-sm" type="text" name="deviceCategoryR" id="deviceCategoryR" />
				</td>
				<th width="10%">申请人:</th>
				<td width="15%">
					<input title="申请人" class="form-control input-sm" type="text" name="createdByPersonR" id="createdByPersonR" />
				</td>
			</tr>
		</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script src="avicit/assets/device/dynreconmsg/js/DynReconMsg.js" type="text/javascript"></script>
<script src="avicit/assets/device/dynreconmsg/js/AssetsReconstructionCheck.js" type="text/javascript"></script>
<script src="avicit/assets/device/dynreconmsg/js/AssetsReconstructionR.js" type="text/javascript"></script>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script type="text/javascript">
    var dynReconMsg;
    var assetsReconstructionCheck;
	var assetsReconstructionR;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="dynReconMsg.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="dynReconMsg.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        dynReconMsg.reLoad();
    };

    $(document).ready(function () {
        var searchMainNames = new Array();
        var searchMainTips = new Array();
        searchMainNames.push("applyYear");
        searchMainTips.push("年度");
        searchMainNames.push("telephone");
        searchMainTips.push("电话");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#dynReconMsg_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#dynReconMsg_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);
        var searchSubNames = new Array();
        var searchSubTips = new Array();
        searchSubNames.push("reconstructionId");
        searchSubTips.push("改造申请单号");
        searchSubNames.push("formState");
        searchSubTips.push("单据状态");
        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
        $('#assetsReconstructionCheck_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        $('#assetsReconstructionCheck_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);
		$('#assetsReconstructionR_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
		$('#assetsReconstructionR_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);
        var dynReconMsgGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '年度', name: 'applyYear', width: 150, formatter: formatValue}
            , {label: '发布日期', name: 'releasedate', width: 150, formatter: format}
            , {label: '部门上报截至日期', name: 'deptDeadline', width: 150, formatter: format}
            , {label: '电话', name: 'telephone', width: 150}
            , {label: '发布人部门', name: 'deptAlias', width: 150}
            , {label: '备注', name: 'formRemarks', width: 150}
            , {label: '标题', name: 'formTitle', width: 150}
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            , {label: '流程状态', name: 'businessstate_', width: 150}
        ];
        var assetsReconstructionCheckGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '改造申请单号', name: 'reconstructionId', width: 150}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '单据状态', name: 'formState', width: 150}
            , {label: '责任部门', name: 'ownerDeptAlias', width: 150}
            , {label: '责任人', name: 'ownerIdAlias', width: 150}
            , {label: '责任人联系方式', name: 'ownerTel', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '密级', name: 'secretLevelName', width: 150}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '立卡时间', name: 'likaDate', width: 150, formatter: format}
            , {label: '设备原值', name: 'originalValue', width: 150}
            , {label: '现有结构性能指标', name: 'existingPerformance', width: 150}
            , {label: '改造理由', name: 'reformingReason', width: 150}
            , {label: '改造后结构性能指标', name: 'afterPerformance', width: 150}
            , {label: '改造途径', name: 'transformWay', width: 150}
            , {label: '经费预算', name: 'budget', width: 150}
            , {label: '净值', name: 'netValue', width: 150}
            , {label: '设备类别', name: 'deviceCategoryName', width: 150}
            , {label: '申请人', name: 'createdByPersonAlias', width: 150}
        ];
        var assetsReconstructionRGridColModel = [ {
            label : 'id',
            name : 'id',
            key : true,
            width : 75,
            hidden : true
        }, {
            label : '改造申请单号',
            name : 'reconstructionIdR',
            width : 150
        }, {
            label : '申请人部门',
            name : 'createdByDeptRAlias',
            width : 150
        }, {
            label : '单据状态',
            name : 'formStateR',
            width : 150
        }, {
            label : '责任部门',
            name : 'ownerDeptRAlias',
            width : 150
        }, {
            label : '责任人',
            name : 'ownerIdRAlias',
            width : 150
        }, {
            label : '责任人联系方式',
            name : 'ownerTelR',
            width : 150
        }, {
            label : '设备名称',
            name : 'deviceNameR',
            width : 150
        }, {
            label : '密级',
            name : 'secretLevelR',
            width : 150
        }, {
            label : '统一编号',
            name : 'unifiedIdR',
            width : 150
        }, {
            label : '设备型号',
            name : 'deviceModelR',
            width : 150
        }, {
            label : '设备规格',
            name : 'deviceSpecR',
            width : 150
        }, {
            label : '生产厂家',
            name : 'manufacturerIdR',
            width : 150
        }, {
            label : '立卡时间',
            name : 'likaDateR',
            width : 150,
            formatter : format
        }, {
            label : '设备原值',
            name : 'originalValueR',
            width : 150
        }, {
            label : '现有结构性能指标',
            name : 'existingPerformanceR',
            width : 150
        }, {
            label : '改造理由',
            name : 'reformingReasonR',
            width : 150
        }, {
            label : '改造后结构性能指标',
            name : 'afterPerformanceR',
            width : 150
        }, {
            label : '改造途径',
            name : 'transformWayR',
            width : 150
        }, {
            label : '经费预算',
            name : 'budgetR',
            width : 150
        }, {
            label : '净值',
            name : 'netValueR',
            width : 150
        }, {
            label : '设备类别',
            name : 'deviceCategoryR',
            width : 150
        }, {
            label : '申请人',
            name : 'createdByPersonR',
            width : 150
        } ];

        dynReconMsg = new DynReconMsg('dynReconMsg', '${url}', 'form', dynReconMsgGridColModel, 'searchDialog',
            function (pid) {
				assetsReconstructionR = new AssetsReconstructionR(
						'assetsReconstructionR', '${surl2}',
						"formSub",
						assetsReconstructionRGridColModel,
						'searchDialogSub', pid, searchSubNames,
						"assetsReconstructionR_keyWord");
                assetsReconstructionCheck = new AssetsReconstructionCheck('assetsReconstructionCheck', '${surl}', "formSub", assetsReconstructionCheckGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsReconstructionCheck_keyWord");
            },
            function (pid) {
				assetsReconstructionR.reLoad(pid);
                assetsReconstructionCheck.reLoad(pid);
            },
            searchMainNames,
            "dynReconMsg_keyWord");
        //主表操作
        //添加按钮绑定事件
        $('#dynReconMsg_insert').bind('click', function () {
            dynReconMsg.insert();
        });
        //编辑按钮绑定事件
        $('#dynReconMsg_modify').bind('click', function () {
            dynReconMsg.modify();
        });
        //删除按钮绑定事件
        $('#dynReconMsg_del').bind('click', function () {
            dynReconMsg.del();
        });
        //打开高级查询框
        $('#dynReconMsg_searchAll').bind('click', function () {
            dynReconMsg.openSearchForm(this, $('#dynReconMsg'));
        });
        //关键字段查询按钮绑定事件
        $('#dynReconMsg_searchPart').bind('click', function () {
            dynReconMsg.searchByKeyWord();
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            dynReconMsg.initWorkFlow($(this).val());
        });
        //子表操作
        //打开高级查询
        $('#assetsReconstructionCheck_searchAll').bind('click', function () {
            assetsReconstructionCheck.openSearchForm(this, $('#assetsReconstructionCheck'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsReconstructionCheck_searchPart').bind('click', function () {
            assetsReconstructionCheck.searchByKeyWord();
        });

        $('#deptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'dept', textFiled: 'deptAlias'});
            this.blur();
            nullInput(e);
        });

        $('#createdByDeptAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDeptSub', textFiled: 'createdByDeptAliasSub'});
            this.blur();
            nullInput(e);
        });
        $('#ownerDeptAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDeptSub', textFiled: 'ownerDeptAliasSub'});
            this.blur();
            nullInput(e);
        });
        $('#ownerIdAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerIdSub', textFiled: 'ownerIdAliasSub'});
            this.blur();
            nullInput(e);
        });

        $('#createdByPersonAliasSub').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'createdByPersonSub',
                textFiled: 'createdByPersonAliasSub'
            });
            this.blur();
            nullInput(e);
        });
		//子表操作
		//打开高级查询
		$('#assetsReconstructionR_searchAll').bind(
				'click',
				function() {
					assetsReconstructionR.openSearchForm(this,
							$('#assetsReconstructionR'));
				});
		//关键字段查询按钮绑定事件
		$('#assetsReconstructionR_searchPart').bind('click',
				function() {
					assetsReconstructionR.searchByKeyWord();
				});

		$('#createdByDeptRAliasSub').on('focus', function(e) {
			new H5CommonSelect({
				type : 'deptSelect',
				idFiled : 'createdByDeptRSub',
				textFiled : 'createdByDeptRAliasSub'
			});
			this.blur();
			nullInput(e);
		});
		$('#ownerDeptRAliasSub').on('focus', function(e) {
			new H5CommonSelect({
				type : 'deptSelect',
				idFiled : 'ownerDeptRSub',
				textFiled : 'ownerDeptRAliasSub'
			});
			this.blur();
			nullInput(e);
		});
		$('#ownerIdRAliasSub').on('focus', function(e) {
			new H5CommonSelect({
				type : 'userSelect',
				idFiled : 'ownerIdRSub',
				textFiled : 'ownerIdRAliasSub'
			});
			this.blur();
			nullInput(e);
		});

		//excel导出
        $("#dynReconMsg_expdp").bind("click",function () {
            layer.confirm("是否确认导出Excel文件?",{
                btn: ['确定', '取消']
            }, function () {
            // layer.close(confirm);
                debugger;
                //封装参数
                var rowsParent=$("#dynReconMsg").jqGrid("getRowData");
                var rows=$("#assetsReconstructionCheck").jqGrid("getRowData");
                var rownum =	$("#assetsReconstructionCheck").jqGrid('getGridParam','colModel')
                // varcolumnFieldsOptions = getGridColumnFieldsOptions('dgUser');
                // vardataGridFields = JSON.stringify(columnFieldsOptions[0]);
                var dataGridFields = JSON.stringify(rownum);
                var expSearchParams ={};
                expSearchParams = expSearchParams?expSearchParams:{};
                //以下参数为服务器端导出所需要的数据
                expSearchParams.dataGridFields=dataGridFields;//设置导出表头
                expSearchParams.hasRowNum=true;//是否有行号
                expSearchParams.sheetName='sheet1';//导出的sheet名称
                expSearchParams.unContainFields='id';//不需要导出的列
                expSearchParams.fileName='大修改造年度征集导出数据'+ new Date().format("yyyy-MM-dd");//导出文件名
                expSearchParams.pid = rowsParent[0].id;

                // if(dynReconMsg.getSearchDate()){
                //     expSearchParams.param = dynReconMsg.getSearchDate();
                // }else{
                //
                // }
                expSearchParams.appid='1';
                var url = "platform/assets/device/dynreconmsg/dynReconMsgController/operation/excel/exp";//服务器请求地址
                var ep = new exportData("xlsExport","xlsExport",expSearchParams,url);
                ep.excuteExport();
                layer.closeAll();

            });

        })

    });

</script>
</html>