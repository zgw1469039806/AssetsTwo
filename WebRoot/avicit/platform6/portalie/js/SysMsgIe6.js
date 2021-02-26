function SysMsgIe6(id, url, keyWordId,searchNames,selectSearch) {
	this.url = url;
	this.id = id;
	this.idGrid = "#" + id + "Grid";
	this.keyInputId = "#" + id + "KeyInput";
	this._keyWordId="#"+keyWordId;
	this._searchNames = searchNames;
	this.searchId = "#" + id + "SearchId";
	this.searchForm = "#" + id + "SearchForm";
	this.searchDialog = "#" + id + "Dialog";
	this.queryParams = null;
	this._sendOrRecv="1";
	this._selectSearch="#"+selectSearch;
	this._isRead="0";
	this.init.call(this);
};
SysMsgIe6.prototype.init = function() {
	var _self = this;
	var param = {};
	param["isReaded"]=this._isRead;
	param["recvOrSend"]=this._sendOrRecv;
	var searchdata = {
			keyWord: JSON.stringify(param)
//			sendOrRecv:this._sendOrRecv,
		}
	this.grid = $(this.idGrid).datagrid({
		url : this.url,
		postData:searchdata,
		//queryParams : this.queryParams
		queryParams :{
			keyWord: JSON.stringify(param)
			}
	});
	$(this.keyInputId).attr('placeholder', '请输入标题');
	$(this.keyInputId).parent().find("span").on('click', function() {
		_self.searchByKeyWord();
	});
	$(this.keyInputId).on('keyup', function(e) {
		if (e.keyCode == 13) {
			_self.searchByKeyWord();
		}
	});
	$(this.searchId).on('click', function() {
		_self.openSearchForm();
	});
	$("#" + this.id + "receptUserName").on('focus', function(e) {
		new EasyuiCommonSelect({
			type : 'userSelect',
			idFiled : _self.id + 'userId',
			textFiled : _self.id + 'receptUserName'
		});
		this.blur();
	});
	$("#" + this.id + "applyDeptidAlias").on('focus', function(e) {
		new EasyuiCommonSelect({
			type : 'deptSelect',
			idFiled : _self.id + 'deptId',
			textFiled : _self.id + 'applyDeptidAlias'
		});
		this.blur();
	});
};
//详细页
SysMsgIe6.prototype.detail=function(options){
	var baseUrl='msystem/sysmsg/sysMsgController/operation/DetailIe6/';
	//默认参数
	var defaults = {
		        formid:'',//消息id
		        url:'',//url
		      	type: 2,
	 		    area: ['100%', '100%'],
	 		    offset:'auto',
	 		    icon:-1,
	 		    shade:0.3,
	 		    shadeClose:false,
	 		    anim:0,
	 		    maxmin:false,
	 		    fixed:true,
	 		    resize:true,
	 		    scrollbar:true,
	 		    maxWidth:360,
	 		    zIndex:19891014,
	 		    moveOut:false,	 		    
	 		    title: '消息详情'
				//其他参数待定
	 	        
		    };
	
	//合并默认参数与用户参数到setings
	var settings = $.extend({},defaults, options);
	if (settings.url==''||settings.url==null||settings.url=='null') {
		settings.content=baseUrl+options+'/null';
	} else {
		settings.content=settings.url;
	}		    
	layer.open(				
		settings		
	);
};
//添加页
SysMsgIe6.prototype.add=function(id){
	this.addIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '添加',
        maxmin: false, //开启最大化最小化按钮
        content: 'avicit/platform6/portalie/themes/fixie_oa/jsp/SysMsgPubAddIe6.jsp?type=addButton'
    });
};
//保存功能
SysMsgIe6.prototype.save=function(form,id){
	var _self = this;
	avicAjax.ajax({
		 url:"msystem/sysmsg/sysMsgController/operation/save",
		 data : {
			 data :JSON.stringify(serializeObject(form))
		 		},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 $("#draftGrid").datagrid("reload");				 
				 layer.close(_self.addIndex);				
				 layer.msg('保存成功！');
			 }else{
				 layer.alert('保存失败！' + r.error, {
					  icon: 7,
					  area: ['400px', ''], // 宽高
					  closeBtn: 0
					}
				);
			 } 
		 }
	 });
};

//过滤事件
SysMsgIe6.prototype.selectSearchChange=function(selectSearch){
	var _self=this;
	var selectValue =$('#'+selectSearch).val();
		if ("all"==selectValue) {
			this._sendOrRecv="1";
			this._isRead="";
			this.changeToRecv();
		}else if ("send"==selectValue) {
			this._sendOrRecv="0";
			this._isRead="";
			this.changeToSend();
		}else if ("unread"==selectValue) {
			this._sendOrRecv="1";
			this._isRead="0";
			this.changeToRecv();
		}else if ("read"==selectValue) {
			this._sendOrRecv="1";
			this._isRead="1";
			this.changeToRecv();
		}
	
		_self.searchByKeyWord();
};
SysMsgIe6.prototype.contentTips=function(contentid,cellvalue){

	$('#'+contentid).attr("title","");
//	layer.tips(cellvalue, '#'+contentid+':parent');
//	layer.tips(cellvalue, '#'+contentid);
	this._tipsIndex= layer.tips(cellvalue, '#'+contentid+':parent', {
		  tips: [1, '#3595CC'],
		  time: 0

		});

};
SysMsgIe6.prototype.closeContentTips=function(){
	layer.close(this._tipsIndex);
};

SysMsgIe6.prototype.recvTips=function(contentid,cellvalue){

	$('#'+contentid).attr("title","");
	this._rcTipsIndex= layer.tips(cellvalue, '#'+contentid+':parent', {
		  tips: [1, '#3595CC'],
		  time: 0

		});

};
SysMsgIe6.prototype.closeRecvTips=function(){
	layer.close(this._rcTipsIndex);
};


SysMsgIe6.prototype.changeToRecv=function(){
	$(this._sysMessage_unread).show();
	$(this._sysMessage_read).show();
};
SysMsgIe6.prototype.changeToSend=function(){
	$(this._sysMessage_unread).hide();
	$(this._sysMessage_read).hide();
};


SysMsgIe6.prototype.setQueryParams = function(queryParams){
	this.queryParams = queryParams;
};


SysMsgIe6.prototype.realod = function() {
	if (this.grid == null) {
		this.init();
	} else {
		this.grid.datagrid('load', this.queryParams).datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	}
};
//打开高级查询框
var copydom = {};
SysMsgIe6.prototype.openSearchForm = function() {
	var _self = this;
	var contentWidth = 800;
	var top = $(this.searchId).offset().top + $(this.searchId).outerHeight(true);
	var left = $(this.searchId).offset().left + $(this.searchId).outerWidth() - contentWidth;
	var text = $(this.searchId).text();
	var width = $(this.searchId).innerWidth();
	layer.open({
		type : 1,
		shift : 5,
		title : false,
		scrollbar : true,
		move : false,
		area : [ contentWidth + 'px', '340px' ],
		offset : [ top + 'px', left + 'px' ],
		closeBtn : 0,
		shadeClose : true,
		btn : [ '查询', '清空', '取消' ],
		content : $(_self.searchDialog),
		success : function(layero, index) {
			if(JSON.stringify(copydom) != "{}"){
				$.each(copydom,function(k,v){
					$(_self.searchDialog).find('input[name='+k+'][value='+v.val+']').attr('checked','checked');
				});
			}
			var serachLabel = $('<div class="serachLabel">'+ text +'</span><span class="caret"></span></div>').appendTo(layero);
			serachLabel.bind('click', function(){
				layer.close(index);
			});
			serachLabel.css('width',  width + 'px');
			$('input[type=checkbox],input[type=radio]').off().on('change',function(){
				var thatName = $(this).attr('name'),
					thatVal = $(this).val(),
					thatType = $(this).attr('type');
				if(thatName&&thatVal){
					copydom[thatName] = {
						'type' : thatType,
						'val' : thatVal
					};
				}
			});
		},
		yes : function(index, layero) {
			_self.searchData();
			layer.close(index);// 查询框关闭
		},
		btn2 : function(index, layero) {
			_self.clearData();
			return false;
		},
		btn3 : function(index, layero) {
		}
	});
};
//隐藏查询框
SysMsgIe6.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
SysMsgIe6.prototype.clearData =function(){
	clearFormData(this.searchForm);
	this.searchData();
};
//关键字段查询
SysMsgIe6.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val();
	var placeholder =$(this._keyWordId).attr("placeholder");
	if (keyWord==placeholder) {
		keyWord="";
	}
	var names = this._searchNames;
	var sendOrRecv=this._sendOrRecv;
	var param = {};
	for(var i in names){
		var name = names[i];
		param[name] = keyWord;
	}
	param["isReaded"]=this._isRead;
	param["recvOrSend"]=this._sendOrRecv;
	var searchdata = {
			keyWord: JSON.stringify(param),
//			sendOrRecv:sendOrRecv,
			param: null
		}
	this.grid = $(this.idGrid).datagrid({
		url : this.url,
		//queryParams : this.queryParams
		queryParams :searchdata
	});
	//$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
	//this.grid.datagrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
	//this.grid.datagrid('load', param).datagrid('setGridParam',{postData: searchdata}).trigger("reloadGrid")
	
	
	
}
//高级查询
SysMsgIe6.prototype.searchData =function(){
	var param = serializeObject($(this.searchForm));
	if ('0'==param.msgTypes) {
//		param["isReaded"]="0";
		param["recvOrSend"]="1";
	}else if ('1'==param.msgTypes) {
		param["isReaded"]="0";
		param["recvOrSend"]="1";
		
	}else if ('2'==param.msgTypes) {
		param["isReaded"]="1";
		param["recvOrSend"]="1";
		
	}else if('3'==param.msgTypes){
		param["recvOrSend"]="0";
		
	}
	var sendDateBegin = param.sendDateBegin;
	var sendDateEnd = param.sendDateEnd;
	if(sendDateBegin!=null && sendDateEnd!=null){
		if(sendDateBegin>sendDateEnd){
			layer.alert('发送日期(开始)不能大于发送日期(结束)！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				});
			return;
		}
	}
	var searchdata = {
			keyWord: null,
//			sendOrRecv:serializeObject($(this._formId)).recvOrSend,
			param:JSON.stringify(param)
		}
	this.grid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	this.grid.datagrid('load',{param :searchdata.param});
};