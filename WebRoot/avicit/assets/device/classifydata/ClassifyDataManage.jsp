<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
    String importlibs = "common,tree,form";
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!-- ControllerPath = "assets/device/classifydata/classifyDataController/toClassifyDataManage" -->
    <title>管理</title>

    <base href="<%=ViewUtil.getRequestPath(request)%>">

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

    <!-----------------------------------------zTree需要引入的css------------------------------------------->
    <link type="text/css" rel="stylesheet" href="static/css/zTree_v3/zTreeStyle/zTreeStyle.css">

    <!-----------------------------------------zTree需要引入的js------------------------------------------->
    <script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="static/js/zTree_v3/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="static/js/zTree_v3/jquery.ztree.exhide.js"></script>
    <script type="text/javascript" src="static/js/zTree_v3/jquery.ztree.exedit.js"></script>
    <script type="text/javascript" src="static/js/zTree_v3/jquery.ztree.excheck.js"></script>
    <script type="text/javascript" src="static/js/zTree_v3/fuzzysearch.js"></script>

    <!-- 切换卡 样式 -->
    <link href="avicit/platform6/switch_card/yyui.css" rel="stylesheet" type="text/css">
</head>

<style>
    .menuIco{
        width:20px;
        height:20px;
        float:left;
        text-align:center;
        background-color:#C9C9C9;
    }
    .menuContent{
        width:115px;
        height:20px;
        background-color:#DCDCDC;
    }
</style>

<body>
    <!-- 切换卡 -->
    <div class="yyui_tab" style="position:relative; z-index:1;">
        <ul>
            <li class="yyui_tab_title_this" onclick="switchTab('NationalStandard')">国标分类</li>
            <li class="yyui_tab_title" onclick="switchTab('MilitaryStandard')">军标分类</li>
            <li class="yyui_tab_title" onclick="switchTab('MeasureClassify')">计量分类</li>
        </ul>
    </div>

    <!-- 页面主体 -->
    <div class="easyui-layout" fit="true" >
        <div data-options="region:'west',split:true,onResize:function(a){do_resize(a);}" style="width:300px">
            <div  class="easyui-layout" style="height:100%;width:100%" >
                <div data-options="region:'north',border:'0px',split:false" style="height:40px;width:100%">
                    <div class="input-group  input-group-sm" style="width:100%">
                        <input class="form-control" placeholder="回车查询" type="text" id="classifyKey" name="classifyKey">
                        <span class="input-group-btn">
                        <button id="searchbtn" class="btn btn-default ztree-search" type="button"><span class="glyphicon glyphicon-search"></span></button>
                      </span>
                    </div>
                </div>
                <ul id="classifyTree" class="ztree" style='width:300px; margin-top:40px; height:805px;'></ul>
            </div>
        </div>
        <div data-options="region:'center',title:'编码规则'">
            <div class="easyui-layout" data-options="fit:true">
                <div data-options="region:'north'" style="height:40px;">
                    <div id="tableToolbar" class="toolbar">
<%--                        <div class="toolbar-left">--%>
<%--                            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_classifyData_save_" permissionDes="保存">--%>
<%--                                <a href="javascript:;" id="classifyData_save" class="btn btn-primary form-tool-btn typeb btn-sm"  title="保存"><i class="fa fa-file-text-o"></i> 保存</a>--%>
<%--                            </sec:accesscontrollist>--%>
<%--                            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_classifyData_insert_" permissionDes="添加平级节点">--%>
<%--                                <a href="javascript:;" id="classifyData_insert1" class="btn btn-primary form-tool-btn btn-sm"  title="添加平级节点" ><i class="fa fa-plus"></i> 添加平级节点</a>--%>
<%--                            </sec:accesscontrollist>--%>
<%--                            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_classifyData_insertsub_" permissionDes="添加子节点">--%>
<%--                                <a href="javascript:;" id="classifyData_insertSub1" class="btn btn-primary form-tool-btn btn-sm"  title="添加子节点" ><i class="fa fa-plus"></i> 添加子节点</a>--%>
<%--                            </sec:accesscontrollist>--%>
<%--                            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_classifyData_del_" permissionDes="删除">--%>
<%--                                <a href="javascript:;" id="classifyData_del1" class="btn btn-primary form-tool-btn btn-sm"  title="删除"><i class="fa fa-trash-o"></i> 删除</a>--%>
<%--                            </sec:accesscontrollist>--%>
<%--                        </div>--%>
                    </div>
                </div>
                <div data-options="region:'center',split:true">
                </div>
            </div>
        </div>
    </div>

    <!-- 添加/编辑分类 -->
    <div class="layui-layer layer-anim layui-layer-iframe bs-modal" id="addClassifyDialog" style="position:absolute; top:30%; left:40%;display:none">
        <div class="layui-layer-title" style="cursor: move;" move="ok" id="dialogTitle">添加分类</div>
        <div class="layui-layer-content">
            <div data-options="region:'center',split:true,border:false">
                <form id='classifyForm'>
                    <input type="hidden" name="id" id="id"/>
                    <input type="hidden" name="parentId" id="parentId"/>
                    <input type="hidden" name="parentCode" id="parentCode"/>
                    <input type="hidden" name="belongCategory" id="belongCategory"/>

                    <table class="form_commonTable">
                        <tr>
                            <th width="30%">
                                <label for="name"><i class="required">*</i>分类名称:</label></th>
                            <td width="70%">
                                <input class="form-control input-sm" type="text" name="name" id="name"/>
                            </td>
                        </tr>

                        <tr>
                            <th width="30%">
                                <label for="code"><i class="required">*</i>分类编号:</label></th>
                            <td width="70%">
                                <input type="hidden" name="code" id="code"/>
                                <input type="text" id="fatherCode" placeholder="父分类编号" style='width:90px; height:30px; border:1px solid #CCC; border-radius:4px' readonly/>—
                                <input type="text" id="sonCode" style='width:90px; height:30px; border:1px solid #CCC; border-radius:4px'/>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>

            <div data-options="region:'south',border:false" style="height: 60px;">
                <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
                    <table class="tableForm" style="border:0;cellspacing:1;width:100%">
                        <tr>
                            <td width="50%" style="padding-right:4%;" align="right">
                                <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="classifyData_saveForm">保存</a>
                                <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="classifyData_closeForm">返回</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- 鼠标右键菜单 -->
    <div id="treeMenu" style='width:110px; position:absolute; display:none; z-index:100;'>
        <div id='rMenuDetail'>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_classifyData_save_" permissionDes="新增同级分类">
                <div style='display:block;'>
                    <div class="menuIco"><i class="fa fa-plus"></i></div>
                    <div class="menuContent" id="classifyData_insert">&nbsp;&nbsp;新增同级分类</div>
                </div>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_classifyData_save_sub_" permissionDes="新增子分类">
                <div style='display:block;'>
                    <div class="menuIco"><i class="glyphicon glyphicon-plus-sign"></i></div>
                    <div class="menuContent" id="classifyData_insertSub">&nbsp;&nbsp;新增子分类</div>
                </div>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_classifyData_modify_" permissionDes="编辑分类">
                <div style='display:block;'>
                    <div class="menuIco"><i class="fa fa-file-text-o"></i></div>
                    <div class="menuContent" id="classifyData_modify">&nbsp;&nbsp;编辑分类</div>
                </div>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_classifyData_del_" permissionDes="删除分类">
                <div style='display:block;'>
                    <div class="menuIco"><i class="fa fa-trash-o"></i></div>
                    <div class="menuContent" id="classifyData_del" style="border-bottom: solid 1px #FFFFFF;">&nbsp;&nbsp;删除分类</div>
                </div>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_classifyData_up_" permissionDes="上移分类">
                <div style='display:block;'>
                    <div class="menuIco"><span class="glyphicon glyphicon-arrow-up"></span></div>
                    <div class="menuContent" id="classifyData_up">&nbsp;&nbsp;上移分类</div>
                </div>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_classifyData_down_" permissionDes="下移分类">
                <div style='display:block;'>
                    <div class="menuIco"><span class="glyphicon glyphicon-arrow-down"></span></div>
                    <div class="menuContent" id="classifyData_down">&nbsp;&nbsp;下移分类</div>
                </div>
            </sec:accesscontrollist>
        </div>
    </div>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

    <!-- 模块js -->
    <script src="avicit/assets/device/classifydata/js/ClassifyData.js" type="text/javascript"></script>

    <!-- 切换卡的js -->
    <script src="avicit/platform6/switch_card/yyui.js"></script>

    <script type="text/javascript">
        var classifyData;

        //获取树节点信息
        var zNodes = ${classifyJson};

        //当前所属分类
        var currentCategory = 'NationalStandard';

        //切换卡切换
        function switchTab(tabId){
            if(currentCategory != tabId){
                currentCategory = tabId;

                avicAjax.ajax({
                    url: '${url}' + '/getClassifyTree',
                    data: {belongCategory : currentCategory},
                    type : 'post',
                    dataType : 'json',
                    success : function(result){
                        if (result.flag == "success"){
                            zNodes = JSON.parse(result.classifyJson);
                            classifyData = new ClassifyData(zNodes, 'classifyTree', '${url}', 'classifyForm', currentCategory, 'classifyKey');
                        }
                        else{
                            layer.alert('分类树获取失败：' + result.msg, {
                                    icon: 7,
                                    area: ['400px', ''],
                                    closeBtn: 0,
                                    btn: ['关闭'],
                                    title:"提示"
                                }
                            );
                        }
                    }
                });
            }
        }

        function do_resize(a){
            $("#_tree-center").width(a-20);
            $(".layout-panel-north").width(a);
            $(".layout-panel-center").width(a-10);
        }
        $(document).ready(function(){
            classifyData = new ClassifyData(zNodes, 'classifyTree', '${url}', 'classifyForm', currentCategory, 'classifyKey');

            //添加同级分类
            $('#classifyData_insert').bind('click', function(){
                classifyData.openDialog('Add');
            });

            //添加子分类
            $('#classifyData_insertSub').bind('click', function(){
                classifyData.openDialog('AddSub');
            });

            //编辑按钮绑定事件
            $('#classifyData_modify').bind('click', function(){
                classifyData.openDialog('Edit');
            });

            //保存按钮绑定事件
            $('#classifyData_saveForm').bind('click', function(){
                classifyData.save();
            });

            //返回按钮绑定事件
            $('#classifyData_closeForm').bind('click', function(){
                hiddenElement('addClassifyDialog');  //隐藏新增/编辑分类弹框
            });

            //删除按钮绑定事件
            $('#classifyData_del').bind('click', function(){
                classifyData.del();
            });

            //上移按钮绑定事件
            $('#classifyData_up').bind('click', function(){
                classifyData.upDownNode('prev');
            });

            //下移按钮绑定事件
            $('#classifyData_down').bind('click', function(){
                classifyData.upDownNode('next');
            });
        });
    </script>
</body>
</html>