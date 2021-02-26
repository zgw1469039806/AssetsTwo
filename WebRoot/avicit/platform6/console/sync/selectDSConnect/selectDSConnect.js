/**
 * 选择数据源
 * @param fieldId       页面隐藏域，用于存储数据源id
 * @param fieldName     页面显示域，用于存储数据源name
 * @constructor
 */
function SelectDSConnect(fieldId, fieldName) {
    this.fieldId = fieldId;
    this.fieldName = fieldName;
}

/**
 * 初始化功能
 * @param postFunction 可选参数；后置处理函数
 */
SelectDSConnect.prototype.init = function (postFunction) {
    var _this = this;

    var fieldId = _this.fieldId;
    var fieldName = _this.fieldName;

    if (postFunction != undefined && typeof postFunction == 'function') {
        _this.postFunction = postFunction;
        $("#" + fieldId).data("data-object", _this);
    }
    // 取消selectPosition绑定的其他事件
    var selectPosition = $("#" + fieldName);
    selectPosition.unbind();
    selectPosition.click(function () {
        var parm = "fieldId=" + fieldId + "&fieldName=" + fieldName;

        layer.open({
            type: 2,
            title: '选择数据源',
            skin: 'bs-modal',
            area: ['350px', '350px'],
            maxmin: false,
            content: "avicit/platform6/console/sync/selectDSConnect/selectDSConnect.jsp?" + parm
        });
    });
    selectPosition.css("cursor", "pointer");
};