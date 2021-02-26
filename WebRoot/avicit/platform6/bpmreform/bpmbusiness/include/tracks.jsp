<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style type="text/css">
.p1{
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 1;
	-webkit-box-orient: vertical;
}
</style>
<div class="panel-main workflow">
	<div class="btn-bar">
	</div>
	<div class="wf-cont">
		<div class="wf-title">
			<span>流程图</span>
			<div class="btns">
				<button type="button" class="btn btn-sm" id="bpmOpenForm" style="display:none;">
					<span class="glyphicon glyphicon-file">相关表单</span>
				</button>
				<button type="button" class="btn btn-sm" id="bpmParentFlowPic" style="display:none;">
					<span class="glyphicon glyphicon-search">父流程图</span>
				</button>
	            <i class="glyphicon glyphicon-unchecked uFlowKeyCss" style="color: rgb(64, 156, 233);"></i><span>已运行</span>
	            <i class="glyphicon glyphicon-unchecked uFlowKeyCss" style="color: rgb(237, 120, 55);"></i><span>运行中</span>
				<i class="glyphicon glyphicon-unchecked uFlowKeyCss" style="color: rgb(162, 162, 162);"></i><span>未运行</span>
				<div class="slideup">
					<i class="icon icon-jiantou-shang"></i>
				</div>
			</div>
		</div>
		<div class="wf-body fixdom">
			<div id="graph" style="width:100%;"></div>
			<!-- <iframe id="bpm_pic_iframe" style="height:175px;width:100%;overflow:hidden;"></iframe> -->
		</div>
	</div>
	<div class="wf-cont" id="showTrackDiv">
		<div class="wf-title">
			<span>文字跟踪</span>
			<div class="btns">
				<div class="switch">
					<div class="l on" for="timer">时间轴</div>
					<div class="r" for="list">列表</div>
				</div>
				<div class="slideup">
					<i class="icon icon-jiantou-shang"></i>
				</div>
			</div>
		</div>
		<div class="wf-body">
			<div class="switch-panel timer on">
				<!-- 时间轴视图 -->
				<div class="time-line"></div>
			</div>
			<div class="switch-panel list">
				<table class="table table-condensed avicTable">
					<thead>
						<tr>
							<td width="8%">节点</td>
							<td width="5%">处理人</td>
							<td width="13%">接收时间</td>
							<td width="13%">打开时间</td>
							<td width="13%">处理时间</td>
							<td width="8%">操作类型</td>
							<td width="12%">累计时间</td>
							<td width="10%">目标接收人</td>
							<td width="18%">处理意见</td>
						</tr>
					</thead>
					<tbody class="bpm_tracks_list">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>