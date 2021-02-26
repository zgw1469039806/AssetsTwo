<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
String importlibs = "common";	
session.setAttribute("index","res");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据分析首页</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
 <jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="avicit/platform6/flowMonitoring/bpaDataAnalyze/css/analyze.css">
<style type="text/css">
.showName {
    text-align : right;
    width: 200px;
    height: 20px;
    position: absolute;
    right: 263px;
    top: 14px;
    font-size: 14px;
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
}
</style>
</head>
<body>
	<div id="toolbar_tab" class="toolbar" style="background : #efefef;">
		<div class="toolbar-left">
			<a id="analyze_button_set" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
				title="参数设置"> 参数设置</a>
		</div>
		<div id="showName" class="showName" >
		</div>
		<div id="showHyberTime" class="toolbar-right">
		</div>
	</div>
	<ul id="myTab" class="nav nav-tabs" style="width:100%;height:100%;">
		<li class="active"><a rel="iframe1" href="#throughput" data-toggle="tab" id="tab1" >吞吐量分析</a></li>
		<li><a rel="iframe2" href="#efficiency" data-toggle="tab" id="tab2" >效率分析</a></li>
		<li><a rel="iframe3" href="#ranking" data-toggle="tab" id="tab3" >排名分析</a></li>
	</ul>
	<div id="myTabContent" class="tab-content" style="width:100%;height:100%; border: 0;">
		<div class="tab-pane fade in active" id="throughput" style="width:100%;height:100%; border: 0;">

		</div>
		<div class="tab-pane fade" id="efficiency" style="width:100%;height:100%; border: 0;">
			<iframe id="iframe2" name="iframe2" src="" scrolling="yes" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
		</div>
		<div class="tab-pane fade" id="ranking" style="width:100%;height:100%; border: 0;">
			<iframe id="iframe3" name="iframe3" src="" scrolling="yes" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
		</div>
	</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
var parentRes = 0;
var select = 0;
var data;
// 全局传递变量
var _treeNodeId = null;
var _treeNodeName = null;
// 避免第一次刷新时没有时间参数，设为全局变量
var selectedTime = null;

function showTimeOnTopRight(sel, startDate, endDate){
	var temp1=new Date(parseInt(startDate)); var temp2 = new Date(parseInt(endDate)); 
	var tempMonth1 = temp1.getMonth()+1; var tempMonth2 = temp2.getMonth()+1;
	if (select == "0") {
		document.getElementById("showHyberTime").innerHTML = "<h5>" +  "日期从" + temp1.getFullYear() + "年" +
		 tempMonth1 + "月" + temp1.getDate() + "日" + "到" + temp2.getFullYear() + "年" + tempMonth2 + "月" + 
		 temp2.getDate() + "日" + "</h5>";
	}else if(select == "1"){
		document.getElementById("showHyberTime").innerHTML = "<h5>" +  "日期从" + temp1.getFullYear() + "年" +
		 tempMonth1 + "月" + temp1.getDate() + "日" + "到" + temp2.getFullYear() + "年" + tempMonth2 + "月" + 
		 temp2.getDate() + "日" + "</h5>";
	}else if(select == "2"){
		document.getElementById("showHyberTime").innerHTML = "<h5>" +  "日期从" + temp1.getFullYear() + "年" +
		 tempMonth1 + "月" + temp1.getDate() + "日" + "到" + temp2.getFullYear() + "年" + tempMonth2 + "月" + 
		 temp2.getDate() + "日" + "</h5>";
	}
}

function showNameOnTop(sel, _treeNodeName){
	if(_treeNodeName == null){
		if(select == "0"){
			document.getElementById("showName").innerHTML = "全部流程 " ;
		}else if(select == "1"){
			document.getElementById("showName").innerHTML = "全部岗位  " ;	
		}else if(select == "2"){
			document.getElementById("showName").innerHTML = "全部组织  " ;
		}
	}else{
		if(_treeNodeName.length > 10){
			if(select == "0"){
				document.getElementById("showName").innerHTML = "流程维度： "+_treeNodeName.substring(0,14) + "..." ;
			}else if(select == "1"){
				document.getElementById("showName").innerHTML = "岗位维度: "+_treeNodeName.substring(0,14) + "..." ;	
			}else if(select == "2"){
				document.getElementById("showName").innerHTML = "组织维度：  "+_treeNodeName.substring(0,14) + "..." ;
			}
		}else if(_treeNodeName.length <= 10){
			if(select == "0"){
				document.getElementById("showName").innerHTML = "流程维度： "+ _treeNodeName ;
			}else if(select == "1"){
				document.getElementById("showName").innerHTML = "岗位维度: "+ _treeNodeName ;	
			}else if(select == "2"){
				document.getElementById("showName").innerHTML = "组织维度：  "+ _treeNodeName ;
			}
		}
	}
	
}

onload = function(){
	showName.onmouseover = function(){
        this.title = _treeNodeName;
    }
}


/*$(document).ready(
		function(){

            /!*setTimeout(function(){
                $("#analyze_button_set").click();
            }, 200);*!/
            }

);*/
	$(function() {
		var temp = new Date();
		document.getElementById("showHyberTime").innerHTML = "<h5>" + "流程维度  " + "日期从" + temp.getFullYear() + 
		 "年1月1日到" + temp.getFullYear() + "年12月31日" + "</h5>";

		$("#myTabContent").css('height', $(document).innerHeight() - 41);
		
		setTimeout(function() {
			var url = "avicit/platform6/flowMonitoring/bpaDataAnalyze/jsp/throughput.jsp?select="
				+ select;
			$(      '<iframe id="iframe1" name="iframe1" src="'
				+ url
				+ '" scrolling="yes" style="width: 100%;height: 100%; border: 0;"></iframe>')
				.appendTo($('#throughput'));
		}, 10);
		var url1 = "avicit/platform6/flowMonitoring/bpaDataAnalyze/jsp/throughput.jsp?select=" + select;
		var url2 = "avicit/platform6/flowMonitoring/bpaDataAnalyze/jsp/efficiency.jsp?select=" + select;
		var url3 = "avicit/platform6/flowMonitoring/bpaDataAnalyze/jsp/ranking.jsp?select=" + select;
	    var ifrm = {
			'iframe1' : url1,
			'iframe2' : url2,
			'iframe3' : url3
		};
		$('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
			if (!$('#' + e.target.rel).attr('src')) {
				$('#' + e.target.rel).attr('src', ifrm[e.target.rel]);
			} else {
				if (window.frames[e.target.rel].bpm_operator_refresh) {
					window.frames[e.target.rel].bpm_operator_refresh();
				}
				$('#' + e.target.rel).attr('src', ifrm[e.target.rel]);
			}

		});
		$("#analyze_button_set").on("click",function() {
			var addIndex = layer.open({
										type : 2,
										offset : ['50px'],
										area : [ '38%', '85%' ],
										title : '维度参数设置',
										maxmin : false, //开启最大化最小化按钮
										content : 'avicit/platform6/flowMonitoring/bpaDataAnalyze/jsp/filter.jsp',
										btn : [ '确定', '关闭' ],
										yes : function(index) {
										    //debugger;
											var res = window["layui-layer-iframe"
												+ index].callbackdata();
											_treeNodeId = window["layui-layer-iframe"
												+ index].callbackdata1();
											_treeNodeName = window["layui-layer-iframe"
												+ index].callbackdata2();
											data = window["layui-layer-iframe"
												+ index].callbackdata3();
											choose = window["layui-layer-iframe"
												+ index].callbackdata4();
											parentId = _treeNodeId;
											parentName = _treeNodeName;
											parentChoose = choose;
											parentData = data;
											parentRes = res;
											select = res;
											var resLIst = res.split(",");
											parentRes = resLIst[0];
											select = resLIst[0];
											selectedTime = resLIst[1]+","+resLIst[2];  // 这个参数由链接传递
											res = select;
											showTimeOnTopRight(select,resLIst[1],resLIst[2]);
											showNameOnTop(select, _treeNodeName);
											// 将维度选择传给三个页面
											//console.log("url中的select值是："+select);
											url1 = "avicit/platform6/flowMonitoring/bpaDataAnalyze/jsp/throughput.jsp?select="
												+ select ; // + "&selectedTime=" + selectedTime;
											url2 = "avicit/platform6/flowMonitoring/bpaDataAnalyze/jsp/efficiency.jsp?select="
												+ select ; // + "&selectedTime=" + selectedTime;
											url3 = "avicit/platform6/flowMonitoring/bpaDataAnalyze/jsp/ranking.jsp?select="
												+ select ; // + "&selectedTime=" + selectedTime;
											ifrm = {
												'iframe1' : url1,
												'iframe2' : url2,
												'iframe3' : url3
											};
											$("#iframe1")[0].contentWindow.throughput(res);
											//打印返回的值，看是否有我们想返回的值。
											//console.log(res);

											$('#iframe1').attr('src', url1);
											$('#iframe2').attr('src', url2);
											$('#iframe3').attr('src', url3);

                                            //最后关闭弹出层
                                            layer.close(index);
											/* $('#tab1').click(); */
										},
										cancel : function() {
											//右上角关闭回调
										}

									});

						});
		setTimeout(function () {
            //模拟点击按钮，弹出设置窗口
            $("#analyze_button_set").click();
        },500);
	})
</script>
</html>