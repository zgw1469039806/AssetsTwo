

    //重写按钮方法
    FEformEditor.prototype.setButtonArea = function(){
        var html = "<span style=\"color: #58a9ff;\">\n" +
            "                    <i class=\"icon iconfont icon-Preservation\" title=\"保存表单\" onclick=\"printEditor.save()\"></i>\n" +
            "                </span>\n";


        html = html +
            "                <span style=\"border-left: 1px solid #B5B5B5;padding-bottom: 0px;padding-top: 7px;\">\n" +
            "                </span>\n" +
            "                <span style=\"color: #B5B5B5;\">\n" +
            "                    <i class=\"icon iconfont icon-style\" title=\"应用样式\" onclick=\"printEditor.applyStyle()\"></i>\n" +
            "                </span>\n" +
            "                <span style=\"color:#B5B5B5;\">\n" +
            "                \t<i class=\"icon iconfont icon-js\" title=\"JS文件扩展\" onclick=\"printEditor.applyJs()\"></i>\n" +
            "                </span>\n" +
            "                <span style=\"color: #B5B5B5;\">\n" +
            "                    <i class=\"icon iconfont icon-preview\" title=\"预览表单\" onclick=\"printEditor.preview()\"></i>\n" +
            "                </span>\n" +
            "                <span style=\"color: #B5B5B5;\">\n" +
            "                    <i class=\"icon iconfont icon-file\" title=\"帮助\" onclick=\"printEditor.helpDoc()\"></i>\n" +
            "                </span>";
        $("#buttonArea").html(html);
    };

    //设计器内容初始方法
    // FEformEditor.prototype.setContent = function () {
    //     tinymce.activeEditor.setContent("123");
    // };
    FEformEditor.prototype.save = function () {
        var _this = this;

        var tinymceContentStyle = _this.tinymceContentStyle;
        var eformJs = _this.eformJs;


        //源代码外包一层
        $('#tinymceArea_ifr').contents().find('.onchoose').removeClass("onchoose");

        var sourceContent = tinymce.activeEditor.getContent();

        var showContent = $('<div class="mce-content-body"></div>');
        showContent.append(sourceContent);

        //表单校验

        if (!verifySaveForm(showContent)){
            return;
        }


        updateForm( tinymceContentStyle, eformJs, showContent);


        //验证表单数据完整性
        function verifySaveForm(sourceContent) {

            var verifyStatus = true;

            var eleViewId = "";
            var eleCode = "";
            var colNameList = [];
            var domIdList = [];
            var tableColList = [];
            var ssd = $("#attrform").validate();
            if (ssd && !ssd.checkForm()) {
                ssd.showErrors();
                return false;
            }
            var tables = $('#tinymceArea_ifr').contents().find('table');
            for (var co = 0; co < tables.length; co++) {
                var tabledomid = tables.eq(co).attr("id");
                if (!isEmptyObject(tabledomid)) {
                    tableColList[tabledomid] = [];
                }
            }
            var datatableEleViewIdArray = [];
            $(sourceContent).find('.element').each(function (index, element) {
                eleViewId = $(element).attr("id");
                eleCode = $(element).attr("class").substr(8);
                var tableattr = editorUtil.getTableAttrByElement($(this));
                var tabletype = tableattr.datatype;


                var eleattr = $(element).find(".eleattr-span").prop("innerHTML");
                var attrJson;
                try {
                    attrJson = $.parseJSON(eleattr);
                }
                catch (error) {
                    console.log(error);
                    layer.msg('该控件源码格式有误！', {icon: 2});
                    verifyStatus = false;

                    return false;
                }
                var ele = printEditor.getElement(eleCode);

                if (ele.validateForm && typeof(ele.validateForm) == "function"){
                    if (!ele.validateForm(attrJson)){
                        verifyStatus = false;
                        return false;
                    }
                }

                if (eleCode == "print-datatable") {
                    datatableEleViewIdArray.push(eleViewId);
                    return true;
                }

                if (ele.colType == "NOT_DB_COL_ELE") {
                    return true;
                }

                //控件属性
                var colName = attrJson.colName.toUpperCase();//字段名称(英文)
                var colLabel = attrJson.colLabel;//字段描述(备注)
                var colLength = attrJson.colLength;//字段长度
                var defaultValue = attrJson.defaultValue;//默认值
                var attribute02 = attrJson.attribute02;//小数位数
                var rows = attrJson.rows;//行数
                var domId = attrJson.domId || colName;
                var rtfHeight=attrJson.rtfHeight;//富文本高度
                var userSelectDomain = attrJson.selectDomain;//用户选人框选择维度
                var xml = attrJson.xml;
                //1.验证必填属性与格式
                if (verifyIsEmpty(colName)) {
                    layer.msg('字段名称(英文)[' + colName + ']不能为空！', {icon: 7});
                    verifyStatus = false;

                    return false;
                }
                if (verifyIsSpecial(colName) || verifyIsChinese(colName) || verifyIsNumStart(colName)) {
                    layer.msg('字段名称(英文)[' + colName + ']不能包含特殊字符、空格、中文或以数字开头！', {icon: 7});
                    verifyStatus = false;

                    return false;
                }
                if (verifyIsEmpty(colLabel)) {
                    layer.msg('字段描述(备注)[' + colName + ']不能为空！', {icon: 7});
                    verifyStatus = false;

                    return false;
                }
                //验证页面元素ID格式
                if (domId!=null && (verifyIsSpecial(domId) || verifyIsChinese(domId))) {
                    layer.msg('页面元素ID[' + colName + ']不能为特殊字符或中文！', {icon: 7});
                    verifyStatus = false;
                    return false;
                }

                if (colLength != null && verifyIsEmpty(colLength)) {
                    layer.msg('字段长度[' + colName + ']不能为空！', {icon: 7});
                    verifyStatus = false;

                    return false;
                }
                if (colLength != null && (!verifyIsInteger(colLength) || colLength <= 0 || colLength > 4000)) {
                    layer.msg('字段长度[' + colName + ']必须为正整数，且值区间为[1, 4000]！', {icon: 7});
                    verifyStatus = false;

                    return false;
                }
                if (attribute02 != null && verifyIsEmpty(attribute02)) {
                    layer.msg('数字输入框[' + colName + ']小数位数不能为空！', {icon: 7});
                    verifyStatus = false;

                    return false;
                }
                if (attribute02 != null && (!verifyIsInteger(attribute02) || attribute02 < 0 || attribute02 > 10)) {
                    layer.msg('数字输入框[' + colName + ']小数位数必须为正整数，且值区间为[0, 10]！', {icon: 7});
                    verifyStatus = false;

                    return false;
                }
                if (rows != null && verifyIsEmpty(rows)) {
                    layer.msg('多行文本框[' + colName + ']行数不能为空！', {icon: 7});
                    verifyStatus = false;

                    return false;
                }
                if (rows != null && (!verifyIsInteger(rows) || rows <= 0 || rows > 20)) {
                    layer.msg('多行文本框行数必须为正整数，且值区间为[1, 20]！', {icon: 7});
                    verifyStatus = false;

                    return false;
                }

                if (rtfHeight != null && rtfHeight!=""&& (!verifyIsInteger(rtfHeight) || rtfHeight <= 0)) {
                    layer.msg('富文本高度必须为正整数', {icon: 7});
                    verifyStatus = false;

                    return false;
                }

                if(eleCode == "print-user-box"){
                    if((!userSelectDomain)||(userSelectDomain=="")){
                        layer.msg('选用户控件选择维度不能为空', {icon: 7});
                        verifyStatus = false;
                        return false;
                    }
                }



                if (verifyIsEmpty(xml)) {
                    layer.msg('字段名称(英文)[引入XML]不能为空！', {icon: 7});
                    verifyStatus = false;

                    return false;
                }
                //2.验证字段名称(英文)不能重复
                if (tabletype == "0") {
                    colNameList.push(colName);
                    var uniqueArray = getUniqueArray(colNameList);
                    if (colNameList.length != uniqueArray.length) {
                        layer.msg('字段名称(英文)[' + colName + ']不能重复！', {icon: 7});
                        verifyStatus = false;

                        return false;
                    }
                } else {
                    var tablelayoutid = tableattr.layoutid;
                    tableColList[tablelayoutid].push(colName);
                    var uniqueArray = getUniqueArray(tableColList[tablelayoutid]);
                    if (tableColList[tablelayoutid].length != uniqueArray.length) {
                        layer.msg('字段名称(英文)[' + colName + ']不能重复！', {icon: 7});
                        verifyStatus = false;

                        return false;
                    }
                }

                domIdList.push(domId);
                var uniqueDomArray = getUniqueArray(domIdList);
                if (domIdList.length != uniqueDomArray.length) {
                    layer.msg('页面元素ID[' + colName + ']不能重复！', {icon: 7});
                    verifyStatus = false;

                    return false;
                }

                if (defaultValue != null && defaultValue.length > colLength) {
                    layer.msg('字段默认值长度为' + defaultValue.length + '已超出字段长度' + colLength + '！', {icon: 7});
                    verifyStatus = false;

                    return false;
                }
            });

            //如果验证失败，则模拟点击该控件
            if (verifyStatus == false) {
                $('#tinymceArea_ifr').contents().find('#' + eleViewId).click();
                $('#tinymceArea_ifr').contents().find('#' + eleViewId).attr("data-mce-selected","1");
            }
            //以下子表名称单独验证
            else {
                var ajaxStatus = false;
                for (var i = 0; i < datatableEleViewIdArray.length; i++) {
                    var eleViewId = datatableEleViewIdArray[i];

                    var eleattr = $('#tinymceArea_ifr').contents().find('#' + eleViewId).find(".eleattr-span").prop("innerHTML");
                    var attrJson = $.parseJSON(eleattr);
                    var subTableName = attrJson.subTableName;
                    var fkColName = attrJson.fkColName;
                    if (fkColName=="请选择"||verifyIsEmpty(fkColName)){
                        layer.msg('子表外键不能为空！', {icon: 7});
                        verifyStatus = false;
                        return false;
                    }

                    if (verifyIsEmpty(attrJson.xml)) {
                        layer.msg('字段名称(英文)[引入XML]不能为空！', {icon: 7});
                        verifyStatus = false;

                        return false;
                    }
                    // 肯定是数据源

                    if (verifyIsEmpty(subTableName)) {
                        layer.msg('子表请选择数据源！', {icon: 7});
                        verifyStatus = false;

                        break;
                    }

                }

                if (verifyStatus == false && ajaxStatus == false) {
                    $('#tinymceArea_ifr').contents().find('#' + eleViewId).click();
                    $('#tinymceArea_ifr').contents().find('#' + eleViewId).find("input, select, textarea").focus();
                }
            }

            return verifyStatus;
        }


        //更新表单
        function updateForm(  tinymceContentStyle, eformJs, showContent) {

            var restUrl = "platform/print/sysPrintDesignerController/saveDesign"

            avicAjax.ajax({
                url: restUrl,
                type: 'POST',
                data: {
                    printId:printId,
                    // eformFormInfoId: eformFormInfoId,
                    // tableName: tableName,
                    tableCss: EformConfig.contentCssPath + "/" + tinymceContentStyle + ".css",
                    tableJs: eformJs,
                    tableContent: showContent.prop('outerHTML')
                    // version:version
                },
                dataType: 'json',
                success: function (backData, status) {
                    if (backData.flag == 'success') {
                        layer.msg("保存成功")
                        // 不需要更新页面
                    }
                    else {
                        layer.msg(backData.error, {icon: 2});
                    }
                }
            });
        }
    }

    FEformEditor.prototype.preview = function (style) {

        var _this = this;
        var tinymceContentStyle = _this.tinymceContentStyle;
        var sourceContent = tinymce.activeEditor.getContent();

        //源代码外包一层
        var showContent = $('<div class="mce-content-body"></div>');
        showContent.append(sourceContent);
        window.tinymceContentStyle = tinymceContentStyle;
        window.showContent = showContent.prop('outerHTML');
        layer.open({
            type: 2,
            title: '电子表单预览',
            skin: 'bs-modal',
            area: ['100%', '100%'],
            maxmin: false,
            content: "print/sysPrintDesignerController/topreview"
        });
    };





