function AssetsOperationDevice(datagrid, url, formSub, dataGridColModel, searchDialogSub, pid, searchSubNames, demoSubUser_KeyWord) {
    if (!datagrid || typeof(datagrid) !== 'string' && datagrid.trim() !== '') {
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
    this.init.call(this);
};
/**
 * 初始化操作
 * 回车查询
 */
AssetsOperationDevice.prototype.init = function (pid) {
    var _self = this;
    $(_self._datagridId).jqGrid({
        url: _self.getUrl() + 'getAssetsOperationDevice',
        postData: {pid: _self.pid},
        mtype: 'POST',
        datatype: "json",
        toolbar: [true, 'top'],
        colModel: _self.dataGridColModel,
        height: $(window).height() * 2 / 5,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
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
        multiboxonly: true,//通过点击行仅有一行能被选中
        autowidth: true,
        shrinkToFit: true,
        responsive: true,//开启自适应
        pager: _self.Pagerlbar
    });

    $(_self.Toolbardiv).append($(_self.Toolbar));

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
AssetsOperationDevice.prototype.insert = function (pid) {
    if (pid == "null" || pid == "undefined") {
        layer.alert('请选择一条主表数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
        return false;
    } else {
        this.insertIndex = layer.open({
            type: 2,
            title: '添加',
            skin: 'bs-modal',
            area: ['100%', '100%'],
            maxmin: false,
            content: this.getUrl() + 'Add/null'
        });
    }
};
/**
 * 编辑页面
 */
AssetsOperationDevice.prototype.modify = function () {
    if (this.pid == null || this.pid == "") {
        layer.alert('请选择一条要编辑的主表数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
        return false;
    }
    var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    if (ids.length == 0) {
        layer.alert('请选择要编辑的数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
        return false;
    } else if (ids.length > 1) {
        layer.alert('只允许选择一条数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
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
        title: '编辑',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content: this.getUrl() + 'Edit/' + rowData.id
    });
};
/**
 * 详情页面
 */
AssetsOperationDevice.prototype.detail = function (id) {
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
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
AssetsOperationDevice.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            deviceName: {
                required: true,
                maxlength: 50
            },
            unifiedId: {
                required: true,
                maxlength: 50
            },
            deviceId: {
                required: true,
                maxlength: 50
            },
            deviceModel: {
                maxlength: 50
            },
            ownerId: {
                maxlength: 50
            },
            ownerDept: {
                maxlength: 50
            },
            positionId: {
                maxlength: 50
            },
            validPeriod: {
                number: true
            },
            beginDate: {
                dateISO: true
            },
            endDate: {
                dateISO: true
            },
            certificateId: {
                required: true,
                maxlength: 50
            },
            serialNumber: {
                maxlength: 255
            },
        }
    });
}
/**
 * 保存方法
 */
AssetsOperationDevice.prototype.save = function (form, id) {
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
AssetsOperationDevice.prototype.del = function () {
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
                area: ['400px', ''],
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
AssetsOperationDevice.prototype.reLoad = function (pid) {
    if (pid != undefined) {
        this.pid = pid;
    }
    var searchdata = {pid: pid};
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关闭对话框
 */
AssetsOperationDevice.prototype.closeDialog = function (id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.editIndex);
    }
};
/**
 * 打开高级查询框
 */
AssetsOperationDevice.prototype.openSearchForm = function (searchDiv, par) {
    var _self = this;
    par = null;
    var contentWidth = 600;
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
 * 去后台查询
 */
AssetsOperationDevice.prototype.searchData = function () {
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
AssetsOperationDevice.prototype.searchByKeyWord = function () {
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
}
/**
 * 隐藏查询框
 */
AssetsOperationDevice.prototype.hideSearchForm = function () {
    layer.close(searchDialogindex);
};
/**
 * 清空查询条件
 */
AssetsOperationDevice.prototype.clearData = function () {
    clearFormData(this.searchForm);
    this.searchData();
};


//弹框选择设备台账的回调函数
function callBackFn(rows, requestType) {
    switch (requestType) {
        case "productModelSelect":
            for(i=0; i<rows.length; i++){
                var row = rows[i];
                // var certificateId = "";
                // if(certificateId == null || certificateId.length == 0){
                //     //操作证id为空则提示
                //     layer.alert('请选择操作证！', {
                //         icon: 7,
                //         area: ['400px', ''], //宽高
                //         closeBtn: 0,
                //         btn: ['关闭'],
                //         title:"提示"
                //     });
                //     break;
                // }
                document.getElementById('unifiedId').value = row.unifiedId;
                document.getElementById('deviceName').value = row.deviceName;
                document.getElementById('deviceId').value = row.id;
                document.getElementById('deviceModel').value = row.deviceModel;
                document.getElementById('ownerId').value = row.ownerId;
                document.getElementById('ownerIdAlias').value = row.ownerIdAlias;
                document.getElementById('ownerDept').value = row.ownerDept;
                document.getElementById('ownerDeptAlias').value = row.ownerDeptAlias;
                document.getElementById('positionId').value = row.positionId;
            }
            break;
        case "productSerySelect":
            $('#seryCode').val(row.seryCode);
            $('#seriesId').val(row.id);
            break;
    }

    closeLayer(openIndex);

}

//弹窗关闭函数
function closeLayer(){
    layer.close(openIndex);
}

/**
 * 设备台账信息选择框
 * param:
 *  singleSelect -是否单选（true-单选，false为多选；字符串）；
 *  requestType-页面请求标记，用于同一页面有多个相同弹出页时，调用回调函数赋值时使用，可为空字符串，代码默认取值‘productModelSelect’；
 *  callBackFn-回调函数名称，用户声明的“弹框选择设备台账的回调函数”的函数名字符串；
 */
function openProductModelLayer (singleSelect, requestType, callBackFn, param){
    sessionStorage.setItem("labSelectParam",param);
    this.openIndex = layer.open({
        type: 2,
        area: ['85%', '75%'],
        title: '设备选择',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/assetsdeviceaccount/AssetsDeviceAccountSelect.jsp?callBackFn="+callBackFn +"&requestType="+"productModelSelect"

    });
};

