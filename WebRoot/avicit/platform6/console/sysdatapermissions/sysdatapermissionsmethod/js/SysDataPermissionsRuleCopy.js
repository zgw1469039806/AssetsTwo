var tempFlag=false;

function SysDataPermissionsRule(datagrid, url, formSub, dataGridColModel,searchDialogSub, pid, searchSubNames, demoSubUser_KeyWord){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
	this._searchDialogId ="#" + searchDialogSub;
	this.searchForm = "#" + formSub;
    this.pid = pid;
	this._datagridId = "#"+ datagrid;
	this.Toolbardiv = "#t_"+ datagrid;
	this.Toolbar = "#toolbar_"+ datagrid;
	this.Pagerlbar = "#" + datagrid + "Pager";
	this._keyWordId="#" + demoSubUser_KeyWord;
	this._searchNames = searchSubNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
/**
 * 初始化操作
 * 回车查询
 */
SysDataPermissionsRule.prototype.init=function(pid){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: _self.getUrl()+'getSysDataPermissionsRule',
    	postData : {pid : _self.pid},
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],
        colModel: _self.dataGridColModel, 
        height : $('#north2').height() - $("#toolbar_sysDataPermissionsRule").innerHeight()-36-40,
        scrollOffset: 10, //设置垂直滚动条宽度
        rowNum: 10	,
        rowList:[30,20,10],
        altRows:true,
        pagerpos:'left',
        hasColSet:false,//设置显隐属性
		loadComplete:function(){
		},
        styleUI : 'Bootstrap', 
		viewrecords: true, //
		multiselect: true,
		autowidth: true,
		shrinkToFit: true,
		responsive:true,//开启自适应
        pager: _self.Pagerlbar,
        gridComplete :function(){
        }
    });
	
    $(_self.Toolbardiv).append($(_self.Toolbar)); 
    
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
	//禁止时间和日期格式手输
	$('.date-picker').on('keydown',nullInput);
	$('.time-picker').on('keydown',nullInput);
	//回车查询
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
};
function updateState(rowId,stateVal){
	avicAjax.ajax({
		url:"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/updateState",
		data : {id:rowId,state:stateVal},
		type : 'get',
		dataType : 'json',
		async : false,
		success : function(r){
			if (r.flag == "success"){
				layer.msg('设置成功！');
			}
		}
	});
}

/**
 * 添加页面
 */
SysDataPermissionsRule.prototype.insert=function(pobj){
	if(pobj == "null" || pobj == "undefined"){
	   layer.alert('请选择一条主表数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
	              title:"提示"
				}
		);
		 return false;
	}else{
		this.insertIndex = layer.open({
		    type: 2,
		    title: '添加',
		    skin: 'bs-modal',
		    area: ['90%', '90%'],
	        maxmin: false,
		    content: this.getUrl()+'Add/null?pid='+pobj.id
		});    
	}
};
/**
 * 编辑页面
 */
SysDataPermissionsRule.prototype.modify=function(pobj){
	if(this.pid == null || this.pid == ""){
		 layer.alert('请选择一条要编辑的主表数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
	              title:"提示"
				}
		);
		 return false;
	}
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择要编辑的数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
	              title:"提示"
				}
		);
		return false;
	}else if(ids.length > 1){
		layer.alert('只允许选择一条数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
	              title:"提示"
				}
		);
		return false;
	}

	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.editIndex = layer.open({
	    type: 2,
	    title: '编辑',
	    skin: 'bs-modal',
	    area: ['90%', '90%'],
        maxmin: false,
	    content: this.getUrl()+'Edit/'+rowData.id+'?pid='+pobj.id
	});
};
/**
 * 详情页面
 */
SysDataPermissionsRule.prototype.detail=function(id){
	this.detailIndex = layer.open({
	    type: 2,
	    area: ['90%', '90%'],
	    title: '详细页',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Detail/'+id
	});
};
/**
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
SysDataPermissionsRule.prototype.formValidate=function(form){
	form.validate({
		rules : {
			ruleName : {
				maxlength : 50,
				required: true
			},
			status : {
				maxlength : 1
			},
			ruleRemarks : {
				maxlength : 300,
				required: true
			},
			matchSymbol : {
				maxlength : 3
			},
			orderBy : {
				number : true,
				required: true
			},
			columnName : {
				maxlength : 20
			},
			columnSymbol : {
				maxlength : 5
			},
			columnType : {
				maxlength : 20
			},
			columnValue : {
				maxlength : 20
			},
			filterCondition : {
				maxlength : 300,
				required: true
			},
			filterConditionSql : {
				maxlength : 4000,
				required: true
			},
			methodId : {
				maxlength : 50
			},
		}
	});
}
/**
 * 保存方法
 */
SysDataPermissionsRule.prototype.save=function(form,id){
	var _self = this;
	avicAjax.ajax({
		 url:_self.getUrl()+"save",
		 data : {data :JSON.stringify(serializeObject(form))},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 if(id == "insert"){
					 layer.close(_self.insertIndex);
				 }else{
					 layer.close(_self.editIndex);
				 }
				 layer.msg('保存成功！');
			 }else{
				 layer.alert('保存失败,请联系管理员!', {
						  icon: 7,
						  area: ['400px', ''], // 宽高
						  closeBtn: 0,
						  btn: ['关闭'],
			              title:"提示"
						}
				 );
			 } 
		 }
	 });
};
/**
 * 删除方法
 */
SysDataPermissionsRule.prototype.del=function(){
	var _self = this;
	var rows = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('删除规则会同时删除已配置的权限规则，且公式会重新生成。是否继续？',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
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
						layer.alert('删除失败,请联系管理员!', {
									  icon: 7,
									  area: ['400px', ''],
									  closeBtn: 0,
									  btn: ['关闭'],
						              title:"提示"
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
				  area: ['400px', ''],
				  closeBtn: 0,
				  btn: ['关闭'],
	              title:"提示"
				}
		);
	}
};
/**
 * 重载数据
 */
SysDataPermissionsRule.prototype.reLoad=function(pid){
	if(pid != undefined){
		this.pid = pid;
	}
	var searchdata = {pid:pid};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关闭对话框
 */
SysDataPermissionsRule.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.editIndex);
	}
};
/**
 * 打开高级查询框	
 */
SysDataPermissionsRule.prototype.openSearchForm = function(searchDiv,par){
	var _self = this;
	par = null;
	var contentWidth = 600; 
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
		area: [contentWidth + 'px', '150px'],
		offset: [top + 'px', left + 'px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['查询', '清空', '取消'],
		content: $(_self._searchDialogId),
		success : function(layero, index) {
			var serachLabel = $('<div class="serachLabel"><span>'+ text +'</span><span class="caret"></span></div>').appendTo(layero);
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
/**
 * 去后台查询
 */
SysDataPermissionsRule.prototype.searchData =function(){
	var datebox = $('.date-picker,.time-picker');
	var data = [];
	$.each(datebox,function(i,item){
		 data[i] = $(item).val();
	});
	for (var i=0;i<(data.length/2);i++) {
		if(data[2*i] == "" || data[2*i+1] == "" || data[2*i] == null || data[2*i+1] == null){
			continue;
		}
		if(data[2*i]>data[2*i+1]){
			layer.alert("查询时,结束日期不能小于起始日期 ！", {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0,
				btn : [ '关闭' ],
				title : "提示"
			});
			return;
		}
	}
	var searchdata = {
		keyWord: null,
		pid:this.pid,
		param:JSON.stringify(serializeObject($(this.searchForm)))
	};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关键字段查询
 */
SysDataPermissionsRule.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val()==$(this._keyWordId).attr("placeholder") ? "" :  $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for(var i in names){
		var name = names[i];
		param[name] = keyWord;
	}

	var searchdata = {
		keyWord: JSON.stringify(param),
		pid:this.pid,
		param: null
	};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
}
/**
 * 隐藏查询框
 */
SysDataPermissionsRule.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/**
 * 清空查询条件
 */
SysDataPermissionsRule.prototype.clearData =function(){
	clearFormData(this.searchForm);
	this.searchData();
};
