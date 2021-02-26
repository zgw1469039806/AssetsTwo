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

function AssetsFurnitureAccount(datagrid, url, searchDialogId, form, keyWordId, searchNames, dataGridColModel) {
    if (!datagrid || typeof(datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = "platform/assets/furniture/assetsfurnitureaccount/assetsFurnitureAccountController/operation/";
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

param = sessionStorage.getItem("param");
if(sessionStorage.getItem("param")!=""){
    sessionStorage.removeItem("param");
}
var searchdata = {
    keyWord: param,
    param: null
}

/**
 * 初始化操作
 * 回车查询
 */
AssetsFurnitureAccount.prototype.init = function () {
    var _self = this;

    param = sessionStorage.getItem("param");
    if(sessionStorage.getItem("param")!="") {
        sessionStorage.removeItem("param");
    }
    var searchdata = {
        keyWord: param,
        param: null
    }

    // /*获取session的筛选数据-begin*/
    // var classData = sessionStorage.getItem("classData");
    // if(sessionStorage.getItem("classData")!=""){
    //     sessionStorage.removeItem("classData");
    // }
    // var searchdata = {
    //     keyWord: null,
    //     param: classData
    // }
    // /*获取session的筛选数据-end*/

    $(_self._datagridId).jqGrid({
        url: _self.getUrl() + 'getAssetsFurnitureAccountsByPage.json',
        mtype: 'POST',
        datatype: "json",
        postData: searchdata,
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
        pager: "#jqGridPager",
        cellEdit: false,//禁用表格行编辑
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
AssetsFurnitureAccount.prototype.insert = function () {
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
AssetsFurnitureAccount.prototype.modify = function () {
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
AssetsFurnitureAccount.prototype.detail = function (id) {
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
 * 重载数据
 */
AssetsFurnitureAccount.prototype.reLoad = function () {
    var searchdata = {
        keyWord: null,
        param: JSON.stringify(serializeObject($(this._formId)))
    }
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关闭对话框
 */
AssetsFurnitureAccount.prototype.closeDialog = function (id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.editIndex);
    }
};

/**
 * 打开高级查询
 */
AssetsFurnitureAccount.prototype.openSearchForm = function (searchDiv) {
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
 * 选择家具提交
 */
AssetsFurnitureAccount.prototype.submit = function(){
    var _self = this;
    if(!callBackFn){
        layer.alert('找不到回调函数！', {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            btn: ['关闭'],
            title:"提示"
        });
        return false;
    }
    var selectedRow = [];
    var selectIds = $(_self._datagridId).jqGrid("getGridParam","selarrrow");
    if(selectIds.length == 0){
        layer.alert('请选择要提交的数据！', {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            btn: ['关闭'],
            title:"提示"
        });
        return false;
    }else if(selectIds.length > 1){
        if(singleSelect =='true'){
            layer.alert('只允许选择一条数据！', {
                    icon: 7,
                    area: ['400px', ''], //宽高
                    closeBtn: 0,
                    btn: ['关闭'],
                    title:"提示"
                }
            );
            return false;
        }else{
            for(var i=0;i<selectIds.length;i++){
                selectedRow.push($(this._datagridId).jqGrid('getRowData', selectIds[i]));
            }
        }
    }else{
        selectedRow.push($(this._datagridId).jqGrid('getRowData', selectIds[0]));
    }
    parent[callBackFn](selectedRow,requestType);
}

/**
 * 关键字段查询
 */
AssetsFurnitureAccount.prototype.searchByKeyWord = function () {
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
