/**
 * 弹出风格 _title:标题 _content:地址 _width、_height：xx%/xxpx _jsonField:父页面传递的json字段对象
 * textId1:"field1",textId2:"field2"…… textId:父页面需要回填数据的控件ID，field:选择页面对应的数据字段
 * splitChar 多选分隔符，默认";"
 * _fun:父页面传递的函数引用 _maxmin：是否最大化 false/true 默认false _closeBtn:是否显示关闭按钮
 * false/true 默认true
 * beforeReturnValueToParent:选择页面返回值前置函数，可用于做一些数据校验，返回fale选择页面不关闭，返回true选择页面关闭。
 * returnValueToParent：选择页面返回值的函数，点击【确定】按钮时调用，需要有返回值{}或[{}]。
 * _callbtnok：子页面直接调用,实现确定按钮的功能。 _parentObj:父对象（实现在父页面打开窗口回填值）
 * 注意：如果绑定的是focus事件，需要在调用此函数前增加$("#控件ID").blur()【解决重复打开页面的问题】 例子：
 * $('#控件ID').bind('focus', function(){ var
 * fields={textId1:"field1",textId2:"field2"}; $("#控件ID").blur();
 * showCustomDialog('请选择',url,"700px","400px",fields,"",null,true,true); });
 */

function showCustomDialog(_title, _content, _width, _height, _jsonField,splitChar, _fun,
		_maxmin, _closeBtn, _parentObj) {
	if(typeof(splitChar)=='undefined'|| splitChar==null||splitChar==""){
		splitChar=";";
	}
	var btn1click = function(index, layero, rowData) {
		var _rowData = null;
		if (!rowData) {
			_rowData = layero.find('iframe')[0].contentWindow
					.returnValueToParent();
		} else {
			_rowData = rowData;
		}
		if (_rowData === false) {
			return;
		}
		
		var _checkFun = layero.find('iframe')[0].contentWindow.beforeReturnValueToParent;
		if (typeof (_checkFun) == "function") {
			if (!_checkFun()) {
				return false;
			}
		}
		if (_jsonField != null && _jsonField != "") {
			if (Object.prototype.toString.call(_rowData) == '[object Array]') {
				var _tempRowData = {};
				for (var i = 0; i < _rowData.length; i++) {
					for ( var en in _rowData[i]) {
						if (!_tempRowData[en]) {
							_tempRowData[en] = _rowData[i][en];
						} else {
							_tempRowData[en] += splitChar + _rowData[i][en];
						}
					}
				}
				_rowData = _tempRowData;
			}
			if (_parentObj) {
				for ( var id in _jsonField) {
					_parentObj.$("#" + id).val(_rowData[_jsonField[id]]);
				}
			} else {
				for ( var id in _jsonField) {
					$("#" + id).val(_rowData[_jsonField[id]]);
				}
			}
		}
		if (_fun && typeof (_fun) == "function") {
			_fun(_rowData);
		}
		layer.close(index);
	};
	layer.open({
		type : 2,
		area : [ _width, _height ],
		title : _title,
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : _maxmin ? true : false, // 开启最大化最小化按钮
		closeBtn : (_maxmin == null || _maxmin) ? true : false,
		btn : [ '确定', '取消' ],
		content : _content,
		success : function(layero, index) {
			//子页面通过双击/单击事件回填数据的方法，将选中的rowdata传入_callbtnok函数即可回填
			layero.find('iframe')[0].contentWindow._callbtnok = function(
					rowData) {
				btn1click(index, layero, rowData)
			};
		},
		btn1 : btn1click,
		btn2 : function(index, layero) {
			layer.close(index);
		}
	});
}
