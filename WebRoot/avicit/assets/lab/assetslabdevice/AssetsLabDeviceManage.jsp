<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/lab/assetslabdevice/assetsLabDeviceController/toAssetsLabDeviceManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

    <script src="avicit/platform6/plusgantt/jquery-1.8.1.min.js" type="text/javascript"></script>
    <script src="avicit/platform6/plusgantt/miniui/miniui.js" type="text/javascript"></script>
    <script src="avicit/platform6/plusgantt/miniui/locale/zh_CN.js" type="text/javascript"></script>

    <link href="avicit/platform6/plusgantt/miniui/themes/default/miniui.css" rel="stylesheet" type="text/css" /><link href="avicit/platform6/plusgantt/miniui/themes/blue/skin.css" rel="stylesheet" type="text/css" />
    <link href="avicit/platform6/plusgantt/miniui/themes/icons.css" rel="stylesheet" type="text/css" />

    <script src="avicit/platform6/plusgantt/plusgantt/GanttMenu.js" type="text/javascript"></script>
    <script src="avicit/platform6/plusgantt/plusgantt/GanttSchedule.js" type="text/javascript"></script>
    <script src="avicit/platform6/plusgantt/plusgantt/GanttService.js" type="text/javascript"></script>

</head>
<style>
    /*.layui-layer-content{*/
    /*height: 120px!important ;*/
    /*}*/
</style>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsLabDevice_button_add"
                               permissionDes="添加">
            <a id="assetsLabDevice_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsLabDevice_button_del"
                               permissionDes="删除">
            <a id="assetsLabDevice_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsLabDevice_button_save"
                               permissionDes="保存">
            <a id="assetsLabDevice_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
        </sec:accesscontrollist>
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsLabDevice_button_edit"--%>
                               <%--permissionDes="编辑">--%>
            <%--<a id="assetsLabDevice_edit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"--%>
               <%--role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>--%>
        <%--</sec:accesscontrollist>--%>
        <sec:accesscontrollist domainObject="formdialog_assetsLabDevice_button_submit"
                               permissionDes="提交">
            <a id="assetsLabDevice_submit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="提交"><i class="fa fa-file-text-o"></i> 提交</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsLabDevice_keyWord" id="assetsLabDevice_keyWord" style="width:240px;"
                   class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsLabDevice_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsLabDevice_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
                <span class="caret"></span></a>
        </div>
    </div>
</div>
<div style="width:100%; height: 100%">
    <div style="width:49%;height:100%;float:left;">
        <table id="assetsLabDevicejqGrid"></table>
        <div id="jqGridPager"></div>
    </div>
    <div id = "ganttArea"; name = "ganttArea" style="width:50%;height:100%;float:right;">
        <%--实验室设备预约流程列表iframe--%>
        <%--<iframe name="labOrderIframe"  id="labOrderIframe" src="assets/lab/assetslaborder/assetsLabOrderController/toAssetsLabOrderManage?isRightFrame=Y" frameborder="0" align="left" width="100%" height="100%" scrolling="auto">--%>
        <%--</iframe>--%>

            <%--甘特图--%>
            <t style="background:white;font-size:13px;">
                顶层时间刻度：
                <select style="margin-right:20px;" onchange="changeTopTimeScale(this.value)">
                    <option value="year">年</option>
                    <option value="halfyear">半年</option>
                    <option value="quarter">季度</option>
                    <option value="month">月</option>
                    <option value="week" selected>周</option>
                    <option value="day">日</option>
                    <option value="hour">时</option>
                </select>
                底层时间刻度：
                <select onchange="changeBottomTimeScale(this.value)" style="margin-right:20px;" >
                    <option value="year">年</option>
                    <option value="halfyear">半年</option>
                    <option value="quarter">季度</option>
                    <option value="month">月</option>
                    <option value="week">周</option>
                    <option value="day" selected>日</option>
                    <option value="hour">时</option>
                </select>
                <img src="static/images/big.png" onclick="zoomIn()">&nbsp&nbsp&nbsp<img src="static/images/small.png" onclick="zoomOut()">
                <%--<input type="button" value="放大" onclick="zoomIn()" class="btn btn-primary form-tool-btn btn-sm"/> <input type="button" value="缩小" onclick="zoomOut()" class="btn btn-primary form-tool-btn btn-sm"/>--%>
                <%--<input type="button" style="width:80px;" value="保存" onclick="save()"/>--%>

                <%--<input type="button" value="增加任务" onclick="addTask()"/>--%>
                <%--<input type="button" value="删除任务" onclick="removeTask()"/>--%>
                <%--<input type="button" value="修改任务" onclick="updateTask()"/>--%>
                <%--<input type="button" value="升级任务" onclick="upgradeTask()"/>--%>
                <%--<input type="button" value="降级任务" onclick="downgradeTask()"/>--%>
                <br /><br />


            </div>
    </div>
    <div style="clear:both;"></div>

</div>

</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none;">
    <form id="form" style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName"
                           id="deviceName"/>
                </td>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <%--<th width="10%">设备id:</th>--%>
                <%--<td width="15%">--%>
                <%--<input title="设备id" class="form-control input-sm" type="text" name="deviceId" id="deviceId"/>--%>
                <%--</td>--%>
                <%--<th width="10%">实验室id:</th>--%>
                <%--<td width="15%">--%>
                <%--<input title="实验室id" class="form-control input-sm" type="text" name="labId" id="labId"/>--%>
                <%--</td>--%>
                <th width="10%">实验室名称:</th>
                <td width="15%">
                    <input title="实验室名称" class="form-control input-sm" type="text" name="labName" id="labName"/>
                </td>
                <th width="10%">责任人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerId" name="ownerId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias"
                               name="ownerIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>

            </tr>
            <tr>

                <%--<th width="10%">序号:</th>--%>
                <%--<td width="15%">--%>
                <%--<input title="序号" class="form-control input-sm" type="text" name="serialNumber" id="serialNumber"/>--%>
                <%--</td>--%>
                <th width="10%">责任人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias"
                               name="ownerDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">设备状态:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceState" id="deviceState" title="设备状态"
                                  isNull="true" lookupCode="DEVICE_STATE"/>
                </td>
                <th width="10%">预约状态:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="orderState" id="orderState" title="预约状态"
                                  isNull="true" lookupCode="ORDER_STATE"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/lab/assetslabdevice/js/AssetsLabDevice.js" type="text/javascript"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var deviceStateData = ${deviceStateData};
    var orderStateData = ${orderStateData};
    var assetsLabDevice;
    $(document).ready(function () {

        //点击甘特图左侧收起按钮
        document.getElementsByClassName("mini-splitter-pane1-button")[0].click();

        /*
        判断是否为实验室设备的弹出选择页
        * */
        var labSelectParam;
        var isLabDeviceSelectPage = "false";
        var isCellEdit = false;//默认关闭行编辑
        labSelectParam = sessionStorage.getItem("labSelectParam");
        if(labSelectParam != null){
            isLabDeviceSelectPage = JSON.parse(labSelectParam).isLabDeviceSelectPage;
        }
        if(isLabDeviceSelectPage == "true"){
            //添加按钮不显示
            $('#assetsLabDevice_insert').attr("style", "display:none;");
            //删除按钮不显示
            $('#assetsLabDevice_del').attr("style", "display:none;");
            //保存按钮不显示
            $('#assetsLabDevice_save').attr("style", "display:none;");
            //编辑按钮不显示
            $('#assetsLabDevice_edit').attr("style", "display:none;");

            //禁用行编辑
            isCellEdit = false;
        }
        else{
            //提交按钮不显示
            $('#assetsLabDevice_submit').attr("style", "display:none;");
        }

        if(sessionStorage.getItem("labSelectParam")!=""){
            //sessionStorage.removeItem("labSelectParam");
        }


        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '序号', name: 'serialNumber', width: 50, editable: true}
            , {label: '<span style="color:red;">*</span>设备名称', name: 'deviceName', width: 150, editable: true}
            , {label: '<span style="color:red;">*</span>统一编号', name: 'unifiedId', width: 150, editable: true}
            , {label: '<span style="color:red;">*</span>设备id', name: 'deviceId', width: 150, editable: true, hidden: true}
            , {label: '<span style="color:red;">*</span>实验室id', name: 'labId', width: 150, editable: true, hidden: true}
            , {label: '实验室名称', name: 'labName', width: 150, editable: true, hidden: true}
            , {
                label: '责任人',
                name: 'ownerIdAlias',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'ownerId'}
            }
            , {label: '责任人id', name: 'ownerId', width: 75, hidden: true, editable: false}
            , {
                label: '责任人部门',
                name: 'ownerDeptAlias',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'ownerDept'}
            }
            , {label: '责任人部门id', name: 'ownerDept', width: 75, hidden: true, editable: false}
            , {label: '设备状态id', name: 'deviceState', width: 75, hidden: true}
            // , {
            //     label: '设备状态',
            //     name: 'deviceStateName',
            //     width: 150,
            //     editable: true,
            //     edittype: "custom",
            //     editoptions: {
            //         custom_element: selectElem1,
            //         custom_value: selectValue1,
            //         forId: 'deviceState',
            //         value: deviceStateData
            //     }
            // }
            // , {label: '预约状态id', name: 'orderState', width: 75, hidden: true}
            // , {
            //     label: '预约状态',
            //     name: 'orderStateName',
            //     width: 150,
            //     editable: true,
            //     edittype: "custom",
            //     editoptions: {
            //         custom_element: selectElem1,
            //         custom_value: selectValue1,
            //         forId: 'orderState',
            //         value: orderStateData
            //     }
            // }
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("deviceName");
        searchTips.push("设备名称");
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsLabDevice_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);

        assetsLabDevice = new AssetsLabDevice('assetsLabDevicejqGrid', '${url}', 'searchDialog', 'form', 'assetsLabDevice_keyWord', searchNames, dataGridColModel ,isCellEdit);
        //添加按钮绑定事件
        $('#assetsLabDevice_insert').bind('click', function () {
            //assetsLabDevice.insert();
            var param = JSON.stringify({unifiedId: "Z555555"});
            openProductModelLayer("false", "", "callBackFn", "");
        });
        //删除按钮绑定事件
        $('#assetsLabDevice_del').bind('click', function () {
            assetsLabDevice.del();
        });
        //保存按钮绑定事件
        $('#assetsLabDevice_save').bind('click', function () {
            assetsLabDevice.save();
        });
        //编辑按钮绑定事件
        $('#assetsLabDevice_edit').bind('click', function () {
            assetsLabDevice.edit();
        });
        //提交按钮绑定事件
        $('#assetsLabDevice_submit').bind('click', function () {
            var labDeviceRows = $('#assetsLabDevicejqGrid').jqGrid('getGridParam','selarrrow');
            if((labDeviceRows == null) || (labDeviceRows == undefined) || (labDeviceRows.length == 0)){
                layer.msg('请先选择实验室设备！');
                return;
            }
            else if(labDeviceRows.length > 1){
                layer.msg('只能选择一个实验室设备！');
                return;
            }
            var rowData = jQuery("#assetsLabDevicejqGrid").jqGrid("getRowData", labDeviceRows[0]);

            parent.parent.procDetail.relateLabDevice(rowData);
        });
        //查询按钮绑定事件
        $('#assetsLabDevice_searchPart').bind('click', function () {
            assetsLabDevice.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsLabDevice_searchAll').bind('click', function () {
            assetsLabDevice.openSearchForm(this);
        });
        //回车键查询
        $('#assetsLabDevice_keyWord').on('keydown', function (e) {
            if (e.keyCode == 13) {
                assetsLabDevice.searchByKeyWord();
            }
        });
        $('#ownerIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerId', textFiled: 'ownerIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#ownerDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDept', textFiled: 'ownerDeptAlias'});
            this.blur();
            nullInput(e);
        });

    });



    /* -------------------------------------------------------创建甘特图对象，设置列配置-----------------------------------------------------------------------------*/

    var gantt = new CreateGantt();
    gantt.render(document.getElementById("ganttArea"));
    gantt.setAllowDragDrop(false);
    //    gantt.on("taskcreated", function (e) {
    //        e.task.Start = null;
    //        e.task.Finish = null;
    //    });

    //右键菜单
    // var ganttMenu = new GanttMenu();
    // gantt.setContextMenu(ganttMenu);


    /* 业务代码
    -----------------------------------------------------------------------------*/


    function save() {
        //获取当前任务树形数据
        var tasktree = gantt.getTaskTree();

        //获取所有被删除的任务
        var taskRemoved = gantt.getRemovedTasks();


        //将数据转换为JSON字符串
        var taskJSON = mini.encode(tasktree);
        var remvedJSON = mini.encode(taskRemoved);

        //alert(taskJSON);
        var params = {
            tasks: taskJSON,
            removeds: remvedJSON
        };
        layer.alert("将甘特图的任务数据提交到服务端进行保存");

        //使用jQuery的ajax，把任务数据，发送到服务端进行处理
//    $.ajax({
//        url: 'savegant.aspx',
//        type: "POST",
//        data: params,
//        success: function (text) {
//            alert("保存成功");
//        }
//    });
    }

    //加载树形数据
    function loadTree() {
        gantt.loading();
        $.ajax({
            url: "avicit/assets/lab/assetslabdevice/data/taskTree.txt",
            cache: false,
            success: function (text) {
                var data = mini.decode(text);

                gantt.loadTasks(data);

                gantt.unmask();
                //折叠全部
                //gantt.collapseAll();
            }
        });
    }

    //加载列表数据
    function loadList(labDeviceId) {
        gantt.loading();
        var labDeviceData;
        labDeviceData = JSON.stringify({labDeviceId:labDeviceId});
        var searchdata = {
            keyWord: null,
            param: labDeviceData
        }
        if(labDeviceId != undefined){
            $.ajax({
                // url: "avicit/assets/lab/assetslabdevice/data/taskList.txt",
                url: 'platform/assets/lab/assetslaborder/assetsLabOrderController/operation/getOrderList',
                type: 'POST',
                async: true,
                dataType: 'json',
                data: JSON.stringify({"labDeviceId": labDeviceId}),
                contentType: "application/json",
                cache: false,
                success: function (labDeviceOrderData) {
                    var data = mini.decode(labDeviceOrderData);
                    //列表转树形
                    data = mini.arrayToTree(data, "children", "UID", "ParentTaskUID");
                    gantt.loadTasks(data);
                    gantt.unmask();

                }
            });
        }

    }

    //加载甘特图数据在js的首次单击选中方法中执行
    // loadList();     //这个方式，服务端只需要生成列表数据就可以。
    //loadTree();


    //setTimeout(function () {
    //    gantt.select(1);
    //    alert(gantt.getSelected());
    //}, 1000);

    function changeTopTimeScale(value) {
        gantt.setTopTimeScale(value)
    }
    function changeBottomTimeScale(value) {
        gantt.setBottomTimeScale(value)
    }
    function zoomIn() {
        gantt.zoomIn();
    }
    function zoomOut() {
        gantt.zoomOut();
    }

    function addTask() {
        var newTask = gantt.newTask();
        newTask.Name = '<新增任务>';    //初始化任务属性

        var selectedTask = gantt.getSelected();
        if (selectedTask) {
            gantt.addTask(newTask, "before", selectedTask);   //插入到到选中任务之前
            //project.addTask(newTask, "add", selectedTask);       //加入到选中任务之内
        } else {
            gantt.addTask(newTask);
        }
    }
    function removeTask() {
        var task = gantt.getSelected();
        if (task) {
            if (confirm("确定删除任务 \"" + task.Name + "\" ？")) {
                gantt.removeTask(task);
            }
        } else {
            alert("请选中任务");
        }
    }
    function updateTask() {
        var selectedTask = gantt.getSelected();
        alert("编辑选中任务:" + selectedTask.Name);
    }
    function upgradeTask() {
        var task = gantt.getSelected();
        if (task) {
            gantt.upgradeTask(task);
        } else {
            alert("请选选中任务");
        }
    }
    function downgradeTask() {
        var task = gantt.getSelected();
        if (task) {
            gantt.downgradeTask(task);
        } else {
            alert("请选选中任务");
        }
    }

    //创建链接、删除链接事件处理
    // gantt.on("linkcreate", function (e) {
    //     var link = e.link;
    //     var task = gantt.getTask(link.TaskUID);
    //     var preTask = gantt.getTask(link.PredecessorUID);
    //
    //     alert("-------------创建链接-------------\n任务：" + task.Name + "\n前置任务：" + preTask.Name + "\n链接类型：" + link.Type);
    // });
    // gantt.on("linkremove", function (e) {
    //     var link = e.link;
    //     var task = gantt.getTask(link.TaskUID);
    //     var preTask = gantt.getTask(link.PredecessorUID);
    //     alert("-------------删除链接-------------\n任务：" + task.Name + "\n前置任务：" + preTask.Name + "\n链接类型：" + link.Type);
    // });




</script>
</html>