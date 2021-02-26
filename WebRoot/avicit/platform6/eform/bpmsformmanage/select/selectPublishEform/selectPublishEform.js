/**
 * Created by xb on 2017/5/25.
 */

/**
 * 选择表单
 * @param fieldId       页面隐藏域，用于存储表单id
 * @param fieldName     页面显示域，用于存储表单name
 * @param parentAreaId  可选参数；当同一页面存在多处选择表单时，用于传参父区域唯一标识
 * @param isBpm         可选参数Y/N；是否走流程表单
 * @param formsType     可选参数bpm/eform；bpm为流程添加表单、eform为设计器设计表单
 * @constructor
 */
function SelectPublishEform(fieldId, fieldName, parentAreaId, isBpm, formsType,handle) {
    this.fieldId = fieldId;
    this.fieldName = fieldName;
    this.parentAreaId = parentAreaId;
    this.isBpm = isBpm;
    this.formsType = formsType;
    this.handle = handle;
}

/**
 * 初始化功能
 * @param postFunction 可选参数；后置处理函数
 */
SelectPublishEform.prototype.init = function (postFunction) {
    var _this = this;

    var fieldId = _this.fieldId;
    var fieldName = _this.fieldName;
    var parentAreaId = _this.parentAreaId;
    var isBpm = _this.isBpm;
    var formsType = _this.formsType;
    var handle = _this.handle;

    var selectPosition;
    if (parentAreaId == null) {
        selectPosition = $("#" + fieldName);
    }else {
        selectPosition = $("#" + parentAreaId).find("#" + fieldName);
    }
    // 取消selectPosition绑定的其他事件
    if (handle==null || handle==undefined){
        handle = selectPosition;
    }
    handle.unbind();
    handle.click(function () {
        var parm = "fieldId=" + fieldId + "&fieldName=" + fieldName + "&parentAreaId=" + parentAreaId + "&isBpm=" + isBpm + "&formsType=" + formsType;

        layer.open({
            type: 2,
            title: '选择表单',
            skin: 'bs-modal',
            area: ['350px', '350px'],
            maxmin: false,
            content: "avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.jsp?" + parm,
            success:function(data, status){
                var dataObjectField;
                if (parentAreaId == null) {
                    dataObjectField = $("#" + fieldId);
                }else {
                    dataObjectField = $("#" + parentAreaId).find("#" + fieldId);
                }
                if (postFunction != undefined && typeof postFunction == 'function') {
                    _this.postFunction = postFunction;
                    dataObjectField.data("data-object", _this);
                }
            	//ie8下页面加载完成重绘关闭按钮
            	redrawPseudoEl();
            }
        });
    });
    handle.css("cursor", "pointer");
}