function initFlowPic(defineId) {
	$("#graph").attr("src", "platform/bpm/bpmPublishAction/getProcessImageTrackByDefid.gif?defid=" + defineId);
}
function bpm_RefreshPic(entryId) {
	if (flowUtils.notNull(entryId)) {
		$("#graph").attr("src", "avicit/platform6/bpmfixie/bpmbusiness/include/ProcessTrackFixie.jsp?processInstanceId=" + entryId);
	}
}