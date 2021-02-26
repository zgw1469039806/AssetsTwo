(function($){

    $.fn.datagridex = function(method){
        var _arguments = arguments;
        var _this = this;
        if (typeof method == 'string') {
            var flag = true;
            this.each(function () {
                if ($.fn.datagridex.methods[method]($(this), _arguments)==false){
                    flag = false;
                    return false;
                }
            });
            return flag;
        }
    };

    $.fn.datagridex.methods = {
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
                console.error("datagrid添加校验方法错误，如果校验包含自定参数，只能逐条添加！");
                return;
            }
            var validateCols = target.data('validateCol');
            var col = {};
            for (var i=ruleArray.length;i>0;i--){
                var ruleobj = {};
                var ruleName = ruleArray[i-1];
                ruleobj[ruleName]= {func:$.fn.datagridex.rules[ruleName],param:ruleparaArray};
                col[colname] = ruleobj;
                if ($.fn.datagridex.validtorinit.hasOwnProperty(ruleName)){
                    $.fn.datagridex.validtorinit[ruleName](target,colname,"add");
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
                    if ($.fn.datagridex.validtorinit.hasOwnProperty(ruleArray[i])){
                        $.fn.datagridex.validtorinit[ruleArray[i]](target,colname,"delete");
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
            var datas = target.datagrid('getRows');
            var validateCols = target.data('validateCol');
            for (var i=0;i<datas.length;i++){
                var data = datas[i];
                for (var col in validateCols) {
                    var name = target.datagrid("getColumnOption",col).title;
                    var value = "";
                    if (data.hasOwnProperty(col)){
                        value = data[col];
                    }
                    for (var valid in validateCols[col]){
                        if (typeof validateCols[col][valid].func == 'function'){
                            var validvalue = validateCols[col][valid].func(name,value,validateCols[col][valid].param);
                            if (!validvalue[0]){
                                layer.msg(validvalue[1]);
                                return false;
                            }
                        }
                    }
                }
            }

        },

        /**
         * 控制列只读
         * @param target
         * @param param
         */
        readonly:function(target,param){
            var colname = param[1],flag = param[2];
            if (flag == null || flag == undefined){
                flag = true;
            }
            var readonlycols = target.data('readonlycols');
            var col = {};
            if (readonlycols) {
                if (readonlycols[colname]){
                    $.extend(readonlycols[colname], flag);
                }else{
                    readonlycols[colname] = flag;
                }

            }else{
                col[colname]  = flag;
                target.data('readonlycols',col);
            }
        }

    };

    /**
     * 定义的校验方法，用户可以通过 $.extend($.fn.datagridex.rules, {})来进行扩展
     * 检验方法最后返回数组[校验结果,提示信息]
     */
    $.fn.datagridex.rules = {
        required: function(name,value,param){
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
        }
    };

    $.fn.datagridex.validtorinit = {
        required: function(target,colname,type){
            var $panel = target.datagrid("getPanel");
            var $field = $('td[field='+colname+']',$panel);
            if (type == "add"){

                if($field.length){
                    var $span = $("span",$field).eq(0);
                    var html = $span.html().replace('<font color="red">*</font>',"");
                    $span.html('<font color="red">*</font>'+html);
                }
            }else if(type == "delete"){
                if($field.length){
                    var $span = $("span",$field).eq(0);
                    $span.html($span.html().replace('<font color="red">*</font>',""));
                }
            }
        }
    };

    function CHBlank(value) {
        value = value || "";
        return value.replace("/(\s|\ \;|　|\xc2\xa0)/","");
    }
    function isArray(obj) {
        return typeof obj == 'object' && obj.constructor == Array;
    }
    function getLength(str) {
        return str.replace(/[\u0391-\uFFE5]/g,"aa").length;  //先把中文替换成两个字节的英文，再计算长度
    }
})(jQuery);