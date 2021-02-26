function ConsoleUser(datagrid,url,searchD,form,keyWordId,searchNames,dataGridColModel){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    };
	this._datagridId="#"+datagrid;
	this._jqgridToolbar="#t_"+datagrid;
	this._doc = document;
	this._formId="#"+form;
	this._searchDialogId ="#"+searchD;
	this._keyWordId="#"+keyWordId;
	this._searchNames = searchNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
}
//初始化操作
ConsoleUser.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: this.getUrl()+'/operation/getSysUsersByPage.json',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 10	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, //
		multiselect: true,
		autowidth: true,
        shrinkToFit: true,
		hasColSet:false,
		hasTabExport:false,
		responsive:true,//开启自适应
        pager: "#jqGridPager",
        gridComplete: function() {
            var ids = $(_self._datagridId).jqGrid("getDataIDs");
            var rowDatas = $(_self._datagridId).jqGrid("getRowData");
            for(var i=0;i < rowDatas.length;i++) {
                var rowData = rowDatas[i];
				if(rowData.sanyuan == "true"){
					$("#" + ids[i] +  " td").css("color","#f26522");
				}
                if(rowData.isChiefDept == "0"){
                    $("#" + ids[i] +  " td").css("color","#b1b1b1");
				}
            }

            var height = document.documentElement.clientHeight;
            height = height- ($("#tableToolbar").outerHeight()+$('#jqGridPager').outerHeight()+45);
            $(_self._datagridId).jqGrid('setGridHeight',height);
        }
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
ConsoleUser.prototype.insert=function(){
	var url = this.getUrl()+'/operation/Add/null';
	var deptId = parent.orgtree._selectNode.id;
	var deptCode = parent.orgtree._selectNode.text; 
	if(deptId !== null){//添加时是否选中部门
		if(parent.orgtree._selectNode.nodeType != "org"){
			url = url + '?deptId=' + deptId ;
		}
	}
	insertIndex = parent.layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '添加用户',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content:  url
	});      
};


//编辑页面
ConsoleUser.prototype.modify=function(){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);

	if(ids.length == 0){
		parent.layer.alert('请选择要编辑的用户！',{
					  icon: 7,
					  title:'提示',
					  area: ['400px', ''], //宽高
					  closeBtn: 0
				    }
		         );
		return false;
	}else if(ids.length > 1){
		parent.layer.alert('请选择一个用户！',{
					  icon: 7,
					  title:'提示',
					  area: ['400px', ''], //宽高
					  closeBtn: 0
				    }
		         );
		return false;
	}
	if(rowData.sanyuan == "true"){
		parent.layer.alert('三员用户不允许操作！',{
				icon: 7,
				title:'提示',
				area: ['400px', ''], //宽高
				closeBtn: 0
			}
		);
		return false;
	}
	if(!checkChiefDept(rowData)){
        parent.layer.alert('选择的用户【' + rowData.name + '】数据是兼职信息，不允许编辑，请重新选择！',{
                icon: 7,
                title:'提示',
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
		return false;
	}
	if(rowData.userLocked!="0"){
		parent.layer.alert('不允许编辑锁定用户！',{
					  icon: 7,
					  title:'提示',
					  area: ['400px', ''], //宽高
					  closeBtn: 0
				    }
		         );
		return false;
	}
	if(rowData.status!="1"){
		parent.layer.alert('不允许编辑无效用户！',{
					  icon: 7,
					  title:'提示',
					  area: ['400px', ''], //宽高
					  closeBtn: 0
				    }
		         );
		return false;
	}
	eidtIndex = parent.layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '编辑【' + rowData.name + '】',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'/operation/Edit/'+rowData.id 
	});   
};
function checkChiefDept(data){
	if(data.isChiefDept == "1"){
		return true;
	}
	return false;
}
//详细页
ConsoleUser.prototype.detail=function(id){
	detailIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '详细页',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Detail/'+id
	});   
};
//打开高级查询框
ConsoleUser.prototype.openSearchForm = function(searchDiv){
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
		area: [contentWidth + 'px', '300px'],
		offset: [top + 'px', left + 'px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['查询', '清空', '取消'],
		content: $(this._searchDialogId),
		success : function(layero, index) {
			var serachLabel = $('<div class="serachLabel"><span>'+ text +'</span></div>').appendTo(layero);
			serachLabel.bind('click', function(){
				layer.close(index);
			});
			serachLabel.css('width', width + 'px');
		},
		yes: function(index, layero){
			_self.searchData();
			layer.close(index);
		},
		btn2: function(index, layero){
			_self.clearData();
			return false;
		},
		btn3: function(index, layero){
			
		}
	});
};
//验证
ConsoleUser.prototype.formValidate=function(form){
		form.validate({
			rules: {
				
				no: {
					required: true,
					maxlength: 50
				},
				loginName: {
					required: true,
					maxlength: 50
				},
				name: {
					required: true,
					maxlength: 50
				},
				nameEn: {
					alnum:true,
					maxlength: 50
				},
				email: {
					email: true,
				},
				
				mobile: {
					mobile: true,
					isMobile:true
				},
				
				applyDeptidAlias: {
					required: true,
				},
				applyPositionidAlias: {
					required: true,
				},
				homeZip:{
			
					isZipCode:true,
				},
				
				secretLevel: {
					required: true,
				},
				
				userType: {
					required: true,
				},
				consoleType: {
					required: true,
				},
				orderBy:{
					orderBy:true,
					maxlength:10
				},
				roomNo:{
					integer:true,
					maxlength:6
				},
				fax:{
			
					tel:true,
				},
				
				officeTel:{
			
					phone:true,
				},
				homeTel:{
			
					phone:true,
				},
				remark:{
					maxlength:250
				}
				
			
				
			}
		});
};
//保存功能
ConsoleUser.prototype.save=function(form,id){

	var _self = this;
	$.ajax({
		 url:_self.getUrl()+"/operation/save",
		 data : {data :JSON.stringify(serializeObject(form)),type:id},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 if(id == "insert"){
					 parent.layer.close(insertIndex);
				 }else{
					 parent.layer.close(eidtIndex);
				 }
				 parent.layer.msg('保存成功！',{
						icon: 1,
						area: ['200px', ''],
						closeBtn: 0
				 });

			 }else{
                 form.parents("body").find("#consoleUser_saveForm").removeClass("disabled");
				 parent.layer.alert('保存失败！' + r.error,{
					  icon: 2,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
				    }
		         );

			 } 
		 }
	 });
};
//删除
ConsoleUser.prototype.del=function(){
	
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if(l > 0){

       for(var i = 0 ; i < rows.length ; i++){
           var rowData = $(this._datagridId).jqGrid('getRowData', rows[i]);
		   if(rowData.sanyuan == "true"){
			   parent.layer.alert('三员用户不允许操作！',{
					   icon: 7,
					   title:'提示',
					   area: ['400px', ''], //宽高
					   closeBtn: 0
				   }
			   );
			   return false;
		   }
           if(!checkChiefDept(rowData)){
               parent.layer.alert('选择的用户【' + rowData.name + '】数据是兼职信息，不允许删除，请重新选择！',{
                       icon: 7,
                       title:'提示',
                       area: ['400px', ''], //宽高
                       closeBtn: 0
                   }
               );
               return false;
           }
	   }
		parent.layer.confirm('确认要删除选择的用户吗?' ,
			{
		    title : '提示',
		    icon : 3,
		    closeBtn:0,
		    area: ['400px', ''],
		    btn: ['确定','取消']
			},  
			function(index){
				for(;l--;){
					 ids.push(rows[l]);
				 }
				 $.ajax({
					 url:_self.getUrl()+'/operation/delete',
					 data:	JSON.stringify(ids),
					 contentType : 'application/json',
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.flag == "success") {
							 
							 parent.layer.msg('删除成功！',{
									icon: 1,
									area: ['200px', ''],
									closeBtn: 0
							 });
							  _self.reLoad();
						}else{
							parent.layer.alert('删除失败！' + r.error,{
						  		icon: 2,
						  		area: ['400px', ''], //宽高
						  		closeBtn: 0
					    		}
		         			);
						}
					 }
				 });
				 parent.layer.close(index);
			});   
	}else{
		//layer.msg('请选择要删除的数据！！');
		parent.layer.alert('请选择要删除的用户数据！',{
							title:'提示',		  		
							icon: 0,
					  		area: ['400px', ''], //宽高
					  		closeBtn: 0
				    }
		         );
	}
};
//重载数据
ConsoleUser.prototype.reLoad=function(){
	var treeNode = parent.orgtree._selectNode;
	//if(treeNode){
		var searchdata = {param:JSON.stringify(treeNode)};
		$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
	
	
	
	

};
//关闭对话框
ConsoleUser.prototype.closeDialog=function(id){
	if(id == "insert"){
		parent.layer.close(insertIndex);
	}else{
		parent.layer.close(eidtIndex);
	}
};
//高级查询
ConsoleUser.prototype.searchData =function(){
	var treeNode = parent.orgtree._selectNode;
	var searchdata = {
			keyWord: null,
			param : JSON.stringify(treeNode),
			searchdatapara:JSON.stringify(serializeObject($(this._formId)))
		};
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
};
//关键字段查询
ConsoleUser.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val();
	
	if(keyWord=="输入用户名或登录名查询"){
		keyWord='';
	}
	var searchdata = {};
	var treeNode = parent.orgtree._selectNode;
	if(keyWord==''){
		 searchdata = {
		keyWord : null,
		param : JSON.stringify(treeNode)
		}
	}else{
		var names = this._searchNames;

		var param = {};
		for ( var i in names) {
			var name = names[i];
			param[name] = keyWord;
		}
	 	searchdata = {
			keyWord : JSON.stringify(param),
			param : JSON.stringify(treeNode)
		}
	}
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
};
//隐藏查询框
ConsoleUser.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
ConsoleUser.prototype.clearData =function(){
	clearFormData(this._formId);
	this.searchData();
};

//设置用户组织密级
ConsoleUser.prototype.setOrgSecret=function(){
    var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);

    if (ids.length == 0) {
        parent.layer.alert('请选择要操作的用户！', {
                icon: 7,
                title: '提示',
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    } else if (ids.length > 1) {
        parent.layer.alert('请选择一个用户！', {
                icon: 7,
                title: '提示',
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }
	if(rowData.sanyuan == "true"){
		parent.layer.alert('三员用户不允许操作！',{
				icon: 7,
				title:'提示',
				area: ['400px', ''], //宽高
				closeBtn: 0
			}
		);
		return false;
	}
    if(!checkChiefDept(rowData)){
        parent.layer.alert('选择的用户【' + rowData.name + '】数据是兼职信息，不允许设置，请重新选择！',{
                icon: 7,
                title:'提示',
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }
    if (rowData.userLocked != "0" || rowData.status != "1") {
        parent.layer.alert('不允许操作无效用户！', {
                icon: 7,
                title: '提示',
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }
    orgSecretIndex = parent.layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '组织密级'+'【'+rowData.name + '】',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl() + '/toOrgSecretList/' + rowData.id
    });
};




/**************************************************************************************************************/
/**
 * 设置是否无效
 */
function setValidFlag(){
	var rows = $('#jqGrid').jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
	$('.dropdown').removeClass('open');
	if(l > 0){

        for(var i = 0 ; i < rows.length ; i++){
            var rowData = $('#jqGrid').jqGrid('getRowData', rows[i]);
			if(rowData.sanyuan == "true"){
				parent.layer.alert('三员用户不允许操作！',{
						icon: 7,
						title:'提示',
						area: ['400px', ''], //宽高
						closeBtn: 0
					}
				);
				return false;
			}
            if(!checkChiefDept(rowData)){
                parent.layer.alert('选择的用户【' + rowData.name + '】数据是兼职信息，不允许设置，请重新选择！',{
                        icon: 7,
                        title:'提示',
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                    }
                );
                return false;
            }
        }
        parent.layer.confirm('确定要执行该操作吗?',
			{
		        title : '提示',
		        icon : 3,
		        closeBtn:0,
		        area: ['400px', ''],
		        btn: ['确定','取消']
			},function(index){
				for(;l--;){
					 ids.push(rows[l]);
				 }
				 $.ajax({
					 url:'platform/console/user/setValidFlag',
					 data : {ids : ids.join(',')},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.result == "0") {
							 parent.layer.msg('设置成功！',{
								 icon: 1,
								 area: ['200px', ''],
								 closeBtn: 0
							 });
							 $('#jqGrid').jqGrid().trigger("reloadGrid");
						}else{
							parent.layer.alert('设置失败！' + r.msg,{
								icon: 2,
								area: ['400px', ''],
								closeBtn: 0
							});
						}
					 }
				 });
				 parent.layer.close(index);
			});   
	}else{
		parent.layer.alert('请选择要设置的用户！', {
				title : '提示',
				icon : 0,
				area: ['400px', ''], //宽高
				closeBtn: 0
			}
		);
	}
}

/**
 * 重置密码
 */
function resetPassword(){
	var rows = $('#jqGrid').jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
	$('.dropdown').removeClass('open');
	if(l > 0){
        for(var i = 0 ; i < rows.length ; i++){
            var rowData = $('#jqGrid').jqGrid('getRowData', rows[i]);
			if(rowData.sanyuan == "true"){
				parent.layer.alert('三员用户不允许操作！',{
						icon: 7,
						title:'提示',
						area: ['400px', ''], //宽高
						closeBtn: 0
					}
				);
				return false;
			}
            if(!checkChiefDept(rowData)){
                parent.layer.alert('选择的用户【' + rowData.name + '】数据是兼职信息，不允许重置密码，请重新选择！',{
                        icon: 7,
                        title:'提示',
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                    }
                );
                return false;
            }
        }
		parent.layer.confirm('确认要重置密码吗?',
			{
			    title : '提示',
			    icon : 3,
			    closeBtn:0,
			    area: ['400px', ''],
			    btn: ['确定','取消']
			}, 
			function(index){
				for(;l--;){
					 var rowsdata = $('#jqGrid').jqGrid('getRowData',rows[l]);
						if(rowsdata.status !="1"||rowsdata.userLocked!="0"){
							parent.layer.alert('请选择有效的用户！',
								{
									title : '提示',
									icon : 0,
									area: ['400px', ''], //宽高
									closeBtn: 0		
								});
							return;
						}
					 ids.push(rows[l]);
				 }
				 $.ajax({
					url:'platform/console/user/resetPassword',
					 data : {ids : ids.join(',')},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.result == "0") {
							 	parent.layer.msg('重置成功！',
						 			{
								 		icon: 1,
								 		area: ['200px', ''],
								 		closeBtn: 0
						 			});
							 	$('#jqGrid').jqGrid().trigger("reloadGrid");
							 	
						}else{
							parent.layer.alert('重置失败！' + r.msg,
								{
							  		icon: 2,
							  		area: ['400px', ''], //宽高
							  		closeBtn: 0
								});
						}
					 }
				 });
				 parent.layer.close(index);
			});   
	}else{
		parent.layer.alert('请选择要重置密码的用户！',
			{
				title : '提示',
				icon : 0,
				area: ['400px', ''], //宽高
				closeBtn: 0
			});
	}
}
/**
 * 重置密码
 */
function activationPassword(){
	var rows = $('#jqGrid').jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		parent.layer.confirm('确定要激活密码吗?', function(index){
				for(;l--;){
					 /*var rowsdata = $('#jqGrid').jqGrid('getRowData',rows[l]);
						if(rowsdata.status !="1"||rowsdata.userLocked!="0"){
							 layer.msg('请选择有效的用户！');
						return;
						}*/
					 ids.push(rows[l]);
				 }
				 $.ajax({
					url:'platform/console/user/activationPassword',
					 data : {ids : ids.join(',')},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.result == "0") {
							 parent.layer.msg('激活密码成功！');
							 $('#jqGrid').jqGrid().trigger("reloadGrid");
						}else{
							parent.layer.alert('激活密码失败！' + r.msg,{
					  		icon: 7,
					  		area: ['400px', ''], //宽高
					  		closeBtn: 0
				    		}
		         			);
						}
					 }
				 });
				 parent.layer.close(index);
			});   
	}else{
		parent.layer.msg('请选择要操作的记录！');
	}
}
var modifyIndex;
function changePassword(url){
	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
	$('.dropdown').removeClass('open');
	var ids = $('#jqGrid').jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		parent.layer.alert('请选择要修改密码的用户！', {
			  title : '提示',
			  icon : 0,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
		return false;
	}else if(ids.length > 1){
		//var user =ids[0];
		//if(user.STATUS !="1"||user.USER_LOCKED!="0"){
			//$.messager.alert('提示',"请选择正常的用户！",'warning');
			//return false;
		//}
		parent.layer.alert('请选择一个用户！', {
			  title : '提示',
			  icon : 0,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
		return false;
	}
	var id =ids[0];
    var rowData = $('#jqGrid').jqGrid('getRowData', id);
	if(rowData.sanyuan == "true"){
		parent.layer.alert('三员用户不允许操作！',{
				icon: 7,
				title:'提示',
				area: ['400px', ''], //宽高
				closeBtn: 0
			}
		);
		return false;
	}
    if(!checkChiefDept(rowData)){
        parent.layer.alert('选择的用户【' + rowData.name + '】数据是兼职信息，不允许修改密码，请重新选择！',{
                icon: 7,
                title:'提示',
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }
	modifyIndex = layer.open({
	    type: 2,
	    area: ['500px', '250px'],
	    title: '修改密码【' + rowData.name + '】',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        shade: 0.5,//新增此项。修改问题：ie8浏览器下弹层与消息提示框背景色一致，导致显示异常
	    content: url+'/avicit/platform6/console/user/modifyUserPasswordbyadmin.jsp?userId=' + id
	});

}
function modifyPassword(uid,newPassword,oldPassword){
	
	  $.ajax({
		url : 'platform/console/user/'+uid+'/changePassword',
		data : {newPassword: newPassword,oldPassword:oldPassword},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if(r.s){
				layer.msg(r.s);
				layer.close(modifyIndex);
			}else{
				layer.alert(r.f,{
					  		icon: 7,
					  		area: ['400px', ''], //宽高
					  		closeBtn: 0
				    }
		         );
				layer.close(modifyIndex);
			}
			
		}
	});       
	        
			  
}


function modifyPasswordbyadmin(uid,newPassword,oldPassword){
	
	  $.ajax({
		url : 'platform/console/user/'+uid+'/changePasswordbyadmin',
		data : {newPassword: newPassword},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if(r.s){
				layer.msg(r.s,{
					icon: 1,
					area: ['200px', ''],
					closeBtn: 0
				});
				layer.close(modifyIndex);
			}else{
				layer.alert(r.f,{
					  		icon: 0,
					  		area: ['400px', ''], //宽高
					  		closeBtn: 0
				    }
		         );
				layer.close(modifyIndex);
			}
			
		}
	});       
	        
			  
}
function closeModiyPassworDilog(){
	layer.close(modifyIndex);
	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
	$('.dropdown').removeClass('open');
}

/**
 * 重置密码
 */
function resetAllPassword(){
	var totalNum = 0;
    $.ajax({
        url : consoleUser.getUrl()+'/operation/getSysUsersByPage.json',
        type : 'post',
        data : "",
        dataType : 'json',
        success : function(r) {
            totalNum = r.records;
        },
        complete:function( req ,status){
        	doResetAllPassword(totalNum);
        }
    });


	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
	$('.dropdown').removeClass('open');
}

function doResetAllPassword(num){
    var orgName = "";
    var treeNode = parent.orgtree.tree.getNodeByParam('id',parent.curOrgId,null);
    if(treeNode){
        orgName = '【'+ treeNode.text + '】';
    }
    var timeInfo ="";
    if(num > 100){
        timeInfo = '预计耗时约'+ parseInt(num * 0.075) +'秒，';
	}

	parent.layer.confirm('该操作会重置当前'+orgName+'组织下所有用户的密码，'+ timeInfo +'确定要执行该操作吗？',
	{
		title : '提示',
		icon : 0,
		closeBtn:0,
		area: ['400px', ''],
		btn: ['确定','取消']
	},
	function(index){
		if(index){
			avicAjaxLoading = parent.layer.load(2,{shade: [0.2, '#000'],scrollbar: false});
			$.ajax({
				url:'platform/console/user/resetAllPassword.json',
				data : "",
				type : 'post',
				dataType : 'json',
				success : function(r){
					parent.layer.close(avicAjaxLoading);
					if (r.result == "0") {
						parent.layer.msg('重置成功！',
							{
								icon: 1,
								area: ['200px', ''],
								closeBtn: 0
							});
						$('#jqGrid').jqGrid().trigger("reloadGrid");
					}else{
						parent.layer.alert('重置失败！' + r.error,
							{
								icon: 0,
								area: ['400px', ''], //宽高
								closeBtn: 0
							});
					}
				}

			});
			parent.layer.close(index);
		}
	});
}
/**
 * 查看某个人的权限
 */
function showPermisstionMenu(url){
	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
	$('.dropdown').removeClass('open');
	var ids = $('#jqGrid').jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		parent.layer.alert('请选择要查看的用户！', {
			  title : '提示',
			  icon : 0,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
		return false;
	}else if(ids.length > 1){
		//var user =ids[0];
		//if(user.STATUS !="1"||user.USER_LOCKED!="0"){
			//$.messager.alert('提示',"请选择正常的用户！",'warning');
			//return false;
		//}
		parent.layer.alert('请选择一个用户！', {
			  title : '提示',
			  icon : 0,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
		return false;
	}
		var rowId =ids[0];
    	var rowData = $('#jqGrid').jqGrid('getRowData', ids[0]);
    	var portalFlag = 0;//标记是否是前台用户
		if(rowData.consoleType.indexOf('前台用户') > -1){
            portalFlag = 1;

		}
		//修改问题：选择自己添加的用户，角色设置为“平台管理员”，没有弹出提示信箱，且打开的页面也是空白的
	    //修改后根据角色判断
		$.ajax({
			url:'ShowPermissController/getUserRoleInfo/' + rowId ,
			data : {},
			type : 'get',
			dataType : 'json',
			success : function(r){
				if(r !="" && r !=null && r != undefined && r.msg == "platform_manager" ){
                    parent.layer.alert('平台管理员拥有所有后台菜单的权限！', {
                            title : '提示',
                            icon : 0,
                            area: ['400px', ''], //宽高
                            closeBtn: 0
                        }
                    );
                    return false;
				}else{
                    showPermisstionIndex = parent.layer.open({
                        type: 2,
                        area: ['100%', '100%'],
                        title: '查看权限'+'【'+ rowData.name +'】',
                        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                        maxmin: false, //开启最大化最小化按钮
                        content: url+'avicit/platform6/console/user/showUserPermisstion.jsp?userId='+rowId+'&portalFlag='+portalFlag
                    });
                }
			}
		})
		/*if(rowData.loginName == 'admin'){
            parent.layer.alert('平台管理员拥有查看所有后台菜单的权限！', {
                    title : '提示',
                    icon : 0,
                    area: ['400px', ''], //宽高
                    closeBtn: 0
                }
            );
            return false;
		}*/
		//var path="platform/console/user/permissControllerInfo/"+__uid;
		/*showPermisstionIndex = parent.layer.open({
			type: 2,
			area: ['100%', '100%'],
			title: '查看权限'+'【'+ rowData.name +'】',
			skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
			maxmin: false, //开启最大化最小化按钮
			content: url+'avicit/platform6/console/user/showUserPermisstion.jsp?userId='+rowId+'&portalFlag='+portalFlag
		});*/

		
	
}



/**
 * 用户解锁
 */
function doUnLockSysUser(){
	var rows = $('#jqGrid').jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l = rows.length;
	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
	$('.dropdown').removeClass('open');
	if(l > 0){
        for(var i = 0 ; i < rows.length ; i++){
            var rowData =  $('#jqGrid').jqGrid('getRowData', rows[i]);
			if(rowData.sanyuan == "true"){
				parent.layer.alert('三员用户不允许操作！',{
						icon: 7,
						title:'提示',
						area: ['400px', ''], //宽高
						closeBtn: 0
					}
				);
				return false;
			}
            if(!checkChiefDept(rowData)){
                parent.layer.alert('选择的用户【' + rowData.name + '】数据是兼职信息，不允许解锁，请重新选择！',{
                        icon: 7,
                        title:'提示',
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                    }
                );
                return false;
            }
        }
        parent.layer.confirm('确认要解锁选择的用户吗?',
			{
			    title : '提示',
			    icon : 3,
			    closeBtn:0,
			    area: ['400px', ''],
			    btn: ['确定','取消']
			}, 
			function(index){
				for(;l--;){
					 ids.push(rows[l]);
					 var rowsdata = $('#jqGrid').jqGrid('getRowData',rows[l]);
					 
					 	if(rowsdata.userLocked =="0"){
					 		parent.layer.alert('请选择锁定的的用户！',{ 
						 			title : '提示',
						 			icon : 0,
						 			area: ['400px', ''], //宽高
						 			closeBtn: 0
					 			}
					 		);
							return;
						}
						if(rowsdata.status !="1"){
							parent.layer.alert('请选择锁定的的用户！',
								{
						 			title : '提示',
						 			icon : 0,
						 			area: ['400px', ''], //宽高
						 			closeBtn: 0
					 			}
							);
							return;
						}
				 }
				 $.ajax({
					url:'platform/console/user/doUnLockSysUser',
					 data : {ids : ids.join(',')},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.result == "0") {							 
							 parent.layer.msg('解锁成功！',
								{
									icon: 1,
									area: ['200px', ''],
									closeBtn: 0
								}
							 );
							 $('#jqGrid').jqGrid().trigger("reloadGrid");
						}else{
							parent.layer.alert('解锁失败！' + r.msg,
								{
							  		icon: 2,
							  		area: ['400px', ''], //宽高
							  		closeBtn: 0
					    		}
		         			);
						}
					 }
				 });
				 parent.layer.close(index);
			});   
	}else{
		parent.layer.alert('请选择要解锁的用户！', 
			{
				title : '提示',
				icon : 0,
				area : [ '400px', '' ], // 宽高
				closeBtn : 0
			}
		);
	}
}


/**
 * 移动用户部门
 */
function batchMoveDept(url){
	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
	$('.dropdown').removeClass('open');
	var ids = $('#jqGrid').jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		parent.layer.alert('请选择要移动的用户！', {
			  title : '提示',
			  icon : 0,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
		return false;
	}
    for(var i = 0 ; i < ids.length ; i++){
        var rowData = $('#jqGrid').jqGrid('getRowData', ids[i]);
		if(rowData.sanyuan == "true"){
			parent.layer.alert('三员用户不允许操作！',{
					icon: 7,
					title:'提示',
					area: ['400px', ''], //宽高
					closeBtn: 0
				}
			);
			return false;
		}
        if(!checkChiefDept(rowData)){
            parent.layer.alert('选择的用户【' + rowData.name + '】数据是兼职信息，不允许移动，请重新选择！',{
                    icon: 7,
                    title:'提示',
                    area: ['400px', ''], //宽高
                    closeBtn: 0
                }
            );
            return false;
        }
    }
    ids = ids.join(',');
	modifyIndex = parent.layer.open({
	    type: 2,
	    area: ['30%', '70%'],
	    title: '移动用户',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: url+'avicit/platform6/console/user/consoleSelectDept.jsp'
	});   
	
}

/**
 * 移动部门返回按钮
 */
function closeSelectDeptDilog(){
	parent.layer.close(modifyIndex);
	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
	$('.dropdown').removeClass('open');
}

/**
 * 保存批量移动部门
 */
function saveBatchMoveDept(deptId){
	if(""==deptId||null==deptId) {
        parent.layer.alert('获取部门为空', {
            title : '提示',
            icon : 0,
            area: ['400px', ''], //宽高
            closeBtn: 0
        });
    }
	var rows=$('#jqGrid').jqGrid('getGridParam','selarrrow');
	var ids = [];
	var deptIds=[];
	if (rows.length > 0) {
		for ( var i = 0, length = rows.length; i < length; i++) {
			var rowsdata = $('#jqGrid').jqGrid('getRowData',rows[i]);
			ids.push(rowsdata.id);
			deptIds.push(rowsdata.deptId);
		}
		$.ajax({
	        cache:false,
	        type: "POST",
	        url:"platform/sysdept/sysDeptController/saveBatchMoveDept",
	        dataType:"json",
	        data:{userIds:ids.join(','),newDeptId:deptId,oldDeptIds:deptIds.join(',')},
	        error: function(request) {
	    		parent.layer.alert('移动失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！', {
	    			  title : '提示',
	    			  icon : 0,
	    			  area: ['400px', ''], //宽高
	    			  closeBtn: 0
	    		});
	        },
	        success: function(data) {
				if(data.result==0){

					 $('#jqGrid').jqGrid().trigger("reloadGrid");
					 parent.layer.close(modifyIndex);
					 $('[data-toggle="dropdown"]').attr('aria-expanded','false');
					 $('.dropdown').removeClass('open');
					 parent.layer.msg('移动成功！',{
							icon: 1,
							area: ['200px', ''],
							closeBtn: 0
					 });
				}else{
					 parent.layer.alert('提示:' + ' ' + data.msg, {
							icon: 2,
							area: ['400px', ''],
							closeBtn: 0
						}
					 );
				}
	        }
	    });
	}else{
		parent.layer.alert('请选择要移动的用户！', {
			  title : '提示',
			  icon : 0,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
	}
}


var expSearchParams;






/**
 * 查看锁定日志
 */
 function toLockLog(){
 	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
 	$('.dropdown').removeClass('open');
 	var rows = $('#jqGrid').jqGrid('getGridParam','selarrrow');
	if(rows.length == 0){

		parent.layer.alert('请选择要查看的用户！', {
				title : '提示',
				icon : 0,
				area: ['400px', ''], //宽高
				closeBtn: 0
			}
		);
		return false;
	}else if(rows.length > 1){
		parent.layer.alert('请选择一个用户！', {
			title : '提示',
			icon : 0,
			area: ['400px', ''], //宽高
			closeBtn: 0
		}
	);
		return false;
	}
    var rowData = $('#jqGrid').jqGrid('getRowData', rows[0]);
	if(rowData.sanyuan == "true"){
		parent.layer.alert('三员用户不允许操作！',{
				icon: 7,
				title:'提示',
				area: ['400px', ''], //宽高
				closeBtn: 0
			}
		);
		return false;
	}
    if(!checkChiefDept(rowData)){
        parent.layer.alert('选择的用户【' + rowData.name + '】数据是兼职信息，不允许查看，请重新选择！',{
                icon: 7,
                title:'提示',
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }
	
	
	logIndex = parent.layer.open({
	    type: 2,
	    area: ['70%', '50%'],
	    title: '用户锁定日志'+'【'+ rowData.name +'】',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform/console/user/toUserLockJsp?id=' + rows[0]
	});   
		
	}



/**
 * 关闭锁定日志
 */
$closeUserLockLogDialog = function(){
	$("#userLockLogDialog").dialog('close');
};

/**
 * 导入数据从excel中
 */
function importUser(){

	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
	$('.dropdown').removeClass('open');
	
	importIndex = parent.layer.open({
	    type: 2,
	    area: ['70%', '70%'],
	    title: '导入用户',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform/excelImportController/excelimportnew/importEmployeeInfo/xls' 
	});   
}
function closeImportData(){
	$("#importData").dialog('close');
}

/**
 * 导出用户(客户端数据)
 */
function exportClientData(){
	parent.layer.confirm('确认要导出当前页用户?',
		{
			title : '提示',
			icon : 3,
			closeBtn:0,
			area: ['400px', ''],
			btn: ['确定','取消']
		},
		function(index) {
			if (index) {
				//封装参数
				var rows=$("#jqGrid").jqGrid("getRowData"); 
				var rownum =	$("#jqGrid").jqGrid('getGridParam','colModel');
                var showCols = [];
                var showIndex = 0;
                for(i=0; i< rownum.length; i++){
                	// 显示是否主部门
                    if(rownum[i].hidden!=true || rownum[i].name =='isChiefDept'){
                        showCols[showIndex] = rownum[i];
                        showIndex++;
                    }
                }
                // 仅导出在页面上显示的列信息
				var dataGridFields = JSON.stringify(showCols);
				var datas = JSON.stringify(rows);
				var myParams = {
						dataGridFields: dataGridFields,//表头信息集合
						datas: datas,//数据集
						hasRowNum : true,//默认为Y:代表第一列为序号
						sheetName: 'sheet1',//如果该参数为空，默认为导出的Excel文件名
						unContainFields : 'cb',//不需要导出的列，使用','分隔即可
						fileName: '用户导出数据',//导出的Excel文件名
				};
				var url = "platform/console/user/exportClient";
				var ep = new exportData("xlsExport","xlsExport",myParams,url);
				ep.excuteExport();
				parent.layer.close(index);
			}
		}
	);
	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
	$('.dropdown').removeClass('open');
}
/**
 * 导出用户(服务端数据)
 */
function exportServerData(){
	parent.layer.confirm('确认要导出所有用户?',
		{
			title : '提示',
			icon : 3,
			closeBtn:0,
			area: ['400px', ''],
			btn: ['确定','取消']
		},function(index) {
			if (index) {
				//封装参数
				var rows=$("#jqGrid").jqGrid("getRowData"); 
				var rownum =	$("#jqGrid").jqGrid('getGridParam','colModel');
                var showCols = []; // 状态列、性别列需要特殊处理,显示是否主部门
                var showIndex = 0;
                for(i=0; i< rownum.length; i++){
                    if(rownum[i].hidden!=true
						|| rownum[i].name == 'sex' || rownum[i].name=='status' ||rownum[i].name =='isChiefDept' ){
                        showCols[showIndex] = rownum[i];
                        showIndex++;
                    }
                }
				var dataGridFields = JSON.stringify(showCols);
				var datas = JSON.stringify(rows);

				expSearchParams = expSearchParams?expSearchParams:{};

				expSearchParams.dataGridFields=dataGridFields;
				expSearchParams.hasRowNum=false;
				expSearchParams.sheetName='sheet1';
				expSearchParams.unContainFields='status11,sex11,cb';
				expSearchParams.fileName='用户导出数据';

				var url = "platform/console/user/exportServer";
				var ep = new exportData("xlsExport","xlsExport",expSearchParams,url);
				ep.excuteExport();
				parent.layer.close(index);
			}
		}
	);
	$('[data-toggle="dropdown"]').attr('aria-expanded','false');
	$('.dropdown').removeClass('open');
}


/**
 * 移交待办
 */
var fromUserId = null;
function transferToDo(){
	var rows = $('#dgUser').datagrid('getChecked');
	if(rows.length == 0){
		$.messager.alert("提示", "请选择用户数据！");
		layer.alert('请选择要删除的数据！', {
	        title : '提示',
	        icon : 0,
	        area: ['400px', ''], //宽高
	        closeBtn: 0
		});
		return;
	}
	if(rows.length > 1){
		$.messager.alert("提示", "移交待办只能选择一条用户数据！");
		return;
	}
	$.ajax({
		url : 'platform/bpm/clientbpmdisplayaction/hasTask',
		data : {userId: rows[0].ID},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if(r.result == 0){
				$.messager.alert("提示", "该用户没有待办！");
			}else{
				fromUserId = rows[0].ID;
				var comSelector = new CommonSelector("user","userSelectCommonDialog",null,null,null,null,null,null,null,null,600,400);
				comSelector.init(false,'selectUserDialogCallBack',1); //选择人员  回填部门 */
			}
		}
	});
}
function selectUserDialogCallBack(data){
	if(data != null && data.length == 1){
		if(data[0].userId == fromUserId){
			$.messager.alert("提示", "移交人和接受人不能为同一人！");
			return;
		}
		$.ajax({
			url : 'platform/bpm/clientbpmWorkHandAction/transferAllTask',
			data : {fromUserId: fromUserId, toUserId: data[0].userId},
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if(r.result == true){
					$.messager.show({
						title : '提示',
						msg : '移交成功！'
					});
				}else{
					$.messager.alert("提示", "移交过程出错！");
				}
			}
		});
	}
	
	





//-----
	
	
}
//初始化用户拼音
function initPinYin(){
	var loadTip;
	var ids = $("#jqGrid").jqGrid('getGridParam','selarrrow');
	var l=ids.length;
	var tip="全部用户";
	if(l>0){
		tip="选择用户"
	}
	parent.layer.confirm('确认要初始化'+tip+'的全拼/简拼吗?' ,
		{
			title : '提示',
			icon : 3,
			closeBtn:0,
			area: ['400px', ''],
			btn: ['确定','取消']
		},
		function(index){
			$.ajax({
				url:'platform/console/user/operation/initUserPinYin',
				data:	JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				beforeSend:function(XMLHttpRequest){ 
					loadTip = parent.layer.load(2, {
					    shadeClose: false,
					    title: '加载中..',
					    shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
			     	},
				success : function(r){
					parent.layer.close(loadTip);
					if (r.flag == "success") {

						parent.layer.msg('初始化成功！',{
							icon: 1,
							area: ['200px', ''],
							closeBtn: 0
						});
					}else{
						parent.layer.alert('初始化失败！' + r.error,{
								icon: 2,
								area: ['400px', ''], //宽高
								closeBtn: 0
							}
						);
					}
				}
			});
			parent.layer.close(index);
		});
}
