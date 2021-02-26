/**
 * text extends MyBase
 */
function MyText(id) {
    MyBase.call(this, id, "text");
    this.style = "text";
};
MyText.prototype = new MyBase();
/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyText.prototype.initLoad = function (xmlValue, rootXml) {
    this.name = xmlValue.getAttribute("name");
    this.alias = $.trim(xmlValue.getAttribute("alias"));
    this.g = xmlValue.getAttribute("g");

    var cell = this.createMxCell();
    cell.setAttribute("connectable", "0");
    rootXml.appendChild(cell);// 创建mxCell
    _myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};