/**
 * Created by xb on 2017/5/25.
 */
function SelectCreatedDbTable(fieldId, fieldName, selectBtn, rootId,dbtype) {
    this.fieldId = fieldId;
    this.fieldName = fieldName;
    this.selectBtn = selectBtn;
    this.rootId = rootId;
    this.dbtype = dbtype || "1";
    this.selectDialog = null;
}

/**
 * 初始化功能
 * @param postFunction 可选参数；后置处理函数
 */
SelectCreatedDbTable.prototype.init = function (postFunction) {
    var _this = this;

    var fieldId = _this.fieldId;
    var fieldName = _this.fieldName;
    var selectBtn = _this.selectBtn;
    var rootId = _this.rootId;
    var dbtype = _this.dbtype;
    var parm = "fieldId=" + fieldId + "&fieldName=" + fieldName + "&rootId=" + rootId+"&dbtype="+dbtype;

    if (postFunction != undefined && typeof postFunction == 'function') {
        _this.postFunction = postFunction;
        $("#" + fieldId).data("data-object", _this);
    }
    
    $("#" + fieldName).click(function () {
        _this.selectDialog = layer.open({
            type: 2,
            title: '选择已经创建的表',
            skin: 'bs-modal',
            area: ['350px', '350px'],
            maxmin: false,
            content: "avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.jsp?" + parm
        });
    });

    if(selectBtn != null && selectBtn != "") {
        $("#" + selectBtn).click(function () {
            _this.selectDialog = layer.open({
                type: 2,
                title: '选择已经创建的表',
                skin: 'bs-modal',
                area: ['350px', '350px'],
                maxmin: false,
                content: "avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.jsp?" + parm
            });
        });
    }

    $("#" + fieldName).css("cursor", "pointer");
};

/**
 * 不绑定事件，只打开页面
 * @param postFunction
 */
SelectCreatedDbTable.prototype.open = function (postFunction) {
    var parm = "fieldId=" + this.fieldId + "&fieldName=" + this.fieldName + "&rootId=" + this.rootId+"&dbtype="+this.dbtype;

    if (postFunction != undefined && typeof postFunction == 'function') {
        this.postFunction = postFunction;
        $("#" + this.fieldId).data("data-object", this);
    }

    this.selectDialog = layer.open({
        type: 2,
        title: '选择已经创建的表',
        skin: 'bs-modal',
        area: ['350px', '350px'],
        maxmin: false,
        content: "avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.jsp?" + encodeURI(parm)
    });
};