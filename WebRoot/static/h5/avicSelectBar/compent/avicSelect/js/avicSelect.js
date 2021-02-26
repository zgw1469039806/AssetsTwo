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
            remote: true,
            shade:0.1,
            shadeClose: true,
            data: '', // 数据渲染的data
            format: 'VALUE', // data对象的数据的回填格式
            showkey: 'name', // 如果用数据渲染时，选择展示的字段
            listen: '.av-child', // 目标子选项
            content: that.find('.avicselect-list'), // 内容区
            listStyle:'',//下拉列表的样式
            findDom: that, // 搜索回填区域的对象
            dataBind: '', // 过滤不回填的数据 string/arr
            delimit: ',', // 多选中时的分隔符
            multi: false, //多选
            afterSelect: '',
            beferOpenPream:'',
            code:'',
	        url:"console/sysdefinedselect/operation/getInitCustomInfo/",       // 数据加载路径	
	        tpl: '<ul>' +
            '<@for ( var index=0;index<this.length;index++ ) {@>' +
            '<li class="av-child" data-val=\'<@ JSON.stringify(this[index])@>\'><@ this[index].VALUE@></li>' +    //本行的VALUE要和数据库字段对应(注意大小写) 它是打开下拉框的展示数据
            '<@}@>' +
            '</ul>'
        };
        var thislayer = null;
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
        	// data.__proto__ = {};

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
        };

        // 事件绑定
        function inputEvent() {
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
            $(".avicselect-list").find(setting.listen).on('mousedown', function() {
                $(this).toggleClass('on');
                
                if (!setting.multi) {
                    $(this).siblings().removeClass('on');
                }
                backfield(getVal());
                if (!setting.multi) {
                	if(thislayer != null){
                		layer.close(thislayer);
                	}
                }
            });
        };

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
            if(setting.afterSelect != null && typeof(setting.afterSelect) === 'function'){
            	setting.afterSelect(data);
                setting.ipt.blur();
            }
        };

        //取值
        function getVal() {
            var arr = [];
            // checkbox和radio的逻辑
            if ($(".avicselect-list").find(setting.listen).is('input')) {
            	$(".avicselect-list").find(setting.listen).each(function() {
                    if (!$(this).is(":checked")) return;
                    var val = $(this).val() || $(this).data('val') || $(this).text();
                    arr.push(val);
                });
            } else {
            	$(".avicselect-list").find(setting.listen + '.on').each(function() {
                    var val = $(this).val() || $(this).data('val') || $(this).text();
                    arr.push(val);
                });
            }
            return arr;
        };

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
                html.append('<li class="av-child ' + listClass + '" style="'+(setting.listStyle||'')+'" data-val=\'' + JSON.stringify(v) + '\'>' + v[setting.showkey] + '</li>');
            });
            return html;
        };
        

        var tital = 0;
        var pagesize = 5;
        var pagecount = 1;
        var sumpage = 1;
        var isopen = false;
        function pagecut(n){
        	if(n == -1){
        		if(pagecount > 1){
        			pagecount--;
        			load();
        		}
        	}else{
        		if(pagecount < sumpage){
        			pagecount++;
        			load();
        		}
        	}

        };

        function toThousands(num) {
            var str = (num || 0).toString().replace(/(\d)(?=(?:\d{4})+$)/g, '$1,');

            var arr = str.split(',');
            if(arr.length == 4){
                str = arr[0]+'兆';
            }else if(arr.length == 3){
                str = arr[0]+'亿';
            }else if(arr.length == 2){
                str = arr[0]+'万';
            }else if(arr.length == 1){
                str = arr[0];
            }

            return str;
        }

        function load() {
        	var pagePreams = {
        			 rows : pagesize,
    				 page: pagecount,
    				 inputText: setting.ipt.val()
        	};
        	if(setting.beferOpenPream != null && typeof(setting.beferOpenPream) === 'function'){
        		var pream = setting.beferOpenPream();
        		pagePreams = $.extend(pagePreams, pream);
        	}

        	$.ajax({
				 url: setting.url + setting.code,
				 data : pagePreams,
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success"){
						 $(".avselectul").empty();
						 total = r.records;
						 sumpage=r.total;
						 setting.data = $.parseJSON(r.rows);
					     if (setting.data) {
					    	 $(".avselectul").append(formateData(setting.data));
					     }

                         var showtotal = toThousands(parseInt(total));

					     $("#avicit_page_tital").html(showtotal).attr('title','每页'+pagesize+'条数据,共'+total+'条数据');
					     // $("#avicit_page_pagesize").html(pagesize);
					     $("#avicit_page_sumpage").html(sumpage);
					     $("#avicit_page_pagecount").html(pagecount);
					     inputEvent();
					 }else{
						    var errorMsg='保存失败！'+r.error;
						 if(r.error==null||r.error=="null")
                          {
							 errorMsg="编码不存在";
                          }
						 layer.alert(errorMsg, {
							  icon: 7,
							  area: ['600px', ''], //宽高
							  closeBtn: 0
							}
						);

					 } 
				 }
			 });
           
        }

        function openselect()
        {
        	if(thislayer != null){
        		layer.close(thislayer);
        	}
        	setting.content.empty();
            var content = "<div class='avselectul'></div><div style='position: relative;overflow:hidden;'>" +
    		"<div style='padding:10px;font-size:12px;float:left;"+(setting.listStyle||'')+"'><span>共<span id='avicit_page_tital'></span>条数据，</span>" +
    		"第<span id='avicit_page_pagecount'></span>/<span id='avicit_page_sumpage'></span>页</span></div>" +
    		"<div style='float:right;padding:10px;font-size:16px;position: absolute;right: 0;'>" +
    		"<i class='glyphicon glyphicon-chevron-left avicselect-page'></i>" +
    		"<i class='glyphicon glyphicon-chevron-right avicselect-page'></i></div></div>";
		    setting.content.append(content);
			$(".glyphicon-chevron-left").on('mousedown', function(e){
		    	selectIndex = -1; 
		    	pagecut(-1);
		    	e.preventDefault();
                //ie8 e.preventDefault()方法不能阻止mousedown事件默认行为，导致input失去焦点关闭弹层，使用以下方式处理
                if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
                    that.find(setting.ipt).focus();
                }
		    });
		    $(".glyphicon-chevron-right").on('mousedown', function(e){
		    	selectIndex = -1; 
		    	pagecut(1);
		    	e.preventDefault();
		    	//ie8 e.preventDefault()方法不能阻止mousedown事件默认行为，导致input失去焦点关闭弹层，使用以下方式处理
                if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
                    that.find(setting.ipt).focus();
                }
		    });
		    var layerWidth= (that.innerWidth() > 250)?that.innerWidth():250;
        	thislayer = layer.open({
                type: setting.type,
                area: [layerWidth + 'px', setting.height],
                skin: 'avicselectui',
                title: false,
                offset: [that.innerHeight(), +.001],
                closeBtn: false,
    			shade:setting.shade,
    			shadeClose:setting.shadeClose,
                content: setting.content,
                btn: (setting.multi) ? ['确定'] : false,
                yes: function(index, layero) {
                    // 多选的确认关闭按钮
                    backfield(getVal(layero, index));
                    layer.close(index);
                },
                success:function(layero){  
                    var mask = $(".layui-layer-shade");  
                    mask.appendTo(layero.parent());  
                    //其中：layero是弹层的DOM对象  
               }  
            });
        };
        
       var selectIndex = -1;
       if(setting.remote){
           that.find(setting.ipt).on('focus', function(e){openselect();load();});
           that.find(setting.ipt).on('blur', function(e){
        	   if(thislayer != null){
              		layer.close(thislayer);
              		thislayer = null;
              		return;
        	   }
           });
           that.find(setting.ipt).on('keyup', function(e){
        	   if(e && e.keyCode==38 ){
        		  if(selectIndex != 0.){
        			  selectIndex = selectIndex -1;
        		  }
        	   }else if(e && e.keyCode==40){
        		   if(selectIndex != $(".av-child").length-1){
        			   selectIndex = selectIndex +1;
        		   }
        	   }

     		   $(".av-child").removeClass("avicselect-item-select");
     		   var item = $(".av-child").slice(selectIndex,selectIndex+1);
     		   item.addClass("avicselect-item-select");
        	   
    		   if(e && e.keyCode==13){
    			   item.toggleClass('on');
                   if (!setting.multi) {
                	   item.siblings().removeClass('on');
                   }
                   backfield(getVal());
                   if (!setting.multi) {
                   	if(thislayer != null){
                   		layer.close(thislayer);
                   		thislayer = null;
                   		return;
                   	}
                   } 
    		   }
    		   
    		   if(e.keyCode!=38 && e.keyCode!=40){
    			   if(thislayer == null){
    				   openselect();
    			   }
        		   load();
        	       selectIndex = -1; 
        	   }
           });
           that.find(setting.action).on('click', function(){openselect();load();});
       }else{
    	   
    	   var showContent = setting.content;

           if (setting.data) {
               setting.content.append(formateData(setting.data));
           }

		    var layerWidth=that.innerWidth();
           that.find(setting.action).on('click', function() {
               layer.open({
                   type: setting.type,
                   area: [layerWidth + 'px', setting.height],
                   skin: 'avicselectui',
                   title: false,
                   offset: [that.innerHeight(), +.001],
                   closeBtn: false,
                   shade: [0.001, '#fff'],
                   shadeClose:setting.shadeClose,
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
       }
        

    };
})(jQuery);
