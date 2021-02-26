function ConsoleRole(datausergrid,datarolegrid,url,searchD,form,keyWordId,keyUserWordId,searchNames,searchUserNames,datauserGridColModel,dataroleGridColModel,appId){
	if(!datausergrid || typeof(datausergrid)!=='string'&&datausergrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    };
    this._appId = appId;
	this._datausergridId="#"+datausergrid;
	this._datarolegridId="#"+datarolegrid;
	this._jqusergridToolbar="#t_"+datausergrid;
	this._roleId='';
	this._jqrolegridToolbar="#t_"+datarolegrid;
	this._JQUSER;
	this.notnullFiled=["roleName","roleCode","orderBy"];//非空字段
	this.notnullFiledComment=["角色名称","角色编码","排序"]; //非空字段注释
	this.lengthValidFiled = ["roleName","roleCode","orderBy"];
	//除时间,数字等类型长度校验字段注释
	this.lengthValidFiledComment = ["角色名称","角色编码","排序"];
	//
	this.lengthValidFiledSize = [50,50,6];
	var _onSelect=function(){};//单击node事件
    
	this.getOnSelect=function(){
		return _onSelect;
	};
	this.setOnSelect=function(func){
		_onSelect=func;
		return this;
	};
	
	
	this._doc = document;
	this._formId="#"+form;
	this._searchDialogId ="#"+searchD;
	this._keyWordId="#"+keyWordId;
	this._keyUserWordId="#"+keyUserWordId;
	this._searchNames = searchNames;
	this._searchUserNames = searchUserNames;
	this.datauserGridColModel = datauserGridColModel;
	this.dataroleGridColModel = dataroleGridColModel;
}
//初始化操作
ConsoleRole.prototype.init=function(){
	var _self = this;
	
	this._JQUSER=$(_self._datausergridId).jqGrid({
    	url: this.getUrl()+'/operation/togetSysUserByPostitionId/null',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.datauserGridColModel,
       
        scrollOffset: 20, //设置垂直滚动条宽度
        altRows:true,
        rowNum: 10	,
        rowList:[200,100,50,30,20,10],
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, //
		multiselect: true,
		autowidth: true,
		hasColSet:false,
		hasTabExport:false,
		responsive:true,
		pager: "#jqGridPager",
        cellEdit:true,
        cellsubmit: 'clientArray'
    });
	
    $(this._jqusergridToolbar).append($("#tableToolbar"));
    
    
    //------------------------------------
    
    
    $(_self._datarolegridId).jqGrid({
    	url: this.getUrl()+'/operation/getSysRolesByPage',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],
        postData : {appId:_self._appId},
        colModel: this.dataroleGridColModel,
        height: this._doc.documentElement.clientHeight-410,
      
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 10,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        pagerpos:'left',
        hasColSet:false,
		hasTabExport:false,
        styleUI : 'Bootstrap',
		viewrecords: true, //
		multiselect: true,
		 onCellSelect:function(rowid,iCol,cellcontent,e){
		 	_self._roleId = rowid;
		 	if(iCol!=0){
		 		_self.getOnSelect()(rowid);
		 	}
		 	
			
		},
		
		
		/*beforeEditCell:function(rowid, cellname, value, iRow, iCol){
        	if (value == '系统管理员'||value == '平台管理员'||value == '安全审计员'
        	||value == 'system_manager'||value == 'platform_manager'||value == 'safety_auditor'
        	||value == 'safety_manager') {
                 setTimeout(function () {
                     $(_self._datarolegridId).jqGrid('restoreCell', iRow, iCol);
                     $(_self._datarolegridId).jqGrid('restoreRow', iRow);
                 }, 1);
             }    	
        },*/
		autowidth: true,
		cellEdit:true,
        cellsubmit: 'clientArray',
		responsive:true,//开启自适应
        pager: "#jqGridPager1"
    });
	
    $(this._jqrolegridToolbar).append($("#tableToolbarrole"));
    
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
	$(_self._keyUserWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchUserByKeyWord();
		}
	});
};

//关键字段查询
ConsoleRole.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val();
	if(keyWord=="请输入名称或编码"){
		keyWord='';
	}
	var searchdata = {};
	if(keyWord==''){
		 searchdata = {
		keyWord : null,
		param : null
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
			param : null
		}
	}
	$(this._datarolegridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

//关键字段查询
ConsoleRole.prototype.searchUserByKeyWord = function() {
	var keyWord = $(this._keyUserWordId).val();
	if(keyWord=="输入用户名或登录名"){
		keyWord='';
	}
	var searchdata = {};
	if(keyWord==''){
		 searchdata = {
		keyWord : null,
		param : null
		}
	}else{
		var names = this._searchUserNames;

		var param = {};
		for ( var i in names) {
			var name = names[i];
			param[name] = keyWord;
		}
	 	searchdata = {
			keyWord : JSON.stringify(param),
			param : null
		}
	}
	
	$(this._datausergridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
ConsoleRole.prototype.insert = function(){
	
	$(this._datarolegridId).jqGrid('endEditCell');
	var newRowId = newRowStart + newRowIndex;
	var parameters = {
		rowID : newRowId,
		initdata : {},
		role :"first",
		useDefValues : true,
		useFormatter : true,
		addRowParams : {extraparam:{}}
	};
	$(this._datarolegridId).jqGrid('addRow', parameters);
	newRowIndex++;  
};
/**
 * 非空验证
 * @param 
 * @param 
 */
ConsoleRole.prototype.nullvalid = function(data,item,nullfiled,notnullFiledComment){
	var msg = "";
	$.each(data,function(i,dataitem){
        var attribute = dataitem[item] ;
        if(typeof (attribute) == "string" ){
            dataitem[item] = attribute.replace(/(^\s*)|(\s*$)/g,"");
        }
		if(dataitem[item] == ""){
			temp = false;
			msg = notnullFiledComment[$.inArray(item,nullfiled )]+"为必填字段";
	    }
	});
	return msg;
};
/**
 * 长度验证
 * @param 
 * @param 
 */
ConsoleRole.prototype.lengthvalid = function(data,item,lengthValidFiled,lengthValidFiledComment,lengthValidFiledSize){
	var msg = "";
	$.each(data,function(i,dataitem){
		if(dataitem[item] != "" && dataitem[item].replace(/[^\x00-\xff]/g,"**").length > lengthValidFiledSize[$.inArray(item,lengthValidFiled)]){
			msg = lengthValidFiledComment[$.inArray(item,lengthValidFiled)]+"的输入长度超过预设长度"+lengthValidFiledSize[$.inArray(item,lengthValidFiled)];
	    }
	});
	return msg;
};
/**
 * 保存功能
 * @param form
 * @param callback
 */
ConsoleRole.prototype.save = function(){
	var _self = this;
	var data = $(this._datarolegridId).jqGrid('getChangedCells');
	
	var rows= $(this._datarolegridId).jqGrid("getRowData");
	
	var l = rows.length,cache={};
	for(;l--;){
		row =rows[l];
		if(row.roleName==''||row.roleCode==''){
				layer.alert('角色名称或角色编码不允许为空，请输入！', {
					  icon: 7,
					  title :'提示',
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					}
				);
				return;
			}
		if(cache['n'+row.roleCode]){
			layer.alert('输入 的角色编码已经存在，请重新输入！' , {
    			  icon: 7,
    			  title :'提示',
    			  area: ['400px', ''], //宽高
    			  closeBtn: 0
    			 }
    		);
			return false;
		}
		cache["n"+row.roleCode]='cunzai';
		
	}
	$(this._datarolegridId).jqGrid('endEditCell');
	var data = $(this._datarolegridId).jqGrid('getChangedCells');
	var hasvalidate = true;
	$.each(_self.notnullFiled,function(i,item){
		var msg = _self.nullvalid(data, item, _self.notnullFiled,_self.notnullFiledComment);
		if(msg && msg.length>0){
			layer.alert(msg , {
    			  icon: 7,
    			  area: ['400px', ''], //宽高
    			  closeBtn: 0
    			 }
    		);
			hasvalidate= false;
			return false;
		}
	});
	$.each(_self.lengthValidFiled,function(i,item){
		if(hasvalidate){
			var msg = _self.lengthvalid(data, item,_self.lengthValidFiled,_self.lengthValidFiledComment, _self.lengthValidFiledSize);
			if(msg && msg.length>0){
				layer.alert(msg , {
	    			  icon: 7,
	    			  area: ['400px', ''], //宽高
	    			  closeBtn: 0
	    			 }
	    		);
				hasvalidate= false;
				return false;
			}
		}
	});
	 if(!hasvalidate){
		return false;
	}
	if(data && data.length > 0){
		for(var i = 0; i < data.length; i++){
			
			if(appid=='-11'&&data[i].usageModifier=='私有使用'){
				layer.alert('公有角色只能添加公共使用的角色，请重新选择应用范围！', {
					  icon: 7,
					  title :'提示',
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					}
				);
				return;
			}
			
			if(data[i].id.indexOf(newRowStart) > -1){
				data[i].id = '';
			}
			
			if(!/^(-)?[0-9]*$/.test(data[i].orderBy)){
				layer.alert('排序字段请输入整数！', {
					  icon: 7,
					  title:'提示',
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					}
				);
				return;
			}
			if(data[i].validFlag.indexOf('有效') > -1){
				data[i].validFlag = '1';
			}else{
				data[i].validFlag = '0';
			}
			if(data[i].usageModifier.indexOf('公共使用') > -1){
				data[i].usageModifier = '0';
			}else{
				data[i].usageModifier = '1';
			}
			
		}
		$.ajax({
			 url:this.getUrl()+'/operation/save/'+appid,
			 data : {data :JSON.stringify(data)},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					 _self.reLoad();
					 layer.msg('保存成功！');
				 }else{
					 layer.alert('保存失败！' + r.error, {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					}
				);
				 } 
			 }
		 });
		 
	}else{
	    layer.alert('没有修改数据！', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0,
					  title:'提示'
					}
		);
	}
};



/**
 * 删除
 */
ConsoleRole.prototype.del = function(){
	var rows = $(this._datarolegridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确认要删除选择的数据吗?', {icon: 3, title:"提示", area: ['400px', '']}, function(index){
				for(;l--;){
					 ids.push(rows[l]);
					 var rowsdata =$(_self._datarolegridId).jqGrid('getRowData',rows[l]);
					 if(rows[l].indexOf("new_row") > -1){
						 _self.reLoad();
						 layer.close(index);
						return;
					}
					
				
				 }
				 $.ajax({
					 url:_self.getUrl()+'/operation/delete',
					 data:	JSON.stringify(ids),
					 contentType : 'application/json',
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						if (r.flag == "success") {
							 _self.reLoad();
							 layer.msg('删除成功！');
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
		layer.alert('请选择要删除的数据！', {
			  icon: 7,
			  title:'提示',
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
	}
};
//打开高级查询框
ConsoleRole.prototype.openSearchForm = function(searchDiv){
	var _self = this;
	
	
	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	
	layer.open({
		type: 1,
	    area: ['50%', '40%'],
	    title: '查询',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
		btn: ['查询', '清空', '取消'],
		content: $(this._searchDialogId),
		success : function(layero, index) {
			
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


//打开高级查询框
ConsoleRole.prototype.openSearchRoleForm = function(searchDiv){
	var _self = this;
	
	
	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	
	layer.open({
		type: 1,
	    area: ['50%', '40%'],
	    title: '查询',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
		btn: ['查询', '清空', '取消'],
		content: $('#searcRolehDialog'),
		success : function(layero, index) {
			
		},
		yes: function(index, layero){
			_self.searchRoleData();
			layer.close(index);
		},
		btn2: function(index, layero){
			_self.clearRoleData();
			return false;
		},
		btn3: function(index, layero){
			
		}
	});
};
//重载数据
ConsoleRole.prototype.reLoad=function(){
	
	$(this._datarolegridId).jqGrid('setGridParam',{postData: {}}).trigger("reloadGrid");
	
};

ConsoleRole.prototype.reLoadByAppid=function(appId){
	if(appid=='-11'){
  		$('#exportrole').addClass("disabled");
    }else{
    	$('#exportrole').removeClass("disabled");
    }
	$(this._datarolegridId).jqGrid('setGridParam',{postData:{appId:appId}}).trigger("reloadGrid");
	
};
/*清空查询条件*/
ConsoleRole.prototype.clearData =function(){
	clearFormData(this._formId);
	this.searchData();
};

/*清空查询条件*/
ConsoleRole.prototype.clearRoleData =function(){
	clearFormData('#formrole');
	this.searchRoleData();
};

//高级查询
ConsoleRole.prototype.searchData =function(){
	var _self = this;
	var param = {
			keyWord: null,
			param:JSON.stringify(serializeObject($(this._formId)))
		};
	$(this._datausergridId).jqGrid('setGridParam',{url: 'console/role/operation/togetSysUserByPostitionId/'+_self._roleId,postData: param}).trigger("reloadGrid");
};
ConsoleRole.prototype.searchRoleData =function(){
	var _self = this;
	var param = {
			keyWord: null,
			param:JSON.stringify(serializeObject($('#formrole')))
		};
	$(this._datarolegridId).jqGrid('setGridParam',{postData: param}).trigger("reloadGrid");
};
ConsoleRole.prototype.loaduserByid = function(roleId){
	var _self = this;
	//var param = {param:JSON.stringify(roleId)}
	var param = {param:''};
	$(this._datausergridId).jqGrid('setGridParam',{url: 'console/role/operation/togetSysUserByPostitionId/'+roleId,postData: param}).trigger("reloadGrid");
};

ConsoleRole.prototype.importrole =function(){
   var extparam=JSON.stringify({
							'appid' : appid
						});
	importorgIndex = layer.open({
	    type: 2,
	    area: ['70%', '70%'],
	    title: '导入角色',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: 'platform/excelImportController/excelimportnew/importRole/xls?extPara='+appid
	});   
};

var newRowIndex_User = 0;
var newRowStart_User = "new_row_user";
ConsoleRole.prototype.insertUser =function(){
var _self = this;
	var rows = $(this._datarolegridId).jqGrid('getGridParam','selarrrow');
	if(_self._roleId==""){
			layer.alert('请选择添加用户的角色数据！',{
				  icon: 7,
				  area: ['400px', ''],
				  closeBtn: 0,
				  title:'提示'
			});
			return;
    }
    var l =rows.length;
	if(l>1){
		layer.alert('只允许选择一条数据！', {
								  icon: 7,
								  area: ['400px', ''],
								  closeBtn: 0,
								  title:'提示'
				}
		);
		return;
    }

	

    /*$(this._datausergridId).jqGrid('endEditCell');
    var newRowId = newRowStart_User + newRowIndex_User;
    var parameters = {
        rowID : newRowId,
        initdata : {},
        role :"first",
        useDefValues : true,
        useFormatter : true,
        addRowParams : {extraparam:{}}
    };
    $(this._datausergridId).jqGrid('addRow', parameters);
    newRowIndex_User++;*/

    new H5CommonSelect({
        type : 'userSelect',
        selectModel : 'multi',
        idFiled : 'user',
        hidTab:["role"],
        textFiled : 'userfile',
        callBack:selectUserBack,
        hasExtendData:true,
        viewScope : 'currentOrg',
        getAll:'true'
    });
    function selectUserBack(user){
        if(_self._roleId==""){
            layer.alert('请选择角色！', {
                icon: 0,
                area: ['400px', ''],
                closeBtn: 0,
                title:'提示'
            });
            return;
        }
        if(user.userids==""){
            layer.alert('请选择用户！', {
                icon: 0,
                area: ['400px', ''],
                closeBtn: 0,
                title:'提示'
            });
            return;
        }
        ///$.each(user.userjsonArray,function(i,user){
        $.ajax({
            url:_self.getUrl()+'/operation/insertRoleuser',
            data:	{ids:user.userids,roleId:_self._roleId},
            type : 'post',
            dataType : 'json',
            success : function(r){
                if (r.flag == "success") {
                    //_self._JQUSER.addRowData(user.id,user,'first');
					layer.msg('添加成功！',{
						icon: 1,
						area: ['200px', ''],
						closeBtn: 0
					});
                    _self.loaduserByid(_self._roleId);
                }else{
                    layer.alert('添加失败！' + r.error, {
                            icon: 2,
                            area: ['400px', ''],
                            closeBtn: 0,
                        }
                    );
                }
            }
        });
        //})
    }
};

ConsoleRole.prototype.saveUser = function () {
    var _self = this;
    var rows = $(this._datarolegridId).jqGrid('getGridParam','selarrrow');
    if(_self._roleId==""){
        layer.alert('请选择保存用户的角色数据！',{
            icon: 0,
            area: ['400px', ''],
            closeBtn: 0,
            title:'提示'
        });
        return;
    }
    var l =rows.length;
    if(l>1){
        layer.alert('只允许选择一个角色数据！', {
                icon: 0,
                area: ['400px', ''],
                closeBtn: 0,
                title:'提示'
            }
        );
        return;
    }

    $(this._datausergridId).jqGrid('endEditCell');
    var data = $(this._datausergridId).jqGrid('getChangedCells');

    if (data && data.length > 0) {
        for (var i = 0; i < data.length; i++) {
            if (data[i].id.indexOf(newRowStart_User) > -1) {
                data[i].id = '';
            }
        }

        $.ajax({
            url:_self.getUrl()+'/operation/insertRoleuserV2',
            data:	{roleId:_self._roleId, data:JSON.stringify(data)},
            type : 'post',
            dataType : 'json',
            success : function(r){
                if (r.flag == "success") {
                    _self.loaduserByid(_self._roleId);
                }else{
                    _self.loaduserByid(_self._roleId);
                    layer.alert('添加失败！' + r.error, {
                            icon: 2,
                            area: ['400px', ''],
                            closeBtn: 0,
                        }
                    );
                }
            }
        });
    } else {
        layer.alert('请添加或修改数据！', {
                icon: 7,
                area: ['400px', ''],
                closeBtn: 0
            }
        );
    }
};

ConsoleRole.prototype.deleteUser =function(){
	var rows = $(this._datausergridId).jqGrid('getGridParam','selarrrow');
	
	var _self = this;
	
	if(_self._roleId==""){
		layer.alert('请选择要删除用户的角色数据！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  title:'提示'
			}
		);
			return;
    }
    var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确认要删除选择的数据吗?', {icon: 3, title:"提示", area: ['400px', '']}, function(index){
				for(;l--;){
					 ids.push(rows[l]);
				 }
				 $.ajax({
					 url:_self.getUrl()+'/operation/deleteRoleuser',
					 data:	{ids:JSON.stringify(ids),roleId:_self._roleId},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						if (r.flag == "success") {
							 _self.loaduserByid(_self._roleId);
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
		layer.alert('请选择要删除的数据！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  title:'提示'
			}
		);
	} 
};
/**
 * 导出用户(客户端数据)
 */
function exportClientData(){
	layer.confirm('确认要导出当前页数据吗?',{icon: 3, title:"提示", area: ['400px', '']},function(index) {
        if (index) {
            //封装参数
            
            $("#jqGridrole").jqGrid('endEditCell');
            var rows=$("#jqGridrole").jqGrid("getRowData"); 
          	var rownum =	$("#jqGridrole").jqGrid('getGridParam','colModel');
          	var dataGridFields = JSON.stringify(rownum);
            var datas = JSON.stringify(rows);
            var myParams = {
                dataGridFields: dataGridFields,//表头信息集合
                datas: datas,//数据集
                hasRowNum : true,//默认为Y:代表第一列为序号
                sheetName: 'sheet1',//如果该参数为空，默认为导出的Excel文件名
                unContainFields : 'STATUS_LABEL,EMAIL,id,cb',//不需要导出的列，使用','分隔即可
                fileName: '角色导出数据' //导出的Excel文件名
            };
            var url = "platform/cc/crole/exportClient";
            var ep = new exportData("xlsExport","xlsExport",myParams,url);
            ep.excuteExport();
            layer.close(index);
        }
       });
}
/**
 * 导出用户(服务端数据)
 */
function exportServerData(){
	layer.confirm('确认要导出所有页数据吗?',{icon: 3, title:"提示", area: ['400px', '']},function(index) {
        if (index) {
            //封装参数
            var rows=$("#jqGridrole").jqGrid("getRowData"); 
          	var rownum =$("#jqGridrole").jqGrid('getGridParam','colModel');
          	var dataGridFields = JSON.stringify(rownum);
            var datas = JSON.stringify(rows);
            
            expSearchParams ={};
            
            expSearchParams.dataGridFields=dataGridFields;
            expSearchParams.hasRowNum=false;
            expSearchParams.sheetName='sheet1';
            expSearchParams.unContainFields='STATUS_LABEL,EMAIL,id,cb';
            expSearchParams.fileName='角色导出数据';
            expSearchParams.appId = appid;
            var url = "platform/cc/crole/exportServer";
            var ep = new exportData("xlsExport","xlsExport",expSearchParams,url);
            ep.excuteExport();
             layer.close(index);
        }
       });
}


