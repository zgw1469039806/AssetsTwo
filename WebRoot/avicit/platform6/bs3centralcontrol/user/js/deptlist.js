/**
 * 初始化对象
 * @param datagrid 表格Id
 * @param url URL参数
 * @param searchDialogId 高级查询Id
 * @param form 高级查询formId
 * @param keyWordId 关键字查询框Id
 * @param searchNames 关键字查询项名称Array
 * @param dataGridColModel 表格列属性Array
 */
function DeptList(datagrid, url, dataGridColModel,userId){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    };
    this.userId = userId;
	this._datagridId="#"+datagrid;
	this._jqgridToolbar="#t_"+datagrid;
	this._doc = document;
	this.notnullFiled=["deptId","deptName","positionId","positionName","isManager","isChiefDept"];//非空字段
	this.notnullFiledComment=["部门ID","部门名称","岗位ID","岗位名称","是否主管","主部门"]; //非空字段注释
	//除时间,数字等类型长度校验字段
	this.lengthValidFiled = [];
	//除时间,数字等类型长度校验字段注释
	this.lengthValidFiledComment = [];
	//
	this.lengthValidFiledSize = [50,50,50,50,50,5];
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
}
/**
 * 初始化操作
 */
DeptList.prototype.init = function(){
	var lastEditRowID;
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: this.getUrl(),
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],//启用toolbar
        colModel: this.dataGridColModel,//表格列的属性
        height:$(window).height() - 120,//初始化表格高度
        scrollOffset: 20, //设置垂直滚动条宽度
        altRows:true,//斑马线
        styleUI : 'Bootstrap', //Bootstrap风格
		viewrecords: true, //是否要显示总记录数
		multiselect: true,//可多选
		autowidth: true,//列宽度自适应
		responsive:true,//开启自适应
        cellEdit:true,
        cellsubmit: 'clientArray'/*,
        beforeEditCell:function(rowid, cellname, value, iRow, iCol){
        	_self.colname = cellname;         	
        },
        afterRestoreCell:function(rowid,value,iRow,iCol){ 
        	if(value == ""){
		    	if($.inArray(_self.colname, _self.notnullFiled) > 0){
		    		if(_self.lastrowid == ""){
		    			_self.rowIds.push(iRow);
		    			_self.lastrowid = rowid;
		        	}else{
		        		if(rowid != lastrowid){
		        			_self.rowIds.push(iRow);
		        		}
		        	}
		    	}
        		
			}else{
				if($.inArray(_self.colname, _self.lengthValidFiled) > 0){
					if(value.replace(/[^\x00-\xff]/g,"**").length >  _self.lengthValidFiledSize[$.inArray(_self.colname,_self.lengthValidFiled)]){
						if(_self.lastrowid == ""){
			    			_self.rowIds.push(iRow);
			    			_self.lastrowid = rowid;
			        	}else{
			        		if(rowid != lastrowid){
			        			_self.rowIds.push(iRow);
			        		}
			        	}
					}
				}
			}
        }*/
    });
	
	//放入表格toolbar中
    $(this._jqgridToolbar).append($("#tableToolbar"));

    //初始化时间控件
    $('.date-picker').datepicker({
		beforeShow: function () {
			setTimeout(function () {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
    });
	$('.time-picker').datetimepicker({
	 	oneLine:true,//单行显示时分秒
	 	showButtonPanel:true,//是否展示功能按钮面板
	 	closeText:'确定',
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
};
 /**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
DeptList.prototype.insert = function(){
	$(this._datagridId).jqGrid('endEditCell');
	var newRowId = newRowStart + newRowIndex;
	var parameters = {
		rowID : newRowId,
		initdata : {},
		position :"first",
		useDefValues : true,
		useFormatter : true,
		addRowParams : {extraparam:{}}
	};
	$(this._datagridId).jqGrid('addRow', parameters);
	newRowIndex++;  
};
/**
 * 非空验证
 * @param 
 * @param 
 */
DeptList.prototype.nullvalid = function(data,item,notnullfiled,notnullFiledComment){
	var msg = "";
	$.each(data,function(i,dataitem){
		if(dataitem[item] == ""){
			temp = false;
			var index=$.inArray(item,notnullfiled );
			if(index==0||index==2){
				index++;
			}
			msg = notnullFiledComment[index]+"为必填字段";
	    }
	});
	return msg;
};
/**
 * 长度验证
 * @param 
 * @param 
 */
DeptList.prototype.lengthvalid = function(data,item,lengthValidFiled,lengthValidFiledComment,lengthValidFiledSize){
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
DeptList.prototype.save = function(){
	var _self = this;
	var consoleUser = parent.consoleUser;
	$(this._datagridId).jqGrid('endEditCell');
	var data = $(this._datagridId).jqGrid('getChangedCells');
	
	/*var rows= $(this._datagridId).jqGrid("getRowData");
	var l = rows.length,cache={};
	for(;l--;){
		row =rows[l];
		if(cache[row.deptId]){
			_self.reLoad();
			layer.alert('部门名称已经存在' , {
    			  icon: 7,
    			  area: ['400px', ''], //宽高
    			  closeBtn: 0
    			 }
    		);
			return false;
		}
		if(cache[row.deptId]!=undefined){
			cache[row.deptId]=1;
		}
		
	}*/
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
	 if(!hasvalidate){
		return false;
	}
	if(data && data.length > 0){
		for(var i = 0; i < data.length; i++){
			if(data[i].id.indexOf(newRowStart) > -1){
				data[i].id = '';
			}
			if(data[i].isManager.indexOf('是') > -1){
				data[i].isManager = '1';
			}else{
				data[i].isManager = '0';
			}
			/*if(data[i].isChiefDept.indexOf('是') > -1){
				data[i].isChiefDept = '1';
			}else{
				data[i].isChiefDept = '0';
			}*/
            data[i].isChiefDept = '0';
		}
		$.ajax({
			 url:'platform/console/user/saveMapDept',
			 data : {data :JSON.stringify(data),userId:_self.userId},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					 _self.reLoad();
					 layer.msg('保存成功！');
					 consoleUser.reLoad();
				 }else{
					 _self.reLoad();
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
	    layer.alert('请先修改数据！', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					}
		);
	}
};



/**
 * 删除
 */
DeptList.prototype.del = function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确定要删除该数据吗?', {icon: 2, title:"请确认：", area: ['400px', '']}, function(index){
				for(;l--;){
				 var rowsdata =$(_self._datagridId).jqGrid('getRowData',rows[l]);
				 	if(rowsdata.deptId==""){
				 	 _self.reLoad();
						layer.msg('删除成功！');
						
						return;
					}
					 ids.push(rows[l]);
				 }
				 $.ajax({
					 url:'platform/console/user/deleteMapDept',
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

/**
 * 重载数据
 */
DeptList.prototype.reLoad = function(){
	var searchdata = {
		keyWord: null,
		param:JSON.stringify(serializeObject($(this._formId)))
	};
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
};

/**
 * 修改行数据
 * @param rowData
 */
DeptList.prototype.setSelRowData = function(rowData){
    var selected = $(this._datagridId).jqGrid('getGridParam', 'selrow');
    if (selected != null) {
        $(this._datagridId).jqGrid('setRowData', selected, rowData);
    }
}

//******************************************************



/**
 * jqGrid单表单元格编辑选部门控件扩展
 * @param value
 * @param options
 */
function deptcustomElem(value, options) {
	var rowId = options.rowId;
	var forId = options.forId;
	var rowData = $(this).jqGrid('getRowData', rowId);
	var viewScopeType='';
				if(isAdmin=="true"){
					viewScopeType = 'all';
				}else{
					viewScopeType = 'allowAcross';
				}
	var elem = $('<div class="input-group input-group-sm">'
			+ '<input type="hidden" id="cellRowId" value="'+ rowId +'">'
			+ '<input type="hidden" id="cellForId" value="'+ forId +'">'
			+ '<input type="hidden" id="cellDeptid" value="'+ rowData[forId] +'">'
			+ '<input class="form-control" placeholder="请选择部门" type="text" id="cellDeptidAlias" value="'+ value +'">'
			+ '<span class="input-group-addon">'
			+ '<i class="glyphicon glyphicon-equalizer"></i>' + '</span>'
			+ '</div>');

	elem.find('#cellDeptidAlias, .input-group-addon').on('click',
			function() {
				
				new H5CommonSelect({
					type : 'deptSelect',
					idFiled : 'cellDeptid',
					textFiled : 'cellDeptidAlias',
					callBack:selectDeptBack,
					getAll:'true',
					viewScope:viewScopeType
				});
	});
	new H5CommonSelect({
		type : 'deptSelect',
		idFiled : 'cellDeptid',
		textFiled : 'cellDeptidAlias',
		callBack:selectDeptBack,
					getAll:'true',
					viewScope:viewScopeType
	});
	
	return elem[0];
}

function selectDeptBack(dept){
    var OrgId =dept.orgIdentitys.split(';')[0];
    // 修改部门信息后，重制岗位，写入组织id
    deptlist.setSelRowData({positionName:"", positionId:'',orgIdentityId:OrgId});
}
function deptcustomValue(elem, operation, value) {
	if (operation === 'get') {
		var rowId = $(elem).find('#cellRowId').val();
		var forId = $(elem).find('#cellForId').val();
		var deptId = $(elem).find('#cellDeptid').val();
		var rowData = {};
		rowData[forId] = deptId;
		$(this).jqGrid('setRowData', rowId, rowData);
		return $(elem).find('.form-control').val();
	} else if (operation === 'set') {
		$(elem).find('.form-control').val(value);
	}
}




/**
 * jqGrid单表单元格编辑选部门控件扩展
 * @param value
 * @param options
 */
function positioncustomElem(value, options) {

    var deptId =  $(this).jqGrid("getCell", options.rowId, 'deptId');
    if(value==''||value=='请先选择部门'){
        if(typeof(deptId) =='undefined'||deptId==""){
            layer.alert('请先选择部门！', {
                    icon: 7,
                    area: ['400px', ''], //宽高
                    closeBtn: 0
                }
            );
            return '0';
        }
    }


    var rowId = options.rowId;
	var forId = options.forId;
	var rowData = $(this).jqGrid('getRowData', rowId);

	var elem = $('<div class="input-group input-group-sm">'
			+ '<input type="hidden" id="cellRowId" value="'+ rowId +'">'
			+ '<input type="hidden" id="cellForId" value="'+ forId +'">'
			+ '<input type="hidden" id="cellpositionid" value="'+ rowData[forId] +'">'
			+ '<input class="form-control" placeholder="请选择岗位" type="text" id="cellpositionAlias" value="'+ value +'">'
			+ '<span class="input-group-addon">'
			+ '<i class="glyphicon glyphicon-equalizer"></i>' + '</span>'
			+ '</div>');

	elem.find('#cellpositionAlias, .input-group-addon').on('click',
			function() {
				var viewScopeType='';
				if(isAdmin=="true"){
					viewScopeType = '';
				}else{
					viewScopeType = 'currentOrg';
				}
                var orgIdentity = rowData['orgIdentityId'];
				new H5CommonSelect({
					type : 'positionSelect',
					idFiled : 'cellpositionid',
					textFiled : 'cellpositionAlias',
					defaultOrgId:orgIdentity
				});
	});
    var orgIdentity = rowData['orgIdentityId'];
	new H5CommonSelect({
		type : 'positionSelect',
		idFiled : 'cellpositionid',
		textFiled : 'cellpositionAlias',
		defaultOrgId:orgIdentity
	});
	return elem[0];
}

function positioncustomValue(elem, operation, value) {

	if (operation === 'get') {
		var rowId = $(elem).find('#cellRowId').val();
		var forId = $(elem).find('#cellForId').val();
		var postionId = $(elem).find('#cellpositionid').val();
		var rowData = {};
		rowData[forId] = postionId;

		$(this).jqGrid('setRowData', rowId, rowData);
		return $(elem).find('.form-control').val();
	} else if (operation === 'set') {
		$(elem).find('.form-control').val(value);
	}
}



