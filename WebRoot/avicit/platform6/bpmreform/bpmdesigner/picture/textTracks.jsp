<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
    String importlibs = "common,tree,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "ttt/bpmcatalog/bpmCatalogController/toBpmCatalogManage" -->
    <title>文字跟踪</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
    <link rel="stylesheet" href="avicit/platform6/bpmreform/bpmmonitor/css/style.css"/>

    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
        }
    </style>
</head>
<body class="easyui-layout" fit="true">
<div
        data-options="region:'center',onResize:function(a){$('#demoMainDept').setGridWidth(a);$(window).trigger('resize');}">
    <div id="toolbar_textTracks" class="toolbar">
        <div class="toolbar-right">
            <div class="input-group form-tool-search">
                <input type="text" name="textTracks_keyWord"
                       id="textTracks_keyWord" style="width:240px;"
                       class="form-control input-sm" placeholder="请输入查询条件"> <label
                    id="textTracks_searchPart"
                    class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="textTracks_searchAll" href="javascript:void(0)"
                   class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
                    <span class="caret"></span>
                </a>
            </div>
        </div>
    </div>
    <table id="textTracks"></table>
    <div id="textTracksPager"></div>
</div>
</body>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
    <form id="formSub">
        <input type="hidden" name="deptid" id="deptid" />
        <table class="form_commonTable">
            <tr>
                <th width="18%">处理人：</th>
                <td width="30%"><input title="处理人："
                                       class="form-control input-sm" type="text" name="assigneeName"
                                       id="assigneeName" /></td>
                <th width="18%">目标接收人：</th>
                <td width="30%"><input title="目标接收人："
                                       class="form-control input-sm" type="text" name="targetuser"
                                       id="targetuser" /></td>
            </tr>
            <tr>
                <th width="15%">操作类型：</th>
                <td width="30%">
                    <select name="operateType" id="operateType"
                            class="easyui-combobox form-control input-sm">
                        <option value="">全部</option>
                        <option value="dorefer">提交</option>
                        <option value="dowithdraw">拿回</option>
                        <option value="doretreattoprev">退回上一步</option>
                        <option value="doretreattodraft">退回拟稿人</option>
                        <option value="doretreattowant">任意退回</option>
                        <option value="doretreattoactivity">跨节点退回</option>
                        <option value="doglobaljump">流程跳转</option>
                        <option value="doglobalidea">修改意见</option>
                        <option value="dosupersede">流程转办</option>
                        <option value="dotransmit">发送阅知</option>
                        <option value="dotimer">自动流转</option>
                        <option value="doautoworkHand">自动委托</option>
                        <option value="dostartsubprocess">发起子流程</option>
                        <option value="dowriteidea">填写意见</option>
                        <option value="dowithdrawassignee">被减签</option>
                        <option value="dowithdrawassigneeop">减签</option>
                        <option value="doend">流程结束</option>
                        <option value="doadduser">加签</option>
                        <option value="dosupplement">补发</option>
                        <option value="doadduserandsubmit">加签并提交</option>
                        <option value="doworkhandcancel">取消委托</option>
                        <option value="dotaskreader">增加读者</option>
                    </select>
                </td>
                <th width="15%">处理意见：</th>
                <td width="30%">
                    <input title="处理意见："
                                       class="form-control input-sm" type="text" name="message"
                                       id="message" />
                </td>
            </tr>
            <tr>
                <th width="15%">打开时间：</th>
                <td width="30%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text"
                               name="openTimeBegin" id="openTimeBegin" /><span
                            class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="15%">至：</th>
                <td width="30%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text"
                               name="openTimeEnd" id="openTimeEnd" /><span
                            class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

            </tr>
            <tr>
                <th width="15%">处理时间：</th>
                <td width="30%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text"
                               name="endTimeBegin" id="endTimeBegin" /><span
                            class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="15%">至：</th>
                <td width="30%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text"
                               name="endTimeEnd" id="endTimeEnd" /><span
                            class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

            </tr>

        </table>
    </form>
</div>
<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmdesigner/picture/TextTracks.js"
        type="text/javascript"></script>
<script type="text/javascript"
        src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
    var textTracks;
    $(document).ready(function() {
        var processInstanceId = "${processInstanceId}";
        var historyActivityInstanceId ="${historyActivityInstanceId}";
        var searchSubNames = new Array();
        var searchSubTips = new Array();
        searchSubNames.push("assigneeName");
        searchSubTips.push("处理人");
        $('#textTracks_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
        var textTracksGridColModel = [

            {
                label : '节点',
                name : 'currentActiveLabel',
                width : 40,
                align : 'left',
                sortable : false
            }
            , {
                label : '处理人',
                name : 'assigneeName',
                width : 50,
                align : 'left',
                sortable : false
            },{
                label : '接收时间',
                name : 'iTime',
                width : 30,
                align : 'left',
                sortable : false
            }
            ,{
                label : '打开时间',
                name : 'oTime',
                width : 30,
                align : 'left',
                sortable : false
            },{
                label : '处理时间',
                name : 'eTime',
                width : 30,
                align : 'left',
                sortable : false
            },{
                label : '操作类型',
                name : 'opType',
                width : 30,
                align : 'left',
                sortable : false
            },{
                label : '累计时间',
                name : 'useTime',
                width : 30,
                align : 'left',
                sortable : false
            },{
                label : '目标接收人',
                name : 'targetuser',
                width : 30,
                align : 'left',
                sortable : false
            },{
                label : '处理意见',
                name : 'message',
                width : 30,
                align : 'left',
                sortable : false
            }

        ];
        var url ='bpm/business/searchTracksByPage?processInstanceId='+processInstanceId+'&historyActivityInstanceId='+historyActivityInstanceId;
        textTracks = new TextTracks('textTracks', url, "formSub", textTracksGridColModel, 'searchDialogSub',searchSubNames, "textTracks_keyWord");
        //打开高级查询
        $('#textTracks_searchAll').bind('click', function() {
            textTracks.openSearchForm(this, $('#textTracks'));
        });
        //关键字段查询按钮绑定事件
        $('#textTracks_searchPart').bind('click', function() {
            textTracks.searchByKeyWord();
        });
    });


</script>
</html>