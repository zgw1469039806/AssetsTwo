function bpm_RefreshTracks(entryId){
	if (!flowUtils.notNull(entryId)) {
		return;
	}
	$.ajax({
		type : "POST",
		data : {
			entryId : entryId
		},
		url : "platform/bpm/business/doGettracks",
		dataType : "JSON",
		success : function(data) {
			if (flowUtils.notNull(data.error)) {
				flowUtils.error(data.error);
			} else {
				var limit = data.textTrackLimit;//显示最大行数
				$(".bpm_tracks_list").empty();
				$.each(data.result.tracklist, function(i, tracks) {
					$.each(tracks, function(j, track) {
						if(j>=limit){
							var moreTr = $("<tr class='\" + tempClass + \"'></tr>");
							moreTr.append($("<td></td>"));
							moreTr.append($("<td></td>"));
							moreTr.append($("<td></td>"));
							moreTr.append($("<td></td>"));
							moreTr.append($("<td></td>"));
							moreTr.append($("<td></td>"));
							moreTr.append($("<td></td>"));
							var moreA = $("<a href='javascript:void(0)'>更多</a>")
							moreA.on("click",function () {
								var url = "bpm/business/openSearchTracks?processInstanceId="+track.processInstanceId+"&historyActivityInstanceId="+track.historyActivityInstanceId;
								layer.open({
									type: 2,
									title: '文字跟踪',
									skin: 'bs-modal',
									area: ['100%', '100%'],
									maxmin: false,
									content:url
								});
							});
							var moreTd = $("<td></td>");
							moreTd.append(moreA);
							moreTr.append(moreTd);
							$(".bpm_tracks_list").append(moreTr);
							return false;
						}
						var tempClass = "bpm_tracks_" + i;
						var tr = $("<tr></tr>");
						tr.addClass(tempClass);
						tr.hover(function() {
							$("." + tempClass).addClass("hover");
						}, function() {
							$("." + tempClass).removeClass("hover");
						});
						// 节点
						var td0 = $("<td></td>");
						td0.html(track.currentActiveLabel);
						var borderCss = null;
						if (tracks.length > 1) {
							if (j == 0) {
								td0.attr("rowspan", tracks.length>limit?(limit * 2):(tracks.length * 2 - 1));
								td0.addClass("merge");
							} else {
								td0 = null;
								// borderCss = "0px";
								$(".bpm_tracks_list").append($("<tr class='" + tempClass + "'></tr>"));
							}
						}

						tr.append(td0);
						// 处理人
						tr.append(bpm_createTd(track.assigneeName, borderCss));
						// 接收时间
						tr.append(bpm_createTd(track.iTime, borderCss));
						// 打开时间
						tr.append(bpm_createTd(track.oTime, borderCss));
						// 处理时间
						tr.append(bpm_createTd(track.eTime, borderCss));
						// 操作类型
						tr.append(bpm_createTd(track.opType, borderCss));
						// 累计时间
						tr.append(bpm_createTd(track.useTime, borderCss));
						// 目标接收人
						tr.append(bpm_createTd(track.targetuser, borderCss));
						// 处理意见
						tr.append(bpm_createTd(track.message, borderCss));
						$(".bpm_tracks_list").append(tr);
					});
				});

				var timelineData = {};
				timelineData.list = [];
				$.each(data.result.timelist, function(i, tracks) {
					var timeO = {};
					timeO.title = tracks[0].dayName;
					timeO.list = [];
					$.each(tracks, function(j, track) {
						var o = {};
						o.l = track.timeName;
						o.r = "<span style=\"color:#c426b3\">" + track.operateUserName + "</span>在<span style=\"color:#2d52df\">" + track.currentActiveLabel + "</span>节点进行了" + bpm_createOpTypeTd(track.opType) + "操作";
						if (flowUtils.notNull(track.targetuser)) {
							o.r += ",目标接收人是<span style=\"color:#c426b3\">" + track.targetuser + "</span>";
						}
						o.r += "<br/><i class='glyphicon glyphicon-pencil'></i><span style=\"color:#2d52df\">" + $.trim(track.message) + "</span>";
						timeO.list.push(o);
					});
					timelineData.list.push(timeO);
				});
				$('.time-line').timeliner({
					data : timelineData
				});
			}
		}
	});
}
function bpm_createTd(value, borderCss){
	var td = $("<td></td>");
	td.html(value);
	if (flowUtils.notNull(borderCss)) {
		td.css("border-top", borderCss);
	}
	return td;
}

function bpm_createOpTypeTd(opType){
	return "<span style=\"color:#49bd32\">" + opType + "</span>";
}