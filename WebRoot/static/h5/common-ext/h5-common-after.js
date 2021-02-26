if($.jgrid){
	$.jgrid.extend({
		saveOrEditDtoToRedis: function(option) {
			var jqGridID =  this.jqGrid("getGridParam","id");
			var jqGridUrl =  this.jqGrid("getGridParam","url");
			var self = this;
			avicAjax.ajax({
		        url: 'platform/SysDatatablesController/saveOrEditDtoToRedis',
		        data: {
		        	tableName : jqGridUrl + "/" + jqGridID, columns : option.columnArrayJson
		        },
		        async:false,
		        type: 'post',
		        dataType: 'json',
		        success: function(r) {
		            if (r.flag == "success") {
						self.jqGrid("setGridWidth", option.jqGridwidth);
						self.jqGrid().trigger("reloadGrid");
		            	layer.msg('保存成功！');
		            } else {
		            	 layer.alert('保存失败！' + r.error,{
							  icon: 7,
							  area: ['400px', ''],
							  closeBtn: 0
						    }
				         );
		            }
		        }
		    });
		},
		getColumnByUserIdAndTableName: function(){
			var jqGridID =  this.jqGrid("getGridParam","id");
			var jqGridUrl =  this.jqGrid("getGridParam","url");
			var jqGridwidth =  this.jqGrid("getGridParam","width");
			var cm =  this.jqGrid("getGridParam","colModel");
			var self = this;
			$.ajax({
				url: 'platform/SysDatatablesController/getColumnByUserIdAndTableName',
				data : {tableName : jqGridUrl + "/" + jqGridID},
				type : 'post',
				dataType : 'json',
				async:false,
				success : function(r){
					var gridParam = self.getGridParam();
					if (r.flag === 'success') {
						var remapOldIndex = {};
						for(var i = 0; i < cm.length; i++){
							if(r[cm[i].name]){
								var columnShow = r[cm[i].name].columnShow;
								var columnWidth = r[cm[i].name].columnWidth;
								cm[i].width = parseInt(columnWidth);
								if (columnShow === "false") {
									self.setGridParam().hideCol(cm[i].name);
								} else {
									self.setGridParam().showCol(cm[i].name);
								}
							}
							remapOldIndex[cm[i].name] = i;
						}
						var obj = shortTableColumn(cm, r, remapOldIndex);
						self.setGridParam().remapColumns(obj.remapIndex, true, false);
						gridParam.colModel = obj.remapCols;
					}
					self.jqGrid("setGridWidth", jqGridwidth);
					self.jqGrid(gridParam).trigger("reloadGrid");
				}
			});
		}
	});

    /**
     * 排序
     * @param cols 表格
     * @param r 保存数据
     * @param oldIndexs 原下标顺序
     */
	function shortTableColumn(cols, r, oldIndexs) {
	    var indexs = [],remapCols = [];
		for (var i = 0; i < cols.length - 1; i++) {
			for (var j = 0; j < cols.length - i -1; j++) {
				if((typeof(cols[j].hasInSetting) !='undefined' && cols[j].hasInSetting != true) || cols[j].name === 'cb'
					|| cols[j].name==='subgrid' || cols[j].name==='rn'
					|| cols[j].name=== 'ID' || cols[j].name === 'id' ||
					cols[j].name === 'VERSION' || cols[j].name === 'version' || cols[j].hidedlg){
					continue;
				}
				var short1 = 99;	// 无数据, 默认最后
				var short2 = 99;	// 无数据, 默认最后
				if(r[cols[j].name]){
					short1 = parseInt(r[cols[j].name].attribute01);
				}
				if(r[cols[j + 1].name]){
					short2 = parseInt(r[cols[j + 1].name].attribute01);
				}
				if (short1 > short2) {
					var temp = cols[j];
					cols[j] = cols[j + 1];
					cols[j + 1] = temp;
				}
			}
		}
		// 已排序后的新表格顺序循环
		for (var i = 0; i < cols.length; i ++) {
            // 获取原下标
            indexs.push(oldIndexs[cols[i].name]);
			remapCols.push(cols[i]);
        }
		return {remapCols: remapCols, remapIndex: indexs};
	}
}
$(function(){
    $(function(){
    	$(function(){
    	  // 3层深度，保证脚本执行再最后面
    	  var funPlaceholder = function(element) {
		    	element.each(function(){
		    		var placeholder = '',that=$(this);
			    	if (element && !("placeholder" in document.createElement("input")) && (placeholder = that.attr("placeholder"))){
			    		that.on('focus',function(){
			    			if (that.val() === placeholder) {
			    	            that.val("");
			    	        }
			    	        that.css('color','');
			    		}).on('blur',function(){
			    			if (that.val() === "") {
			    	            that.val(placeholder);
			    	            that.css('color','graytext');
			    	        }
			    		});
			    	    //样式初始化
			    	    if (that.val() === "") {
			    	        that.val(placeholder);
			    	        that.css('color','graytext');
			    	    }
			    	}
		    	});
			};
			/* 提示信息兼容  start */
			funPlaceholder($('[placeholder]'));
    		/* 提示信息兼容  end */

    		/* 输入框图标点击触发获取焦点 */
			$('.form_commonTable,.form_commonTable1').each(function(){
                $(this).find(".input-group-addon").unbind("click.auto").bind("click.auto",function(){
                    $(this).parent().find('input[type="text"]').trigger('focus');
				});
			});
    	});
	});
});