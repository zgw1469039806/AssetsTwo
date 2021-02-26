$(function(){
    try {
        initForm();
    }catch (e) {

    }
    jqgridInit();

    $('#jslist_insert').bind('click', function() {
        insert();
    });

    $("#jslist_del").bind('click',function(){
        del();
    });
});

var linkageProperty = {
    mydata : [
    ],
    dataGridColModel:[
        {
            label:'目标字段',
            name:'linkageColumnid',
            width : 30,
            hidden:true
        },
        {
            label:'目标字段',
            name:'linkageColumnLabel',
            width : 30
        },
        {
            label:'目标字段值',
            name:'targetValue',
            width : 30,
            editable:true,
            edittype: "text"
        },
        {
            label:'关联表单id',
            name:'linkformid',
            width : 30,
            hidden:true
        },
        {
            label:'关联表单dbid',
            name:'linkformdbid',
            width : 30,
            hidden:true
        },
        {
            label:'关联表单',
            name:'linkformname',
            width : 50,
            editable: true,
            edittype : "custom",
            editoptions : {
                custom_element : dictElem,
                custom_value : dictValue
            }
        },
        {
            label:'关联参数设置',
            name:'paralist',
            width : 50,
            editable: true,
            edittype : "custom",
            editoptions : {
                custom_element : formparaElem,
                custom_value : formparaValue
            }
        }
    ]
};

function jqgridInit(){


    jQuery("#propertytable").jqGrid(
        {

            datatype: "local",
            data:linkageProperty.mydata,
            toolbar: [false,'top'],//启用toolbar
            colModel: linkageProperty.dataGridColModel,//表格列的属性
            height:$(window).height() - 200,//初始化表格高度
            scrollOffset: 20, //设置垂直滚动条宽度
            altRows:true,//斑马线
            rowNum:10000,
            styleUI : 'Bootstrap', //Bootstrap风格
            viewrecords: true, //是否要显示总记录数
            multiselect: true,//可多选
            multiboxonly: true,
            autowidth: true,//列宽度自适应
            responsive:true,//开启自适应
            shrinkToFit: true,
            cellEdit: true,
            cellsubmit: 'clientArray',
            loadComplete:function(){
                var ids = $(this).jqGrid('getDataIDs');
                if (ids.length > 0) {
                    for (var i = 0; i < ids.length; i++) {
                        $(this).jqGrid("editRow", ids[i], {
                            keys: true
                        })
                    }
                }
            }
        });

    $('#propertytable').validateJqGrid("addValidate","targetValue","required");
    $('#propertytable').validateJqGrid("addValidate","linkageResult","required");

}
var newRowIndex = 0;
var newRowStart = "new_row";
function insert(){
    var newRowId = newRowStart + newRowIndex;
    var rows = $("#propertytable").jqGrid('getRowData');
    var parameters = {
        rowID : newRowId,
        initdata : {
            linkageColumnid:$("#linkageColumnid").val(),
            linkageColumnLabel:$("#linkageColumnid option:selected").text()
        },
        position :"first",
        useDefValues : true,
        useFormatter : true,
        addRowParams : {extraparam:{}}
    };
    //$("#propertytable").jqGrid('addRowData', newRowId, {linkageColumnid:$("#linkageColumnid").val(),linkageColumnLabel:$("#linkageColumnid option:selected").text()}, 'last');
    $("#propertytable").jqGrid('addRow', parameters);
    $("#propertytable").jqGrid("editRow",newRowId, {
        keys: true
    })
    newRowIndex++;
}
function del(){
    var rows = $("#propertytable").jqGrid('getGridParam','selarrrow');
    var ids = [];
    var l =rows.length;
    if(l>0){
        layer.confirm('确定要删除该数据吗？',{icon:2,title:"请确认：",area:['400px','']},function(index){
            for(var i=0;i<l;i++){
                $("#propertytable").jqGrid('delRowData',rows[i]);
            }
            layer.close(index);
        });
    }else{
        layer.alert('请选择要删除的记录！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
    }
}
function initForm(){
    var jsondata = $('#linkformPara', window.parent.document).val();
    var linkageColumnid = $('#linkformColumnid', window.parent.document).val();

    if (jsondata){
        var data = $.parseJSON(jsondata);
        linkageProperty.mydata = data;
    }

    var doms = parent.editorUtil.getTableDbDomAttr();
    var count = 0;
    for (var dom in doms){
        if (dom != "clone"){
            var id = doms[dom].domId||doms[dom].colName;
            if (count == 0) {
                $("#linkageColumnid").append("<option value=\"" + id + "\" selected>" + doms[dom].colLabel + "</option>");
            }else{
                $("#linkageColumnid").append("<option value=\"" + id + "\">" + doms[dom].colLabel + "</option>");
            }
            count++;
        }

    }


    if(linkageProperty.mydata.length == 0){
        linkageProperty.mydata = setGrid(doms,$("#linkageColumnid").val());
        $("#propertytable").jqGrid('setGridParam',{
            datatype:'local',
            data: linkageProperty.mydata
        }).trigger("reloadGrid");
    }

    if (linkageColumnid){
        $("#linkageColumnid").val(linkageColumnid);
    }

    $("#linkageColumnid").change(function(){

        linkageProperty.mydata = setGrid(doms,$("#linkageColumnid").val());
        $("#propertytable").jqGrid("clearGridData");
        $("#propertytable").jqGrid('setGridParam',{
            datatype:'local',
            data: linkageProperty.mydata
        }).trigger("reloadGrid");

    });

}

function setGrid(doms,linkageColumnid){
    var da = new Array();
    for (var dom in doms){
        var id = doms[dom].domId||doms[dom].colName;
        if (dom != "clone" && linkageColumnid ==  id
            && (doms[dom].domType == "select-box"
                || doms[dom].domType == "radio-box"
                || doms[dom].domType == "check-box")){
            var temp = doms[dom].selectedvalues.split(",");
            for(var i=0; i<temp.length ; i++){
                if(temp[i] != "" && temp[i] != null){
                    var d = {linkageColumnLabel : doms[dom].colLabel,
                        linkageColumnid : id,
                        linkageResult : "",
                        targetValue : temp[i],
                        isSelect : "1"
                    };
                    da.push(d);
                }
            }
        }
    }
    return da;
}


//自定义选择通用代码
function dictValue(elem, operation, value) {
    return elem.find("input[type='text']").val();
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
        '<input type="hidden" id="'+rowId+'linkformid">'+
        '<input class="form-control" placeholder="请选择" type="text" id="'+rowId+options.name+'" name="'+options.name+'" readonly value="'+ value +'">'+
        '<span class="input-group-addon">'+
        '<i class="fa fa-search-plus"></i>'+
        '</span>'+
        '</div>');
    var selectPublishEform = new SelectPublishEform(rowId+"linkformid", rowId+options.name, null, "", "eform",$elem.find('#'+options.name+', .input-group-addon'));
    selectPublishEform.init(function(data) {
        $(_this).jqGrid('setCell', rowId, "linkformid", data.id);
        $(_this).jqGrid('setCell', rowId, "linkformdbid", data.treeNode.attribute.datasourceId);
    });
    return $elem;
}

//自定义选择通用代码
function formparaValue(elem, operation, value) {
    return elem.find("input[type='text']").val();
}
/**
 * 自定义选择通用代码
 * @param value
 * @param options
 * @returns
 */
function formparaElem(value, options){
    var rowId = options.rowId;
    var _this = this;
    var rowData = $(this).jqGrid('getRowData', rowId);
    var jqObject = $(this);
    var $elem = $('<div class="input-group input-group-sm" style="margin:2px">'+
        '<input class="form-control" placeholder="请选择" type="text" id="'+rowId+options.name+'" name="'+options.name+'" readonly>'+
        '<span class="input-group-addon">'+
        '<i class="fa fa-search-plus"></i>'+
        '</span>'+
        '</div>');
    $elem.find("#"+rowId+options.name).val(value);
    $elem.find('#'+options.name+', .input-group-addon').click(function(){
        var rowdata = $(_this).jqGrid('getRowData', rowId);
        if (rowdata.linkformdbid == null || rowdata.linkformdbid == undefined || rowdata.linkformdbid == ""){
            layer.alert('请先选择关联表单！', {
                icon: 7,
                area: ['400px', ''],
                title:'提示',
                closeBtn: 0
            });
            return false;
        }
        publishDialog = layer.open({
            type: 2,
            title: '参数配置',
            skin: 'bs-modal',
            area: ['45%', '85%'],
            maxmin: false,
            content: "avicit/platform6/eform/formdesign/js/plugins/form-box/formpara-property.jsp",
            btn: ['确定', '取消'],
            yes: function(index, layero){
                var frm = layero.find('iframe')[0].contentWindow;
                var jsonData = [], rs = [];
                jsonData = frm.dataJsonList;
                if (jsonData.length > 0) {
                    for (var i = 0,length=jsonData.length; i < length; i++) {
                        var data = jsonData[i].data;
                        rs.push(data);
                    }
                    $("#"+rowId+options.name).val(JSON.stringify(rs)).trigger("keyup");
                } else {
                    $("#"+rowId+options.name).val("").trigger("keyup");
                }
                layer.close(index);

            },
            no: function(index, layero){
                layero.close(index);
            },
            success: function(layero, index){
                var frm = layero.find('iframe')[0].contentWindow;
                frm.initPage({
                    dbid:rowdata.linkformdbid,
                    dbArray:parent.DataArea.dbarray,
                    paralist:$("#"+rowId+options.name).val(),
                    EformEditor:parent.parent.EformEditor,
                    editorUtil:parent.parent.editorUtil
                });
                var btn1= $(".layui-layer-btn .layui-layer-btn0");
                btn1.addClass("form-tool-btn");
                btn1.addClass("typeb");
            }
        });
    });

    return $elem;
}

function commitForm(){
    var obj = {};
    var ids = $("#propertytable").jqGrid('getDataIDs');
    for (var i=0;i<ids.length;i++){
        $("#propertytable").jqGrid("saveRow",ids[i]);
    }

    if (!$('#propertytable').validateJqGrid("validate")){
        if (ids.length > 0) {
            for (var i = 0; i < ids.length; i++) {
                $("#propertytable").jqGrid("editRow", ids[i], {
                    keys: true
                })
            }
        }
        return false;
    }



    obj.linkageColumnid = $("#linkageColumnid").val();
    obj.datagridData = $("#propertytable").jqGrid("getRowData");

    return obj;
}


