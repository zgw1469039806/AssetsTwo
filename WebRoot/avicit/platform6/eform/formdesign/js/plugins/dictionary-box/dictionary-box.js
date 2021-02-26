
var MyElement = {
    elecode: "dictionary-box",
    colType:"VARCHAR2",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "数据字典";
    	dragelement.icon = "fa fa-book";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="数据字典">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },

    validateForm:function(eleattr){
        if((!eleattr.dictionaryPara) ||(eleattr.dictionaryPara == "[]" ))
        {
            layer.msg('数据字典控件数据字典配置不能为空', {icon: 7});
            return false;
        }
        return true;
    },

    initAttrForm: function (form, attrJson) {
    	var _this = this;
        if (attrJson) {
            var json = $.parseJSON(attrJson);
        }

        $("#propertyBtn").click(function () {
            linkagedialog = top.layer.open({
                type: 2,
                title: '数据字典配置维护',
                skin: 'bs-modal',
                area: ['45%', '85%'],
                maxmin: false,
                content: "avicit/platform6/eform/formdesign/js/plugins/dictionary-box/dictionary-property.jsp?isMain=1",
                btn: ['确定', '取消'],
                success: function (layero, index) {
                    //传入参数，并赋值给iframe的元素
                    var iframeWin = layero.find('iframe')[0].contentWindow;
                    var dictionaryPara = $('#dictionaryPara').val();
                    var rowCount = $('#rowCount').val();
                    var queryStatement = $('#queryStatement').val();

                    var jsSuccess = $('#jsSuccess').val();
                    var jsBefore = $('#jsBefore').val();
                    var jsAfter = $('#jsAfter').val();
                    
                    var isMuti = $('#isMuti').val();
                    var waitSelect = $('#waitSelect').val();
                    var inputChk = $('#inputChk').val();
                    var inputDetail = $('#inputDetail').val();
                    var detail = $('#detail').val();
                    var detailpagefileId = $('#detailpagefileId').val();
                    var detailpagePath = $('#detailpagePath').val();
                    var detailpagefileName = $('#detailpagefileName').val();

                    var dataCombox = $('#dataCombox').val();
                    var dataComboxType = $('#dataComboxType').val();
                    var dataComboxText = $('#dataComboxText').val();

                    var btn1= $(".layui-layer-btn .layui-layer-btn0");
                    btn1.addClass("form-tool-btn");
                    btn1.addClass("typeb");

                    iframeWin.initForm(rowCount,queryStatement,dictionaryPara,jsSuccess,
                    		jsBefore,jsAfter,dataCombox,dataComboxType,dataComboxText,isMuti,waitSelect,
                    		inputChk,inputDetail,detail,detailpagefileId,detailpagePath,detailpagefileName,"1");
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
                    $("#inputChk").val(reData.inputChk);
                    $("#inputDetail").val(reData.inputDetail);
                    $("#detail").val(reData.detail);
                    $("#detailpagefileId").val(reData.detailpagefileId);
                    $("#detailpagePath").val(reData.detailpagePath);
                    $("#detailpagefileName").val(reData.detailpagefileName);
                    
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
    	
    }
};


