<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
    String userId = (String) request.getParameter("userId");
    String portalFlag = (String) request.getParameter("portalFlag");
%>
<!DOCTYPE html>
<html>
<head>
    <title>查看个人权限</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <script type="text/javascript">

    </script>
</head>
<body>
<div id="tableToolbar" class="toolbar">
<div class="toolbar-right">
        <div class="input-group form-tool-search" style="width: 180px">
            <input type="text" name="sysUser_keyWord"
                   id="keyWord"
                   class="form-control input-sm" placeholder="请输入菜单名称">
            <label id="searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
    </div>
</div>
<table id="jqGrid"></table>

</body>

<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/console/user/js/consoleUser.js"
        type="text/javascript"></script>
<script type="text/javascript">


    $(document)
        .ready(
            function () {

                var dataGridColModel = [
                    {
                        label: 'id',
                        name: 'id',
                        index: 'id',
                        key: true,
                        width: 75,
                        hidden: true
                    },
                    {
                        label: '一级菜单',
                        name: 'name',
                        index: 'name',
                        width: 100,
                        align: 'center',
                        cellattr: function (rowId, tv, rawObject,
                                            cm, rdata) {

                            //合并单元格

                            return 'id=\'name' + rowId + "\'";

                        }
                    },
                    {
                        label: '二级菜单',
                        name: 'sencondName',
                        index: 'sencondName',
                        width: 200,
                        align: 'center',
                        cellattr: function (rowId, tv, rawObject,
                                            cm, rdata) {

                            //合并单元格

                            return 'id=\'sencondName' + rowId
                                + "\'";

                        }
                    },
                    {
                        label: '三级菜单',
                        name: 'thirdName',
                        index: 'thirdName',
                        width: 200,
                        align: 'center',
                        cellattr: function (rowId, tv, rawObject,
                                            cm, rdata) {

                            //合并单元格

                            return 'id=\'thirdName' + rowId + "\'";

                        }
                    },
                    {
                        label: '四级菜单',
                        name: 'fourthName',
                        index: 'fourthName',
                        width: 200,
                        align: 'center',
                        cellattr: function (rowId, tv, rawObject,
                                            cm, rdata) {

                            //合并单元格

                            return 'id=\'fourthName' + rowId + "\'";

                        }
                    }

                ];

                var newPath = null;
                portalFlag = <%=portalFlag%>;
                if(portalFlag == "1"){//前台用户
                    newPath = 'platform/ShowPermissController/portalfindUserResources.json?userId=' + '<%=userId%>';
                }else{//后台用户
                    newPath = 'platform/ShowPermissController/newfindUserResources.json?userId=' + '<%=userId%>';
                }

                $('#jqGrid')
                    .jqGrid(
                        {
                            //url: 'platform/ShowPermissController/newfindUserResources.json?userId=' + '<%=userId%>',
                            url: newPath,
                            mtype: 'POST',
                            datatype: "json",
                            colModel: dataGridColModel,
                            height: document.documentElement.clientHeight - 100,
                            rowNum: -1,
                            altRows: true,
                            pagerpos: 'left',
                            styleUI: 'Bootstrap',
                            viewrecords: true, //
                            autowidth: true,
                            hasColSet: false,
                            hasTabExport: false,
                            responsive: true,
                            gridComplete: function () {

                                var gridName = "jqGrid";
                                Merger(gridName, 'name');
                                Merger(gridName, 'sencondName');
                                Merger(gridName, 'thirdName');

                            }

                        });
                $("#t_jqGrid").append($("#tableToolbar"));
                $('#searchPart').bind('click', function () {
                    searchByKeyWord();
                });
                $('#keyWord').on('keydown',function(e){
            		if(e.keyCode == '13'){
            			searchByKeyWord();
            		}
            	});
                function Merger(gridName, CellName) {
                    var gridL = $("#" + gridName + "").getDataIDs();
                    var length = gridL.length;
                    for (var i = 0; i < length; i++) {
                        var before = $("#" + gridName + "").jqGrid(
                            'getRowData', gridL[i]);
                        var rowSpanTaxCount = 1;
                        for (j = i + 1; j <= length; j++) {
                            var end = $("#" + gridName + "").jqGrid(
                                'getRowData', gridL[j]);
                            if (before[CellName] == end[CellName]) {
                                rowSpanTaxCount++;
                                $("#" + gridName + "").setCell(
                                    gridL[j], CellName, '', {
                                        display: 'none'
                                    });
                            } else {
                                rowSpanTaxCount = 1;
                                break;
                            }
                            $("#" + CellName + "" + gridL[i] + "")
                                .attr("rowspan", rowSpanTaxCount);
                        }
                    }
                }
                function searchByKeyWord(){
                	var searchdata = {};
                	var keyWord=$("#keyWord").val();
                	searchdata={
                		keyWord:keyWord
                	}
                	$("#jqGrid").jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
                }

            });
</script>
</html>