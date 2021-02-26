var MyElement = {
    elecode: "form-box",
    colType:"NOT_DB_COL_ELE",
    //selectflag:false,
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "引用表单";
    	dragelement.icon = "fa fa-quote-right";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="引用表单">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();

        if (attrJson.hasOwnProperty("formid")&&this.selectflag) {
            if (!ui.hasClass("element")) {
                var ii = $(ui.find(".element")[0]);
                ui.replaceWith($(ui.find(".element")[0]));
                ui = ii;
            }
            this.selectflag = false;
            var uid = ui.attr("id");
            var editorcontent = $("<div>"+tinymce.activeEditor.getContent()+"</div>");
            var content = $(this.getHtmlContent(attrJson.formid));
            content.find(".eleattr-span").remove();
            content.find(".element").removeClass("element");
            var html = content.html();
            ui.wrap("<div for=\""+uid+"\" contenteditable=\"false\" class=\"show-dom-area\"></div>");
            ui.css("display","none");
            ui.removeClass("onchoose");
            ui.parent().append(html);

            editorcontent.find("#"+uid).replaceWith(ui.parent().prop("outerHTML"));
            tinymce.activeEditor.setContent(editorcontent.html());

            //模拟点击该控件元素
            $('#tinymceArea_ifr').contents().find('.element').each(function (index, element) {
                var eleViewId = $(element).attr("id");
                $('#tinymceArea_ifr').contents().find('#' + eleViewId).click();
            });
        }
    },

    validateForm:function(eleattr){
        var regExp = /[\S+]/i;
        if(!eleattr.formname || !eleattr.fkcol ||(eleattr.fkcol!=null && !regExp.test(eleattr.fkcol)))
        {
            layer.msg('引用表单控件引用表单、关联外键不能为空', {icon: 7});
            return false;
        }
        if (!eleattr.domId ||(eleattr.domId!=null && !regExp.test(eleattr.domId))) {
            layer.msg('引用表单控件页面元素ID属性不能为空', {icon: 7});
            return false;
        }else{
            var value=eleattr.domId,
                regEn = /[`~!@#$%^&*()+<>?:{},.\/;'[\]]/im,
                regCn = /[·！#￥（——）：；“”‘、，|《。》？、【】[\]]/im,
                regCh = /[\u4E00-\u9FA5]|[\uFE30-\uFFA0]/gi;
            if(regEn.test(value) || regCn.test(value) ||regCh.test(value)) {
                layer.msg('引用表单控件页面元素ID属性不能含有特殊字符或中文', {icon: 7});
                return false;
            }
        }

        return true;
    },

    initAttrForm: function (form, attrJson) {
        $("#domId").val(GenNonDuplicateID()).trigger("keyup");
        var _self = this;
        var selectPublishEform = new SelectPublishEform("formid", "formname", null, "", "eform");
        selectPublishEform.init(function(data) {
            _self.selectflag = true;
            $("#dbid").val(data.treeNode.attribute.datasourceId);
            $("#paralist").val("");
            $("#paraarea").html("");
            $("#formname").trigger("keyup");
        });
        $("#addpara").click(function () {
            /*if (isEmptyObject($("#dbid").val())){
                layer.msg('请先选择数据集！', {icon: 7});
                return false;
            }*/
            publishDialog = top.layer.open({
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
                    $("#paraarea").html("");
                    if (jsonData.length > 0) {
                        for (var i = 0,length=jsonData.length; i < length; i++) {
                            var data = jsonData[i].data;
                            var li = $('<li class="item-red clearfix"></li>');
                            var coltypediv = $('<div class="col-xs-3"><i class="ace-icon fa fa-bars"></i></div>');
                            var colLabeldiv = $('<div class="col-xs-9"></div>');
                            colLabeldiv.append('<span class="lbl">' + data.paratypename + '</span>');
                            li.append(coltypediv).append(colLabeldiv);
                            $("#paraarea").append(li);
                            rs.push(data);
                        }
                        $("#paralist").val(JSON.stringify(rs)).trigger("keyup");
                    } else {
                        $("#paraarea").empty();
                        $("#paralist").val("").trigger("keyup");
                    }
                    top.layer.close(index);

                },
                no: function(index, layero){
                    layero.close(index);
                },
                success: function(layero, index){
                    var frm = layero.find('iframe')[0].contentWindow;
                    frm.initPage({
                        dbid:$("#dbid").val(),
                        dbArray:DataArea.dbarray
                    });
                    var btn1= $(".layui-layer-btn .layui-layer-btn0");
                    btn1.addClass("form-tool-btn");
                    btn1.addClass("typeb");
                }
            });
        });

        if (attrJson) {
            var json = $.parseJSON(attrJson);
            if (json.paralist) {
                var list = $.parseJSON(json.paralist);
                for (var i = 0; i < list.length; i++) {
                    var data = list[i];
                    var li = $('<li class="item-red clearfix"></li>');
                    var coltypediv = $('<div class="col-xs-3"><i class="ace-icon fa fa-bars"></i></div>');
                    var colLabeldiv = $('<div class="col-xs-9"></div>');
                    colLabeldiv.append('<span class="lbl">' + data.paratypename + '</span>');
                    li.append(coltypediv).append(colLabeldiv);
                    $("#paraarea").append(li);
                }
            }
        }
    },
    getHtmlContent: function (formid) {
        var content = "";
        $.ajax({
            url: 'platform/eform/bpmsClient/getFormContent/'+formid,
            contentType: "application/xml; charset=utf-8",
            type : 'post',
            dataType : 'json',
            async:false,
            success : function(r){
                if (r != null) {
                    content = r.content;
                }
            }
        });
        return content;
    }
};