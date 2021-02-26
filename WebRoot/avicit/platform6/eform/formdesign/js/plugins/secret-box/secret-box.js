var MyElement = {
    elecode: "secret-box",
    colType:"VARCHAR2",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "密级控件";
    	dragelement.icon = "fa fa-user-secret";
    	return dragelement;
    },
    dropElement: function () {
        return '<select onChange="this.blur();"><option>密级控件</option></select>';
    }
};