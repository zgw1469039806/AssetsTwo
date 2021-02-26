<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit|ie-stand">
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <link href="static/js/platform/component/jQuery/jquery-easyui-1.3.5/themes/blue/easyui.css" type="text/css" rel="stylesheet">
    <link href="static/js/platform/component/jQuery/jquery-easyui-1.3.5/themes/blue/avicit-easyui-extend-1.3.5.css" type="text/css" rel="stylesheet">
    <link href="static/js/platform/component/jQuery/jquery-easyui-1.3.5/themes/blue/icon.css" type="text/css" rel="stylesheet">
    <script src="static/js/platform/component/common/json2.js" type="text/javascript"></script>
    <script src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.js" type="text/javascript"></script>
    <script src="static/js/platform/component/jQuery/jquery-easyui-1.3.5/jquery.easyui.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="static/h5/skin/imgslider.min.js"></script>

<style type="text/css">
	/*简单标签切换 Start*/
    body,html {
        margin:0;
        padding: 0;
        height: 100%;
        font-size: 14px;
        font-family: 'Microsoft YaHei', simsun, sans-serif, Arial, Helvetica;
    }

    ul {margin:0;padding: 0;}

    .simple-tab {

    }
    .simple-movetab {
        height: 45px;
        position: absolute;
        top: 0;
        right: 0;
        z-index: 1;
    }
    .simple-tab-title {
        padding: 12px;
        border-bottom: 1px solid #2fad95;
    }
    .simple-tab-title li {
        list-style: none;
        display: inline-block;
        font-size: 14px;
        padding: 0 10px;
        line-height: 16px;
        color: #b4b4b4;
        cursor: pointer;
        position: relative;
        border-right: 1px solid #b4b4b4;
    }
    .simple-tab-title li:last-child {
        border:0;
    }
    .simple-tab-title li.on {
        color:#2fad95;
    }
    .simple-tab-title li.on:after,.simple-tab-title li.on:before {
        content: ' ';
        width: 0;
        height: 0;
        position: absolute;
        bottom: -15px;
        left: 50%;
    }
    .simple-tab-title li.on:after {
        border: 6px solid transparent;
        border-bottom: 6px solid #fff;
        margin-left: -4px;
        z-index: 2;
    }
    .simple-tab-title li.on:before {
        border: 8px solid transparent;
        border-bottom: 8px solid #2fad95;
        margin-left: -6px;
        z-index: 1;
    }

    .simple-tab-content {
        padding:20px;
    }
    .simple-tab-item {
        display: none;
        padding-left:50px;
    }
    .simple-tab-item.on {
        display: block;
    }
    /*简单标签切换 End*/
    /*换肤模块 Start*/
    .changui-skins .preview {
        width:128px;
        height: 128px;
        line-height: 128px;
        margin:10px auto 30px;
        text-align: center;
    }
    .changui-skins .preview i {
        font-size: 94px;
    }
    .changui-skins ul {
        text-align: center;
    }
    .changui-skins ul li:hover{
        cursor: pointer;
    }
    .changui-skins li {
        width: 80px;
        height: 80px;
        position: relative;
        display: inline-block;
        top: -10px;
        margin-right: -5px;
        -webkit-transition: all .2s;
        transition: all .2s;
    }
    .changui-skins li.on,.changui-skins li:hover {
        width: 100px;
        height: 120px;
        top: 10px;
        border:2px solid #2fad95;
    }

    .changui-theme li {
        /*     width: 170px; */
        /*     height: 120px; */
        border:0px solid #FFF;
        position: relative;
        display: inline-block;
        /*     margin-right: 15px; */
    }
    .changui-theme img {
        width:100%;
        height: 100%;
    }
    .changui-theme li.on,.changui-theme li:hover {
        border:2px solid #2fad95;
    }

    .icon-jiantou-you {
        background: url("avicit/platform6/portalie/css/images/arrow_right.png") no-repeat;

    }
    .icon-jiantou-zuo {
        background: url("avicit/platform6/portalie/css/images/arrow_left.png") no-repeat;
    }
    .iconfont{
        font-size:60px;
        color: #2fad95;
    }

    .simple-tab-item a{
        text-decoration:none;
        position:absolute;
        display: block;
        top: 180px;
        margin-top: -78px;
        width: 24px;
        height: 26px;
        cursor: pointer;
        z-index: 2;
    }
/*换肤模块 End*/
</style>
</head>
<body>
<div class="easyui-layout" fit="true" >
        <div class="simple-tab"> 
            <div class="simple-movetab"></div> 
            <ul class="simple-tab-title"> 
                <li class="on">主题</li> 
            </ul> 
            <div class="simple-tab-content"> 
                <div class="simple-tab-item on"> 
                    <a class="icon iconfont icon-jiantou-zuo" style="left:0"></a><a class="icon iconfont icon-jiantou-you" style="right:0;"></a>
                    <div class="changui-theme" >
                        ${previews}
                    </div>
                </div> 
            </div> 
        </div> 
        
        <div class="simple-tab" > 
            <ul class="simple-tab-title"></ul> 
            <div class="simple-tab-content"> 
                <div class="simple-tab-item on"> 
                    <div class="changui-skins"> 
                        <ul id="skinsContent">
                            ${skins}
                        </ul>
                    </div> 
                </div> 
            </div> 
        </div> 
	</div>
<script type="text/javascript">
    $(".changui-theme").YuxiSlider({
        width:500, //容器宽度
        height:170, //容器高度
        control:$('a'), //绑定控制按钮
        during:3600000, //间隔4秒自动滑动
        speed:800, //移动速度0.8秒
        //mousewheel:true, //是否开启鼠标滚轮控制
        direkey:true //是否开启左右箭头方向控制
    });
    var defaultTypeKey = '${defaultTypeKey}';
    $(function(){
        loadInit();
    });
    function loadInit(){
        //个人切换皮肤
        $('.changui-theme li').click(function(){
            var typeKey = $(this).attr('data');
            $('#typeKey').val(typeKey);
            selectionThemes(typeKey);
        }).mouseover(function(){
            try{
                layer.tips($(this).attr('name'),this,{tips:[3,"#2fad95"]});
            }catch(e){}
        });

        $('.changui-skins li').click(function(){
            $('#skinsType').val($(this).attr('data'));
            $(this).addClass('on').siblings().removeClass('on');
        });
    }
    function save(){
        $.ajax({
            url:'portal/toSavePersonPortalConfig',
            data : {
                typeKey : $('#typeKey').val(),
                skinsType : $('#skinsType').val(),
                resourceType : 'user',
                appId : '${appId}',
                orgIdentity : '${orgIdentity}',
                j: Math.random()
            },
            dataType : "text",
            type : 'GET',
            success : function(msg){
                if(msg > 0 || msg == 'success'){
                    top.layer.confirm('主题皮肤设置成功，是否进行切换?',{icon: 3, title:'提示'}, function(index){
                        changeThemes();
                    });
                }
            },
            error : function(msg){
                top.layer.alert('主题皮肤设置失败！',{icon: 3, title:'提示'});
            }
        });
    }
    function changeThemes(){
        window.top.location = window.top.location;
        return false;
    }
    function selectionThemes(typeKey){
        var lis = $('.changui-theme li');
        for(var i = 0; i < lis.length ;i++){
            var li = lis[i];
            if($(li).attr('data') == typeKey){
                $(li).addClass('on');
            } else {
                $(li).removeClass();
            }
        }
        getSkinsForThemes(typeKey);
    }
    //动态获取 选中主题下的皮肤
    function getSkinsForThemes(typeKey){
        $.ajax({
            url:'portal/toPersonPortalConfigSkinsForThemes',
            data : {
                typeKey : $('#typeKey').val()
            },
            dataType : "text",
            type : 'GET',
            success : function(msg){
                $("#skinsContent").html(msg);
                loadInit();
            },
            error : function(msg){
                top.layer.alert('主题皮肤设置失败！',{icon: 3, title:'提示'});
            }
        });
    }
</script>
</body>
</html>