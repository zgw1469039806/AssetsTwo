<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
	.btn-bar .webuploader-pick {
		background: #2fae95;
	}
	.btn-bar .webuploader-pick:hover {
		background: #17957c;
	}
</style>
<link rel="stylesheet" type="text/css"
	  href="avicit/platform6/bpmreform/bpmcommon/css/avictabs.css">
<div id="u101961" class="ax_default text_field" style="        position: absolute;
    left: 1461px;
    top: 17%;
    width: 400px;
    height: 40px;
    overflow: hidden;">
	<input id="u101961_input" class="form-control input-sm" style="width: 54%;" type="text" value="流程">
	<label id="formViewModel_searchPart" class="icon icon-search form-tool-searchicon" style="cursor:hand;    top: 7px;
    right: 189px;"></label>
	<div class="toolbar-left" style="position: absolute;
    top: 0px;
    right: 90px;">

		<a id="assetsUstdtempapplyProc_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>



	</div>
</div>
<div id="u102015" class="ax_default text_area" style="     position: absolute;
    left: 1461px;
    top: 17%;
    width: 400px;
    height: 322px;
    overflow: hidden;
    background-color: white;
    display: none;
">
              <textarea id="u102015_input" style="    position: absolute;
    left: 0px;
    top: 0px;
    width: 400px;
    height: 327px;
    font-family: 'Arial Normal', 'Arial';
    font-weight: 400;
    font-style: normal;
    font-size: 13px;
    text-decoration: none;
    color: #000000;
    text-align: left;
    border-color: transparent;
    outline-style: none;">一、定义

1、流程 一个或一系列有规律的活动，这些行动以确定的方式发生或执行，导致特定结果的实现。

2、关键流程 管理过程中涉及项目内容重大，职责划分跨越两个或两个以上部室，管理流程的履行需要部室之间的协调、沟通、配合才能完成的重要性流程。

3、流程管理 指从流程的角度切入，关注流程是否增值，从而形成认识流程、建立流程、运作流程、优化流程的体系，并在此基础上开始一个“再认识流程”的新的循环。同时有着流程描述、流程改进等一系列方法、技术与工具。

二、流程设计的原则

1、要从工作的目标而非工作的过程出发
1）工作目标是可衡量的
2）只有达到预期的工作目标，工作过程才是有意义的
3）如果只考虑工作过程中的活动，最多只能简化现有的过程

2、剔除对内部客户和外部客户不增值的活动，使企业对内部和外部客户反应速度加快

3、在工作的过程当中设置质量检查机制
1）质量控制是工作过程的一个部分，只有工作的成果符合质量标准，工作才告完成
2）对于任何工作，在工作过程中发现质量问题比在工作完成后的返工成本要低得多

4、使决策点尽可能靠近需进行决策的“点”做出，在决策点和实际工作点之间的时间延迟会导致工作进程的停止，造成成本增加

5、部门之间的沟通、决策和问题的解决应在直接参与作业的层面进行
1)凡事汇报给部门领导，由部门的领导进行沟通和解决问题的方式导致时间浪费和企业成本增加
2)部门领导对具体问题的了解比基层人员少
3)部门领导应该利用其经验给出适当的建议，而不是替基层人员做出决定
4）反复的上下沟通可能会带来信息的失真

6、尽可能使同一个人完成一项完整的工作（职责完整性原则）
1）完整的工作增加员工的工作积极性和成就感
2）完整的工作使得对员工的绩效评价有可衡量的依据
3）由一个人完成一项完整的工作减少了交接和重复工作

7、在工作过程中尽量减少交接的次数
1）工作过程中的交接对工作的结果不增加价值
2）大多数的工作过程中的问题是由交接引起的
3）大多数的工作交接引起扯皮的现象，导致时间延迟

8、在工作过程中建立绩效考核机制，对工作效果的评价和反馈以及必要的纠正是

</textarea>
</div>
<div class="panel-main" style="    border-width: 0px;
    position: absolute;
    left: 1461px;
    top: 22%;
    width: 400px;
    height: 100%;
    overflow: hidden;
    background-color: white;
">

	<div class="btn-bar" style="display: none">
		<div class="ac-btn inner" id="bpm_files_add" style="padding:0px;">
			<i class="fa fa-paperclip fa-fw"></i>选择文件
		</div>
		<div class="ac-btn inner" id="bpm_files_upload" style="padding:0px;">
			<div class="webuploader-pick">
				<i class="fa fa-upload fa-fw"></i>开始上传
			</div>
		</div>
	</div>
	<div style="height: 50%;">
		<table class="table table-condensed avicTable">
			<thead>
			<tr>
				<td width="120px;">文档名称</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="120px;">创建人</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;">操作</td>
				<%--				<td width="120px;">状态</td>--%>
			</tr>
			</thead>
			<tbody id="bpm_files_div">
			<tr>
				<td width="150px;">流程帮助文档1</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">柯嘉</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;"></td>
				<%--				<td width="120px;">状态</td>--%>
			</tr>
			<tr>
				<td width="150px;">流程帮助文档1</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">柯嘉</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;"> </td>
				<%--				<td width="120px;">状态</td>--%>
			</tr><tr>
				<td width="150px;">流程帮助文档1</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">柯嘉</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;"> </td>
				<%--				<td width="120px;">状态</td>--%>
			</tr>
			<tr>
				<td width="150px;">流程帮助文档1</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">柯嘉</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;"></td>
				<%--				<td width="120px;">状态</td>--%>
			</tr>
			<tr>
				<td width="150px;">流程帮助文档1</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">柯嘉</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;"> </td>
				<%--				<td width="120px;">状态</td>--%>
			</tr><tr>
				<td width="150px;">流程帮助文档1</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">柯嘉</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;"> </td>
				<%--				<td width="120px;">状态</td>--%>
			</tr>
			<tr>
				<td width="150px;">流程帮助文档1</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">柯嘉</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;"></td>
				<%--				<td width="120px;">状态</td>--%>
			</tr>
			<tr>
				<td width="150px;">流程帮助文档1</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">柯嘉</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;"> </td>
				<%--				<td width="120px;">状态</td>--%>
			</tr><tr>
				<td width="150px;">流程帮助文档1</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">柯嘉</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;"> </td>
				<%--				<td width="120px;">状态</td>--%>
			</tr>
			<tr>
				<td width="150px;">流程帮助文档1</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">柯嘉</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;"></td>
				<%--				<td width="120px;">状态</td>--%>
			</tr>
			<tr>
				<td width="150px;">流程帮助文档1</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">柯嘉</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;"> </td>
				<%--				<td width="120px;">状态</td>--%>
			</tr><tr>
				<td width="150px;">流程帮助文档1</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">柯嘉</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;"> </td>
				<%--				<td width="120px;">状态</td>--%>
			</tr>
			</tbody>
		</table>

	</div>
	<div style="height: 50%;">
		<table class="table table-condensed avicTable">
			<thead>
			<tr>
				<td width="150px;">文档名称</td>
				<%--				<td width="120px;">密级</td>--%>
				<td width="80px;">创建人</td>
				<%--				<td width="120px;">创建时间</td>--%>
				<td width="80px;">操作</td>
				<%--				<td width="120px;">状态</td>--%>
			</tr>

			</thead>
			<tbody id="bpm_files_div2">


			</tbody>
		</table>

	</div>
</div>