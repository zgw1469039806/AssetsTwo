<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
    String importlibs = "common,table,form";
    Calendar calendar = Calendar.getInstance();


    Date nowDate =new Date();



    calendar.setTime(nowDate);
    int year = calendar.get(Calendar.YEAR);
    int year1 =year-1;
    int year2 =year1-1;
    int year3 =year2-1;
    int year4 =year3-1;

%>
<!DOCTYPE html>
<html>
<head>

    <!-- ControllerPath = "ttt/bpmcatalog/bpmCatalogController/toBpmCatalogManage" -->
    <title>效率看板</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
</head>
<body>
<ul id="myTab" class="nav nav-tabs" style="width: 100%;height:100%;">
    <li class="active"><a rel="B" href="#bpm" data-toggle="tab">流程</a></li>
    <li><a rel="P" href="#postion" data-toggle="tab">岗位</a></li>
    <li><a rel="O" href="#org" data-toggle="tab">组织</a></li>
</ul>
<div id="myTabContent" class="tab-content" style="width:100%;height:100%; border: 0;">
    <div class="tab-pane fade in active" id="bpm" style="width:100%;height:100%; border: 0;">

        <div id="tableToolbarBpm" class="toolbar" style="border-bottom: 1px solid #d7d7d7;">
            <div class="toolbar-left">
                <a  id="bpmchoose" style="display: inline-block;" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="选择流程"><i class="icon icon-add"></i> 选择流程</a>
            </div>
            <div class="toolbar-right">
                <select style="width:200px;display: inline-block;" id="timeBaseBpm" name="timeBaseBpm" class="form-control input-sm" title="时间段">
                    <option value="1">最近一个月</option>
                    <option value="2">最近三个月</option>
                    <option value="3">今年内</option>
                    <option value="4"><%=year1%>年</option>
                    <option value="5"><%=year2%>年</option>
                    <option value="6"><%=year3%>年</option>
                    <option value="7"><%=year4%>年前</option>
                </select>
            </div>
        </div>
        <div class="myContainer" style="overflow-y: auto;background-color: #FFFFFF;">
            <div id="bpmThroughput" title="流程吞吐量" style="height:400px;text-align:center;align:center"></div>
            <div id="taskThroughput" title="任务吞吐量" style="height:400px;text-align:center;align:center"></div>
        </div>
    </div>

    <div class="tab-pane fade" id="postion" style="width:100%;height:100%; border: 0;">
        <div id="tableToolbarPosition" class="toolbar" style="border-bottom: 1px solid #d7d7d7;">
            <div class="toolbar-left">
                <a style="display: inline-block;" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="选择岗位" onclick='choosePostion();' href="javascript:void(0);"><i class="icon icon-add"></i> 选择岗位</a>
            </div>
            <div class="toolbar-right">
                <select style="width:200px;display: inline-block;" id="timeBasePosition" name="timeBaseBpm" class="form-control input-sm" title="时间段">
                    <option value="1">最近一个月</option>
                    <option value="2">最近三个月</option>
                    <option value="3">今年内</option>
                    <option value="4"><%=year1%>年</option>
                    <option value="5"><%=year2%>年</option>
                    <option value="6"><%=year3%>年</option>
                    <option value="7"><%=year4%>年前</option>
                </select>
            </div>
        </div>
        <div class="myContainer" style="overflow-y: auto;background-color: #FFFFFF;">
            <div id="bpmThroughputP" title="流程吞吐量" style="height:400px;text-align:center;align:center"></div>
            <div id="taskThroughputP" title="任务吞吐量" style="height:400px;text-align:center;align:center"></div>
        </div>
    </div>

    <div class="tab-pane fade" id="org" style="width:100%;height:100%; border: 0;">
        <div id="tableToolbarOrg" class="toolbar" style="border-bottom: 1px solid #d7d7d7;">
            <div class="toolbar-left">
                <a style="display: inline-block;" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="选择人员" onclick='chooseUser();' href="javascript:void(0);"><i class="icon icon-add"></i> 选择人员</a>
            </div>
            <div class="toolbar-right">
                <select style="width:200px;display: inline-block;" id="timeBaseOrg" name="timeBaseBpm" class="form-control input-sm" title="时间段">
                    <option value="1">最近一个月</option>
                    <option value="2">最近三个月</option>
                    <option value="3">今年内</option>
                    <option value="4"><%=year1%>年</option>
                    <option value="5"><%=year2%>年</option>
                    <option value="6"><%=year3%>年</option>
                    <option value="7"><%=year4%>年前</option>
                </select>
            </div>
        </div>
        <div class="myContainer" style="overflow-y: auto;background-color: #FFFFFF;">
            <div id="bpmThroughputO" title="流程吞吐量" style="height:400px;text-align:center;align:center"></div>
            <div id="taskThroughputO" title="任务吞吐量" style="height:400px;text-align:center;align:center"></div>
        </div>
    </div>
</div>
</body>
<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmbusiness/workhand/js/BpmModuleSelect.js" type="text/javascript"></script>
<script src="static/h5/echarts/dist/echarts-all.js" type="text/javascript"></script>
<script type="text/javascript">



    $('.myContainer').css("height",document.documentElement.clientHeight-100);


    var myechars={};

    //选择流程id集合
    var bpmArray=[];
    var bpmNames=[];
    //选择岗位id集合
    var positionArray=[];
    //选择人员id集合
    var userArray=[];


    new BpmModuleSelect("bpmchoose","bpmchoose", function(data){
        bpmArray=data.ids.split(",");
        bpmNames=data.texts.split(",");
        getDate($('#timeBaseBpm').val());
    });
    //};

    var choosePostion=function(){
        new H5CommonSelect({
            type : 'positionSelect',
            idFiled : '',
            textFiled : '',
            selectModel:'multi',
            callBack:function(posit){
                positionArray=posit.positionids.split(";");
                getDate4Position($("#timeBasePosition").val());


            },
            viewScope : 'currentOrg'
        });
    };

    var chooseUser=function(){
        new H5CommonSelect({
            type : 'userSelect',
            idFiled : '',
            textFiled : '',
            selectModel:'multi',
            callBack:function(user){
                userArray=user.userids.split(";");
                getDate4Org($("#timeBaseOrg").val());


            },
            viewScope : 'currentOrg'
        });
    };


    $('#timeBaseBpm').on('change',function(){
        getDate($(this).val())
    });

    $('#timeBasePosition').on('change',function(){
        getDate4Position($(this).val())
    });

    $('#timeBaseOrg').on('change',function(){
        getDate4Org($(this).val())
    });


    function showView(jsonDate,echar){
        if(jsonDate[0].xAxis.length ==0){
            jsonDate[0].xAxis=['无流程'];
        }
        if(jsonDate[0].yAxis.length ==0){
            jsonDate[0].yAxis=[0];
        }
        echar.bpmThroughput.Option.xAxis[0].data=jsonDate[0].xAxis;
        echar.bpmThroughput.Option.series[0].data=jsonDate[0].yAxis;
        echar.bpmThroughput.chart.setOption(echar.bpmThroughput.Option,true);

        if(jsonDate[1].xAxis.length ==0){
            jsonDate[1].xAxis=['无流程'];
        }
        if(jsonDate[1].yAxis.length ==0){
            jsonDate[1].yAxis=[0];
        }
        echar.taskThroughput.Option.xAxis[0].data=jsonDate[1].xAxis;
        echar.taskThroughput.Option.series[0].data=jsonDate[1].yAxis;
        echar.taskThroughput.chart.setOption(echar.taskThroughput.Option,true);

    }

    var initFlag={};

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        if(e.target.rel==='P'&&!initFlag.P){

            var temp = myechars;
            temp.position={};
            temp.position.bpmThroughput={},
            temp.position.taskThroughput={},
            temp.position.bpmThroughput.chart = echarts.init(document.getElementById('bpmThroughputP')),
            temp.position.taskThroughput.chart = echarts.init(document.getElementById('taskThroughputP')),


            temp.position.bpmThroughput.Option = {
                title : {
                    text: '流程吞吐量',
                    x:'center',
                    y:'top',
                    textAlign:'center'
                },

                tooltip : {
                    trigger: 'axis'
                },
                grid : {
                    top : 40,    //距离容器上边界40像素
                    bottom: 30   //距离容器下边界30像素
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                      /*  magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}
                       /* saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        data : ['一般员工1']
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        name:'流程完成数量'
                    }
                ],
                series : [
                    {
                        name:'流程完成数量',
                        type:'bar',
                        data:[0],
                        barWidth:80
                    }
                ]
            };


            temp.position.taskThroughput.Option = {
                title : {
                    text: '任务吞吐量',
                    x:'center',
                    y:'top',
                    textAlign:'center'
                },

                tooltip : {
                    trigger: 'axis'
                },
                grid : {
                    top : 40,    //距离容器上边界40像素
                    bottom: 30   //距离容器下边界30像素
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                        /*magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}//,
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        data : ['一般员工1']
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        name:'任务完成数量'
                    }
                ],
                series : [
                    {
                        name:'任务完成数量',
                        type:'bar',
                        data:[0],
                        barWidth:80
                    }
                ]
            };


            temp.position.bpmThroughput.chart.setOption(temp.position.bpmThroughput.Option);
            temp.position.taskThroughput.chart.setOption(temp.position.taskThroughput.Option);
            getDate4Position(1);
            initFlag.P=true;

        }else if(e.target.rel==='O'&&!initFlag.O){
            var temp = myechars;
            temp.Org={};
            temp.Org.bpmThroughput={},
            temp.Org.taskThroughput={},
            temp.Org.bpmThroughput.chart = echarts.init(document.getElementById('bpmThroughputO')),
            temp.Org.taskThroughput.chart = echarts.init(document.getElementById('taskThroughputO')),


            temp.Org.bpmThroughput.Option = {
                title : {
                    text: '流程吞吐量',
                    x:'center',
                    y:'top',
                    textAlign:'center'
                },

                tooltip : {
                    trigger: 'axis'
                },
                grid : {
                    top : 40,    //距离容器上边界40像素
                    bottom: 30   //距离容器下边界30像素
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                       /* magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        data : [' ']
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        name:'流程完成数量'
                    }
                ],
                series : [
                    {
                        name:'流程完成数量',
                        type:'bar',
                        data:[0],
                        barWidth:80
                    }
                ]
            };


            temp.Org.taskThroughput.Option = {
                title : {
                    text: '任务吞吐量',
                    x:'center',
                    y:'top',
                    textAlign:'center'
                },

                tooltip : {
                    trigger: 'axis'
                },
                grid : {
                    top : 40,    //距离容器上边界40像素
                    bottom: 30   //距离容器下边界30像素
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                       /* magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        data : ['张三']
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        name:'任务完成数量'
                    }
                ],
                series : [
                    {
                        name:'任务完成数量',
                        type:'bar',
                        data:[10],
                        barWidth:80
                    }
                ]
            };




            temp.Org.bpmThroughput.chart.setOption(temp.Org.bpmThroughput.Option);
            temp.Org.taskThroughput.chart.setOption(temp.Org.taskThroughput.Option);
            getDate4Org(1);
            initFlag.O=true;
        }




    });

    $(document).ready(function() {
        var temp = myechars;

        temp.bpm={},
        temp.bpm.bpmThroughput={},
        temp.bpm.taskThroughput={},
        temp.bpm.bpmThroughput.chart = echarts.init(document.getElementById('bpmThroughput')),
        temp.bpm.taskThroughput.chart = echarts.init(document.getElementById('taskThroughput')),


        temp.bpm.bpmThroughput.Option = {
            title : {
                text: '流程吞吐量',
                x:'center',
                y:'top',
                textAlign:'center'
            },

            tooltip : {
                trigger: 'axis'
            },
            grid : {
                top : 40,    //距离容器上边界40像素
                bottom: 30   //距离容器下边界30像素
            },
            toolbox: {
                show : true,
                feature : {
                    mark : {show: false},
                    dataView : {show: false, readOnly: false},
                   /* magicType : {show: true, type: ['line']},*/
                    restore : {show: true}
                    /*selfButtons:{//自定义按钮 danielinbiti,这里增加，selfbuttons可以随便取名字
                        show:true,//是否显示
                        title:'自定义', //鼠标移动上去显示的文字
                        icon:'test.png', //图标
                        option:{},
                        onclick:function(option1) {//点击事件,这里的option1是chart的option信息
                            alert('1');//这里可以加入自己的处理代码，切换不同的图形
                        }
                    },*/

                },
                padding:[5,80]
            },
            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    data : ['报销流程']
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    name:'流程完成数量'
                }
            ],
            series : [
                {
                    name:'流程完成数量',
                    type:'line',
                    data:[0],
                    barWidth:80
                }
            ]
        };

        temp.bpm.taskThroughput.Option = {
            title : {
                text: '任务吞吐量',
                x:'center',
                y:'top',
                textAlign:'center'
            },

            tooltip : {
                trigger: 'axis'
            },
            grid : {
                top : 40,    //距离容器上边界40像素
                bottom: 30   //距离容器下边界30像素
            },
            toolbox: {
                show : true,
                feature : {
                    mark : {show: false},
                    dataView : {show: false, readOnly: false},
                   /* magicType : {show: true, type: ['line', 'bar']},*/
                    restore : {show: true}
                    /*saveAsImage : {show: true}*/
                },
                padding:[5,80]
            },
            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    data : ['报销流程']
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    name:'任务完成数量'
                }
            ],
            series : [
                {
                    name:'任务完成数量',
                    type:'bar',
                    data:[0],
                    barWidth:80
                }
            ]
        };




        temp.bpm.bpmThroughput.chart.setOption(temp.bpm.bpmThroughput.Option);
        temp.bpm.taskThroughput.chart.setOption(temp.bpm.taskThroughput.Option);

        getDate(1);

    });

    var getDate=function(basetime){
        $.ajax({
            url: 'platform/bpm/analyze/rank/effective/bpm/'+basetime+'.json',
            type :'post',
            data:JSON.stringify({ids:bpmArray,names:bpmNames}),
            contentType : 'application/json',
            dataType :'json',
            success :function(r){
                showView(r,myechars.bpm);
            }
        });
    }


    var getDate4Position=function (basetime) {
        $.ajax({
            url: 'platform/bpm/analyze/rank/effective/position/'+basetime+'.json',
            type :'post',
            data:JSON.stringify(positionArray),
            contentType : 'application/json',
            dataType :'json',
            success :function(r){
                showView(r,myechars.position);
            }
        });
    };

    var getDate4Org=function (basetime) {
        $.ajax({
            url: 'platform/bpm/analyze/rank/effective/org/'+basetime+'.json',
            type :'post',
            data:JSON.stringify(userArray),
            contentType : 'application/json',
            dataType :'json',
            success :function(r){
                showView(r,myechars.Org);
            }
        });
    };
</script>
</html>