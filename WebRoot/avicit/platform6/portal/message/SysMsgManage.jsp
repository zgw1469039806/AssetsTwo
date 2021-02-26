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
<!-- ControllerPath = "platform6/msystem/sysmsg/sysMsgController/toSysMsgManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="static/h5/select2/select2.css"/>
<style type="text/css">
select {
height: 30px;
	}
	
	.aaa {
    float: left;
    margin-left: 10px;
    margin-right: 10px;
}

optgroup {
font-family:'微软雅黑';font-style:normal ;
}
/*修改select2选中后边框颜色*/
.select2-container--default .select2-search--dropdown .select2-search__field {
	border: 1px solid #D9D9D9;
	outline: none;
}

.select2-container .select2-selection--single {
	box-sizing: border-box;
	cursor: pointer;
	display: block;
	height: 30px;
	user-select: none;
	-webkit-user-select: none;
	outline: none;
}
.select2-container--default .select2-selection--single{
	border: 1px solid #D9D9D9;
}
</style>
<link rel="stylesheet" type="text/css" href="avicit/platform6/portal/message/css/bootstrap-switch.css"/>

</head>
<body>

<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMessage_button_add" permissionDes="添加">
  	<a id="sysMessage_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-commenting-o"></i> 添加</a>
	</sec:accesscontrollist>

	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMessage_button_delete" permissionDes="删除">
	<a id="sysMessage_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
	</sec:accesscontrollist>
	
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMessage_button_read" permissionDes="标记已读">
	<a id="sysMessage_read" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="标记已读"><i class="fa fa-bookmark"></i> 标记已读</a>
	</sec:accesscontrollist>
	
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMessage_button_unread" permissionDes="标记未读">
	<a id="sysMessage_unread" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="标记未读"><i class="fa fa-bookmark-o"></i> 标记未读</a>
	</sec:accesscontrollist>
<!-- 		<a id="doReadtest" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="标记已读"><i class="fa fa-bookmark-o"></i> api已读</a> -->
<!-- 		<a id="doUnReadTest" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="标记未读"><i class="fa fa-bookmark-o"></i> api未读</a> -->
<!-- 	<a id="sendTest" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title=""><i class="fa fa-bookmark-o"></i> 发送测试</a> -->

		</div>
    <div class="toolbar-right">
    <div class='aaa'>
    	<%--<select id="selectSearch" class="form-control input-sm">
   		  <optgroup label="我的接收" >

		  <option value="all">全部</option>
		  <option value="unread" selected="selected" >未读</option>		  
		  <option value="read">已读</option>
	
		  </optgroup>
		    <option value="" disabled>——————</option>
		  	  <option value="send">我的发送</option>
		</select>--%>
		<select class="form-control input-sm" id="selectSearch" name="selectSearch" >
		</select>
    
    
    </div>
    

  
	    <div class="input-group form-tool-search">
     		<input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="sysMessage_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="sysMessage_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="sysMessagejqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">标题:</th>
				<td width="39%"><input title="标题"
					class="form-control input-sm" type="text" name="title" id="title" />
				</td>
				<th width="10%">内容:</th>
				<td width="39%"><input class="form-control input-sm"
						rows="3" title="内容" name="content" id="content" style="resize:none;"></input>
				</td>
			</tr>
			<tr>
				<th width="10%">发送人:</th>
				<td width="39%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="sendUser" name="sendUser"> <input
							class="form-control" placeholder="请选择用户" type="text"
							id="sendUserAlias" name="sendUserAlias"> <span
							class="input-group-addon" id="userbtn"> <i
							class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
				<th width="10%">发送人部门:</th>
				<td width="39%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="sendDeptid" name="sendDeptid"> <input
							class="form-control" placeholder="请选择部门" type="text"
							id="sendDeptidAlias" name="sendDeptidAlias"> <span
							class="input-group-addon" id="deptbtn"> <i
							class="glyphicon glyphicon-equalizer"></i>
						</span>
					</div>
				</td>
				
			</tr>
			<tr>
			<th width="10%">发送日期(开始):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<%--date-picker：这种格式在封装实体时时间字段的格式化有异常问题--%>
						<%--<input class="form-control date-picker" type="text"--%>
						<input class="form-control time-picker" type="text"
							name="sendDateBegin" id="sendDateBegin" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%">发送日期(结束):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<%--date-picker：这种格式在封装实体时时间字段的格式化有异常问题--%>
						<%--<input class="form-control date-picker" type="text"--%>
						<input class="form-control time-picker" type="text"
							name="sendDateEnd" id="sendDateEnd" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			</tr>
<!-- 			<tr> -->
<!-- 				<th width="10%">接收日期(从):</th> -->
<!-- 				<td width="39%"> -->
<!-- 					<div class="input-group input-group-sm"> -->
<!-- 						<input class="form-control time-picker" type="text" -->
<!-- 							name="recvDateBegin" id="recvDateBegin" /> <span -->
<!-- 							class="input-group-addon"><i -->
<!-- 							class="glyphicon glyphicon-calendar"></i></span> -->
<!-- 					</div> -->
<!-- 				</td> -->
<!-- 				<th width="10%">接收日期(至):</th> -->
<!-- 				<td width="39%"> -->
<!-- 					<div class="input-group input-group-sm"> -->
<!-- 						<input class="form-control time-picker" type="text" -->
<!-- 							name="recvDateEnd" id="recvDateEnd" /> <span -->
<!-- 							class="input-group-addon"><i -->
<!-- 							class="glyphicon glyphicon-calendar"></i></span> -->
<!-- 					</div> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<th width="10%">发送/接收</th> -->
<%-- 				<td width="39%"><pt6:h5radio css_class="radio-inline" --%>
<%-- 						name="recvOrSend" title="发送接收" canUse="0" --%>
<%-- 						lookupCode="PLATFORM_MSG_RECV_OR_SEND" /></td> --%>
<!-- 				<th width="10%">是否已读</th> -->
<%-- 				<td width="39%"><pt6:h5radio css_class="radio-inline" --%>
<%-- 						name="isReaded" title="是否已读" canUse="0" --%>
<%-- 						lookupCode="PLATFORM_SYSTEM_FLAG" /></td> --%>

<!-- 			</tr> -->

			<tr>
				<th width="10%">我的接收</th>
				<td width="39%">
				<label class="radio-inline"  title="发送接收"> <input name="msgTypes" title="全部" type="radio" value="0">全部</label>
				<label class="radio-inline"  title="发送接收"> <input name="msgTypes" title="未读" type="radio" value="1" checked="true">未读</label>
				<label class="radio-inline"  title="发送接收"> <input name="msgTypes" title="已读" type="radio" value="2">已读</label>				
				</td>
				<th width="10%">我的发送</th>
				<td width="39%">
				<label class="radio-inline"  title="我的发送"> <input name="msgTypes" title="我的发送" type="radio" value="3"></label>
					</td>

			</tr>

		</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
 <script src="avicit/platform6/portal/message/js/bootstrap-switch.js" type="text/javascript"></script> 
<!-- <script src="avicit/platform6/portal/message/js/highlight.js" type="text/javascript"></script> -->
<!-- <script src="avicit/platform6/portal/message/js/main.js" type="text/javascript"></script> -->

<script src="avicit/platform6/portal/message/js/SysMsg.js" type="text/javascript"></script>
<script src="avicit/platform6/portal/message/js/SysMsgPub.js" type="text/javascript"></script>
<script type="text/javascript" src="static/h5/select2/select2.js"></script>



<script type="text/javascript">

	var sysMessage;

	function formatValue(cellvalue, options, rowObject) {
//方式1：消息详情页不跳，只跳url
// 		if(null!=rowObject.urlAddress&&""!=rowObject.urlAddress){
// 			return '<a href="javascript:void(0);" onclick="sysMessage.url(\''
// 					+ rowObject.urlAddress + '\');">' + cellvalue + '</a>';
// 		}else{
// 			return  '<a href="javascript:void(0);" onclick="sysMessage.detail(\''
// 			+ rowObject.id + '\');">' + cellvalue + '</a>';
// 		}

//方式2：用公用的，优先跳url，没有则跳详情页
			return  '<a id="'+rowObject.id+'_title" class="title_url" data-rowid="'+rowObject.id+'"  data-url="'+rowObject.urlAddress+
			'" href="javascript:void(0);" onMouseOver="sysMessage.titleTips(\''+ rowObject.id + '_title\',\''+cellvalue+'\');" onMouseOut="sysMessage.closeContentTips();">' + cellvalue + '</a>';
			
	}
	
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="sysMessage.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}
	
	function formatContentValue(cellvalue, options, rowObject) {
	    if(cellvalue != null && cellvalue !='' && cellvalue != undefined){
            cellvalue = cellvalue.replace(/\r\n/g,"");//换行在ie8下回js报错，统一替换处理
		}
        return '<a id="'+rowObject.id+'_content" style="text-decoration:none;">' + cellvalue + '</a>';

		// return '<a id="'+rowObject.id+'_content" onMouseOver="sysMessage.contentTips(\''
		// 		+ rowObject.id + '_content\',\''+cellvalue+'\');" onMouseOut="sysMessage.closeContentTips();" style="text-decoration:none;">' + cellvalue + '</a>';
	}
	
	function formatRecvValue(cellvalue, options, rowObject) {

		return '<a id="'+rowObject.id+'_recv" onMouseOver="sysMessage.recvTips(\''
		+ rowObject.id + '_recv\',\''+cellvalue+'\');" onMouseOut="sysMessage.closeRecvTips();" style="text-decoration:none;">' + cellvalue + '</a>';
	}
	
	function formatReadValue(cellvalue, options, rowObject) {
		if("1"==rowObject.recvOrSend){
			if('是'==cellvalue){		

				return '<input type="checkbox" name="my-checkbox" data-rowid="'+rowObject.id+'" data-broadcastFlag="'+rowObject.broadcastFlag+'" checked  />';
// 				return '<input type="checkbox" name="my-checkbox"  data-rowid="'+rowObject.id+'" data-broadcastFlag="'+rowObject.broadcastFlag+'"  />';

			}else{

				return '<input type="checkbox" name="my-checkbox"  data-rowid="'+rowObject.id+'" data-broadcastFlag="'+rowObject.broadcastFlag+'"  />';
		
			}		
		}else if("0"==rowObject.recvOrSend) {
		    if('是'==cellvalue)
		        return "消息已读";
		    else
		        return "消息未读";
		}
		else {

			return "";
		}
		
		
// 		return '<div class="switch switch-mini"  data-on-label="SI" data-off-label="NO"> <input type="checkbox" name="my-checkbox" checked /></div>';

// 		return '<div id="create-switch"><div/>';
	}

	

	$(document).ready(
			function() {
				var dataGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, 
				{
					label : 'broadcastFlag',
					name : 'broadcastFlag',
					width : 50,
					hidden : true
					},
				{
					label : 'recvOrSend',
					name : 'recvOrSend',
					width : 50,
					hidden : true
					},	
					
					
				
				{
					label : '标题',
					name : 'title',
					width : 150,
					formatter : formatValue
				}, {
					label : '内容',
					name : 'content',
					formatter:formatContentValue
					,width : 150
				}, {
					label : '来源',
					name : 'sourceName',
					width : 150
				}, {
					label : '发送人',
					name : 'sendUserAlias',
					width : 150
				}, {
					label : '发送人部门',
					name : 'sendDeptidAlias',
					width : 150
				}, 
				{
					label : '发送日期',
					name : 'sendDate',
					width : 150
				}, {
					label : '接收人',
					name : 'recvUserAlias',
					formatter:formatRecvValue,
					width : 150
				}, {
					label : '到期时间',
					name : 'disappearDate',
					width : 150
				}, {
					label : '是否已读',
					name : 'isReaded',
					align:'center',
					formatter:formatReadValue,
// 					editable:true, 
// 					edittype:'custom', 
// 					editoptions:{custom_element: myelem, custom_value:myvalue},
					width : 80
				} ];
				var searchNames = new Array();
				var searchTips = new Array();
				searchNames.push("title");
				searchTips.push("标题");
				searchNames.push("content");
				searchTips.push("内容");
				$('#keyWord').attr('placeholder',
						'请输入' + searchTips[0] + '或' + searchTips[1]);
				sysMessage = new SysMessage('sysMessagejqGrid', '${url}',
						'searchDialog', 'form', 'keyWord', searchNames,
						dataGridColModel,'selectSearch','sysMessage_read','sysMessage_unread');
				//添加按钮绑定事件
				$('#sysMessage_insert').bind('click', function() {
					sysMessage.insert();
				});
				//编辑按钮绑定事件
// 				$('#sysMessage_modify').bind('click', function() {
// 					sysMessage.modify();
// 				});
				//删除按钮绑定事件
				$('#sysMessage_del').bind('click', function() {
					sysMessage.deldtos();
				});
				
				//已读按钮绑定事件
				$('#sysMessage_read').bind('click', function() {
					sysMessage.read();
				});
				
				//未读按钮绑定事件
				$('#sysMessage_unread').bind('click', function() {
					sysMessage.unread();
				});
				
				
				
				//查询按钮绑定事件
				$('#sysMessage_searchPart').bind('click', function() {
					sysMessage.searchByKeyWord();
				});
				//打开高级查询框
				$('#sysMessage_searchAll').bind('click', function() {
					sysMessage.openSearchForm(this);
				});
				$('#sendUserAlias').on('focus', function(e) {
					new H5CommonSelect({
						type : 'userSelect',
						idFiled : 'sendUser',
						textFiled : 'sendUserAlias'
					});
				});
				$('#recvUserAlias').on('focus', function(e) {
					new H5CommonSelect({
						type : 'userSelect',
						idFiled : 'recvUser',
						textFiled : 'recvUserAlias'
					});
				});
				$('#sendDeptidAlias').on('focus', function(e) {
					new H5CommonSelect({
						type : 'deptSelect',
						idFiled : 'sendDeptid',
						textFiled : 'sendDeptidAlias'
					});
				});
				
				
				//列表，分享下拉框，用于过滤数据
				$('#selectSearch').bind('change', function() {
					sysMessage.selectSearchChange("selectSearch");
					// 			alert("选中改变");

				});
				
// 	测试公用发送页			
// 				$('#sendTest').sendMsg(
// 						{
// 						area: ['100%', '100%'],
// 						recvUser:'1'
// 						});
				
	
				
				
// 				//api测试
// 				$('#doReadtest').bind('click', function() {
// 					sysMessage.doReadtest();
// 				});
// 				//api测试
// 				$('#doUnReadTest').bind('click', function() {
// 					sysMessage.doUnReadTest();
// 				});
// 				$("[name='my-checkbox']").bootstrapSwitch();
			

// 				 $('.make-switch').bootstrapSwitch();
				
// 				$('#doUnReadTest').on('focus', function() {
// 					sysMessage.doUnReadTest();
// 				});

				/*下拉框修改为select2插件并且使用本地数据初始化*/
                var data = [{
                    text: '我的接收',
                    children: [{
                        id: "all",
                        text: '全部'
                    }, {
                        id: "unread",
                        text: '未读',
                        selected: true
                    }, {
                        id: "read",
                        text: '已读'
                    }]
                },
                    {
                        text: '——————',
                        children: [{
                            id: "send",
                            text: "我的发送"
                        }]
                    }
                ];
                //select2初始化
                $("#selectSearch").select2({
                    data:data
                });
            });

</script>
</html>