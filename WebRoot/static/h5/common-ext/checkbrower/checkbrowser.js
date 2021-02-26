(function() {
    function addLoadEvent(func) {
        var oldonload = window.onload;
        if (typeof window.onload != 'function') {
            window.onload = func;
        } else {
            window.onload = function() {
                if (oldonload) {
                    oldonload();
                }
                func();
            }
        }
    }

    var alertContent = '<p>提示 : 您正在使用低版本ie浏览器。为确保您的最佳体验及正常使用，请升级您的ie至 <a id="btnUpdateBrowser" title="IE10" target="_blank" href="https://support.microsoft.com/zh-cn/help/17621/internet-explorer-downloads">ie10</a> 以上版本，或考虑使用以下浏览器 ' +
        '<a title="Chrome" target="_blank" href="http://www.google.cn/chrome/browser/desktop/index.html"><i class="dicon w chrome"></i>Chrome</a>;' +
        '<a title="Firefox" target="_blank" href="http://www.firefox.com.cn/download/"><i class="dicon w firefox"></i>Firefox</a>;' +
        '<a title="Safari" target="_blank" href="https://support.apple.com/zh_CN/downloads/safari"><i class="dicon w safari"></i>Safari</a>' +
        '</p>' +
        '<p class="last"><a href="#" id="btnCloseUpdateBrowser"  title="现在不升级也没关系，我后天再来提醒您~">&times;</a></p>';
    //判断ie8及以下
    if (document.all && !document.addEventListener) {
        addLoadEvent(function() {
            setTimeout(function(){
                displayResponse();
            },3000)
        });
    }
    function displayResponse() {
        if(getCookie('checkbrower')) return;
        var od = document.createElement('div');
        document.body.appendChild(od);
        od.setAttribute("id", "outdated");
        var insertContentHere = document.getElementById("outdated");
        insertContentHere.innerHTML = alertContent;
        startStylesAndEvents();
        return false;
    }

    function startStylesAndEvents() {
        var btnClose = document.getElementById("btnCloseUpdateBrowser");

        btnClose.onmousedown = function() {
            outdated.style.display = 'none';
            setCookie('checkbrower',1,2)
            return false;
        };
    }

    function getCookie(objName) {
        var arrStr = document.cookie.split("; ");
        for (var i = 0; i < arrStr.length; i++) {
            var temp = arrStr[i].split("=");
            if (temp[0] == objName) return unescape(temp[1]);
        }
        return "";
    }

    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires=" + d.toGMTString();
        document.cookie = cname + "=" + escape(cvalue) + "; " + expires;
    }
})();