<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<% 
String importlibs = "common,form,table";
String indexId = "\'"+request.getParameter("indexId")+"\'";
String indexNext = "\'"+request.getParameter("indexNext")+"\'";
String selectId = "\'"+request.getParameter("selectId")+"\'";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>列表详情分析</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/flowMonitoring/bpaDataAnalyze/css/analyze.css"/>
<link rel="stylesheet" href="avicit/platform6/bpmreform/bpmdeploy/css/style.css"/>
<%--<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>--%>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
div#customText {
    font-size:  14px;
    padding-left: 14px;
    padding-top: 6px;
}
</style>
</head>
<body>
	<div id="customText" class="text" style="visibility: visible;">
		<p>
			<span id="span_id" style="text-align: center;display:block;"></span>
		</p>
	</div>

	<table id="datagridOnly"></table>
	<div id="pager"></div>

</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<%--<script type="text/javascript" src="static/h5/jqGrid-5.2.0/js/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="static/h5/jqGrid-5.2.0/js/jquery.jqGrid.custom.js"></script>
<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
<script type="text/javascript" src="static/h5/common-ext/avic.ajax.js"></script>--%>
<script type="text/javascript">
	var index = <%=indexId%>;   //  index用于表示流程维度，节点维度，部门维度，人员维度，岗位维度等
	var indexNext = <%=indexNext%>;   //  indexNext表示同一维度下的图索引
	var selectId = <%=selectId%>;  //  记录选中的Id
	var selectName = parent.drillName;   // 要钻取的名称
//debugger;
	var selectIds=[]; selectIds.push(selectId);
	// 确定时间范围数组
	var startMillis = parent.startMillis;
	var endMillis = parent.endMillis;
	$(document).ready(function(){   //  初始化页面
	    // 针对不同维度选择进行判断
		if(index=='0' && indexNext=='11'){  // 流程维度第一张图钻取
			document.getElementById("span_id").innerHTML="流程 " + selectName + " : 待办积压详情列表";

			var data_json = new Array();
            var theData = {procIds:selectIds,startTime:startMillis,endTime:endMillis};
			$('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getWaitForDetailByProcSDByPage.json',
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
				colNames:['流程名称55','任务名称','实际完成时间','合理完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'taskName',index : 'taskName',width : 120},
                    {name : 'cycleEnd',index : 'cycleEnd',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'reasTime',index : 'reasTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
			});

		}else if(index=='0' && indexNext=='12'){
            document.getElementById("span_id").innerHTML="流程 " + selectName + " : 办理时间详情列表";
            var theData = {procIds:selectIds,startTime:startMillis,endTime:endMillis};
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getTimeAndPutDetailByProcSDByPage.json',
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
                colNames:['流程名称','实例ID','实际完成时间','实际完成时长（小时）'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'cycleEnd',index : 'cycleEnd',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'duRation',index : 'duRation',width : 120}
                ]
            });

        }else if(index=='0' && indexNext=='13'){
            document.getElementById("span_id").innerHTML="流程 " + selectName + " : 办结数量详情列表";

            var theData = {procIds:selectIds,startTime:startMillis,endTime:endMillis};
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getTimeAndPutDetailByProcSDByPage.json',
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
                colNames:['流程名称','实例ID','流程开始时间','流程结束时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'instID',index : 'instID',width : 120},
                    {name : 'cycleFrom',index : 'cycleFrom',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'cycleEnd',index : 'cycleEnd',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });

        }else if(index=='2' && indexNext=='31'){
            document.getElementById("span_id").innerHTML="部门 " + selectName + " : 待办积压详情列表";

            var theData = {deptIds:selectIds,startTime:startMillis,endTime:endMillis};
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getWaitForDetailByDeptSDByPage.json',
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
                colNames:['流程名称','任务名称','实际完成时间','合理完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'taskName',index : 'taskName',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    },
                    {name : 'reasTime',index : 'reasTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='2' && indexNext=='32'){
            document.getElementById("span_id").innerHTML="部门 " + selectName + " : 办理时间详情列表";

            var theData = {deptIds:selectIds,startTime:startMillis,endTime:endMillis};
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getTimeDetailByDeptSDByPage.json',
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
                colNames:['部门名称','流程名称','实例ID','实际完成时长（小时）'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'deptName',index : 'deptName',width : 120},
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'processInstanceId',index : 'processInstanceId',width : 120},
                    {name : 'duRation',index : 'duRation',width : 120}
                ]
            });
        }else if(index=='2' && indexNext=='33'){
            document.getElementById("span_id").innerHTML="部门 " + selectName + " : 任务数量详情列表";

            var theData = {deptIds:selectIds,startTime:startMillis,endTime:endMillis};
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getPutDetailByDeptSDByPage.json',
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
                colNames:['流程名称','任务名称','流程开始时间','流程完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'taskName',index : 'taskName',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
						formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }}
                ]
            });
        }else if(index=='1' && indexNext=='21'){
            document.getElementById("span_id").innerHTML="岗位 " + selectName + " : 待办积压详情列表";
			//debugger;
            var theData = {posIds:selectIds,startTime:startMillis,endTime:endMillis};
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getWaitForDetailByPosSDByPage.json',
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
                colNames:['流程名称','任务名称','实际完成时间','合理完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'taskName',index : 'taskName',width : 120},
                    {name : 'endTime',index : 'endTime',width : 120, formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
					},
                    {name : 'reasTime',index : 'reasTime',width : 120, formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }
                    }
                ]
            });
        }else if(index=='1' && indexNext=='22'){
            document.getElementById("span_id").innerHTML="岗位 " + selectName + " : 办理时间详情列表";

            var theData = {posIds:selectIds,startTime:startMillis,endTime:endMillis};
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getTimeDetailByPosSDByPage.json',
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
                colNames:['岗位名称','流程名称','实例ID','实际完成时长（小时）'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'posName',index : 'posName',width : 120},
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'processInstanceId',index : 'processInstanceId',width : 120},
                    {name : 'duRation',index : 'duRation',width : 120}
                ]
            });
        }else if(index=='1' && indexNext=='23'){
            document.getElementById("span_id").innerHTML="岗位 " + selectName + " : 任务数量详情列表";

            var theData = {posIds:selectIds,startTime:startMillis,endTime:endMillis};
            $('#datagridOnly').jqGrid({   //  初始化表格控件
                url: 'bpa/flowmonitoring/getPutDetailByPosSDByPage.json',
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
                colNames:['流程名称','任务名称','流程开始时间','流程完成时间'],//jqGrid的列显示名字
                colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name : 'procName',index : 'procName',width : 120},
                    {name : 'taskName',index : 'taskName',width : 120},
                    {name : 'startTime',index : 'startTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }},
                    {name : 'endTime',index : 'endTime',width : 120,
                        formatter: function (cellvalue, options, row) {
                            return new Date(cellvalue).toLocaleString().replace(/\/|\//g, "-").replace(/上午|下午/g, " ")
                        }}
                ]
            });
        }
	})
</script>
</html>