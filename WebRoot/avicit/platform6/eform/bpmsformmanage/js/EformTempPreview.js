
/**
 * 预览
 * @param colList
 * @param tableLength
 */
function temppreview(colList,tableLength) {
    var _this = this;
    if(colList.length>0) {
        var table = drawTableHtml(colList, tableLength);
        var content;
        var formName = $("#formName").val();

        if(!verifyIsEmpty(formName)){
            content = "<h1 style=\"text-align: center;\">"+formName+"</h1>"+table.prop('outerHTML');
        }else{
            content = table.prop('outerHTML');
        }

        var tinymceContentStyle = "default";
        var sourceContent = content;

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
            content: "platform/eform/bpmsClient/topreview/bootstrap"
        });
    }
}

function drawTableHtml(colData,trLength,tableLength){
    var itemArray = [];
    var  tableLength = (document.body.clientWidth - 385)*0.94;
    for (var j = 0; j < colData.length; j++) {
        colData[j].realColspan = colData[j].colspan!=''?colData[j].colspan:2;
        var labelId = GenNonDuplicateID();
        var td = '<td style="width: '+ Math.floor(tableLength/trLength)+'px; text-align: right;" ><span class="element label-box" contenteditable="false" id="' + labelId + '"><label for="' + colData[j].colName + '" id="' + GenNonDuplicateID() + '">' +
            (colData[j].colIsMust == "Yes" ? '<i class="required" style="color: #ff0000;">*</i>' : '') + colData[j].colLabel + '：</label>' +
            '<span class="eleattr-span" style="display: none;">{"domId":"' + labelId + '","elementType":"' + colData[j].plugins + '","bindField":"' + colData[j].colName + '","labelName":"' + colData[j].colLabel + '：","labeltype":"' + colData[j].plugins + '-box","ischuantou":"","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","tooltip":"N","tooltipcontent":"","css_class":"","css_style":"","colIsVisibleShow":"","domType":"label-box","colType":"' + colData[j].colType + '"}</span></span></td>' +
            '<td style="width: '+ Math.floor(tableLength/trLength*(colData[j].realColspan-1))+'px;"';
        if(Math.abs(colData[j].colspan)>2){
            td += ' colspan="'+(Math.abs(colData[j].colspan)-1)+'"';
        }
        td += '>';

        var lookup = [];
        var lookupLable = '';
        var lookupValue = '';
        if (colData[j].LookupType != '') {
            $.ajax({
                url: 'platform/syslookuptype/getLookUpCode/' + colData[j].LookupType + '.json',
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (r) {
                    if (r)
                        r.lookupType = colData[j].LookupType;
                    lookup = r;
                }
            });
        }
        if (colData[j].plugins == 'text') {
            td += '<span class="element text-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><input type="text" value="文本输入框" style="width: 95%;" /><span class="eleattr-span" style="display: none;">{"elementType":"text","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsUnique":"N","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","defaultValue":"","formatValidate":"' + colData[j].formatValidate + '","calculateValue":"","calculateCol":"","calculateText":"","onLoadEvent":"","onClickEvent":"","onChangeEvent":"","onKeyupEvent":"","onBlurEvent":"","onFocusEvent":"","onBeforeEvent":"","css_class":"","css_style":"","bpmVar":"","domType":"text-box","colType":"VARCHAR2","allowType":"CLOB"}</span></span>';
        } else if (colData[j].plugins == 'number') {
            td += '<span class="element number-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><input type="text" value="数字输入框" style="width: 95%;" /><span class="eleattr-span" style="display: none;">{"elementType":"text","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsUnique":"N","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","attribute02":"0","minValue":"","maxValue":"","defaultValue":"","calculateValue":"","calculateCol":"","calculateText":"","onLoadEvent":"","onClickEvent":"","onChangeEvent":"","onKeyupEvent":"","onBlurEvent":"","onFocusEvent":"","onBeforeEvent":"","css_class":"","css_style":"","bpmVar":"","domType":"number-box","colType":"NUMBER"}</span></span>';
        } else if (colData[j].plugins == 'date') {
            td += '<span class="element date-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><input type="text" value="日期输入框" style="width: 95%;" /><span class="eleattr-span" style="display: none;">{"elementType":"text","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsUnique":"N","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","attribute03":"2","onLoadEvent":"","onChangeEvent":"","onBlurEvent":"","onBeforeEvent":"","css_class":"","css_style":"","bpmVar":"","defaultVar":"","domType":"date-box","colType":"DATE"}</span></span>';
        }else if(colData[j].plugins == 'textarea'){
            td += '<span class="element textarea-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><textarea style="width: 95%;" rows="2">多行文本框</textarea><span class="eleattr-span" style="display: none;">{"elementType":"textarea","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","rows":"2","defaultPromptValue":"","defaultValue":"","calculateValue":"","calculateCol":"","calculateText":"","onLoadEvent":"","onClickEvent":"","onChangeEvent":"","onKeyupEvent":"","onBlurEvent":"","onFocusEvent":"","onBeforeEvent":"","css_class":"","css_style":"","bpmVar":"","showMaxLength":"","domType":"textarea-box","colType":"VARCHAR2","allowType":"CLOB"}</span></span>';
        } else if (colData[j].plugins == 'select'){
            td += '<span class="element select-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><select onchange="this.blur();" style="width: 95%;">\n';
            for (var ks = 0; ks < lookup.length; ks++) {
                td += '<option value="' + lookup[ks].lookupCode + '">' + lookup[ks].lookupName + '</option>';
                lookupLable += lookup[ks].lookupName + ',';
                lookupValue += lookup[ks].lookupCode + ',';
            }

            td += '</select><span class="eleattr-span" style="display: none;">{"elementType":"text","attribute01":"' + colData[j].LookupType + '","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","showLookupTypeName":"' + colData[j].LookupTypeName + '","showLookupType":"' + colData[j].LookupType + '","selectedoption":"' + lookupLable + '","selectedvalues":"' + lookupValue + '","defaultValue":"","onLoadEvent":"","onChangeEvent":"","onBeforeEvent":"","css_class":"","css_style":"","bpmVar":"","domType":"select-box","colType":"VARCHAR2"}</span></span>';
        }else if(colData[j].plugins == 'radio'){
            td += '<span class="element radio-box" contenteditable="false" id="' + GenNonDuplicateID() + '">';
            for (var kr = 0; kr < lookup.length; kr++) {
                td += '<input type="radio" value="' + lookup[kr].lookupCode + '" /><span class="option">' + lookup[kr].lookupName + '</span>';
                lookupLable += lookup[kr].lookupName + ',';
                lookupValue += lookup[kr].lookupCode + ',';
            }
            td += '<span class="eleattr-span" style="display: none;">{"elementType":"radio","attribute01":"' + colData[j].LookupType + '","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","showLookupTypeName":"' + colData[j].LookupTypeName + '","showLookupType":"' + colData[j].LookupType + '","selectedoption":"' + lookupLable + '","selectedvalues":"' + lookupValue + '","defaultValue":"","onLoadEvent":"","onClickEvent":"","onChangeEvent":"","onBeforeEvent":"","css_class":"","css_style":"","bpmVar":"","domType":"radio-box","colType":"VARCHAR2"}</span></span>';
        }else if(colData[j].plugins == 'check') {
            td += '<span class="element check-box" contenteditable="false" id="' + GenNonDuplicateID() + '">';
            for (var kc = 0; kc < lookup.length; kc++) {
                td += '<input type="checkbox" value="' + lookup[kc].lookupCode + '" /><span class="option">' + lookup[kc].lookupName + '</span>';
                lookupLable += lookup[kc].lookupName + ',';
                lookupValue += lookup[kc].lookupCode + ',';
            }
            td += '<span class="eleattr-span" style="display: none;">{"elementType":"checkbox","attribute01":"' + colData[j].LookupType + '","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","showLookupTypeName":"' + colData[j].LookupTypeName + '","showLookupType":"' + colData[j].LookupType + '","selectedoption":"' + lookupLable + '","selectedvalues":"' + lookupValue + '","defaultValue":"","onLoadEvent":"","onClickEvent":"","onChangeEvent":"","onBeforeEvent":"","css_class":"","css_style":"","bpmVar":"","domType":"check-box","colType":"VARCHAR2"}</span></span>';
        }else if(colData[j].plugins == 'user'){
            td += '<span class="element user-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><input type="text" value="用户选择框" style="width: 95%;" /><span class="eleattr-span" style="display: none;">{"elementType":"text","colRuleName":"user","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsUnique":"N","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","allowSecret":"false","formSecret":"","selectModel":"single","defaultOrgId":"","defaultDeptId":"","redundanceColName":"","chuantouurl":"","chuantouwidth":"","chuantouheight":"","selectDomain":["dept","group","role","position"],"deptlist":"","grouplist":"","rolelist":"","positionlist":"","callbackdept":"","onLoadEvent":"","onBeforeEvent":"","onCallbackEvent":"","css_class":"","css_style":"","bpmVar":"","redundance":"","chuantou":"","defaultUser":"","domType":"user-box","colType":"CLOB","allowType":"VARCHAR2"}</span></span>';
        }else if(colData[j].plugins == 'dept'){
            td += '<span class="element dept-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><input type="text" value="部门选择框" style="width: 95%;" /><span class="eleattr-span" style="display: none;">{"elementType":"text","colRuleName":"dept","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsUnique":"N","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","selectModel":"single","redundanceColName":"","chuantouurl":"","chuantouwidth":"","chuantouheight":"","defaultDeptType":"dept","deptlevel":"","defaultOrgId":"","defaultDeptId":"","deptlist":"","onLoadEvent":"","onBeforeEvent":"","onCallbackEvent":"","css_class":"","css_style":"","bpmVar":"","redundance":"","chuantou":"","defaultDept":"","domType":"dept-box","colType":"CLOB","allowType":"VARCHAR2"}</span></span>';
        }else if(colData[j].plugins == 'org'){
            td += '<span class="element org-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><input type="text" value="组织选择框" style="width: 95%;" /><span class="eleattr-span" style="display: none;">{"elementType":"text","colRuleName":"org","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsUnique":"N","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","selectModel":"single","redundanceColName":"","chuantouurl":"","chuantouwidth":"","chuantouheight":"","onLoadEvent":"","onBeforeEvent":"","onCallbackEvent":"","css_class":"","css_style":"","bpmVar":"","redundance":"","chuantou":"","defaultOrg":"","domType":"org-box","colType":"CLOB","allowType":"VARCHAR2"}</span></span>';
        }else if(colData[j].plugins == 'position'){
            td += '<span class="element position-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><input type="text" value="岗位选择框" style="width: 95%;" /><span class="eleattr-span" style="display: none;">{"elementType":"text","colRuleName":"position","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsUnique":"N","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","selectModel":"single","redundanceColName":"","chuantouurl":"","chuantouwidth":"","chuantouheight":"","positionlist":"","onLoadEvent":"","onBeforeEvent":"","onCallbackEvent":"","css_class":"","css_style":"","bpmVar":"","redundance":"","chuantou":"","domType":"position-box","colType":"CLOB","allowType":"VARCHAR2"}</span></span>';
        }else if(colData[j].plugins == 'role'){
            td += '<span class="element role-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><input type="text" value="角色选择框" style="width: 95%;" /><span class="eleattr-span" style="display: none;">{"elementType":"text","colRuleName":"role","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsUnique":"N","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","selectModel":"single","redundanceColName":"","chuantouurl":"","chuantouwidth":"","chuantouheight":"","rolelist":"","onLoadEvent":"","onBeforeEvent":"","onCallbackEvent":"","css_class":"","css_style":"","bpmVar":"","redundance":"","chuantou":"","domType":"role-box","colType":"CLOB","allowType":"VARCHAR2"}</span></span>';
        }else if(colData[j].plugins == 'group'){
            td += '<span class="element group-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><input type="text" value="群组选择框" style="width: 95%;" /><span class="eleattr-span" style="display: none;">{"elementType":"text","colRuleName":"group","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsUnique":"N","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","selectModel":"single","redundanceColName":"","chuantouurl":"","chuantouwidth":"","chuantouheight":"","grouplist":"","onLoadEvent":"","onBeforeEvent":"","onCallbackEvent":"","css_class":"","css_style":"","bpmVar":"","redundance":"","chuantou":"","domType":"group-box","colType":"CLOB","allowType":"VARCHAR2"}</span></span>';
        }else if(colData[j].plugins == 'photo'){
            td += '<span class="element photo-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><input type="text" value="图片选择框" style="width: 95%;" /><span class="eleattr-span" style="display: none;">{"elementType":"text","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1)  + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsUnique":"N","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '", "linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","cropwidth":"","cropheight":"","css_class":"","css_style":"","bpmVar":"","crop":"","domType":"photo-box","colType":"BLOB"}</span></span>';
        }else {
            td += '<span class="element text-box" contenteditable="false" id="' + GenNonDuplicateID() + '"><input type="text" value="文本输入框" style="width: 95%;" /><span class="eleattr-span" style="display: none;">{"elementType":"text","tableName":"","colName":"' + colData[j].colName + '","colLabel":"' + colData[j].colLabel + '","domId":"","domdataid":"","colIsMust":"' + colData[j].colIsMust.substring(0, 1) + '","colIsVisible":"' + colData[j].colIsVisible.substring(0, 1) + '","colDropdownType":"' + colData[j].colDropdownType.substring(0, 1) + '","colIsUnique":"N","linkageEle_ctrl":"","linkageColumnid_ctrl":"","linkageImpl_ctrl":"","linkageResultType_ctrl":"","colLength":"' + colData[j].colLength + '","defaultValue":"","formatValidate":"","calculateValue":"","calculateCol":"","calculateText":"","onLoadEvent":"","onClickEvent":"","onChangeEvent":"","onKeyupEvent":"","onBlurEvent":"","onFocusEvent":"","onBeforeEvent":"","css_class":"","css_style":"","bpmVar":"","domType":"text-box","colType":"VARCHAR2","allowType":"CLOB"}</span></span>';
        }
        td += '</td>';
        itemArray.push(td);
    }
    //var emptyTd = '<td style="width: '+ Math.floor(tableLength/trLength)+'px;"></td><td style="width: '+ Math.floor(tableLength/trLength)+'px;"></td>';
    var emptyTd = '<td style="width: '+ Math.floor(tableLength/trLength)+'px;"></td>';
    var itemCount = 0;
    var tr = '<tr>';
    var forceNext = false;
    while (itemCount<itemArray.length){
        for(var l=0; l<=trLength;){
            if(l==trLength){                                    //占满换行
                tr += '</tr><tr>';
                l += 2;
                forceNext = false;
            }else if(itemCount>=itemArray.length){              //最后填满
                while(l<trLength){
                    tr+= emptyTd;
                    l += 1;
                }
                tr += '</tr>';
                continue
            }else if(colData[itemCount].realColspan<0){        //另起一行
                colData[itemCount].realColspan = Math.abs(colData[itemCount].realColspan);
                if(l!=0){
                    forceNext = true;
                }
            }
            else if(l+parseInt(colData[itemCount].realColspan)>trLength || forceNext){  //当前列太长需换行或是强制换行
                while(l<trLength){
                    tr+= emptyTd;
                    l += 1;
                }
                forceNext = false;
            }else{  //正常填入td
                tr += itemArray[itemCount];
                l += parseInt(colData[itemCount].realColspan);
                itemCount ++;
            }
        }
    }
    var content = $("<table class=\" onchoose\" style=\"width: "+tableLength+"px;\"><tbody></tbody></table>");
    content.append($(tr));
    return content;
}

function GenNonDuplicateID() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
        return v.toString(16);
    });
}

/**
 * 验证是否为空
 * @param value
 * @returns {boolean}
 */
function verifyIsEmpty(value) {
    var regExp = /[\S+]/i;
    if (regExp.test(value)) {
        return false;
    }
    else {
        return true;
    }
}