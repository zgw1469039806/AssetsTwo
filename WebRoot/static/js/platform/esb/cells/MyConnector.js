/**
 * 
 */
function MyConnector() {
	MyBase.call(this);
	this.selectDom = null;
	this.name = null;
	this.parentId = null;
	this.dbSql = new Map();
};
MyConnector.prototype = new MyBase();
MyConnector.prototype.init = function() {
	var _self = this;
	$.ajax({
		type : "POST",
		data : {
			projectId : _projectId
		},
		url : _controlPath + "getConnectorByProjectId",
		dataType : "json",
		async : false,
		success : function(r) {
			var obj = r.obj;
			for(var p in obj){
				var arr = obj[p];
				$.each(arr, function(i, n){
					var option = $("<option>").val(n).text(n);
					$("." + p).append(option);
				});
			}
			var dbSql = r.dbSql;
			for(var p in dbSql){
				_self.dbSql.put(p, dbSql[p]);
			}
		}
	});
};
MyConnector.prototype.openDialog = function(flg) {
	$('#' + this.id).find("div,form").show();
	if(flg){
		$('#' + this.id).find("input,select").each(function(i, n){
			var defaultValue = $(this).attr("defaultValue");
			if($.notNull(defaultValue)){
				$(this).val(defaultValue);
			}else{
				$(this).val("");
			}
		});
	}else{
		$('#' + this.id).find("input,select").val("");
	}
	$('#' + this.id).find("#ming_cheng").removeAttr("disabled");
	$('#' + this.id).window('open');
};
MyConnector.prototype.load = function() {
	var _self = this;
	$.ajax({
		type : "POST",
		data : {
			name : _self.name,
			projectId : _projectId
		},
		url : _controlPath + "getConnByName",
		dataType : "json",
		success : function(result) {
			easyHelp.showResultMsg(result, "", function(){
				_self.openDialog(false);
				$('#' + _self.id).find("#id").val(result.id);
				$('#' + _self.id).find("#ming_cheng").val(result.name);
				$('#' + _self.id).find("#ming_cheng").attr("disabled", "true");
				var xml = mxUtils.parseXml(result.mule);
				$(xml).find("mule").children().each(function(){
					if(_self.id == "db_connector"){
						_self.loadDbConnector($(this));
					}else if(_self.id == "db_sql"){
						_self.loadDbSqlConnector($(this));
					}else if(_self.id == "db_dataSource"){
						_self.loadDbDataSourceConnector($(this));
					}else if(_self.id == "conn_smtp"){
						_self.loadSmtpConnector($(this));
					}
				});
			});
		}
	});
};
MyConnector.prototype.closeDialog = function() {
	$('#' + this.id).window('close');
};
MyConnector.prototype.save = function(node) {
	var xml = ComUtils.getPrettyXml(node);
	var connId = $('#' + this.id).find("#id").val();
	var _self = this;
	if($.notNull(connId)){
		//修改
		$.ajax({
			type : "POST",
			data : {
				xml : xml,
				id : connId
			},
			url : _controlPath + "updateConnector",
			dataType : "json",
			success : function(r) {
				easyHelp.showResultMsg(r, "保存成功！", function(){
					_self.closeDialog();
				});
			}
		});
	}else{
		//增加
		var name = $('#' + this.id).find("#ming_cheng").val();
		if($.notNull(name)){
			if(!name.isEn()){
				easyHelp.showMsg("名称只能使用英文、数字和下划线");
				return false;
			}
			var flowId = myAction.getFlowId();
			$.ajax({
				type : "POST",
				data : {
					name : name,
					flowId : flowId,
					xml : xml,
					type : _self.id,
					parentId : _self.parentId
				},
				url : _controlPath + "saveConnector",
				dataType : "json",
				success : function(r) {
					easyHelp.showResultMsg(r, "保存成功！", function(){
						//在IE下，添加后无法立即显示
						var option = $("<option>").val(name).text(name);
						if(_self.id == "db_sql"){
							if(_self.dbSql.containsKey(_self.parentId)){
								_self.dbSql.get(_self.parentId).push(name);
							}else{
								var arr = new Array();
								arr.push(name);
								_self.dbSql.put(_self.parentId, arr);
							}
							_self.selectDom.append(option);
						}else{
							$("." + _self.id).append(option);
						}
						_self.selectDom.val(name);
						_self.closeDialog();
						_self.selectDom.trigger("change");
					});
				}
			});
		}else{
			easyHelp.showMsg("名称不能为空！");
		}
	}
};
MyConnector.prototype.saveTcpConnector = function(){
	var node = ComUtils.createElement("tcp:connector");
	this.setXmlAttrByVal("name", "ming_cheng", node);
	this.setXmlAttrByVal("doc:name", "ming_cheng", node);
	var child = ComUtils.createElement("tcp:direct-protocol");
	this.putAttr("payloadOnly", "true", child);
	node.appendChild(child);
	this.save(node);
};
MyConnector.prototype.saveDbConnector = function(){
	var node = ComUtils.createElement("jdbc:connector");
	this.setXmlAttrByVal("name", "ming_cheng", node);
	this.setXmlAttrByVal("doc:name", "ming_cheng", node);
	this.setXmlAttrByVal("dataSource-ref", "dataSource-ref", node);
	this.setXmlAttrByVal("pollingFrequency", "pollingFrequency", node);
	this.setXmlAttrByVal("transactionPerMessage", "transactionPerMessage", node);
	this.save(node);
};
MyConnector.prototype.loadDbConnector = function(xmlValue){
	this.setDomValByAttr("dataSource-ref", xmlValue, "dataSource-ref");
	this.setDomValByAttr("pollingFrequency", xmlValue, "pollingFrequency");
	this.setDomValByAttr("transactionPerMessage", xmlValue, "transactionPerMessage");
};
MyConnector.prototype.saveDbSqlConnector = function(){
	var node = ComUtils.createElement("jdbc:query");
	this.setXmlAttrByVal("key", "ming_cheng", node);
	this.setXmlAttrByVal("value", "sql", node);
	this.save(node);
};
MyConnector.prototype.loadDbSqlConnector = function(xmlValue){
	this.setDomValByAttr("sql", xmlValue, "value");
};
MyConnector.prototype.saveDbDataSourceConnector = function(){
	var node = ComUtils.createElement("spring:bean");
	this.setXmlAttrByVal("id", "ming_cheng", node);
	this.setXmlAttrByVal("class", "class", node);
	this.setXmlAttrByVal("destroy-method", "destroy-method", node);
	this.setXmlPropertyByVal("spring:property", "driverClassName", "driverClassName", node);
	this.setXmlPropertyByVal("spring:property", "url", "url", node);
	this.setXmlPropertyByVal("spring:property", "username", "username", node);
	this.setXmlPropertyByVal("spring:property", "password", "password", node);
	this.setXmlPropertyByVal("spring:property", "maxActive", "maxActive", node);
	this.setXmlPropertyByVal("spring:property", "minIdle", "minIdle", node);
	this.setXmlPropertyByVal("spring:property", "maxIdle", "maxIdle", node);
	this.setXmlPropertyByVal("spring:property", "initialSize", "initialSize", node);
	this.setXmlPropertyByVal("spring:property", "logAbandoned", "logAbandoned", node);
	this.setXmlPropertyByVal("spring:property", "removeAbandoned", "removeAbandoned", node);
	this.setXmlPropertyByVal("spring:property", "removeAbandonedTimeout", "removeAbandonedTimeout", node);
	this.setXmlPropertyByVal("spring:property", "maxWait", "maxWait", node);
	this.setXmlPropertyByVal("spring:property", "timeBetweenEvictionRunsMillis", "timeBetweenEvictionRunsMillis", node);
	this.setXmlPropertyByVal("spring:property", "numTestsPerEvictionRun", "numTestsPerEvictionRun", node);
	this.setXmlPropertyByVal("spring:property", "minEvictableIdleTimeMillis", "minEvictableIdleTimeMillis", node);
	this.setXmlPropertyByVal("spring:property", "validationQuery", "validationQuery", node);
	this.save(node);
};
MyConnector.prototype.loadDbDataSourceConnector = function(xmlValue){
	var _self = this;
	this.setDomValByAttr("class", xmlValue, "class");
	this.setDomValByAttr("destroy-method", xmlValue, "destroy-method");
	$(xmlValue).children().each(function(){
		var name = $(this).attr("name");
		var value = $(this).attr("value");
		$("#" + _self.id).find("#" + name).val(value);
	});
};
MyConnector.prototype.saveSmtpConnector = function(){
	var node = ComUtils.createElement("smtp:connector");
	this.setXmlAttrByVal("name", "ming_cheng", node);
	this.setXmlAttrByVal("doc:name", "ming_cheng", node);
	
	this.setXmlAttrByVal("ccAddresses", "chao_song", node);
	this.setXmlAttrByVal("bccAddresses", "mi_song", node);
	this.setXmlAttrByVal("fromAddress", "fa_jian_ren", node);
	this.setXmlAttrByVal("subject", "biao_ti", node);
	
	var mimetype = $("#" + this.id).find("#MIME_TYPE").val();
	var zifuji = $("#" + this.id).find("#zi_fu_ji").val();
	if($.notNull(zifuji)){
		mimetype = mimetype + ";charset=" + zifuji;
	}
	this.putAttr("contentType", mimetype, node);
	
	this.save(node);
};
MyConnector.prototype.loadSmtpConnector = function(xmlValue){
	this.setDomValByAttr("chao_song", xmlValue, "ccAddresses");
	this.setDomValByAttr("mi_song", xmlValue, "bccAddresses");
	this.setDomValByAttr("fa_jian_ren", xmlValue, "fromAddress");
	this.setDomValByAttr("biao_ti", xmlValue, "subject");
	
	var contentType = this.getAttr(xmlValue, "contentType");
	if($.notNull(contentType)){
		var contentTypeArr = contentType.split(";charset=");
		$("#" + this.id).find("#MIME_TYPE").val($.trim(contentTypeArr[0]));
		if(contentTypeArr.length >1){
			$("#" + this.id).find("#zi_fu_ji").val($.trim(contentTypeArr[1]));
		}
	}
};