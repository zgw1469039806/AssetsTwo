/**
 * 
 */
function MobileCommandInfo(datagrid, url, dataGridColModel, searchForm, searchDialog,pid,searchSubNames,afterInit,clickRowLoad,demoMainDept_KeyWord){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    };
	this._datagridId = "#"+datagrid;
	this.Toolbardiv = "#t_"+datagrid;
	this.Toolbar = "#toolbar_"+datagrid;
	this._searchDialogId ="#"+searchDialog;
	this.Pagerlbar = "#" +datagrid + "Pager";
	this.searchForm = "#" + searchForm;
	this._keyWordId="#"+demoMainDept_KeyWord;
	this._searchNames = searchSubNames;
	this.dataGridColModel = dataGridColModel;
	this.afterInit = afterInit;
	 this.pid = pid;
	 this.clickRowLoad = clickRowLoad;
	this.init.call(this);
	this.searchType = 'null';
};
//初始化操作
MobileCommandInfo.prototype.init=function(){
	var _self = this;
	var issubinit = false;
	$(_self._datagridId).jqGrid({
    	url: this.getUrl()+'getMobileCommandInfo',
        postData : {pid : _self.pid},
    	mtype: 'POST',
    	multiselect:true,
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        height:($(window).height()-78)/2 - 76,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
        scrollOffset: 1,
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        userDataOnFooter: true,
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true,
		multiboxonly:true,
        autowidth: true,
        shrinkToFit: true,
        responsive:true,//开启自适应
        hasColSet:false,
        hasTabExport:false,
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
        	$(this).jqGrid('getColumnByUserIdAndTableName');
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
	        		_self.clickRowLoad("");
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
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
};
//添加页面
MobileCommandInfo.prototype.insert=function(pid){
	if(this.pid == null || this.pid == "" || this.pid == -1){
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
	this.insertIndex = layer.open({
	    type: 2,
	    area: ['80%', '80%'],
	    title: '添加',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Add/null' 
	});
};
//编辑页面
MobileCommandInfo.prototype.modify=function(){
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
	this.eidtIndex = layer.open({
	    type: 2,
	    area: ['80%', '80%'],
	    title: '编辑',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Edit/'+rowData.id 
	});
};
//详细页
MobileCommandInfo.prototype.detail=function(id){
	this.detailIndex = layer.open({
	    type: 2,
	    area: ['80%', '80%'],
	    title: '详细页',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Detail/'+id
	}); 
};
//控件校验   规则：表单字段name与rules对象保持一致
MobileCommandInfo.prototype.formValidate=function(form){
	form.validate({
		rules : {
			serviceId : {
				required:true,
				maxlength : 200
			},
			methodUrl : {
				required:true,
				maxlength : 200
			},
			methodType : {
				required:true,
				maxlength : 200
			},
			methodName : {
				required:true,
				maxlength : 200
			},
			methodShowName : {
				required:true,
				maxlength : 200
			},
		}
	});
};
// 保存功能
MobileCommandInfo.prototype.save=function(form,id){
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
					 layer.close(_self.eidtIndex);
				 }
				 layer.msg('保存成功！');
			 }else{
				 layer.alert('保存失败！' + r.error,{
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0,
					  btn: ['关闭'],
			          title:"提示"
				    }
		         );
			 } 
		 }
	 });
};
//删除
MobileCommandInfo.prototype.del=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确认要删除选中的数据吗?',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
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
							 layer.alert('删除失败！'+ r.error, {
								  icon: 7,
								  area: ['400px', ''], //宽高
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
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  btn: ['关闭'],
			  title:"提示"
			}
		);
	}
};

//导入
MobileCommandInfo.prototype.imp=function(form){
    var _self = this;
    $('#'+form)
        .ajaxSubmit({
        async: false,
        url : _self.getUrl()+'import',
        data : {
            pid : _self.pid,
        },
        success : function(response) {
            response = $.parseJSON(response);

            if (response.flag == "success") {
                _self.reLoad();
				var impInfo = response.msg;
                var html = '<table style="width: 100%;">'+
                    '<tr style="height: 20px;background-color: #efefef">'+
                    '<th width="40%" style="border: 1px solid #ddd;padding: 8px;text-align: center;">名称</th>'+
                    '<th  width="10%" style="border: 1px solid #ddd;padding: 8px;text-align: center;">状态</th>'+
                    '<th width="50%" style="border: 1px solid #ddd;padding: 8px;text-align: center;">详情</th>'+
                    '</tr>';
                impInfo.forEach(function(item){
                    html +='<tr style="height: 20px;">'+
                        '<td width="40%" style="border: 1px solid #ddd;padding: 8px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;word-break: break-all;">'+item[1]+'</td>'+
                        '<td width="10%" style="border: 1px solid #ddd;padding: 8px;text-align: center;">'+item[0]+'</td>'+
                        '<td width="50%" style="border: 1px solid #ddd;padding: 8px;">'+item[2]+'</td>'+
                        '</tr>';
                });
                html +='</table>';

                layer.open({
                    type: 1,
                    area: ['40%', '80%'],
                    title: '导入结果',
                    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                    maxmin: false, //开启最大化最小化按钮
                    content: html,
                    scrollbar: false
                });

            }else{
                layer.alert('导入失败！'+ response.msg, {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0,
                        btn: ['关闭'],
                        title:"提示"
                    }
                );

            }
        }
    });
};

//导出
MobileCommandInfo.prototype.exp=function(){
    var _self = this;
    var rows = $(this._datagridId).getRowData();//所有的数据
	if(rows.length>0){
    var myParams = {
        pid: _self.pid,
    };
    if('data'==_self.searchType){
        myParams.param = JSON.stringify(serializeObject($(_self.searchForm)));
	}
	if('word'==_self.searchType){
        var keyWord = $(this._keyWordId).val()==$(this._keyWordId).attr("placeholder") ? "" :  $(this._keyWordId).val();
        var names = this._searchNames;

        var param = {};
        for(var i in names){
            var name = names[i];
            param[name] = keyWord;
        }
        myParams.keyWord = JSON.stringify(param);
	}
    var url = _self.getUrl()+'export';
    var ep = new exportData("commandExport","commandExport",myParams,url);
    ep.excuteExport();
    }else{
        layer.alert('无对应数据', {
            icon : 2,
            title : "错误",
            area : [ '400px', '' ]
        });
	}
};


//上传文件格式
function checkfiletype(id) {
    var fileName = document.getElementById(id).value;
    //设置文件类型数组
    var extArray = [ ".xml" ];
    //获取文件名称
    while (fileName.indexOf("//") != -1)
        fileName = fileName.slice(fileName.indexOf("//") + 1);
    //获取文件扩展名
    var ext = fileName.slice(fileName.lastIndexOf(".")).toLowerCase();
    //遍历文件类型
    var count = extArray.length;
    for (; count--;) {
        if (extArray[count] == ext) {
            return true;
        }
    }
    layer.alert('只能上传下列类型的文件: ' + extArray.join(" "), {
        icon : 2,
        title : "错误",
        area : [ '400px', '' ]
    });
    return false;
}
//重载数据
MobileCommandInfo.prototype.reLoad=function(pid){
	if(pid != undefined){
		this.pid = pid;
	}
	var searchdata = {pid:pid};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
//关闭对话框
MobileCommandInfo.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.eidtIndex);
	}
};
//打开高级查询框
MobileCommandInfo.prototype.openSearchForm = function(searchDiv,par){
	var _self = this;
	par = null;
	//if(!par) par = $(window);
	var contentWidth = 550; //(par.width()*.6 >= 600)?600:par.width()*.6;
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
		content: $(this._searchDialogId),
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
//高级查询
MobileCommandInfo.prototype.searchData =function(){
	var searchdata = {
			keyWord: null,
			param:JSON.stringify(serializeObject($(this.searchForm)))
		}
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
	this.searchType = 'data';
};
//关键字段查询
MobileCommandInfo.prototype.searchByKeyWord =function(){
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
    this.searchType = 'word';
}
//隐藏查询框
MobileCommandInfo.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
MobileCommandInfo.prototype.clearData =function(){
	clearFormData(this.searchForm);
	this.searchData();
	this.searchType = 'null';
};
