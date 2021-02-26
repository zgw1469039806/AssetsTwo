<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>桌面门户列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="static/js/platform/component/common/json2.js"></script>
<style type="text/css">
	a{text-decoration:none}
</style>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div data-options="region:'center',onResize:function(a){$('#portletList').setGridWidth(a);$(window).trigger('resize');}" id="centerLayout">
			<div class="toolbar-right" style="padding:4px 0 4px 4px;">
				<a id="insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="icon icon-add"></i> 添加</a>
				<a id="edit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="icon icon-edit"></i> 编辑</a>
				<a id="delete" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
			 </div>
			 <table id="portletList"></table>
			<div id="jqGridPager1"></div>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<!-- 模块js -->
	<script type="text/javascript">
	$(document).ready(function(){
		$('#centerLayout').css("height",document.documentElement.clientHeight - 20);
		$('#insert').bind('click', function() {
			  insert();
		});

		$('#edit').bind('click', function() {
				var ids = $('#portletList').jqGrid('getGridParam','selarrrow');
				if(ids.length > 0){
						if(ids.length > 1){
							parent.layer.alert('只允许选择一条数据，进行编辑！', {
								  title : '提示',
								  icon : 7,
								  area: ['400px', ''], //宽高
								  closeBtn: 0
								}
							);
							return;
						}
						edit(ids[0]);
				} else {
					parent.layer.alert('请选择要编辑的数据！', {
						  title : '提示',
						  icon : 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0
						}
					);
						return;
				}
		});

		$('#delete').bind('click', function() {
				var ids = $('#portletList').jqGrid('getGridParam','selarrrow');
				if(ids.length > 0){
						deleteConfig(ids);
				} else {
					parent.layer.alert('请选择要删除的数据！', {
						  title : '提示',
						  icon : 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0
						}
					);
						return;
				}
		});

	});
	$("#portletList").jqGrid({
		url : 'portal/portlet/togGetPortalConfigJsonDataByPage?appId=${appId}&orgIdentity=${orgIdentity}',
		mtype : 'POST',
		datatype: "json",
		height : parent.$("#portletFrame").height() - 130,
		multiselect: true,
		styleUI : 'Bootstrap',
		rowNum: 20,
		rowList:[200,100,50,30,20,10],
		altRows:true,
		pagerpos:'left',
		pager: "#jqGridPager1",
		hasTabExport:false,
		hasColSet:false,
		viewrecords: true, //
		autowidth: true,
		responsive:true,

		colModel:[
			{name:'id',index:'id', width:155,hidden:true},
            {name:'portletName',index:'portletName', label:'名称',width:140,align:"left",sortable:false},
			{name:'portletCode',index:'portletCode', label:'编码',width:180, align:"left",sortable:false},
            {name:'resourceType',index:'resourceType', label:'应用范围',width:100,align:"center",formatter:formatter,sortable:false},
			{name:'isDefault',index:'isDefault', label:'是否默认',width:100,align:"center",formatter:isDefaultFormatter,sortable:false},
			{name:'resourceId',index:'resourceId', label:'范围内容',width:140,align:"center",sortable:false},
			{name:'orderBy',index:'orderBy', label:'排序',width:60,align:"center",sortable:false},
			{name:'memo',index:'memo', label:'描述',width:150,hidden:false,sortable:false},
			{name:'opt',index:'roleType', label:'操作',width:80,hidden:false,formatter:opt,align:"center",sortable:false}
		],
		sortname: 'id'
	});
	function isDefaultFormatter(cellvalue, options, rowObject){
		if(cellvalue == "1"){
			return "是";
		} else {
			return "否";
		}
	}
	function formatter(cellvalue, options, rowObject){
		if(cellvalue == "0"){
			return "系统默认";
		} else if(cellvalue == "1"){
			return "角色定义";
		} else if(cellvalue == "2"){
			return "用户自定义";
		} else {
			return "";
		}
	}
	//操作
	function opt(cellvalue, options, rowObject){
		var content = "<a style='text-decoration:none;' class='glyphicon glyphicon-cog flow-icon-small' onclick='setting(\"" + rowObject.id + "\",\"" + rowObject.portletName + "\",\"" + rowObject.resourceType + "\");return false;' title='点击进行设计' href='javascript:void(0)'></a>";
		content += "&nbsp;&nbsp;&nbsp;<a style='text-decoration:none;' class='glyphicon glyphicon-eye-open flow-icon-small' onclick='review(\"" + rowObject.id + "\",\"" + rowObject.portletName + "\");return false;'  title='点击进行预览' href='javascript:void(0)'></a>";
		return content;
	}
	//设置
	function setting(id,portletName,resourceType){
		var isPortal = false;
		var url = 'portal/portlet/toGetPortalConfigDesign?id=' + id + '&resourceType=' + resourceType + '&isPortal=' + isPortal + '&appId=${appId}';
		var indexSet = top.layer.open({
			 type : 2,
			 /*title: "设置【" + portletName + "】",*/
			 title:false,
			 skin: 'index-model-noborder',
			 move :'.simple-movetab',
			 shade: false,
             closeBtn : 0,
			 area: ['100%', '100%'],
			 content : url
		 });
	}
	//预览
	function review(id,portletName){
		var url = "portal/userDefinedPortlet/toGetPortalConfigContent?id=" + id;
        var indexPre = top.layer.open({
			 type : 2,
			 title: "预览【" + portletName + "】",
			 skin: 'index-model-noborder',
			 move :'.simple-movetab',
			 shade: false,
             area: ['100%', '100%'],
			 content : url
		 });
	}
	//删除
	function deleteConfig(ids){
        var names = '';
        for(var i = 0 ; i < ids.length ; i++){
            var id = ids[i];
            var rowData = $("#portletList").jqGrid("getRowData",id);
            names += ' 【' + rowData.portletName + '】';
        }
        parent.layer.confirm('确认要删除选择的数据吗?', {
            title : '提示',
            icon : 3,
            area: ['400px', ''],
            btn: ['确定','取消'],
            closeBtn : 0
        }, function(index,layero){
            deletePortletAjax(ids);
            parent.layer.close(index);
        }, function(){

        });
	}
	function deletePortletAjax(ids){
		$.ajax({
			url:'portal/portlet/toDeletePortletConfig',
			data : {
				data : ids.toString()
			},
			dataType : "text",
			type : 'POST',
			success : function(msg){
				layer.msg('删除成功！');
				reloadGrid();
			},
			error : function(msg){
				layer.msg('删除失败！');
			}
		});
	}

	function reloadGrid(){
		$("#portletList").trigger("reloadGrid");
	}
	//编辑
	function edit(id){
		parent.layer.open({
			type : 2,
			title: "编辑桌面门户",
			area : [ "90%", "90%" ],
			content : "portal/portlet/toGetPortalConfigEdit?id=" + id + "&appId=${appId}&orgIdentity=${orgIdentity}",
			offset : "auto",
			btn : [ '保存','保存并设计桌面门户', '取消' ],
			yes: function(index, layero){//保存
				var iframeWin = layero.find('iframe')[0].contentWindow;
				var resourceType = iframeWin.$("input[name='resourceType']:checked").val();
				var resourceId = '';
				if(resourceType == 1){
						resourceId = iframeWin.$('#ruleId').val();
				} else if(resourceType == 2){
						resourceId = iframeWin.$('#userId').val();
				}
				var data = {
					id : iframeWin.$('#id').val(),
					portleName : iframeWin.$('#portletName').val(),
					portletCode : iframeWin.$('#portletCode').val(),
					resourceType : resourceType,
					resourceId : resourceId,
					appId : iframeWin.$('#appId').val(),
					orgIdentity : iframeWin.$('#orgIdentity').val(),
					isDefault: iframeWin.$("input[name='isDefault']:checked").val(),
					memo : iframeWin.$('#memo').val(),
					orderBy : iframeWin.$('#orderBy').val()
				};
				if(!validate(data)){
					return false;
				}
			  save(data,index);
			},
			btn2 : function(index,layero){
				var iframeWin = layero.find('iframe')[0].contentWindow;
				var resourceType = iframeWin.$("input[name='resourceType']:checked").val();
				var resourceId = '';
				if(resourceType == 1){
						resourceId = iframeWin.$('#ruleId').val();
				} else if(resourceType == 2){
						resourceId = iframeWin.$('#userId').val();
				}
				var data = {
					id : iframeWin.$('#id').val(),
					portleName : iframeWin.$('#portletName').val(),
					portletCode : iframeWin.$('#portletCode').val(),
					resourceType : resourceType,
					resourceId : resourceId,
					appId : iframeWin.$('#appId').val(),
					orgIdentity : iframeWin.$('#orgIdentity').val(),
					isDefault : iframeWin.$("input[name='isDefault']:checked").val(),
					memo : iframeWin.$('#memo').val(),
					orderBy : iframeWin.$('#orderBy').val()
				};
				if(!validate(data)){
					return false;
				}
				saveAndDesignPortlet(data,index);
			},
			btn3 : function(index,layero){
				layer.close(index);
			}
		});
	}
	function validate(data){
		if(data.portleName.length == 0){
			isNullTips('名称');
			return false;
		}
		if(data.portletCode.length == 0){
			isNullTips('编码');
			return false;
		}
		if(data.resourceType.length == 0){
			isNullTips('应用范围');
			return false;
		}
		if(data.resourceType == '1' && data.resourceId.length == 0){
			isNullTips('角色');
			return false;
		}
		if(data.resourceType == '2' && data.resourceId.length == 0){
			isNullTips('用户');
			return false;
		}
        if(data.orderBy.length == 0){
            isNullTips('排序');
            return false;
        }
		return true;
	}
	function isNullTips(msg){
		parent.layer.alert('【' + msg + '】值不允许为空，请输入或选择', {
			  title : '提示',
			  icon : 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
	}
	//添加
	function insert(){
		parent.layer.open({
			type : 2,
			title: "添加桌面门户",
			area : [ "90%", "90%" ],
			content : "portal/portlet/toGetPortalConfigEdit?appId=${appId}&orgIdentity=${orgIdentity}",
			offset : "auto",
			btn : [ '保存','保存并设计桌面门户', '取消' ],
			yes: function(index, layero){//保存
				var iframeWin = layero.find('iframe')[0].contentWindow;
				var resourceType = iframeWin.$("input[name='resourceType']:checked").val();
				var resourceId = '';
				if(resourceType == 1){
						resourceId = iframeWin.$('#ruleId').val();
				} else if(resourceType == 2){
						resourceId = iframeWin.$('#userId').val();
				}
				var data = {
					id : "",
					portleName : iframeWin.$('#portletName').val(),
					portletCode : iframeWin.$('#portletCode').val(),
					resourceType : resourceType,
					resourceId : resourceId,
					appId : iframeWin.$('#appId').val(),
					orgIdentity : iframeWin.$('#orgIdentity').val(),
					isDefault : iframeWin.$("input[name='isDefault']:checked").val(),
					memo : iframeWin.$('#memo').val(),
					orderBy : iframeWin.$('#orderBy').val()
				};
				if(!validate(data)){
					return false;
				}
			  save(data,index);
			},
			btn2 : function(index,layero){
				var iframeWin = layero.find('iframe')[0].contentWindow;
				var resourceType = iframeWin.$("input[name='resourceType']:checked").val();
				var resourceId = '';
				if(resourceType == 1){
						resourceId = iframeWin.$('#ruleId').val();
				} else if(resourceType == 2){
						resourceId = iframeWin.$('#userId').val();
				}
				var data = {
					id : iframeWin.$('#id').val(),
					portleName : iframeWin.$('#portletName').val(),
					portletCode : iframeWin.$('#portletCode').val(),
					resourceType : resourceType,
					resourceId : resourceId,
					appId : iframeWin.$('#appId').val(),
					orgIdentity : iframeWin.$('#orgIdentity').val(),
					memo : iframeWin.$('#memo').val(),
					orderBy : iframeWin.$('#orderBy').val()
				};
				if(!validate(data)){
					return false;
				}
				saveAndDesignPortlet(data,index);
			},
			btn3 : function(index,layero){
				layer.close(index);
			}
		});
	}

	//保存
	function save(data,layerIndex){
		$.ajax({
			url:'portal/portlet/toSavePortletConfig',
			data : {
				data : JSON.stringify(data)
			},
			dataType : "text",
			type : 'POST',
			success : function(msg){
				parent.layer.close(layerIndex);
				$("#portletList").trigger("reloadGrid");
			},
			error : function(msg){
				alert('error');
			}
		});
	}
	//保存并设计桌面门户
	function saveAndDesignPortlet(data,layerIndex){
			$.ajax({
				url:'portal/portlet/toSavePortletConfig',
				data : {
					data : JSON.stringify(data)
				},
				async: false,
				dataType : "text",
				type : 'POST',
				success : function(msg){
					parent.layer.close(layerIndex);
					$("#portletList").trigger("reloadGrid");
					top.layer.open({
						 type : 2,
						 /*title: "设置自定义首页",*/
						 title: false,
						 skin: 'index-model-noborder',
						 move :'.simple-movetab',
						 shade: false,
						 area: ['100%', '100%'],
						 content : 'portal/portlet/toGetPortalConfigDesign?id=' + msg + '&resourceType=' + data.resourceType + '&appId=${appId}'
					});
				},
				error : function(msg){
					alert('error');
				}
		});
	  return false;
	}
	</script>
	<input type='hidden' id='appId' name='appId' value='${appId}' />
</body>
</html>