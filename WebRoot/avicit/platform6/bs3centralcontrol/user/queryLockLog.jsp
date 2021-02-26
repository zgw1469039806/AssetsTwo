<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>查看日志</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">

</script>
</head>
<body>

<div class="panel panel-warning" >
	<div class="panel-heading">
	</div>
	<table class="form_commonTable">
				
			
				<tr>
					<th width="30%" style="word-break: break-all; word-warp: break-word;"><label for="">用户编号:</label></th>
					<td width="39%"> <span class="badge">${username}</span></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="">锁定次数:</label></th>
					<td width="39%"> <span class="badge">${lockSize}</span></td>
					
				</tr>
				
			</table>
</div>

<table id="jqGrid"></table>
<div id="jqGridPager"></div>
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/console/user/js/consoleUser.js" type="text/javascript"></script> 
<script type="text/javascript">
Date.prototype.format = function (format) {
     var o = {
         "M+": this.getMonth() + 1, //month 
         "d+": this.getDate(),    //day 
         "h+": this.getHours(),   //hour 
         "m+": this.getMinutes(), //minute 
         "s+": this.getSeconds(), //second 
         "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter 
         "S": this.getMilliseconds() //millisecond 
     };
     if (/(y+)/.test(format)) format = format.replace(RegExp.$1,
     (this.getFullYear() + "").substr(4 - RegExp.$1.length));
     for (var k in o) if (new RegExp("(" + k + ")").test(format))
         format = format.replace(RegExp.$1,
       RegExp.$1.length == 1 ? o[k] :
         ("00" + o[k]).substr(("" + o[k]).length));
     return format;
 };
 //对Date的扩展，将 Date 转化为指定格式的String 
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function(fmt) 
{ //author: meizz 
	  var o = {
		"M+" : this.getMonth() + 1, //月份 
		"d+" : this.getDate(), //日 
		"h+" : this.getHours(), //小时 
		"m+" : this.getMinutes(), //分 
		"s+" : this.getSeconds(), //秒 
		"q+" : Math.floor((this.getMonth() + 3) / 3), //季度 
		"S" : this.getMilliseconds()
	//毫秒 
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt; 
};
//格式化日期
function fmtDate(cellvalue){
	var newDate=new Date(cellvalue);
	return newDate.Format("yyyy-MM-dd hh:mm:ss"); 
};
$(document).ready(function () {
	
	var dataGridColModel =  [
      
 	  { label: '锁定IP', name: 'lockIp', width: 100,align:'center'}
      ,{ label: '锁定时间', name: 'lockDate', width: 200 ,align:'center',formatter:fmtDate}
      ,{ label: '锁定原因', name: 'lockContent', width: 200,align:'center'}
      
	];
	
	$('#jqGrid').jqGrid({
    	url: 'platform/console/user/'+'${id}'+'/getUserLockLog',
        mtype: 'POST',
        datatype: "json",
        colModel: dataGridColModel,
        height: document.documentElement.clientHeight-130,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 10	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, //
		multiselect: true,
		autowidth: true,
		hasColSet:false,
		hasTabExport:false,
		responsive:true,//开启自适应
        pager: "#jqGridPager"
    });
	
 	 $('.date-picker').datepicker({
		beforeShow: function () {
			setTimeout(function () {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
    });
	$('.time-picker').datetimepicker({
	 	oneLine:true,//单行显示时分秒
	 	closeText:'确定',//关闭按钮文案
	 	showButtonPanel:true,//是否展示功能按钮面板
	 	showSecond:false,//是否可以选择秒，默认否
	 	beforeShow: function(selectedDate) {
	 		if($('#'+selectedDate.id).val()==""){
	 			$(this).datetimepicker("setDate", new Date());
	 			$('#'+selectedDate.id).val('');
	 		}
	 		setTimeout(function () {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
	 	}
	});
    
  
});

</script>
</html>