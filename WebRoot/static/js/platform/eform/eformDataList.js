(function ($) {

    $.fn.eformDataList = function (option) {
        var _arguments = arguments;
        var _this = this;
        $.fn.eformDataList.property.jqdom = this;
        if (typeof option == 'string') {
            var flag = true;
            this.each(function () {
                flag = $.fn.eformDataList.methods[option]($(this), _arguments);
                if (flag == false) {
                    return false;
                }
            });
            return flag;
        }
        $.extend($.fn.eformDataList.defaults,option);
        return this.each(function () {
            var _jq = this;
            function createEformDataList() {
                var data = $.extend($.fn.eformDataList.defaults.postData,{rows: $.fn.eformDataList.defaults.rowNum, page: 1});
                if ($.fn.eformDataList.defaults.datatype === "local"){
                    var rowlistdom;
                    if ($.fn.eformDataList.defaults.fixcol) {
                        rowlistdom = $("<div class='eform_datalist' style='overflow: auto;width: 100%'></div>");
                    } else {
                        rowlistdom = $("<ul class='eform_datalist' style='overflow: auto;width: 100%'></ul>");
                    }
                    $(_jq).append(rowlistdom);
                    if ($.fn.eformDataList.defaults.pager) {
                        $(_jq).append($($.fn.eformDataList.defaults.pager));
                        $($.fn.eformDataList.defaults.pager).eformPagination({
                            total: 0,
                            pages: 0,
                            limit: $.fn.eformDataList.defaults.rowNum,
                            clickevent: function (pages, limit) {
                                updateViewInfo(pages, limit, $(_jq))
                            }
                        });
                    }
                }else if($.fn.eformDataList.defaults.datatype === "json") {
                    $.ajax({
                        url: $.fn.eformDataList.defaults.url,
                        data: data,
                        type: 'post',
                        dataType: 'json',
                        complete: function(XHR, TS){
                            if (typeof $.fn.eformDataList.defaults.loadComplete === "function"){
                                $.fn.eformDataList.defaults.loadComplete.call(this,XHR, TS);
                            }
                        },
                        success: function (r) {
                            if (r.error) {
                                layer.alert('加载失败！' + r.error, {
                                        icon: 7,
                                        area: ['400px', ''], //宽高
                                        closeBtn: 0
                                    }
                                );
                                return false;
                            }
                            var oneRowdata = [], rowlistdom;
                            if ($.fn.eformDataList.defaults.fixcol) {
                                rowlistdom = $("<div class='eform_datalist' style='overflow: auto;width: 100%'></div>");
                            } else {
                                rowlistdom = $("<ul class='eform_datalist' style='overflow: auto;width: 100%'></ul>");
                            }
                            for (var i = 0, l = r.rows.length; i < l; i++) {
                                $.fn.eformDataList.rowData[r.rows[i][$.fn.eformDataList.defaults.key]] = r.rows[i];
                                if ($.fn.eformDataList.defaults.fixcol) {
                                    if ((i + 1) % $.fn.eformDataList.defaults.col == 0) {
                                        oneRowdata.push(r.rows[i]);
                                        appendFixedDom(oneRowdata, $.fn.eformDataList.defaults, rowlistdom);
                                        oneRowdata = [];
                                    } else {
                                        oneRowdata.push(r.rows[i]);
                                    }

                                    if (i == l - 1 && oneRowdata.length > 0) {
                                        appendFixedDom(oneRowdata, $.fn.eformDataList.defaults, rowlistdom);
                                    }
                                } else {
                                    appendNoFixedDom(r.rows[i], $.fn.eformDataList.defaults, rowlistdom);
                                }
                            }
                            $(_jq).append(rowlistdom);
                            if ($.fn.eformDataList.defaults.pager) {
                                $(_jq).append($($.fn.eformDataList.defaults.pager));
                                $($.fn.eformDataList.defaults.pager).eformPagination({
                                    total: r.records,
                                    pages: r.total,
                                    limit: $.fn.eformDataList.defaults.rowNum,
                                    clickevent: function (pages, limit) {
                                        updateViewInfo(pages, limit, $(_jq))
                                    }
                                });
                            }
                        }
                    });
                }
            }



            createEformDataList();
        });
    };

    $.fn.eformDataList.property = {};

    $.fn.eformDataList.rowData = {};

    function updateViewInfo(pages, limit,jq){
        jq.eformDataList("reloadDataList",{page:pages,rowNum:limit});
    }

    function appendFixedDom(oneRow, option,jq) {
        var bootstrapcol = 12 / option.col;
        var row = $('<div class="row eform_row"></div>');
        if (!option.rowline) {
            row.addClass("noborder");
        }
        for (var i = 0, l = oneRow.length; i < l; i++) {
            var coldiv = $('<div class="col-xs-' + bootstrapcol + ' eform_div_block" dataid="'+oneRow[i][option.key]+'"></div>');
            coldiv = createColDiv(oneRow[i],coldiv,option);
            row.append(coldiv);
        }
        jq.append(row);
    }


    function appendNoFixedDom(onedom, option,jq) {
        var blockwidth = option.blocksize.width,blockheight = option.blocksize.height;;
        if ("auto" !== blockwidth){
            blockwidth = blockwidth + "px";
        }
        if ("auto" !== blockheight){
            blockheight = blockheight + "px";
        }
        var coldiv = $('<li class="eform_div_block" dataid="'+onedom[option.key]+'" style="height:'+blockheight+';width:'+blockwidth+'"></li>');
        coldiv = createColDiv(onedom,coldiv,option);
        jq.append(coldiv);

    }

    function createColDiv(onedom,coldiv,option){
        var html = option.html || "";
        var toHtml = compile(html);
        var hhh = $.trim(toHtml(onedom));
        var block = $(hhh);
        if (option.multiselect) {
            var check = $('<div style="\n' +
                '    position: absolute;\n' +
                '    float: left;\n' +
                '    width: 20px;\n' +
                '    top: 32%;\n' +
                '"></div>');
            var checkbox = $('<input role="checkbox" type="checkbox" class="datalist_check cbox checkbox">');
            checkbox.on("click",function(e){
                blcokSelect(coldiv,"multi",option,onedom[option.key],onedom);
                e.stopPropagation();
            });
            check.append(checkbox);
            coldiv.append(check);
            block.css('position', 'relative');
            block.css('margin-left', '20px');
        }
        if (option.hasOwnProperty('hoverevent') && typeof option.hoverevent == 'function') {
            coldiv.hover(option.hoverevent);
        }
        coldiv.append(block);
        if (option.hasOwnProperty('blockInit') && typeof option.blockInit == 'function'){
            option.blockInit.call(this,coldiv,onedom);
        }
        coldiv.on("click",function(){
            blcokSelect(coldiv,"single",option,onedom[option.key],onedom);
        });
        return coldiv;
    }

    function blcokSelect(dom,type,option,id,onedom){
        var checkflag = true;
        if (type === "single") {
            $.fn.eformDataList.property.jqdom.find(".block-selected").removeClass("block-selected");
            $.fn.eformDataList.property.jqdom.find(".datalist_check").prop("checked",false);
        }else {

            if (dom.find(".datalist_check").eq(0).is(':checked')) {
                checkflag = true;
            } else {
                checkflag = false;
            }
        }
        if (checkflag) {
            dom.addClass("block-selected");
            dom.find(".datalist_check").prop("checked", true);
            if (option.hasOwnProperty('onSelectBlock') && typeof option.onSelectBlock == 'function') {
                option.onSelectBlock.call(this, id,onedom);
            }
        }else{
            dom.removeClass("block-selected");
            dom.find(".datalist_check").prop("checked", false);
        }
    }

    var compile = function (html) {
        return function (it) {
            var functionstring = "";
            if (typeof html === "function"){
                functionstring = html.toString().match(/\/\*([\s\S]*?)\*\//)[1];
            }else {
                functionstring = html;
            }
            return functionstring.replace(/\$\{\w.+\}/g, function (variable) {
                var value = it;
                variable = variable.replace('${', '').replace('}', '');
                variable.split('.').forEach(function (section) {
                    var module = $.fn.eformDataList.property.jqdom.eformDataList("getColModule",section);
                    if (module!=null && module.hasOwnProperty("transform")){
                        if (module.transform){
                            section = section + "Name";
                            module = $.fn.eformDataList.property.jqdom.eformDataList("getColModule",section);
                        }
                    }

                    if (module!=null && module.hasOwnProperty("formatter")){
                        value = module.formatter(value[section],module,value);
                    }else {
                        value = value[section];
                    }
                });
                return value || '';
            }).replace(/[\r\n]/g,"");
        }
    };


    $.fn.eformDataList.methods = {

        getRowData:function(jq,param){
            var id = param[1];
            return $.fn.eformDataList.rowData[id];
        },

        getColModule:function(jq,param){
            var id = param[1];
            var rs = {};
            $.fn.eformDataList.defaults.colModel.forEach(function(item,index){
                if (item["name"] === id){
                    rs =  item;
                    return false;
                }
            });
            return rs;
        },

        getSelected:function(jq,param){
            var ids = [];
            jq.find(".block-selected").each(function(){
                ids.push($(this).attr("dataid"));
            });
            return ids;
        },
        setHeight:function(jq,param){
            var height = param[1];
            if (typeof $.fn.eformDataList.defaults.pager != "undefined"){
                height = height - 38;
            }
            jq.find(".eform_datalist").css("height",height);
        },
        reloadDataList: function (jq,param) {
            var option = param[1];
            $.extend(true,$.fn.eformDataList.defaults,option);
            if ($.fn.eformDataList.defaults.hasOwnProperty("page")) {
                delete $.fn.eformDataList.defaults.page
            }
            if ($.fn.eformDataList.defaults.postData.hasOwnProperty("page")) {
                delete $.fn.eformDataList.defaults.postData.page
            }
            var data = $.extend($.fn.eformDataList.defaults.postData,{rows: $.fn.eformDataList.defaults.rowNum, page: option.page});
            if ($.fn.eformDataList.defaults.datatype === "local"){

            }else if($.fn.eformDataList.defaults.datatype === "json") {
                $.ajax({
                    url: $.fn.eformDataList.defaults.url,
                    data: data,
                    type: 'post',
                    dataType: 'json',
                    complete: function(XHR, TS){
                        if (typeof $.fn.eformDataList.defaults.loadComplete === "function"){
                            $.fn.eformDataList.defaults.loadComplete.call(this,XHR, TS);
                        }
                    },
                    success: function (r) {
                        if (r.error) {
                            layer.alert('加载失败！' + r.error, {
                                    icon: 7,
                                    area: ['400px', ''], //宽高
                                    closeBtn: 0
                                }
                            );
                            return false;
                        }
                        var oneRowdata = [];
                        var rowlistdom = jq.find(".eform_datalist");
                        rowlistdom.html("");
                        for (var i = 0, l = r.rows.length; i < l; i++) {
                            $.fn.eformDataList.rowData[r.rows[i][$.fn.eformDataList.defaults.key]] = r.rows[i];
                            if ($.fn.eformDataList.defaults.fixcol) {
                                if ((i + 1) % $.fn.eformDataList.defaults.col == 0) {
                                    oneRowdata.push(r.rows[i]);
                                    appendFixedDom(oneRowdata, $.fn.eformDataList.defaults, rowlistdom);
                                    oneRowdata = [];
                                } else {
                                    oneRowdata.push(r.rows[i]);
                                }

                                if (i == l - 1 && oneRowdata.length > 0) {
                                    appendFixedDom(oneRowdata, $.fn.eformDataList.defaults, rowlistdom);
                                }
                            } else {
                                appendNoFixedDom(r.rows[i], $.fn.eformDataList.defaults, rowlistdom);
                            }
                        }

                        if (!option.page && $.fn.eformDataList.defaults.pager) {
                            $($.fn.eformDataList.defaults.pager).eformPagination({
                                total: r.records,
                                pages: r.total,
                                limit: $.fn.eformDataList.defaults.rowNum
                            });
                        }
                    }
                });
            }
        }
    };

    /**
     * 默认参数
     * @type {{}}
     */
    $.fn.eformDataList.defaults = {postData:{},blocksize:{height:"auto",width:"auto"}};

})(jQuery);