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
	<title>自动编码</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-right">
		<div class="input-group form-tool-search">
			<input type="text" name="keyWord" id="keyWord" style="width: 240px;" class="form-control input-sm" placeholder="请输入查询条件">
			<label id="sysAutoCode_searchPart" class="icon icon-search form-tool-searchicon"></label>
		</div>
	</div>
</div>
<table id="sysAutoCodejqGrid"></table>
<div id="jqGridPager"></div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
    var callback = null;
    var searchNames = new Array();
    var searchTips = new Array();
    var codetableName = "";
    var codefieldName = "";

    function init(o){
        callback = o.callback;
    };

    //修改是否有效的显示式样
    function formatterValidFlag(cellvalue, options, rowObject) {
        var validString;
        if(cellvalue == "Y"){
            validString = "有效";
        }else{
            validString = "无效";
        }
        return validString;
    };

    //返回是否有效的值
    function unFormatterValidFlag(cellvalue, options, cellobject) {
        var validString;
        if(cellvalue == "有效"){
            validString = "Y";
        }else{
            validString = "N";
        }
        return validString;
    };

    function initGrid(){
		$('#sysAutoCodejqGrid').jqGrid({
			url:'platform/sysautocode/sysAutoCodeManageController/getSysAutoCodesByPageForWa',
			mtype: 'POST',
			datatype: "json",
			postData:{tableName:codetableName,colName:codefieldName},
			toolbar: [true,'top'],
			colModel: [	{label : 'id', name : 'id', key : true, width : 75,hidden : true},
				{label : '编码代码', name : 'code', width : 150},
				{label : '编码名称', name : 'name', width : 150},
				{label : '编码样式', name : 'style', width : 200},
				{label : '绑定表', name : 'tableName', width : 150 },
				{label : '绑定字段', name : 'columnName', width : 150},
				{label : '创建时间', name : 'creationDate', width : 150, align:"center"},
				{label : '是否有效', name : 'validFlag', width : 100, align:"center", formatter:formatterValidFlag, unformat:unFormatterValidFlag}
			],
			height:$(window).height()-120,
			scrollOffset: 20, //设置垂直滚动条宽度
			rowNum: 20	,
			rowList:[200,100,50,30,20,10],
			altRows:true,
			userDataOnFooter: true,
			pagerpos:'left',
			loadonce: false,
			loadComplete:function(){
				//$(this).jqGrid('getColumnByUserIdAndTableName');
			},
			styleUI : 'Bootstrap',
			viewrecords: true,
			multiselect: true,
			multiboxonly: true,
			autowidth: true,
			shrinkToFit: true,
			hasTabExport:false,
			hasColSet:false,
			responsive:true,//开启自适应
			pager: "#jqGridPager",
			/*onSelectRow : function(rowid, status) {
                var rowData = $(this).jqGrid('getRowData', rowid);
                rowObjData = rowData;
            },*/
			ondblClickRow:function(rowid,iRow,iCol,e){//双击
				var rowData = $(this).jqGrid('getRowData', rowid);
				//parent.$("#" + codeFiled).attr("value", rowData.code);
				if(typeof(callback) == 'function'){
					callback(rowData);
				}
			}
		});
		$('#t_sysAutoCodejqGrid').append($("#tableToolbar"));

		$('.dropdown-menu').click(function(e) {
			e.stopPropagation();
		});
		//查询按钮绑定事件
		$('#sysAutoCode_searchPart').on('click', function() {
			searchByKeyWord();
		});
		$('#keyWord').on('keydown',function(e){
			if(e.keyCode == '13'){
				searchByKeyWord();
			}
		});
	}

    $(document).ready(
        function() {
            searchNames.push("code");
            searchTips.push("编码代码");
            searchNames.push("name");
            searchTips.push("编码名称");
            $('#keyWord').attr('placeholder','请输入' + searchTips[0] + '或' + searchTips[1]);
            //sysAutoCode = new SysAutoCode('sysAutoCodejqGrid', 'keyWord', searchNames);



        });

    //关键字段查询
    function searchByKeyWord(){
        var keyWord = $('#keyWord').val() == $('#keyWord').attr("placeholder") ? "" : $('#keyWord').val();
        var names = searchNames;

        var param = {};
        for(var i in names){
            var name = names[i];
            param[name] = keyWord;
        }
        var searchdata = {
            keyWord: JSON.stringify(param)
        }
        $('#sysAutoCodejqGrid').jqGrid("setGridParam",{postData: searchdata,datatype:"json"}).trigger("reloadGrid");
    }

    //返回选择数据
	function getSelectedData(){
        var rows = new Array();
        var ids = $("#sysAutoCodejqGrid").jqGrid('getGridParam', 'selarrrow');
		if(ids.length > 0){
            for(var i in ids){
                var rowData = $("#sysAutoCodejqGrid").jqGrid('getRowData', ids[i]);
                rows.push(rowData)
            }
		}
        return rows;
	}
</script>
</html>