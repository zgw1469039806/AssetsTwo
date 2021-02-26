/**
 * task extends MyBase
 */
function MyTask(id) {
	MyBase.call(this, id, "task");
	this.style = "image;image=static/js/platform/designer/images/48/task_human.png;";
};
MyTask.prototype = new MyBase();

/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 * @param rootXml
 */
MyTask.prototype.initLoad = function(xmlValue, rootXml) {
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	
	var icon = this.getAttr(xmlValue, "icon");
	if($.notNull(icon)){
		if(icon == "领导01.png"){
			this.style = "image;image=static/js/platform/designer/images/node/leader01.png;";
		}else if(icon == "领导02.png"){
			this.style = "image;image=static/js/platform/designer/images/node/leader02.png;";
		}else if(icon == "员工01.png"){
			this.style = "image;image=static/js/platform/designer/images/node/employee01.png;";
		}else if(icon == "员工02.png"){
			this.style = "image;image=static/js/platform/designer/images/node/employee02.png;";
		}
	}
	
	rootXml.appendChild(this.createMxCell());// 创建mxCell
	_myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
