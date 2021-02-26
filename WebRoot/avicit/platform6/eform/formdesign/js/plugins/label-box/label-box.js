var MyElement = {
    elecode: "label-box",
    colType: "NOT_DB_COL_ELE",
    dragElement: function () {
        var dragelement = {};
        dragelement.name = "标签";
        dragelement.icon = "fa fa-tag";
        return dragelement;
    },
    dropElement: function () {
        return '<label for="">标签</label>';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },
    initAttrForm: function (form, attrJson) {
        var labelEle = EformEditor.nowElement[0].firstChild;//面板标签dom
        //var labelAttr=$.parseJSON(EformEditor.nowElement.children('.eleattr-span').html());//标签属性
        var allEle = editorUtil.getAllDomAttr();
        var bindField = form[0].bindField;//右侧菜单栏绑定字段dom
        var labelText = form[0].labelName;//右侧菜单栏标签名称
        var eleMap={};//用来存储所有控件的英文名和中文名
        var i = 1;
        var op = new Option("请选择");
        bindField.options[0] = op;
        for (ele in allEle) {
            if (ele != "clone" && ("domId" in allEle[ele] || "colName" in allEle[ele] || "subTableName" in allEle[ele]) && allEle[ele]["domType"] != "label-box") {
            	if (allEle[ele]["colName"] != undefined && allEle[ele]["colName"] != "") {
                    var op = new Option(allEle[ele]["colName"], allEle[ele]["colName"]);
                    if (allEle[ele]["domId"] != undefined && allEle[ele]["domId"] != "") {
                        op = new Option(allEle[ele]["domId"], allEle[ele]["domId"]);
                    }
                    bindField.options[i] = op;
                    if(allEle[ele]["colLabel"]!= undefined&& $.trim(allEle[ele]["colLabel"])!="")
                	{
                    	 eleMap[allEle[ele]["colName"]] = allEle[ele]["colLabel"];
                	}else if(allEle[ele]["title"]!= undefined&& $.trim(allEle[ele]["title"])!="")
            		{
                		eleMap[allEle[ele]["colName"]] = allEle[ele]["title"];
            		}else if(allEle[ele]["colName"]!= undefined&& $.trim(allEle[ele]["colName"])!="")
        			{
        				eleMap[allEle[ele]["colName"]] = allEle[ele]["colName"];
        			}else
    				{
        				eleMap[allEle[ele]["colName"]] = "标签";
    				}
                   
                }else if (allEle[ele]["domId"] != undefined && allEle[ele]["domId"] != "") {
                    var op = new Option(allEle[ele]["domId"], allEle[ele]["domId"]);
                    bindField.options[i] = op;
                    if(allEle[ele]["colLabel"]!= undefined&& $.trim(allEle[ele]["colLabel"])!="")
                	{
                    	eleMap[allEle[ele]["domId"]] = allEle[ele]["colLabel"];
                	}else if(allEle[ele]["title"]!=undefined&& $.trim(allEle[ele]["title"])!="")
            		{
                		eleMap[allEle[ele]["domId"]] = allEle[ele]["title"];
            		}else if(allEle[ele]["colName"]!= undefined&& $.trim(allEle[ele]["colName"])!="")
        			{
        				eleMap[allEle[ele]["domId"]] = allEle[ele]["colName"];
        			}else
    				{
        				eleMap[allEle[ele]["domId"]] = "标签";
    				}
                    
                }else if (allEle[ele]["subTableName"] != undefined && allEle[ele]["subTableName"] != ""){
                    var op = new Option(allEle[ele]["subTableName"], allEle[ele]["subTableName"]);
                    bindField.options[i] = op;
                    if(allEle[ele]["title"]!=undefined&& $.trim(allEle[ele]["title"])!="")
                    {
                        eleMap[allEle[ele]["subTableName"]] = allEle[ele]["title"];
                    }else if(allEle[ele]["subTableName"]!= undefined&& $.trim(allEle[ele]["subTableName"])!="")
                    {
                        eleMap[allEle[ele]["subTableName"]] = allEle[ele]["subTableName"];
                    }else
                    {
                        eleMap[allEle[ele]["subTableName"]] = "标签";
                    }
                }
                i = i + 1;
            }
        }
        
        
        bindField.onclick = function () {
            if (bindField.value != "请选择") {
                if (labelText.value == "" || labelText.value == "标签") {
                    labelText.value = eleMap[bindField.value];
                    labelEle.innerHTML = labelText.value;

                }
                for (e in allEle) {
                    if ((e != "clone" && ("colName" in allEle[e]) && allEle[e]["colName"] == bindField.value)
                        || e != "clone" && ("domId" in allEle[e]) && allEle[e]["domId"] == bindField.value) {

                        if (allEle[e]["colIsMust"] == 'Y') {
                            if (EformEditor.nowElement.find(".required").length == 0)//防止多填
                            {
                                EformEditor.nowElement.find("label").prepend("<i class='required' style='color:red;'>*</i>");
                                $("#colIsMust").val("Y").trigger("keyup");
                            }
                        }
                        else {
                            if (EformEditor.nowElement.find(".required").length > 0) {
                                EformEditor.nowElement.find(".required").remove();
                                $("#colIsMust").val("N").trigger("keyup");
                            }
                        }

                        if (allEle[e]["colIsVisible"] == 'Y') {
                            $('input[name=colIsVisibleShow]').eq(1).removeAttr("checked");
                            $('input[name=colIsVisibleShow]').eq(0).attr("checked", 'checked');
                            $('input[name=colIsVisibleShow]').eq(0).trigger("keyup");
                        }
                        else {
                            $('input[name=colIsVisibleShow]').eq(0).removeAttr("checked");
                            $('input[name=colIsVisibleShow]').eq(1).attr("checked", 'checked');
                            $('input[name=colIsVisibleShow]').eq(1).trigger("keyup");
                        }

                        $('input[name=colIsVisible]').val(allEle[e]["colIsVisible"]);
                        $('input[name=colIsVisible]').trigger("keyup");

                        if (allEle[e]["domId"] != "") {
                            labelEle.setAttribute("for", allEle[e]["domId"]);
                         
                        }
                        else {
                            labelEle.setAttribute("for", allEle[e]["colName"]);
                            
                        }
                        $("#labeltype").val(allEle[e]["domType"]);
                        if (allEle[e].hasOwnProperty("chuantou")) {
                            $("#ischuantou").val(allEle[e]["chuantou"]);
                        }else{
                            $("#ischuantou").val("");
                        }
                    }
                }
            }
            $("#labelName").trigger("keyup");
        };
        labelText.onchange = function () {
            if (labelEle.innerHTML.indexOf("*")!=-1) {
                labelEle.innerHTML = "<i class='required' style='color:red;'>*</i>";
            }else{
                labelEle.innerHTML = "";
            }
            labelEle.innerHTML += labelText.value;
            $('#tinymceArea_ifr').contents().find(".eleattr-span").each(function(){
                var json = $.parseJSON($(this).html());
                if ((json.hasOwnProperty("domId") && json.domId == bindField.value)
                        || (json.hasOwnProperty("colName") && json.domId == bindField.value) ){
                    json.title = labelText.value;
                    $(this).text(JSON.stringify(json));
                    return false;
                }
            });

        };

        //var labelAttr=$.parseJSON(EformEditor.nowElement.children('.eleattr-span').html());//标签属性
        if (labelEle.getAttribute('for') != '') {

            for (e in allEle) {
                if ((e != "clone" && ("colName" in allEle[e]) && allEle[e]["colName"] == labelEle.getAttribute('for'))
                    || (e != "clone" && ("domId" in allEle[e]) && allEle[e]["domId"] == labelEle.getAttribute('for'))) {

                    if (allEle[e]["colIsVisible"] == 'Y') {
                        $('input[name=colIsVisibleShow]').eq(1).removeAttr("checked");
                        $('input[name=colIsVisibleShow]').eq(0).attr("checked", 'checked');
                        $('input[name=colIsVisibleShow]').eq(0).trigger("click");
                    }
                    else {
                        $('input[name=colIsVisibleShow]').eq(0).removeAttr("checked");
                        $('input[name=colIsVisibleShow]').eq(1).attr("checked", 'checked');
                        $('input[name=colIsVisibleShow]').eq(1).trigger("click");
                    }
                }
            }

            /* if(labelAttr.colIsVisible=='Y')
                 {
                     $('input[name=colIsVisibleShow]').eq(1).removeAttr("checked");
                     $('input[name=colIsVisibleShow]').eq(0).attr("checked",'checked');
                     $('input[name=colIsVisibleShow]').eq(0).trigger("click");
                 }
                 else
                 {
                     $('input[name=colIsVisibleShow]').eq(0).removeAttr("checked");
                     $('input[name=colIsVisibleShow]').eq(1).attr("checked",'checked');
                     $('input[name=colIsVisibleShow]').eq(1).trigger("click");
                 }*/
        }
        if(attrJson){
            var ajObject = JSON.parse(attrJson);
            if(ajObject.hasOwnProperty("tooltip")&&ajObject.tooltip == "Y"){
                $("#tooltipdiv").show();
            }else{
                $("#tooltipdiv").hide();
            }
        }else{
            $("#tooltipdiv").hide();
        }
        $('input[type=radio][name=tooltip]').change(function() {
            if (this.value == 'Y') {
                $("#tooltipdiv").css("display","block");
            }else if (this.value == 'N') {
                $("#tooltipdiv").css("display","none");
            }
        });

        $("#tooltipcontent").click(function () {
            var _this = this;
            eventEdit(_this, '提示内容');
        });

        function eventEdit(_this, title) {
            layer.open({
                type: 2,
                title: title,
                skin: 'layui-layer-rim',
                area: ['70%', '80%'],
                content: 'avicit/platform6/eform/common/richtexteditor.html',
                btn: ['确认', '取消'],
                success: function (layero, index) {
                    //传入参数，并赋值给iframe的元素
                    var iframeWin = layero.find('iframe')[0].contentWindow;
                    iframeWin.setEditorValue(_this.value);
                },
                yes: function (index,layero) {
                    var frm = layero.find('iframe')[0].contentWindow;
                    $(_this).val(frm.getEditorValue()).trigger("keyup");
                    layer.close(index);
                }
            });
        }
    }

};



