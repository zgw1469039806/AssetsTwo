function FieldRelationControl (option) {
    this.id = option.id;
    this.dataDomId = option.dataDomId;
    this.tableId = option.tableId;
    this.formId = option.formId;
    this.callback = option.callback;
    this.option = option;
    this.process = option.process;
    this.attachmentTableId = option.attachmentTableId;
    // 将配置信息保存到dom对象里，方便在弹出页面调用
    $("#"+this.dataDomId).data("data-object", this);
    var dataDomId = encodeURIComponent(this.dataDomId);
    this.template = "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/FieldRelationControl/FieldRelationControl.jsp?dataDomId="
        +dataDomId;
    this.init();
}

FieldRelationControl.prototype.init = function() {
    var _self = this;
    layer.config({
        extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
    });
    var box = layer.open({
        type:  2,
        area: [ "800px",  "600px"],
        title: "表单字段关联控制",
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        shade:   0.3,
        maxmin: true, //开启最大化最小化按钮
        content: _self.template ,
        btn: ['确定', '关闭'],
        yes: function(index, layero){
            var iframeWin = layero.find('iframe')[0].contentWindow;
            var allConfigValue = iframeWin.getAllConfigValue();
            if(allConfigValue && allConfigValue.length>0){
                var allConfigValueJson = JSON.stringify(allConfigValue)
                $("#"+_self.dataDomId).val(allConfigValueJson);
                _self.addAllConfigValue(allConfigValue);
            }else{
                $("#"+_self.dataDomId).val("");
                var _table =  $("#"+_self.id+" #"+_self.tableId+" tbody");
                _table.empty();
            }
            layer.close(index);
        },
        cancel: function(index){
            layer.close(index);
        },
        success: function(layero, index){
        }
    });
};

FieldRelationControl.prototype.getTableTr = function(configObj){
    var _self = this;
    var _tr = $("<tr></tr>");
    var _td1 = $("<td></td>");
    var conditonValues = configObj.conditonValues;
    var conditionHtml = "";
    var conditonTitle = "";
    if(conditonValues && conditonValues.length){
        for(var i=0;i<conditonValues.length;i++){
            conditionHtml += conditonValues[i].controlTagName+" "+conditonValues[i].operName+" "+conditonValues[i].compareValueName+"<br>";
            conditonTitle += conditonValues[i].controlTagName+" "+conditonValues[i].operName+" "+conditonValues[i].compareValueName+"\n";
        }
    }
    _td1.append(conditionHtml);
    _td1.attr("title",conditonTitle);
    var _td2 = $("<td></td>");
    var beControledFields = configObj.beControledFields;
    var beControledFieldsHtml = "";
    var beControledFieldsTitle = "";
    if(beControledFields && beControledFields.length){
        for(var j=0;j<beControledFields.length;j++){
            beControledFieldsHtml+=beControledFields[j].tagName;
            if(beControledFields[j].accessibility == "1"){
                beControledFieldsHtml+="可显示";
                beControledFieldsTitle+=" 可显示";
            }else{
                beControledFieldsHtml+=" 隐藏";
                beControledFieldsTitle+=" 隐藏";
            }
            if(beControledFields[j].hideRow == "1"){
                beControledFieldsHtml+=" 隐藏行";
                beControledFieldsTitle+=" 隐藏行";
            }else{
                beControledFieldsHtml+=" 不隐藏行";
                beControledFieldsTitle+=" 不隐藏行";
            }
            if(beControledFields[j].operability == "1"){
                beControledFieldsHtml+=" 可编辑";
                beControledFieldsTitle+=" 可编辑";
            }else{
                beControledFieldsHtml+=" 不可编辑";
                beControledFieldsTitle+=" 不可编辑";
            }
            if(beControledFields[j].required == "1"){
                beControledFieldsHtml+=" 必填";
                beControledFieldsTitle+=" 必填";
            }else{
                beControledFieldsHtml+=" 非必填";
                beControledFieldsTitle+=" 非必填";
            }
            beControledFieldsHtml+="<br>";
            beControledFieldsTitle+="\n";
        }
    }
    _td2.append(beControledFieldsHtml);
    _td2.attr("title",beControledFieldsTitle);
    _tr.append(_td1);
    _tr.append(_td2);
    return _tr;
};
FieldRelationControl.prototype.getTableTr1 = function(configObj){
    var _self = this;
    var _tr = $("<tr></tr>");
    var _td1 = $("<td></td>");
    var conditonValues = configObj.conditonValues;
    var _subTable = $("<table class=\"form_commonTable\" border=\"0\"></table>");
    if(conditonValues && conditonValues.length){
        for(var i=0;i<conditonValues.length;i++){
            var _subTr = $("<tr></tr>");
            var _subTd1 = $("<td width='30%'></td>");
            _subTd1.append(conditonValues[i].controlTagName);
            var _subTd2 = $("<td width='20%'></td>");
            _subTd2.append(conditonValues[i].operName);
            var _subTd3 = $("<td width='50%'></td>");
            _subTd3.append(conditonValues[i].compareValueName);
            _subTr.append(_subTd1);
            _subTr.append(_subTd2);
            _subTr.append(_subTd3);
            _subTable.append(_subTr);
            //conditionHtml+= conditonValues[i].conditonName + "<br>";
        }
    }
    _td1.append(_subTable);
    var _td2 = $("<td></td>");
    var beControledFields = configObj.beControledFields;
    var _subTable1 = $("<table class=\"form_commonTable\" border=\"0\"></table>");
    if(beControledFields && beControledFields.length){
        for(var j=0;j<beControledFields.length;j++){
            var _subTr = $("<tr></tr>");
            var _subTd1 = $("<td></td>");
            _subTd1.append(beControledFields[j].tagName);
            var _subTd2 = $("<td></td>");
            if(beControledFields[j].accessibility == "1"){
                _subTd2.append("可显示");
            }else{
                _subTd2.append("隐藏");
            }
            var _subTd3 = $("<td></td>");
            if(beControledFields[j].hideRow == "1"){
                _subTd3.append("隐藏行");
            }else{
                _subTd3.append("不隐藏行");
            }
            var _subTd4 = $("<td></td>");
            if(beControledFields[j].operability == "1"){
                _subTd4.append("可编辑");
            }else{
                _subTd4.append("不可编辑");
            }
            var _subTd5 = $("<td></td>");
            if(beControledFields[j].required == "1"){
                _subTd5.append("必填");
            }else{
                _subTd5.append("非必填");
            }
            _subTr.append(_subTd1);
            _subTr.append(_subTd2);
            _subTr.append(_subTd3);
            _subTr.append(_subTd4);
            _subTr.append(_subTd5);
            _subTable1.append(_subTr);
        }
    }
    _td2.append(_subTable1);
    _tr.append(_td1);
    _tr.append(_td2);
    return _tr;
};

FieldRelationControl.prototype.addAllConfigValue = function(allConfigValue){
    var _self = this;
    var _table =  $("#"+_self.id+" #"+_self.tableId+" tbody");
    _table.empty();
    if(allConfigValue.length && allConfigValue.length>0){
        for(var i=0;i<allConfigValue.length;i++){
            _table.append(_self.getTableTr(allConfigValue[i]));
        }
    }
};
