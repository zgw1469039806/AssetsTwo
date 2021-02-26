function AppList(datagrid,type){
    if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
        throw new Error("datagrid不能为空！");
    }

    this._datagridId="#"+datagrid;
    this._jqgridToolbar="#t_"+datagrid;
    this._doc = document;
    this._type=type;

    var _onSelect=function(){};//单击node事件
    this.getOnSelect=function(){
        return _onSelect;
    };
    this.setOnSelect=function(func){
        _onSelect=func;
    };
    this.init.call(this);
};
//初始化操作
AppList.prototype.init=function(){
    var _self = this;
    $(_self._datagridId).jqGrid({
        url: 'platform/cc/sysapp/bs3/sysapptree/'+_self._type,
        mtype: 'get',
        datatype: "json",
        toolbar: [true,'top'],
        colModel: [
            { label: 'id', name: 'id', key: true,  hidden:true },
            { label: '应用名称', name: 'text', width: 80 ,align:'center'},
            { label:'url',name:'attributes.url',hidden:true}
        ],
        height:this._doc.documentElement.clientHeight-113,
        scrollOffset: 20, //设置垂直滚动条宽度
        altRows:true,
        pagerpos:'left',
        styleUI : 'Bootstrap',
        viewrecords: true, //
        autowidth: true,
        responsive:true,//开启自适应
        hasTabExport:false,
        hasColSet:false,
        onSelectRow:function(rowid){
            _self.getOnSelect()(rowid);
        },
        gridComplete :function(){
            $(this).closest('.ui-jqgrid-view').find('div.ui-jqgrid-hdiv').hide();

            var ids =  $(_self._datagridId).jqGrid('getDataIDs');
            if(ids.length==0){
               // _self.getOnSelect()('abc');
                return false;
            }
            for(var i=0;i<ids.length;i++){
                if(ids[0]=="1"){
                    $(_self._datagridId).jqGrid('setSelection',"1");
                    return true;
                }
            }
            $(_self._datagridId).jqGrid('setSelection',ids[0]);


        }
    });

    $(this._jqgridToolbar).append($("#tableToolbarM"));

    $("#appSearchInput").on('keydown',function(e){
        if(e.keyCode == '13'){
            _self.searchByKeyWord();
        }
    });
    $("#appSearch").on('click',function(){
            _self.searchByKeyWord();
    });
};

//关键字段查询
AppList.prototype.searchByKeyWord =function(){
    var keyWord = $('#appSearchInput').val();

    if(keyWord=='输入名称查询'){
        keyWord="";
    }

    var searchdata = {
        keyWord: keyWord
    };
    $(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
}

