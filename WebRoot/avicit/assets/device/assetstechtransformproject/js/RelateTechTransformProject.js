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
function AssetsTechTransformProject(datagrid, url, searchForm, dataGridColModel, searchDialog, searchMainNames, demoMainDept_KeyWord) {
    if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = url;
    this.getUrl = function () {
        return _url;
    }
    this._formCode = "assetsTechTransformProject"; //表单的code，启动流程时需要
    this._datagridId = "#" + datagrid;
    this.Toolbardiv = "#t_" + datagrid;
    this.Toolbar = "#toolbar_" + datagrid;
    this._searchDialogId = "#" + searchDialog;
    this.Pagerlbar = "#" + datagrid + "Pager";
    this.searchForm = "#" + searchForm;
    this._keyWordId = "#" + demoMainDept_KeyWord;
    this._searchNames = searchMainNames;
    this.dataGridColModel = dataGridColModel;
    this.init.call(this);
};
/**
 * 初始化操作
 */
AssetsTechTransformProject.prototype.init = function () {
    var _self = this;
    var issubinit = false;
    $(_self._datagridId).jqGrid({
        url: _self.getUrl() + 'getAssetsTechTransformProjectsByPage.json',
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
 * 详情页面
 */
AssetsTechTransformProject.prototype.detail = function (id, value) {
    flowUtils.detail(id);
};

/**
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
AssetsTechTransformProject.prototype.formValidate=function(form){
	form.validate({
		rules: {
			ttProjectName:{
				required: true,
				maxlength: 100
			},
			chiefEngineer:{
				required: true,
				maxlength: 50
			},
			projectDirector:{
				required: true,
				maxlength: 50
			},
			remarks:{
				maxlength: 1024
			},
		}
	});
}

/**
 * 重载数据
 */
AssetsTechTransformProject.prototype.reLoad = function () {
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
 * 打开高级查询框
 */
AssetsTechTransformProject.prototype.openSearchForm = function (searchDiv, par) {
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
AssetsTechTransformProject.prototype.searchData = function () {
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
AssetsTechTransformProject.prototype.searchByKeyWord = function () {
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
AssetsTechTransformProject.prototype.hideSearchForm = function () {
    layer.close(searchDialogindex);
};
/**
 * 根据流程状态查询
 */
AssetsTechTransformProject.prototype.initWorkFlow = function (status) {
    $('#bpmState').val(status);
    if (status == "start") {
        $("#assetsTechTransformProject_modify").show();
        $("#assetsTechTransformProject_del").show();
    } else {
        $("#assetsTechTransformProject_modify").hide();
        $("#assetsTechTransformProject_del").hide();
    }
    this.searchData();
};
/**
 * 清空查询条件
 */
AssetsTechTransformProject.prototype.clearData = function () {
    clearFormData(this.searchForm);
    this.searchData();
};

/**
 * 关闭对话框
 */
AssetsTechTransformProject.prototype.relateTechTransformProject = function () {
    layer.close(this.insertIndex);
};