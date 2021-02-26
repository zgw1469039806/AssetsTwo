/**
 * 自增长字符串控制
 */
var CountUtils = function() {
	var start = 0;
	var end = 0;
	var task = 0;
	var java = 0;
	var sql = 0;
	var ws = 0;
	var state = 0;
	var fork = 0;
	var join = 0;
	var exclusive = 0;
	var subprocess = 0;
	var foreach = 0;
	var jms = 0;
	var custom = 0;
	var rules = 0;
	var rest = 0;
	var swimlane = 0;
	var text = 0;
	var selfId = 2;
	return {
		getSelfId : function() {
			return "" + selfId++;
		},
		getStart : function() {
			return ++start;
		},
		getEnd : function() {
			return ++end;
		},
		getTask : function() {
			return ++task;
		},
		getJava : function() {
			return ++java;
		},
		getSql : function() {
			return ++sql;
		},
		getWs : function() {
			return ++ws;
		},
		getState : function() {
			return ++state;
		},
		getFork : function() {
			return ++fork;
		},
		getJoin : function() {
			return ++join;
		},
		getExclusive : function() {
			return ++exclusive;
		},
		getSubprocess : function() {
			return ++subprocess;
		},
		getForeach : function() {
			return ++foreach;
		},
		getJms : function() {
			return ++jms;
		},
		getCustom : function() {
			return ++custom;
		},
		getRules : function() {
			return ++rules;
		},
        getRest : function() {
            return ++rest;
        },
		getSwimlane : function() {
			return ++swimlane;
		},
		getText : function() {
			return ++text;
		},
		setSelfId : function(value) {
			if (value >= selfId) {
				selfId = value + 1;
			}
		},
		setStart : function(value) {
			if (value > start) {
				start = value;
			}
		},
		setEnd : function(value) {
			if (value > end) {
				end = value;
			}
		},
		setTask : function(value) {
			if (value > task) {
				task = value;
			}
		},
		setJava : function(value) {
			if (value > java) {
				java = value;
			}
		},
		setSql : function(value) {
			if (value > sql) {
				sql = value;
			}
		},
		setWs : function(value) {
			if (value > ws) {
				ws = value;
			}
		},
		setState : function(value) {
			if (value > state) {
				state = value;
			}
		},
		setFork : function(value) {
			if (value > fork) {
				fork = value;
			}
		},
		setJoin : function(value) {
			if (value > join) {
				join = value;
			}
		},
		setExclusive : function(value) {
			if (value > exclusive) {
				exclusive = value;
			}
		},
		setSubprocess : function(value) {
			if (value > subprocess) {
				subprocess = value;
			}
		},
		setForeach : function(value) {
			if (value > foreach) {
				foreach = value;
			}
		},
		setJms : function(value) {
			if (value > jms) {
				jms = value;
			}
		},
		setCustom : function(value) {
			if (value > custom) {
				custom = value;
			}
		},
		setRules : function(value) {
			if (value > rules) {
				rules = value;
			}
		},
        setRest : function(value) {
            if (value > rest) {
                rest = value;
            }
        },
		setSwimlane : function(value) {
			if (value > swimlane) {
				swimlane = value;
			}
		},
		setText : function(value) {
			if (value > text) {
				text = value;
			}
		}
	};
};