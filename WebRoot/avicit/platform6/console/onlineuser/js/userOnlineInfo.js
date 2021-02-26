$(function() {
	var locat = (window.location+'').split('/'); 
	if('tool'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};


	var myChart = echarts.init(document.getElementById('main'));
	var now = new Date();
	var res = [];
	var len = 30;
	function formatDate(datetime){
		if(datetime){
		    var hour = datetime.getHours()< 10 ? "0" + datetime.getHours() : datetime.getHours();  
		    var minute = datetime.getMinutes()< 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();  
		    var second = datetime.getSeconds()< 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();  
			return  hour+":"+minute+":"+second;
		}
		return '';
	}
	while (len--) {
		var time = formatDate(now);
		res.unshift(time);
		now = new Date(now - 30000);
	}
	var arr = [];
	option = {
		legend : {
			data : [ '在线用户人数']
		},
		grid : {
			x : 40,
			y : 30,
			x2 : 10,
			y2 : 45,
			borderWidth : 0,
			borderColor : "#FFFFFF"
		},
		xAxis : [ {
			axisLabel : {
				rotate : 40
			},
			type : 'category',// 坐标轴类型，横轴默认为类目型'category'，纵轴默认为数值型'value'
			data : res
		} ],
		yAxis : [ {
			axisLabel : {
				formatter : '{value}'
			}
		} ],
		series : [
				{
					name : '在线用户人数',
					type : 'line',
					data : (function(){
						/*var init = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
						if(arr.length > 0 && arr.length < 12){
							
						}else if(arr.length <= 0){
							return init;
						}*/
						var init = [];
						$.ajax({
							type : "POST",
							url : "platform/onlineuser/h5OnlineUserController/getOnlineUserTotal",
							async : false,
							dataType : 'json',
							success : function(json) {
								var total = 0;
								if(json.total != undefined){
									total = json.total;
									for(var i = 0; init.length < 30;i++){
										init[i] = total;
									}
								}
							}
						});
						return init;
					})()
				}]
	};
	myChart.setOption(option);
	$(window).resize(function() {
	  	myChart.resize();
	});
	var axisData;
	clearInterval(timeTicket);
	var timeTicket = setInterval(function() {
		axisData = new Date();
		axisData = formatDate(axisData);
		$.ajax({
			type : "POST",
			url : "platform/onlineuser/h5OnlineUserController/getOnlineUserTotal",
			async : false,
			dataType : 'json',
			success : function(json) {
				var total = 0;
				if(json.total != undefined){
					total = json.total;
				}
				// 动态数据接口 addData
				myChart.addData([ [ 0, // 系列索引
				total, // 新增数据
				false, // 新增数据是否从队列头部插入
				false, // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
				axisData
				]]);
			}
		});
	}, 30000);
	
});