/**
 * Created by xb on 2017/8/10.
 */
function DbTableSearch(searchArea, searchDbDiv) {
    this.searchArea = searchArea;
    this.searchDbDiv = searchDbDiv;

    this.init.call(this);
}
//初始化操作
DbTableSearch.prototype.init = function () {
    var _this = this;
};

//搜索表模型
DbTableSearch.prototype.searchDbTable = function (searchParm) {
    var _this = this;

    $("#" + dbTable.componentArea).css("display", "none");
    $("#" + _this.searchArea).css("display", "");

    $('#' + _this.searchDbDiv).empty();
    $.ajax({
        url: "platform/db/dbTableManageController/searchDbTableList",
        data: "searchParm=" + searchParm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var componentList = backData.data;

            for (var i = 0; i < componentList.length; i++) {
                dbTable.setComponent(componentList[i], _this.searchDbDiv);
            }
        }
    });
};