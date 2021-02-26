(function($) {
    $.fn.avicselect = function(opt) {
        var that = this,
            options = {
                type: 1, // 默认1为页面层 2位iframe层
                shift: 3, // 下拉框动画 参数通layer的shift
                listType: 1, // 子项的布局，1为竖向List，2位横向自适应块,只在data渲染时有效
                ipt: that.find(".form-control"), // 回填框对象
                action: '.avicselect-act', // 按钮框对象
                height: 'auto', // 列表默认高
                multipt: true, // 默认数据回填有多字段时分别回填对应input
                data: '', // 数据渲染的data
                format: '', // data对象的数据的回填格式
                showkey: 'name', // 如果用数据渲染时，选择展示的字段
                listen: '.av-child', // 目标子选项
                content: that.find('.avicselect-list'), // 内容区
                tpl: '', // 模板
                findDom: that, // 搜索回填区域的对象
                dataBind: '', // 过滤不回填的数据 string/arr
                delimit: ',', // 多选中时的分隔符
                multi: false, //多选
                success: '' // 自定义方法
            };
        var setting = $.extend(options, opt);

        /**
         * 模板解析
         * @param  {[string]} tpl
         * @param  {[object]} data
         * @return {[string]}
         */
        function tmpl(html, options) {
        	var data = [];
        		$.each(options,function(i,v){
        			data[i] = v;
        		});
        	data.__proto__ = {};

            var re = /<@([^@>]+)?@>/g,
                reExp = /(^( )?(if|for|else|switch|case|break|{|}))(.*)?/g,
                code = 'var r=[];\n',
                cursor = 0;
            var add = function(line, js) {
                js ? (code += line.match(reExp) ? line + '\n' : 'r.push(' + line + ');\n') :
                    (code += line != '' ? 'r.push("' + line.replace(/"/g, '\\"') + '");\n' : '');
                return add;
            }
            while (match = re.exec(html)) {
                add(html.slice(cursor, match.index))(match[1], true);
                cursor = match.index + match[0].length;
            }
            add(html.substr(cursor, html.length - cursor));
            code += 'return r.join("");';
            return new Function(code.replace(/[\r\t\n]/g, '')).apply(data);
        }

        // 事件绑定
        function inputEvent(layero, index) {
            // 提供iframe内的回调
            if (setting.type == 2) {
                // 只提供回填和关闭弹窗
                window.avicIframeSelect = function(val) {
                    setting.ipt.val(val);
                    layer.close(index);
                    backfield(val);
                };
                return;
            }
            // 本页表单执行
            layero.find(setting.listen).off().on('click', function() {
                $(this).toggleClass('on');
                if (!setting.multi) {
                    $(this).siblings().removeClass('on');
                }
                backfield(getVal(layero, index));
                if (!setting.multi) {
                    layer.close(index);
                }
            });
        }

        /**
         * 数据回填
         * @param  {[object]} data
         * @param  {[string]} type
         */
        function backfield(data) {
            var obj = {};
            obj['show'] = '',
                obj['data'] = [];
            if (data[0] && typeof data[0] == 'object') {
                var showStr = "",backObj={};
                if(setting.dataBind && setting.dataBind[0] && setting.dataBind[0]['dataKey'] ){
                    var earr = {};
                    $.each(setting.dataBind,function(i,v){
                        earr[v.dataKey] = v.formControlID;
                    });
                    setting.dataBind = earr;
                }
                // 对象型数据回填
                $.each(data, function(i, v) {
                    var eachShow = "",
                        dataObj = "";
                    if (setting.format) {
                        eachShow = setting.format;
                    }
                    $.each(v, function(j, k) {
                        var findName = "";
                        if (setting.format) {
                            eachShow = eachShow.replace(j, k);
                        }
                        // 判断需要回填的字段
                        if (typeof setting.dataBind == "string" && setting.dataBind.indexOf(j) >= 0) {
                            findName = j;
                        } else if (typeof setting.dataBind == "object") {
                            if (setting.dataBind[j]) {
                                findName = setting.dataBind[j];
                            }
                        }else if (!setting.dataBind) {
                            findName = j;
                        }

                        if (findName) {
                        	if(!backObj[findName]){
                        		backObj[findName] = k;
                        	}else{
                        		backObj[findName] += setting.delimit + k;
                        	}
                            if (setting.findDom.find('input[name=' + findName + ']').length) {
                                setting.findDom.find('input[name=' + findName + ']').val(backObj[findName]);
                            } else {
                                setting.findDom.append('<input type="hidden" name="' + findName + '" value="' + backObj[findName] + '"/>');
                            }
                            obj['data'].push({ 'name': findName, 'value': k });
                        }
                    });
                    if (!setting.format) {
                        showStr += v[setting.showkey] + setting.delimit;
                    } else {
                        showStr += eachShow + setting.delimit;
                    }
                });
                showStr = showStr.substr(0, showStr.length - 1);
                obj['show'] = showStr;
                setting.ipt.val(showStr);
            } else {
                // 非对象型数据回填
                var str = "";
                $.each(data, function(i, v) {
                    str += v + setting.delimit;
                });
                str = str.substr(0, str.length - 1);
                obj['show'] = str;
                obj['data'].push(data);
                setting.ipt.val(str);
            }

            if (setting.success && typeof setting.success == 'function') {
                setting.success(obj);
            }
        }

        //取值
        function getVal(layero, index) {
            var arr = [];
            // checkbox和radio的逻辑
            if (layero.find(setting.listen).is('input')) {
                layero.find(setting.listen).each(function() {
                    if (!$(this).is(":checked")) return;
                    var val = $(this).val() || $(this).data('val') || $(this).text();
                    arr.push(val);
                });
            } else {
                layero.find(setting.listen + '.on').each(function() {
                    var val = $(this).val() || $(this).data('val') || $(this).text();
                    arr.push(val);
                });
            }
            return arr;
        }

        // 格式化数据
        function formateData(data) {
            if (setting.tpl) {
                return tmpl(setting.tpl, setting.data);
            }
            var html = $("<ul></ul>"),
                listClass = "";
            if (setting.listType > 1) {
                listClass = "tofu";
            }
            $.each(data, function(i, v) {
                html.append('<li class="av-child ' + listClass + '" data-val=\'' + JSON.stringify(v) + '\'>' + v[setting.showkey] + '</li>');
            });
            return html;
        }

        var showContent = setting.content;

        if (setting.data) {
            setting.content.append(formateData(setting.data));
        }

        that.find(setting.action).on('click', function() {
            layer.open({
                type: setting.type,
                area: [that.innerWidth() + 'px', setting.height],
                skin: 'avicselectui',
                title: false,
                offset: [that.innerHeight(), +.001],
                closeBtn: false,
                shade: [0.001, '#fff'],
                shadeClose: true,
                shift: setting.shift,
                content: showContent,
                success: function(layero, index) {
                    // 单选直接关闭
                    inputEvent(layero, index);
                },
                btn: (setting.multi) ? ['确定'] : false,
                yes: function(index, layero) {
                    // 多选的确认关闭按钮
                    backfield(getVal(layero, index));
                    layer.close(index);
                }
            });
        });

    };
})(jQuery);
