function FormFieldParameter (option) {
	this.id = option.id;
	this.dataDomId1 = option.dataDomId1;
	this.dataDomId2 = option.dataDomId2;
	this.mainProcessFormId = option.mainProcessFormId;
	this.subProcessKey = option.subProcessKey;
	this.callback = option.callback;
	this.option = option;
	this.process = option.process;
	this.hiddenVarParameter = option.hiddenVarParameter;
	// 将配置信息保存到dom对象里，方便在弹出页面调用
	$("#"+this.dataDomId1).data("data-object", this);
	var dataDomId1 = encodeURIComponent(this.dataDomId1);
	this.template = "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/FormFieldParameter/FormFieldParameter.jsp?dataDomId1="
		+dataDomId1+"&hiddenVarParameter="+this.hiddenVarParameter;
	this.subTableNameArr = new Array();
	this.subJqGrids = new Array();
	this.subTableLastrowArr = new Array();
	this.subTableLastcellArr = new Array();
	this.init();
}

FormFieldParameter.prototype.init = function() {
	var _self = this;
	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
		var box = layer.open({
		    type:  2,
		    area: [ "900px",  "650px"],
		    title: "流程传参",
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		    shade:   0.3,
	        maxmin: true, //开启最大化最小化按钮
		    content: _self.template ,
		    btn: ['确定', '关闭'],
		    yes: function(index, layero){
		    	var formInDataStr =  _self.getFormInData();
		    	$("#"+_self.dataDomId1).val(formInDataStr);
		    	if(_self.hiddenVarParameter!='1'){
		    		var formOutDataStr = _self.getFormOutData();
			    	$("#"+_self.dataDomId2).val(formOutDataStr);
		    	}
		    	layer.close(index);
			 },
			cancel: function(index){
				layer.close(index);
				$('html').addClass('fix-ie-font-face');
				setTimeout(function() {
					$('html').removeClass('fix-ie-font-face');
				}, 10);
		    },
		   success: function(layero, index){
		   }
		});
}

FormFieldParameter.prototype.getFormInData = function () {
	var _self = this;
	var dataArr = [];
	
	_self.jqGird1.saveCell(_self.grid1Lastrow,_self.grid1Lastcell);
	var objArr = _self.jqGird1.getRowData();
	if(objArr && objArr.length){
		for(i=0;i<objArr.length;i++){
			var data = objArr[i];
			if(data.toColName =='' || data.toColName == '请选择'){
				continue;
			}
			var dataObj = {};
			dataObj.formTable = _self.mainProcessTableName;
			dataObj.formCol = data.colName;
			dataObj.subFormTable = _self.subProcessTableName;
			dataObj.subFormCol = data.toColId;
			dataObj.colType = data.toColType;
			dataObj.tableModify = _self.subProcessTableModify;
			dataObj.colComments = data.toColName;
			dataObj.isOrgIdentity = _self.subProcessIsOrgIdentity;
			dataObj.fromComments = data.colComments;
			dataArr.push(dataObj);
			//console.log("fromCol="+data.colName+"--toCol="+toColId+"--toColType="+toColType+"--mainProcessTableName="+_self.mainProcessTableName+"--subProcessTableName="+_self.subProcessTableName);
		}
	}

	if(_self.hiddenVarParameter!='1'){
		_self.varParameterIn.setDataToParent(dataArr);
	}


	/**
	 * 子表
	 */
	var subTableDataMap = {};
	for(var j=0;j<_self.subTableNameArr.length;j++){
		var subTableDataArr = [];
		var subTableName = _self.subTableNameArr[j];
		var subJqGird = _self.subJqGrids[subTableName];
		var lastRow = _self.subTableLastrowArr[subTableName];
		var lastCell =_self.subTableLastcellArr[subTableName];
		subJqGird.saveCell(lastRow,lastCell);
		var objArr = subJqGird.getRowData();
		if(objArr && objArr.length){
			for(var i=0;i<objArr.length;i++){
				var data = objArr[i];
				if(data.toColName =='' || data.toColName == '请选择'){
					continue;
				}
				var dataObj = {};

				dataObj.formTable = data.formTable;
				dataObj.formCol = data.colName;
				dataObj.subFormTable = data.subFormTable;
				dataObj.subFormCol = data.toColId;
				dataObj.colType = data.toColType;
				dataObj.tableModify = data.tableModify;
				dataObj.colComments = data.toColName;
				dataObj.isOrgIdentity = data.isOrgIdentity;
				dataObj.fromComments = data.colComments;
				dataObj.isSubTable = "1";
				dataObj.fromFkColName = data.fkColName;
				dataObj.toFkColName = data.toFkColName;
				dataArr.push(dataObj);
				subTableDataArr.push(dataObj);
				//console.log("fromCol="+data.colName+"--toCol="+toColId+"--toColType="+toColType+"--mainProcessTableName="+_self.mainProcessTableName+"--subProcessTableName="+_self.subProcessTableName);
			}
			if(subTableDataArr.length>0){
				subTableDataMap[subTableName]=subTableDataArr;
			}
		}
	}
	if(_self.hiddenVarParameter!='1'){
		_self.varParameterIn.setSubTableDataToParent(subTableDataMap);
	}

	
	return JSON.stringify(dataArr);
}

FormFieldParameter.prototype.getFormOutData = function () {
	var _self = this;
	var dataArr = [];
	
	_self.jqGird2.saveCell(_self.grid2Lastrow,_self.grid2Lastcell);
	var objArr = _self.jqGird2.getRowData();
	if(objArr && objArr.length){
		for(i=0;i<objArr.length;i++){
			var data = objArr[i];
			if(data.toColName =='' || data.toColName == '请选择'){
				continue;
			}
			var dataObj = {};
			var toColName = data.toColName;
			var toColId = data.toColId;
			var toColType = data.toColType;
			dataObj.formTable = _self.mainProcessTableName;
			dataObj.formCol = data.toColId;
			dataObj.subFormTable = _self.subProcessTableName;
			dataObj.subFormCol = data.colName;
			dataObj.colType = data.toColType;
			dataObj.tableModify = _self.mainProcessTableModify;
			dataObj.colComments = data.toColName;
			dataObj.isOrgIdentity = _self.mainProcessIsOrgIdentity;
			dataObj.fromComments = data.colComments;
			dataArr.push(dataObj);
			//console.log("fromCol="+data.colName+"--toCol="+toColId+"--toColType="+toColType+"--mainProcessTableName="+_self.mainProcessTableName+"--subProcessTableName="+_self.subProcessTableName);
		}
	}
	if(_self.hiddenVarParameter!='1'){
		_self.varParameterOut.setDataToParent(dataArr);
	}
	return JSON.stringify(dataArr);
}

