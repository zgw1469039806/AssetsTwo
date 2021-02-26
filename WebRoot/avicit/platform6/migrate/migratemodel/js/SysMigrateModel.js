/**
 * Created by FQ on 2017/6/22.
 */
function SysMigrateModel(modelList ,modelDetailFormId, modelDetailTableBody) {

    this.$modelList = $("#" + modelList);
    this.$modelDetailForm = $("#" + modelDetailFormId);
    this.$modelDetailTableBody = $("#" + modelDetailTableBody);

    this.url = "platform/migrate/sysMigrateModelController/";
    this.modelTemplate = null;
    this.modelDetailTemplate = null;
    this.selectedModelData = {};
    this.selectedModelDetailData = [];
    this.$selectedModel = null;
    this.sameModelNameFlag = false;
    this.validateModelDetailResult = true;
    this.validateSqlScriptOnChangeResult = true;
    this.validateDateFieldOnChangeResult = true;

    this.init.call(this);
};

// 初始化操作
//查询模块数据，然后将数据展示在列表上，同时选中第一个model，并查询mode detail数据
SysMigrateModel.prototype.init = function() {
    var _this = this;

    this.modelTemplate = '<li class="model-li" id="model_" data-id="" data-name="" data-type="">'+
                                '<a>'+
                                    '<i class="fa fa-file"></i>'+
                                    '<span title=""></span>'+
                                '</a>'+
                          '</li>';

    this.modelDetailTemplate =  '<tr >'+
                                    '<td style="white-space:nowrap;">'+
                                        '<input type="hidden" name="id" id="detalId_1"/>'+
                                        '<input type="hidden" name="sqlNo" id="sqlNo_1" value="1"/>'+
                                        '<span class="" name="sqlNoSpan"  id="sqlNoSpan_1" title="SQL No.">1</span>'+
                                    '</td>'+
                                    '<td style="white-space:nowrap;">'+
                                        '<input class="form-control input-sm" type="text" name="sqlScript" id="sqlScript_1" title="SQL脚本" data-placement="bottom"></input>'+
                                    '</td>'+
                                    '<td style="white-space:nowrap;">'+
                                        '<input class="form-control input-sm" type="text" name="dateField"  id="dateField_1" title="时间字段" data-placement="bottom"/>'+
                                    '</td>'+
                                    '<td style="white-space:nowrap;">'+
                                        '<select class="form-control input-sm" id="sqlExecType_1" name="sqlExecType" title="执行类型">'+
                                            '<option value="1">同步</option>'+
                                            '<option value="2">迁移</option>'+
                                        '</select>'+
                                    '</td>'+
                                    '<td style="white-space:nowrap;">'+
                                        '<a id="addModelDetail_1" href="javascript:void(0)" class="btn btn-sm form-tool-btn" style="min-width: 30px;padding:0 5px;" role="button" title="添加"><i class="glyphicon glyphicon-plus"></i></a>'+
                                        '<a id="delModelDetail_1" href="javascript:void(0)" class="btn btn-sm form-tool-btn" style="min-width: 30px;padding:0 5px;" role="button" title="删除"><i class="glyphicon glyphicon-minus"></i></a>'+
                                        '<a id="upModelDetail_1" href="javascript:void(0)" class="btn btn-sm form-tool-btn" style="min-width: 30px;padding:0 5px;" role="button" title="向上"><i class="glyphicon glyphicon-arrow-up"></i></a>'+
                                        '<a id="downModelDetail_1" href="javascript:void(0)" class="btn btn-sm form-tool-btn" style="min-width: 30px;padding:0 5px;" role="button" title="向下"><i class="glyphicon glyphicon-arrow-down"></i></a>'+
                                    '</td>'+
                                '</tr>';

    //查询模块数据
    $.ajax({
        url: _this.url + "getMigrateModelData",
        data: "",
        type: "post",
        async: false,
        dataType: "json",
        success: function (resp) {
            if (resp.flag == "success" && resp.data != "undefined") {
                _this.drawModelList(resp.data);
            }else {
                layer.msg('查询模块数据失败!',{icon:2,title: "提示",area: ['400px', '']});
            }
        }
    });

};

//绘制模块列表
SysMigrateModel.prototype.drawModelList = function(modelData){
    var _this = this;
    var $modelTemplate;
    $.each(modelData, function(idx, obj){

        $modelTemplate = $(_this.modelTemplate);
        //模块赋值
        $modelTemplate.attr("id","model_"+ (_this.$modelList.find("li").length + 1));
        $modelTemplate.attr("data-id",obj.id);
        $modelTemplate.attr("data-name",obj.modelName);
        $modelTemplate.attr("data-type",obj.modelType);
        $modelTemplate.attr("data-lastupdatedatestring",obj.lastUpdateDateString);
        $modelTemplate.find("span").text(obj.modelName).attr("title",obj.modelName);

        //如果模块类型是平台的话，设置样式
        if(obj.modelType == "1"){
            $modelTemplate.find("i").removeClass("fa fa-file");
            $modelTemplate.find("i").addClass("fa fa-file-text");
        }

        //绑定模块列表的单击事件
        $modelTemplate.off("click").on("click",function(event){
            _this.selectedModel(event);
        });

        //选中第一个模块
        if(idx == 0){
            $modelTemplate.click();
        }

        _this.$modelList.append($modelTemplate);
    });

};

//校验模块名称是否重复
SysMigrateModel.prototype.validModelName = function($modelName){
    var _this = this;

    var modelName = $modelName.val();
    if(modelName.gblen() > 255){
        var error = "最多可以输入255个字符(一个中文字符长度为2)";
        $modelName.attr("title", error).tooltip("show");
        $modelName.attr("data-original-title", error).tooltip("show");
        $modelName.addClass("error");
        _this.sameModelNameFlag = true;
    }else {

        _this.$modelList.find("li").each(function (idx, elem) {
            if (modelName == $(this).attr("data-name")) {
                _this.sameModelNameFlag = true;
                return false;
            } else {
                _this.sameModelNameFlag = false;
            }
        });

        if (_this.sameModelNameFlag) {
            var error = modelName + "模块名称已存在，请重新输入！";
            $modelName.attr("title", error).tooltip("show");
            $modelName.attr("data-original-title", error).tooltip("show");
            $modelName.addClass("error");
        } else {
            $modelName.attr("title", "");
            $modelName.attr("data-original-title", "");
            $modelName.removeClass("error");
            $modelName.tooltip('destroy');
        }
    }
};

//添加模块
SysMigrateModel.prototype.addModel = function(){
    var _this = this;

    if (_this.$selectedModel != null && _this.isChangeModelData()) {
        if (_this.isNotEmpty(_this.$selectedModel.attr("data-id"))) {
            layer.alert("既存的[" + _this.$selectedModel.attr("data-name") + ']模块的数据已经被修改，请保存后再添加新模块！',{icon: 7,title: "提示",closeBtn: 0,area: ['400px', '']});
        } else {
            layer.alert("新增的[" + _this.$selectedModel.attr("data-name") + ']模块的详细数据已经被修改，请保存后再添加新模块！',{icon: 7,title: "提示",closeBtn: 0,area: ['400px', '']});
        }
    }else {
        layer.open({
            type: 2,
            area: ['400px', '200px'],
            title: '添加模块',
            skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
            maxmin: false, // 开启最大化最小化按钮
            content: "avicit/platform6/migrate/migratemodel/SysMigrateModel.jsp",
            success: function (layero, index) {
                var $childrenBody = layer.getChildFrame('body', index);//建立父子联系
                var $modelName = $childrenBody.find("#modelName");

                //绑定事件:校验模块名称是否重复
                $modelName.off("change").on("change", function (event) {
                    _this.validModelName($modelName)
                });

                //监听键盘事件
                $childrenBody.on('keydown', function(event){
                    if(event.keyCode === 13){
                        return false; //阻止系统默认回车事件
                    }
                });
            },
            btn: ['确认', '取消'],
            btn1: function (index, layero) {
                var $childrenBody = layer.getChildFrame('body', index);//建立父子联系
                var $modelName = $childrenBody.find("#modelName");
                var modelName = $modelName.val();

                //校验模块名称
                if(!_this.isNotEmpty(modelName)){
                    var error = "请输入模块名称！";
                    $modelName.attr("title", error).tooltip("show");
                    $modelName.attr("data-original-title", error).tooltip("show");
                    $modelName.addClass("error");
                    return false;
                } else {
                    //校验模块名称是否重复
                    if (_this.sameModelNameFlag) {
                        return false;
                    }else{
                        $modelName.attr("title", "");
                        $modelName.attr("data-original-title", "");
                        $modelName.removeClass("error");
                        $modelName.tooltip('destroy');
                    }
                }

                //模块赋值
                var $modelTemplate = $(_this.modelTemplate);
                var modelType = $childrenBody.find('input[name="modelType"]:checked').val();
                $modelTemplate.attr("id", "model_" + (_this.$modelList.find("li").length + 1));
                $modelTemplate.attr("data-name", modelName);
                $modelTemplate.attr("data-type", modelType);
                $modelTemplate.attr("data-lastupdatedatestring", "");
                $modelTemplate.find("span").text(modelName).attr("title", modelName);

                //如果模块类型是平台的话，设置样式
                if(modelType == "1"){
                    $modelTemplate.find("i").removeClass("fa fa-file");
                    $modelTemplate.find("i").addClass("fa fa-file-text");
                }

                //绑定模块列表的单击事件
                $modelTemplate.off("click").on("click", function (event) {
                    _this.selectedModel(event);
                });

                $modelTemplate.click();
                _this.$modelList.append($modelTemplate);

                layer.close(index);
            },
            btn2: function (index, layero) {
                layer.close(index);
            }
        });
    }
};

//修改模块
SysMigrateModel.prototype.editModel = function(){
    var _this = this;

    if(_this.$selectedModel == null){
        layer.alert("请选择要编辑的模块！",{icon: 3 ,title: "提示",closeBtn: 0,area: ['400px', '']});
        return;
    }

    layer.open({
        type : 2,
        area: ['400px', '200px'],
        title : '编辑模块',
        skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin : false, // 开启最大化最小化按钮
        content : "avicit/platform6/migrate/migratemodel/SysMigrateModel.jsp",
        success: function(layero, index){
            var $childrenBody = layer.getChildFrame('body',index);//建立父子联系
            var $modelName = $childrenBody.find("#modelName");

            $modelName.val(_this.$selectedModel.attr("data-name"));
            if(_this.$selectedModel.attr("data-type") == "1"){
                $childrenBody.find("input[name='modelType'][value='1']").prop("checked",true);
            }else{
                $childrenBody.find("input[name='modelType'][value='2']").prop("checked",true);
            }

            //绑定事件:校验模块名称是否重复
            $modelName.off("change").on("change", function (event) {
                _this.validModelName($modelName)
            });

            //监听键盘事件
            $childrenBody.on('keydown', function(event){
                if(event.keyCode === 13){
                    return false; //阻止系统默认回车事件
                }
            });
        },
        btn:['确认','取消'],
        btn1:function(index, layero){
            var $childrenBody = layer.getChildFrame('body',index);//建立父子联系
            var $modelName = $childrenBody.find("#modelName");
            var modelName = $modelName.val();
            var modelType = $childrenBody.find('input[name="modelType"]:checked').val();

            //校验模块名称
            if(!_this.isNotEmpty(modelName)){
                var error = "请输入模块名称！";
                $modelName.attr("title", error).tooltip("show");
                $modelName.attr("data-original-title", error).tooltip("show");
                $modelName.addClass("error");
                return false;
            } else {
                //校验模块名称是否重复
                if (_this.sameModelNameFlag) {
                    return false;
                }else{
                    $modelName.attr("title", "");
                    $modelName.attr("data-original-title", "");
                    $modelName.removeClass("error");
                    $modelName.tooltip('destroy');
                }
            }

            //模块赋值
            _this.$selectedModel.attr("data-name", modelName);
            _this.$selectedModel.attr("data-type", modelType);
            _this.$selectedModel.find("span").text(modelName).attr("title", modelName);

            if(!_this.isNotEmpty(_this.$selectedModel.attr("data-id"))){
                _this.selectedModelData.modelName = modelName;
                _this.selectedModelData.modelType = modelType;
            }

            //如果模块类型是平台的话，设置样式
            if(modelType == "1"){
                if(_this.$selectedModel.find("i").hasClass("fa fa-file")) {
                    _this.$selectedModel.find("i").removeClass("fa fa-file");
                    _this.$selectedModel.find("i").addClass("fa fa-file-text");
                }
            }else{
                if(_this.$selectedModel.find("i").hasClass("fa fa-file-text")){
                    _this.$selectedModel.find("i").removeClass("fa fa-file-text");
                    _this.$selectedModel.find("i").addClass("fa fa-file");
                }
            }

            layer.close(index);
        },
        btn2:function(index, layero){
            layer.close(index);
        }
    });
};

//删除模块
SysMigrateModel.prototype.delModel = function(){
    var _this = this;

    if(_this.$selectedModel == null){
        layer.alert("请选择要删除的模块！",{icon: 7,title: "提示",closeBtn: 0,area: ['400px', '']});
        return;
    }

    layer.confirm('确认要删除选中的模块吗?', {icon : 7,title : "提示",closeBtn: 0,area : [ '400px', '' ]}, function(index) {
        var dataId = _this.$selectedModel.attr("data-id");
        var $prev;
        if( _this.$selectedModel.prev().length >0){
            $prev = _this.$selectedModel.prev();
        }
        if(!_this.isNotEmpty(dataId)) {
            //如果是dataID是空，说明还没有保存到数据库，直接删除

            _this.$selectedModel.remove();
            _this.$selectedModel = null;
            _this.$modelDetailTableBody.empty();
            if($prev){
                $prev.click();
            }

        }else{
            //如果是dataID不是空，说明还已近保存到数据库，从数据库直接删除
            $.ajax({
                url : _this.url + "deleteMirgateMode",
                data : {"id":dataId},
                type : 'post',
                async: false,
                dataType : 'json',
                success : function(resp) {
                    if (resp.flag == "success") {
                        if(resp.result == "1"){
                            layer.alert('该模块正在使用中，不能删除！',{icon:7,title: "提示",closeBtn: 0,area: ['400px', '']});
                        }else{
                            _this.$selectedModel.remove();
                            _this.$selectedModel = null;
                            _this.$modelDetailTableBody.empty();
                            if($prev){
                                $prev.click();
                            }
                            layer.msg('删除成功！',{icon:7,title: "提示",closeBtn: 0,area: ['400px', '']});
                        }
                    } else {
                        layer.alert('删除失败！',{icon: 7,title: "提示",closeBtn: 0,area: ['400px', '']});
                    }
                }
            });
        }
        layer.close(index);
    });

};

//模块选中
SysMigrateModel.prototype.selectedModel = function(event){
    var _this = this;

    var $selectedTag = $(event.target);
    var $selectedModelLocal = $selectedTag.closest("li");

    if(_this.$selectedModel == null || _this.$selectedModel.attr("id") != $selectedModelLocal.attr("id")) {
        if (_this.$selectedModel != null && _this.isChangeModelData()) {
            if(_this.isNotEmpty(_this.$selectedModel.attr("data-id"))){
                layer.alert("既存的["+_this.$selectedModel.attr("data-name") + ']模块的数据已经被修改，请先保存！',{icon: 7,title: "提示",closeBtn: 0,area: ['400px', '']});
            }else{
                layer.alert("新增的["+_this.$selectedModel.attr("data-name") + ']模块的详细数据已经被修改，请先保存！',{icon: 7,title: "提示",closeBtn: 0,area: ['400px', '']});
            }

            // layer.confirm(_this.$selectedModel.attr("data-name") + '模块的细信息被修改，需要保存么？', {
            //     btn: ['保存', '返回'],//按钮
            //     icon: "0"
            // }, function(){
            //     var promise = _this.saveData(event);
            //     promise.done(_this.selectedModel(event));
            // }),function(){
            //     _this.selectedModel(event);
            // };
        }else {
            _this.$selectedModel = $selectedModelLocal;

            //删除其他模块的选中样式
            var oldRedrawLi = _this.$modelList.find("li.selected-model-li").removeClass("selected-model-li");
            //修改被选中模块的样式
            var newRedrawLi = $selectedModelLocal.addClass("selected-model-li");
            if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
            	//IE8下对icon图标伪类重绘，解决点击模块时选中色不重绘问题，这里只针对变更的两个li进行重绘
	            	oldRedrawLi = oldRedrawLi.find('.fa');
	            	oldRedrawLi.addClass('content-empty');
		   	 		  setTimeout(function(){
		   	 			oldRedrawLi.removeClass('content-empty');
		   	 		  },0);
		   	 		newRedrawLi = newRedrawLi.find('.fa');
		   	       	newRedrawLi.addClass('content-empty');
		   	 		  setTimeout(function(){
		   	 			newRedrawLi.removeClass('content-empty');
		   	 		  },0);
	   	 	  }
            //保存选中时的数据
            _this.selectedModelData = {
                id: _this.$selectedModel.attr("data-id"),
                modelName: _this.$selectedModel.attr("data-name"),
                modelType: _this.$selectedModel.attr("data-type")
            }

            //取得模块详细数据，并绘制详细页面
            var dataId = $selectedModelLocal.attr("data-id");
            if (_this.isNotEmpty(dataId)) {
                _this.createModelDetail();
            } else {
                _this.selectedModelDetailData = [{
                    id: "",
                    sqlNo: "1",
                    sqlScript: "",
                    dateField: "",
                    sqlExecType: "1"
                }];
                _this.$modelDetailTableBody.empty();
                //邦定事件
                var $newModelDetail = $(_this.modelDetailTemplate);
                _this.bindTrEvent($newModelDetail);
                _this.$modelDetailTableBody.append($newModelDetail);
            }
        }
    }

};

//绘制模块detail
SysMigrateModel.prototype.createModelDetail = function(){
    var _this = this;

    //查询模块detail数据
    $.ajax({
        url: _this.url + "getMigrateModelDetailData",
        data: {"id": _this.$selectedModel.attr("data-id")},
        type: "post",
        async: false,
        dataType: "json",
        success: function (resp) {
            if (resp.flag == "success" && resp.data != "undefined") {
                if (resp.data.length > 0) {
                    _this.selectedModelDetailData = resp.data;
                    _this.drawModelDetail(resp.data);
                } else {
                    _this.selectedModelDetailData = [];
                    _this.$modelDetailTableBody.empty();
                    //邦定事件
                    var $newModelDetail = $(_this.modelDetailTemplate);
                    _this.bindTrEvent($newModelDetail);
                    _this.$modelDetailTableBody.append($newModelDetail);
                    layer.msg(_this.$selectedModel.attr("data-name") + '模块没有详细数据！', {icon: 5, time: 2000 ,title: "提示",area: ['400px', '']});
                }

            } else {
                layer.msg('查询模块数据失败', {icon: 2, time: 2000 ,title: "提示",area: ['400px', '']});
            }
        }
    });
};

//绘制模块detail
SysMigrateModel.prototype.drawModelDetail = function(modelDetailData){
    var _this = this;

    _this.$modelDetailTableBody.empty();

    $.each(modelDetailData, function (idx, obj) {
        var $modelDetailTemplate = $(_this.modelDetailTemplate);
        //赋值
        $modelDetailTemplate.find('input[name="id"]').val(obj.id);
        $modelDetailTemplate.find('span[name="sqlNoSpan"]').text(obj.sqlNo);
        $modelDetailTemplate.find('input[name="sqlNo"]').val(obj.sqlNo);
        $modelDetailTemplate.find('input[name="sqlScript"]').val(obj.sqlScript);
        $modelDetailTemplate.find('input[name="dateField"]').val(obj.dateField);
        $modelDetailTemplate.find('select[name="sqlExecType"]').val(obj.sqlExecType);

        //修改ID属性
        $modelDetailTemplate.find("input,td>span,a,select").each(function (index, elem) {
            var elemIdArray = $(this).attr("id").split("_");
            $(this).attr("id", elemIdArray[0] + "_" + obj.sqlNo);
        });

        //邦定事件
        _this.bindTrEvent($modelDetailTemplate);

        _this.$modelDetailTableBody.append($modelDetailTemplate);
    });
};

//判断字符串是否是uundefined null ""
SysMigrateModel.prototype.isNotEmpty = function(checkObject){
    if(!checkObject){
        return false;
    }
    if(checkObject ==  "undefined" || checkObject == null || checkObject == ""
        || typeof(checkObject) == "undefined" || checkObject == "null"){
        return false;
    }
    return true;
};

//行添加
SysMigrateModel.prototype.addTr = function(event){
    var _this = this;
    var $currentTr = $(event.target).closest("tr");

    var currentId = $currentTr.find('input[id^="sqlNo_"]').val();
    var $addTr = $(_this.modelDetailTemplate);
    //addTr.find("input,span").val("");//清空值


    $addTr.find("input,td>span,a,select").each(function(index,e){
        var eIdArray = $(this).attr("id").split("_");
        $(this).attr("id", eIdArray[0] + "_" + (parseInt(currentId) + 1));
        //设定SQL No.的值
        if($(this).is('span[id^="sqlNoSpan_"]')){
            $(this).text(parseInt(currentId) + 1);
        }
        if($(this).is('input[id^="sqlNo_"]')){
            $(this).val(parseInt(currentId) + 1);
        }

    });

    //邦定事件
    _this.bindTrEvent($addTr);

    //修改后面所有行的ID属性
    $currentTr.nextAll().each(function(idx,e){
        //设定的值
        $(this).find("input,td>span,a,select").each(function(index,elem){
            var elemIdArray = $(this).attr("id").split("_");
            $(this).attr("id", elemIdArray[0] + "_" + (parseInt(elemIdArray[1]) + 1));
            //设定SQL No.的值
            if($(this).is('span[id^="sqlNoSpan_"]')){
                $(this).text(parseInt(elemIdArray[1]) + 1);
            }
            if($(this).is('input[id^="sqlNo_"]')){
                $(this).val(parseInt(elemIdArray[1]) + 1);
            }
        });

    });

    //添加新行
    $currentTr.after($addTr);

};

//行删除
SysMigrateModel.prototype.delTr = function(event){
    var _this = this;

    var $currentTr = $(event.target).closest("tr");

    if($currentTr.siblings().length > 0){
        //修改后面所有行的ID属性
        $currentTr.nextAll().each(function(idx,e){
            $(this).find("input,td>span,a,select").each(function(index,elem){
                var elemIdArray = $(this).attr("id").split("_");
                $(this).attr("id", elemIdArray[0] + "_" + (parseInt(elemIdArray[1]) - 1));
                //设定SQL No.的值
                if($(this).is('span[id^="sqlNoSpan_"]')){
                    $(this).text(parseInt(elemIdArray[1]) - 1);
                }
                if($(this).is('input[id^="sqlNo_"]')){
                    $(this).val(parseInt(elemIdArray[1]) - 1);
                }
            });
        });

        //删除当前行
        $currentTr.remove();

    }
};


//行向上
SysMigrateModel.prototype.upTr = function(event){
    var _this = this;

    var $currentTr = $(event.target).closest("tr");
    var $prevTr = $currentTr.prev();

    if($prevTr.length > 0){
        var currentTrTop = $currentTr.position().top;
        var prevTrTop = $prevTr.position().top;
        var width = $currentTr.width();

        //修改上一行的ID属性
        $prevTr.find("input,td>span,a,select").each(function(idx,e){
            var eIdArray = $(this).attr("id").split("_");
            $(this).attr("id", eIdArray[0] + "_" + (parseInt(eIdArray[1]) + 1));
            //设定SQL No.的值
            if($(this).is('span[id^="sqlNoSpan_"]')){
                $(this).text(parseInt(eIdArray[1]) + 1);
            }
            if($(this).is('input[id^="sqlNo_"]')){
                $(this).val(parseInt(eIdArray[1]) + 1);
            }
        });

        //修改当前行的ID属性
        $currentTr.find("input,td>span,a,select").each(function(idx,e){
            var eIdArray = $(this).attr("id").split("_");
            $(this).attr("id", eIdArray[0] + "_" + (parseInt(eIdArray[1]) - 1));
            //设定SQL No.的值
            if($(this).is('span[id^="sqlNoSpan_"]')){
                $(this).text(parseInt(eIdArray[1]) - 1);
            }
            if($(this).is('input[id^="sqlNo_"]')){
                $(this).val(parseInt(eIdArray[1]) - 1);
            }

        });

        //交换动画
        $currentTr.css('visibility','hidden');
        $prevTr.css('visibility','hidden');
        $currentTr.clone()
            .insertAfter($currentTr)
            .css({position:'absolute',visibility:'visible',top:currentTrTop,width:width})
            .animate(	{top:prevTrTop},
                300,
                function(){
                    $(this).remove();
                    $currentTr.insertBefore($prevTr).css('visibility','visible');
                });
        $prevTr.clone()
            .insertAfter($prevTr)
            .css({position:'absolute',visibility:'visible',top:prevTrTop,width:width})
            .animate(	{top:currentTrTop},
                300,
                function(){
                    $(this).remove();
                    $prevTr.insertAfter($currentTr).css('visibility','visible')
                });

        //行交换
        //currentTr.after(prevTr);
    }

};

//行向下
SysMigrateModel.prototype.downTr = function(event){
    var _this = this;

    var $currentTr = $(event.target).closest("tr");
    var $nextTr = $currentTr.next();

    if($nextTr.length > 0){
        var currentTrTop = $currentTr.position().top;
        var nextTrTop = $nextTr.position().top;
        var width = $currentTr.width();

        //修改下一行的ID属性
        $nextTr.find("input,td>span,a,select").each(function(idx,e){
            var eIdArray = $(this).attr("id").split("_");
            $(this).attr("id", eIdArray[0] + "_" + (parseInt(eIdArray[1]) - 1));
            //设定SQL No.的值
            if($(this).is('span[id^="sqlNoSpan_"]')){
                $(this).text(parseInt(eIdArray[1]) - 1);
            }
            if($(this).is('input[id^="sqlNo_"]')){
                $(this).val(parseInt(eIdArray[1]) - 1);
            }
        });

        //修改当前行的ID属性
        $currentTr.find("input,td>span,a,select").each(function(idx,e){
            var eIdArray = $(this).attr("id").split("_");
            $(this).attr("id", eIdArray[0] + "_" + (parseInt(eIdArray[1]) + 1));
            //设定SQL No.的值
            if($(this).is('span[id^="sqlNoSpan_"]')){
                $(this).text(parseInt(eIdArray[1]) + 1);
            }
            if($(this).is('input[id^="sqlNo_"]')){
                $(this).val(parseInt(eIdArray[1]) + 1);
            }
        });

        //交换动画
        $currentTr.css('visibility','hidden');
        $nextTr.css('visibility','hidden');
        $currentTr.clone()
            .insertAfter($currentTr)
            .css({position:'absolute',visibility:'visible',top:currentTrTop,width:width})
            .animate(	{top:nextTrTop},
                300,
                function(){
                    $(this).remove();
                    $currentTr.insertAfter($nextTr).css('visibility','visible');
                });
        $nextTr.clone()
            .insertAfter($nextTr)
            .css({position:'absolute',visibility:'visible',top:nextTrTop,width:width})
            .animate(	{top:currentTrTop},
                300,
                function(){
                    $(this).remove();
                    $nextTr.insertBefore($currentTr).css('visibility','visible');
                });

        //行交换
        //currentTr.before(nextTr);
    }
};

//邦定事件
SysMigrateModel.prototype.bindTrEvent = function($target){
    var _this = this;

    //邦定添加按钮
    $target.find('a[id^="addModelDetail_"]').off("click").on("click", function (event) {
        _this.addTr(event);
    });

    //邦定删除按钮
    $target.find('a[id^="delModelDetail_"]').off("click").on("click", function (event) {
        _this.delTr(event);
    });

    //邦定向上按钮
    $target.find('a[id^="upModelDetail_"]').off("click").on("click", function (event) {
        _this.upTr(event);
    });

    //邦定向下按钮
    $target.find('a[id^="downModelDetail_"]').off("click").on("click", function (event) {
        _this.downTr(event);
    });

    //sqlscript和dateField的onchange事件
    $target.find('[id^="sqlScript_"],[id^="dateField_"]').off("change").on("change", function (event) {
        _this.validateModelDetailOnChange(event);
    });

    //sqlscript打开框
    $target.find('input[name="sqlScript"]').off("click").on("click", function (event) {
        $(this).blur();
        _this.openSqlScriptDialog(event);

    });


};


//模块详细的数据是否有更改
SysMigrateModel.prototype.isChangeModelData = function(){
    var _this = this;
    //模块数据是否改变
    if(_this.selectedModelData.id != _this.$selectedModel.attr("data-id") ||
        _this.selectedModelData.modelName != _this.$selectedModel.attr("data-name") ||
        _this.selectedModelData.modelType != _this.$selectedModel.attr("data-type")){
        return true;
    }

    //页面数据
    var data = _this.serializeArrayObject(_this.$modelDetailForm);

    //模块详细初始数据
    var　initData = _this.selectedModelDetailData;

    if(data.length == 0 || initData.length == 0){
        return false;
    }else if( initData.length != data.length){
        return true;
    }else{
        for(var i=0;i< data.length; i++) {
            for (var j = 0; j < initData.length; j++) {
                if (data[i].id == initData[j].id) {
                    if (data[i].sqlNo != initData[j].sqlNo ||
                        data[i].sqlScript != initData[j].sqlScript ||
                        data[i].dateField != initData[j].dateField ||
                        data[i].sqlExecType != initData[j].sqlExecType) {
                        return true;
                    }
                }
            }
        }
    }

    return false;
};

//保存
SysMigrateModel.prototype.saveData = function(){
    var _this = this;
    var detailData = _this.serializeArrayObject(_this.$modelDetailForm);

    _this.validateModelDetail(detailData);
    if(!_this.validateModelDetailResult || !_this.validateSqlScriptOnChangeResult || !_this.validateDateFieldOnChangeResult){
        return;
    }

    var modelData = JSON.stringify({
        id:_this.$selectedModel.attr("data-id"),
        modelName:_this.$selectedModel.attr("data-name"),
        modelType:_this.$selectedModel.attr("data-type"),
        lastUpdateDateString:_this.$selectedModel.attr("data-lastupdatedatestring")
    });
    var modelDetailData = JSON.stringify(detailData);

    var promise = $.ajax({
        url: _this.url + "saveMigrateModelData",
        data: {"modelData": modelData, "modelDetailData": modelDetailData},
        type: "post",
        async: false,
        dataType: "json",
        success: function (resp) {
            if (resp.flag == "success" ) {
                if(_this.isNotEmpty(resp.result.updateReuslt) && resp.result.updateReuslt == "-1"){
                    layer.alert('该数据已经被其他程序更新，请刷新后再修改！',{icon:7 ,title: "提示",area: ['400px', '']});
                }else {
                    _this.$selectedModel.attr("data-id", resp.result.id)
                    _this.$selectedModel.attr("data-lastupdatedatestring", resp.result.lastUpdateDateString)
                    _this.selectedModelData = JSON.parse(modelData);
                    _this.selectedModelData.id = resp.result.id;
                    _this.selectedModelDetailData = JSON.parse(modelDetailData);
                    _this.createModelDetail();
                    layer.msg('保存模块数据成功!', {icon: 1 ,title: "提示",area: ['400px', '']});
                }
            }else {
                layer.alert('保存模块数据失败!',{icon:2 ,title: "提示",area: ['400px', '']});
            }
        }
    });

    return promise;

};

//关闭对话框
SysMigrateModel.prototype.closeDialog = function(windowName){
    var index = parent.layer.getFrameIndex(windowName); //先得到当前iframe层的索引
    parent.layer.close(index);
};

//校验模块详细数据
SysMigrateModel.prototype.validateModelDetail = function(data){
    var _this = this;

    //var data = _this.serializeArrayObject(_this.$modelDetailForm);
    var error = "";

    $.each(data, function (idx, elem) {
        //非空判断
        if(!_this.isNotEmpty(elem.sqlScript)){
            error = "请填写SQL脚本!";
            _this.$modelDetailForm.find("#sqlScript_" + (idx+1)).attr("title", error).tooltip("show");
            _this.$modelDetailForm.find("#sqlScript_" + (idx+1)).attr("data-original-title", error).tooltip("show");
            _this.$modelDetailForm.find("#sqlScript_" + (idx+1)).addClass("error");

        }else{
            if(_this.validateSqlScriptOnChangeResult){
                _this.$modelDetailForm.find("#sqlScript_" + (idx+1)).removeClass("error");
                _this.$modelDetailForm.find("#sqlScript_" + (idx+1)).tooltip('destroy');
            }

        }

        if(!_this.isNotEmpty(elem.dateField)){
            error = "请填写时间字段!";
            _this.$modelDetailForm.find("#dateField_" + (idx+1)).attr("title", error).tooltip("show");
            _this.$modelDetailForm.find("#dateField_" + (idx+1)).attr("data-original-title", error).tooltip("show");
            _this.$modelDetailForm.find("#dateField_" + (idx+1)).addClass("error");
        }else{
            if(_this.validateDateFieldOnChangeResult) {
                _this.$modelDetailForm.find("#dateField_" + (idx + 1)).removeClass("error");
                _this.$modelDetailForm.find("#dateField_" + (idx + 1)).tooltip('destroy');
            }
        }

    });

    if(_this.isNotEmpty(error)){
        _this.validateModelDetailResult = false;
    }else{
        _this.validateModelDetailResult = true;
    }
};

//SQL脚本是否合法
SysMigrateModel.prototype.validateModelDetailOnChange = function(event){
    var _this = this;
    var $elem = $(event.target);
    var elemValue = $elem.val();
    var error = "";

    if(_this.isNotEmpty(elemValue)){

        if($elem.attr("name") == "sqlScript"){
            //SQL脚本是否合法
            $.ajax({
                url: _this.url + "checkSqlScript",
                data: {"sqlScript": elemValue},
                type: "post",
                async: false,
                dataType: "json",
                success: function (resp) {
                    if(resp.result == "1"){
                        error = "请输入SELECT语句!";
                        $elem.attr("title", error).tooltip("show");
                        $elem.attr("data-original-title", error).tooltip("show");
                        $elem.addClass("error");
                        _this.validateSqlScriptOnChangeResult = false;
                    }else if(resp.result == "2"){
                        error = "脚本有误!";
                        $elem.attr("title", error).tooltip("show");
                        $elem.attr("data-original-title", error).tooltip("show");
                        $elem.addClass("error");
                        _this.validateSqlScriptOnChangeResult = false;
                    }else{
                        $elem.attr("title", "");
                        $elem.attr("data-original-title", "");
                        $elem.removeClass("error");
                        $elem.tooltip('destroy');
                        _this.validateSqlScriptOnChangeResult = true;
                    }
                }
            });
        }

        if($elem.attr("name") == "dateField"){
            if(!/^[A-Za-z_]{1}[A-Za-z0-9_]*\.[A-Za-z_]{1}[A-Za-z0-9_]*$/.test(elemValue)){
                error = "时间字段格式[TABLE.DATE]不正确!";
                $elem.attr("title", error).tooltip("show");
                $elem.attr("data-original-title", error).tooltip("show");
                $elem.addClass("error");
                _this.validateDateFieldOnChangeResult = false;

            }else{
                //SQL脚本是否合法
                $.ajax({
                    url: _this.url + "checkDateField",
                    data: {"dateField": elemValue},
                    type: "post",
                    async: false,
                    dataType: "json",
                    success: function (resp) {
                        if (resp.result !== "true") {
                            error = "时间字段在数据库中不存在!";
                            $elem.attr("title", error).tooltip("show");
                            $elem.attr("data-original-title", error).tooltip("show");
                            $elem.addClass("error");
                            _this.validateDateFieldOnChangeResult = false;
                        } else {
                            var sqlScriptValue = $elem.closest("tr").find("input[name='sqlScript']").val().toUpperCase();
                            var tableName = $elem.val().split(".")[0].toUpperCase();
                            if(_this.isNotEmpty(sqlScriptValue) && sqlScriptValue.indexOf(tableName) == -1){
                                error = "时间字段的表名在SQL脚本中不存在!";
                                $elem.attr("title", error).tooltip("show");
                                $elem.attr("data-original-title", error).tooltip("show");
                                $elem.addClass("error");
                                _this.validateDateFieldOnChangeResult = false;

                            }else{
                                $elem.attr("title", "");
                                $elem.attr("data-original-title", "");
                                $elem.removeClass("error");
                                $elem.tooltip('destroy');
                                _this.validateDateFieldOnChangeResult = true;
                            }
                        }
                    }
                });
            }

        }

    }
};

//SQL脚本
SysMigrateModel.prototype.openSqlScriptDialog = function (event){
    var _this = this;
    var $sqlScriptInput = $(event.target);

    layer.open({
        type: 2,
        area: ['700px', '400px'],
        title: 'SQL脚本',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, // 开启最大化最小化按钮
        content: "avicit/platform6/migrate/migratemodel/SysMigrateModelSqlScriptDialog.jsp",
        success: function (layero, index) {
            var $childrenBody = layer.getChildFrame('body', index);//建立父子联系
            var $sqlScript = $childrenBody.find("#sqlScript");

            $sqlScript.val($sqlScriptInput.val());
        },
        btn: ['确认', '取消'],
        yes: function (index, layero) {
            var $childrenBody = layer.getChildFrame('body', index);//建立父子联系
            var $sqlScript = $childrenBody.find("#sqlScript");
            //赋值
            $sqlScriptInput.val($sqlScript.val().replace(/\r\n/g, " ").replace(/\n/g, " "));
            $sqlScriptInput.change();
            layer.close(index);
        },
        btn2: function (index, layero) {
            layer.close(index);
        }
    });

};


//取得form数据
SysMigrateModel.prototype.serializeArrayObject = function ($form){
    var r = [];
    var o = {};
    var a = $form.serializeArray();
    if(a.length == 0){
        return r;
    }else{
        $.each(a, function() {

            if (o[this.name] !== undefined) {
                r.push(o);
                o = {};
                o[this.name] = this.value || '';
            } else {
                o[this.name] = this.value || '';
            }
        });
        r.push(o);
        return r;
    }
};

//计算字符串长度(英文占1个字符，中文汉字占2个字符)
String.prototype.gblen = function() {
    var len = 0;
    for (var i=0; i<this.length; i++) {
        if (this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {
            len += 2;
        } else {
            len ++;
        }
    }
    return len;
};

