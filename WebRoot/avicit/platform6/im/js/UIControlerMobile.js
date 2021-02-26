
var mylayim;
var mylayer;



function initLayIM(mine, friend, group){
	layui.use('mobile', function(){
  var mobile = layui.mobile
  ,layim = mobile.layim,
  layer = mobile.layer;
	  	layim.config({
		    init: {
		        mine: mine,
		        friend: friend,
		        group: group
		    },
		    uploadImage: {
			    	  url: '/FileUpLoad'
		    	},
		    	uploadFile: {
		    		url: '/FileUpLoad'
		    	},
		    	isgroup: true
		    	
		});
		mylayim = layim;
		mylayer = layer;
		layim.on('sendMessage', function(data){
			if(data.to.type == 'chat' || data.to.type == 'friend' ) {
				//单聊
				//{"mine":{"username":"a@121.199.30.240","avatar":"avicit/platform6/im/image/icon.png","id":"a@121.199.30.240","mine":true,"content":"eqwed"},"to":{"username":"b@121.199.30.240","id":"0","avatar":"avicit/platform6/im/image/icon.png","sign":"","status":"onlne","name":"b@121.199.30.240","type":"friend"}}
				Chat.sendMessage(data.to.id + "@" + Chat.BOSH_SERVICE_HOST,data.mine.content,'chat');
			}else if(data.to.type == 'group') {
				//群聊
				//{"mine":{"username":"a1","avatar":"avicit/platform6/im/image/icon.png","id":"a1","mine":true,"content":"s"},"to":{"type":"group","avatar":"avicit/platform6/im/image/icon.png","groupname":"room6","id":"room6","members":"2","name":"room6"}}
				Chat.sendMessage(data.to.id + "@conference." + Chat.BOSH_SERVICE_HOST,data.mine.content,'groupchat');
			}
		});
		
		layim.on('newFriend', function(){
		    layim.panel({
		      title: '添加朋友' //标题
		      ,tpl: '<div style="padding: 10px;"><input style="width:100%; height:40px" id="accountuser" type="text" placeholder="账号" style="width: 200px; height: 30px;"/><br/><br/><input type="button" value="添加" style="width: 100%;" onclick="customAddUser()"/></div>' //模版
		      ,data: { //数据
		      }
		    });
	  	});
		  layim.on('newGroup', function(){
			    layim.panel({
			      title: '添加群组' //标题
			      ,tpl: '<div style="padding: 10px;"><input style="width:100%; height:40px" id="accountgroup" type="text" placeholder="账号" style="width: 200px; height: 30px;"/><br/><br/><input type="button" value="添加" style="width: 100%;" onclick="customAddNewGroup()"/></div>' //模版
			      ,data: { //数据
			      }
			    });
		  });
		  layim.on('detail', function(){
			    layim.panel({
			      title: '成员列表' //标题
			      ,tpl: '<div style="padding: 10px;">{{d.data.rows}}</div>'
			      ,data: { //数据
			      }
			    });
		  });
	}); 
}

function customAddUser(){
	var name = document.getElementById('accountuser').value;
	if(name == ""){
		 mylayer.open({
	        content: '<p style="padding-bottom: 5px;">请输入好友用户名</p></p>'
	        ,className: 'layim-about'
	        ,shadeClose: false
	        ,btn: '确定'
	      });
		return;
	}
	var jid = (name.indexOf("@") == -1) ? name + "@" + Chat.BOSH_SERVICE_HOST : name;
  	var username = jid;
  	if(Chat.userExists(jid)){
  		mylayer.open({
	        content: '<p style="padding-bottom: 5px;">该用户已是你的好友，不能重复添加</p></p>'
	        ,className: 'layim-about'
	        ,shadeClose: false
	        ,btn: '确定'
	     });
	      return;
  	}else{
  		mylayer.open({
	        content: '<p style="padding-bottom: 5px;">请求好友成功，请等待好友审核</p></p>'
	        ,className: 'layim-about'
	        ,shadeClose: false
	        ,btn: '确定'
	     });
	     Chat.subscribeUser(jid,null);
  	}
  	/*Chat.addUser(jid, username, false);*/
  
}
function customAddNewGroup(){
	var name = document.getElementById('accountgroup').value;
	if(name == ""){
		 mylayer.open({
	        content: '<p style="padding-bottom: 5px;">请输入群组名称</p></p>'
	        ,className: 'layim-about'
	        ,shadeClose: false
	        ,btn: '确定'
	      });
		return;
	}
	var jid = (name.indexOf("@") == -1) ? name + "@" + Chat.BOSH_SERVICE_HOST : name;
  	var username = jid;
  	var nickname = Chat.currentUser.jid.split("@")[0];
  	/*Chat.addUser(jid, username, false);*/
  	Chat.mucCreateRoom(name,nickname,
  		function(status){
				layer.alert('创建群组成功', {
					title: '提示'
					,shade: false
				});
				
				var dic = {
					type: 'group',
					avatar: "avicit/platform6/im/image/avatar.jpg",
					groupname: name,
					id: $(this).attr("jid").split("@")[0],
					members: 1
				};
				Chat.mucRooms.push(dic);
				addList(dic);
            },
            function(status){
				layer.alert('创建群组失败', {
					title: '提示'
					,shade: false
				});
            }
  	);
}
