<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,table,fileupload";
    String formId = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/dynsdcollecupld/dynSdCollecUpldController/operation/toDetailJsp" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>详细</title>
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
                </ul>
            </div>
            <div class="btn-bar on">
                <!-- 暂存 关注 正文 等流程代理的按钮 -->
                <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttonBar.jsp" %>
            </div>
            <div class="tab-panel">
                <div class="panel-body on">
                    <div class="panel-main">
                        <!-- 业务表单 Start -->
                        <form id='form'>
                            <input type="hidden" name="id"/>
                            <input type="hidden" name="version"/>
                            <table class="form_commonTable">
                                <tr>
                                    <th width="10%">
                                        <label for="authorAlias">上报人:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="author" name="author">
                                            <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias"
                                                   name="authorAlias">
                                            <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="releasedate">上报日期:</label></th>
                                    <td width="15%">
                                        <div class="input-group input-group-sm">
                                            <input class="form-control date-picker" type="text" name="releasedate"
                                                   id="releasedate"/><span class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="deptAlias">上报单位:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="dept" name="dept">
                                            <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias"
                                                   name="deptAlias">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="tel">电话:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="tel" id="tel"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="collectSelect">关联征集单:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="collectSelect"
                                               id="collectSelect" readonly onclick="openNoticeList()"/>
                                    </td>
                                    <th width="10%">
                                        <label for="collectYear">年度:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="collectYear"
                                               id="collectYear"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th><label for="attachment">附件</label></th>
                                    <td colspan="3">
                                        <div id="attachment"></div>
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
            </div>
        </div>
        <!-- 简单tab End -->
    </div>
    <!-- 正文内容 End -->
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/device/assetssdequipcollect/js/AssetsSdequipCollect.js" type="text/javascript"></script>
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
<script src="avicit/assets/device/dynsdcollecupld/js/DynSdCollecUpldDetail.js"></script>
<script type="text/javascript">
    //注册附件上传完毕后执行的方法
    var afterUploadEvent = null;

    function openNoticeList() {
        var param = '';
        openProductModelLayer("true", "noticeSelect", "callBackFn", param);
    }

    $(document).ready(function () {
        //创建业务操作JS
        var dynSdCollecUpldDetail = new DynSdCollecUpldDetail('form');
        //创建流程操作JS
        new FlowEditor(dynSdCollecUpldDetail);

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
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '<%=formId%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //绑定表单验证规则
        dynSdCollecUpldDetail.formValidate($('#form'));

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