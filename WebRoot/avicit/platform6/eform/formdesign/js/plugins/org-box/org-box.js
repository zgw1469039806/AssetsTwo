var MyElement = {
    elecode: "org-box",
    colType:"CLOB",
    allowType:"VARCHAR2",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "选组织";
    	dragelement.icon = "fa fa-tree";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="组织选择框">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },
    validateForm:function(eleattr){
        if(eleattr.hasOwnProperty("chuantou")&&eleattr.chuantou=="Y") {
            var regExp = /[\S+]/i;
            if((!eleattr.chuantouurl)||(eleattr.chuantouurl!=null && !regExp.test(eleattr.chuantouurl)))
            {
                layer.msg('控件['+eleattr.colName+']的穿透页面URL属性不能为空', {icon: 7});
                return false;
            }
        }
        if(eleattr.hasOwnProperty("redundance")&&eleattr.redundance=="Y") {
            var regExp = /[\S+]/i;
            if((!eleattr.redundanceColName)||(eleattr.redundanceColName==null)||(eleattr.redundanceColName==""))
            {
                layer.msg('控件['+eleattr.colName+']的冗余字段名不能为空', {icon: 7});
                return false;
            }
        }
        return true;
    },
    initAttrForm:function(form,attrJson){
        if(attrJson){
            var ajObject = JSON.parse(attrJson);
            if(ajObject.hasOwnProperty("chuantou")&&ajObject.chuantou == "Y"){
                $("#chuantouurldiv").show();
            }else{
                $("#chuantouurldiv").hide();
            }
            if(ajObject.hasOwnProperty("redundance")&&ajObject.redundance == "Y"){
                $("#redundanceColNameDiv").show();
            }else{
                $("#redundanceColNameDiv").hide();
            }
        }else{
            $("#chuantouurldiv").hide();
            $("#redundanceColNameDiv").hide();
        }
        $("#chuantou").change(function() {
            if($("#chuantou").is(':checked')){
                $("#chuantouurldiv").show();
            }else{
                $("#chuantouurldiv").hide();
            }
        });


        $("#propertyBtn").click(function () {

            selectDialog = top.layer.open({
                type: 2,
                title: '组织范围',
                skin: 'bs-modal',
                area: ['1100px', '570px'],
                maxmin: false,
                content: "avicit/platform6/eform/formdesign/js/plugins/attr-jsp/commonselect-default.jsp",
                btn: ['确定', '取消'],
                yes: function(index, layero){
                    var frm = layero.find('iframe')[0].contentWindow;
                    var jsonData = [], rs = [];
                    jsonData = frm.dataJsonList;
                    if (!jsonData){
                        return false;
                    }

                    if (jsonData.length > 0) {
                        for (var i = 0; i < jsonData.length; i++) {
                            var data = jsonData[i].data;
                            rs.push(data);
                        }
                    }
                    $("#orglist").val(JSON.stringify(rs)).trigger("keyup");

                    top.layer.close(index);

                },
                no: function(index, layero){
                    layero.close(index);
                },
                success:function(layero, index){
                    var frm = layero.find('iframe')[0].contentWindow;
                    frm.selecttype = "orgSelect";
                }
            });
        });
    }
};