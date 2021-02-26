/**
 * 
 */
function SysMigrateDb(datagrid, keyWordId, searchNames) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	this.url = "platform/migrate/sysMigrateDbController/";
	this._datagridId = "#" + datagrid;
	this._jqgridToolbar = "#t_" + datagrid;
	this._keyWordId = "#" + keyWordId;
	this._searchNames = searchNames;
	this.init.call(this);
}

// 初始化操作
SysMigrateDb.prototype.init = function() {
	var _this = this;
	$(_this._datagridId).jqGrid({
		url : _this.url + 'getSysMigrateDbsByPage',
		mtype : 'POST',
		datatype : "json",
		toolbar : [ true, 'top' ],
		colModel : [	{label : 'id', name : 'id', key : true, width : 75,hidden : true}, 
		            	{label : '数据库名称', name : 'dbName',width : 150},
		            	{label : '数据库类型', name : 'dbType', width : 150},
		            	{label : '数据库地址', name : 'dbIp', width : 150}, 
		            	{label : '数据库端口', name : 'dbPort', width : 150}, 
		            	{label : '用户名', name : 'dbUser',width : 150}, 
		            	//{label : '密码', name : 'dbPass', width : 150},
		            	{label : '数据库用途 ',name : 'dbUsage', width : 150,  formatter:_this.formatterDbUsage, unformat:_this.unFormatterDbUsage}
					 ],
		height : $(window).height() - 120,
		scrollOffset : 20, // 设置垂直滚动条宽度
		rowNum : 20,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		userDataOnFooter : true,
		pagerpos : 'left',
		loadonce : false,
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		styleUI : 'Bootstrap',
		viewrecords : true,
		multiselect : true,
        multiboxonly: true,
		autowidth : true,
		shrinkToFit : true,
		responsive : true,// 开启自适应
        hasTabExport:false,
        hasColSet:false,
		pager : "#jqGridPager"
	});
	$(_this._jqgridToolbar).append($("#tableToolbar"));

	$('.dropdown-menu').click(function(e) {
		e.stopPropagation();
	});
	$(_this._keyWordId).on('keydown', function(e) {
		if (e.keyCode == '13') {
			_this.searchByKeyWord();
		}
	});
};

SysMigrateDb.prototype.formatDetail = function(cellvalue, options, rowObject, isExpoot) {
	if (isExpoot) {
		return '<a href="javascript:void(0);" onclick="sysMigrateDb.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	} else {
		return cellvalue;
	}
};

//修改数据库用途的显示式样
SysMigrateDb.prototype.formatterDbUsage = function(cellvalue, options, rowObject) {
    var dbUsageString;
    if(cellvalue == "1"){
        dbUsageString = "目标数据库";
    }else{
        dbUsageString = "源数据库";
    }
    return dbUsageString;
};

//返回数据库用途的值
SysMigrateDb.prototype.unFormatterDbUsage = function(cellvalue, options, cellobject) {
    var dbUsageString;
    if(cellvalue == "目标数据库"){
        dbUsageString = "1";
    }else{
        dbUsageString = "2";
    }
    return dbUsageString;
};

// 添加页面
SysMigrateDb.prototype.insert = function() {
	var _this = this;
	layer.open({
		type : 2,
		//area : [ '100%', '100%' ],
        area : [ '683px', '80%' ],
		title : '添加数据源',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, // 开启最大化最小化按钮
		content : "avicit/platform6/migrate/migratedb/SysMigrateDbAdd.jsp"
	});
};
// 编辑页面
SysMigrateDb.prototype.modify = function() {
	var _this = this;
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择要编辑的数据！',{icon: 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
		return false;
	} else if (ids.length > 1) {
		layer.alert('只允许选择一条数据进行编辑！',{icon: 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	layer.open({
		type : 2,
        //area : [ '100%', '100%' ],
        area : [ '683px', '80%' ],
		title : '编辑数据源',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, // 开启最大化最小化按钮
		content : _this.url + 'initEditData/' + rowData.id
	});
};

// 控件校验 规则：表单字段name与rules对象保持一致
SysMigrateDb.prototype.formValidate = function(form) {
	var　rules = {
			dbName : {
				required : true,
				maxlength : 100,
                dbName: true
			},
			dbType : {
				required : true
			},
			dbIp : {
				ip:true,
				required : true
			},
			dbPort : {
				number:true,
				required : true,
				maxlength : 5
			},
			dbUser : {
				required : true,
				maxlength : 32
			},
			dbPass : {
				required : true,
				maxlength : 32
			},
        	dbUsage : {
				required : true
			}
		};
	var messages = {
            dbName:{
                required:"请填写数据库名称",
                maxlength:"最多可以输入100个字符",//"输入长度最多是5的字符串(汉字算一个字符)"
                dbName:"请输入英文，数字或'_'，'#'，'$'"
            },
            dbType:{
                required:"请选择数据库类型"
            },
            dbIp:{
                required:"请填写数据库IP地址",
                ip:"请填写正确IP地址"
            },
            dbPort:{
                required:"请填写数据库端口",
                maxlength:"最多可以输入5个数字",
				number:"请填写数字"
            },
			dbUser : {
				required : "请填写用户名",
				maxlength : "最多可以输入32个字符(一个中文字符长度为2)"
			},
			dbPass : {
				required : "请填写密码",
				maxlength : "最多可以输入32个字符"
			},
			dbUsage : {
            	required : "请选择数据库用途"
        	}
        };

    form.validate({
        rules: rules,
        messages: messages,
        errorClass: "error",
        success: 'valid',
        unhighlight: function (element, errorClass, validClass) { //验证通过
            $(element).tooltip('destroy').removeClass(errorClass);
        },

        //自定义错误消息放到哪里
        errorPlacement: function (error, element) {
            if ($(element).next("div").hasClass("tooltip")) {
                $(element).attr("data-original-title", $(error).text()).tooltip("show");
            } else {
                $(element).attr("title", $(error).text()).tooltip("show");
            }
        }
    });
};
// 保存功能
SysMigrateDb.prototype.save = function(form,windowName) {
	var _this = this;
    avicAjax.ajax({
        url: _this.url + "save",
        data: {data: JSON.stringify(serializeObject(form))},
        type: 'post',
        dataType: 'json',
        success: function (r) {
            if (r.flag == "success") {
                _this.closeDialog(windowName)
                _this.reLoad();
				layer.msg('保存成功！',{
					icon: 1,
					area: ['200px', ''],
					closeBtn: 0
				});
                // layer.msg('保存成功！', {icon: 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
            } else {
                // layer.alert('保存失败！', {icon: 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
				layer.alert('保存失败！' + r.error, {
						icon: 2,
						area: ['400px', ''],
						closeBtn: 0,
					}
				);
            }
        }
    });


};

//更新功能
SysMigrateDb.prototype.update = function(form,windowName) {
	var _this = this;
    avicAjax.ajax({
        url: _this.url + "update",
        data: {data: JSON.stringify(serializeObject(form))},
        type: 'post',
        dataType: 'json',
        success: function (r) {
            if (r.flag == "success") {
                if (r.result == -1) {
					layer.alert('该数据已经被其他程序更新，请刷新后再修改！' + r.error, {
							icon: 2,
							area: ['400px', ''],
							closeBtn: 0
						}
					);
                    // layer.alert('该数据已经被其他程序更新，请刷新后再修改！', {icon: 7});
                } else {
                    _this.closeDialog(windowName)
                    _this.reLoad();
                    // layer.msg('保存成功！', {icon: 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
					layer.msg('保存成功！',{
							icon: 1,
							area: ['200px', ''],
							closeBtn: 0
						}
					);
                }
            } else {
				layer.alert('保存失败！' + r.error, {
						icon: 2,
						area: ['400px', ''],
						closeBtn: 0
					}
				);
                // layer.alert('保存失败！', {icon: 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
            }
        }
    });


};
// 删除
SysMigrateDb.prototype.del = function() {
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var _this = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		layer.confirm('确认要删除选中的数据吗?', {icon : 3,title : "提示",closeBtn: 0,area : [ '400px', '' ]}, function(index) {
			for (; l--;) {
				ids.push(rows[l]);
			}
            avicAjax.ajax({
				url : _this.url + 'delete',
				data : JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success") {
						if(r.result == "1"){
							layer.alert('存在正在使用中的数据源，不能删除，请重新选择！' + r.error, {
									icon: 2,
									area: ['400px', ''],
									closeBtn: 0
								}
							);
                            // layer.alert('存在正在使用中的数据源，不能删除，请重新选择！',{icon:7 ,title: "提示",closeBtn:0,area: ['400px', '']});
						}else{
                            _this.reLoad();
                            // layer.msg('删除成功！',{icon:7 ,title: "提示",closeBtn:0,area: ['400px', '']});
							layer.msg('删除成功！',{
									icon: 1,
									area: ['200px', ''],
									closeBtn: 0
								}
							);
						}
					} else {
						// layer.alert('删除失败！',{icon: 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
						layer.alert('删除失败！' + r.error, {
								icon: 2,
								area: ['400px', ''],
								closeBtn: 0
							}
						);
					}
				}
			});
			layer.close(index);
		});
	} else {
		layer.alert('请选择要删除的数据' + r.error, {
				icon: 2,
				area: ['400px', ''],
				closeBtn: 0
			}
		);
		// layer.alert('请选择要删除的数据！',{icon: 7 ,title: "提示", closeBtn:0, area: ['400px', '']});
	}
};
// 重载数据
SysMigrateDb.prototype.reLoad = function() {
	var _this = this;
	var searchdata = {keyWord:""};
	$(_this._datagridId).jqGrid("setGridParam",{postData: searchdata,datatype:"json"}).trigger("reloadGrid");
};

// 关闭对话框
SysMigrateDb.prototype.closeDialog = function(windowName){
	var index = layer.getFrameIndex(windowName); //先得到当前iframe层的索引
    layer.close(index);
};


// 关键字段查询
SysMigrateDb.prototype.searchByKeyWord = function() {
	var _this = this;
    var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr("placeholder") ? "" : $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for ( var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
		keyWord : JSON.stringify(param)
	};
	$(_this._datagridId).jqGrid("setGridParam",{postData: searchdata,datatype:"json"}).trigger("reloadGrid");
};

// 测试连接
SysMigrateDb.prototype.testDbConnect = function(form){
    var _this = this;
    avicAjax.ajax({
        url : _this.url + "testDbConnect",
        data : {data : JSON.stringify(serializeObject(form))},
        type : 'post',
        dataType : 'json',
        success : function(r) {
            if (r.flag == "success" && r.result == "true") {
                // layer.msg('连接成功！',{icon: 1 ,title: "提示",area: ['400px', '']});
				layer.msg('连接成功！',{
						icon: 1,
						area: ['200px', ''],
						closeBtn: 0
					}
				);
            } else {
				layer.msg('连接失败！',{
						icon: 2,
						area: ['400px', ''],
						closeBtn: 0
					}
				);
                // layer.msg('连接失败！',{icon: 2 ,title: "提示",area: ['400px', '']});
            }
        }
    });
};

//数据原只能存在一个
SysMigrateDb.prototype.validateDBSource = function(form){
    var _this = this;
    var currentDbUsage = form.find("input[name='dbUsage']:checked").val();
    var datadbusage = form.find("#dbUsageTargetDb").attr("data-dbusage") || form.find("#dbUsageSourceDb").attr("data-dbusage");
    var isError = false;
    if(currentDbUsage == "2" && datadbusage != "2"){ //数据源是源数据库
        var data = $(_this._datagridId).jqGrid("getRowData");
        $.each(data,function(idx,obj){
            if(obj.dbUsage == currentDbUsage){
                //isError = true;
                //layer.alert('已配置了一个源数据库，请选择目标数据库！', {icon: 7});
                return false;
            }
        });
		if(!isError){
            avicAjax.ajax({
                url : _this.url + "isExistsSourceDb",
                data : {dbUsage: "2"},
                type : 'post',
                async : false,
                dataType : 'json',
                success : function(r) {
                    if (r.flag == "success" && r.result) {
                        isError = true;
                        layer.alert('已经配置了一个源数据库，请选择目标数据库！', {icon: 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
                    }
                }
            });
		}
	}

    return isError;

};

//数据库名+IP+端口号+用户名 只能存在一个
SysMigrateDb.prototype.validateDB = function(form){
    var _this = this;
    var dbId = form.find("#id").val();
    var dbType = form.find("#dbType").val().toUpperCase();
    var dbName = form.find("#dbName").val().toUpperCase();
    var ip = form.find("#dbIp").val().toUpperCase();
    var port = form.find("#dbPort").val().toUpperCase();
    var userName = form.find("#dbUser").val().toUpperCase();

    var isError = false;
    var data = $(_this._datagridId).jqGrid("getRowData");
    $.each(data,function(idx,obj){
        if((!dbId || dbId != obj.id)&& obj.dbType.toUpperCase() == dbType && obj.dbName.toUpperCase() == dbName && obj.dbIp.toUpperCase() == ip && obj.dbPort.toUpperCase() == port && obj.dbUser.toUpperCase() == userName){
            isError = true;
            layer.alert('该数据源已存在,请重新填写！', {icon: 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
            return false;
        }
    });
    if(!isError){
        avicAjax.ajax({
            url : _this.url + "isExistsDbByCondition",
            data : {dbId:dbId ? dbId : "", dbType: dbType, dbName:dbName, ip:ip, port:port, userName:userName},
            type : 'post',
            async : false,
            dataType : 'json',
            success : function(r) {
                if (r.flag == "success" && r.result) {
                    isError = true;
                    layer.alert('该数据源已存在,请重新填写！', {icon: 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
                }
            }
        });
    }
    return isError;

};


