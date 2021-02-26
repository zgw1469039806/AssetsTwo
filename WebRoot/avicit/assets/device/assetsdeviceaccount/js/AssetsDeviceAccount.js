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

function AssetsDeviceAccount(datagrid, url, searchD, form, keyWordId, searchNames, dataGridColModel) {
    if (!datagrid || typeof(datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = "platform/assets/device/assetsdeviceaccount/assetsDeviceAccountController/operation/";
    this.getUrl = function () {
        return _url;
    }
    this._datagridId = "#" + datagrid;
    this._jqgridToolbar = "#t_" + datagrid;
    this._doc = document;
    this._formId = "#" + form;
    this._searchDialogId = "#" + searchD;
    this._keyWordId = "#" + keyWordId;
    this._searchNames = searchNames;
    this.dataGridColModel = dataGridColModel;
    this.init.call(this);
};


/**
 * 初始化操作
 */
AssetsDeviceAccount.prototype.init = function () {
    var _self = this;

    /*获取session的筛选数据-begin*/
    var classData = sessionStorage.getItem("classData");
    if(sessionStorage.getItem("classData")!=""){
        sessionStorage.removeItem("classData");
    }
    var searchdata = {
        keyWord: null,
        param: classData
    }
    /*获取session的筛选数据-end*/

    $(_self._datagridId).jqGrid({
        url: _self.getUrl() + 'getAssetsDeviceAccountsByPage.json',
        mtype: 'POST',
        datatype: "json",
        postData: searchdata,//增加筛选数据
        toolbar: [true, 'top'],
        colModel: _self.dataGridColModel,
        height: $(window).height()*2/5,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 10,
        rowList: [200, 100, 50, 30, 20, 10],
        altRows: true,
        userDataOnFooter: true,
        pagerpos: 'left',
        hasColSet: false,//设置显隐属性
        loadComplete: function () {
            $(this).jqGrid('getColumnByUserIdAndTableName');
        },
        styleUI: 'Bootstrap',
        viewrecords: true,
        multiselect: true,
        multiboxonly: true,
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

    //单击延时触发
    var clickTimeId;
    //给列表行绑定单击事件
    var _self = this;
    var tableList = document.getElementById('assetsDeviceAccountjqGrid');
    tableList.onclick = function (event){
        var rowId = event.target.parentNode.id;
        // 取消上次延时未执行的方法
        clearTimeout(clickTimeId);
        //执行延时
        clickTimeId = setTimeout(rowClick(rowId, _self), 250);
    }
    tableList.ondblclick = function (event) {
        // 取消上次延时未执行的方法
        clearTimeout(clickTimeId);
        var rowId = event.target.parentNode.id;
        assetsDeviceAccount.detail(rowId);
    }

    setTimeout(function () {
        if($("#assetsDeviceAccountjqGrid").find("tr").get(1) != undefined){
            var firstRowId = $("#assetsDeviceAccountjqGrid").find("tr").get(1).id;
            document.getElementById(firstRowId).click();//选中当前行
            rowClick(firstRowId, _self);
        }
    },1500);
};



/**
 * 单击方法
 */
function rowClick(rowId, _self){
    //构建列表页下的台账详情begin
    if (rowId != "") {
        avicAjax.ajax({
            url: _self.getUrl() + 'getAccountDetail',
            type: 'POST',
            async: true,
            dataType: 'json',
            data: JSON.stringify({"id": rowId}),
            contentType: "application/json",
            success: function (assetsDeviceAccountDTOMap) {
                //成功回调

                //设备类别select字符串
                var deviceCategoryName = "";
                for (i = 0; i < assetsDeviceAccountDTOMap["deviceCategoryList"].length; i++) {
                    var selectIndex = assetsDeviceAccountDTOMap["deviceCategoryList"][i].lookupCode;
                    var selectName = assetsDeviceAccountDTOMap["deviceCategoryList"][i].lookupName;
                    if (selectIndex == assetsDeviceAccountDTOMap["assetsAccountDTO"].deviceCategory) {
                        deviceCategoryName = selectName;
                    } else {
                    }
                }
                var unifiedId = assetsDeviceAccountDTOMap["assetsAccountDTO"].unifiedId;
                var deviceName = assetsDeviceAccountDTOMap["assetsAccountDTO"].deviceName;
                var deviceCategory = assetsDeviceAccountDTOMap["assetsAccountDTO"].deviceCategory;
                var deviceModel = assetsDeviceAccountDTOMap["assetsAccountDTO"].deviceModel;
                var manufacturerId = assetsDeviceAccountDTOMap["assetsAccountDTO"].manufacturerId;
                var ownerId = assetsDeviceAccountDTOMap["assetsAccountDTO"].ownerId;
                var ownerIdAlias = assetsDeviceAccountDTOMap["assetsAccountDTO"].ownerIdAlias;
                var ownerDept = assetsDeviceAccountDTOMap["assetsAccountDTO"].ownerDept;
                var ownerDeptAlias = assetsDeviceAccountDTOMap["assetsAccountDTO"].ownerDeptAlias;
                var positionId = assetsDeviceAccountDTOMap["assetsAccountDTO"].positionId;
                var productDate = assetsDeviceAccountDTOMap["assetsAccountDTO"].productDate;
                var userId = assetsDeviceAccountDTOMap["assetsAccountDTO"].userId;
                var userIdAlias = assetsDeviceAccountDTOMap["assetsAccountDTO"].userIdAlias;
                var userDept = assetsDeviceAccountDTOMap["assetsAccountDTO"].userDept;
                var userDeptAlias = assetsDeviceAccountDTOMap["assetsAccountDTO"].userDeptAlias;
                /**
                 * 台账子表筛选条件
                 * 以session存储分类数据
                 */
                var deviceAccountData;
                deviceAccountData = JSON.stringify({
                    unifiedId:unifiedId,
                    deviceName:deviceName,
                    deviceCategory:deviceCategory,
                    deviceCategoryName:deviceCategoryName,
                    deviceModel:deviceModel,
                    manufacturerId:manufacturerId,
                    ownerId:ownerId,
                    ownerIdAlias:ownerIdAlias,
                    ownerDept:ownerDept,
                    ownerDeptAlias:ownerDeptAlias,
                    positionId:positionId,
                    productDate:productDate,
                    userId:userId,
                    userIdAlias:userIdAlias,
                    userDept:userDept,
                    userDeptAlias:userDeptAlias
                });
                sessionStorage.setItem("deviceAccountData",deviceAccountData);//以session存储设备台账数据


                //解析数据begin
                //设备类别select字符串
                var str_deviceCategory = "";
                for (i = 0; i < assetsDeviceAccountDTOMap["deviceCategoryList"].length; i++) {
                    var selectIndex = assetsDeviceAccountDTOMap["deviceCategoryList"][i].lookupCode;
                    var selectName = assetsDeviceAccountDTOMap["deviceCategoryList"][i].lookupName;
                    if (selectIndex == assetsDeviceAccountDTOMap["assetsAccountDTO"].deviceCategory) {
                        str_deviceCategory += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_deviceCategory += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }


                //统管设备状态select字符串
                var str_manageState = "";
                for (i = 0; i < assetsDeviceAccountDTOMap["manageStateList"].length; i++) {
                    var selectIndex = assetsDeviceAccountDTOMap["manageStateList"][i].lookupCode;
                    var selectName = assetsDeviceAccountDTOMap["manageStateList"][i].lookupName;
                    if (selectIndex == assetsDeviceAccountDTOMap["assetsAccountDTO"].manageState) {
                        str_manageState += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_manageState += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }
                //设备状态select字符串
                var str_deviceState = "";
                for (i = 0; i < assetsDeviceAccountDTOMap["deviceStateList"].length; i++) {
                    var selectIndex = assetsDeviceAccountDTOMap["deviceStateList"][i].lookupCode;
                    var selectName = assetsDeviceAccountDTOMap["deviceStateList"][i].lookupName;
                    if (selectIndex == assetsDeviceAccountDTOMap["assetsAccountDTO"].deviceState) {
                        str_deviceState += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_deviceState += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }
                //ABC分类select字符串
                var str_abcCategory = "";
                for (i = 0; i < assetsDeviceAccountDTOMap["abcCategoryList"].length; i++) {
                    var selectIndex = assetsDeviceAccountDTOMap["abcCategoryList"][i].lookupCode;
                    var selectName = assetsDeviceAccountDTOMap["abcCategoryList"][i].lookupName;
                    if (selectIndex == assetsDeviceAccountDTOMap["assetsAccountDTO"].abcCategory) {
                        str_abcCategory += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_abcCategory += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }
                //资产财务类别select字符串
                var str_assetsFinanceType = "";
                for (i = 0; i < assetsDeviceAccountDTOMap["assetsFinanceTypeList"].length; i++) {
                    var selectIndex = assetsDeviceAccountDTOMap["assetsFinanceTypeList"][i].lookupCode;
                    var selectName = assetsDeviceAccountDTOMap["assetsFinanceTypeList"][i].lookupName;
                    if (selectIndex == assetsDeviceAccountDTOMap["assetsAccountDTO"].assetsFinanceType) {
                        str_assetsFinanceType += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_assetsFinanceType += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }
                //资产来源select字符串
                var str_assetsSource = "";
                for (i = 0; i < assetsDeviceAccountDTOMap["assetsSourceList"].length; i++) {
                    var selectIndex = assetsDeviceAccountDTOMap["assetsSourceList"][i].lookupCode;
                    var selectName = assetsDeviceAccountDTOMap["assetsSourceList"][i].lookupName;
                    if (selectIndex == assetsDeviceAccountDTOMap["assetsAccountDTO"].assetsSource) {
                        str_assetsSource += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_assetsSource += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }
                //资产来源select字符串
                var str_assetsFinanceState = "";
                for (i = 0; i < assetsDeviceAccountDTOMap["assetsFinanceStateList"].length; i++) {
                    var selectIndex = assetsDeviceAccountDTOMap["assetsFinanceStateList"][i].lookupCode;
                    var selectName = assetsDeviceAccountDTOMap["assetsFinanceStateList"][i].lookupName;
                    if (selectIndex == assetsDeviceAccountDTOMap["assetsAccountDTO"].assetsFinanceState) {
                        str_assetsFinanceState += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_assetsFinanceState += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }
                //研究所/公司select字符串
                var str_instituteOrCompany = "";
                for (i = 0; i < assetsDeviceAccountDTOMap["instituteOrCompanyList"].length; i++) {
                    var selectIndex = assetsDeviceAccountDTOMap["instituteOrCompanyList"][i].lookupCode;
                    var selectName = assetsDeviceAccountDTOMap["instituteOrCompanyList"][i].lookupName;
                    if (selectIndex == assetsDeviceAccountDTOMap["assetsAccountDTO"].instituteOrCompany) {
                        str_instituteOrCompany += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_instituteOrCompany += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }
                //平台公用是否select字符串
                var str_yesNo = "";
                for (i = 0; i < assetsDeviceAccountDTOMap["yesNoList"].length; i++) {
                    var selectIndex = assetsDeviceAccountDTOMap["yesNoList"][i].lookupCode;
                    var selectName = assetsDeviceAccountDTOMap["yesNoList"][i].lookupName;
                    if (selectIndex == assetsDeviceAccountDTOMap["assetsAccountDTO"].METERING_MODE) {
                        str_yesNo += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_yesNo += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }
                //计量结论select字符串
                var str_meteringConclution = "";
                for (i = 0; i < assetsDeviceAccountDTOMap["meteringConclusionList"].length; i++) {
                    var selectIndex = assetsDeviceAccountDTOMap["meteringConclusionList"][i].lookupCode;
                    var selectName = assetsDeviceAccountDTOMap["meteringConclusionList"][i].lookupName;
                    if (selectIndex == assetsDeviceAccountDTOMap["assetsAccountDTO"].meteringConclution) {
                        str_meteringConclution += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_meteringConclution += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }

                //计量结论select字符串
                var str_meteringMode = "";
                for (i = 0; i < assetsDeviceAccountDTOMap["meteringModeList"].length; i++) {
                    var selectIndex = assetsDeviceAccountDTOMap["meteringModeList"][i].lookupCode;
                    var selectName = assetsDeviceAccountDTOMap["meteringModeList"][i].lookupName;
                    if (selectIndex == assetsDeviceAccountDTOMap["assetsAccountDTO"].isSceneMetering) {
                        str_meteringMode += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_meteringMode += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }
                //解析数据end


                <!--基本信息tab页begin-->
                $("#BasicInfo").html("<table class=\"form_commonTable\">\n" +
                    "<tr>\n" +
                    "                    <!-- 资产编号 -->\n" +
                    "                   <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"assetId\">资产编号:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'assetId' id='assetId' value='" + assetsDeviceAccountDTOMap["assetsAccountDTO"].assetId + "' />" +
                    "                    </td>\n" +
                    "                    <!-- 统一编号 -->\n" +
                    "                   <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"unifiedId\">统一编号:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'unifiedId' id='unifiedId' value='" + assetsDeviceAccountDTOMap["assetsAccountDTO"].unifiedId + "' />" +
                    "                    </td>\n" +
                    "                    <!-- 设备类别 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"deviceCategory\">设备类别:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                       <select class= 'form-control input-sm' disabled='disabled' name= 'deviceCategory' id= 'deviceCategory' title='' isNull='true'>" + str_deviceCategory + "</select>" +
                    "                    </td>\n" +
                    "                    <!-- 设备名称 -->\n" +
                    "                   <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"deviceName\">设备名称:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'deviceName' id='deviceName' value='" + assetsDeviceAccountDTOMap["assetsAccountDTO"].deviceName + "' />" +
                    "                    </td>\n" +
                    "</tr>" +
                    "<tr>\n" +
                    "                    <!-- 设备型号 -->\n" +
                    "                   <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"deviceModel\">设备型号:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'deviceModel' id='deviceModel' value='" + assetsDeviceAccountDTOMap["assetsAccountDTO"].deviceModel + "' />" +
                    "                    </td>\n" +
                    "                    <!-- 设备规格 -->\n" +
                    "                   <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"deviceSpec\">设备规格:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'deviceSpec' id='deviceSpec' value='" + assetsDeviceAccountDTOMap["assetsAccountDTO"].deviceSpec + "' />" +
                    "                    </td>\n" +
                    "                  <!-- 责任人 -->\n" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"ownerIdAlias\">责任人:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <div class=\"input-group  input-group-sm\">\n" +
                    "                                <input type=\"hidden\" id=\"ownerId\" name=\"ownerId\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].ownerId + "\"/>\n" +
                    "                                <input class=\"form-control\" placeholder=\"请选择用户\" type=\"text\" id=\"ownerIdAlias\"\n" +
                    "                                       readonly=\"readonly\" name=\"ownerIdAlias\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].ownerIdAlias + "\"/>\n" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "<i class=\"glyphicon glyphicon-user\"></i>\n" +
                    "</span>\n" +
                    "                            </div>\n" +
                    "                        </td>" +
                    "                  <!-- 责任人部门 -->\n" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"ownerDeptAlias\">责任人部门:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <div class=\"input-group  input-group-sm\">\n" +
                    "                                <input type=\"hidden\" id=\"ownerDept\" name=\"ownerDept\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].ownerDept + "\"/>\n" +
                    "                                <input class=\"form-control\" placeholder=\"请选择部门\" type=\"text\" id=\"ownerDeptAlias\"\n" +
                    "                                       readonly=\"readonly\" name=\"ownerDeptAlias\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].ownerDeptAlias + "\"/>\n" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "<i class=\"glyphicon glyphicon-equalizer\"></i>\n" +
                    "</span>\n" +
                    "                            </div>\n" +
                    "                        </td>" +
                    "</tr>" +
                    "<tr>" +
                    "                  <!-- 使用人 -->\n" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"userIdAlias\">使用人:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <div class=\"input-group  input-group-sm\">\n" +
                    "                                <input type=\"hidden\" id=\"userId\" name=\"userId\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].userId + "\"/>\n" +
                    "                                <input class=\"form-control\" placeholder=\"请选择用户\" type=\"text\" id=\"userIdAlias\"\n" +
                    "                                       readonly=\"readonly\" name=\"userIdAlias\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].userIdAlias + "\"/>\n" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "<i class=\"glyphicon glyphicon-user\"></i>\n" +
                    "</span>\n" +
                    "                            </div>\n" +
                    "                        </td>" +
                    "                  <!-- 使用人部门 -->\n" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"userDeptAlias\">使用人部门:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <div class=\"input-group  input-group-sm\">\n" +
                    "                                <input type=\"hidden\" id=\"userDept\" name=\"userDept\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].userDept + "\"/>\n" +
                    "                                <input class=\"form-control\" placeholder=\"请选择部门\" type=\"text\" id=\"userDeptAlias\"\n" +
                    "                                       readonly=\"readonly\" name=\"userDeptAlias\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].userDeptAlias + "\"/>\n" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "<i class=\"glyphicon glyphicon-equalizer\"></i>\n" +
                    "</span>\n" +
                    "                            </div>\n" +
                    "                        </td>" +
                    "                    <!-- 生产厂家 -->\n" +
                    "                   <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"manufacturerId\">生产厂家:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'manufacturerId' id='manufacturerId' value='" + assetsDeviceAccountDTOMap["assetsAccountDTO"].manufacturerId + "' />" +
                    "                    </td>\n" +
                    "                    <!-- 立卡日期 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"createdDate\">立卡日期:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'createdDate' id='createdDate' value=" + formatDate(assetsDeviceAccountDTOMap["assetsAccountDTO"].createdDate) + " />" +
                    "                    </td>" +
                    "</tr>" +
                    "<tr>" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"monthCount\">质保期:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"guaranteePeriod\" id=\"guaranteePeriod\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].guaranteePeriod + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "      </td>\n" +

                    "                    <!-- 质保截止日期 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"createdDate\">质保截止日期:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'guaranteeDate' id='guaranteeDate' value=" + formatDate(assetsDeviceAccountDTOMap["assetsAccountDTO"].guaranteeDate) + " />" +
                    "                    </td>" +
                    "</tr>" +
                    "</table>");
                <!--基本信息tab页end-->
                <!--财务信息tab页end-->
                $("#FinanceInfo").html("<table class=\"form_commonTable\">\n" +
                    "<tr>\n" +
                    "                    <!-- 资产财务类别 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"assetsFinanceType\">资产财务类别:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                       <select class= 'form-control input-sm' disabled='disabled' name= 'assetsFinanceType' id= 'assetsFinanceType' title='' isNull='true'>" + str_assetsFinanceType + "</select>" +
                    "                    </td>\n" +
                    "                  <!-- 资产来源 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"assetsSource\">资产来源:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                       <select class= 'form-control input-sm' disabled='disabled' name= 'assetsSource' id= 'assetsSource' title='' isNull='true'>" + str_assetsSource + "</select>" +
                    "                    </td>\n" +
                    "                    <!-- 资产财务状态 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"assetsFinanceState\">资产财务状态:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                       <select class= 'form-control input-sm' disabled='disabled' name= 'assetsFinanceState' id= 'assetsFinanceState' title='' isNull='true'>" + str_assetsFinanceState + "</select>" +
                    "                    </td>\n" +
                    "                    <!-- 财务入账时间 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"financeEntryDate\">财务入账时间:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'financeEntryDate' id='financeEntryDate' value=" + formatDate(assetsDeviceAccountDTOMap["assetsAccountDTO"].financeEntryDate) + " />" +
                    "                    </td>" +
                    "</tr>" +
                    "<tr>\n" +
                    "                    <!-- 原值 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"originalValue\">原值:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"originalValue\" id=\"originalValue\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].assetsSource + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "                    </td>\n" +
                    "                    <!-- 累计折旧 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"totalDepreciation\">累计折旧:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"totalDepreciation\" id=\"totalDepreciation\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].totalDepreciation + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "                    </td>\n" +

                    "                    <!-- 折旧方法 -->\n" +
                    "                   <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"originalValue\">折旧方法:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'assetsFinanceState' id='assetsFinanceState' value='" + assetsDeviceAccountDTOMap["assetsAccountDTO"].depreciationMethod + "' />" +
                    "                    </td>\n" +
                    "                    <!-- 折旧年限 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"depreciationYear\">折旧年限:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"depreciationYear\" id=\"depreciationYear\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].depreciationYear + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "</td>\n" +
                    "</tr>" +

                    "<tr>\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"netSalvage\">净残值:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"netSalvage\" id=\"netSalvage\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].netSalvage + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "      </td>\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"monthDepreciationRate\">月折旧率:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"monthDepreciationRate\" id=\"monthDepreciationRate\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].monthDepreciationRate + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "      </td>\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"monthDepreciation\">月折旧额:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"monthDepreciation\" id=\"monthDepreciation\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].monthDepreciation + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "      </td>\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"yearDepreciationRate\">年折旧率:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"yearDepreciationRate\" id=\"yearDepreciationRate\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].yearDepreciationRate + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "      </td>\n" +
                    "</tr>" +

                    "<tr>\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"yearDepreciation\">年折旧额:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"yearDepreciation\" id=\"yearDepreciation\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].yearDepreciation + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "      </td>\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"netValue\">净值:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"netValue\" id=\"netValue\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].netValue + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "      </td>\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"monthCount\">已提月份:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"monthCount\" id=\"monthCount\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].monthCount + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "      </td>\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"monthRemain\">未计提月份:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"monthRemain\" id=\"monthRemain\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].monthRemain + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "      </td>\n" +
                    "</tr>" +

                    "<tr>\n" +
                    "                    <!-- 研究所/公司 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"instituteOrCompany\">研究所/公司:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                       <select class= 'form-control input-sm' disabled='disabled' name= 'instituteOrCompany' id= 'instituteOrCompany' title='' isNull='true'>" + str_instituteOrCompany + "</select>" +
                    "                    </td>\n" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"proofNum\">凭证编号:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <input class=\"form-control input-sm\" type=\"text\" name=\"proofNum\" id=\"proofNum\" readonly=\"readonly\"\n" +
                    "                                   value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].proofNum + "\"/>\n" +
                    "                        </td>" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"contractNum\">合同号:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <input class=\"form-control input-sm\" type=\"text\" name=\"contractNum\" id=\"contractNum\" readonly=\"readonly\"\n" +
                    "                                   value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].contractNum + "\"/>\n" +
                    "                        </td>" +
                    "</tr>" +
                    "</table>");
                <!--财务信息tab页end-->

                <!--计算机信息tab页begin-->
                $("#ComputerInfo").html("<table class=\"form_commonTable\">\n" +
                    "<tr>\n" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"ip\">IP地址:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <input class=\"form-control input-sm\" type=\"text\" name=\"ip\" id=\"ip\" readonly=\"readonly\"\n" +
                    "                                   value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].ip + "\"/>\n" +
                    "                        </td>" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"mac\">MAC地址:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <input class=\"form-control input-sm\" type=\"text\" name=\"mac\" id=\"mac\" readonly=\"readonly\"\n" +
                    "                                   value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].mac + "\"/>\n" +
                    "                        </td>" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"diskNum\">硬盘序列号:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <input class=\"form-control input-sm\" type=\"text\" name=\"diskNum\" id=\"diskNum\" readonly=\"readonly\"\n" +
                    "                                   value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].diskNum + "\"/>\n" +
                    "                        </td>" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"os\">操作系统:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <input class=\"form-control input-sm\" type=\"text\" name=\"os\" id=\"os\" readonly=\"readonly\"\n" +
                    "                                   value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].os + "\"/>\n" +
                    "                        </td>" +
                    "</tr>" +

                    "<tr>\n" +
                    "<!-- 操作系统安装时间 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"osInstallDate\">操作系统安装时间:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'osInstallDate' id='osInstallDate' value=" + formatDate(assetsDeviceAccountDTOMap["assetsAccountDTO"].osInstallDate) + " />" +
                    "                    </td>" +
                    "</tr>" +
                    "</table>");
                <!--计算机信息tab页end-->

                <!--计量信息tab页begin-->
                $("#MeteringInfo").html("<table class=\"form_commonTable\">\n" +
                    "<tr>\n" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"meteringId\">计量文件受控号:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <input class=\"form-control input-sm\" type=\"text\" name=\"meteringId\" id=\"meteringId\" readonly=\"readonly\"\n" +
                    "                                   value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].meteringId + "\"/>\n" +
                    "                        </td>" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"metermanAlias\">计量人员:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <div class=\"input-group  input-group-sm\">\n" +
                    "                                <input type=\"hidden\" id=\"meterman\" name=\"meterman\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].meterman + "\"/>\n" +
                    "                                <input class=\"form-control\" placeholder=\"请选择用户\" type=\"text\" id=\"metermanAlias\"\n" +
                    "                                       readonly=\"readonly\" name=\"metermanAlias\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].metermanAlias + "\"/>\n" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "<i class=\"glyphicon glyphicon-user\"></i>\n" +
                    "</span>\n" +
                    "                            </div>\n" +
                    "                        </td>" +
                    "                    <!-- 计量时间 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"meteringDate\">计量时间:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm\">"+
                    "                        <input  class = 'form-control date-picker'  type='text' name = 'meteringDate' id='meteringDate' readonly='readonly' value=" + formatDate(assetsDeviceAccountDTOMap["assetsAccountDTO"].meteringDate) + " />" +
                    "<span class=\"input-group-addon\"><i class=\"glyphicon glyphicon-calendar\"></i></span>"+
                    "</div>"+
                    "                    </td>" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"meteringCycle\">计量周期:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"meteringCycle\" id=\"meteringCycle\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].meteringCycle + "\" \n" +
                    "                               data-min=\"-9.99999999999999E11\"\n" +
                    "                               data-max=\"9.99999999999999E11\" data-step=\"1\" data-precision=\"3\">" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "    <a href=\"javascript:;\" class=\"spin-up\" data-spin=\"up\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-top\"></i></a>\n" +
                    "    <a href=\"javascript:;\" class=\"spin-down\" data-spin=\"down\"><i\n" +
                    "                                                        class=\"glyphicon glyphicon-triangle-bottom\"></i></a>\n" +
                    "</span>\n" +
                    "</div>" +
                    "      </td>\n" +
                    "</tr>" +


                    "<tr>\n" +
                    "                    <!-- 上次计量日期 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"lastMeteringDate\">上次计量日期:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'lastMeteringDate' id='lastMeteringDate' value=" + formatDate(assetsDeviceAccountDTOMap["assetsAccountDTO"].lastMeteringDate) + " />" +
                    "                    </td>" +
                    "                    <!-- 下次计量日期 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"nextMeteringDate\">下次计量日期:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'nextMeteringDate' id='nextMeteringDate' value=" + formatDate(assetsDeviceAccountDTOMap["assetsAccountDTO"].nextMeteringDate) + " />" +
                    "                    </td>" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"planMetermanAlias\">计量计划员:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <div class=\"input-group  input-group-sm\">\n" +
                    "                                <input type=\"hidden\" id=\"planMeterman\" name=\"planMeterman\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].planMeterman + "\"/>\n" +
                    "                                <input class=\"form-control\" placeholder=\"请选择用户\" type=\"text\" id=\"planMetermanAlias\"\n" +
                    "                                       readonly=\"readonly\" name=\"planMetermanAlias\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].planMetermanAlias + "\"/>\n" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "<i class=\"glyphicon glyphicon-user\"></i>\n" +
                    "</span>\n" +
                    "                            </div>\n" +
                    "                        </td>" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"meteringDeptAlias\">计量单位:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <div class=\"input-group  input-group-sm\">\n" +
                    "                                <input type=\"hidden\" id=\"meteringDept\" name=\"meteringDept\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].meteringDept + "\"/>\n" +
                    "                                <input class=\"form-control\" placeholder=\"请选择部门\" type=\"text\" id=\"meteringDeptAlias\"\n" +
                    "                                       readonly=\"readonly\" name=\"meteringDeptAlias\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].meteringDeptAlias + "\"/>\n" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "<i class=\"glyphicon glyphicon-equalizer\"></i>\n" +
                    "</span>\n" +
                    "                            </div>\n" +
                    "                        </td>" +
                    "</tr>" +

                    "<tr>\n" +
                    "<!-- 计量方式 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"isSceneMetering\">计量方式:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                       <select class= 'form-control input-sm' disabled='disabled' name= 'isSceneMetering' id= 'isSceneMetering' title='' isNull='true'>" + str_meteringMode + "</select>" +
                    "                    </td>\n" +
                    "<!-- 计量结论 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"meteringConclution\">计量结论:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                       <select class= 'form-control input-sm' disabled='disabled' name= 'meteringConclution' id= 'meteringConclution' title='' isNull='true'>" + str_meteringConclution + "</select>" +
                    "                    </td>\n" +
                    "<!-- 计量外送员 -->\n" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"meteringOuterAlias\">计量外送员:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <div class=\"input-group  input-group-sm\">\n" +
                    "                                <input type=\"hidden\" id=\"meteringOuter\" name=\"meteringOuter\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].meteringOuter + "\"/>\n" +
                    "                                <input class=\"form-control\" placeholder=\"请选择用户\" type=\"text\" id=\"meteringOuterAlias\"\n" +
                    "                                       readonly=\"readonly\" name=\"meteringOuterAlias\"\n" +
                    "                                       value=\"" + assetsDeviceAccountDTOMap["assetsAccountDTO"].meteringOuterAlias + "\"/>\n" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "<i class=\"glyphicon glyphicon-user\"></i>\n" +
                    "</span>\n" +
                    "                            </div>\n" +
                    "                        </td>" +

                    "</tr>" +

                    "</table>");
                <!--计量信息tab页end-->



                <!--安全信息tab页begin-->
                $("#SafeInfoTab").html("<table class=\"form_commonTable\">\n" +
                "<tr>\n" +
                        "<!-- 安全信息 -->\n" +
                        "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                        "                        <label for=\"SafeInfoTab\">安全信息:</label></th>\n" +
                        "                    <td width=\"15%\">\n" +
                        "                       <input class= 'form-control input-sm' type='text' name= 'SafeInfoTab' id= 'SafeInfoTab' readonly='readonly' value="+ assetsDeviceAccountDTOMap["assetsAccountDTO"].safeInfo +">"+
                        "                    </td>\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                    <td width=\"15%\">\n" +
                    "                    </td>\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                    <td width=\"15%\">\n" +
                    "                    </td>\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                    <td width=\"15%\">\n" +
                    "                    </td>\n" +
                "</tr>" +
                "</table>");
                <!--安全信息tab页end-->
            }
        });

        $('.date-picker').datepicker({
            beforeShow: function () {
                setTimeout(function () {
                    $('#ui-datepicker-div').css("z-index", 99999999);
                }, 100);
            }
        });

        <!-- 构建附件列表begin -->
        var tdArr = document.getElementById('DYN_SUB').firstElementChild;
        //删除可能存在的已构建的附件行
        var attachmentRowList = document.getElementsByName("attachmentRow");
        if (attachmentRowList != null) {
            var attachmentRowListLength = attachmentRowList.length;
            // for(i = attachmentRowListLength-1; i > -1; i--){
            //     attachmentRowList[i].remove();
            // }
            while (attachmentRowList.length > 0) {
                attachmentRowList[0].remove();
            }
        }
        //var AttachmentTabChoosed = document.getElementsByClassName('tab-pane active')[0].outerHTML.indexOf('Attachment');
        //if(!((isSameRow == "Y") && (AttachmentTabChoosed != -1))){
        if (true) {
            avicAjax.ajax({
                url:  _self.getUrl() + 'getAttachmentList',
                //_self.getUrl() = platform/assets/device/assetsdeviceaccount/assetsDeviceAccountController/operation/
                type: 'POST',
                async: true,
                dataType: 'json',
                data: JSON.stringify({"id": rowId}),
                contentType: "application/json",
                success: function (assetsDeviceAccountDTOMap) {
                    for (i = 0; i < assetsDeviceAccountDTOMap["attachmentList"].length; i++) {
                        var index = i + 1;
                        var unified_id = assetsDeviceAccountDTOMap["attachmentList"][i].unifiedId;
                        var deviceName = assetsDeviceAccountDTOMap["attachmentList"][i].deviceName;
                        var deviceModel = assetsDeviceAccountDTOMap["attachmentList"][i].deviceModel;
                        var deviceSpec = assetsDeviceAccountDTOMap["attachmentList"][i].deviceSpec;
                        var ownerId = assetsDeviceAccountDTOMap["attachmentList"][i].ownerId;
                        var ownerIdAlias = assetsDeviceAccountDTOMap["attachmentList"][i].ownerIdAlias;
                        var positionId = assetsDeviceAccountDTOMap["attachmentList"][i].positionId;
                        var tr = document.createElement("tr");
                        tr.setAttribute("name", "attachmentRow");
                        tr.innerHTML =
                            '<td>' + index + '</td>' +
                            '<td>' + unified_id + '</td>' +
                            '<td>' + deviceName + '</td>' +
                            '<td>' + deviceModel + '</td>' +
                            '<td>' + deviceSpec + '</td>' +
                            '<td>' + ownerIdAlias + '</td>' +
                            '<td>' + positionId + '</td>';
                        ;
                        tdArr.appendChild(tr);
                    }
                }
            });
        }
        <!-- 构建附件列表end -->

        <!-- 子表信息begin -->
        var unifiedId = "";
        avicAjax.ajax({
            url: _self.getUrl() + 'getAccountDetail',
            type: 'POST',
            async: true,
            dataType: 'json',
            data: JSON.stringify({"id": rowId}),
            contentType: "application/json",
            success: function (assetsDeviceAccountDTOMap) {
                unifiedId = assetsDeviceAccountDTOMap["assetsAccountDTO"].unifiedId;

                //模拟设备组件点击
                $("#componentIframe").contents().find("#assetsDeviceComponent_keyWord").val(unifiedId);
                $("#componentIframe").contents().find("#assetsDeviceComponent_searchPart").click();

                //模拟保养信息点击
                $("#maintainIframe").contents().find("#assetsDeviceMaintain_keyWord").val(unifiedId);
                $("#maintainIframe").contents().find("#assetsDeviceMaintain_searchPart").click();

                //模拟定检信息点击
                $("#regularCheckIframe").contents().find("#assetsDeviceRegularCheck_keyWord").val(unifiedId);
                $("#regularCheckIframe").contents().find("#assetsDeviceRegularCheck_searchPart").click();

                //模拟点检信息点击
                $("#spotCheckIframe").contents().find("#assetsDeviceSpotCheck_keyWord").val(unifiedId);
                $("#spotCheckIframe").contents().find("#assetsDeviceSpotCheck_searchPart").click();

                //模拟精度检查信息点击
                $("#accCheckIframe").contents().find("#assetsDeviceAccCheck_keyWord").val(unifiedId);
                $("#accCheckIframe").contents().find("#assetsDeviceAccCheck_searchPart").click();

                //模拟测试设备组件信息点击
                $("#tDeviceComponentIframe").contents().find("#assetsTdeviceComponent_keyWord").val(unifiedId);
                $("#tDeviceComponentIframe").contents().find("#assetsTdeviceComponent_searchPart").click();

                //模拟测试设备软件信息点击
                $("#tDeviceSoftwareIframe").contents().find("#assetsTdeviceSoftware_keyWord").val(unifiedId);
                $("#tDeviceSoftwareIframe").contents().find("#assetsTdeviceSoftware_searchPart").click();

                //模拟测试设备适用产品信息点击
                $("#tDeviceAppProductIframe").contents().find("#assetsTdeviceAppproduct_keyWord").val(unifiedId);
                $("#tDeviceAppProductIframe").contents().find("#assetsTdeviceAppproduct_searchPart").click();



            }
        });
        <!-- 子表信息end -->

    }
    //构建列表页下的台账详情end
}

/**
 * 添加页面
 */
AssetsDeviceAccount.prototype.insert = function () {
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
AssetsDeviceAccount.prototype.modify = function () {
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
AssetsDeviceAccount.prototype.detail = function (id) {
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
 * 打开高级查询框
 */
AssetsDeviceAccount.prototype.openSearchForm = function (searchDiv) {
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
            layer.close(index);//查询框关闭
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
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
AssetsDeviceAccount.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            assetId: {
                required: true,
                maxlength: 50
            },
            unifiedId: {
                required: true,
                maxlength: 50
            },
            deviceCategory: {
                maxlength: 10
            },
            deviceName: {
                maxlength: 50
            },
            deviceModel: {
                maxlength: 50
            },
            deviceSpec: {
                maxlength: 50
            },
            ownerId: {
                maxlength: 50
            },
            ownerDept: {
                maxlength: 50
            },
            userId: {
                maxlength: 50
            },
            userDept: {
                maxlength: 50
            },
            manufacturerId: {
                maxlength: 50
            },
            createdDate: {
                dateISO: true
            },
            isManage: {
                maxlength: 10
            },
            isInWorkflow: {
                maxlength: 10
            },
            manageState: {
                maxlength: 10
            },
            deviceState: {
                maxlength: 10
            },
            parentId: {
                maxlength: 50
            },
            parentName: {
                maxlength: 30
            },
            commonName: {
                maxlength: 30
            },
            positionId: {
                maxlength: 50
            },
            abcCategory: {
                maxlength: 10
            },
            isKeyDevice: {
                maxlength: 10
            },
            isResearch: {
                maxlength: 10
            },
            productCountry: {
                maxlength: 10
            },
            productFactory: {
                maxlength: 50
            },
            supplier: {
                maxlength: 50
            },
            productDate: {
                dateISO: true
            },
            productNum: {
                maxlength: 50
            },
            devicePower: {
                maxlength: 30
            },
            deviceWeight: {
                maxlength: 30
            },
            deviceSize: {
                maxlength: 50
            },
            checkDate: {
                dateISO: true
            },
            improveProject: {
                maxlength: 50
            },
            unitPrice: {
                number: true
            },
            contractNum: {
                maxlength: 50
            },
            applyNum: {
                maxlength: 50
            },
            checkNum: {
                maxlength: 50
            },
            carFrameNum: {
                maxlength: 50
            },
            engineNum: {
                maxlength: 50
            },
            carNum: {
                maxlength: 50
            },
            secretLevel: {
                maxlength: 10
            },
            isMetering: {
                maxlength: 10
            },
            isMaintain: {
                maxlength: 10
            },
            isAccuracyCheck: {
                maxlength: 10
            },
            isRegularCheck: {
                maxlength: 10
            },
            isSpotCheck: {
                maxlength: 10
            },
            isSpecialDevice: {
                maxlength: 10
            },
            isSafetyProduction: {
                maxlength: 10
            },
            isNeedInstall: {
                maxlength: 10
            },
            isPc: {
                maxlength: 10
            },
            deviceType: {
                maxlength: 10
            },
            enableDate: {
                dateISO: true
            },
            runningTime: {
                number: true
            },
            ip: {
                maxlength: 50
            },
            mac: {
                maxlength: 50
            },
            diskNum: {
                maxlength: 50
            },
            os: {
                maxlength: 50
            },
            osInstallDate: {
                dateISO: true
            },
            meteringId: {
                maxlength: 50
            },
            meterman: {
                maxlength: 50
            },
            meteringDate: {
                dateISO: true
            },
            meteringCycle: {
                number: true
            },
            lastMeteringDate: {
                dateISO: true
            },
            nextMeteringDate: {
                dateISO: true
            },
            planMeterman: {
                maxlength: 50
            },
            meteringDept: {
                maxlength: 50
            },
            isSceneMetering: {
                maxlength: 10
            },
            lastMaintainDate: {
                dateISO: true
            },
            lastAccuracyCheckDate: {
                dateISO: true
            },
            meteringConclution: {
                maxlength: 10
            },
            totalBorrow: {
                number: true
            },
            safeInfo: {
                maxlength: 50
            },
            useCost: {
                number: true
            },
            repairDept: {
                maxlength: 50
            },
            stateChangeDate: {
                dateISO: true
            },
            deviceSysName: {
                maxlength: 50
            },
            deviceRelatedMan: {
                maxlength: 100
            },
            isLabDevice: {
                maxlength: 10
            },
            isFixedAssets: {
                maxlength: 10
            },
            assetsFinanceType: {
                maxlength: 10
            },
            assetsSource: {
                maxlength: 10
            },
            assetsFinanceState: {
                maxlength: 10
            },
            financeEntryDate: {
                dateISO: true
            },
            originalValue: {
                number: true
            },
            totalDepreciation: {
                number: true
            },
            depreciationMethod: {
                maxlength: 50
            },
            depreciationYear: {
                number: true
            },
            netSalvageRate: {
                number: true
            },
            netSalvage: {
                number: true
            },
            monthDepreciationRate: {
                number: true
            },
            monthDepreciation: {
                number: true
            },
            yearDepreciationRate: {
                number: true
            },
            yearDepreciation: {
                number: true
            },
            netValue: {
                number: true
            },
            monthCount: {
                number: true
            },
            monthRemain: {
                number: true
            },
            instituteOrCompany: {
                maxlength: 10
            },
            indexInfo: {
                maxlength: 1000
            },
            proofNum: {
                maxlength: 50
            },
            isTransFixed: {
                maxlength: 10
            },
            meteringOuter: {
                maxlength: 50
            },
            applyModel: {
                maxlength: 10
            },
            applyProduct: {
                maxlength: 50
            },
            testedObject: {
                maxlength: 50
            },
            majorType: {
                maxlength: 10
            },
            deviceNature: {
                maxlength: 10
            },
            softwareNum: {
                maxlength: 50
            },
            softwareDesigner: {
                maxlength: 100
            },
            hardwareDesigner: {
                maxlength: 100
            },
            isTestDevice: {
                maxlength: 10
            },
        }
    });
}
/**
 * 保存方法
 */
AssetsDeviceAccount.prototype.save = function (form, id) {
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
AssetsDeviceAccount.prototype.del = function () {
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
AssetsDeviceAccount.prototype.reLoad = function () {
    var searchdata = {param: JSON.stringify(serializeObject($(this._formId)))}
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关闭对话框
 */
AssetsDeviceAccount.prototype.closeDialog = function (id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.editIndex);
    }
};
/**
 * 后台查询
 */
AssetsDeviceAccount.prototype.searchData = function () {
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
AssetsDeviceAccount.prototype.searchByKeyWord = function () {
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
AssetsDeviceAccount.prototype.hideSearchForm = function () {
    layer.close(searchDialogindex);
};
/**
 * 清空查询条件
 */
AssetsDeviceAccount.prototype.clearData = function () {
    clearFormData(this._formId);
    this.searchData();
};
/**
 * 设备附表添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
AssetsDeviceAccount.prototype.insertSUB = function(){
    var _self = this;
    $(_self._datagridId).jqGrid('endEditCell');
    var hasvalidate = true;
    var data = $(_self._datagridId).jqGrid('getRowData');
    if(data.length > 0 && _self.dataGridColModel.length > 0){
        $.each(_self.notnullFiled, function(i, item) {
            var msg = _self.nullvalid(data, item, _self.notnullFiled, _self.notnullFiledComment);
            if (msg && msg.length > 0) {
                layer.alert(msg, {
                    icon : 7,
                    area : [ '400px', '' ], // 宽高
                    closeBtn : 0,
                    btn: ['关闭'],
                    title:"提示"
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
        rowID : newRowId,
        initdata : {},
        position :"first",
        useDefValues : true,
        useFormatter : true,
        addRowParams : {extraparam:{}}
    };
    $(_self._datagridId).jqGrid('addRow', parameters);
    newRowIndex++;
};
