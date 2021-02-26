var MyElement = {
    elecode: "print-text-box",
    colType:"VARCHAR2",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "打印文本";
    	dragelement.icon = "fa fa-text-height";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="文本展示框">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },
    initAttrForm: function (form, attrJson) {
        var _this = this;
        if (attrJson) {
            var json = $.parseJSON(attrJson);
        }
        var ele = EformEditor.nowElement;
        var aa = new selectarea("selectarea",{
            lookup_url:"avicit/platform6/eform/printdesign/js/plugins/print-text-box/addLookup.jsp"
            // ,
            // onChange: function(obj){
            //    var eleattr = ele.find(".eleattr-span");
            //     ele.empty();
            //     if (!obj.length>0){
            //         ele.append('<input type="checkbox"><span class="option">复选按钮</span>');
            //     }
            //     for (var i = 0; i < obj.length; i++) {
            //         var value = obj[i].value;
            //         var option = obj[i].option;
            //         ele.append('<input type="checkbox"  value="' + value + '"><span class="option">' + option + '</span>');
            //     }
            //     ele.append(eleattr);
            // }
        });

        //增加通用代码显示通用代码类型及名称功能
        var attrJsonObj = attrJson!=undefined?JSON.parse(attrJson):new Object;

        var array=[];
        // 如果是键值，改为从attrJson找键值定义
        if(attrJsonObj.colformat === 'lookup'){
            var optionInfo = attrJsonObj.selectedoption;
            var valueInfo = attrJsonObj.selectedvalues;
            var optList = optionInfo.split(',');
            var valList = valueInfo.split(',');
            if(optList[optList.length -1] === ''){
                optList.pop();
            }
            for(var i =0; i < optList.length; i++){
                var obj = {};
                obj.lookupCode = valList[i];
                obj.lookupName = optList[i];
                array.push(obj);
            }

        }
        if(attrJsonObj.hasOwnProperty("showLookupType")){
            var ob = new Object();
            ob.rows = array;
            ob.lookupType = attrJsonObj.showLookupType;
            ob.lookupTypeName = attrJsonObj.showLookupTypeName;
            aa.setSelect(ob);
        }else{
            aa.setSelect(array);
        }

    }
};