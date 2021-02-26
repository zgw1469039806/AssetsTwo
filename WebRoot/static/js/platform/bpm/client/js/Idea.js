var IdeaManage = {};
IdeaManage.IdeaDiv = null;
IdeaManage.getIdea = function (entryId){
	
	var url = "platform/bpm/ideaaction/getImageIdea.json";
	var contextPath = getPath2();
	var urltranslated = contextPath + "/" + url;

	if(entryId == 'undefined' || entryId == null){
		return ;
	}
	var _ideaDiv = document.getElementById("idea");
	if(_ideaDiv==null||_ideaDiv=="undefined"){
		return;
	}
	jQuery.ajax({
        type:"POST",
		data:"processInstanceId="+entryId,
        url: urltranslated,  
        dataType:"json",
		context: document.body, 
        success: function(msg){
        	IdeaManage.drawIdeaAndSign(msg);
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){
//			window.alert("调用Ajax操作发生异常，地址为：" + urltranslated + "，异常信息为：" + errorThrown);
		}
	}); 
};

IdeaManage.drawIdeaAndSign = function (msg){
	
	if(msg == null){
		return ;
	}
	var codes = msg.ideaCode;
	var titles = msg.titleMap;
	var ideas = msg.ideaMap;
	
	if(codes == null || titles == null || ideas==null){
		return ;
	}
	 
	IdeaManage.IdeaDiv = document.getElementById("idea");
	var cdiv = document.createElement("div");
	var ideaContent = "<table class='idea-table'>";
	//debugger;
	for (var code in codes){
		var title = "";
		var idea = "";
		for (var t in titles){
			if(codes[code] == t){
				title = titles[t];
				break;
			}
		}
		for (var i in ideas){
			if(codes[code] == i){
				idea = ideas[i];
				break;
			}
		}
		if(title == null || title == ""){
			continue;
		}
		ideaContent +="<tr>";
		ideaContent +="<td class='idea-table-title'>";
		ideaContent +=title;
		ideaContent +="</td>";
		ideaContent +="<td class='idea-table-idea'>";
		ideaContent +="<table border='0'>";
		for (var i=0;i<idea.length;i++){
			ideaContent +="<tr><td >"
			ideaContent +=idea[i].comment;
			ideaContent +="</td>";
			
			if(idea[i].showSign=="1"){
					ideaContent +="<td >"
					ideaContent +="<div id=\"signDiv\"  onmouseover=\"IdeaManage.forbidRightMouseClick()\">"
					ideaContent +="<img width=\"80\" height=\"30\" title=\"电子签名\" style=\"cursor: pointer;\" src=\"platform/cc/sysuserphoto/upload/signphoto?sysUserId="+idea[i].userId+"\"/>"
					ideaContent +="</div>"	
					ideaContent +="</td>"
			}
			ideaContent +="</tr>"
		}
		ideaContent +="</table>";
		ideaContent +="</td>";
		ideaContent +="</tr>";
	}
	ideaContent +="</table>";
	cdiv.innerHTML = ideaContent;
	IdeaManage.IdeaDiv.appendChild(cdiv); 
};

IdeaManage.forbidRightMouseClick = function (){
	$("#signDiv").bind('contextmenu',function(){
		return false;
	});
}

function hiddenTip(){
}

IdeaManage.drawIdea = function (msg){
	
	if(msg == null){
		return ;
	}
	var codes = msg.ideaCode;
	var titles = msg.titleMap;
	var ideas = msg.ideaMap;
	
	if(codes == null || titles == null || ideas==null){
		return ;
	}
	 
	IdeaManage.IdeaDiv = document.getElementById("idea");
	var cdiv = document.createElement("div");
	var ideaContent = "<table class='idea-table'>";
	//debugger;
	for (var code in codes){
		var title = "";
		var idea = "";
		for (var t in titles){
			if(codes[code] == t){
				title = titles[t];
				break;
			}
		}
		for (var i in ideas){
			if(codes[code] == i){
				idea = ideas[i];
				break;
			}
		}
		if(title == null || title == ""){
			continue;
		}
		ideaContent +="<tr>";
		ideaContent +="<td class='idea-table-title'>";
		ideaContent +=title;
		ideaContent +="</td>";
		ideaContent +="<td class='idea-table-idea'>";
		ideaContent +="<table border='1'>";
		for (var i=0;i<idea.length;i++){
			ideaContent +="<tr><td >"
			ideaContent +=idea[i];
			ideaContent +="</td>";
			
			ideaContent +="<td >"
			ideaContent +="<div width=\"100\" height=\"30\">"
			ideaContent +="<img width=\"100\" height=\"30\" title=\"电子签名\" style=\"cursor: pointer;\" src=\"static/images/platform/bpm/client/images/trackTask.gif\"/>"
			ideaContent +="</div>"	
			ideaContent +="</td></tr>"		
		}
		ideaContent +="</table>";
		ideaContent +="</td>";
		ideaContent +="</tr>";
	}
	ideaContent +="</table>";
	cdiv.innerHTML = ideaContent;
	IdeaManage.IdeaDiv.appendChild(cdiv); 
};
