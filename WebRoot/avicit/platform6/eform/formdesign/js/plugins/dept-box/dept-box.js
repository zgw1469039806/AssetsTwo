var MyElement = {
    elecode: "dept-box",
    colType:"CLOB",
    allowType:"VARCHAR2",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "选部门";
    	dragelement.icon = "fa fa-sitemap";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="部门选择框">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },
    validateForm:function(eleattr){
        if (eleattr) {
            if (eleattr.hasOwnProperty("chuantou") && eleattr.chuantou == "Y") {
                var regExp = /[\S+]/i;
                if ((!eleattr.chuantouurl) || (eleattr.chuantouurl != null && !regExp.test(eleattr.chuantouurl))) {
                    layer.msg('控件[' + eleattr.colName + ']的穿透页面URL属性不能为空', {icon: 7});
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
            if (eleattr.hasOwnProperty("domId")) {
                var reg2 = /(^_([a-zA-Z0-9]_?)*$)|(^[a-zA-Z](_?[a-zA-Z0-9])*_?$)/;
                if ((eleattr.domId!="" && eleattr.domId != null && !reg2.test(eleattr.domId))) {
                    layer.msg('控件[' + eleattr.colName + ']的"页面元素ID"属性格式不正确', {icon: 7});
                    return false;
                }
            }
            if (eleattr.hasOwnProperty("deptlevel")&&eleattr.deptlevel!="") {
                var re = /^[0-9]+$/ ;
                if (!re.test(eleattr.deptlevel)) {
                    layer.msg('控件[' + eleattr.colName + ']的"部门层级"属性需要是整数', {icon: 7});
                    return false;
                }
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
            if(ajObject.hasOwnProperty("defaultDept")&&ajObject.defaultDept == "Y"){
                $("#defaultDeptTypeDiv").show();
            }else{
                $("#defaultDeptTypeDiv").hide();
            }
        }else{
            $("#chuantouurldiv").hide();
            $("#redundanceColNameDiv").hide();
            $("#defaultDeptTypeDiv").hide();
        }
        $("#chuantou").change(function() {
            if($("#chuantou").is(':checked')){
                $("#chuantouurldiv").show();
            }else{
                $("#chuantouurldiv").hide();
            }
        });


        var allEle = editorUtil.getTableDbDomAttr();
        var defaultOrgId = form[0].defaultOrgId;//右侧菜单栏绑定字段dom
        var defaultDeptId = form[0].defaultDeptId;
        //var labelText = form[0].labelName;//右侧菜单栏标签名称
        var i = 1;
        var op = new Option("请选择","");
        defaultOrgId.options[0] = op;
        var op1 = new Option("请选择","");
        defaultDeptId.options[0] = op1;
        for (ele in allEle) {
            if (ele != "clone" && ("domId" in allEle[ele] || "colName" in allEle[ele])) {
                if (allEle[ele]["domId"] != undefined && allEle[ele]["domId"] != "") {
                    var op = new Option(allEle[ele]["domId"], allEle[ele]["domId"]);
                    defaultOrgId.options[i] = op;
                    var op1 = new Option(allEle[ele]["domId"], allEle[ele]["domId"]);
                    defaultDeptId.options[i] = op1;
                } else if (allEle[ele]["colName"] != undefined && allEle[ele]["colName"] != "") {
                    var op = new Option(allEle[ele]["colName"], allEle[ele]["colName"]);
                    defaultOrgId.options[i] = op;
                    var op1 = new Option(allEle[ele]["colName"], allEle[ele]["colName"]);
                    defaultDeptId.options[i] = op1;
                }
                i = i + 1;
            }
        }

        $("#propertyBtn").click(function () {

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
    }
};