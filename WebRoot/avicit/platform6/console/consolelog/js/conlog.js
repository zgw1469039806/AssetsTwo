function ConsoleLog(datagrid,url,searchD,form,keyWordId,searchNames,dataGridColModel,appId){
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
	this.appId=appId;
	this.init.call(this);
};
//初始化操作
ConsoleLog.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: this.getUrl()+'getSysLogDataByPage/1/-1.json',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        height:this._doc.documentElement.clientHeight-113,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, 
		autowidth: true,
		responsive:true,//开启自适应
        pager: "#jqGridPager"
    });
    
    $('#set_jqGridPager').remove();
    $('#exportExcel_jqGridPager').remove();
	
    $(this._jqgridToolbar).append($("#tableToolbar"));
  
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
    $('#searchPart').on('click',function(e){
            _self.searchByKeyWord();
    });
};
ConsoleLog.prototype.loadByConditions=function(appId,tableId){
	
	$(this._datagridId).jqGrid('setGridParam',{url:this.getUrl()+'getSysLogDataByPage/'+appId+'/'+tableId+'.json',}).trigger("reloadGrid");
};
//打开高级查询框
ConsoleLog.prototype.openSearchForm = function(searchDiv){
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
		area: [contentWidth + 'px', '320px'],
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

//重载数据
/*ConsoleLog.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this._formId)))}
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");

};*/

//高级查询
ConsoleLog.prototype.searchData =function(){
	this.searchdata=serializeObject($(this._formId));
	var searchdata = {
			param:JSON.stringify(this.searchdata)
		}
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
};
//关键字段查询
ConsoleLog.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val();
	if(keyWord==='请输入操作人或者模块名称'){
		keyWord="";
	}
	var names = this._searchNames;

	var param = {};
	for(var i in names){
		var name = names[i];
		param[name] = keyWord;
	}
	param.type='_%%_';
	var searchdata = {
			param: JSON.stringify(param),
		}
	this.searchdata=param;
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
}

//隐藏查询框
ConsoleLog.prototype.getSearchDate =function(){
	return this.searchdata;
};
//隐藏查询框
ConsoleLog.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
ConsoleLog.prototype.clearData =function(){
	clearFormData(this._formId);
	this.searchData();
};
Date.prototype.format = function (format) {
     var o = {
         "M+": this.getMonth() + 1, //month 
         "d+": this.getDate(),    //day 
         "h+": this.getHours(),   //hour 
         "m+": this.getMinutes(), //minute 
         "s+": this.getSeconds(), //second 
         "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter 
         "S": this.getMilliseconds() //millisecond 
     };
     if (/(y+)/.test(format)) format = format.replace(RegExp.$1,
     (this.getFullYear() + "").substr(4 - RegExp.$1.length));
     for (var k in o) if (new RegExp("(" + k + ")").test(format))
         format = format.replace(RegExp.$1,
       RegExp.$1.length == 1 ? o[k] :
         ("00" + o[k]).substr(("" + o[k]).length));
     return format;
 };
 //对Date的扩展，将 Date 转化为指定格式的String 
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function(fmt) 
{ //author: meizz 
	  var o = {
		"M+" : this.getMonth() + 1, //月份 
		"d+" : this.getDate(), //日 
		"h+" : this.getHours(), //小时 
		"m+" : this.getMinutes(), //分 
		"s+" : this.getSeconds(), //秒 
		"q+" : Math.floor((this.getMonth() + 3) / 3), //季度 
		"S" : this.getMilliseconds()
	//毫秒 
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt; 
};
