/**
 * text extends MyBase
 */
function MyText(id) {
    MyBase.call(this, id, "text");
    this.style = "text";
};
MyText.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyText.prototype.init = function () {
    this.initBase();
    this.name = this.tagName + _countUtils.getText();
    this.labelChanged("添加文本");
    this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyText.prototype.initLoad = function (xmlValue, rootXml) {
    this.initBase();
    this.name = xmlValue.getAttribute("name");
    this.alias = $.trim(xmlValue.getAttribute("alias"));
    this.g = xmlValue.getAttribute("g");
    _countUtils.setText(this.resolve());// 设置自增长数字
    this.initJBXX();// 初始化基本信息
    /*****以上是公共的*******/
    /*****以下是公共的*******/
    var cell = this.createMxCell();
    cell.setAttribute("connectable", "0");
    rootXml.appendChild(cell);// 创建mxCell
    _myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 组装processXML的自定义信息
 *
 * @param node
 */
MyText.prototype.getOtherAttr = function (node) {
};
