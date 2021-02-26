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

    <title>自定义页面</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>"></base>
    <jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>

    <link rel="stylesheet" type="text/css" href="static/fixie/bsie/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="static/fixie/bsie/bootstrap/css/bootstrap-ie6.css">
    <link rel="stylesheet" type="text/css" href="static/fixie/bsie/bootstrap/css/ie.css">

</head>
<body class=" easyui-layout" fit="true">
    <div data-options="region:'center'" >
        <div id="tableToolbar" class="datagrid-toolbar" >

            <input id="dictionary_keyWord" class="easyui-searchbox" style="width:300px"
                   data-options="searcher:searchByKeyWord,prompt:'请输入查询条件'"></input>
        </div>
        <table id="dictionarydatagrid"></table>
    </div>
</body>

<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
<script type="text/javascript" src="static/h5/common-ext/avic.ajax.js"></script>

<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script
        src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script type="text/javascript">
    var mapping;
    var querySql;

    function initGrid(selectType, rowCnt,queryStatement,dataGridField,imapping){
        mapping = JSON.parse(imapping);
        querySql = queryStatement;
        $('#dictionary_keyWord').attr('placeholder','请输入搜索值！');

        var searchdata = {
            sql: queryStatement
        };

        var singleSelect = false;
        if(selectType == "1"){
            singleSelect = true;
        }
        $('#dictionarydatagrid').datagrid({
            fit: true,
            border: false,
            rownumbers: false,
            url: "eform/plugin/getDictionaryGridInfo",
            columns:[JSON.parse(dataGridField)],
            queryParams:searchdata,
            animate: true,
            collapsible: false,
            fitColumns: true,
            autoRowHeight: false,
            idField :'id',
            toolbar:'#tableToolbar',
            singleSelect: singleSelect,
            checkOnSelect: true,
            selectOnCheck: true,
            method:'post',
            pagination:true,
            pageSize:20,
            pageList:[ 200, 100, 50, 30, 20, 10 ],
            striped:true
        });
    }


    function searchByKeyWord(value,name){
        var searchdata = {
            keyWord : value,
            sql: querySql,
            mapParam: JSON.stringify(mapping)
        };

        $("#dictionarydatagrid").datagrid('load', searchdata)
    }

</script>
</html>