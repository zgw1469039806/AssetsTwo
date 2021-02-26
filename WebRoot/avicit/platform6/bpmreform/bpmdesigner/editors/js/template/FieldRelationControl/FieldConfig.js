function FieldConfig (option) {
    this.dataDomId = option.dataDomId;
    this.tableId = option.tableId;
    this.buttonId = option.buttonId;
    this.formFields = option.formFields;
    this.allElements = option.allElements;
    this.subFieldsMap = option.subFieldsMap;
    this.secretList = option.secretList;
    this.callback = option.callback;
    this.option = option;
    // 将配置信息保存到dom对象里，方便在弹出页面调用
    $("#"+this.dataDomId).data("data-object", this);
    var dataDomId = encodeURIComponent(this.dataDomId);
    this.template = "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/FieldRelationControl/FieldConfig.jsp?dataDomId="
        +dataDomId;
    this.init();
}

FieldConfig.prototype.init = function() {
    var _self = this;
    $("button[name='"+_self.buttonId+"']").on("click", function(e){
        e.preventDefault();
        _self.openDialog();
    });
};

FieldConfig.prototype.openDialog = function() {
    var _self = this;
    layer.config({
        extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
    });
    var fieldConfigWindow = layer.open({
        type:  2,
        area: [ "800px",  "500px"],
        title: "字段关联配置",
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        shade:   0.3,
        maxmin: true, //开启最大化最小化按钮
        content: _self.template ,
        btn: ['确定', '关闭'],
        yes: function(index, layero){
            var iframeWin = layero.find('iframe')[0].contentWindow;
            if(iframeWin.valid()){
                var configValue = iframeWin.getConfigValue();
                _self.addSysData(configValue);
                layer.close(index);
            }
        },
        cancel: function(index){
            layer.close(index);
        },
        success: function(layero, index){
        }
    });
    layer.full(fieldConfigWindow);
};

FieldConfig.prototype.getTableTr = function(configObj){
    var _self = this;
    var _tr = $("<tr></tr>");
    var _td1 = $("<td width='40%'></td>");
    var _hidden = $("<input type='hidden' name='fieldConfigValue'/>");
    _hidden.val(JSON.stringify(configObj));
    _td1.append(_hidden);
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
    var _td2 = $("<td width='40%'></td>");
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
    var op = "<td width='20%'><a href='javascript:void(0)' name='deleteData'><i class='iconfont icon-delete'></i></a>" +
        "<a href='javascript:void(0)' name='modifyData' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
    var _td3 = $(op);
    _td3.find("a[name='deleteData']").off("click").on("click",function() {
        $(this).parent().parent().remove();
    });
    _td3.find("a[name='modifyData']").off("click").on("click",function() {
        var $oldTr = $(this).parentsUntil("tr").parent();
        var configStr = $oldTr.find("td:eq(0)").find("input").val();
        var configObjModify = JSON.parse(configStr);
        $("#"+_self.dataDomId).data("configObj",configObjModify);
        layer.config({
            extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
        });
        var modifyFieldWindow = layer.open({
            type:  2,
            area: [ "800px",  "500px"],
            title: "字段关联配置",
            skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
            shade:   0.3,
            maxmin: true, //开启最大化最小化按钮
            content: _self.template+"&update=1",
            btn: ['确定', '关闭'],
            yes: function(index, layero){
                var iframeWin = layero.find('iframe')[0].contentWindow;
                if(iframeWin.valid()){
                    var configObj = iframeWin.getConfigValue();
                    _self.modifyTableTr($oldTr,configObj);
                    layer.close(index);
                }

            },
            cancel: function(index){
                layer.close(index);
                $('html').addClass('fix-ie-font-face');
                setTimeout(function() {
                    $('html').removeClass('fix-ie-font-face');
                }, 10);
            },
            success: function(layero, index){
            }
        });
        layer.full(modifyFieldWindow);
    });
    _tr.append(_td1);
    _tr.append(_td2);
    _tr.append(_td3);
    return _tr;
};

FieldConfig.prototype.getTableTr1 = function(configObj){
    var _self = this;
    var _tr = $("<tr></tr>");
    var _td1 = $("<td></td>");
    _td1.append(configObj.controlTagName);
    var _hidden = $("<input type='hidden'/>");
    _hidden.val(JSON.stringify(configObj));
    _td1.append(_hidden);
    _tr.append(_td1);
    var _td2 = $("<td></td>");
    _td2.append(configObj.operName);
    var _td3 = $("<td></td>");
    _td3.append(configObj.compareValueName);
    var _td4 = $("<td></td>");
    _td4.append(configObj.tagName);
    var _td5 = $("<td></td>");
    _td5.append(configObj.accessibility=='1'?'是':'否');
    var _td6 = $("<td></td>");
    _td6.append(configObj.hideRow=='1'?'是':'否');
    var _td7 = $("<td></td>");
    _td7.append(configObj.operability=='1'?'是':'否');
    var _td8 = $("<td></td>");
    _td8.append(configObj.required=='1'?'是':'否');
    var op = "<td><a href='javascript:void(0)' name='deleteData'><i class='iconfont icon-delete'></i></a>" +
        "<a href='javascript:void(0)' name='modifyData' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
    var _td9 = $(op);
    _td9.find("a[name='deleteData']").off("click").on("click",function() {
        $(this).parent().parent().remove();
    });

    _td9.find("a[name='modifyData']").off("click").on("click",function() {
        var $oldTr = $(this).parentsUntil("tr").parent();
        var configStr = $oldTr.find("td:eq(0)").find("input").val();
        var configObjModify = JSON.parse(configStr);
        $("#"+_self.dataDomId).data("configObj",configObjModify);
        layer.config({
            extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
        });
        var modifyFieldWindow = layer.open({
            type:  2,
            area: [ "700px",  "330px"],
            title: "字段关联配置",
            skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
            shade:   0.3,
            maxmin: true, //开启最大化最小化按钮
            content: _self.template+"&update=1",
            btn: ['确定', '关闭'],
            yes: function(index, layero){
                var iframeWin = layero.find('iframe')[0].contentWindow;
                if(iframeWin.valid()){
                    var configObj = iframeWin.getConfigValue();
                    _self.modifyTableTr($oldTr,configObj);
                    layer.close(index);
                }

            },
            cancel: function(index){
                layer.close(index);
                $('html').addClass('fix-ie-font-face');
                setTimeout(function() {
                    $('html').removeClass('fix-ie-font-face');
                }, 10);
            },
            success: function(layero, index){
            }
        });
    });
    _tr.append(_td1);
    _tr.append(_td2);
    _tr.append(_td3);
    _tr.append(_td4);
    _tr.append(_td5);
    _tr.append(_td6);
    _tr.append(_td7);
    _tr.append(_td8);
    _tr.append(_td9);
    return _tr;
};

FieldConfig.prototype.modifyTableTr = function(_tr,configObj){
    var _self = this;
    _tr.replaceWith(_self.getTableTr(configObj));
};

FieldConfig.prototype.addSysData = function(configObj){
    var _self = this;
    //var _table =  $("#"+_self.tableId+" tbody",window.parent.document);
    var _table =  $("#"+_self.tableId);
    _table.append(_self.getTableTr(configObj));

};