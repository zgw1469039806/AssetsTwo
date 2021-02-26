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
function EditEformClassConfig(datagrid, url, searchDialogId, form, keyWordId, searchNames, dataGridColModel) {
    if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = url;
    this.getUrl = function () {
        return _url;
    };
    this.datagrid = datagrid;
    this._datagridId = "#" + datagrid;
    this._jqgridToolbar = "#t_" + datagrid;
    this._doc = document;
    this._formId = "#" + form;
    this._searchDialogId = "#" + searchDialogId;
    this._keyWordId = "#" + keyWordId;
    this._searchNames = searchNames;
    this.dataGridColModel = dataGridColModel;
    this.notnullFiled = [];//非空字段
    this.notnullFiledComment = []; //非空字段注释
    this._clickrowid = "";
    //除时间,数字等类型长度校验字段
    this.lengthValidFiled = [];
    //除时间,数字等类型长度校验字段注释
    this.lengthValidFiledComment = [];
    //除时间,数字等类型长度
    this.lengthValidFiledSize = [];
    this.init.call(this);
}

/**
 * 初始化操作
 */
EditEformClassConfig.prototype.init = function () {
    var _self = this;
    $(_self._datagridId).jqGrid({
        url: this.getUrl() + 'searchEformClassConfig',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true, 'top'],//启用toolbar
        colModel: this.dataGridColModel,//表格列的属性
        height: $(window).height() - 120,//初始化表格高度
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20,
        rowList:[200,100,50,30,20,10],
        altRows: true,//斑马线
        pagerpos:'left',
        styleUI: 'Bootstrap', //Bootstrap风格
        viewrecords: true, //是否要显示总记录数
        hasTabExport: false, //导出
        multiselect: true,
        hasColSet: false,  //设置显隐
        autowidth: true,//列宽度自适应
        responsive: true,//开启自适应
        cellEdit: true,
        cellsubmit: 'clientArray',
        pager: "#eformClassConfigPager"
    });
    //放入表格toolbar中
    $(this._jqgridToolbar).append($("#tableToolbar"));

    _self.notnullFiled.push("classPath");
    _self.notnullFiledComment.push("路径");
    _self.notnullFiled.push("classType");
    _self.notnullFiledComment.push("类型");

    _self.lengthValidFiled.push("className");
    _self.lengthValidFiledComment.push("名称");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiled.push("classPath");
    _self.lengthValidFiledComment.push("路径");
    _self.lengthValidFiledSize.push(500);
    _self.lengthValidFiled.push("classDesc");
    _self.lengthValidFiledComment.push("详细描述");
    _self.lengthValidFiledSize.push(500);
};
/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
EditEformClassConfig.prototype.insert = function () {
    $(this._datagridId).jqGrid('endEditCell');
    var newRowId = newRowStart + newRowIndex;
    var parameters = {
        rowID: newRowId,
        initdata: {isSystemDefault: 0,buttonCode:"customize"},
        position: "first",
        useDefValues: true,
        useFormatter: true,
        addRowParams: {
            extraparam: {}
        }
    };
    $(this._datagridId).jqGrid('addRow', parameters);
    newRowIndex++;
};

/**
 * 保存功能
 * @param form
 * @param callback
 */
EditEformClassConfig.prototype.save = function () {
    var _self = this;
    $(this._datagridId).jqGrid('endEditCell');
    var hasvalidate = true;
    var data = $(this._datagridId).jqGrid('getRowData');
    $.each(_self.notnullFiled, function (i, item) {
        var msg = _self.nullvalid(data, item, _self.notnullFiled, _self.notnullFiledComment);
        if (msg && msg.length > 0) {
            layer.alert(msg, {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0
            });
            hasvalidate = false;
            return false;
        }
    });
    $.each(_self.lengthValidFiled, function (i, item) {
        var msg = _self.lengthvalid(data, item, _self.lengthValidFiled, _self.lengthValidFiledComment, _self.lengthValidFiledSize);
        if (msg && msg.length > 0) {
            layer.alert(msg, {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0
            });
            hasvalidate = false;
            return false;
        }
    });
    if (!hasvalidate) {
        return false;
    }
    if (data && data.length > 0) {
        avicAjax.ajax({
            url: _self.getUrl() + "saveEformClassConfig",
            data: {
                data:JSON.stringify(data)
            },
            type: 'post',
            dataType: 'json',
            success: function (r) {
                if (r.flag == "success") {
                    _self.reLoad();
                    layer.msg('保存成功！',{
                        icon: 1,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
                } else {
                    layer.alert('保存失败！' + r.msg, {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                    });
                }
            }
        });
    } else {
        layer.alert('没有修改数据！', {
            icon: 7,
            area: ['400px', ''], //宽高
            title: '提示',
            closeBtn: 0
        });
    }
};
/**
 * 非空验证
 * @param
 * @param
 */
EditEformClassConfig.prototype.nullvalid = function (data, item, nullfiled, notnullFiledComment) {
    var msg = "";
    $.each(data, function (i, dataitem) {
        if (dataitem[item] == "") {
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
EditEformClassConfig.prototype.lengthvalid = function (data, item, lengthValidFiled, lengthValidFiledComment, lengthValidFiledSize) {
    var msg = "";
    $.each(data, function (i, dataitem) {
        if (dataitem[item].length > lengthValidFiledSize[$.inArray(item, lengthValidFiled)]) {
            msg = lengthValidFiledComment[$.inArray(item, lengthValidFiled)] + "过长，最大长度为"+lengthValidFiledSize[$.inArray(item, lengthValidFiled)]+'\r\n';

        }
    });
    return msg;
};

/**
 * 删除
 */
EditEformClassConfig.prototype.del = function () {
    $(this._datagridId).jqGrid('endEditCell');
    var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    var id = $(this._datagridId).jqGrid('getGridParam', 'selrow');
    var _self = this;
    var ids = [];
    var l = rows.length;
    if (l == 0) {
        layer.alert('请选择要删除的数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                title: '提示'
            }
        );
    }
    else {
        var theRow = $(this._datagridId).jqGrid('getRowData', id);
        layer.confirm('确认要删除选择的数据吗?', {
            icon: 3,
            title: "提示",
            area: ['400px', '']
        }, function (index) {
            for (; l--;) {
                ids.push(rows[l]);
            }
            avicAjax.ajax({
                url: _self.getUrl() + 'deleteEformClassConfig',
                data: JSON.stringify(ids),
                contentType: 'application/json',
                type: 'post',
                dataType: 'json',
                success: function (r) {
                    if (r.flag == "success") {
                        // _self.reLoad();
                        for (var i in ids){
                            $(_self._datagridId).jqGrid("delRowData", ids[i]);
                        }
                        layer.msg('删除成功！',{
                            icon: 1,
                            area: ['200px', ''],
                            closeBtn: 0
                        });
                    } else {
                        layer.alert('删除失败！' + r.msg, {
                            icon: 7,
                            area: ['400px', ''],
                            closeBtn: 0
                        });
                    }
                }
            });
            layer.close(index);
        });
    }
};

//打开高级查询框
EditEformClassConfig.prototype.openSearchForm = function(searchDiv){
    var _self = this;

    var contentWidth = 800;
    var top =  $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
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
        move : false,
        area: [contentWidth + 'px', '200px'],
        offset: [top + 'px', left + 'px'],
        closeBtn: 0,
        shadeClose: true,
        btn: ['查询', '清空', '取消'],
        content: $(this._searchDialogId),
        success : function(layero, index) {
            var serachLabel = $('<div class="serachLabel"><span>'+ text +'</span></div>').appendTo(layero);
            serachLabel.bind('click', function(){
                layer.close(index);
            });
            serachLabel.css('width', width + 'px');
        },
        yes: function(index, layero){
            _self.searchData();
            layer.close(index);
        },
        btn2: function(index, layero){
            _self.clearData();
            return false;
        },
        btn3: function(index, layero){

        }
    });
};

/*清空查询条件*/
EditEformClassConfig.prototype.clearData =function(){
    clearFormData(this._formId);
    this.searchData();
};

//高级查询
EditEformClassConfig.prototype.searchData =function(){
   this.reLoad();
};

/**
 * 重载数据
 */
EditEformClassConfig.prototype.reLoad = function () {
    var searchdata = {
        keyWord: null,
        searchParam: JSON.stringify(serializeObject($(this._formId)))
    };
    $(this._datagridId).jqGrid('setGridParam', {
        datatype: 'json',
        postData: searchdata
    }).trigger("reloadGrid");
};