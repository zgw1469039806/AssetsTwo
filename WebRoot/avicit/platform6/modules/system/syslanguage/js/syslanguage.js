var sysLanguage=(function(a){
	var jq=a,
		_id,
		_url,
		datagrid,
		editIndex=-1,
		languageCodeCombo=[{"v":"日文 (日本)","k":"ja_JP"},{"v":"西班牙文 (秘鲁)","k":"es_PE"},{"v":"英文","k":"en"},{"v":"日文 (日本,JP)","k":"ja_JP_JP"},{"v":"西班牙文 (巴拿马)","k":"es_PA"},{"v":"塞尔维亚文 (波斯尼亚和黑山共和国)","k":"sr_BA"},{"v":"马其顿文","k":"mk"},{"v":"西班牙文 (危地马拉)","k":"es_GT"},{"v":"阿拉伯文 (阿拉伯联合酋长国)","k":"ar_AE"},{"v":"挪威文 (挪威)","k":"no_NO"},{"v":"阿尔巴尼亚文 (阿尔巴尼亚)","k":"sq_AL"},{"v":"保加利亚文","k":"bg"},{"v":"阿拉伯文 (伊拉克)","k":"ar_IQ"},{"v":"阿拉伯文 (也门)","k":"ar_YE"},{"v":"匈牙利文","k":"hu"},{"v":"葡萄牙文 (葡萄牙)","k":"pt_PT"},{"v":"希腊文 (塞浦路斯)","k":"el_CY"},{"v":"阿拉伯文 (卡塔尔)","k":"ar_QA"},{"v":"马其顿文 (马其顿王国)","k":"mk_MK"},{"v":"瑞典文","k":"sv"},{"v":"德文 (瑞士)","k":"de_CH"},{"v":"英文 (美国)","k":"en_US"},{"v":"芬兰文 (芬兰)","k":"fi_FI"},{"v":"冰岛文","k":"is"},{"v":"捷克文","k":"cs"},{"v":"英文 (马耳他)","k":"en_MT"},{"v":"斯洛文尼亚文 (斯洛文尼亚)","k":"sl_SI"},{"v":"斯洛伐克文 (斯洛伐克)","k":"sk_SK"},{"v":"意大利文","k":"it"},{"v":"土耳其文 (土耳其)","k":"tr_TR"},{"v":"中文","k":"zh"},{"v":"泰文","k":"th"},{"v":"阿拉伯文 (沙特阿拉伯)","k":"ar_SA"},{"v":"挪威文","k":"no"},{"v":"英文 (英国)","k":"en_GB"},{"v":"塞尔维亚文 (塞尔维亚及黑山)","k":"sr_CS"},{"v":"立陶宛文","k":"lt"},{"v":"罗马尼亚文","k":"ro"},{"v":"英文 (新西兰)","k":"en_NZ"},{"v":"挪威文 (挪威,Nynorsk)","k":"no_NO_NY"},{"v":"立陶宛文 (立陶宛)","k":"lt_LT"},{"v":"西班牙文 (尼加拉瓜)","k":"es_NI"},{"v":"荷兰文","k":"nl"},{"v":"爱尔兰文 (爱尔兰)","k":"ga_IE"},{"v":"法文 (比利时)","k":"fr_BE"},{"v":"西班牙文 (西班牙)","k":"es_ES"},{"v":"阿拉伯文 (黎巴嫩)","k":"ar_LB"},{"v":"朝鲜文","k":"ko"},{"v":"法文 (加拿大)","k":"fr_CA"},{"v":"爱沙尼亚文 (爱沙尼亚)","k":"et_EE"},{"v":"阿拉伯文 (科威特)","k":"ar_KW"},{"v":"塞尔维亚文 (塞尔维亚)","k":"sr_RS"},{"v":"西班牙文 (美国)","k":"es_US"},{"v":"西班牙文 (墨西哥)","k":"es_MX"},{"v":"阿拉伯文 (苏丹)","k":"ar_SD"},{"v":"印度尼西亚文 (印度尼西亚)","k":"in_ID"},{"v":"俄文","k":"ru"},{"v":"拉托维亚文(列托)","k":"lv"},{"v":"西班牙文 (乌拉圭)","k":"es_UY"},{"v":"拉托维亚文(列托) (拉脱维亚)","k":"lv_LV"},{"v":"希伯来文","k":"iw"},{"v":"葡萄牙文 (巴西)","k":"pt_BR"},{"v":"阿拉伯文 (叙利亚)","k":"ar_SY"},{"v":"克罗地亚文","k":"hr"},{"v":"爱沙尼亚文","k":"et"},{"v":"西班牙文 (多米尼加共和国)","k":"es_DO"},{"v":"法文 (瑞士)","k":"fr_CH"},{"v":"印地文 (印度)","k":"hi_IN"},{"v":"西班牙文 (委内瑞拉)","k":"es_VE"},{"v":"阿拉伯文 (巴林)","k":"ar_BH"},{"v":"英文 (菲律宾)","k":"en_PH"},{"v":"阿拉伯文 (突尼斯)","k":"ar_TN"},{"v":"芬兰文","k":"fi"},{"v":"德文 (奥地利)","k":"de_AT"},{"v":"西班牙文","k":"es"},{"v":"荷兰文 (荷兰)","k":"nl_NL"},{"v":"西班牙文 (厄瓜多尔)","k":"es_EC"},{"v":"中文 (台湾地区)","k":"zh_TW"},{"v":"阿拉伯文 (约旦)","k":"ar_JO"},{"v":"白俄罗斯文","k":"be"},{"v":"冰岛文 (冰岛)","k":"is_IS"},{"v":"西班牙文 (哥伦比亚)","k":"es_CO"},{"v":"西班牙文 (哥斯达黎加)","k":"es_CR"},{"v":"西班牙文 (智利)","k":"es_CL"},{"v":"阿拉伯文 (埃及)","k":"ar_EG"},{"v":"英文 (南非)","k":"en_ZA"},{"v":"泰文 (泰国)","k":"th_TH"},{"v":"希腊文 (希腊)","k":"el_GR"},{"v":"意大利文 (意大利)","k":"it_IT"},{"v":"加泰罗尼亚文","k":"ca"},{"v":"匈牙利文 (匈牙利)","k":"hu_HU"},{"v":"法文","k":"fr"},{"v":"英文 (爱尔兰)","k":"en_IE"},{"v":"乌克兰文 (乌克兰)","k":"uk_UA"},{"v":"波兰文 (波兰)","k":"pl_PL"},{"v":"法文 (卢森堡)","k":"fr_LU"},{"v":"荷兰文 (比利时)","k":"nl_BE"},{"v":"英文 (印度)","k":"en_IN"},{"v":"加泰罗尼亚文 (西班牙)","k":"ca_ES"},{"v":"阿拉伯文 (摩洛哥)","k":"ar_MA"},{"v":"西班牙文 (玻利维亚)","k":"es_BO"},{"v":"英文 (澳大利亚)","k":"en_AU"},{"v":"塞尔维亚文","k":"sr"},{"v":"中文 (新加坡)","k":"zh_SG"},{"v":"葡萄牙文","k":"pt"},{"v":"乌克兰文","k":"uk"},{"v":"西班牙文 (萨尔瓦多)","k":"es_SV"},{"v":"俄文 (俄罗斯)","k":"ru_RU"},{"v":"朝鲜文 (韩国)","k":"ko_KR"},{"v":"越南文","k":"vi"},{"v":"阿拉伯文 (阿尔及利亚)","k":"ar_DZ"},{"v":"越南文 (越南)","k":"vi_VN"},{"v":"塞尔维亚文 (黑山)","k":"sr_ME"},{"v":"阿尔巴尼亚文","k":"sq"},{"v":"阿拉伯文 (利比亚)","k":"ar_LY"},{"v":"阿拉伯文","k":"ar"},{"v":"中文 (中国)","k":"zh_CN"},{"v":"白俄罗斯文 (白俄罗斯)","k":"be_BY"},{"v":"中文 (香港)","k":"zh_HK"},{"v":"日文","k":"ja"},{"v":"希伯来文 (以色列)","k":"iw_IL"},{"v":"保加利亚文 (保加利亚)","k":"bg_BG"},{"v":"印度尼西亚文","k":"in"},{"v":"马耳他文 (马耳他)","k":"mt_MT"},{"v":"西班牙文 (巴拉圭)","k":"es_PY"},{"v":"斯洛文尼亚文","k":"sl"},{"v":"法文 (法国)","k":"fr_FR"},{"v":"捷克文 (捷克共和国)","k":"cs_CZ"},{"v":"意大利文 (瑞士)","k":"it_CH"},{"v":"罗马尼亚文 (罗马尼亚)","k":"ro_RO"},{"v":"西班牙文 (波多黎哥)","k":"es_PR"},{"v":"英文 (加拿大)","k":"en_CA"},{"v":"德文 (德国)","k":"de_DE"},{"v":"爱尔兰文","k":"ga"},{"v":"德文 (卢森堡)","k":"de_LU"},{"v":"德文","k":"de"},{"v":"西班牙文 (阿根廷)","k":"es_AR"},{"v":"斯洛伐克文","k":"sk"},{"v":"马来文 (马来西亚)","k":"ms_MY"},{"v":"克罗地亚文 (克罗地亚)","k":"hr_HR"},{"v":"英文 (新加坡)","k":"en_SG"},{"v":"丹麦文","k":"da"},{"v":"马耳他文","k":"mt"},{"v":"波兰文","k":"pl"},{"v":"阿拉伯文 (阿曼)","k":"ar_OM"},{"v":"土耳其文","k":"tr"},{"v":"泰文 (泰国,TH)","k":"th_TH_TH"},{"v":"希腊文","k":"el"},{"v":"马来文","k":"ms"},{"v":"瑞典文 (瑞典)","k":"sv_SE"},{"v":"丹麦文 (丹麦)","k":"da_DK"},{"v":"西班牙文 (洪都拉斯)","k":"es_HN"}],
		cell={},
		cellNBame={},
		s=function(record){
			cellNBame.val(record.k); 
		},
		afterEdit=function(){
			editIndex=-1;
		},
		myClickRow=function(index,rowData){
			if(rowData.isSystemDefault ==1){
				jq.messager.show({
					 title : '提示！',
					 msg : '系统默认语言，不能修改！'
				 });
				return;
			}
			datagrid.datagrid('endEdit', editIndex);
			if(editIndex==-1){
				datagrid.datagrid('beginEdit', index);  
				editIndex=index;
				
				var ed = datagrid.datagrid('getEditor',{index: index, field: 'languageName'});
				cell = jq(ed.target);
				var value=cell.combobox('getValue');
				cell.combobox('loadData', languageCodeCombo);
				cell.combobox({
					onSelect : s
				});
				
				cell.combobox({
					width : cell.parent().width()
				});
				cell.combobox('setValue', value);
				// 语言名称的文本框
				var ed = datagrid.datagrid('getEditor', {
					index : index,
					field : 'languageCode'
				});
				cellNBame =jq(ed.target).attr('disabled', true);

				// 默认语言的文本框
				var ed = datagrid.datagrid('getEditor', {
					index : index,
					field : 'isSystemDefault'
				});
				jq(ed.target).attr('disabled', true);
			}else{
				jq.messager.alert('提示','不能编辑，请确保上一条数据填写完整','warning');
			} 
		},
		reload=function(){
			jq.ajax({
				url: 'platform/syslanguage/list.json',
				type :'get',
				cache :false,
				dataType :'json',
				success :function(r){
					if(r&&r.flag==0){
						datagrid.datagrid('loadData',r.rows);
					}else{
						jq.messager.show({
							 title : '加载失败！',
							 msg : r.e
						 });
					}
				}
			});
		};
		
		
	return {
		inite:function(id,url){
			_id='#'+id;
			_url=url;
			datagrid=jq(_id).datagrid({
				url:null,
				onAfterEdit:afterEdit,
				onClickRow: myClickRow
			});
			reload();
		},
		addRow : function() {
			datagrid.datagrid('endEdit', editIndex);
			if (editIndex != -1) {
				jq.messager.alert('提示', '不能添加，请确保上一条数据填写完整', 'warning');
				return;
			}

			datagrid.datagrid('insertRow', {
				index : 0,
				row : {
					id : "",
					isSystemDefault : '0'
				}
			});
			datagrid.datagrid('selectRow', 0).datagrid('beginEdit', 0);
			editIndex = 0;

			// 语言代码的下拉框
			var ed = datagrid.datagrid('getEditor', {
				index : 0,
				field : 'languageName'
			});
			cell = jq(ed.target);

			// 这部分是由于onselect的副作用，造成了value的丢失和width的变化，而必须额外编写的程序
			cell.combobox('loadData', languageCodeCombo);
			cell.combobox({
				onSelect : s
			});
			cell.combobox({
				width : cell.parent().width()
			});

			// 语言名称的文本框
			var ed = datagrid.datagrid('getEditor', {
				index : 0,
				field : 'languageCode'
			});
			cellNBame =jq(ed.target).attr('disabled', true);

			// 默认语言的文本框
			/*var ed = datagrid.datagrid('getEditor', {
				index : 0,
				field : 'isSystemDefault'
			});
			jq(ed.target).attr('disabled', true);*/
		},
		format:function(value){
			if(value ==1){
				return '是';
			}
			return '否';
		},
		save:function(){
			datagrid.datagrid('endEdit',editIndex);
			var rows = datagrid.datagrid('getChanges');
			
			if(editIndex!=-1){
				jq.messager.alert('提示','不能保存，请确保上一条数据填写完整','warning');
				return;
			}
			if(rows.length <0){
				return;
			}
			var data =JSON.stringify(rows);
			$.ajax({
				 url:'platform/syslanguage/save',
				 data : {data : data},
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					if(r.flag==0){
						 datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						 jq.messager.show({
							 title : '提示',
							 msg : '保存成功'
						 });
						 reload();
					 }else{
						 jq.messager.show({
							 title : '提示',
							 msg : r.e
						 });
					 } 
				 }
			 });
		},
		del:function(){
			var rows = datagrid.datagrid('getChecked');
			var ids = [];
			var l =rows.length;
		  	if(l > 0){
		  		jq.messager.confirm('请确认','您确定要删除当前所选的数据？',function(b){
				 if(b){
					 for (;l--;){
						 ids.push(rows[l].id);
					 }
					 jq.ajax({
						 url:'platform/syslanguage/delete',
						 data:{data : JSON.stringify(ids)},
						 type : 'post',
						 dataType : 'json',
						 success : function(r){
							 if (r.flag == 0) {
								 datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
								 jq.messager.show({
									 title : '提示',
									 msg : '删除成功！'
								 });
								 reload();
							}else{
								jq.messager.show({
									 title : '提示',
									 msg : r.e
								 });
							}
						 }
					 });
				 } 
			  });
		  	}else{
		  		jq.messager.alert('提示','请选择要删除的记录！','warning');
		  	}
		}
	};
}($));
