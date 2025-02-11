/**
 * 单表附件
 * @param Jqgrid
 * @param url
 * @param searchDialogId
 * @param form
 * @param keyWordId
 * @param searchNames
 * @param dataGridColModel
 */

//日期转换函数
function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();
    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    return [year, month, day].join('-');
}

function AssetsLabAccount(datagrid, url, searchDialogId, form, keyWordId, searchNames, dataGridColModel) {
    if (!datagrid || typeof(datagrid) !== 'string' && datagrid.trim() !== '') {
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
    this._searchDialogId = "#" + searchDialogId;
    this._keyWordId = "#" + keyWordId;
    this._searchNames = searchNames;
    this.dataGridColModel = dataGridColModel;
    this.init.call(this);
};
/**
 * 初始化操作
 * 回车查询
 */
AssetsLabAccount.prototype.init = function () {
    var _self = this;
    $(_self._datagridId).jqGrid({
        url: _self.getUrl() + 'getAssetsLabAccountsByPage.json',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true, 'top'],
        colModel: _self.dataGridColModel,
        height: $(window).height()*2/5,
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
        viewrecords: true,
        styleUI: 'Bootstrap',
        multiselect: true,
        multiboxonly: true,
        autowidth: true,
        shrinkToFit: true,
        responsive: true,//开启自适应
        pager: "#jqGridPager"
    });
    $(_self._jqgridToolbar).append($("#tableToolbar"));

    $('.date-picker').datepicker({
        beforeShow: function () {
            setTimeout(function () {
                $('#ui-datepicker-div').css("z-index", 99999999);
            }, 100);
        }
    });
    $('.time-picker').datetimepicker({
        oneLine: true,//单行显示时分秒
        showButtonPanel: true,//是否展示功能按钮面板
        closeText: '确定',
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
    //form回车事件
    $(_self._formId).find('input').bind('keyup', function (e) {
        if (e.keyCode == 13) {
            _self.searchData();
        }
    });
    $('.dropdown-menu').click(function (e) {
        e.stopPropagation();
    });


    //单击延时触发
    var clickTimeId;
    //给列表行绑定单击事件
    var _self = this;
    var tableList = document.getElementById('assetsLabAccountjqGrid');
    tableList.onclick = function (event) {
        var rowId = event.target.parentNode.id;
        // 取消上次延时未执行的方法
        clearTimeout(clickTimeId);
        //执行延时
        clickTimeId = setTimeout(rowClick(rowId, _self), 250);
    }
    tableList.ondblclick = function (event) {
        // 取消上次延时未执行的方法
        clearTimeout(clickTimeId);
        var rowId = event.target.parentNode.id;
        assetsLabAccount.detail(rowId);
    }

    setTimeout(function () {
        if ($("#assetsLabAccountjqGrid").find("tr").get(1) != undefined) {
            var firstRowId = $("#assetsLabAccountjqGrid").find("tr").get(1).id;
            document.getElementById(firstRowId).click();//选中当前行
            rowClick(firstRowId, _self);
        }
    }, 500);

};

/**
 * 单击方法
 */
function rowClick(rowId, _self) {
    if (rowId != "") {
        avicAjax.ajax({
            url: _self.getUrl() + 'getLabAccountDetail',
            type: 'POST',
            async: true,
            dataType: 'json',
            data: JSON.stringify({"id": rowId}),
            contentType: "application/json",
            success: function (assetsLabAccountDTOMap) {
                //成功回调
                var labId = assetsLabAccountDTOMap["assetsLabAccountDTO"].id;
                var labName = assetsLabAccountDTOMap["assetsLabAccountDTO"].labName;
                /**
                 * 实验室筛选条件
                 * 以session存储分类数据
                 */
                var labDeviceData;
                labDeviceData = JSON.stringify({labId:labId, labName:labName});
                sessionStorage.setItem("labDeviceData",labDeviceData);//以session存储id数据

                document.getElementById('labDeviceIframe').contentWindow.location.reload(true);
            }
        });
    }
}

/**
 * 添加页面
 */
AssetsLabAccount.prototype.insert = function () {
    this.insertIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '添加',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl() + 'Add/null'
    });
};
/**
 * 编辑页面
 */
AssetsLabAccount.prototype.modify = function () {
    var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    if (ids.length == 0) {
        layer.alert('请选择要编辑的数据！', {
                icon: 7,
                area: ['400px', ''],
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
        return false;
    } else if (ids.length > 1) {
        layer.alert('只允许选择一条数据！', {
                icon: 7,
                area: ['400px', ''],
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
        return false;
    }
    var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
    this.editIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '编辑',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl() + 'Edit/' + rowData.id
    });
};
/**
 * 详情页面
 */
AssetsLabAccount.prototype.detail = function (id) {
    this.detailIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '详细',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl() + 'Detail/' + id
    });
};
/**
 * 校验方法
 */
AssetsLabAccount.prototype.formValidate = function (form) {
    var _self = this;
    form.validate({
        rules: {
            labName: {
                required: true,
                maxlength: 100
            },
            labNameShort: {
                maxlength: 100
            },
            labNum: {
                maxlength: 50
            },
            unifiedId: {
                maxlength: 50
            },
            assetId: {
                maxlength: 50
            },
            majorCategory: {
                maxlength: 10
            },
            labPosition: {
                maxlength: 50
            },
            labDeviceCount: {
                number: true
            },
            labInfo: {
                maxlength: 4000
            },
            manageDept: {
                maxlength: 50
            },
            managerId: {
                maxlength: 50
            },
            createdDate: {
                dateISO: true
            },
        }
    });
}
/**
 * 保存方法
 */
AssetsLabAccount.prototype.save = function (form, callback) {
    var _self = this;
    avicAjax.ajax({
        url: _self.getUrl() + "save",
        data: {data: JSON.stringify(serializeObject(form))},
        type: 'post',
        dataType: 'json',
        success: function (r) {
            if (r.flag == "success") {
                _self.reLoad();
                if (typeof(callback) == "function") {
                    callback(r.id);
                }
                layer.msg('保存成功！');
            } else {
                layer.alert('保存失败,请联系管理员!', {
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
};
/**
 * 删除方法
 */
AssetsLabAccount.prototype.del = function () {
    var _self = this;
    var rows = $(_self._datagridId).jqGrid('getGridParam', 'selarrrow');
    var ids = [];
    var l = rows.length;
    if (l > 0) {
        layer.confirm('确认要删除选中的数据吗?', {icon: 3, title: "提示", area: ['400px', '']}, function (index) {
            for (; l--;) {
                ids.push(rows[l]);
            }
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
AssetsLabAccount.prototype.reLoad = function () {
    var searchdata = {
        keyWord: null,
        param: JSON.stringify(serializeObject($(this._formId)))
    }
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关闭对话框
 */
AssetsLabAccount.prototype.closeDialog = function (id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.editIndex);
    }
};

/**
 * 打开高级查询
 */
AssetsLabAccount.prototype.openSearchForm = function (searchDiv) {
    var _self = this;
    var _resizeFunc;

    var contentWidth = 800;//查询弹窗宽度
    var _top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
    var _left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
    var _text = $(searchDiv).text();
    var _width = $(searchDiv).innerWidth();
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
        offset: [_top + 'px', _left + 'px'],
        closeBtn: 0,
        shadeClose: true,
        btn: ['查询', '清空', '取消'],
        content: $(_self._searchDialogId),
        success: function (layero, index) {
            var serachLabel = $('<div class="serachLabel"><span>' + _text + '</span><span class="caret"></span></div>').appendTo(layero);
            serachLabel.bind('click', function () {
                layer.close(index);
            });
            serachLabel.css('width', _width + 'px');
        },
        yes: function (index, layero) {
            _self.searchData();
            layer.close(index);
        },
        btn2: function (index, layero) {
            clearFormData(_self._formId);
            _self.searchData();
            return false;
        },
        btn3: function (index, layero) {

        }
    });
};
/**
 * 后台查询方法
 */
AssetsLabAccount.prototype.searchData = function () {
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
AssetsLabAccount.prototype.searchByKeyWord = function () {
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
