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
function UserTableModel() {
};

/**
 * 添加页面
 */
UserTableModel.prototype.insert = function (belongTable) {
    this.insertIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '添加视图',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: 'assets/device/usertablemodel/userTableModelController/operation/Add/' + belongTable + '/null'
    });
};

/**
 * 编辑页面
 */
UserTableModel.prototype.modify = function (belongTable, viewName) {
    console.log(viewName);
    this.insertIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '编辑视图',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: 'assets/device/usertablemodel/userTableModelController/operation/Edit/' + belongTable + '/' + viewName
    });
};

/**
 * 详情页面
 */
UserTableModel.prototype.detail = function (id) {
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
UserTableModel.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            belongTable: {
                maxlength: 100
            },
            viewName: {
                maxlength: 100
            },
        }
    });
}

/**
 * 保存方法
 */
UserTableModel.prototype.save = function (myModelJson) {
    var _self = this;
    var modelList = [];

    for(i = 0; i<myModelJson.length; i++){
        if(i<3){
            modelList.push(myModelJson[i]);
        }
        else{
            modelList.push(JSON.stringify(myModelJson[i]));
        }
    }

    avicAjax.ajax({
        url: "assets/device/usertablemodel/userTableModelController/operation/create",
        data: JSON.stringify(modelList),
        contentType : 'application/json',
        type: 'post',
        dataType: 'json',
        success: function (r) {
            if (r.flag == "success") {
                var tBody = document.getElementById('selectViewTbody');

                if(modelList[0] == 'insert'){
                    tBody.innerHTML = '<tr>' +
                                         '<td role="gridcell" onclick="switchView(\'' + modelList[1] + '\')" title="'+ modelList[1] + '">' + modelList[1] + '</td>' +
                                         '<td>' +
                                            '<i class="fa fa-file-text-o" onclick="editView(\'' + modelList[1] + '\')" title="编辑视图"></i>' +
                                            '<i class="fa fa-trash-o" onclick="delView(\'' + modelList[1] + '\')" title="删除视图"></i>' +
                                         '</td>' +
                                      '</tr>' + tBody.innerHTML;
                }
                else if(modelList[0] == 'modify'){
                    var innerHtml = tBody.innerHTML;
                    innerHtml = innerHtml.replaceAll(modelList[2], modelList[1]);
                    tBody.innerHTML = innerHtml;
                }
                switchView(modelList[1]);
                _self.reLoad();
                layer.close(_self.insertIndex);
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
UserTableModel.prototype.del = function (belongTable, viewName, trEle) {
    var _self = this;
    var params = [];

    params.push(belongTable);
    params.push(viewName);

    layer.confirm('确认要删除视图“' + viewName + '”吗?', {icon: 3, title: "提示", area: ['400px', '']}, function (index) {
        avicAjax.ajax({
            url: 'assets/device/usertablemodel/userTableModelController/operation/delete',
            data: JSON.stringify(params),
            contentType: 'application/json',
            type: 'post',
            dataType: 'json',
            success: function (r) {
                if (r.flag == "success") {
                    trEle.style.display = 'none';
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
};

/**
 * 重载数据
 */
UserTableModel.prototype.reLoad = function () {
    var searchdata = {param: JSON.stringify(serializeObject($(this._formId)))}
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};

/**
 * 关闭对话框
 */
UserTableModel.prototype.closeDialog = function (id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.editIndex);
    }
};

/**
 * 后台查询
 */
UserTableModel.prototype.searchData = function () {
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
UserTableModel.prototype.searchByKeyWord = function () {
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
UserTableModel.prototype.hideSearchForm = function () {
    layer.close(searchDialogindex);
};

/**
 * 清空查询条件
 */
UserTableModel.prototype.clearData = function () {
    clearFormData(this._formId);
    this.searchData();
};
