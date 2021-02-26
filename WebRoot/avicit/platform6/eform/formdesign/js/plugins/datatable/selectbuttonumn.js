var dataJsonList = [];//按钮数据
var curId;

//点击确定后调用
function submitJsonData(){
    updateJsonData(curId,formattingForm($('#property_form')));
    var obj = {};
    if (!validSubmitData()){
        return false;
    }
    obj.dataList = dataJsonList;
    return obj;
}

function isEmpty(dataJsonList){
    if (dataJsonList.length>0){
        $(".empty-tip").hide();
        $("#property_form").show();
        return false;
    }else{
        $(".empty-tip").show();
        $("#property_form").hide();
        return true;
    }
}

//删除层级
function removeItem(obj){
    var id = $(obj).parent().attr("id");
    delJsonData(id);
    drawListArea();
    if (!isEmpty(dataJsonList)){
        var fistId = dataJsonList[0].id;
        $("#"+fistId).click();
    }
}

//根据id获取数据
function getJsonData(id){
    if (id){
        for (var i=0;i<dataJsonList.length;i++){
            if (dataJsonList[i].id == id){
                return dataJsonList[i].data;
            }
        }
    }
}

//列明细点击联动
function showColumnData(showId){
    updateJsonData(curId,formattingForm($('#property_form')));
    curId = showId;
}

//层级点击事件
function itemClick(obj){
    $("#list_area").find(".current").removeClass("current");
    $(obj).addClass("current");
    var id = $(obj).attr("id");
    if (id !== curId)
        showColumnData(id);
    setProperty(id);
}

function setProperty(id){
    var jsondata = getJsonData(id);
    var buttonType = jsondata.buttonType;
    //自定义按钮可修改id，其他类型不可修改
    if (buttonType === 'custom'){
        $("#iconId").removeAttr("readonly");
    }else{
        $("#iconId").attr("readonly","readonly");
    }
    //控制各个类型按钮的特殊属性显隐
    $("#specialAttributes").find(".property-list").hide();
    $("#specialAttributes").find("."+buttonType+"_button").show();
    //设置所有选择框未选中
    $("#property_form").each( function(){
        this.reset();
        $(this).find("input[type='checkbox'],input[type='radio']").attr("checked",false);
    });
    if (jsondata){
        $("#property_form").setform(jsondata,false);
    }
}

//画层级区域
function drawListArea(){
    $("#list_area").html("");

    if (!isEmpty(dataJsonList)){
        for (var i=0;i<dataJsonList.length;i++){
            var id = dataJsonList[i].id;
            var item = $('<li id="'+id+'" class="item-list" style="overflow: hidden"></li>');
            if (id == curId){
                item.addClass("current");
            }
            item.append('<span class="item-order" order="'+(i+1)+'">['+(i+1)+']</span>').append('<span class="item-title" style="font-size: 13px">'+(dataJsonList[i].data.iconName!=''?dataJsonList[i].data.iconName:'按钮'+ (i + 1)) +'</span>');
            if (dataJsonList[i].data.buttonType == "custom") {
                var removeButton = $('<a href="javascript:void(0)" class="remove"></a>');
                removeButton.append('<i class="fa fa-times"></i>');
                item.append(removeButton);
                removeButton.click(function () {
                    removeItem(this);
                });
            }

            item.click(function(){
                itemClick(this);
            }).hover(function(){
                $(this).addClass("hover");
            },function(){
                $(this).removeClass("hover");
            });
            $("#list_area").append(item);

        }
    }
}

function update(id){
    var json = $("#property_form").serializeObject();
    updateJsonData(id,json);
    drawListArea();
}


function delJsonData(id){
    for (var i=0;i<dataJsonList.length;i++){
        if (dataJsonList[i].id == id){
            dataJsonList.splice(i, 1);
            break;
        }
    }
}

function updateJsonData(id,json){
    for (var j=0;j<dataJsonList.length;j++){
        if (dataJsonList[j].id == id){
            dataJsonList[j].data = json;
            dataJsonList[j].data.colIsVisible = $('#colIsVisible').is(':checked')?"Y":"N";
            break;
        }
    }
}

function putJsonData (id,json,index){
    if (index != undefined){
        dataJsonList.splice(index, 0, {id:id,data:json});
    }else{
        dataJsonList.push({
            id:id,
            data:json
        });
    }
}

//form转json
function formattingForm(form){
    var formArray = form.serializeArray();
    var obj={};
    $(formArray).each(function(){
        obj[this.name]=this.value;
    });
    return obj;
}
//添加层级
function addItem(){
    if(curId!=undefined){
        updateJsonData(curId,formattingForm($('#property_form')));
    }
    //添加新的层级
    var lastNum = dataJsonList.length+1;
    var id = GenNonDuplicateID();
    curId = id;
    $('#iconId').val("btn_"+lastNum);
    $('#iconName').val("按钮"+lastNum);
    $('#buttonIcon').val("");
    $('#buttonclick').val("");
    $('#colIsVisible').prop("checked",true);
    data={
        iconId:"btn_"+lastNum,
        iconName:"按钮"+lastNum,
        buttonIcon:"",
        buttonType:"custom",
        buttonclick:"",
        colIsVisible:"Y"
    }
    putJsonData(id,data);
    drawListArea();
    $("#"+id).click();
}


var newRowIndex = 0;
var newRowStart = "new_row";


function jqgridInit(jsonDatas,originalParam){
    jsonDatas = jsonDatas.replace(/&lt;/g, "<");
    jsonDatas = jsonDatas.replace(/&gt;/g, ">");
    jsonDatas = jsonDatas.replace(/&amp;/g, "&");
   var datas = jsonDatas=="" ? [] : JSON.parse(jsonDatas);
    if (datas.length>0) {
        for (var i = 0; i < datas.length; i++) {
            var data = datas[i];
            var type = data.data.buttonType;
            if (type === "insert"){
                data.data.iconId = tableName + "_insertBtn";
            }else if (type === "export"){
                data.data.iconId = tableName + "_exportBtn";
            }else if (type === "import"){
                data.data.iconId = tableName + "_importBtn";
            }else if (type === "delete"){
                data.data.iconId = tableName + "_deleteBtn";
            }else if (type === "dictionary"){
                data.data.iconId = tableName + "_inputBtn";
            }
            var id = data.id;
            putJsonData(id, data.data);
        }
    }
    curId = dataJsonList[0].id;
    drawListArea();
    $("#"+curId).click();

}



function setIconInfo(data) {
    if(data.type=="bootstrap"){
        $("#buttonIcon").val("<span class = '"+data.icon+"'></span>");
    }else{
        $("#buttonIcon").val("<i class = '"+data.icon+"'></i>");
    }
    layer.close(iconlayer);
}

function escape2Html(str) {
    var arrEntities={'lt':'<','gt':'>','nbsp':' ','amp':'&','quot':'"'};
    return str.replace(/&(lt|gt|nbsp|amp|quot);/ig,function(all,t){return arrEntities[t];});
}

$(document).ready(function () {
    //编辑图标
    $(".iconBtn").click(function () {
        var content = 'static/h5/selectIcon/index.html';
        iconlayer = layer.open({
            type: 2,
            title: "",
            params:{callBack:"t"},
            skin: 'bs-modal',
            area: ['90%', '90%'],
            shadeClose: false,
            closeBtn:2,
            content: content
        });
    });
    //层级初始化
    $("#item_add").click(function () {
        addItem();
    });

    $("#list_area").sortable({
        stop: function (e, t) {
            var $li = $(t.item);
            var id = $li.attr("id");
            var order = $li.prev().find(".item-order").attr("order") || "0";
            var data = getJsonData(id);
            delJsonData(id);
            if (t.position.top>t.originalPosition.top){
                putJsonData(id, data, parseInt(order)-1);
            }else{
                putJsonData(id, data, parseInt(order));
            }

            drawListArea();
            $("#" + curId).click();
        }
    });

    $("#iconName").change(function () {
        update(curId);
    });

    $.ajax({
        url: 'platform/eform/eformViewInfoController/getEformClassConfigListByType/8',
        contentType: "application/xml; charset=utf-8",
        type : 'post',
        dataType : 'json',
        async:false,
        success : function(r){
            if (r != null) {
                var list = $.parseJSON(r.data);
                var $colDom = $("#event_delete_java");
                $colDom.empty();
                $colDom.append($('<option value=""></option>'));
                for (var i=0;i<list.length;i++){
                    var $option = $('<option value="'+list[i].classPath+'">'+list[i].className+'</option>');
                    $colDom.append($option);
                }

            }
        }
    });

    $("#propertyBtn").click(function () {
        linkagedialog = top.layer.open({
            type: 2,
            title: '参考录入配置',
            skin: 'bs-modal',
            area: ['800px', '570px'],
            maxmin: false,
            content: "avicit/platform6/eform/formdesign/js/plugins/dictionary-box/dictionary-property.jsp?isMain=0&selectType=2",
            btn: ['确定', '取消'],
            success: function (layero, index) {
                var iframeWin = layero.find('iframe')[0].contentWindow;
                var dictionaryPara = $('#dictionaryPara').val();
                var rowCount = $('#rowCount').val();
                var queryStatement = $('#queryStatement').val();
                var jsSuccess = $('#jsSuccess').val();
                var jsBefore = $('#jsBefore').val();
                var jsAfter = $('#jsAfter').val();

                var isMuti = $('#isMuti').val();
                var waitSelect = $('#waitSelect').val();


                var dataCombox = $('#dataCombox').val();
                var dataComboxType = $('#dataComboxType').val();
                var dataComboxText = $('#dataComboxText').val();

                //iframeWin.initForm(rowCount,escape2Html(queryStatement),dictionaryPara,jsSuccess,jsBefore,jsAfter,dataCombox,dataComboxType,dataComboxText,selectMuti);
                iframeWin.initForm(rowCount,escape2Html(queryStatement),dictionaryPara,jsSuccess,
                    jsBefore,jsAfter,dataCombox,dataComboxType,dataComboxText,isMuti,waitSelect,
                    "","","","","","","2");

                var attrJson = $('#colList', window.parent.document).val();
                var colList = $.parseJSON(attrJson);
                iframeWin.changeTargetNameFunc(colList);
            },
            yes: function(index, layero){
                var frm = layero.find('iframe')[0].contentWindow;
                var reData = frm.commitForm();
                if (reData == false){
                    return false;
                }
                //$("#dictionaryName").val(reData.dictionaryName);
                $("#rowCount").val(reData.rowCount);
                $("#queryStatement").val(reData.queryStatement);

                $("#jsSuccess").val(reData.jsSuccess);
                $("#jsBefore").val(reData.jsBefore);
                $("#jsAfter").val(reData.jsAfter);

                $("#isMuti").val(reData.isMuti);
                $("#waitSelect").val(reData.waitSelect);

                $("#dataCombox").val(reData.dataCombox);
                $("#dataComboxType").val(reData.dataComboxType);
                $("#dataComboxText").val(reData.dataComboxText);

                $("#dictionaryPara").val(JSON.stringify(reData.datagridData)).trigger("keyup");
                top.layer.close(index);

            },
            no: function(index, layero){
                layero.close(index);
            }
        });
    });

});