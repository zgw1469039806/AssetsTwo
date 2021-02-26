<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,table";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <style>
        .searchBox {
            padding: 5px;
            left: 0;
            top: 90px;
            width: 199px;
            background: #fff
        }

        .searchBox input {
            color: #888888;
            font-size: 12px;
            padding-left: 14px;
            border-radius: 14px;
            background: #f3f4f9;
            border: 1px solid #EAECF2;
            height: 28px;
            line-height: 32px;
            width: 100%;
            padding: 0 46px 0 14px;
            outline: medium;
        }

        .searchBox i.clear {
            position: absolute;
            left: auto;
            right: 92px;
            font-size: 14px;
            width: 28px;
            height: 28px;
            text-align: center;
            line-height: 28px;
            cursor: pointer;
            color: #888888;
            display: none;
        }

        .searchBox i.query {
            position: absolute;
            left: auto;
            right: 75px;
            font-size: 14px;
            width: 28px;
            height: 28px;
            text-align: center;
            line-height: 28px;
            cursor: pointer;
            color: #888888;
        }

        .ui-jqgrid .ui-jqgrid-btable tbody tr.jqgrow td {
            padding-right: 2px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            word-break: break-all;
            vertical-align: middle;
            padding-top: 4px;
            padding-bottom: 4px;
        }
    </style>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='addForm'>
        <input type="hidden" id="eformComponentId" name="eformComponentId">

        <table class="form_commonTable">
            <tr class="add">
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formName">名称：</label>
                </th>
                <td width="35%">
                    <input title="名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="formName" id="formName"/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formCode">编码：</label>
                </th>
                <td width="35%">
                    <input title="编码" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="formCode" id="formCode"/>
                </td>
            </tr>

            <tr class="add">
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="orderBy">排序：</label>
                </th>
                <td width="35%">
                    <input title="排序" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="orderBy" id="orderBy"/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="formStyle">样式：</label>
                </th>
                <td width="35%">
                    <select id="formStyle" name="formStyle" class="form-control">
                        <%-- <option value="easyui">EasyUI</option>--%>
                        <option value="bootstrap" selected>Bootstrap</option>
                    </select>
                </td>
            </tr>

            <tr class="add">
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="isBpm">是否流程表单</label>
                </th>
                <td width="35%">
                    <label class="radio-inline">
                        <input type="radio" name="isBpm" value="Y" checked>是
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="isBpm" value="N" >否
                    </label>
                </td>

                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="dataSourceName">数据源：</label>
                </th>
                <td width="35%">
                    <div class="input-group input-group-sm">
                        <input type="hidden" id="dataSourceId" name="dataSourceId">
                        <input title="数据源" placeholder="请选择数据源" class="form-control input-sm" type="text"
                               id="dataSourceName" readonly/>
                        <span class="input-group-addon" id="dataSourceBtn"><i class="glyphicon glyphicon-menu-hamburger"></i></span>
                    </div>
                </td>
            </tr>

            <tr class="add">
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="userName">所属人员：</label>
                </th>
                <td width="35%">
                    <div class="input-group input-group-sm " style="width:100%;">
                        <input type="hidden" id="userId" name="userId" title="所属人员" >
                        <input type="text" class="form-control" id="userName" name="userName" style="" title="所属人员" >
                        <span class="input-group-addon user-box-act" id="userButton"> <i class="glyphicon glyphicon-user"></i> </span>
                    </div>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="deptName">所属部门：</label>
                </th>
                <td width="35%">
                    <div class="input-group input-group-sm ">
                        <input type="hidden" id="deptId" name="deptId" title="所属部门" >
                        <input type="text" class="form-control" style="" id="deptName" name="deptName" title="所属部门" >
                        <span class="input-group-addon dept-box-act" id="deptButton"> <i class="glyphicon glyphicon-equalizer"></i> </span>
                    </div>
                </td>
            </tr>
            <%--<tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="labelCount">每行控件数：</label>
                </th>
                <td width="35%">
                    <input type="number" id="labelCount" name="labelCount" title="每行控件数" class="form-control input-sm" value="2" min="1">
                </td>
                <td width="50%"colspan="2">生成后实际每行列数为每行控件数2倍</td>
            </tr>--%>

            <tr style="display: none;">
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="tableIsUpload">附件：</label>
                </th>
                <td width="35%">
                    <select id="tableIsUpload" name="tableIsUpload" class="form-control">
                        <option value="Y">是</option>
                        <option value="N" selected>否</option>
                    </select>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    &nbsp;
                </th>
                <td width="35%">
                    &nbsp;
                </td>
            </tr>
        </table>

        <div class="form_commonTable">
            <div class="toolbar">
                <div class="toolbar-left">
                    <a id="toAdd" href="javascript:void(0)"
                       class="btn btn-default form-tool-btn btn-sm btn-point" role="button"
                       title="添加"><i class="fa fa-plus"></i> 添加</a>
                    <a id="toCommonCol" href="javascript:void(0)"
                       class="btn btn-default form-tool-btn btn-sm" role="button"
                       title="常用字段"><i class="icon icon-cont"></i> 常用字段</a>
                    <a id="toDel" href="javascript:void(0)"
                       class="btn btn-default form-tool-btn btn-sm" role="button"
                       title="删除"><i class="fa fa-trash-o"></i> 删除</a>

                    <%--                    <a id="toMust" href="javascript:void(0)"--%>
                    <%--                       class="btn btn-default form-tool-btn btn-sm" role="button"--%>
                    <%--                       title="必填</">必填</a>--%>
                    <%--                    <a id="toUnMust" href="javascript:void(0)"--%>
                    <%--                       class="btn btn-default form-tool-btn btn-sm" role="button"--%>
                    <%--                       title="非必填">非必填</a>--%>
                    <div class="dropdown">
                        <a class="btn btn-primary form-tool-btn btn-sm" role="button" href="javascript:void(0);" data-toggle="dropdown" aria-expanded="false">批量必填设置<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
                            <li role="presentation"> <a id="toMust" href="javascript:void(0);" title="添加电子表单">必填</a></li>
                            <li role="presentation"> <a id="toUnMust" href="javascript:void(0);" title="添加电子表单新">非必填</a></li>
                        </ul>
                    </div>
                    <div class="dropdown">
                        <a class="btn btn-primary form-tool-btn btn-sm" role="button" href="javascript:void(0);" data-toggle="dropdown" aria-expanded="false">批量只读设置<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
                            <li role="presentation"> <a id="toDropdown" href="javascript:void(0);" title="添加电子表单">只读</a></li>
                            <li role="presentation"> <a id="toUnDropdown" href="javascript:void(0);" title="添加电子表单新">非只读</a></li>
                        </ul>
                    </div>
                    <div class="dropdown">
                        <a class="btn btn-primary form-tool-btn btn-sm" role="button" href="javascript:void(0);" data-toggle="dropdown" aria-expanded="false">批量显示设置<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
                            <li role="presentation"> <a id="toVisible" href="javascript:void(0);" title="添加电子表单">显示</a></li>
                            <li role="presentation"> <a id="toUnVisible" href="javascript:void(0);" title="添加电子表单新">非显示</a></li>
                        </ul>
                    </div>
                    <div class="dropdown">
                        <label for="labelCount" style="display: inline-block;vertical-align: middle;line-height: 32px;">每行列数：</label>
                        <input type="number" id="labelCount" name="labelCount" title="每行列数" class="form-control input-sm" style="display: inline-block;width: 70px;" value="4" min="2" max="10">
                    </div>
                    <a id="toPreview" href="javascript:void(0)"
                       class="btn btn-default form-tool-btn btn-sm" role="button"
                       title="删除"><i class="icon iconfont icon-preview"></i> 预览</a>
                </div>
                <div class="toolbar-right">

                    <div class="searchBox">
                        <input type="text" id="search" placeholder="请输入字段名称"> <i class="icon icon-guanbi1 clear" id="searchClear"></i><i class="icon icon-search_ query" id="searchQuery"></i>
                    </div>
                </div>
            </div>
            <table id="dbCols"></table>
        </div>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm typeb" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="static/h5/jquery.spinner-master/dist/js/jquery.spinner.js"></script>
<script type="text/javascript" src="static/h5/common-ext/validate-ext.js"></script>
<script type="text/javascript" src="static/h5/jquery-validation/1.14.0/localization/messages_zh.js"></script>
<script type="text/javascript" src="static/h5/common-ext/window-ext.js"></script>
<script type="text/javascript" src="static/h5/common-ext/CommonSelect.js"></script>
<script type="text/javascript" src="static/h5/colorpicker/js/colorpicker.js"></script>
<script type="text/javascript" src="static/h5/avicSelectBar/compent/avicSelect/js/avicSelect.js"></script>

<script src="static/h5/jquery-ui-1.9.2.custom/development-bundle/ui/jquery.ui.core.js"></script>
<script src="static/js/platform/eform/widget.js"></script>
<script src="static/js/platform/eform/mouse.js"></script>
<script src="static/js/platform/eform/sortable.js"></script>

<script src="avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.js"></script>
<script type="text/javascript" src="static/h5/avicSelectBar/compent/lookupTypeSelect/lookupTypeSelect.js"></script>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
<script src="avicit/platform6/eform/bpmsformmanage/js/EformTempPreview.js"></script>
<script type="text/javascript">
    var formEditor = {};
    formEditor.eformFormInfoId = "";
    var eformInfoStyle = "bootstrap";
    var formContentJs = "";
    var formContentUrlCss = "";

    var grid_selector = "#" + "dbCols";
    var row_id = null;
    var colTypeMap = {};
    var colType = {
        "all":"text:文本;date:日期;number:数字;textarea:多行;select:下拉框;radio:单选;check:多选;user:选用户;org:选组织;dept:选部门;position:选岗位;role:选角色;group:选群组;photo:图片上传",
        "VARCHAR2":"text:文本;textarea:多行;select:下拉框;radio:单选;check:多选;user:选用户;org:选组织;dept:选部门;position:选岗位;role:选角色;group:选群组",
        "BLOB":"photo:图片上传",
        "CLOB":"user:选用户;org:选组织;dept:选部门;position:选岗位;role:选角色;group:选群组",
        "DATE":"date:日期",
        "NUMBER":"number:数字",
    }
    var gridRowColList = {
        "2" : "2列",
        "3" : "3列",
        "4" : "4列"
    }

    var formatValidate = {
        "" : "请选择",
        "email" : "邮箱",
        "phone" : "手机",
        "idcard" : "身份证",
        "zipcode" : "邮编"
    }

    function jqgridInit(){
        var jqgridHeight = window.innerHeight - 325
        if(parent.FEformEditor){
            jqgridHeight = window.innerHeight - 155
        }



        $(grid_selector).jqGrid({
            datatype: "local",
            toolbar: [],
            colModel: [{
                label: "移动",
                name: "columnOrderNo",
                width: 50,
                frozen: true,
                align: "center",
                editable: false,
                edittype: "text",
                formatter:function( b, c, a) {
                    return '<i class="fa fa-arrows" style="color:#aaa;cursor:move"></i>'
                },
                editoptions: {
                    maxlength: "8",

                }
            },{
                label: '字段名称(英文)',
                name: 'colName',
                editable: true,
                edittype: "text",
                width: 100
            }, {
                label: '字段描述(备注)',
                name: 'colLabel',
                editable: true,
                edittype: "text",
                width: 100
            }, {
                label: '控件类型',
                name: 'plugins',
                editable: true,
                edittype: "select",
                editoptions: {value: colType.all,
                    dataEvents:[{type:'change',fn:function(e){
                            var rowid=$(e.target).closest("tr").attr("id");//通过事件获得行ID
                            //$(grid_selector).jqGrid('setCell', rowid, "transValue", "");    //清空通用代码数据
                            //$(grid_selector).jqGrid("saveCell", rowid, 3);
                            var value = $(e.target).val();
                            if(colTypeMap[value] == undefined){                             //新建字段控件改变字段类型
                                var rowType = "VARCHAR2";
                                if(value == "text" ){
                                    $("#"+rowid+"_formatValidate").removeAttr("disabled");
                                }else{
                                    $("#"+rowid+"_formatValidate").val("");
                                    $("#"+rowid+"_formatValidate").attr("disabled","disabled");
                                }
                                if(value == "date"){
                                    rowType = "DATE";
                                    //$(grid_selector).jqGrid('setCell', rowid, "colLength", '');
                                }else if(value == "number"){
                                    rowType = "NUMBER";
                                    //$(grid_selector).jqGrid('setCell', rowid, "colLength", '20');
                                }else if(value == "photo"){
                                    rowType = "BLOB";
                                    $(grid_selector).jqGrid('setCell', rowid, "colLength", '');
                                }else if(value == "user" || value == "org" || value == "dept" || value == "position" || value == "role" || value == "group"){
                                    rowType = "CLOB";
                                    //$(grid_selector).jqGrid('setCell', rowid, "colLength", '1000');
                                }else if(value == "select" || value == "radio" || value == "check"){
                                    //$(grid_selector).jqGrid('setCell', rowid, "colLength", '50');
                                }else{
                                    //$(grid_selector).jqGrid('setCell', rowid, "colLength", '4000');
                                }

                                $(grid_selector).jqGrid('setCell', rowid, "colType", rowType);    //重新设置字段控件
                                //$(grid_selector).jqGrid("saveCell", rowid, 3);
                            }

                        }}]},
                width: 75
            }, {
                label: '字段类型',
                name: 'colType',
                width: 75,
                align: "center"
            }, {
                label: '通用代码',
                name: 'LookupType',
                width: 100,
                editable: true,
                edittype : "custom",
                editoptions : {
                    custom_element : dictElem,
                    custom_value : dictValue
                }
            }, {
                label: '格式校验',
                name: 'formatValidate',
                editable: true,
                edittype: "select",
                editoptions: {value: formatValidate},
                width: 75
            }, {
                label: '通用代码类型名称',
                name: 'LookupTypeName',
                hidden: true,
            }, {
                label: '所占列数',
                name: 'colspan',
                editable: true,
                edittype: "select",
                editoptions : {
                    value : gridRowColList
                },
                width: 100
            }, {
                label: '新行',
                name: 'newRow',
                align: "center",
                formatter: "checkbox",
                formatoptions: {disabled: false},
                width: 50
            }, {
                label: '必填',
                name: 'colIsMust',
                align: "center",
                formatter: "checkbox",
                formatoptions: {disabled: false},
                width: 50
            }, {
                label: '只读',
                name: 'colDropdownType',
                align: "center",
                formatter: "checkbox",
                formatoptions: {disabled: false},
                width: 50
            }, {
                label: '显示',
                name: 'colIsVisible',
                align: "center",
                formatter: "checkbox",
                formatoptions: {disabled: false},
                width: 50
            }, {
                label: '字段长度',
                name: 'colLength',
                hidden: true,
            }],
            styleUI: 'Bootstrap',
            height: jqgridHeight,
            width:$(window).width()-82,//宽度必须指定，使用autoweidth导致主子表是后面的表格横向滚动条有问题
            rownumbers: true,
            rownumWidth: 30,
            rowNum:2000,
            autowidth: true,
            sortable: false,
            multiselect: true,
            multiboxonly: true,
            cellEdit: true,
            cellsubmit: "clientArray",
            loadComplete:function(){
                var ids = $(this).jqGrid('getDataIDs');
                if (ids.length > 0) {
                    for (var i = 0; i < ids.length; i++) {
                        $(this).jqGrid("editRow", ids[i], {
                            keys: true
                        })
                    }
                    $("#toPreview").removeClass("disabled");
                }else{
                    $("#toPreview").addClass("disabled");
                }
                $(grid_selector).setGridWidth($(window).width()-82);
            },
            beforeSaveCell: function (rowid, cellname, value, iRow, iCol) {	//列转换修改时清空其他相关内容
                /*$("#dbCols").setColProp("plugins", {
                    edittype: "text",
                    editoptions: {value: colType['all']},
                });
                var row = $(grid_selector).jqGrid('getRowData', rowid);
                if(cellname == "colName"){
                    var nowColType = colTypeMap[value];
                    if(nowColType!=undefined){
                        var rowPlugins = row.colType =="VALCHAR2"?"text":row.colType =="DATE"?"date":row.colType =="NUMBER"?"number":row.colType =="BLOB"?"img":"user";
                        $(grid_selector).jqGrid('setCell', rowid, "LookupType", "");    //清空通用代码数据
                        $(grid_selector).jqGrid("saveCell", rowid, 6);


                        //$(grid_selector).jqGrid('endEditCell');
                        $("#dbCols").setColProp("plugins", {
                            edittype: "text",
                            editoptions: {value: colType['all']},
                        });
                        //$(grid_selector).jqGrid('endEditCell');
                        $(grid_selector).jqGrid('setCell', rowid, "plugins", rowPlugins);    //重新设置字段控件
                        $(grid_selector).jqGrid("saveCell", rowid, 5);

                        $(grid_selector).jqGrid('setCell', rowid, "colType", nowColType);    //重新设置字段控件
                        $(grid_selector).jqGrid("saveCell", rowid, 3);
                    }
                }*/
            },
            afterSaveCell: function (rowid, cellname, value, iRow, iCol) {	//列转换修改时清空其他相关内容
                /*var row = $(grid_selector).jqGrid('getRowData', rowid);
                if (cellname == "plugins") {
                    $(grid_selector).jqGrid('setCell', rowid, "transValue", "");    //清空通用代码数据
                    $(grid_selector).jqGrid("saveCell", rowid, iCol + 1);
                    if(colTypeMap[value] == undefined){                             //新建字段控件改变字段类型
                        var rowType = "VARCHAR2";
                        if(value == "date"){
                            rowType = "DATE";
                        }else if(value == "number"){
                            rowType = "NUMBER";
                        }else if(value == "img"){
                            rowType = "BLOB";
                        }else if(value == "user" || value == "org" || value == "dept" || value == "position" || value == "role" || value == "group"){
                            rowType = "CLOB";
                        }else if(value == "date"){
                            rowType = "DATE";
                        }
                        $(grid_selector).jqGrid('setCell', rowid, "colType", rowType);    //重新设置字段控件
                        $(grid_selector).jqGrid("saveCell", rowid, 3);

                    }
                }else if(cellname == "colName"){
                    var nowColType = colTypeMap[value];
                    if(nowColType!=undefined){
                        var rowPlugins = row.colType =="VALCHAR2"?"text":row.colType =="DATE"?"date":row.colType =="NUMBER"?"number":row.colType =="BLOB"?"img":"user";
                        $(grid_selector).jqGrid('setCell', rowid, "LookupType", "");    //清空通用代码数据
                        $(grid_selector).jqGrid("saveCell", rowid, 6);


                        //$(grid_selector).jqGrid('endEditCell');
                        $("#dbCols").setColProp("plugins", {
                            edittype: "text",
                            editoptions: {value: colType['all']},
                        });
                        $(grid_selector).jqGrid('setCell', rowid, "plugins", rowPlugins);    //重新设置字段控件
                        $(grid_selector).jqGrid("saveCell", rowid, 5);

                        $(grid_selector).jqGrid('setCell', rowid, "colType", nowColType);    //重新设置字段控件
                        $(grid_selector).jqGrid("saveCell", rowid, 3);
                    }
                }*/
            },
            onCellSelect: function (rowid, iCol, cellcontent, e) {
                //$("td").removeClass("edit-cell success")
                // $(grid_selector).jqGrid('endEditCell');
                //$("tr.active").removeClass("active");			//清除行选中
                /*var row = $(grid_selector).jqGrid('getRowData', rowid);
                if (iCol == 5) {                                //通过字段类型判断可选的控件类型
                    if(colTypeMap[row.colName]==undefined){
                        $("#dbCols").setColProp("plugins", {
                            editoptions: {value: colType['all']},
                            edittype: "select",
                        });
                    }else{
                        $("#dbCols").setColProp("plugins", {
                            editoptions: {value: colType[row.colType]},
                            edittype: "select",
                        });
                    }
                }
                else if (iCol == 6) {
                    if (row.plugins == "select" || row.plugins == "radio" || row.plugins == "check") {
                        selectLookup($(grid_selector), rowid)
                    } else {
                        layer.msg("控件类型为“下拉”、“单选”、“多选”才可编辑此项");
                        return false;
                    }

                }*/
            },

        });
        $(grid_selector).jqGrid('sortableRows');//实现行拖拽
    }

    function selectDbCallBack(id, name, tablename) {
        drawJqgridCol(id);
    }

    /**
     * 通过表信息生成对应字段填入jqgrid
     * @param id
     */
    function drawJqgridCol(id) {
        avicAjax.ajax({
            url: 'platform/eform/eformViewInfoController/getDbCol/' + id,
            contentType: "application/xml; charset=utf-8",
            type: 'post',
            dataType: 'json',
            async: true,
            success: function (r) {
                if (r != null) {
                    $(".tableCols").css("visibility", "visible");
                    var colList = $.parseJSON(r.data);
                    var dataTable = new Array();
                    for (var i = 0; i < colList.length; i++) {
                        var plugins = colList[i].colType=="DATE"?"date":colList[i].colType=="NUMBER"?"number":colList[i].colType=="BLOB"?"photo":colList[i].colType=="CLOB"?"user":"text";
                        colTypeMap[colList[i].colName] = colList[i].colType;
                        if (colList[i].colIsSys != "Y") {
                            dataTable.push({
                                "colName": colList[i].colName,
                                "colType": colList[i].colType,
                                "colLabel": colList[i].colComments,
                                "plugins": plugins,
                                "colspan": "1",
                                "newRow": false,
                                "colIsMust": false,
                                "colDropdownType": false,
                                "colIsVisible": true,
                                "colLength":colList[i].colLength,
                            })
                        }
                    }
                    $("#dbCols").jqGrid("clearGridData");
                    $("#dbCols").setGridParam({data: dataTable}).trigger('reloadGrid');

                    var $trDom = $("#dbCols").find("tr");
                    $trDom.each(function () {
                        var tdDom = $(this).children("td");
                        var plugins = "";
                        for (var i = 0; i < tdDom.length; i++) {
                            if ($(tdDom[i]).attr("aria-describedby") == "dbCols_plugins") {
                                plugins = $(tdDom[i]).find("select").val();
                            }
                        }
                        if (plugins != "text") {
                            for (var i = 0; i < tdDom.length; i++) {
                                if ($(tdDom[i]).attr("aria-describedby") == "dbCols_formatValidate") {
                                    $(tdDom[i]).find("select").attr("disabled","disabled");
                                }
                            }
                        }
                    });
                }
            }
        });
    }


    function selectLookup(jqgrid, rowid) {
        new H5CommonLookupTypeSelect({
            type: 'lookupSelect', callBack: function (rowdata) {
                //$(grid_selector).jqGrid('endEditCell');
                $(grid_selector).jqGrid('setCell', rowid, "LookupTypeName", rowdata.lookupTypeName);
                $(grid_selector).jqGrid('setCell', rowid, "LookupType", rowdata.lookupType);

            }
        });
    }

    function drowColspan(maxColSpan) {
        if(maxColSpan < 2){
            $("#labelCount").val(2)
            maxColSpan = 2;
        }else if(maxColSpan > 10){
            $("#labelCount").val(10)
            maxColSpan = 10;
        }
        var spanValue = '';
        for(var i=2;i<=maxColSpan;i++){
            spanValue += i + ':' + i + "列;";
        }
        spanValue = spanValue.substring(0,spanValue.length-1);
        $("#dbCols").setColProp("colspan", {
            editoptions: {value: spanValue},
        });
        //$(grid_selector).jqGrid('endEditCell');
        var rows = $(grid_selector).jqGrid('getRowData');
        $(rows).each(function (index) {
            var colSpan = $("#"+$(this.colspan).attr("id")).val();
            $("#" + $(this.colspan).attr("id") + " option").remove();
            for(var i = 2; i <= maxColSpan; i++){
                $("#" + $(this.colspan).attr("id")).append("<option role='option' value='"+i+"'>"+i+"列</option>");
            }
            if(colSpan==''){
                $("#"+$(this.colspan).attr("id")).val(2);
            }else if (Math.abs(colSpan)> maxColSpan) {
                $("#"+$(this.colspan).attr("id")).val(colSpan<0?-maxColSpan:maxColSpan);
            }else{
                $("#"+$(this.colspan).attr("id")).val(colSpan);
            }
        })
    }


    function verification(row) {
        var falId = row.colName;
        var colNameFlag = (verifyIsSpecial(falId) || verifyIsChinese(falId) || verifyIsNumStart(falId));
        if(colNameFlag){
            layer.msg("字段名称(英文)不能包含特殊字符、空格、中文或以数字开头！");
            return false;
        }

        if ((row.plugins == "select" || row.plugins == "radio" || row.plugins == "check") && (row.LookupType == "" || row.LookupTypeName == "")) {
            layer.msg(falId + " 请填写通用代码");
            return false;
        }else if (row.plugins == "") {
            layer.msg(falId + " 请填写控件类型");
            return false;
        }else if (row.colspan == "select") {
            layer.msg(falId + " 请填写所占列数");
            return false;
        }
        return true;
    }
    function toCheck(type,value){
        var ids = $(grid_selector).jqGrid('getGridParam', 'selarrrow');
        for (var i = 0; i < ids.length; i++) {
            $(grid_selector).jqGrid('setCell', ids[i],type, value);
        }
    }

    document.ready = function () {
        var fixie = "${fixie}";
        if ("1" == fixie){
            $("#formStyle option[value='easyui']").attr("selected","selected");
        }
        $.validator.addMethod("integer", function (value, element) {
            var tel = /^-?\d+$/g;  //正、负 整数 + 0
            return this.optional(element) || (tel.test(value));
        }, "请输入整数");
        $.validator.addMethod("codeFormat", function (value, element) {
            var tel = /^[a-zA-Z0-9_]{1,}$/;
            return this.optional(element) || (tel.test(value));
        }, "编码格式只能是字母、数字、下划线的组合");

        selectCreatedDbTable = new SelectCreatedDbTable("dataSourceId","dataSourceName", "dataSourceBtn");
        selectCreatedDbTable.init();

        jqgridInit();
        if(parent.FEformEditor){       //判断入口为重新设计
            $(".add").hide();
            if(parent.EformEditor){
                if(parent.EformEditor.nowDbid){
                    //不再回带以设计的表单信息
                    drawJqgridCol(parent.EformEditor.nowDbid);
                }
            }
        }else {                         //入口为新建表单
            $("#eformComponentId").val(parent.eformComponent.selectedEformComponentId);

            var componenData = {"eformComponentId": parent.eformComponent.selectedEformComponentId}
            var paramData = "param=" + JSON.stringify(componenData);
            $.ajax({
                url: "platform/eform/bpmsManageController/getNewEformFormInfoNb",
                data: paramData,
                type: "post",
                dataType: "json",
                success: function (r) {
                    $("#orderBy").val(r.number);
                }
            });
            parent.eformFormInfo.formValidate($('#addForm'));
        }

        $('#saveForm').bind('click', function () {

            //$(grid_selector).jqGrid('endEditCell');
            var saveVerification = 0;
            var rows = $(grid_selector).jqGrid('getRowData');
            $.each(rows,function(i,v){
                v.LookupType = $("#"+$(v.LookupType).find("input[type='text']").attr("id")).val();
                v.colLabel = $("#"+$(v.colLabel).attr("id")).val();
                v.colName = $("#"+$(v.colName).attr("id")).val();
                v.colspan = $("#"+$(v.colspan).attr("id")).val();
                v.plugins = $("#"+$(v.plugins).attr("id")).val();
                v.formatValidate = $("#"+$(v.formatValidate).attr("id")).val();
                if(v.newRow == "Yes"){
                    v.colspan = 0 - v.colspan;
                }
                delete v.columnOrderNo;
            });


            if(rows.length>0){
                $("#dbCols").setColProp("plugins", {        //还原选项
                    editoptions: {value: 'text:文本;date:日期;number:数字;textarea:多行;select:下拉框;radio:单选;check:多选;user:选用户;org:选组织;dept:选部门;position:选岗位;role:选角色;group:选群组;photo:图片上传\''},
                });
                $(rows).each(function () {
                    saveVerification = verification(this)?saveVerification+0:saveVerification+1;
                });
            }
            if(!saveVerification){
                if(parent.FEformEditor){
                    parent.EformEditor.redesign("add",rows,$("#labelCount").val(),$("#dataSourceName").val());
                }else{
                    parent.eformFormInfo.subAdd($("#addForm"),rows,$("#labelCount").val());
                }
            }
        });
        $('#closeForm').bind('click', function () {
            if(parent.FEformEditor){
                parent.EformEditor.redesign("close");
            }else{
                parent.eformFormInfo.closeDialog("add");
            }
        });
        $('#toAdd').bind('click', function () {
            //$(grid_selector).jqGrid('endEditCell');
            var rows = $(grid_selector).jqGrid('getRowData');
            var colName = "DATA_";
            var isNewName = false;
            var newNumber = 1;
            while(!isNewName){
                isNewName = true;
                $(rows).each(function () {
                    var domId = $(this.colName).attr("id");
                    isNewName = isNewName && (colName+newNumber)!=$("#"+domId).val();
                });
                newNumber ++;
            }


            $(grid_selector).jqGrid('addRowData', rows.length+1, {colLength:4000,colIsVisible:"YES",plugins:"text",colName:colName+(newNumber-1),colLabel:colName+(newNumber-1),colType:"VARCHAR2",colspan:"1"}, 'last');
            $(grid_selector).jqGrid("editRow", rows.length+1, {
                keys: true
            })

            $("#toPreview").removeClass("disabled");
        });

        $('#toCommonCol').bind('click', function () {
            var _this = this;

            var selectDialog = openDialog({
                type : 'selectWindow',
                title : "请选择常用字段",
                url : "avicit/platform6/db/dbcommoncol/commonColSelect.jsp",
                width : "720px",
                height : "460px",
                opentype : 2,
                shade : true,
                submit : function(index, layer) {
                    var iframeWin = layer.find('iframe')[0].contentWindow;
                    var r = iframeWin.getColList();
                    var rows = $(grid_selector).jqGrid('getRowData');

                    for(var i = 0; i< r.length; i++) {
                        var ele = r[i];
                        var rowData = {};
                        rowData.colLabel = ele.colComments;//字段中文
                        rowData.colLength = ele.colLength; //字段长度
                        rowData.colName = ele.colName;  //字段名称
                        rowData.plugins = ele.colDomType;
                        rowData.colType = ele.colType;
                        rowData.colIsVisible = 'YES';
                        rowData.colspan = '1';

                        $(grid_selector).jqGrid('addRowData', rows.length+1, rowData, 'last');
                        $(grid_selector).jqGrid("editRow", rows.length+1, {
                            keys: true
                        })
                    }
                },
                beferClose: function(index, layer){

                },
                init : function(index, layer) {
                    var iframeWin = layer.find('iframe')[0].contentWindow;
                    iframeWin.init();
                }
            });


        });

        $('#toDel').bind('click', function () {
            var ids = $(grid_selector).jqGrid('getGridParam', 'selarrrow');
            layer.confirm('确认要删除选中的数据吗?', {
                icon: 3,
                title: "提示",
                area: ['400px', '']
            }, function (index) {
                for (var i = ids.length - 1; i >= 0; i--) {
                    $(grid_selector).jqGrid("delRowData", ids[i]);
                }

                var rows = $(grid_selector).jqGrid('getRowData');
                if(rows.length == 0){
                    $("#toPreview").addClass("disabled");
                }
                layer.close(index);
            });

        });

        $('#toPreview').bind('click', function () {
            var rows = $(grid_selector).jqGrid('getRowData');
            $.each(rows,function(i,v){
                v.LookupType = $("#"+$(v.LookupType).find("input[type='text']").attr("id")).val();
                v.colLabel = $("#"+$(v.colLabel).attr("id")).val();
                v.colName = $("#"+$(v.colName).attr("id")).val();
                v.colspan = $("#"+$(v.colspan).attr("id")).val();
                v.plugins = $("#"+$(v.plugins).attr("id")).val();
                v.formatValidate = $("#"+$(v.formatValidate).attr("id")).val();
                if(v.newRow == "Yes"){
                    v.colspan = 0 - v.colspan;
                }
                delete v.columnOrderNo;
            });
            if(parent.FEformEditor){
                parent.EformEditor.temppreview(rows,$("#labelCount").val());
            }else{
                temppreview(rows,$("#labelCount").val());
            }

        });

        $('#toMust').bind('click', function () {
            toCheck("colIsMust", "YES");
        });
        $('#toUnMust').bind('click', function () {
            toCheck("colIsMust", "NO");
        });
        $('#toDropdown').bind('click', function () {
            toCheck("colDropdownType", "YES");
        });
        $('#toUnDropdown').bind('click', function () {
            toCheck("colDropdownType", "NO");
        });
        $('#toVisible').bind('click', function () {
            toCheck("colIsVisible", "YES");
        });
        $('#toUnVisible').bind('click', function () {
            toCheck("colIsVisible", "NO");
        });

        $('#deptName').on('focus',function(e){
            var secretLevelValue = '';
            new H5CommonSelect({secretLevel:secretLevelValue,type:'deptSelect', idFiled:'deptId',textFiled:'deptName',viewScope:'currentOrg',selectModel:'single'
                ,hidTab:[]
            });
            this.blur();
        });

        $("#labelCount").on('blur',function(e){
            drowColspan($("#labelCount").val());
        });

        $('#userName').on('focus',function(e){
            var secretLevelValue = '';
            new H5CommonSelect({secretLevel:secretLevelValue,type:'userSelect', idFiled:'userId',textFiled:'userName',viewScope:'currentOrg',selectModel:'single'
                ,hidTab:[], callBack:function(user){$('#deptId').val(user.userdeptids);$('#deptName').val(user.userdeptnames);}
            });
            this.blur();
        });

        //处理谷歌中文输入法不触发keyup的问题
        var bind_name = 'input';
        if (navigator.userAgent.indexOf("MSIE") != -1){
            bind_name = 'propertychange';
        }

        //查询
        $('#search').bind(bind_name,function(e){
            var search = $("#search").val();
            if (search!='') {
                $("#searchClear").show();
            } else {
                $("#searchClear").hide();
            }
            searchWord($(e.target).val());
        });


        $('#searchClear').bind('click',function(event){
            $("#searchClear").hide();
            $("#search").val(null);
            searchWord("");
        });
    };


    function searchWord(val){
        var search_param = new Array(); //用于保存筛选规则
        var a = new GridSearch($(grid_selector)); //创建实例-传入JqGrid的对象
        search_param.push({
            rule_name: 'vague', //筛选方式
            str: val, //筛选值
            column: 'colName' //列名
        });
        a.set_search_param(search_param); //提交设置规则
        a.search();
    }
    //自定义选择通用代码
    function dictValue(elem, operation, value) {
        return elem.val();
    }
    /**
     * 自定义选择通用代码
     * @param value
     * @param options
     * @returns
     */
    function dictElem(value, options){
        var rowId = options.rowId;
        var _this = this;
        var rowData = $(this).jqGrid('getRowData', rowId);
        var jqObject = $(this);
        var $elem = $('<div class="input-group input-group-sm" style="margin:2px">'+
            '<input type="hidden" id="cellRowId" value="'+ rowId +'">'+
            '<input class="form-control" placeholder="请选择" type="text" id="'+rowId+options.name+'" name="'+options.name+'" readonly value="'+ value +'">'+
            '<span class="input-group-addon">'+
            '<i class="fa fa-search-plus"></i>'+
            '</span>'+
            '</div>');
        var selectUrl = "avicit/platform6/h5component/common/LookupTypeSelect.jsp";
        $elem.find('#'+options.name+', .input-group-addon').on('click',function() {
            var plugins = $("#"+rowId+"_plugins").val();
            if (plugins != "select" && plugins !=  "radio" && plugins !=  "check") {
                layer.msg("控件类型为“下拉”、“单选”、“多选”才可编辑此项");
                return false;
            }
            layer.open({
                type:  2,
                area: ['800px', '500px'],
                title : "请选择通用代码类型",
                skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                shade:   0.3,
                maxmin: false, //开启最大化最小化按钮
                content: selectUrl,
                btn: ['确定', '关闭'],
                yes: function(index, layero){
                    var iframeWin = layero.find('iframe')[0].contentWindow;
                    var objData = iframeWin.rowObjData;
                    $("#"+rowId+options.name).val(objData.lookupType);//对其方式
                    $(grid_selector).jqGrid('setCell', rowId, "LookupTypeName", objData.lookupTypeName);
                    layer.close(index);
                },
                btn2: function(index, layero){
                    layer.close(index);
                },
                success: function(layero, index){
                    row_id = rowId;
                    var iframeWin = layero.find('iframe')[0].contentWindow;
                    iframeWin.init({
                        lookuptypeid:null,
                        idFiled : rowId+options.name,
                        textFiled :rowId+options.name,
                        callBack:lookupFeedback
                    });
                }
            });
        });
        return $elem;
    }


    function lookupFeedback(rowObjData){
        if(row_id != null && row_id != undefined){
            $("#"+row_id+"LookupType").val(rowObjData.lookupType);
            $(grid_selector).jqGrid('setCell', row_id, "LookupTypeName", rowObjData.lookupTypeName);
            row_id = null;
        }
    }

    /*
        jqGrid 前端筛选功能
    */
    var GridSearch = function (grid) {

        this.grid = grid;
        this.search_param = null;
        this.r = [];
        this.data = this.grid.jqGrid('getRowData');

        //根据键值删除指定的元素
        this.delete_val_by_key = function (keys, arr) {
            for (var j = 0, i = 0; i < keys.length; i++) {
                arr.splice(keys[i - j], 1);
                j++;
            }
            return arr;
        }

        /**
         * 隐藏行
         */
        this.hideRow = function(rowId) {
            this.grid.setRowData(rowId, null, {
                display : 'none'
            });
        }
        /**
         * 显示行
         */
        this.showRow = function(rowId) {
            this.grid.setRowData(rowId, null, {
                display : ''
            });
        }
        /**
         * 显示全部行
         */
        this.showAllRow = function() {
            for (var i = 0; i < this.data.length; i++) {
                this.showRow(i+1)
            }
        }

        //设置筛选参数
        this.set_search_param = function (search_param) {
            this.search_param = search_param;
        }

        //筛选规则
        /*模糊筛选*/
        this.vagueSearch = function (str, column) {
            var re = new RegExp(str, "i");
            // var is = [];
            for (var i = 0; i < this.data.length; i++) {
                var colValue = $("#"+$(this.data[i][column]).attr("id")).val();
                if (re.test(colValue)) {
                    this.showRow(i+1)
                }else{
                    this.hideRow(i+1);
                }
            }
        }

        /*区间查找*/
        this.betweenSearch = function (start, end, column) {
            // var is = [];
            for (var i = 0; i < this.data.length; i++) {
                if (this.data[i][column] >= start && this.data[i][column] <= end) {
                    this.showRow(i+1)
                }else{
                    this.hideRow(i+1);
                }
            }
        }

        /*根据参数选择规则筛选*/
        this.select = function (params) {
            //var rule_name = params.rule_name;
            switch (params.rule_name) {
                case 'between':
                    //console.log(this.result);
                    this.betweenSearch(params.start, params.end, params.column);
                    break;
                case 'vague':
                    this.vagueSearch(params.str, params.column);
                    break;
            }
        }

        /*清空 result */
        this.clearData = function () {
            this.data = [];
        }

        //执行筛选
        this.search = function () {
            if (this.search_param) {
                if ($.type(this.search_param) == 'array') {
                    for (var i = 0; i < this.search_param.length; i++) {
                        if (this.search_param[i]) {
                            this.select(this.search_param[i]);
                        }else{
                            this.showAllRow();
                        }
                    }
                } else {
                    this.select(this.search_param);
                }
            }else{
                this.showAllRow();
            }
        }
    }


    /**
     * 验证是否特殊字符
     * @returns {boolean}
     */
    function verifyIsSpecial(value) {
        var regEn = /[`~!@#$%^&*()+<>?:{},.\/;'[\]]/im,
            regCn = /[·！#￥（——）：；“”‘、，|《。》？、【】[\]]/im,regblank = /^\S*$/;;
        if(regEn.test(value) || regCn.test(value) ||!regblank.test(value)) {
            return true;
        }
        else {
            return false;
        }
    }

    /**
     * 验证是否是中文
     * @returns {boolean}
     */
    function verifyIsChinese(value) {
        var reg = /[\u4E00-\u9FA5]|[\uFE30-\uFFA0]/gi;
        if(reg.test(value)) {
            return true;
        }
        else {
            return false;
        }
    }

    /**
     * 验证是否数字开头
     * @returns {boolean}
     */
    function verifyIsNumStart(value) {
        var reg = /^\d+/;
        if(reg.test(value)) {
            return true;
        }
        else {
            return false;
        }
    }
</script>
</body>
</html>
