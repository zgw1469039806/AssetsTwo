<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
String importlibs = "common,table,form";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>日志审计信息</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

</head>
<body class="easyui-layout" fit="true">
	<c:if test= "${m}">
		<div data-options="region:'west',split:false,title:'应用列表',collapsible:false" style="overflow:hidden; width:160px;">

                <div id="tableToolbarM" class="toolbar">
                    <div class="toolbar-left">
                        <div class="input-group  input-group-sm">
                            <input  class="form-control" placeholder="输入名称查询" type="text" id="appSearchInput" name="txt">
                            <span class="input-group-btn">
                            <button id="appSearch" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
                        </span>
                        </div>
                    </div>
                </div>
                <div  id='mdiv' style="overflow:auto;">
                    <table id="jqGridApp"></table>
                </div>
	 	</div>
 	</c:if>
 	<div  id="panelcenter" data-options="region:'center',split:true ,onResize:function(a){$('#jqGrid').setGridWidth(a);$('#jqGrid').setGridHeight(getJgridTableHeight($('#panelcenter')));$(window).trigger('resize');}" style="overflow:auto;">
			<div id="tableToolbar" class="toolbar">
				<div class="toolbar-left" style="width: 520px;">
					<label for="logArchived">历史归档:</label>
					<select style="width:230px;display: inline-block;" id="logArchived" name="logArchived" class="form-control input-sm" title="归档历史" >
					</select>
                    <a style="display: inline-block;" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="归档日志" onclick='archiveLog();' href="javascript:void(0);"><i class="icon icon-edit"></i> 归档日志</a>
					<div class="dropdown">
						<a class="btn btn-primary form-tool-btn btn-sm" role="button"  href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu">导出日志<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
							<li role="presentation"><a href="javascript:void(0);" onclick="exportClientData();">EXCEL导出（当前页）</a></li>
							<li role="presentation"><a href="javascript:void(0);" onclick="exportServerData();">EXCEL导出（所有页）</a></li>
						</ul>
					</div>


					<span id='threshold' style="color: red;display: none;"></span>
				</div>
				<div class="toolbar-right">
					<div class="input-group form-tool-search">
						<input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入操作人或者模块名称">
						<label id="searchPart" class="icon icon-search form-tool-searchicon"></label>
					</div>
					<div class="input-group-btn form-tool-searchbtn">
						<a id="searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
					</div>
				</div>
				
			</div>
			<table id="jqGrid"></table>
			<div id="jqGridPager"></div>
		</div>
		
	
	 
	</div>
  	</div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id='form' style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="12%">操作人:</th>
				<td width="38%">
					<input class="form-control" type="text" name="syslogUsernameZh" id="syslogUsernameZh" />
				</td>
				<th width="12%">操作类型:</th>
				<td>
					<select class="form-control" name="syslogOp" id="syslogOp">
						<option value=""></option>
						<option value="insert">插入</option>
						<option value="delete">删除</option>
						<option value="update">修改</option>
						<option value="select">查看</option>
						<option value="login">登录</option>
						<option value="logout">注销</option>
					</select>
				</td>
			</tr>
			<tr>
				<th width="12%">日志类型:</th>
				<td width="38%">
					<select class="form-control" name="syslogType" id="syslogType">
					</select>
				</td>
				<th width="12%">模块名称:</th>
				<td>
					<input class="form-control" type="text" name="syslogModule" id="syslogModule" />
				</td>
			</tr>
			<tr>
				<th width="12%">操作时间(从):</th>
				<td width="38%">
					<div class="input-group input-group-sm">
							<input class="form-control time-picker" type="text"
								name="syslogTimeBegin" id="syslogTimeBegin" /><span
								class="input-group-addon"> <i
								class="glyphicon glyphicon-time"></i></span>
						</div>

				</td>
				<th width="12%">操作时间(到):</th>
				<td>
					<div class="input-group input-group-sm">
							<input class="form-control time-picker" type="text"
								name="syslogTimeEnd" id="syslogTimeEnd" /><span
								class="input-group-addon"> <i
								class="glyphicon glyphicon-time"></i></span>
						</div>

				</td>
			</tr>
			<tr>
				<th width="12%">日志内容:</th>
				<td width="38%">
					<input class="form-control" type="text" name="syslogTitle" id="syslogTitle" />
				</td>
				<th width="12%">操作人IP:</th>
				<td>
					<input class="form-control" type="text" name="syslogIp" id="syslogIp" />
				</td>
			</tr>
			<tr>
				<th width="12%">操作结果:</th>
				<td width="38%">
					<select class="form-control" name="syslogResult" id="syslogResult">
						<option value=""></option>
						<option value="success">成功</option>
						<option value="failure">失败</option>
					</select>
				</td>
			</tr>
			
		</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<c:if test= "${m}">
<script src="avicit/platform6/bs3centralcontrol/appliaction/js/AppList.js" type="text/javascript"></script>
</c:if>
<script type="text/javascript" src="avicit/platform6/console/consolelog/js/conlog.js" ></script>
<script type="text/javascript">
$('#mdiv').height(document.documentElement.clientHeight-38);
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

//格式化日期
function fmtDate(cellvalue){
	var newDate=new Date(cellvalue);
	return newDate.Format("yyyy-MM-dd hh:mm:ss"); 
};

var type={};
(function(func){
	$.ajax({
		url: 'platform/console/log/initSysLogType/'+APPLICATION+'.json',
		type :'get',
		cache :false,
		dataType :'json',
		success :func
	});
})(function(r){
	if(r.length >0){
		r.push({lookupCode:'',lookupName:''});
		l=r.length;
		for(;l--;){
			$('<option value="'+r[l].lookupCode+'">'+r[l].lookupName+'</option>').appendTo($('#syslogType'));
		}
	}
});


//var queryParams;
var sysAppTree,logGrid;

$(function(){
	var searchNames =[];
	searchNames.push("syslogUsernameZh");//用户可自定义查询条件，修改参数。
	searchNames.push("syslogModule");
	
	var dataGridColModel =  [
      { label: 'id', name: 'id', key: true,  hidden:true },
      { label: '操作人', name: 'syslogUsernameZh', width: 40 ,align:'center'},
      { label: '操作人编码', name: 'syslogUserNo', width: 50,align:'center' },
      { label: '操作人IP', name: 'syslogIp', width: 50,align:'center' },
      { label: '操作时间', name: 'syslogTime', width: 60,align:'center',formatter:fmtDate},
      { label: '模块名称', name: 'syslogModule', width: 50,align:'center'},
      { label: '日志内容', name: 'syslogTitle', width: 200,align:'left' },
      { label: '操作类型', name: 'syslogOp', width: 30,sortable:false,align:'center'},
      { label: '操作结果', name: 'syslogResult', width: 30,sortable:false,align:'center'},
      { label: '日志类型', name: 'syslogType', width: 40,sortable:false,align:'center'},
      { label: '来源', name: 'sysApplicationId', width: 50,sortable:false,align:'center',formatter:fmtApp}
	];


	$('#logArchived').on('change',function(){
		logTable=$(this).val();
		loadRoleInfo(APPLICATION);
	});


    if(${m}){

        sysAppTree = new AppList('jqGridApp','1','searchDialog','form','keyWord');

        sysAppTree.setOnSelect(function(appId){
            APPLICATION=appId;

            $.ajax({
                url: 'platform/console/log/getSysLogArchived.json',
                data : {appId:APPLICATION},
                type :'get',
                dataType :'json',
                success :function(r){
                    var l =r.json.length;
                    if(l>0){
                        for(;l--;){
                            $('<option value="'+r.json[l].archiveTableName+'">'+r.json[l].archiveName+'</option>').appendTo($('#logArchived'));
                        }
                    }else{
                        $("#logArchived").empty();
                    }
                }
            });


            if(logGrid){
                loadRoleInfo(APPLICATION);
                return;
            }
            logGrid = new ConsoleLog('jqGrid','${url}','searchDialog','form','keyWord',searchNames,dataGridColModel);

        });

	}else{
        logGrid = new ConsoleLog('jqGrid','${url}','searchDialog','form','keyWord',searchNames,dataGridColModel);
		$.ajax({
			url: 'platform/console/log/getSysLogArchived.json',
			data : {appId:APPLICATION},
			type :'get',
			dataType :'json',
			success :function(r){
				var l =r.json.length;
				if(l>0){
					for(;l--;){
						$('<option value="'+r.json[l].archiveTableName+'">'+r.json[l].archiveName+'</option>').appendTo($('#logArchived'));
					}
				}
			}
		});
	}
	ajaxSysCount();
	$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:false,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
				beforeShow: function(selectedDate) {
					setTimeout(function () { 
						$('#ui-datepicker-div').css("z-index", 20170816); 
					}, 100); 
					if($('#'+selectedDate.id).val()==""){
						$(this).datetimepicker("setDate", new Date());
						$('#'+selectedDate.id).val('');
					}
				}
			});
});
	
	
function ajaxSysCount(){
	$.ajax({
		url: 'platform/console/log/sysLogCount.json',
		data : {appId:APPLICATION,logTable:logTable},
		type :'get',
		dataType :'json',
		success :function(r){
			total=r.total;
			if(r.total>r.threshold){
				$('#threshold').css('display','inline-block').text('日志数据量已经超过系统阈值('+r.threshold/10000+'万条)，请及时归档日志！');
			}
		}
	});
};
//打开高级查询框
$('#searchAll').bind('click',function(){
	logGrid.openSearchForm(this);
});
//按照应用id加载
function loadRoleInfo(appId){
		logGrid.loadByConditions(appId,logTable);
};


function formatDate(value){
	var newDate=new Date(value);
	return newDate.Format("yyyy-MM-dd hh:mm:ss");   
};
function fmtApp(value){
	var _t=APPLCATION;
	var l=_t.length;
	for(;l--;){
		if(_t[l].id == value){
			return _t[l].name;
		}
	}
};

//归档日志文件
function archiveLog(){
	layer.confirm('确定要归档当前日志吗?', function(index){
		$.ajax({
			url: 'platform/console/log/archiveLog/'+APPLICATION+'.json',
			type :'get',
			dataType :'json',
			success :function(r){
				if(r.flag =='success'){
					layer.msg('归档成功!',{
						icon: 1,
						area: ['200px', ''],
						closeBtn: 0
					});
					$('#logArchived').empty();
					logTable=-1;
					$.ajax({
						url: 'platform/console/log/getSysLogArchived.json',
						data : {appId:APPLICATION},
						type :'get',
						cache :false,
						dataType :'json',
						success :function(r){
							var l =r.json.length;
							if(l>0){
								for(;l--;){
									$('<option value="'+r.json[l].archiveTableName+'">'+r.json[l].archiveName+'</option>').appendTo($('#logArchived'));
								}
							}
						}
					});
					 loadRoleInfo(APPLICATION);
				}else{
					
					layer.alert('归档失败:' + r.e, {
						icon: 2,
						area: ['400px', ''],
						closeBtn: 0
					});
				}
			}
		});
	});
};


function exportClientData(){
	layer.confirm('是否确认导出Excel文件?',function(index) {
        if (index) {
            //封装参数
            var rows=$("#jqGrid").jqGrid("getRowData"); 
          	var rownum =$("#jqGrid").jqGrid('getGridParam','colModel')
          	var dataGridFields = JSON.stringify(rownum);
            var datas = JSON.stringify(rows);
            var myParams = {
                dataGridFields: dataGridFields,//表头信息集合
                datas: datas,//数据集
                hasRowNum : true,//默认为Y:代表第一列为序号
                sheetName: 'sheet1',//如果该参数为空，默认为导出的Excel文件名
                unContainFields : 'id',//不需要导出的列，使用','分隔即可
                fileName: '平台日志导出数据',//导出的Excel文件名
            };
            var url = "platform/console/log/exportClient";
            var ep = new exportData("xlsExport","xlsExport",myParams,url);
            ep.excuteExport();
            layer.close(index);
        }
       });
}


/**
 * 导出日志(服务端数据)
 */
function exportServerData1(){
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
            var url = "platform/console/log/exportServer";
            var ep = new exportData("xlsExport","xlsExport",expSearchParams,url);
            ep.excuteExport();
            _a={};
        }
       });
};
/**
 * 导出用户(服务端数据)
 */
function exportServerData(){
	layer.confirm('是否确认导出Excel文件?',function(index) {
        if (index) {
            //封装参数
            var rows=$("#jqGrid").jqGrid("getRowData"); 
          	var rownum =	$("#jqGrid").jqGrid('getGridParam','colModel')
          	var dataGridFields = JSON.stringify(rownum);
            
          	var expSearchParams ={};
            
            expSearchParams.dataGridFields=dataGridFields;
            expSearchParams.hasRowNum=true;
            expSearchParams.sheetName='sheet1';
            expSearchParams.unContainFields='id';
            expSearchParams.fileName='平台日志导出数据';
            if(logGrid.getSearchDate()){
            	 expSearchParams.param = logGrid.getSearchDate();
            }else{
            	expSearchParams.param = '';
            }
            
            expSearchParams.appid=APPLICATION;
            expSearchParams.logTable=logTable;
            expSearchParams.total=total;
           
            var url = "platform/console/log/exportServer";
            var ep = new exportData("xlsExport","xlsExport",expSearchParams,url);
            ep.excuteExport();
            layer.close(index);
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
</html>