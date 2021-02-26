String.prototype.replaceAll = function(FindText, RepText) {
	regExp = new RegExp(FindText, "g");
	return this.replace(regExp, RepText);
}

function H5KadsView(option) {
	this.id = option.id;
	this.selectModel = option.selectModel;
	this.template = option.template;
	this.beferRemove = option.beferRemove;
	this.afertRemove = option.afertRemove;

	this.remove = function(kardsid) {
		if (this.beferRemove) {
			this.beferRemove(kardsid);
		}
		$("#kads_" + kardsid).remove();
		if (this.afertRemove) {
			this.afertRemove();
		}
	};

	this.removeAll = function() {
		if (this.beferRemove) {
			this.beferRemove("all");
		}
		$(this.id).empty();
		if (this.afertRemove) {
			this.afertRemove();
		}
	};
	this.removeAllNOEvent = function() {
		$(this.id).empty();
	};

	this.getDataList = function() {
		var ret = [];
		$(".userviewkads").each(function() {
			var data = $.parseJSON($(this).attr("data"));
			
			ret.push(data);
		});

		return ret;
	}
	this.getextendDataList = function() {
		var ret = [];
		$(".userviewkads").each(function() {
			var data =$(this).attr("extendData");
			ret.push(data);
		});

		return ret;
	}
	this.add = function(kadsid, preamArray,extendJson, o) {
		if ($("#kads_" + kadsid).length > 0) {
			if (o == null || o) {
				layer.msg("已添加！");
			}
			return false;
		}
		if (this.selectModel != 'multi' && $(".userviewkads").length > 0) {
			if (o == null || o) {
				layer.msg("单选只允许选择一条数据！");
			}
			return false;
		}

		var temp = this.template().concat();
		for ( var i = 0; i < preamArray.length; i++) {
			temp = temp.replaceAll("#" + i + "#", preamArray[i]);
		}
		
		temp = temp.replaceAll("&", JSON.stringify(extendJson));
		
		$(this.id).append(temp);
	};

	return this;
};

function H5CommonPopupSelect(option) {
	// 用户参数
	this.type = option.type;
	this.idFiled = option.idFiled;
	this.textFiled = option.textFiled;
	this.divid = option.divid;
	this.rule = option.rule;
	this.callBack = option.callBack;
	this.contentWidth = option.contentWidth;
	this.contentHeight = option.contentHeight;
	this.placeStyle = option.placeStyle;
	if (option.selectModel == null) {
		this.selectModel = "single";
	} else if (option.selectModel == "single") {
		this.selectModel = "single";
	} else {
		this.selectModel = "multi";
	}
	if (this.type == "deptSelect") {
		this.deptSelectUrl = "avicit/platform6/h5component/common/deptPopupselect.jsp";
	}
	this.init.call(this);
	return this;
};
H5CommonPopupSelect.prototype.init = function() {
	var _self = this;
	var contentWidth = _self.contentWidth;
	var top =  $("#"+_self.divid).offset().top + $("#"+_self.divid).outerHeight(true);
	var left;
	if(_self.placeStyle == "left"){
		left = $("#"+_self.divid).offset().left;
	}else if(_self.placeStyle == "right"){
		left = $("#"+_self.divid).offset().left + $("#"+_self.divid).outerWidth() - contentWidth;
	}else{
		left = $("#"+_self.divid).offset().left;
	}
	
	//var width = $("#"+_self.divid).innerWidth();
	layer.config({
		  extend: 'skin/layer-bootstrap.css'
	});
	if(_self.selectModel == "single"){
		lay_select_icon = layer.open({
			type: 2,
			shift: 5,
			title: false,
			scrollbar: false,
			move : false,
			area: [_self.contentWidth + 'px', _self.contentHeight+'px'],
			offset: [top + 'px', left + 'px'],
			closeBtn: 0,
			shade: 0.1,
			shadeClose:true,
			content: _self.deptSelectUrl,
			success : function(layero, index) {
				var iframeWin = layero.find('iframe')[0].contentWindow;
				iframeWin.init({
					selectModel : _self.selectModel,
					deptids : $("#" + _self.idFiled).val()
				});
			}
			
		});
	}else{
		lay_select_icon = layer.open({
			type: 2,
			shift: 5,
			title: false,
			scrollbar: false,
			move : false,
			area: [_self.contentWidth + 'px',  _self.contentHeight+'px'],
			offset: [top + 'px', left + 'px'],
			closeBtn: 0,
			shade: 0.1,
			shadeClose:true,
			btn: ['确认'],
			content: _self.deptSelectUrl,
			success : function(layero, index) {
				var iframeWin = layero.find('iframe')[0].contentWindow;
				iframeWin.init({
					selectModel : _self.selectModel,
					deptids : $("#" + _self.idFiled).val()
				});
			},yes: function(index, layero){
				var iframeWin = layero.find('iframe')[0].contentWindow;
				var id = $(iframeWin.$("#selectDeptTree"))[0].id;
				var nodes = iframeWin.$.fn.zTree.getZTreeObj(id).getCheckedNodes();
				//iframeWin.$.fn.zTree.getZTreeObj(id).expandAll(true);
				var list = [];
				for(var i = 0;i < nodes.length; i++ ){
					if(nodes[i].nodeType == "dept" ){
						list.push({deptid:nodes[i].id,deptname:nodes[i].text});
					}
				}
				var data = getDeptObject(list);
				if(_self.callBack!=null && _self.callBack!='undefined'){
					if(typeof(_self.callBack) === 'function'){
			 			_self.callBack(data);
			 		}
				}
				$("#"+_self.idFiled).val(data.id);
				$("#"+_self.textFiled).val(data.text);
				layer.close(index);
			},
			
		});
	}
	setSelectedInfo = function(data){
		if(_self.callBack!=null && _self.callBack!='undefined'){
			if(typeof(_self.callBack) === 'function'){
	 			_self.callBack(data);
	 		}
		}
		$("#"+_self.idFiled).val(data.id);
		$("#"+_self.textFiled).val(data.text);
		layer.close(lay_select_icon);
	}
	getDeptObject = function (deptlist){
		var deptids = "";
		var deptnames = "";
		for(var i = 0;  i< deptlist.length; i ++ ){
			deptids = deptids + deptlist[i].deptid + ";";
			deptnames = deptnames + deptlist[i].deptname + ";";
		}
		deptids = deptids.substring(0, deptids.length-1);
		deptnames = deptnames.substring(0, deptnames.length-1);
		return {id: deptids, text: deptnames };
	}
	
}
