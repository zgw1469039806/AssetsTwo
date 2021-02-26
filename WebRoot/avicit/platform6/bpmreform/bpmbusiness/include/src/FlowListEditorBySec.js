/**
 * 模块列表操作类
 */
function FlowListEditorBySec(formCode, formData) {
	this.formCode = formCode;
	this.formData = formData;
};
FlowListEditorBySec.prototype.setFormCode = function(formCode){
	this.formCode = formCode;
};
FlowListEditorBySec.prototype.setFormData = function(formData){
	this.formData = formData;
};
FlowListEditorBySec.prototype.doStart = function(pdId){
	flowUtils.success(pdId+"，需要重写doStart方法，实现保存数据并启动流程的逻辑");
};
FlowListEditorBySec.prototype.start = function(){
	if (!flowUtils.notNull(this.formCode)) {
		flowUtils.warning("没有指定必要的参数：formCode！请联系管理员！");
		return;
	}
	var _self = this;
	avicAjax.ajax({
		type : "POST",
		data : {
			formCode : this.formCode,
			formData : this.formData
		},
		url : "platform/bpm/clientbpmdisplayaction/getprocessbyformcode",
		dataType : "json",
		success : function(obj) {
			if (obj != null && obj.length == 1) {
				_self.doStart(obj[0].dbid);
			} else if (obj != null && obj.length > 1) {
				_self.openDefDialog(obj);
			} else {
				flowUtils.warning("没有找到符合条件的流程模板！请联系管理员！");
			}
		}
	});
};
FlowListEditorBySec.prototype.openDefDialog = function(obj) {
	var _self = this;
	_bpm_listeditor_dialogBySec = layer.open({
		type : 1,
		title : "流程模板选择",
		area : [ "300px", "400px" ],
		content : "<table id='defTable'></table>",
		end : function() {
			_bpm_listeditor_dialogBySec = null;
		},
		success : function(layero, index) {
			$("#defTable").jqGrid({
				datastr : JSON.stringify(obj),
				datatype : "jsonstring",
				colModel : [ {
					name : 'dbid',
					key : true,
					hidden : true
				}, {
					label : '流程名称',
					name : 'name',
					align : 'center',
					formatter : _self.formatDefValue
				}, {
					label : '版本',
					name : 'version',
					align : 'center'
				} ],
				rownumbers : true,
				altRows : true,
				styleUI : 'Bootstrap',
                width : 290,
                height:320
			});
		}
	});
};
FlowListEditorBySec.prototype.formatDefValue = function(cellvalue, options, rowObject) {
	return "<a href='javascript:void(0);' onclick='_bpm_listeditor_startBySec(\"" + rowObject.dbid + "\");'>" + cellvalue + "</a>";
};
var _bpm_listeditor_dialogBySec = null;
function _bpm_listeditor_startBySec(defId) {
	if (_bpm_listeditor_dialogBySec != null) {
		layer.close(_bpm_listeditor_dialogBySec);
		_bpm_listeditor_dialogBySec = null;
	}
	new FlowListEditorBySec().doStart(defId);
}





var FORMCODE = "";
var US_GIALOG = "";
var __processList;
var StartProcessByFormCode = function(){
	this.formCode = "";
	this.formData = "";
	this.custom = false;//是否需要自定义流程，默认不需要
	this.appendIframe = false;//是否需要iframe遮罩
	var _self = this;
	StartProcessByFormCode.prototype.SetFormCode = function(_formCode){
		this.formCode = _formCode;
		FORMCODE = _formCode;
	};
	StartProcessByFormCode.prototype.SetFormData = function(_formData){
		this.formData = _formData;
	};
	/**
	 * 设置是否需要自定义流程，默认不需要，设置为“true”标识需要
	 */
	StartProcessByFormCode.prototype.SetCustom = function(_custom){
		this.custom = _custom;
	};
	/**
	 * 设置是否需要iframe遮罩，默认不需要，设置为“true”标识需要
	 */
	StartProcessByFormCode.prototype.SetAppendIframe = function(_appendIframe){
		this.appendIframe = _appendIframe;
	};
	this.start = function (){
		//var paras = "formCode="+this.formCode+"&formData="+this.formData;
		//ajaxRequest("POST",paras,"platform/bpm/clientbpmdisplayaction/getprocessbyformcode","json","this.startBack");
		var url = "platform/bpm/clientbpmdisplayaction/getprocessbyformcode";
		var contextPath = getPath2();
		var urltranslated = contextPath + "/" + url;
		jQuery.ajax({
	        type:"POST",
			data:"formCode="+this.formCode+"&formData="+this.formData+"&custom="+this.custom,
	        url: urltranslated,  
	        dataType:"json",
	        async:false,
			context: document.body, 
	        success: function(obj){
	        	if(obj != null && obj.length == 1){
	        		if(!_self.custom){
	        			var processDefinitionId = obj[0].dbid;
	        			new StartProcessByFormCode().doStart(processDefinitionId);
	        		}else{
	        			_self.openSelectProcessDialog(obj);
	        		}
	    		}else{
	    			_self.openSelectProcessDialog(obj);
	    		}
			},
			error: function(msg){}
		}); 	
	};
	
	this.openSelectProcessDialog = function(obj){
		__processList = obj; //付给页面变量为选流程页面使用
		var dialogUrl=getPath2()+"/avicit/platform6/bpmclient/bpm/ProcessDefinitionList.jsp";
		dialogUrl += "?formCode="+this.formCode;
		if(!_self.custom){
			dialogUrl += "&custom=0";
		}else{
			dialogUrl += "&custom=1";
		}
		var usd = new UserSelectDialog("startProcessByFormCodedialog","400","400",encodeURI(dialogUrl) ,"流程定义选择",null,null,this.appendIframe);
		var buttons = [{
 			text:'提交',
 			id : 'tj',
 			//iconCls : 'icon-submit',
 			handler:function(){
 				var frm = document.getElementById("_iframe_startProcessByFormCodedialog").contentWindow;
 				var processDefInfo = frm.$('#Process_Definition_data').datagrid('getSelected');
 				if(processDefInfo == null){
 					return ;
 				}
 				var processDefinitionId = processDefInfo.dbid;
 				var processName = processDefInfo.name;
 				//请求操作
 				if(confirm('你确定要启动['+processName+']流程吗??')){
 					new StartProcessByFormCode().doStart(processDefinitionId);
 					usd.close();
 				}
 			}
 		}];
		if(_self.custom){
			buttons.push({
				text:'自定义',
	 			id : 'custom',
	 			handler:function(){
	 				try{
	 					window.showModalDialog(getPath2() + "/platform/bpm/bpmdesigner/bpmWebDesigner/index?formCode=" + _self.formCode, window, "dialogHeight=2000px;dialogWidth:2000px;status=no;scroll=no");
	 					usd.close();
	 					_self.start();
	 				}catch(e){
	 					window.open(getPath2() + "/platform/bpm/bpmdesigner/bpmWebDesigner/index?refreshFlg=1&formCode=" + _self.formCode, window, 'left=0,top=0,width='+ (screen.availWidth - 10) +',height='+ (screen.availHeight-50) +',scrollbars,resizable=yes,toolbar=no');
	 					window.refreshFlg = function(){
	 						usd.close();
		 					_self.start();
	 					};
	 				}
	 				
	 			}});
		}
		usd.createButtonsInDialog(buttons);
		usd.show();
		return usd;
	};
};