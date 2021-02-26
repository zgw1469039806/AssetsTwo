function ListObj(datagrid,url,searchD,type,keyWordId,searchNames,dataGridColModel,appid){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url,_self=this;
    this.getUrl = function(){
    	return _url;
    }
	this._datagridId="#"+datagrid;
	this._jqgridToolbar="#t_"+datagrid;
	this._doc = document;
	this.appId=appid;
	this._type=type;
	this._searchDialogId ="#"+searchD;
	this._keyWordId="#"+keyWordId;
	this._searchNames = searchNames;
	this.dataGridColModel = dataGridColModel;
	var _onClick=function(){};//单击事件
	this.getOnClick=function(){
		return _onClick;
	};
	this.setOnClick=function(func){
		_onClick=func;
		return _self;
	};
	this._selectId='-11';

	var isNull=true;

	this.getNull=function(){
	    return isNull;
    };

	this.setNull=function(f){
	    isNull=f;

    };


	this.init.call(this);


};
//初始化操作
ListObj.prototype.init=function(){
	var _self = this;
	var pageId="#jqGridPager"+this._type;
	$(_self._datagridId).jqGrid({
    	url:_self.getUrl()+'/list',
        mtype: 'get',
        postData:{appId:_self.appId},
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        height:this._doc.documentElement.clientHeight-143,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 15	,
        rowList:[200,100,50,30,15],
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, //
		autowidth: true,
        hasTabExport:false,
        hasColSet:false,
		//responsive:true,//开启自适应
        pager: pageId,
        onSelectRow:function(rowid){
        	if(_self._selectId ===rowid){
        		return ;
        	}
        	_self._selectId=rowid;
            _self.setNull(false);
        	_self.getOnClick()(rowid,_self._type);
        }
    
    });
    $(pageId+"_left").css("width",4);
	
    $(this._jqgridToolbar).append($("#tableToolbar"+this._type));
    
   
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
	$(_self._keyWordId+'L').on('click',function(e){
		_self.searchByKeyWord();
	});
};
//关键字段查询
ListObj.prototype.searchByKeyWord =function(){
    this.setNull(true);
	var keyWord = $(this._keyWordId).val();
	var names = this._searchNames;

	if(keyWord==="角色名称"){
	    keyWord="";
    }

	var param = {};
	for(var i in names){
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
			keyWord: JSON.stringify(param),
			param: null
		}
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
};
ListObj.prototype.loadByAppId=function(appId){
	var searchdata={
		key:'zhang'
	};
	$(this._datagridId).jqGrid('setGridParam',{url:this.getUrl()+'/list'}).trigger("reloadGrid");
};
