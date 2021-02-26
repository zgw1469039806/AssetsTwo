<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <title>标签</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <style>
        .ztree li span.button.ico_open {
            vertical-align: unset !important;
        }

        .ztree li span.button.ico_docu {
            vertical-align: unset !important;
        }

        .ztree li span.button.ico_close {
            vertical-align: unset !important;
        }
    </style>
    <link rel="stylesheet" id="bsztree" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro.css">
    <%--    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css">--%>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',onResize:function(a){$('#portalProgram').setGridWidth(a);$(window).trigger('resize');}">

    <div class="toolbar-left" style="margin:15px 40px 10px;">
        <a id="addNode" href="javascript:void(0)"
           class="btn btn-primary form-tool-btn btn-sm" role="button"
           title="添加"><i class="glyphicon glyphicon-plus"></i></a>
        <a id="delNode"
           href="javascript:void(0)"
           class="btn btn-primary form-tool-btn btn-sm" role="button"
           title="删除"><i class="glyphicon glyphicon-minus"></i></a>
    </div>
    <div style="height:80%;width:90%;overflow-x: auto;overflow-y: auto;">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
</div>
<div data-options="region:'east',split:true,width:fixwidth(.5),onResize:function(a){$('#programRalation').setGridWidth(a);$(window).trigger('resize');}">
    <div>
        <table class="form_commonTable">
            <tr class="labelInfo">
                <th width="10%">
                    <label for="nowNodeName">节点名称:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="nowNodeName" id="nowNodeName"/>
                </td>
            </tr>
            <tr class="labelInfo">
                <th width="10%">
                    <label for="removeNodeBind">解除当前绑定:</label></th>
                <td width="39%">
                    <button type="button" id="removeNodeBind" class="btn btn-default btn-sm">
                        <span class="glyphicon glyphicon-remove"></span>
                    </button>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label>选择绑定:</label></th>
                <td width="39%">
            </tr>
        </table>
        <div>
            <table id="labeljqGrid"></table>
        </div>
        </td>
    </div>
</div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript">
    var allEle = parent.editorUtil.getAllDomAttr();

    var zTreeObj;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var nowNode = null;

    /**选中节点时 更新当前节点对应右侧编辑数据
     * @param event,treeId,treeNode
     */
    function selectNode(event, treeId, treeNode) {
        nowNode = treeNode;
        refreshRight();
        window.location.hash = "#" + treeNode.labelId;
    }

    function addNode() {
        if (nowNode) {
            newNodes = zTreeObj.addNodes(nowNode, [{name: "新锚点"}]);
            nowNode = nowNode;
            refreshRight();
        } else {
            layer.msg("请选择节点！");
        }
    }

    function delNode() {
        if (!nowNode.isRoot) {
            zTreeObj.removeNode(nowNode);
            nowNode = null;
            refreshRight();
            setSelectNode();
        }
    }

    function removeNodeBind() {
        if (nowNode) {
            nowNode.labelId = undefined,
                setSelectNode();
        } else {
            layer.msg("请选择节点！");
        }
    }

    /**在点击节点后刷新对应右侧节点信息
     *
     */
    function refreshRight() {
        $("#labeljqGrid").jqGrid('resetSelection');
        if (nowNode) {
            $(".labelInfo").show();
            $('#labeljqGrid').setGridHeight($(window).height() - 170);
            $("#nowNodeName").val(nowNode.name);
            $('#labeljqGrid').jqGrid('setSelection', nowNode.labelId);
        } else {
            $(".labelInfo").hide();
            $('#labeljqGrid').setGridHeight($(window).height() - 120);
        }
    }

    /**右侧jquery数据填入
     *
     */
    function setSelectNode() {
        $('#labeljqGrid').jqGrid("clearGridData");
        //绑定控件加载
        for (ele in allEle) {
            if (ele != "clone" && ("domId" in allEle[ele] || "colName" in allEle[ele] || "subTableName" in allEle[ele]) && allEle[ele]["domType"] == "label-box") {
                var eleId = allEle[ele]["domId"];
                if ((!eleId) || (eleId == null) || (eleId == '')) { //对应标签无domId
                    var eleId = parent.GenNonDuplicateID();
                }
                $('#labeljqGrid').jqGrid('addRowData', eleId, {
                    labelName: allEle[ele]["labelName"],
                    bindField: allEle[ele]["bindField"],
                    bindNode: "",
                    domId: allEle[ele]["domId"],
                    index: ele,
                }, 'last');
            }
        }
        //对应节点重新加载
        var selectedNode = zTreeObj.transformToArray(zTreeObj.getNodes());
        for (nod in selectedNode) {
            var row = $("#labeljqGrid").jqGrid('getRowData', selectedNode[nod].labelId);
            if (row) {
                var nodeNames = row.bindNode;
                $('#labeljqGrid').jqGrid('setCell', selectedNode[nod].labelId, "bindNode", nodeNames + (nodeNames == "" ? "" : ", ") + selectedNode[nod].name);
            }
        }

    }

    /**
     * 修改表单页面所对应标签id
     * @param labelParentId
     * @param newId
     */
    function redrawHtml(labelParentId, newId) {
        var allHtmlEle = parent.EformEditor.nowElement.parents().find("body")[0].getElementsByTagName("label");//页面所有标签
        for (i in allHtmlEle) {
            if (allHtmlEle[i].parentNode) {
                if (allHtmlEle[i].parentNode.id == labelParentId) {
                    allHtmlEle[i].id = newId;
                    var $bindLabel = $(allHtmlEle[i]);
                    var labelJson = $.parseJSON($bindLabel.siblings(".eleattr-span").html());
                    labelJson.domId = newId;
                    $bindLabel.parent().find(".eleattr-span").remove();
                    $bindLabel.parent().append($("<span class='eleattr-span' style='display: none;'>" + JSON.stringify(labelJson) + "</span>"));
                }
            }
        }
    }

    function init() {

        var setting = {
            callback: {
                onClick: selectNode,
            }
        };
        if (!parent.$("#labelListValue").val() == '') {
            var nodes = JSON.parse(parent.$("#labelListValue").val());
            zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, nodes);
        } else {
            var zNodes = [{name: "锚点导航", isRoot: true, id: "-1", open: true}];
            zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        }
        $('#labeljqGrid').jqGrid({
            datatype: "local",
            toolbar: '',
            colModel: [
                {label: '标签名称', name: 'labelName', width: 150},
                {label: '绑定控件', name: 'bindField', width: 150},
                {label: '对应节点', name: 'bindNode', width: 250},
                {label: '控件Id', name: 'domId', width: 0, hidden: false},
                {label: '控件排序', name: 'index', width: 0, hidden: true},
            ],
            height: $(window).height() - 120,
            rowNum: 2000,
            altRows: true,
            userDataOnFooter: true,
            pagerpos: 'left',
            loadonce: false,
            loadComplete: function () {
                //$(this).jqGrid('getColumnByUserIdAndTableName');
            },
            styleUI: 'Bootstrap',
            viewrecords: true,
            multiselect: false,
            // autowidth: true,
            shrinkToFit: true,
            hasTabExport: false,
            hasColSet: false,
            responsive: true,//开启自适应
            hiddengrid: true,
            beforeSelectRow: function (rowid, iCol, cellcontent, e) {
                if (!nowNode) {
                    layer.msg("请先选择节点！");
                    return false
                } else {
                    var row = $('#labeljqGrid').jqGrid('getRowData', rowid);
                    nowNode.labelId = row.domId;
                    if ((!nowNode.labelId) || (nowNode.labelId == null) || (nowNode.labelId == '')) { //对应标签无domId

                        var randomId = parent.GenNonDuplicateID();
                        $('#labeljqGrid').jqGrid('setCell', rowid, "domId", randomId);
                        $('#labeljqGrid').jqGrid("saveCell", rowid);
                        allEle[row.index].domId = randomId;
                        redrawHtml(row.index, randomId);         //所选标签赋值新id
                        var aaa = allEle[row.index];
                        nowNode.labelId = randomId;
                    }
                    setSelectNode();
                }
            }
        });
        setSelectNode();
        refreshRight();
    }

    $(document).ready(
        function () {
            init();

            $("#nowNodeName").on('blur', function (e) {
                if (!nowNode) {
                    layer.msg("请先选择节点！");
                    $("#nowNodeName").val('');
                } else if ($.trim($(this).val()) === "") {
                    layer.msg("名称不可为空！");
                    return false;
                } else {
                    nowNode.name = $("#nowNodeName").val();
                    zTreeObj.updateNode(nowNode);
                    setSelectNode();
                }
            });

            $("#addNode").on('click', function (e) {
                addNode();
            });

            $("#delNode").on('click', function (e) {
                delNode();
            });

            $("#removeNodeBind").on('click', function (e) {
                removeNodeBind();
            });
        });

    //返回选择数据
	function getSelectedData(){
        var nodes = zTreeObj.getNodes();
        return nodes;
    }
</script>
</html>