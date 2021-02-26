(function($){

    $.fn.validateJqGrid = function(method){
        var _arguments = arguments;
        var _this = this;
        if (typeof method == 'string') {
            var flag = true;
            this.each(function () {
                if ($.fn.validateJqGrid.methods[method]($(this), _arguments)==false){
                    flag = false;
                    return false;
                }
            });
            return flag;
        }
    };

    $.fn.validateJqGrid.methods = {
        /**
         * 添加校验方法
         * @param target
         * @param param 传参为colname,rules，其中rule可以为以逗号隔开的校验名称，或者数组
         */
        addValidate:function(target,param){
            var colname = param[1],rules = param[2],rulepara=param[3]||"";
            if (rules == null || rules == "" || rules == "undefined"){
                return;
            }
            var ruleparaArray = null;
            if (typeof rulepara == 'string') {
                ruleparaArray = rulepara.split(",");
            }else if (typeof rulepara == 'object'){
                ruleparaArray = rulepara;
            }else{
                ruleparaArray = [];
            }
            var ruleArray = [];
            if (typeof rules=='string'){
                ruleArray = rules.split(",");
            }else if (isArray(rules)){
                ruleArray = rules;
            }else{
                return;
            }
            if (ruleparaArray!="" && ruleArray.length>1){
                console.error("jqgrid添加校验方法错误，如果校验包含自定参数，只能逐条添加！");
                return;
            }
            var validateCols = target.data('validateCol');
            var col = {};
            for (var i=ruleArray.length;i>0;i--){
                var ruleobj = {};
                var ruleName = ruleArray[i-1];
                ruleobj[ruleName]= {func:$.fn.validateJqGrid.rules[ruleName],param:ruleparaArray};
                col[colname] = ruleobj;
                if ($.fn.validateJqGrid.validtorinit.hasOwnProperty(ruleName)){
                    $.fn.validateJqGrid.validtorinit[ruleName](target,colname,"add");
                }
            }

            if (validateCols) {
                if (validateCols[colname]){
                    $.extend(validateCols[colname], col[colname]);
                }else{
                    validateCols[colname] = col[colname];
                }

            }else{
                target.data('validateCol',col);
            }
        },

        /**
         * 清除校验
         * @param target
         * @param param 传参为colname,rules，其中rule可以为以逗号隔开的校验名称，或者数组
         */
        deleteValidate:function(target,param){
            var colname = param[1],rules = param[2];
            if (rules == null || rules == "" || rules == "undefined"){
                return;
            }
            var ruleArray = [];
            if (typeof rules=='string'){
                ruleArray = rules.split(",");
            }else if (isArray(rules)){
                ruleArray = rules;
            }else{
                return;
            }
            var validateCols = target.data('validateCol');
            if (validateCols && validateCols.hasOwnProperty(colname)){
                for (var i=0;i<ruleArray.length;i++){
                    delete validateCols[colname][ruleArray[i]];
                    if ($.fn.validateJqGrid.validtorinit.hasOwnProperty(ruleArray[i])){
                        $.fn.validateJqGrid.validtorinit[ruleArray[i]](target,colname,"delete");
                    }
                }

            }
        },

        /**
         * 验证调用
         * @param target
         * @returns {boolean}
         */
        validate:function(target){
            var required = target.jqGrid('getGridParam').jsonReader.required;
            var required = required==undefined?'':required;
            // var isTableHidden = target.is(":hidden");
            // if(isTableHidden){
            //     return true;
            // }
            var datas = target.jqGrid('getRowData');

            var validateCols = target.data('validateCol');
            var countCols = 0;
            for (var col in validateCols) {
                if (validateCols[col]['required']) {
                    countCols++;
                }
            }
            if (datas.length ==0 && countCols>0 && required=="required"){
                var label = target.parents("table").attr("title");
                if (label!=null && label!=undefined && label!=""){
                    layer.msg("子表【"+label+"】数据必填，请检查！");
                }else{
                    layer.msg("子表数据必填，请检查！");
                }

                return false;
            }
            for (var i=0;i<datas.length;i++){
                var data = datas[i];
                for (var col in validateCols) {
                    if (data.hasOwnProperty(col)){
                        var value = data[col];
                        var name = target.getColProp(col).label;
                        for (var valid in validateCols[col]){
                            if (typeof validateCols[col][valid].func == 'function'){
                                var validvalue = validateCols[col][valid].func(name,value,validateCols[col][valid].param,target);
                                if (!validvalue[0]){
                                    layer.msg(validvalue[1]);
                                    return false;
                                }
                            }
                        }
                    }
                }
            }

        }
    };

    /**
     * 定义的校验方法，用户可以通过 $.extend($.fn.validateJqGrid.rules, {})来进行扩展
     * 检验方法最后返回数组[校验结果,提示信息]
     */
    $.fn.validateJqGrid.rules = {
        required: function(name,value,param,target){
            value = CHBlank(value).trim();
            if (value==null||value==""||value=="undefined"){
                return [false,"["+name+"]不能为空！"];
            }else{
                return [true,''];
            }
        },

        maxlength: function(name,value,param){
            value = value||"";
            var maxlength = param.maxlength;
            var length = getLength(CHBlank(value).trim());
            if (length>maxlength){
                return [false,"["+name+"]中信息过长，最大长度为"+maxlength+"！"];
            }else{
                return [true,''];
            }
        },
        email: function(name,value,param){
            value = value||"";
            if (value !== "") {
                var reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
                if (!reg.test(value)) {
                    return [false, "[" + name + "]中邮箱格式不对，请输入正确邮箱地址"];
                } else {
                    return [true, ""];
                }
            }
            return [true, ""];
        },
        phone: function(name,value,param){
            if (value !== "") {
                value = value || "";
                var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
                if (!reg.test(value)) {
                    return [false, "[" + name + "]中手机号格式不对，请输入正确手机号"];
                } else {
                    return [true, ""];
                }
            }
            return [true, ""];
        },
        zipcode: function(name,value,param){
            if (value !== "") {
                value = value || "";
                reg = /^\d{6}$/;
                if (!reg.test(value)) {
                    return [false, "[" + name + "]中邮编格式不对，请输入正确邮编"];
                } else {
                    return [true, ""];
                }
            }
            return [true, ""];
        },
        idcard: function(name,value,param){
            if (value !== "") {
                value = value || "";
                var len = value.length, re;
                if (len == 15)
                    re = new RegExp(/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{2})(\w)$/);
                else if (len == 18)
                    re = new RegExp(/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/);
                else {
                    return [false, "[" + name + "]中身份证输入的数字位数不对。"];
                }
                var a = value.match(re);
                if (a != null) {
                    if (len == 15) {
                        var D = new Date("19" + a[3] + "/" + a[4] + "/" + a[5]);
                        var B = D.getYear() == a[3] && (D.getMonth() + 1) == a[4]
                            && D.getDate() == a[5];
                    } else {
                        var D = new Date(a[3] + "/" + a[4] + "/" + a[5]);
                        var B = D.getFullYear() == a[3] && (D.getMonth() + 1) == a[4]
                            && D.getDate() == a[5];
                    }
                    if (!B) {
                        return [false, "[" + name + "]中输入的身份证号 " + a[0] + " 里出生日期不对。"];
                    }
                }
                if (!re.test(value)) {
                    return [false, "[" + name + "]中身份证最后一位只能是数字和字母。"];
                }
            }
            return [true, ""];
        }
    };

    $.fn.validateJqGrid.validtorinit = {
        required: function(target,colname,type){
            var col = target.getColProp(colname);
            var colVisible = target.getColProp(colname+"Name");
            if (type == "add"){
                target.setLabel(colname,"<font color='red'>*</font>"+col.label);
                if (colVisible.hasOwnProperty("label")){
                    target.setLabel(colname+"Name","<font color='red'>*</font>"+colVisible.label);
                }

            }else if(type == "delete"){
                if (colVisible.hasOwnProperty("label")){
                    target.setLabel(colname+"Name",colVisible.label.replace("<font color='red'>*</font>",""));
                }
                target.setLabel(colname,col.label.replace("<font color='red'>*</font>",""));

            }
        }
    };

    function CHBlank(value) {
        return value.replace("/(\s|\ \;|　|\xc2\xa0)/","");
    }
    function isArray(obj) {
        return typeof obj == 'object' && obj.constructor == Array;
    }
    function getLength(str) {
        return str.replace(/[\u0391-\uFFE5]/g,"aa").length;  //先把中文替换成两个字节的英文，再计算长度
    }
})(jQuery);