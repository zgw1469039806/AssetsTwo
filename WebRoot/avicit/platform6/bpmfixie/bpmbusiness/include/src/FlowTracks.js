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
				$("#bpm_tracks_list").empty();
				$.each(data.result.tracklist, function(i, tracks) {
					$.each(tracks, function(j, track) {
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
								td0.attr("rowspan", tracks.length * 2 - 1);
								td0.addClass("merge");
							} else {
								td0 = null;
								// borderCss = "0px";
								$("#bpm_tracks_list").append($("<tr class='" + tempClass + "'></tr>"));
							}
						}

						tr.append(td0);
						// 处理人
						tr.append(bpm_createTd(track.assigneeName, borderCss));
						// 接收时间
						tr.append(bpm_createTd(track.iTime, borderCss));
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
						$("#bpm_tracks_list").append(tr);
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
						o.r = "<span style=\"color:#c426b3\">" + track.operateUserName + "</span>在<span style=\"color:#2d52df\">" + track.currentActiveLabel + "</span>节点进行了<span style=\"color:#49bd32\">" + track.opType + "</span>操作";
						if (flowUtils.notNull(track.targetuser)) {
							o.r += ",目标接收人是<span style=\"color:#c426b3\">" + track.targetuser + "</span>";
						}
						o.r += "<br/>意见：<span style=\"color:#2d52df\">" + $.trim(track.message) + "</span>";
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