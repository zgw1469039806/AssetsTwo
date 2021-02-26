var ViewEditor = function (id) {
    this.editor = $("#" + id);
    this.nowArea = null;
    this.viewStyle = 'bootstrap';
    this.initViewEditor(id);
};
ViewEditor.prototype = {

    initLayout: function () {
        var _this = this;

        $(".eform-layout").find(".tabs_div").each(function () {
            _this.drawTabsTool($(this));
        });

        $(".eform-layout").find(".view_com").each(function () {
            _this.drawComTool($(this).parent());
        });

        $(".eform-layout").find("div").each(function () {
            if (!$(this).children().length > 0) {
                //没有tab
                if ($(this).attr("class").indexOf("tab-pane") == -1) {
                    _this.drawAddArea($(this), true);
                }
                //有tab
                else {
                    _this.drawAddArea($(this), true);
                }
            }
        });
    },

    initViewEditor: function (id) {
        var _this = this;
        $(".eform-item").bind("click", function () {
            _this.setLayout(this);
        });
        this.initLayout();
        $(".eform-layout").height($(window).height() - 41 - 53 - 30);
    },

    getLayoutHtml: function () {
        var $html = $(".eform-layout").clone();
        $html.find(".add-area").remove();
        $html.find(".tools").remove();
        $html.find(".tools_tab").remove();
        var data = $html.html();

        //easyui tabs
        if (this.viewStyle != 'bootstrap' && $html.find('.tabs_div').length > 0) {
            var tabsContentEasyui = $('<div style="height: 100%;" data-options="fit:true" class="tabs_div easyui-tabs"></div>');
            $html.find('.tab-pane.eform-position-item').each(function (index, item) {
                var tabName = $(item).attr('id');
                var viewCom = item.innerHTML;

                tabsContentEasyui.append('<div title="' + tabName + '" class="eform-position-item" style="height: 100%">' + viewCom + '</div>');
            });

            var position = $('<div class="eform-position eform-item-center eform-position-item"></div>');
            position.append(tabsContentEasyui);

            data = position[0].outerHTML;
        }

        return data;
    },

    openTemplate: function () {
    	$('.nav-tabs').find('>li:eq(1)').click();
        var _this = this;
        $('#top-style').modal('show');
    },
    setLayout: function (obj) {
        var _this = this;
        var $clone = $(obj).clone();
        var html = $clone.html();
        $(".eform-layout").html("");
        $(".eform-layout").append(html);
        $(".eform-layout").find("div").each(function () {
            if (!$(this).children().length > 0) {
                _this.drawAddArea(this, true);
            }
        });
    },

    setTabLayout:function(obj,parent){
        var _this = this;
        var $clone = $(obj).clone();
        var html = $clone.html();
        parent.html("");
        parent.append(html);
        parent.find("div").each(function () {
            if (!$(this).children().length > 0) {
                _this.drawAddArea(this, true);
            }
        });

    },

    drawAddArea: function (obj, initDraw) {
        var _this = this;
        $(obj).addClass("eform-position-item");

        var $addArea = $('<div class="add-area"><div class="add-button"></div></div>');

        if (initDraw == true) {
            //添加tab按钮
            var addTabButton = $('<i class=" glyphicon glyphicon-th-large" title="添加Tab页签"></i>');
            addTabButton.click(function () {
                var $parent = $(this).parent().parent().parent();
                _this.drawTabs($parent);
            });
            $addArea.find(".add-button").append(addTabButton);
            $addArea.find(".add-button").append("&nbsp;&nbsp;&nbsp;&nbsp;");
        }

        //添加组件按钮
        var addComButton = $('<i class=" glyphicon glyphicon-plus-sign" title="添加组件"></i>');
        addComButton.click(function () {
            _this.nowArea = this;
            _this.addComAreaClick(this);
        });
        $addArea.find(".add-button").append(addComButton);

        $(obj).append($addArea);
    },

    drawCom: function (obj) {
        var _this = this;
        if (this.nowArea) {
            var $com = $('<span class="view_com"></span>');
            $com.attr("id", obj.id);
            $com.append(obj.name);
            var $parent = $(this.nowArea).parent().parent().parent();
            $parent.html("");
            $parent.append($com);
            //示意图
            if (obj.type == 'tree' || obj.type == 'treeGrid') {
                var $graphIcon = $('<br><br><i class="icon iconfont icon-treelist" style="font-size:800%;color:#2fae95"></i>');
                $parent.append($graphIcon);
            } else if (obj.type == 'table') {
                var $graphIcon = $('<br><br><i class="icon iconfont icon-biaoge-w" style="font-size:800%;color:#2fae95;"></i>');
                $parent.append($graphIcon);
            } else if (obj.type == 'form') {
                var $graphIcon = $('<br><br><i class="icon iconfont icon-cont" style="font-size:800%;color:#2fae95;"></i>');
                $parent.append($graphIcon);
            } else if (obj.type == 'iframe') {
                var $graphIcon = $('<br><br><i class="fa fa-th-large" style="font-size:800%;color:#2fae95;"></i>');
                $parent.append($graphIcon);
            } else if (obj.type === 'dataList'){
                var $graphIcon = $('<br><br><i class="fa fa-list-alt" style="font-size:1100%;color:#2fae95;"></i>');
                $parent.append($graphIcon);
            }

            this.drawComTool($parent);
        }
    },

    drawTabs: function ($parent) {
    	var dataList = [];
    	var tabAlign = $("#tabl_list").data("tabalign");
    	
    	if($parent.find("[role='tablist'] a").length != 0){
    		for(var i=0;i<$parent.find("[role='tablist'] a").length;i++){
    			
    			var liIndex = i;
                if(tabAlign == "2"){
                	liIndex = $parent.find("[role='tablist'] a").length - i -1;
                }
    		    var data = {};
                data.id = $($parent.find("[role='tablist'] a")[liIndex]).attr("aria-controls");
                if (data.id.length != 36){
                    data.id = uuid();
                }
                data.oldValue = $($parent.find("[role='tablist'] a")[liIndex]).attr("aria-controls");
                //兼容之前配置，由于使用图标tab，不需要显示文本，将tab文字挪到a的属性title上保存
                data.tab = $parent.find("[role='tablist'] a")[liIndex].innerText;
                if(data.tab == "" || data.tab == undefined){
                	data.tab = $parent.find("[role='tablist'] a")[liIndex].title;
                }
                
                var iconClass = $($parent.find("[role='tablist'] a")[liIndex]).attr("tabicon");
                if(iconClass != "" && iconClass != undefined){
                	data.tabIcon = '<i class="'+iconClass+'"></i>';
                }else{
                	iconClass = $($parent.find("[role='tablist'] a")[liIndex]).attr("class");
                	iconClass = iconClass.replaceAll("noneBolder",'').trim();
                	if(iconClass != "" && iconClass != undefined){
                		data.tabIcon = '<i class="'+iconClass+'"></i>';
                	}
                }
                dataList.push(data);
    		}
    	}
    	
    	
        var _this = this;
        addDialog = layer.open({
            type: 2,
            title: '设置Tab页签',
            skin: 'bs-modal',
            area: ['50%', '70%'],
            maxmin: false,
            content: "avicit/platform6/eform/bpmsviewdesign/tabManage.jsp",
            btn: ['确定', '关闭'],
            success: function (layero, index) {
                var iframeWin = layero.find('iframe')[0].contentWindow;
                var extData = {};
                extData.tabStyle = $("#tabl_list").data("tabstyle");
                extData.tabAlign = $("#tabl_list").data("tabalign");
                extData.fontSize = $("#tabl_list").data("fontsize");
                
                iframeWin.initJqgrid(dataList,extData);
            },
            yes: function (index, layero) {
                var iframeWin = layero.find('iframe')[0].contentWindow;
                var tabsStr = iframeWin.saveTab();
                var tabRows = iframeWin.getDataRows();
                var tabExtData = iframeWin.getExtData();
                
                // if(tabRows.length > 8){
                // 	 layer.msg('只能添加8个以内的tab页签！', {icon: 7});
                //      return;
                // }
                
                if (tabsStr == undefined || tabsStr == "") {
                    layer.msg('请添加Tab页签！', {icon: 7});
                    return;
                }

                var tabs = tabsStr.split(",");

                for (var tabIndex in tabs) {
                    if (tabIndex == "clone"){
                        continue;
                    }
                    if (tabs[tabIndex].trim() == null || tabs[tabIndex].trim().length == 0) {
                        var errorIndex = parseInt(tabIndex) + 1;
                        layer.msg('第' + errorIndex + '个页签为空,请添加Tab页签！', {icon: 7});
                        return;
                    }
                }
                
                //根据对齐方式设置class
                var alignClass = '';
                if(tabExtData.tabAlign == "2"){
                	alignClass = 'rightAlign';
                }
                
                var tabsContent = $('<div style="height: 100%" class="tabs_div '+alignClass+'" addheight="40"></div>');
                tabsContent.append('<ul id="tabl_list" class="nav nav-tabs" role="tablist" data-tabstyle="' + tabExtData.tabStyle + '" data-tabalign="' + tabExtData.tabAlign + '" data-fontsize="' + tabExtData.fontSize + '"></ul>');
                tabsContent.append('<div class="tab-content" style="height:100%;padding-bottom: 40px"></div>');
                var viewCom = [];
                for (var i = 0; i < tabRows.length; i++) {
                    var li = "";
                    var div = "";
                    var id = "";
                    //根据对齐方式设置索引值，处理li设置居右后被反序了
                    var liIndex = i;
                    if(tabExtData.tabAlign == "2"){
                    	liIndex = tabRows.length - i -1;
                    }
                    
                    if (tabRows[liIndex].id !=null && tabRows[liIndex].id != undefined && tabRows[liIndex].id != ""){
                        id = tabRows[liIndex].id;
                    }else{
                        id = uuid();
                    }
                    
                    //如果存在图标显示，通过class noneBolder去除图片外边框和背景色
                    var iconClass = "";
                    if(tabRows[liIndex].tabIcon != "" && tabRows[liIndex].tabIcon != undefined){
                    	iconClass = $(tabRows[liIndex].tabIcon).attr("class") + ' noneBolder';
                    }
                    
                    if (liIndex == 0) {
                    	if(tabExtData.tabStyle == '1'){
                    		li = '<li role="presentation" class="active" onclick="$(window).trigger(\'resize\');"><a href="#' + id + '" aria-controls="' + id + '" role="tab" data-toggle="tab" style="font-size:' + tabExtData.fontSize + 'px" title="' + tabRows[liIndex].tab + '" tabicon="' + iconClass + '">' + tabRows[liIndex].tab + '</a></li>';
                    	}else{
                    		li = '<li role="presentation" class="active" onclick="$(window).trigger(\'resize\');"><a href="#' + id + '" aria-controls="' + id + '" class="' + iconClass + '" role="tab" data-toggle="tab" style="font-size:' + tabExtData.fontSize + 'px" title="'+tabRows[liIndex].tab+'" > </a></li>';
                    	}
                        div = '<div role="tabpanel" class="tab-pane active" id="' + id + '" style="height: 100%;"><div class="eform-position eform-item-center eform-position-item"></div></div>';
                    }
                    else {
                    	if(tabExtData.tabStyle == '1'){
                    		li = '<li role="presentation" onclick="$(window).trigger(\'resize\');"><a href="#' + id + '" aria-controls="' + id + '" role="tab" data-toggle="tab" style="font-size:' + tabExtData.fontSize + 'px" title="' + tabRows[liIndex].tab + '" tabicon="' + iconClass + '">' + tabRows[liIndex].tab + '</a></li>';
                    	}else{
                    		li = '<li role="presentation" onclick="$(window).trigger(\'resize\');"><a href="#' + id + '" aria-controls="' + id + '" class="' + iconClass + '" role="tab" data-toggle="tab" style="font-size:' + tabExtData.fontSize + 'px" title="' + tabRows[liIndex].tab + '" > </a></li>';
                    	}
                        div = '<div role="tabpanel" class="tab-pane" id="' + id + '" style="height: 100%;"><div class="eform-position eform-item-center eform-position-item"></div></div>';
                    }

                    if($("#" + tabRows[liIndex].oldValue).find('.view_com').length != 0){
                    	var ob = new Object();
                    	ob.divId = tabRows[liIndex].id;
                    	ob.comId = $("#" + tabRows[liIndex].oldValue).find('.view_com').attr("id");
                    	ob.comName = $("#" + tabRows[liIndex].oldValue).find('.view_com').text();
            			viewCom.push(ob);
                    }
                    
                    tabsContent.find(".nav-tabs").append(li);
                    tabsContent.find(".tab-content").append(div);
                }

                $parent.html("");
                $parent.addClass("eform-position-item");
                $parent.append(tabsContent);
                
                // $parent.find('.tab-content').height($(window).height() - 180);
                $parent.find('.tab-pane').each(function (index, element) {
            	   _this.drawAddArea($(element).children(".eform-position"), true);
            	   //画组件
            	   var comId = "";
            	   var comName = "";
            	   var comType = "";
            	   for(var i=0;i<viewCom.length;i++){
            		  if(viewCom[i].divId == $(element).attr("id")){
                    	  comId = viewCom[i].comId;
                    	  comName = viewCom[i].comName;
                    	  //示意图
                          if (comId.indexOf('tree') !=-1 ) {
                        	  comType = 'tree';
                          } else if (comId.indexOf('table') !=-1 ) {
                        	  comType = 'table';
                          } else if (comId.indexOf('form') !=-1 ) {
                        	  comType = 'form';
                          } else if (comId.indexOf('iframe') !=-1 ) {
                        	  comType = 'iframe';
                          }
                       }
            	    }
                	if(comId != ""){
                        _this.nowArea = $(element).find('.glyphicon-plus-sign');
                		var o = {};
                		o.id = comId;
                		o.name = comName;
                		o.type = comType;
                		_this.drawCom(o);
                	}
                });

                _this.drawTabsTool(tabsContent);

                layer.close(index);
            }
        });
    },

    drawTabsTool: function (parentdom) {
        var _this = this;
        var $parent = parentdom.parent();
        parentdom.append('<div class="tools_tab"></div>');
        var $edittab = $('<i class=" glyphicon glyphicon-th-large" style="cursor:pointer;color:green;position: absolute;right: 40px;top:12px;font-size: 150%;" title="编辑Tab页签"></i>').click(function () {_this.drawTabs($parent);});

        var $deltab = $('<i class="ace-icon fa fa-times" style="cursor:pointer;color:red;position: absolute;right: 10px;top:12px;font-size: 150%;" title="移除Tab页签"></i>').click(function () {
            layer.confirm("确认要移除Tab页签吗？", {icon: 3, title: '提示', area: ['400px', '']}, function (index) {
                $parent.html("");
                _this.drawAddArea($parent, true);

                layer.close(index);
            });
        });

        var $tablayout = $('<i class="ace-icon fa fa-adjust" style="cursor:pointer;position: absolute;right: 79px;top:12px;font-size: 150%;" title="变更布局"></i>').click(function () {

            var cloneLayout = $("#styleList").clone();
            cloneLayout.find(".closeButton").remove();
            cloneLayout.css("padding","10px");
            cloneLayout.attr("id","tabLayoutList");
            var layoutlayer = layer.open({
                type: 1,
                title: "",
                skin: 'bs-modal',
                area: ['50%', '50%'],
                content: cloneLayout.prop("outerHTML"),
                success:function(index){
                    $("#tabLayoutList").find(".eform-item").bind("click", function () {
                        var $tabpane = parentdom.find(".tab-pane.active");
                        _this.setTabLayout(this,$tabpane);
                        layer.close(layoutlayer);
                    });

                }
            });



        });


        parentdom.find(".tools_tab").append($tablayout).append($edittab).append($deltab);
    },

    drawComTool: function (parentdom) {
        var _this = this;
        var $tool = $("<div></div>");
        $tool.addClass("tools tools-top");
//			var $buttonOp = $("<button></button>").addClass("btn btn-white btn-info btn-bold");
//			$buttonOp.append('<i class="ace-icon fa fa-floppy-o blue"></i>操作');
//			var $buttonDel = $("<button></button>").addClass("btn btn-white btn-warning btn-bold");
//			$buttonDel.append('<i class="ace-icon fa fa-trash-o orange"></i>删除');

        var $buttonDel = $('<i class="ace-icon fa fa-trash-o" style=\"cursor:pointer;color:#2fae95\" title=\"移除组件\"></i>');
        $buttonDel.attr('cursor', 'pointer');
        $buttonDel.click(function () {
            var $parent = $(this).parent().parent();

            $parent.html("");
            //没有tab
            if ($parent.attr("class").indexOf("tab-pane") == -1) {
                _this.drawAddArea($parent, true);
            }
            //有tab
            else {
                _this.drawAddArea($parent, true);
            }
        });
//			$tool.append($buttonOp).append($buttonDel);
        $tool.append($buttonDel);

        parentdom.append($tool);
    },

    addComAreaClick: function () {
        addDialog = layer.open({
            type: 2,
            title: '添加组件',
            skin: 'bs-modal',
            area: ['42%', '40%'],
            maxmin: false,
            content: "avicit/platform6/eform/bpmsviewdesign/selectComponent.jsp"
        });
    },

    closeDialog: function (type) {
        if (type == "add") {
            layer.close(addDialog);
        }
        if (type == "edit") {
            layer.close(editDialog);
        }
    },

    preview: function (html) {
        $.ajax({
            url: 'platform/eform/bpmsClient/layoutpreview.json',
            data: {tableContent: html},
            type: 'post',
            dataType: 'json',
            success: function (r) {
                if (r) {

                }
            }
        });
    }
};

function isIE8() {
    if (!+[1,]) return true;
    else return false;
}


function loadExtraJs(callback){
    if (typeof EformConfig.viewExtraJs == "undefined"){
        if (typeof callback == "function") {
            callback();
        }
        return;
    }

    var jsArray = EformConfig.viewExtraJs;
    for (var i=0;i<jsArray.length;i++){
        var script = document.createElement("script");
        script.type = "text/javascript";
        if (i==(jsArray.length-1)) {
            if (typeof callback == "function") {
                script.onload = function () {
                    callback();
                };
            }
            if (isIE8()) {
                if (typeof callback == "function") {
                    script.onreadystatechange = function () {
                        var r = script.readyState;
                        if (r === 'loaded' || r === 'complete') {
                            script.onreadystatechange = null;
                            callback();
                        }
                    };
                }
            }
        }

        script.src = jsArray[i];
        document.getElementsByTagName("head")[0].appendChild(script);
    }
}