<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@page import="avicit.platform6.api.session.SessionHelper" %>
<%@ page import="avicit.platform6.api.sysuser.dto.SysUser" %>

<%
    String importlibs = "common,form,table,fileupload,tree";
    String formId = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/lab/assetslaborder/assetsLabOrderController/operation/toDetailJsp" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>实验室预约</title>

    <%
        String userId = SessionHelper.getLoginSysUserId(request);
        SysUser user = SessionHelper.getLoginSysUser(request);
        String userName = user.getName();
        String userDeptId = SessionHelper.getCurrentDeptId(request);
        String userDeptName = SessionHelper.getCurrentDeptName(request);
    %>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <!-- 当前页 样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/editForm.css">
    <!-- 定制tab标签样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/avictabs.css">
    <!-- 流程标签 样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/workflow.css">
    <!-- 时间轴 样式 -->
    <link rel="stylesheet" type="text/css" href="static/h5/timeliner/css/timeliner.css">
</head>
<body>
<div class="main">
    <!-- 右侧工具栏 Start -->
    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttons.jsp" %>
    <!-- 右侧工具栏 End -->
    <!-- 正文内容 Start -->
    <div class="content">
        <!-- 简单tab Start -->
        <div class="avic-tab">
            <div class="tab-bar">
                <ul>
                    <li class="on">表单信息</li>
                    <li>流程跟踪</li>
                    <li>引用文档</li>
                    <li>关联流程</li>
                </ul>
            </div>
            <div class="btn-bar on">
                <!-- 暂存 关注 正文 等流程代理的按钮 -->
                <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttonBar.jsp" %>
            </div>
            <div class="tab-panel">
                <div style="margin-top: 15px;text-align: center; font-size: 18pt"><label>实验室预约</label></div>
                <div class="panel-body on">
                    <div class="panel-main">
                        <!-- 业务表单 Start -->
                        <form id='form'>
                            <input type="hidden" name="id" id="id"/>
                            <input type="hidden" name="version" id="version"/>
                            <table class="form_commonTable">
                                <tr>
                                    <th width="10%">
                                        <label for="orderNumber">预约单号:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="orderNumber"
                                               id="orderNumber"/>
                                        <%--<div id = "orderNumber"></div>--%>
                                    </td>
                                    <th width="10%">
                                        <label for="applyIdAlias">申请人:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="applyId" name="applyId" value="<%=userId%>">
                                            <input class="form-control" placeholder="请选择用户" type="text"
                                                   id="applyIdAlias" name="applyIdAlias" value="<%=userName%>">
                                            <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="applyDeptAlias">申请部门:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="applyDept" name="applyDept" value="<%=userDeptId%>">
                                            <input class="form-control" placeholder="请选择部门" type="text"
                                                   id="applyDeptAlias" name="applyDeptAlias" value="<%=userDeptName%>">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="telephone">联系电话:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="telephone"
                                               id="telephone"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="tdeviceName">试件名称:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="tdeviceName"
                                               id="tdeviceName"/>
                                    </td>
                                    <th width="10%">
                                        <label for="tdeviceCode">试件代号:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="tdeviceCode"
                                               id="tdeviceCode"/>
                                    </td>
                                    <th width="10%">
                                        <label for="tdeviceModel">试件型号:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="tdeviceModel"
                                               id="tdeviceModel"/>
                                    </td>
                                    <th width="10%">
                                        <label for="tdeviceNum">试件编号:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="tdeviceNum"
                                               id="tdeviceNum"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="belongModel">所属机型:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="belongModel"
                                               id="belongModel"/>
                                    </td>
                                    <th width="10%">
                                        <label for="testType">试验类型:</label></th>
                                    <td width="15%">
                                        <pt6:h5select css_class="form-control input-sm" name="testType" id="testType"
                                                      title="" isNull="true" lookupCode="TEST_TYPE"/>
                                    </td>
                                    <th width="10%">
                                        <label for="testNature">试验性质:</label></th>
                                    <td width="15%">
                                        <pt6:h5select css_class="form-control input-sm" name="testNature"
                                                      id="testNature" title="" isNull="true" lookupCode="TEST_NATURE"/>
                                    </td>
                                    <th width="10%">
                                        <label for="supportTool">配套工装:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="supportTool"
                                               id="supportTool" onchange="orderTimeChange()"/>
                                    </td>

                                </tr>

                                <tr>

                                    <th width="10%">
                                        <label for="orderStartTime">预约开始时间:</label></th>
                                    <td width="15%">
                                        <div class="input-group input-group-sm">
                                            <input class="form-control time-picker" type="text" name="orderStartTime"
                                                   id="orderStartTime"

                                            />
                                            <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="orderFinishTime">预约结束时间:</label></th>
                                    <td width="15%">
                                        <div class="input-group input-group-sm">
                                            <input class="form-control time-picker" type="text" name="orderFinishTime"
                                                   id="orderFinishTime"
                                            />
                                            <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="labDeviceUid">实验设备统一编号:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="labDeviceUid"
                                               id="labDeviceUid"
                                        />
                                    </td>
                                    <th width="10%">
                                        <label for="labDeviceName">实验设备名称:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="labDeviceName"
                                               id="labDeviceName"/>
                                    </td>
                                </tr>
                                <tr>

                                    <th width="10%">
                                        <label for="approvalStartTime">审核开始时间:</label></th>
                                    <td width="15%">
                                        <div class="input-group input-group-sm">
                                            <input class="form-control time-picker" type="text" name="approvalStartTime"
                                                   id="approvalStartTime"/><span class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="approvalFinishTime">审核结束时间:</label></th>
                                    <td width="15%">
                                        <div class="input-group input-group-sm">
                                            <input class="form-control time-picker" type="text"
                                                   name="approvalFinishTime" id="approvalFinishTime"/><span
                                                class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </td>

                                    <th width="10%">
                                        <label for="actualStartTime">实际开始时间:</label></th>
                                    <td width="15%">
                                        <div class="input-group input-group-sm">
                                            <input class="form-control time-picker" type="text" name="actualStartTime"
                                                   id="actualStartTime"/><span class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="actualFinishTime">实际结束时间:</label></th>
                                    <td width="15%">
                                        <div class="input-group input-group-sm">
                                            <input class="form-control time-picker" type="text" name="actualFinishTime"
                                                   id="actualFinishTime"/><span class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="testCondition">试验条件:</label></th>
                                    <td width="15%" colspan="9">
                                        <textarea class="form-control input-sm" name = "testCondition" id = "testCondition" rows = "5"></textarea>
                                        <%--<input class="form-control input-sm" type="text" name="testCondition"--%>
                                        <%--id="testCondition"/>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="labDeviceId">实验设备ID:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="labDeviceId"
                                               id="labDeviceId"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th><label for="attachment">附件</label></th>
                                    <td colspan="<%=4 * 2 - 1%>">
                                        <div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
                                    </td>
                                </tr>
                            </table>
                        </form>
                        <!-- 业务表单 End -->
                    </div>
                </div>
                <div class="panel-body">
                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/tracks.jsp" %>
                </div>
                <div class="panel-body">
                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/files.jsp" %>
                </div>
                <div class="panel-body">
                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/processlevel.jsp" %>
                </div>
            </div>
        </div>
        <!-- 简单tab End -->
    </div>
    <!-- 正文内容 End -->
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
<!-- 业务的js -->
<script src="avicit/assets/lab/assetslaborder/js/AssetsLabOrderDetail.js"></script>
<!-- 自动编码的js -->
<script src="avicit/platform6/autocode/js/AutoCode.js"></script>
<script type="text/javascript">
    //页面变量
    var procDetail;

    //注册附件上传完毕后执行的方法
    var afterUploadEvent = null;
    $(document).ready(function () {

        //编码初始化-begin
        var autoCode = new AutoCode("LABDEVICEORDER_PROC","orderNumber",false,"autoCodeValue","123");
        //编码初始化-end

        //创建业务操作JS
        var assetsLabOrderDetail = new AssetsLabOrderDetail('form');
        //创建流程操作JS
        new FlowEditor(assetsLabOrderDetail);

        procDetail = assetsLabOrderDetail;

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
            },

            onClose: orderTimeChange
        });

        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '<%=formId%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //绑定表单验证规则
        assetsLabOrderDetail.formValidate($('#form'));

        $('#applyIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'applyId', textFiled: 'applyIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#applyDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'applyDept', textFiled: 'applyDeptAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);


        //实验设备统一编号绑定弹出选择实验室设备框
        $('#labDeviceUid').bind('click', function () {
            //assetsLabDevice.insert();
            var labSelectParam = JSON.stringify({isLabDeviceSelectPage: "true"});
            openProductModelLayer("false", "", "callBackFn", labSelectParam);
        });
        //实验设备名称绑定弹出选择实验室设备框
        $('#labDeviceName').bind('click', function () {
            //assetsLabDevice.insert();
            var labSelectParam = JSON.stringify({isLabDeviceSelectPage: "true"});
            openProductModelLayer("false", "", "callBackFn", labSelectParam);
        });

    });

    /*
    *  时间比较函数，如果t1<t2,返回true
    * */
    function compareTime(t1,t2){
        return ((new Date(t1.replace(/-/g,"\/")))<(new Date(t2.replace(/-/g,"\/"))));
    }

    /*
  *  时间选择判断
  * */
    function orderTimeChange() {
        //预约时间
        var orderStartTime = document.getElementById("orderStartTime").value;
        var orderFinishTime = document.getElementById("orderFinishTime").value;
        if(orderStartTime == null || orderStartTime.length == 0 || orderFinishTime == null || orderFinishTime.length == 0)
        {}
        else{
            if(compareTime(orderStartTime, orderFinishTime)
            ){
                //时间正确
            }
            else{
                //时间不正确则提示
                document.getElementById("orderFinishTime").value = "";
                layer.msg('结束时间应大于开始时间！');
                // layer.alert('结束时间应大于开始时间！', {
                //     icon: 7,
                //     area: ['400px', ''], //宽高
                //     closeBtn: 0,
                //     btn: ['关闭'],
                //     title:"提示"
                // });
            }
        }
        //审核时间
        var approvalStartTime = document.getElementById("approvalStartTime").value;
        var approvalFinishTime = document.getElementById("approvalFinishTime").value;
        if(approvalStartTime == null || approvalStartTime.length == 0 || approvalFinishTime == null || approvalFinishTime.length == 0)
        {}
        else{
            if(compareTime(approvalStartTime, approvalFinishTime)
            ){
                //时间正确
            }
            else{
                //时间不正确则提示
                document.getElementById("approvalFinishTime").value = "";
                layer.msg('结束时间应大于开始时间！');
                // layer.alert('结束时间应大于开始时间！', {
                //     icon: 7,
                //     area: ['400px', ''], //宽高
                //     closeBtn: 0,
                //     btn: ['关闭'],
                //     title:"提示"
                // });
            }
        }
        //实际时间
        var actualStartTime = document.getElementById("actualStartTime").value;
        var actualFinishTime = document.getElementById("actualFinishTime").value;
        if(actualStartTime == null || actualStartTime.length == 0 || actualFinishTime == null || actualFinishTime.length == 0)
        {}
        else{
            if(compareTime(actualStartTime, actualFinishTime)
            ){
                //时间正确
            }
            else{
                //时间不正确则提示
                document.getElementById("actualFinishTime").value = "";
                layer.msg('结束时间应大于开始时间！');
                // layer.alert('结束时间应大于开始时间！', {
                //     icon: 7,
                //     area: ['400px', ''], //宽高
                //     closeBtn: 0,
                //     btn: ['关闭'],
                //     title:"提示"
                // });
            }
        }
    }


</script>
</body>
</html>