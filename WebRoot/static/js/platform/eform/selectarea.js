/**
 *
 */

var  selectarea= function(id,opt){
    //配置项
    opt = opt || {};
    //通用代码选择页面url
    this.lookupUrl = opt.lookup_url||"";
    // onchange事件
    this.onChange = opt.onChange||function(){};
    // init事件
    this.onInit = opt.onInit||function(){};
    //总区域
    this.area = $("#"+id);
    //按钮区域
    this.buttonarea = null;
    //选择框区域
    this.selectbox = null;
    //默认值下拉框区域
    this.defaultArea = null;
    //默认值下拉框内容
    this.defaultselectOption = null;
    //已选option展示区域
    this.selectoptions = null;
    //已选value展示区域
    this.selectvalues = null;
    //已添加选项的排序编号
    this.optionCount = null;
    //手动添加value输出框
    this.inputvalue = null;
    //手动添加option输出框
    this.inputoption = null;
    //回填页面option的input
    this.selectedoptions = null;
    //回填页面value的input
    this.selectedvalues = null;

    this.lookupType = $("#attribute01");

    this.init();
};

selectarea.prototype = {
    init : function(){
        this.drawButtonArea();
        this.drawSelectbox();
        this.drawDefaultSelect();
        this.bindKeyEvent();
        this.lookupType.val("none");
        this.onInit(this);
        this.funPlaceholder($('[placeholder]'));
    },



    drawSelectbox: function(){
        var selectboxid = 'select_box_'+GenNonDuplicateID();
        this.selectbox = $('<div id="'+selectboxid+'"></div>');
        var layoutleft = $('<div class="col-xs-6" style="padding-left:0px;"></div>');
        this.inputoption = $('<input type="text"  class="select-input" placeholder="options..." value="">');
        this.selectedoptions = $('<input type="hidden" name="selectedoption">');
        this.selectoptions = $('<ul class="selectoptions" contenteditable="false"></ul>');
        layoutleft.append(this.inputoption).append(this.selectedoptions).append(this.selectoptions);

        var layoutright = $('<div class="col-xs-6" style="padding-left:0px;"></div>');
        this.inputvalue = $('<input type="text"  class="select-input" placeholder="values..." value="">');
        this.selectedvalues = $('<input type="hidden" name="selectedvalues" id="selectedvalues">');
        this.selectvalues = $('<ul class="selectvalues" contenteditable="false"></ul>');
        layoutright.append(this.inputvalue).append(this.selectedvalues).append(this.selectvalues);

        this.selectbox.append(layoutleft).append(layoutright);

        this.area.append(this.selectbox);
    },

    //绘制按钮区域
    drawButtonArea:function(){
        var _this = this;
        var buttonareaid = 'button_area_'+GenNonDuplicateID();
        this.buttonarea = $('<div id="'+buttonareaid+'"><div class="col-xs-12 button-area-layout" style="font-size:12px;margin-bottom:3px; padding-left: 0px;"></div></div>');
        this.addButton("添加","fa fa-fw fa-lg fa-check",function(){_this.selectInsert()});
        this.addButton("删除","fa fa-fw fa-lg fa-remove",function(){_this.selectDel()});
        if (this.lookupUrl ){
            this.addButton("关联通用代码","fa fa-fw fa-lg fa-share-square-o",function(){_this.selectLookup()});
        }
        this.addButton("上移","fa fa-fw fa-lg fa-arrow-up",function(){_this.selectUp()});
        this.addButton("下移","fa fa-fw fa-lg fa-arrow-down",function(){_this.selectDown()});
        this.area.append(this.buttonarea);
    },

    //绘制默认值区域
    drawDefaultSelect:function(){
        var _this = this;
        var defaultselectid = 'default_area_'+GenNonDuplicateID();
        this.defaultArea = $('<div id="'+defaultselectid+'" style="clear: both;"><label class="control-label">默认选中：</label></div>');
        this.defaultselectOption = $('<select id="defaultValue" name="defaultValue" class="form-control input-sm"></select>');
        this.defaultselectOption.append("<option></option>");
        this.defaultArea.append(this.defaultselectOption);
        this.area.append(this.defaultArea);
    },

    //添加按钮
    addButton: function(title,icon,clickmethod){
        var button = $('<a title="'+title+'"></a>');
        button.append('<i class="'+icon+'"></i>');
        button.click(function(){
            typeof(clickmethod)=="function"&&clickmethod();
        });
        this.buttonarea.find(".button-area-layout").append(button);
    },


    //绑定键盘事件
    bindKeyEvent: function(){
        var _this = this;
        this.inputoption.on('keyup',function(e) {
            if (e.keyCode == 13) {
                _this.selectInsert();
            }
        });

        this.inputvalue.on('keyup',function(e) {
            if (e.keyCode == 13) {
                _this.selectInsert();
            }
        });
    },

    //删除选项
    selectDel:function(){
        var delValue = this.selectvalues.find(".ui-state-highlight")[0].textContent;
        var delText = this.selectoptions.find(".ui-state-highlight")[0].textContent;
        for(var i=0;i<this.defaultselectOption.find("option").length;i++){
            var that = this.defaultselectOption.find("option")[i];
            var value = that.value;
            var text = that.text;
            if(value==delValue&&text==delText){
                that.remove();
                break
            }
        }
        this.selectoptions.find(".ui-state-highlight").remove();
        this.selectvalues.find(".ui-state-highlight").remove();
        this.lookupType.val("none");
        var rs = this.getSelectOptionAndValue();
        this.onChange(rs);
        $('#lookupTypeDiv').remove();
        $('input').trigger("keyup");
    },

    //上移
    selectUp:function(){
        var onthis = this.selectvalues.find(".ui-state-highlight");
        var getup = this.selectvalues.find(".ui-state-highlight").prev();
        $(getup).before(onthis);

        var onthis1 = this.selectoptions.find(".ui-state-highlight");
        var getup1 = this.selectoptions.find(".ui-state-highlight").prev();
        $(getup1).before(onthis1);
        this.lookupType.val("none");
        var rs = this.getSelectOptionAndValue();
        this.onChange(rs);
        $('#lookupTypeDiv').remove();
        $('input').trigger("keyup");
    },

    //下移
    selectDown:function(){
        var onthis = this.selectvalues.find(".ui-state-highlight");
        var getdown = this.selectvalues.find(".ui-state-highlight").next();
        $(getdown).after(onthis);
        var onthis1 = this.selectoptions.find(".ui-state-highlight");
        var getdown1 = this.selectoptions.find(".ui-state-highlight").next();
        $(getdown1).after(onthis1);
        this.lookupType.val("none");
        var rs = this.getSelectOptionAndValue();
        this.onChange(rs);
        $('#lookupTypeDiv').remove();
        $('input').trigger("keyup");
    },

    //插入选项
    selectInsert:function(){
        if (!this.optionCount) {
            this.optionCount = 0;
        }
        if (!this.inputvalue.val()) {
            alert("请先填写选项value值");
            return false;
        }
        if (!this.inputoption.val()) {
            alert("请先填写选项option值");
            return false;
        }
        var li = $('<li class="ui-state-default" contenteditable="true" num="' + this.optionCount+'">'+ this.inputoption.val() + '</li>');
        var li2 =$('<li class="ui-state-default" contenteditable="true" num="' + this.optionCount+'">'+ this.inputvalue.val() + '</li>');
        var opt =$('<option value="' + this.inputvalue.val()+'">'+ this.inputoption.val() + '</option>');
        this.selectoptions.append(li);
        this.selectvalues.append(li2);
        this.defaultselectOption.append(opt);
        this.bindSelectEvent();
        this.lookupType.val("none");
        var rs = this.getSelectOptionAndValue();
        this.onChange(rs);
        this.optionCount++;
        $('#lookupTypeDiv').remove();
        $('input').trigger("keyup");
    },

    //选择通用代码
    selectLookup:function(){
        var _this = this;




        /*			var dialog = new CommonJQueryUIDialog("syslookup","700","600", this.lookupUrl,"选择通用代码", null, true, false, true);
                    var buttons = [{
                        text:'保存',
                        "class" : "btn btn-minier btn-info",
                        click:function(){
                             var frmId = $('#syslookup iframe').attr('id');
                             var frm = document.getElementById(frmId).contentWindow;
                             var jsonData = [];
                             if (typeof(frm.commitData) === 'function'){
                                 jsonData = frm.commitData();
                                 if (jsonData){
                                     if (jsonData.hasOwnProperty("lookupType")){
                                         _this.setSelect(jsonData);
                                     }else{
                                         alert("弹出页返回参数错误！");
                                         return false;
                                     }
                                 }else{
                                     alert("弹出页返回值为null！");
                                     return false;
                                 }
                             }else{
                                 alert("提交方法名称错误！");
                                 return false;
                             }
                             dialog.close();
                        }
                    },
                    {
                        text: "关闭",
                        "class" : "btn btn-minier",
                        click: function() {
                            dialog.close();
                        }

                    }];
                    dialog.createButtonsInDialog(buttons);
                     dialog.show();*/



        new H5CommonLookupTypeSelect({type:'lookupSelect', idFiled:'',textFiled:'', callBack: function(rowdata){
            $.ajax({
                url : 'platform/eform/bpmsClient/getSysLookup.json',
                data: {lookupCode : rowdata.lookupType},
                type : 'post',
                dataType : 'json',
                success : function(r) {
                    r.lookupType = rowdata.lookupType;
                    r.lookupTypeName = rowdata.lookupTypeName;
                    _this.setSelect(r);
                }
            });
        }});
    },


    //selectbox控件绑定事件
    bindSelectEvent:function(){
        var _this = this;
        //绑定option元素的点击事件以及禁用键盘回车事件
        this.selectoptions.find("li").click(function() {
            var num =  $(this).attr("num");
            _this.selectvalues.find("li").removeClass("ui-state-highlight");
            _this.selectoptions.find("li").removeClass("ui-state-highlight");
            $(this).addClass("ui-state-highlight");
            _this.selectvalues.find('li[num="'+num+'"]').addClass("ui-state-highlight");
        }).on('keydown',function(e) {
            if (e.keyCode == 13) {
                return false;
            }
        }).on('keyup',function(e){
            var rs = _this.getSelectOptionAndValue();
            _this.onChange(rs);
            _this.lookupType.val("none");
            $('#lookupTypeDiv').remove();
            $('#defaultValue').val("");
            _this.defaultselectOption.empty();
            _this.defaultselectOption.append('<option value=""></option>');
            for (var i = 0; i < _this.selectvalues.find("li").length; i++) {
                var value = _this.selectvalues.find("li").eq(i).text();
                var num = _this.selectvalues.find("li").eq(i).attr("num");
                var option = _this.selectoptions.find("li[num='" + num + "']").eq(0).text();
                var opt =$('<option value="' + value+'">'+ option + '</option>');
                _this.defaultselectOption.append(opt);
            }
        }).on('paste',function(e){
            // 阻止默认粘贴
            e.preventDefault();
            // 粘贴事件有一个clipboardData的属性，提供了对剪贴板的访问
            // clipboardData的getData(fomat) 从剪贴板获取指定格式的数据
            var text =  (e.originalEvent || e).clipboardData.getData('text/plain');
            // 插入
            document.execCommand("insertText", false, text);
        });

        //绑定value元素的点击事件以及禁用键盘回车事件
        this.selectvalues.find("li").click(function() {
            var num =  $(this).attr("num");
            _this.selectvalues.find("li").removeClass("ui-state-highlight");
            _this.selectoptions.find("li").removeClass("ui-state-highlight");
            $(this).addClass("ui-state-highlight");
            _this.selectoptions.find('li[num="'+num+'"]').addClass("ui-state-highlight");
        }).on('keydown',function(e) {
            if (e.keyCode == 13) {
                return false;
            }
        }).on('keyup',function(e){
            var rs = _this.getSelectOptionAndValue();
            _this.onChange(rs);
            _this.lookupType.val("none");
            $('#lookupTypeDiv').remove();
            $('#defaultValue').val("");
            _this.defaultselectOption.empty();
            _this.defaultselectOption.append('<option value=""></option>');
            for (var i = 0; i < _this.selectvalues.find("li").length; i++) {
                var value = _this.selectvalues.find("li").eq(i).text();
                var num = _this.selectvalues.find("li").eq(i).attr("num");
                var option = _this.selectoptions.find("li[num='" + num + "']").eq(0).text();
                var opt =$('<option value="' + value+'">'+ option + '</option>');
                _this.defaultselectOption.append(opt);
            }
        }).on('paste',function(e){
            // 阻止默认粘贴
            e.preventDefault();
            // 粘贴事件有一个clipboardData的属性，提供了对剪贴板的访问
            // clipboardData的getData(fomat) 从剪贴板获取指定格式的数据
            var text =  (e.originalEvent || e).clipboardData.getData('text/plain');
            // 插入
            document.execCommand("insertText", false, text);
        });

        //禁用组件内输入框的onchange事件
        this.inputvalue.change(function(){
            return false;
        });
        this.inputoption.change(function(){
            return false;
        });
        this.selectedoptions.change(function(){
            return false;
        });
        this.selectedvalues.change(function(){
            return false;
        });
    },

    //seletbox赋值
    setSelect: function(obj){
        var dataList;
        if (obj.lookupType){
            this.lookupType.val(obj.lookupType);
            //增加通用代码显示通用代码类型及名称功能
            $('#lookupTypeDiv').remove();
            $('#selectarea').prepend('<div id="lookupTypeDiv" class="form-group">' +
                '<li style="list-style-type:none"><input name="showLookupTypeName" id="showLookupTypeName" type="text" readonly="readonly" class="input-medium" value="'+ obj.lookupTypeName + '"></li>' +
                //'&nbsp;' +
                '<li style="list-style-type:none"><input name="showLookupType" id="showLookupType" type="text" readonly="readonly" class="input-medium" value="'+ obj.lookupType + '"></li></div>');
            dataList = obj.rows;
        }
        else {
            dataList = obj;
        }

        this.selectvalues.empty();
        this.selectoptions.empty();
        this.defaultselectOption.empty();
        this.defaultselectOption.append('<option value=""></option>');
        this.optionCount = 0;
        for (var i=0 ;i<dataList.length;i++){
            var li = $('<li class="ui-state-default" contenteditable="true" num="' + this.optionCount+'">'+ dataList[i].lookupName + '</li>');
            var li2 =$('<li class="ui-state-default" contenteditable="true" num="' + this.optionCount+'">'+ dataList[i].lookupCode + '</li>');
            var opt =$('<option value="' + dataList[i].lookupCode+'">'+ dataList[i].lookupName + '</option>');
            this.selectoptions.append(li);
            this.selectvalues.append(li2);
            this.defaultselectOption.append(opt);
            this.optionCount++;
        }
        var rs = this.getSelectOptionAndValue();
        this.onChange(rs);
        this.bindSelectEvent();
    },

    //获取已插入的option和value
    getSelectOptionAndValue:function(){
        var rsObj = [];
        var rsValues = "";
        var rsOptions="";
        for (var i = 0; i < this.selectvalues.find("li").length; i++) {
            var value = this.selectvalues.find("li").eq(i).text();
            rsValues += value+",";
            var num = this.selectvalues.find("li").eq(i).attr("num");
            var option = this.selectoptions.find("li[num='" + num + "']").eq(0).text();
            rsOptions += option+",";
            var obj = {value:value,option:option};
            rsObj.push(obj);
        }
        this.selectedvalues.val(rsValues);
        this.selectedoptions.val(rsOptions);
        this.selectedvalues.trigger("keyup");
        return rsObj;
    },
    
    funPlaceholder : function(element) {
    	element.each(function(){
    		var placeholder = '',that=$(this);
	    	if (element && !("placeholder" in document.createElement("input")) && (placeholder = that.attr("placeholder"))){
	    		that.on('focus',function(){
	    			if (that.val() === placeholder) {
	    	            that.val("");
	    	        }
	    	        that.css('color','');
	    		}).on('blur',function(){
	    			if (that.val() === "") {
	    	            that.val(placeholder);
	    	            that.css('color','graytext');
	    	        }
	    		});
	    	    //样式初始化
	    	    if (that.val() === "") {
	    	        that.val(placeholder);
	    	        that.css('color','graytext');
	    	    }
	    	}
    	});
	}
	
};