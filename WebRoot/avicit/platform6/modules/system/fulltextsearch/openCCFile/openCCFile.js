/**
 * Created by lianch on 2018/3/21.
 */
function OpenCCFile(formId,formName) {
    this.formId = formId;
    this.formName = formName;

    this.selectDialog = null;
}

OpenCCFile.prototype.init = function () {
    var _this = this;

    var formId = _this.formId;
    var formName = _this.formName;
    var parm = "formId=" + formId + "&formName=" + formName;
    $("#" + formName).click(function () {
        _this.selectDialog = layer.open({
            type: 2,
            title: '选择CC数据源',
            skin: 'bs-modal',
            area: ['600px', '450px'],
            maxmin: false,
            content: "avicit/platform6/modules/system/fulltextsearch/openCCFile/openCCFile.jsp?"+parm
        });
    });
    $("#" + formName).css("cursor", "pointer");
}
function openCC(osel){
	if(osel.options[osel.selectedIndex].text=="cc数据源"){
		document.getElementById('displayAtt2').style.display = '';
	}else{
		document.getElementById('displayAtt2').style.display = 'none';
	}
}