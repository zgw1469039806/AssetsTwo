<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="panel-main">
	<div class="ac-btn" id="bpm_files_add" style="padding:0px;width:100px;">
		选择文件
	</div>
	<div class="ac-btn" id="bpm_files_upload" style="padding:0px 0px 3px 0px;width:100px; background-color:#FFF">
		<div class="webuploader-pick">
			开始上传
		</div>
	</div>
	<table class="table table-condensed avicTable">
		<thead>
			<tr>
				<td>文档名称</td>
				<td width="120px;">密级</td>
				<td width="120px;">创建人</td>
				<td width="120px;">创建时间</td>
				<td width="80px;">操作</td>
				<td width="120px;">状态</td>
			</tr>
		</thead>
		<tbody id="bpm_files_div">
		</tbody>
	</table>
</div>