<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<% 
String importlibs = "common,tree,table,form";	
String a = session.getAttribute("index").toString();
%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type"  content="text/html; charset=UTF-8">
<title>维度参数设置</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/flowMonitoring/bpaDataAnalyze/css/analyze.css">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<link rel="stylesheet" href="avicit/platform6/bpmreform/bpmdeploy/css/style.css"/>
<style type="text/css">
.ui-datepicker { z-index:2 !important}
.ztree li span.button.ico_docu:before {
    opacity: 0;
    content: "\e677";
}
.ztree li span.button.ico_open:before {
    opacity: 0;
    content: "\e678";
}
.ztree li span.button.ico_close:before {
    opacity: 0;
    content: "\e676";
}
.fmt_opt{
		min-width: 8px;

	}
	.jqgrow td a {
		color:#fff;
	}
	
	
.icon-edit {
    background: rgba(0, 0, 0, 0) url('avicit/platform6/console/org/images/iconselectors.gif') no-repeat scroll -200px 0;
}
.datepicker('setDate', new Date());
</style>
</head>
<body>
	<div id="dimensionality" class="dimensionality">
		<div id="dimensionality_div" class="dimensionality_div"></div>
		<div id="dimensionalityText" class="text" style="visibility: visible;">
			<p>
				<span class="font">分析维度：</span>
			</p>
		</div>
		<input id="processSelect" type="radio" value="radio" name="维度radio_group" checked />
		<div id="process" class="process radio_button">
			<label for="processLabel">
				<div id="processText" class="text" style="visibility: visible;width: 40px;">
					<p>
						<span>流程</span>
					</p>
				</div>
			</label>
		</div>

		<input id="jobsSelect" type="radio" value="radio" name="维度radio_group"  />
		<div id="jobs" class="jobs radio_button">
			<label for="jobsLabel">
				<div id="jobsText" class="text" style="visibility: visible;width: 40px;">
					<p>
						<span>岗位</span>
					</p>
				</div>
			</label>
		</div>

		<input id="organizationSelect" type="radio" value="radio"
			name="维度radio_group" />
		<div id="organization" class="organization radio_button">
			<label for="organizationLabel">
				<div id="organizationText" class="text" style="visibility: visible;width: 40px;">
					<p>
						<span>组织</span>
					</p>
				</div>
			</label>
		</div>
	</div>
	<div id="time" class="time">
		<div id="time_div" class=""></div>
		<div id="timeText" class="text" style="visibility: visible;">
			<p>
				<span class="time">时间范围：</span>
			</p>
		</div>
		<div id="scope" class="now_year" data-label="时间范围">
			<div class="layui-input-block">
				<select name="interest" lay-filter="aihao" id="selectSearch" title="时间段" >
					<optgroup label="年">
						<option value="nowYear" id="nowYear" selected>当前年度</option>
						<option value="lastYear" id="lastYear">上一年度</option>
						<option value="nowLastYear" id="nowLastYear">从当前日期到上一年度</option>
					</optgroup>
					<optgroup label="季">
						<option value="nowQuarter" id="nowQuarter">当前季度</option>
						<option value="lastQuarter" id="lastQuarter">上一季度</option>
						<option value="nowLastQuarter" id="nowLastQuarter">从年初到当前季度末</option>
						<option value="firstQuarter" id="firstQuarter">今年第一季度</option>
						<option value="secondQuarter" id="secondQuarter">今年第二季度</option>
						<option value="thirdQuarter" id="thirdQuarter">今年第三季度</option>
						<option value="fourthQuarter" id="fourthQuarter">今年第四季度</option>
					</optgroup>
					<optgroup label="月">
						<option value="nowMouth" id="nowMouth">当前月份</option>
						<option value="lastMouth" id="lastMouth">上一月份</option>
						<option value="nowLastMouth" id="nowLastMouth">从当前日期到上一月份</option>
						<option value="january" id="january ">今年一月份</option>
						<option value="february" id="february">今年二月份</option>
						<option value="march" id="march">今年三月份</option>
						<option value="april" id="april">今年四月份</option>
						<option value="may" id="may">今年五月份</option>
						<option value="june" id="june">今年六月份</option>
						<option value="july" id="july">今年七月份</option>
						<option value="august" id="august">今年八月份</option>
						<option value="september" id="september">今年九月份</option>
						<option value="october" id="october">今年十月份</option>
						<option value="november" id="november">今年十一月份</option>
						<option value="december" id="december">今年十二月份</option>
					</optgroup>
				</select>
			</div>
		</div>
		</label> <input id="customSelect" type="checkbox" value="checkbox" />
		<div id="custom" class="custom">
			<label for="customLabel">
				<div id="customText" class="text" style="visibility: visible;width: 48px;">
					<p>
						<span>自定义</span>
					</p>
				</div>
		</div>
	</div>
	<div id="scope_state1" class="panel_state" data-label="input"
		style="display: none">
		<div id="scope_state1_content" class="panel_state_content">
			<div id="from" class="from">
				<div id="from_div" class=""></div>
				<div id="fromText" class="text" style="visibility: visible;">
					<p>
						<span class="cong">从</span>
					</p>
				</div>
			</div>

			<div id="fromReach" class="reach">
					<input class="form-control date-picker" type="text" name="fromReach_input" id="fromReach_input" />
			</div>
			<div id="reach" class="ax_default">
				<div id="reach_div" class=""></div>
				<div id="reachText" class="text" style="visibility: visible;">
						<span class="dao">到</span>
				</div>
			</div>
			<div id="reachInput" class="input">
				<input class="form-control date-picker" type="text" name="reachInput_input" id="reachInput_input" />
			</div>
		</div>
	</div>
	<div id="treeSelect" class="treeSelect">
		<div id="choosed" class="choosed" style="visibility: visible;">
			<p>
				<span class="choosed">选择分析：</span>
			</p>
		</div>
		
		<input id="allSelect" type="radio" value="radio" name="全部radio_group" checked />
		<div id="all" class="all radio_button">
				<label for="allLabel">
					<div id="allText" class="text" style="visibility: visible;">
						<p>
							<span>全部</span>
						</p>
					</div>
				</label>
		</div>
		
		<input id="partSelect" type="radio" value="radio" name="全部radio_group"  />
		<div id="part" class="part radio_button">
				<label for="partLabel">
					<div id="partText" class="text" style="visibility: visible;">
						<p>
							<span>选择</span>
						</p>
					</div>
				</label>
		</div>
	</div>
	<div id="box" class="boxed" style='height:62%;'>
		<div id="box_div" class="" style='OVERFLOW: auto;'>
			<div id="boxHide" style="height:100%;width:100%">
        		<ul id="flowTypeTreeUL" class="ztree" style="height: 100%"></ul>
			</div>
			<div id="boxHidden"  style="display:none; height:100%;width:100%">
				<ul id="positiontree" class="ztree" style="height: 100%"></ul>
			</div>
			<div id="boxHidden_div"  style="display:none;height:100%;width:100%">
				<ul id="orgtree" class="ztree" style="height: 100%"></ul>
			</div>
		</div>
	</div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/platform6/flowMonitoring/bpaDataAnalyze/js/OrgTree.js" ></script>
<script type="text/javascript" src="avicit/platform6/flowMonitoring/bpaDataAnalyze/js/ShareTypeTree.js"></script>
<script type="text/javascript" src="avicit/platform6/flowMonitoring/bpaDataAnalyze/js/PositionTree.js"></script>
<script type="text/javascript">
    //回传
	var select = window.parent.parentRes;
	var sonData = window.parent.parentData;
	var sonChoose = window.parent.parentChoose;
	var sonId = window.parent.parentId;
	var sonName = window.parent.parentName;
	//树列表
	var orgtree;
	var shareTypeTree;
	var zTreeObj;
	var data;
	var choose;
	var _positionids = null;
	var _positionNames = null;
	var _flowids = null;
	var _flowNames = null;
	var _orgids = null;
	var _orgNames = null;
	var data = null;
	var zNodes;
	var startTime=(new Date(new Date().getFullYear(),0,1)).getTime();
	var endTime=(new Date(new Date().getFullYear(),11,31)).getTime();
	
    if(sonChoose == null){
	 window.onload=function(){
		 function all() {
			 choose = 3;
		 }
	     var button = document.getElementById('allSelect');
		 button.click = all(); 
         if(choose == 3){
        	 $("#box").hide();
         }else{
        	 $("#box").show();
         }
	   }
    }
	//岗位树取ID及名称
	function onCheck(e,treeId,treeNode){
        var treeObj=$.fn.zTree.getZTreeObj("positiontree"); nodes=treeObj.getCheckedNodes(true); positionids=""; positionNames="";
        for(var i=0;i<nodes.length;i++){
            if(i == nodes.length-1){
            	positionids+=nodes[i].id;//id字符串拼接
                positionNames += nodes[i].name;
            }else{
            	positionids+=nodes[i].id + ",";
                positionNames += nodes[i].name+ ",";
            }
        }
        _positionids = positionids;
        _positionNames = positionNames;
    }
	//流程树取ID及名称
	function onCheck1(e,treeId,treeNode){
        var treeObj=$.fn.zTree.getZTreeObj("flowTypeTreeUL"); nodes=treeObj.getCheckedNodes(true); flowids=""; flowNames="";
        for(var i=0;i<nodes.length;i++){
			if(nodes[i].nodeType == "process"){
				flowids+=nodes[i].id + ","; // id字符串拼接
				flowNames += nodes[i].name + ",";
			}
        }
        if(flowids.length!=0){ _flowids = flowids.substring(0,flowids.length-1); }
		if(flowNames.length!=0){ _flowNames = flowNames.substring(0,flowNames.length-1); }
    }
	//组织树取ID及名称
	function onCheck2(e,treeId,treeNode){
        var treeObj=$.fn.zTree.getZTreeObj("orgtree"); nodes=treeObj.getCheckedNodes(true); orgids=""; orgNames="";
        for(var i=0;i<nodes.length;i++){
			if(nodes[i].nodeType == "dept"){
            	orgids+=nodes[i].id + ",";  //  id字符串拼接
            	orgNames += nodes[i].text+ ",";
           }
        }
        if(orgids.length!=0){ _orgids = orgids.substring(0,orgids.length-1); }
		if(orgNames.length!=0){ _orgNames = orgNames.substring(0,orgNames.length-1); }
    }
	
	var setting = {
			callback: {
				onCheck:onCheck
			}, 
			view: {
				selectedMulti: false,
				showIcon: false
			},
			check: {
				  enable: true,
				  chkStyle: "checkbox",
				  chkboxType: { "Y": "s", "N": "ps" }

            },
            data: {
                simpleData: {
                    enable: true
                }
            }
	};
	
	//时间算法
	$('#selectSearch').on('change', function() {

	    //记录选择的时间信息
		var d1 = $("#selectSearch option:selected").val();
		var d2 =$("#selectSearch option:selected").text();
        //var checkIndex=$("#selectSearch ").get(0).selectedIndex;  //获取Select选择的索引值
		
		// var myDate = new Date();
		var myDate = null;
		data = this.value;
		// 获取服务器的值
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getServerCurrentDate", 
			type: "post",
			async: false,
			cache: false,
			dataType: "json",
			success : function(ret) {
				myDate = new Date(ret);
			},
			error : function() {
				myDate = new Date();
				layer.msg('无法获取服务器时间,取网页时间');
			},
		});

		if(data == "nowYear"){                                    //当前年度
			 a = myDate.getFullYear();
			 b = myDate.getMonth();       
			 c = myDate.getDate();    
			 e = myDate.getHours();                      
			 f = myDate.getMinutes();                   
			 g = myDate.getSeconds();                   
			 layer.msg("选择的时间为：" + a + "年" );
			 var time1 = new Date(a,0,1);
	         var time2 = new Date(a,b,c,e,f,g);
	         startTime =  time1.getTime();
	         endTime = time2.getTime();
		}else if(data == "lastYear"){                             //上一年度
		     a = myDate.getFullYear()-1;
			 layer.msg("选择的时间为：" + a + "年" );
			 var time1 = new Date(a,0,1);
	         var time2 = new Date(a,11,31,23,59,59);
	         startTime =  time1.getTime();
	         endTime = time2.getTime();
		}else if(data == "nowLastYear"){                          //从当前日期到上一年度  
			 a = myDate.getFullYear();
			 b = myDate.getMonth()+1;       
			 c = myDate.getDate();          
			 d = a-1;
			 e = myDate.getHours();                      
			 f = myDate.getMinutes();                   
			 g = myDate.getSeconds();    
			 layer.msg("选择的时间为：" + d + "年" + "1月1日"+ "~" + a + "年" + b + "月" + c + "日");
			 var time1 = new Date(d,0,1);
	         var time2 = new Date(a,b-1,c,e,f,g);
	         startTime =  time1.getTime();
	         endTime = time2.getTime();
		}else if(data == "nowQuarter"){    					      //当前季度
			 a = myDate.getFullYear();
			 b = myDate.getMonth()+1;   
			 c = myDate.getDate();    
			 e = myDate.getHours();                      
			 f = myDate.getMinutes();                   
			 g = myDate.getSeconds();     
			 if(b == "1" || b== "2" || b == "3"){
					 layer.msg("选择时间为当前季度："  + a + "年" + "1月1日"+ "~" + a + "年" + b + "月" + c + "日" );
					 var time1 = new Date(a,0,1);
			         var time2 = new Date(a,b-1,c,e,f,g);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			 }else if(b == "4" || b== "5" || b == "6"){
					 layer.msg("选择时间为当前季度："  + a + "年" + "4月1日"+ "~" + a + "年" + b + "月" + c + "日" );
					 var time1 = new Date(a,3,1);
			         var time2 = new Date(a,b-1,c,e,f,g);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			 }else if(b == "7" || b== "8" || b == "9"){
					 layer.msg("选择时间为当前季度："  + a + "年" + "7月1日"+ "~" + a + "年"  + b + "月" + c + "日" );
					 var time1 = new Date(a,6,1);
			         var time2 = new Date(a,b-1,c,e,f,g);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			 }else if(b == "10" || b== "11" || b == "12"){
					 layer.msg("选择时间为当前季度："  + a + "年" + "10月1日"+ "~" + a + "年" + b + "月" + c + "日");
					 var time1 = new Date(a,9,1);
			         var time2 = new Date(a,b-1,c,e,f,g);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			 }
		}else if(data == "lastQuarter"){					     //上一季度
			 a = myDate.getFullYear();
			 b = myDate.getMonth()+1;
			 x = a-1;
			 if(b == "1" || b== "2" || b == "3"){
					 layer.msg("选择的时间为："  + x + "年" + "10月1日"+ "~" + x + "年" + "12月31日");
					 var time1 = new Date(x,9,1);
			         var time2 = new Date(x,11,31,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			 }else if(b == "4" || b== "5" || b == "6"){
					 layer.msg("选择的时间为："  + a + "年" + "1月1日"+ "~" + a + "年" + "3月31日"  );
					 var time1 = new Date(a,0,1);
			         var time2 = new Date(a,2,31,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			 }else if(b == "7" || b== "8" || b == "9"){
					 layer.msg("选择的时间为："  + a + "年" + "4月1日"+ "~" + a + "年" + "6月30日"  );
					 var time1 = new Date(a,3,1);
			         var time2 = new Date(a,5,30,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			 }else if(b == "10" || b== "11" || b == "12"){
					 layer.msg("选择的时间为："  + a + "年" + "7月1日"+ "~" + a + "年" + "9月30日"  );
					 var time1 = new Date(a,6,1);
			         var time2 = new Date(a,8,30,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			 }
		}else if(data == "nowLastQuarter"){    					//从年初到当前季度末
			 a = myDate.getFullYear();
			 b = myDate.getMonth()+1;   
			 c = myDate.getDate();    
			 e = myDate.getHours();                      
			 f = myDate.getMinutes();                   
			 g = myDate.getSeconds(); 
			 if(b == "1" || b== "2" || b == "3"){
					 layer.msg("选择的时间为："  + a + "年" + "1月1日"+ "~" + a + "年" + "3月31日"  );
					 var time1 = new Date(a,0,1);
			         var time2 = new Date(a,b-1,c,e,f,g);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			 }else if(b == "4" || b== "5" || b == "6"){
					 layer.msg("选择的时间为："  + a + "年" + "1月1日"+ "~" + a + "年" + "6月30日"  );
					 var time1 = new Date(a,0,1);
			         var time2 = new Date(a,b-1,c,e,f,g);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			 }else if(b == "7" || b== "8" || b == "9"){
					 layer.msg("选择的时间为："  + a + "年" + "1月1日"+ "~" + a + "年" + "9月30日"  );
					 var time1 = new Date(a,0,1);
			         var time2 = new Date(a,b-1,c,e,f,g);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			 }else if(b == "10" || b== "11" || b == "12"){
					 layer.msg("选择的时间为："  + a + "年" + "1月1日"+ "~" + a + "年" + "12月31日" );
					 var time1 = new Date(a,0,1);
			         var time2 = new Date(a,b-1,c,e,f,g);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			 }
		}else if(data == "firstQuarter"){    					//第一季度
				 	 a = myDate.getFullYear();
					 layer.msg("选择的时间为："  + a + "年" + "1月1日"+ "~" + a + "年" + "3月31日"  );
					 var time1 = new Date(a,0,1);
			         var time2 = new Date(a,2,31,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
		}else if(data == "secondQuarter"){    					//第二季度
				 a = myDate.getFullYear();
				 b = myDate.getMonth()+1;  
				 if(b < 4){
					 layer.msg("选择的时间超出本年度时间范围");
					 return false;
				 }else{
				     layer.msg("选择的时间为："  + a + "年" + "4月1日"+ "~" + a + "年" + "6月30日"  );
				     var time1 = new Date(a,3,1);
			         var time2 = new Date(a,5,30,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
				 }
		}else if(data == "thirdQuarter"){    					//第三季度
				 a = myDate.getFullYear();
				 b = myDate.getMonth()+1;  
				 if(b < 7){
					 layer.msg("选择的时间超出本年度时间范围");
					 return false;
				 }else{
					 layer.msg("选择的时间为："  + a + "年" + "7月1日"+ "~" + a + "年" + "9月30日"  );
					 var time1 = new Date(a,6,1);
			         var time2 = new Date(a,8,30,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
				 }
		}else if(data == "fourthQuarter"){    					//第四季度
				 a = myDate.getFullYear();
				 b = myDate.getMonth()+1;  
				 if(b < 10){
					 layer.msg("选择的时间超出本年度时间范围");
					 return false;
				 }else{
					 layer.msg("选择的时间为："  + a + "年" + "10月1日"+ "~" + a + "年" + "12月31日");
					 var time1 = new Date(a,9,1);
			         var time2 = new Date(a,11,31,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
				 }
		}else if(data == "nowMouth"){                        	//当前月份
				 a = myDate.getFullYear();
				 b = myDate.getMonth()+1;
				 c = myDate.getDate();    
				 e = myDate.getHours();                      
				 f = myDate.getMinutes();                   
				 g = myDate.getSeconds(); 
				 layer.msg("选择的时间为：" + a + "年" + b + "月");
				 var time1 = new Date(a,b-1);
		         var time2 = new Date(a,b-1,c,e,f,g);
		         startTime =  time1.getTime();
		         endTime = time2.getTime();
		}else if(data == "lastMouth"){                        	//上一月份
				 a = myDate.getFullYear();
				 b = myDate.getMonth()+1;  
		         c = a-1;
		         d = b-1;
			if(b == "1"){
				 layer.msg("选择的时间为：" + c + "年" + "12月");
					 var time1 = new Date(c,11);
			         var time2 = new Date(c,11,31,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			}else if(b == "2" || b== "4" || b == "6" || b == "9" || b == "11"){
				     layer.msg("选择的时间为：" + a + "年" + d + "月");
				     var time1 = new Date(a,d-1);
			         var time2 = new Date(a,d-1,31,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			}else if(b == "5" || b== "7" || b == "10" || b == "12"){
			     layer.msg("选择的时间为：" + a + "年" + d + "月");
			     var time1 = new Date(a,d-1);
		         var time2 = new Date(a,d-1,30,23,59,59);
		         startTime =  time1.getTime();
		         endTime = time2.getTime();
			}else if(b == "3"){
			     layer.msg("选择的时间为：" + a + "年" + d + "月");
			     var time1 = new Date(a,d-1);
		         var time2 = new Date(a,d-1,27,23,59,59);
		         startTime =  time1.getTime();
		         endTime = time2.getTime();
			}else if(b == "8"){
			     layer.msg("选择的时间为：" + a + "年" + d + "月");
			     var time1 = new Date(a,d-1);
		         var time2 = new Date(a,d-1,31,23,59,59);
		         startTime =  time1.getTime();
		         endTime = time2.getTime();
			}
	    }else if(data == "nowLastMouth"){                       //从当前日期到上一月份
				 a = myDate.getFullYear();
				 b = myDate.getMonth()+1;  
		         h = a-1;
		         d = b-1;
		         c = myDate.getDate();  
		         e = myDate.getHours();                      
				 f = myDate.getMinutes();                   
				 g = myDate.getSeconds(); 
			if(b == "1"){
					 layer.msg("选择的时间为：" + h + "年" + "12月" + "~" + a + "年" + b + "月" + c + "日");
					 var time1 = new Date(h,11);
			         var time2 = new Date(a,b-1,c,e,f,g);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			}else{
					 layer.msg("选择的时间为：" + a + "年" + d + "月" + "~" + a + "年" + b + "月" + c + "日");
					 var time1 = new Date(a,d-1);
			         var time2 = new Date(a,b-1,c,e,f,g);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
			}
       }else if(data == "january"){							//今年一月份
	        		 a = myDate.getFullYear();
	        		 layer.msg("选择的时间为：" + a + "年" + "1月");
	        		 var time1 = new Date(a,0);
			         var time2 = new Date(a,0,31,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
       }else if(data == "february"){							//今年二月份
   		     a = myDate.getFullYear();
   		     b = myDate.getMonth()+1; 
   		if(b >= "2"){
	    			 layer.msg("选择的时间为：" + a + "年" + "2月");
	    			 var time1 = new Date(a,1);
			         var time2 = new Date(a,1,27,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
   		}else{ 
   			 	 layer.msg("选择的时间超出本年度时间范围");
   		}
       }else if(data == "march"){								//今年三月份
			     a = myDate.getFullYear();
			     b = myDate.getMonth()+1; 
			if(b >= "3"){
				     layer.msg("选择的时间为：" + a + "年" + "3月");
				     var time1 = new Date(a,2);
			         var time2 = new Date(a,2,31,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
		 }else{
			     layer.msg("还未到达三月");
		    }
       }else if(data == "april"){							    //今年四月份
			     a = myDate.getFullYear();
			     b = myDate.getMonth()+1; 
		    if(b >= "4"){
			     	 layer.msg("选择的时间为：" + a + "年" + "4月");
			     	 var time1 = new Date(a,3);
			         var time2 = new Date(a,3,30,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
	     }else{
		     	 layer.msg("还未到达四月");
	        }
       }else if(data == "may"){								//今年五月份
		     	 a = myDate.getFullYear();
		     	 b = myDate.getMonth()+1; 
	        if(b >= "5"){
		     	 	 layer.msg("选择的时间为：" + a + "年" + "5月");
		     	 	 var time1 = new Date(a,4);
			         var time2 = new Date(a,4,31,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
   	 }else{
	     	 	 layer.msg("还未到达五月");
           }
    	}else if(data == "june"){								//今年六月份
	     	 	 a = myDate.getFullYear();
	     		 b = myDate.getMonth()+1; 
       	if(b >= "6"){
	     	 	 	 layer.msg("选择的时间为：" + a + "年" + "6月");
	     	 	 	 var time1 = new Date(a,5);
			         var time2 = new Date(a,5,30,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
	     }else{
    	 	 	 layer.msg("还未到达六月");
       	}
	    }else if(data == "july"){								//今年七月份
    	 	 	 a = myDate.getFullYear();
    			 b = myDate.getMonth()+1; 
   		if(b >= "7"){
	 	 	 	 	 layer.msg("选择的时间为：" + a + "年" + "7月");
	 	 	 	 	 var time1 = new Date(a,6);
			         var time2 = new Date(a,6,31,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
    	 }else{
	 	 		 layer.msg("还未到达七月");
   		}
	    }else if(data == "august"){								//今年八月份
	 	 	 	 a = myDate.getFullYear();
			 	 b = myDate.getMonth()+1; 
			if(b >= "8"){
		 	 	 	 layer.msg("选择的时间为：" + a + "年" + "8月");
		 	 	 	 var time1 = new Date(a,7);
			         var time2 = new Date(a,7,31,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
	 	 }else{
	 	 		 layer.msg("还未到达八月");
			}
   	}else if(data == "september"){							//今年九月份
	 	 	 	 a = myDate.getFullYear();
			 	 b = myDate.getMonth()+1; 
			if(b >= "9"){
	 	 	 	 	 layer.msg("选择的时间为：" + a + "年" + "9月");
	 	 	 	 	 var time1 = new Date(a,8);
			         var time2 = new Date(a,8,30,23,59,59);
			         startTime =  time1.getTime();
			         endTime = time2.getTime();
	 	 }else{
	 		 	 layer.msg("还未到达九月");
			}
		}else if(data == "october"){							//今年十月份
	 	 	 	 a = myDate.getFullYear();
		 	 	 b = myDate.getMonth()+1; 
			if(b >= "10"){
	 	 	 	 layer.msg("选择的时间为：" + a + "年" + "10月");
	 	 	 	 var time1 = new Date(a,9);
		         var time2 = new Date(a,9,31,23,59,59);
		         startTime =  time1.getTime();
		         endTime = time2.getTime();
		 }else{
	 		 	 layer.msg("还未到达十月");
			}
		}else if(data == "november"){							//今年十一月份
	 	 		 a = myDate.getFullYear();
	 	 		 b = myDate.getMonth()+1; 
			if(b >= "10"){
	 	 		 layer.msg("选择的时间为：" + a + "年" + "11月");
	 	 		 var time1 = new Date(a,10);
		         var time2 = new Date(a,10,30,23,59,59);
		         startTime =  startTime.getTime();
		         endTime = endTime.getTime();
		 }else{
		 	 	 layer.msg("还未到达十一月");
			}
		}else if(data == "december"){							//今年十二月份
	 			 a = myDate.getFullYear();
	 			 b = myDate.getMonth()+1; 
			if(b >= "10"){
	 	 		 layer.msg("选择的时间为：" + a + "年" + "12月");
	 	 		 var time1 = new Date(a,11);
		         var time2 = new Date(a,11,31,23,59,59);
		         startTime =  time1.getTime();
		         endTime = time2.getTime();
		 }else{
		 	 	 layer.msg("还未到达十二月");
			}
		}
	})
	$(document).ready(function() {
		//组织树
		orgtree = new OrgTree('orgtree','console/dept');
	    orgtree.init();		
	    //流程树
        shareTypeTree = new ShareTypeTree("flowTypeTreeUL",null);  
	    //岗位树
	    $.post('bpm/monitor/getPositionTree',
			function(r) {
				$.each(r,function(i,item) {
						zNodes =r;
						zTreeObj = $.fn.zTree.init($("#positiontree"), setting, zNodes);
				});
		});
	    
		$("#customSelect").on('click', function() {
			if (this.checked == true) {
				$("#scope_state1").show();
				$("#scope").hide();
			} else {
				$("#scope_state1").hide();
				$("#scope").show();
			}
		});
		//时间
		$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
				beforeShow: function(selectedDate) {
					if($('#'+selectedDate.id).val()==""){
						$(this).datetimepicker("setDate", new Date().getTime());
						$('#'+selectedDate.id).val('');
					}
				}
			});
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
	    //父页面回传值
		if (select == "0") {
			$("#processSelect").attr("checked", true);
			$("#boxHide").show();
			$("#boxHidden").hide();
			$("#boxHidden_div").hide();
		} else if (select == "1") {
			$("#jobsSelect").attr("checked", true);
			$("#boxHidden").show();
			$("#boxHide").hide();
			$("#boxHidden_div").hide();
		} else if (select == "2") {
			$("#organizationSelect").attr("checked", true);
			$("#boxHidden_div").show();
			$("#boxHidden").hide();
			$("#boxHide").hide(); 
		}
	    
	    //时间回传
		if(sonData == "nowYear"){     
			$("#nowYear").attr("selected", true);//当前年度
		}else if(sonData == "lastYear"){        //上一年度
			$("#lastYear").attr("selected", true);
		}else if(sonData == "nowLastYear"){                          //从当前日期到上一年度  
			$("#nowLastYear").attr("selected", true);
		}else if(sonData == "nowQuarter"){  
			$("#nowQuarter").attr("selected", true);              //当前季度
		}else if(sonData == "lastQuarter"){		
			$("#lastQuarter").attr("selected", true);//上一季度
		}else if(sonData == "nowLastQuarter"){ 
			$("#nowLastQuarter").attr("selected", true);//从年初到当前季度末
		}else if(sonData == "firstQuarter"){    	
			$("#firstQuarter").attr("selected", true);//第一季度
		}else if(sonData == "secondQuarter"){    	
			$("#secondQuarter").attr("selected", true);//第二季度
		}else if(sonData == "thirdQuarter"){    	
			$("#thirdQuarter").attr("selected", true);//第三季度
		}else if(sonData == "fourthQuarter"){    	
			$("#fourthQuarter").attr("selected", true);//第四季度
		}else if(sonData == "nowMouth"){            
			$("#nowMouth").attr("selected", true);//当前月份
		}else if(sonData == "lastMouth"){           
			$("#lastMouth").attr("selected", true);//上一月份
	    }else if(sonData == "nowLastMouth"){        
	    	$("#nowLastMouth").attr("selected", true);//从当前日期到上一月份
	    }else if(sonData == "january"){				
	    	$("#january").attr("selected", true);//今年一月份
        }else if(sonData == "february"){			
        	$("#february").attr("selected", true);//今年二月份
        }else if(sonData == "march"){				
        	$("#march").attr("selected", true);//今年三月份
        }else if(sonData == "april"){				
        	$("#april").attr("selected", true);//今年四月份
        }else if(sonData == "may"){					
        	$("#may").attr("selected", true);//今年五月份
     	}else if(sonData == "june"){				
     		$("#june").attr("selected", true);//今年六月份
	    }else if(sonData == "july"){				
	    	$("#july").attr("selected", true);//今年七月份
	    }else if(sonData == "august"){				
	    	$("#august").attr("selected", true);//今年八月份
     	}else if(sonData == "september"){			
     		$("#september").attr("selected", true);//今年九月份
		}else if(sonData == "october"){				
			$("#october").attr("selected", true);//今年十月份
		}else if(sonData == "november"){			
			$("#november").attr("selected", true);//今年十一月份
		}else if(sonData == "december"){			
			$("#december").attr("selected", true);//今年十二月份
		}
		 //选择分析回传
	    if(sonChoose == "3"){
	    	$("#allSelect").attr("checked", true);
	    	$("#box").hide();
	    }else if(sonChoose == "4"){
	    	$("#partSelect").click();
	    	if (select == "0") {
	    		$("#sonId").attr("checked", true);
				$("#boxHide").show();
				$("#boxHidden").hide();
				$("#boxHidden_div").hide();
			} else if (select == "1") {
				$("#sonName").attr("checked", true);
				$("#boxHidden").show();
				$("#boxHide").hide();
				$("#boxHidden_div").hide();
			} else if (select == "2") {
				$("#sonId").attr("checked", true);
				$("#boxHidden_div").show();
				$("#boxHidden").hide();
				$("#boxHide").hide();
			}  
	    } 
		//点击赋值
		$("#processSelect").on('click', function() {
			select = 0;
			tree(select);
		})
		$("#jobsSelect").on('click', function() {
			select = 1;
			tree(select);
		})
		$("#organizationSelect").on('click', function() {
			select = 2;
			tree(select);
		})
		$("#allSelect").on('click', function() {
			choose = 3;
			$("#box").hide();
		})
		$("#partSelect").on('click', function() {
			choose = 4;
			$("#box").show();
		})
		
		
		
		/* function all(choose) {
			if (choose == "3") {
				$("#box").hide();
			} else {
				$("#box").show();
			} 
		} */
		
		function getDeptList(){
			var deptids = "";
			var deptnames = "";
			var orgIdentitys = ""
			
			var deptlist = h5KadsView.getDataList();
			for(var i = 0;  i< deptlist.length; i++ ){
				deptids = deptids + deptlist[i].id + ";";
				deptnames = deptnames + deptlist[i].name + ";";
				orgIdentitys = orgIdentitys + deptlist[i].orgIdentity+ ";";
			}
			deptids = deptids.substring(0, deptids.length-1);
			deptnames = deptnames.substring(0, deptnames.length-1);
			return {deptids: deptids, deptnames: deptnames , orgIdentitys: orgIdentitys};
		}
		function tree(select) {
			if (select == "0") {
				$("#boxHide").show();
				$("#boxHidden").hide();
				$("#boxHidden_div").hide();
			} else if (select == "1") {
				$("#boxHidden").show();
				$("#boxHide").hide();
				$("#boxHidden_div").hide();
			} else {
				$("#boxHidden_div").show();
				$("#boxHidden").hide();
				$("#boxHide").hide();
			}
		}
	})
	
	var callbackdata = function() {
		var reList='';
		reList += select;
		if(document.getElementById("customSelect").checked==false){
			reList += "," + startTime;
			reList += "," + endTime;
		}else{
			var dateBegin = (new Date($('#fromReach_input').val())).getTime();
			var dateEnd = (new Date($('#reachInput_input').val())).getTime();
			if(!dateBegin || dateEnd=="null" || !dateEnd || dateEnd=="null"){
				dateBegin = (new Date(new Date().getFullYear(),0,1)).getTime();
				dateEnd = (new Date(new Date().getFullYear(),11,31)).getTime();
			}
			reList += "," + dateBegin;
			reList += "," + dateEnd;
		}
		return reList;
	}
	var callbackdata1 = function() {
		if (select == "0") {
			return _flowids;
		} else if (select == "1") {
			return _positionids;
		} else if (select == "2"){
			return _orgids;
		} 
	}
	var callbackdata2 = function() {
		if (select == "0") {
			return _flowNames;
		} else if (select == "1") {
			return _positionNames;
		} else if (select == "2"){
			return _orgNames;
		}
	}
	var callbackdata3 = function() {
	    if(data != null){//新变更时间数据
		    return data;
	    }else if(sonData != null){//之前选择的时间数据
	        return sonData;
        }
	}
	var callbackdata4 = function() {
		return choose;
	}
</script>
</html>