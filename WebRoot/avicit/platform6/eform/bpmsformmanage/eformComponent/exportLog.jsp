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
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',onResize:function(a){$('#sysLookupType').setGridWidth(a);$(window).trigger('resize');}">
		<div id="tableToolbar"  class="toolbar" style="height:38px;">
			<div class="toolbar-right">
				<div class="input-group-btn form-tool-searchbtn">
					<a id="consoleUser_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button"
					   title="高级查询">高级查询 <span class="caret"></span></a>
				</div>
			</div>
		</div>
		<table id="sysLookupType"></table>
		<div id="sysLookupTypePager"></div>
	</div>
	<!-- 高级查询 -->
	<div id="searchDialog" style="overflow: auto;display: none">
		<form id='form' style="padding: 10px;">
			<table class="form_commonTable">
				<tr>
					<th width="17%" style="word-break: break-all; word-warp: break-word;"><label
							for="positionbtn">操作人:</label></th>
					<td width="32%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="userId" name="userId" value=''>
							<input class="form-control" placeholder="请选择用户" type="text" id="userName"
								   name="userName">
							<span class="input-group-btn">
							        <button class="btn btn-default" type="button" id="userButton"><span
											class="glyphicon glyphicon-equalizer"></span></button>
							      </span>
						</div>
					</td>

					<th width="17%" style="word-break: break-all; word-warp: break-word;"><label for="status">导出结果:</label>
					</th>
					<td width="32%">

						<select id="opResult" name="opResult" class="form-control input-sm" title="导出结果">

							<option value="" selected="selected">无</option>
							<option value="1">成功</option>
							<option value="0">失败</option>

						</select>
					</td>
				</tr>
				<tr>
					<th>操作时间（开始）:</th>
					<td>
						<div class="input-group  input-group-sm">
						<input type="text" class="form-control input-sm cellinput-addon time-picker" id="exportDateStart" name="exportDateStart" >
						<span class="input-group-btn">
							        <button class="btn btn-default data-box-act" type="button" id="exportDateStartButton"><span
											class="glyphicon glyphicon-calendar"></span></button>
							      </span>
						</div>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="exportDateStart">操作时间（结束）:</label>
					</th>
					<td width="39%">
						<div class="input-group  input-group-sm">
						<input type="text" class="form-control input-sm cellinput-addon time-picker" id="exportDateEnd" name="exportDateEnd" >
						<span class="input-group-btn">
							        <button class="btn btn-default data-box-act" type="button" id="exportDateEndButton"><span
											class="glyphicon glyphicon-calendar"></span></button>
							      </span>
						</div>
					</td>
				</tr>

			</table>
		</form>
	</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
var rowObjData;
var lookuptypeid;
var callBack;
var idFiled;
var textFiled;

//打开高级查询框
function openSearchForm(searchDiv){
	var _self = this;

	var contentWidth = 740;
	var top =  $("#consoleUser_searchAll").offset().top + $("#consoleUser_searchAll").outerHeight(true);
	var left = $("#consoleUser_searchAll").offset().left + $("#consoleUser_searchAll").outerWidth() - contentWidth;
	if (left < 0){contentWidth = contentWidth + left; left = 0}
	var text = $("#consoleUser_searchAll").text();
	var width = $("#consoleUser_searchAll").innerWidth();


	layer.config({
		extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});

	layer.open({
		type: 1,
		shift: 5,
		title: false,
		scrollbar: false,
		move : false,
		area: [contentWidth + 'px', '200px'],
		offset: [top + 'px', left + 'px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['查询', '清空', '取消'],
		content: $(searchDiv),
		success : function(layero, index) {
			var serachLabel = $('<div class="serachLabel"><span>'+ text +'</span></div>').appendTo(layero);
			serachLabel.bind('click', function(){
				layer.close(index);
			});
			serachLabel.css('width', width + 'px');
		},
		yes: function(index, layero){
			searchData();
			layer.close(index);
		},
		btn2: function(index, layero){
			clearFormData($("#searchDialog"));

			return false;
		},
		btn3: function(index, layero){
			layer.close(index);
		}
	});
};


function searchData(){
	var searchdata = {
		param:JSON.stringify(serializeObject($("#form")))
	}
	$('#sysLookupType').jqGrid('setGridParam',{datatype: 'json',postData:searchdata }).trigger("reloadGrid");
};

function eventEdit(_this) {
	layer.open({
		type: 1,
		title: "日志内容",
		skin: 'layui-layer-rim',
		area: ['70%', '80%'],
		content: '<textarea id="logcontentarea" readonly style="width: 100%; height: 98%;">' + _this.text + '</textarea>'
	});
}

function formatlogContent(value){
	return '<a onclick="eventEdit(this)">'+value+'</a>';
}


function formatOpresult(value){
	if (value!=null && value!=""&& value !=undefined){
		if (value == "1"){
			return "成功";
		}else if (value == "0"){
			return "失败";
		}
	}else{
		return "";
	}
}
function init(o){
	lookuptypeid = o.lookuptypeid;	
	idFiled = o.idFiled;
	textFiled = o.textFiled;
	callBack = o.callBack;
};
$(document).ready(function() {



	$('.time-picker').datetimepicker({
		oneLine:true,
		closeText:'确定',
		showButtonPanel:true,
		showSecond:false,
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
			label : '操作人',
			name : 'userName',
			width : 40
		},{
			label : '操作时间',
			name : 'exportDate',
			width : 60
		},{
			label : '日志内容',
			name : 'logContent',
			width : 200,
			formatter: formatlogContent
		}, {
			label : '导出结果',
			name : 'opResult',
			width : 40,
			formatter: formatOpresult
		} ];
		$('#sysLookupType').jqGrid({
			url :'eform/bpmsComponentExportLogController/getLogPage.json',
			mtype : 'POST',
			datatype : "json",
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

		$('#consoleUser_searchAll').bind('click',function(){
			openSearchForm($("#searchDialog"));
		});

		$('#userName').on('focus',function(e){
			new H5CommonSelect({type:'userSelect', idFiled:'userId',textFiled:'userName',viewScope:'currentOrg'});
		});

		$('#userButton').on('click',function(e){
			$('#userName').trigger("focus");
		});

		$('#exportDateStartButton').click(function(e){
			$('#exportDateStart').datetimepicker('show');
			$('#exportDateStart').datetimepicker().trigger('click');
		});

		$('#exportDateEndButton').click(function(e){
			$('#exportDateEnd').datetimepicker('show');
			$('#exportDateEnd').datetimepicker().trigger('click');
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