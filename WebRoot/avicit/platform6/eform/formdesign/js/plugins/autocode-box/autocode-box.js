var MyElement = {
    elecode: "autocode-box",
    colType:"VARCHAR2",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "自动编码";
    	dragelement.icon = "fa fa-magic";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="自动编码">';
    },
    update: function (form, ui) {
       // var attrJson = form.serializeObject();
    },

    afterSaveEvent:function(eleattr){
        $.ajax({
            url:"platform/sysautocode/sysAutoCodeManageController/updateForWa",
            data : {"autocode" : eleattr.autoCode,"tablename":eleattr.tableName,"colname":eleattr.colName},
            type : 'post',
            dataType : 'json',
            async : false,
            success : function(result){
                if (result.error){
                    layer.msg("保存表单后处理失败："+result.error, {icon: 7});
                }
            }
        });
    },

    validateForm:function(eleattr){
    	var reflag = true;
        var regExp = /[\S+]/i;
        if((!eleattr.autoCode)||(eleattr.autoCode!=null && !regExp.test(eleattr.autoCode)))
        {
            layer.msg('自动编码控件自动编码属性不能为空', {icon: 7});
            reflag = false;
        }else{
	        $.ajax({
		   		 url:"platform/sysautocode/sysAutoCodeManageController/getSysAutoCodeByCode",
		   		 data : {"code" : eleattr.autoCode},
		   		 type : 'post',
		   		 dataType : 'json',
		   		 async : false,
		   		 success : function(result){
		   			 if (result == true){
		   	            layer.msg('自动编码控件自动编码属性未被定义', {icon: 7});
		   	            reflag = false;
		   			 }
		   		 }
		   	});
        }
        return reflag;
    },
    initAttrForm:function(form,attrJson){
        $('#autoCode').click(function(event){
            layer.open({
                type : 2,
                area : [ '800px', '450px' ],
                title : '请选择自动编码',
                btn: ['确定', '取消'],
                maxmin : false, // 开启最大化最小化按钮
                content : 'avicit/platform6/eform/formdesign/js/plugins/autocode-box/sysAutoCodeSelect.jsp',
                yes: function(index,layero){//
                    var iframeWin = layero.find('iframe')[0].contentWindow;//子页面的窗口对象
                    var rowdatas = iframeWin.getSelectedData();
                    if(rowdatas.length == 1){
                        $("#autoCode").val(rowdatas[0].code);
                    }else if(rowdatas.length > 1){
                        layer.msg('只能选择一条数据！', {icon: 7});
                        return false;
                    }

                    $('input').trigger("keyup");
                    layer.close(index);
                },
                cancel: function(index){
                    layer.close(index);
                },
                success : function(layero, index) {
                    var iframeWin = layero.find('iframe')[0].contentWindow;
                    iframeWin.codetableName = EformEditor.nowTableName;
                    iframeWin.codefieldName = $("#colName").val();
                    iframeWin.initGrid();
                    iframeWin.init({
                        callback : function (data){
                            $("#autoCode").val(data.code);
                            $('input').trigger("keyup");
                            layer.close(index);
                        }
                    });                
                    var btn1= $(".layui-layer-btn .layui-layer-btn0");
                	btn1.addClass("form-tool-btn");
                	btn1.addClass("typeb");
                }
            });
        });
    }
};