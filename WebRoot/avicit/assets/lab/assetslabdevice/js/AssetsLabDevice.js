/**
 * 单表列表
 * @param datagrid 表格Id
 * @param url URL参数
 * @param searchDialogId 高级查询Id
 * @param form 高级查询formId
 * @param keyWordId 关键字查询框Id
 * @param searchNames 关键字查询项名称Array
 * @param dataGridColModel 表格列属性Array
 */
function AssetsLabDevice(datagrid, url, searchDialogId, form, keyWordId, searchNames, dataGridColModel ,isCellEdit) {
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
    this.notnullFiled = [];//非空字段
    this.notnullFiledComment = []; //非空字段注释
    //除时间,数字等类型长度校验字段
    this.lengthValidFiled = [];
    //除时间,数字等类型长度校验字段注释
    this.lengthValidFiledComment = [];
    //除时间,数字等类型长度
    this.lengthValidFiledSize = [];
    this.isCellEdit = isCellEdit;//是否行编辑

    this.init.call(this);

};

/**
 * 初始化操作
 */
AssetsLabDevice.prototype.init = function () {
    var _self = this;

    /*获取session的筛选数据-begin*/
    var labDeviceData = sessionStorage.getItem("labDeviceData");
    if(sessionStorage.getItem("labDeviceData")!=""){
        //sessionStorage.removeItem("labDeviceData");
    }
    var searchdata = {
        keyWord: null,
        param: labDeviceData
    }
    /*获取session的筛选数据-end*/

    $(_self._datagridId).jqGrid({
        url: 'platform/assets/lab/assetslabdevice/assetsLabDeviceController/operation/getAssetsLabDevicesByPage.json',
        mtype: 'POST',
        datatype: "json",
        postData: searchdata,//增加筛选数据
        toolbar: [true, 'top'],//启用toolbar
        colModel: _self.dataGridColModel,//表格列的属性
        height: 240 ,//初始化表格高度
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20,//每页条数
        rowList: [200, 100, 50, 30, 20, 10],//每页条数可选列表
        altRows: true,//斑马线
        pagerpos: 'left',//分页栏位置
        hasColSet: false,//设置显隐属性
        loadComplete: function () {
            $(this).jqGrid('getColumnByUserIdAndTableName');
        },
        styleUI: 'Bootstrap', //Bootstrap风格
        viewrecords: true, //是否要显示总记录数
        multiselect: true,//可多选
        multiboxonly: true,
        autowidth: true,//列宽度自适应
        responsive: true,//开启自适应
        pager: "#jqGridPager",
        cellEdit: _self.isCellEdit,//是否行编辑
        cellsubmit: 'clientArray'
    });

    //放入表格toolbar中
    $(_self._jqgridToolbar).append($("#tableToolbar"));

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
    //禁止时间和日期格式手输
    $('.date-picker').on('keydown', nullInput);
    $('.time-picker').on('keydown', nullInput);
    //初始化校验字段
    _self.notnullFiled.push("deviceName");
    _self.notnullFiledComment.push("设备名称");
    _self.lengthValidFiled.push("deviceName");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("设备名称");
    _self.notnullFiled.push("unifiedId");
    _self.notnullFiledComment.push("统一编号");
    _self.lengthValidFiled.push("unifiedId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("统一编号");
    _self.notnullFiled.push("deviceId");
    _self.notnullFiledComment.push("设备id");
    _self.lengthValidFiled.push("deviceId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("设备id");
    _self.notnullFiled.push("labId");
    _self.notnullFiledComment.push("实验室id");
    _self.lengthValidFiled.push("labId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("实验室id");
    _self.lengthValidFiled.push("labName");
    _self.lengthValidFiledSize.push(100);
    _self.lengthValidFiledComment.push("实验室名称");
    _self.lengthValidFiled.push("serialNumber");
    _self.lengthValidFiledSize.push(255);
    _self.lengthValidFiledComment.push("序号");
    _self.lengthValidFiled.push("ownerId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("责任人");
    _self.lengthValidFiled.push("ownerDept");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("责任人部门");
    _self.lengthValidFiled.push("deviceState");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("设备状态");
    _self.lengthValidFiled.push("orderState");
    _self.lengthValidFiledSize.push(10);
    _self.lengthValidFiledComment.push("预约状态");

    //给列表行绑定单击事件
    var _self = this;
    var tableList = document.getElementById('assetsLabDevicejqGrid');
    tableList.onclick = function (event) {
        /*
        *获取当前行数据
        var projectRows = $('#assetsLabDevicejqGrid').jqGrid('getGridParam','selarrrow');
        var rowData = jQuery("#assetsLabDevicejqGrid").jqGrid("getRowData", projectRows[0]);
        */

        var rowId = event.target.parentNode.id;
        var rowData = $("#assetsLabDevicejqGrid").jqGrid('getRowData', rowId);
        var deviceId = rowData.deviceId;//实验室设备id
        rowClick(deviceId, _self);
    }

    setTimeout(function () {
        if ($("#assetsLabDevicejqGrid").find("tr").get(1) != undefined) {
            var firstRowId = $("#assetsLabDevicejqGrid").find("tr").get(1).id;
            var rowData = $("#assetsLabDevicejqGrid").jqGrid('getRowData', firstRowId);
            var deviceId = rowData.deviceId;//实验室设备id
            document.getElementById(firstRowId).click();//选中当前行

            //延时首次加载甘特图数据
            //参数为实验室设备的id
            if (deviceId != ""){
                loadList(deviceId);
            }
        }
    }, 500);//等加载完成后再点击

};

/**
 * 单击方法
 */
function rowClick(deviceId, _self) {
    if (deviceId != "") {
        /**
         * 实验室预约流程筛选条件
         * 以session存储设备id数据
         */
        var labDeviceOrderData;
        labDeviceOrderData = JSON.stringify({labDeviceId:deviceId});
        sessionStorage.setItem("labDeviceOrderData",labDeviceOrderData);//以session存储设备id数据

        if(document.getElementById('labOrderIframe') != null || document.getElementById('labOrderIframe') != undefined){
            document.getElementById('labOrderIframe').contentWindow.location.reload(true);
        }

        //单击重新加载甘特图数据
        //参数为实验室设备的id
        loadList(deviceId);


    }
}


/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
AssetsLabDevice.prototype.insert = function () {
    var _self = this;
    var $info = $(_self._datagridId).jqGrid('endEditCell');
    if ($info[0].flag) {
        layer.alert("非法含有JS脚本完整标签");
        return false;
    }
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
AssetsLabDevice.prototype.nullvalid = function (data, item, nullfiled, notnullFiledComment) {
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
AssetsLabDevice.prototype.lengthvalid = function (data, item, lengthValidFiled, lengthValidFiledComment, lengthValidFiledSize) {
    var msg = "";
    $.each(data, function (i, dataitem) {
        if (dataitem[item] != "" && dataitem[item] != undefined && dataitem[item].replace(/[^\x00-\xff]/g, "**").length > lengthValidFiledSize[$.inArray(item, lengthValidFiled)]) {
            msg = lengthValidFiledComment[$.inArray(item, lengthValidFiled)] + "的输入长度超过预设长度" + lengthValidFiledSize[$.inArray(item, lengthValidFiled)];
        }
    })
    return msg;
}

/**
 * 编辑功能
 * @param form
 * @param callback
 */
AssetsLabDevice.prototype.edit = function () {
    //启用行编辑
    //获取当前行数据
    debugger;
    var projectRows = $('#assetsLabDevicejqGrid').jqGrid('getGridParam', 'selarrrow');
    // $("#assetsLabDevicejqGrid").jqGrid("editRow", projectRows[0],{ keys: true});//开启行可编辑模式
    // $("#assetsLabDevicejqGrid").editRow(projectRows[0], true);/开启行可编辑模式

    $("#assetsLabDevicejqGrid").jqGrid('setCell', projectRows[0], 'deviceName', '', 'edit-cell');

}

/**
 * 保存功能
 * @param form
 * @param callback
 */
AssetsLabDevice.prototype.save = function () {
    var _self = this;
    var $info = $(_self._datagridId).jqGrid('endEditCell');
    if ($info[0].flag) {
        layer.alert("非法含有JS脚本完整标签");
        return false;
    }
    var data = $(_self._datagridId).jqGrid('getRowData');
    var hasvalidate = true;
    $.each(_self.notnullFiled, function (i, item) {
        var msg = _self.nullvalid(data, item, _self.notnullFiled, _self.notnullFiledComment);
        if (msg && msg.length > 0) {
            layer.alert(msg, {
                    icon: 7,
                    area: ['400px', ''], //宽高
                    closeBtn: 0,
                    btn: ['关闭'],
                    title: "提示"
                }
            );
            hasvalidate = false;
            return false;
        }
    });
    $.each(_self.lengthValidFiled, function (i, item) {
        if (hasvalidate) {
            var msg = _self.lengthvalid(data, item, _self.lengthValidFiled, _self.lengthValidFiledComment, _self.lengthValidFiledSize);
            if (msg && msg.length > 0) {
                layer.alert(msg, {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0,
                        btn: ['关闭'],
                        title: "提示"
                    }
                );
                hasvalidate = false;
                return false;
            }
        }
    });
    if (!hasvalidate) {
        return false;
    }
    if (data && data.length > 0) {
        // for (var i = 0; i < data.length; i++) {
        //     if (data[i].id.indexOf(newRowStart) > -1) {
        //         data[i].id = '';
        //     }
        // }

        avicAjax.ajax({
            url: _self.getUrl() + "save",
            data: {data: JSON.stringify(data)},
            type: 'post',
            dataType: 'json',
            success: function (r) {
                if (r.flag == "success") {
                    _self.reLoad();
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
    } else {
        layer.alert('请先修改数据！', {
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
 * 详细页
 * @param id
 */
AssetsLabDevice.prototype.detail = function (id) {
    this.detailIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '详细',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //不显示最大化最小化按钮
        content: this.getUrl() + 'Detail/' + id
    });
};


/**
 * 删除
 */
AssetsLabDevice.prototype.del = function () {
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
 * 增加实验室id的筛选条件
 */
AssetsLabDevice.prototype.reLoad = function () {

    /*获取session的筛选数据-begin*/
    var labDeviceData = sessionStorage.getItem("labDeviceData");
    var obj = JSON.parse(labDeviceData);
    var labId = obj.labId;
    if(sessionStorage.getItem("labDeviceData")!=""){
        //sessionStorage.removeItem("labDeviceData");
    }
    /*获取session的筛选数据-end*/

    var jsonObj = serializeObject($(this._formId));
    jsonObj.labId = labId;//增加实验室id的筛选条件
    var searchdata = {
        keyWord: null,
        param: JSON.stringify(jsonObj)
        //param: JSON.stringify(serializeObject($(this._formId)))
    }
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};


/**
 * 打开高级查询框
 * @param searchBtn 高级查询按钮HTMLObject对象
 * @param contentWidth 高级查询框宽度
 * @param contentHeight 高级查询框高度
 */
AssetsLabDevice.prototype.openSearchForm = function (searchDiv) {
    var _self = this;
    var contentWidth = 800;
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
        area: [contentWidth + 'px', '200px'],
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
            layer.close(index);//查询框关闭
        },
        btn2: function (index, layero) {
            clearFormData(_self._formId); //清空数据
            _self.searchData(); //查询
            return false;
        },
        btn3: function (index, layero) {

        }
    });
};

/**
 * 高级查询
 */
AssetsLabDevice.prototype.searchData = function () {
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


    /*获取session的筛选数据-begin*/
    var labDeviceData = sessionStorage.getItem("labDeviceData");
    var obj = JSON.parse(labDeviceData);
    var labId = obj.labId;
    if(sessionStorage.getItem("labDeviceData")!=""){
        //sessionStorage.removeItem("labDeviceData");
    }
    /*获取session的筛选数据-end*/

    var jsonObj = serializeObject($(this._formId));
    jsonObj.labId = labId;//增加实验室id的筛选条件
    var searchdata = {
        keyWord: null,
        param: JSON.stringify(jsonObj)
        //param: JSON.stringify(serializeObject($(this._formId)))
    }

    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};

/**
 * 关键字查询
 */
AssetsLabDevice.prototype.searchByKeyWord = function () {
    var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr("placeholder") ? "" : $(this._keyWordId).val();
    var names = this._searchNames;

    var param = {};
    for (var i in names) {
        var name = names[i];
        param[name] = keyWord;
    }


    /*获取session的筛选数据-begin*/
    var labDeviceData = sessionStorage.getItem("labDeviceData");
    var obj = JSON.parse(labDeviceData);
    var labId = obj.labId;
    if(sessionStorage.getItem("labDeviceData")!=""){
        //sessionStorage.removeItem("labDeviceData");
    }
    /*获取session的筛选数据-end*/

    param.labId = labId;//搜索框搜索增加实验室id条件，且实验室id在xml的sql语句中为and的必要条件

    var searchdata = {
        keyWord: JSON.stringify(param),
        param: null
    }

    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
}


/* 设备通用选择框选择回填 */
function addAssetsRow(rowJson) {
    //获取列表中的数据
    var allData = $('#assetsLabDevicejqGrid').jqGrid('getRowData');
    //判断列表中的数据是否为空
    if((allData != null) && (allData != undefined) && (allData.length>0)){
        for(j=0; j<allData.length; j++){
            //判断是否已添加
            if(allData[j].unifiedId == rowJson.unifiedId){
                layer.msg('编号' + rowJson.unifiedId +'的设备已添加！');
                return;
            }
        }
    }
    var newRowId = newRowStart + newRowIndex;
    var parameters = {
        rowID: newRowId,
        initdata: rowJson,
        position: "first",
        useDefValues: true,
        useFormatter: true,
        addRowParams: {extraparam: {}}
    };
    $('#assetsLabDevicejqGrid').jqGrid('addRow', parameters);

    newRowIndex++;
};

//弹框选择设备台账的回调函数
function callBackFn(rows, requestType) {
    switch (requestType) {
        case "productModelSelect":
            for(i=0; i<rows.length; i++){
                var row = rows[i];
                var rowJson = {};
                /*获取session的筛选数据-begin*/
                var labInfo = sessionStorage.getItem("labDeviceData");
                if(sessionStorage.getItem("labDeviceData")!=""){
                    //sessionStorage.removeItem("labDeviceData");
                }
                /*获取session的筛选数据-end*/

                var obj = JSON.parse(labInfo);
                var labId = obj.labId;
                var labName = obj.labName;
                if(labId == null || labId.length == 0){
                    //实验室id为空则提示
                    layer.alert('请选择实验室！', {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0,
                        btn: ['关闭'],
                        title:"提示"
                    });
                    break;
                }

                rowJson.labId = labId;      //使用当前选中实验室的id
                rowJson.labName = labName;  //使用当前选中实验室的名称
                rowJson.deviceName = row.deviceName;
                rowJson.unifiedId = row.unifiedId;
                rowJson.deviceId = row.id;

                rowJson.ownerId = row.ownerId;
                rowJson.ownerIdAlias = row.ownerIdAlias;
                rowJson.ownerDept = row.ownerDept;
                rowJson.ownerDeptAlias = row.ownerDeptAlias;

                addAssetsRow(rowJson);
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
    sessionStorage.setItem("param",param);
    this.openIndex = layer.open({
        type: 2,
        area: ['65%', '85%'],
        title: '台账信息选择',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/assetsdeviceaccount/AssetsDeviceAccountSelect.jsp?singleSelect="+singleSelect+"&requestType="+requestType+"&callBackFn="+callBackFn

    });
};
