/**
 * Created by xb on 2017/5/25.
 */

/**
 * 选择表单
 * @param fieldId       页面隐藏域，用于存储表单id
 * @param fieldName     页面显示域，用于存储表单name
 * @constructor
 */
function SelectDbType(fieldId, fieldName, selectBtn) {
    this.fieldId = fieldId;
    this.fieldName = fieldName;
    this.selectBtn = selectBtn;
    this.postFunction = null;
}

/**
 * 初始化功能
 * @param postFunction 可选参数；后置处理函数
 */
SelectDbType.prototype.init = function (postFunction) {
    var _this = this;

    var fieldId = _this.fieldId;
    var fieldName = _this.fieldName;
    var selectBtn = _this.selectBtn;

    var selectPosition;
    selectPosition = $("#" + fieldName);

    if (postFunction != undefined && typeof postFunction == 'function') {
        _this.postFunction = postFunction;
        $("#" + fieldId).data("data-object", _this);
    }
    
  

    selectPosition.click(function () {
        var parm = "fieldId=" + fieldId + "&fieldName=" + fieldName;

        layer.open({
            type: 2,
            title: '选择存储模型分类',
            skin: 'bs-modal',
            area: ['350px', '350px'],
            maxmin: false,
            content: "avicit/platform6/db/dbselect/selectDbType/selectDbType.jsp?" + parm
        });
    });
    selectPosition.css("cursor", "pointer");

    if(selectBtn != null && selectBtn != "") {
        $("#" + selectBtn).click(function () {
            var parm = "fieldId=" + fieldId + "&fieldName=" + fieldName;

            layer.open({
                type: 2,
                title: '选择存储模型分类',
                skin: 'bs-modal',
                area: ['350px', '350px'],
                maxmin: false,
                content: "avicit/platform6/db/dbselect/selectDbType/selectDbType.jsp?" + parm
            });
        });
    }
};