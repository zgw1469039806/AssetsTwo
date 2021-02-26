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
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css-fixie8-fonticon.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style type="text/css">
#t_sysLookupType{
	display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',onResize:function(a){$('#sysLookupType').setGridWidth(a);$(window).trigger('resize');}">
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 220px;margin-left: 15px;" >
					<input type="text" name="sysLookupType_keyWord" 
						id="sysLookupType_keyWord" class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="sysLookupType_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
			</div>
		</div>
		<table id="sysLookupType"></table>
		<div id="sysLookupTypePager"></div>
	</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
var rowObjData;
var lookup_validFlag = {1:"有效",0:"无效"};
var lookuptypeid;
var callBack;
var idFiled;
var textFiled;
function init(o){
	lookuptypeid = o.lookuptypeid;	
	idFiled = o.idFiled;
	textFiled = o.textFiled;
	callBack = o.callBack;
};
$(document).ready(
	function() {
		var searchMainNames = new Array();
		var searchMainTips = new Array();
		searchMainNames.push("lookupType");
		searchMainTips.push("代码类型");
		searchMainNames.push("lookupTypeName");
		searchMainTips.push("代码名称");
		$('#sysLookupType_keyWord').attr('placeholder',
				'请输入' + searchMainTips[0] + '或' + searchMainTips[1]);

		var sysLookupTypeGridColModel = [ {
			label : 'id',
			name : 'id',
			key : true,
			width : 75,
			hidden : true
		}, {
			label : '应用ID',
			name : 'sysApplicationId',
			hidden : true,
			width : 150,
		},{
			label : '代码类型',
			name : 'lookupType',
			width : 150
		},{
			label : '代码类型名称',
			name : 'lookupTypeName',
			width : 150
		},{
			label : '代码类型描述',
			name : 'lookupTypeDesc',
			width : 150
		}, {
			label : '是否为系统初始 Y 是 N 否',
			name : 'systemFlag',
			hidden : true,
			width : 150
		}, {
			label : '是否有效',
			name : 'validFlag',
			width : 150,
			edittype : "custom",
			editoptions : {
				custom_element : selectElem,
				custom_value : selectValue,
				forId : 'PLATFORM_VALID_FLAG',
				value : lookup_validFlag
			}
		}, {
			label : '所属模块',
			name : 'belongModule',
			hidden : true,
			width : 150
		}, {
			label : '使用级别',
			name : 'usageModifier',
			width : 150
		} ];
		$('#sysLookupType').jqGrid({
			url :'console/lookup/operation/getSysLookupTypesByPage.json',
			mtype : 'POST',
			datatype : "json",
			toolbar : [ true, 'top' ],
			colModel : sysLookupTypeGridColModel,
			height : $(window).height() - 110 ,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
			scrollOffset : 10,
			rownumbers:true,
			rowNum : 20,
			rowList : [ 200, 100, 50, 30, 20, 10 ],
			altRows : true,
			userDataOnFooter : true,
			pagerpos : 'left',
			styleUI : 'Bootstrap',
			viewrecords : true,
			multiboxonly : true,
			hasColSet: false,
			hasTabExport: false,
			autowidth : true,
			shrinkToFit : true,
			responsive : true,
			pager : $('#sysLookupTypePager'),
			onSelectRow : function(rowid, status) {//单击
				var rowData = $(this).jqGrid('getRowData', rowid);
				rowObjData = rowData;			
			},
			ondblClickRow:function(rowid,iRow,iCol,e){//双击
				var rowData = $(this).jqGrid('getRowData', rowid);
				rowObjData = rowData;
				parent.$("#" + idFiled).attr("value", rowData.id);
				parent.$("#" + textFiled).attr("value", rowData.lookupType);
				if(callBack!=null && callBack!='undefined'){
					if(typeof(callBack) === 'function'){
			 			callBack(rowObjData);
			 		}
				}
				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				parent.layer.close(index);
			},
			loadComplete : function() {
				$(this).setSelection(lookuptypeid);
			}
		});
		$('#sysLookupType_keyWord').on('keydown', function(e) {
			if (e.keyCode == '13') {
				searchData();
			}
		});
		//关键字段查询按钮绑定事件
		$('#sysLookupType_searchPart').bind('click', function() {
			searchData();
		});
		
		function searchData(){
			var keyWord = $('#sysLookupType_keyWord').val()==$('#sysLookupType_keyWord').attr("placeholder") ? "" :  $('#sysLookupType_keyWord').val();
			var param = {};
			for ( var i in searchMainNames) {
				var name = searchMainNames[i];
				param[name] = keyWord;
			}
			var searchdata = {
				keyWord : JSON.stringify(param),
				param : null
			}
			$('#sysLookupType').jqGrid('setGridParam', {
				datatype : 'json',
				postData : searchdata
			}).trigger("reloadGrid");
		}
});
</script>
</html>