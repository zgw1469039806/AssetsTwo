<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form,fileupload";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController/operation/Edit/id" -->
    <title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <style type="text/css">
        #t_assetsUstdtempapplyCollect {
            display: none;
        }
    </style>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsUstdtempapplyCtMainDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsUstdtempapplyCtMainDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="authorAlias">上报人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="author" name="author"
                               value="<c:out  value='${assetsUstdtempapplyCtMainDTO.author}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" name="authorAlias"
                               value="<c:out  value='${assetsUstdtempapplyCtMainDTO.authorAlias}'/>">
                        <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="releasedate">上报日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedate" id="releasedate"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsUstdtempapplyCtMainDTO.releasedate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deptAlias">上报单位:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="dept" name="dept"
                               value="<c:out  value='${assetsUstdtempapplyCtMainDTO.dept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" name="deptAlias"
                               value="<c:out  value='${assetsUstdtempapplyCtMainDTO.deptAlias}'/>">
                        <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="tel">电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="tel" id="tel"
                           value="<c:out  value='${assetsUstdtempapplyCtMainDTO.tel}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="collectSelect">关联征集单:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="collectSelect" id="collectSelect"
                           value="<c:out  value='${assetsUstdtempapplyCtMainDTO.collectSelect}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="collectYear">年度:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="collectYear" id="collectYear"
                           value="<c:out  value='${assetsUstdtempapplyCtMainDTO.collectYear}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="stdId">申购单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="stdId" id="stdId"
                           value="<c:out  value='${assetsUstdtempapplyCtMainDTO.stdId}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <div id="toolbar_assetsUstdtempapplyCollect" class="toolbar">
                        <div class="toolbar-left">
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_assetsUstdtempapplyCollect_button_add"
                                                   permissionDes="添加">
                                <a id="assetsUstdtempapplyCollect_insert" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm" role="button"
                                   title="添加"><i class="fa fa-plus"></i> 添加</a>
                            </sec:accesscontrollist>
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_assetsUstdtempapplyCollect_button_delete"
                                                   permissionDes="删除">
                                <a id="assetsUstdtempapplyCollect_del" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm" role="button"
                                   title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                            </sec:accesscontrollist>
                        </div>
                    </div>
                    <table id="assetsUstdtempapplyCollect"></table>
                </th>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=4 * 2 - 1%>">
                    <div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
                </td>
            </tr>
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar"
         class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                       title="保存" id="assetsUstdtempapplyCtMain_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsUstdtempapplyCtMain_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript"
        src="avicit/assets/device/assetsustdtempapplyctmain/js/AssetsUstdtempapplyCollect.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var deviceCategoryData = ${deviceCategoryData};
    var isNeedInstallData = ${isNeedInstallData};
    var isHumidityNeedData = ${isHumidityNeedData};
    var isWaterNeedData = ${isWaterNeedData};
    var isGasNeedData = ${isGasNeedData};
    var isLetData = ${isLetData};
    var isOtherNeedData = ${isOtherNeedData};
    var isAboveConditionsData = ${isAboveConditionsData};
    var financialResourcesData = ${financialResourcesData};
    var isTestDeviceData = ${isTestDeviceData};
    var afterUploadEvent = null;
    var assetsUstdtempapplyCollect;
    var assetsUstdtempapplyCollectGridColModel = [
        {label: 'id', name: 'id', key: true, width: 75, hidden: true}
        , {label: '<span style="color:red;">*</span>申购单号', name: 'stdId', width: 150, editable: true}
        , {
            label: '申请人部门',
            name: 'createdByDeptAlias',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'createdByDept'}
        }
        , {label: '申请人部门id', name: 'createdByDept', width: 75, hidden: true, editable: true}
        , {label: '申请人电话', name: 'createdByTel', width: 150, editable: true}
        , {label: '单据状态', name: 'formState', width: 150, editable: true}
        , {label: '设备名称', name: 'deviceName', width: 150, editable: true}
        , {label: '设备类别id', name: 'deviceCategory', width: 75, hidden: true}
        , {
            label: '设备类别',
            name: 'deviceCategoryName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'deviceCategory',
                value: deviceCategoryData
            }
        }
        , {label: '承制单位', name: 'manufactureUnit', width: 150, editable: true}
        , {label: '课题代号', name: 'subjectCode', width: 150, editable: true}
        , {
            label: '主管机关',
            name: 'competentAuthorityAlias',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'competentAuthority'}
        }
        , {label: '主管机关id', name: 'competentAuthority', width: 75, hidden: true, editable: true}
        , {
            label: '型号主管',
            name: 'modelDirectorAlias',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {custom_element: userElem, custom_value: userValue, forId: 'modelDirector'}
        }
        , {label: '型号主管id', name: 'modelDirector', width: 75, hidden: true, editable: true}
        , {
            label: '主管所领导',
            name: 'competentLeaderAlias',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {custom_element: userElem, custom_value: userValue, forId: 'competentLeader'}
        }
        , {label: '主管所领导id', name: 'competentLeader', width: 75, hidden: true, editable: true}
        , {label: '申购理由及用途', name: 'applyReasonPurpose', width: 150, editable: true}
        , {label: '原有设备的情况', name: 'orignEquipSituation', width: 150, editable: true}
        , {label: '使用效率情况', name: 'efficiencySituation', width: 150, editable: true}
        , {label: '研制内容', name: 'developmentContent', width: 150, editable: true}
        , {label: '技术指标', name: 'technicalIndex', width: 150, editable: true}
        , {label: '研制周期', name: 'developmentCycle', width: 150, editable: true}
        , {label: '是否需要安装id', name: 'isNeedInstall', width: 75, hidden: true}
        , {
            label: '是否需要安装',
            name: 'isNeedInstallName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'isNeedInstall',
                value: isNeedInstallData
            }
        }
        , {label: '安装地点ID', name: 'positionId', width: 150, editable: true}
        , {label: '使用电压', name: 'serviceVoltage', width: 150, editable: true}
        , {label: '是否对温湿度有要求id', name: 'isHumidityNeed', width: 75, hidden: true}
        , {
            label: '是否对温湿度有要求',
            name: 'isHumidityNeedName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'isHumidityNeed',
                value: isHumidityNeedData
            }
        }
        , {label: '温湿度要求', name: 'humidityNeed', width: 150, editable: true}
        , {label: '是否有用水要求id', name: 'isWaterNeed', width: 75, hidden: true}
        , {
            label: '是否有用水要求',
            name: 'isWaterNeedName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'isWaterNeed',
                value: isWaterNeedData
            }
        }
        , {label: '用水要求', name: 'waterNeed', width: 150, editable: true}
        , {label: '是否有用气要求id', name: 'isGasNeed', width: 75, hidden: true}
        , {
            label: '是否有用气要求',
            name: 'isGasNeedName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'isGasNeed',
                value: isGasNeedData
            }
        }
        , {label: '用气要求', name: 'gasNeed', width: 150, editable: true}
        , {label: '是否有气体排放id', name: 'isLet', width: 75, hidden: true}
        , {
            label: '是否有气体排放',
            name: 'isLetName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {custom_element: selectElem, custom_value: selectValue, forId: 'isLet', value: isLetData}
        }
        , {label: '气体排放要求', name: 'letNeed', width: 150, editable: true}
        , {label: '是否有其他特殊要求id', name: 'isOtherNeed', width: 75, hidden: true}
        , {
            label: '是否有其他特殊要求',
            name: 'isOtherNeedName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'isOtherNeed',
                value: isOtherNeedData
            }
        }
        , {label: '其他特殊要求', name: 'otherNeed', width: 150, editable: true}
        , {label: '以上需求条件在拟安装地点是否都已具备id', name: 'isAboveConditions', width: 75, hidden: true}
        , {
            label: '以上需求条件在拟安装地点是否都已具备',
            name: 'isAboveConditionsName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'isAboveConditions',
                value: isAboveConditionsData
            }
        }
        , {label: '是否计量', name: 'isMetering', width: 150, editable: true}
        , {label: '计量要求', name: 'meteringRequirement', width: 150, editable: true}
        , {
            label: '经费概算',
            name: 'financialEstimate',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {
                custom_element: spinnerElem,
                custom_value: spinnerValue,
                min: -<%=Math.pow(10,12)-Math.pow(10,-3)%>,
                max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,
                step: 1,
                precision: 3
            }
        }
        , {label: '经费来源id', name: 'financialResources', width: 75, hidden: true}
        , {
            label: '经费来源',
            name: 'financialResourcesName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'financialResources',
                value: financialResourcesData
            }
        }
        , {label: '所属项目', name: 'belongProject', width: 150, editable: true}
        , {label: '项目序号', name: 'projectNo', width: 150, editable: true}
        , {label: '批复名称', name: 'replyName', width: 150, editable: true}
        , {label: '立项单号', name: 'approvalFormNumber', width: 150, editable: true}
        , {label: '是否测试设备id', name: 'isTestDevice', width: 75, hidden: true}
        , {
            label: '是否测试设备',
            name: 'isTestDeviceName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'isTestDevice',
                value: isTestDeviceData
            }
        }
        , {
            label: '主管设备所领导',
            name: 'competentDeviceLeaderAlias',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {custom_element: userElem, custom_value: userValue, forId: 'competentDeviceLeader'}
        }
        , {label: '主管设备所领导id', name: 'competentDeviceLeader', width: 75, hidden: true, editable: true}
    ];

    function closeForm() {
        parent.assetsUstdtempapplyCtMain.closeDialog(window.name);
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
        //验证附件密级
        var files = $('#attachment').uploaderExt('getUploadFiles');
        for (var i = 0; i < files.length; i++) {
            var name = files[i].name;
            var secretLevel = files[i].secretLevel;
            //这里验证密级
        }
        //限制保存按钮多次点击
        $('#assetsUstdtempapplyCtMain_saveForm').addClass('disabled').unbind("click");
        parent.assetsUstdtempapplyCtMain.save($('#form'), window.name);
    }

    $(document).ready(function () {
        var pid = "${assetsUstdtempapplyCtMainDTO.id}";
        var isReload = "edit";
        var searchSubNames = "";
        var surl = "platform/assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController/operation/sub/";
        assetsUstdtempapplyCollect = new AssetsUstdtempapplyCollect('assetsUstdtempapplyCollect', surl,
            "formSub",
            assetsUstdtempapplyCollectGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsUstdtempapplyCollect_keyWord', isReload);
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
            beforeShow: function (selectedDate) {
                if ($('#' + selectedDate.id).val() == "") {
                    $(this).datetimepicker("setDate", new Date());
                    $('#' + selectedDate.id).val('');
                }
            }
        });

        parent.assetsUstdtempapplyCtMain.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsUstdtempapplyCtMainDTO.id}',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //保存按钮绑定事件
        $('#assetsUstdtempapplyCtMain_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsUstdtempapplyCtMain_closeForm').bind('click', function () {
            closeForm();
        });
        //添加按钮绑定事件
        $('#assetsUstdtempapplyCollect_insert').bind('click', function () {
            assetsUstdtempapplyCollect.insert();
        });
        //删除按钮绑定事件
        $('#assetsUstdtempapplyCollect_del').bind('click', function () {
            assetsUstdtempapplyCollect.del();
        });

        $('#authorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'author', textFiled: 'authorAlias'});
            this.blur();
            nullInput(e);
        });

        $('#deptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'dept', textFiled: 'deptAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>