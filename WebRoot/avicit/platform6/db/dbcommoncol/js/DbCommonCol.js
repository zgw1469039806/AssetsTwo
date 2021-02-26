

/**
 * 单表
 * @param datagrid 
 * @param url 
 * @param searchD
 * @param form
 * @param keyWordId
 * @param searchNames
 * @param dataGridColModel
 */
function DbCommonCol(datagrid,url,searchD,form,keyWordId,searchNames,dataGridColModel){
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
	this.colClass='';
	this.colTypeList = {
		"all":"text:文本;date:日期;number:数字;textarea:多行;select:下拉框;radio:单选;check:多选;user:选用户;org:选组织;dept:选部门;position:选岗位;role:选角色;group:选群组;photo:图片上传",
		"VARCHAR2":"text:文本;textarea:多行;select:下拉框;radio:单选;check:多选;user:选用户;org:选组织;dept:选部门;position:选岗位;role:选角色;group:选群组",
		"BLOB":"photo:图片上传",
		"CLOB":"user:选用户;org:选组织;dept:选部门;position:选岗位;role:选角色;group:选群组",
		"DATE":"date:日期",
		"NUMBER":"number:数字",
	};

	this.init.call(this);
};
/**
 * 初始化操作
 */
DbCommonCol.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: _self.getUrl()+'getDbCommonColsByPage.json',
        mtype: 'POST',
        datatype: "local",
        toolbar: [true,'top'],
        colModel: _self.dataGridColModel,
        height:$(window).height()-120,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        userDataOnFooter: true,
        pagerpos:'left',
        hasColSet:false,//设置显隐属性
        loadComplete:function(){
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
        styleUI : 'Bootstrap',
		viewrecords: true, 
		multiselect: true,
		autowidth: true,
		shrinkToFit: true,
		responsive:true,//开启自适应
        pager: "#jqGridPager"
    });
    $(_self._jqgridToolbar).append($("#tableToolbar"));
    
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
 * 添加页面
 */
DbCommonCol.prototype.insert=function(){
	this.insertIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '添加',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Add/null' 
	});
};
/**
 * 编辑页面
 */
DbCommonCol.prototype.modify=function(){
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
	    area: ['100%', '100%'],
	    title: '编辑',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Edit/'+rowData.id 
	});
};
/**
 * 详情页面
 */
DbCommonCol.prototype.detail=function(id){
	this.detailIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '详细页',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Detail/'+id
	}); 
};
/**
 * 打开高级查询框
 */
DbCommonCol.prototype.openSearchForm = function(searchDiv){
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
		area: [contentWidth + 'px', '230px'],
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
			layer.close(index);//查询框关闭
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
 * 控件校验规则：表单字段name与rules对象保持一致
 */
DbCommonCol.prototype.formValidate=function(form){
	form.validate({
		rules: {
			colName:{
				english : true,
				required: true
			},
			colType:{
				required: true
			},
			colLength:{
			},
			colDecimal:{
			},
			orderBy:{
				number:true
			},
			colDomType:{
				required: true
			},
			colClass:{
				required: true
			},
			colComments:{
			}
		}
	});
}
/**
 * 保存方法
 */
DbCommonCol.prototype.save=function(form,id){
	var _self = this;
	avicAjax.ajax({
		 url:_self.getUrl()+"save",
		 data : {data :JSON.stringify(serializeObject(form))},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad(dbColClassTree.selectedNodeId);
				 if(id == "insert"){
					 layer.close(_self.insertIndex);
				 }else{
					 layer.close(_self.editIndex);
				 }
				 layer.msg('保存成功！');
			 }else{
				 layer.alert('保存失败,请联系管理员!', {
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
/**
 * 删除方法
 */
DbCommonCol.prototype.del=function(){
	var _self = this;
	var rows = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
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
							 _self.reLoad(dbColClassTree.selectedNodeId);
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
			  area: ['400px', ''], //宽高
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
DbCommonCol.prototype.reLoad=function(colClass){
	//var colClass;
	var formData = serializeObject($(this._formId));
	if(colClass != undefined && colClass != '1'){
		formData.colClass = colClass;
	}else{
		formData.colClass = null;
	}

	var searchdata = {param:JSON.stringify(formData)}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关闭对话框
 */
DbCommonCol.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else if(id == "edit"){
		layer.close(this.editIndex);
	}else{
		layer.close(this.detailIndex);
	}
};
/**
 * 后台查询	
 */
DbCommonCol.prototype.searchData =function(){
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

	var colClass = dbColClassTree.selectedNodeId;
	var params = serializeObject($(this._formId));
	if(colClass != null && colClass != "" && colClass != undefined && colClass != "1"){
		params.colClass = colClass;
	}else{
		params.colClass = null;
	}
	var searchdata = {
			keyWord: null,
			param:JSON.stringify(params)
		}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};
/**
 * 快速查询
 */
DbCommonCol.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val()==$(this._keyWordId).attr("placeholder") ? "" :  $(this._keyWordId).val();
	/*var names = this._searchNames;

	var param = {};
	for(var i in names){
		var name = names[i];
		param[name] = keyWord;
	}*/
	var searchdata = {
			keyWord: keyWord
			//param: null
		}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
}
/**
 * 隐藏查询框
 */
DbCommonCol.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/**
 * 清空查询条件
 */
DbCommonCol.prototype.clearData =function(){
	clearFormData(this._formId);
	this.searchData();
};

DbCommonCol.prototype.initDomSelect = function(colType){
	$("#colDomType option").remove();
	var colDomStr = dbCommonCol.colTypeList[colType];
	var colDomList = colDomStr.split(";");
	for(var i = 0; i< colDomList.length; i++){
		var colDom = colDomList[i].split(":");
		$("#colDomType").append("<option value='"+colDom[0]+"'>"+colDom[1]+"</option>");
	}
}

function DbColClassTree(treeUL) {
	this.treeUL = treeUL;//tree位置
	this.tree = null;//tree对象
	this.selectedNodeId = null;//tree点击选中的节点
	this.init.call(this);

}
//初始化操作
DbColClassTree.prototype.init = function () {
	var _this = this;

	var setting = {
		async: {
			enable: true,
			url: "platform/db/dbCommonColController/getDbColClassTree",//异步请求树子节点url
			autoParam: ["id"]//父节点id
		},
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdkey: "pId"
			}
		},
		view:{
			selectedMulti: false//进制按住ctrl多选
		},
		callback: {
			//节点点击事件
			onClick: function (event, treeId, treeNode) {
				//moduleType = "1";
				_this.selectedNodeId = treeNode.id;
				//$("." + diggerComponent.componentArea).css("display", "");
				//$("." + diggerFormInfo.formArea).css("display", "none");

				//diggerComponent.selectedEformComponentId = null;
				//获取该分类下的模块列表
				dbCommonCol.reLoad(_this.selectedNodeId);
			}
		}
	};

	//手动请求根节点数据
	$.ajax({
		url: "platform/db/dbCommonColController/getDbColClassTree",
		data: "id=-1",
		type: "post",
		async: false,
		dataType: "json",
		success: function (backData) {
			var zNodes = backData;
			_this.tree = $.fn.zTree.init($("#" + _this.treeUL), setting, zNodes);

			_this.clickFirstSubNodeOfFirstRootNode();
		}
	});
};
//模拟点击第一个根节点的第一个子节点
DbColClassTree.prototype.clickFirstSubNodeOfFirstRootNode = function () {
	var _this = this;
	moduleType = "1";
	var firstRootNode = _this.tree.getNodeByParam("pId", null, null);
	var firstSubNodeOfFirstRootNode = _this.tree.getNodeByParam("pId", firstRootNode.id, null);
	if (firstSubNodeOfFirstRootNode) {
		var spanId = firstSubNodeOfFirstRootNode.tId + "_span";
		$("#" + spanId).click();
	}else{
		var spanId = firstRootNode.tId + "_span";
		$("#" + spanId).click();
	}
};

/**
 * 验证是否特殊字符
 * @returns {boolean}
 */
function verifyIsSpecial(value) {
	var regEn = /[`~!@#$%^&*()+<>?:{},.\/;'[\]]/im,
		regCn = /[·！#￥（——）：；“”‘、，|《。》？、【】[\]]/im,regblank = /^\S*$/;;
	if(regEn.test(value) || regCn.test(value) ||!regblank.test(value)) {
		return true;
	}
	else {
		return false;
	}
}

/**
 * 验证是否是中文
 * @returns {boolean}
 */
function verifyIsChinese(value) {
	var reg = /[\u4E00-\u9FA5]|[\uFE30-\uFFA0]/gi;
	if(reg.test(value)) {
		return true;
	}
	else {
		return false;
	}
}

/**
 * 验证是否数字开头
 * @returns {boolean}
 */
function verifyIsNumStart(value) {
	var reg = /^\d+/;
	if(reg.test(value)) {
		return true;
	}
	else {
		return false;
	}
}