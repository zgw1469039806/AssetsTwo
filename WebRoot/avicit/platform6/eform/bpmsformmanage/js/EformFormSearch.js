/**
 * Created by xb on 2017/8/10.
 */
function EformFormSearch(searchArea, searchFormInfoDiv, searchFormViewDiv) {
    this.searchArea = searchArea;
    this.searchFormInfoDiv = searchFormInfoDiv;
    this.searchFormViewDiv = searchFormViewDiv;

    this.init.call(this);
}
//初始化操作
EformFormSearch.prototype.init = function () {
    var _this = this;
};

//搜索表单
EformFormSearch.prototype.searchEform = function (searchParm) {

    var _this = this;
    $("." + eformComponent.componentArea).css("display", "none");
    $("#" + eformFormInfo.formArea).css("display", "none");
    $("." + _this.searchArea).css("display", "");
    $('#' + _this.searchFormInfoDiv).empty();
    if (showType == "1") {

        $.ajax({
            url: "platform/eform/bpmsManageController/searchFormInfoList",
            data: "searchParm=" + searchParm,
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                var formInfoList = backData.data;

                for (var i = 0; i < formInfoList.length; i++) {
                    eformFormInfo.setFormInfo(formInfoList[i], _this.searchFormInfoDiv);
                }
            }
        });

        $('#' + _this.searchFormViewDiv).empty();
        $.ajax({
            url: "platform/eform/eformViewInfoController/searchViewInfoList",
            data: "searchParm=" + searchParm,
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                var formViewList = backData.data;

                for (var i = 0; i < formViewList.length; i++) {
                    eformFormView.setViewInfo(formViewList[i], _this.searchFormViewDiv);
                }
            }
        });

        bpmsFormInfo.getFormInfoList('null',searchParm);
    }else{
        if(eformFormViewModel==null || eformFormViewModel==undefined){
            var searchSubNames = [];
            var searchSubTips = [];
            searchSubNames.push("name");
            searchSubTips.push("名称");
            $('#formViewModel_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
            var module = [
                {
                    label : 'id',
                    name : 'id',
                    key : true,
                    hidden : true
                }
                , {
                    label : '名称',
                    name : 'name',
                    width : 40,
                    align : 'left',
                    sortable : true,
                    formatter:getformviewEdit
                }
                ,{
                    label : '编码',
                    name : 'code',
                    width : 30,
                    align : 'left',
                    sortable : true
                },
                {
                    label : '样式',
                    name : 'style',
                    width : 30,
                    align : 'left',
                    sortable : true,
                    hidden:true
                },
                {
                    label : '状态',
                    name : 'status',
                    width : 30,
                    align : 'left',
                    sortable : true,
                    formatter:getformviewStatus
                },
                {
                    label : '类型',
                    name : 'type',
                    width : 30,
                    align : 'left',
                    sortable : true,
                    formatter:getformviewType
                }

                ,  {
                    label : '操作',
                    name : 'opt',
                    width : 35,
                    align : 'left',
                    sortable : false,
                    formatter:getformviewButtons
                }
            ];

            var url = "platform/eform/bpmsManageController/getFormViewByPage";
            eformFormViewModel = new EformFormViewModel('formViewModel', url, "formSub", module, 'searchDialogSub', "",
                "", searchSubNames, "formViewModel_keyWord");
            setTimeout(function () {
                eformFormViewModel.searchByKeyWord(searchParm);
            },100);

        }else{
            eformFormViewModel.searchByKeyWord(searchParm);
        }


        if (bpmsformInfoModel==null || bpmsformInfoModel==undefined){
            var searchBpmNames = [];
            var searchBpmTips = [];
            searchBpmNames.push("formName");
            searchBpmTips.push("名称");
            $('#bpmFormModel_keyWord').attr('placeholder', '请输入' + searchBpmTips[0]);
            bpmsformInfoModel = new EformFormInfoModel('bpmFormModel', "bpmFormSub", 'searchBpmForm', this.selectedEformComponentId,
                "", searchBpmNames, "bpmFormModel_keyWord");
            setTimeout(function () {
                bpmsformInfoModel.searchByKeyWord(searchParm);
            },100);
        }else{
            bpmsformInfoModel.searchByKeyWord(searchParm);
        }
    }
    var fl = true;
    $('.nav-tabs>li').each(function(){
        if ($(this).hasClass("active")){
            $(this).trigger("click");
            fl = false;
        }
    });
    if (fl) {
        $('.nav-tabs>li').eq(0).trigger("click");
    }
};