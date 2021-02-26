/**
 * 更换主题-事件
 */
function changeThemesSkinsEvent(){
	var url = "portal/toPersonPortalConfig";
    layer.open({
    	type : 2,
        title: false,
        skin: 'index-model-noborder',
        move :'.simple-movetab',
        area: ['680px', '420px'],
        content : url,
        btn: ['确认', '取消'],
        yes: function(index, layero) {
        	var iframeWin = layero.find('iframe')[0].contentWindow;
        	iframeWin.save();
            return false;
        },
        success: function(dom) {
            changeThemeOrSkin(dom);
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
    });
}

//设置
function settings(){
    layer.open({
        type : 2,
        area: ['900px', '550px'],
        title : '个人设置',
        maxmin : false, // 开启最大化最小化按钮
        content : "platform/console/customed/toSysCustomedEditIe?random="+Math.random()
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
        window.location ='login/logout.jsp';
    }, function(){
        //点击取消
    });
}
//用户多组织身份切换
function userSwich() {
    openChangeMoreOrgDailog();
}
//打开用户多组织身份切换界面
function openChangeMoreOrgDailog(){
	layer.open({
        type : 2,
        area: ['450px', '230px'],
        title : '切换身份',
        skin: 'index-model-noborder',
        maxmin : false, 
        closeBtn : 0,
        content : "userChangeMultipleIdentity/getChangeUserLoginOrgWeb",
        btn: ['确定','取消'],
        yes: function(index, layero){
        	var iframeWin = layero.find('iframe')[0].contentWindow;
        	var orgId = iframeWin.getOrgId();
        	var deptId = iframeWin.getDeptId();
        	var currentOrgId = iframeWin.getCurrentOrgId();
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
        	alert('error');
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
        url: "portal/getUnReadMessageCount",
        // type: 'post'
        quiet:true,
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
            }
        },
        error : function(r){
        	
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
    layer.confirm('确认清空吗？', {
        btn: ['确认','取消'] //按钮
    }, function(){
        avicAjax.ajax({
            url: "portal/trunkMenu",
            data : {
                j: Math.random()
            },
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
    $.ajax({
        url: "portal/getAvailableMenu",
        data : {
            j: Math.random()
        },
        type: 'get',
        dataType: 'json',
        success: function (r) {
            if(r.flag=='success'){
                var html = '';
                var data = r.data;
                for(var i = 0;i < data.length;i++){
                    html+='<div class="parentMenu"><span class="parentMenuName">'+data[i].menuName+'</span></div>';
                    var sub = data[i].subMenu;
                  html+='<div class="subMenu">';
                   for(var j=0;j<sub.length;j++){
                        html+='<div class="checkbox">'+
                            '<label>'+
                            '<input name="selectMenu" type="checkbox"  style="width : 30px" ';
                        if(sub[j].select){
                            html+='checked="checked"';
                        }
                        html+='value="'+sub[j].menuId+'">'+
                            '<span class="text">'+sub[j].menuName+'</span>'+
                            '</label>'+
                            '</div>';
                    }
                    html+='</div>';
                }
                  layer.open({
                    title: '新增菜单',
                    area: ['370px', '400px'],
                   content: "<div style='width:330px;height:350px;overflow-y:auto;overflow-x:hidden;'>" + html + "</div>",
                    success: function(dom) {
                    	dom.find('.layui-layer-content')
                    },
                    btn: ['确认', '取消'],
                    yes: function(index, layero) {
                        savePersonalMenu();
                        return false;
                    },
                    btn2: function(index, layero) {
                        //按钮【取消】的回调

                        //return false; //开启该代码可禁止点击该按钮关闭
                    }
                });
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
 * 加载个人菜单并更新dom
 */
function loadPersonalMenu() {
    avicAjax.ajax({
        url: "portal/getPersonalMenu",
        data : {
            j: Math.random()
        },
        type: 'get',
        dataType: 'json',
        quiet:true,
        success: function (r) {
            if(r.flag=='success'){
                var html = '',menuid;
                var data = r.data;
               
                for(var i=0;i<data.length;i++){
                    html+='<li id="li-'+data[i].menuId+'"  title="'+data[i].menuName+'" onclick="openPersonalItem(this)" rel="'+data[i].menuUrl+'">'+data[i].menuName + '<em class="icon icon-close" onclick="delPersonalMenu(\''+data[i].menuId+'\')"></em></li>';
                    menuid = data[i].menuId;
                    html = $('<li id="li-'+data[i].menuId+'"  title="'+data[i].menuName+'" onclick="openPersonalItem(this)" rel="'+data[i].menuUrl+'">'+data[i].menuName+'<em class="icon icon-close"></em></li>');
                    html.find('em').on("click",function(e){
                        e.stopPropagation();
                        delPersonalMenu(menuid);
                    });
                    $('#personalMenuUl').html(html);
                }
                $('#personalMenuUl').find('li').on('mouseenter',function(){
                    $(this).addClass('on');
                }).on('mouseleave',function(){
                    $(this).removeClass('on');
                });
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
function savePersonalMenu() {
    var toAddArray = [];
    $('input[name="selectMenu"]:checked').each(function () {
        toAddArray.push($(this).val());
    });
    if(toAddArray.length<=0){
        alert('请至少勾选一项菜单');
        return;
    }
    avicAjax.ajax({
        url: "portal/saveMenu",
        type: 'post',
        data:{
            menuIds:toAddArray.join(";"),
            j: Math.random()
        },
        dataType: 'json',
        quiet:true,
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

function delPersonalMenu(menuId) {
    var title = $('#li-'+menuId).text();
    layer.confirm('确认删除['+title+']吗？', {
        btn: ['确认','取消'] //按钮
    }, function(){
        avicAjax.ajax({
            url: "portal/deleteByMenuId",
            data : {
                j: Math.random()
            },
            type: 'post',
            data:{
                menuIds:menuId
            },
            dataType: 'json',
            quiet:true,
            success: function (r) {
                if(r.flag=='success'){
                    $('#li-'+menuId).remove();//移除菜单
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
    });
   if(window.event){       //这是IE浏览器
    	event.cancelBubble=true;//阻止冒泡事件
    	event.returnValue=false;//阻止默认事件
    }else if(event && event.stopPropagation){     //这是其他浏览器
    	event.stopPropagation();//阻止冒泡事件
    	event.preventDefault();//阻止默认事件
    }
}



/**
 * 加载个人消息并更新dom
 */
function loadPersonalMessage() {
    avicAjax.ajax({
        url: "portal/getUnReadMessageList",
        type: 'get',
        data : {
            j: Math.random()
        },
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
    $(obj).detailMsg({
    	formid:id,
    	url:url,
    	area: ['80%', '80%'],
    	success: function(layero, index){
    		$.ajax({
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