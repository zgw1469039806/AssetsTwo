<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>--%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>

<%
    String importlibs = "common,form,table";
    String selectId = "\'"+request.getParameter("ids")+"\'";
    String activityNames = "\'"+request.getParameter("activityNames")+"\'";
    String startTime = "\'"+request.getParameter("startTime")+"\'";
    String endTime = "\'"+request.getParameter("endTime")+"\'";
    String index = "\'"+request.getParameter("index")+"\'";
    String indexNext = "\'"+request.getParameter("indexNext")+"\'";
%>
<!DOCTYPE html>
<html>
<head>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
    <title>详情分析</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <%--<link rel="stylesheet" type="text/css"
          href="avicit/platform6/flowMonitoring/bpaDataAnalyze/css/analyze.css"/>
    <link rel="stylesheet" href="avicit/platform6/bpmreform/bpmdeploy/css/style.css"/>--%>
    <%--<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>--%>


    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="customText" class="text" style="visibility: visible;">
    <p>
        <span id="span_id" style="text-align: center;display:block;"></span>
    </p>
</div>

<div class="jqGrid_wrapper">
    <table id="datagridOnly"></table>
    <div id="pager"></div>
</div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<%--<script type="text/javascript" src="static/h5/jqGrid-5.2.0/js/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="static/h5/jqGrid-5.2.0/js/jquery.jqGrid.custom.js"></script>--%>
<%--<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
<script type="text/javascript" src="static/h5/common-ext/avic.ajax.js"></script>--%>
<script type="text/javascript">
    // 确定时间范围数组
    var startMillis = <%=startTime%>;
    var endMillis = <%=endTime%>;
    var selectId = <%=selectId%>;  //  记录选中的Id
    var activityNames = <%=activityNames%>;  //  记录选中的Id
    //var selectName = parent.drillName;   // 要钻取的名称
    var index = <%=index%>;//  index用于表示流程维度，节点维度，部门维度，人员维度，岗位维度等
    var indexNext = <%=indexNext%>;//  indexNext表示同一维度下的图索引

    var selectIds=[]; selectIds.push(selectId);
    var activityNamesArry=[]; activityNamesArry.push(activityNames);
    //debugger;

    $(document).ready(function(){
        document.getElementById("span_id").innerHTML="流程 " /*+ selectName */+ "详情列表";
        var theData = {Ids:selectIds,activityNames:activityNamesArry,startTime:startMillis,endTime:endMillis};
        if(index=='0' && indexNext=='1'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getInstCountByProcAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程实例ID','开始时间','完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        } else if(index=='0' && indexNext=='2'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getTaskCountByProcAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程实例ID','开始时间','完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='0' && indexNext=='3'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getToDeptCountByProcAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','任务办理者部门名称','开始时间','完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='0' && indexNext=='4'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getToPosCountByProcAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','任务办理者岗位名称','开始时间','完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='0' && indexNext=='102'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getTaskCountByActivityAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['任务名称','流程名称','开始时间','完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='0' && indexNext=='103'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getToDeptCountByActivityAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['部门名称','流程名称','开始时间','完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='0' && indexNext=='104'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getToPosCountByActivityAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['岗位名称','流程名称','开始时间','完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='0' && indexNext=='111'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getKPIAnalyzeForProcSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程ID','合理完成时间','实际完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='0' && indexNext=='112'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getKPIAnalyzeForTaskSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程ID','合理完成时间','实际完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='0' && indexNext=='113'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getEffAnalyzeForProcSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程实例ID','实际完成时间','实际完成时长(小时)'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'duRation',index : 'duRation',width : 120}
                ]
            });
        }else if(index=='0' && indexNext=='114'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getEffAnalyzeForTaskSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程ID','实际完成时间','实际完成时长(小时)'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'duRation',index : 'duRation',width : 120}
                ]
            });
        }else if(index=='1' && indexNext=='111'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getKPIAnalyzeForProcByPosSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程实例ID','实际完成时间','合理完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='1' && indexNext=='112'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getKPIAnalyzeForTaskByPosSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['任务名称','流程名称','实际完成时间','合理完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='1' && indexNext=='113'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getEffAnalyzeForProcByPosSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程ID','实际完成时间','实际完成时长(小时)'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'duRation',index : 'duRation',width : 120}
                ]
            });
        }else if(index=='1' && indexNext=='114'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getEffAnalyzeForTaskByPosSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['任务名称','流程名称','实际完成时间','实际完成时长(小时)'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'duRation',index : 'duRation',width : 120}
                ]
            });
        }else if(index=='2' && indexNext=='111'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getKPIAnalyzeForProcByDeptSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                scrollOffset: 10, //设置垂直滚动条宽度
                rowNum: 10,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                styleUI : 'Bootstrap',
                viewrecords: true, //
                autowidth: true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                rownumbers:true,
                pager: "#pager",
                colNames:['流程名称','部门名称','实际完成时间','合理完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='2' && indexNext=='112'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getKPIAnalyzeForTaskByDeptSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['部门名称','流程名称','实际完成时间','合理完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='2' && indexNext=='113'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getEffAnalyzeForProcByDeptSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['部门名称','任务名称','实际完成时间','实际完成时长(小时)'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'duRation',index : 'duRation',width : 120}
                ]
            });
        }else if(index=='2' && indexNext=='114'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getEffAnalyzeForTaskByDeptSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['部门名称','流程ID','实际完成时间','实际完成时长(小时)'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'duRation',index : 'duRation',width : 120}
                ]
            });
        }else if((index=='2' && indexNext=='121') || (index=='1' && indexNext=='121')){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getKPIAnalyzeForProcByOrgSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程ID','实际完成时间','合理完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if((index=='2' && indexNext=='122') || (index=='1' && indexNext=='122')){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getKPIAnalyzeForTaskByOrgSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['任务名称','流程ID','实际完成时间','合理完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if((index=='2' && indexNext=='123') || (index=='1' && indexNext=='123')){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getEffAnalyzeForProcByOrgSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程ID','实际完成时间','实际完成时长(小时)'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'duRation',index : 'duRation',width : 120}
                ]
            });
        }else if((index=='2' && indexNext=='124') || (index=='1' && indexNext=='124')){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getEffAnalyzeForTaskByOrgSByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['任务名称','任务办理者','实际完成时间','实际完成时长(小时)'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'duRation',index : 'duRation',width : 120}
                ]
            });
        }else if(index=='1' && indexNext=='1'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getInstCountByPosAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程ID','开始时间','完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='1' && indexNext=='2'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getTaskCountByPosAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['任务名称','流程实例ID','实际完成时间','完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='2' && indexNext=='1'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getInstCountByDeptAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','部门名称','开始时间','完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='2' && indexNext=='2'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getTaskCountByDeptAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['任务名称','部门名称','开始时间','完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if((index=='1' && indexNext=='101') || (index=='2' && indexNext=='101')){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getInstCountByUserAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程ID','流程开始时间','流程结束时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if((index=='1' && indexNext=='102') || (index=='2' && indexNext=='102')){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getTaskCountByUserAByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程ID','流程开始时间','流程结束时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='0' && indexNext=='122'){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getKPIAnalyzeForActivitySByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程ID','合理完成时间','实际完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if((index=='0' && indexNext=='124') ){
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getEffAnalyzeForActivitySByPage.json',
                mtype: 'POST',
                datatype: "json",
                postData:{
                    param: JSON.stringify(theData)
                },
                height: '300',
                width:'980',
                fit:'true',
                rowNum: 10	,
                rowList:[100,50,30,20,10],
                altRows:true,
                pagerpos:'left',
                pgbuttons:true,
                styleUI : 'Bootstrap',
                viewrecords: true,
                multiselect: false,
                rownumbers:true,
                hasColSet:false,
                hasTabExport:false,
                responsive:true,//开启自适应
                pager: "#pager",
                colNames:['流程名称','流程ID','节点名称','流程开始时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'id',index : 'id',width : 120},
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }

        //表格宽度自适应
        $(function(){
            //debugger;
            setTimeout(function(){
                $("#datagridOnly").setGridWidth($(window).width());
            }, 200);


        });
    });
</script>
</html>
