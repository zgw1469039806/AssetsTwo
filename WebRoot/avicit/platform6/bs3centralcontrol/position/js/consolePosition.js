function ConsolePosition(datausergrid,datapositiongrid,url,searchD,form,keyWordId,keyUserWordId,searchNames,searchUserNames,datauserGridColModel,datapositionGridColModel){
	if(!datausergrid || typeof(datausergrid)!=='string'&&datausergrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
	this._datausergridId="#"+datausergrid;
	this._datapositiongridId="#"+datapositiongrid;
	this._jqusergridToolbar="#t_"+datausergrid;
	this._positionId='';
	this._jqpositiongridToolbar="#t_"+datapositiongrid;
	
	this.notnullFiled=["positionName","positionCode","orderBy"];//非空字段
	this.notnullFiledComment=["岗位名称","岗位编码","排序"]; //非空字段注释
	
	this.lengthValidFiled = ["positionName","positionCode","orderBy","positionDesc"];
	//除时间,数字等类型长度校验字段注释
	this.lengthValidFiledComment = ["岗位名称","岗位编码","排序","描述"];
	//
	this.lengthValidFiledSize = [50,50,6,100];
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
	this.datapositionGridColModel = datapositionGridColModel;
};
//初始化操作
ConsolePosition.prototype.init=function(){
	var _self = this;
	
	$(_self._datausergridId).jqGrid({
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
		pager: "#jqGridPager"
    });
	
    $(this._jqusergridToolbar).append($("#tableToolbar"));
    
    
    //------------------------------------
    
    
    $(_self._datapositiongridId).jqGrid({
    	url: this.getUrl()+'/operation/getSysPositionsByPage',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.datapositionGridColModel,
       height: this._doc.documentElement.clientHeight-410,
        
        scrollOffset: 20, //设置垂直滚动条宽度
       rowNum: 10	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        hasColSet:false,
		hasTabExport:false,
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, //
		multiselect: true,
		onCellSelect:function(rowid,iCol,cellcontent,e){
			_self._positionId = rowid;
			_self.getOnSelect()(rowid);
		},
		autowidth: true,
		cellEdit:true,
        cellsubmit: 'clientArray',
		responsive:true,//开启自适应
        pager: "#jqGridPager1"
    });
	
    $(this._jqpositiongridToolbar).append($("#tableToolbarPosition"));
    
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
ConsolePosition.prototype.searchByKeyWord = function() {
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
	$(this._datapositiongridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
}

//关键字段查询
ConsolePosition.prototype.searchUserByKeyWord = function() {
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
}
/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
ConsolePosition.prototype.insert = function(){
	
	$(this._datapositiongridId).jqGrid('endEditCell');
	var newRowId = newRowStart + newRowIndex;
	var parameters = {
		rowID : newRowId,
		initdata : {},
		position :"first",
		useDefValues : true,
		useFormatter : true,
		addRowParams : {extraparam:{}}
	}
	$(this._datapositiongridId).jqGrid('addRow', parameters);
	newRowIndex++;  
};
/**
 * 非空验证
 * @param 
 * @param 
 */
ConsolePosition.prototype.nullvalid = function(data,item,nullfiled,notnullFiledComment){
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
	})
	return msg;
}

/**
 * 长度验证
 * @param 
 * @param 
 */
ConsolePosition.prototype.lengthvalid = function(data,item,lengthValidFiled,lengthValidFiledComment,lengthValidFiledSize){
	var msg = "";
	$.each(data,function(i,dataitem){
		if(dataitem[item] != "" && dataitem[item].replace(/[^\x00-\xff]/g,"**").length > lengthValidFiledSize[$.inArray(item,lengthValidFiled)]){
			msg = lengthValidFiledComment[$.inArray(item,lengthValidFiled)]+"的输入长度超过预设长度"+lengthValidFiledSize[$.inArray(item,lengthValidFiled)];
	    }
	})
	return msg;
}

/**
 * 保存功能
 * @param form
 * @param callback
 */
ConsolePosition.prototype.save = function(){
	var _self = this;
	var data = $(this._datapositiongridId).jqGrid('getChangedCells');
	
	var rows= $(this._datapositiongridId).jqGrid("getRowData");
	var l = rows.length,cache={};
	for(;l--;){
		row =rows[l];
		if(row.positionName==''||row.positionCode==''){
				layer.alert('岗位名称或者岗位编码不能为空', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					}
				);
				return;
			}
		if(cache[row.positionCode]){
			layer.alert('岗位已经存在' , {
    			  icon: 7,
    			  area: ['400px', ''], //宽高
    			  closeBtn: 0
    			 }
    		);
			return false;
		}
		cache[row.positionCode]='cunzai';
	}
	$(this._datapositiongridId).jqGrid('endEditCell');
	var data = $(this._datapositiongridId).jqGrid('getChangedCells');
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
			if(data[i].id.indexOf(newRowStart) > -1){
				data[i].id = '';
			}
		if(!/^(-)?[0-9]*$/.test(data[i].orderBy)){
				layer.alert('排序字段请输入整数！', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					}
				);
				return;
			}
			
		}
		$.ajax({
			 url:this.getUrl()+'/operation/save',
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
ConsolePosition.prototype.del = function(){
	var rows = $(this._datapositiongridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确认要删除选择的数据吗?', {icon: 3, title:"提示", area: ['400px', '']}, function(index){
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
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  title:'提示'
			}
		);
	}
};
//打开高级查询框
ConsolePosition.prototype.openSearchForm = function(searchDiv){
	var _self = this;
	
	
	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	
	layer.open({
		type: 1,
	    area: ['50%', '40%'],
	    title: '添加',
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
//重载数据
ConsolePosition.prototype.reLoad=function(){
	
	$(this._datapositiongridId).jqGrid('setGridParam',{postData: {}}).trigger("reloadGrid");
	
};
/*清空查询条件*/
ConsolePosition.prototype.clearData =function(){
	clearFormData(this._formId);
	this.searchData();
};

//高级查询
ConsolePosition.prototype.searchData =function(){
	var _self = this;
	var param = {
			keyWord: null,
			param:JSON.stringify(serializeObject($(this._formId)))
		}
	$(this._datausergridId).jqGrid('setGridParam',{url: 'console/position/operation/togetSysUserByPostitionId/'+_self._positionId,postData: param}).trigger("reloadGrid");
};
ConsolePosition.prototype.loaduserByid = function(positionId){
	var _self = this;
	//var param = {param:JSON.stringify(positionId)}
	var param = {param:''}
	$(this._datausergridId).jqGrid('setGridParam',{url: 'console/position/operation/togetSysUserByPostitionId/'+positionId,postData: param}).trigger("reloadGrid");
};

ConsolePosition.prototype.importposition =function(){
	importorgIndex = layer.open({
	    type: 2,
	    area: ['70%', '70%'],
	    title: '导入岗位',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform/excelImportController/excelimportnew/importPosition/xls' 
	});   
};

/**
 * 导出用户(客户端数据)
 */
function exportClientData(){
	layer.confirm('确认要导出当前页数据吗?',{icon: 3, title:"提示", area: ['400px', '']},function(index) {
        if (index) {
            //封装参数
            
            $("#jqGridposition").jqGrid('endEditCell');
            var rows=$("#jqGridposition").jqGrid("getRowData"); 
          	var rownum =	$("#jqGridposition").jqGrid('getGridParam','colModel')
          	var dataGridFields = JSON.stringify(rownum);
            var datas = JSON.stringify(rows);
            var myParams = {
                dataGridFields: dataGridFields,//表头信息集合
                datas: datas,//数据集
                hasRowNum : true,//默认为Y:代表第一列为序号
                sheetName: 'sheet1',//如果该参数为空，默认为导出的Excel文件名
               unContainFields : 'STATUS_LABEL,EMAIL,id,cb',//不需要导出的列，使用','分隔即可
                fileName: '岗位导出数据',//导出的Excel文件名
            };
            var url = "platform/console/position/exportClient";
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
            var rows=$("#jqGridposition").jqGrid("getRowData"); 
          	var rownum =$("#jqGridposition").jqGrid('getGridParam','colModel')
          	var dataGridFields = JSON.stringify(rownum);
            var datas = JSON.stringify(rows);
            
            expSearchParams ={};
            
            expSearchParams.dataGridFields=dataGridFields;
            expSearchParams.hasRowNum=false;
            expSearchParams.sheetName='sheet1';
            expSearchParams.unContainFields='STATUS_LABEL,EMAIL,id,cb';
            expSearchParams.fileName='岗位导出数据';
           
            var url = "platform/console/position/exportServer";
            var ep = new exportData("xlsExport","xlsExport",expSearchParams,url);
            ep.excuteExport();
             layer.close(index);
        }
       });
}


