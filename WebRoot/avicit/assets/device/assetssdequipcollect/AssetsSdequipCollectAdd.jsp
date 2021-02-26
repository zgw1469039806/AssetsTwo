<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@page import="avicit.platform6.api.session.SessionHelper" %>
<%@ page import="avicit.platform6.api.sysuser.dto.SysUser" %>
<%
    String importlibs = "common,form";
    String callBackFnList = request.getParameter("callBackFnList");
    request.getParameter("callBackFnList");// 回调函数名称
    String pid = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetssdequipcollect/assetsSdequipCollectController/operation/Add/null" -->
    <title>添加</title>
    <%
        String userId = SessionHelper.getLoginSysUserId(request);
        SysUser user = SessionHelper.getLoginSysUser(request);
        String userName = user.getName();
        String userDeptId = SessionHelper.getCurrentDeptId(request);
        String userDeptName = SessionHelper.getCurrentDeptName(request);
    %>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<style type="text/css">
    tbody tr {
        text-align: center;
    }
    #t_assetsSupplier {
        display: none;
    }

    .isSimple td {
        display: none;
    }

    .isSimple th {
        display: none;
    }

    th {
        text-align: left;
    }

    .form_commonTable {
        border-spacing: 0;
    }

    .form_commonTable tr.commonTableTr th {
        text-align: left;
        background-color: rgba(228, 228, 228, 1);
        border-bottom: 2px solid #ffffff;
        padding: 0 5px;
    }

    .form_commonTable tr.isSimple th {
        text-align: left;
        background-color: rgba(228, 228, 228, 1);
        border-bottom: 2px solid #ffffff;
        padding: 0 5px;
    }

    .tab-paneOne, .tab-paneTwo {
        width: 100%;
        margin-top: 10px;
    }

    .tab-paneOne tr td textarea {
        padding: 6px;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        line-height: 20px;
        font-size: 14px;
        color: #333333;
        width: 100%;
        height: 100px;
        margin-top: 10px;
        border: 1px solid #cccccc;

    }

    .tab-paneTwo tr td textarea {
        padding: 6px;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        line-height: 20px;
        font-size: 14px;
        color: #333333;
        width: 100%;
        height: 50px;
        margin-top: 10px;
        border: 1px solid #cccccc;

    }
</style>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id"/>
        <input type="hidden" name="parentId" id="parentId"/>
        <input type="hidden" name="attribute01" id="attribute01"/>
        <table class="form_commonTable">
            <tr class="commonTableTr">
                <th width="10%">
                    <label for="createdByPersionAlias">申购人</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPersion" name="createdByPersion"
                               value="<%=userId%>">
                        <input class="form-control" placeholder="请选择用户" type="text"
                               id="createdByPersionAlias" name="createdByPersionAlias"
                               aria-invalid="false" value="<%=userName%>">
                        <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="createdByDeptAlias">申购部门</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<%=userDeptId%>">
                        <input class="form-control" placeholder="请选择部门" type="text"
                               id="createdByDeptAlias" name="createdByDeptAlias"
                               value="<%=userDeptName%>">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="deviceName">设备名称</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName"
                           id="deviceName"/>
                </td>
                <th width="10%">
                    <label for="deviceCategory">设备类别</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory"
                                  id="deviceCategory" title="" isNull="true"
                                  lookupCode="DEVICE_CATEGORY"/>
                </td>
            </tr>
            <tr class="commonTableTr">
                <th width="10%">
                    <label for="financialResources">经费来源</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="financialResources"
                                  id="financialResources" title="" isNull="true"
                                  lookupCode="FINANCIAL_RESOURCES"/>
                </td>
                <th width="10%">
                    <label for="deviceModel">设备型号</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceModel"
                           id="deviceModel"/>
                </td>
                <th width="10%">
                    <label for="deviceType">设备类型</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceType"
                                  id="deviceType" title="" isNull="true" lookupCode="DEVICE_TYPE"/>
                </td>
                <th width="10%">
                    <label for="deviceSpec">设备规格</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSpec"
                           id="deviceSpec"/>
                </td>
            </tr>

            <tr class="commonTableTr">
                <th width="10%">
                    <label for="referencePlant">参考厂家 </label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="referencePlant"
                           id="referencePlant"/>
                </td>
                <th width="10%">
                    <label for="deviceNum">台（套）数</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="deviceNum" id="deviceNum"
                               data-min="0"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1"
                               data-precision="0">
                        <span class="inpu t-group-addon">
                                <a href="javascript:;" class="spin-up" data-spin="up"><i
                                        class="glyphicon glyphicon-triangle-top"></i></a>
                                <a href="javascript:;" class="spin-down" data-spin="down"><i
                                        class="glyphicon glyphicon-triangle-bottom"></i></a>
                        </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="unitPrice">单价(元)</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice"
                               data-min="0"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1"
                               data-precision="3">
                        <span class="input-group-addon">
                            <a href="javascript:;" class="spin-up" data-spin="up"><i
                                    class="glyphicon glyphicon-triangle-top"></i></a>
                            <a href="javascript:;" class="spin-down" data-spin="down"><i
                                    class="glyphicon glyphicon-triangle-bottom"></i></a>
                        </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="totalPrice">总金额（元）</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalPrice" id="totalPrice"
                               data-min="0"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1"
                               data-precision="3">
                        <span class="input-group-addon">
                                <a href="javascript:;" class="spin-up" data-spin="up"><i
                                        class="glyphicon glyphicon-triangle-top"></i></a>
                                <a href="javascript:;" class="spin-down" data-spin="down"><i
                                        class="glyphicon glyphicon-triangle-bottom"></i></a>
                        </span>
                    </div>
                </td>
            </tr>
            <tr class="commonTableTr">

            </tr>

        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存"
                       id="assetsSdequipCollect_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsSdequipCollect_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 页面脚本 avictabs.js-->
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/avictabs.js"></script>
<!-- 时间轴组件 timeliner.js-->
<script type="text/javascript" src="static/h5/timeliner/js/timeliner.js"></script>
<!-- 页面脚本 editForm.js-->
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/editForm.js"></script>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowEditor.js"></script>
<script src="static/h5/jqGrid-5.2.0/jqGrid.js" type="text/javascript"></script>
<script src="avicit/assets/device/dynsdcollecmain/js/AssetsSdequipCollect.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    //初始化通用代码值
    function initOnceInAdd() {
        avicAjax.ajax({
            url: "platform/assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController/getLookUpCode",
            type: 'post',
            dataType: 'json',
            async: false,
            success: function (r) {
                if (r.flag == "success") {
                } else {
                    layer.alert('获取失败！' + r.error, {
                            icon: 7,
                            area: ['400px', ''], //宽高
                            closeBtn: 0,
                            btn: ['关闭'],
                            title: "提示"
                        }
                    );
                }
            }
        });
    };

    var afterUploadEvent = null;
    $(document).ready(function () {
        var pid = "<%=pid%>";
        var isReload = "true";
        var searchSubNames = "";
        initOnceInAdd(); //初始化通用代码值
        //创建业务操作JS
        //创建流程操作JS

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
        $('.date-picker').datepicker({yearRange: "c-100:c+10"}); //时间控件增加年度选择

        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#chiefEngineerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'chiefEngineer', textFiled: 'chiefEngineerAlias'});
            this.blur();
            nullInput(e);
        });
        $('#projectDirectorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'projectDirector', textFiled: 'projectDirectorAlias'});
            this.blur();
            nullInput(e);
        });
        $('#buyerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'buyer', textFiled: 'buyerAlias'});
            this.blur();
            nullInput(e);
        });
        $('#planBuyerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'planBuyer', textFiled: 'planBuyerAlias'});
            this.blur();
            nullInput(e);
        });
        $('#createdByPersionAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'createdByPersion', textFiled: 'createdByPersionAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
    $("#largeDeviceType").change(function () {
        if ($(this).val() != 1) {
            $(".isSimple>th").show();
            $(".isSimple>td").show();
        } else {
            $(".isSimple>th").hide();
            $(".isSimple>td").hide();
        }
    });
    var deviceNum = 0;
    var unitPrice = 0;
    var totalPrice = 0;
    $("#deviceNum").val(0);
    $("#unitPrice").val(0);
    $("#totalPrice").val(0);
    $("#deviceNum").blur(function () {
        deviceNum = $("#deviceNum").val();
        if (unitPrice != 0) {
            totalPrice = deviceNum * unitPrice;
        }
        $("#totalPrice").val(totalPrice);
    });
    $("#unitPrice").blur(function () {
        unitPrice = $("#unitPrice").val();
        if (deviceNum != 0) {
            totalPrice = deviceNum * unitPrice;
        }
        $("#totalPrice").val(totalPrice);

    });
    // sessionHelper.
    <%--alert(<%=sessionHelper.userId%>);--%>

</script>


<script type="text/javascript">
    $("#parentId").val($("#comId", window.parent.document).val());
    $("#attribute01").val(parent.noticeId);
    var callBackFnList = '<%=callBackFnList%>';
    $("#assetsSdequipCollect_saveForm").on("click", function () {
        save($('#form'), "insert");
        parent["callBackFnList"]();
    })
    $("#assetsSdequipCollect_closeForm").on("click", function () {
        var closewindow = window.parent.document.getElementsByClassName("layui-layer-ico layui-layer-close layui-layer-close1");
        closewindow[0].click();
    })

</script>
</body>
</html>