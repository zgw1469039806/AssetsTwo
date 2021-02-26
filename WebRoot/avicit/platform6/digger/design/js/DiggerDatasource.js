function getOptionValue(diggerUrl,dataSourceTypeValue){
    //先要通过数据源id获取配置的字段列信息;
    var diggerUrl = diggerUrl;
    if(diggerUrl == ''){
        return;
    }
    var options = {};
    $.ajax({
        async: false,  //千万要记住加这个属性配置
        type: "get",
        dataType:"json",
        url: "digger/diggerManageController/getDatasourceOptionJsonData?diggerUrl=" + diggerUrl + '&datasourceType=' + dataSourceTypeValue,
        success: function(data) {
            options =  data;
        },
        error : function(e){
            alert(e);
        }
    });
    return options;
}

function getColumnValues(diggerUrl,dataSourceTypeValue){
    //先要通过数据源id获取配置的字段列信息;
    var diggerUrl = diggerUrl;
    if(diggerUrl == ''){
        return;
    }
    var options = {};
    $.ajax({
        async: false,  //千万要记住加这个属性配置
        type: "get",
        dataType:"json",
        url: "digger/diggerManageController/getColumnValues?diggerUrl=" + diggerUrl + '&datasourceType=' + dataSourceTypeValue,
        success: function(data) {
            options =  data;
        },
        error : function(e){
            alert(e);
        }
    });
    return options;
}

/**
 * 获取表名称-根据列名称值
 * @returns {{}}
 */
function getEntityName(diggerurl,datasourcetype,fieldName){
    var options = '';
    $.ajax({
        async: false,  //千万要记住加这个属性配置
        type: "get",
        dataType:"text",
        url: "digger/diggerManageController/getDatasourceGoupCountByFieldName?diggerUrl=" + diggerurl + '&datasourceType=' + datasourcetype + '&fieldName=' + fieldName,
        success: function(text) {
            options =  text;
        },
        error : function(e){
            alert(e);
        }
    });
    return options;
}


//数据源标签页的where 子句支持平台rule表达式
var zTreeObj;
var setting = {
    check: {enable: false},
    callback : {
        beforeExpand : function(treeId, node){
            zTreeObj.setting.async.url = "bpm/business/getExprTreeJsonData"
        },
        onClick : function(event, treeId, node){
            $("#diggersql").insertAtCaret(node.name);
            $(".expressionDisplay").hide();
        }
    },
    data : {
        simpleData : {
            enable : true
        },
        showTitle : true,
        key : {
            title : 'title'
        }
    },
    async: {
        enable: true,
        type: "post",
        url:"bpm/business/getExprTreeJsonData",
        autoParam: ["id"],
        dataType: 'json'
    }
};
var zNodes = [{
    name:"expr表达式",
    id:"root",
    isParent:true,
    open:true,
    attributes : {
        nodeType : 'group'
    }
}];
$(document).ready(function(){
    zTreeObj = $.fn.zTree.init($("#exprTree"), setting, zNodes);

    $("#diggersql").keyup(function(event){
        if(event.keyCode == 50){
            $(".expressionDisplay").show(function(){
                //显示时，展开树节点
                expandAll();
            });
        }
    });
});
//展开所有节点
function expandAll() {
    var zTree = $.fn.zTree.getZTreeObj("exprTree");
    zTree.expandNode(zTree.getNodes()[0], true, false, false);
    setTimeout(function(){
        var nodes = zTree.getNodes()[0].children;
        for(var i = 0 ; i < nodes.length ; i++){
            zTree.expandNode(nodes[i], true, false, false);
        }
    }, 500);
}
function getValue(){
    return $("#diggersql").val();
}
(function($) {
    $.fn.extend({
        insertAtCaret: function(myValue) {
            var $t = $(this)[0];
            //ie
            if (document.selection) {
                this.focus();
                sel = document.selection.createRange();
                sel.text = myValue;
                this.focus();
            } else if ($t.selectionStart || $t.selectionStart == "0") {  // !ie
                var startPos = $t.selectionStart;
                var endPos = $t.selectionEnd;
                var scrollTop = $t.scrollTop;
                if($t.value.length > 0 && $t.value.substring(startPos - 1, startPos) == '@'){
                    $t.value = $t.value.substring(0, startPos - 1) + myValue + $t.value.substring(endPos, $t.value.length);
                } else {
                    $t.value = $t.value.substring(0, startPos) + myValue + $t.value.substring(endPos, $t.value.length);
                }
                this.focus();
                $t.selectionStart = startPos + myValue.length;
                $t.selectionEnd = startPos + myValue.length;
                $t.scrollTop = scrollTop;
            } else {
                this.value += myValue;
                this.focus();
            }
        }
    });
})(jQuery);


//数据源配置保存
function datasourceSave(){
    var form = $("#datasourceForm")
    var _this = this;
    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var datasourceFormId = form.find("#datasourceFormId").val();
    if(datasourceFormId.indexOf("\"") !== -1 || datasourceFormId.indexOf("\\") !== -1 || datasourceFormId.indexOf("&") !== -1) {
        layer.msg('数据源不能含有特殊字符！', {icon: 7});
        return false;
    }
    var datasourcetype = $('input[name="datasourcetype"]:checked').val();
    if(datasourcetype == 0){//如果值为0,把sql文本框的内容赋给datasourceFormId
        $('#datasourceFormId').val($('#sql').val());
    }
    var diggerType = $("#diggerType").val();
    var formSerializeValue = form.serialize();
    var tableFormSerializeValue = $("#tableForm").serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);
    var tableFormDataJson = "";
    var groupCountDataGridJsonData;
    if($('#diggerType').val() == "1"){//如果是图表类型，调用getGroupCountDataGridJsonData()方法
        groupCountDataGridJsonData = getGroupCountDataGridJsonData();
    } else {//非图表类型，调用getDiggerColumnGridJsonData()方法和convertFormSerializeValueToJson(tableFormSerializeValue)逻辑
        groupCountDataGridJsonData = getDiggerColumnGridJsonData();//获取列属性的表格配置
        tableFormDataJson = convertFormSerializeValueToJson(tableFormSerializeValue);
    }
    if(groupCountDataGridJsonData == false){
        return ;
    }
    var parm = "diggerType=" + diggerType + "&formDataJson=" + formDataJson + "&groupCountDataGridJsonData=" + groupCountDataGridJsonData + "&tableFormDataJson=" + tableFormDataJson;
    $.ajax({
        url: "platform/digger/diggerManageController/subAddDiggerFormInfo",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.flag == "sucess") {
                $("#diggerColumnGrid").jqGrid().trigger("reloadGrid");
                layer.msg('保存成功！', {icon: 1});
            } else {
                layer.alert('保存失败！' + backData.message,{
                        icon: 7,
                        title:'提示',
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                    }
                );
            }
        },
        error: function(backData){

        }
    });

}
