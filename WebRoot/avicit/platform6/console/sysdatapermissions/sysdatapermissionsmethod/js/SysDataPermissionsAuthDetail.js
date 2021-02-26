function formatValue(cellvalue, options, rowObject) {
	if(cellvalue == "true"){
		return '<img src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/img/true.png">';
	} else {
		return "";
	}
}

function formatFilterCondition(cellvalue, options, rowObject) {
	var newVal = rowObject.formula;
	var str = "";
	for(var ii = 0 ; ii < newVal.length; ii++){
		var charStr = newVal.charAt(ii);
		var idVal = idMap.get(charStr);
		if(undefined != idVal){
			str += idVal.name;
		} else {
			str += charStr;
		}
	}
	return str;
}

function formatFilterConditionSql(cellvalue, options, rowObject) {
	var newVal = rowObject.formula;
	var str = "";
	for(var ii = 0 ; ii < newVal.length; ii++){
		var charStr = newVal.charAt(ii);
		var idVal = idMap.get(charStr);
		if(undefined != idVal){
			str += idVal.sql;
		} else {
			str += charStr;
		}
	}
	return str;
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
