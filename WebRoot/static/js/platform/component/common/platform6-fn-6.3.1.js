/**
 * 
 */
var Platform6 =Platform6 ||{};
Platform6.fn =Platform6.fn||{};
Platform6.fn.lookup =Platform6.fn.lookup||{};
Platform6.fn.lookup =((function(a){
	var _$=a;
	return {
		/**
		 * 获得系统可用的通用代码
		 * @param type 通用代码code
		 * @param func 回调函数
		 */
		getLookupType:function(type,func,isNull){
			var isnull=0;
			if(isNull){
				isnull=1;
			}
			
			_$.ajax({
				url: 'platform/syslookuptype/getLookUpCode/'+type+'/'+isnull+'.json',
				type :'get',
				cache :false,
				dataType :'json',
				success : func
			})
		},
		/**
		 * /**格式化显示通用代码
		 */
		formatLookupType:function(value,array){
			if(!(value||value===0)) return '';
			var l=array.length;
			//start   ws
			var show_value="";
			var value_array=[];
			if(value.length>1){
				value_array = value.split(",");
				for(var i=0;i<l;i++){
					for(var j=0;j<value_array.length;j++){
						if(array[i].lookupCode == value_array[j] && array[i].lookupCode!=""){
							show_value=show_value+array[i].lookupName+",";
						}
					}
			   }
				
			    return show_value.substring(0, show_value.length-1);
			  //end  ws
			}else{
				for(;l--;){
					if(array[l].lookupCode == value){
						return array[l].lookupName;
					}
				}
			}
			
					
				
		}
	};
})($));
Platform6.fn.profile =Platform6.fn.profile||{};
Platform6.fn.profile.getProfile=function(type,func){
	$.ajax({
		url: 'platform/sysprofile/getProfile/'+type+'.json',
		type :'get',
		cache :false,
		dataType :'text',
		success : func
	});
};
Platform6.fn.role =Platform6.fn.role||{};
Platform6.fn.role.getRole=function(type,func){
	$.ajax({
		url: 'platform/sysrole/getRoleByCode/'+type+'.json',
		type :'get',
		cache :false,
		dataType :'json',
		success : func
	});
};