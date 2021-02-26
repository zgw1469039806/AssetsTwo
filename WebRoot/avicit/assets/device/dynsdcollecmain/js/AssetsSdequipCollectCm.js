function AssetsSdequipCollectCm(datagrid, url, formSub, dataGridColModel, searchDialogSub, pid, searchSubNames, demoSubUser_KeyWord, isReload) {
    if (!datagrid || typeof(datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = "platform/assets/device/dynsdcollecmain/dynSdCollecMainController/operation/sub/";
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
AssetsSdequipCollectCm.prototype.init = function (pid) {
    var _self = this;
    if (_self.isReload == "true") {
        $(_self._datagridId).jqGrid({
            url: _self.getUrl() + 'getAssetsSdequipCollectCm',
            postData: {pid: _self.pid},
            mtype: 'POST',
            datatype: "json",
            toolbar: [true, 'top'],
            colModel: assetsSdequipCollectCmGridColModel,
            height: 200,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
            scrollOffset: 10, //设置垂直滚动条宽度
            altRows: true,
            pagerpos: 'left',
            hasColSet: false,//设置显隐属性
            styleUI: 'Bootstrap',
            viewrecords: true, //
            multiselect: true,
            width: document.body.clientWidth - 400,
            autowidth: false,
            shrinkToFit: true,
            responsive: true,//开启自适应
            cellEdit: true,
            cellsubmit: 'clientArray'
        });
    } else if (_self.isReload == "edit") {
        $(_self._datagridId).jqGrid({
            url: _self.getUrl() + 'getAssetsSdequipCollectCm',
            postData: {pid: _self.pid},
            mtype: 'POST',
            datatype: "json",
            toolbar: [true, 'top'],
            colModel: assetsSdequipCollectCmGridColModel,
            height: 200,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
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
            cellsubmit: 'clientArray'
        });
    } else {
        $(_self._datagridId).jqGrid({
            url: _self.getUrl() + 'getAssetsSdequipCollectCm',
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
    _self.lengthValidFiled.push("stdId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("申购单号");
    _self.lengthValidFiled.push("createdByPersion");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("申请人");
    _self.lengthValidFiled.push("createdByDept");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("申请人部门");
    _self.lengthValidFiled.push("createdByTel");
    _self.lengthValidFiledSize.push(20);
    _self.lengthValidFiledComment.push("申请人电话");
    _self.lengthValidFiled.push("formState");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("单据状态");
    _self.lengthValidFiled.push("deviceName");
    _self.lengthValidFiledSize.push(30);
    _self.lengthValidFiledComment.push("设备名称");
    _self.lengthValidFiled.push("deviceSpec");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("设备规格");
    _self.lengthValidFiled.push("deviceModel");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("设备型号");
    _self.lengthValidFiled.push("secretLevel");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("密级");
    _self.lengthValidFiled.push("referencePlant");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("参考厂家");
    _self.lengthValidFiled.push("deviceType");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("设备类型");
    _self.lengthValidFiled.push("deviceCategory");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("设备类别");
    _self.lengthValidFiled.push("isMetering");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否计量");
    _self.lengthValidFiled.push("isSceneMetering");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否现场计量");
    _self.lengthValidFiled.push("isMaintain");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否保养");
    _self.lengthValidFiled.push("isAccuracyCheck");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否精度检查");
    _self.lengthValidFiled.push("isRegularCheck");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否定检");
    _self.lengthValidFiled.push("isSpotCheck");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否点检");
    _self.lengthValidFiled.push("isSpecialDevice");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否特种设备");
    _self.lengthValidFiled.push("isPrecisionIndex");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否精度指标");
    _self.lengthValidFiled.push("isNeedInstall");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否需要安装");
    _self.lengthValidFiled.push("installPosition");
    _self.lengthValidFiledSize.push(200);
    _self.lengthValidFiledComment.push("安装地点");
    _self.lengthValidFiled.push("isFoundation");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否需要地基基础");
    _self.lengthValidFiled.push("isSafetyProduction");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否涉及安全生产");
    _self.lengthValidFiled.push("financialResources");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("经费来源");
    _self.lengthValidFiled.push("toProject");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("所属项目");
    _self.lengthValidFiled.push("approvalName");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("批复名称");
    _self.lengthValidFiled.push("chiefEngineer");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("主管总师");
    _self.lengthValidFiled.push("projectNum");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("项目序号");
    _self.lengthValidFiled.push("projectDirector");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("项目主管");
    _self.lengthValidFiled.push("demandUrgencyDegree");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("需求紧急程度");
    _self.lengthValidFiled.push("isTrain");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否需要设备培训");
    _self.lengthValidFiled.push("isPc");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否是计算机");
    _self.lengthValidFiled.push("buyer");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("采购员");
    _self.lengthValidFiled.push("planBuyer");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("采购计划员");
    _self.lengthValidFiled.push("isWireless");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否具有无线功能");
    _self.lengthValidFiled.push("devicePurchaseType");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("设备购置类型");
    _self.lengthValidFiled.push("devicePurchaseCause");
    _self.lengthValidFiledSize.push(255);
    _self.lengthValidFiledComment.push("设备购置原因");
    _self.lengthValidFiled.push("technicalIndex");
    _self.lengthValidFiledSize.push(1024);
    _self.lengthValidFiledComment.push("技术指标");
    _self.lengthValidFiled.push("technicalIndex02");
    _self.lengthValidFiledSize.push(1024);
    _self.lengthValidFiledComment.push("技术指标");
    _self.lengthValidFiled.push("advancement");
    _self.lengthValidFiledSize.push(1024);
    _self.lengthValidFiledComment.push("指标先进性");
    _self.lengthValidFiled.push("deviceReliability");
    _self.lengthValidFiledSize.push(1024);
    _self.lengthValidFiledComment.push("设备可靠性");
    _self.lengthValidFiled.push("isWeedOut");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否属于即将产能淘汰设备");
    _self.lengthValidFiled.push("notMeetDemand");
    _self.lengthValidFiledSize.push(1024);
    _self.lengthValidFiledComment.push("已有设备为什么不能满足要求");
    _self.lengthValidFiled.push("useRatio");
    _self.lengthValidFiledSize.push(1024);
    _self.lengthValidFiledComment.push("设备利用率情况");
    _self.lengthValidFiled.push("energyConsumption");
    _self.lengthValidFiledSize.push(1024);
    _self.lengthValidFiledComment.push("设备能耗情况 ");
    _self.lengthValidFiled.push("consumableEconomics");
    _self.lengthValidFiledSize.push(1024);
    _self.lengthValidFiledComment.push("设备耗材经济性");
    _self.lengthValidFiled.push("universality");
    _self.lengthValidFiledSize.push(1024);
    _self.lengthValidFiledComment.push("设备通用性");
    _self.lengthValidFiled.push("maintainCost");
    _self.lengthValidFiledSize.push(1024);
    _self.lengthValidFiledComment.push("设备维保费用情况");
    _self.lengthValidFiled.push("security");
    _self.lengthValidFiledSize.push(1024);
    _self.lengthValidFiledComment.push("安全性");
    _self.lengthValidFiled.push("isBearingMeet");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("安装设备楼层承重是否满足");
    _self.lengthValidFiled.push("isOutdoorUnit");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("设备是否有室外机");
    _self.lengthValidFiled.push("isAllowOutdoorUnit");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("所安装位置是否允许安装室外机");
    _self.lengthValidFiled.push("isNeedFoundation");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("设备是否需要地基基础");
    _self.lengthValidFiled.push("isFoundationCondition");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("所安装位置是否具备设置地基条件");
    _self.lengthValidFiled.push("serviceVoltage");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("使用电压");
    _self.lengthValidFiled.push("isVoltageCondition");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("安装位置是否具备电压条件");
    _self.lengthValidFiled.push("isHumidityNeed");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否对温湿度有要求");
    _self.lengthValidFiled.push("humidityNeed");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("温湿度要求");
    _self.lengthValidFiled.push("isCleanlinessNeed");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否对洁净度有要求");
    _self.lengthValidFiled.push("cleanlinessNeed");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("洁净度要求");
    _self.lengthValidFiled.push("isWaterNeed");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否有用水要求");
    _self.lengthValidFiled.push("waterNeed");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("用水要求");
    _self.lengthValidFiled.push("isGasNeed");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否有用气要求");
    _self.lengthValidFiled.push("gasNeed");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("用气要求");
    _self.lengthValidFiled.push("isLet");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否是否有气体、污水排放");
    _self.lengthValidFiled.push("letNeed");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("气体、污水排放要求");
    _self.lengthValidFiled.push("isOtherNeed");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否有其他特殊要求");
    _self.lengthValidFiled.push("otherNeed");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("其他特殊要求");
    _self.lengthValidFiled.push("isNoise");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("是否有噪音");
    _self.lengthValidFiled.push("isNoiseInfluence");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("噪音是否影响安装地工作办公");
    _self.lengthValidFiled.push("aboveNeedHave");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("以上需求条件在拟安装地点是否都已具备");
    _self.lengthValidFiled.push("examineApproveEngineer");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("审批总师");
    _self.lengthValidFiled.push("professionalAuditor");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("专业审核员");
    _self.lengthValidFiled.push("competentLeader");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("主管所领导");
    _self.lengthValidFiled.push("deptHeadConclusion");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("部门领导结论");
    _self.lengthValidFiled.push("deptHeadOpinion");
    _self.lengthValidFiledSize.push(100);
    _self.lengthValidFiledComment.push("部门领导意见");
    _self.lengthValidFiled.push("professionalAuditorOpinion");
    _self.lengthValidFiledSize.push(500);
    _self.lengthValidFiledComment.push("专业审核员意见");
    _self.lengthValidFiled.push("chiefEngineerConclusion");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("总师结论");
    _self.lengthValidFiled.push("chiefEngineerOpinion");
    _self.lengthValidFiledSize.push(100);
    _self.lengthValidFiledComment.push("总师意见");
    _self.lengthValidFiled.push("competentLeaderConclusion");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("主管所领导结论");
    _self.lengthValidFiled.push("competentLeaderOpinion");
    _self.lengthValidFiledSize.push(100);
    _self.lengthValidFiledComment.push("主管所领导意见");
    _self.lengthValidFiled.push("largeDeviceType");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("简易/大型设备");
    _self.lengthValidFiled.push("instituteOrCompany");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("研究所/公司");
    _self.lengthValidFiled.push("positionId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("安装地点（未使用）");
    _self.lengthValidFiled.push("parentId");
    _self.lengthValidFiledSize.push(100);
    _self.lengthValidFiledComment.push("标准设备年度申购征集通知单id");

};
/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
AssetsSdequipCollectCm.prototype.insert = function () {
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
AssetsSdequipCollectCm.prototype.nullvalid = function (data, item, nullfiled, notnullFiledComment) {
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
AssetsSdequipCollectCm.prototype.lengthvalid = function (data, item, lengthValidFiled, lengthValidFiledComment, lengthValidFiledSize) {
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
AssetsSdequipCollectCm.prototype.valid = function () {
    var _self = this;
    $(_self._datagridId).jqGrid('endEditCell');
    var isAddRow = false; //是新增行
    var data = $(_self._datagridId).jqGrid('getChangedCells');
    var Rowdata = $(_self._datagridId).jqGrid('getRowData');
    if (Rowdata.length > 0) {
        for (var i = 0; i < Rowdata.length; i++) {
            if (Rowdata[i].id == "") {
                isAddRow = true;
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
AssetsSdequipCollectCm.prototype.save = function (pid) {
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
                    if (typeof(closeForm) != "undefined") {
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
    }
};
/**
 * 删除
 */
AssetsSdequipCollectCm.prototype.del = function () {
    debugger;
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
        $('#cb_assetsSdequipCollectCm').click();
        return false;
    }
    if (l > 0) {
        layer.confirm('确认要删除选中的数据吗?', {icon: 3, title: "提示", area: ['400px', '']}, function (index) {
            avicAjax.ajax({
                url: _self.getUrl() + 'deletecm',
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
AssetsSdequipCollectCm.prototype.reLoad = function (pid) {
    if (pid != undefined) {
        this.pid = pid;
    }
    pid = this.pid;
    var searchdata = {pid: pid};
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关闭对话框
 */
AssetsSdequipCollectCm.prototype.closeDialog = function (id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.editIndex);
    }
};
/**
 * 打开高级查询框
 */
AssetsSdequipCollectCm.prototype.openSearchForm = function (searchDiv, par) {
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
AssetsSdequipCollectCm.prototype.searchData = function () {
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
AssetsSdequipCollectCm.prototype.searchByKeyWord = function () {
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
AssetsSdequipCollectCm.prototype.hideSearchForm = function () {
    layer.close(searchDialogindex);
};
/**
 * 清空查询条件
 */
AssetsSdequipCollectCm.prototype.clearData = function () {
    clearFormData(this.searchForm);
    this.searchData();
};
AssetsSdequipCollectCm.prototype.submit = function(){
    var _self = this;
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
    }else {
        selectedRow.push($(this._datagridId).jqGrid('getRowData', selectIds[0]));
    }
    avicAjax.ajax({
        url: _self.getUrl() + "/submit",
        data: {
        data: JSON.stringify(data),
            pid: pid
    },
    type: 'post',
        dataType: 'json',
        success: function (r) {
        if (r.flag == "success") {
            _self.reLoad();
            if (typeof(closeForm) != "undefined") {
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
}

