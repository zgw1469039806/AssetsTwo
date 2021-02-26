function initFormData(){
	if("" == roleId){
		layer.alert('请选择一个角色！', {
			icon: 7,
			area: ['400px', ''],
			closeBtn: 0
		});
		return false;
	} 
	if("" == methodId){
		return false;
	}
	// 清空form
	clearFormData();
	// 查询对应的方法及权限
	avicAjax.ajax({
		url:"platform6/msystem/sysdatapermissions/sysdatapermissionsauth/sysDataPermissionsAuthController/getMethodDto",
		data : {roleId:roleId,methodId : methodId},
		type : 'get',
		dataType : 'json',
		success : function(r){
			if (r.flag == "success"){
				authMap = r.authMap;
				// 给模块表单赋值
				setForm(r.dto);
				
				if(r.dto.type == "1"){ // 电子表单
					$(".defaultAndEformTr").show();
					$(".EformTr").show();
					$(".defaultTr").hide();
					$(".selectTr").hide();
				} else if(r.dto.type == "0"){// 非电子表单
					$(".defaultTr").show();
					$(".defaultAndEformTr").show();
					$(".EformTr").hide();
					$(".selectTr").hide();
				} else if(r.dto.type == "2"){ // 选择页
					$(".defaultAndEformTr").hide();
					$(".EformTr").hide();
					$(".defaultTr").hide();
					$(".selectTr").show();
					if(r.dto.selectType == '2'){
						$(".selectCustomTr").show();
					}
				}

				// 生成规则复选框
				var ruleHtml = "";
				$.each(r.ruleList, function (i, d) {
					ruleHtml += "<label class='checkbox-inline'><input onclick=\"initFormula();\" type='checkbox' id='"+d.id+"' name='ruleCheckbox' value='"+d.id+"' identifier='"+d.identifier+"'  >【"+d.identifier+"】"+d.ruleName+"</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:void(0);' onclick=\"ruleDetail('"+d.id+"');\">详情</a><br/>";
        		});
				$("#ruleList").html(ruleHtml);
				// 如果分配过权限的话则勾选对应的规则
				$("#id").val("");
				authId = "";
				if(null != r.authDTO){
					authId = r.authDTO.id;
					$("#id").val(authId);
					$("#formula").val(r.authDTO.formula);
					if(null != r.authDTO.ruleIds){
						$.each(r.authDTO.ruleIds.split(","), function (i, d) {
							$("#"+d).attr("checked",true);
		        		});
					}
					analysisFormula(r.authDTO.formula);
				}
			}
		}
	});
}

// 清空表单
function clearFormData(){
	var formId = "#methodForm";
	$(formId).find('input[type=text]').val('');
	$(formId).find('select').val('');
	$(formId).find('input[type=hidden][name !=bpmState]').val('');// 不能清除name = bpmState 的流程条件
	$(formId).find('textarea').val('');//对 textarea中内容进行清除
	$(formId).find("input[type=checkbox]").attr("checked",false);//对 checkbox中内容进行清除
	$(formId).find("input[type=radio]").attr("checked",false);//对 radio中内容进行清除
}

// 赋值表单
function setForm(jsonValue){
	var obj = $("#methodForm");
    $.each(jsonValue, function (name, ival) {
        var oinput = obj.find("input[name=" + name + "]");
        if (oinput.attr("type") == "checkbox") {
            if (ival !== null) {
                var checkboxObj = $("[name=" + name + "]");
                var checkArray = ival.length > 0 ?ival.split(",") : ival;
                for (var i = 0; i < checkboxObj.length; i++) {
             	    checkboxObj[i].checked = false;
                    for (var j = 0; j < checkArray.length; j++) {
                        if (checkboxObj[i].value == checkArray[j]) {
                     	   checkboxObj[i].checked=true;
                        }
                    }
                } 
            }
        }else if (oinput.attr("type") == "radio") {
            oinput.each(function () {
                var radioObj = $("[name=" + name + "]");
                for (var i = 0; i < radioObj.length; i++) {
                    if (radioObj[i].value == ival) {
                 	   radioObj[i].checked=true;
                    }
                }
            });
        }else if (oinput.attr("type") == "textarea") {
            obj.find("[name=" + name + "]").html(ival);
        }else {
        	if("method" == name){
        		if(null != ival && "" != ival){
            		var methodHtml = "";
            		$.each(ival.split(","), function (i, d) {
            			methodHtml += "<option value='"+d+"'>"+d+"</option>";
            		});
            		$("#method").html(methodHtml);
            		$('#method').val(ival.split(","));
                    $('#method').trigger('change.select2');
        		} else {
        			$("#method").html("");
            		$('#method').val("");
                    $('#method').trigger('change.select2');
        		}
        	} else {
	            obj.find("[name=" + name + "]").val(ival);
        	}
        }
    });
    
    if(jsonValue){
    	if("2" == jsonValue.type){
    		$("#selectRemarks").val(jsonValue.tableRemarks);
    		if("2" == jsonValue.selectType){
        		$("#selectMapperName").val(jsonValue.mapperName);
        		$("#selectMethodName").val(jsonValue.method);

    		}
    	}
    }
}

// 生成规则
function initFormula(){
	var orArray = new Array();
	var orIdArray = new Array();
	var orNameArray = new Array();
	
	var andArray = new Array();
	var andIdArray = new Array();
	var andNameArray = new Array();
	
	$.each($("input[name='ruleCheckbox']:checked"), function (index, input) {
		var data = authMap[input.id];
		var matchSymbol = data.matchSymbol;
		var filterConditionSql = data.sql;
		var identifier = data.identifier;
		var name = data.name;
		
		if("0" == matchSymbol){
			orArray.push(filterConditionSql);
			orIdArray.push(identifier);
			orNameArray.push(name);
		} else {
			andArray.push(filterConditionSql);
			andIdArray.push(identifier);
			andNameArray.push(name);
		}
	});
	
	$("#filterConditionSql").val("");
	$("#filterCondition").val("");
	$("#formula").val("")
	
	var falg = true;
	if(orArray.length > 0){
		falg = false;
		$("#formula").val("( " + orIdArray.join("  or  ") + " )");
		$("#filterCondition").val("( " + orNameArray.join("  or  ") + " )");
		$("#filterConditionSql").val("( " + orArray.join("  or  ") + " )");
	}
	if(andArray.length > 0){
		var andStr = falg ? "" : "  and  ";
		$("#formula").val($("#formula").val() + andStr + "( " + andIdArray.join("  and  ") + " )");
		$("#filterCondition").val($("#filterCondition").val() + andStr + "( " + andNameArray.join("  and  ") + " )");
		$("#filterConditionSql").val($("#filterConditionSql").val() + andStr + "( " + andArray.join("  and  ") + " )");
	}
}

// 解析公式
var reg = /\d+/g;
function analysisFormula(newVal){
	$.each($("#ruleList").find("input"),function(i,d){
		$(d).prop("checked",false);
	});
	if(null == newVal || "" == newVal){
	} else {
		var idMap = new Map();
		$.each(authMap, function (index, data) {
			idMap.put(data.identifier,data);
		});
		var newValIds = newVal.match(reg);
		if(null != newValIds){
			var errorIds = new Array();
			var currentIds = new Array();
			$.each(newValIds, function (index1, data1) {
		    	var temp = false;
		    	$.each(idMap.keys(), function (index2, data2) {
		    		if(data2 == data1){
		    			temp = true;
		    			return;
		    		}
		    	});
		    	if(!temp){
		    		errorIds.push(data1);
		    	} else {
		    		$.each($("#ruleList").find("input"),function(index3,data3){
						if($(data3).attr("identifier") == data1){
		    				$(data3).prop("checked",true);
		    			}
					});
		    	}
			});
			if(errorIds.length > 0){
				layer.msg('编号为【'+errorIds.join(",")+'】不存在', {icon: 2});
				return false;
			}
			
			var filterConditionValue = "";
			var filterConditionSqlValue = "";
			for(var ii = 0 ; ii < newVal.length; ii++){
				var charStr = newVal.charAt(ii);
				var idVal = idMap.get(charStr);
				if(undefined != idVal){
					filterConditionValue += idVal.name;
					filterConditionSqlValue += idVal.sql;
				} else {
					filterConditionValue += charStr;
					filterConditionSqlValue += charStr;
				}
			}
			
			$("#filterCondition").val(filterConditionValue);
			$("#filterConditionSql").val(filterConditionSqlValue);
		}
	}
	return true;
}

function Map() {
	this.elements = new Array();
	this.size = function() {
		return this.elements.length
	};
	this.isEmpty = function() {
		return (this.elements.length < 1)
	};
	this.clear = function() {
		this.elements = new Array()
	};
	this.put = function(b, a) {
		this.remove(b);
		this.elements.push({
			key : b,
			value : a
		})
	};
	this.remove = function(b) {
		var d = false;
		try {
			for (var a = 0; a < this.elements.length; a++) {
				if (this.elements[a].key == b) {
					this.elements.splice(a, 1);
					return true
				}
			}
		} catch (c) {
			d = false
		}
		return d
	};
	this.get = function(b) {
		try {
			for (var a = 0; a < this.elements.length; a++) {
				if (this.elements[a].key == b) {
					return this.elements[a].value
				}
			}
		} catch (c) {
			return null
		}
	};
	this.element = function(a) {
		if (a < 0 || a >= this.elements.length) {
			return null
		}
		return this.elements[a]
	};
	this.containsKey = function(b) {
		var d = false;
		try {
			for (var a = 0; a < this.elements.length; a++) {
				if (this.elements[a].key == b) {
					d = true
				}
			}
		} catch (c) {
			d = false
		}
		return d
	};
	this.containsValue = function(a) {
		var d = false;
		try {
			for (var b = 0; b < this.elements.length; b++) {
				if (this.elements[b].value == a) {
					d = true
				}
			}
		} catch (c) {
			d = false
		}
		return d
	};
	this.values = function() {
		var a = new Array();
		for (var b = 0; b < this.elements.length; b++) {
			a.push(this.elements[b].value)
		}
		return a
	};
	this.keys = function() {
		var a = new Array();
		for (var b = 0; b < this.elements.length; b++) {
			a.push(this.elements[b].key)
		}
		return a
	}
}

$.event.special.valuechange = {
	teardown: function (namespaces) {
		$(this).unbind('.valuechange');
	},
	handler: function (e) {
		$.event.special.valuechange.triggerChanged($(this));
	},
	add: function (obj) {
		$(this).on('keyup.valuechange cut.valuechange paste.valuechange input.valuechange', obj.selector, $.event.special.valuechange.handler);
	},
	triggerChanged: function (element) {
		var current = element[0].contentEditable === 'true' ? element.html() : element.val(), previous = typeof element.data('previous') === 'undefined' ? element[0].defaultValue : element.data('previous');
		if (current !== previous) {
			element.trigger('valuechange', [element.data('previous')]);
			element.data('previous', current);
		}
	}
}