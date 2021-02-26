<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

</head>
<body class=" easyui-layout" fit="true">
	<div id="toolbar_bpmTask" class="toolbar">
		<div class="toolbar-right">
			<div class="input-group form-tool-search" >
				<input type="text" name="search_keyWord"
					id="search_keyWord" style="width:240px;"
					class="form-control input-sm" placeholder="请输入流程名称查询"> <label
					id="search_keyWordPart"
					class="icon icon-search form-tool-searchicon"></label>
			</div>		
		</div>
	</div>
	<table id="jqGrid"></table>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script>
	$(function() {
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		var parentId = decodeURIComponent(flowUtils.getUrlQuery("id"));
		var parentObj = parent.$("#"+parentId).data("data-object");
		var process = parentObj.process;
		var multiple = parentObj.multiple;
		var dataVal = parent.$("#"+parentId).val();
		var dataGridColModel = [ {
			label : '流程名称',
			name : 'displayName',

			width : 150
		}, {
			label : '流程key',
			name : 'key',
			width : 150
		}, {
			name : 'id',
            key :true,
            hidden:true
		}
		/* ,
		 {
			label : '流程描述',
			name : 'desc',
			width : 150
		} */
		];
		
		var jq = $('#jqGrid').jqGrid({
			url : "platform/bpm/bpmdesigner/bpmWebDesigner/getAllProcessList",
			mtype : 'POST',
			datatype : "json",
            postData:{flowKey:"",flowName:""},
			colModel : dataGridColModel,
			height : $(window).height() - 120,
			scrollOffset : 20, //设置垂直滚动条宽度
			altRows : true,
			userDataOnFooter : true,
			loadonce : true,
			viewrecords : true,
			styleUI : 'Bootstrap',
			viewrecords : true,
			autowidth : true,
			responsive : true,//开启自适应  
			multiboxonly : false,
			multiselect : multiple,
			onSelectAll : multiple,
			rowNum:-1,
			gridComplete : function() {
				/*  if (dataVal) {
					var pos = dataVal.split(';');
					for ( var o = 0; o < pos.length; o++) {
						var id = pos[o];
						$(this).jqGrid("setSelection", id);
					}
				}  */
			}
		});
		parentObj.jqGrid = jq;
//		if(process) {
//		/* 	{"alias":"123","name":"123","initExpr":"1432","type":"string","desc":"4324"} */
//			var i = 1;
//			 parent.$("#"+process.id +" table[name='table-flow-variable']").find("input[name='dataValue']").each(function(){
//				 jq.addRowData(i,JSON.parse($(this).val()));
//				 i++;
//			});
//			 if (dataVal) {
//					var rowDataArr = parentObj.jqGrid.getRowData();
//					var pos = dataVal.split(';');
//					for ( var o = 0; o < pos.length; o++) {
//						var alias = pos[o];
//						for (var j = 0 ; j < rowDataArr.length; j++) {
//							if (rowDataArr[j].alias == alias) {
//								parentObj.jqGrid.setSelection(j+1);
//							}
//
//						}
//					}
//				}
//		}
		
		$("#search_keyWord").on('keydown', function(e) {
			if (e.keyCode == '13') {
				var searchdata = {
					flowName : $("#search_keyWord").val()
				};
				jq.jqGrid('setGridParam', {
					datatype : 'json',
					postData : searchdata
				}).trigger("reloadGrid");
			}
		});
		$(".icon-search").on('click', function() {
			var searchdata = {
				flowName : $("#search_keyWord").val()
			};
			jq.jqGrid('setGridParam', {
				datatype : 'json',
				postData : searchdata
			}).trigger("reloadGrid");
		});
	});
	
</script>
</body>
</html>
