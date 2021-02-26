//Chat中所有接口参数，均不再需要加ip，比如jid，a@123.57.57.88，用a即可
//比如房间id，room1@conference.123.57.57.88,用room1即可
//Chat对象继承config.js中ImConfig对象
var Chat = {
    SERVICE_CONNECT_URL: null,
    BOSH_SERVICE_HOST: null,
    MUC_HOST: null,
    ROSTER_TYPE: CONST_ROSTER_TYPE,
    ROOM_TYPE_GROUP: 0,
    ROOM_TYPE_TEMPGROUP: 1,
    connection: null,
    connected: false,
    debuggingMode: false,// 是否打印调试日志
    isFocus: true,
    currentUser: null,// 当前登录人
    rootOrgDept: [],// 组织机构成员缓存
    unreadMsgFroms: [],// 未读消息桌面通知
    favoriteGroupDefs: [],// 常用联系人分组
    msgboxData: [],// 消息盒子数据
    imHeartbeatTime: null,// 心跳检测定时器
    errMsg: {
        '406': "已经离开群组无法发送消息",
        '601': "即时通讯正在维护中，请稍后登录",
        '602': "与服务器断开连接，请重新登录",
        '603': "已经离开群聊,无法查看历史记录",
        '604': "群组中没有其他成员,请确认群组是否已经解散"
    },// 错误编码
    showOnlineCnt: true,// 是否显示在线人数，true:显示;  false:不显示
    cacheChatWindow: true,// 是否缓存聊天窗口

    // 可配置项start
    roomMaxUsers: 500,// 聊天室最大人数
    pingInterval: 60000,// 向服务器端发送ping消息的时间间隔，单位毫秒
    chatInitMin: false,// 面板是否初始化为最小化状态
    // 可配置项end

    //登录
    connect: function (jid, password, BOSH_SERVICE, debugginMode) {
        Chat.SERVICE_CONNECT_URL = (BOSH_SERVICE) ? BOSH_SERVICE : Chat.SERVICE_CONNECT_URL;
        Chat.debuggingMode = (debugginMode) ? debugginMode : false; //set to false after done testing!!
        //The transport-protocol for this connection will be chosen automatically
        //based on the given service parameter.
        //URLs starting with “ws://” or “wss://” will use WebSockets,
        //URLs starting with “http://”, “https://” or without a protocol will use BOSH.

        ////using BOSH
        //Chat.connection = new Strophe.Connection(Chat.SERVICE_CONNECT_URL);
        //using  websocket
        //Chat.disconnect();

        setTimeout(
            function () {
                $.post("./im/ImUserController/auth", '', function (result) {
                    if (result.flag == 'success') {
                        //设置系统参数
                        Chat.roomMaxUsers = result.setting.roomMaxUsers;
                        Chat.pingInterval = result.setting.pingInterval;
                        Chat.chatInitMin = result.setting.chatInitMin;
                        Chat.BOSH_SERVICE_HOST = result.setting.serverHost;
                        Chat.MUC_HOST = 'conference.' + Chat.BOSH_SERVICE_HOST;
                        var connectOpts = {};
                        connectOpts.keepalive = true;
                        if(document.location.protocol == 'https:') {
                            connectOpts.protocol = "wss";
                            if (result.setting.serviceConnectWssUrl) {
                                Chat.SERVICE_CONNECT_URL = result.setting.serviceConnectWssUrl;
                            } else {
                                Chat.SERVICE_CONNECT_URL = 'wss://'+Chat.BOSH_SERVICE_HOST + ':5281/ws'
                            }
                        } else {
                            if (result.setting.serviceConnectWsUrl) {
                                Chat.SERVICE_CONNECT_URL = result.setting.serviceConnectWsUrl;
                            } else {
                                Chat.SERVICE_CONNECT_URL = 'ws://'+Chat.BOSH_SERVICE_HOST + ':5280/ws'
                            }
                        }
                        // 是否为调试用户
                        Chat.debuggingMode = result.data.debug;
                        if (jid.indexOf("@") == -1) {
                            jid += "@" + Chat.BOSH_SERVICE_HOST;
                        }
                        var userId = jid.split('@')[0];

                        Chat.connection = new Strophe.Connection(Chat.SERVICE_CONNECT_URL, connectOpts);
                        Chat.connection.connect(jid, userId, Chat.onConnect);
                        Chat.currentUser = {
                            jid: jid,
                            password: userId,
                            id: userId,
                            sign: result.data.sign,
                            secretLevel: result.data.secretLevel,
                            imAdmin: !!result.data.IM_ADMIN_ROLE,
                            status: 'online'
                        };
                        
                        Chat.imHeartbeatTime = window.setInterval(function(){
                        	Chat.ping(userId);
                        },Chat.pingInterval || 60000);
                    } else if (result.flag == 'failure') {
                        if(result.data && result.data.ip){
                            layer.msg('用户已经在【' + result.data.ip + "】登陆聊天工具！", {time: 5000});
                        } else if(result.data) {
                           
                        } else if(result.code){
                        	layer.msg(Chat.errMsg[result.code], {time: 2500});
                        }
                    }
                });
            }, 2500
        );

    },

    //登出
    disconnect: function () {
        Chat.connection.flush();
        Chat.connection.disconnect();
        Chat.connected = false;
    },
    //登录状态回调
    onConnect: function (status) {
        if (status === Strophe.Status.CONNECTING) {
            Chat.log('Strophe is connecting.');
        }
        else if (status === Strophe.Status.CONNFAIL) {
            Chat.log('Strophe failed to connect.');
        }
        else if (status === Strophe.Status.DISCONNECTING) {
            Chat.log('Strophe is disconnecting.');
        }
        else if (status === Strophe.Status.DISCONNECTED) {
            Chat.log('Strophe is disconnected.');
            layer.msg("与服务器断开连接，请重新登录！",{
            	success:function(){
        		   Chat.currentUser.status = 'offline';
                   $('img.layim-mine').addClass('layim-list-gray');
                   mylayim && mylayim.refreshAllStatus();
                   window.clearInterval(Chat.imHeartbeatTime);
                   Chat.imHeartbeatTime = null;
            	}
            });
        }
        else if (status === Strophe.Status.CONNECTED) {
            Chat.log('Strophe is connected.');
            Chat.connected = true;

            //Chat.sendPresence();
            Chat.connection.addHandler(Chat.presenceReceived, null, "presence");
            Chat.connection.addHandler(Chat.receiveMessage, null, 'message');//好友请求列表
            Chat.connection.roster.registerRequestCallback(Chat.friendRequestReceived);
            
            Chat.connection.ping.addPingHandler(Chat.ping);
            //getRoster from server
            //Chat.connection.roster.get(Chat.rosterReceived);
            openTreeOrg(!!Chat.showOnlineCnt, Chat.rosterReceived, function () {
                layer.msg('加载人员失败', {
                    time: 5000, //20s后自动关闭
                });
            });

            // 更新最后登录即时通讯时IP&时间
            $.post("./im/ImUserController/updateLastLoginIp");

            //Add ping handler ~noy working...
//            Chat.connection.ping.addPingHandler(Chat.receivePing);

            //GetPubSub Nodes
            Chat.discoverNodes();

            //getNodes user is subscribed to
            //Chat.getSubscriptions();
        }
    },
    //注册结果回调
    onRegister: function (status) {
        if (status === Strophe.Status.REGISTER) {
            Chat.log("Registering");
            Chat.connection.register.fields.username = Chat.registerUserInfo.Jid;
            Chat.connection.register.fields.password = Chat.registerUserInfo.Password;
          
            Chat.connection.register.submit();
        } else if (status === Strophe.Status.REGISTERED) {
            Chat.log("Registered!");
            Chat.connection.authenticate();
        } else if (status === Strophe.Status.CONNECTED) {
            Chat.log("logged in!");
        } else {
            // every other status a connection.connect would receive
        }
    },
    registerUserInfo: {},
    //注册
    registerUser: function (server, Jid, Password, BOSH_SERVICE) {
        //XEP-0077 InBand Registration
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
        Chat.registerUserInfo = {'Jid': Jid, 'Password': Password};
        //possibly more reg fields later... email,name

        Chat.connection = true;
        //Chat.debuggingMode = true;
        Chat.SERVICE_CONNECT_URL = (BOSH_SERVICE) ? BOSH_SERVICE : Chat.SERVICE_CONNECT_URL;
        Chat.connection = new Strophe.Connection(Chat.SERVICE_CONNECT_URL);
        Chat.connection.register.connect(server, Chat.onRegister);
    },
    sendPriority: function (priority) {
        Chat.connection.send($pres()
            .c("priority").t(priority));
        Chat.log("Priority of " + priority + " sent to contacts.");
    },
    sendPresence: function () {
        Chat.connection.send($pres());
        Chat.log("Presence Sent.");
    },
    msgs: [],
    messages: {},//未读消息
    historyMessages: [],
    chatStates: {},
    //收到消息回调
    receiveMessage: function (msg) {
        Chat.log("message received: ", msg);
        var to = msg.getAttribute('to');
        var from = msg.getAttribute('from');
        Chat.msgs.push(from);
        var type = msg.getAttribute('type');
        //var elems = msg.getElementsByTagName('body');

//        console.info(msg);
        //muc GroupChat message
        if (type == 'groupchat') {
            Chat.log("Group Chat message");
        }
        else if (msg.getElementsByTagName('paused').length) {
            Chat.log("Sender is Paused");
            Chat.chatStates[from] = "paused";
        }
        else if (msg.getElementsByTagName('active').length) {
            Chat.log("Sender is Active");
            Chat.chatStates[from] = "active";
        }
        else if (msg.getElementsByTagName('composing').length) {
            Chat.log("Sender is composing");
            Chat.chatStates[from] = "composing"
        }

        //在群聊时发送消息失败
        var msgUniqueId = msg.getAttribute('id');
        if (msg.getAttribute('type') == 'error') {
            var errorTag = msg.getElementsByTagName('error')[0];
            if(errorTag && errorTag.getAttribute('code')) {
                mylayim.sendMsgFail(from.split('@')[0], msgUniqueId, errorTag.getAttribute('code'));
            } else {
                mylayim.sendMsgFail(from.split('@')[0], msgUniqueId);
            }
            return true;
        }

        //msg可能同时有body和书写状态内容
        if (from.indexOf(Chat.MUC_HOST) != -1 &&
            msg.getElementsByTagName('forwarded').length <= 0) {
            //muc sub 消息
            var items = msg.getElementsByTagName('items');
            for (var i = 0; i < items.length; i++) {
                item = items[i];
                var message = item.getElementsByTagName('message')[0];
                var mFrom = message.getAttribute('from');
                msgUniqueId= message.getAttribute('id');
                var archived = message.getElementsByTagName("archived");
                var archivedTimestamp = archived.length && archived[0].getAttribute('id');
                var mGroup = mFrom.split('@')[0];
                var mSenderId = mFrom.split('/')[1];
//                var mSender = mTo.split('@')[0];
                var x = Chat.getUserInfoById(mSenderId);
                var roomObj = Chat.getRoomInfoById(mGroup);
                var mTo = message.getAttribute('to');

                if (mSenderId == Chat.getBareIdFromJid(mTo)) {
                    //自己发送的消息
                } else {
                    var mText = Strophe.getText(message.getElementsByTagName('body')[0]);

                    var timestamp = msg.getElementsByTagName('delay')[0] && msg.getElementsByTagName('delay')[0].getAttribute('stamp');
                    //2018-10-19T11:42:20.367239Z format
                    timestamp = timestamp || (archivedTimestamp && parseInt(archivedTimestamp.substring(0,13))) || (new Date(timestamp)).getTime();

                    mylayim.getMessage({
                        username: x.username,
                        avatar: x.avatar,
                        status:x.status,
                        id: mGroup,
                        type: "group",
                        content: mText,
                        mine: false,
                        groupname: (roomObj && roomObj.groupname) || mGroup,
                        chatname: (roomObj && roomObj.groupname) || mGroup,
                        timestamp: timestamp,
                        fromid: mSenderId,
                        msguniqueid:msgUniqueId
                    });
                }
            }
        } else if (msg.getElementsByTagName('body').length) {
            msgUniqueId = msg.getAttribute('id');
            var archived = msg.getElementsByTagName("archived");
            var archivedTimestamp = archived.length && archived[0].getAttribute('id');
            //消息
            var body = msg.getElementsByTagName('body')[0];

            if (msg.getElementsByTagName('forwarded').length) {
                //历史消息
                var messageInner = msg.getElementsByTagName('message')[0];
                from = messageInner.getAttribute('from');
                var historyType = messageInner.getAttribute('type');
                var timestamp = msg.getElementsByTagName('delay')[0].getAttribute('stamp');
                //2017-07-27T08:48:54.271488Z format
                timestamp = (new Date(timestamp)).getTime();

                var senderInfo = {};
                if (historyType === "groupchat") {
                    var xEl = messageInner.getElementsByTagName('item')[0];
                    var xjid = xEl.getAttribute('jid');
                    senderInfo = Chat.getUserInfoById(xjid.split("@")[0]);
                } else {
                    senderInfo = Chat.getUserInfoById(from.split("@")[0]);
                }
                var messageInfo = {
                    'username': senderInfo.username,
                    'id': senderInfo.id,
                    'avatar': (senderInfo.avatar ? senderInfo.avatar : CONST_IMAGE_ICON_ROOT_URL + "group_avatar.jpg"),
                    'timestamp': timestamp,
                    'content': Strophe.getText(body)
                };
                Chat.historyMessages.push(messageInfo);
            } else if (msg.getElementsByTagName('delay').length) {
                var senderInfo = Chat.getUserInfoById(from.split("@")[0]);
                var messageInfo = {
                    'to': to,
                    'from': from,
                    'type': type,
                    'message': Strophe.getText(body)
                };
                //Chat.messages.push(messageInfo);

                var timestamp = msg.getElementsByTagName('delay')[0].getAttribute('stamp');
                //2017-07-27T08:48:54.271488Z format
                timestamp = timestamp && (new Date(timestamp)).getTime();
                mylayim.getMessage({
                    username: senderInfo.username,
                    status:senderInfo.status,
                    avatar: (senderInfo.avatar ? senderInfo.avatar : CONST_IMAGE_ICON_ROOT_URL + "avatar.jpg"),
                    id: senderInfo.id,
                    type: "friend",
                    timestamp: timestamp,
                    content: messageInfo.message,
                    msguniqueid:msgUniqueId
                });

            } else {
                var senderId = from.split("@")[0];

                var timestamp = (archivedTimestamp && parseInt(archivedTimestamp.substring(0, 13))) || null;
                //自己发送的消息
                if (senderId == Chat.currentUser.id) {
                    return true;
                }
                var senderInfo = Chat.getUserInfoById(senderId);
                var msgContent = Strophe.getText(body);
                if (msg.getAttribute('type') == 'error') {
                    return true;
                    //msgContent = 'system[发送失败！请使用其他方式联系对方！]';
                }
                //常规消息
                var messageInfo = {
                    'to': to,
                    'from': from,
                    'type': type,
                    'message': msgContent
                };
                //Chat.messages.push(messageInfo);
                mylayim.getMessage({
                    username: senderInfo.username,
                    status:senderInfo.status,
                    avatar: (senderInfo.avatar ? senderInfo.avatar : CONST_IMAGE_ICON_ROOT_URL + "avatar.jpg"),
                    id: senderInfo.id,
                    type: "friend",
                    'timestamp':timestamp,
                    content: messageInfo.message,
                    msguniqueid:msgUniqueId
                });
            }

        } else {

        }
        // 必须返回true，保持在线
        // 返回false会掉线
        return true;
    },
    //发送消息
    sendMessage: function (messageTo, message, type) {
        var dfd = $.Deferred();
        var messagetype = (type) ? type : 'chat';
        var reply;
        var msgUniqueId = Chat.connection.getUniqueId();
        if (messagetype === 'groupchat') {
            if (messageTo.indexOf("@") == -1) {
                messageTo += "@" + Chat.MUC_HOST;
            }
            var s = {
                to: messageTo,
                from: Chat.connection.jid,
                type: messagetype,
                id: msgUniqueId
            };
            reply = $msg(s).c("body", {xmlns: Strophe.NS.CLIENT}).t(message);
        }
        else {
            if (messageTo.indexOf("@") == -1) {
                messageTo += "@" + Chat.BOSH_SERVICE_HOST;
            }
            reply = $msg({
                to: messageTo,
                from: Chat.connection.jid,
                type: messagetype,
                id: msgUniqueId
            }).c("body").t(message);
        }

        var fail_fn = function (errCode) {
            if(errCode){
                if(isNaN(errCode)){
                    layer.msg(errCode);
                } else {
                    layer.msg(Chat.errMsg[errCode]);
                    //与平台断开连接
                    if(errCode == "602"){
                        Chat.currentUser.status = 'offline';
                        $('img.layim-mine').addClass('layim-list-gray');
                        mylayim && mylayim.refreshAllStatus();
                    }
                }
            } else {
                var status = Chat.getUserStatus(Chat.currentUser.id);
                if(status == 'offline'){
                    Chat.currentUser.status = 'offline';
                    $('img.layim-mine').addClass('layim-list-gray');
                    mylayim && mylayim.refreshAllStatus();
                    layer.msg(Chat.errMsg['602']);
                } else {
                    layer.msg('发送失败，请稍后重试！');
                }
            }
            dfd.reject();
        };

        var succ_fn = function () {
            try {
                Chat.connection.send(reply.tree());
                Chat.log('I sent ' + messageTo + ': ' + message, reply.tree());
                dfd.resolve(msgUniqueId);
                setTimeout(function () {
                    Chat.sendMsgAfter(messageTo, messagetype, msgUniqueId)
                }, 10000);
            } catch (e) {
                fail_fn();
            }
        };

        $.when(Chat.sendMsgBefore(messageTo, messagetype, msgUniqueId))
            // sendMsgBefore执行成功
            .done(function () {
                succ_fn();
            })
            // sendMsgBefore执行失败
            .fail(function (errCode) {
                fail_fn(errCode);
            });
        return dfd.promise();
    },
    Roster: [],
    //获取好友列表
    getRoster: function () {
        if (!Chat.Roster) {
            Chat.log("Roster Items not yet loaded!/No Contacts");
        }
        else {
            return Chat.Roster;
        }

    },
    getAllUnreadMessages: function(){
        $.ajax({
            type: "get",
            url: "./im/ImUnreadMessageController/getMsg",
            cache: false,
            dataType: "json",
            success: function (result) {
                if(result.data && result.data.length){
                    $.each(result.data, function (index,item) {
                        var senderInfo = Chat.getUserInfoById(item.fromUser);
                        var msgInfo = {};
                        if(item.type == 'chat') {
                            msgInfo = {
                                username: senderInfo.username,
                                avatar: senderInfo.avatar,
                                id: senderInfo.id,
                                status: senderInfo.status,
                                type: "friend",
                                'timestamp': item.createdAt,
                                content: item.msg,
                                msguniqueid: item.msgUniqueId
                            };
                        } else {
                            var roomObj = Chat.getRoomInfoById(item.roomId);
                            msgInfo = {
                                username: senderInfo.username,
                                id: item.roomId,
                                avatar: senderInfo.avatar,
                                status:senderInfo.status,
                                type: "group",
                                content: item.msg,
                                mine: false,
                                groupname: (roomObj && roomObj.groupname) || item.roomId,
                                chatname: (roomObj && roomObj.groupname) || item.roomId,
                                timestamp: item.createdAt,
                                fromid: senderInfo.id,
                                msguniqueid:item.msgUniqueId
                            };
                        }
                        mylayim.getMessage(msgInfo);
                    });

                }
            }
        });
    },
    sendMsgBefore: function(messgeTo, messageType, msgUniqueId){
        var to = messgeTo.split('@')[0];
        var currentId = Chat.currentUser.id;
        var result = false;
        var postData;
        // 创建deferred对象
        var dfd = $.Deferred();
        if(messageType == 'groupchat'){
            //var toArr = Chat.getUsersOfRoom(to);
            postData = {
                from: Chat.currentUser.id,
                type: '1',
                msgUniqueId: msgUniqueId,
                //to: toArr.join(','),
                roomId: to
            };
        } else {
            if(to != currentId) {
                postData = {
                    from: Chat.currentUser.id,
                    to: to,
                    type: '0',
                    msgUniqueId: msgUniqueId
                };
            } else {
                dfd.resolve();
            }
        }
        postData && $.ajax({
            type: "post",
            url: "./im/ImUnreadMessageController/sendMsgBefore",
            data: postData,
            cache: false,
            dataType: "json",
            success: function (result) {
                if(result && result.count > 0){
                    dfd.resolve();
                } else if(result && result.count === 0){
                    dfd.reject('604');
                } else {
                    dfd.reject();
                }
            },
            error : function (e) {
                Chat.log(e);
                dfd.reject();
            }
        });
        return dfd.promise();
    },

    sendMsgAfter: function(messgeTo, messageType, msgUniqueId){
        var data = {};
        if (messageType == 'groupchat') {
            data = {
                from: Chat.currentUser.id,
                type: '1' ,
                msgUniqueId: msgUniqueId,
                roomId:messgeTo
            };
        } else {
            data = {
                from: Chat.currentUser.id,
                type: '0' ,
                msgUniqueId: msgUniqueId
            };
        }
        $.ajax({
            type: "post",
            url: "./im/ImUnreadMessageController/sendMsgAfter",
            data: data,
            cache: false,
            dataType: "json",
            success: function (result) {
                // return result && result.count > 0;
            }
        });
    },
    deleteReadMessage: function (msgUniqueIds) {
        $.ajax({
            type: "post",
            url: "./im/ImUnreadMessageController/updateMsg",
            data: {
                to: Chat.currentUser.id,
                msgUniqueId: msgUniqueIds
            },
            cache: false,
            dataType: "json",
            success: function (result) {
            }
        });
    },
    // result含多级组织机构通讯录
    rosterReceived: function (result) {
        Chat.log('rosterReceived:');
        //Chat.log(result);
        //Chat.Roster = Chat.getRosterArrayFromMultipleLevel(result);
        Chat.rootOrgDept = result.orgs;
        var users = Chat.getAllUserFromObj(Chat.rootOrgDept);
        users.sort(function (sortA, sortB) {
            return sortA.id.localeCompare(sortB.id);
        });
        Chat.Roster = users;
        Chat.favoriteGroupDefs = result.favoriteGroupDefs;
        Chat.renderLayimMain();
    },
    //绘制主面板
    renderLayimMain : function (){
        var contactList = [];
        contactList.push(Chat.getFavoriteFriendObj());
        contactList.push(Chat.rootOrgDept);

        var mine = {
            "username": Chat.currentUser.jid.split("@")[0], //我的昵称
            "id": Chat.currentUser.jid.split("@")[0], //我的ID
            "status": "online", //在线状态 online：在线、hide：隐身
            "sign": Chat.currentUser.sign, //我的签名
            "secretLevel": Chat.currentUser.secretLevel, //我的密级
            "avatar": CONST_IMAGE_ICON_ROOT_URL + "avatar.jpg" //我的头像
        };

        $.each(Chat.Roster, function (index) {
            var item = Chat.Roster[index];
            if (item.id == mine.id) {
                mine.username = item.username;
                mine.avatar = item.avatar;
                item.status = 'online';
                Chat.currentUser.id = item.id;
                Chat.currentUser.username = item.username;
                return false;
            }
        });

        var friend = [];
        var defaultGroup = {
            "groupname": "默认分组",
            "id": 1,
            "list": Chat.Roster
        };
        friend.push(defaultGroup);
        initLayIM(mine, friend, null);
        setTimeout(
            function () {
                Chat.initLazyContactList(contactList);
                Chat.sendPresence();//这句话会导致离线消息全部清除，触发服务器消息推送。需要放在合适位置服务器才能推送所有消息，否则只会推送一条
                //获取群组
                Chat.mucListRooms(function(){
                    mylayim.initHistoryImRecord();
                    setTimeout(Chat.getAllUnreadMessages, 3000);
                });
            }, 2500
        );
    },
    //好友请求,如果有多个请求，该方法会被调用多次。初始化的时候和登录过程中都会在获取到请求时调用
    //result 请求加好友的Jid 。
    friendRequestReceived: function (Jid) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
        Chat.log("friendRequestReceived:" + Jid);
        //TODO:  完善各个字段
        var msg = {
            "id": 0,
            "content": "申请添加你为好友",
            "uid": Jid,
            "from": Jid,
            "from_group": 0,
            "type": 1,
            "remark": null,
            "href": null,
            "read": 1,
            "time": "刚刚",
            "user": {
                "id": Jid,
                "avatar": CONST_IMAGE_ICON_ROOT_URL + "avatar.jpg",
                "username": Jid.split("@")[0],
                "sign": null
            }
        };
        Chat.msgboxData.push(msg);
        Chat.setCookie("ozs_msgboxdata", JSON.stringify(Chat.msgboxData));
    },
    //设置头像 data:base64  type:png/jpg/bmp etc.
    setAvatar: function (data, type) {
        var iq = $iq({type: 'set', to: Chat.currentUser.jid}).c('vCard', {xmlns: Strophe.NS.VCARD})
            .c('PHOTO', {'TYPE': 'avicit/platform6/im/image/' + type, 'BINVAL': data});
        Chat.connection.sendIQ(iq,
            function (result) {//success
                Chat.log("success set nickname ");
                Chat.log(result);
            },
            function (result) {//failed
                Chat.log("failed to set nickname ");
                Chat.log(result);
            });
    },
    //设置昵称
    setNickname: function (nickname) {
        var iq = $iq({
            type: 'set',
            to: Chat.currentUser.jid
        }).c('vCard', {xmlns: Strophe.NS.VCARD}).c('NICKNAME').t(nickname);
        ;
        Chat.connection.sendIQ(iq,
            function (result) {//success
                Chat.log("success set nickname ");
                Chat.log(result);
            },
            function (result) {//failed
                Chat.log("failed to set nickname ");
                Chat.log(result);
            });
    },
    //获取用户详情 包括昵称 头像等,返回结果
//  <iq
//  xmlns="jabber:client" xml:lang="en" to="a@123.57.57.88/3790703262202572185239" from="a@123.57.57.88" type="result" id="dad65af9-5b6c-4ef4-b501-34b01c488a21:sendIQ">
//  <vCard
//      xmlns="vcard-temp">
//      <NICKNAME>a</NICKNAME>
//      <PHOTO>
//          <TYPE>image/png</TYPE>
//          <BINVAL>/9j/4AAQSkZJRgABAQAASABIAAD/4QBYRXhpZgAATU0AKgAAAAgAAgESAAMAAAABAAEAAIdpAAQAAAABAAAAJgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAIqADAAQAAAABAAAAIgAAAAD/7QA4UGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAAA4QklNBCUAAAAAABDUHYzZjwCyBOmACZjs+EJ+/8AAEQgAIgAiAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/bAEMABgYGBgYGCgYGCg4KCgoOEg4ODg4SFxISEhISFxwXFxcXFxccHBwcHBwcHCIiIiIiIicnJycnLCwsLCwsLCwsLP/bAEMBBwcHCwoLEwoKEy4fGh8uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLv/dAAQAA//aAAwDAQACEQMRAD8A+kdX1eLTIhxulb7q/wBT7V59d6pfXhJmlbB/hBwPyo1S7N5fSzE5G4hfoOlUURpGCICzHoBXrUaMYRu9zwcTiZVJNJ6E0F3c2zboJGQ+xxXb6L4g+1uLW8wJD91ugb2PvXCSRSQttlUqTzzTVYowZTgg5FVUpRqLUzo150pafcez0Vz0HiC1MKGU/OVG7645qX+37H1rzvq8+x7H1yn3P//Q9Iu4GtrmSBuqMRRamJZgZjhcH1644zjnHrXb+INFe7P2y1GZAPmX+8B3HvXBMrISrAgjsa9ilUVSJ89WpOlPVFy7lieOJIypKbs7QQOTnjNUaK6bQ9DlupFubldsK8gH+L/61VKSpxuyIxlVnaKLMHhqSSFJC2Cyg49Mipf+EXf+/Xa0VwfW5Hq/UIH/0fqmue8QQQm1MpRS/wDewM/nXQ1h+IP+PE1vh/jRy4v+GzB8NQQySMZEViOmQDiu6rifC333rtq0xfxGWA+AKKKK5DvP/9k=</BINVAL>
//      </PHOTO>
//  </vCard>
//  </iq>
    getUserDetailInfo: function (Jid) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
        Chat.connection.vcard.get(Jid,
            function (result) {//success
//                Chat.log("success get user info: ");
//                Chat.log(result);
                var nickname = $(result).find("NICKNAME").text();
//                Chat.log('nickname:' +nickname);
                var avatarType = $(result).find("PHOTO").find("TYPE").text();
                var avatarData = $(result).find("PHOTO").find("BINVAL").text();
                $.each(Chat.Roster, function (index) {
                    var item = Chat.Roster[index];

                    if ((item.id || item.jid) == Jid.split("@")[0]) {
                        item.username = nickname;
                        if (avatarData) {
                            item.avatar = "data:" + avatarType + ";base64," + avatarData;
                        } else {
                            item.avatar = CONST_IMAGE_ICON_ROOT_URL + "avatar.jpg";
                        }
                        Chat.Roster[index] = item;
                    }
                });
                //    return result;
            },
            function (result) {//failed
                Chat.log("failed to get user info: ");
                Chat.log(result);
            });
    },
    getMyDetailInfo: function () {
        Chat.getUserDetailInfo(Chat.currentUser.jid);
    },
    //房间通讯录
    roomRosterReceived: function (result) {
        Chat.log("roomRosterReceived:");
        Chat.log(result);

        //Chat.connection.addHandler(Chat.presenceReceived,null,"presence");
    },
    //删除好友
    removeUser: function (Jid) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
        if (Chat.userExists(Jid)) {
            Chat.connection.roster.remove(Jid,
                function (result) {//success
                    Chat.log("success remove " + jid);
                },
                function (result) {//failed
                    Chat.log("failed to remove " + jid);
                }
            );
//          //Chat.connection.roster.get();
//          var iq = $iq({type: 'set'}).c('query', {xmlns: Strophe.NS.ROSTER}).c('item', {jid: Jid,
//              subscription: "remove"});
//          Chat.connection.sendIQ(iq, function(status){
//              Chat.log("Removed: "+Jid, status);
//          });
            for (var i = Chat.Roster.length - 1; i >= 0; i--) {
                if (Chat.Roster[i].jid === Jid) {
                    Chat.Roster.splice(i, 1);
                    Chat.log(Chat.Roster);
                }
            }
        } else
            Chat.log("Error removing user");
    },

    //同意某人的好友请求
    authorizeUser: function (Jid, message) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
//      if(Chat.userExists(Jid)){
        Chat.connection.roster.authorize(Jid, message);
        Chat.log("Authorized: " + Jid);
//      }else
//          Chat.log("Error Authorizing");
    },
    //拒绝某人的好友请求
    unauthorizeUser: function (Jid, message) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
        if (Chat.userExists(Jid)) {
            Chat.connection.roster.unauthorize(Jid, message);
            Chat.log("Unauthorized: " + Jid);
        } else
            Chat.log("Error Unauthorizing");

    },
    //请求添加某人为好友
    subscribeUser: function (Jid, message) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }

        if (!Chat.userExists(Jid)) {
            Chat.connection.roster.subscribe(Jid, message);
            //可能不是必须的，但是先加上
            Chat.Roster.push({
                'jid': Jid,
                'name': Jid,
                subscription: '' //NOTE:MIGHT BE ERROR PRONE TO NOT DECLARE SUBSCRIPTION...
            });
            Chat.log("Subscribed: " + Jid);
        } else {
            Chat.log("Error subscribing user");
        }
    },
    //添加联系人到通讯录
    addFriend: function (Jid, name, groupName) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
//      if(Chat.userExists(Jid)){
        var groupArr = new Array(groupName);
        Chat.connection.roster.add(Jid, name, groupArr, Chat.onAddFriend);
        Chat.log("Friend added: " + Jid);
//      }else
//          Chat.log("Error adding Friend");
    },
    //修改好友信息回调
    onAddFriend: function (status) {
        Chat.log("add Friend result:" + status);
    },
    //不再关注好友
    unsubscribeUser: function (Jid, message) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
        if (Chat.userExists(Jid)) {
            Chat.connection.roster.unsubscribe(Jid, message);
            Chat.log("Unsubscribed: " + Jid);
        } else
            Chat.log("Error unsubscribing");
    },
    //修改好友信息：修改好友昵称，移动好友所属分组。
    //    一个好友可以属于多个分组,分组如果不存在会自动创建
    // name 好友昵称
    // groupName 分组名称
    updateFriendInfo: function (Jid, name, groupName) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
        if (Chat.userExists(Jid)) {
            var groupArr = new Array(groupName);
            Chat.connection.roster.update(Jid, name, groupArr, Chat.onUpdateFriendInfo);
            Chat.log("Subscribed: " + Jid);
        } else
            Chat.log("Error subscribing user");
    },
    //修改好友信息回调
    onUpdateFriendInfo: function (status) {
        Chat.log("update result:" + status);
    },
    //好友是否已经在通讯录
    userExists: function (Jid) {
//      if(Jid.indexOf("@") == -1){
//              Jid += "@" + Chat.BOSH_SERVICE_HOST;
//      }
//      	if(Chat.connection.roster.findItem(Jid)){
//      		return true;
//      	}
        if (Jid.indexOf("@") >= 0) {
            Jid = Jid.split('@')[0];
        }
        if (Chat.getUserInfoById(Jid) != null) {
            return true;
        }
        return false;
    },
    /*  not working
        //检查Jid是否注册过
        //示例：Chat.checkIsUserRegistered("b6@121.199.30.240",function(data){Chat.log(data);})
       checkIsUserRegistered:function(Jid, result_cb){
            Chat.connection.disco.info(Jid,null,
                function(result){
                    result_cb ? result_cb(true) : Chat.onCheckIsUserRegistered(true);
                },//查询到用户时回调
                function(result){
                    result_cb ? result_cb(false) : Chat.onCheckIsUserRegistered(false);
                }//查询不到用户时回调
            );
        },
        //检查Jid是否注册过的回调
        onCheckIsUserRegistered: function(result) {

        },
    */
    presenceMessage: {},
    //presence回调
    presenceReceived: function (presence) {
        Chat.log("presenceReceived:");
        Chat.log(presence);
        var presence_type = $(presence).attr('type'); // unavailable, subscribed, etc...
        var from = Chat.getBareIdFromJid($(presence).attr('from')); // the jabber_id of the contact...
        var show = $(presence).find("show").text(); // this is what gives away, dnd, etc.

        //muc related
        //创建群成功
//      <?xml version="1.0" encoding="utf-8"?>
//      <presence xmlns="jabber:client" xml:lang="en" to="test1@123.57.57.88/785908345030760697221938" from="a117@conference.123.57.57.88/test1">
//          <x xmlns="http://jabber.org/protocol/muc#user">
//              <item jid="test1@123.57.57.88/785908345030760697221938" role="moderator" affiliation="owner"/>
//              <status code="170"/>
//              <status code="100"/>
//              <status code="201"/>
//              <status code="110"/>
//          </x>
//      </presence>
        //已经在群里
//      <?xml version="1.0" encoding="utf-8"?>
//      <presence xmlns="jabber:client" xml:lang="en" to="test1@123.57.57.88/1154299134771584139621986" from="a121@conference.123.57.57.88/test1">
//          <x xmlns="http://jabber.org/protocol/muc#user">
//              <item jid="test1@123.57.57.88/1154299134771584139621986" role="moderator" affiliation="owner"/>
//              <status code="170"/>
//              <status code="100"/>
//              <status code="110"/>
//          </x>
//      </presence>
        //群已经存在，不在这个群里
//      <?xml version="1.0" encoding="utf-8"?>
//      <presence xmlns="jabber:client" xml:lang="en" to="test1@123.57.57.88/785908345030760697221938" from="aaa@conference.123.57.57.88/test1">
//          <x xmlns="http://jabber.org/protocol/muc#user">
//              <item jid="test1@123.57.57.88/785908345030760697221938" role="participant" affiliation="none"/>
//              <status code="170"/>
//              <status code="100"/>
//              <status code="110"/>
//          </x>
//      </presence>
        var item = $(presence).find("item");
        if (item.length > 0) {
            var fromstring = $(presence).attr('from')
            var roomname = fromstring.split("/")[0];
            var nickname = fromstring.split("/")[1];
            var affiliation = item.attr("affiliation");
            var role = item.attr("role");
            var status = $(presence).find("status[code='201']");
            var result = "";
            if (role === "none") {
                //无用的presence
//              <?xml version="1.0" encoding="utf-8"?>
//              <presence xmlns="jabber:client" xml:lang="en" to="test1@123.57.57.88/310995165742378557922066" from="a117@conference.123.57.57.88/test1" type="unavailable" id="ea69ddab-2abf-4fc3-a513-9558fd40f5eb">
//                  <x xmlns="http://jabber.org/protocol/muc#user">
//                      <item jid="test1@123.57.57.88/310995165742378557922066" role="none" affiliation="owner"/>
//                      <status code="110"/>
//                  </x>
//              </presence>
            } else {
                if (affiliation === "none") {
                    result = "alreadyExits"; //群组已经存在，当前用户不在这个群里
                } else if (status.length > 0) {
                    result = "createSuccess";//群组创建成功
                } else {
                    result = "alreadyIn";//群组已经存在，当前用户在这个群里
                }
                Chat.mucCreateRoomCallback(roomname, nickname, result);
            }

        }

        // user status related
//      <presence xmlns="jabber:client" xml:lang="en" to="c1@123.57.57.88/161118538734797447402630" from="c2@123.57.57.88/converse.js-23571549">
//          <priority>0</priority>
//          <show>dnd</show>
//      </presence>
        if ((show === 'chat' || show === '') && (!Chat.presenceMessage[from])) {
            // Mark contact as online
            Chat.log("Contact: ", $(presence).attr('from'), " is online");
            Chat.presenceMessage[from] = "online";
            mylayim.setFriendStatus(from, 'online');
            Chat.sendPresence();
        } else if (show === 'away') {//离开
            Chat.log("Contact: ", $(presence).attr('from'), " is offline");
            Chat.presenceMessage[from] = "offline";
            mylayim.setFriendStatus(from, 'offline');
        } else if (show === 'dnd') { //忙碌中
            Chat.presenceMessage[from] = "offline";
            mylayim.setFriendStatus(from, 'offline');
        } else if (show === "") {
//          <presence xmlns="jabber:client" xml:lang="en" to="c1@123.57.57.88/161118538734797447402630" from="c2@123.57.57.88/converse.js-23571549">
//              <priority>0</priority>
//          </presence>
            //用户在线时没有show字段
            Chat.presenceMessage[from] = "online";
            mylayim.setFriendStatus(from, 'online');
        }

        if (presence_type != 'error') {
            if (presence_type === 'undefined') {
            } else if (presence_type === 'unavailable') {
            } else {
            }
        }
        return true;
    },
    //聊天状态，暂停，正在写
    sendChatState: function (Jid, status, type) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
        var chatType = (type) ? type : "chat";
        if (Chat.connection && Jid) {
            Chat.connection.chatstates.init(Chat.connection);
            if (status === "active") {
                Chat.connection.chatstates.sendActive(Jid, chatType);
            } else if (status === "composing") {
                Chat.connection.chatstates.sendComposing(Jid, chatType);
            } else if (status === "paused") {
                Chat.connection.chatstates.sendPaused(Jid, chatType);
            } else
                Chat.log("Error, try again");

        } else {
            Chat.log("Error,sorry not connected")
        }
    },
    discoSuccess: {},
    discoInfo: function (Jid) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
        Chat.connection.disco.info(Jid, '',
            //Success callback
            function (status) {
                Chat.log("Disc Info Success", status);
                Chat.discoSuccess[Jid] = true;
            },
            //error callback
            function (status) {
                Chat.log("Disc Info Error", status);
                Chat.discoSuccess[Jid] = false;
            }
        );
    },
    Pings: {},
    ping: function (Jid) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
        Chat.log('heartbeat detection：' + Jid + '/' + (new Date().getTime()));
        Chat.currentUser.status == 'online' && Chat.connection.ping.ping(Jid,
            function (status) {
//                Chat.log("Ping Success", status);
        	    Chat.log('heartbeat detection success');
        	    Chat.log(status);
                Chat.Pings[Jid] = true;
                Chat.connection.ping.pong(status); //响应pong
            },
            function (status) {
//            	Chat.log("connection fail：" + offlineCount++ + '次');
//                Chat.log("Ping Error", status);
            	 Chat.log('heartbeat detection fail!' );
                Chat.Pings[Jid] = false;
            },
            2000
        );
    },
    discoverNodes: function () {
        Chat.connection.pubsub.discoverNodes(
            function (iq) {
                $(iq).find("item").each(function () {
                    Chat.pubsubNodes.push($(this).attr('node'));
                    if (!Chat.pubsubJid) {
                        Chat.pubsubJid = $(this).attr('jid');
                    }
                });
                Chat.log("success retreiving nodes, stored in array Chat.pubsubNodes", iq);
            },
            function (status) {
                Chat.log("error", status)
            }
        );
    },
    pubsubNodes: [],
    pubsubJid: false,
    //send presence to room will create this room if it's not exits'
    //if room exists, and user not in this room,current users will be participant
    //if current user is already in this room, role and affiliation will be returned.
    mucSendPresence: function (roomName) {
        if (roomName.indexOf("@") == -1) {
            roomName += "@" + Chat.MUC_HOST;
        }
        //http://xmpp.org/extensions/xep-0045.html#createroom
        var presence = $pres({
            to: roomName
        }).c('x', {'xmlns': 'http://jabber.org/protocol/muc'});
        Chat.log(presence.tree());
        Chat.connection.send(presence.tree());
    },
    mucRooms: [],
    //创建房间
    //roomName: 房间名称必须是这种格式：'roomName@conference.localhost',可以不传@及其后边内容
    //nickname：创建者进入房间后的昵称
    mucCreateRoom: function (roomName, nickname, success_cb, fail_cb) {
        if (roomName.indexOf("@") == -1) {
            roomName += "@" + Chat.MUC_HOST;
        }
        //nickName 是创建者在这个群里的昵称
        Chat.mucSendPresence(roomName + "/" + nickname);
        Chat.connection.muc.leave(
            roomName, nickname,
            Chat.presenceReceived,
            null);

    },
    //调用mucCreateRoom创建房间结果的回调
    //result ：
    //  "alreadyExits"; //群组已经存在，当前用户不在这个群里
    //  "createSuccess";//群组创建成功
    //  "alreadyIn";//群组已经存在，当前用户在这个群里
    mucCreateRoomCallback: function (roomName, nickname, result) {
        //  console.log("mucCreateRoomCallback: roomName="+roomName+", nickname="+nickname+",result="+result);
        if (result === "alreadyExits") {
            //房间已经存在，不能创建
            layer.alert('创建群组失败,群组已经存在或者管理员禁止创建', {
                title: '提示'
                , shade: false
            });
        }
        /* else if(result === "alreadyIn"){            layer.alert('您已经在这个群组中', {
                 title: '提示'
                 ,shade: false
             });
         }*/
        else if (result === "createSuccess" || result === "alreadyIn") {
            Chat.connection.mucsub_wskj.subscribe(roomName, nickname, null,
                function (status) {
                    Chat.log("success subscribe ChatRoom:");
                    Chat.log(status);
                    lay.msg('创建群组成功');
                    /* layer.alert('创建群组成功', {
                         title: '提示'
                         ,shade: false
                     });*/
                    //刷新群组
                    Chat.mucRooms = [];
                    Chat.mucListRooms();
                },
                function (status) {
                    Chat.log("Error subscribe ChatRoom:");
                    Chat.log(status);
                }
            );
        }
    },
    mucSessionInfo: {},
    //离开房间
    mucLeave: function (roomId, success_cb, fail_cb) {
        var roomJid = roomId;
        if (roomJid.indexOf("@") == -1) {
            roomJid += "@" + Chat.MUC_HOST;
        }
        Chat.connection.mucsub_wskj.unsubscribe(roomJid,
            function (status) {
                Chat.deleteMucRoom(roomId);
                if (success_cb) {
                    success_cb();
                }
                Chat.log("mucLeave success:" + status);
                Chat.log(status);
            },
            function (status) {
                if (fail_cb) {
                    fail_cb();
                }
                Chat.log("mucLeave failed:" + status);
                Chat.log(status);
            }
        );
    },

    // 将从服务器上获取到的房间信息缓存到本地，如果已经存在则更新本地缓存信息
    addToMucRoom: function (imRoom) {
        var existFlag = false;
        var isTemporary = (imRoom.roomType != Chat.ROOM_TYPE_GROUP);
        var dic = {
            type: 'group',
            avatar: isTemporary ? CONST_IMAGE_ICON_ROOT_URL + "tem.png" : CONST_IMAGE_ICON_ROOT_URL + "avatar_group.jpg",
            groupname: imRoom.roomName,
            chatname: imRoom.roomName,
            temporary: isTemporary,
            create_at: (imRoom.create_at ? "创建于" + layui.data.date(imRoom.create_at) : ''),
            last_active_time: (imRoom.last_active_time ? imRoom.last_active_time : 0),
            creator: imRoom.creator,
            id: imRoom.id
        };
        $.each(Chat.mucRooms, function (i, e) {
            if (e.id == imRoom.id) {
                existFlag = true;
                e.groupname = imRoom.roomName;
                e.chatname = imRoom.roomName;
                return false;
            }
        });
        if (!existFlag) {
            Chat.mucRooms.push(dic);
        }
        return dic;
    },
    deleteMucRoom: function (imRoomId) {
        var delIndex = -1;
        $.each(Chat.mucRooms, function (i, e) {
            if (e.id == imRoomId) {
                delIndex = i;
                return false;
            }
        });
        if (delIndex > -1) {
            Chat.mucRooms.splice(delIndex, 1);
        }
    },

    //获取房间列表
    mucListRooms: function (success_cb) {
        $.ajax({
            type: "post",
            url: "./im/ImRoomController/getImRoomByLoginUser",
            cache: false,
            dataType: "json",
            async : false,
            success: function (data) {
                if (data && data.length > 0) {
                    $.each(data, function (i, e) {
                        Chat.addToMucRoom(e);
                    });

                    //排序 群组>临时会话，再按最后活动时间倒序排列，最后按创建时间倒序排列
                    Chat.mucRooms.sort(function (sortA, sortB) {
                        if (!sortA.temporary) {
                            return -1;
                        } else if (!sortB.temporary) {
                            return 1;
                        } else if (sortA.last_active_time == sortB.last_active_time) {
                            return sortB.create_at.localeCompare(sortA.create_at);
                        } else {
                            return sortB.last_active_time - sortA.last_active_time;
                        }
                    });

                    if (mylayim) {
                        $.each(Chat.mucRooms, function (i, e) {
                            mylayim.addList(e);
                        });
                    }
                }
                if (success_cb) {
                    success_cb();
                }
            },
            error : function (e) {
            }
        });
    },

    //是否为房间创建人
    isRoomCreatorUser: function (roomId) {
        var isOwner = false;
        var roomObj = Chat.getRoomFromServer(roomId);
        if(roomObj && roomObj.creator == Chat.currentUser.id){
            isOwner = true;
        }
        return isOwner;
    },

    //获取房间成员
    //roomName example："room6@conference.121.199.30.240"
    mucQueryOccupants: function (roomName, success_cb, fail_cb) {
        var userCreator = '';

        if (roomName.indexOf("@") == -1) {
            roomName += "@" + Chat.MUC_HOST;
        }
        //roomName.split("@")[0];
        $.get("./im/ImRoomController/getImRoomById/" + roomName.split("@")[0], function (result) {
            var jidArr = [];
            if(result.members && result.members.length > 0){
                var membersIds = result.members;
                var membersIdArr = result.members.split(",");
                $.each(membersIdArr,function (i,e) {
                    var item = Chat.getUserInfoById(e);
                    if (item) {
                        jidArr.push(item);
                    }
                });
            }
            if (success_cb) {
                success_cb(jidArr);
            }
        });
    },
    //群组管理员拉多个用户加入房间
    // userNameArr : [] 用户名数组
    mucMultipleInvite: function (roomName, jidArr) {
        for (var i in userNameArr) {
            Chat.mucInvite(roomName, jid[i]);
        }
    },
    //群组管理员拉用户加入房间
    mucInvite: function (roomName, userName, success_cb, fail_cb) {
        if (roomName.indexOf("@") == -1) {
            roomName += "@" + Chat.MUC_HOST;
        }
        if (userName.indexOf("@") == -1) {
            userName += "@" + Chat.BOSH_SERVICE_HOST;
        }
        Chat.connection.mucsub_wskj.subscribeByAdmin(userName, roomName, null, null,
            function (status) {
                Chat.log("mucInvite success:");
                Chat.log(status);
                if (success_cb) {
                    success_cb();
                }
            },
            function (status) {
                Chat.log("mucInvite failed:");
                Chat.log(status);
                if (fail_cb) {
                    fail_cb();
                }
            }
        );
    },

    //用户主动加入临时会话
    mucJoinIntoGroup: function (roomId) {
        var userId = Chat.currentUser.id;
        var rtn = false;
        var postData = {room: roomId, user: userId};
        $.ajax({
            url: './im/XmppController/subscribeRoom',
            type: "POST",
            dataType: 'json',
            async : false,
            data: postData,
            success: function () {
                rtn = Chat.setRoomAffiliation(roomId, userId, "admin");
            },
            error: function () {
                rtn = false;
            }
        });
        return rtn;
    },
    //群组管理员踢出用户
    mucThrowOut: function (roomName, userName, success_cb, fail_cb) {
        if (roomName.indexOf("@") == -1) {
            roomName += "@" + Chat.MUC_HOST;
        }
        if (userName.indexOf("@") == -1) {
            userName += "@" + Chat.BOSH_SERVICE_HOST;
        }
        Chat.connection.mucsub_wskj.unsubscribeByAdmin(userName, roomName,
            function (status) {
                Chat.log("mucThrowOut success:");
                Chat.log(status);
                if (success_cb) {
                    success_cb();
                }
            },
            function (status) {
                Chat.log("mucThrowOut failed:");
                Chat.log(status);
                if (fail_cb) {
                    fail_cb();
                }
            }
        );
    },

    log: function () {
        //如果连接失败
        if (!Chat.connection) {
            console.log("Error, not connected`, please enter credentials:\n " +
                "Chat.connect('jid','password')");
        }
        if (Chat.debuggingMode) {
            for (var i = 0; i < arguments.length; i++) {
                console.log(arguments[i]);
            }
        }
    },
    getSubJID: function (Jid) {
        //解析JID: ramon@localhost/1234567
        // 变成
        // ramon@localhost
        var Jid = (Jid) ? Jid : Chat.connection.Jid;
        var subJID = '';
        for (i = 0; i < Jid.length; i++) {
            if (Jid[i] === '/') {
                if (Chat.connected) Chat.log(Jid + " => " + subJID);
                return subJID;
            }
            subJID += Jid[i];
        }
        return subJID;
    },
    //写cookies
    setCookie: function (name, value) {
        var Days = 30;
        var exp = new Date();
        exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
        document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
    },
    //读取cookies
    getCookie: function (name) {
        var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");

        if (arr = document.cookie.match(reg))
            return unescape(arr[2]);
        else
            return null;
    },
    //获取用户id 不包含域名和资源id. a@1.2.3.4/xxxx  -> a
    getBareIdFromJid: function (jid) {
        if (jid.indexOf("@") < 0) {
            return jid;
        }
        return jid.split("@")[0];
    },

    getNickNameFromJid: function (jid) {
        var id = "";
        if (jid.indexOf("@") < 0) {
            id = jid;
        } else {
            id = jid.split("@")[0];
        }
        var user = Chat.getUserInfoById(id);
        return user.userName;
    },

    //获取消息历史 using mam plugin
    //参数Jid 支持单聊用户Jid和群组jid.  jid需要是完整的jid， 只有用户名，则表示是单聊
    // length： 要获取的消息数量
    // after_message_id: 返回的消息体中包括消息的id，这个参数表示获取从该id之后的消息，实现分页。顺序是从现在到更早的倒序
    //onmessage_cb: 接收到第一条消息内容。
    //  在Chat.receiveMessage 接收所有消息，消息是一条一条出现。
    //oncomplete_cb： 消息接收完毕后，会调用这个方法。内容如下：
    //  <?xml version="1.0" encoding="utf-8"?>
    //<iq xmlns="jabber:client" xml:lang="en" to="test1@123.57.57.88/489008241665666843220994" from="test2@123.57.57.88" type="result" id="c2638f7c-2c6e-4144-b0f0-4c46598aadb2:sendIQ">
    //  <fin xmlns="urn:xmpp:mam:1" complete="false">//是还有更多历史消息
    //      <set xmlns="http://jabber.org/protocol/rsm">
    //          <count>1787</count>  //消息总数量
    //          <first>1511762137029954</first>  //刚发送的消息列表中的第一条
    //          <last>1511762246689415</last>    //刚发送的消息列表中的最后一条，把这条id作为after参数，就可以获取下一页内容
    //      </set>
    //  </fin>
    //</iq>

    getMessageHistoryByMAM: function (Jid, onmessage_cb, oncomplete_cb, length, after_message_id) {
        if (Jid.indexOf("@") == -1) {
            Jid += "@" + Chat.BOSH_SERVICE_HOST;
        }
        Chat.historyMessages = [];
        var options = {
            onMessage: (onmessage_cb ? onmessage_cb : function (result) {
                Chat.log("on get message histroy :");
                Chat.log(result);
            }),
            onComplete: (oncomplete_cb ? oncomplete_cb : function (result) {
                Chat.log("on complete message histroy :");
                Chat.log(result);
            })
        };

        if (Jid.endsWith(Chat.MUC_HOST)) {
            //如果是群聊，不设置with 参数。
            //意味着后来加入的人，也可以看到以前的聊天消息

        } else {
            options["with"] = Jid;
        }
        if (length) {
            options["max"] = length;
        }
        if (after_message_id) {
            options["after"] = after_message_id;
        }

        Chat.connection.mam.query(Jid, options);
    },
    initContactList: function (friends) {
        var html = '<li>' + Chat.listMultiLevelContactTpl(friends, true) + '</li>';
        $(".layim-list-friend.layim-tab-content").html(html);
    },
    initLazyContactList: function (friends) {
        var html = '<li>' + Chat.lazyLevelContactTpl(friends, true) + '</li>';
        $(".layim-list-friend.layim-tab-content").html(html);
        var me = Chat.getUserInfoById(Chat.currentUser.id);
        if(me && me.deptOrgs){
            // 展开自己所在部门下的联系人
            for(var i=1;i<me.deptOrgs.length;i++){
                $('#layim_user_box h5[data-name="'+me.deptOrgs[i]+'"] > i').click()
            }
            $('img.lazy').lazyload({container: $("#layim_user_box")});
        }
    },

    //懒加载组织机构
    openUserTree: function (e) {
        if (e.next().children().length == 0) {
            if ($(e).data('nodetype') == 'dept' || $(e).data('nodetype') == 'org') {
                var orgDept = Chat.getOrgDeptFromRoot($(e).data('id'));
                var data = Chat.getUserAndDeptsFromObj(orgDept);
                e.next().html(Chat.lazyLevelContactTpl(data, false));
                if (data.length > 0) {
                    $('img.lazy').lazyload({container: $("#layim_user_box")});
                }
            } else if ((e).data('nodetype') == 'favoriteGroup') {
                var favoriteFriendObj = Chat.getFavoriteFriendObj();
                var data = [];
                $.each(favoriteFriendObj.children, function (index, elem) {
                    if (elem.id == $(e).data('id')) {
                        data = elem.children;
                    }
                });
                e.next().html(Chat.lazyLevelContactTpl(data, false));
            }
        }

    },

    //从本地缓存中获取组织部门
    getOrgDeptFromRoot: function (id, searchInOrgDept) {
        var orgDept = {};
        var tempDept = searchInOrgDept || Chat.rootOrgDept;
        if (!id || !tempDept) {
            return null;
        }
        if (id == tempDept.id) {
            return tempDept;
        } else if (tempDept.children && tempDept.children.length) {
            var dept = null;
            $.each(tempDept.children, function (index) {
                dept = Chat.getOrgDeptFromRoot(id, tempDept.children[index]);
                if (dept) {
                    return false;
                }
            });
            return dept;
        } else {
            return null;
        }
    },
    //从本地缓存中获取组织部门的父节点
    getParentOrgDeptFromRoot: function (id) {
        var orgDept = null;
        var parentId = $('#layim_user_box ul[data-id="'+id+'"]').parent('ul').data('id');
        if(parentId){
            orgDept = Chat.getOrgDeptFromRoot(parentId);
        }
        return orgDept;
    },
    //从本地缓存中获取组织部门下的直属部门和直属用户
    getUserAndDeptsFromObj: function (orgDept) {
        var data = [];
        if (orgDept && orgDept.children) {
            $.each(orgDept.children, function (index) {
                data.push(orgDept.children[index]);
            });
        }

        if (orgDept && orgDept.users) {
            //按照在线状态(online在前，offline在后) ，再按 id排序
            orgDept.users.sort(function (sortA, sortB) {
                if (sortA.status == sortB.status) {
                    return sortA.id.localeCompare(sortB.id);
                } else {
                    return sortB.status.localeCompare(sortA.status);
                }
            });

            $.each(orgDept.users, function (index) {
                data.push(orgDept.users[index]);
            });
        }
        return data;
    },
    //从本地缓存中获取组织部门下的所有用户
    getAllUserFromObj: function (orgDept) {
        var data = [];
        if (orgDept && orgDept.children) {
            $.each(orgDept.children, function (index) {
                var allSubUsers = Chat.getAllUserFromObj(orgDept.children[index]);
                $.each(allSubUsers, function (i) {
                    data.push(allSubUsers[i]);
                });
            });
        }

        if (orgDept && orgDept.users) {
            $.each(orgDept.users, function (index) {
                //取默认头像
                orgDept.users[index].avatar = CONST_IMAGE_ICON_ROOT_URL + "avatar.jpg";
                //orgDept.users[index].avatar = "./platform/sysuser/photo/upload/headerphoto?sysUserId=" + orgDept.users[index].sysUserId;
                data.push(orgDept.users[index]);
            });
        }
        return data;
    },
    //判断是否是当前登录人是否属于某部门
    isCurrentUserInDept: function (deptId) {
        var deptUsers = Chat.getAllUserFromObj(Chat.getOrgDeptFromRoot(deptId));
        var userInDept = false;
        $.each(deptUsers, function (index, elem) {
            if (elem.id == Chat.currentUser.id) {
                userInDept = true;
                return false;
            }
        });
        return userInDept;
    },
    //新建常用联系分组
    addFavoriteGroupDef: function (favoriteGroupDef) {
        Chat.favoriteGroupDefs.push(favoriteGroupDef);
        var favoriteFriendObj = Chat.getFavoriteFriendObj();
        var html = Chat.lazyLevelContactTpl(favoriteFriendObj.children);
        $('#layim_user_box h5[data-nodetype="favoriteGroup"][data-id="-1"]').next().html(html);
    },
    //删除联系分组
    removeFavoriteGroupDef: function (favoriteGroupDefId) {
        var index = Chat.getFavoriteGroupDefIndexById(favoriteGroupDefId);
        if (index > -1) {
            Chat.favoriteGroupDefs.splice(index, 1);
            $('#layim_user_box h5[data-nodetype="favoriteGroup"][data-id="' + favoriteGroupDefId + '"]').remove();
        }
    },
    //添加到常用联系分组
    addContactToFavoriteGroupDef: function (favoriteGroupDefId, item) {
        var favoriteGroupDef = Chat.getFavoriteGroupDefById(favoriteGroupDefId);
        favoriteGroupDef.contacts.push(item);
        var favoriteFriendObj = Chat.getFavoriteFriendObj();
        var html = Chat.lazyLevelContactTpl(favoriteFriendObj.children);
        $('#layim_user_box h5[data-nodetype="favoriteGroup"][data-id="-1"]').next().html(html);
    },
    //从常用联系分组列表移出
    removeContactFromFavoriteGroupDef: function (favoriteGroupDefId, item) {
        var favoriteGroupDef = Chat.getFavoriteGroupDefById(favoriteGroupDefId);
        var removeIndex = -1;
        for (var index = 0; index < favoriteGroupDef.contacts.length; index++) {
            if (favoriteGroupDef.contacts[index].contact == item.id) {
                removeIndex = index;
                break;
            }
        }
        if (removeIndex > -1) {
            favoriteGroupDef.contacts.splice(removeIndex, 1);
            var favoriteFriendObj = Chat.getFavoriteFriendObj();
            var html = Chat.lazyLevelContactTpl(favoriteFriendObj.children);
            $('#layim_user_box h5[data-nodetype="favoriteGroup"][data-id="-1"]').next().html(html);

        }
    },
    getFavoriteFriendObj: function () {
        var favoriteFriendObj = {};
        var children = [];
        $.each(Chat.favoriteGroupDefs, function (index) {
            var users = [];
            $.each(Chat.favoriteGroupDefs[index].contacts, function (i, elem) {
                var item = Chat.getUserInfoById(elem.contact);
                if (item) {
                    item.favorite = true;
                    users.push(item);
                }
            });
            users.sort(function (sortA, sortB) {
                if (sortA.status == sortB.status) {
                    return sortA.id.localeCompare(sortB.id);
                } else {
                    return sortB.status.localeCompare(sortA.status);
                }
            });
            Chat.favoriteGroupDefs[index].users = users;
            if (index > 0) {
                children.push({
                    groupname: Chat.favoriteGroupDefs[index].groupDesc
                    , children: Chat.favoriteGroupDefs[index].users
                    , existsChilds: true
                    , nodeType: "favoriteGroup"
                    , headcount: 0
                    , onlineCount: 0
                    , id: Chat.favoriteGroupDefs[index].id + ''
                });
            } else {

            }
        });
        $.each(Chat.favoriteGroupDefs[0].users, function (i, elem) {
            children.push(elem);
        });
        favoriteFriendObj = {
            groupname: "常用联系人"
            , children: children
            , existsChilds: true
            , headcount: 0
            , onlineCount: 0
            , nodeType: "favoriteGroup"
            , id: Chat.favoriteGroupDefs[0].id
        };
        return favoriteFriendObj;
    },

    getAvailableFavoriteGroupDefs: function (contact) {
        var result = [];
        $.each(Chat.favoriteGroupDefs, function (i, elemGroup) {
            var notExistFlag = true;
            $.each(elemGroup.contacts, function (i, elemContact) {
                if (elemContact.contact == contact) {
                    return notExistFlag = false;
                }
            });
            !notExistFlag || result.push(elemGroup);
        });
        return result;
    },

    getFavoriteGroupDefById: function (favoriteGroupDefId) {
        var result = [];
        var index = Chat.getFavoriteGroupDefIndexById(favoriteGroupDefId);
        if (index > -1) {
            result = Chat.favoriteGroupDefs[index];
        }
        return result;
    },

    getFavoriteGroupDefIndexById: function (favoriteGroupDefId) {
        var result = -1;
        $.each(Chat.favoriteGroupDefs, function (i, elem) {
            if (elem.id == favoriteGroupDefId) {
                result = i;
                return false;
            }
        });
        return result;
    },

    //常用联系人
    getAllFavoriteFriends: function () {
        var friends = [];
        for (var index = 0; index < Chat.favoriteGroupDefs.length; index++) {
            $.each(Chat.favoriteGroupDefs[index].users, function (i, user) {
                var exist = false;
                $.each(friends, function (k, friend) {
                    if (user.id == friend.id) {
                        exist = true;
                        return false;
                    }
                });
                exist || friends.push(user);
            });
        }
        return friends;
    },

    //计算在线人数
    computeOnlineCount: function (orgDept) {
        var totalOnlineCnt = 0;
        if (orgDept) {
            orgDept.users && $.each(orgDept.users, function (i, user) {
                if (user.status === 'online') {
                    totalOnlineCnt = totalOnlineCnt + 1;
                }
            });
            orgDept.children && $.each(orgDept.children, function (i, child) {
                totalOnlineCnt = totalOnlineCnt + Chat.computeOnlineCount(child);
            });
            $('h5[data-id="' + orgDept.id + '"] p.onlinecount').html(totalOnlineCnt);
            orgDept.onlineCount = totalOnlineCnt;
        }
        return totalOnlineCnt;
    },

    //计算父节点在线人数
    computeParentOnlineCount: function (orgDept) {
        var totalOnlineCnt = 0;
        if(!orgDept){
            return totalOnlineCnt;
        }
        var parentOrgDept = Chat.getParentOrgDeptFromRoot(orgDept.id);
        if (parentOrgDept) {
            parentOrgDept.users && $.each(parentOrgDept.users, function (i, user) {
                if (user.status === 'online') {
                    totalOnlineCnt = totalOnlineCnt + 1;
                }
            });
            parentOrgDept.children && $.each(parentOrgDept.children, function (i, child) {
                totalOnlineCnt = (totalOnlineCnt + child.onlineCount);
            });
            $('h5[data-id="' + parentOrgDept.id + '"] p.onlinecount').html(totalOnlineCnt);
            parentOrgDept.onlineCount = totalOnlineCnt;
            Chat.computeParentOnlineCount(parentOrgDept);
        }
        return totalOnlineCnt;
    },

    //判断联系人是否已经在分组中存在
    isInFavoriteGroupDef: function (favoriteGroupDefId, contact) {
        var result = false;
        var favoriteGroupDef = Chat.getFavoriteGroupDefById(favoriteGroupDefId);
        if (favoriteGroupDef && favoriteGroupDef.contacts) {
            $.each(Chat.favoriteGroupDefs, function (i, elem) {
                if (elem.contact == contact) {
                    result = true;
                    return false;
                }
            });
        }
        return result;
    },

    //toSpread 是否展开展开一级目录
    lazyLevelContactTpl: function (friends, toSpread) {
        var html = '';

        for (var index = 0; index < friends.length; index++) {
            var item = friends[index];
            var spread = toSpread;//d.local["spread"+item.id];
            if ("children" in item) {
                html += '<h5 layim-event="spread"  data-nodeType="' + item.nodeType + '" data-id="' + item.id + '" data-name="' + item.groupname + '" lay-type="' + spread + '" title="' + item.groupname + '"><i class="layui-icon">';
                if (spread) {
                    html += '&#xe61a';
                } else {
                    html += '&#xe602';
                }
                html += '</i><span>' + item.groupname + '</span>';
                if (item.nodeType != 'favoriteGroup') {
                    html += '<em>(<cite class="layim-count">';
                    if (!!Chat.showOnlineCnt) {
                        html += '<p class="onlinecount">' + item.onlineCount + '</p>/<p class="headcount">' + item.headcount + "</p>";
                    } else {
                        html += '<p class="headcount">' + item.headcount + "</p>";
                    }
                    html += '</cite>)</em>';
                }
                html += '</h5>';
                html += '<ul class="layui-layim-list layim-list-friend  ';
                if (spread) {
                    html += ' layui-show';
                }
                html += '" data-id="' + item.id + '" >';
                if (item.children != null && toSpread) {
                    html += Chat.lazyLevelContactTpl(item.children, false);
                }
                html += '</ul>';
            } else {
                html += '<li  layim-event="chat" data-id="' + item.id + '" data-uname="' + item.username + '" data-sys-user-id="' + item.sysUserId + '" data-type="friend" data-index="';
                var indexInRoster = Chat.getFriendIndexInRoster(item);
                html += indexInRoster + '" class="layim-friend' + (item.id);
                if (item.favorite) {
                    html += '" title="' + layui.data.joinDeptOrgs(Chat.Roster[indexInRoster]) + '"><img class="layim-friend' + (item.id)+ (item.status === "offline" ? ' layim-list-gray' : '')+ '" src="' + item.avatar + '"><span>' + item.username + '</span><p>';

                    if (item && item.status == "online") {
                        html += '<i class="layui-icon layim-chat-status layim-chat-status-online" data-id="' + item.id + '" title="在线"></i>';
                    } else if (item && item.status == "offline") {
                        html += '<i class="layui-icon layim-chat-status layim-chat-status-offline" data-id="' + item.id + '" title="离线"></i>';
                    }
                    html += item.positionName + '</p><p>' + (item.remark || item.sign || "") + '</p><span class="layim-msg-status">new</span></li>';
                } else {
                    html += '" title="' + layui.data.joinDeptOrgs(Chat.Roster[indexInRoster]) + '"><img class="lazy layim-friend'+(item.id)+ (item.status === "offline" ? ' layim-list-gray' : '')+'"  data-original="' + item.avatar + '"><span>' + item.username + '</span><p>';
                    if (item && item.status == "online") {
                        html += '<i class="layui-icon layim-chat-status layim-chat-status-online" data-id="' + item.id + '"  title="在线"></i>';
                    } else if (item && item.status == "offline") {
                        html += '<i class="layui-icon layim-chat-status layim-chat-status-offline" data-id="' + item.id + '" title="离线"></i>';
                    }
                    html += item.positionName + '</p><p>' + (item.remark || item.sign || "") + '</p><span class="layim-msg-status">new</span></li>';
                }
            }

        }
        return html;
    },

    //多级通讯录模板
    //toSpread 是否展开展开一级目录
    listMultiLevelContactTpl: function (friends, toSpread) {
        var html = '';

        for (var index = 0; index < friends.length; index++) {
            var item = friends[index];
            var spread = toSpread;//d.local["spread"+item.id];
            if ("list" in item) {

                html += '<h5 layim-event="spread"  layim-event="chatopenUserTree" data-id="' + item.id + '" data-name="' + item.groupname + '" lay-type="' + spread + '"><i class="layui-icon">';
                if (spread) {
                    html += '&#xe61a';
                } else {
                    html += '&#xe602';
                }
                html += '</i><span>' + item.groupname + '</span><em>(<cite class="layim-count"> ';
                html += (item.list || []).length;
                html += '</cite>)</em></h5>';
                html += '<ul class="layui-layim-list layim-list-friend  ';
                if (spread) {
                    html += ' layui-show';
                }
                html += '" data-id="' + item.id + '" >';

                html += Chat.listMultiLevelContactTpl(item.list, false);
                html += '</ul>';
            } else {
                var sysUserId = item.avatar.substring(item.avatar.lastIndexOf('sysUserId=') + 10);
                html += '<li  layim-event="chat" data-id="' + item.id + '" data-uname="' + item.username + '" data-sys-user-id="' + sysUserId + '" data-type="friend" data-index="';
                var indexInRoster = Chat.getFriendIndexInRoster(item);
                html += indexInRoster + '" class="layim-friend' + (item.id + (item.status === "offline" ? ' layim-list-gray' : ''));
                html += '" title="' + layui.data.joinDeptOrgs(Chat.Roster[indexInRoster]) + '"><img src="' + item.avatar + '"><span>' + item.username + '</span><p>' + item.secretLevel + '</p><p>' + (item.remark || item.sign || "") + '</p><span class="layim-msg-status">new</span></li>';
            }

        }
        return html;
    },

    //获取在线用户
    getConnectedUsers: function () {
        var connectedUsers = [];
        if ('online' != Chat.currentUser.status) {
            return connectedUsers;
        }
        $.ajax({
            url: './im/XmppController/getConnectedUsers',
            type: "POST",
            dataType: "json",
            async: false,
            success: function (data) {
                connectedUsers = data;
            },
            error: function (err, msg) {
                Chat.log("发生异常");
            }
        });
        return connectedUsers;
    },

    //获取用户在线状态
    getUserStatus: function (jid) {
        var result = 'offline';
        $.ajax({
            type: "post",
            url: "./im/XmppController/getUserStatus/"+jid,
            cache: false,
            async : false,
            dataType : "json",
            success : function (data) {
                result = data.responseBody;
            },
            error : function (msg) {
            }
        });
        return result;
    },

    //设置用户在线
    setOnline: function (userOnline, userList) {
        layui.each(userList, function (index, time) {
            if ("list" in time) {
                Chat.setOnline(userOnline, time.list);
            } else {
                layui.each(userOnline, function (index, user) {
                    if (userOnline.indexOf(time.id) < 0) {
                        time.status = 'offline';
                    } else {
                        time.status = 'online';
                    }
                })
            }
        });
        return userList;
    },

    getRosterArrayFromMultipleLevel: function (friends) {
        var arr = [];
        for (var index = 0; index < friends.length; index++) {
            var item = friends[index];
            if ("list" in item) {
                var a = Chat.getRosterArrayFromMultipleLevel(item.list);
                arr = arr.concat(a);
            } else {
                arr.push(item);
            }
        }
        return arr;
    },

    getFriendIndexInRoster: function (friend) {
        for (var index = 0; index < Chat.Roster.length; index++) {
            var item = Chat.Roster[index];
            if (friend.id === item.id) {
                return index;
            }
        }
        return -1;
    },

    //根据id从通讯录中获取用户信息
    getUserInfoById: function (id) {
        for (var index = 0; index < Chat.Roster.length; index++) {
            var temp = Chat.Roster[index];
            if (temp.id == id) {
                return temp;
            }
        }
        return null;
    },

    //根据id从通讯录中获取群聊信息
    getRoomInfoById: function (id) {
        for (var index = 0; index < Chat.mucRooms.length; index++) {
            var temp = Chat.mucRooms[index];
            if (temp.id == id) {
                return temp;
            }
        }
        return Chat.getRoomFromServer(id);
    },

    //根据id从服务器获取群聊信息,并缓存到本地
    getRoomFromServer: function (id) {
        var roomObj;
        $.ajax({
            type: "Post", //Post传参
            url: "./im/ImRoomController/getImRoomById/" + id,//服务地址
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            async : false,
            success: function (result) {
                roomObj = result;
            }
        });
        return Chat.addToMucRoom(roomObj);
    },

    //根据id从服务器获取群成员列表
    getRoomMembers: function (id) {
        var roomMembers = [];
        $.ajax({
            type: "Post", //Post传参
            url: "./im/ImRoomController/getImRoomById/" + id,//服务地址
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            async : false,
            success: function (result) {
                if (result && result.members) {
                    // 群创建者放在首位
                    if (result.creator) {
                        roomMembers.push(result.creator);
                    }
                    var members = result.members.split(',');
                    for (var i = 0; i < members.length; i++) {
                        if (members[i] != result.creator) {
                            roomMembers.push(members[i]);
                        }
                    }
                }
            }
        });
        return roomMembers;
    },

    //获取所有群聊的id，使用逗号分隔
    getAllRoomIds: function () {
        var ids = [];
        for (var index = 0; index < Chat.mucRooms.length; index++) {
            var temp = Chat.mucRooms[index];
            ids.push(temp.id );
        }
        return ids;
    },

    //获取房间创建者 管理员 全部成员
    getRoomOwnerAll: function (room, success, fail) {
        $.ajax({
            url: './im/XmppController/getRoomAffiliations/'+room,
            type: "POST",
            contentType: 'application/json',
            dataType: 'json',
            async : false,
            success: function (data, textStatus, jqXHR) {
                success && success(data);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                fail && fail((jqXHR && jqXHR.responseJSON)||textStatus);
            }
        });
    },

    //聊天室授予权限
    setRoomAffiliation: function (room, userId, affiliation) {
        var rtn = false;
        var postData = {domain: room, username: userId, affiliation:(affiliation || "admin")};
        $.ajax({

            type: "post",
            url: './im/XmppController/setRoomAffiliation',
            data: postData,
            cache: false,
            dataType: "json",
            async : false,
            success: function (data) {
                rtn = true;
            },
            error: function () {
                rtn = false;
            }
        });
        return rtn;
    },

    //树行选人弹框
    getUserTeam: function (layui, selectIds, type, success, fail) {
        var result = [];
        var selectedUserString='';
        var existUsersArr = new Array();
        var selectedUsersArr = new Array();
        var userSuccess = function (data) {
            var indexLoad = layer.load(1, {zIndex: 99999999999999999, time: 10 * 1000});
            for(var i=0;i<selectIds.length;i++){
                selectedUsersArr.push(selectIds[i].id);
                selectedUserString += '<li style="float:left;width:105px;text-align:center;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;margin:5px auto;vertical-align: '
                    +'middle;border:solid 1px #c7dbec;background-color:#f2f2f2;margin-right:10px;height:20px;line-height: 20px; " title="'
                    + layui.data.joinDeptOrgs(selectIds[i])+ '">'+selectIds[i].username+'</li>';
            }
            var stringContent='<div style="width:100%;height:100%;border-bottom: solid 1px lightgray;">'
                +'<div style="width: 45%;margin-top:30px;height:469px;float:left;border-right:solid 1px lightgray;overflow-y:auto" class="user_team_box" >'
                +'<div class="search-user-in-tree" id="search-user-in-tree" style="position:absolute;width:795px">'
                +'<input style="width:45%" name="searchKey" placeholder="输入名称后按回车键显示检索结果"/>'
                +'<label class="layui-icon" style="right:55%" title="清空检索框">&#x1007;</label>'
                +'</div>'
                +'<div style="width:99%;float:left;display:inline-block;overflow-y:auto;" id="userTree" ></div>'
                +'<div style="width:99%;float:left;display:none;overflow-y:auto;background-color:#f9f9f9;" id="userTreeSearchResult" ></div>'
                +'</div>'
                +'<div style="width:46%;height:498px;position:fixed; right: 0;top: 43px;border-left:solid lightgray 1px;">'
                +'<div class="insideMumbers" style="margin-top:20px;padding-top:4px;background-color:#fbfafa;height:225px;overflow:auto;border-bottom:solid 1px lightgray;padding-left:10px;">'
                +'<p style="top:42px;height:25px;line-height:25px;background-color: wheat;position: fixed;width: 367px;right: 0px;padding-left: 10px;">已添加用户<span>('+selectIds.length+'人)</span></p>'
                +'<ul>'
                +selectedUserString
                +'</ul></div>'
                +'<div class="possibleMumbers" style="height:220px;overflow:auto;padding-left:10px;margin-top:20px;">'
                +'<p style="padding-left:10px;height: 25px;background-color: lightgray;line-height: 25px; position: fixed;width: 367px;right: 0;top:288px;">待添加用户<span></span></p>'
                +'<ul style="margin-top:5px;"></ul>'
                +'</div>'
                +'</div>'
                +'<button class="addUser layui-btn" style="cursor:pointer; position:fixed;left:369px;bottom: 37%;'
                +'background-color:#dddddd"  title="添加至"><i class="layui-icon" style="color:black">&#xe65b;</i></button>'
                +'</div>';

            //弹框
            layer.open({
                type: 1
                , title: "请选择用户" //显示标题栏
                //, offset: 'b'
                , id: 'exitToGroup' //防止重复弹出
                ,area:["800px","600px"]
                ,content:stringContent
                //, btn: '关闭全部'
                , btnAlign: 'c' //按钮居中
                //, shade: 0 //不显示遮罩
                , btn: ['确认', '取消']
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
                , yes: function (index) {
                    layer.close(index);
                    if (success) {
                        var indexLoad = layer.load(1, {zIndex: 99999999999999999, time: 10 * 1000});
                        var orgAndDeptList = [];
                        var searchVal = $('.search-user-in-tree').find('input').val().replace(/\s/);
                        //去掉重复数据
                        success(removeDuplicate(result));
                        layer.close(indexLoad);
                    }
                }
            });

            var nudes = createTree([data]);
            $("#userTree").html('');
            var input = $('#search-user-in-tree').find('input[name=searchKey]');
            input.off('keyup');
            input.on('keyup', function (event) {
                if(event.keyCode == 13){
                    searchUserInTree();
                }
            });

            $(".addUser").on('click', function () {
                var orgAndDeptList = [];
//                result = [];
                var chosenArr=[];
                var invitedUsersArr = new Array();
                for(var i=0;i<$(".possibleMumbers ul li").length;i++){
                    chosenArr.push($($(".possibleMumbers ul li")[i]).attr("class"));
                }
                //选择树节点数据后放到result中
                if($('#userTree').css("display")=="block"){
                    //遍历所有被选中节点
                    $.each($('#userTree input[name=checkboxUser]:checked'), function () {
                        var dataType = $(this).data('type');
                        var userObject = Chat.getUserInfoById($(this).val());
                        var userTitle = layui.data.joinDeptOrgs(userObject);
                        if (dataType == true) {
                            var nodetype = $(this).data('nodetype');
                            //找出选中的所有部门或者组织
                            if (typeof nodetype != "undefined") {
                                orgAndDeptList.push($(this).val());
                                //获取组织或者部门下所有用户
                                var allUsers = getAllUsersInOrgDepts(orgAndDeptList);
                                layui.each(allUsers, function (index, user) {
                                    var userTitle=layui.data.joinDeptOrgs(user);
                                    if(result.length>0){
                                        if($.inArray(user.id,chosenArr)<0){
                                            result.push({id: user.id, name: user.username,title:userTitle});
                                        }
                                    }else{
                                        result.push({id: user.id, name: user.username,title:userTitle});
                                    }
                                });
                            }
                        } else {
                            if(result.length>0){
                                if($.inArray($(this).val(), chosenArr)<0){
                                    result.push({id: userObject.id, name: userObject.username,title:userTitle});
                                }
                            }else{
                                result.push({id: userObject.id, name: userObject.username,title:userTitle});
                            }
                        }
                    });
                }

                //搜索后将所选择的人员数据 放到result中
                if($('#userTreeSearchResult').css("display")=="block"){
                    //遍历所有被选中搜索节点
                    $.each($('#userTreeSearchResult input[name=checkboxUser]:checked'), function () {
                        var userObject = Chat.getUserInfoById($(this).val());
                        var userTitle = layui.data.joinDeptOrgs(userObject);
                        if(result.length>0){
                            if($.inArray($(this).val(), chosenArr)<0){
                                result.push({id: userObject.id, name: userObject.username,title:userTitle});
                            }
                        }else{
                            result.push({id: userObject.id, name: userObject.username,title:userTitle});
                        }
                    });
                }
                result = removeDuplicate(result);

                //判断是否是已添加人员
                var existUserNames="";
                existUsersArr=[];
                invitedUsersArr=[];
                for (var i = 0; i < result.length; i++) {
                    var index = $.inArray(result[i].id, selectedUsersArr);
                    if (index >= 0) {
                        existUsersArr.push(result[i].id);
                        existUserNames+='【'+result[i].name+'】'+' ';
                    } else {
                        invitedUsersArr.push(result[i]);
                    }
                }
                result=invitedUsersArr;
                if(existUsersArr.length>0){
                    var alertMsg = existUserNames + ' 已经存在。';
                    layer.alert(alertMsg, {
                        title: '提示'
                        , shade: false
                    });
                }

                //待添加人员字符串
                var waitingAddUserString="";
                for(var i=0;i<invitedUsersArr.length;i++){
                    if(chosenArr.length>0){
                        if($.inArray(result[i].id, chosenArr)<0){
                            waitingAddUserString +=  '<li  title="'+result[i].title
                                +'" style="margin-top:5px;margin-right:10px;float:left;cursor:pointer;'
                                +'text-align:center;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;width:105px;'
                                +'position:relative;height:20px;border:solid 1px lightgray;line-height:20px;" class="'+result[i].id+'">'
                                +result[i].name+'<span data-type="exit" layim-event="remove_waitingUser"  class="clearUser"'
                                +'style="display:none;position: absolute;top:0;right:-2px;padding: 0px 1px" '
                                +'"color: #333;cursor: pointer;z-index:99"  title="移出"><i class="layui-icon" >&#x1007;</i></span></li>';
                        }
                    }else{
                        waitingAddUserString +=  '<li title="'+result[i].title
                            +'" style="margin-top:5px;margin-right:10px;float:left;width:105px;cursor:pointer;position:relative;'
                            +'text-align:center;overflow:hidden;text-overflow:ellipsis;white-space: nowrap;'
                            +'position:relative;height:20px;border:solid 1px lightgray;line-height:20px;" class="'+result[i].id+'">'
                            +result[i].name+'<span data-type="exit"  layim-event="remove_waitingUser"  class="clearUser"'
                            +'style="display:none;position: absolute;top:0;right:-2px;padding: 0px 1px" '
                            +'"color: #333;cursor: pointer;z-index:99"  title="移出"><i class="layui-icon" >&#x1007;</i></span></li>';
                    }
                }
                //将待添加人员放到"possibleMumbers ul"元素中
                $(".possibleMumbers ul").append(waitingAddUserString);
                $(".possibleMumbers p span").html("("+$(".possibleMumbers ul li").length+"人)");

                //悬浮出现删除按钮
                $(".possibleMumbers ul li").hover(
                    function(){
                        $(this).find("span").css("display","block");
                    },function(){
                        $(this).find("span").css("display","none");
                    }
                );

                //在待添加人员中删除人员方法
                $(".clearUser").off('click').on('click', function () {
                    var removeName=$(this).parent().attr("class");
                    $(this).parent().remove();
                    $(".possibleMumbers p span").html("("+$(".possibleMumbers ul li").length+"人)");
                    var index=0;
                    for(var i in result){
                        if(invitedUsersArr[i]["id"]==removeName){
                            index=i;
                            break;
                        }
                    }
                    invitedUsersArr.splice(index,1);
                    for(var i=0;i<$('#userTree input[name=checkboxUser]:checked').length;i++){
                        if($($('#userTree input[name=checkboxUser]:checked')[i]).val()==removeName){
                            $($('#userTree input[name=checkboxUser]:checked')[i]).prop("checked",false);
                        }
                    }
                    //搜索结果 显示
                    for(var i=0;i<$('#userTreeSearchResult input[name=checkboxUser]:checked').length;i++){
                        if($($('#userTreeSearchResult input[name=checkboxUser]:checked')[i]).val()==removeName){
                            $($('#userTreeSearchResult input[name=checkboxUser]:checked')[i]).prop("checked",false);
                        }
                    }
                });
            });

            $('#search-user-in-tree').find('label').on('click',cleanSearch);
            var tr = layui.tree({
                elem: '#userTree',
                nodes: nudes,
                click: function (node) {
                    choose(node);
                },
                open: function (tree, node, elem) {
                    if (node.existsChilds) {
                        openChildren(tree, node, elem);
                    }
                }
            });
            layer.close(indexLoad);
        };

        //搜索
        var searchUserInTree = function (e) {
            var userTree = $('#userTree');
            var searchResult = $('#userTreeSearchResult');
            var input = $('#search-user-in-tree').find('input');
            var val = input.val().trim();
            if (val) {
                userTree.css("display", "none");
                searchResult.css("display", "inline-block");
                var data = [];
                var html = '';
                for (var i = 0; i < Chat.Roster.length; i++) {
                    var itemE = Chat.Roster[i];
                    if (itemE.username.indexOf(val) !== -1 || itemE.id.indexOf(val) !== -1) {
                        itemE.index = i;
                        itemE.deptOrgStr = layui.data.joinDeptOrgs(itemE);
                        data.push(itemE);
                    }
                }
                if (data.length > 0) {
                    for (var l = 0; l < data.length; l++) {
                        var searchd = data[l];
                        html += '<li style="margin-left: 12px;" title="' + searchd.deptOrgStr + '"><a href="javascript:;"><cite><label layim-event="" style="font-weight:normal;font-family:Verdana,Arial,Helvetica, AppleGothic,sans-serif;"><input type="checkbox" value="' + searchd.id + '" name="checkboxUser" data-type="false" data-name="' + searchd.username + '" data-nodetype="undefined" id="' + searchd.id + '" lay-skin="primary" style="margin:0;vertical-align:middle"><span style="vertical-align:middle;padding-left:5px">' + searchd.username + '</span></label></cite></a></li>';
                    }
                } else {
                    html = '<li class="layim-null">无搜索结果</li>';
                }
                searchResult.html(html);
            } else {
                userTree.css("display", "inline-block");
                searchResult.css("display", "none");
            }
            input.focus();
        };

        //清除搜索框
        var cleanSearch = function () {
            $('#search-user-in-tree').find('input').val('');
            $('#userTree').css("display", "inline-block");
            $('#userTreeSearchResult').css("display", "none");
        };

        //选中或者反选
        var choose = function (node) {
            if (node && node.children && node.children.length > 0) {
                layui.each(node.children, function (index, children) {
                    $("input:checkbox[id=" + children.id + "]").prop("checked", $("#" + node.id).is(":checked"));
                    if (children.children && children.children.length > 0) {
                        choose(children);
                    }
                })
            }
        };

        //创建树 数据
        var createTree = function (data, start) {
            var arr = [];
            layui.each(data, function (index, item) {
                var user = (item.groupname ? item.groupname : item.username);
                if (type) {
                    user = '<label layim-event="" style="font-weight:normal;font-family:Verdana,Arial,Helvetica, AppleGothic,sans-serif;"><input  type="checkbox"  value="' + item.id + '" name="checkboxUser" data-type="' + (item.groupname ? true : false) + '" data-name="' + user + '" data-nodetype="' + item.nodeType + '"  id="' + item.id + '" lay-skin="primary" ' + (selectIds.indexOf(item.id) != -1 ? 'checked="true"' : '') + '  style="margin:0;vertical-align:middle"><span style="vertical-align:middle;padding-left:5px">' + user + '</span></label>';
                }
                var user = {
                    name: user,
                    id: item.id,
                    children: item ? item.children : [],
                    check: true,
                    nodeType: item.nodeType,
                    existsChilds: item.existsChilds,
                    users: item.users
                };
                arr.push(user)
            });
            return arr;
        };

        //从本地缓存中获取组织部门下所有用户
        var getAllUsersInOrgDepts = function (orgDeptIds) {
            var allUsers = [];
            if (orgDeptIds && orgDeptIds.length) {
                layui.each(orgDeptIds, function (index) {
                    var orgDept = Chat.getOrgDeptFromRoot(orgDeptIds[index]);
                    var subAllUsers = Chat.getAllUserFromObj(orgDept);
                    layui.each(subAllUsers, function (i) {
                        allUsers.push(subAllUsers[i]);
                    });
                });
            }
            return allUsers;
        };

        //去掉重复记录
        var removeDuplicate = function (list) {
            var r = [];
            for (var i = 0; i < list.length; i++) {
                var flag = true;
                var temp = list[i];
                for (var j = 0; j < r.length; j++) {
                    if (temp.id === r[j].id) {
                        flag = false;
                        break;
                    }
                }
                if (flag) {
                    r.push(temp);
                }
            }
            //按照id排序
            r.sort(function (sortA, sortB) {
                return sortA.id.localeCompare(sortB.id);
            });
            return r;
        };

        //懒加载创建子节点
        var openChildren = function (tree, node, elem) {
            var pid = node.id;
            var orgDept = Chat.getOrgDeptFromRoot(pid);
            var data = Chat.getUserAndDeptsFromObj(orgDept);
            var nudes = createTree(data);
            var node = null;
            layui.each(elem[0].childNodes, function (i, tim) {
                if (tim.tagName == 'UL') {
                    node = tim;
                }
            });
            $(node).html('');
            tree.tree($(node), nudes, pid);
        };

        //初始化
        if (userSuccess) {
            userSuccess(Chat.rootOrgDept);
            //展开第一层组织
            setTimeout(function () {
                $('#userTree > li > i').click();
            }, 500);
        }

    },

    //树行选组织部门弹框
    getOrgDepts: function (layui, selectIds, success, fail) {
        var result = [];

        var userSuccess = function (data) {
            var nudes = createOrgDeptTree(data);
            var indexLoad = layer.load(1, {zIndex: 99999999999999999, time: 10 * 1000});
            //弹框
            layer.open({
                type: 1
                , title: "请选择组织部门" //显示标题栏
                , offset: 'selectOrgDepts'
                , id: 'selectOrgDepts' //防止重复弹出
                , content: '<div style="width: 300px;height: 300px;" class="org_dept_box" ><div style="width: 100%;height: 100%;float: left;display: inline-block;" id="orgDeptTree" ></div></div>'
                //, btn: '关闭全部'
                , btnAlign: 'c' //按钮居中
                , btn: ['确认', '取消']
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
                , yes: function (index) {
                    layer.close(index);
                    if (success) {
                        var indexLoad = layer.load(1, {zIndex: 99999999999999999, time: 10 * 1000});
                        $.each($('#orgDeptTree input[name=checkboxOrgDept]:checked'), function () {
                            result.push({id: $(this).val()
                                , name: $(this).data('name')
                                , fullId: ($(this).data('parentorgdeptids')?$(this).data('parentorgdeptids')+','+$(this).val():$(this).val())
                                , parentIds: $(this).data('parentorgdeptids')
                                , parentNames: $(this).data('parentorgdeptnames')
                            });
                        });
                        result = removeDuplicateOrgDept(result);
                        success(result);
                        layer.close(indexLoad);
                    }
                }
            });

            $("#orgDeptTree").html('');

            var tr = layui.tree({
                elem: '#orgDeptTree',
                nodes: nudes,
                click: function (node) {
                    chooseOrgDept(node);
                },
                open: function (tree, node, elem) {
                    if (node.existsChilds && node.children.length === 0) {
                        openChildren(tree, node, elem);
                    }
                }
            });
            layer.close(indexLoad);
        };

        //选中或者反选
        var chooseOrgDept = function (node) {
            var checkStatus = $("#" + node.id).is(":checked");
            node.check = checkStatus;
            if (node && node.children && node.children.length > 0) {
                layui.each(node.children, function (index, child) {
                    child.check = checkStatus;
                    $("input:checkbox[id=" + child.id + "]").prop("checked", checkStatus);
                    if (child.children && child.children.length > 0) {
                        choose(child);
                    }
                })
            }
        };

        //创建树 数据
        var createOrgDeptTree = function (data, parentOrgDepts) {
            var arr = [];
            layui.each(data, function (index, item) {
                var html = '<label layim-event="" style="font-weight:normal;font-family:Verdana,Arial,Helvetica, AppleGothic,sans-serif;">';
                html = html + '<input  type="checkbox"  value="' + item.id + '" name="checkboxOrgDept" data-nodetype="' + item.nodeType + '" data-name="' + item.groupname + '" id="' + item.id + '" lay-skin="primary" ' + (selectIds.indexOf(item.id) != -1 ? 'checked="true"' : '');
                if (parentOrgDepts && parentOrgDepts.length) {
                    var parentOrgDeptIds = [];
                    var parentOrgDeptNames = [];
                    layui.each(parentOrgDepts, function (index, parent) {
                        parent && parent.id && parentOrgDeptIds.push(parent.id);
                        parent && parent.groupname && parentOrgDeptNames.push(parent.groupname);
                    });
                    if (parentOrgDeptIds && parentOrgDeptIds.length) {
                        html = html + ' data-parentorgdeptids="' + parentOrgDeptIds.join(',') + '"';
                    }
                    if (parentOrgDeptNames && parentOrgDeptNames.length) {
                        html = html + ' data-parentorgdeptnames="' + parentOrgDeptNames.join(' &gt;&gt; ') + '"';
                    }
                }
                html = html + '  style="margin:0;vertical-align:middle">';
                html = html + '<span style="vertical-align:middle;padding-left:5px">' + item.groupname + '</span></label>';
                var orgDeptObj = {
                    name: html,
                    id: item.id,
                    children: item.children ? item.children : [],
                    check: (selectIds.indexOf(item.id) != -1),
                    nodeType: item.nodeType,
                    existsChilds: true,
                    groupname: item.groupname,
                    parentOrgDepts: parentOrgDepts || []
                };
                arr.push(orgDeptObj);
            });
            return arr;
        };

        //懒加载创建子节点
        var openChildren = function (tree, node, elem) {
            var pid = node.id;
            $.ajax({
                type: "post", //Post传参
                url: "./im/ImOrgController/getSubOrgDepts/" + pid,
                dataType: "json",
                success: function (result) {
                    if (result && result.length) {
                        var parentOrgDepts = [];
                        layui.each(node.parentOrgDepts, function (i, parent) {
                            parentOrgDepts.push(parent);
                        });
                        parentOrgDepts.push(node);
                        var nudes = createOrgDeptTree(result, parentOrgDepts);
                        var nodeTemp = null;

                        layui.each(elem[0].childNodes, function (i, tim) {
                            if (tim.tagName == 'UL') {
                                nodeTemp = tim;
                            }
                        });
                        $(nodeTemp).html('');
                        tree.tree($(nodeTemp), nudes, pid);

                    } else {
                        node.existsChilds = false;
                    }
                },
                error: function (e) {
                }
            });

        };

        //去除重复项,合并父子项
        var removeDuplicateOrgDept = function (items) {
            var selectedIds = [];
            var actualIds = [];
            var actualItems = [];
            if (!items || items.length == 0) {
                return;
            }
            layui.each(items, function (i, item) {
                selectedIds.push(item.fullId)
            });
            selectedIds.sort(function (sortA, sortB) {
                return sortA.localeCompare(sortB);
            });
            layui.each(selectedIds, function (i, item) {
                var alreadyExist = false;

                layui.each(actualIds, function (k) {
                    if (item.indexOf(actualIds[k]) > -1) {
                        alreadyExist = true;
                        return false;
                    }
                });
                if (!alreadyExist) {
                    actualIds.push(item);
                }
            });

            for (var i = 0; i < actualIds.length; i++) {
                layui.each(items, function (k, item) {
                    if (item.fullId == actualIds[i]) {
                        actualItems.push(item);
                    }
                });
            }
            return actualItems;
        };

        //初始化
        if (userSuccess) {
            $.ajax({
                type: "post", //Post传参
                url: "./im/ImOrgController/getSubOrgDepts/-1",
                dataType: "json",
                success: function (result) {
                    userSuccess(result);
                },
                error: function (e) {
                }
            });
        }

    },

    //选联系人或群组
    selectFriendOrGroup: function (success){
        var userSuccess = function () {
            var indexLoad = layer.load(1, {zIndex: 99999999999999999, time: 10 * 1000});
            //弹框
            layer.open({
                type: 1
                , title: "选择联系人或群组" //显示标题栏
                , offset: 'selectFriendOrGroup'
                , id: 'selectFriendOrGroup' //防止重复弹出
                , content: '<div style="width: 300px;height: 300px;" class="user_team_box" ><div class="search-user-in-tree" id="search-friend-group"><input name=”searchKey" placeholder="输入名称后按回车键显示检索结果"/><label class="layui-icon" title="清空检索框">&#x1007;</label></div><div style="width: 100%;height: 100%;float: left;display: inline-block;" id="friendGroupResult" ></div></div>'
                //, btn: '关闭全部'
                , btnAlign: 'c' //按钮居中
                , btn: ['确认', '取消']
                , success: function (layero) {
                    layero.on('contextmenu', function (event) {
                        event.cancelBubble = true;
                        event.returnValue = false;
                        return false;
                    });
                }
                , yes: function (index) {
                    layer.close(index);
                    if (success) {
                        var indexLoad = layer.load(1, {zIndex: 99999999999999999, time: 10 * 1000});
                        var selectedFriendGroup = [];
                        var searchVal = $('#search-friend-group').find('input').val().replace(/\s/);
                        if (searchVal) {
                            $.each($('#friendGroupResult input[name=checkboxFriendGroup]:checked'), function () {
                                var type = $(this).data('type');
                                if(type === 'friend'){
                                    var item = Chat.getUserInfoById($(this).val());
                                    if(item){
                                        selectedFriendGroup.push(item);
                                    }
                                } else if(type === 'group'){
                                    var item = Chat.getRoomInfoById($(this).val());
                                    if(item){
                                        selectedFriendGroup.push(item);
                                    }
                                }
                            });
                        }
                        success(selectedFriendGroup);
                        layer.close(indexLoad);
                    }
                }
            });

            var input = $('#search-friend-group').find('input');
            input.off('keyup');
            input.on('keyup', function (event) {
                if(event.keyCode == 13){
                    searchFriendAndGroup();
                }
            });
            $('#search-friend-group').find('label').on('click',cleanSearch);
            input.focus();

            //$("#orgDeptTree").html('');
            layer.close(indexLoad);
        };

        var searchFriendAndGroup = function () {
            var userTree = $('#search-friend-group');
            var searchResult = $('#friendGroupResult');
            var input = userTree.find('input');
            var val = input.val().replace(/\s/);
            if (val) {
                var data = [];
                var html = '';
                for (var i = 0; i < Chat.Roster.length; i++) {
                    var itemE = Chat.Roster[i];
                    if (itemE.username.indexOf(val) !== -1 || itemE.id.indexOf(val) !== -1) {
                        itemE.index = i;
                        itemE.deptOrgStr = layui.data.joinDeptOrgs(itemE);
                        data.push(itemE);
                    }
                }
                for (var i = 0; i < Chat.mucRooms.length; i++) {
                    var itemE = Chat.mucRooms[i];
                    if (itemE.chatname.indexOf(val) !== -1 ) {
                        itemE.index = i;
                        data.push(itemE);
                    }
                }
                if (data.length > 0) {
                    for (var l = 0; l < data.length; l++) {
                        var searchd = data[l];
                        if(searchd.type === 'group'){
                            html += '<li style="margin-left: 12px;" title="['+(searchd.temporary?"临时会话":"群组")+']' + searchd.chatname + '"><a href="javascript:;"><cite><label layim-event="" style="font-weight:normal;font-family:Verdana,Arial,Helvetica, AppleGothic,sans-serif;"><input type="checkbox" value="' + searchd.id + '" name="checkboxFriendGroup" data-type="group" data-name="' + searchd.chatname + '" lay-skin="primary" style="margin:0;vertical-align:middle"><span style="vertical-align:middle;padding-left:5px">' + searchd.chatname + '</span></label></cite></a></li>';
                        } else {
                            html += '<li style="margin-left: 12px;" title="[联系人]' + searchd.deptOrgStr + '"><a href="javascript:;"><cite><label layim-event="" style="font-weight:normal;font-family:Verdana,Arial,Helvetica, AppleGothic,sans-serif;"><input type="checkbox" value="' + searchd.id + '" name="checkboxFriendGroup" data-type="friend" data-name="' + searchd.username + '" lay-skin="primary" style="margin:0;vertical-align:middle"><span style="vertical-align:middle;padding-left:5px">' + searchd.username + '</span></label></cite></a></li>';
                        }
                    }
                } else {
                    html = '<li class="layim-null">无搜索结果</li>';
                }
                searchResult.html(html);
            } else {
                searchResult.html('');
            }
            input.focus();
        };

        //清除搜索框
        var cleanSearch = function () {
            $('#search-friend-group').find('input[name=searchKey]').val('');
            $('#friendGroupResult').html('');
        };

        //初始化
        userSuccess();
    }
};
