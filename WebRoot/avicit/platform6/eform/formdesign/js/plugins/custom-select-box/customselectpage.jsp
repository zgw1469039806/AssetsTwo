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
	<title>编码</title>
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

    function init(o){
        callback = o.callback;
    };

    $(document).ready(
        function() {
            searchNames.push("code_");
            searchTips.push("编码");
            searchNames.push("des_");
            searchTips.push("描述");
            $('#keyWord').attr('placeholder','请输入' + searchTips[0] + '或' + searchTips[1]);
            //sysAutoCode = new SysAutoCode('sysAutoCodejqGrid', 'keyWord', searchNames);

            $('#sysAutoCodejqGrid').jqGrid({
                url:'platform/console/sysdefinedselect/operation/getSysDefineSelectsByPage.json',
                mtype: 'POST',
                datatype: "json",
                toolbar: [true,'top'],
                colModel: [	{label : 'id', name : 'id', key : true, width : 75,hidden : true},
                    {label : '编码',
						name : 'code_',
						width : 150},
                    {label : '描述',
						name : 'des_',
						width : 150}
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