<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String bpm_entryId = request.getParameter("entryId");
	String bpm_executionId = request.getParameter("executionId");
	String bpm_taskId = request.getParameter("taskId");
	String bpm_formId = request.getParameter("id");
	String bpm_defineId = request.getParameter("defineId");
%>
<script type="text/javascript">
var _bpm_entryId = "<%=bpm_entryId == null ? "" : bpm_entryId%>";
var _bpm_executionId = "<%=bpm_executionId == null ? "" : bpm_executionId%>";
var _bpm_taskId = "<%=bpm_taskId == null ? "" : bpm_taskId%>";
var _bpm_formId = "<%=bpm_formId == null ? "" : bpm_formId%>";
var _bpm_defineId = "${defineId}";
var _bpm_simulation = "${simulation}";
var _bpm_deploymentId = "${deploymentId}";
var _bpm_firstTaskName = "${firstTaskName}";
var _bpm_firstTaskAlias = "${firstTaskAlias}";
var _bpm_ideaCompelManner = "${ideaCompelManner}";
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
<div class="editFrom">
	<div class="info">
		<div class="info-ico" id="bpm_buttons_remark"></div>
		<div class="info-cont">
			<div class="info-title" id="bpm_buttons_title"></div>
			<div class="info-desc" id="bpm_buttons_desc"></div>
		</div>
	</div>
	<div class="cont">
		<div class="textDom" id="bpm_buttons_area">
			<div class="radio bpmhide bpm_compelManner_div" style="display:none;">
				<label> <input type="radio" name="bpm_compelManner" id="bpm_compelManner_yes" value="yes"> 同意
				</label>
				<label> <input type="radio" name="bpm_compelManner" id="bpm_compelManner_no" value="no"> 不同意
				</label>
			</div>
			<div class="titleBar bpmhide" >
				<div class="title" title="常用意见在个人设置中维护" style="width:85%;height:100%;">流程意见</div>
				<div class="menu icon icon-menu" title>
					<ul class="submenu" id="bpm_buttons_idealist">
					</ul>
					<input class="menuValue" type="hidden" value="0"></input>
				</div>
			</div>
			<div class="textArea bpmhide">
				<textarea name="info" data-len="4000" cols="30" rows="10" id="bpm_buttons_idea"></textarea>
				<div class="num">
					<span class="now">0</span>/<span class="limit"></span>
				</div>
			</div>
			<div class="bpmhide" id="bpm_buttons_idea_for_third"></div>
			<div class="btnBar">
				<div class="menuBtn pull-right bpmhide" id="bpm_buttons_more" style="display:none;">
					<span class="txt">更多</span><i class="icon icon-xiajiantou"></i>
					<div class="childMenu">
						<div class="cm-title"></div>
						<div class="cm-body">
							<div class="cm-l-title bpmhide" style="display:none;">将流程从下一节点拿回或向下一节点增加处理人</div>
							<div class="cm-l-body bpmhide" style="display:none;">
								<div class="cm-btn" id="bpm_withdraw">拿回</div>
								<div class="cm-btn" id="bpm_supplement">补发</div>
							</div>
							<div class="cm-l-title bpmhide" style="display:none;">将流程发送给他人传阅</div>
							<div class="cm-l-body bpmhide" style="display:none;">
								<div class="cm-btn" id="bpm_transmit">发送阅知</div>
							</div>
							<div class="cm-l-title bpmhide" style="display:none;">增加或减少本节点办理人</div>
							<div class="cm-l-body bpmhide" style="display:none;">
								<div class="cm-btn" id="bpm_adduser">加签</div>
								<div class="cm-btn" id="bpm_withdrawassignee">减签</div>
							</div>
							<div class="cm-l-title bpmhide" style="display:none;">将本待办转给其他人办理</div>
							<div class="cm-l-body bpmhide" style="display:none;">
								<div class="cm-btn" id="bpm_supersede">流程转办</div>
							</div>
							<div class="cm-l-title bpmhide" style="display:none;">其他权限</div>
							<div class="cm-l-body bpmhide" style="display:none;">
								<div class="cm-btn" id="bpm_globalend">流程结束</div>
								<div class="cm-btn" id="bpm_globalidea">意见修改</div>
								<div class="cm-btn" id="bpm_globaljump">流程跳转</div>
								<div class="cm-btn" id="bpm_globalresume">流程恢复</div>
								<div class="cm-btn" id="bpm_globalsuspend">流程暂停</div>
								<div class="cm-btn" id="bpm_stepuserdefined">自定义选人</div>
								<div class="cm-btn" id="bpm_taskreader">增加读者</div>
								<div class="cm-btn" id="bpm_presstodo">发送催办</div>
							</div>
						</div>
					</div>
				</div>
				<div class="dropdown loc pull-right" id="bpm_buttons_default2">
				</div>
				<div class="dropdown loc pull-right" id="bpm_buttons_default1">
				</div>
			</div>
		</div>
	</div>
</div>