/**
 * 选择表
 * @param fieldId       页面隐藏域，用于存储id
 * @param fieldName     页面显示域，用于存储name
 * @constructor
 */
function SelectTable(fieldId, fieldName) {
    this.fieldId = fieldId;
    this.fieldName = fieldName;
}

/**
 * 初始化功能
 * @param postFunction 可选参数；后置处理函数
 */
SelectTable.prototype.init = function (postFunction) {
    var _this = this;

    var fieldId = _this.fieldId;
    var fieldName = _this.fieldName;

    if (postFunction != undefined && typeof postFunction == 'function') {
        _this.postFunction = postFunction;
        $("#" + fieldId).data("data-object", _this);
    }

    var selectPosition = $("#" + fieldName);
    // 取消selectPosition绑定的其他事件
    selectPosition.unbind();
    selectPosition.click(function () {
        var parm = "fieldId=" + fieldId + "&fieldName=" + fieldName;
        //点击后使input失去焦点,否则ie8下弹层不能遮挡鼠标
        setTimeout(function() { $("#"+fieldName).blur(); }, 1);

        layer.open({
            type: 2,
            title: '选择表',
            skin: 'bs-modal',
            area: ['700px', '90%'],
            maxmin: false,
            content: "avicit/platform6/autocode/table/selectTable.jsp?" + parm
        });
    });
    selectPosition.css("cursor", "pointer");
};

/**
 * 选择表字段
 * @param fieldId       页面隐藏域，用于存储id
 * @param fieldName     页面显示域，用于存储name
 * @param tableName     传参，已选择的表名
 * @constructor
 */
function SelectTableColumn(fieldId, fieldName, tableName) {
    this.fieldId = fieldId;
    this.fieldName = fieldName;
    this.tableName = tableName;
}

/**
 * 初始化功能
 * @param postFunction 可选参数；后置处理函数
 */
SelectTableColumn.prototype.init = function (postFunction) {
    var _this = this;

    var fieldId = _this.fieldId;
    var fieldName = _this.fieldName;
    var tableName = _this.tableName;

    if (postFunction != undefined && typeof postFunction == 'function') {
        _this.postFunction = postFunction;
        $("#" + fieldId).data("data-object", _this);
    }

    var selectPosition = $("#" + fieldName);
    // 取消selectPosition绑定的其他事件
    selectPosition.unbind();
    selectPosition.click(function () {
        var parm = "fieldId=" + fieldId + "&fieldName=" + fieldName + "&tableName=" + tableName;
        //点击后使input失去焦点,否则ie8下弹层不能遮挡鼠标
        setTimeout(function() { $("#"+fieldName).blur(); }, 1);

        layer.open({
            type: 2,
            title: '选择表字段',
            skin: 'bs-modal',
            area: ['700px', '90%'],
            maxmin: false,
            content: "avicit/platform6/autocode/table/selectTableColumn.jsp?" + parm
        });
    });
    selectPosition.css("cursor", "pointer");
};