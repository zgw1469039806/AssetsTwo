﻿/**
 * jQuery EasyUI 1.3.5
 * 
 * Copyright (c) 2009-2013 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the GPL or commercial licenses
 * To use it on other terms please contact us: info@jeasyui.com
 * http://www.gnu.org/licenses/gpl.txt
 * http://www.jeasyui.com/license_commercial.php
 *
 */
(function(){
var _1={resizable:{js:"jquery.resizable.js"},panel:{js:"jquery.panel.js",css:"panel.css"},layout:{js:"jquery.layout.js",css:"layout.css",dependencies:["resizable","panel"]},parser:{js:"jquery.parser.js"}};
var _2={"af":"easyui-lang-af.js","ar":"easyui-lang-ar.js","bg":"easyui-lang-bg.js","ca":"easyui-lang-ca.js","cs":"easyui-lang-cs.js","cz":"easyui-lang-cz.js","da":"easyui-lang-da.js","de":"easyui-lang-de.js","el":"easyui-lang-el.js","en":"easyui-lang-en.js","es":"easyui-lang-es.js","fr":"easyui-lang-fr.js","it":"easyui-lang-it.js","jp":"easyui-lang-jp.js","nl":"easyui-lang-nl.js","pl":"easyui-lang-pl.js","pt_BR":"easyui-lang-pt_BR.js","ru":"easyui-lang-ru.js","sv_SE":"easyui-lang-sv_SE.js","tr":"easyui-lang-tr.js","zh_CN":"easyui-lang-zh_CN.js","zh_TW":"easyui-lang-zh_TW.js"};
var _3={};
function _4(_5,_6){
var _7=false;
var _8=document.createElement("script");
_8.type="text/javascript";
_8.language="javascript";
_8.src=_5;
_8.onload=_8.onreadystatechange=function(){
if(!_7&&(!_8.readyState||_8.readyState=="loaded"||_8.readyState=="complete")){
_7=true;
_8.onload=_8.onreadystatechange=null;
if(_6){
_6.call(_8);
}
}
};
document.getElementsByTagName("head")[0].appendChild(_8);
};
function _9(_a,_b){
_4(_a,function(){
document.getElementsByTagName("head")[0].removeChild(this);
if(_b){
_b();
}
});
};
function _c(_d,_e){
var _f=document.createElement("link");
_f.rel="stylesheet";
_f.type="text/css";
_f.media="screen";
_f.href=_d;
document.getElementsByTagName("head")[0].appendChild(_f);
if(_e){
_e.call(_f);
}
};
function _10(_11,_12){
_3[_11]="loading";
var _13=_1[_11];
var _14="loading";
var _15=(easyloader.css&&_13["css"])?"loading":"loaded";
if(easyloader.css&&_13["css"]){
if(/^http/i.test(_13["css"])){
var url=_13["css"];
}else{
var url=easyloader.base+"themes/"+easyloader.theme+"/"+_13["css"];
}
_c(url,function(){
_15="loaded";
if(_14=="loaded"&&_15=="loaded"){
_16();
}
});
}
if(/^http/i.test(_13["js"])){
var url=_13["js"];
}else{
var url=easyloader.base+"plugins/"+_13["js"];
}
_4(url,function(){
_14="loaded";
if(_14=="loaded"&&_15=="loaded"){
_16();
}
});
function _16(){
_3[_11]="loaded";
easyloader.onProgress(_11);
if(_12){
_12();
}
};
};
function _17(_18,_19){
var mm=[];
var _1a=false;
if(typeof _18=="string"){
add(_18);
}else{
for(var i=0;i<_18.length;i++){
add(_18[i]);
}
}
function add(_1b){
if(!_1[_1b]){
return;
}
var d=_1[_1b]["dependencies"];
if(d){
for(var i=0;i<d.length;i++){
add(d[i]);
}
}
mm.push(_1b);
};
function _1c(){
if(_19){
_19();
}
easyloader.onLoad(_18);
};
var _1d=0;
function _1e(){
if(mm.length){
var m=mm[0];
if(!_3[m]){
_1a=true;
_10(m,function(){
mm.shift();
_1e();
});
}else{
if(_3[m]=="loaded"){
mm.shift();
_1e();
}else{
if(_1d<easyloader.timeout){
_1d+=10;
setTimeout(arguments.callee,10);
}
}
}
}else{
if(easyloader.locale&&_1a==true&&_2[easyloader.locale]){
var url=easyloader.base+"locale/"+_2[easyloader.locale];
_9(url,function(){
_1c();
});
}else{
_1c();
}
}
};
_1e();
};
easyloader={modules:_1,locales:_2,base:".",theme:"default",css:true,locale:null,timeout:2000,load:function(_1f,_20){
if(/\.css$/i.test(_1f)){
if(/^http/i.test(_1f)){
_c(_1f,_20);
}else{
_c(easyloader.base+_1f,_20);
}
}else{
if(/\.js$/i.test(_1f)){
if(/^http/i.test(_1f)){
_4(_1f,_20);
}else{
_4(easyloader.base+_1f,_20);
}
}else{
_17(_1f,_20);
}
}
},onProgress:function(_21){
},onLoad:function(_22){
}};
var _23=document.getElementsByTagName("script");
for(var i=0;i<_23.length;i++){
var src=_23[i].src;
if(!src){
continue;
}
var m=src.match(/easyloader\.js(\W|$)/i);
if(m){
easyloader.base=src.substring(0,m.index);
}
}
window.using=easyloader.load;
if(window.jQuery){
jQuery(function(){
easyloader.load("parser",function(){
jQuery.parser.parse();
});
});
}
})();

