/**
 * 流程按钮提示信息
 */
var ButtonTools = {
	
	img : {
		submit : getPath2()+"/static/images/platform/bpm/client/images/button/tijiao.png",
		bactchsubmit : getPath2()+"/static/images/platform/bpm/client/images/button/tijiao.png",
		jump : getPath2()+"/static/images/platform/bpm/client/images/button/tiaozhuan.png",
		retreattofirst : getPath2()+"/static/images/platform/bpm/client/images/button/tuihuikaishi.png",
		retreattoprev : getPath2()+"/static/images/platform/bpm/client/images/button/tuihuishangyibu.png",
		withdraw : getPath2()+"/static/images/platform/bpm/client/images/button/nahui.png",
		innerwithdraw : getPath2()+"/static/images/platform/bpm/client/images/button/nahui.png",
		transmit : getPath2()+"/static/images/platform/bpm/client/images/button/xunhuan.png",
		globalTransmit : getPath2()+"/static/images/platform/bpm/client/images/button/xunhuan.png",
		supersede : getPath2()+"/static/images/platform/bpm/client/images/button/zhuanban.png",
		supplement : getPath2()+"/static/images/platform/bpm/client/images/button/duzhe.png",
		end : getPath2()+"/static/images/platform/bpm/client/images/button/jihuo.png",
		suspend : getPath2()+"/static/images/platform/bpm/client/images/button/zanting.png",
		track : getPath2()+"/static/images/platform/bpm/client/images/button/genzhong.png",
		focustask : getPath2()+"/static/images/platform/bpm/client/images/button/guanzhu.png",
		idea : getPath2()+"/static/images/platform/bpm/client/images/button/fasongxiaoxi.png",
		adduser : getPath2()+"/static/images/platform/bpm/client/images/button/renyuan.png",
		adduserandsubmit : getPath2()+"/static/images/platform/bpm/client/images/button/renyuan.png",
		resume : getPath2()+"/static/images/platform/bpm/client/images/button/huifu.png",
		reader : getPath2()+"/static/images/platform/bpm/client/images/button/duzhe.png",
		taskreader : getPath2()+"/static/images/platform/bpm/client/images/button/duzhe.png",
		writeidea : getPath2()+"/static/images/platform/bpm/client/images/button/fasongxiaoxi.png",
		formsave : getPath2()+"/static/images/platform/bpm/client/images/button/save.png",
		wordcreate : getPath2()+"/static/images/platform/bpm/client/images/button/wordcreate.png",
		wordedit : getPath2()+"/static/images/platform/bpm/client/images/button/wordedit.png",
		wordread : getPath2()+"/static/images/platform/bpm/client/images/button/wordread.png",
		wordredtemplet : getPath2()+"/static/images/platform/bpm/client/images/button/wordredtemplet.png",
		userdefined : getPath2()+"/static/images/platform/bpm/client/images/button/zidingyclr.png"
		//TODO:新建设为关注图标
	},
	alt : {
		bactchsubmit : "流程批量提交",
		submit : "流程提交",
		jump : "流程跳转",
		retreattofirst : "流程退回开始节点",
		retreattoprev : "流程退回上一节点",
		withdraw : "流程拿回",
		innerwithdraw : "流程节点内拿回",
		transmit : "流程转发",
		supersede : "流程转办",
		supplement : "流程补发",
		end : "流程结束",
		suspend : "流程暂停",
		track : "流程跟踪",
		idea : "修改意见",
		adduser : "流程增发",
		adduserandsubmit : "增发并提交",
		resume : "流程恢复",
		reader : "流程读者",
		taskreader : "流程读者",
		globalTransmit : "全局转发",
		writeidea : "填写意见",
		formsave : "保存表单",
		wordcreate : "创建正文",
		wordedit : "编辑正文",
		wordread : "查看正文",
		wordredtemplet : "套红",
		focustask : "关注工作",
		userdefined : "自定义流程处理人"
	},
	visible : {
		bactchsubmit : "true",
		submit : "true",
		jump : "true",
		retreattofirst : "true",
		retreattoprev : "true",
		withdraw : "true",
		innerwithdraw : "true",
		transmit : "true",
		supersede : "true",
		supplement : "true",
		end : "true",
		suspend : "true",
		track : "true",
		idea : "true",
		adduser : "true",
		adduserandsubmit : "true",
		resume : "true",
		reader : "true",
		taskreader : "true",
		globalTransmit : "true",
		writeidea : "true",
		formsave : "true",
		wordcreate : "true",
		wordedit : "true",
		wordread : "true",
		wordredtemplet : "true",
		focustask : "true",
		userdefined : "true"
	}
};


/**
 * 流程按钮
 */
Button = function (){
	
	this.id = null;
	this.html = null;
 	this.buttonDiv = null;
	this.Buttons = new Array();
	this.ButtonsEvent = new Array();
	
	this.init = function(){
		this.buttonDiv = document.createElement("div");
		this.buttonDiv.setAttribute("id","toolbar_inner");
	};
	
	//改用了easyui的button
	this.createEasyUIButton = function(data){
		this.id = data.id || "_button_id_"+Math.random();
		var orderBy = data.orderBy || -1;
		var buttonName =  data.event;
		buttonName = buttonName.toLowerCase();
		var title = "";
		var img = "";
		var visible = "false";
		//var background = ButtonTools.img.background;
		//var onMouse = "";
		if(ButtonProcessing.ButtonName_Submit == buttonName){//流程提交
			title = ButtonTools.alt.submit;
			img = "bpmIcon-submit";
			visible = ButtonTools.visible.submit;
		}else if(ButtonProcessing.ButtonName_Track == buttonName){//流程跟踪
			title = ButtonTools.alt.track;
			img = "bpmIcon-track";
			visible = ButtonTools.visible.track;
		}else if(ButtonProcessing.ButtonName_Rejecttofirst == buttonName){//流程退回开始节点
			title = ButtonTools.alt.retreattofirst;
			img = "bpmIcon-retreattofirst";
			visible = ButtonTools.visible.retreattofirst;
		}else if(ButtonProcessing.ButtonName_Retreattoactivity == buttonName){//退回指定节点
			title = "退回到指定节点";
			img = "bpmIcon-retreattofirst";
			visible = ButtonTools.visible.retreattofirst;
		}else if(ButtonProcessing.ButtonName_Presstodo == buttonName){//催办
			title = "催办";
			img = "bpmIcon-retreattofirst";
			visible = ButtonTools.visible.retreattofirst;
		}else if(ButtonProcessing.ButtonName_Rejecttoprev == buttonName){//流程退回上一节点
			title = ButtonTools.alt.retreattoprev;
			img = "bpmIcon-retreattoprev";
			visible = ButtonTools.visible.retreattoprev;
		}else if(ButtonProcessing.ButtonName_Withdraw == buttonName){//流程拿回
			title = ButtonTools.alt.withdraw;
			img = "bpmIcon-withdraw";
			visible = ButtonTools.visible.withdraw;
		}else if(ButtonProcessing.ButtonName_Innerwithdraw == buttonName){//流程节点内拿回
			title = ButtonTools.alt.innerwithdraw;
			img = "bpmIcon-innerwithdraw";
			visible = ButtonTools.visible.innerwithdraw;
		}else if(ButtonProcessing.ButtonName_Transmit == buttonName){//流程转发
			title = ButtonTools.alt.transmit;
			img = "bpmIcon-transmit";
			visible = ButtonTools.visible.transmit;
		}else if(ButtonProcessing.ButtonName_Supersede == buttonName){//流程转办
			title = ButtonTools.alt.supersede;
			img = "bpmIcon-supersede";
			visible = ButtonTools.visible.supersede;
		}else if(ButtonProcessing.ButtonName_Supplement == buttonName){//流程补发
			title = ButtonTools.alt.supplement;
			img = "bpmIcon-supplement";
			visible = ButtonTools.visible.supplement;
		}else if(ButtonProcessing.ButtonName_End == buttonName){//流程结束
			title = ButtonTools.alt.end;
			img = "bpmIcon-end";
			visible = ButtonTools.visible.end;
		}else if(ButtonProcessing.ButtonName_Suspend == buttonName){//暂停
			title = ButtonTools.alt.suspend;
			img = "bpmIcon-suspend";
			visible = ButtonTools.visible.suspend;
		}else if(ButtonProcessing.ButtonName_Idea == buttonName){//修改意见
			title = ButtonTools.alt.idea;
			img = "bpmIcon-idea";
			visible = ButtonTools.visible.idea;
		}else if(ButtonProcessing.ButtonName_Adduser == buttonName){//流程增发
			title = ButtonTools.alt.adduser;
			img = "bpmIcon-adduser";
			visible = ButtonTools.visible.adduser;
		}else if(ButtonProcessing.ButtonName_AdduserAndSubmit == buttonName){//流程增发并提交
			title = ButtonTools.alt.adduserandsubmit;
			img = "bpmIcon-adduser";
			visible = ButtonTools.visible.adduserandsubmit;
		}else if(ButtonProcessing.ButtonName_Resume == buttonName){//流程恢复
			title = ButtonTools.alt.resume;
			img = "bpmIcon-resume";
			visible = ButtonTools.visible.resume;
		}else if(ButtonProcessing.ButtonName_Reader == buttonName){//流程读者
			title = ButtonTools.alt.reader;
			img = "bpmIcon-reader";
			visible = ButtonTools.visible.reader;
		}else if(ButtonProcessing.ButtonName_TaskReader == buttonName){//流程读者
			title = ButtonTools.alt.taskreader;
			img = "bpmIcon-reader";
			visible = ButtonTools.visible.taskreader;
		}else if(ButtonProcessing.ButtonName_GlobalTransmit == buttonName){//全局转发
			title = ButtonTools.alt.globalTransmit;
			img = "bpmIcon-globalTransmit";
			visible = ButtonTools.visible.globalTransmit;
		}else if(ButtonProcessing.ButtonName_Jump == buttonName){//流程跳转
			title = ButtonTools.alt.jump;
			img = "bpmIcon-jump";
			visible = ButtonTools.visible.jump;
		}else if(ButtonProcessing.ButtonName_WriteIdea == buttonName){ //填写意见
			title = ButtonTools.alt.writeidea;
			img = "bpmIcon-writeidea";
			visible = ButtonTools.visible.writeidea;
		}else if(ButtonProcessing.ButtonName_FormSave == buttonName){ //保存表单
			title = ButtonTools.alt.formsave;
			img = "bpmIcon-formsave";
			visible = ButtonTools.visible.formsave;
		}else if(ButtonProcessing.ButtonName_WordCreate == buttonName){ //创建正文
			title = ButtonTools.alt.wordcreate;
			img = "bpmIcon-wordcreate";
			visible = ButtonTools.visible.wordcreate;
		}else if(ButtonProcessing.ButtonName_WordEdit == buttonName){ //编辑正文
			title = ButtonTools.alt.wordedit;
			img = "bpmIcon-wordedit";
			visible = ButtonTools.visible.wordedit;
		}else if(ButtonProcessing.ButtonName_WordRead == buttonName){ //查看正文
			title = ButtonTools.alt.wordread;
			img = "bpmIcon-wordread";
			visible = ButtonTools.visible.wordread;
		}else if(ButtonProcessing.ButtonName_WordRedTemplet == buttonName){ //套红
			title = ButtonTools.alt.wordredtemplet;
			img = "bpmIcon-wordredtemplet";
			visible = ButtonTools.visible.wordredtemplet;
		}else if(ButtonProcessing.ButtonName_Batchsubmit == buttonName ){ //流程批量提交
			title = ButtonTools.alt.bactchsubmit;
			img = "bpmIcon-submit";
			visible = ButtonTools.visible.bactchsubmit;
		}else if(ButtonProcessing.ButtonName_FocusTask == buttonName ){ //关注流程任务
			title = ButtonTools.alt.focustask;
			img = "bpmIcon-focustask"; //TODO：创建“关注工作”新图标
			visible = ButtonTools.visible.focustask;
		}else if(ButtonProcessing.ButtonName_userdefined == buttonName){ //自定义流程处理人
			title = ButtonTools.alt.userdefined;
			img = "bpmIcon-userdefined";
			visible = ButtonTools.visible.userdefined;
		}
		if(visible!=null&&visible=="true"){
			var button =  "";
			var divId = "";
			if(data.isAutoOpen!=null&&data.isAutoOpen=="yes"){ 
				divId = "autoOpen_"+this.id+"_c";
				button += " <a title='"+title+"' id='"+divId+"' href='javascript:void(0);'></a>";
			}else{
				divId = this.id+"_c";
				button += " <a title='"+title+"' id='"+divId+"' href='javascript:void(0);'></a>";
			}
			if(data.event.indexOf("doretreatto") != -1){
				button = "<div title='"+title+"' id='"+divId+"' iconCls='" + img + "' style='padding-right: 20px'>" + data.lable + "</div>";
			}
			var buttonEvent = data.event+"('"+data.procinstDbid+"','"+data.executionId+"','"+data.taskId+"','"+data.name+"','"+data.targetActivityName+"');";
			//button += " <div id='"+ this.id+"_l' class='bbtn-left'></div><div id='"+this.id+"_t' class='bbtn'><img src='"+img+"' style='border:0px;vertical-align:text-top;' />&nbsp;"+ data.lable+"</div><div id='"+this.id+"_r' class='bbtn-right'></div></div>";
			this.Buttons[this.Buttons.length] = new Array(orderBy,button,divId,data.alias||data.lable,img,buttonEvent, data.jScript);
		}
	};
	this.createButton = function (data){
		this.id = data.id || "_button_id_"+Math.random();
		var orderBy = data.orderBy || -1;
		var buttonName =  data.event;
		buttonName = buttonName.toLowerCase();
		var title = "";
		var img = "";
		var visible = "false";
		//var background = ButtonTools.img.background;
		//var onMouse = "";
		if(ButtonProcessing.ButtonName_Submit == buttonName){//流程提交
			title = ButtonTools.alt.submit;
			img = ButtonTools.img.submit;
			visible = ButtonTools.visible.submit;
		}else if(ButtonProcessing.ButtonName_Track == buttonName){//流程跟踪
			title = ButtonTools.alt.track;
			img = ButtonTools.img.track;
			visible = ButtonTools.visible.track;
		}else if(ButtonProcessing.ButtonName_Rejecttofirst == buttonName){//流程退回开始节点
			title = ButtonTools.alt.retreattofirst;
			img = ButtonTools.img.retreattofirst;
			visible = ButtonTools.visible.retreattofirst;
		}else if(ButtonProcessing.ButtonName_Rejecttoprev == buttonName){//流程退回上一节点
			title = ButtonTools.alt.retreattoprev;
			img = ButtonTools.img.retreattoprev;
			visible = ButtonTools.visible.retreattoprev;
		}else if(ButtonProcessing.ButtonName_Withdraw == buttonName){//流程拿回
			title = ButtonTools.alt.withdraw;
			img = ButtonTools.img.withdraw;
			visible = ButtonTools.visible.withdraw;
		}else if(ButtonProcessing.ButtonName_Innerwithdraw == buttonName){//流程节点内拿回
			title = ButtonTools.alt.innerwithdraw;
			img = ButtonTools.img.innerwithdraw;
			visible = ButtonTools.visible.innerwithdraw;
		}else if(ButtonProcessing.ButtonName_Transmit == buttonName){//流程转发
			title = ButtonTools.alt.transmit;
			img = ButtonTools.img.transmit;
			visible = ButtonTools.visible.transmit;
		}else if(ButtonProcessing.ButtonName_Supersede == buttonName){//流程转办
			title = ButtonTools.alt.supersede;
			img = ButtonTools.img.supersede;
			visible = ButtonTools.visible.supersede;
		}else if(ButtonProcessing.ButtonName_Supplement == buttonName){//流程补发
			title = ButtonTools.alt.supplement;
			img = ButtonTools.img.supplement;
			visible = ButtonTools.visible.supplement;
		}else if(ButtonProcessing.ButtonName_End == buttonName){//流程结束
			title = ButtonTools.alt.end;
			img = ButtonTools.img.end;
			visible = ButtonTools.visible.end;
		}else if(ButtonProcessing.ButtonName_Suspend == buttonName){//暂停
			title = ButtonTools.alt.suspend;
			img = ButtonTools.img.suspend;
			visible = ButtonTools.visible.suspend;
		}else if(ButtonProcessing.ButtonName_Idea == buttonName){//修改意见
			title = ButtonTools.alt.idea;
			img = ButtonTools.img.idea;
			visible = ButtonTools.visible.idea;
		}else if(ButtonProcessing.ButtonName_Adduser == buttonName){//流程增发
			title = ButtonTools.alt.adduser;
			img = ButtonTools.img.adduser;
			visible = ButtonTools.visible.adduser;
		}else if(ButtonProcessing.ButtonName_AdduserAndSubmit == buttonName){//流程增发并提交
			title = ButtonTools.alt.adduserandsubmit;
			img = ButtonTools.img.adduser;
			visible = ButtonTools.visible.adduserandsubmit;
		}else if(ButtonProcessing.ButtonName_Resume == buttonName){//流程恢复
			title = ButtonTools.alt.resume;
			img = ButtonTools.img.resume;
			visible = ButtonTools.visible.resume;
		}else if(ButtonProcessing.ButtonName_Reader == buttonName){//流程读者
			title = ButtonTools.alt.reader;
			img = ButtonTools.img.reader;
			visible = ButtonTools.visible.reader;
		}else if(ButtonProcessing.ButtonName_TaskReader == buttonName){//流程读者
			title = ButtonTools.alt.taskreader;
			img = ButtonTools.img.taskreader;
			visible = ButtonTools.visible.taskreader;
		}else if(ButtonProcessing.ButtonName_GlobalTransmit == buttonName){//全局转发
			title = ButtonTools.alt.globalTransmit;
			img = ButtonTools.img.globalTransmit;
			visible = ButtonTools.visible.globalTransmit;
		}else if(ButtonProcessing.ButtonName_Jump == buttonName){//流程跳转
			title = ButtonTools.alt.jump;
			img = ButtonTools.img.jump;
			visible = ButtonTools.visible.jump;
		}else if(ButtonProcessing.ButtonName_WriteIdea == buttonName){ //填写意见
			title = ButtonTools.alt.writeidea;
			img = ButtonTools.img.writeidea;
			visible = ButtonTools.visible.writeidea;
		}else if(ButtonProcessing.ButtonName_FormSave == buttonName){ //保存表单
			title = ButtonTools.alt.formsave;
			img = ButtonTools.img.formsave;
			visible = ButtonTools.visible.formsave;
		}else if(ButtonProcessing.ButtonName_WordCreate == buttonName){ //创建正文
			title = ButtonTools.alt.wordcreate;
			img = ButtonTools.img.wordcreate;
			visible = ButtonTools.visible.wordcreate;
		}else if(ButtonProcessing.ButtonName_WordEdit == buttonName){ //编辑正文
			title = ButtonTools.alt.wordedit;
			img = ButtonTools.img.wordedit;
			visible = ButtonTools.visible.wordedit;
		}else if(ButtonProcessing.ButtonName_WordRead == buttonName){ //查看正文
			title = ButtonTools.alt.wordread;
			img = ButtonTools.img.wordread;
			visible = ButtonTools.visible.wordread;
		}else if(ButtonProcessing.ButtonName_WordRedTemplet == buttonName){ //套红
			title = ButtonTools.alt.wordredtemplet;
			img = ButtonTools.img.wordredtemplet;
			visible = ButtonTools.visible.wordredtemplet;
		}else if(ButtonProcessing.ButtonName_Batchsubmit == buttonName ){ //流程批量提交
			title = ButtonTools.alt.bactchsubmit;
			img = ButtonTools.img.submit;
			visible = ButtonTools.visible.bactchsubmit;
		}else if(ButtonProcessing.ButtonName_FocusTask == buttonName ){ //关注流程任务
			title = ButtonTools.alt.focustask;
			img = ButtonTools.img.focustask; //TODO：创建“关注工作”新图标
			visible = ButtonTools.visible.focustask;
		}else if(ButtonProcessing.ButtonName_userdefined == buttonName){ //自定义流程处理人
			title = ButtonTools.alt.userdefined;
			img = ButtonTools.img.userdefined;
			visible = ButtonTools.visible.userdefined;
		}
		if(visible!=null&&visible=="true"){
			var button =  "";
			var divId = "";
			if(data.isAutoOpen!=null&&data.isAutoOpen=="yes"){ 
				divId = "autoOpen_"+this.id+"_c";
				button += " <div  title='"+title+"' id='"+divId+"'";
			}else{
				divId = this.id+"_c";
				button += " <div  title='"+title+"' id='"+divId+"'";
			}
			var buttonEvent = data.event+"('"+data.procinstDbid+"','"+data.executionId+"','"+data.taskId+"','"+data.name+"','"+data.targetActivityName+"');";
			//button += " onclick=\""+data.event+"('"+data.procinstDbid+"','"+data.executionId+"','"+data.taskId+"','"+data.name+"','"+data.targetActivityName+"');\" ";
			button += " class='bbtnContainer' onmouseup=\"onButtonUp(this);\" onmousedown=\"onButtonDown(this);\" onmouseout=\"onButtonOut(this);\"  onmouseover=\"onButtonOver(this);\">";
			button += " <div id='"+ this.id+"_l' class='bbtn-left'></div><div id='"+this.id+"_t' class='bbtn'><img src='"+img+"' style='border:0px;vertical-align:text-top;' />&nbsp;"+ data.lable+"</div><div id='"+this.id+"_r' class='bbtn-right'></div></div>";
			this.Buttons[this.Buttons.length] = new Array(orderBy,button);
			this.ButtonsEvent[this.ButtonsEvent.length] = new Array(divId,buttonEvent);
		}
	};
	
	this.createUserButton= function(data){
		this.id = data.id || "_button_id_"+Math.random();
		var orderBy = data.orderBy || -1;
		var buttonName =  data.event;
		buttonName = buttonName.toLowerCase();
		var title = data.title || "";
		var img = data.img || ButtonTools.img.submit;
		var button =  "";
		var divId = this.id+"_c";
		var buttonEvent = data.event+"('"+data.entryId+"','"+data.executionId+"','"+data.formId+"')";
		button += " <div  title='"+title+"' id='"+divId+"'";
		//button += " <div  title='"+title+"' id='"+this.id+"_c' ";
		//button += " onclick=\""+data.event+"('"+data.entryId+"','"+data.executionId+"','"+data.formId+"');\" ";
		button += " class='bbtnContainer' onmouseup=\"onButtonUp(this);\" onmousedown=\"onButtonDown(this);\" onmouseout=\"onButtonOut(this);\"  onmouseover=\"onButtonOver(this);\">";
		button += " <div id='"+ this.id+"_l' class='bbtn-left'></div><div id='"+this.id+"_t' class='bbtn'><img src='"+img+"' style='border:0px;vertical-align:text-top;' />&nbsp;"+ data.lable+"</div><div id='"+this.id+"_r' class='bbtn-right'></div></div>";
		this.Buttons[this.Buttons.length] = new Array(orderBy,button);
		this.ButtonsEvent[this.ButtonsEvent.length] = new Array(divId,buttonEvent);
	};
	
	//改用了easyui的button
	this.createEasyUIButtons = function(buttonsArea){
		submitButJScriptEvent = new Array();
		this.Buttons.sort(function(a,b){
			var x = a[0];
			var y = b[0];
			var reg = /^(-|\+)?\d+$/ ;
			if(x!=null&&y!=null&&reg.test(x)&&reg.test(y)){//判断是否为空，是否是数字
				return x-y;
			}
			return 0;
		});//按钮排序
		var $menuLink = $('<a href="javascript:void(0)" id="bpm_retreat_mb">退回</a>');
		var $menu = $('<div id="bpm_retreat_mm" style="width:auto"></div>');
		var showFlg = false;
		for(var i=0;i<this.Buttons.length;i++){
			var button = this.Buttons[i][1];
			var divId = this.Buttons[i][2];
			var text = this.Buttons[i][3];
			var iconCls = this.Buttons[i][4];
			var event = this.Buttons[i][5];
			var jScript = this.Buttons[i][6];
			if(event.indexOf("doretreatto") != -1){
				if(!showFlg){
					$(buttonsArea).append($menuLink);
					$(buttonsArea).append($menu);
					showFlg = true;
				}
				$menu.append($(button));
			}else {
				$(buttonsArea).append(button);

				$(document.getElementById(divId)).linkbutton({
					text:text,
					plain:true,
					iconCls:iconCls
				});
			}
			document.getElementById(divId).onclick=(function(event){
				return function(){
					eval(event);
				};
			})(event);

			if(event.indexOf("dosubmit") != -1 && typeof jScript != "undefined" && jScript != null && jScript != "" && jScript != "null"){
				submitButJScriptEvent.push({divId:divId, jScript:jScript});
			}
		}
		if(showFlg){
			$menuLink.menubutton({
				iconCls: 'icon-redo',
				menu: '#bpm_retreat_mm',
				plain:true
			});
		}
		execSubmitButJScript();
	};
	
	this.getButtons = function(){
		this.Buttons.sort(function(a,b){
			var x = a[0];
			var y = b[0];
			var reg = /^(-|\+)?\d+$/ ;
			if(x!=null&&y!=null&&reg.test(x)&&reg.test(y)){//判断是否为空，是否是数字
				return x-y;
			}
			return 0;
		});//按钮排序
		var buttons = "";
		for(var i=0;i<this.Buttons.length;i++){
			buttons +=this.Buttons[i][1];
		}
		this.buttonDiv.innerHTML = buttons;
	};
	
	this.getButtonDIV = function (){
		this.getButtons();
		return this.buttonDiv;	
	};
	
	this.regButtonEvent = function (){
		for(var i=0;i<this.ButtonsEvent.length;i++){
			var  id =this.ButtonsEvent[i][0];
			var  event =this.ButtonsEvent[i][1];
			if(id!=null&&id!=""){
				document.getElementById(id).onclick=(function(event){
					return function(){
						eval(event);
					}
				})(event);
			}
		}
	};
	
	this.init();
};
function onButtonOver(obj){
	try{
		var id = obj.id.substr(0,obj.id.length-1);
		//document.getElementById(id+"l").style.background = " url('"+getPath2()+"/static/images/platform/bpm/client/images/button/btoolbar-button-bg.gif') 0 -55px no-repeat";
		//document.getElementById(id+"t").style.background = " url('"+getPath2()+"/static/images/platform/bpm/client/images/button/btoolbar-button-bg.gif') 0 -77px repeat-x";
		//document.getElementById(id+"r").style.background = " url('"+getPath2()+"/static/images/platform/bpm/client/images/button/btoolbar-button-bg.gif') 0 -319px no-repeat";

		document.getElementById(id+"t").style.background = "-webkit-gradient(linear, left top, left bottom, from(#b8d9fe), to(#778aa1))";
		document.getElementById(id+"t").style.background = "-moz-linear-gradient(top,  #b8d9fe,  #778aa1)";
		document.getElementById(id+"t").style.border = "1px solid #778aa1";
	}catch(e){
	}
}

function onButtonOut(obj){
	try{
		var id = obj.id.substr(0,obj.id.length-1);
		document.getElementById(id+"l").style.background = " url('')";
		document.getElementById(id+"t").style.background = " url('')";
		document.getElementById(id+"r").style.background = " url('')";
		
		document.getElementById(id+"t").style.border = "";
	}catch(e){
	}
}

function onButtonDown(obj){
	try{
		var id = obj.id.substr(0,obj.id.length-1);
		//document.getElementById(id+"l").style.background = " url('"+getPath2()+"/static/images/platform/bpm/client/images/button/btoolbar-button-bg.gif') 0 -187px no-repeat;";
		//document.getElementById(id+"t").style.background = " url('"+getPath2()+"/static/images/platform/bpm/client/images/button/btoolbar-button-bg.gif') 0 -209px repeat-x;";
		//document.getElementById(id+"r").style.background = " url('"+getPath2()+"/static/images/platform/bpm/client/images/button/btoolbar-button-bg.gif') 0 -341px no-repeat;";
	}catch(e){
	}
}

function onButtonUp(obj){
	try{
		var id = obj.id.substr(0,obj.id.length-1);
		//document.getElementById(id+"l").style.background = " url('"+getPath2()+"/static/images/platform/bpm/client/images/button/btoolbar-button-bg.gif') 0 -55px no-repeat;";
		//document.getElementById(id+"t").style.background = " url('"+getPath2()+"/static/images/platform/bpm/client/images/button/btoolbar-button-bg.gif') 0 -77px repeat-x;";
		//document.getElementById(id+"r").style.background = " url('"+getPath2()+"/static/images/platform/bpm/client/images/button/btoolbar-button-bg.gif') 0 -319px no-repeat;";
	}catch(e){
	}
}
var submitButJScriptEvent = new Array();
function execSubmitButJScript() {
	$.each(submitButJScriptEvent, function (i, n) {
		_submitButJScriptEvent(n.divId, n.jScript);
	});
}
function _submitButJScriptEvent(divId, jScript) {
	if(eval(jScript)){
		$(document.getElementById(divId)).show();
	}else {
		$(document.getElementById(divId)).hide();
	}
}
