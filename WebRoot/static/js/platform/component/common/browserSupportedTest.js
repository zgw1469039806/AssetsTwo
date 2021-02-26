function MyBrowserSupported(){
}
MyBrowserSupported.prototype.IS_SVG = function(){
	return navigator.userAgent.indexOf('Firefox/') >= 0 || navigator.userAgent.indexOf('Iceweasel/') >= 0 || navigator.userAgent.indexOf('Seamonkey/') >= 0 || navigator.userAgent.indexOf('Iceape/') >= 0 || navigator.userAgent.indexOf('Galeon/') >= 0 || navigator.userAgent.indexOf('Epiphany/') >= 0 || navigator.userAgent.indexOf('AppleWebKit/') >= 0 || navigator.userAgent.indexOf('Gecko/') >= 0 || navigator.userAgent.indexOf('Opera/') >= 0;
};
MyBrowserSupported.prototype.IS_IE8 = function(){
	return navigator.userAgent.indexOf('MSIE 8') >= 0;
};
MyBrowserSupported.prototype.isBrowserSupported = function(){
	return this.IS_IE8() || this.IS_SVG();
}; 
var myBrowserSupported = new MyBrowserSupported();