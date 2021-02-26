/**
 * 单表
 * @param datagrid
 * @param url
 * @param searchD
 * @param form
 * @param keyWordId
 * @param searchNames
 * @param dataGridColModel
 */
function AssetsTechTransformDevice(datagrid, url, searchD, form, keyWordId, searchNames, dataGridColModel) {
    if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = url;
    this.getUrl = function () {
        return _url;
    }
    this._datagridId = "#" + datagrid;
    this._jqgridToolbar = "#t_" + datagrid;
    this._doc = document;
    this._formId = "#" + form;
    this._searchDialogId = "#" + searchD;
    this._keyWordId = "#" + keyWordId;
    this._searchNames = searchNames;
    this.dataGridColModel = dataGridColModel;
    this.init.call(this);
};

/**
 * 初始化操作
 */
AssetsTechTransformDevice.prototype.init = function () {
    var _self = this;
    $(_self._datagridId).jqGrid({
        url: _self.getUrl() + 'getAssetsTechTransformDevices.json',
        mtype: 'POST',
        datatype: "json",
        treeGrid: true,
        treeGridModel: "adjacency",
        ExpandColumn: "pointNo",//展开的列
        toolbar: [true, 'top'],
        colModel: _self.dataGridColModel,
        treeReader:{
            level_field: "pointLevel",
            parent_id_field: "parentId",
            leaf_field: "isLeaf"
        },
        height: $(window).height() - 120,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20,
        rowList: [200, 100, 50, 30, 20, 10],
        altRows: true,
        userDataOnFooter: true,
        pagerpos: 'left',
        hasColSet: false,//设置显隐属性
        loadComplete: function () {
            $(this).jqGrid('getColumnByUserIdAndTableName');
        },
        styleUI: 'Bootstrap',
        viewrecords: true,
        multiselect: true,
        autowidth: true,
        shrinkToFit: true,
        responsive: true//开启自适应
    });
    $(_self._jqgridToolbar).append($("#tableToolbarDevice"));

    $('.date-picker').datepicker({
        beforeShow: function () {
            setTimeout(function () {
                $('#ui-datepicker-div').css("z-index", 99999999);
            }, 100);
        }
    });
    $('.time-picker').datetimepicker({
        oneLine: true,//单行显示时分秒
        closeText: '确定',//关闭按钮文案
        showButtonPanel: true,//是否展示功能按钮面板
        showSecond: false,//是否可以选择秒，默认否
        beforeShow: function (selectedDate) {
            if ($('#' + selectedDate.id).val() == "") {
                $(this).datetimepicker("setDate", new Date());
                $('#' + selectedDate.id).val('');
            }
            setTimeout(function () {
                $('#ui-datepicker-div').css("z-index", 99999999);
            }, 100);
        }
    });
    //禁止时间和日期格式手输
    $('.date-picker').on('keydown', nullInput);
    $('.time-picker').on('keydown', nullInput);
    //回车查询
    $(_self._keyWordId).on('keydown', function (e) {
        if (e.keyCode == '13') {
            _self.searchByKeyWord();
        }
    });
};

/**
 * 添加页面
 */
AssetsTechTransformDevice.prototype.insert = function (projectId, parentId) {
    if(parentId == undefined || parentId == null || parentId == ''){
        parentId = 'null';
    }
    this.insertIndex = layer.open({
        type: 2,
        area: ['60%', '450px'],
        title: '添加项目设备',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl() + 'Add/' + projectId + '/' + parentId + '/null'
    });
};

/**
 * 编辑页面
 */
AssetsTechTransformDevice.prototype.modify = function (deviceId) {
    this.editIndex = layer.open({
        type: 2,
        area: ['60%', '450px'],
        title: '编辑',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl() + 'Edit/null/null/' + deviceId
    });
};

/**
 * 详情页面
 */
AssetsTechTransformDevice.prototype.detail = function (id) {
    this.detailIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '详细页',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl() + 'Detail/' + id
    });
};

/**
 * 打开高级查询框
 */
AssetsTechTransformDevice.prototype.openSearchForm = function (searchDiv) {
    var _self = this;
    var contentWidth = 800;
    var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
    var left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
    var text = $(searchDiv).text();
    var width = $(searchDiv).innerWidth();

    layer.config({
        extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
    });

    layer.open({
        type: 1,
        shift: 5,
        title: false,
        scrollbar: false,
        move: false,
        area: [contentWidth + 'px', '400px'],
        offset: [top + 'px', left + 'px'],
        closeBtn: 0,
        shadeClose: true,
        btn: ['查询', '清空', '取消'],
        content: $(_self._searchDialogId),
        success: function (layero, index) {
            var serachLabel = $('<div class="serachLabel"><span>' + text + '</span><span class="caret"></span></div>').appendTo(layero);
            serachLabel.bind('click', function () {
                layer.close(index);
            });
            serachLabel.css('width', width + 'px');
        },
        yes: function (index, layero) {
            _self.searchData();
            layer.close(index);//查询框关闭
        },
        btn2: function (index, layero) {
            _self.clearData();
            return false;
        },
        btn3: function (index, layero) {

        }
    });
};

/**
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
AssetsTechTransformDevice.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            projectId: {
                maxlength: 100
            },
            deviceName: {
                maxlength: 50
            },
            isEntity: {
                maxlength: 10
            },
            technicalRequirement: {
                maxlength: 255
            },
            nation: {
                maxlength: 50
            },
            singleOrSet: {
                maxlength: 10
            },
            unitPrice: {
                number: true
            },
            amount: {
                number: true
            },
            total: {
                number: true
            },
            foreignExchange: {
                number: true
            },
            biddingSituation: {
                maxlength: 50
            },
            remarks: {
                maxlength: 1024
            },
            parentId: {
                maxlength: 100
            },
            pointNo: {
                maxlength: 10
            },
            treePath: {
                maxlength: 255
            },
            pointLevel: {
                number: true
            },
            isLeaf: {
                maxlength: 10
            },
            deviceSn: {
                number: true
            },
        }
    });
}

/**
 * 保存方法
 */
AssetsTechTransformDevice.prototype.save = function (form, id) {
    var _self = this;
    avicAjax.ajax({
        url: _self.getUrl() + "save",
        data: {data: JSON.stringify(serializeObject(form))},
        type: 'post',
        dataType: 'json',
        success: function (r) {
            if (r.flag == "success") {
                _self.reLoad();
                if (id == "insert") {
                    layer.close(_self.insertIndex);
                } else {
                    layer.close(_self.editIndex);
                }
                layer.msg('保存成功！');
            } else {
                layer.alert('保存失败,请联系管理员!', {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0,
                        btn: ['关闭'],
                        title: "提示"
                    }
                );
            }
        }
    });
};

/**
 * 删除方法
 */
AssetsTechTransformDevice.prototype.del = function () {
    var _self = this;
    var deviceId = $("#assetsTechTransformDevicejqGrid").jqGrid("getGridParam","selrow");
    var ids = [];

    if (deviceId != null && deviceId != undefined) {
        layer.confirm('确认要删除选中的数据吗?', {icon: 3, title: "提示", area: ['400px', '']}, function (index) {
            ids.push(deviceId);

            avicAjax.ajax({
                url: _self.getUrl() + 'delete',
                data: JSON.stringify(ids),
                contentType: 'application/json',
                type: 'post',
                dataType: 'json',
                success: function (r) {
                    if (r.flag == "success") {
                        _self.reLoad();
                    } else {
                        layer.alert('删除失败:' + r.message, {
                                icon: 7,
                                area: ['400px', ''],
                                closeBtn: 0,
                                btn: ['关闭'],
                                title: "提示"
                            }
                        );
                    }
                }
            });
            layer.close(index);
        });
    } else {
        layer.alert('请选择要删除的数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
    }
};

/**
 * 重载数据
 */
AssetsTechTransformDevice.prototype.reLoad = function () {
    var searchdata = {param: JSON.stringify(serializeObject($(this._formId)))}
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};

/**
 * 关闭对话框
 */
AssetsTechTransformDevice.prototype.closeDialog = function (id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.editIndex);
    }
};

/**
 * 后台查询
 */
AssetsTechTransformDevice.prototype.searchData = function () {
    var datebox = $('.date-picker,.time-picker');
    var data = [];
    $.each(datebox, function (i, item) {
        data[i] = $(item).val();
    });
    for (var i = 0; i < (data.length / 2); i++) {
        if (data[2 * i] == "" || data[2 * i + 1] == "" || data[2 * i] == null || data[2 * i + 1] == null) {
            continue;
        }
        if (data[2 * i] > data[2 * i + 1]) {
            layer.alert("查询时,结束日期不能小于起始日期 ！", {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            });
            return;
        }
    }
    var searchdata = {
        keyWord: null,
        param: JSON.stringify(serializeObject($(this._formId)))
    }
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};

/**
 * 关键字段查询
 */
AssetsTechTransformDevice.prototype.searchByKeyWord = function () {
    var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr("placeholder") ? "" : $(this._keyWordId).val();
    var names = this._searchNames;

    var param = {};
    for (var i in names) {
        var name = names[i];
        param[name] = keyWord;
    }
    var searchdata = {
        keyWord: JSON.stringify(param),
        param: null
    }
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
}

/**
 * 隐藏查询框
 */
AssetsTechTransformDevice.prototype.hideSearchForm = function () {
    layer.close(searchDialogindex);
};

/**
 * 清空查询条件
 */
AssetsTechTransformDevice.prototype.clearData = function () {
    clearFormData(this._formId);
    this.searchData();
};
