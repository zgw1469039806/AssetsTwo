/**
 * 
 */
function SysMessage(datagrid,url,searchD,form,keyWordId,searchNames,dataGridColModel,selectSearch,
		sysMessage_read,sysMessage_unread){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
	this._datagridId="#"+datagrid;
	this._jqgridToolbar="#t_"+datagrid;
	this._doc = document;
	this._formId="#"+form;
	this._searchDialogId ="#"+searchD;
	this._keyWordId="#"+keyWordId;
	this._searchNames = searchNames;
	this.dataGridColModel = dataGridColModel;
	this._tipsIndex;
	this._rcTipsIndex;
	
	this._selectSearch="#"+selectSearch;
	this._sysMessage_read="#"+sysMessage_read;
	this._sysMessage_unread="#"+sysMessage_unread;
	this._sendOrRecv="1";
	this._isRead="0";
	this.init.call(this);
};
//初始化操作
SysMessage.prototype.init=function(){
	var _self = this;
	var param = {};
	param["isReaded"]=this._isRead;
	param["recvOrSend"]=this._sendOrRecv;
	var searchdata = {
			keyWord: JSON.stringify(param)
//			sendOrRecv:this._sendOrRecv,
		}
	$(_self._datagridId).jqGrid({
    	url: this.getUrl()+'getSysMsgsByPage.json',
        mtype: 'POST',
        postData:searchdata,
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        height:$(window).height()-120,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, //
		multiselect: true,
		autowidth: true,
		responsive:true,//开启自适应
        pager: "#jqGridPager",
        gridComplete :function(){
        	$(':input[name="my-checkbox"]').bootstrapSwitch(
				{size:'mini',
				onText:'是',
				offText:'否'
//				handleWidth:15  该版本不支持
				}	
			);
			
			
			$(':input[name="my-checkbox"]').on('switchChange.bootstrapSwitch', function(event, state) {
//				  console.log(this); // DOM element
//				  console.log(event); // jQuery event
//				  console.log(state); // true | false 3.0与最新版本不一样，不是直接获取true false
//				  console.log(state.value);
//				  console.log(this.getAttribute('data-rowid'));
				var rowid=this.getAttribute('data-rowid');
				var broadcastFlag=this.getAttribute('data-broadcastFlag');
				var operation;
				if (state.value) {
					//标记已读					
					operation="doread";
				} else {
					//标记未读
					operation="dounread";
				}
				
				_self.doReadSingle(rowid,broadcastFlag,operation);		
				});
			
			
			$('.title_url').on('click', function(e) {
				var rowid=$(this).attr('data-rowid');
				var urladrr=$(this).attr('data-url');			
				$('').detailMsg(
						{
							formid:rowid,
							url:urladrr
							
						});
			});

        },
        hasTabExport:false,
		hasColSet:false
        
//        onCellSelect: function(rowid,iCol,cellcontent,e	){ 

//        	layer.tips('默认就是向右的', '#id或者.class');
//        	$("[href='#']")
//        	alert("rowid:"+rowid+" iCol:"+iCol+" cellcontent:"+cellcontent);
//        	layer.tips('默认就是向右的', '[title="'+cellcontent+'"]');

//        }
    });
    $(this._jqgridToolbar).append($("#tableToolbar"));
    
    $('.date-picker').datepicker({
		beforeShow: function () {
			setTimeout(function () {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
    });
	$('.time-picker').datetimepicker({
	 	oneLine:true,//单行显示时分秒
	 	closeText:'确定',//关闭按钮文案
	 	showButtonPanel:true,//是否展示功能按钮面板
	 	showSecond:false,//是否可以选择秒，默认否
	 	beforeShow: function(selectedDate) {
	 		if($('#'+selectedDate.id).val()==""){
	 			$(this).datetimepicker("setDate", new Date());
	 			$('#'+selectedDate.id).val('');
	 		}
	 		setTimeout(function () {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
	 	}
	});
	$('.dropdown-menu').click(function(e) {
		    e.stopPropagation();
	});
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});


	
	
};
//添加页面
SysMessage.prototype.insert=function(){
	this.insertIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '添加',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Add/null' 
	});
};
//编辑页面
SysMessage.prototype.modify=function(){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择数据！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
		return false;
	}else if(ids.length > 1){
		layer.alert('请选择一条数据！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.eidtIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '编辑',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Edit/'+rowData.id 
	});
};
//详细页
SysMessage.prototype.detail=function(id){
	this.detailIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '详细页',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Detail/'+id
	}); 
};

//详细页
SysMessage.prototype.url=function(url){
	this.detailIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '详细页',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: url
	}); 
};


//打开高级查询框
SysMessage.prototype.openSearchForm = function(searchDiv){
	var _self = this;
	var contentWidth = 800;
	var top =  $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
	var left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
	var text = $(searchDiv).text();
	var width = $(searchDiv).innerWidth();
	
	
	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	
	layer.open({
		type: 1,
		shift: 5,
		title: false,
		scrollbar: false,
		move : false,
		area: [contentWidth + 'px', '340px'],
		offset: [top + 'px', left + 'px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['查询', '清空', '取消'],
		content: $(this._searchDialogId),
		success : function(layero, index) {
			var serachLabel = $('<div class="serachLabel"><span>'+ text +'</span><span class="caret"></span></div>').appendTo(layero);
			serachLabel.bind('click', function(){
				layer.close(index);
			});
			serachLabel.css('width', width + 'px');
		},
		yes: function(index, layero){
			_self.searchData();
			layer.close(index);//查询框关闭
		},
		btn2: function(index, layero){
			_self.clearData();
			return false;
		},
		btn3: function(index, layero){
			
		}
	});
};
//控件校验   规则：表单字段name与rules对象保持一致
SysMessage.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			title : {
				required : true,
				maxlength : 255
			},
			content : {
				required : true,
				maxlength : 1000
			},
			sendUserAlias : {
				required : true,
				maxlength : 50
			},
			sendDate : {
				required : true,
//				dateISO : true
			},
            disappearDate : {
                required : true,
            },
			recvUserAlias : {
				required : true,
				maxlength : 50
			},
			autoDisappear : {
				maxlength : 2
			},
			sendDeptid : {
				maxlength : 50
			},
			sysApplicationId : {
				maxlength : 32
			},
		}
	});
}
// 保存功能
SysMessage.prototype.save=function(form,id){
	var _self = this;
//	console.log(JSON.stringify(serializeObject(form)));
	avicAjax.ajax({
		 url:_self.getUrl()+"save",
		 data : {
//			 msgType:"personal",
//			 recvUsers:serializeObject(form).recvUsers,
			 data :JSON.stringify(serializeObject(form))
			 
		 		},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 if(id == "insert"){
					 layer.close(_self.insertIndex);
				 }else{
					 layer.close(_self.eidtIndex);
				 }
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
// 删除
SysMessage.prototype.del=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确定要删除该数据吗?',  {icon: 3, title:"提示", area: ['400px', ''],closeBtn: 0}, function(index){
				for(;l--;){
					 ids.push(rows[l]);
				 }
				 avicAjax.ajax({
					 url:_self.getUrl()+'delete',
					 data:	JSON.stringify(ids),
					 contentType : 'application/json',
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.flag == "success") {
							 _self.reLoad();
						}else{
							layer.alert('删除失败！' + r.error, {
								  icon: 7,
								  area: ['400px', ''],
								  closeBtn: 0
								}
							);
						}
					 }
				 });
				 layer.close(index);
			});   
	}else{
	    layer.alert('请选择要删除的记录！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
	}
};





//标记已读
SysMessage.prototype.read=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	var datas = [];
	if(l > 0){
		layer.confirm('确定要标记已读吗?',  {icon: 3, title:"提示", area: ['400px', ''],closeBtn: 0}, function(index){
				
				for ( var i = 0; i < rows.length; i++) {
					var rowData = $(_self._datagridId).jqGrid('getRowData',rows[i]);
//					console.log("rowData:"+JSON.stringify(rowData));
//					console.log("id:"+rowData.id+" rf:"+rowData.broadcastFlag);
					var sys_msg= {
							id:rowData.id,
							broadcastFlag:rowData.broadcastFlag					
					};
					datas.push(sys_msg);
				}
				
//				console.log("datas:"+JSON.stringify(datas));
				 avicAjax.ajax({
					 url:_self.getUrl()+'doread',
					 data:{
						 para:'11',
						 datas:JSON.stringify(datas)
					 },
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.flag == "success") {
							 _self.reLoad();
						}else{
							layer.alert('标记失败！' + r.error, {
								  icon: 7,
								  area: ['400px', ''],
								  closeBtn: 0
								}
							);
						}
					 }
				 });
				 layer.close(index);
			});   
	}else{
	    layer.alert('请选择要标记的记录！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
	}
};

SysMessage.prototype.doReadtest=function(){
	var _self = this;
	 avicAjax.ajax({
		 url:_self.getUrl()+'doReadtest',
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success") {
				 _self.reLoad();
			}else{
				layer.alert('标记失败！' + r.error, {
					  icon: 7,
					  area: ['400px', ''],
					  closeBtn: 0
					}
				);
			}
		 }
	 });
};

SysMessage.prototype.doUnReadTest=function(){
	var _self = this;
	 avicAjax.ajax({
		 url:_self.getUrl()+'doUnReadTest',
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success") {
				 _self.reLoad();
			}else{
				layer.alert('标记失败！' + r.error, {
					  icon: 7,
					  area: ['400px', ''],
					  closeBtn: 0
					}
				);
			}
		 }
	 });
};

//标记未读
SysMessage.prototype.unread=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	var datas = [];
	if(l > 0){
		layer.confirm('确定要标记未读吗?',  {icon: 3, title:"提示", area: ['400px', ''],closeBtn: 0}, function(index){
				
				for ( var i = 0; i < rows.length; i++) {
					var rowData = $(_self._datagridId).jqGrid('getRowData',rows[i]);
//					console.log("rowData:"+JSON.stringify(rowData));
//					console.log("id:"+rowData.id+" rf:"+rowData.broadcastFlag);
					var sys_msg= {
							id:rowData.id,
							broadcastFlag:rowData.broadcastFlag					
					};
					datas.push(sys_msg);
				}
				
//				console.log("datas:"+JSON.stringify(datas));
				 avicAjax.ajax({
					 url:_self.getUrl()+'dounread',
					 data:{
						 datas:JSON.stringify(datas)
					 },
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.flag == "success") {
							 _self.reLoad();
						}else{
							layer.alert('标记失败！' + r.error, {
								  icon: 7,
								  area: ['400px', ''],
								  closeBtn: 0
								}
							);
						}
					 }
				 });
				 layer.close(index);
			});   
	}else{
	    layer.alert('请选择要标记的记录！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
	}
};



//新删除方法
SysMessage.prototype.deldtos=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	var datas = [];
	if(l > 0){
		layer.confirm('确定要删除吗?',  {icon: 3, title:"提示", area: ['400px', ''],closeBtn:0}, function(index){
				
				for ( var i = 0; i < rows.length; i++) {
					var rowData = $(_self._datagridId).jqGrid('getRowData',rows[i]);
//					console.log("rowData:"+JSON.stringify(rowData));
//					console.log("id:"+rowData.id+" rf:"+rowData.broadcastFlag);
					var sys_msg= {
							id:rowData.id,
							broadcastFlag:rowData.broadcastFlag					
					};
					datas.push(sys_msg);
				}
				
//				console.log("datas:"+JSON.stringify(datas));
				 avicAjax.ajax({
					 url:_self.getUrl()+'delete',
					 data:{
						 datas:JSON.stringify(datas)
					 },
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.flag == "success") {
							 _self.reLoad();
						}else{
							layer.alert('删除失败！' + r.error, {
								  icon: 7,
								  area: ['400px', ''],
								  closeBtn: 0
								}
							);
						}
					 }
				 });
				 layer.close(index);
			});   
	}else{
	    layer.alert('请选择要删除的记录！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
	}
};








//重载数据
SysMessage.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this._formId)))};
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
};
//关闭对话框
SysMessage.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.eidtIndex);
	}
};
//高级查询
SysMessage.prototype.searchData =function(){
	var param = serializeObject($(this._formId));
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
/*	if(sendDateBegin!=null && sendDateEnd!=null){
		if(sendDateBegin>sendDateEnd){
			layer.alert('发送日期(开始)不能大于发送日期(结束)！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				});
			return;
		}
	}*/
	var searchdata = {
			keyWord: null,
//			sendOrRecv:serializeObject($(this._formId)).recvOrSend,
			param:JSON.stringify(param)
		}
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
};
//关键字段查询
SysMessage.prototype.searchByKeyWord =function(){
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
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
	
	
	
}
//隐藏查询框
SysMessage.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
SysMessage.prototype.clearData =function(){
	clearFormData(this._formId);
    //处理高级查询中清空查询条件导致查询出所有数据的问题
    $('input:radio[value=1]').prop('checked', true);
	this.searchData();
};

//过滤事件
SysMessage.prototype.selectSearchChange=function(selectSearch){
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

SysMessage.prototype.titleTips=function(contentid,cellvalue){
    $('#'+contentid).attr("title","");
    this._tipsIndex= layer.tips(cellvalue, '#'+contentid+':parent', {
        tips: [1, '#3595CC'],
        time: 0
    });
};
SysMessage.prototype.closeTitleTips=function(){
    layer.close(this._tipsIndex);
};

SysMessage.prototype.contentTips=function(contentid,cellvalue){

	$('#'+contentid).attr("title","");
//	layer.tips(cellvalue, '#'+contentid+':parent');
//	layer.tips(cellvalue, '#'+contentid);
	this._tipsIndex= layer.tips(cellvalue, '#'+contentid+':parent', {
		  tips: [1, '#3595CC'],
		  time: 0

		});

};
SysMessage.prototype.closeContentTips=function(){
	layer.close(this._tipsIndex);
};

SysMessage.prototype.recvTips=function(contentid,cellvalue){

	$('#'+contentid).attr("title","");
	this._rcTipsIndex= layer.tips(cellvalue, '#'+contentid+':parent', {
		  tips: [1, '#3595CC'],
		  time: 0

		});

};
SysMessage.prototype.closeRecvTips=function(){
	layer.close(this._rcTipsIndex);
};


SysMessage.prototype.changeToRecv=function(){
	$(this._sysMessage_unread).show();
	$(this._sysMessage_read).show();
	$("#sysMessage_del").show();
};
SysMessage.prototype.changeToSend=function(){
	$(this._sysMessage_unread).hide();
	$(this._sysMessage_read).hide();
	$("#sysMessage_del").hide();
	
};

SysMessage.prototype.doReadSingle=function(rowid,broadcastFlag,operation){
	_self=this;
	var datas = [];
	var sys_msg = {
		id : rowid,
		broadcastFlag : broadcastFlag

	};
	datas.push(sys_msg);
	avicAjax.ajax({
		url : _self.getUrl() + operation,
		data : {
			datas : JSON.stringify(datas)
		},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.reLoad();
			} else {
				layer.alert('标记失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0
				});
			}
		}
	});

};

