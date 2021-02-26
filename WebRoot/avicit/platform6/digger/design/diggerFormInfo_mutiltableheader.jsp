<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form,tree";
%>
<!DOCTYPE html>
<HTML>
<head>
<title>${diggername}-设计-多级表头</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ui-1.9.2.custom/css/base/jquery-ui-1.9.2.custom.css"/>
<style type="text/css">
    a{
        color : #555;
    }

    .img-delete {
         position: absolute;
         top: 0px;
         right: 0px;
         dispaly: inline-block;
         z-index: 2;
         font-size: 15px;
         width: 20px;
         height: 20px;
         background-color: #ffffff;
         text-align: center;
         opacity:0.7
     }
    .img-delete:hover{
        cursor: pointer;
        opacity:0.9;
    }
</style>
<script type="text/javascript">
	var uid='${uid}';
</script>
</head>
<body class="easyui-layout" fit="true">
	<form id="form">
        <input type="hidden" id="diggerId" name="diggerId" value="${diggerId}" />
        <div id="queryTableToolbar" class="toolbar">
            <div class="toolbar-left">
                <a id="multiHeader_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
                   role="button" title="添加"><i class="icon icon-add"></i> 添加</a>
                <a id="multiHeader_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button"
                   title="删除"><i class="icon icon-delete"></i> 删除</a>
            </div>
        </div>
        <table id="mutilHeaderGrid"></table>
        <div>
            <font color="red">注：</font>每级表头需要跨越：${colSpanTotal}列<br>
            表头所跨列数根据【显示字段】中字段定义从上向下依次跨越
        </div>
    </form>
	<input type="hidden" id="datasourcetype" name="datasourcetype" value="${datasourcetype}">
	<input type="hidden" id="diggerUrl" name="diggerUrl" value="${diggerUrl}">
	<input type="hidden" id="colSpanTotal" name="colSpanTotal" value="${colSpanTotal}">
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
	<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
	<script src="avicit/platform6/digger/design/js/DiggerMutilHeaderGrid.js"></script>

	<script type="text/javascript">
        //定义查询器datatable
        var mutilHeaderGridModel = [
            {
                label : 'id',
                name : 'id',
                width : 75,
                sortable : false,
                hidden : true
            }, {
                label : '<span class="remind">*</span>'+'表头列名称',
                name : 'headerName',
                width : 100,
                sortable : false,
                editable : true

            }, {
                label : '所处层级',
                name : 'layer',
                width : 100,
                editable : true,
                sortable : false,
                edittype : 'select',
                editoptions:{
                    defaultValue:1,
                    value:{1:'一级表头',2:'二级表头',3:'三级表头'}
                },
                formatter : formatLayerTypeColumn
            }, {
				label : '跨越列数(colspan)',
				name : 'colspan',
				width : 100,
				editable : true,
				sortable : false,
				edittype : ''
			}, {
				label : '排序',
				name : 'colspan',
				width : 100,
				editable : true,
				sortable : false,
				edittype : ''
			}
        ];
        var diggerMutilHeaderGrid;
        $(function() {
			diggerMutilHeaderGrid = new DiggerMutilHeaderGrid('mutilHeaderGrid','${url}',mutilHeaderGridModel,'${diggerId}');
            $('#multiHeader_insert').bind('click', function() {
				diggerMutilHeaderGrid.insert();
            });
            $('#multiHeader_del').bind('click', function() {
				diggerMutilHeaderGrid.del();
            });
            // $('#query_save').bind('click', function() {
            //     diggerQueryGrid.save($('#queryForm'));
            // });
        });
        function saveMutilTableHeader() {
			diggerMutilHeaderGrid.save($('#form'));
        }
	</script>
</body>
</html>