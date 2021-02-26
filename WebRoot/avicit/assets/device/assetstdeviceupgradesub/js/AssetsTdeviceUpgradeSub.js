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
function AssetsTdeviceUpgradeSub(datagrid, url, searchDialogId, form, keyWordId, searchNames, dataGridColModel) {
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
AssetsTdeviceUpgradeSub.prototype.init = function () {
    var _self = this;
    $(_self._datagridId).jqGrid({
        url: _self.getUrl() + 'getAssetsTdeviceUpgradeSubsByPage.json',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true, 'top'],
        colModel: _self.dataGridColModel,
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
        viewrecords: true,
        styleUI: 'Bootstrap',
        multiselect: true,
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
};
/**
 * 添加页面
 */
AssetsTdeviceUpgradeSub.prototype.insert = function () {
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
function modify() {
    var ids = $('#ASSETS_TDEVICE_UPGRADE_SUB').jqGrid('getGridParam', 'selarrrow');
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
        content: 'platform/assets/device/assetstdeviceupgradesub/assetsTdeviceUpgradeSubController/operation/' + 'Edit/' + ids[0]
    });
};
/**
 * 详情页面
 */
AssetsTdeviceUpgradeSub.prototype.detail = function (id) {
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
AssetsTdeviceUpgradeSub.prototype.formValidate = function (form) {
    var _self = this;
    form.validate({
        rules: {
            unifiedId: {
                required: true,
                maxlength: 50
            },
            deviceName: {
                required: true,
                maxlength: 50
            },
            softwareName: {
                required: true,
                maxlength: 50
            },
            softwareBasicName: {
                maxlength: 50
            },
            softwareId: {
                maxlength: 50
            },
            softwareCode: {
                maxlength: 50
            },
            softwareVersion: {
                maxlength: 50
            },
            softwareVersionNew: {
                maxlength: 50
            },
            softwareReleaseNum: {
                maxlength: 50
            },
            softwarePeriod: {
                maxlength: 50
            },
            softwareCodeSize: {
                number: true
            },
            softwareLeader: {
                maxlength: 50
            },
            softwareLanguage: {
                maxlength: 50
            },
            softwareRunEnvironment: {
                maxlength: 50
            },
            softwareDevEnvironment: {
                maxlength: 50
            },
            remarks: {
                maxlength: 50
            },
            tdeviceForeign: {
                maxlength: 50
            },
            tdeviceSoftwareId: {
                required: true,
                maxlength: 50
            },
            upgradeInfo: {
                maxlength: 4000
            },
            attachementUrl: {
                maxlength: 50
            },
            attachementName: {
                maxlength: 50
            },
        }
    });
}

/**
 * 保存方法
 */
function save(form) {
    avicAjax.ajax({
        url: "platform/assets/device/assetstdeviceupgradesub/assetsTdeviceUpgradeSubController/operation/save",
        data: {data: JSON.stringify(serializeObject(form))},
        type: 'post',
        async: false,
        dataType: 'json',
        success: function (r) {
            if (r.flag == "success") {
                /* js文件可以调用引用它的jsp页面中的函数，以下两个函数是Edit页面中的函数 */
                callback(r.id);
                saveForm();

                layer.msg('保存成功！');

            } else if(r.id=="exist"){
                parent.layer.msg("保存失败，请勿添加重复数据！");
            }
            else {
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
AssetsTdeviceUpgradeSub.prototype.del = function () {
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
AssetsTdeviceUpgradeSub.prototype.reLoad = function () {
    var searchdata = {
        keyWord: null,
        param: JSON.stringify(serializeObject($(this._formId)))
    }
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关闭对话框
 */
AssetsTdeviceUpgradeSub.prototype.closeDialog = function (id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.editIndex);
    }
};

/**
 * 打开高级查询
 */
AssetsTdeviceUpgradeSub.prototype.openSearchForm = function (searchDiv) {
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
AssetsTdeviceUpgradeSub.prototype.searchData = function () {
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
AssetsTdeviceUpgradeSub.prototype.searchByKeyWord = function () {
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


//弹窗关闭函数
function closeLayer() {
    layer.close(openIndex);
}

//弹框选择测试设备软件的回调函数
function callBackFn(rows) {
    var row = null;
    if (rows.length > 0) {
        row = rows[0];
    }

    $('#tdeviceSoftwareId').val(row.id);
    $('#softwareName').val(row.softwareName);
    $('#softwareBasicName').val(row.softwareBasicName);
    $('#softwareId').val(row.softwareId);
    $('#softwareCode').val(row.softwareCode);
    $('#softwareVersion').val(row.softwareVersion);
    $('#softwareReleaseNum').val(row.softwareReleaseNum);
    $('#softwarePeriod').val(row.softwarePeriod);
    $('#softwareCodeSize').val(row.softwareCodeSize);
    $('#softwareLeader').val(row.softwareLeader);
    $('#softwareLeaderAlias').val(row.softwareLeaderAlias);
    $('#softwareLanguage').val(row.softwareLanguage);
    $('#softwareRunEnvironment').val(row.softwareRunEnvironment);
    $('#softwareDevEnvironment').val(row.softwareDevEnvironment);
    $('#remarks').val(row.remark);
    $('#upgradeInfo').val(row.upgradeInfo);

    closeLayer(openIndex);
}

function openProductModelLayer(callBackFn, param) {
    sessionStorage.setItem("param", param);
    this.openIndex = layer.open({
        type: 2,
        area: ['70%', '80%'],
        title: '测试设备软件选择',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/assetstdevicesoftware/AssetsTdeviceSoftwareSelect.jsp?callBackFn=" + callBackFn
    });
};

/* 通过接收formID，并通过formID访问附件查看弹出框 */
function getFileUrl(formId) {
    this.openIndex = layer.open({
        type: 2,
        area: ['70%', '80%'],
        title: '查看附件',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/assetsattachment/AssetsAttachmentEdit.jsp?formId="+formId
    });

}
