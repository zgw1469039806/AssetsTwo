function BpmTaskGrid(id, url, title, index, showTotal) {
	this.url = url;
	this.title = title;
	this.index = index;
	this.showTotal = showTotal;
	this.id = id;
	this.idGrid = "#" + id + "Grid";
	this.keyInputId = "#" + id + "KeyInput";
	this.searchId = "#" + id + "SearchId";
	this.searchForm = "#" + id + "SearchForm";
	this.searchDialog = "#" + id + "Dialog";
	this.queryParams = null;
	this.grid = null;
};
BpmTaskGrid.prototype.init = function() {
	var _self = this;
	this.grid = $(this.idGrid).datagrid({
		url : this.url,
		queryParams : this.queryParams,
		onLoadSuccess : function(data) {
			if (_self.showTotal) {
				var newTitle = _self.title + "<span style='color:red'>(" + data.total + ")</span>";
				var tab = $("#tabs").tabs("getTab", _self.index);
				$('#tabs').tabs('update', {
					tab : tab,
					options : {
						title : newTitle
					}
				});
			}
		}
	});
	$(this.keyInputId).attr('placeholder', '请输入标题');
	$(this.keyInputId).parent().find("span").on('click', function() {
		_self.searchByKeyWord();
	});
	$(this.keyInputId).on('keyup', function(e) {
		if (e.keyCode == 13) {
			_self.searchByKeyWord();
		}
	});
	$(this.searchId).on('click', function() {
		_self.openSearchForm();
	});
	$("#" + this.id + "processStarterAlias").on('focus', function(e) {
		new EasyuiCommonSelect({
			type : 'userSelect',
			idFiled : _self.id + 'processStarter',
			textFiled : _self.id + 'processStarterAlias',
			viewScope : 'currentOrg'
		});
		this.blur();
	});
	$("#" + this.id + "processStartDeptAlias").on('focus', function(e) {
		new EasyuiCommonSelect({
			type : 'deptSelect',
			idFiled : _self.id + 'processStartDept',
			textFiled : _self.id + 'processStartDeptAlias',
			viewScope : 'currentOrg'
		});
		this.blur();
	});
};
BpmTaskGrid.prototype.setQueryParams = function(queryParams){
	this.queryParams = queryParams;
};
BpmTaskGrid.prototype.realod = function() {
	if (this.grid == null) {
		this.init();
	} else {
		this.grid.datagrid('load', this.queryParams).datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	}
};
BpmTaskGrid.prototype.searchByKeyWord = function() {
	var param = flowUtils.clone(this.queryParams);
	param.keyWord = JSON.stringify({
		taskTitle : $(this.keyInputId).val() == $(this.keyInputId).attr("placeholder") ? "" : $(this.keyInputId).val()
	});
	this.grid.datagrid('load', param).datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
};
BpmTaskGrid.prototype.searchByData = function() {
	var param = flowUtils.clone(this.queryParams);
	param.searchParam = JSON.stringify(serializeObject($(this.searchForm)));
	this.grid.datagrid('load', param).datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
};
BpmTaskGrid.prototype.clearData = function() {
	clearFormData(this.searchForm);
	this.searchByData();
};
BpmTaskGrid.prototype.openSearchForm = function() {
	var _self = this;
	var contentWidth = 800;
	var top = $(this.searchId).offset().top + $(this.searchId).outerHeight(true);
	var left = $(this.searchId).offset().left + $(this.searchId).outerWidth() - contentWidth;
	var text = $(this.searchId).text();
	var width = $(this.searchId).innerWidth();
	layer.open({
		type : 1,
		shift : 5,
		title : false,
		scrollbar : true,
		move : false,
		area : [ contentWidth + 'px', '400px' ],
		offset : [ top + 'px', left + 'px' ],
		closeBtn : 0,
		shadeClose : true,
		btn : [ '查询', '清空', '取消' ],
		content : $(_self.searchDialog),
		success : function(layero, index) {
			$(layero).css('height', '400px').css('overflow', 'auto');
		},
		yes : function(index, layero) {
			_self.searchByData();
			layer.close(index);// 查询框关闭
		},
		btn2 : function(index, layero) {
			_self.clearData();
			return false;
		},
		btn3 : function(index, layero) {
		}
	});
};