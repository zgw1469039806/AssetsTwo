/**
 * 模拟ajax下载
 * 无弹出框，post提交无参数限制
 * @param iframeId
 * @param formId
 * @param headData
 */
function DownLoad4URL(iframeId, formId, headData, actionUrl) {
    //设置是否显示遮罩Iframe
    if (typeof(iframeId) !== 'string' && iframeId.trim() !== '') {
        throw new Error("iframeId不能为空！");
    }

    //设置是否显示遮罩Iframe
    if (typeof(formId) !== 'string' && formId.trim() !== '') {
        throw new Error("formId不能为空！");
    }
    this.iframeName = "_iframe_" + iframeId;
    this.formName = "_form_" + formId;
    this.doc = document; //缓存全局对象
    this.createDom.call(this, headData, actionUrl);
};
DownLoad4URL.prototype.createDom = function(headData, url) {
    if (jQuery("#" + this.iframeName).length == 0) {
        var exportIframe = this.doc.createElement("iframe");
        exportIframe.id = this.iframeName;
        exportIframe.name = this.iframeName;
        exportIframe.style.display = 'none';
        this.doc.body.appendChild(exportIframe);
        //创建form 
        var exportForm = this.doc.createElement("form");
        exportForm.method = 'post';
        exportForm.action = url;
        exportForm.name = this.formName;
        exportForm.id = this.formName;
        exportForm.target = this.iframeName;
        this.doc.body.appendChild(exportForm);
        if (headData && typeof(headData) === 'object') {
            for (var key in headData) {
                var headInput = this.doc.createElement("input");
                headInput.setAttribute("name", key);
                headInput.setAttribute("type", "text");
                if (typeof(headData[key]) == 'string') {
                    headInput.setAttribute("value", headData[key]);
                } else {
                    var jsonStr = JSON.stringify(headData[key]);
                    headInput.setAttribute("value", jsonStr);
                }
                exportForm.appendChild(headInput);
            }
        }
    }else{
    	var exportForm = this.doc.getElementById(this.formName);
        exportForm.action = url;
    }
};
DownLoad4URL.prototype.downLoad = function() {
    this.doc.getElementById(this.formName).submit();
};