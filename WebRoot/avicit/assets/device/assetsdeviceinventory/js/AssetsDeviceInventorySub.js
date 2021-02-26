function AssetsDeviceInventorySub(datagrid, url, formSub, dataGridColModel, searchDialogSub, pid, searchSubNames, demoSubUser_KeyWord, isReload) {
    if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = url;
    this.getUrl = function () {
        return _url;
    }
    this._searchDialogId = "#" + searchDialogSub;
    this.searchForm = "#" + formSub;
    this.pid = pid;
    this._datagridId = "#" + datagrid;
    this.Toolbardiv = "#t_" + datagrid;
    this.Toolbar = "#toolbar_" + datagrid;
    this.Pagerlbar = "#" + datagrid + "Pager";
    this._keyWordId = "#" + demoSubUser_KeyWord;
    this._searchNames = searchSubNames;
    this.dataGridColModel = dataGridColModel;
    this.isReload = isReload;
    this.notnullFiled = [];//非空字段
    this.notnullFiledComment = []; //非空字段注释
    //除时间,数字等类型长度校验字段
    this.lengthValidFiled = [];
    //除时间,数字等类型长度校验字段注释
    this.lengthValidFiledComment = [];
    //除时间,数字等类型长度
    this.lengthValidFiledSize = [];
    this.init.call(this);
};
/**
 * 初始化操作
 */
AssetsDeviceInventorySub.prototype.init = function (pid) {
    var _self = this;
    if (_self.isReload == "true") {
        $(_self._datagridId).jqGrid({
            url: _self.getUrl(),
            postData: {pid: _self.pid},
            mtype: 'POST',
            datatype: "json",
            toolbar: [true, 'top'],
            colModel: assetsDeviceInventorySubGridColModel,
            height: 400,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
            scrollOffset: 10, //设置垂直滚动条宽度
            rowNum: 20,
            rowList: [200, 100, 50, 30, 20, 10],
            altRows: true,
            pagerpos: 'left',
            hasColSet: true,//设置显隐属性
            styleUI: 'Bootstrap',
            viewrecords: true, //
            multiselect: true,
            width: document.body.clientWidth,
            autowidth: false,
            shrinkToFit: true,
            responsive: true,//开启自适应
            cellEdit: true,
            cellsubmit: 'clientArray',
            pager: _self.Pagerlbar
        });
    } else if (_self.isReload == "edit") {
        $(_self._datagridId).jqGrid({
            url: _self.getUrl() + 'getAssetsDeviceInventorySub',
            postData: {pid: _self.pid},
            mtype: 'POST',
            datatype: "json",
            toolbar: [true, 'top'],
            colModel: assetsDeviceInventorySubGridColModel,
            height: 400,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
            scrollOffset: 10, //设置垂直滚动条宽度
            altRows: true,
            pagerpos: 'left',
            hasColSet: false,//设置显隐属性
            styleUI: 'Bootstrap',
            viewrecords: true, //
            multiselect: true,
            autowidth: true,
            shrinkToFit: true,
            responsive: true,//开启自适应
            cellEdit: true,
            cellsubmit: 'clientArray',
            pager: _self.Pagerlbar
        });
    } else {
        $(_self._datagridId).jqGrid({
            url: _self.getUrl() + 'getAssetsDeviceInventorySub',
            postData: {pid: _self.pid},
            mtype: 'POST',
            datatype: "json",
            toolbar: [true, 'top'],
            colModel: _self.dataGridColModel,
            height: $(window).height() - 410,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
            scrollOffset: 10, //设置垂直滚动条宽度
            rowNum: 20,
            rowList: [200, 100, 50, 30, 20, 10],
            altRows: true,
            pagerpos: 'left',
            hasColSet: false,//设置显隐属性
            loadComplete: function () {
                $(this).jqGrid('getColumnByUserIdAndTableName');
            },
            styleUI: 'Bootstrap',
            viewrecords: true, //
            multiselect: true,
            autowidth: true,
            shrinkToFit: true,
            responsive: true,//开启自适应
            pager: _self.Pagerlbar

        });

        $(_self.Toolbardiv).append($(_self.Toolbar));
    }

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
    $(_self._keyWordId).on('keydown', function (e) {
        if (e.keyCode == '13') {
            _self.searchByKeyWord();
        }
    });
//禁止时间和日期格式手输
    $('.date-picker').on('keydown', nullInput);
    $('.time-picker').on('keydown', nullInput);

    //初始化校验字段
    _self.notnullFiled.push("parentId");
    _self.notnullFiledComment.push("父表ID");
    _self.lengthValidFiled.push("parentId");
    _self.lengthValidFiledSize.push(100);
    _self.lengthValidFiledComment.push("父表ID");
    _self.lengthValidFiled.push("unifiedId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("统一编号");
    _self.lengthValidFiled.push("deviceId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("设备ID");
    _self.lengthValidFiled.push("assetId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("资产编号");
    _self.lengthValidFiled.push("deviceName");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("设备名称");
    _self.lengthValidFiled.push("deviceModel");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("设备型号");
    _self.lengthValidFiled.push("deviceSpec");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("设备规格");
    _self.lengthValidFiled.push("ownerId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("责任人");
    _self.lengthValidFiled.push("ownerDept");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("责任人部门");
    _self.lengthValidFiled.push("manufacturerId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("生产厂家");
    _self.lengthValidFiled.push("supplier");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("供应商");
    _self.lengthValidFiled.push("positionId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("安装地点ID");
    _self.lengthValidFiled.push("deviceState");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("设备状态");
    _self.lengthValidFiled.push("inventoryPerson");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("盘点人");
    _self.lengthValidFiled.push("inventoryDept");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("盘点人部门");
    _self.lengthValidFiled.push("remarks");
    _self.lengthValidFiledSize.push(1024);
    _self.lengthValidFiledComment.push("备注");
    _self.lengthValidFiled.push("flag");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("标志位");
    _self.lengthValidFiled.push("inventoryState");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("盘点状态");
    _self.lengthValidFiled.push("inventoryResult");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("盘点结果");

};
/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
AssetsDeviceInventorySub.prototype.insert = function () {
    var _self = this;
    $(_self._datagridId).jqGrid('endEditCell');
    var hasvalidate = true;
    var data = $(_self._datagridId).jqGrid('getRowData');
    if (data.length > 0 && _self.notnullFiled.length > 0) {
        $.each(_self.notnullFiled, function (i, item) {
            var msg = _self.nullvalid(data, item, _self.notnullFiled, _self.notnullFiledComment);
            if (msg && msg.length > 0) {
                layer.alert(msg, {
                    icon: 7,
                    area: ['400px', ''], // 宽高
                    closeBtn: 0,
                    btn: ['关闭'],
                    title: "提示"
                });
                hasvalidate = false;
                return false;
            }
        });
    }
    if (!hasvalidate) {
        return false;
    }

    var newRowId = newRowStart + newRowIndex;
    var parameters = {
        rowID: newRowId,
        initdata: {},
        position: "first",
        useDefValues: true,
        useFormatter: true,
        addRowParams: {extraparam: {}}
    };
    $(_self._datagridId).jqGrid('addRow', parameters);
    newRowIndex++;
};

/**
 * 非空验证
 * @param
 * @param
 */
AssetsDeviceInventorySub.prototype.nullvalid = function (data, item, nullfiled, notnullFiledComment) {
    var msg = "";
    $.each(data, function (i, dataitem) {
        if (dataitem[item] == "") {
            temp = false;
            msg = notnullFiledComment[$.inArray(item, nullfiled)] + "为必填字段";
        }
    })
    return msg;
}
/**
 * 长度验证
 * @param
 * @param
 */
AssetsDeviceInventorySub.prototype.lengthvalid = function (data, item, lengthValidFiled, lengthValidFiledComment, lengthValidFiledSize) {
    var msg = "";
    $.each(data, function (i, dataitem) {
        if (dataitem[item] != "" && dataitem[item] != undefined && dataitem[item].replace(/[^\x00-\xff]/g, "**").length > lengthValidFiledSize[$.inArray(item, lengthValidFiled)]) {
            msg = lengthValidFiledComment[$.inArray(item, lengthValidFiled)] + "的输入长度超过预设长度" + lengthValidFiledSize[$.inArray(item, lengthValidFiled)];
        }
    })
    return msg;
}

/*
 * 长度和非空校验
 */
AssetsDeviceInventorySub.prototype.valid = function () {
    var _self = this;
    $(_self._datagridId).jqGrid('endEditCell');
    var isAddRow = false; //是新增行
    var data = $(_self._datagridId).jqGrid('getChangedCells');
    var Rowdata = $(_self._datagridId).jqGrid('getRowData');
    if (Rowdata.length > 0) {
        for (var i = 0; i < Rowdata.length; i++) {
            if (Rowdata[i].id == "") {
                // isAddRow = true;
            }
        }
    }
    var hasvalidate = true;
    var msg = "";
    if (data.length == 0 && isAddRow) {
        msg = "请修改子表数据";
    } else {
        $.each(_self.notnullFiled, function (i, item) {
            msg = _self.nullvalid(Rowdata, item, _self.notnullFiled, _self.notnullFiledComment);
            if (msg && msg.length > 0) {
                hasvalidate = false;
                return false;
            }
        });
        $.each(_self.lengthValidFiled, function (i, item) {
            if (hasvalidate) {
                msg = _self.lengthvalid(Rowdata, item, _self.lengthValidFiled, _self.lengthValidFiledComment, _self.lengthValidFiledSize);
                if (msg && msg.length > 0) {
                    hasvalidate = false;
                    return false;
                }
            }
        });
    }
    return msg;
};

/**
 * 保存功能
 * @param pid
 */
AssetsDeviceInventorySub.prototype.save = function (pid) {
    var _self = this;
    _self.pid = pid;
    $(_self._datagridId).jqGrid('endEditCell');
    var data = $(_self._datagridId).jqGrid('getRowData');
    if (data && data.length > 0) {
        avicAjax.ajax({
            url: _self.getUrl() + "save",
            data: {
                data: JSON.stringify(data),
                pid: pid
            },
            type: 'post',
            dataType: 'json',
            success: function (r) {
                if (r.flag == "success") {
                    _self.reLoad();
                    if (typeof (closeForm) != "undefined") {
                        closeForm();
                    }
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
    } else {
        //关闭弹窗
        if (typeof (closeForm) != "undefined") {
            closeForm();
        }
    }
};
/**
 * 删除
 */
AssetsDeviceInventorySub.prototype.del = function () {
    var _self = this;
    //删除之前结束单元格
    $(_self._datagridId).jqGrid('endEditCell');
    var rows = $(_self._datagridId).jqGrid('getGridParam', 'selarrrow');
    var isAddRow = false; //是新增行
    var notAddRow = false; //不是新增行
    var ids = [];
    var l = rows.length;
    if (l > 0) {
        for (var i = 0; i < l; i++) {
            if (rows[i].indexOf("new_row") != -1) {
                isAddRow = true;
            } else {
                notAddRow = true;
            }
            ids.push(rows[i]);
        }
    }
    if (isAddRow && notAddRow) {
        layer.alert('请确保上一条数据修改完毕！', {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            title: '提示'
        });
        return false;
    } else if (isAddRow && !notAddRow) {
        for (var i = 0; i < ids.length; i++) {
            $(_self._datagridId).jqGrid('delRowData', ids[i]);
        }
        $('#cb_assetsDeviceInventorySub').click();
        return false;
    }
    if (l > 0) {
        layer.confirm('确认要删除选中的数据吗?', {icon: 3, title: "提示", area: ['400px', '']}, function (index) {
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
                        layer.alert('删除失败,请联系管理员!', {
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
AssetsDeviceInventorySub.prototype.reLoad = function (pid) {
    if (pid != undefined) {
        this.pid = pid;
    }
    pid = this.pid;
    var searchdata = {pid: pid};
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};
/**
 * 获取子表数据
 */
AssetsDeviceInventorySub.prototype.getSubData = function () {
    var _self = this;
    $(_self._datagridId).jqGrid('endEditCell');
    var data = $(_self._datagridId).jqGrid('getRowData');
    return JSON.stringify(data);
};
/**
 * 关闭对话框
 */
AssetsDeviceInventorySub.prototype.closeDialog = function (id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.editIndex);
    }
};
/**
 * 打开高级查询框
 */
AssetsDeviceInventorySub.prototype.openSearchForm = function (searchDiv, par) {
    var _self = this;
    par = null;
    //if(!par) par = $(window);
    var contentWidth = 600; //(par.width()*.6 >= 600)?600:par.width()*.6;
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
            layer.close(index);
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
 * 高级查询
 */
AssetsDeviceInventorySub.prototype.searchData = function () {
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
        pid: this.pid,
        param: JSON.stringify(serializeObject($(this.searchForm)))
    };
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关键字段查询
 */
AssetsDeviceInventorySub.prototype.searchByKeyWord = function () {
    var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr("placeholder") ? "" : $(this._keyWordId).val();
    var names = this._searchNames;

    var param = {};
    for (var i in names) {
        var name = names[i];
        param[name] = keyWord;
    }

    var searchdata = {
        keyWord: JSON.stringify(param),
        pid: this.pid,
        param: null
    };
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};
/**
 * 隐藏查询框
 */
AssetsDeviceInventorySub.prototype.hideSearchForm = function () {
    layer.close(searchDialogindex);
};
/**
 * 清空查询条件
 */
AssetsDeviceInventorySub.prototype.clearData = function () {
    clearFormData(this.searchForm);
    this.searchData();
};

