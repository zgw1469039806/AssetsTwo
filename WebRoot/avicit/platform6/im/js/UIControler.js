
var mylayim;
function initLayIM(mine, friend, group){
	layui.use('layim', function(layim){
		mylayim = layim;
		layim.config({
			init: {
				mine: mine,
				friend: friend,
				group: group
			},
			uploadImage: false,
			uploadFile: false,
			debug: false, //用于开启调试模式，默认false，如果设为true，则JS模块的节点会保留在页面
			notice: true, //桌面消息通知
			voice: false, //新消息声音提醒
			refresh: true, //是否支持手动刷新好友在线状态
			//find: layui.cache.dir + 'css/modules/layim/html/find.html', //发现页面地址，若不开启，剔除该项即可
			findgroup: layui.cache.dir + 'css/modules/layim/html/findgroup.html', //发现页面地址，若不开启，剔除该项即可
			msgbox: layui.cache.dir + 'css/modules/layim/html/msgbox.html', //消息盒子页面地址，若不开启，剔除该项即可
			setting: layui.cache.dir + 'css/modules/layim/html/setting.html', //管理源设置
			chatLog: layui.cache.dir + 'css/modules/layim/html/chatlog.html',
			fileuploadPage: layui.cache.dir + 'css/modules/layim/html/fileupload.html',
			fileDownloadUrl: '/im/imFileUploadController/download?fileuploadBusinessId=imFileUpload&fileuploadBusinessTableName=null&encryption=&',
			fileuploadIsSaveToDatabase:'fastdfs' // fastdfs：文件存储于fastDFS服务器 true:文件存储于数据库；
		});
		//  TODO:有问题
		layim.on('friendRequestReceived', function(){
			if(Chat.msgboxData != null && Chat.msgboxData.length > 0 ){
				layim.msgbox(Chat.msgboxData.length);
			}
		});
		layim.off('sendMessage');
		layim.on('sendMessage', function(data){
			//console.log(Chat.msgboxData);
			//	console.log(JSON.stringify(data));
			//	console.log()
			if(data.to.type == 'chat' || data.to.type == 'friend' ) {
				//单聊
				//{"mine":{"username":"a@121.199.30.240","avatar":"avicit/platform6/im/image/icon.png","id":"a@121.199.30.240","mine":true,"content":"eqwed"},"to":{"username":"b@121.199.30.240","id":"0","avatar":"avicit/platform6/im/image/icon.png","sign":"","status":"onlne","name":"b@121.199.30.240","type":"friend"}}
				return Chat.sendMessage(data.to.id ,data.mine.content,'chat');
			}else if(data.to.type == 'group') {
				//群聊
				//{"mine":{"username":"a1","avatar":"avicit/platform6/im/image/icon.png","id":"a1","mine":true,"content":"s"},"to":{"type":"group","avatar":"avicit/platform6/im/image/icon.png","groupname":"room6","id":"room6","members":"2","name":"room6"}}
				return Chat.sendMessage(data.to.id ,data.mine.content,'groupchat');
			}
		});
		layim.off('receiveMessage');
		layim.on('receiveMessage', function(){
			if(Chat.msgboxData.length > 0 ){
				layim.msgbox(Chat.msgboxData.length);
			}
		});
		layim.off('chatChange');
		layim.on('chatChange', function(res){
			// console.log(res);
			var type = res.data.type;
			if(type === 'friend'){
				for (var i=0;i<Chat.msgs.length;i++) {
//			  		if(res.data.id==Chat.msgs[i].split("@")[0]){
//				  		if(Chat.chatStates[Chat.msgs[i]] != undefined){
//				  			layim.setChatStatus('<span style="color:#FF5722;">'+Chat.chatStates[Chat.msgs[i]]+'</span>'); 
//			  			}else{
//			  				layim.setChatStatus('<span style="color:#FF5722;">在线</span>'); //模拟标注好友在线状态
//			  			}
//			  		}else{
//			  			layim.setChatStatus('<span style="color:#FF5722;">在线</span>'); //模拟标注好友在线状态
//			  		}
				}
			} else if(type === 'group'){
//			    //模拟系统消息
//			    layim.getMessage({
//			      system: true //系统消息
//			      ,id: 111111111
//			      ,type: "group"
//			      ,content: '贤心加入群聊'
//			    });
			}
		});

		if(Chat.msgboxData != null && Chat.msgboxData.length > 0 ){
			layim.msgbox(Chat.msgboxData.length);
		};
		layim.on('online', function(status){
			//console.log(status); //获得online或者hide


		});

	});

}


String.prototype.replaceAll  = function(s1,s2){
	return this.replace(new RegExp(s1,"gm"),s2);
}
