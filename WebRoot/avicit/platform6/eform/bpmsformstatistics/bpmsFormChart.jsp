<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
    String importlibs = "common";
%>
<!DOCTYPE html>
<html>
<head>
    <title>电子表单统计</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
        }

    </style>

</head>
<body>
<div id="eformmodole" style="padding-top:30px;height:400px;width:50%;float:left;text-align:center;align:center;overflow:hidden;"></div>
<div id="eformflow" style="padding-top:30px;height:400px;margin-left:50%;text-align:center;align:center;overflow:hidden;"></div>
</body>

<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<script src="static/h5/echarts/dist/echarts-all.js" type="text/javascript"></script>
<script type="text/javascript">
    //基于准备好的dom，初始化echarts实例
    var eformmodoleChart = echarts.init(document.getElementById('eformmodole'));
    var eformmenu,cformmenu,cformwf,eformwf;
    eformmodoleChart.on('click', function(param){
        layer.open({
            type: 2,
            title: "详情",
            skin: 'bs-modal',
            area: ['45%', '85%'],
            maxmin: false,
            content: "avicit/platform6/eform/bpmsformstatistics/formChartDetail.jsp",
            no: function(index, layero){
                layero.close(index);
            },
            success: function(layero, index){
                var frm = layero.find('iframe')[0].contentWindow;
                frm.initModuleJqgrid(param.dataIndex);
            }
        });
    });

    var eformmodoleOption = {
        title : {
            text: '电子表单使用情况（模块）',
            subtext: '截止当前',
            x:'60',
            y:'5',
            textAlign:'left'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            data:['电子表单模块','普通表单模块'],
            x:'center',
            y:'40',
            padding:[0,0,80,80]
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: false},
                dataView : {false: true, readOnly: false},
                magicType : {
                    show: false,
                    type: ['pie', 'funnel'],
                    option: {
                        funnel: {
                            x: '25%',
                            width: '50%',
                            funnelAlign: 'left',
                            max: 1548
                        }
                    }
                }
            }
        },
        calculable : false,
        series : [
            {
                name:'模块数量',
                type:'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:[]
            }
        ]
    };



    var eformflowChart = echarts.init(document.getElementById('eformflow'));

    eformflowChart.on('click', function(param){
        layer.open({
            type: 2,
            title: "详情",
            skin: 'bs-modal',
            area: ['45%', '85%'],
            maxmin: false,
            content: "avicit/platform6/eform/bpmsformstatistics/flowChartDetail.jsp",
            no: function(index, layero){
                layero.close(index);
            },
            success: function(layero, index){
                var frm = layero.find('iframe')[0].contentWindow;
                frm.initModuleJqgrid(param.dataIndex);
            }
        });
    });


    var eformflowOption = {
        title : {
            text: '电子表单使用情况（流程）',
            subtext: '截止当前',
            x:'60',
            y:'5',
            textAlign:'left'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            data:['电子表单流程','普通表单流程'],
            x:'center',
            y:'40',
            padding:[0,0,80,80]
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: false},
                dataView : {false: true, readOnly: false},
                magicType : {
                    show: false,
                    type: ['pie', 'funnel'],
                    option: {
                        funnel: {
                            x: '25%',
                            width: '50%',
                            funnelAlign: 'left',
                            max: 1548
                        }
                    }
                }
            }
        },
        calculable : false,
        series : [
            {
                name:'流程数量',
                type:'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:[]
            }
        ]
    };



    function showView(data){
        eformmodoleOption.series[0]['data'][0] = {value:data.eformmenucount,name:'电子表单模块'};
        eformmodoleOption.series[0]['data'][1] = {value:data.commonformcount,name:'普通表单模块'};

        eformflowOption.series[0]['data'][0] = {value:data.eformwfcount,name:'电子表单流程'};
        eformflowOption.series[0]['data'][1] = {value:data.cformwfcount,name:'普通表单流程'};
        // 使用刚指定的配置项和数据显示图表。
        eformmodoleChart.setOption(eformmodoleOption,true);
        eformflowChart.setOption(eformflowOption,true);
        eformmenu = data.eformmenu;
        cformmenu = data.commonform;
        cformwf = data.cformwf;
        eformwf = data.eformwf;
    }

    $(document).ready(function() {

        avicAjax.ajax({
            url: "platform/eform/bpmsStatisticsController/getEformModuleCount",
            type: "post",
            dataType: "json",
            success: function (data) {
                showView(data);
            }
        });

    });


</script>
</html>