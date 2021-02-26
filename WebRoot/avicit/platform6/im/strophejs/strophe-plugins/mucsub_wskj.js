Strophe.addConnectionPlugin('mucsub_wskj', {
	init : function(connection) {
		this.connection = connection;
		
	},
	//订阅群组
	//昵称不同 即可修改昵称
	subscribe : function(roomJid,nickname,password,succss_cb,fail_cb) {
		var iq = $iq({
              type: 'set',
              from: this.connection.jid, 
              to : roomJid
        }).c('subscribe', {xmlns: 'urn:xmpp:mucsub:0', nick: nickname, password: password})
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:presence'}).up()
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:subject'}).up()
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:system'}).up()
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:messages'}).up()
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:affiliations'}).up()
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:subject'}).up()
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:config'}).up();
        var stanza = iq.tree();
        Chat.connection.sendIQ(stanza, succss_cb,  fail_cb);

		return true;
	},
	//管理员把别人拉入群组
    subscribeByAdmin : function(userJid,roomJid,nickname,password,succss_cb,fail_cb) {
        if(nickname == null) {
            nickname = Chat.getBareIdFromJid(userJid);
        }
        var iq = $iq({
              type: 'set',
              from: this.connection.jid, 
              to : roomJid
        }).c('subscribe', {xmlns: 'urn:xmpp:mucsub:0',jid: userJid, nick: nickname, password: password})
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:presence'}).up()
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:subject'}).up()
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:system'}).up()
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:messages'}).up()
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:affiliations'}).up()
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:subject'}).up()
        .c('event', {'node': 'urn:xmpp:mucsub:nodes:config'}).up();
        var stanza = iq.tree();
        Chat.connection.sendIQ(stanza, succss_cb,  fail_cb);

        return true;
    },
    //退出群组订阅
    unsubscribe : function(roomJid,succss_cb,fail_cb) {
        var iq = $iq({
              type: 'set',
              from: this.connection.jid, 
              to : roomJid
        }).c('unsubscribe', {xmlns: 'urn:xmpp:mucsub:0'});
        var stanza = iq.tree();
        Chat.connection.sendIQ(stanza, succss_cb,  fail_cb);
        
        return true;
    },
    //管理员把成员踢出群组
    unsubscribeByAdmin : function(userJid, roomJid,succss_cb,fail_cb) {
        var iq = $iq({
              type: 'set',
              from: this.connection.jid, 
              to : roomJid
        }).c('unsubscribe', {xmlns: 'urn:xmpp:mucsub:0', jid: userJid});
        var stanza = iq.tree();
        Chat.connection.sendIQ(stanza, succss_cb,  fail_cb);

        return true;
    },
    //获取群组列表
    subscriptions : function(succss_cb,fail_cb) {
        var iq = $iq({
              type: 'get',
              from: this.connection.jid, 
              to : Chat.MUC_HOST
        }).c('subscriptions', {xmlns: 'urn:xmpp:mucsub:0'});
        var stanza = iq.tree();
        Chat.connection.sendIQ(stanza, succss_cb,  fail_cb);

        return true;
    },
    //获取群组成员列表 默认权限moderator
    members : function(roomJid,succss_cb,fail_cb) {
        var iq = $iq({
              type: 'get',
              from: this.connection.jid, 
              to : roomJid
        }).c('subscriptions', {xmlns: 'urn:xmpp:mucsub:0'});
        var stanza = iq.tree();
        Chat.connection.sendIQ(stanza, succss_cb,  fail_cb);
        return true;
    },
    //修改affiliation
    affiliation: function(roomJid, userJid, affiliation,succss_cb,fail_cb) {
         var iq = $iq({
              type: 'set',
              from: this.connection.jid, 
              to : roomJid
        }).c('query', {xmlns: 'http://jabber.org/protocol/muc#admin'})
        .c('item', {'nick': userJid.split('@')[0],'affiliation': affiliation,'jid': userJid}).up();
        var stanza = iq.tree();
        Chat.connection.sendIQ(stanza, function(a){Chat.log(a);},  function(a){Chat.log(a);});
    },
});