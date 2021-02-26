var MyElement = {
    elecode: "print-dbfield-box",
    colType:"NOT_DB_COL_ELE",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "外部字段";
    	dragelement.icon = "fa fa-info";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="外部数据模型字段">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },

    validateForm:function(eleattr){
        if(!eleattr.db_tableName || !eleattr.db_tableId || !eleattr.db_colName ||!eleattr.db_fk)
        {
            layer.msg('外部字段控件的存储模型、列名称、外键属性不能为空', {icon: 7});
            return false;
        }

        var regExp = /[\S+]/i;
        if((!eleattr.domId)||(eleattr.domId!=null && !regExp.test(eleattr.domId)))
        {
            layer.msg('外部字段控件页面元素ID属性不能为空', {icon: 7});
            return false;
        }else{
            var value=eleattr.domId,
                regEn = /[`~!@#$%^&*()+<>?:{},.\/;'[\]]/im,
                regCn = /[·！#￥（——）：；“”‘、，|《。》？、【】[\]]/im,
                regCh = /[\u4E00-\u9FA5]|[\uFE30-\uFFA0]/gi;
            if(regEn.test(value) || regCn.test(value) ||regCh.test(value)) {
                layer.msg('外部字段控件页面元素ID属性不能含有特殊字符或中文', {icon: 7});
                return false;
            }
        }
        return true;
    },

    initAttrForm: function (form, attrJson) {
        selectCreatedDbTable = new SelectCreatedDbTable("db_tableId", "db_tableName");
        selectCreatedDbTable.init(function (treeNode) {
            var tableId = treeNode.id;
            var cnname = treeNode.name;
            var tablename = treeNode.tablename;

            $("#db_tableName").val(tablename).trigger("keyup");

            $("#db_colName").val("").trigger("keyup");
            bindDbColName(tableId);
            $("#db_colName").attr('readonly',false);
            $("#db_colName").focus(function(){
            	this.blur();
            });

            $("#db_fk").val("").trigger("keyup");        
            bindDbFk(tableId);
            $("#db_fk").attr('readonly',false);
            $("#db_fk").focus(function(){
            	this.blur();
            });
            $('#span_colName').on('click',function(){
            	$('#db_colName').trigger('click');
        	}) 	
            $('#span_fk').on('click',function(){
            	$('#db_fk').trigger('click');
        	})   
        });

        if(attrJson != undefined) {
            var json = $.parseJSON(attrJson);
            if(!verifyIsEmpty(json.db_tableName)) {
                bindDbColName(json.db_tableId);
                bindDbFk(json.db_tableId);
            }
        }
        
        $('#span_tableName').on('click',function(){
        	$('#db_tableName').trigger('click');
    	})
    	
    	
    }    
};