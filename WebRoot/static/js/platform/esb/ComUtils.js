/**
 * 一些工具类的方法
 */
var ComUtils = {
	/**
	 * 构建xml的工具
	 */
	doc : mxUtils.createXmlDocument(),
	/**
	 * 构建xml元素
	 * 
	 * @param value
	 * @returns
	 */
	createElement : function(value) {
		return this.doc.createElement(value);
	},
	/**
	 * 构建xmltext元素
	 * 
	 * @param value
	 * @returns
	 */
	createTextNode : function(value) {
		return this.doc.createTextNode($.trim(value));
	},
	/**
	 * 重写的mxUtils中的方法，因为原方法在处理text类型时会多加一个空格
	 * 
	 * @param node
	 * @param tab
	 * @param indent
	 * @returns
	 */
	getPrettyXml : function(node, tab, indent) {
		var result = [];

		if (node != null) {
			tab = tab || '';
			indent = indent || '';

			if (node.nodeType == mxConstants.NODETYPE_TEXT) {
				result.push(node.nodeValue);
			} else {
				result.push(indent + '<' + node.nodeName);

				// Creates the string with the node attributes
				// and converts all HTML entities in the values
				var attrs = node.attributes;

				if (attrs != null) {
					for (var i = 0; i < attrs.length; i++) {
						var val = mxUtils.htmlEntities(attrs[i].nodeValue);
						result.push(' ' + attrs[i].nodeName + '="' + val + '"');
					}
				}

				// Recursively creates the XML string for each
				// child nodes and appends it here with an
				// indentation
				var tmp = node.firstChild;

				if (tmp != null) {
					var temIndent = "";
					result.push('>');
					if (tmp.nodeType != mxConstants.NODETYPE_TEXT) {
						temIndent = indent;
						result.push('\n');
					}

					while (tmp != null) {
						result.push(ComUtils.getPrettyXml(tmp, tab, indent
								+ tab));
						tmp = tmp.nextSibling;
					}
					result.push(temIndent + '</' + node.nodeName + '>\n');
				} else {
					result.push('/>\n');
				}
			}
		}

		return result.join('');
	}
};
