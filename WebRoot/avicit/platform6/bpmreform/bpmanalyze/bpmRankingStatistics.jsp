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
    <title>排名统计</title>
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
            <div id="todoOverstockRank" title="待办积压排名" style="height:400px;text-align:center;align:center"></div>
            <div id="bpmThroughputRank" title="流程吞吐量排名" style="height:400px;text-align:center;align:center"></div>
            <div id="todoDealtimeRank" title="流程办理时间排名" style="height:400px;text-align:center;align:center"></div>
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
            <div id="todoOverstockRankP" title="待办积压排名" style="height:400px;text-align:center;align:center"></div>
            <div id="bpmThroughputRankP" title="流程吞吐量排名" style="height:400px;text-align:center;align:center"></div>
            <div id="todoDealtimeRankP" title="流程办理时间排名" style="height:400px;text-align:center;align:center"></div>
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
            <div id="todoOverstockRankO" title="待办积压排名" style="height:400px;text-align:center;align:center"></div>
            <div id="bpmThroughputRankO" title="流程吞吐量排名" style="height:400px;text-align:center;align:center"></div>
            <div id="todoDealtimeRankO" title="流程办理时间排名" style="height:400px;text-align:center;align:center"></div>
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

    //var chooseBpm =function(){

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
        getDate($(this).val());
    });

    $('#timeBasePosition').on('change',function(){
        getDate4Position($(this).val());
    });

    $('#timeBaseOrg').on('change',function(){
        getDate4Org($(this).val());
    });


    function showView(jsonDate,echar){
        if(jsonDate[0].xAxis.length ==0){
            jsonDate[0].xAxis=['无流程'];
        }
        if(jsonDate[0].yAxis.length ==0){
            jsonDate[0].yAxis=[0];
        }
        echar.todoOverstockRank.Option.xAxis[0].data=jsonDate[0].xAxis;
        echar.todoOverstockRank.Option.series[0].data=jsonDate[0].yAxis;
        echar.todoOverstockRank.chart.setOption(echar.todoOverstockRank.Option,true);

        if(jsonDate[1].xAxis.length ==0){
            jsonDate[1].xAxis=['无流程'];
        }
        if(jsonDate[1].yAxis.length ==0){
            jsonDate[1].yAxis=[0];
        }
        echar.bpmThroughputRank.Option.xAxis[0].data=jsonDate[1].xAxis;
        echar.bpmThroughputRank.Option.series[0].data=jsonDate[1].yAxis;
        echar.bpmThroughputRank.chart.setOption(echar.bpmThroughputRank.Option,true);

        if(jsonDate[2].xAxis.length ==0){
            jsonDate[2].xAxis=['无流程'];
        }
        if(jsonDate[2].yAxis.length ==0){
            jsonDate[2].yAxis=[0];
        }
        echar.todoDealtimeRank.Option.xAxis[0].data=jsonDate[2].xAxis;
        echar.todoDealtimeRank.Option.series[0].data=jsonDate[2].yAxis;
        echar.todoDealtimeRank.chart.setOption(echar.todoDealtimeRank.Option,true);
    }

    var initFlag={};

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        if(e.target.rel==='P'&&!initFlag.P){

            var temp = myechars;
            temp.position={};
            temp.position.todoOverstockRank={},
            temp.position.bpmThroughputRank={},
            temp.position.todoDealtimeRank={},
            temp.position.todoOverstockRank.chart = echarts.init(document.getElementById('todoOverstockRankP')),
            temp.position.bpmThroughputRank.chart = echarts.init(document.getElementById('bpmThroughputRankP')),
            temp.position.todoDealtimeRank.chart = echarts.init(document.getElementById('todoDealtimeRankP'));


            temp.position.todoOverstockRank.Option = {
                title : {
                    text: '流程待办积压排名',
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
                        name:'待办任务数量'
                    }
                ],
                series : [
                    {
                        name:'待办积压',
                        type:'bar',
                        data:[0],
                        barWidth:80
                    }
                ]
            };


            temp.position.bpmThroughputRank.Option = {
                title : {
                    text: '流程吞吐量排名',
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
                        name:'流程实例数量'
                    }
                ],
                series : [
                    {
                        name:'吞吐量',
                        type:'bar',
                        data:[0],
                        barWidth:80
                    }
                ]
            };

            temp.position.todoDealtimeRank.Option = {
                title : {
                    text: '流程办理时间排名',
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
                        name:'流程最大办理时间(小时)'
                    }
                ],
                series : [
                    {
                        name:'待办积压',
                        type:'bar',
                        data:[0],
                        barWidth:80
                    }
                ]
            };


            temp.position.todoOverstockRank.chart.setOption(temp.position.todoOverstockRank.Option);
            temp.position.bpmThroughputRank.chart.setOption(temp.position.bpmThroughputRank.Option);
            temp.position.todoDealtimeRank.chart.setOption(temp.position.todoDealtimeRank.Option);
            getDate4Position(1);
            initFlag.P=true;

        }else if(e.target.rel==='O'&&!initFlag.O){
            var temp = myechars;
            temp.Org={};
            temp.Org.todoOverstockRank={},
            temp.Org.bpmThroughputRank={},
            temp.Org.todoDealtimeRank={},
            temp.Org.todoOverstockRank.chart = echarts.init(document.getElementById('todoOverstockRankO')),
            temp.Org.bpmThroughputRank.chart = echarts.init(document.getElementById('bpmThroughputRankO')),
            temp.Org.todoDealtimeRank.chart = echarts.init(document.getElementById('todoDealtimeRankO'));


            temp.Org.todoOverstockRank.Option = {
                title : {
                    text: '流程待办积压排名',
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
                        name:'待办任务数量'
                    }
                ],
                series : [
                    {
                        name:'待办积压',
                        type:'bar',
                        data:[0],
                        barWidth:80
                    }
                ]
            };


            temp.Org.bpmThroughputRank.Option = {
                title : {
                    text: '流程吞吐量排名',
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
                        data : ['']
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        name:'流程实例数量'
                    }
                ],
                series : [
                    {
                        name:'吞吐量',
                        type:'bar',
                        data:[0],
                        barWidth:80
                    }
                ]
            };

            temp.Org.todoDealtimeRank.Option = {
                title : {
                    text: '流程办理时间排名',
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
                        name:'流程最大办理时间(小时)'
                    }
                ],
                series : [
                    {
                        name:'待办积压',
                        type:'bar',
                        data:[0],
                        barWidth:80
                    }
                ]
            };


            temp.Org.todoOverstockRank.chart.setOption(temp.Org.todoOverstockRank.Option);
            temp.Org.bpmThroughputRank.chart.setOption(temp.Org.bpmThroughputRank.Option);
            temp.Org.todoDealtimeRank.chart.setOption(temp.Org.todoDealtimeRank.Option);
            getDate4Org(1);
            initFlag.O=true;
        }




    });

    $(document).ready(function() {
        var temp = myechars;

        temp.bpm={},
        temp.bpm.todoOverstockRank={},
        temp.bpm.bpmThroughputRank={},
        temp.bpm.todoDealtimeRank={},
        temp.bpm.todoOverstockRank.chart = echarts.init(document.getElementById('todoOverstockRank')),
        temp.bpm.bpmThroughputRank.chart = echarts.init(document.getElementById('bpmThroughputRank')),
        temp.bpm.todoDealtimeRank.chart = echarts.init(document.getElementById('todoDealtimeRank'));


        temp.bpm.todoOverstockRank.Option = {
            title : {
                text: '流程待办积压排名',
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
                    data : [' ']
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    name:'待办任务数量'
                }
            ],
            series : [
                {
                    name:'待办积压',
                    type:'line',
                    data:[0],
                    barWidth:80
                }
            ]
        };

        temp.bpm.bpmThroughputRank.Option = {
            title : {
                text: '流程吞吐量排名',
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
                    name:'流程实例数量'
                }
            ],
            series : [
                {
                    name:'吞吐量',
                    type:'bar',
                    data:[0],
                    barWidth:80
                }
            ]
        };

        temp.bpm.todoDealtimeRank.Option = {
            title : {
                text: '流程办理时间排名',
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
                    name:'流程最大办理时间(小时)'
                }
            ],
            series : [
                {
                    name:'流程办理时间',
                    type:'line',
                    data:[0],
                    barWidth:80
                }
            ]
        };


        temp.bpm.todoOverstockRank.chart.setOption(temp.bpm.todoOverstockRank.Option);
        temp.bpm.bpmThroughputRank.chart.setOption(temp.bpm.bpmThroughputRank.Option);
        temp.bpm.todoDealtimeRank.chart.setOption(temp.bpm.todoDealtimeRank.Option);

        getDate(1);

    });

    var getDate=function(basetime){
        $.ajax({
            url: 'platform/bpm/analyze/rank/statistics/bpm/'+basetime+'.json',
            type :'post',
            data:JSON.stringify({ids:bpmArray,names:bpmNames}),
            contentType : 'application/json',
            dataType : 'json',
            success :function(r){
                showView(r,myechars.bpm);
            }
        });
    }


    var getDate4Position=function (basetime) {
        $.ajax({
            url: 'platform/bpm/analyze/rank/statistics/position/'+basetime+'.json',
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
            url: 'platform/bpm/analyze/rank/statistics/org/'+basetime+'.json',
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