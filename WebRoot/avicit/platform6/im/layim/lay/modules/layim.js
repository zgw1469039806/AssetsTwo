layui.define(['layer', 'tree', 'laytpl', 'upload'], function (exports) {

    var v = '3.6.0 Pro';
    var $ = layui.jquery;
    var layer = layui.layer;
    var laytpl = layui.laytpl;
    var device = layui.device();

    var SHOW = 'layui-show', THIS = 'layim-this', MAX_ITEM = 20;

    //回调
    var call = {};

    //对外API
    var LAYIM = function () {
        this.v = v;
        $('body').on('click', '*[layim-event]', function (e) {
            if(Chat.currentUser.status != 'online'){
                layer.msg(Chat.errMsg['602']);
            } else {
                var othis = $(this), methid = othis.attr('layim-event');
                events[methid] ? events[methid].call(this, othis, e) : '';
            }
        });
        $('body').on('blur', '*[layim-blur]', function (e) {
            if(Chat.currentUser.status != 'online'){
                layer.msg(Chat.errMsg['602']);
            } else {
                var othis = $(this), methid = othis.attr('layim-blur');
                events[methid] ? events[methid].call(this, othis, e) : '';
            }
        });
    };

    //基础配置
    LAYIM.prototype.config = function (options) {
        var skin = [];
        layui.each(Array(5), function (index) {
            skin.push(layui.cache.dir + 'css/modules/layim/skin/' + (index + 1) + '.jpg')
        });
        options = options || {};
        options.skin = options.skin || [];
        layui.each(options.skin, function (index, item) {
            skin.unshift(item);
        });
        options.skin = skin;
        options = $.extend({
            isfriend: !0
            , isgroup: !0
            , voice: 'default.mp3'
            , isAudio: false //开启聊天工具栏音频
            , isVideo: false //开启聊天工具栏视频
        }, options);
        if (!window.JSON || !window.JSON.parse) return;
        //console.log(options,'---------options-------');
        init(options);
        return this;
    };

    //监听事件
    LAYIM.prototype.on = function (events, callback) {
        if (typeof callback === 'function') {
            call[events] ? call[events].push(callback) : call[events] = [callback];
        }
        return this;
    };
    LAYIM.prototype.off = function (events) {
        delete call[events];
        return this;
    };

    //获取所有缓存数据
    LAYIM.prototype.cache = function () {
        return cache;
    };

    //打开一个自定义的会话界面
    LAYIM.prototype.chat = function (data) {
        if (!window.JSON || !window.JSON.parse) return;
        return popchat(data, true), this;
    };

    //设置聊天界面最小化
    LAYIM.prototype.setChatMin = function () {
        return setChatMin(), this;
    };

    //设置当前会话状态
    LAYIM.prototype.setChatStatus = function (str) {
        var thatChat = thisChat();
        if (!thatChat) return;
        var status = thatChat.elem.find('.layim-chat-status');
        return status.html(str), this;
    };

    //接受消息
    LAYIM.prototype.getMessage = function (data) {
        return getMessage(data), this;
    };

    //桌面消息通知
    LAYIM.prototype.notice = function (data) {
        return notice(data), this;
    };

    //打开添加好友/群组面板
    LAYIM.prototype.add = function (data) {
        return popAdd(data), this;
    };

    //好友分组面板
    LAYIM.prototype.setFriendGroup = function (data) {
        return popAdd(data, 'setGroup'), this;
    };

    //消息盒子的提醒
    LAYIM.prototype.msgbox = function (nums) {
        //return msgbox(nums), this;
        return appendOneMsg2Box(nums), this;
    };
    LAYIM.prototype.clearMsgBox = function () {
        return clearMsgBox(), this;
    };
    LAYIM.prototype.clearNewMsgFlag = function (id) {
        return clearNewMsgFlag(id), this;
    };
    //添加好友/群
    LAYIM.prototype.addList = function (data) {
        return addList(data), this;
    };

    //删除好友/群
    LAYIM.prototype.removeList = function (data) {
        return removeList(data), this;
    };

    //初始化聊天窗口
    LAYIM.prototype.initHistoryImRecord = function () {
        return initHistoryImRecord(), this;
    };

    //设置好友在线/离线状态
    LAYIM.prototype.setFriendStatus = function (id, type, peerUser) {
        if (peerUser && peerUser.status != type) {
            var title = (type === 'online' ? '在线':'离线');
            var elemI = $('i.layim-chat-status[data-id="'+id+'"]');
            elemI.removeClass('layim-chat-status-' + peerUser.status);
            elemI.addClass('layim-chat-status-' + type);
            elemI.attr('title',title);
            peerUser.status = type;
            resetFriendOrder(id, peerUser.status);
            var list = $('img.layim-friend' + id);
            list[type === 'online' ? 'removeClass' : 'addClass']('layim-list-gray');
            //懒加载头像图片
            $('img.lazy').lazyload({container: $("#layim_user_box")});
        }
    };

    //解析聊天内容
    LAYIM.prototype.content = function (content) {
        return layui.data.content(content);
    };
    //body形如system[xxx]时为系统消息，从消息盒子中打开查看
    LAYIM.prototype.isSystemMsg = function (content) {
        return layui.data.isSystemMsg(content);
    };

    //消息盒子数据 by onezeros
    LAYIM.prototype.msgboxData = function () {
        var msgdata = window.parent.Chat.getCookie("ozs_msgboxdata");
        if (msgdata) {
            var data = JSON.parse(msgdata);
            return data;
        }
        return new Array();
    };

    //发送消息(不影响发送框中的文本信息)
    LAYIM.prototype.sendMsg = function (content, systemMsg) {
        return sendMsg(content, systemMsg), this;
    };
    LAYIM.prototype.getRootPath = function () {
        return getRootPath();
    };
    LAYIM.prototype.refreshAllStatus = function () {
        return refreshAllStatus();
    };

    //显示好友详细信息
    LAYIM.prototype.showProfile = function (data) {
        return showProfile(data), this;
    };

    //发送消息失败
    LAYIM.prototype.sendMsgFail = function(peerId, msguniqueid, errorCode) {
        return sendMsgFail(peerId, msguniqueid, errorCode), this;
    };

    //主模板
    var listTpl = function (options) {

        var nodata = {
            friend: "该分组下暂无好友"
            , group: "暂无群组"
            , history: "暂无历史会话"
        };
        options = options || {};
        options.item = options.item || ('d.' + options.type);
        //console.log(options.item,'---------------主模板 options.item-----');
        x = ['{{# var length = 0; layui.each(' + options.item + ', function(i, data){ if(d.mine && data.belongTo != d.mine.id){  ' + (options.type === 'history' ? "return;" : "") + ' }length++; }}'
            , '{{# if(data.type==="group"){ }}'
            , '<li layim-event="chat" data-type="' + options.type + '" id="{{data.id}}" data-id="{{data.id}}" data-index="{{ ' + (options.index || 'i') + ' }}" class="layim-' + (options.type === 'history' ? '{{i}}' : options.type + '{{data.id}}') + ' ">'
            , '{{# }; }}'
            , '{{# if(data.type!="group"){ }}'
            , '<li layim-event="chat" data-type="' + options.type + '" id="{{data.id}}" data-id="{{data.id}}" data-index="{{ ' + (options.index || 'i') + ' }}" class="layim-' + (options.type === 'history' ? '{{i}}' : options.type + '{{data.id}}') + ' " title="{{ layui.data.joinDeptOrgs(data) }}" >'
            , '{{# }; }}'
            , '{{# if(data.type==="group"&&!data.temporary){ }}'
            , '<img  src="' + CONST_IMAGE_ICON_ROOT_URL + 'avatar_group.jpg\">'
            , '{{# }; }}'
            , '{{# if(data.type==="group"&&data.temporary){ }}'
            , '<img  src="' + CONST_IMAGE_ICON_ROOT_URL + 'tem.png\">'
            , '{{# }; }}'
            , '{{# if(data.type==="friend"){ }}'
            , '<img  src="{{ data.avatar }}"    class="layim-{{ data.type }}{{ data.id }} {{data.status === "offline" ? "layim-list-gray" : ""}}" >'
            , '{{# }; }}'
            , '<span>{{ data.chatname||data.username||data.groupname||data.name||"佚名" }} </span><p>{{ data.remark||data.sign||data.create_at||"" }}</p><span class="layim-msg-status">new</span></li>'
            , '{{# }); if(length === 0){ }}'
            , '<li class="layim-null">' + (nodata[options.type] || "暂无数据") + '</li>'
            , '{{# } }}'].join('');
        // console.info(x);
        return x;
    };

    //多级通讯录模板
//var listMultiLevelContactTpl = function(friends) {
//    var html = '';
//    for(var index =0 ; index < friends.length; index++) {
//        var item = friends[index];
//        var spread = d.local["spread"+item.id];
//
//    }
//    var html = ['{{# layui.each(' +friends+', function(index, item){ var spread = d.local["spread"+item.id]; }}'
//    ,'<li>'
//    ,'{{# if(item.isgroup === "true"){ }}'
//      ,'<h5 layim-event="spread" lay-type="{{ spread }}"><i class="layui-icon">{{# if(spread === "true"){ }}&#xe61a;{{# } else {  }}&#xe602;{{# } }}</i><span>{{ item.groupname||"未命名分组"+index }}</span><em>(<cite class="layim-count"> {{ (item.list||[]).length }}</cite>)</em></h5>'
//      ,'<ul class="layui-layim-list layim-list-friend {{# if(spread === "true"){ }}'
//      ,' layui-show'
//      ,'{{# } }}">'
//      ,listMultiLevelContactTpl("item.list")
//      ,'</ul>'
//    ,'{{# } else { }}'
////        ,'<li layim-event="chat" data-type="friend" data-index="{{ item.id }}" class="layim-friend' + '{{item.id}}') +' {{ item.status === "offline" ? "layim-list-gray" : "" }}><img src="{{ item.avatar }}"><span>{{ item.name }}</span><p>{{ data.remark||data.sign||"" }}</p><span class="layim-msg-status">new</span></li>'
//    ,'{{# } }}'
//    ,'</li>'
//    ,'{{# }); }}'].join('');
//    return html;
//};

    var elemTpl = ['<div class="layui-layim-main">'
        , '<div class="layui-layim-info">'
        , '<div class="layui-layim-user">{{ d.mine.username }}<i class="layui-icon layim-chat-status layim-chat-status-online" data-id="{{ d.mine.id }}" title="在线" style="margin-left: 6px;"></i></div>'
        /*,'<div class="layui-layim-status">'
        ,'{{# if(d.mine.status === "online"){ }}'
        ,'<span class="layui-icon layim-status-online" layim-event="status" lay-type="show">&#xe617;</span>'
        ,'{{# } else if(d.mine.status === "hide") { }}'
        ,'<span class="layui-icon layim-status-hide" layim-event="status" lay-type="show">&#xe60f;</span>'
        ,'{{# } }}'
        ,'<ul class="layui-anim layim-menu-box">'
          ,'<li {{d.mine.status === "online" ? "class=layim-this" : ""}} layim-event="status" lay-type="online"><i class="layui-icon">&#xe618;</i><cite class="layui-icon layim-status-online">&#xe617;</cite>在线</li>'
          ,'<li {{d.mine.status === "hide" ? "class=layim-this" : ""}} layim-event="status" lay-type="hide"><i class="layui-icon">&#xe618;</i><cite class="layui-icon layim-status-hide">&#xe60f;</cite>隐身</li>'
        ,'</ul>'
      ,'</div>'*/
        , '<input layim-blur="updateSign" class="layui-layim-remark" placeholder="编辑签名" value="{{ d.mine.remark||d.mine.sign||"" }}">'
        , '</div>'
        , '<ul class="layui-unselect layui-layim-tab{{# if(!d.base.isfriend || !d.base.isgroup){ }}'
        , ' layim-tab-two'
        , '{{# } }}">'
        , '<li class="layui-icon'
        , '{{# if(!d.base.isfriend){ }}'
        , ' layim-hide'
        , '{{# } else { }}'
        , ' layim-this'
        , '{{# } }}'
        , '" title="联系人" layim-event="tab" lay-type="friend">&#xe612;</li>'
        , '<li class="layui-icon'
        , '{{# if(!d.base.isgroup){ }}'
        , ' layim-hide'
        , '{{# } else if(!d.base.isfriend) { }}'
        , ' layim-this'
        , '{{# } }}'
        , '" title="群组" layim-event="tab" lay-type="group">&#xe613;</li>'
        , '<li class="layui-icon" title="历史会话" layim-event="tab" lay-type="history">&#xe611;</li>'
        , '</ul>'
        , '<ul id="layim_user_box" class="layui-unselect layim-tab-content {{# if(d.base.isfriend){ }}layui-show{{# } }} layim-list-friend">'

        , '{{# layui.each(d.friend, function(index, item){ var spread = d.local["spread"+index]; }}'
        , '<li>'
        , '<h5 layim-event="spread" lay-type="{{ spread }}"><i class="layui-icon">{{# if(spread === "true"){ }}&#xe61a;{{# } else {  }}&#xe602;{{# } }}</i><span>{{ item.groupname||"未命名分组"+index }}</span><em>(<cite class="layim-count"> {{ (item.list||[]).length }}</cite>)</em></h5>'
        , '<ul class="layui-layim-list layim-list-friend {{# if(spread === "true"){ }}'
        , ' layui-show'
        , '{{# } }}">'
        , listTpl({
            type: "friend"
            , item: "item.list"
            , index: "index"
        })
        , '</ul>'
        , '</li>'
        , '{{# }); }}'
//      ,listMultiLevelContactTpl( "d.friend"  )
        , '{{# if(d.friend.length === 0){ }}'
        , '<li><ul class="layui-layim-list layui-show"><li class="layim-null">暂无联系人</li></ul>'
        , '{{# } }}'
        , '</ul>'
        , '<ul class="layui-unselect layim-tab-content {{# if(!d.base.isfriend && d.base.isgroup){ }}layui-show{{# } }}">'
        , '<li>'
        //群组标签页自定义
        , '<ul class="layui-layim-list layui-show layim-list-group">'
        , listTpl({
            type: 'group'
        })
        , '</ul>'
        , '</li>'
        , '</ul>'
        , '<ul class="layui-unselect layim-tab-content  {{# if(!d.base.isfriend && !d.base.isgroup){ }}layui-show{{# } }}">'
        , '<li>'
        , '<ul class="layui-layim-list layui-show layim-list-history">'
        , listTpl({
            type: 'history'
        })
        , '</ul>'
        , '</li>'
        , '</ul>'
        , '<ul class="layui-unselect layim-tab-content">'
        , '<li>'
        , '<ul class="layui-layim-list layui-show" id="layui-layim-search"></ul>'
        , '</li>'
        , '</ul>'
        , '<ul class="layui-unselect layui-layim-tool">'
        , '<li class="layui-icon layim-tool-search" layim-event="search" title="搜索">&#xe615;</li>'
        , '{{# if(d.base.msgbox){ }}'
        , '<li class="layui-icon layim-tool-msgbox" layim-event="msgbox" title="消息盒子">&#xe645;<span class="layui-anim"></span></li>'
        , '{{# } }}'
        , '{{# if(d.base.find){ }}'
        , '<li class="layui-icon layim-tool-find" layim-event="find" title="添加好友">&#xe608;</li>'
        , '{{# } }}'
        , '{{# if(d.base.findgroup){ }}'
        , '<li class="layui-icon layim-tool-findgroup" layim-event="findgroup" title="添加群组">&#xe613;</li>'
        , '{{# } }}'
        , '{{# if(d.base.refresh){ }}'
        , '<li class="layui-icon layim-tool-refresh" layim-event="refresh" title="刷新">&#xe669;</li>'
        , '{{# } }}'
        , '{{# if(Chat.currentUser.imAdmin){ }}'
        , '<li class="layui-icon layim-tool-setting" layim-event="setting" title="设置">&#xe620;</li>'
        , '{{# } }}'
        /*,'<li class="layui-icon layim-tool-skin" layim-event="skin" title="更换背景">&#xe61b;</li>'*/
        , '{{# if(!d.base.copyright){ }}'
        /*,'<li class="layui-icon layim-tool-about" layim-event="about" title="关于">&#xe60b;</li>'*/
        /* ,'<li class="layui-icon layim-tool-setting" layim-event="setting" title="设置">&#xe620;</li>'*/
        , '{{# } }}'
        , '</ul>'
        , '<div class="layui-layim-search"><input placeholder="输入名称后按回车键显示检索结果"><label class="layui-icon" layim-event="closeSearch">&#x1007;</label></div>'
        , '</div>'].join('');

    //换肤模版
    var elemSkinTpl = ['<ul class="layui-layim-skin">'
        , '{{# layui.each(d.skin, function(index, item){ }}'
        , '<li><img layim-event="setSkin" src="{{ item }}"></li>'
        , '{{# }); }}'
        , '<li layim-event="setSkin"><cite>简约</cite></li>'
        , '</ul>'].join('');

    //聊天主模板
    var elemChatTpl = [

        '<div class="layim-chat layim-chat-{{d.data.type}}{{d.first ? " layui-show" : ""}}"  >'
        , '{{# if(d.data.type == \"friend\"){ }}'
        , '<span style="position: absolute;right: 14px;top: -40px;" id="addGroupChat_{{d.data.id}}" ><img style="height: 25px;width: 25px;" src="' + CONST_IMAGE_ICON_ROOT_URL + 'add_user.png" /> </span>'
        , '{{# }; }}'
        , '{{# if(d.data.type == \"group\"){ }}'
        , '<span style="position: absolute;right: 14px;top: -40px;"> </span>'
        , '{{# }; }}'
        , '{{# if(d.data.temporary){ }}'
        , '<span style="position: absolute;right: 14px;top: -40px;" > </span>'
        , '{{# }; }}'
        , '{{# if(d.data.type===\"friend\"){ }}'
        , '<div class="layui-unselect layim-chat-title" title="{{ layui.data.joinDeptOrgs(d.data) }}" >'
        , '{{# }; }}'
        , '{{# if(d.data.type!=\"friend\"){ }}'
        , '<div class="layui-unselect layim-chat-title">'
        , '{{# }; }}'
        , '<div class="layim-chat-other">'
        , '{{# if(d.data.type==="group"&&!d.data.temporary){ }}'
        , '<img class="layim-{{ d.data.type }}{{ d.data.id }}"  src="' + CONST_IMAGE_ICON_ROOT_URL + 'avatar_group.jpg\">'
        , '{{# }; }}'
        , '{{# if(d.data.type==="group"&&d.data.temporary){ }}'
        , '<img class="layim-{{ d.data.type }}{{ d.data.id }}"  src="' + CONST_IMAGE_ICON_ROOT_URL + 'tem.png\">'
        , '{{# }; }}'
        , '{{# if(d.data.type==="friend"){ }}'
        , '<img  class="layim-{{ d.data.type }}{{ d.data.id }}  {{d.data.status === "offline" ? "layim-list-gray" : " "}}"  layim-event="menu_profile" data-id="{{d.data.id}}" style="cursor:pointer;" title="点击查看详细信息"  src="{{d.data.avatar}}"  class="">'
        , '{{# }; }}'
        , '<span class="layim-chat-username" data-type="{{ d.data.type }}" data-id="{{ d.data.id }}" layim-event="{{ d.data.type==="group" ? \"groupMembers\" : \"\" }}"><span>{{ d.data.chatname||"佚名" }} </span>{{d.data.temporary ? "<cite>临时会话</cite>" : ""}} {{# if(d.data.type==="group"){ }} <em class="layim-chat-members" id="groupUserCount" ></em><i class="layui-icon">&#xe61a;</i> {{# } }}</span>'
        , '<p class="layim-chat-tip-info">'
        , '{{# if(d.data.type==="friend" && d.data.status==="online"){ }}'
        , '<i class="layui-icon layim-chat-status layim-chat-status-online" data-id="{{ d.data.id }}" title="在线"></i>{{ d.data.id||"" }}'
        , '{{# }; }}'
        , '{{# if(d.data.type==="friend" && d.data.status==="offline"){ }}'
        , '<i class="layui-icon layim-chat-status layim-chat-status-offline" data-id="{{ d.data.id }}"  title="离线"></i>{{ d.data.id||"" }}'
        , '{{# }; }}'
        , '{{# if(d.data.type==="group"){ }}'
        , '{{ d.data.remark||d.data.sign||d.data.create_at||"" }}'
        , '{{# }; }}'
        , '</p>'
        , '</div>'
        , '</div>'
        , '<div class="layim-chat-main">'
        , '<ul></ul>'
        , '</div>'
        , '<div class="layim-chat-footer">'
        , '<div class="layui-unselect layim-chat-tool" data-json="{{encodeURIComponent(JSON.stringify(d.data))}}" data-json2="{{JSON.stringify(d.data)}}" >'
        , '<span class="layui-icon layim-tool-face" title="选择表情" layim-event="face">&#xe60c;</span>'
        , '{{# if(d.base && d.base.uploadImage){ }}'
        , '<span class="layui-icon layim-tool-image" title="发送图片" layim-event="image">&#xe60d;</span>'
        , '{{# }; }}'
        , '{{# if(d.base && d.base.uploadFile){ }}'
        , '<span class="layui-icon layim-tool-image" title="发送文件" layim-event="image" data-type="file">&#xe61d;</span>'
        , '{{# }; }}'
        , '{{# if(d.base && d.base.isAudio){ }}'
        , '<span class="layui-icon layim-tool-audio" title="发送网络音频" layim-event="media" data-type="audio">&#xe6fc;</span>'
        , '{{# }; }}'
        , '{{# if(d.base && d.base.isVideo){ }}'
        , '<span class="layui-icon layim-tool-video" title="发送网络视频" layim-event="media" data-type="video">&#xe6ed;</span>'
        , '{{# }; }}'
        , '{{# layui.each(d.base.tool, function(index, item){ }}'
        , '<span class="layui-icon layim-tool-{{item.alias}}" title="{{item.title}}" layim-event="extend" lay-filter="{{ item.alias }}">{{item.icon}}</span>'
        , '{{# }); }}'
        , '{{# if(d.base && d.base.chatLog){ }}'
        , '<span class="layim-tool-log" layim-event="chatLog"><i class="layui-icon">&#xe60e;</i>聊天记录</span>'
        , '{{# }; }}'
        , '</div>'
        , '<div class="layim-chat-textarea"><textarea></textarea></div>'
        , '<div class="layim-chat-bottom">'
        , '<div class="layim-chat-send">'
        , '{{# if(!d.base.brief){ }}'
        , '<span class="layim-send-close" layim-event="closeThisChat">关闭</span>'
        , '{{# } }}'
        , '<span class="layim-send-btn" layim-event="send">发送</span>'
        , '<span class="layim-send-set" layim-event="setSend" lay-type="show"><em class="layui-edge"></em></span>'
        , '<ul class="layui-anim layim-menu-box">'
        , '<li {{d.local.sendHotKey !== "Ctrl+Enter" ? "class=layim-this" : ""}} layim-event="setSend" lay-type="Enter"><i class="layui-icon">&#xe67a;</i>按Enter键发送消息</li>'
        , '<li {{d.local.sendHotKey === "Ctrl+Enter" ? "class=layim-this" : ""}} layim-event="setSend"  lay-type="Ctrl+Enter"><i class="layui-icon">&#xe67a;</i>按Ctrl+Enter键发送消息</li>'
        , '</ul>'
        , '</div>'
        , '</div>'
        , '</div>'
        , '</div>'].join('');

    //添加好友群组模版
    var elemAddTpl = ['<div class="layim-add-box">'
        , '<div class="layim-add-img"><img class="layui-circle" src="{{ d.data.avatar }}"><p>{{ d.data.name||"" }}</p></div>'
        , '<div class="layim-add-remark">'
        , '{{# if(d.data.type === "friend" && d.type === "setGroup"){ }}'
        , '<p>选择分组</p>'
        , '{{# } if(d.data.type === "friend"){ }}'
        , '<select class="layui-select" id="LAY_layimGroup">'
        , '{{# layui.each(d.data.group, function(index, item){ }}'
        , '<option value="{{ item.id }}">{{ item.groupname }}</option>'
        , '{{# }); }}'
        , '</select>'
        , '{{# } }}'
        , '{{# if(d.data.type === "group"){ }}'
        , '<p>请输入验证信息</p>'
        , '{{# } if(d.type !== "setGroup"){ }}'
        , '<textarea id="LAY_layimRemark" placeholder="验证信息" class="layui-textarea"></textarea>'
        , '{{# } }}'
        , '</div>'
        , '</div>'].join('');

    //聊天内容列表模版
    var elemChatMain = [
        '{{# if(layui.data.isSystemMsg(d.content)){ }}'
        , '<div class="layim-chat-system">'
        , '<i class="layui-icon">&#xe645;</i><span><i>{{ layui.data.date(d.timestamp) }}</i>{{ layui.data.content(d.content||"&nbsp") }}'
        , '</span></div>'
        , '{{# } else { }}'
        , '  {{# if(d.mine){ }}'
        , '  <li class="layim-chat-mine" {{# if(d.cid){ }}data-cid="{{d.cid}}"{{# } }} data-msguniqueid="{{d.msguniqueid}}">'
        , '  <div class="layim-chat-user"><img class="layim-mine layim-friend{{Chat.currentUser.id }}  {{Chat.currentUser.status === "offline" ? "layim-list-gray" : ""}}" src="{{ d.avatar }}"><cite>'
        , '  <i>{{ layui.data.date(d.timestamp) }}</i>{{ d.username||"佚名" }}'
        , '  {{# } else { }}'
        , '  <li {{# if(d.cid){ }}data-cid="{{d.cid}}"{{# } }} data-msguniqueid="{{d.msguniqueid}}">'
        , '  <div class="layim-chat-user"><img class="layim-friend{{d.fromid ? d.fromid : d.id}} {{d.status === "offline" ? "layim-list-gray" : ""}}" src="{{ d.avatar }}"  layim-event="menu_profile" data-id="{{d.fromid ? d.fromid : d.id}}" style="cursor:pointer;" title="点击查看详细信息"><cite>'
        , '  {{ d.username||"佚名" }}<i>{{ layui.data.date(d.timestamp) }}</i>'
        , '  {{# } }}'
        , '</cite></div>'
        , '<div class="layim-chat-text">'
        , '{{ layui.data.content(d.content||"&nbsp") }}'
        , '</div>'
        , '</li>'
        , '{{# } }}'
        ].join('');


    var elemChatList = '{{# if(d.data.type!="friend"){ }}'
        + '<li data-type="{{ d.data.type }}" data-id="{{ d.data.id }}" class="layim-{{ d.data.type }}{{ d.data.id }}  layim-chatlist-{{ d.data.type }}{{ d.data.id }} layim-this" title="{{ d.data.chatname }}"  layim-event="tabChat">'
        + '{{# }; }}'
        + '{{# if(d.data.type==="friend"){ }}'
        + '<li data-type="{{ d.data.type }}" data-id="{{ d.data.id }}" class="layim-{{ d.data.type }}{{ d.data.id }}  layim-chatlist-{{ d.data.type }}{{ d.data.id }} layim-this" layim-event="tabChat" title="{{ layui.data.joinDeptOrgs(d.data) }}">'
        + '{{# }; }}'
        + '{{# if(d.data.type==="group"&&!d.data.temporary){ }}'
        + '<img class="layim-{{ d.data.type }}{{ d.data.id }}"  src="' + CONST_IMAGE_ICON_ROOT_URL + 'avatar_group.jpg\">'
        + '{{# }; }}'
        + '{{# if(d.data.type==="group"&&d.data.temporary){ }}'
        + '<img class="layim-{{ d.data.type }}{{ d.data.id }}"  src="' + CONST_IMAGE_ICON_ROOT_URL + 'tem.png\">'
        + '{{# }; }}'
        + '{{# if(d.data.type==="friend"){ }}'
        + '<img class="layim-{{ d.data.type }}{{ d.data.id }} {{d.data.status === "offline" ? "layim-list-gray" : ""}}"  src="{{d.data.avatar}}" >'
        + '{{# }; }}'
        + '<span>{{ d.data.chatname||"佚名" }}</span>{{# if(!d.base.brief){ }}<i class="layui-icon" layim-event="closeChat">&#x1007;</i>{{# } }}</li>';

    //补齐数位
    var digit = function (num) {
        return num < 10 ? '0' + (num | 0) : num;
    };

    //转换时间
    layui.data.date = function (timestamp) {
        var d = new Date(timestamp || new Date());
        return d.getFullYear() + '-' + digit(d.getMonth() + 1) + '-' + digit(d.getDate())
            + ' ' + digit(d.getHours()) + ':' + digit(d.getMinutes()) + ':' + digit(d.getSeconds());
    };

    layui.data.isSystemMsg = function (content) {
        var mText = content || '';
        var reg = /system\[([\s\S]+?)\]/;
        return !!mText.match(reg) && mText.replace(reg, "") === "";
    };

    //连接部门数组
    layui.data.joinDeptOrgs = function (userItem) {
        var deptStr = '';
        if (userItem && userItem.deptOrgs && userItem.deptOrgs.length) {
            layui.each(userItem.deptOrgs, function (index, item) {
                if(index === 0 ){
                    //不显示第一级组织
                } else {
                    deptStr = (deptStr ? deptStr + ' &gt;&gt; ' + item :  item);
                }
            });
        }
        if (userItem && userItem.positionName) {
            deptStr = deptStr + ' &gt;&gt; ' + userItem.positionName;
        }
        if (userItem && userItem.id && userItem.type != "group") {
            deptStr = deptStr + ' &gt;&gt; ' + userItem.id;
        }
        return deptStr;
    };
    //转换内容
    layui.data.content = function (content) {
        //支持的html标签
        var html = function (end) {
            return new RegExp('\\n*\\[' + (end || '') + '(pre|div|span|p|table|thead|th|tbody|tr|td|ul|li|ol|li|dl|dt|dd|h2|h3|h4|h5)([\\s\\S]*?)\\]\\n*', 'g');
        };
        if(layui.data.isSystemMsg(content)){
            content = content.replace(/system\[([\s\S]+?)\]/g, function (msg) {  //转义系统消息
                var alt = msg.replace(/(^system\[)|(\]$)/g, '');
                return '系统消息：' + alt + "";
            });
            return content;
        }
        content = (content || '').replace(/&(?!#?[a-zA-Z0-9]+;)/g, '&amp;')
            .replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/'/g, '&#39;').replace(/"/g, '&quot;') //XSS
            //.replace(/@(\S+)(\s+?|$)/g, '@<a href="javascript:;">$1</a>$2') //转义@

            .replace(/face\[([^\s\[\]]+?)\]/g, function (face) {  //转义表情
                var alt = face.replace(/^face/g, '');
                return '<img alt="' + alt + '" title="' + alt + '" src="' + faces[alt] + '">';
            })
            .replace(/img\[([^\s]+?)\]/g, function (img) {  //转义图片
                var url = addHostToUrl(img.replace(/(^img\[)|(\]$)/g, ''));
                return '<img class="layui-layim-photos" src="' + url + '">';
            })
            .replace(/file\([\s\S]+?\)\[[\s\S]*?\]/g, function (str) { //转义文件
                var href = (str.match(/file\(([\s\S]+?)\)\[/) || [])[1];
                var text = (str.match(/\)\[([\s\S]*?)\]/) || [])[1];
                if (!href) return str;
                href = addHostToUrl(href);
                var secret = href.split(";")[href.split(";").length - 1].split("=");
                var secretValue = secret[secret.length - 1];
                var currentUsersecretlevel = window.parent.Chat.currentUser.secretLevel;
                if (secretValue <= currentUsersecretlevel) {
                    if (secretValue == "1") {
                        secretValue = "非涉密文件";
                    } else if (secretValue == "2") {
                        secretValue = "一般涉密文件";
                    } else if (secretValue == "3") {
                        secretValue = "重点涉密文件";
                    } else if (secretValue == "4") {
                        secretValue = "核心涉密文件";
                    }

                    return '<a class="layui-layim-file" href="' + href + '" download target="_blank"><i class="layui-icon" title="'+(text)+'">&#xe61e;</i><cite><span title="' + (text || href) + '">' + (text || href) + '</span><span>' + secretValue + '</span></cite></a>';
                } else {
                    return '<span>文件密级较高，您无法查看此消息</span>';
                }
            })
            .replace(/audio\[([^\s]+?)\]/g, function (audio) {  //转义音频
                return '<div class="layui-unselect layui-layim-audio" layim-event="playAudio" data-src="' + audio.replace(/(^audio\[)|(\]$)/g, '') + '"><i class="layui-icon">&#xe652;</i><p>音频消息</p></div>';
            })
            .replace(/video\[([^\s]+?)\]/g, function (video) {  //转义音频
                return '<div class="layui-unselect layui-layim-video" layim-event="playVideo" data-src="' + video.replace(/(^video\[)|(\]$)/g, '') + '"><i class="layui-icon">&#xe652;</i></div>';
            })

            .replace(/a\([\s\S]+?\)\[[\s\S]*?\]/g, function (str) { //转义链接
                var href = (str.match(/a\(([\s\S]+?)\)\[/) || [])[1];
                var text = (str.match(/\)\[([\s\S]*?)\]/) || [])[1];
                if (!href) return str;
                return '<a href="' + href + '" target="_blank">' + (text || href) + '</a>';
            }).replace(html(), '\<$1 $2\>').replace(html('/'), '\</$1\>') //转移HTML代码
            .replace(/\n/g, '<br>') //转义换行
        return content;
    };

    //Ajax
    var post = function (options, callback, tips) {
        options = options || {};
        return $.ajax({
            url: options.url
            , type: options.type || 'get'
            , data: options.data
            , dataType: options.dataType || 'json'
            , cache: false
            , success: function (res) {
                res.code == 0
                    ? callback && callback(res.data || {})
                    : layer.msg(res.msg || ((tips || 'Error') + ': LAYIM_NOT_GET_DATA'), {
                        time: 5000
                    });
            }, error: function (err, msg) {
                window.console && console.log && console.error('LAYIM_DATE_ERROR：' + msg);
            }
        });
    };
    var refreshHistoryStatus = function (history) {
        if(history){
            $.each(history,function(index,item){
                if('friend' === item.type){
                    var user = Chat.getUserInfoById(item.id);
                    if(user){
                        item.status = user.status;
                    }
                }
            });
        }
    };

    //刷新好友在线状态 + 群组名称
    var refreshAllStatus = function (success_b) {
        $('.layim-tool-refresh').hide();
        var onlineUsers = Chat.getConnectedUsers();
        $.each(Chat.Roster, function (index) {
            var item = Chat.Roster[index];
            var statusNow = $.inArray(item.id, onlineUsers);
            var toStatus = statusNow === -1 ? 'offline' : 'online';
            if(toStatus != item.status ){
                //在线变为离线 or 离线变为在线
                layui.layim.setFriendStatus(item.id, toStatus, item);
                if(item.id == Chat.currentUser.id){
                    Chat.currentUser.status = toStatus;
                }
            }

            //刷新组织部门的在线人数
            if(index == Chat.Roster.length - 1){
                Chat.computeOnlineCount(Chat.rootOrgDept);
            }
        });

        // 刷新群组名称
        var groupIds = [];
        $.each(cache.group, function (i, e) {
            groupIds.push(e.id);
        });
        if (groupIds && groupIds.length) {
            $.post("./im/ImRoomController/getImRoomByIds", {"ids": groupIds}, function (data) {
                $.each(data, function (i, e) {
                    updateGroupName(e.id, e.roomName);
                });
            });
        }
        success_b && success_b();
        
    };

    //显示好友详细信息
    var showProfile = function (id) {
        var user = Chat.getUserInfoById(id);
        if(user == null && !$(this).data("sys-user-id")){
            return;
        }
        var uname = (user && user.username) || id;
        var userId = user.sysUserId || $(this).data("sys-user-id");
        $.ajax({
            type: "Post", //Post传参
            url: "./im/ImUserController/getUser/" + userId,//服务地址
            data: {loginName: id},//参数
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            success: function (result) {
                // 调用成功后，将获取的名字填入name文本框中。
                //  $("#name").val(result.d);
                //  console.info(result);
                if (result.sign === null) {
                    result.sign = "";
                }
                if (result.secretLevel == "1") {
                    result.secretLevel = "非涉密人员";
                } else if (result.secretLevel == "2") {
                    result.secretLevel = "一般涉密人员";
                } else if (result.secretLevel == "3") {
                    result.secretLevel = "重点涉密人员";
                } else if (result.secretLevel == "4") {
                    result.secretLevel = "核心涉密人员";
                } else {
                    result.secretLevel = "";
                }
                var str = [];
                str.push('<form class="layui-form" action="" style="width: 636px;margin: 0 auto;margin-top:30px">');

                str.push('<div class="layui-form-item">');
                str.push('     <div class="layui-inline" style="float:left">');
                str.push('          <label class="layui-form-label" style="width: 100px;">头像：</label>');
                str.push('          <div class="layui-input-inline" >');
                str.push('                 <img style="height: 120px;width:110px;" src="platform/sysuser/photo/upload/headerphoto?sysUserId=' + result.id + '" class="userAvatar">');
                str.push('          </div>');
                str.push('     </div>');
                str.push('     <div class="layui-inline" style="float:left;margin-left:4px;margin-top:27px">');
                str.push('          <label class="layui-form-label" style="width: 100px;">签名：</label>');
                str.push('          <div class="layui-input-inline" style="padding-top: 9px;">');
                str.push('               ' + (result.sign ? result.sign : '') + '');
                str.push('          </div>');
                str.push('      </div>');
                str.push('     <div class="layui-inline" style="float:left;margin-left:4px;margin-top:0px">');
                str.push('          <label class="layui-form-label" style="width: 100px;">密级：</label>');
                str.push('          <div class="layui-input-inline" style="padding-top: 9px;">');
                str.push('               ' + (result.secretLevel ? result.secretLevel : '') + '');
                str.push('          </div>');
                str.push('      </div>');
                str.push('</div>');

                str.push('<div class="layui-form-item">');
                str.push('     <div class="layui-inline">');
                str.push('          <label class="layui-form-label" style="width: 100px;">用户姓名：</label>');
                str.push('          <div class="layui-input-inline" style="padding-top: 9px;">');
                str.push('                ' + (result.name ? result.name : '') + '');
                str.push('          </div>');
                str.push('     </div>');
                str.push('     <div class="layui-inline">');
                str.push('          <label class="layui-form-label" style="width: 100px;">登录名：</label>');
                str.push('          <div class="layui-input-inline" style="padding-top: 9px;">');
                str.push('               ' + (result.loginName ? result.loginName : '') + '');
                str.push('          </div>');
                str.push('      </div>');
                str.push('</div>');

                str.push('<div class="layui-form-item">');
                str.push('     <div class="layui-inline">');
                str.push('          <label class="layui-form-label" style="width: 100px;">部门：</label>');
                str.push('          <div class="layui-input-inline" style="padding-top: 9px;">');
                str.push('               ' + (user.deptOrgs[user.deptOrgs.length - 1]) + '');
                str.push('          </div>');
                str.push('     </div>');
                str.push('     <div class="layui-inline">');
                str.push('          <label class="layui-form-label" style="width: 100px;">岗位：</label>');
                str.push('          <div class="layui-input-inline" style="padding-top: 9px;">');
                str.push('               ' + (user.positionName ? user.positionName : '') + '');
                str.push('          </div>');
                str.push('      </div>');
                str.push('</div>');

                str.push('<div class="layui-form-item">');
                str.push('     <div class="layui-inline">');
                str.push('          <label class="layui-form-label" style="width: 100px;">人员路径：</label>');
                str.push('          <div class="layui-input-block" style="padding-top: 9px;">');
                str.push('               ' + layui.data.joinDeptOrgs(user));
                str.push('          </div>');
                str.push('     </div>');
                str.push('</div>');

                str.push('<div class="layui-form-item">');
                str.push('     <div class="layui-inline">');
                str.push('          <label class="layui-form-label" style="width: 100px;">性别：</label>');
                str.push('          <div class="layui-input-inline" style="padding-top: 9px;">');
                str.push('               ' + (result.sex ? (result.sex == '1' ? '男' : '女') : '') + '');
                str.push('          </div>');
                str.push('     </div>');
                str.push('     <div class="layui-inline">');
                str.push('          <label class="layui-form-label" style="width: 100px;">办公电话：</label>');
                str.push('          <div class="layui-input-inline" style="padding-top: 9px;">');
                str.push('               ' + (result.officeTel ? result.officeTel : '') + '');
                str.push('          </div>');
                str.push('     </div>');
                str.push('</div>');

                str.push('<div class="layui-form-item">');
                str.push('     <div class="layui-inline">');
                str.push('          <label class="layui-form-label" style="width: 100px;">手机：</label>');
                str.push('          <div class="layui-input-inline" style="padding-top: 9px;">');
                str.push('               ' + (result.mobile ? result.mobile : '') + '');
                str.push('          </div>');
                str.push('     </div>');
                str.push('     <div class="layui-inline">');
                str.push('          <label class="layui-form-label" style="width: 100px;">邮箱地址：</label>');
                str.push('          <div class="layui-input-inline" style="padding-top: 9px;">');
                str.push('              ' + (result.email ? result.email : '') + '');
                str.push('          </div>');
                str.push('      </div>');
                str.push('</div>');

                str.push('<div class="layui-form-item">');
                str.push('     <div class="layui-inline">');
                str.push('         <label class="layui-form-label" style="width: 100px;">备注：</label>');
                str.push('         <div class="layui-input-block" style="width: 556px;padding-top: 3px;">');
                str.push('              <textarea rows="3" readonly=readonly style="width:96%;height: 60px;border: 0;">' + (result.remark ? result.remark : '') + '');
                str.push('              </textarea>');
                str.push('         </div>');
                str.push('     </div>');
                str.push('</div>');
                str.push('</form>');
                layer.open({
                    type: 1,
                    moveType: 1,
                    title: uname,
                    area: ['800px', '520px'],
                    fixed: true,
                    maxmin: false,
                    content: str.join(''),
                    //关闭事件
                    end: function () {
                        layer.closeAll('tips');
                    }
                    , success: function (layero) {
                        layero.on('contextmenu', function (event) {
                            event.cancelBubble = true;
                            event.returnValue = false;
                            return false;
                        });
                    }
                });
            },
            error: function (e) {
                layer.msg("加载失败");
            }
        });
    };

    //处理初始化信息
    var cache = {message: {}, chat: []}, init = function (options) {

        var init = options.init || {};
        var mine = init.mine || {};
        var local = layui.data('layim')[mine.id] || {};
        refreshHistoryStatus(local.history);
        var obj = {
            base: options
            , local: local
            , mine: mine
            , history: local.history || {}
        };
        var create = function (data) {
            var mine = data.mine || {};
            var local = layui.data('layim')[mine.id] || {};
            refreshHistoryStatus(local.history);
            var obj = {
                base: options //基础配置信息
                , local: local //本地数据
                , mine: mine //我的用户信息
                , friend: data.friend || [] //联系人信息
                , group: data.group || [] //群组信息
                , history: local.history || {} //历史会话信息
            };
            cache = $.extend(cache, obj);
            var x = laytpl(elemTpl).render(obj);

            popim(x);

            /**初始化面板是否最小化*/
            if (local.close || options.min || Chat.chatInitMin) {
                popmin();
            }

            layui.each(call.ready, function (index, item) {
                item && item(obj);
            });
        };
        cache = $.extend(cache, obj);
        if (options.brief) {
            return layui.each(call.ready, function (index, item) {
                item && item(obj);
            });
        }
        init.url ? post(init, create, 'INIT') : create(init);

    };

    //显示主面板
    var layimMain, popim = function (content) {
        return layer.open({
            type: 1
            , area: ['280px', '520px']
            , skin: 'layui-box layui-layim'
            , title: '&#8203;'
            , offset: 'rb'
            , id: 'layui-layim'
            , shade: false
            , anim: 2
            , resize: false
            , content: content
            , success: function (layero) {
                layimMain = layero;

                setSkin(layero);

                if (cache.base.right) {
                    layero.css('margin-left', '-' + cache.base.right);
                }
                if (layimClose) {
                    layer.close(layimClose.attr('times'));
                }

                //按最新会话重新排列
                var arr = [], historyElem = layero.find('.layim-list-history');
                historyElem.find('li').each(function () {
                    arr.push($(this).prop('outerHTML'))
                });
                if (arr.length > 0) {
                    arr.reverse();
                    historyElem.html(arr.join(''));
                }

                banRightMenu();
                events.sign();
            }
            , cancel: function (index) {
                popmin();
                var local = layui.data('layim')[cache.mine.id] || {};
                local.close = true;
                layui.data('layim', {
                    key: cache.mine.id
                    , value: local
                });
                return false;
            }
            , end:function () {
                Chat.renderLayimMain();
                setTimeout(function () {
                    popmin();
                }, 5000);
            }
        });
    };
    var othis;
    //屏蔽主面板右键菜单
    var banRightMenu = function () {
        layimMain.on('contextmenu', function (event) {
            event.cancelBubble = true;
            event.returnValue = false;
            return false;
        });

        var hide = function () {
            layer.closeAll('tips');
        };

        //自定义历史会话右键菜单
        layimMain.find('.layim-list-history').on('contextmenu', 'li', function (e) {
            othis = $(this);
            var cl = $(this).attr("class");
            var id = othis[0].id;
            var html = '<ul data-id="' + othis[0].id + '" data-index="' + othis.data('index') + '">';
            html += '<li layim-event="menuHistory" data-type="one">移除会话</li>';
            html += '<li layim-event="menuHistory" data-type="all">清空全部会话列表</li>';
            if (cl.indexOf("layim-friend") > -1) {
                html += '<li layim-event="menu_profile" data-type="all">查看资料</li></ul>';
            }
            if (othis.hasClass('layim-null')) return;

            layer.tips(html, this, {
                tips: 1
                , time: 0
                , anim: 5
                , fixed: true
                , skin: 'layui-box layui-layim-contextmenu'
                , success: function (layero) {
                    var stopmp = function (e) {
                        stope(e);
                    };
                    layero.off('mousedown', stopmp).on('mousedown', stopmp);
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                    var layerobj = $("#contextmenu_" + id).parent(".layui-layim-contextmenu");
//          resetposition(layerobj,t,l);
                    resetposition(layerobj);
                }
            });
            $(document).off('mousedown', hide).on('mousedown', hide);
            $(window).off('resize', hide).on('resize', hide);

        });

        //自定义联系人右键菜单layim-list-friend
        layimMain.find('.layim-list-friend').on('contextmenu', '.layui-layim-list li', function (e) {
            othis = $(this);
            var id = othis[0].id || othis.data('id') || '';
            var uname = othis[0].uname || othis.data('uname') || '';
            var html = '<ul id="contextmenu_' + othis[0].id + '" data-id="' + othis[0].id + '" data-index="' + othis.data('index') + '">';
//          html += '<li layim-event="menu_chat"><i class="layui-icon" >&#xe611;</i>发送即时消息</li>';
            //var isFavorite = Chat.isInFavorite(id);
            html += '<li layim-event="menu_profile">&nbsp;&nbsp;查看资料&nbsp;' + uname + '</li>';
            if ($(othis).parent().prev().data('nodetype') == 'favoriteGroup') {
                var favoriteGroupDefId = $(othis).parent().prev().data('id') || '';
                var groupDesc = $(othis).parent().prev().data('name') || '';
                var contactName = uname || '';
                html += '<li layim-event="remove_favorite" title="移出分组' + groupDesc + '" data-contact-name="' + contactName + '" data-favorite-group-def-id="' + favoriteGroupDefId + '" data-favorite-group-desc="' + groupDesc + '">&nbsp;&nbsp;移出分组&nbsp;' + groupDesc + '</li>';
            } else {
                var favoriteGroupDefs = Chat.getAvailableFavoriteGroupDefs(id);
                if (!favoriteGroupDefs || !favoriteGroupDefs.length) {
                    //没有可用分组
                } else if (favoriteGroupDefs.length == 1) {
                    html += '<li layim-event="add_favorite" data-favorite-group-def-id="' + favoriteGroupDefs[0].id + '" data-favorite-group-desc="' + favoriteGroupDefs[0].groupDesc + '">&nbsp;&nbsp;添加到&nbsp;' + (favoriteGroupDefs[0].groupDesc) + '</li>';
                } else {
                    html += '<li layim-event="show_favorite_group_list">&nbsp;&nbsp;添加到联系人分组&gt;</li>';
                    html += '<div id="favoriteGroupList" style="display: none;"><ul>';
                    for (var index = 0; index < favoriteGroupDefs.length; index++) {
                        html += '<li layim-event="add_favorite" title="' + favoriteGroupDefs[index].groupDesc + '" data-favorite-group-def-id="' + favoriteGroupDefs[index].id + '" data-favorite-group-desc="' + favoriteGroupDefs[index].groupDesc + '">&nbsp;&nbsp;&nbsp;&nbsp;' + (favoriteGroupDefs[index].groupDesc) + '</li>';
                    }
                    html += '</div></ul>';
                }
            }
            /* html += '<li layim-event="menu_nomsg">屏蔽消息</li>';
            html += '<li layim-event="menu_delete" >&nbsp;&nbsp;&nbsp;&nbsp;删除好友</li>';
            html += '<li layim-event="menu_moveto" >&nbsp;&nbsp;&nbsp;&nbsp;移动至</li></ul>';*/
            html += '</ul>';
            if (othis.hasClass('layim-null')) return;

            layer.tips(html, this, {
                tips: 1
                , time: 0
                , anim: 5
                , fixed: true
                , skin: 'layui-box layui-layim-contextmenu'
                , success: function (layero) {
                    var stopmp = function (e) {
                        stope(e);
                    };
                    layero.off('mousedown', stopmp).on('mousedown', stopmp);
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                    var layerobj = $("#contextmenu_" + id).parent(".layui-layim-contextmenu");
                    resetposition(layerobj);
                }
            });
            $(document).off('mousedown', hide).on('mousedown', hide);
            $(window).off('resize', hide).on('resize', hide);

        });

        //自定义组织机构右键菜单layim-list-friend
        layimMain.find('.layim-list-friend').on('contextmenu', 'h5', function (e) {
            othis = $(this);
            var id = othis[0].id || $(othis).data('id');
            var liCnt = 0;
            var html = '<ul id="contextmenu_' + othis[0].id + '" data-id="' + othis[0].id + '" data-index="' + othis.data('index') + '">';
            if ($(othis).data('nodetype') == 'dept') {
                if (Chat.isCurrentUserInDept($(othis).data('id'))) {
                    html += '<li layim-event="menu_office_chat" >&nbsp;&nbsp;&nbsp;&nbsp;临时会话</li></ul>';
                    liCnt++;
                }
            } else if ($(othis).data('nodetype') == 'favoriteGroup') {
                if (id == '-1') {
                    html += '<li layim-event="create_contact_group" >&nbsp;&nbsp;&nbsp;&nbsp;新建联系人分组</li></ul>';
                    liCnt++;
                } else {
                    var groupDesc = othis[0].name || $(othis).data('name');
                    html += '<li layim-event="rename_contact_group" data-id="' + id + '" data-group-desc="' + groupDesc + '" >&nbsp;&nbsp;&nbsp;&nbsp;重命名联系人分组</li></ul>';
                    html += '<li layim-event="delete_contact_group" data-id="' + id + '"  data-group-desc="' + groupDesc + '">&nbsp;&nbsp;&nbsp;&nbsp;删除联系人分组</li></ul>';
                    liCnt = liCnt + 2;
                }
            }
            if (liCnt == 0) {
                return;
            }

            layer.tips(html, this, {
                tips: 1
                , time: 0
                , anim: 5
                , fixed: true
                , skin: 'layui-box layui-layim-contextmenu'
                , success: function (layero) {
                    var stopmp = function (e) {
                        stope(e);
                    };
                    layero.off('mousedown', stopmp).on('mousedown', stopmp);
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                    var layerobj = $("#contextmenu_" + id).parent(".layui-layim-contextmenu");
                    resetposition(layerobj);
                }
            });
            $(document).off('mousedown', hide).on('mousedown', hide);
            $(window).off('resize', hide).on('resize', hide);

        });

        //右键查询好友
        layimMain.find('#layui-layim-search').on('contextmenu', 'li', function (e) {
            othis = $(this);
            var id = othis[0].id || othis.data('id') || '';
            var uname = othis[0].uname || othis.data('uname') || '';
            var html = '<ul id="contextmenu_' + othis[0].id + '" data-id="' + othis[0].id + '" data-index="' + othis.data('index') + '">';
            html += '<li layim-event="menu_profile">&nbsp;&nbsp;查看资料&nbsp;' + uname + '</li>';
            var favoriteGroupDefs = Chat.getAvailableFavoriteGroupDefs(id);
            if (!favoriteGroupDefs || !favoriteGroupDefs.length) {
                //没有可用分组
            } else if (favoriteGroupDefs.length == 1) {
                html += '<li layim-event="add_favorite" data-favorite-group-def-id="' + favoriteGroupDefs[0].id + '" data-favorite-group-desc="' + favoriteGroupDefs[0].groupDesc + '">&nbsp;&nbsp;&nbsp;添加到&nbsp;' + (favoriteGroupDefs[0].groupDesc) + '</li>';
            } else {
                html += '<li layim-event="show_favorite_group_list">&nbsp;&nbsp;添加到联系人分组&gt;</li>';
                html += '<div id="favoriteGroupList" style="display: none;"><ul>';
                for (var index = 0; index < favoriteGroupDefs.length; index++) {
                    html += '<li layim-event="add_favorite" data-favorite-group-def-id="' + favoriteGroupDefs[index].id + '" data-favorite-group-desc="' + favoriteGroupDefs[index].groupDesc + '">&nbsp;&nbsp;&nbsp;&nbsp;' + (favoriteGroupDefs[index].groupDesc) + '</li>';
                }
                html += '</div></ul>';
            }
            html += '</ul>';

            if (othis.hasClass('layim-null')) return;

            layer.tips(html, this, {
                tips: 1
                , time: 0
                , anim: 5
                , fixed: true
                , skin: 'layui-box layui-layim-contextmenu'
                , success: function (layero) {
                    var stopmp = function (e) {
                        stope(e);
                    };
                    layero.off('mousedown', stopmp).on('mousedown', stopmp);
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                    var layerobj = $("#contextmenu_" + id).parent(".layui-layim-contextmenu");
                    resetposition(layerobj);
                }
            });
            $(document).off('mousedown', hide).on('mousedown', hide);
            $(window).off('resize', hide).on('resize', hide);
        });

        //自定义分组右键菜单
        layimMain.find('.layim-list-group').on('contextmenu', 'li', function (e) {
            var othis = $(this);
            var _this = this;
            var id = othis[0].id || $(othis).data('id');
            if (othis.hasClass('layim-null')) return;
            var dataIndex = othis.data('index');
            var groupObj = cache.group[dataIndex];
            var html = '<ul data-id="' + othis[0].id + '" data-type="group" data-list="' + dataIndex + '" data-index="' + dataIndex + '"  data-groupname="' + groupObj.groupname + '">';

            if(groupObj.temporary || Chat.isRoomCreatorUser(othis[0].id)) {
                html = html + '<li layim-event="renameGroup" data-type="one">重命名群组</li>';
            } else {
                // 无右键菜单
                return;
            }
            // else {
            //     if(Chat.isRoomCreatorUser(othis[0].id)){
            //         html = html + '<li layim-event="renameGroup" data-type="one">重命名群组</li>';
            //     } else {
            //         html = html + '<li layim-event="exitGroup" data-type="two">退出群组</li>';
            //     }
            // }
            html = html + '</ul>';
            layer.tips(html, _this, {
                tips: 1
                , time: 0
                , anim: 5
                , fixed: true
                , skin: 'layui-box layui-layim-contextmenu'
                , success: function (layero) {
                    var stopmp = function (e) {
                        stope(e);
                    };
                    layero.off('mousedown', stopmp).on('mousedown', stopmp);
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                    var layerobj = $("#contextmenu_" + id).parent(".layui-layim-contextmenu");
                    resetposition(layerobj);
                }
            });

            $(document).off('mousedown', hide).on('mousedown', hide);
            $(window).off('resize', hide).on('resize', hide);

        });

    };
    var resetposition = function (obj) {
        if (obj.length) {
            var top = obj.css("top").toLowerCase().replace("px", "");
            var left = obj.css("left").toLowerCase().replace("px", "");
            top = parseInt(top);
            left = parseInt(left);
            obj.css({"left": left + "px", "top": top + "px"});
        }
    };
    //主面板最小化状态
    var layimClose, popmin = function (content) {
        if (layimClose) {
            layer.close(layimClose.attr('times'));
        }
        if (layimMain) {
            layimMain.hide();
        }
        cache.mine = cache.mine || {};
        return layer.open({
            type: 1
            ,
            title: false
            ,
            id: 'layui-layim-close'
            ,
            skin: 'layui-box layui-layim-min layui-layim-close'
            ,
            shade: false
            ,
            closeBtn: false
            ,
            anim: 2
            ,
            offset: 'rb'
            ,
            resize: true
            ,
            content: '<img src="' + (cache.mine.avatar || (layui.cache.dir + 'css/pc/layim/skin/logo.jpg')) + '"><span style="color: #333333;">' + (content || cache.base.title || '我的消息') + '</span>'
            ,
            move: '#layui-layim-close img'
            ,
            success: function (layero, index) {
                layimClose = layero;
                if (cache.base.right) {
                    layero.css('margin-left', '-' + cache.base.right);
                }
                layero.on('click', function () {
                    layer.close(index);
                    layimMain.show();
                    var local = layui.data('layim')[cache.mine.id] || {};
                    delete local.close;
                    layui.data('layim', {
                        key: cache.mine.id
                        , value: local
                    });
                    $('img.lazy').lazyload({container: $("#layim_user_box")});
                });

                if(Chat.messages && !$.isEmptyObject(Chat.messages)){
                    $('div#layui-layim-close').addClass('sparkling');
                }

            }
        });
    };

    //显示聊天面板
    var layimChat, layimMin, chatIndex, To = {}, popchat = function (data, showUnreadMsg) {
        data = data || {};
        if (data.type != "friend") {
            var roomObj = Chat.getRoomInfoById(data.id);
            addList(roomObj);
            chat_temp(roomObj, showUnreadMsg);
        } else {
            data.chatname = data.name;
            chat_temp(data, showUnreadMsg);
        }
        if (layimChat) {
            layimChat.on('contextmenu', function (event) {
                event.cancelBubble = true;
                event.returnValue = false;
                return false;
            });
        }
    };

    var chat_temp = function (data, showUnreadMsg) {
        var chat = $('#layui-layim-chat'), render = {
            data: data
            , base: cache.base
            , local: cache.local
        };


        if (!data.id) {
            return layer.msg('非法用户');
        }

        if (chat[0]) {
            //data.id =data.id.replace("@","\\@");
            var list = layimChat.find('.layim-chat-list');
            var listThat = list.find('.layim-chatlist-' + data.type + data.id);
            var hasFull = layimChat.find('.layui-layer-max-org').hasClass('layui-layer-max-orgmin');
            var chatBox = chat.children('.layim-chat-box');

            //如果是最小化，则还原窗口
            if (layimChat.css('display') === 'none') {
                layimChat.show();
            }

            if (layimMin) {
                layer.close(layimMin.attr('times'));
            }

            //如果出现多个聊天面板
            if (list.find('li').length === 1 && !listThat[0]) {
                hasFull || layimChat.css('width', 800);
                list.css({height: layimChat.height()}).show();
                chatBox.css('margin-left', '200px');

            }

            //打开的是非当前聊天面板，则新增面板
            if (!listThat[0]) {
                list.append(laytpl(elemChatList).render(render));
                chatBox.append(laytpl(elemChatTpl).render(render));
                //syncGray(data);
                resizeChat();
                $("#addGroupChat_" + data.id).on('click', function () {
                    openIMGroup(data);
                })
            }
            //layimChat.find('#layui-layim-chat').find('.addGroupChat').on('click', function(){
            //   openIMGroup(data);
            // });
            changeChat(list.find('.layim-chatlist-' + data.type + data.id), 0, false);
            listThat[0] || viewChatlog();
            //显示未读消息
            if(showUnreadMsg) {
                showUnreadMessage();
            }
            setHistory(data);
            hotkeySend();

            return chatIndex;
        }
        render.first = !0;
        var index = chatIndex = layer.open({
            type: 1
            ,
            area: '600px'
            ,
            skin: 'layui-box layui-layim-chat'
            ,
            id: 'layui-layim-chat'
            ,
            title: '&#8203;'
            ,
            shade: false
            ,
            maxmin: true
            ,
            offset: data.offset || 'auto'
            ,
            anim: data.anim || 0
            ,
            closeBtn: cache.base.brief ? false : 1
            ,
            content: laytpl('<ul class="layui-unselect layim-chat-list">' + elemChatList + '</ul><div class="layim-chat-box">' + elemChatTpl + '</div>').render(render)
            ,
            success: function (layero) {
                layimChat = layero;

                layero.css({
                    'min-width': '500px'
                    , 'min-height': '420px'
                });
                //console.log(data,'----------data-------');
                layero.find('#layui-layim-chat').find('#addGroupChat_' + data.id).on('click', function () {
                    //console.log(data,'----------data-------');
                    openIMGroup(data);
                });
                //syncGray(data);

                typeof data.success === 'function' && data.success(layero);

                hotkeySend();
                setSkin(layero);
                setHistory(data);

                viewChatlog();
                showOffMessage();
                if(showUnreadMsg) {
                    //显示未读消息
                    showUnreadMessage();
                    //聊天窗口的切换监听
                    layui.each(call.chatChange, function (index, item) {
                        item && item(thisChat());
                    });
                }

                layero.on('contextmenu', function (event) {
                    event.cancelBubble = true;
                    event.returnValue = false;
                    return false;
                });

                //查看大图
                layero.on('dblclick', '.layui-layim-photos', function () {
                    var src = this.src;
                    layer.close(popchat.photosIndex);
                    layer.photos({
                        photos: {
                            data: [{
                                "alt": "大图模式",
                                "src": src
                            }]
                        }
                        , shade: 0.01
                        , closeBtn: 2
                        , anim: 0
                        , resize: false
                        , success: function (layero, index) {
                            popchat.photosIndex = index;
                        }
                    });
                });
            }
            ,
            full: function (layero) {
                layer.style(index, {
                    width: '100%'
                    , height: '100%'
                }, true);
                resizeChat();
            }
            ,
            resizing: resizeChat
            ,
            restore: resizeChat
            ,
            min: function () {
                setChatMin();
                return false;
            }
            ,
            cancel: function () {
                clearHistoryImRecord();
            }
            ,
            end: function () {
                layer.closeAll('tips');
                layimChat = null;
            }
        });
        return index;
    };

    //同步置灰状态
    var syncGray = function (data) {
        $('.layim-' + data.type + data.id).each(function () {
            if ($(this).hasClass('layim-list-gray')) {
                layui.layim.setFriendStatus(data.id, 'offline');
            }
        });
    };

    //单人聊天场景下发起临时会话添加群组人员
    var openIMGroup = function (data) {
        Chat.getUserTeam(layui, '', true, function (userIds) {
            if(userIds && userIds.length > Chat.roomMaxUsers){
                layer.msg('创建失败，群组人数超过' + Chat.roomMaxUsers + '！')
            } else if (userIds && userIds.length > 0) {
                var nickname = Chat.currentUser.jid.split("@")[0];
                var groupName = "与" + data.name + "等人的群聊";
                $.post("./im/ImRoomController/saveImRoom/2", {roomName: groupName,currentUser:nickname}, function (result1) {
                    var imRoom = result1.imRoom;
                    layui.layim.chat({
                        name: imRoom.id
                        , temporary: true
                        , type: 'group' //群组类型
                        , avatar: CONST_IMAGE_ICON_ROOT_URL + "tem.png"
                        , id: imRoom.id //定义唯一的id方便你处理信息
                        , members: 0 //成员数，不好获取的话，可以设置为0
                    });
                    //当前聊天对象是否在选择的用户中
                    var ischatUserGroup = false;
                    //当前登录人是否在选择的用户中
                    var isSessionUserGroup = false;
                    layui.each(userIds, function (i, e) {
                        if (e.id == nickname) {
                            isSessionUserGroup = true;
                        }
                        if (e.id == data.id) {
                            ischatUserGroup = true;
                        }
                    });
                    if (isSessionUserGroup == false) {
                        userIds.push({id: nickname, name: ''});
                    }
                    if (ischatUserGroup == false) {
                        userIds.push({id: data.id, name: data.name});
                    }
                    inviteUsersToGroup(imRoom.id, userIds, Chat.ROOM_TYPE_TEMPGROUP);
                    addList(Chat.addToMucRoom(imRoom));
                });
            }
        });
    }

    //重置聊天窗口大小
    var resizeChat = function () {
        var list = layimChat.find('.layim-chat-list')
            , chatMain = layimChat.find('.layim-chat-main')
            , chatHeight = layimChat.height();
        list.css({
            height: chatHeight
        });
        chatMain.css({
            height: chatHeight - 20 - 80 - 158
        })
    };

    //设置聊天窗口最小化 & 新消息提醒
    var setChatMin = function (newMsg) {
        var thatChat = newMsg || thisChat().data, base = layui.layim.cache().base;
        if (layimChat && !newMsg) {
            layimChat.hide();
        }
        layer.close(setChatMin.index);
        var avatar = thatChat.avatar;
        if (thatChat.type == 'group') { //临时会话头像
            if (thatChat.temporary) {
                avatar = './avicit/platform6/im/image/tem.png';
            } else {
                avatar = './avicit/platform6/im/image/avatar_group.jpg';
            }
            var groupObj = Chat.getRoomInfoById(thatChat.id);
            if(groupObj){
                thatChat.chatname = groupObj.chatname;
            }
        }
        var titleTxt = (typeof (thatChat.chatname) == "undefined" ? thatChat.name : thatChat.chatname);
        setChatMin.index = layer.open({
            type: 1
            ,
            title: false
            ,
            skin: 'layui-box layui-layim-min'
            ,
            shade: false
            ,
            closeBtn: false
            ,
            anim: thatChat.anim || 2
            ,
            offset: 'b'
            ,
            move: '#layui-layim-min'
            ,
            resize: true
            ,
            area: ['182px', '50px']
            ,
            content: '<img id="layui-layim-min" data-id="'+(thatChat.id)+'" src="' + avatar + '"><span style="color:#333333;" title="'+ titleTxt +'">' + titleTxt + '</span>'
            ,
            success: function (layero, index) {
                if (!newMsg) layimMin = layero;

                if (base.minRight) {
                    layer.style(index, {
                        left: $(window).width() - layero.outerWidth() - parseFloat(base.minRight)
                    });
                }

                layero.find('div.layui-layer-content').addClass('layui-layim-chat-min');
                if(newMsg){
                    layero.find('div.layui-layer-content').addClass('sparkling');
                }

                layero.find('.layui-layer-content span').on('click', function () {
                    layer.close(index);
                    if (newMsg) {
                        //点击下方【收到新消息】后，只有最后一个聊天窗口为活动窗口，并且加载未读消息
                        layui.each(cache.chat, function (i, item) {
                            if(cache.chat.length == (i+1)){
                                popchat(item, true);
                            } else {
                                popchat(item, false);
                            }
                        });
                        //其他聊天窗口显示未读消息标识
                        layui.each(cache.chat, function (i, item) {
                            var unreadMessage = Chat.messages[item.type + item.id];
                            if(unreadMessage && unreadMessage.length) {
                                appendNewMsgFlag(item.id, unreadMessage.length, 0);
                            }
                        });
                        cache.chat = [];
                        chatListMore();
                    } else {
                        layimChat.show();
                        showUnreadMessage();
                    }
                });
                layero.find('.layui-layer-content img').on('click', function (e) {
                    stope(e);
                });
            }
        });
    };

    //打开添加好友、群组面板、好友分组面板
    var popAdd = function (data, type) {
        data = data || {};
        layer.close(popAdd.index);
        return popAdd.index = layer.open({
            type: 1
            , area: '430px'
            , title: {
                friend: '添加好友'
                , group: '加入群组'
            }[data.type] || ''
            , shade: false
            , resize: false
            , btn: type ? ['确认', '取消'] : ['发送申请', '关闭']
            , content: laytpl(elemAddTpl).render({
                data: {
                    name: data.username || data.groupname
                    , avatar: data.avatar
                    , group: data.group || parent.layui.layim.cache().friend || []
                    , type: data.type
                }
                , type: type
            })
            , yes: function (index, layero) {
                var groupElem = layero.find('#LAY_layimGroup')
                    , remarkElem = layero.find('#LAY_layimRemark')
                if (type) {
                    data.submit && data.submit(groupElem.val(), index);
                } else {
                    data.submit && data.submit(groupElem.val(), remarkElem.val(), index);
                }
            }
        });
    };

    //切换聊天(默认情况下显示未读消息)
    var changeChat = function (elem, del, showUnreadMsgFlag) {
        elem = elem || $('.layim-chat-list .' + THIS);
        var index = elem.index() === -1 ? 0 : elem.index();
        var str = '.layim-chat', cont = layimChat.find(str).eq(index);
        var hasFull = layimChat.find('.layui-layer-max-org').hasClass('layui-layer-max-orgmin');
        var showUnreadMsg = (showUnreadMsgFlag === undefined ? true : showUnreadMsgFlag);
        if (del) {
            //删除聊天面板
            removeHistoryImRecord(elem.data("id"));
            //如果关闭的是当前聊天，则切换聊天焦点
            if (elem.hasClass(THIS)) {
                if(index === 0 && elem.next().length){
                    changeChat(elem.next());
                } else if(index !== 0 && elem.prev().length){
                    changeChat(elem.prev());
                }
            }

            var length = layimChat.find(str).length;

            //关闭聊天界面
            if (length === 1) {
                return layer.close(chatIndex);
            }

            elem.remove();
            cont.remove();

            //只剩下1个列表，隐藏左侧区块
            if (length === 2) {
                layimChat.find('.layim-chat-list').hide();
                if (!hasFull) {
                    layimChat.css('width', '600px');
                }
                layimChat.find('.layim-chat-box').css('margin-left', 0);
            }

            return false;
        }

        elem.addClass(THIS).siblings().removeClass(THIS);
        cont.addClass(SHOW).siblings(str).removeClass(SHOW);
        cont.find('textarea').focus();

        showOffMessage();
        if(showUnreadMsg){
            //显示未读消息
            showUnreadMessage();
            //聊天窗口的切换监听
            layui.each(call.chatChange, function (index, item) {
                item && item(thisChat());
            });
        }

        var thatChat = thisChat();
        var type = thatChat.type;
    };

    //显示未读消息
    var showUnreadMessage = function () {
        var thatChat = thisChat(), ul = thatChat.elem.find('.layim-chat-main ul');
        //未读消息列表
        var unreadMessage = Chat.messages[thatChat.data.type + thatChat.data.id];
        removeNewMsgSeperator();
        if(unreadMessage){
            var msgUniqueIds = [];
            var userInfo = null;
            if( 'friend' == thatChat.data.type ){
                userInfo = Chat.getUserInfoById(thatChat.data.id);
            }
            if(unreadMessage.length){
                ul.append('<div style="width:100%; text-align:left; margin-left:15px; margin-right:15px;height: 20px;line-height: 20px;padding: 0;font-size: 14px;color: #999;background-color: white;text-align: center;cursor:default;" class="new-msg-seperator"> <hr style="width:35%;vertical-align:middle; display:inline-block;">以下是新消息<hr style="width:35%;vertical-align:middle; display:inline-block;"> </div>');
            }
            $.each(unreadMessage,function (index,item) {
                if(userInfo) {
                    item.status = userInfo.status;
                }
                pushChatlog(item);
                ul.append(laytpl(elemChatMain).render(item));
                msgUniqueIds.push(item.msguniqueid);
            });
            Chat.deleteReadMessage(msgUniqueIds.join(','));
            //展现后,删除未读消息
            delete Chat.messages[thatChat.data.type + thatChat.data.id];
            //清除新消息标识
            clearNewMsgFlag(thatChat.data.id);
            layui.each(cache.chat, function (i, item) {
                if(item.type == thatChat.data.type && item.id == thatChat.data.id){
                    cache.chat.splice(i, 1);
                    return false;
                }
            });
            if(cache.chat.length == 0){
                layer.close(setChatMin.index);
            }
        }

        //刷新用户在线状态
        var data = thatChat.data;
        var peerUser = data.type == 'friend' && Chat.getUserInfoById(data.id);
        if(peerUser){
            var status = Chat.getUserStatus(data.id);
            layui.layim.setFriendStatus(data.id, status, peerUser);
        }

        setHistoryImRecord(data);//聊天窗口缓存到本地
        setActiveImRecord(data.id, data.type);
    };
    //展示存在队列中的消息
    var showOffMessage = function () {
        var thatChat = thisChat();
        var message = cache.message[thatChat.data.type + thatChat.data.id];
        if (message) {
            //展现后，删除队列中消息
            delete cache.message[thatChat.data.type + thatChat.data.id];
        }
    };

    // 删除新消息分割线
    var removeNewMsgSeperator = function () {
        var thatChat = thisChat();
        thatChat.elem.find('.layim-chat-main ul div.new-msg-seperator').remove();
    };

    //获取当前聊天面板
    var thisChat = function () {
        if (!layimChat) return;
        var index = $('.layim-chat-list .' + THIS).index();
        var cont = layimChat.find('.layim-chat').eq(index);
        var to = JSON.parse(decodeURIComponent(cont.find('.layim-chat-tool').data('json')));
        return {
            elem: cont
            , data: to
            , textarea: cont.find('textarea')
        };
    };

    //记录聊天窗口信息(缓存)
    var setHistoryImRecord = function (data) {
        if (Chat.cacheChatWindow) {
            var local = layui.data('layim.chatCache')[cache.mine.id] || {};
            var imrecords = local.imrecord || [];
            var has = false;
            for (var index = 0; index < imrecords.length; index++) {
                if (imrecords[index].id == data['id']) {
                    has = true;
                }
            }
            if(!has){
                imrecords.push(data);
                local.imrecord = imrecords;
                layui.data('layim.chatCache', {
                    key: cache.mine.id,
                    value: local
                });
            }
        }
    };

    //移除聊天窗口信息(缓存)
    var removeHistoryImRecord = function (id) {
        var cacheChatWindow = Chat.cacheChatWindow;
        if (cacheChatWindow) {
            var local = layui.data('layim.chatCache')[cache.mine.id] || {};
            var imrecords = local.imrecord || [];
            for (var index = 0; index < imrecords.length; index++) {
                if (id === imrecords[index]['id']) {
                    imrecords.splice(index, 1)
                }
            }
            local.imrecord = imrecords;
            if(local.active && local.active.id == id){
                local.active = {};
            }
            layui.data('layim.chatCache', {
                key: cache.mine.id,
                value: local
            });
        }
    };

    //设置当前聊天窗口(缓存)
    var setActiveImRecord = function (id, type) {
        var cacheChatWindow = Chat.cacheChatWindow;
        if (cacheChatWindow) {
            var local = layui.data('layim.chatCache')[cache.mine.id] || {};
            local.active = {
                id: id,
                type: type
            };
            layui.data('layim.chatCache', {
                key: cache.mine.id,
                value: local
            });
        }
    };

    //初始化聊天窗口信息(缓存)
    var initHistoryImRecord = function () {

        if (Chat.cacheChatWindow) {
            var local = layui.data('layim.chatCache')[cache.mine.id] || {};
            var imrecords = local.imrecord || [];
            if (imrecords && imrecords.length) {
                for (var index = 0; index < imrecords.length; index++) {
                    var imrecord = imrecords[index];
                    if("friend" == imrecord.type){
                        var item = Chat.getUserInfoById(imrecord.id);
                        if(item){
                            imrecord.status = item.status;
                        }
                    } else if(imrecord.type == 'group'){
                        var roomObj = Chat.getRoomInfoById(imrecord.id);
                        if(roomObj){
                            imrecord.chatname = roomObj.chatname;
                            imrecord.groupname = roomObj.groupname;
                        }
                    }
                    if (imrecord.hasOwnProperty("id")) {
                        chat_temp(imrecord, false);
                    }
                }
            }

            var active = local.active || {};
            if (active && active.type && active.id) {
                changeChat($(".layim-chat-list").find(".layim-chatlist-" + active.type + active.id), null, false);
                setChatMin();
            }
        }
    };

    //删除聊天窗口信息(缓存)
    var clearHistoryImRecord = function () {
        var local = layui.data('layim.chatCache')[cache.mine.id] || {};
        local.imrecord = [];
        local.active = {};
        layui.data('layim.chatCache', {
            key: cache.mine.id,
            value: local
        });
    };

    //记录初始背景
    var setSkin = function (layero) {
        var local = layui.data('layim')[cache.mine.id] || {}
            , skin = local.skin;
        layero.css({
            'background-image': skin ? 'url(' + skin + ')' : function () {
                return cache.base.initSkin
                    ? 'url(' + (layui.cache.dir + 'css/modules/layim/skin/' + cache.base.initSkin) + ')'
                    : 'none';
            }()
        });
    };

    //记录历史会话
    var setHistory = function (data) {
        var local = layui.data('layim')[cache.mine.id] || {};
        var obj = {}, history = local.history || {};
        var is = history[data.type + data.id];

        if (!layimMain) return;

        var historyElem = layimMain.find('.layim-list-history');

        data.historyTime = new Date().getTime();
        data.belongTo = cache.mine.id;
        history[data.type + data.id] = data;

        local.history = history;

        layui.data('layim', {
            key: cache.mine.id
            , value: local
        });

        if (is) return;
        if(historyElem.find('#' + data.id).length) return;
        obj[data.type + data.id] = data;
        var historyList = laytpl(listTpl({
            type: 'history'
            , item: 'd.data'
        })).render({data: obj});
        //console.log(historyList+' '+data,'---------------记录lishi-----');
        historyElem.prepend(historyList);
        historyElem.find('.layim-null').remove();
    };

    //发送消息
    var sendMessage = function () {
		if(Chat.currentUser.status != 'online'){
            layer.msg('与服务器断开连接，请重新登录！');
			return;
        }
        var data = {
            username: cache.mine ? cache.mine.username : '访客'
            , avatar: cache.mine ? cache.mine.avatar : (layui.cache.dir + 'css/pc/layim/skin/logo.jpg')
            , id: cache.mine ? cache.mine.id : null
            , type: cache.mine ? cache.mine.type : null
            , secretLevel: cache.mine.secretLevel ? cache.mine.secretLevel : null
            , mine: true
        };
        //console.log(cache,'--------11111111-------');
        var thatChat = thisChat(), ul = thatChat.elem.find('.layim-chat-main ul');
        var maxLength = cache.base.maxLength || 3000;
        data.content = thatChat.textarea.val();
        thatChat.textarea.val('');
        if (data.content.replace(/\s/g, '') !== '') {
            layui.data.isSystemMsg(data.content) && (data.content = ' ' + data.content);
            if (data.content.length > maxLength) {
                return layer.msg('内容最长不能超过' + maxLength + '个字符')
            }

            var param = {
                mine: data
                , to: thatChat.data
            }, message = {
                username: param.mine.username
                , avatar: param.mine.avatar
                , id: param.to.id
                , type: param.to.type
                , secretLevel: param.to.secretLevel
                , content: param.mine.content
                , timestamp: new Date().getTime()
                , mine: true
            };
            thatChat.textarea.attr('readonly', 'readonly');
            layui.each(call.sendMessage, function (index, item) {
                item && $.when(item(param))
                    .done(function (msguniqueid) {
                        data.msguniqueid = msguniqueid;
                        ul.append(laytpl(elemChatMain).render(data));
                        message.msguniqueid = msguniqueid;
                        pushChatlog(message);
                        sortHistoryChat(thatChat.data);
                        chatListMore();
                        thatChat.textarea.val('').focus();
                        thatChat.textarea.removeAttr('readonly');
                        removeNewMsgSeperator();
                    })
                    .fail(function () {
                        //Do nothing
                        thatChat.textarea.val(param.mine.content).focus();
                        thatChat.textarea.removeAttr('readonly');
                        removeNewMsgSeperator();
                    });
            });
        } else {
            //layer.msg('消息内容不能为空！');
        }
    };

    //发送消息
    var sendMsg = function (content, systemMsg) {
		if(Chat.currentUser.status != 'online'){
            layer.msg('与服务器断开连接，请重新登录！');
			return;
        }
        var data = {
            username: cache.mine ? cache.mine.username : '访客'
            , avatar: cache.mine ? cache.mine.avatar : (layui.cache.dir + 'css/pc/layim/skin/logo.jpg')
            , id: cache.mine ? cache.mine.id : null
            , mine: true
            , system: !!systemMsg
        };
        var thatChat = thisChat(), ul = thatChat.elem.find('.layim-chat-main ul');
        var maxLength = cache.base.maxLength || 3000;
        data.content = content;
        if (data.content.replace(/\s/g, '') !== '') {
            if (data.system) {
                data.content = "system[" + data.content.replace('\[', '').replace('\]', '') + "]"
            }

            if (data.content.length > maxLength) {
                return layer.msg('内容最长不能超过' + maxLength + '个字符')
            }

            var param = {
                mine: data
                , to: thatChat.data
            }, message = {
                username: param.mine.username
                , avatar: param.mine.avatar
                , id: param.to.id
                , type: param.to.type
                , content: param.mine.content
                , timestamp: new Date().getTime()
                , mine: true
            };

            layui.each(call.sendMessage, function (index, item) {
                //item && item(param);
                item && $.when(item(param))
                    .done(function () {
                        data.system || ul.append(laytpl(elemChatMain).render(data));
                        data.system || pushChatlog(message);
                        sortHistoryChat(thatChat.data);
                        chatListMore();
                        thatChat.textarea.focus();
                    });
            });
        }
        return true;
    };

    //桌面消息提醒
    var notice = function (data) {
        data = data || {};
        if (window.Notification) {
            if (Notification.permission === 'granted') {
                //如果是图片或者文件，去掉链接内容
                var content = data.content;
                if (content) {
                    if (content.startsWith("img[")) {
                        content = "图片";
                    } else if (content.startsWith("audio[")) {
                        content = "语音";
                    } else if (content.startsWith("file(")) {
                        content = "文件";
                    } else if (content.startsWith("face[")) {
                        content = "表情";
                    } else if (content.startsWith("system[")) {
                        content = "系统消息：" + content.substring(7, content.length - 1);
                    } else {
                        content = layui.data.content(data.content);
                    }
                }
                var notification = new Notification(data.title || '', {
                    body: content || ''
                    , icon: data.avatar || 'http://tva1.sinaimg.cn/default/images/default_avatar_male_50.gif'
                });
            } else {
                Notification.requestPermission();
            }
            ;
        }
    };

    //消息声音提醒
    var voice = function () {
        if (device.ie && device.ie < 9) return;
        var audio = document.createElement("audio");
        audio.src = layui.cache.dir + 'css/modules/layim/voice/' + cache.base.voice;
        audio.play();
    };

    //接受消息
    var messageNew = {}, getMessage = function (data) {

        data = data || {};

        var elem = $('.layim-chatlist-' + data.type + data.id);
        var group = {}, index = elem.index();

        data.timestamp = data.timestamp || new Date().getTime();
        if (data.fromid == cache.mine.id) {
            data.mine = true;
        }

        if(existInChatlog(data)) {
            data.msguniqueid && Chat.deleteReadMessage(data.msguniqueid);
            return;
        }

        if (data.type === 'group') {
            group = Chat.getRoomInfoById(data.id);
        }
        pushUnreadMessage(data);
        sortHistoryChat(data);
        messageNew = JSON.parse(JSON.stringify(data));

        if (cache.base.voice) {
            voice();
        }

        if ((!layimChat && data.content) || index === -1) {
            if (cache.message[data.type + data.id]) {
                cache.message[data.type + data.id].push(data)
            } else {
                cache.message[data.type + data.id] = [data];

                //记录聊天面板队列
                if (data.type === 'friend') {
                    var friend;
                    layui.each(cache.friend, function (index1, item1) {
                        layui.each(item1.list, function (index, item) {
                            if (item.id == data.id) {
                                item.type = 'friend';
                                item.name = item.username;
                                cache.chat.push(item);
                                return friend = true;
                            }
                        });
                        if (friend) return true;
                    });
                    if (!friend) {
                        data.name = data.username;
                        data.temporary = true; //临时会话
                        cache.chat.push(data);
                    }
                } else if (data.type === 'group') {
                    var isgroup;
                    layui.each(cache.group, function (index, item) {
                        if (item.id == data.id) {
                            item.type = 'group';
                            item.name = item.groupname;
                            cache.chat.push(item);
                            return isgroup = true;
                        }
                    });
                    if (!isgroup) {
                        data.name = data.groupname;
                        cache.chat.push(data);
                    }
                } else {
                    data.name = data.name || data.username || data.groupname;
                    cache.chat.push(data);
                }
            }

            if (!data.system) {
                setChatMin({
                    name: '收到新消息'
                    , avatar: (group && group.avatar) || data.avatar
                    , anim: 6
                });
            }
        }

        //发送桌面通知
        if (cache.base.notice && !Chat.isFocus) {
            var alreadyNotice = false;
            $.each(Chat.unreadMsgFroms,function(i,item){
                if(item == data.id){
                    alreadyNotice = true;
                }
            });
            if(!alreadyNotice){
                notice({
                    title: '来自 ' + data.username + ' 的消息'
                    , content: data.content
                    , avatar: (group && group.avatar) || data.avatar
                });
                Chat.unreadMsgFroms.push(data.id);
            }
        }

        //新消息提醒--主聊天窗口未打开
        if (data.content && (!layimChat || index === -1)) {
            //收到新消息时，在历史会话列表中增加新消息标识
            appendNewMsgFlag(data.id, 1, 1);
            return;
        }

        var thatChat = thisChat();
        var minBoxChatid = $('img#layui-layim-min').data('id');
        //接收到的消息属于当前会话,并且不处于最小化状态
        if (thatChat.data.type + thatChat.data.id === data.type + data.id && data.id !== minBoxChatid) {
            showUnreadMessage();
            removeNewMsgSeperator();
            chatListMore();
        } else {
            elem.addClass('layui-anim layer-anim-06');
            setTimeout(function () {
                elem.removeClass('layui-anim layer-anim-06')
            }, 300);
            //收到新消息时，在左侧聊天窗口列表和历史会话列表中增加新消息标识
            appendNewMsgFlag(data.id, 1, 0);
            appendNewMsgFlag(data.id, 1, 1);
            if(data.id === minBoxChatid){
                $('div.layui-layim-chat-min').addClass('sparkling');
            }
        }
    };

    //消息盒子的提醒
    var ANIM_MSG = 'layui-anim-loop layer-anim-05', msgbox = function (num) {
        var msgboxElem = layimMain.find('.layim-tool-msgbox');
        msgboxElem.find('span').addClass(ANIM_MSG).html(num);
    };
    var appendOneMsg2Box = function (msgCnt) {
        var msgboxElem = $('.layim-tool-msgbox > span');
        var appendCnt = msgCnt || 1;
        if (msgboxElem && msgboxElem.html()) {
            msgboxElem.html(parseInt(msgboxElem.html()) + appendCnt);
        } else {
            msgbox(appendCnt);
        }
    };
    var clearMsgBox = function () {
        var msgboxElem = $('.layim-tool-msgbox > span');
        msgboxElem.html("");
        msgboxElem.removeClass(ANIM_MSG);
    };
    //接受到新消息，显示新消息标识
    var appendNewMsgFlag = function (id, msgCnt, posType) {
        //左侧聊天窗口列表
        if (posType === 0) {
            if (!layimChat) {
                return;
            }
            var liElem = layimChat.find('ul > li[data-id="' + id + '"]');
            var minBoxChatid = $('img#layui-layim-min').data('id');
            //不需要在左侧聊天窗口列表显示新消息标识的情景
            //1 发送方不存在于左侧聊天窗口列表
            //2 发送方存在于左侧聊天窗口列表，正在与发送方聊天且不处于最小化状态
            if (liElem.length === 0 || (liElem.hasClass("layim-this") && !minBoxChatid)) {
                return;
            }
            var msgboxSpan = liElem.find('span.layim-tool-msgbox span.new-flag');
            var appendCnt = msgCnt || 1;
            if (msgboxSpan && msgboxSpan.length > 0) {
                if (msgboxSpan.html()) {
                    msgboxSpan.addClass(ANIM_MSG).html(parseInt(msgboxSpan.html()) + appendCnt);
                } else {
                    msgboxSpan.addClass(ANIM_MSG).html(appendCnt);
                }
            } else {
                var msgboxLi = $('<span class="layim-tool-msgbox"></span>');
                msgboxSpan = $('<span class="new-flag" style="width: 20px;height: 20px;left: 0px;top: 0px;padding-left: 0;font-size: 10px;line-height: 20px;">1</span>');
                msgboxSpan.addClass(ANIM_MSG).html(appendCnt);
                msgboxLi.append(msgboxSpan);
                liElem.append(msgboxLi);
            }
        }

        //历史会话
        if (posType === 1) {
            var hisElem = layimMain.find('.layim-list-history li[id="' + id + '"]');
            if (hisElem && hisElem.length > 0) {
                //历史会话列表
                var msgboxSpan = hisElem.find('span.layim-tool-msgbox span.new-flag');
                var appendCnt = msgCnt || 1;
                if (msgboxSpan && msgboxSpan.length > 0) {
                    if (msgboxSpan.html()) {
                        msgboxSpan.addClass(ANIM_MSG).html(parseInt(msgboxSpan.html()) + appendCnt);
                    } else {
                        msgboxSpan.addClass(ANIM_MSG).html(appendCnt);
                    }
                } else {
                    var msgboxLi = $('<span class="layim-tool-msgbox"></span>');
                    msgboxSpan = $('<span class="new-flag" style="left: 0px;top: 0px;">1</span>');
                    msgboxSpan.addClass(ANIM_MSG).html(appendCnt);
                    msgboxLi.append(msgboxSpan);
                    hisElem.append(msgboxLi);
                }

                //历史会话Tab页签
                var historyTab = $('div.layui-layim-main > ul.layui-layim-tab > li[lay-type="history"]');
                if (historyTab && historyTab.length ) {
                    var historyTabMsg = historyTab.find('span.layim-tool-msgbox span.new-flag');
                    if (!historyTabMsg || historyTabMsg.length === 0) {
                        var msgboxLi = $('<span class="layim-tool-msgbox"></span>');
                        historyTabMsg = $('<span class="new-flag" style="left: 60px;top: -10px;">1</span>');
                        historyTabMsg.addClass(ANIM_MSG).html('New');
                        msgboxLi.append(historyTabMsg);
                        historyTab.append(msgboxLi);
                    }
                }
                $('div#layui-layim-close').addClass('sparkling');
            }
        }

    };
    window.onblur = function () {
        if (Chat) {
            Chat.isFocus = false;
        }
    };
    window.onfocus = function () {
        if (Chat) {
            Chat.isFocus = true;
            Chat.unreadMsgFroms = [];
        }
    };
    var clearNewMsgFlag = function (id) {
        //清除左侧聊天窗口列表新消息标识
        var msgboxElem = layimChat && layimChat.find('ul > li[data-id="' + id + '"] > span.layim-tool-msgbox');
        if (msgboxElem) {
            msgboxElem.remove();
        }

        //清除历史会话新消息标识
        var hisElem = layimMain.find('.layim-list-history li[id="' + id + '"]');
        msgboxElem = hisElem && hisElem.find('span.layim-tool-msgbox');
        if (msgboxElem) {
            msgboxElem.remove();
        }

        //如果没有未读消息的话，清除历史会话Tab页签上的新消息标识
        var historyTab = $('div.layui-layim-main > ul.layui-layim-tab > li[lay-type="history"]');
        if(Chat.messages && $.isEmptyObject(Chat.messages)){
            historyTab.find('span.layim-tool-msgbox').remove();
            $('div#layui-layim-close').removeClass('sparkling');
        }
    };

    //重新设置好友顺序
    var resetFriendOrder = function (id, type) {
        var liElem = $('#layim_user_box li.layim-friend' + id);
        for (var index = 0; index < liElem.length; index++) {
            if (type === 'online') {
                //移至在线用户的第一个
                liElem.eq(index).parent('ul').find('> li').eq(0).before(liElem.eq(index));
            } else {
                //移至离线用户的第一个
                liElem.eq(index).parent('ul').find('> li >img.layim-list-gray').eq(0).parent().before(liElem.eq(index));
            }
        }
    };

    //保存未读消息
    var pushUnreadMessage = function (message) {
        var thisPeerMessages = Chat.messages[message.type + message.id];
        if(thisPeerMessages){
            var hasSame = false;
            layui.each(thisPeerMessages, function (index, item) {
                if ((item.msguniqueid === message.msguniqueid
                    && item.type === message.type
                    && item.id === message.id
                    && item.content === message.content)) {
                    hasSame = true;
                }
            });
            if(!hasSame){
                thisPeerMessages.push(message);
            }
        } else {
            Chat.messages[message.type + message.id] = [message];
        }
    };
    //消息是否存在于本地缓存
    var existInChatlog = function (message) {
        var local = layui.data('layim')[cache.mine.id] || {};
        local.chatlog = local.chatlog || {};
        var thisChatlog = local.chatlog[message.type + message.id];
        if (thisChatlog) {
            var hasSame;
            layui.each(thisChatlog, function (index, item) {
                if ((item.timestamp === message.timestamp
                    && item.type === message.type
                    && item.id === message.id
                    && item.content === message.content)) {
                    hasSame = true;
                }
            });
            if (hasSame || message.fromid == cache.mine.id) {
                return true;
            }
        }
        return false;
    };
    //存储最近MAX_ITEM条聊天记录到本地
    var pushChatlog = function (message) {
        var local = layui.data('layim')[cache.mine.id] || {};
        local.chatlog = local.chatlog || {};
        var thisChatlog = local.chatlog[message.type + message.id];
        if (thisChatlog) {
            //避免浏览器多窗口时聊天记录重复保存
            var nosame;
            layui.each(thisChatlog, function (index, item) {
                if ((item.timestamp === message.timestamp
                    && item.type === message.type
                    && item.id === message.id
                    && item.content === message.content)) {
                    nosame = true;
                }
            });
            if (!(nosame || message.fromid == cache.mine.id)) {
                thisChatlog.push(message);
            }
            if (thisChatlog.length > MAX_ITEM) {
                thisChatlog.shift();
            }
        } else {
            local.chatlog[message.type + message.id] = [message];
        }
        layui.data('layim', {
            key: cache.mine.id
            , value: local
        });
    };

    //打开历史消息查询框
    var openChatHistoryPage = function (chatname, id, type) {
        return parent.layer.open({
            type: 2
            , title: '与 ' + chatname + ' 的聊天记录'
            , shade: [0.3, '#393D49']
            , shadeClose: false
            , maxmin: false
            , area: ['800px', '600px']
            , skin: 'layui-box layui-layer-border'
            , resize: false
            , id: 'layui-layim-chatlog'
            , content: [cache.base.msgbox + '?id=' + id + '&type=' + type+'&searchKind=other&v='+(new Date().getTime()), 'no']
            , success: function (layero) {
                layero.on('contextmenu', function (event) {
                    event.cancelBubble = true;
                    event.returnValue = false;
                    return false;
                });
            }
        });
    };
    //渲染本地最新聊天记录到相应面板
    var viewChatlog = function () {
        var local = layui.data('layim')[cache.mine.id] || {}
            , thatChat = thisChat(), chatlog = local.chatlog || {}
            , ul = thatChat.elem.find('.layim-chat-main ul'), fromUserItem;
        //console.log(chatlog,'----------chatlog-------');
        layui.each(chatlog[thatChat.data.type + thatChat.data.id], function (index, item) {
            //console.log(item,'----------item-------');
            item.status = 'offline';
            if (item.type === 'friend') {
                if(item.id){
                    fromUserItem = Chat.getUserInfoById(item.id);
                }
            } else if(item.type === 'group') {
                if(item.mine){
                    fromUserItem = Chat.getUserInfoById(Chat.currentUser.id);
                } else if(item.fromid){
                    fromUserItem = Chat.getUserInfoById(item.fromid);
                }
            }
            if(fromUserItem){
                item.status = fromUserItem.status;
            }
            ul.append(laytpl(elemChatMain).render(item));
        });
        chatListMore();
    };

    //添加群
    var addList = function (data) {
        if (!data) {
            return;
        }
        var obj = {}, has, listElem = layimMain.find('.layim-list-' + data.type);

        if (cache[data.type] && data.type === 'group') {
            //检查群组是否已经在列表中
            layui.each(cache.group, function (idx, itm) {
                if (itm.id == data.id) {
                    has = true;
                    return false;
                }
            });
            has = has && listElem.find('li[data-id="' + data.id + '"]').length > 0;
            if(has) return; // layer.alert(/*'您已是 ['+ (data.groupname||'') +'] 的群成员'*/"群组创建成功");
            obj[cache.group.length] = data;
            cache.group.push(data);

            var list = laytpl(listTpl({
                type: data.type
                , item: 'd.data'
                , index: data.type === 'friend' ? 'data.groupIndex' : null
            })).render({data: obj});
            listElem.append(list);
            //如果初始没有群组
            if (listElem.find('.layim-null')[0]) {
                listElem.find('.layim-null').remove();
            }
        }
    };

    //移出好友或群
    var removeList = function (data) {
        var listElem = layimMain.find('.layim-list-' + data.type);
        var obj = {};
        if (cache[data.type]) {
            if (data.type === 'friend') {
                layui.each(cache.friend, function (index1, item1) {
                    layui.each(item1.list, function (index, item) {
                        if (data.id == item.id) {
                            var li = listElem.find('>li').eq(index1);
                            var list = li.find('.layui-layim-list>li');
                            li.find('.layui-layim-list>li').eq(index).remove();
                            cache.friend[index1].list.splice(index, 1); //从cache的friend里面也删除掉好友
                            li.find('.layim-count').html(cache.friend[index1].list.length); //刷新好友数量
                            //如果一个好友都没了
                            if (cache.friend[index1].list.length === 0) {
                                li.find('.layui-layim-list').html('<li class="layim-null">该分组下已无好友了</li>');
                            }
                            return true;
                        }
                    });
                });
            } else if (data.type === 'group') {
                layui.each(cache.group, function (index, item) {
                    if (data.id == item.id) {
                        listElem.find('>li').eq(index).remove();
                        cache.group.splice(index, 1); //从cache的group里面也删除掉数据
                        //如果一个群组都没了
                        if (cache.group.length === 0) {
                            listElem.html('<li class="layim-null">暂无群组</li>');
                        }
                        return true;
                    }
                });
            }
        }
    };

    //查看更多记录
    var chatListMore = function () {
        var thatChat = thisChat();
        var chatMain = thatChat && thatChat.elem && thatChat.elem.find('.layim-chat-main');
        if (!chatMain) {
            return;
        }
        var ul = chatMain.find('ul');
        var length = ul.find('li').length;

        if (length >= MAX_ITEM) {
            var first = ul.find('li').eq(0);
            if (!ul.prev().hasClass('layim-chat-system')) {
                ul.before('<div class="layim-chat-system"><span layim-event="chatLog">查看更多记录</span></div>');
            }
            if (length > MAX_ITEM) {
                first.remove();
            }
        }
        chatMain.scrollTop(chatMain[0].scrollHeight + 1000);
        chatMain.find('ul li:last').find('img').load(function () {
            chatMain.scrollTop(chatMain[0].scrollHeight + 1000);
        });
    };

    //快捷键发送
    var hotkeySend = function () {
        var thatChat = thisChat(), textarea = thatChat.textarea;
        textarea.focus();
        textarea.off('keydown').on('keydown', function (e) {
            var local = layui.data('layim')[cache.mine.id] || {};
            var keyCode = e.keyCode;
            if (local.sendHotKey === 'Ctrl+Enter') {
                if (e.ctrlKey && keyCode === 13) {
                    sendMessage();
                }
                return;
            }
            if (keyCode === 13) {
                if (e.ctrlKey) {
                    return textarea.val(textarea.val() + '\n');
                }
                if (e.shiftKey) return;
                e.preventDefault();
                sendMessage();
            }
        });
    };

    //表情库
    var faces = function () {
        var alt = ["[微笑]", "[嘻嘻]", "[哈哈]", "[可爱]", "[可怜]", "[挖鼻]", "[吃惊]", "[害羞]", "[挤眼]", "[闭嘴]", "[鄙视]", "[爱你]", "[泪]", "[偷笑]", "[亲亲]", "[生病]", "[太开心]", "[白眼]", "[右哼哼]", "[左哼哼]", "[嘘]", "[衰]", "[委屈]", "[吐]", "[哈欠]", "[抱抱]", "[怒]", "[疑问]", "[馋嘴]", "[拜拜]", "[思考]", "[汗]", "[困]", "[睡]", "[钱]", "[失望]", "[酷]", "[色]", "[哼]", "[鼓掌]", "[晕]", "[悲伤]", "[抓狂]", "[黑线]", "[阴险]", "[怒骂]", "[互粉]", "[心]", "[伤心]", "[猪头]", "[熊猫]", "[兔子]", "[ok]", "[耶]", "[good]", "[NO]", "[赞]", "[来]", "[弱]", "[草泥马]", "[神马]", "[囧]", "[浮云]", "[给力]", "[围观]", "[威武]", "[奥特曼]", "[礼物]", "[钟]", "[话筒]", "[蜡烛]", "[蛋糕]"],
            arr = {};
        layui.each(alt, function (index, item) {
            arr[item] = layui.cache.dir + 'images/face/' + index + '.gif';
        });
        return arr;
    }();

    //邀请到群组
    var inviteToGroup = function (groupId, roomType, selectUserIds) {
        Chat.getUserTeam(layui, selectUserIds, true, function (userIds) {
            if (!userIds || !userIds.length) {
                return;
            }
            var existUserIdsArr = Chat.getRoomMembers(groupId);
            var existUsersArr = new Array();
            var invitedUsersArr = new Array();
            for (var i = 0; i < userIds.length; i++) {
                var index = $.inArray(userIds[i].id, existUserIdsArr);
                if (index >= 0) {
                    existUsersArr.push(userIds[i]);
                } else {
                    invitedUsersArr.push(userIds[i]);
                }
            }

            if (Chat.roomMaxUsers && (invitedUsersArr.length + existUserIdsArr.length) > Chat.roomMaxUsers) {
                layer.msg('创建失败，群组人数超过' + Chat.roomMaxUsers + '！')
            } else if (invitedUsersArr.length >= 200) {

                var confirmIndex = layer.confirm("邀请人数较多，可能要消耗较长时间，您确认要添加吗？", {
                        btn: ['确认添加', '取消添加'] // 按钮
                    }, function () {
                        layer.close(confirmIndex);
                        inviteUsersToGroup(groupId, invitedUsersArr, roomType);
                    }
                    , function () {
                    });
            } else {
                inviteUsersToGroup(groupId, invitedUsersArr, roomType);
                if (invitedUsersArr.length === 0 && existUsersArr.length > 0) {
                    var existUserNames = "", alertMsg = "";
                    for (var i = 0; i < existUsersArr.length; i++) {
                        if (i === 0) {
                            existUserNames = existUsersArr[i].name;
                        } else {
                            existUserNames = existUserNames + ',' + existUsersArr[i].name;
                        }
                    }
                    alertMsg = existUserNames + ' 已经存在, ';
                    layer.alert(alertMsg, {
                        title: '提示'
                        , shade: false
                    });
                }
            }
        }, function () {
            layer.alert('邀请好友失败', {
                title: '提示'
                , shade: false
            });
        });
    };


    var inviteUsersToGroup = function (groupId, invitedUsersArr, roomType, preLayerIndex, index) {
        var total = invitedUsersArr.length;
        var inviteIndex = index || 0;

        if (inviteIndex < invitedUsersArr.length) {
            var invitedUser = invitedUsersArr[inviteIndex];
            var jid = (invitedUser.id.indexOf("@") == -1) ? invitedUser.id + "@" + Chat.BOSH_SERVICE_HOST : invitedUser.id;
            var layerIndex = preLayerIndex || layer.open({
                time: 0
                ,
                type: 1
                ,
                area: ['300px', '150px']
                ,
                shadeClose: false
                ,
                shade: [0.3, '#393D49']
                ,
                closeBtn: 0
                ,
                content: '<progress max="' + total + '" value="0" id="invitePg" style="width:290px;margin-top:10px;margin-left:4px;"></progress><div id="inviteProgress" style="margin-left:4px;"><p>正在添加：<span id="invitedUserName"></span></p><p>已经添加人数：<span id="finishedUserCnt"></span></p><p>剩余人数：<span id="unfinishedCnt"></span></p>'
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
            });
            $('#invitedUserName').html(invitedUser.name);
            $('#finishedUserCnt').html(inviteIndex);
            $('#unfinishedCnt').html(invitedUsersArr.length - inviteIndex);
            $('#invitePg').attr('value', (inviteIndex));
            //群组设置为member，临时会话设置为admin(允许成员自由邀请其他人员)
            //var affiliation = (roomType != Chat.ROOM_TYPE_GROUP ? "admin" : "member");
            var affiliation = "admin";
            Chat.mucInvite(groupId, jid, function () {
            	$.post("./im/ImRoomController/addUserToGroup",{
                	'groupId':groupId,
                	'userId':jid,
                	'affiliation':affiliation
                },function(){
                	 var groupUserCountElem = $('div.layim-chat.layim-chat-group.layui-show span[data-id="' + groupId + '"] em');
                     if (groupUserCountElem && groupUserCountElem.length) {
                         var groupUserCountHtml = groupUserCountElem.html();
                         var groupUserCount = groupUserCountHtml.substring(0, groupUserCountHtml.length - 1);
                         if (groupUserCount) {
                             groupUserCountElem.html((parseInt(groupUserCount) + 1) + "人");
                         }
                     }
                     var nextIndex = inviteIndex + 1;
                     inviteUsersToGroup(groupId, invitedUsersArr, roomType, layerIndex, nextIndex);
            	});
            }, function () {
                if (layerIndex) {
                    layer.close(layerIndex);
                }
                layer.msg("添加失败！");
            });
        } else {
            if (preLayerIndex) {
                $('#inviteProgress').empty();
                $('#invitePg').attr('value', total);
                $('#inviteProgress').append($('<p>已成功添加' + total + '人</p>'));
                setTimeout(function () {
                    layer.close(preLayerIndex);
                }, 1000);
            }
        }
    };

    // 退出群组&临时会话
    var exitToGroup = function (groupId) {
        layer.open({
            type: 1
            , title: false //不显示标题栏
            , offset: 'exitToGroup'
            , id: 'exitToGroup' //防止重复弹出
            , content: '<div  style="height: 50px;text-align: center;line-height: 50px;padding: 10px;" >您确定要退出群聊吗</div>'
            , btnAlign: 'c' //按钮居中
            , shade: false
            , btn: ['<span layim-event="closeChat"  >退出</span>', '取消']
            , yes: function (openIndex, layero) {
                $.post("./im/XmppController/removeUserFromRoom", {
                    roomId: groupId,
                    userId: Chat.currentUser.id
                }, function (res) {
                    if(res && res.responseBody){
                        changeChat(null, 1);
                        $('li[data-id="' + groupId+'"').remove();
                        deletLocalStorageHistory(groupId);
                        $.post("./im/ImRoomController/removeUserFromGroup",{
                            groupId : groupId,
                            userId : Chat.currentUser.id
                        },function(){
                            layer.msg('退出成功');
                        });
                    } else {
                        layer.msg('退出失败');
                    }
                });

                $('#layui-layer' + openIndex).remove();
            }
        });
    };

    // 群主将成员移出群组&临时会话
    var removeUserFromGroup = function (groupId, userId, username) {
        layer.open({
            type: 1
            , title: false //不显示标题栏
            , offset: 'removeUserFromGroup'
            , id: 'removeUserFromGroup' //防止重复弹出
            , content: '<div  style="padding: 10px;height: 50px;text-align: center;line-height: 50px;" >您确定要把' + username + '移出群聊吗?</div>'
            , btnAlign: 'c' //按钮居中
            , shade: false
            , btn: ['移出', '取消']
            , yes: function (openIndex, layero) {
                // Chat.mucThrowOut(groupId, userId, function (res) {
                //     var groupUserCountElem = $('div.layim-chat.layim-chat-group.layui-show span[data-id="' + groupId + '"] em');
                //     if (groupUserCountElem && groupUserCountElem.length) {
                //         var groupUserCountHtml = groupUserCountElem.html();
                //         var groupUserCount = groupUserCountHtml.substring(0, groupUserCountHtml.length - 1) || 1;
                //         groupUserCountElem.html((groupUserCount - 1) + "人");
                //     }
                //     $.get("./im/ImRoomController/removeUserFromGroup", {
                //         groupId: groupId,
                //         userId: userId
                //     }, function () {
                //
                //     });
                // });
                $.post("./im/XmppController/removeUserFromRoom", {
                    roomId: groupId,
                    userId: userId
                }, function (res) {
                    if(res && res.responseBody) {
                        var groupUserCountElem = $('div.layim-chat.layim-chat-group.layui-show span[data-id="' + groupId + '"] em');
                        if (groupUserCountElem && groupUserCountElem.length) {
                            var groupUserCountHtml = groupUserCountElem.html();
                            var groupUserCount = groupUserCountHtml.substring(0, groupUserCountHtml.length - 1) || 1;
                            groupUserCountElem.html((groupUserCount - 1) + "人");
                        }
                        $.post("./im/ImRoomController/refreshGroup/" + groupId, {}, function () {
                            layer.msg('移出成功');
                        });
                    } else {
                        layer.msg('移出失败');
                    }

                });
                $('#layui-layer' + openIndex).remove();
            }
        });
    };

    // 解散群组--创建者
    var releaseGroup = function (groupId) {
        var thatChat = thisChat();
        var chatName = (thatChat && thatChat.data && thatChat.data.chatname) || '';
        layer.open({
            type: 1
            , title: false //不显示标题栏
            , offset: 'releaseGroup'
            , id: 'releaseGroup' //防止重复弹出
            , content: '<div  style="padding: 10px;height: 50px;text-align: center;line-height: 50px;" >您确定要解散群聊' + chatName + '吗</div>'
            , btnAlign: 'c' //按钮居中
            , btn: ['解散', '取消']
            , success: function (layero) {
                layero.on('contextmenu', function (event) {
                    event.cancelBubble = true;
                    event.returnValue = false;
                    return false;
                });
            }
            , yes: function (openIndex, layero) {
                layer.close(openIndex);
                var members = Chat.getRoomMembers(groupId);
                // 创建者最后移出
                for(var i = members.length - 1; i >= 0; i--){
                    $.ajax({
                        type: "Post", //Post传参
                        url: "./im/XmppController/removeUserFromRoom",//服务地址
                        data: {
                            roomId: groupId,
                            userId: members[i]
                        },//参数
                        dataType: "json",
                        async : false,
                        success: function (result) {
                        }
                    });
                }
                //解散群组后同步修改数据库数据
                $.post("./im/ImRoomController/dissolveRoom",{
                    roomId : groupId
                },function(){
                    changeChat(null, 1);
                    $('li[data-id="' + groupId+'"').remove();
                    deletLocalStorageHistory(groupId);
                    $('#layui-layer' + openIndex).remove();
                    layer.msg('解散成功！');
                });
            }
        });

    };

    // 刷新群组
    var refreshGroup = function (groupId) {
        $.post("./im/ImRoomController/refreshGroup/"+groupId, {}, function (result) {
            layer.closeAll('tips');
            layer.msg('刷新成功！');
        });
    };

    // 转让群--创建者转移
    var transferGroup = function (groupId, id, newId) {
        var jid = (id.indexOf("@") == -1) ? id + "@" + Chat.BOSH_SERVICE_HOST : id;
        var newJid = (newId.indexOf("@") == -1) ? newId + "@" + Chat.BOSH_SERVICE_HOST : newId;
        if (Chat.setRoomAffiliation(groupId, newJid, "owner")) {
            if (Chat.setRoomAffiliation(groupId, jid, "admin")) {
                $.post("./im/ImRoomController/transferGroup", {
                    groupId: groupId,
                    newJid: newJid,
                    jid: jid
                }, function () {
                    layer.msg("转让成功！");
                });
            } else {
                layer.msg("转让失败！");
            }
        } else {
            layer.msg("转让失败！");
        }
    };

    // 更新群组名称
    var updateGroupName = function (groupId,groupName) {
        //修改本地缓存中群组名称
        var cacheGroup;
        for(var i=0;i<cache.group.length;i++) {
            if(cache.group[i].id === groupId){
                cacheGroup = cache.group[i];
                if(cacheGroup.chatname == groupName){
                    return;
                } else {
                    cacheGroup.chatname = groupName;
                    cacheGroup.groupname = groupName;
                    cacheGroup.name = groupName;
                }
                break;
            }
        }

        if(cacheGroup){
            // 【群组】Tab群组名称更新
            $('ul.layim-list-group li[data-id="'+groupId+'"]').find('>span').html(groupName);
            // 【历史会话】Tab群组名称更新
            $('ul.layim-list-history li[data-id="'+groupId+'"]').find('>span').html(groupName);
            // 聊天窗口上方群组名称更新
            $('span.layim-chat-username[data-id="'+groupId+'"]').find('>span').html(groupName);
            // 聊天窗口左侧Tab群组名称更新
            $('#layui-layim-chat .layim-group'+groupId).find('>span').html(groupName);
        }

        var roomObj = Chat.getRoomInfoById(groupId);
        if(roomObj){
            roomObj.chatname = groupName;
            roomObj.groupname = groupName;
            roomObj.name = groupName;
        }
    };

    //删除本地存储的历史记录
    var deletLocalStorageHistory = function (id) {
        var nickname = Chat.currentUser.jid.split("@")[0];
        var data = JSON.parse(localStorage.layim);
        for (var key in data) {
            if (nickname == key) {
                var history = data[key];
                if (history && history.history) {
                    var historyData = history.history;
                    for (var userId in historyData) {
                        if (historyData[userId].id == id) {
                            delete historyData[userId];
                        }
                    }
                    data[key].history = historyData;
                    localStorage.setItem("layim", JSON.stringify(data));
                }
            }
        }
    };
    var stope = layui.stope; //组件事件冒泡

    //在焦点处插入内容
    var focusInsert = function (obj, str) {
        var result, val = obj.value;
        obj.focus();
        if (document.selection) { //ie
            result = document.selection.createRange();
            document.selection.empty();
            result.text = str;
        } else {
            result = [val.substring(0, obj.selectionStart), str, val.substr(obj.selectionEnd)];
            obj.focus();
            obj.value = result.join('');
        }
    };

    //在url前添加host信息
    var addHostToUrl = function (url) {
        if (url) {
            try {
                var reUrl = url.substring(url.indexOf('/imUploadController'), url.length)
                var rootPath = getRootPath();
                return rootPath + reUrl;
            } catch (e) {
                return url
            }
        }
        return url;
    };

    var getRootPath = function () {
        //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
        var curWwwPath = window.document.location.href;
        //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
        var pathName = window.document.location.pathname;
        var pos = curWwwPath.indexOf(pathName);
        //获取主机地址，如： http://localhost:8083
        var localhostPaht = curWwwPath.substring(0, pos);
        //获取带"/"的项目名，如：/uimcardprj
        var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
        return localhostPaht + projectName;
    };
    //重新排序历史记录、最新的聊天记录放在第一位
    var sortHistoryChat = function(data){
  	    var hisElem = layimMain.find('.layim-list-history');
  	    var x = hisElem.find('#' + data.id);
  	    if(x && x.length){
  	        x.remove();
            //先删除本地记录缓存，再存储
            deletLocalStorageHistory(data.id);
            hisElem.prepend(x);
            setHistory(data);
        } else {
  	        if(data.type == 'friend') {
                setHistory(data);
            } else {
                var roomObj = Chat.getRoomInfoById(data.id);
                if(roomObj){
                    data.temporary = roomObj.temporary;
                } else {
                    $.ajax({
                        type: "Post", //Post传参
                        url: "./im/ImRoomController/getImRoomById/" + data.id,//服务地址
                        data: {name: 'xx'},//参数
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        async : false,
                        success: function (result) {
                            data.temporary = (result.roomType != Chat.ROOM_TYPE_GROUP);
                            data.chatname = data.groupname = result.roomName;
                        }
                    });
                }
                setHistory(data);
            }
        }
    };
    //发送消息失败时
    var sendMsgFail = function(peerId, msguniqueid, errorCode){
        var thatChat = thisChat();
        if(thatChat && peerId == thatChat.data.id){
            var li = thatChat.elem.find('div.layim-chat-main > ul > li[data-msguniqueid="'+msguniqueid+'"]');
            if(li){
                var failedContent = li.find('div.layim-chat-text').html();
                thatChat.textarea.val(failedContent);
                li.remove();
            }
            if(Chat.errMsg[errorCode]){
                layer.msg(Chat.errMsg[errorCode]);
            } else {
                layer.msg('消息发送失败');
            }

            //先删除本地缓存的失败记录
            var local = layui.data('layim')[cache.mine.id] || {};
            local.chatlog = local.chatlog || {};
            var thisChatlog = local.chatlog['group' + peerId];
            if (thisChatlog) {
                for (var i = thisChatlog.length - 1; i >= 0; i--) {
                    var item = thisChatlog[i];
                    if(msguniqueid == item.msguniqueid){
                        thisChatlog.splice(i, 1);
                        break;
                    }
                }
                layui.data('layim', {
                    key: cache.mine.id
                    , value: local
                });
            }
        }
    };
    //事件
    var anim = 'layui-anim-upbit', events = {
        //在线状态
        status: function (othis, e) {
            var hide = function () {
                othis.next().hide().removeClass(anim);
            };
            var type = othis.attr('lay-type');
            if (type === 'show') {
                stope(e);
                othis.next().show().addClass(anim);
                $(document).off('click', hide).on('click', hide);
            } else {
                var prev = othis.parent().prev();
                othis.addClass(THIS).siblings().removeClass(THIS);
                prev.html(othis.find('cite').html());
                prev.removeClass('layim-status-' + (type === 'online' ? 'hide' : 'online'))
                    .addClass('layim-status-' + type);
                layui.each(call.online, function (index, item) {
                    item && item(type);
                });
            }
        }

        //编辑签名
        , sign: function () {
            var input = layimMain.find('.layui-layim-remark');
            input.on('change', function () {
                var value = this.value;
                layui.each(call.sign, function (index, item) {
                    item && item(value);
                });
            });
            input.on('keyup', function (e) {
                var keyCode = e.keyCode;
                if (keyCode === 13) {
                    this.blur();
                }
            });
        }

        //大分组切换
        , tab: function (othis) {
            layer.closeAll('tips'); //关闭所有的tips层
            var index, main = '.layim-tab-content';
            var tabs = layimMain.find('.layui-layim-tab>li');
            typeof othis === 'number' ? (
                index = othis
                    , othis = tabs.eq(index)
            ) : (
                index = othis.index()
            );
            index > 2 ? tabs.removeClass(THIS) : (
                events.tab.index = index
                    , othis.addClass(THIS).siblings().removeClass(THIS)
            )
            layimMain.find(main).eq(index).addClass(SHOW).siblings(main).removeClass(SHOW);
        }

        //展开联系人分组
        , spread: function (othis) {
            var type = othis.attr('lay-type');
            var spread = type === 'true' ? 'false' : 'true';
            var local = layui.data('layim')[cache.mine.id] || {};
            othis.next()[type === 'true' ? 'removeClass' : 'addClass'](SHOW);
            local['spread' + othis.parent().index()] = spread;
            layui.data('layim', {
                key: cache.mine.id
                , value: local
            });
            othis.attr('lay-type', spread);
            othis.find('.layui-icon').html(spread === 'true' ? '&#xe61a;' : '&#xe602;');

            //Chat.log(othis.next(), '---------------next-----------');
            //重新计算在线人数
            if(Chat.showOnlineCnt && othis.data('nodetype') != 'favoriteGroup'){
                var orgDeptId = othis.data('id') || '';
                var orgDept = Chat.getOrgDeptFromRoot(orgDeptId);
                var totalOnlineCnt = orgDept.onlineCount;
                othis.find('p.onlinecount').html(totalOnlineCnt);
            }
            if (spread == 'true') {
                Chat.openUserTree(othis);
            }
        }

        //搜索
        , search: function (othis) {
            var search = layimMain.find('.layui-layim-search');
            var main = layimMain.find('#layui-layim-search');
            var input = search.find('input'), find = function (e) {
                var val = input.val().toLowerCase().replace(/\s/);
                if (val === '') {
                    events.tab(events.tab.index | 0);
                } else {
                    var data = [], friend = cache.friend || [];
                    var group = cache.group || [], html = '';
                    for (var i = 0; i < friend.length; i++) {
                        for (var k = 0; k < (friend[i].list || []).length; k++) {
                            if (friend[i].list[k].username.indexOf(val) !== -1 || friend[i].list[k].id.indexOf(val) !== -1) {
                                friend[i].list[k].type = 'friend';
                                friend[i].list[k].index = k;
                                friend[i].list[k].list = k;
                                data.push(friend[i].list[k]);
                            }
                        }
                    }
                    for (var j = 0; j < group.length; j++) {
                        if (group[j].groupname.indexOf(val) !== -1) {
                            group[j].type = 'group';
                            group[j].index = j;
                            group[j].list = j;
                            data.push(group[j]);
                        }
                    }
                    if (data.length > 0) {
                        for (var l = 0; l < data.length; l++) {
                            var searchd = data[l];
                            if (searchd.deptOrgs && searchd.deptOrgs.length > 0) {
                                html += '<li layim-event="chat" data-id="' + searchd.id + '" data-type="' + searchd.type + '" data-index="' + searchd.index + '" data-list="' + searchd.list + '" title="' + layui.data.joinDeptOrgs(searchd) + '">';
                            } else {
                                html += '<li layim-event="chat" data-id="' + searchd.id + '" data-type="' + searchd.type + '" data-index="' + searchd.index + '" data-list="' + searchd.list + '">';
                            }
                            if (searchd.type === "group" && !searchd.temporary) {
                                html += '<img  src="' + CONST_IMAGE_ICON_ROOT_URL + 'avatar_group.jpg\">';
                            }
                            if (searchd.type === "group" && searchd.temporary) {
                                html += '<img  src="' + CONST_IMAGE_ICON_ROOT_URL + 'tem.png\">';
                            }
                            if (searchd.type === "friend") {
                                html += '<img src="' + searchd.avatar + '"   class="layim-friend' + searchd.id + ' ' + (searchd.status === "offline" ? "layim-list-gray" : " ") + '" >';
                            }
                            html += '<span>' + (searchd.username || searchd.groupname || '佚名') + '</span>';
                            html +=  '<p>';
                            if(searchd.status == "online"){
                                html += '<i class="layui-icon layim-chat-status layim-chat-status-online" data-id="'+searchd.id+'" title="在线"></i>';
                            } else if(searchd.status == "offline"){
                                html += '<i class="layui-icon layim-chat-status layim-chat-status-offline" data-id="'+searchd.id+'" title="离线"></i>';
                            }
                            html +=  (searchd.positionName || searchd.remark || searchd.sign || '')+'</p></li>';
                        }
                    } else {
                        html = '<li class="layim-null">无搜索结果</li>';
                    }
                    main.html(html);
                    events.tab(3);
                }
            };
            if (!cache.base.isfriend && cache.base.isgroup) {
                events.tab.index = 1;
            } else if (!cache.base.isfriend && !cache.base.isgroup) {
                events.tab.index = 2;
            }
            search.show();
            input.focus();
            input.off('keyup');
            input.on('keyup', function (event) {
                if(event.keyCode == 13) {
                    find();
                }
            });
        }

        //关闭搜索
        , closeSearch: function (othis) {
            othis.parent().hide();
            events.tab(events.tab.index | 0);
        }
        //清空搜索框内容
        , cleanSearch: function (othis) {
            var input = othis.parent().find('input');
            input.val('');
            if (input && input.keyup) {
                input.keyup();
            }
        }
        //设置
        , setting: function () {
            layer.open({
                type: 2
                , title: "设置"
                , shade: [0.3, '#393D49']
                , shadeClose: false
                , maxmin: false
                , area: ['600px', '550px']
                , skin: 'layui-box layui-layer-border'
                , content: cache.base.setting+'?v='+(new Date().getTime())
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
            });
        }
        //消息盒子
        , msgbox: function () {
            var msgboxElem = layimMain.find('.layim-tool-msgbox');
            layer.close(events.msgbox.index);
            msgboxElem.find('span').removeClass(ANIM_MSG).html('');
            return events.msgbox.index = layer.open({
                type: 2
                , title: '消息盒子'
                , shade: [0.3, '#393D49']
                , shadeClose: false
                , maxmin: false
                , area: ['800px', '600px']
                , skin: 'layui-box layui-layer-border'
                , id: 'layui-layim-chatlog'
                , resize: false
                , content: cache.base.msgbox+'?searchKind=all&v='+(new Date().getTime())
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }

            });
        }

        //弹出查找页面
        , find: function () {
            /*layer.close(events.find.index);
        layer.open({
            type: 2,
            title: "查找",
            skin: 'layui-layer-rim',
            area: ['610px', '500px'],
            content: layui.cache.dir + 'css/modules/layim/html/findfriend.html'*/


            //查找好友  注掉下面的代码，放开上面的代码
            layer.prompt({
                title: '请输入好友名称'
                , shade: false
            }, function (name, index) {
                if (!name || name == "") {
                    return;
                }
                var jid = (name.indexOf("@") == -1) ? name + "@" + Chat.BOSH_SERVICE_HOST : name;
                var username = jid;
                if (Chat.userExists(jid)) {
                    layer.alert('该用户已是你的好友，不能重复添加', {
                        title: '提示'
                        , shade: false
                    });
                    return;
                }
                Chat.subscribeUser(jid, '');
                layer.alert('请求好友成功，请等待好友审核', {
                    title: '提示'
                    , shade: false
                });
                layer.close(index);
//TODO: 先判断用户是否存在
//    	Chat.checkIsUserRegistered(jid,
//    		function(isExists) {
//    			if(isExists) {
//    			    //Chat.addUser(jid, username, false);
//					Chat.subscribeUser(jid, '');
//					layer.alert('请求好友成功，请等待好友审核', {
//							title: '提示'
//							,shade: false
//					});
//    			}else {
//    				layer.alert('该用户尚未注册，不能添加为好友', {
//						title: '提示'
//						,shade: false
//					  });
//					  return;
//    			}
//      		layer.close(index);
//    		}
//    	);

            });

//    layer.close(events.find.index);
//    return events.find.index = layer.open({
//      type: 2
//      ,title: '查找'
//      ,shade: false
//      ,maxmin: true
//      ,area: ['1000px', '520px']
//      ,skin: 'layui-box layui-layer-border'
//      ,resize: false
//      ,content: cache.base.find
//    });
        }

        , refresh: function () {
            refreshAllStatus(function(){
            	layer.msg('刷新成功', {
                    time: 1000, //1s后自动关闭
                },function(){
                    setTimeout(
                        function () {
                            $('.layim-tool-refresh').show();
                        }, 20000
                    );
                });
            });
        }

        //弹出添加群组
        , findgroup: function () {

            layer.prompt({
                title: '请输入群组名称'
                , shade: false
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
            }, function (name, index) {
                if (!name || name == "") {
                    return;
                }
                var jid = (name.indexOf("@") == -1) ? name + "@conference." + Chat.BOSH_SERVICE_HOST : name;
                var nickname = Chat.currentUser.jid.split("@")[0];
                //Chat.addUser(jid, username, false);

                $.post("./im/ImRoomController/saveImRoom/0", {roomName: name,currentUser:nickname}, function (result1) {
                    var imRoom = result1.imRoom;
                    layui.layim.chat({
                        name: imRoom.id
                        , temporary: true
                        , type: 'group' //群组类型
                        , avatar: CONST_IMAGE_ICON_ROOT_URL + "avatar_group.jpg"
                        , id: imRoom.id //定义唯一的id方便你处理信息
                        , members: 0 //成员数，不好获取的话，可以设置为0
                    });
                    Chat.mucInvite(imRoom.id, Chat.currentUser.jid);
                });
                layer.close(index);
            });
        }
        //弹出更换背景
        , skin: function () {
            layer.open({
                type: 1
                , title: '更换背景'
                , shade: false
                , area: '300px'
                , skin: 'layui-box layui-layer-border'
                , id: 'layui-layim-skin'
                , zIndex: 66666666
                , resize: false
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
                , content: laytpl(elemSkinTpl).render({
                    skin: cache.base.skin
                })
            });
        }

        //关于
        , about: function () {
            layer.alert('版本： ' + v + '<br>版权所有：<a href="http://layim.layui.com" target="_blank">layim.layui.com</a>', {
                title: '关于 LayIM'
                , shade: false
            });
        }

        //生成换肤
        , setSkin: function (othis) {
            var src = othis.attr('src');
            var local = layui.data('layim')[cache.mine.id] || {};
            local.skin = src;
            if (!src) delete local.skin;
            layui.data('layim', {
                key: cache.mine.id
                , value: local
            });
            try {
                layimMain.css({
                    'background-image': src ? 'url(' + src + ')' : 'none'
                });
                layimChat.css({
                    'background-image': src ? 'url(' + src + ')' : 'none'
                });
            } catch (e) {
            }
            layui.each(call.setSkin, function (index, item) {
                var filename = (src || '').replace(layui.cache.dir + 'css/modules/layim/skin/', '');
                item && item(filename, src);
            });
        }

        //弹出聊天面板
        , chat: function (othis) {
            layer.closeAll('tips');
            var local = layui.data('layim')[cache.mine.id] || {};
            var type = othis.data('type'), index = othis.data('index');
            var list = othis.attr('data-list') || othis.attr('data-index') || othis.index(), data = {};

            if (type === 'friend') {
                // 如果是多级通讯录，索引方法不同
                if (Chat.ROSTER_TYPE === CONST_ROSTER_TYPE_MULTIPLE) {
                    list = index;
                    index = 0;
                }
                data = cache[type][index].list[list];
            } else if (type === 'group') {
                data = cache[type][list];
            } else if (type === 'history') {
                data = (local.history || {})[index] || {};
            }
            data.name = data.name || data.username || data.groupname;
            if (type !== 'history') {
                data.type = type;
            }
            popchat(data, true);
        }

        //切换聊天
        , tabChat: function (othis) {
            changeChat(othis);
        }

        //关闭聊天列表
        , closeChat: function (othis, e) {
            changeChat(othis.parent(), 1);
            stope(e);
        }, closeThisChat: function () {
            changeChat(null, 1);
        }

        //展开群组成员
        , groupMembers: function (othis, e) {
            var icon = othis.find('.layui-icon'), hide = function () {
                icon.html('&#xe61a;');
                othis.data('down', null);
                layer.close(events.groupMembers.index);
            }, stopmp = function (e) {
                stope(e)
            };
            if (othis.data('down')) {
                hide();
            } else {
                icon.html('&#xe619;');
                othis.data('down', true);
                events.groupMembers.index = layer.tips('<ul class="layim-members-list"></ul>', othis, {
                    tips: 3
                    , time: 0
                    , anim: 5
                    , fixed: true
                    , skin: 'layui-box layui-layim-members'
                    , success: function (layero) {
                        var members = cache.base.members || {}, thatChat = thisChat()
                            , ul = layero.find('.layim-members-list'), li = '', membersCache = {}
                            , hasFull = layimChat.find('.layui-layer-max-org').hasClass('layui-layer-max-orgmin')
                            , listNone = layimChat.find('.layim-chat-list').css('display') === 'none';
                        if (hasFull) {
                            ul.css({
                                width: $(window).width() - 22 - (listNone || 200)
                            });
                        }
                        members.data = $.extend(members.data, {
                            id: thatChat.data.id
                        });

                        var nickname = Chat.currentUser.jid.split("@")[0];
                        var groupId = $(othis).data("id");
                        $.get("./im/ImRoomController/getImRoomById/" + groupId, function (result) {
                        	if(!result.members){
                                layer.closeAll('tips');
                                //移除历史会话 && 关闭聊天
                                changeChat(null, 1);
                                $(".layim-group" + groupId).remove();
                                deletLocalStorageHistory(groupId);
                                layer.msg("该群已经解散！");
                        		return;
                        	}
                        	var roomType = result.roomType;
                        	var membersIdArr = result.members.split(",");
                        	var creatorUser = result.creator.split(',');
                        	
                        	//获取当前聊天室的管理员
                        	var adminUserName = '';
                        	layui.each(creatorUser, function (i, userId) {
                        		adminUserName = userId;
                        		return false;
                        	});
                        	//判断是否在聊天室
                        	var existInGroup = false;
                        	layui.each(membersIdArr, function (i, userId) {
                        		if (userId == nickname) {
                        			existInGroup = true;
                        			return false;
                        		}
                        	});	
                        								
                        	if (!existInGroup) {
                        		layer.closeAll('tips');
                        		//移除历史会话 && 关闭聊天
                        		changeChat(null, 1);
                        		$(".layim-group" + groupId).remove();
                        		deletLocalStorageHistory(groupId);
                        		layer.msg("您已经退出该群！");
                        		return;
                        	}
                        	
                        	var memberGroups = [];
                        	$.each(membersIdArr,function(i,e){
                        	    var user = Chat.getUserInfoById(e);
                        		if(user){
                        			memberGroups.push(user);
                        		}
                        	});

                        	//把管理排到第一个,在线的放在前面，不在线的放在后面
                        	memberGroups.sort(function (sortA, sortB) {
                        		if (sortA.id === adminUserName) {
                        			return -100000;
                        		} else if (sortB.id === adminUserName) {
                        			return 100000;
                        		} else if (sortA.status === sortB.status) {
                        			return sortA.id.localeCompare(sortB.id);
                        		} else {
                        			return sortB.status.localeCompare(sortA.status);
                        		}
                        	});

                        	layui.each(memberGroups, function (index, item) {
                        		var deletUser = "";
                        		if (roomType == Chat.ROOM_TYPE_GROUP) {
                        			//只有群主能够添加或移出成员
                        			if (nickname === adminUserName && item.id != adminUserName) {
                        				deletUser = '<span data-type="exit" data-uid="' + item.id + '" data-uname="' + item.username + '" style="position: absolute;right: 13px;padding: 1px 1px;background-color: #fff;color: #333;cursor: pointer;z-index:99" class="badge" title="移出"><i class="layui-icon" >&#x1006;</i></span>';
                        			}
                        			//右上角加上群主标示
                        			if (item.id === adminUserName) {
                        				deletUser = '<span data-uid="' + item.id + '" data-uname="' + item.username + '" style="position: absolute;right: 13px;padding: 1px 1px;background-color: #fff;color: #333;cursor: pointer;z-index:99" class="badge" title="群主"><img style="height: 16px;width: 16px;" src="' + CONST_IMAGE_ICON_ROOT_URL + 'admin.png"/></span>';
                        			}
                        		}
                        		var grayClass = " ";
                        		if (item.status == "offline") {
                        			grayClass = "layim-list-gray";
                        		}
                        		li += '<li data-uid="' + item.id + '" data-uname="' + item.username + '" data-index="' + index + '" data-index="' + index + '" title="' + layui.data.joinDeptOrgs(item) + '" data-type="open" style="position: relative;" >' + deletUser + '<a  href="javascript:;"><img src="' + item.avatar + '" class="' + grayClass + '"><cite>' + item.username + '</cite></a></li>';
                        		membersCache[item.id] = item;
                        	});

                        	if (roomType == Chat.ROOM_TYPE_GROUP) {
                        		//只有群主能够添加成员
                        		if (adminUserName === nickname) {
                        			//添加成员按钮
                        			li += '<li data-uid="" data-type="add"><img src="' + CONST_IMAGE_ICON_ROOT_URL + 'add.png"/><cite style="display: block;" >添加成员</cite></li>';
                        			li += '<li data-uid="" data-type="release" ><img src="' + CONST_IMAGE_ICON_ROOT_URL + 'release.png"/><cite style="display: block;" >解散群聊</cite></li>';
                        		} else {

                        			li += '<li data-uid="" data-type="exit" ><img src="' + CONST_IMAGE_ICON_ROOT_URL + 'exit.png"/><cite style="display: block;" >退出群聊</cite></li>';
                        		}
                        	} else {
                        		//添加成员按钮
                        		li += '<li data-uid="" data-type="add"><img src="' + CONST_IMAGE_ICON_ROOT_URL + 'add.png"/><cite style="display: block;" >添加成员</cite></li>';
                        		li += '<li data-uid="" data-type="exit" ><img src="' + CONST_IMAGE_ICON_ROOT_URL + 'exit.png"/><cite style="display: block;" >退出临时会话</cite></li>';
                        	}
                        	li += '<li data-uid="" data-type="refresh" ><img src="' + CONST_IMAGE_ICON_ROOT_URL + 'refresh.png"/><cite style="display: block;" >刷新群组</cite></li>';
                        	ul.html(li);

                        	//获取群员数
                        	othis.find('.layim-chat-members').html(memberGroups.length + '人');

                        	//私聊
                        	ul.find('li').on('click', function () {
                        		var uid = $(this).data('uid');
                        		if (uid) {
                        			info = membersCache[uid];
                        			popchat({
                        				name: $.trim(info.username)
                        				, type: 'friend'
                        				, avatar: info.avatar
                        				, id: $.trim(info.id)
                        				, deptOrgs: info.deptOrgs
                        				, status: info.status
                        			}, true);
                        		} else {
                        			var clickType = $(this).data('type');
                        			if (clickType == 'add') {
                        				selectUserIds=memberGroups;
                        				inviteToGroup(members.data.id,roomType,memberGroups);
                        			} else if (clickType == 'exit') {
                        				exitToGroup(members.data.id);
                        			} else if (clickType == 'release') {
                        				releaseGroup(members.data.id);
                        			} else if (clickType == 'refresh') {
                        				refreshGroup(members.data.id);
                        			}
                        		}
                        		hide();
                        	});

                        	ul.find('li').find('span').on('click', function (e) {
                        		e.stopPropagation();
                        		var uid = $(this).data('uid');
                        		var username = $(this).data('uname');
                        		var type = $(this).data('type');
                        		if (uid && type && type === "exit") {
                                    removeUserFromGroup(members.data.id, uid, username);
                        		}
                        	});

                        	layui.each(call.members, function (index, item) {
                        		item && item(res);
                        	});

                        	layero.on('mousedown', function (e) {
                        		stope(e);
                        	});
                        });

                        layero.on('contextmenu', function (event) {
                            event.cancelBubble = true;
                            event.returnValue = false;
                            return false;
                        });

                        layero.find('.layim-members-list').on('contextmenu', 'li', function (e) {
                            var hide1 = function () {
                                layer.closeAll('tips');
                            };

                            var obj = $(e.currentTarget)[0];
                            if ($(obj).data("type") == "add" || $(obj).data("type") == "exit") {
                                return;
                            }
                            var id = $(obj).data("uid");

                            var html = '';
                            var adminSpan = $('.layim-members-list span[title="群主"]');
                            var adminUserId = adminSpan && adminSpan.length && adminSpan.data("uid");
                            html += '<ul id="members_contextmenu_' + id + '" data-id="' + id + '" data-index="' + $(obj).data('index') + '">';
                            html += '<li layim-event="menu_profile" data-id="' + id + '" data-uname="' + $(obj).data("uname") + '">查看资料</li>';
                            if (adminUserId == Chat.currentUser.id && adminUserId != id) {
                                html += '<li layim-event="transfer_group" data-adminid="' + adminUserId + '"  data-id="' + id + '"  data-uname="' + $(obj).data("uname") + '">转让群</li>';
                            }
                            html += '</ul>';

                            layer.tips(html, this, {
                                tips: 1
                                , time: 0
                                , anim: 5
                                , fixed: true
                                , shade: [0.3, '#393D49']
                                , shadeClose: true
                                , tipsMore: true
                                , skin: 'layui-box layui-layim-contextmenu'
                                , success: function (layero) {
                                    var stopmp = function (e) {
                                        stope(e);
                                    };
                                    layero.on('contextmenu', function (event) {
                                        event.cancelBubble = true;
                                        event.returnValue = false;
                                        return false;
                                    });
                                    layero.off('mousedown', stopmp).on('mousedown', stopmp);
                                    var layerobj = $("#members_contextmenu_" + id).parent(".layui-layim-contextmenu");
                                    resetposition(layerobj);
                                }
                            });
                            $(document).off('mousedown', hide).on('mousedown', hide);
                            $(window).off('resize', hide).on('resize', hide);
                            ul.off('mousedown', stopmp).on('mousedown', stopmp);
                        });
                    }
                });
                $(document).off('mousedown', hide).on('mousedown', hide);
                $(window).off('resize', hide).on('resize', hide);
                othis.off('mousedown', stopmp).on('mousedown', stopmp);
            }
        }

        //发送聊天内容
        , send: function () {
            sendMessage();
        }

        //设置发送聊天快捷键
        , setSend: function (othis, e) {
            var box = events.setSend.box = othis.siblings('.layim-menu-box')
                , type = othis.attr('lay-type');

            if (type === 'show') {
                stope(e);
                box.show().addClass(anim);
                $(document).off('click', events.setSendHide).on('click', events.setSendHide);
            } else {
                othis.addClass(THIS).siblings().removeClass(THIS);
                var local = layui.data('layim')[cache.mine.id] || {};
                local.sendHotKey = type;
                layui.data('layim', {
                    key: cache.mine.id
                    , value: local
                });
                events.setSendHide(e, othis.parent());
            }
        }, setSendHide: function (e, box) {
            (box || events.setSend.box).hide().removeClass(anim);
        }

        //表情
        , face: function (othis, e) {
            var content = '', thatChat = thisChat();

            for (var key in faces) {
                content += '<li title="' + key + '"><img src="' + faces[key] + '"></li>';
            }
            content = '<ul class="layui-clear layim-face-list">' + content + '</ul>';

            events.face.index = layer.tips(content, othis, {
                tips: 1
                , time: 0
                , fixed: true
                , skin: 'layui-box layui-layim-face'
                , success: function (layero) {
                    layero.find('.layim-face-list>li').on('mousedown', function (e) {
                        stope(e);
                    }).on('click', function () {
                        focusInsert(thatChat.textarea[0], 'face' + this.title + ' ');
                        layer.close(events.face.index);
                    });
                }
            });

            $(document).off('mousedown', events.faceHide).on('mousedown', events.faceHide);
            $(window).off('resize', events.faceHide).on('resize', events.faceHide);
            stope(e);

        }, faceHide: function () {
            layer.close(events.face.index);
        }

        , image: function (othis) {
            var thatChat = thisChat();
            var fileType = othis.data('type') || 'images';
            layer.close(events.image.index);
            events.image.index = layer.open({
                type: 2
                , title: '发送' + (fileType === 'images' ? '图片' : '文件') + '给 ' + thatChat.data.chatname + ''
                , area: ['800px', '65%']
                , shade: [0.3, '#393D49']
                , skin: 'bs-modal'// bootstrap 风格皮肤 需加载skin
                , maxmin: false //开启最大化最小化按钮maxmin
                , offset: 'center'
                , anim: 2
                , id: 'layui-layim-fileupload'
                , closeBtn: 1
                , shadeClose: false
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
                , content: cache.base.fileuploadPage + '?fileType=' + fileType
            });
            //layer.full(events.image.index);
            return events.image.index;
        }

        //音频和视频
        , media: function (othis) {
            var type = othis.data('type'), text = {
                audio: '音频'
                , video: '视频'
            }, thatChat = thisChat()

            layer.prompt({
                title: '请输入网络' + text[type] + '地址'
                , shade: false
                , offset: [
                    othis.offset().top - $(window).scrollTop() - 158 + 'px'
                    , othis.offset().left + 'px'
                ]
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
            }, function (src, index) {
                focusInsert(thatChat.textarea[0], type + '[' + src + ']');
                sendMessage();
                layer.close(index);
            });
        }

        //扩展工具栏
        , extend: function (othis) {
            var filter = othis.attr('lay-filter')
                , thatChat = thisChat();

            layui.each(call['tool(' + filter + ')'], function (index, item) {
                item && item.call(othis, function (content) {
                    focusInsert(thatChat.textarea[0], content);
                }, sendMessage, thatChat);
            });
        }

        //播放音频
        , playAudio: function (othis) {
            var audioData = othis.data('audio')
                , audio = audioData || document.createElement('audio')
                , pause = function () {
                audio.pause();
                othis.removeAttr('status');
                othis.find('i').html('&#xe652;');
            };
            if (othis.data('error')) {
                return layer.msg('播放音频源异常');
            }
            if (!audio.play) {
                return layer.msg('您的浏览器不支持audio');
            }
            if (othis.attr('status')) {
                pause();
            } else {
                audioData || (audio.src = othis.data('src'));
                audio.play();
                othis.attr('status', 'pause');
                othis.data('audio', audio);
                othis.find('i').html('&#xe651;');
                //播放结束
                audio.onended = function () {
                    pause();
                };
                //播放异常
                audio.onerror = function () {
                    layer.msg('播放音频源异常');
                    othis.data('error', true);
                    pause();
                };
            }
        }

        //播放视频
        , playVideo: function (othis) {
            var videoData = othis.data('src')
                , video = document.createElement('video');
            if (!video.play) {
                return layer.msg('您的浏览器不支持video');
            }
            layer.close(events.playVideo.index);
            events.playVideo.index = layer.open({
                type: 1
                ,
                title: '播放视频'
                ,
                area: ['460px', '300px']
                ,
                maxmin: true
                ,
                shade: false
                ,
                content: '<div style="background-color: #000; height: 100%;"><video style="position: absolute; width: 100%; height: 100%;" src="' + videoData + '" loop="loop" autoplay="autoplay"></video></div>'
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
            });
        }

        //聊天记录
        , chatLog: function (othis) {
            var thatChat = thisChat();
            if (!cache.base.chatLog) {
                return layer.msg('未开启更多聊天记录');
            }
            layer.close(events.chatLog.index);

            if('group' == thatChat.data.type){
                // 是否能查看聊天记录， 解决退出或者被踢出还能查看聊天记录
                var roomMembers = Chat.getRoomMembers(thatChat.data.id);
                if(roomMembers && $.inArray(Chat.currentUser.id, roomMembers) >= 0){
                    events.chatLog.index = openChatHistoryPage(thatChat.data.chatname,thatChat.data.id,thatChat.data.type);
                } else {
                    layer.msg(Chat.errMsg['603']);
                }
            } else {
                events.chatLog.index = openChatHistoryPage(thatChat.data.chatname,thatChat.data.id,thatChat.data.type);
            }

        }
        //右键点击的聊天记录
        , chatLogs: function (othis) {
            var thatChat = othis;
            if (!cache.base.chatLog) {
                return layer.msg('未开启更多聊天记录');
            }
            layer.close(events.chatLog.index);
            return events.chatLog.index = layer.open({
                type: 2
                , maxmin: true
                , title: '与 ' + thatChat.context.innerText + ' 的聊天记录'
                , area: ['450px', '100%']
                , shade: false
                , offset: 'rb'
                , skin: 'layui-box'
                , anim: 2
                , id: 'layui-layim-chatlog'
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
                , content: cache.base.chatLog + '?id=' + thatChat.data.id + '&type=' + thatChat.data.type
            });
        }
        //历史会话右键菜单操作
        , menuHistory: function (othis, e) {
            var local = layui.data('layim')[cache.mine.id] || {};
            var parent = othis.parent(), type = othis.data('type');
            var hisElem = layimMain.find('.layim-list-history');
            var none = '<li class="layim-null">暂无历史会话</li>'
            //移除个人会话
            if (type === 'one') {
                var history = local.history;
                delete history[parent.data('index')];
                local.history = history;
                layui.data('layim', {
                    key: cache.mine.id
                    , value: local
                });
//                hisElem.find('li.layim-group' + parent.data('id')).remove();
                //群组、临时和个人会话都有ID
                //根据会话ID移除
                hisElem.find('#' + parent.data('id')).remove();
                /*$('div.layui-layim-chat ul.layim-chat-list li.layim-group' + parent.data('id')).remove();
                if (hisElem.find('li').length === 0) {
                    hisElem.html(none);
                }*/
            } 
            //移除群组会话
            else if (type === 'all') {
                delete local.history;
                layui.data('layim', {
                    key: cache.mine.id
                    , value: local
                });
                hisElem.html(none);
            }

            layer.closeAll('tips');
        }
        //右键退出群聊
        , exitGroup: function (othis, e) {
            var parent = othis.parent();
            var dataset = parent[0].dataset;
            var groupId = dataset.id;
            exitToGroup(groupId);
        }
        //右键重命名群聊
        , renameGroup: function (othis, e) {
            var parent = othis.parent();
            var dataset = parent[0].dataset;
            var groupId = dataset.id;
            var groupname = dataset.groupname;
            layer.open({
                id: 1,
                type: 1,
                title: '重命名群组',
                skin: 'layui-layer-rim',
                area: ['450px', 'auto'],
                content: ' <div class="row" style="width: 420px;  margin-left:7px; margin-top:10px;">'
                    + '<div class="col-sm-12" style="line-height:30px;">'
                    + '<div class="input-group">'
                    + '<span class="input-group-addon">原群组名称:</span>'
                    + '<div class="layui-input-inline" style="padding-left: 12px; padding-top: 5px;">'
                    + groupname
                    + '</div>'
                    + '</div>'
                    + '</div>'
                    + '<div class="col-sm-12" style="margin-top:9px;">'
                    + '<div class="input-group">'
                    + '<span class="input-group-addon">新群组名称:</span>'
                    + '<input type="input" class="form-control inputGroupName" maxlength="20" placeholder="请输入群组名称">'
                    + '<input type="hidden" class="groupId" value="'+groupId+'">'
                    + '</div>'
                    + '</div>'
                    + '</div>'
                ,
                btn: ['保存', '取消'],
                btn1: function (index, layero) {
                    var inputGroupName = $(layero).find('.inputGroupName').val().trim();
                    var groupId = $(layero).find('.groupId').val().trim();
                    if (!inputGroupName){
                        layer.msg('群组名称不能为空，请重新选择群组名称！',function(){
                            var inputElem = $(layero).find('input.inputGroupName');
                            inputElem.val('');
                            inputElem.focus();
                        });
                    } else if( inputGroupName.length > 20) {
                        layer.msg('群组名称【' + inputGroupName + '】与长度超过20，请重新选择群组名称！',function(){
                            var inputElem = $(layero).find('input.inputGroupName');
                            inputElem.val(inputGroupName.substring(0,20));
                            inputElem.focus();
                        });
                    } else if( inputGroupName == groupname) {
                        layer.msg('群组名称【' + inputGroupName + '】与原名一样，请重新选择群组名称！',function(){
                            var inputElem = $(layero).find('input.inputGroupName');
                            inputElem.val('');
                            inputElem.focus();
                        });
                    } else {
                        $.ajax({
                            type: "post", //Post传参
                            url: "./im/ImRoomController/renameImRoom",
                            dataType: "json",
                            data: {groupId: groupId, groupName: inputGroupName},
                            success: function (result) {
                                layer.msg('重命名群组成功', function () {
                                    if (result) {
                                        updateGroupName(groupId, inputGroupName);
                                        layer.close(index);
                                    }
                                });
                            },
                            error: function (e) {
                                layer.msg("重命名群组失败，请稍后重试！", function () {
                                    layer.close(index);
                                });
                            }
                        });
                    }

                },
                btn2: function (index, layero) {
                    layer.close(index);
                }
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
            });
            $('input.inputGroupName').focus();
        }
        //发送即时消息menu_chat
        , menu_chat: function () {
            //console.log(othis);
            //打开聊天窗口
            events.chat(othis);
            //关闭右键菜单
            layer.closeAll('tips');
        }

        //部门右键 > 临时会话
        , menu_office_chat: function () {
            var id = $(othis.context).data("id");
            var name = $(othis.context).data("name");
            var cId = Chat.currentUser.jid.split("@")[0];
            var deptUsers = Chat.getAllUserFromObj(Chat.getOrgDeptFromRoot(id));
            
            if(deptUsers && deptUsers.length > Chat.roomMaxUsers){
                layer.msg('不能发起临时会话，部门人数超过' + Chat.roomMaxUsers + '！');
                return;
            } 
            var userInDept = false;
            $.each(deptUsers, function (index,elem) {
                if(elem.id == cId){
                    userInDept = true;
                }
            });
            if(!userInDept){
                return;
            }
            $.post("./im/ImRoomController/saveImRoom/1/" + id, {roomName: name,currentUser:cId}, function (result1) {
                var imRoom = result1.imRoom;
                var users = result1.users;
                var imRoomId = imRoom.id;
                layui.layim.chat({
                    name: imRoomId
                    , temporary: true
                    , type: 'group' //群组类型
                    , avatar: CONST_IMAGE_ICON_ROOT_URL + "tem.png"
                    , id: imRoomId //定义唯一的id方便你处理信息
                    , members: 0 //成员数，不好获取的话，可以设置为0
                });
                if (users && users.length > 0) {
                    //加入临时会话
                    if(Chat.mucJoinIntoGroup(imRoomId)) {
                        var existUserIdsArr = Chat.getRoomMembers(imRoomId);
                        var existUsersArr = new Array();
                        var invitedUsersArr = new Array();
                        $("#groupUserCount").html(existUserIdsArr.length + "人");
                       for (var i = 0; i < users.length; i++) {
                            var index = $.inArray(users[i].id, existUserIdsArr);
                            if (index >= 0) {
                                existUsersArr.push(users[i]);
                            } else {
                                invitedUsersArr.push(users[i]);
                            }
                        }

                        if (invitedUsersArr.length >= 200) {
                            layer.confirm("邀请人数较多，可能要消耗较长时间，您确认要创建临时会话吗？",{
                                btn: ['确认创建', '取消创建'],
                                yes: function (index) {
                                    inviteUsersToGroup(imRoomId, invitedUsersArr, Chat.ROOM_TYPE_TEMPGROUP);
                                    addList(Chat.addToMucRoom(imRoom));
                                    layer.close(index);
                                }
                            });
                        } else {
                            inviteUsersToGroup(imRoomId, invitedUsersArr, Chat.ROOM_TYPE_TEMPGROUP);
                            addList(Chat.addToMucRoom(imRoom));
                        }
                    }
                }
            })
        }

        //移动至
        , menu_moveto: function () {
            //console.log(othis);
            layer.setFriendGroup(othis);
            //关闭右键菜单
            layer.closeAll('tips');
        }
        //右键消息记录
        , menu_history: function () {

            events.chatLogs(othis);
            layer.closeAll('tips');
        }
        //右键点击删除好友unsubscribeUser
        //TODO： 有问题
        , menu_delete: function () {
            var jid = (othis.context.textContent.substr(0, othis.context.textContent.length - 3) + "@" + Chat.BOSH_SERVICE_HOST);
            //console.log(jid);
            Chat.removeUser(jid);
            Chat.getRoster();
            layer.closeAll('tips');
        }

        //转让群
        , transfer_group: function () {
            var thatChat = thisChat();
            if (thatChat && thatChat.data && "group" === thatChat.data.type && !thatChat.data.temporary) {
                var groupId = thatChat.data.id;
                var groupName = thatChat.data.chatname;
                var adminid = $(this).data("adminid" );
                var id = $(this).data("id");
                var uname = $(this).data("uname");
                layer.closeAll('tips');
                var confirmIndex = layer.confirm("您确认要将群组【" + groupName + "】转让给【" + uname + "】吗？", {
                        btn: ['确认转让', '取消转让'] // 按钮
                    }, function () {
                        layer.close(confirmIndex);
                        transferGroup(groupId, adminid, id);
                    }
                    , function () {
                    });
            }
        }

        //移出常用联系人
        , remove_favorite: function () {
            var id = $(this).data("id") || $(othis.context).data("id") || '';
            var contactName = $(this).data("contact-name") || $(othis.context).data("contact-name") || '';
            var favoriteGroupDefId = $(this).data("favorite-group-def-id") || '';
            var favoriteGroupDesc = $(this).data("favorite-group-desc") || '';
            var currentUserId = Chat.currentUser.id;
            layer.closeAll('tips');
            layer.confirm('您确认要将【'+contactName+'】移出分组【' + favoriteGroupDesc + '】吗？', {
                btn: ['移出', '取消'] // 按钮
            }, function (index, layero) {
                $.ajax({
                    type: "post", //Post传参
                    url: "./im/UserFavoriteController/delete/" + currentUserId + "/" + id + "/"+favoriteGroupDefId,
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (result) {
                        var user = Chat.getUserInfoById(id);
                        layer.msg('将【'+contactName+'】移出分组【'+favoriteGroupDesc+'】成功', function () {
                            if (result) {
                                Chat.removeContactFromFavoriteGroupDef(favoriteGroupDefId,user);
                            }
                        });
                    },
                    error: function (e) {
                        layer.msg("移出常用联系人失败，请稍后重试！");
                    }
                });
            }, function (index, layero) {
                layer.close(index);
            });
        }

        //显示联系人分组
        , show_favorite_group_list : function () {
            if($('#favoriteGroupList').css('display') == 'block'){
                $('#favoriteGroupList').hide();
            } else {
                $('#favoriteGroupList').show();
            }
        }
        //新建联系人分组
        , create_contact_group  : function () {
            layer.closeAll('tips');
            layer.open({
                id:1,
                type: 1,
                title:'新建联系人分组',
                skin:'layui-layer-rim',
                area:['450px', 'auto'],
                content: ' <div class="row" style="width: 420px;  margin-left:7px; margin-top:10px;">'
                    +'<div class="col-sm-12">'
                    +'<div class="input-group">'
                    +'<span class="input-group-addon">分组名:</span>'
                    +'<input type="input"  maxlength="20" class="form-control inputGroupDefName" placeholder="请输入分组名">'
                    +'</div>'
                    +'</div>'
                    +'</div>'
                ,
                btn:['保存','取消'],
                btn1: function (index,layero) {
                    var inputGroupDefName = $(layero).find('input.inputGroupDefName').val().trim();
                    if (!inputGroupDefName){
                        layer.msg('分组名不能为空，请重新选择分组名！',function(){
                            var inputElem = $(layero).find('input.inputGroupDefName');
                            inputElem.val('');
                            inputElem.focus();
                        });
                    } else if(inputGroupDefName.length > 20){
                        layer.msg('分组名长度超过20，请重新选择分组名！',function(){
                            var inputElem = $(layero).find('input.inputGroupDefName');
                            inputElem.val(inputGroupDefName.substring(0,20));
                            inputElem.focus();
                        });

                    } else {
                        var groupNameRepetition = false;
                        $.each(Chat.favoriteGroupDefs, function (index,elem) {
                            if(inputGroupDefName == elem.groupDesc){
                                groupNameRepetition = true;
                                return false;
                            }
                        });
                        if(groupNameRepetition){
                            layer.msg('分组名【'+inputGroupDefName+'】已经存在，请重新选择分组名！');
                        } else {
                            var currentUserId = Chat.currentUser.id;
                            $.ajax({
                                type: "post", //Post传参
                                url: "./im/UserFavoriteController/saveUserFavoriteGroupDef",
                                dataType: "json",
                                data: {username: currentUserId, groupDesc: inputGroupDefName},
                                success: function (result) {
                                    layer.msg('新建联系人分组成功', function () {
                                        if (result) {
                                            Chat.addFavoriteGroupDef(result);
                                        }
                                        layer.close(index);
                                    });
                                },
                                error: function (e) {
                                    layer.msg("新建联系人分组失败，请稍后重试！", function () {
                                        layer.close(index);
                                    });
                                }
                            });

                        }
                    }

                },
                btn2:function (index,layero) {
                    layer.close(index);
                }
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
            });
            $('input.inputGroupDefName').focus();
        }
        //删除联系人分组
        , delete_contact_group: function () {
            layer.closeAll('tips');
            var id = $(this).data("id") || $(othis.context).data("id") || '';
            var groupDesc = $(this).data("group-desc") || $(othis.context).data("group-desc") || '';
            layer.confirm('您确认要删除分组【'+groupDesc+'】吗？', {
                    btn: ['删除', '取消'] // 按钮
                }, function (index, layero) {
                    $.ajax({
                        type: "post", //Post传参
                        url: "./im/UserFavoriteController/deleteUserFavoriteGroupDef",
                        dataType: "json",
                        data: {groupId: id, username: Chat.currentUser.id},
                        success: function (result) {
                            if (result) {
                                layer.msg('删除联系人分组【'+groupDesc+'】成功', function () {
                                    Chat.removeFavoriteGroupDef(id);
                                });
                            } else {
                                layer.msg("联系人分组不存在，请刷新后重试！");
                            }
                            layer.close(index);
                        },
                        error: function (e) {
                            layer.msg("删除联系人分组失败，请稍后重试！");
                            layer.close(index);
                        }
                    });
                }
                , function (index, layero) {
                    layer.close(index);
                });
        }
        //重命名联系人分组
        , rename_contact_group: function () {
            var id = $(this).data("id") || $(othis.context).data("id") || '';
            var groupDesc = $(this).data("group-desc") || $(othis.context).data("group-desc") || '';
            layer.closeAll('tips');
            layer.open({
                id: 1,
                type: 1,
                title: '重命名联系人分组',
                skin: 'layui-layer-rim',
                area: ['450px', 'auto'],
                content: ' <div class="row" style="width: 420px;  margin-left:7px; margin-top:10px;">'
                    + '<div class="col-sm-12" style="line-height:30px;">'
                    + '<div class="input-group">'
                    + '<span class="input-group-addon">原分组名:</span>'
                    + '<div class="layui-input-inline" style="padding-left: 12px; padding-top: 5px;">'
                    + groupDesc
                    + '</div>'
                    + '</div>'
                    + '</div>'
                    + '<div class="col-sm-12" style="margin-top:9px;">'
                    + '<div class="input-group">'
                    + '<span class="input-group-addon">新分组名:</span>'
                    + '<input type="input" class="form-control inputGroupDefName" maxlength="20" placeholder="请输入分组名">'
                    + '<input type="hidden" class="groupDefId" value="'+id+'">'
                    + '</div>'
                    + '</div>'
                    + '</div>'
                ,
                btn: ['保存', '取消'],
                btn1: function (index, layero) {
                    var inputGroupDefName = $(layero).find('.inputGroupDefName').val().trim();
                    var groupId = $(layero).find('.groupDefId').val().trim();
                    if (!inputGroupDefName){
                        layer.msg('分组名不能为空，请重新选择分组名！',function(){
                            var inputElem = $(layero).find('input.inputGroupDefName');
                            inputElem.val('');
                            inputElem.focus();
                        });
                    } else if( inputGroupDefName.length > 20) {
                        layer.msg('分组名【' + inputGroupDefName + '】与长度超过20，请重新选择分组名！',function(){
                            var inputElem = $(layero).find('input.inputGroupDefName');
                            inputElem.val(inputGroupDefName.substring(0,20));
                            inputElem.focus();
                        });
                    } else if( inputGroupDefName == groupDesc) {
                        layer.msg('分组名【' + inputGroupDefName + '】与原名一样，请重新选择分组名！',function(){
                            var inputElem = $(layero).find('input.inputGroupDefName');
                            inputElem.val('');
                            inputElem.focus();
                        });
                    } else {
                        var groupNameRepetition = false;
                        $.each(Chat.favoriteGroupDefs, function (index, elem) {
                            if (inputGroupDefName == elem.groupDesc && id  != elem.id) {
                                groupNameRepetition = true;
                                return false;
                            }
                        });
                        if (groupNameRepetition) {
                            layer.msg('分组名【' + inputGroupDefName + '】已经存在，请重新选择分组名！', function () {
                                var inputElem = $(layero).find('input.inputGroupDefName');
                                inputElem.val('');
                                inputElem.focus();
                            });
                        } else {
                            var currentUserId = Chat.currentUser.id;
                            $.ajax({
                                type: "post", //Post传参
                                url: "./im/UserFavoriteController/updateUserFavoriteGroupDef",
                                dataType: "json",
                                data: {groupId: groupId, groupDesc: inputGroupDefName},
                                success: function (result) {
                                    layer.msg('重命名联系人分组成功', function () {
                                        if (result) {
                                            var elemH5 = $('#layim_user_box h5[data-nodetype="favoriteGroup"][data-id="'+groupId+'"]');
                                            elemH5.data('name',inputGroupDefName);
                                            elemH5.find('>span').html(inputGroupDefName);
                                            var groupDef = Chat.getFavoriteGroupDefById(groupId);
                                            groupDef.groupDesc = inputGroupDefName;
                                            layer.close(index);
                                        }
                                    });
                                },
                                error: function (e) {
                                    layer.msg("重命名联系人分组失败，请稍后重试！", function () {
                                        layer.close(index);
                                    });
                                }
                            });

                        }
                    }

                },
                btn2: function (index, layero) {
                    layer.close(index);
                }
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }

            });
            $('input.inputGroupDefName').focus();
        }

        //添加到常用联系分组
        , add_favorite: function () {
            var id = $(this).data("id") || $(othis.context).data("id") || '';
            var groupDesc = $(this).data("favoriteGroupDesc") || $(othis.context).data("favoriteGroupDesc") || '';
            var favoriteGroupDefId = $(this).data("favorite-group-def-id") || $(othis.context).data("favorite-group-def-id") || '';
            var currentUserId = Chat.currentUser.id;
            layer.closeAll('tips');
            $.ajax({
                type: "Post", //Post传参
                url: "./im/UserFavoriteController/saveUserFavoriteContact/" + currentUserId + "/" + favoriteGroupDefId + "/"+id,
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                success: function (result) {
                    var user = Chat.getUserInfoById(id);
                    layer.msg(result ? '添加到['+groupDesc+']成功' : "已经存在于【"+groupDesc + ']', function () {
                        if (result) {
                            Chat.addContactToFavoriteGroupDef(favoriteGroupDefId,result);
                        }
                    });
                },
                error: function (e) {
                    layer.msg("添加到常用联系分组失败，请稍后重试！");
                }
            });
        }

        //右键个人信息
        , menu_profile: function () {
            var id = $(this).data("id") || $(othis.context).data("id");
            showProfile(id);
        },
        updateSign: function (e) {
            var sign = $(e).val();
            var nickname = Chat.currentUser.jid.split("@")[0];
            $.post("./im/ImUserController/saveImUserSign", {signature: sign,currentUser:nickname}, function (result) {
            });
        }
    };

    //暴露接口
    exports('layim', new LAYIM());

}).addcss(
    'modules/layim/layim.css?v=v20190328'
    , 'skinlayimcss'
);
