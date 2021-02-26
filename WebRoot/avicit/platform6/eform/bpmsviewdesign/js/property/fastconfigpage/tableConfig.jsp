<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,table";
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<head>
    <!-- ControllerPath = "demo/demoreception/demoReceptionController/operation/Add/null" -->
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/jqGrid-5.2.0/css/ui.jqgrid-bootstrap.css"/>
    <style type="text/css">
        .jqgrow .edit-cell {
            padding: 8px !important;
        }

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
<div style="overflow-y: auto; height:100%">
    <form>

        <table class="form_commonTable">
            <tr>
                <th width="15%"></th>
                <td width="34%"></td>
                <th width="15%"></th>
                <td width="34%"></td>
            </tr>
            <tr>
                <th width="15%"><label><i class="required">*</i>数据源类型</label></th>
                <td width="34%">
                    <select id="dataSrc" name="dataSrc" class="form-control input-sm">
                        <option value=""></option>
                        <option value="databaseTable" selected>存储模型</option>
                    </select></td>
                <th width="15%" class="wuli"><label><i class="required">*</i>存储模型名称</label></th>
                <td width="34%" class="wuli">
                    <input type="text" id="refdb" name="refdb" class="form-control input-sm" placeholder="请选择一个存储模型"
                           readonly="readonly">
                    <input type="hidden" name="name" id="name"/>
                    <input type="hidden" id="dbtype" name="dbtype">
                    <input type="hidden" name="dbid" id="dbid"/>
                </td>
            </tr>
            <tr>
                <th width="15%"><i class="required">*</i><label>默认排序规则</label></th>

                <td width="83%" colspan="3">
                    &nbsp;<input type="radio" name="orderBy" value="0" checked/>&ensp;按创建时间从新到旧&nbsp;
                    &nbsp;<input type="radio" name="orderBy" value="1"/>&ensp;按创建时间从旧到新&nbsp;
                    &nbsp;<input type="radio" name="orderBy" value="2"/>&ensp;按修改时间从新到旧&nbsp;
                    &nbsp;<input type="radio" name="orderBy" value="3"/>&ensp;按修改时间从旧到新&nbsp;
                </td>
            </tr>
            <tr>
                <th width="15%"><label>页面操作</label></th>
                <td width="83%" colspan="3">
                    <div class="input-group input-group-sm" style="display: flex ;width:100%">
                        &nbsp;添加&nbsp;<input name="addBtn" id="addBtn" type="checkbox" class="ace" value="Y">
                        <i class="required addArea">*</i><input type="text" id="addFormName" name="addFormName"
                                                                style="width:25%;" readonly="readonly"
                                                                class="form-control input-sm addArea"
                                                                placeholder="添加表单名称">
                        <input type="hidden" name="addFormId" id="addFormId">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编辑&nbsp;<input name="editBtn" id="editBtn"
                                                                                             type="checkbox" class="ace"
                                                                                             value="Y">
                        <i class="required editArea">*</i><input type="text" id="editFormName" name="editFormName"
                                                                 style="width:25%;" readonly="readonly"
                                                                 class="form-control input-sm editArea"
                                                                 placeholder="编辑表单名称">
                        <input type="hidden" name="editFormId" id="editFormId">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;删除&nbsp;<input name="delBtn" id="delBtn"
                                                                                             type="checkbox" class="ace"
                                                                                             value="Y">
                    </div>
                </td>
            </tr>
            <tr>
                <th width="15%"><label>分页栏</label></th>
                <td width="83%" colspan="3">&nbsp;<input name="Pagingbar" id="Pagingbar" type="checkbox" class="ace" checked
                                                         value="Y"></td>
            </tr>
            <tr class="Pagingbar">
                <th width="15%"><label><i class="required">*</i>页数量选项</label></th>
                <td width="34%">
                    <input name="rowList" id="rowList" type="text" class="ace" value="[20, 50, 100, 200, 500]">
                </td>
                <th width="15%"><label><i class="required">*</i>页默认页数量</label></th>
                <td width="34%">
                    <input name="rowNum" id="rowNum" type="text" class="ace" value="20">
                </td>
            </tr>

        </table>
        <div class="form_commonTable tableCols">
            <div id="toolbar" class="toolbar">
                <div class="toolbar-left">
                    <a id="toShow" href="javascript:void(0)"
                       class="btn btn-default form-tool-btn btn-sm" role="button"
                       title="显示"><i class="fa fa-plus"></i> 显示</a>
                    <a id="toHide" href="javascript:void(0)"
                       class="btn btn-default form-tool-btn btn-sm" role="button"
                       title="隐藏"><i class="fa fa-file-text-o"></i> 隐藏</a>
                    <a id="toDel" href="javascript:void(0)"
                       class="btn btn-default form-tool-btn btn-sm" role="button"
                       title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                    <a id="toLeft" href="javascript:void(0)"
                       class="btn btn-default form-tool-btn btn-sm" role="button"
                       title="居左">居左</a>
                    <a id="toCenter" href="javascript:void(0)"
                       class="btn btn-default form-tool-btn btn-sm" role="button"
                       title="居中">居中</a>
                    <a id="toRight" href="javascript:void(0)"
                       class="btn btn-default form-tool-btn btn-sm" role="button"
                       title="居右">居右</a>
                </div>
                <div class="toolbar-right">
                    <div class="searchBox">
                        <input type="text" id="search" placeholder="请输入列标识或列名称"> <i class="icon icon-guanbi1 clear" id="searchClear"></i><i class="icon icon-search_ query" id="searchQuery"></i>
                    </div>
                </div>
            </div>
            <table id="dbCols"></table>
        </div>

    </form>
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
<script src="avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.js"></script>
<script type="text/javascript" src="static/h5/avicSelectBar/compent/lookupTypeSelect/lookupTypeSelect.js"></script>
<script type="text/javascript">
    var tablePageParam = {dbChangeFlag: false};
    $(".addArea").hide();
    $(".editArea").hide();
    var grid_selector = "#" + "dbCols";
    var row_id = null;
    function jqgridInit() {
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
                label: '列标识',
                name: 'colId',
                width: 75
            }, {
                label: '字段类型',
                name: 'type',
                width: 75
            }, {
                label: '列主键',
                name: 'isKey',
                hidden: true,
            }, {
                label: '列名称',
                name: 'colName',
                editable: true,
                edittype: "text",
                editrules: {required: true},
                width: 100
            }, {
                label: '列转换',
                name: 'transform',
                editable: true,
                edittype: "select",
                editoptions: {value: ':;userid:用户ID转名称;orgid:组织ID转名称;deptid:部门ID转名称;positionid:岗位ID转名称;roleid:角色ID转名称;groupid:群组ID转名称;lookup:通用代码',
                    dataEvents:[{type:'change',fn:function(e){
                            var rowid=$(e.target).closest("tr").attr("id");//通过事件获得行ID
                            var value = $(e.target).val();
                            if(value == undefined || value == ""){
                                $("#"+rowid+"_align").val("left");
                            }else{
                                $("#"+rowid+"_align").val("center");
                            }

                        }}]},
                width: 100
            }, {
                label: '通用代码',
                name: 'LookupType',
                width: 150,
                editable: true,
                edittype : "custom",
                editoptions : {
                    custom_element : dictElem,
                    custom_value : dictValue
                }
            }, {
                label: '通用代码',
                name: 'LookupTypeName',
                hidden: true,
            }, {
                label: '通用代码ID',
                name: 'LookupTypeId',
                hidden: true,
            }, {
                label: '列显隐',
                name: 'hidden',
                align: "center",
                formatter: "checkbox",
                formatoptions: {disabled: false},
                width: 50
            }, {
                label: '对齐方式',
                name: 'align',
                editable: true,
                edittype: "select",
                editoptions: {value: 'left:左对齐;center:居中对齐;right:右对齐'},
                width: 80
            }, {
                label: '高级查询',
                name: 'searchAll',
                align: "center",
                formatter: "checkbox",
                formatoptions: {disabled: false},
                width: 50
            }, {
                label: '基本查询',
                name: 'search',
                align: "center",
                formatter: "checkbox",
                formatoptions: {disabled: false},
                width: 50
            }, {
                label: '是否小数',
                name: 'hasDecimal',
                hidden: true,
            }],
            styleUI: 'Bootstrap',
            height:$(window).height()-290,
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
                }
                $(grid_selector).setGridWidth($(window).width()-82);
            },
            afterSaveCell: function (rowid, cellname, value, iRow, iCol) {	//列转换修改时清空其他相关内容
                if (cellname == "transform") {
                    var row = $(grid_selector).jqGrid('getRowData', rowid);
                    if(value == 'userid'||value == 'lookup'){                   //改变对齐方式
                        $(grid_selector).jqGrid('setCell', rowid, "align", "left");
                    }else if(value == ''){
                        var align = row.type != "DATE" && row.type != "NUMBER" ? "left" : row.hasDecimal? "center" : "right";
                        $(grid_selector).jqGrid('setCell', rowid, "align", align);
                    }else{
                        $(grid_selector).jqGrid('setCell', rowid, "align", "center");
                    }
                    $(grid_selector).jqGrid('setCell', rowid, "transValue", "");    //清空通用代码数据
                    $(grid_selector).jqGrid("saveCell", rowid, iCol + 1);
                    $(grid_selector).jqGrid("saveCell", rowid, iCol + 4);
                }
            },
            onCellSelect: function (rowid, iCol, cellcontent, e) {
                //$("td").removeClass("edit-cell success")
                //$(grid_selector).jqGrid('endEditCell');
                //$("tr.active").removeClass("active");			//清除行选中
                //var row = $(grid_selector).jqGrid('getRowData', rowid);
                //if (iCol != 7) {
                //} else if (row.transform == "lookup") {
                    //selectLookup($(grid_selector), rowid)
                //} else {
               //     layer.msg("列转换为“通用代码”才可编辑此项");
                //    return false;
               // }
            }

        });
        $(grid_selector).jqGrid('sortableRows');//实现行拖拽
    }

    function selectLookup(jqgrid, rowid) {
        new H5CommonLookupTypeSelect({
            type: 'lookupSelect', callBack: function (rowdata) {
                $(grid_selector).jqGrid('endEditCell');
                $(grid_selector).jqGrid('setCell', rowid, "LookupId", rowdata.id);
                $(grid_selector).jqGrid('setCell', rowid, "LookupType", rowdata.lookupType);

            }
        });
    }

    function selectDbCallBack(id, name, tablename) {
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
                    var dataId = new Array();
                    var dataTable = new Array();
                    var dataPlatform = new Array();
                    for (var i = 0; i < colList.length; i++) {
                        if (colList[i].colIsPk == "Y") {
                            dataId.push({
                                "colId": colList[i].colName,
                                "colName": colList[i].colComments,
                                "type": colList[i].colType,
                                "isKey": colList[i].colIsPk,
                                "hidden": colList[i].colIsPk != "Y",
                                "align": "left",
                                "search": false,
                                "searchAll": false,
                                "hasDecimal": false,
                            })
                        } else if (colList[i].colIsSys != "Y") {
                            dataTable.push({
                                "colId": colList[i].colName,
                                "colName": colList[i].colComments,
                                "type": colList[i].colType,
                                "isKey": colList[i].colIsPk,
                                "hidden": true,
                                "align": colList[i].colType != "DATE" && colList[i].colType != "NUMBER" ? "left" : colList[i].attribute02 == "" || colList[i].attribute02 == null ? "center" : "right",
                                "search": false,
                                "searchAll": false,
                                "hasDecimal": false,
                            })
                        } else {
                            dataPlatform.push({
                                "colId": colList[i].colName,
                                "colName": colList[i].colComments,
                                "type": colList[i].colType,
                                "isKey": colList[i].colIsPk,
                                "hidden": false,
                                "align": colList[i].colType != "DATE" && colList[i].colType != "NUMBER" ? "left" : colList[i].attribute02 == "" || colList[i].attribute02 == null ? "center" : "right",
                                "search": false,
                                "searchAll": false,
                                "hasDecimal": colList[i].attribute02 != "" && colList[i].attribute02 != null,
                            })
                        }
                    }
                    $("#dbCols").setGridParam({data: dataId.concat(dataTable).concat(dataPlatform)}).trigger('reloadGrid');

                    var $trDom = $("#dbCols").find("tr");
                    $trDom.each(function () {
                        var tdDom = $(this).children("td");
                        var type = "";
                        for (var i = 0; i < tdDom.length; i++) {
                            if ($(tdDom[i]).attr("aria-describedby") == "dbCols_type") {
                                type = $(tdDom[i]).text();
                            }
                        }
                        if (type != "VARCHAR2" && type != "CLOB") {
                            for (var i = 0; i < tdDom.length; i++) {
                                if ($(tdDom[i]).attr("aria-describedby") == "dbCols_search" || $(tdDom[i]).attr("aria-describedby") == "dbCols_transform") {
                                    $(tdDom[i]).empty();
                                }
                            }
                        }
                    });
                }
            }
        });
    }

    function modifyForm(type) {
        var ids = $(grid_selector).jqGrid('getGridParam', 'selarrrow');
        if (ids.length == 0) {
            layer.alert('请选择要编辑的数据！', {
                icon: 7,
                area: ['400px', ''], // 宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            });
            return false;
        }
        if (type == "del") {
            layer.confirm('确认要删除选中的数据吗?', {
                icon: 3,
                title: "提示",
                area: ['400px', '']
            }, function (index) {
                for (var i = ids.length - 1; i >= 0; i--) {
                    $(grid_selector).jqGrid("delRowData", ids[i]);
                }
                layer.close(index);
            });
        } else {
            for (var i = 0; i < ids.length; i++) {
                if (type == "show") {
                    $(grid_selector).jqGrid('setCell', ids[i], "hidden", "YES");
                } else if (type == "hide") {
                    $(grid_selector).jqGrid('setCell', ids[i], "hidden", "NO");
                } else {
                    //$(grid_selector).jqGrid('setCell', ids[i], "align", type);
                    $("#"+ids[i]+"_align").val(type);
                }
            }
        }
    }

    function getNodes() {
        var returnNode = new Array();
        var tableId = "table" + parent.uuid();
        returnNode.push({
            "id": tableId,
            "name": $("#name").val(),
            "type": "table",
            "parentId": "root",
            "attribute": {
                "scrollload": "N",
                "dbtype": $("#dbtype").val(),
                "event_init_ondblClickRow": "",
                "event_init_loadBeforeSend": "",
                "flowid": "",
                "refdb": $("#refdb").val(),
                "showRowNum": "N",
                "refsql": "",
                "where": "",
                "event_init_onRightClickRow": "",
                "id": tableId,
                "footerrow": "N",
                "ishead": "Y",
                "dataSrc": $("#dataSrc").val(),
                "name": $("#name").val(),
                "dbid": $("#dbid").val(),
                "ismultiple": "Y",
                "refurl": "",
                "rowedit": "N",
                "colFit": "Y",
                "event_init_onSelectRow": "",
                "event_init_onCellSelect": "",
                "isbpm": "N",
                "flowname": "",
                "formid": "",
                "flowfilter": "1",
                "formcode": "",
                "event_init_loadComplete": "",
                "event_init_gridComplete": "",
                "evt": "",
                "isorgfilter": "Y",
                "formname": ""
            }
        });
        var tableColModelId = "tableColModel" + tableId;
        var searchArray = new Array();
        var searchAllArray = new Array();
        returnNode.push({
            "id": tableColModelId,
            "name": "列模型",
            "type": "tableColModel",
            "parentId": tableId,
            "attribute": {
                "id": tableColModelId,
                "name": "列模型",
            },
        });
        var orderType = $("input[name='orderBy']:checked").val();
        var rows = $(grid_selector).jqGrid('getRowData');
        for (var i = 0; i < rows.length; i++) {
            var sorttype = "";
            var orderindex = "";
            var transform = $("#"+$(rows[i].transform).attr("id")).val();
            var lookupType = $("#"+$(rows[i].LookupType).find("input[type='text']").attr("id")).val();
            var colName = $("#"+$(rows[i].colName).attr("id")).val();
            var colAlign = $("#"+$(rows[i].align).attr("id")).val();
            if ((orderType == "0" && rows[i].colId == "CREATION_DATE") || (orderType == "2" && rows[i].colId == "LAST_UPDATE_DATE")) {
                sorttype = "desc";
                var orderindex = "1";
            } else if ((orderType == "1" && rows[i].colId == "CREATION_DATE") || (orderType == "3" && rows[i].colId == "LAST_UPDATE_DATE")) {
                sorttype = "asc";
                var orderindex = "1";
            }
            if (rows[i].search == "Yes") {
                searchArray.push({
                    "id": rows[i].colId,
                    "name": colName,
                    "formControl": "text"
                })
            }


            if (rows[i].searchAll == "Yes") {
                var formControl = rows[i].type == "NUMBER" ? "number" : rows[i].type == "DATE" ? "date" : "text";
                if(transform!=""){
                    {value: ':;userid:用户ID转名称;orgid:组织ID转名称;deptid:部门ID转名称;positionid:岗位ID转名称;roleid:角色ID转名称;groupid:群组ID转名称;lookup:通用代码'}
                    formControl = transform=="userid"?"userSelect":
                                    transform=="orgid"?"orgSelect":
                                        transform=="deptid"?"deptSelect":
                                            transform=="positionid"?"positionSelect":
                                                transform=="roleid"?"roleSelect":
                                                    transform=="groupid"?"groupSelect":
                                                        transform=="lookup"?"select":formControl;


                }
                searchAllArray.push({
                    "id": rows[i].colId,
                    "name": colName,
                    "formControl": formControl,
                    "LookupType":transform=="lookup"?lookupType:"",

                })
            }
            returnNode.push({
                "id": rows[i].colId,
                "name": colName,
                "type": "tableColumn",
                "parentId": tableColModelId,
                "attribute": {
                    "id": rows[i].colId,
                    "name": colName,
                    "orderindex": "",
                    "hidden": rows[i].hidden != "Yes" ? "true" : "false",
                    "transform": transform==undefined?"":transform,
                    "LookupType": rows[i].LookupTypeId,
                    "LookupTypeName": lookupType,
                    "sorttype": sorttype,
                    "orderindex": orderindex,
                    "align": colAlign,
                    "width": "",
                    "ispkfiled": rows[i].isKey,
                    "dbid": "",
                    "format": rows[i].type == "DATE" ? "yyyy-mm-dd" : "",
                    "db_filed_type": rows[i].type,
                },
            });
        }
        var tableToolbarId = tableId + "Toolbar";
        returnNode.push({
            "id": tableToolbarId,
            "name": "工具栏",
            "type": "tableToolbar",
            "parentId": tableId,
            "attribute": {
                "id": tableToolbarId,
                "name": "工具栏",
            },
        });
        if (searchArray.length > 0 || searchAllArray.length > 0) {
            var tableSearchbarAreaId = tableToolbarId + "tableSearchbarArea";
            returnNode.push({
                "id": tableSearchbarAreaId,
                "name": "查询区",
                "type": "tableSearchbarArea",
                "parentId": tableToolbarId,
                "attribute": {
                    "id": tableSearchbarAreaId,
                    "name": "查询区",
                },
            });
            if (searchArray.length > 0) {
                var tableKeyWordSearchId = tableSearchbarAreaId + "tableKeyWordSearch";
                returnNode.push({
                    "id": tableKeyWordSearchId,
                    "name": "基本查询",
                    "type": "tableKeyWordSearch",
                    "parentId": tableSearchbarAreaId,
                    "attribute": {
                        "id": tableKeyWordSearchId,
                        "name": "基本查询",
                    },
                });
                for (var j = 0; j < searchArray.length; j++) {
                    returnNode.push({
                        "id": searchArray[j].id,
                        "name": searchArray[j].name,
                        "type": "keyWordFiled",
                        "parentId": tableKeyWordSearchId,
                        "attribute": {
                            "id": searchArray[j].id,
                            "_value": searchArray[j].name,
                            "formFiledID": searchArray[j].id,
                            "_key": searchArray[j].id,
                            "name": searchArray[j].name,
                            "DbFiledName": searchArray[j].name,
                            "formControl": searchArray[j].formControl
                        },
                    });
                }
            }
            if (searchAllArray.length > 0) {
                var formSearchId = tableSearchbarAreaId + "formSearch";
                returnNode.push({
                    "id": formSearchId,
                    "name": "高级查询",
                    "type": "formSearch",
                    "parentId": tableSearchbarAreaId,
                    "attribute": {
                        "id": formSearchId,
                        "name": "高级查询",
                    },
                });
                for (var j = 0; j < searchAllArray.length; j++) {
                    returnNode.push({
                        "id": searchAllArray[j].id,
                        "name": searchAllArray[j].name,
                        "type": "formSearchFiled",
                        "parentId": formSearchId,
                        "attribute": {
                            "id": searchAllArray[j].id,
                            "_value": searchAllArray[j].name,
                            "formFiledID": searchAllArray[j].id,
                            "_key": searchAllArray[j].id,
                            "name": searchAllArray[j].name,
                            "DbFiledName": searchAllArray[j].name,
                            "formControl": searchAllArray[j].formControl,
                            "LookupTypeName": searchAllArray[j].LookupType,
                            "LookupType": searchAllArray[j].LookupType
                        },
                    });
                }
            }
        }
        if ($("#addBtn").is(':checked') || $("#editBtn").is(':checked') || $("#delBtn").is(':checked')) {
            var buttonAreaId = tableToolbarId + "ButtonArea";
            returnNode.push({
                "id": buttonAreaId,
                "name": "按钮区",
                "type": "tableToolbarButtonArea",
                "parentId": tableToolbarId,
                "attribute": {
                    "id": buttonAreaId,
                    "name": "按钮区",
                },
            });
            if ($("#addBtn").is(':checked')) {
                var addBtnId = "tableToolbarButton" + parent.uuid();
                returnNode.push({
                    "id": addBtnId,
                    "name": "添加",
                    "type": "tableToolbarButton",
                    "parentId": buttonAreaId,
                    "attribute": {
                        "id": addBtnId,
                        "icon": "glyphicon glyphicon-plus",
                        "buttontype": "1",
                        "name": "添加",
                        "adddatatype": "1",
                        "addflowtype": "1",
                        "formid": $("#addFormId").val(),
                        "formname": $("#addFormName").val(),
                        "formpara": "",
                        "formparatype": "",
                        "formparaname": "",
                        "codename": "",
                        "funcurl": "",
                        "funcname": "",
                        "event_reg_bt_click": "",
                        "event_delete_java": "",
                        "event_before_bt_click": "",
                        "event_after_bt_click": ""
                    },
                });
            }
            if ($("#editBtn").is(':checked')) {
                var eidtBtnId = "tableToolbarButton" + parent.uuid();
                returnNode.push({
                    "id": eidtBtnId,
                    "name": "编辑",
                    "type": "tableToolbarButton",
                    "parentId": buttonAreaId,
                    "attribute": {
                        "id": eidtBtnId,
                        "icon": "glyphicon glyphicon-edit",
                        "buttontype": "2",
                        "name": "编辑",
                        "adddatatype": "1",
                        "addflowtype": "1",
                        "formid": $("#editFormId").val(),
                        "formname": $("#editFormName").val(),
                        "formpara": "",
                        "formparatype": "",
                        "formparaname": "",
                        "codename": "",
                        "funcurl": "",
                        "funcname": "",
                        "event_reg_bt_click": "",
                        "event_delete_java": "",
                        "event_before_bt_click": "",
                        "event_after_bt_click": ""
                    },
                });
            }
            if ($("#delBtn").is(':checked')) {
                var delBtnId = "tableToolbarButton" + parent.uuid();
                returnNode.push({
                    "id": delBtnId,
                    "name": "删除",
                    "type": "tableToolbarButton",
                    "parentId": buttonAreaId,
                    "attribute": {
                        "id": delBtnId,
                        "icon": "glyphicon glyphicon-trash",
                        "buttontype": "3",
                        "name": "删除",
                        "adddatatype": "1",
                        "addflowtype": "1",
                        "formid": "",
                        "formname": "",
                        "formpara": "",
                        "formparatype": "",
                        "formparaname": "",
                        "codename": "",
                        "funcurl": "",
                        "funcname": "",
                        "event_reg_bt_click": "",
                        "event_delete_java": "",
                        "event_before_bt_click": "",
                        "event_after_bt_click": ""
                    },
                });
            }

        }
        if ($("#Pagingbar").is(':checked')) {
            var tablePagingbarId = tableId + "tablePagingbar";
            returnNode.push({
                "id": tablePagingbarId,
                "name": "分页栏",
                "type": "tablePagingbar",
                "parentId": tableId,
                "attribute": {
                    "id": tablePagingbarId,
                    "name": "分页栏",
                    "rowList": $("#rowList").val(),
                    "rowNum": $("#rowNum").val()
                },
            });
        }
        return returnNode;
    }

    function isValidate() {
        //$(grid_selector).jqGrid('endEditCell');
        //$("tr.active").removeClass("active");			//清除行选中
        if ($.trim($("#dataSrc").val()) == "") {
            layer.msg('数据源类型不可为空，请检查！', {icon: 7});
            return false;
        } else if ($.trim($("#refdb").val()) == "" || $.trim($("#name").val()) == "" || $.trim($("#dbtype").val()) == "" || $.trim($("#dbid").val()) == "") {
            layer.msg('存储模型名称不可为空，请检查！', {icon: 7});
            return false;
        } else if ($("input[name='orderBy']:checked").val() == "") {
            layer.msg('默认排序规则不可为空，请检查！', {icon: 7});
            return false;
        } else if ($("#addBtn").is(':checked') && ($.trim($("#addFormName").val()) == "" || $.trim($("#addFormId").val()) == "")) {
            layer.msg('添加表单名称不可为空，请检查！', {icon: 7});
            return false;
        } else if ($("#editBtn").is(':checked') && ($.trim($("#editFormName").val()) == "" || $.trim($("#editFormId").val()) == "")) {
            layer.msg('编辑表单名称不可为空，请检查！', {icon: 7});
            return false;
        } else if ($("#Pagingbar").is(':checked') && ($.trim($("#rowList").val()) == "")) {
            layer.msg('页数量选项不可为空，请检查！', {icon: 7});
            return false;
        } else if ($("#Pagingbar").is(':checked') && ($.trim($("#rowNum").val()) == "")) {
            layer.msg('页默认页数量不可为空，请检查！', {icon: 7});
            return false;
        }
        var rows = $("#dbCols").jqGrid('getRowData');
        var ret = true
        $(rows).each(function () {
            if ($("#"+$(this.transform).attr("id")).val() == "lookup" && ($("#"+$(this.LookupType).find("input[type='text']").attr("id")).val() == "")) {
                ret = false;
                layer.msg(this.colId + '：请选择通用代码！');
                return false;
            }
        })
        return ret;
    }

    // 加载完后初始化
    $(document).ready(function () {
        var selectCreatedDbTable = new SelectCreatedDbTable("dbid", "refdb", "", "-1", "-1");
        selectCreatedDbTable.init(function (data) {
            $("#name").val(data.name);
            $("#refdb").val(data.tablename);
            $("#dbtype").val(data.dbtype);
            tablePageParam.dbChangeFlag = true;
        });
        var selectPublishEform = new SelectPublishEform("addFormId", "addFormName", null, "N", "eform");
        selectPublishEform.init(function () {
        });
        var selectPublishEform = new SelectPublishEform("editFormId", "editFormName", null, "N", "eform");
        selectPublishEform.init(function () {
        });
        jqgridInit();


        $("form").find("input[type='checkbox'],select").on("change", function () {
            var value = this.value;
            var name = this.name;
            if (name == "dataSrc") {
                if (value == "databaseTable") {
                    $(".wuli").show();
                } else {
                    $(".wuli").hide();
                }
            } else if (name == "addBtn") {
                if ($(this).is(':checked')) {
                    $(".addArea").show();
                    if($("#addFormName").val()==""&&$("#editFormName").val()!=""&&$("#editFormId").val()!=""){
						$("#addFormName").val($("#editFormName").val());
						$("#addFormId").val($("#editFormId").val());
					}
                } else {
                    $(".addArea").hide();
                    $("#addFormName").val("");
                    $("#addFormId").val("");
                }
            } else if (name == "editBtn") {
                if ($(this).is(':checked')) {
                    $(".editArea").show();
					if($("#editFormName").val()==""&&$("#addFormName").val()!=""&&$("#addFormId").val()!="") {
						$("#editFormName").val($("#addFormName").val());
						$("#editFormId").val($("#addFormId").val());
					}
                } else {
                    $(".editArea").hide();
                    $("#editFormName").val("");
                    $("#editFormId").val("");
                }
            } else if (name == "Pagingbar") {
                if ($(this).is(':checked')) {
                    $(".Pagingbar").show();
                } else {
                    $(".Pagingbar").hide();
                }
            }
        });
        //显示按钮绑定事件
        $('#toShow').bind('click', function () {
            modifyForm("show");
        });
        //隐藏按钮绑定事件
        $('#toHide').bind('click', function () {
            modifyForm("hide");
        });
        //删除按钮绑定事件
        $('#toDel').bind('click', function () {
            modifyForm("del");
        });
        //居左按钮绑定事件
        $('#toLeft').bind('click', function () {
            modifyForm("left");
        });
        //居中按钮绑定事件
        $('#toCenter').bind('click', function () {
            modifyForm("center");
        });
        //居右按钮绑定事件
        $('#toRight').bind('click', function () {
            modifyForm("right");
        });

        //处理谷歌中文输入法不触发keyup的问题
        var bind_name = 'input';
        if (navigator.userAgent.indexOf("MSIE") != -1){
            bind_name = 'propertychange';
        }

        //菜单查询
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

    });

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
    function dictElem(value, options) {
        var rowId = options.rowId;
        var _this = this;
        var rowData = $(this).jqGrid('getRowData', rowId);
        var jqObject = $(this);
        var $elem = $('<div class="input-group input-group-sm" style="margin:2px">' +
            '<input type="hidden" id="cellRowId" value="' + rowId + '">' +
            '<input class="form-control" placeholder="请选择" type="text" id="' + rowId + options.name + '" name="' + options.name + '" readonly value="' + value + '">' +
            '<span class="input-group-addon">' +
            '<i class="fa fa-search-plus"></i>' +
            '</span>' +
            '</div>');
        var selectUrl = "avicit/platform6/h5component/common/LookupTypeSelect.jsp";
        $elem.find('#' + options.name + ', .input-group-addon').on('click', function () {
            var transform = $("#" + rowId + "_transform").val();
            if (transform != "lookup") {
                layer.msg("列转换为“通用代码”才可编辑此项");
                return false;
            }
            layer.open({
                type: 2,
                area: ['800px', '500px'],
                title: "请选择通用代码类型",
                skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                shade: 0.3,
                maxmin: false, //开启最大化最小化按钮
                content: selectUrl,
                btn: ['确定', '关闭'],
                yes: function (index, layero) {
                    var iframeWin = layero.find('iframe')[0].contentWindow;
                    var objData = iframeWin.rowObjData;
                    $("#" + rowId + options.name).val(objData.lookupType);
                    $(grid_selector).jqGrid('setCell', rowId, "LookupTypeName", objData.lookupTypeName);
                    $(grid_selector).jqGrid('setCell', rowId, "LookupTypeId", objData.id);
                    layer.close(index);
                },
                btn2: function (index, layero) {
                    layer.close(index);
                },
                success: function (layero, index) {
                    row_id = rowId;
                    var iframeWin = layero.find('iframe')[0].contentWindow;
                    iframeWin.init({
                        lookuptypeid: null,
                        idFiled: rowId + options.name,
                        textFiled: rowId + options.name,
                        callBack: lookupFeedback
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
            $(grid_selector).jqGrid('setCell', row_id, "LookupTypeId", rowObjData.id);
            row_id = null;
        }
    }




    function searchWord(val){
        var search_param = new Array(); //用于保存筛选规则
        var a = new GridSearch($(grid_selector)); //创建实例-传入JqGrid的对象
        search_param.push({
            rule_name: 'vague', //筛选方式
            str: val, //筛选值
            column: 'colId,colName' //列名
        });
        a.set_search_param(search_param); //提交设置规则
        a.search();
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
            var columns = column.split(",");
            var re = new RegExp(str, "i");
            // var is = [];
            for (var i = 0; i < this.data.length; i++) {
                for(var j = 0; j < columns.length; j++){
                    var columnName = columns[j];
                    var colValue = "";
                    if(columnName == "colId"){
                        colValue = this.data[i][columnName];
                    }else{
                        colValue = $("#"+$(this.data[i][columnName]).attr("id")).val();
                    }
                    if (re.test(colValue)) {
                        this.showRow(i+1);
                        break;
                    }else{
                        this.hideRow(i+1);
                    }
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
</script>
</body>
</html>