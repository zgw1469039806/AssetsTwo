<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>日志审计信息</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>

</head>
<body class="easyui-layout" fit="true">
	<c:if test= "${m}">
		<div data-options="region:'west',split:true,title:'应用列表',collapsible:false" style="height:0; overflow:hidden; font-size:0;width:150px;">
			 	<div id="toolbarTree" class="datagrid-toolbar">
				 	<table width="100%">
				 		<tr>
				 			<td width="100%"><input type="text"  name="searchApp" id="searchApp"></input></td>
				 		</tr>
				 	</table>
		 	 	</div>
		 		<ul id="apps">正在加载应用列表...</ul>
	 	</div>
 	</c:if>
 	<div data-options="region:'center',split:true" style="padding:0px;">
      <div class="easyui-layout" data-options="fit:true">     	  
		<div id="toolbar" class="datagrid-toolbar" style="height:auto;display: none;">
			<table >
				<tr>
					<td><span>历史归档：</span><input id="sysLogArchived" class="easyui-combobox" name="sysLogArchived" style="width: 200px;" data-options="panelHeight:'auto', editable:false,valueField:'archiveTableName',textField:'archiveName'"/></td>
					<td>
						<a class="easyui-menubutton"  data-options="menu:'#export',iconCls:'icon-export'" href="javascript:void(0);">导出日志</a>
						<a id="btAchve" class="easyui-linkbutton" iconCls="icon-setting"  plain="true" onclick="archiveLog();" href="javascript:void(0);">归档日志</a>
						<a id="btSearch" class="easyui-linkbutton" iconCls="icon-search"  plain="true" onclick="showSearch();" href="javascript:void(0);">查询</a>
					</td>
					<td><span id='threshold' style="color: red;display: none;"></span></td>
				</tr>
			</table>
			<div id="export" style="width:150px;display: none;">
				<div data-options="iconCls:'icon-excel'" onclick="exportClientData();">Excel导出(客户端)</div>
				<div data-options="iconCls:'icon-excel'" onclick="showExportLog();">Excel导出(服务器端)</div>
			</div>
		</div>
		
	<div data-options="region:'center',split:true,title:''" style="height:0; overflow:hidden; font-size:0;padding:0px;">	
		<table id="sysLoglist" class="easyui-datagrid"
			data-options=" 
				fit: true,
				border: false,
				rownumbers: false,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbar',
				idField :'id',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				onLoadSuccess:cellTip,
				striped:true,
				queryParams:{'':''}		
				">
			<thead>
				<tr>
					<th data-options="field:'id', hidden:true" >id</th>
					<th data-options="field:'syslogUsernameZh',halign:'center',align:'left'" width="100">操作人</th>
					<th data-options="field:'syslogIp',required:true,halign:'center',align:'left',sortable:true" width="150">操作人IP</th>
					<th data-options="field:'syslogTime',required:true,halign:'center',align:'left', formatter: formatDate,sortable:true" editor="{type:'text'}" width="220">操作时间</th>
					<th data-options="field:'syslogModule',halign:'center',align:'left',sortable:true"  width="150">模块名称</th>
					<th data-options="field:'syslogTitle',halign:'center',align:'left',sortable:true" width="600">日志内容</th>
					<th data-options="field:'syslogOp',halign:'center',align:'left',sortable:true"  width="100">操作类型</th>
					<th data-options="field:'syslogType',halign:'center',align:'left'"  width="150">日志类型</th>
					<th data-options="field:'sysApplicationId',halign:'center',align:'left',formatter: formatApp"  width="150">来源</th>
				</tr>
			</thead>
		</table>	
	 </div>
	 
	</div>
  </div>
  <div id="searchDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchUserBtns'" 
	style="width: 500px;height:220px; visible: hidden;display: none;" title="搜索日志">
	<form id="searchForm">
   		<table class="tableForm" id="searchForm" width='100%'>
			<tr>
				<td >操作人：</td>
				<td><input name="syslogUsernameZh" id="syslogUsernameZh" type='text' class="easyui-validatebox" editable="false" style="width: 150px;" />
				<td>操作类型：</td>
				<!-- ,{label: 'logout',value: '注销'} 去除注销类型查询 -->
				<td><input name="syslogOp" id="syslogOp" class="easyui-combobox" style="width: 150px;" data-options="editable:false,panelHeight:'auto',valueField: 'label',textField: 'value',data: [{label: 'insert',value: '插入'},{label: 'delete',value: '删除'},{label: 'update',value: '修改'},{label: 'select',value: '查看'},{label: 'login',value: '登录'},{label: 'logout',value: '注销'}]"/>
				</td>
			</tr>
			<tr>	
				<td>日志类型：</td>
				<td>
					<input name="syslogType" id="syslogType" class="easyui-combobox" style="width: 150px;" data-options="
					valueField:'lookupCode',
					textField:'lookupName',
					editable:false,
					panelHeight:'auto'
				"/>
				     
				</td>
				<td>模块名称：</td>
				<td><input name="syslogModule" id="syslogModule" type='text' class="easyui-validatebox" editable="false" style="width: 150px;" />
			</tr>
			
			<tr>
				<td>操作时间(从)：</td>
				<td><input name="startDateBegin" id="startDateBegin" class="easyui-datetimebox" editable="false" style="width:150px;" />
				</td>
				<td>操作时间(至)：</td>
				<td><input name="startDateEnd" id="startDateEnd"  class="easyui-datetimebox" editable="false" style="width: 150px;" />
				</td>
			</tr>
			<tr>
				<td>日志内容：</td>
				<td><input name="syslogTitle" id="syslogTitle" type='text' class="easyui-validatebox" editable="false" style="width: 150px;" />
				</td>
				<td>操作人IP：</td>
				<td><input name="syslogIp" id="syslogIp" type='text' class="easyui-validatebox" editable="false" style="width: 150px;" />
				</td>
				
			</tr>
			
		</table>
   	</form>
   	<div id="searchUserBtns">
   		<a class="easyui-linkbutton" plain="false" onclick="searchFun();" href="javascript:void(0);">查询</a>
   		<a class="easyui-linkbutton" plain="false" onclick="clearFun();" href="javascript:void(0);">清空</a>
   		<a class="easyui-linkbutton" plain="false" onclick="hideSearch();" href="javascript:void(0);">返回</a>
   	</div>
   </div>
   
   <div id="exportLogDialog" data-options="iconCls:'icon-search',resizable:true,modal:true,buttons:'#exportLogBtns'" 
	style="width: 500px;height:220px; visible: hidden;display: none;" title="过滤日志">
	<form id="searchForm1">
   		<table class="tableForm" id="searchForm1" width='100%'>
			<tr>
				<td >操作人：</td>
				<td><input name="syslogUsernameZh" id="syslogUsernameZh1" type='text' class="easyui-validatebox" editable="false" style="width: 150px;" />
				<td>操作类型：</td>
				<td><input name="syslogOp1" id="syslogOp1" class="easyui-combobox"  style="width: 150px;" data-options="editable:false,panelHeight:'auto',valueField: 'label',textField: 'value',data: [{label: 'insert',value: '插入'},{label: 'update',value: '修改'},{label: 'login',value: '登录'},{label: 'logout',value: '注销'}]"/>
				</td>
			</tr>
			<tr>	
				<td>日志类型：</td>
				<td><input name="syslogType1" id="syslogType1" class="easyui-combobox" style="width: 150px;" data-options="
					valueField:'lookupCode',
					textField:'lookupName',
					editable:false,
					panelHeight:'auto'
				"/>
				     
				</td>
				<td>模块名称：</td>
				<td><input name="syslogModule" id="syslogModule1" class="easyui-combobox" style="width: 150px;" data-options="editable:false,panelHeight:'auto',valueField: 'label',textField: 'value',data: [{label: '用户管理',value: '用户管理'},{label: '用户退出',value: '用户退出'},{label: '集中授权管理',value: '集中授权管理'},{label: '菜单授权管理',value: '菜单授权管理'}]" />
			</tr>
			
			<tr>
				<td>操作时间(从)：</td>
				<td><input name="startDateBegin" id="startDateBegin1" class="easyui-datetimebox" editable="false" style="width:150px;" />
				</td>
				<td>操作时间(至)：</td>
				<td><input name="startDateEnd" id="startDateEnd1"  class="easyui-datetimebox" editable="false" style="width: 150px;" />
				</td>
			</tr>
		</table>
   	</form>
   	<div id="exportLogBtns">
   		<a class="easyui-linkbutton" plain="false" onclick="exportServerData();" href="javascript:void(0);">导出</a>
   	</div>
   </div>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script src="avicit/platform6/centralcontrol/sysapp/js/SysAppTree.js" type="text/javascript"></script>
<script type="text/javascript">
var APPLICATION ='${d}';
var logTable=-1;
var total=0;
(function(func){
	$.ajax({
		url: 'platform/sysApps/sysApplicationMap.json',
		type :'get',
		cache:false,
		dataType :'json',
		success :func
	});
})(function(r){r.json&&(APPLCATION=r.json);});

var type={};
(function(func){
	$.ajax({
		url: 'platform/syslog/initSysLogType/'+APPLICATION+'.json',
		type :'get',
		cache :false,
		dataType :'json',
		success :func
	});
})(function(r){
	if(r){
		$('#syslogType1').combobox('loadData',r); 
	}
});


(function(func){
	$.ajax({
		url: 'platform/syslog/initSysLogType/'+APPLICATION+'.json',
		type :'get',
		cache :false,
		dataType :'json',
		success :func
	});
})(function(r){
	if(r){
		$('#syslogType').combobox('loadData',r);
	}
});



//var queryParams;
var sysAppTree;
var m=${m};
$(document).ready(function(){ 
	$('#searchDialog').css('display','block').dialog({
		title:'日志查询'
	}).dialog('close',true);
	$('#exportLogDialog').css('display','block').dialog({
		title:'日志过滤'
	}).dialog('close',true);
	$('#searchForm').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchFun();
		}
	});
	$('#searchForm').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchFun();
		}
	});
	$('#sysLogArchived').combobox({'onSelect':function(rec){
		logTable=rec.archiveTableName;
		loadRoleInfo(APPLICATION);
	}});
	if(${m}){
		sysAppTree = new SysAppTree('apps','searchApp',APP_.PRIVATE,null,120);
		
		sysAppTree.setOnLoadSuccess(function(){
		});
		sysAppTree.setOnSelect(function(_sysAppTree,node){
			APPLICATION=node.id;
			$('#sysLogArchived').combobox('setValue', '');
			logTable=-1;
			$.ajax({
				url: 'platform/syslog/getSysLogArchived.json',
				data : {appId:APPLICATION},
				type :'get',
				dataType :'json',
				success :function(r){
					$('#sysLogArchived').combobox('loadData',r.json);
				}
			});
			loadRoleInfo(APPLICATION);
			//ajaxSysCount();
		});
		sysAppTree.init();
	}else{
		$.ajax({
			url: 'platform/syslog/getSysLogArchived.json',
			data : {appId:APPLICATION},
			type :'get',
			dataType :'json',
			success :function(r){
				$('#sysLogArchived').combobox('loadData',r.json);
			}
		});
		loadRoleInfo(APPLICATION);
	}
	ajaxSysCount();
});
function ajaxSysCount(){
	$.ajax({
		url: 'platform/syslog/sysLogCount.json',
		data : {appId:APPLICATION,logTable:logTable},
		type :'get',
		dataType :'json',
		success :function(r){
			total=r.total;
			if(r.total>r.threshold){//
				$('#threshold').css('display','block').text('日志数据量已经超过系统阈值('+r.threshold/10000+'万条)，请及时归档日志！');
			}
		}
	});
};

function loadRoleInfo(appId){
	$('#sysLoglist').datagrid("options").url ="platform/syslog/getSysLogDataByPage/"+appId+"/"+logTable+".json";
	var opts = $("#sysLoglist").datagrid('options');
   	var pager = $("#sysLoglist").datagrid('getPager');
   	opts.pageNumber = 1;
   	pager.pagination('refresh',{
   	    	pageNumber:1
   	});
	$('#sysLoglist').datagrid("reload",{});
};
var _a={};
//查询
function searchFun(){
	_a={};
    _a.syslogOp =$('#syslogOp').combobox('getValue').trim();
    _a.syslogType =$('#syslogType').combobox('getValue').trim();
    _a.syslogUsernameZh = $('#syslogUsernameZh').attr('value').trim();
    _a.syslogModule = $('#syslogModule').attr('value').trim();	
    _a.syslogTitle = $('#syslogTitle').attr('value').trim();	
    _a.syslogTimeBegin = $('#startDateBegin').datetimebox('getValue').trim();	
    _a.syslogTimeEnd = $('#startDateEnd').datetimebox('getValue').trim();	
    _a.syslogIp = $('#syslogIp').attr('value').trim();	
    $("#sysLoglist").datagrid('reload',{ param : JSON.stringify(_a)});
}
//查询选项重置
function clearFun(){
	$('#searchForm input').val('');
	$('#searchForm select').val('');
	_a={};
};

function formatDate(value){
	var newDate=new Date(value);
	return newDate.Format("yyyy-MM-dd hh:mm:ss");   
};
function formatApp(value){
	var _t=APPLCATION;
	var l=_t.length;
	for(;l--;){
		if(_t[l].id == value){
			return _t[l].name;
		}
	}
};

function cellTip(data){
	$('#sysLoglist').datagrid('doCellTip',   
	{   
		onlyShowInterrupt:true,   
		position:'bottom',
		tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
	}); 
};

function showSearch(){
	$('#searchDialog').dialog('open');
};

function hideSearch(){
	$('#searchDialog').dialog('close');
};

function showExportLog(){
	$('#exportLogDialog').dialog('open');
};
//归档日志文件
function archiveLog(){
	$.messager.confirm('确认','是否确认归档日志?',function(r){
		if (r) {
			$.ajax({
				url: 'platform/syslog/archiveLog/'+APPLICATION+'.json',
				type :'get',
				dataType :'json',
				success :function(r){
					if(r.flag =='success'){
						 $.messager.show({
							 title : '提示',
							 msg : '归档成功！'
						 });
						 $('#sysLogArchived').combobox('setValue', '');
						 logTable=-1;
						 $.ajax({
								url: 'platform/syslog/getSysLogArchived.json',
								data : {appId:APPLICATION},
								type :'get',
								cache :false,
								dataType :'json',
								success :function(r){
									$('#sysLogArchived').combobox('loadData',r.json);
								}
						 });
						 loadRoleInfo(APPLICATION);
					}else{
						 $.messager.show({
							 title : '提示',
							 msg : '归档失败：'+r.e
						});
					}
				}
			});
		}
	});
};
/**
 * 导出日志(客户端数据)
 */
function exportClientData(){
	$.messager.confirm('确认','是否确认导出Excel文件?',function(r) {
        if (r) {
            //封装参数
            var columnFieldsOptions = getGridColumnFieldsOptions('sysLoglist');
            var dataGridFields = JSON.stringify(columnFieldsOptions[0]);
            var rows = $('#sysLoglist').datagrid('getRows');
            var datas = JSON.stringify(rows);
            var myParams = {
                dataGridFields: dataGridFields,//表头信息集合
                datas: datas,//数据集
                unContainFields:'id',
                hasRowNum : true,//默认为Y:代表第一列为序号
                sheetName: 'sheet1',//如果该参数为空，默认为导出的Excel文件名
                fileName: '平台日志导出数据'+ new Date().format("yyyy-MM-dd")//导出的Excel文件名
            };
            var url = "platform/syslog/exportClient";
            var ep = new exportData("xlsExport","xlsExport",myParams,url);
            ep.excuteExport();
        }
       });
};
/**
 * 导出日志(服务端数据)
 */
function exportServerData(){
	$.messager.confirm('确认','是否确认导出Excel文件?',function(r) {
        if (r) {   
            //封装参数
            var columnFieldsOptions = getGridColumnFieldsOptions('sysLoglist');
            var dataGridFields = JSON.stringify(columnFieldsOptions[0]);
            enhanceLogFilter();
            var expSearchParams ={};
            
            expSearchParams.dataGridFields=dataGridFields;
            expSearchParams.hasRowNum=true;
            expSearchParams.sheetName='sheet1';
            expSearchParams.unContainFields='id';//由于id没有chechbox，所以需要显示的过滤掉
            expSearchParams.fileName='平台日志导出数据'+ new Date().format("yyyy-MM-dd");
            expSearchParams.param = JSON.stringify(_a);
            expSearchParams.appid=APPLICATION;
            expSearchParams.logTable=logTable;
            expSearchParams.total=total;
            var url = "platform/syslog/exportServer";
            var ep = new exportData("xlsExport","xlsExport",expSearchParams,url);
            ep.excuteExport();
            _a={};
        }
       });
};

function enhanceLogFilter(){
    var value=$('#syslogOp1').combobox('getValue');
    if(value){
    	 _a.syslogOp =value.trim();
    }
    value=$('#syslogType1').combobox('getValue');
    if(value){
    	 _a.syslogType =value.trim();
    }
    value=$('#syslogUsernameZh1').attr('value');
    if(value){
    	_a.syslogUsernameZh=value.trim();
    }
    value=$('#syslogModule1').combobox('getValue');
    if(value){
    	_a.syslogModule=value.trim();
    }
    value=$('#startDateBegin1').datetimebox('getValue');
    if(value){
    	_a.syslogTimeBegin=value.trim();	
    }
    value=$('#startDateEnd1').datetimebox('getValue');
    if(value){
    	_a.syslogTimeEnd=value.trim();
    }
};

</script>
</body>
</html>