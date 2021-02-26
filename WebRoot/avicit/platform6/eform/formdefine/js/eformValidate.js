//扩展easyui表单的验证
$.extend($.fn.validatebox.defaults.rules, {
	isRC: {
        validator: function (value, param) {
        	  var chk_value =[];    
        	  $('input[name='+param[0]+']:checked').each(function(){    
        	   chk_value.push($(this).val());    
        	  });    
        	  if(chk_value.length==0){
        		  return false;
        	  } else{
        		  return true;
        	  }
        },
        message: '该输入项为必输项'
    },

  length: {
      	 validator: function (value, param) {
    	 var len=value.replace(/[^\x00-\xff]/g, '...').length;
    	 return len>=param[0]&&len<=param[1];
    },
       message: '输入内容长度必须介于{0}和{1}之间'
	},
    //验证汉字
    chinese: {
        validator: function (value) {
            return /^[\u0391-\uFFE5]+$/.test(value);
        },
        message: '只能输入汉字'
    },
    english:{
    	validator: function (value){
    		for (var i = 0; i < value.length; i++) {  
    			if (value.charCodeAt(i) > 255) return false;  
    		}  
    		return true;
    	},
    	message: '不能包含汉字'
    },
    //移动手机号码验证
    mobile: {//value值为文本框中的值
        validator: function (value) {
            var reg = /^1[3|4|5|8|9]\d{9}$/;
            return reg.test(value);
        },
        message: '输入手机号码格式不准确.'
    },
    //国内邮编验证
    zipcode: {
        validator: function (value) {
            var reg = /^[1-9]\d{5}$/;
            return reg.test(value);
        },
        message: '邮编必须是非0开始的6位数字.'
    },
    radio: {
        validator: function (value, param) {
            var frm = param[0], groupname = param[1], ok = false;
            $('input[name="' + groupname + '"]', document[frm]).each(function () { //查找表单中所有此名称的radio
                if (this.checked) { ok = true; return false; }
            });

            return ok;
        },
        message: '需要选择一项！'
    },
    checkbox: {
        validator: function (value, param) {
            var frm = param[0], groupname = param[1], ok = false;
            $('input[name="' + groupname + '"]', document[frm]).each(function () { //查找表单中所有此名称的checkbox
                if (this.checked)  { ok = true; return false; }
            });

            return ok;
        },
        message: '需要选择一项！'
    }
    
});