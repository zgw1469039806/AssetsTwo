<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程关联页</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<%
	String importlibs = "common,table,form";
	String id = request.getParameter("pid");
%>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
<div id="toolbar_uums" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3"
				domainObject="related_button_add"
				permissionDes="添加">
				<a id="related_add" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3"
				domainObject="related_button_delete"
				permissionDes="删除">
				<a id="related_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
		</sec:accesscontrollist>
	</div>
	<div class="toolbar-right">
		<div id="commonSearch" class="input-group form-tool-search" >
			<input type="text" name="related_keyWord"
				id="related_keyWord" style="width:240px;"
				class="form-control input-sm" placeholder="请输入查询标题"> <label
				id="related_searchPart"
				class="icon icon-search form-tool-searchicon"></label>
		</div>		
	</div>
</div>
	<table id="relatedPageGrid"></table>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script>
    $("#relatedPageGrid").jqGrid({
        url: 'bpm/business/related/relatedData',
        postData:{
        	pid : "<%=id%>"
        },
        mtype: 'POST',
        datatype: "json", 
        colModel: [
			  {label: 'dbid', name: 'dbId', key : true,width: 150,hidden:true}
			, {label: '关联流程名称', name: 'title', width: 150,formatter : getTraceButtons}		
			, {label: '申请时间', name: 'time', width: 150,formatter : function(value, rec) {
				var startdateMi = value;
				if (startdateMi == undefined) {
					return '';
				}
				var newDate = new Date(startdateMi);
				return newDate.format("yyyy-MM-dd hh:mm:ss");
			}
}
			, {label: '状态', name: 'businessState', width: 150,
				formatter : function(cellvalue, options, rowObject) {
					if (cellvalue == 'start') {
						return '拟稿中';
					} else if (cellvalue == 'active') {
						return '流转中';
					} else if (cellvalue == 'ended') {
						return '已完成';
					}else{
						return cellvalue;
					}

				}
}
			, {label: '处理人', name: 'assigneeName', width: 150}
			, {label: '维护人', name: 'attribute01', width: 150}
			, {label: '维护时间', name: 'attribute02', width: 150}
            , {label: '流程实例ID', name: 'entryId1', width: 150,hidden:true}
            , {label: '关联流程实例ID', name: 'entryId2', width: 150,hidden:true}
        ],
        height:$(window).height()-120,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 100000000	,
        altRows:true,
        pagerpos:'left',
        loadonce: true,
        styleUI : 'Bootstrap',
        multiselect: true,
        autowidth: true,
        shrinkToFit: true,
        responsive:true,//开启自适应 
    });
    
    function getTraceButtons(cellvalue, options, rowObject){
		if(cellvalue==undefined || cellvalue==''){
			cellvalue=rowObject.name;
			if(cellvalue==undefined || cellvalue==''){
				cellvalue="无";
			}
		}
		return '<a href="javascript:void(0)" onClick="flowUtils.detail(\''+rowObject.entryId2+'\',\'2\')">'+cellvalue+'</a>';
	}
    

    
    //关键字查询
    function searchByKey(){
    	var data = $("#related_keyWord").val() == $("#related_keyWord").attr(
		"placeholder") ? "" : $("#related_keyWord").val();
		
		var searchdata = {
				keyWord : null,
				data : data,
				param : null
			}
			$('#relatedPageGrid').jqGrid('setGridParam', {
				datatype : 'json',
				postData : searchdata
			}).trigger("reloadGrid")
    }
    function reload1(){
    	var searchdata = {
			} 
			$('#relatedPageGrid').jqGrid('setGridParam', {
				datatype : 'json',
				postData : searchdata
			}).trigger("reloadGrid")
    }
    
    $(document).ready(function() {
		var searchSubNames = new Array();
		var searchSubTips = new Array();
		searchSubNames.push("title");
		searchSubTips.push("流程名称");
		$('#related_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
		
		//关键字段查询按钮绑定事件
		$('#related_searchPart').bind('click', function() {
			searchByKey();
		});
		
		//查询框回车事件
		$("#related_keyWord").keydown(function(event) {  
	         if (event.keyCode == 13) { 
	        	 searchByKey();
	         }  
	     });
		//删除绑定事件
	     $('#related_del').bind('click', function() {
	    	 	var _self = this;
	    		var rows = $('#relatedPageGrid').jqGrid('getGridParam', 'selarrrow');
	    		var ids = [];
	    		var l = rows.length;
	    		if (l > 0) {
	    			layer.confirm('确认要删除选中的数据吗?', {
	    				icon : 3,
	    				title : "提示",
	    				area : [ '400px', '' ]
	    			}, function(index) {
	    				for (; l--;) {
	    					ids.push(rows[l]);
	    				}
	    				avicAjax.ajax({
	    					url : 'bpm/business/related/relatedDelData',
	    					data : JSON.stringify(ids),
	    					contentType : 'application/json',
	    					type : 'post',
	    					dataType : 'json',
	    					success : function(r) {
	    						if (r.flag == "success") {
	    							layer.msg('删除成功！');
	    							reload1();
	    						} else {
	    							layer.alert('删除失败！' + r.error, {
	    								icon : 7,
	    								area : [ '400px', '' ],
	    								closeBtn : 0,
	    								btn : [ '关闭' ],
	    								title : "提示"
	    							});
	    						}
	    					}
	    				});
	    				//layer.close(index);
	    			});
	    		} else {
	    			layer.alert('请选择要删除的数据！', {
	    				icon : 7,
	    				area : [ '400px', '' ], //宽高
	    				closeBtn : 0,
	    				btn : [ '关闭' ],
	    				title : "提示"
	    			});
	    		}
		});
	     $('#related_add').bind('click', function() {
	    	 this.index = layer.open({
					type : 2,
	    			area : [ '100%', '100%' ],
	    			title : '相关流程',
	    			skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
	    			maxmin : false, //开启最大化最小化按钮
	    			btn: ['保存','返回'],
	    			content : "avicit/platform6/bpmreform/bpmbusiness/include/relatedBpmAdd.jsp?instId="+"<%=id%>",
	    			yes : function(index1,layero){
	    				var body = layer.getChildFrame('body', index1);
	    				var selectedRowIds = body.find("#firstjqGrid").getGridParam("selarrrow");//行数据 
	    				var len = selectedRowIds.length;
	    				for(var i=0;i<len;i++){
	    					var rowData = body.find("#firstjqGrid").getRowData(selectedRowIds[i]);
	    					avicAjax.ajax({
	    						url : 'bpm/business/related/relatedSaveData',
	    						data : {
	    							dbid1 : "<%=id%>",
	    							dbid2 : rowData["dbId"]
	    						},
	    						type : 'post',
	    						dataType : 'json',
	    						success : function(r) {
	    							if (r.flag == "success") {
	    								layer.msg('保存成功！');
	    								layer.close(index1);
	    								reload1();
	    							} else if(r.flag == 'exist'){
	    								layer.alert('数据存在！', {
	    									icon : 7,
	    									area : [ '400px', '' ], //宽高
	    									closeBtn : 0,
	    									btn : [ '关闭' ],
	    									title : "提示"
	    								});
	    							}else {
	    								layer.alert('保存失败！', {
	    									icon : 7,
	    									area : [ '400px', '' ], //宽高
	    									closeBtn : 0,
	    									btn : [ '关闭' ],
	    									title : "提示"
	    								});
	    							}
	    						}
	    					});
	    				}
				        
	    			}
				})
	     });

	});

</script>
</html>