<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="panel-main workflow">
	<div class="wf-cont">
		<div class="wf-title">
			<span>流程图</span>
			<div class="btns">
				<div class="slideup">
					<i class="icon icon-jiantou-shang"></i>
				</div>
			</div>
		</div>
		<div class="wf-body fixdom">
			<iframe style="height:300px;width:99%;" id="graph"></iframe>
		</div>
	</div>
	<div class="wf-cont">
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
							<td width="8%">处理人</td>
							<td width="14%">接收时间</td>
							<td width="14%">处理时间</td>
							<td width="8%">操作类型</td>
							<td width="12%">累计时间</td>
							<td width="18%">目标接收人</td>
							<td width="18%">处理意见</td>
						</tr>
					</thead>
					<tbody id="bpm_tracks_list">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>