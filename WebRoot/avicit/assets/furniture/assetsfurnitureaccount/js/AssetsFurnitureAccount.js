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
    this.init.call(this);
};
/**
 * 初始化操作
 * 回车查询
 */
AssetsFurnitureAccount.prototype.init = function () {
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
        url: _self.getUrl() + 'getAssetsFurnitureAccountsByPage.json',
        mtype: 'POST',
        datatype: "json",
        postData: searchdata,//增加筛选数据
        toolbar: [true, 'top'],
        colModel: _self.dataGridColModel,
        height: $(window).height() * 2 / 5,
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


    //单击延时触发
    var clickTimeId;
    //给列表行绑定单击事件
    var _self = this;
    var tableList = document.getElementById('assetsFurnitureAccountjqGrid');
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
        assetsFurnitureAccount.detail(rowId);
    }

    setTimeout(function () {
        if($("#assetsFurnitureAccountjqGrid").find("tr").get(1) != undefined){
            var firstRowId = $("#assetsFurnitureAccountjqGrid").find("tr").get(1).id;
            document.getElementById(firstRowId).click();//选中当前行
            rowClick(firstRowId, _self);
        }
    },500);

};


/**
 * 单击方法
 */
function rowClick(rowId, _self) {
    //构建列表页下的台账详情begin
    if (rowId != ""){
        avicAjax.ajax({
            url: _self.getUrl() + 'getFurnitureAccountDetail',
            type: 'POST',
            async: true,
            dataType: 'json',
            data: JSON.stringify({"id": rowId}),
            contentType: "application/json",
            success: function (assetsFurnitureAccountDTOMap) {
                //成功回调
                //解析数据begin
                //平台公用是否select字符串
                var str_yesNo = "";
                for (i = 0; i < assetsFurnitureAccountDTOMap["yesNoList"].length; i++) {
                    var selectIndex = assetsFurnitureAccountDTOMap["yesNoList"][i].lookupCode;
                    var selectName = assetsFurnitureAccountDTOMap["yesNoList"][i].lookupName;
                    if (selectIndex == assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].METERING_MODE) {
                        str_yesNo += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_yesNo += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }
                //家具分类select字符串
                var str_assetsFurnitureCategory = "";
                for (i = 0; i < assetsFurnitureAccountDTOMap["furnitureCategoryList"].length; i++) {
                    var selectIndex = assetsFurnitureAccountDTOMap["furnitureCategoryList"][i].lookupCode;
                    var selectName = assetsFurnitureAccountDTOMap["furnitureCategoryList"][i].lookupName;
                    if (selectIndex == assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].furnitureCategory) {
                        str_assetsFurnitureCategory += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_assetsFurnitureCategory += "<option value='" + selectIndex + "'>" + selectName + "</option>";
                    }
                }
                //家具状态select字符串
                var str_assetsFurnitureState = "";
                for (i = 0; i < assetsFurnitureAccountDTOMap["furnitureStateList"].length; i++) {
                    var selectIndex = assetsFurnitureAccountDTOMap["furnitureStateList"][i].lookupCode;
                    var selectName = assetsFurnitureAccountDTOMap["furnitureStateList"][i].lookupName;
                    if (selectIndex == assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].furnitureState) {
                        str_assetsFurnitureState += "<option selected value='" + selectIndex + "'>" + selectName + "</option>";
                    } else {
                        str_assetsFurnitureState += "<option value='" + selectIndex + "'>" + selectName + "</option>";
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
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'assetId' id='assetId' value='" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].assetId + "' />" +
                    "                    </td>\n" +
                    "                    <!-- 统一编号 -->\n" +
                    "                   <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"unifiedId\">统一编号:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'unifiedId' id='unifiedId' value='" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].unifiedId + "' />" +
                    "                    </td>\n" +
                    "                    <!-- 家具分类 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"furnitureCategory\">家具分类:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                       <select class= 'form-control input-sm' disabled='disabled' name= 'furnitureCategory' id= 'furnitureCategory' title='' isNull='true'>" + str_assetsFurnitureCategory + "</select>" +
                    "                    </td>\n" +
                    "                    <!-- 家具名称 -->\n" +
                    "                   <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"furnitureName\">家具名称:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'furnitureName' id='furnitureName' value='" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].furnitureName + "' />" +
                    "                    </td>\n" +
                    "</tr>" +
                    "<tr>\n" +
                    "                    <!-- 家具规格 -->\n" +
                    "                   <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"furnitureSpec\">家具规格:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'furnitureSpec' id='furnitureSpec' value='" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].furnitureSpec + "' />" +
                    "                    </td>\n" +
                    "                    <!-- 安装地点 -->\n" +
                    "                   <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"position_id\">安装地点:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'position_id' id='position_id' value='" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].positionId + "' />" +
                    "                    </td>\n" +
                    "                  <!-- 责任人 -->\n" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"ownerIdAlias\">责任人:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <div class=\"input-group  input-group-sm\">\n" +
                    "                                <input type=\"hidden\" id=\"ownerId\" name=\"ownerId\"\n" +
                    "                                       value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].ownerId + "\"/>\n" +
                    "                                <input class=\"form-control\" placeholder=\"请选择用户\" type=\"text\" id=\"ownerIdAlias\"\n" +
                    "                                       readonly=\"readonly\" name=\"ownerIdAlias\"\n" +
                    "                                       value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].ownerIdAlias + "\"/>\n" +
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
                    "                                       value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].ownerDept + "\"/>\n" +
                    "                                <input class=\"form-control\" placeholder=\"请选择部门\" type=\"text\" id=\"ownerDeptAlias\"\n" +
                    "                                       readonly=\"readonly\" name=\"ownerDeptAlias\"\n" +
                    "                                       value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].ownerDeptAlias + "\"/>\n" +
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
                    "                                       value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].userId + "\"/>\n" +
                    "                                <input class=\"form-control\" placeholder=\"请选择用户\" type=\"text\" id=\"userIdAlias\"\n" +
                    "                                       readonly=\"readonly\" name=\"userIdAlias\"\n" +
                    "                                       value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].userIdAlias + "\"/>\n" +
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
                    "                                       value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].userDept + "\"/>\n" +
                    "                                <input class=\"form-control\" placeholder=\"请选择部门\" type=\"text\" id=\"userDeptAlias\"\n" +
                    "                                       readonly=\"readonly\" name=\"userDeptAlias\"\n" +
                    "                                       value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].userDeptAlias + "\"/>\n" +
                    "                                <span class=\"input-group-addon\">\n" +
                    "<i class=\"glyphicon glyphicon-equalizer\"></i>\n" +
                    "</span>\n" +
                    "                            </div>\n" +
                    "                        </td>" +
                    "                    <!-- 生产厂家 -->\n" +
                    "                   <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"manufacturerId\">生产厂家:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'manufacturerId' id='manufacturerId' value='" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].manufacturerId + "' />" +
                    "                    </td>\n" +
                    "                    <!-- 立卡日期 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"createdDate\">立卡日期:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'createdDate' id='createdDate' value=" + formatDate(assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].createdDate) + " />" +
                    "                    </td>" +
                    "</tr>" +
                    "<tr>" +
                    "                    <!-- 单价 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"originalValue\">单价:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"unitPrice\" id=\"unitPrice\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].unitPrice + "\" \n" +
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
                    "                    <!-- 质保期 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"monthRemain\">质保期(天):</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"guaranteePeriod\" id=\"guaranteePeriod\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].guaranteePeriod + "\" \n" +
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
                    "                        <label for=\"guaranteeDate\">质保截止日期:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'guaranteeDate' id='guaranteeDate' value=" + formatDate(assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].guaranteeDate) + " />" +
                    "                    </td>" +
                    "                    <!-- 家具状态 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"furnitureState\">家具状态:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                       <select class= 'form-control input-sm' disabled='disabled' name= 'furnitureState' id= 'furnitureState' title='' isNull='true'>" + str_assetsFurnitureState + "</select>" +
                    "                    </td>\n" +
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
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'assetsFinanceType' id='assetsFinanceType' value='" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].assetsFinanceType + "' />" +
                    "                  <!-- 资产来源 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"assetsSource\">资产来源:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'assetsSource' id='assetsSource' value='" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].assetsSource + "' />" +
                    "                    </td>\n" +
                    "                    <!-- 资产财务状态 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"assetsFinanceState\">资产财务状态:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'assetsFinanceState' id='assetsFinanceState' value='" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].assetsFinanceState + "' />" +
                    "                    </td>\n" +
                    "                    <!-- 财务入账时间 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"financeEntryDate\">财务入账时间:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'financeEntryDate' id='financeEntryDate' value=" + formatDate(assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].financeEntryDate) + " />" +
                    "                    </td>" +
                    "</tr>" +
                    "<tr>\n" +
                    "                    <!-- 原值 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"originalValue\">原值:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"originalValue\" id=\"originalValue\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].assetsSource + "\" \n" +
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
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].totalDepreciation + "\" \n" +
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
                    "                        <label for=\"depreciationMethod\">折旧方法:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'depreciationMethod' id='depreciationMethod' value='" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].depreciationMethod + "' />" +
                    "                    </td>\n" +
                    "                    <!-- 折旧年限 -->\n" +
                    "                    <th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                        <label for=\"depreciationYear\">折旧年限:</label></th>\n" +
                    "                    <td width=\"15%\">\n" +
                    "<div class=\"input-group input-group-sm spinner\" data-trigger=\"spinner\">\n" +
                    "                                <input class=\"form-control\" type=\"text\" name=\"depreciationYear\" id=\"depreciationYear\"\n" +
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].depreciationYear + "\" \n" +
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
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].netSalvage + "\" \n" +
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
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].monthDepreciationRate + "\" \n" +
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
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].monthDepreciation + "\" \n" +
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
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].yearDepreciationRate + "\" \n" +
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
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].yearDepreciation + "\" \n" +
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
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].netValue + "\" \n" +
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
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].monthCount + "\" \n" +
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
                    "                                 readonly=\"readonly\" value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].monthRemain + "\" \n" +
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
                    "                        <input type='text' class = 'form-control input-sm' disabled='disabled'  name = 'instituteOrCompany' id='instituteOrCompany' value='" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].instituteOrCompany + "' />" +
                    "                    </td>\n" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"proofNum\">凭证编号:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <input class=\"form-control input-sm\" type=\"text\" name=\"proofNum\" id=\"proofNum\" readonly=\"readonly\"\n" +
                    "                                   value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].proofNum + "\"/>\n" +
                    "                        </td>" +
                    "<th width=\"10%\" style=\"word-break:break-all;word-warp:break-word;\">\n" +
                    "                            <label for=\"contractNum\">合同号:</label></th>\n" +
                    "                        <td width=\"15%\">\n" +
                    "                            <input class=\"form-control input-sm\" type=\"text\" name=\"contractNum\" id=\"contractNum\" readonly=\"readonly\"\n" +
                    "                                   value=\"" + assetsFurnitureAccountDTOMap["assetsFurnitureAccountDTO"].contractNum + "\"/>\n" +
                    "                        </td>" +
                    "</tr>" +
                    "</table>");
                <!--财务信息tab页end-->

            }
        });
    }
    //构建列表页下的台账详情end
}


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
 * 校验方法
 */
AssetsFurnitureAccount.prototype.formValidate = function (form) {
    var _self = this;
    form.validate({
        rules: {
            unifiedId: {
                required: true,
                maxlength: 50
            },
            assetId: {
                maxlength: 50
            },
            furnitureName: {
                maxlength: 50
            },
            furnitureCategory: {
                maxlength: 10
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
            furnitureSpec: {
                maxlength: 50
            },
            createdDate: {
                dateISO: true
            },
            positionId: {
                maxlength: 50
            },
            guaranteeDate: {
                dateISO: true
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
            isTransFixed: {
                maxlength: 10
            },
            proofNum: {
                maxlength: 50
            },
            isInWorkflow: {
                maxlength: 10
            },
            furniturePhoto: {
                maxlength: 50
            },
            furnitureState: {
                maxlength: 10
            },
            parentId: {
                maxlength: 50
            },
            parentName: {
                maxlength: 30
            },
        }
    });
}
/**
 * 保存方法
 */
AssetsFurnitureAccount.prototype.save = function (form, callback) {
    var _self = this;
    avicAjax.ajax({
        url: _self.getUrl() + "save",
        data: {data: JSON.stringify(serializeObject(form))},
        type: 'post',
        dataType: 'json',
        success: function (r) {
            if (r.flag == "success") {
                _self.reLoad();
                if (typeof(callback) == "function") {
                    callback(r.id);
                }
                layer.msg('保存成功！');
            } else {
                layer.alert('保存失败,请联系管理员!', {
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
};
/**
 * 删除方法
 */
AssetsFurnitureAccount.prototype.del = function () {
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
 * 后台查询方法
 */
AssetsFurnitureAccount.prototype.searchData = function () {
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
