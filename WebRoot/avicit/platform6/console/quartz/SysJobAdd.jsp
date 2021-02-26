<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.quartz.dto.Job"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
String importlibs = "common,form,table";
%>
<!DOCTYPE html>
<html>
<head>
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<!-- 属性 -->
	<div data-options="region:'north'" split="false" border="false" style="height:179px;">
		<form id="form" fit="true">
			<input type="hidden" name="status" value="S">
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="group">任务分组</label></th>
                	<td width="40%">
                	         <select id="group" name="group" title="" class="form-control input-sm"></select>
                	</td>
                	<th width="10%"><label for="name">任务名称</th>
                	<td>
                    	<input id="name" name="name" title="" class="form-control input-sm" type="text" />
                	</td>
                </tr>
                <tr>
                	<th><label for="type">任务类型</label></th>
                	<td><select id="type" name="type" title="" class="form-control input-sm" onChange="onChangeType();">
                	            <option value="">请选择</option>
                	            <option value="spring">SpringBean</option>
                	            <option value="clazz">Java类</option>
                	            <option value="quartzClazz">Quartz Job</option>
                	            <option value="sql">Sql语句</option>
                	            <option value="sp">存储过程</option>
								<option value="rest">Rest服务</option>
                	         </select>
                	</td>
                	<th><label for="cron">表达式</label></th>
                	<td>
                    	<input id="cron" name="cron" title="" class="form-control input-sm" type="text"  value="0/5 0/6 * ? * *" readonly="readonly"/>
                	</td>
                </tr>
                <tr>
                	<th><label for="typeRemark">类型说明</label></th>
                	<td class="input-readonly">
                    	<input id="typeRemark" name="" title="类型说明" class="form-control input-sm"  type="text" value="" readonly="readonly"/>
                	</td>
                	<th><label for="program">执行程序</label></th>
                	<td>
                    	<input id="program" name="program" title="" class="form-control input-sm"  type="text"  value="" />
                	</td>
                </tr>
                <tr>
                	<th><label for="description">描述</label></th>
                	<td colspan="3">
                    	<input id="description" name="description" title="描述" class="form-control input-sm" type="text"  value="" />
                	</td>
                </tr>
            </table>
		</form>
	</div>
	<div data-options="region:'center'" split="false"  border="false" >
		<ul id="myTab" class="nav nav-tabs">
			<li class="active">
				<a href="#home" data-toggle="tab">参数列表</a>
			</li>
			<li><a href="#excludedDate"  data-toggle="tab">排除日期</a></li>
	    </ul>
	    <!-- 参数列表 -->
	   <div id="myTabContent" class="tab-content">
		 <div class="tab-pane fade in active" id="home">
			<iframe frameborder="0" id="paramifr" src="avicit/platform6/console/quartz/SysJobVariablesManage.jsp" style="height:260px;width:100%;"></iframe>
		 </div>
		 <!-- 排除日期 -->
	    <div class="tab-pane fade" id="excludedDate">
	       <iframe frameborder="0" id="excludedDateifr" src="avicit/platform6/console/quartz/ExcludedDate.jsp?jobCalendarIds=${jobCalendarIds}" style="height:260px;width:100%;" ></iframe>
	      
		</div>
	  </div>
	</div>
	<div data-options="region:'south',border:false" style="height:60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
						title="保存" id="sysJob_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="sysJob_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
</body>
<script type="text/javascript">

/**
 * 改变任务类型时
 */
function onChangeType(){
	var newValue= $('#type').val();
	setTypeRemark(newValue);
	if(newValue == 'spring'){
		var insertIndex = layer.open({
			type : 2,
			area : [ '50%', '50%' ],
			title : '选择Bean和函数',
			skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
			maxmin : false, //开启最大化最小化按钮
			content : 'avicit/platform6/console/quartz/selectBean.jsp'
		});
		/**
		 * 关闭页面
		 */
		closeSelectBeanDialog = function(result) {
			$('#program').val(result);
			layer.close(insertIndex);
		};
	}
}

/**
 * 设置类型说明
 */
function setTypeRemark(type){
	var typeRemark = "";
	if(type == 'spring'){
		typeRemark = "注册在Spring中的Bean#方法名,例如springBeanId#methodName";
	}else if(type == 'clazz'){
		typeRemark = "类的全路径#方法,例如com.demo.test.Test#sayHello";
	}else if(type == 'quartzClazz'){
		typeRemark = "类的全路径并且该类继承自org.quart.Job接口,例如com.demo.test.Test";
	}else if(type == 'sql'){
		typeRemark = "SQL语句";
	}else if(type == 'sp'){
		typeRemark = "存储过程名称";
	}else if (type === 'rest'){
		typeRemark = "Rest服务编号#服务URL，例如main#/api/demo/Test/test";
	}
	$('#typeRemark').val(typeRemark);
}

/**
 * 格式化状态
 */
function formatterDataType(value, row, index){      
	var dataType = "";
	if(value == 'String'){
		dataType = "字符串";
	}else if(value == 'Integer'){
		dataType = "整型";
	}else if(value == 'Long'){
		dataType = "长整型";
	}else if(value == 'Float'){
		dataType = "浮点型";
	}else if(value == 'Date'){
		dataType = "日期类型";
	}
	return dataType;
}
function formatdataType(value){
	var dataType = "";
	if(value == "字符串"){
		dataType = "String";
	}else if(value == '整型'){
		dataType = "Integer";
	}else if(value == '长整型'){
		dataType = "Long";
	}else if(value == '浮点型'){
		dataType = "Float";
	}else if(value == '日期类型'){
		dataType = "Date";
	}
	return dataType;
}
/**
 * 打开表达式页面
 */
function openSelectCron(){
	var confIndex = layer.open({
		type : 2,
		area : [ '50%', '100%' ],
		title : '选择执行时间',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : 'avicit/platform6/console/quartz/cronGenerator.jsp'
	});
	/**
	 * 获取表达式(名称固定)
	 */
	getCronExpr = function(cronExpr) {
		return $('#cron').val();
	}; 
	
	/**
	 * 成功后调用
	 */
	doSelectCronSuccess = function(cronExpr) {
		$('#cron').val(cronExpr);
		layer.close(confIndex);
	};
	closeDialog=function(){
		layer.close(confIndex);
	};
}
//关闭添加弹窗
function closeForm(){
	parent.sysJob.closeDialog("insert");
}
$(document).ready(function () {
	$.ajax({  
         url: "console/quartz/operation/loadGroups.json",  
         dataType: "json",  
         success: function (data) {  
             $.each(data, function (index, units) {  
                 $("#group").append("<option value="+units.name+">" + units.description + "</option>");  
             });  
         },  

         error: function (XMLHttpRequest, textStatus, errorThrown) {  
        	 layer.alert(errorThrown, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0,
					btn: ['关闭'],
					title:"提示"
			 });
         }  
     });  
	parent.sysJob.formValidate($('#form'));
	//保存按钮绑定事件
	$('#sysJob_saveForm').bind('click', function(){
		addJob();
	}); 
	//返回按钮绑定事件
	$('#sysJob_closeForm').bind('click', function(){
		closeForm();
	});
	$('#cron').bind('click',function(){
		$(this).blur();
		openSelectCron();
	});
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        // 获取已激活的标签页的名称
        var activeTab = $(e.target).text();
        if(activeTab=='排除日期'){
            $("#excludedDateifr").attr("src","avicit/platform6/console/quartz/ExcludedDate.jsp?jobCalendarIds=${jobCalendarIds}");
         }
    });
});

/**
 * 是否指定的日期格式,yyyyMMdd
 */
function isDate(dateString){
    if(dateString == ""){
    	return false;
    }
    var pattern = /^[1-9]\d{3}((0[1-9]{1})|(1[0-2]{1}))((0[1-9]{1})|([1-2]{1}\d{1})|(3[0-1]{1}))$/;
    if(!pattern.test(dateString)){
        return false;
    }
    return true;
 } 

/**
 * 添加定时任务
 */
function addJob(){
	//form验证
	var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }
	//获取基本信息
	var job = JSON.stringify(serializeObject($('#form')));
	
	//参数列表验证
	var obj = document.getElementById("paramifr").contentWindow;  
    var ifmObj = obj.document.getElementById("sysJobVariablesjqGrid");  
	$(ifmObj).jqGrid('endEditCell');
	//var variables = $(ifmObj).jqGrid('getChangedCells');
	var variables = $(ifmObj).jqGrid('getRowData');
	if(variables.length > 0){
		for(var i = 0; i < variables.length; i++){
		    variables[i].id = "";
			var name = $.trim(variables[i].name);
			var dataType = formatdataType(variables[i].dataTypeName);
			variables[i].dataType = dataType;
			var value = $.trim(variables[i].value);
			
			if (name == "" || dataType == "" || value == "") {
				layer.alert('参数名称、类型和值不能为空，请检查。', {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0,
					btn: ['关闭'],
					title:"提示"
				});
	            return false;
			}
			
			if(value != null && value != "" && value.replace(/[^\x00-\xff]/g, "**").length > 100){
				layer.alert('参数值超过长度！', {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0,
					btn: ['关闭'],
					title:"提示"
				});
				return false;
			}
			if (dataType == "Long" || dataType == "Integer") {
				if (isNaN(value) || String(parseInt(value)).length != value.length) {
		            layer.alert('参数类型指定为整型或长整型，参数值不匹配，请检查。', {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0,
						btn: ['关闭'],
						title:"提示"
					});
		            return false;
		        } 
			}else if(dataType == "Float"){
				if (isNaN(value) || String(parseFloat(value)).length != value.length) {
		            layer.alert('参数类型指定为浮点型，参数值不匹配，请检查。', {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0,
						btn: ['关闭'],
						title:"提示"
					});
		            return false;
	            } 
			}else if(dataType == "Date"){
				if (isDate(value) == false) {
	                layer.alert('参数类型指定为日期类型，参数值不匹配，请检查。日期格式为yyyyMMdd。', {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0,
						btn: ['关闭'],
						title:"提示"
					});
		            return false;
	            } 
			}
		}
	}
	//获取排除日历ID
	var objx = document.getElementById("excludedDateifr").contentWindow;  
    var ExcludedCalendarObj = objx.document.getElementById("sysJobExcludedCalendar"); 
	var calendarChecked = $(ExcludedCalendarObj).jqGrid('getGridParam', 'selarrrow');
	var idArray = new Array();
	if(calendarChecked.length > 0){
		for (var i = 0; i < calendarChecked.length; i++){
			idArray.push(calendarChecked[i]);
		}
	}
	//组合成参数
	var param = {
		"job": job,
		"jobCalendarIds": idArray.join(','),
		"variables": JSON.stringify(variables)
	};
	$.ajax({
		url : 'console/quartz/operation/save',
		data : param,
		type : 'post',
		dataType : 'json',
		success : function(result) {
			if (result.flag == 'success') {
				parent.sysJob.reLoad();
				parent.sysJob.tip('添加成功！');

				closeForm();
			} else {
				if(result.error){
					layer.alert('添加定时任务失败！ '+ result.error, {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0,
						btn: ['关闭'],
						title:"提示"
					});
				}else{
					layer.alert('添加定时任务失败！ ', {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0,
						btn: ['关闭'],
						title:"提示"
					}); 
				}
			}
		}
	});
}
</script>
</html>