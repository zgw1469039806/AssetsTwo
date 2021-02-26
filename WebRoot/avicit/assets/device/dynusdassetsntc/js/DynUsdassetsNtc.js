/**
 * 主子附件流程
 * @param datagrid
 * @param url
 * @param searchForm
 * @param dataGridColModel
 * @param searchDialog
 * @param afterInit
 * @param clickRowLoad
 * @param searchMainNames
 * @param demoMainDept_KeyWord
 */
function DynUsdassetsNtc(datagrid, url, searchForm, dataGridColModel, searchDialog, afterInit, clickRowLoad, searchMainNames, demoMainDept_KeyWord) {
    if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = url;
    this.getUrl = function () {
        return _url;
    }
    this._formCode = "assetsusdequipcollectntc"; //表单的code，启动流程时需要
    this._datagridId = "#" + datagrid;
    this.Toolbardiv = "#t_" + datagrid;
    this.Toolbar = "#toolbar_" + datagrid;
    this._searchDialogId = "#" + searchDialog;
    this.Pagerlbar = "#" + datagrid + "Pager";
    this.searchForm = "#" + searchForm;
    this._keyWordId = "#" + demoMainDept_KeyWord;
    this._searchNames = searchMainNames;
    this.dataGridColModel = dataGridColModel;
    this.afterInit = afterInit;
    this.clickRowLoad = clickRowLoad;
    this.init.call(this);
    //定义流程帮助类
    this.flowListEditor;
};
/**
 * 初始化操作
 */
DynUsdassetsNtc.prototype.init = function () {
    var _self = this;
    //初始化流程帮助类
    flowListEditor = new FlowListEditor(this._formCode);
    var issubinit = false;
    $(_self._datagridId).jqGrid({
        url: _self.getUrl() + 'getDynUsdassetsNtcsByPage.json',
        mtype: 'POST',
        multiselect: true,
        datatype: "json",
        toolbar: [true, 'top'],
        colModel: _self.dataGridColModel,
        scrollOffset: 10,
        rowNum: 20,
        rowList: [200, 100, 50, 30, 20, 10],
        altRows: true,
        userDataOnFooter: true,
        pagerpos: 'left',
        hasColSet: false,//设置显隐属性
        styleUI: 'Bootstrap',
        viewrecords: true,
        multiboxonly: true,
        autowidth: true,
        shrinkToFit: true,
        responsive: true,
        pager: _self.Pagerlbar,
        onSelectAll: function () {
            _self.clickRowLoad("");
        },
        onSelectRow: function (rowid, status) {
            var rows = $(_self._datagridId).jqGrid('getGridParam',
                'selarrrow');
            if (issubinit && rows.length == 1) {
                _self.clickRowLoad(rows[0]);
            } else {
                if (issubinit) {
                    _self.clickRowLoad("");
                }
            }
        },
        loadComplete: function () {
            $(this).jqGrid('getColumnByUserIdAndTableName');
            var rowdata = $(_self._datagridId).jqGrid('getRowData');
            if (issubinit == false) {
                if (rowdata != null && rowdata.length > 0) {
                    $(_self._datagridId).setSelection(rowdata[0].id);
                    _self.afterInit(rowdata[0].id);
                    issubinit = true;
                } else {
                    _self.afterInit("-1");
                    issubinit = true;
                }
            } else {
                if (rowdata != null && rowdata.length > 0) {
                    $(_self._datagridId).setSelection(rowdata[0].id);
                    _self.clickRowLoad(rowdata[0].id);

                } else {
                    _self.clickRowLoad("-1");
                }
            }
        }
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
    $(_self._keyWordId).on('keydown', function (e) {
        if (e.keyCode == '13') {
            _self.searchByKeyWord();
        }
    });
};
/**
 * 添加页面
 */
DynUsdassetsNtc.prototype.insert = function () {
    //添加流程
    flowListEditor.addFlow();
};
/**
 * 编辑页面
 */
DynUsdassetsNtc.prototype.modify = function () {
    var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    if (ids.length == 0) {
        layer.alert('请选择要编辑的数据！', {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            btn: ['关闭'],
            title: "提示"
        });
        return false;
    } else if (ids.length > 1) {
        layer.alert('只允许选择一条数据！', {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            btn: ['关闭'],
            title: "提示"
        });
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
DynUsdassetsNtc.prototype.detail = function (id, value) {
    flowUtils.detail(id);
};
/**
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
DynUsdassetsNtc.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            author: {
                maxlength: -1
            },
            applyYear: {
                maxlength: 50
            },
            deptDeadline: {
                dateISO: true
            },
            releasedate: {
                dateISO: true
            },
            telephone: {
                maxlength: 50
            },
            dept: {
                maxlength: -1
            },
            formRemarks: {
                maxlength: 4000
            },
            formTitle: {
                maxlength: 50
            },
        }
    });
}
/**
 * 保存方法
 */
DynUsdassetsNtc.prototype.save = function (form, id) {
    var _self = this;
    var subFrame = $('iframe')[0].contentWindow;
    avicAjax.ajax({
        url: _self.getUrl() + "save",
        data: {
            data: JSON.stringify(serializeObject(form))
        },
        type: 'post',
        dataType: 'json',
        success: function (r) {
            if (r.flag == "success") {
                var files = subFrame.$('#attachment').uploaderExt('getUploadFiles');
                if (files.length != 0) {
                    subFrame.afterUploadEvent = function () {
                        _self.reLoad();
                        var msg = subFrame.assetsUstdtempapplyCollect.valid();
                        if (msg && msg != "") {
                            layer.alert(msg, {
                                icon: 7,
                                area: ['400px', ''], //宽高
                                closeBtn: 0,
                                btn: ['关闭'],
                                title: "提示"
                            });
                            return false;
                        }
                        subFrame.assetsUstdtempapplyCollect.save(r.pid);
                    };
                    subFrame.$('#attachment').uploaderExt('doUpload', r.pid);
                } else {
                    _self.reLoad();
                    var msg = subFrame.assetsUstdtempapplyCollect.valid();
                    if (msg && msg != "") {
                        layer.alert(msg, {
                            icon: 7,
                            area: ['400px', ''], //宽高
                            closeBtn: 0,
                            btn: ['关闭'],
                            title: "提示"
                        });
                        return false;
                    }
                    subFrame.assetsUstdtempapplyCollect.save(r.pid);
                }
            } else {
                layer.alert('保存失败,请联系管理员!', {
                    icon: 7,
                    area: ['400px', ''], //宽高
                    closeBtn: 0,
                    btn: ['关闭'],
                    title: "提示"
                });
            }
        }
    });
};
/**
 * 删除方法
 */
DynUsdassetsNtc.prototype.del = function () {
    var _self = this;
    var rows = $(_self._datagridId).jqGrid('getGridParam', 'selarrrow');
    var ids = [];
    var l = rows.length;
    if (l > 0) {
        layer.confirm('确认要删除选中的数据吗?', {
            icon: 3,
            title: "提示",
            area: ['400px', '']
        }, function (index) {
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
                            area: ['400px', ''], //宽高
                            closeBtn: 0,
                            btn: ['关闭'],
                            title: "提示"
                        });

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
        });
    }
};
/**
 * 重载数据
 */
DynUsdassetsNtc.prototype.reLoad = function () {
    var searchdata = {
        keyWord: null,
        param: JSON.stringify(serializeObject($(this.searchForm)))
    };
    $(this._datagridId).jqGrid('setGridParam', {
        datatype: 'json',
        postData: searchdata
    }).trigger("reloadGrid");
};
/**
 * 关闭对话框
 */
DynUsdassetsNtc.prototype.closeDialog = function (windowName) {
    layer.close(layer.getFrameIndex(windowName));
};
/**
 * 打开高级查询框
 */
DynUsdassetsNtc.prototype.openSearchForm = function (searchDiv, par) {
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
            var serachLabel = $(
                '<div class="serachLabel"><span>' + text
                + '</span><span class="caret"></span></div>')
                .appendTo(layero);
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
DynUsdassetsNtc.prototype.searchData = function () {
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
        param: JSON.stringify(serializeObject($(this.searchForm)))
    };
    $(this._datagridId).jqGrid('setGridParam', {
        datatype: 'json',
        postData: searchdata
    }).trigger("reloadGrid");
};
/**
 * 关键字段查询
 */
DynUsdassetsNtc.prototype.searchByKeyWord = function () {
    var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr("placeholder") ? "" : $(this._keyWordId).val();
    var names = this._searchNames;
    var bpmState = $('#bpmState').val();

    var param = {
        bpmState: bpmState
    };
    for (var i in names) {
        var name = names[i];
        param[name] = keyWord;
    }
    var searchdata = {
        keyWord: JSON.stringify(param),
        param: null
    }
    $(this._datagridId).jqGrid('setGridParam', {
        datatype: 'json',
        postData: searchdata
    }).trigger("reloadGrid");
}
/**
 * 隐藏查询框
 */
DynUsdassetsNtc.prototype.hideSearchForm = function () {
    layer.close(searchDialogindex);
};
/**
 * 根据流程状态查询
 */
DynUsdassetsNtc.prototype.initWorkFlow = function (status) {
    $('#bpmState').val(status);
    if (status == "start") {
        $("#dynUsdassetsNtc_modify").show();
        $("#dynUsdassetsNtc_del").show();
    } else {
        $("#dynUsdassetsNtc_modify").hide();
        $("#dynUsdassetsNtc_del").hide();
    }
    this.searchData();
};

/**
 * 导出
 */
function exportAll(){
    //封装参数
    var rows=$("#assetsUstdtempapplyCollect").jqGrid("getRowData");
    var rownum =	$("#assetsUstdtempapplyCollect").jqGrid('getGridParam','colModel')

    var rowid=$("#dynUsdassetsNtc").jqGrid("getGridParam","selrow");
    var rowData=jQuery("#dynUsdassetsNtc").jqGrid("getRowData",rowid);


    var dataGridFields = JSON.stringify(rownum);
    var expSearchParams ={};
    expSearchParams.dataGridFields=dataGridFields;
    expSearchParams.hasRowNum=true;
    expSearchParams.sheetName='sheet1';
    expSearchParams.unContainFields='id';//由于id没有chechbox，所以需要显示的过滤掉
    expSearchParams.fileName='非标设备年度征集表'+ new Date().format("yyyy-MM-dd");
    expSearchParams.pid=rowData.id;
    expSearchParams.appid='1';

    var url = "assets/device/dynusdassetsntc/dynUsdassetsNtcController/exportList";
    var ep = new exportData("xlsExport","xlsExport",expSearchParams,url);
    ep.excuteExport();

};


/*Excel导入模板表头信息，prop字段dto值，name：label信息，rownum：第几列，dropdown：是否为数据字典，lookupType：数据字典类型编码*/
var templeteHeadersArray={
    headers:  [
        {prop:"xuhao",name: "序号", rownum: "0", dropdown: false, lookupType: ""},
        {prop:"stdIdCm",name: "申购单号", rownum: "1", dropdown: false, lookupType: ""},
        {prop:"createdByPersionAliasCm",name: "申请人", rownum: "2", dropdown: false, lookupType: ""},
        {prop:"createdByDeptAliasCm",name: "申请人部门", rownum: "3", dropdown: false, lookupType: ""},
        {prop:"attribute02",name: "申请人账号", rownum: "4", dropdown: false, lookupType: ""},
        {prop:"deviceNameCm",name: "设备名称", rownum: "5", dropdown: false, lookupType: ""},
        {prop:"deviceCategoryCmName",name: "设备类别", rownum: "6", dropdown: true, lookupType: "DEVICE_CATEGORY"},
        {prop:"belongProjectCm",name: "所属项目", rownum: "7", dropdown: false, lookupType: ""},
        {prop:"financialResourcesCmName",name: "经费来源", rownum: "8", dropdown: true, lookupType: "FINANCIAL_RESOURCES"},
        {prop:"financialEstimateCm",name: "经费概算", rownum: "9", dropdown: false, lookupType: ""},
        {prop:"replyNameCm",name: "批复名称", rownum: "10", dropdown: false, lookupType: ""},
        {prop:"approvalFormNumberCm",name: "立项单号", rownum: "11", dropdown: false, lookupType: ""}


    ],
    fileName:"importUsdequipPlan"
}


/* 生成Exel导入模板*/
function generateExcel () {

    avicAjax.ajax({
        url: 'assets/device/excelutil/controller/operation/generateExel',
        type: 'POST',
        data:JSON.stringify(templeteHeadersArray),
        dataType: 'JSON',
        contentType: 'application/json',
    });
};


/*导入数据*/
function importSdequipPlan() {
    var rowid=$("#dynUsdassetsNtc").jqGrid("getGridParam","selrow");
    var rowData=jQuery("#dynUsdassetsNtc").jqGrid("getRowData",rowid);
    importIndex = parent.layer.open({
        type: 2,
        area: ['70%', '70%'],
        title: '征集下发导入',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: 'platform/excelImportController/excelimport/importUsdequipPlan/xlsx?extPara='+rowData.id,
        cancel: function(){
            var searchdata = {pid: rowData.id};
            $("#assetsUstdCollectCm").jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
        }

    });
}

/**
 * 清空查询条件
 */
DynUsdassetsNtc.prototype.clearData = function () {
    clearFormData(this.searchForm);
    this.searchData();
};