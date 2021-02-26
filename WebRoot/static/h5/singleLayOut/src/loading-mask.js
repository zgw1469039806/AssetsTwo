// 独立加载蒙层
var loadingMask = {
    _id: 'loadingDiv',
    auto: function() {
        var nod = document.createElement('style'),
            str = 'body{overflow:hidden} body.loaded {overflow:auto}';
        nod.type = 'text/css';
        var configCss = 
        		".snippet{" +
        		"position: fixed;" + 
			    "left: 0;" + 
			    "right: 0;" + 
			    "top: 0;" + 
			    "bottom: 0;" + 
			    "background: #fff;" + 
			    "z-index: 10010;" + 
        		"}" + 
				".stage {" +
				"    display: block;" + 
				"    width: 140px;" + 
				"    margin: 0 auto;" + 
				"    position: absolute;" + 
				"    left: 50%;" + 
				"    top: 50%;" + 
				"    margin-left: -60px;" + 
				"    margin-top: -20px;" + 
				"}" + 
				".filter-contrast {" + 
				"  filter: contrast(5);" + 
				"  background-color: white;" + 
				"}" + 
				".dot-p {" + 
				"  text-align: center;" + 
				"  font-size: 16px;" + 
				"  margin-top: 10px;" + 
				"  color: #92a0b2;" + 
				"}" + 
				".dot-pulse {" + 
				"  position: relative;" + 
				"  left: -9999px;" + 
				"  width: 10px;" + 
				"  height: 10px;" + 
				"  border-radius: 5px;" + 
				"  background-color: #297CE6;" + 
				"  color: #297CE6;" + 
				"  box-shadow: 9984px 0 0 0 #297CE6, 9999px 0 0 0 #297CE6, 10014px 0 0 0 #297CE6;" + 
				"  animation: dotPulse 1.5s infinite linear;" + 
				"  margin-left: 60px;" + 
				"}" + 
				"@keyframes dotPulse {" + 
				"  0% {" + 
				"    box-shadow: 9984px 0 0 -5px #297CE6, 9999px 0 0 0 #297CE6, 10014px 0 0 2px #297CE6" + 
				"  }" + 
				"  25% {" + 
				"    box-shadow: 9984px 0 0 0 #297CE6, 9999px 0 0 2px #297CE6, 10014px 0 0 0 #297CE6" + 
				"  }" + 
				"  50% {" + 
				"    box-shadow: 9984px 0 0 2px #297CE6, 9999px 0 0 0 #297CE6, 10014px 0 0 -5px #297CE6" + 
				"  }" + 
				"  75% {" + 
				"    box-shadow: 9984px 0 0 0 #297CE6, 9999px 0 0 -5px #297CE6, 10014px 0 0 0 #297CE6" + 
				"  }" + 
				"  100% {" + 
				"    box-shadow: 9984px 0 0 -5px #297CE6, 9999px 0 0 0 #297CE6, 10014px 0 0 2px #297CE6" + 
				"  }" + 
				"}" + 
				".dot-pulse{" + 
				"  display: block\\0;" + 
				"  height: 16px\\0;" + 
				"  background: url(static/h5/singleLayOut/themes/images/loadingImage.gif) no-repeat center\\0;" + 
				"  margin-left: -20px\\0;" + 
				"  left: auto\\0;" + 
				"  width: auto\\0;" + 
				"}";
        
        
        if (nod.styleSheet) {
            nod.styleSheet.cssText = str;
        } else {
            nod.innerHTML = str + configCss;
        }
        
        document.getElementsByTagName('head')[0].appendChild(nod);
        var that = this;
		
        function _onchange() {
            if (document.readyState == "complete") {
                setTimeout(function() {
                    that.close();
                }, 500);
            }
        }
        //呈现loading效果
        that.open();
        //监听加载状态改变
        document.onreadystatechange = _onchange;
    },
    open: function() {
        //加载gif地址
        var _loadimagerul = "";
        var _dom = '';
        if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
//          _dom = '<div id="' + this._id + '" style="position:fixed;left:0;width:100%;height:100%;top:0;background:#f3f8ff;opacity:1;filter:alpha(opacity=100);z-index:10000000;"><div style="position: fixed; cursor: wait; left: 50%;margin-left:-50px; top:50%; width:100px; height: 40px; line-height: 38px;margin-top:-50px;text-align:center;padding-left: 5px; padding-right: 5px; background: #fff url(' + _loadimagerul + ') no-repeat scroll 5px 12px; border: 2px solid #95B8E7; color: #696969; font-family:\'Microsoft YaHei\';">加载中...</div></div>';
        	_dom = '<div id="' + this._id + '" style="position:fixed;left:0;width:100%;height:100%;top:0;background:#f3f8ff;opacity:1;filter:alpha(opacity=100);z-index:10000000;">'+
        	   '<div style="position:absolute;left:50%; top:50%; margin-left:-50px; margin-top:-20px;cursor: wait;width:100px; height: 40px; line-height: 38px;text-align:center;padding-left: 5px; padding-right: 5px; background: #fff url(' + _loadimagerul + ') no-repeat scroll 5px 12px; border: 2px solid #95B8E7; color: #696969; font-family:\'Microsoft YaHei\';">'+
        	    '数据加载中...'+
        	   '</div>' +
        	  '</div>'; 
        }else{
        	 _dom = '<div id="' + this._id + '" class="snippet">'+
				'<div class="stage">'+
					'<div class="dot-pulse"></div>'+
					'<p class="dot-p">数据加载中...</p>'+
				'</div>'+
			'</div>';
        }
        document.write(_dom);
        
    },
    close: function() {
        var loadingMask = document.getElementById(this._id);
        loadingMask.parentNode.removeChild(loadingMask);
        document.getElementsByTagName('body')[0].className += ' loaded';
    }
};
loadingMask.auto();
