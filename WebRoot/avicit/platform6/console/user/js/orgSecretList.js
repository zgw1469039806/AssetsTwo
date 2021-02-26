/**
 * 初始化对象
 * @param datagrid 表格Id
 * @param url URL参数
 * @param searchDialogId 高级查询Id
 * @param form 高级查询formId
 * @param keyWordId 关键字查询框Id
 * @param searchNames 关键字查询项名称Array
 * @param dataGridColModel 表格列属性Array
 */
function OrgSecretList(datagrid, url, dataGridColModel, userId) {
    if (!datagrid || typeof(datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = url;
    this.getUrl = function () {
        return _url;
    };
    this.userId = userId;
    this._$grid;
    this._datagridId = "#" + datagrid;
    this._jqgridToolbar = "#t_" + datagrid;
    this._doc = document;
    this.notnullFiled = [];//非空字段
    this.notnullFiledComment = []; //非空字段注释
    //除时间,数字等类型长度校验字段
    this.lengthValidFiled = [];
    //除时间,数字等类型长度校验字段注释
    this.lengthValidFiledComment = [];
    //
    this.lengthValidFiledSize = [50, 50, 50, 50, 50, 5];
    this.dataGridColModel = dataGridColModel;
    this.currentRowId = '';
    this.init.call(this);
}
/**
 * 初始化操作
 */
OrgSecretList.prototype.init = function () {
    var lastEditRowID;
    var _self = this;
    _self._$grid = $(_self._datagridId).jqGrid({
        url: this.getUrl(),
        mtype: 'POST',
        datatype: "json",
        toolbar: [true, 'top'],//启用toolbar
        colModel: this.dataGridColModel,//表格列的属性
        height: $(window).height() - 120,//初始化表格高度
        scrollOffset: 20, //设置垂直滚动条宽度
        altRows: true,//斑马线
        styleUI: 'Bootstrap', //Bootstrap风格
        viewrecords: true, //是否要显示总记录数
        multiselect: true,//可多选
        autowidth: true,//列宽度自适应
        responsive: true,//开启自适应
        cellEdit: true,
        cellsubmit: 'clientArray',
        onCellSelect: function (rowid, index, contents, event) {
            _self.currentRowId = rowid;
        }
    });

    //放入表格toolbar中
    $(this._jqgridToolbar).append($("#tableToolbar"));

    //初始化时间控件
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
};
/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
OrgSecretList.prototype.insert = function () {
    $(this._datagridId).jqGrid('endEditCell');
    var _self = this;
    var newRowId = newRowStart + newRowIndex;
    var parameters = {
        rowID: newRowId,
        initdata: {},
        position: "first",
        useDefValues: true,
        useFormatter: true,
        addRowParams: {extraparam: {}}
    };
    _self._$grid.addRowData(newRowId, parameters, 'first');
    newRowIndex++;
};
/**
 * 非空验证
 * @param
 * @param
 */
OrgSecretList.prototype.nullvalid = function (data, item, nullfiled, notnullFiledComment) {
    var msg = "";
    $.each(data, function (i, dataitem) {
        if (dataitem[item] == "") {
            temp = false;
            msg = notnullFiledComment[$.inArray(item, nullfiled)] + "为必填字段";
        }
    });
    return msg;
};
/**
 * 长度验证
 * @param
 * @param
 */
OrgSecretList.prototype.lengthvalid = function (data, item, lengthValidFiled, lengthValidFiledComment, lengthValidFiledSize) {
    var msg = "";
    $.each(data, function (i, dataitem) {
        if (dataitem[item] != "" && dataitem[item].replace(/[^\x00-\xff]/g, "**").length > lengthValidFiledSize[$.inArray(item, lengthValidFiled)]) {
            msg = lengthValidFiledComment[$.inArray(item, lengthValidFiled)] + "的输入长度超过预设长度" + lengthValidFiledSize[$.inArray(item, lengthValidFiled)];
        }
    });
    return msg;
};
/**
 * 保存功能
 * @param form
 * @param callback
 */
OrgSecretList.prototype.save = function () {
    var _self = this;

    $(this._datagridId).jqGrid('endEditCell');
    var data = $(this._datagridId).jqGrid('getChangedCells');

    if (data && data.length > 0) {
        for (var i = 0; i < data.length; i++) {
            if (data[i].id.indexOf(newRowStart) > -1) {
                data[i].id = '';
            }
        }

        $.ajax({
            url: 'platform/console/user/saveUserOrgSecret',
            data: {data: JSON.stringify(data), userId: _self.userId},
            type: 'post',
            dataType: 'json',
            success: function (r) {
                if (r.flag == "success") {
                    _self.reLoad();
                    layer.msg('保存成功！');
                } else {
                    _self.reLoad();
                    layer.alert('保存失败！' + r.error, {
                            icon: 7,
                            area: ['400px', ''], //宽高
                            closeBtn: 0
                        }
                    );
                }
            }
        });
    } else {
        layer.alert('请添加或修改数据！', {
                icon: 7,
                area: ['400px', ''],
                closeBtn: 0
            }
        );
    }
};


/**
 * 删除
 */
OrgSecretList.prototype.del = function () {
    var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    var _self = this;
    var ids = [];
    var l = rows.length;
    if (l > 0) {
        layer.confirm('确定要删除该数据吗?', {icon: 2, title: "请确认：", area: ['400px', '']}, function (index) {
            for (; l--;) {
                ids.push(rows[l]);
            }
            $.ajax({
                url: 'platform/console/user/deleteUserOrgSecret',
                data: JSON.stringify(ids),
                contentType: 'application/json',
                type: 'post',
                dataType: 'json',
                success: function (r) {
                    if (r.flag == "success") {
                        _self.reLoad();
                        layer.msg('删除成功！');
                    } else {
                        layer.alert('删除失败！' + r.error, {
                                icon: 7,
                                area: ['400px', ''],
                                closeBtn: 0
                            }
                        );
                    }
                }
            });
            layer.close(index);
        });
    } else {
        layer.alert('请选择要删除的记录！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
    }
};

/**
 * 重载数据
 */
OrgSecretList.prototype.reLoad = function () {
    var searchdata = {
        keyWord: null,
        param: JSON.stringify(serializeObject($(this._formId)))
    };
    $(this._datagridId).jqGrid('setGridParam', {postData: searchdata}).trigger("reloadGrid");
};