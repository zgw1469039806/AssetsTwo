/**
 * 主子表
 * @param Jqgrid 
 * @param url 
 * @param searchForm
 * @param dataGridColModel
 * @param searchDialog
 * @param afterInit
 * @param clickRowLoad
 * @param searchMainNames
 * @param demoMainDept_KeyWord
 */
function SysDataPermissionsMethod(datagrid, url, searchForm, dataGridColModel, searchDialog, afterInit, clickRowLoad,searchMainNames,demoMainDept_KeyWord,selectTreeId){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
	this._datagridId = "#"+datagrid;
	this.Toolbardiv = "#t_"+datagrid;
	this.Toolbar = "#toolbar_"+datagrid;
	this._searchDialogId ="#"+searchDialog;
	this.Pagerlbar = "#" +datagrid + "Pager";
	this.searchForm = "#" + searchForm;
	this._keyWordId="#"+demoMainDept_KeyWord;
	this._searchNames = searchMainNames;
	this.dataGridColModel = dataGridColModel;
	this.afterInit = afterInit;
	this.clickRowLoad = clickRowLoad;
	this.selectTreeId = selectTreeId;
	this.init.call(this);
};
/**
 * 初始化操作
 * 回车查询
 */
SysDataPermissionsMethod.prototype.init=function(){
	var _self = this;
	var issubinit = false;
	$(_self._datagridId).jqGrid({
    	url: _self.getUrl()+'getSysDataPermissionsMethodsByPage.json',
		postData: {selectTreeId:_self.selectTreeId},
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],
        colModel: _self.dataGridColModel,
        height : $('#north1').height() - $("#toolbar_sysDataPermissionsMethod").innerHeight()-70,
        scrollOffset: 10,
        rowNum: 10	,
        rowList:[30,20,10],
        altRows:true,
        multiselect:true, 
        userDataOnFooter: true,
        pagerpos:'left',
        hasColSet:false,//设置显隐属性
        styleUI : 'Bootstrap', 
		viewrecords: true,
		multiboxonly:true,
		autowidth: true,
		shrinkToFit : true,
		responsive:true,
		pager: _self.Pagerlbar,
        onSelectAll: function(){
			_self.clickRowLoad("");
		},
        onSelectRow : function(rowid, status) {
			var rows = $(_self._datagridId).jqGrid('getGridParam', 'selarrrow');
			if (issubinit &&  rows.length == 1) {
				_self.clickRowLoad(rows[0]);
			}else{
				if(issubinit){
					_self.clickRowLoad("");
				}
			}
		},
        loadComplete:function(){
        	var rowdata = $(_self._datagridId).jqGrid('getRowData');
        	if(issubinit == false){
		        if(rowdata != null && rowdata.length > 0){
		            $(_self._datagridId).setSelection(rowdata[0].id);
		            _self.afterInit(rowdata[0].id);
		            issubinit = true;
	        	}else{
	        		_self.afterInit("-1");
	        		issubinit = true;
	        	}
	        }else{
	        	if(rowdata != null && rowdata.length > 0){
		            $(_self._datagridId).setSelection(rowdata[0].id);
		            _self.clickRowLoad(rowdata[0].id);

	        	}else{
	        		_self.clickRowLoad("-1");
	        	}
        	}
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
/**
 * 详情页面
 */
SysDataPermissionsMethod.prototype.detail=function(id){
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
 * 重载数据
 */
SysDataPermissionsMethod.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this.searchForm)))}
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关闭对话框
 */
SysDataPermissionsMethod.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.editIndex);
	}
};
SysDataPermissionsMethod.prototype.closeCopyDialog=function(){
	layer.close(copyPageIndex);
};
/**
 * 打开高级查询框	
 */
SysDataPermissionsMethod.prototype.openSearchForm = function(searchDiv,par){
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
		area: [contentWidth + 'px', '200px'],
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
SysDataPermissionsMethod.prototype.searchData =function(){
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
			param:JSON.stringify(serializeObject($(this.searchForm)))
		}
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关键字段查询
 */
SysDataPermissionsMethod.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val()==$(this._keyWordId).attr("placeholder") ? "" :  $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for(var i in names){
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
			keyWord: JSON.stringify(param),
			param: null
		}
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
}
/**
 * 隐藏查询框
 */
SysDataPermissionsMethod.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/**
 * 清空查询条件
 */
SysDataPermissionsMethod.prototype.clearData =function(){
	clearFormData(this.searchForm);
	this.searchData();
};
/**
 * 返回主表id
 */
SysDataPermissionsMethod.prototype.getSelectID=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var l =rows.length;
	if(l == 0){
		this._selectId = "null";
	}else if(l > 1){
		this._selectId = "undefined";
	}else{
	    this._selectId = rows[0].id;
	}
	return this._selectId;
};

SysDataPermissionsMethod.prototype.reloadDataByMenuId=function(menuId){
	var param = {
		menuId : menuId
	};
	var searchdata = {
		selectTreeId : menuId
	}
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
