$(function(){
    fixPlaceHold();
});
// 修复ie9一下placeholer问题
function fixPlaceHold(){
    if(navigator.appName == "Microsoft Internet Explorer"&&parseInt(navigator.appVersion.split(";")[1].replace(/[ ]/g, "").replace("MSIE",""))<=9){
        $('input[placeholder]').each(function(){
            var $this = $(this);
            $this.val($this.attr('placeholder'));
            $this.on('focus.placeholder',function(){
                if($this.val() == $this.attr('placeholder')){
                    $this.val('');
                }
            }).on('blur.placeholder',function(){
                if(!$this.val()){
                    $this.val($this.attr('placeholder'));
                }
            });
        });
    }
}

/**
 * 更换主题-事件
 */
function changeThemesSkinsEvent(){
    var url = "portal/toPersonPortalConfig";
    layer.open({
        type : 2,
        title: '切换主题',
        skin: 'index-model-noborder',
        move :'.simple-movetab',
        area: ['680px', '420px'],
        content : url,
        btn: ['确认', '取消'],
        yes: function(index, layero) {
            var iframeWin = layero.find('iframe')[0].contentWindow;
            iframeWin.save();
            return false;
        },btn2: function(index, layero) {
        	var iframeWin = layero.find('iframe')[0].contentWindow;
            iframeWin.restSkin();
        },
        success: function(dom) {
            changeThemeOrSkin(dom);
        },cancel: function (index, layero) {
        	var iframeWin = layero.find('iframe')[0].contentWindow;
            iframeWin.restSkin();
         }

    });
}

// 换主题或者换肤里的交互效果
function changeThemeOrSkin(dom){
    //皮肤选择效果初始化
    dom.find('.changui-skins .preview').css('color',dom.find('.changui-skins li.on').css('backgroundColor'));
    dom.find('.changui-skins li').on('mouseenter',function(){
        var color = $(this).css('backgroundColor');
        $(this).parents('.changui-skins').find('.preview').css('color',color);
    }).on('mouseout',function(){
        var color = $(this).parent().find('li.on').css('backgroundColor');
        $(this).parents('.changui-skins').find('.preview').css('color',color);
    }).on('click',function(){
        $(this).addClass('on').siblings().removeClass('on');
    }).changeui({
        linkDom:"#theme"
    });
}

//设置
function settings(){
    layer.open({
        type : 2,
        area: ['900px', '550px'],
        title : '个人设置',
        skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin : false, // 开启最大化最小化按钮
        content : "platform/console/customed/toSysCustomedEdit"
    });
}

// 注销
function logout() {
    layer.confirm('确认要离开系统吗？', {
        title: '提示',
        icon : 3,
        area: ['400px', ''],
        closeBtn : 0,
        btn: ['确定','取消'] //按钮
    }, function(){
        window.location ='login/console/logout.jsp';
    }, function(){
        //点击取消
    });
}
//返回控制台
function backConsole() {
	window.open('console/index','_console');
}
//用户多组织身份切换
function userSwich() {
//    $('.rightTool').delegate('.userhead .switch', 'click', function(e) {
//        e.stopPropagation();
//       
//    });
    openChangeMoreOrgDailog();
}
//打开用户多组织身份切换界面
function openChangeMoreOrgDailog(){
    layer.open({
        type : 2,
        area: ['430px', '200px'],
        title : '切换身份',
        skin : 'bs-modal',
        maxmin : false, 
        closeBtn : 0,
        content : "userChangeMultipleIdentity/getChangeUserLoginOrgWeb",
        btn: ['确定','取消'],
        yes: function(index, layero){
            var iframeWin = layero.find('iframe')[0].contentWindow;
            var orgId = iframeWin.getOrgId();
            var deptId = iframeWin.getDeptId();
            var currentOrgId = iframeWin.getCurrentOrgId();
//          if(orgId == currentOrgId){
//              layer.alert('当前身份已是【' + iframeWin.getCurrentOrgName() + '】', {
//                    title : '提示',
//                    icon : 7,
//                    area: ['400px', ''], //宽高
//                    closeBtn: 0
//                  }
//              );
//              return;
//          }
            layer.confirm('确认要切换当前身份吗？', {
                title: '提示',
                icon : 3,
                area: ['400px', ''],
                btn: ['确定','取消'], //按钮
                closeBtn : 0
            }, function(){
                changeUserLoginDeptEvent(deptId,orgId);
            }, function(){
                //点击取消
            });
        }
    });
}
//切换当前登陆用户身份
function changeUserLoginDeptEvent(deptId,orgId){
    $.ajax({
        url: "userChangeMultipleIdentity/changeUserLoginOrg",
        type: 'POST',
        dataType: 'text',
        data:{
          deptId : deptId,
          orgId : orgId
        },
        success: function (r) {
            if(r == 'success') {
                window.top.location = window.top.location;
            } else {
                layer.alert(r, {icon: 7});
            }
        },
        error : function(r){

        }
    });
}

/**
 * 打开更多消息页
 */
function moreMessage() {
    addTab('我的消息','msystem/sysmsg/sysMsgController/toSysMsgManage');
}
/**
 * 获取本人未读消息数量
 */
function queryUnReadMessageAmount() {
    $.ajax({
        url: "portal/getUnReadMessageCount?o="+Math.random()+"&_notUpdateSession=true",
        // type: 'post',
        success: function (r) {
            if(r.flag=='success'){
                var data = r.count;
                if(data > 99){
                    data = 99;
                }
                if(data > 0){
                    $('#unreadMessage').html('<div class="msg-tip"><span class="text">'+data+'</span></div>');
                } else {
                    $('#unreadMessage').html('');
                }
            } else {
                layer.alert('当前会话已失效，请重新登录系统.', {icon: 7,title : '提示',area: ['400px', ''], closeBtn: 0}, function(index){
                    top.location.href="login";
                    layer.close(index);
                });
            }
        }
    });
}

/**
 * 清空个人菜单
 */
function trunkPersonalMenu() {
    try{
         event.stopPropagation();
    } catch(e){
        
    }
    layer.confirm('确认清空吗？',{
        title: '提示',
        icon : 3,
        area: ['400px', ''],
        btn: ['确定','取消'], //按钮
        closeBtn : 0
    }, function(){
        avicAjax.ajax({
            url: "portal/trunkMenu",
            type: 'post',
            dataType: 'json',
            quiet:true,
            success: function (r) {
                if(r.flag=='success'){
                    $('#personalMenuUl').html('');//清空内容
                    layer.msg("清空成功");
                } else{
                    layer.alert('清空失败！' + r.data, {
                            icon: 7,
                            area: ['400px', ''], //宽高
                            closeBtn: 0
                        }
                    );
                }
            }
        });
    }, function(){
    });
}

/**
 * 加载候选的菜单
 */
function loadMenuNotAdded() {
    layer.open({
        title: '新增菜单',
        skin: 'index-model',
        area: ['370px', '490px'],
        content: 'portal/getAvailableMenu',
        type : 2,
        btn: ['确认', '取消'],
        yes: function(index, layero) {
            var iframeWin = layero.find('iframe')[0].contentWindow;
            var toAddArray = iframeWin.getSelected();
            savePersonalMenu(toAddArray);
            layer.close(index);
        },
        btn2: function(index, layero) {

        }
    });

}

/**
 * 加载个人菜单并更新dom
 */
function loadPersonalMenu() {

    avicAjax.ajax({
        url: "portal/getPersonalMenu?o="+Math.random(),
        type: 'get',
        dataType: 'json',
        success: function (r) {
            if(r.flag=='success'){
                var html = '';
                var data = r.data;
                for(var i = 0 ; i < data.length ; i++){
                    html+='<li style="cursor:default"><span style="cursor: pointer;" id="li-' + data[i].menuId + '"  title="' + data[i].menuName + '" onclick="openPersonalItem(this);return false;" rel="' + data[i].menuUrl + '">' + data[i].menuName + '</span><em style="cursor: pointer;" class="icon icon-close" onclick="delPersonalMenu(this,\''+data[i].menuId+'\');return false;"></em></li>';
                }
                $('#personalMenuUl').html(html);
            } else{
                layer.alert('获取失败！' + r.data, {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                    }
                );
            }
        }
    });
}



/**
 * 保存选中菜单
 */
function savePersonalMenu(toAddArray) {
    if(toAddArray.length <= 0){
        layer.alert('请至少勾选一项菜单！' + r.data, {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return;
    }
    avicAjax.ajax({
        url: "portal/saveMenu",
        type: 'post',
        data:{
            menuIds:toAddArray.join(";")
        },
        dataType: 'json',
        success: function (r) {
            if(r.flag=='success'){
                layer.msg("添加成功");
            } else{
                layer.alert('添加失败！' + r.data, {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                    }
                );
            }
        }
    });
}

/**
 * 根据menuId删除选中菜单
 * @param menuId
 */
function delPersonalMenu(e,menuId) {
    var evt = e || window.event;
    evt.stopPropagation ? evt.stopPropagation() : (evt.cancelBubble=true);
    var title = $('#li-'+menuId).text();
    layer.confirm('确认删除['+title+']吗？', {
        title: '提示',
        icon : 3,
        area: ['400px', ''],
        closeBtn : 0,
        btn: ['确认','取消'] //按钮
    }, function(){
        avicAjax.ajax({
            url: "portal/deleteByMenuId",
            type: 'post',
            data:{
                menuIds:menuId
            },
            dataType: 'json',
            success: function (r) {
                if(r.flag=='success'){
                    $('#li-' + menuId).remove();//移除菜单
                    layer.msg("删除成功");
                } else{
                    layer.alert('删除失败！' + r.data, {
                            icon: 7,
                            area: ['400px', ''], //宽高
                            closeBtn: 0
                        }
                    );
                }
            }
        });
    }, function(){
    });
}

function stopPropagation(e){
    e = window.event || e;
    if(document.all){
        e.cancelBubble=true;
    }else{
        e.stopPropagation();
    }
}


/**
 * 加载个人消息并更新dom
 */
function loadPersonalMessage() {
    avicAjax.ajax({
        url: "portal/getUnReadMessageList?o="+Math.random()+"&_notUpdateSession=true",
        type: 'get',
        dataType: 'json',
        quiet:true,
        success: function (r) {
            if(r.flag=='success'){
                var html = '';
                var data = r.list;
                for(var i=0;i<data.length;i++){
                    html+='<li title="'+data[i].title+'" data-id="'+data[i].id+'" data-broadcastFlag="'+data[i].broadcastFlag+'" onclick="readPersonalMessage(this)" rel="'+data[i].urlAddress+'">'+data[i].title+'</li>';
                }
                $('#personalMessageUl').html(html);
            } else{
                layer.alert('获取失败！' + r.data, {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                    }
                );
            }
        }
    });
}

/**
 * 读个人消息
 * @param obj
 */
function readPersonalMessage(obj) {
    var id = $(obj).attr('data-id');
    var broadcastFlag = $(obj).attr('data-broadcastFlag');
    var url = $(obj).attr('rel');
    
    $(obj).detailMsg({formid:id,url:url,area: ['60%', '80%'],success: function(layero, index){
        avicAjax.ajax({
            url: "portal/readMessage",
            type: 'get',
            dataType: 'json',
            data:{
              id:id,
              broadcastFlag:broadcastFlag
            },
            quiet:true,
            success: function (r) {
                queryUnReadMessageAmount();//读消息后，刷新数量
            }
        });
    }});
}



//---------------------------个人消息:end----------------------------



//常用菜单栏菜单点击事件
function openPersonalItem(obj) {
    var evt = obj || window.event;
    evt.stopPropagation ? evt.stopPropagation() : (evt.cancelBubble=true);
    var title = $(obj).text(),
        url = $(obj).attr("rel");
    addTab(title,url);
}
/**
 * 设置主体高度
 */
function setHeight() {
    var head = $('.header'),
        body = $('.mainBody'),
        main = $('.main');
    main.height($('body').innerHeight() - head.height());
    body.height($('body').innerHeight());
    $("#tabs-panel").height($('body').innerHeight() - head.height());
    $(window).on('resize', function() {
        main.height($('body').innerHeight() - head.height());
        body.height($('body').innerHeight());
    });
}

//授权信息
function showLicenseInfo(){
    $.ajax({
        cache: false,
        type: "GET",
        url:'platform/systemversion/getLicenseInfo',
        dataType:"html",
        error: function(data) {
            layer.alert('授权信息获取失败!',{iconType:3,title:'提示',area: ['400px', '']});
        },
        success: function(data) {
            layer.alert(data,{title:'授权信息',area: ['450px', '']});
            
        }
    });
}
//版本信息
function showVersionInfo(){
    $.ajax({
        cache: false,
        type: "GET",
        url:'platform/systemversion/getVersionInfo',
        dataType:"html",
        error: function(data) {
            layer.alert('授权信息获取失败!',{iconType:3,title:'提示',area: ['400px', '']});
        },
        success: function(data) {
            layer.alert(data,{title:'版本信息',area: ['400px', '']});
            
        }
    });
}



//全屏执行方法
function fullWindow() {
	$("#fullWindowBtn").hide();
	$("#quiteFullWindowBtn").show();
	var content = document.getElementById('content');
	fullScreen(content);
};
//退出全屏执行方法
function quiteFullWindowBtnFullWindow() {
	$("#fullWindowBtn").show();
	$("#quiteFullWindowBtn").hide();
	var content = document.getElementById('content');
	exitFullScreen();
};
function WALL_web() {
	var WshShell = new ActiveXObject('WScript.Shell')
	WshShell.SendKeys('{F11}');
}

function fullScreen(el) {
	var rfs = el.requestFullScreen || el.webkitRequestFullScreen
			|| el.mozRequestFullScreen || el.msRequestFullScreen, wscript;
	if (typeof rfs != "undefined" && rfs) {
		rfs.call(el);
		return;
	}
	if (typeof window.ActiveXObject != "undefined") {
		try{
			wscript = new ActiveXObject("WScript.Shell");
			if (wscript) {
				wscript.SendKeys("{F11}");
			}
		}catch(e){
			$("#fullWindowBtn").show();
			$("#quiteFullWindowBtn").hide();
			layer.alert("请设置IE浏览器允许加载ActiveX控件，否则无法支持全屏操作！",{title:'提示',area: ['450px', '']});
		}
	}
}
function exitFullScreen(el) {
	var el = document, cfs = el.cancelFullScreen || el.webkitCancelFullScreen
			|| el.mozCancelFullScreen || el.exitFullScreen, wscript;

	if (typeof cfs != "undefined" && cfs) {
		cfs.call(el);
		return;
	}

	if (typeof window.ActiveXObject != "undefined") {
		wscript = new ActiveXObject("WScript.Shell");
		if (wscript != null) {
			wscript.SendKeys("{F11}");
		}
	}
} 





//打开方式：mairFrame
function openMainFrame(title,url){
    //tab标题长度大于8个字符,截取前8个,后面的显示为...
    var preTitle = title;
    if(title != null && title != '' && title != undefined ){
        if(title.length > 8){
            title = title.substr(0,8) + "...";
        }
    }
    if(!url) return;
    var exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
    if (!exist && url != undefined && url != "") {
        $('#tabs-panel').tabs({
            onAdd:function(title,index){
                var target = this;
                var tab = $('#tabs-panel').tabs('getTab', title);
                setTimeout(function(){
                    $(target).tabs('select', title).tabs('update',{
                        tab:tab,
                        options:{
                            content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>'
                        }
                    });
                },500);
                //获取当前添加的tab并增加title属性
                var currentTab = $(target).tabs('select', title).find(".tabs-selected").find("span.tabs-title");
                if(currentTab != null && currentTab != '' && currentTab != undefined){
                    currentTab.attr("title",preTitle);
                }
            }
        });
        $('#tabs-panel').tabs('add', {
            title: title,
            content: ' ',
            closable: true
        });
    } else {
        $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
    }
}
//打开方式:top
function openTop(title,url){
    window.open(url, '_top');
}
//打开方式:blank
function openBlank(title,url){
    window.open(url, '_blank');
}
//打开方式:self
function openSelf(title,url){
     window.open(url,'_self');
}

