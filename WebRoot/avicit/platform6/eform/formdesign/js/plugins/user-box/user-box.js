var MyElement = {
    elecode: "user-box",
    colType:"CLOB",
    allowType:"VARCHAR2",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "选用户";
    	dragelement.icon = "fa fa-user";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="用户选择框">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },

    validateForm:function(eleattr){
        if (eleattr.allowSecret=='true') {
            if ((!eleattr.formSecret) || (eleattr.formSecret == "请选择")) {
                layer.msg('选用户控件关联的密级字段不能为空', {icon: 7});
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
        if(eleattr.hasOwnProperty("chuantou")&&eleattr.chuantou=="Y") {
            var regExp = /[\S+]/i;
            if((!eleattr.chuantouurl)||(eleattr.chuantouurl!=null && !regExp.test(eleattr.chuantouurl)))
            {
                layer.msg('控件['+eleattr.colName+']的穿透页面URL属性不能为空', {icon: 7});
                return false;
            }
        }
        return true;
    },

    //属性页面初始化方法  可选方法
    initAttrForm:function(form,attrJson){

        var allEle = editorUtil.getTableDbDomAttr();
        var defaultOrgId = form[0].defaultOrgId;//右侧菜单栏绑定字段dom
        var defaultDeptId = form[0].defaultDeptId;//右侧菜单栏绑定字段dom
        var callbackdept = form[0].callbackdept;
        //var labelText = form[0].labelName;//右侧菜单栏标签名称
        var i = 1;
        var callbackdeptcount = 1;
        var defaultDeptcount = 1;
        var op = new Option("请选择","");
        defaultOrgId.options[0] = op;
        var op2 = new Option("请选择","");
        callbackdept.options[0] = op2;
        var op3 = new Option("请选择","");
        defaultDeptId.options[0] = op3;
        for (ele in allEle) {
            if (ele != "clone" && ("domId" in allEle[ele] || "colName" in allEle[ele])) {
                if (allEle[ele]["domId"] != undefined && allEle[ele]["domId"] != "") {
                    var op = new Option(allEle[ele]["domId"], allEle[ele]["domId"]);
                    defaultOrgId.options[i] = op;
                    if (allEle[ele]["domType"] == "dept-box"){
                        var op2 = new Option(allEle[ele]["domId"], allEle[ele]["domId"]);
                        callbackdept.options[callbackdeptcount] = op2;
                        callbackdeptcount++;
                        var op3 = new Option(allEle[ele]["domId"], allEle[ele]["domId"]);
                        defaultDeptId.options[defaultDeptcount] = op3;
                        defaultDeptcount++;
                    }

                } else if (allEle[ele]["colName"] != undefined && allEle[ele]["colName"] != "") {
                    var op = new Option(allEle[ele]["colName"], allEle[ele]["colName"]);
                    defaultOrgId.options[i] = op;
                    if (allEle[ele]["domType"] == "dept-box"){
                        var op2 = new Option(allEle[ele]["colName"], allEle[ele]["colName"]);
                        callbackdept.options[callbackdeptcount] = op2;
                        callbackdeptcount++;
                        var op3 = new Option(allEle[ele]["colName"], allEle[ele]["colName"]);
                        defaultDeptId.options[defaultDeptcount] = op3;
                        defaultDeptcount++;
                    }
                }
                i = i + 1;
            }
        }

        $("#rolepropertyBtn").click(function () {

            selectDialog = top.layer.open({
                type: 2,
                title: '角色范围',
                skin: 'bs-modal',
                area: ['1100px', '570px'],
                maxmin: false,
                content: "avicit/platform6/eform/formdesign/js/plugins/attr-jsp/commonselect-default.jsp?selecttype=roleSelect",
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
                    $("#rolelist").val(JSON.stringify(rs)).trigger("keyup");

                    top.layer.close(index);

                },
                no: function(index, layero){
                    layero.close(index);
                },
                success:function(layero, index){
                    var frm = layero.find('iframe')[0].contentWindow;
                    frm.selecttype = "roleSelect";
                    var btn1= $(".layui-layer-btn .layui-layer-btn0");
                	btn1.addClass("form-tool-btn");
                	btn1.addClass("typeb");
                }
            });
        });

        $("#deptpropertyBtn").click(function () {

            selectDialog = top.layer.open({
                type: 2,
                title: '部门范围',
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
                    $("#deptlist").val(JSON.stringify(rs)).trigger("keyup");

                    top.layer.close(index);

                },
                no: function(index, layero){
                    layero.close(index);
                },
                success:function(layero, index){
                    var frm = layero.find('iframe')[0].contentWindow;
                    frm.selecttype = "deptSelect";
                    var btn1= $(".layui-layer-btn .layui-layer-btn0");
                	btn1.addClass("form-tool-btn");
                	btn1.addClass("typeb");
                }
            });
        });

        $("#grouppropertyBtn").click(function () {

            selectDialog = top.layer.open({
                type: 2,
                title: '群组范围',
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
                    $("#grouplist").val(JSON.stringify(rs)).trigger("keyup");

                    top.layer.close(index);

                },
                no: function(index, layero){
                    layero.close(index);
                },
                success:function(layero, index){
                    var frm = layero.find('iframe')[0].contentWindow;
                    frm.selecttype = "groupSelect";
                    var btn1= $(".layui-layer-btn .layui-layer-btn0");
                	btn1.addClass("form-tool-btn");
                	btn1.addClass("typeb");
                }
            });
        });

        $("#positionpropertyBtn").click(function () {

            selectDialog = top.layer.open({
                type: 2,
                title: '岗位范围',
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
                    $("#positionlist").val(JSON.stringify(rs)).trigger("keyup");

                    top.layer.close(index);

                },
                no: function(index, layero){
                    layero.close(index);
                },
                success:function(layero, index){
                    var frm = layero.find('iframe')[0].contentWindow;
                    frm.selecttype = "positionSelect";
                    var btn1= $(".layui-layer-btn .layui-layer-btn0");
                	btn1.addClass("form-tool-btn");
                	btn1.addClass("typeb");
                }
            });
        });


        if(attrJson != undefined) {
            var attr = $.parseJSON(attrJson);
            var selectDomain = attr.selectDomain;
            var options = [{name   : '部门',value  : 'dept',checked: true},
                           {name   : '群组',value  : 'group',checked: true},
                           {name   : '角色',value  : 'role',checked: true},
                           {name   : '岗位',value  : 'position',checked: true}];
	        if(selectDomain){
	        	for(var i=0;i<options.length;i++){
		        	var option = options[i];
		        	if(selectDomain.indexOf(option.value)>-1){
		        		option.checked = true;
		        	}else{
		        		option.checked = false;
		        	}
		        }
	        }else{
	        	for(var i=0;i<options.length;i++){
	        		var option = options[i];
	        		option.checked = true;
		        }
	        }
            $('select[multiple]').multiselect( 'loadOptions', options);
        }
        var fileEle = EformEditor.nowElement[0].firstChild;//面板标签dom
        //var labelAttr=$.parseJSON(EformEditor.nowElement.children('.eleattr-span').html());//标签属性
        var allEle = editorUtil.getAllDomAttr();
        var formSecret = form[0].formSecret;//右侧菜单栏绑定字段dom
        //var labelText = form[0].labelName;//右侧菜单栏标签名称
        var i = 1;
        var op = new Option("请选择","");
        formSecret.options[0] = op;
        for (ele in allEle) {
            if (ele != "clone" && ("domId" in allEle[ele] || "colName" in allEle[ele])) {
                if (allEle[ele]["domId"] != undefined && allEle[ele]["domId"] != "") {
                    var op = new Option(allEle[ele]["domId"], allEle[ele]["domId"]);
                    formSecret.options[i] = op;
                } else if (allEle[ele]["colName"] != undefined && allEle[ele]["colName"] != "") {
                    var op = new Option(allEle[ele]["colName"], allEle[ele]["colName"]);
                    formSecret.options[i] = op;
                }
                i = i + 1;
            }
        }
        formSecret.onclick = function () {
            if (formSecret.value != "请选择") {
                for (e in allEle) {
                    if ((e != "clone" && ("colName" in allEle[e]) && allEle[e]["colName"] == formSecret.value)
                        || e != "clone" && ("domId" in allEle[e]) && allEle[e]["domId"] == formSecret.value) {

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
                            fileEle.setAttribute("for", allEle[e]["domId"]);
                        }
                        else {
                            fileEle.setAttribute("for", allEle[e]["colName"]);
                        }
                    }
                }
            }
        };

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

    }
};