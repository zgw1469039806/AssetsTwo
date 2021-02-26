    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
        <%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
        <%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
            <% String importlibs = "common,tree,table,form";%>
        <!DOCTYPE html>
        <html>
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>父级菜单选择</title>
        <base href="<%=ViewUtil.getRequestPath(request)%>">

        <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
            <jsp:param value="<%=importlibs%>" name="importlibs"/>
        </jsp:include>
       <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
        <style type="text/css">
        .fmt_opt{
        min-width: 8px;

        }
        .jqgrow td a {
        color:#fff;
        }
        .ztree li span.button.switch{
            left: 26px;
        }
        </style>
        </head>
        <body class="easyui-layout" fit="true">

        <div data-options="region:'center',split:true" style="width: 250px;border-top-style: hidden;">
        <%--<div class="row" style="margin: 5px;">--%>
        <div id="tableToolbarM" class="toolbar" >
        <div class="toolbar-left" style="width: 96%;">
        <div class="input-group input-group-sm" style="width: 100%;">
        <input class="form-control" placeholder="输入名称查询" type="text" id="txt" name="txt">
        <span class="input-group-btn">
        <button id="searchbtn" class="btn btn-default" type="button"><span class="glyphicon
        glyphicon-search"></span></button>
        </span>
        </div>
        </div>
        </div>
        <div id='div' style="overflow:auto;">
        <ul id="menuselect" class="ztree"></ul>
        </div>
        <%--</div>--%>
        </div>
        <div data-options="region:'south',border:false" style="height: 60px;">
        <div id="toolbar"
        class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
        <tr>
        <td width="100%" style="padding-right:4%;float:right;display:block;" align="right">
        <a href="javascript:void(0)" onclick="saveDialog();" style="margin-right:10px;" class="btn btn-primary
        form-tool-btn typeb btn-sm" role="button" title="保存" id="demoSingle_saveForm">保存</a>
        <a href="javascript:void(0)" onclick="closeDialog();" class="btn btn-grey form-tool-btn btn-sm" role="button"
        title="返回" id="demoSingle_closeForm">返回</a>
        </td>
        </tr>
        </table>
        </div>
        </div>
        </body>

        <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
            <jsp:param value="<%=importlibs%>" name="importlibs"/>
        </jsp:include>
        <script type="text/javascript" src="avicit/platform6/console/menu/js/MenuSelectTree.js" ></script>
        <script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>

        <script type="text/javascript">
        var menuTree;
        $(function(){
                //默认是前台菜单
                var menuTypeUrl = (parent.parent.menuTree.getUrl() == '') ? 'console/menu/console/1-ORG_ROOT-1-zh_CN' :
                parent.parent.menuTree.getUrl();
                //菜单树初始化
                menuTree = new MenuTree('menuselect',menuTypeUrl,'','txt','searchbtn');

                menuTree.setOnSelect(function(treeNode) {
                pId=treeNode.id;
                }).init();
        });
        //关闭
        function closeDialog(){
                parent.layer.close(parent.layer.index);
        }
        //保存
        function saveDialog(){
                treeNode = menuTree._selectNode;
                parent.setParentMenu(treeNode);
                //parent.layer.close(parent.layer.index);
        }
        </script>
        </html>
