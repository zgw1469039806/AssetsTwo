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
<title>${diggername}-设计-查询器</title>
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
	<form id="queryForm">
        <input type="hidden" id="diggerId" name="diggerId" value="${diggerId}" />
        <div id="queryTableToolbar" class="toolbar">
            <div class="toolbar-left">
                <a id="query_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
                   role="button" title="添加"><i class="icon icon-add"></i> 添加</a>
                <a id="query_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button"
                   title="删除"><i class="icon icon-delete"></i> 删除</a>
            </div>
        </div>
        <table id="diggerQueryGrid"></table>
    </form>
	<input type="hidden" id="datasourcetype" name="datasourcetype" value="${datasourcetype}">
	<input type="hidden" id="diggerUrl" name="diggerUrl" value="${diggerUrl}">
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
	<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
	<script src="avicit/platform6/digger/design/js/DiggerQueryDataGrid.js"></script>

	<script type="text/javascript">
        //定义查询器datatable
        var dataGridQueryModel = [
            {
                label : 'id',
                name : 'id',
                width : 75,
                sortable : false,
                hidden : true
            }, {
                label : '<span class="remind">*</span>'+'列名称',
                name : 'fieldName',
                width : 200,
                sortable : false,
                editable : true,
                edittype : 'select'

            }, {
                label : '<span class="remind">*</span>'+'显示名称',
                name : 'fieldTitle',
                width : 200,
                sortable : false,
                editable : true
            },  {
                label : '关系',
                name : 'joinType',
                width : 50,
                editable : true,
                sortable : false,
                edittype : 'select',
                editoptions:{
                    defaultValue:'0',
                    value:{0:'与',1:'或'}
                },
                formatter : formatJoinTypeColumn
            },{
                label : '类型',
                name : 'rtFieldType',
                width : 100,
                sortable : false,
                editable : true,
                edittype : 'select',
                editoptions:{
                    value:{'text':'文本','num':'数值','date':'日期'},
                    defaultValue:'text'
                },
                formatter : formatRtFieldTypeColumn
            },{
                 label : '比较方式',
                 name : 'compareType',
                 width : 100,
                 sortable : false,
                 editable : true,
                 edittype : 'select',
                 editoptions:{
                     defaultValue:'='
                 },
                 formatter : formatCompareTypeColumn
             },{
                label : '展现类型',
                name : 'rtFieldDisplayType',
                width : 100,
                sortable : false,
                editable : true,
                edittype : 'select',
                editoptions:{
                    value:{'text':'文本','num':'数字','date':'日期','user':'选用户','dept':'选部门','org':'选组织','role':'选角色','group':'选群组','position':'选岗位'},
                    defaultValue:'text'
                },
                formatter : formatRtFieldDisplayTypeColumn
            },{
                label : '默认值',
                name : 'mapValueDef',
                width : 200,
                sortable : false,
                editable : true
            },{
                label : '表名称',
                name : 'entityName',
                width : 200,
                sortable : false,
                editable : false,
                hidden : false
            }
        ];
        var diggerQueryGrid;
        $(function() {
            diggerQueryGrid = new DiggerQueryDataGrid('diggerQueryGrid','${url}',dataGridQueryModel,'${diggerId}');
            $('#query_insert').bind('click', function() {
                diggerQueryGrid.insert();
            });
            $('#query_del').bind('click', function() {
                diggerQueryGrid.del();
            });
            // $('#query_save').bind('click', function() {
            //     diggerQueryGrid.save($('#queryForm'));
            // });
        });
        function saveQuery() {
            diggerQueryGrid.save($('#queryForm'));
        }
	</script>
</body>
</html>