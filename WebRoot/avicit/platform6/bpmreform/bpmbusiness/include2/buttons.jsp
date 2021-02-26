<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ page import="avicit.platform6.bpmreform.bpmbusiness.service.BusinessService" %>
<%@ page import="avicit.platform6.api.bpmbusiness.vo.BpmButtonExt" %>
<%@ page import="java.util.*" %>
<%@ page import="avicit.platform6.core.spring.SpringFactory" %>
<%@ page import="avicit.platform6.api.bpmbusiness.vo.BpmTabs" %>
<%@ page import="avicit.platform6.api.session.SessionHelper" %>
<%@ page import="avicit.platform6.core.redisCacheManager.CacheHelper" %>
<%@ page import="avicit.platform6.api.sysprofile.SysProfileAPI" %>
<%
    String bpm_entryId = request.getParameter("entryId");
    String bpm_executionId = request.getParameter("executionId");
    String bpm_taskId = request.getParameter("taskId");
    String bpm_formId = request.getParameter("id");

    BusinessService businessService = SpringFactory.getBean(BusinessService.class);
    List<BpmButtonExt> bpmButtonExts = businessService.getBpmButtonList();
    bpmButtonExts = businessService.getBpmButtonListBySelf(bpmButtonExts, bpm_entryId, bpm_executionId, bpm_taskId, bpm_formId, SessionHelper.getLoginSysUserId(request));

    List<BpmTabs> bpmTabs = businessService.getBpmTabs(SessionHelper.getLoginSysUserId(request));
    String type = CacheHelper.getInstance().get("BPMNAVBAR_" + SessionHelper.getLoginSysUserId(request));
    if (type == null || type.equals("")) {
        SysProfileAPI sysProfileAPI = SpringFactory.getBean(SysProfileAPI.class);
        String result = sysProfileAPI.getProfileValueByCodeByAppId("PLATFORM_V6_BPMNAVBARTYPE", SessionHelper.getApplicationId());
        if (result == null || result.equals("")) {
            type = "1";
        } else {
            type = result;
        }
    }
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
    var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
<div id="main">
    <div class="top-head">
        <div id="top-tool">
            <div class="top-logo">
                <div class="switch">
                    <%
                        if (type.equals("1")) {
                    %>
                    <em title="隐藏快速导航条"></em>
                    <%
                    } else {
                    %>
                    <em title="显示快速导航条" class="type2"></em>
                    <%
                        }
                    %>

                    <span></span>
                </div>
            </div>
            <div class="top-btns">
                <ul>
                    <%
                        for (BpmButtonExt button : bpmButtonExts) {
                            if (button.getCode().endsWith("_mesh")) {
                    %>
                    <li class="had-sublist bpmhide" id="<%=button.getCode()%>" style="display: none;"
                        label-template="<%=button.getName() != null && !button.getName().equals("") ? button.getName() : button.getdName()%>">
                        <a class="hs-title" href="javascript:void(0)" title="<%=button.getName() != null && !button.getName().equals("") ? button.getName() : button.getdName()%>"><em
                                class="<%=button.getIcon()!=null&&!button.getIcon().equals("")?button.getIcon():"glyphicon glyphicon-pencil"%>"></em><span><%=button.getName() != null && !button.getName().equals("") ? button.getName() : button.getdName()%><i
                                class="open-list"></i></span>
                        </a>
                        <ul class="sub-list">
                        </ul>
                    </li>
                    <%
                    } else {
                    %>
                    <li id="<%=button.getCode()%>"
                        class="bpmhide <%=button.getIsPlatform().equals("0")?"_attribute":""%>"
                        _function="<%=button.getJsfunction()%>" style="display: none;"
                        label-template="<%=button.getName() != null && !button.getName().equals("") ? button.getName() : button.getdName()%>">
                        <a href="javascript:void(0)" title="<%=button.getName() != null && !button.getName().equals("") ? button.getName() : button.getdName()%>">
                            <em class="<%=button.getIcon()!=null&&!button.getIcon().equals("")?button.getIcon():"glyphicon glyphicon-pencil"%>"></em><span><%=button.getName() != null && !button.getName().equals("") ? button.getName() : button.getdName()%></span>
                        </a>
                    </li>
                    <%
                            }
                        }
                    %>
                    <li class="had-sublist more-list last bpmhide" style="display: none;">
                        <a class="hs-title" href="javascript:void(0)">
                            <em class="glyphicon glyphicon-option-horizontal"></em><span>更多<i
                                class="open-list"></i></span>
                        </a>
                        <ul class="sub-list b">
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="top-lock-box">
                <a href="javascript:void(0)" onclick="changeLock()">
                    <div id="top_lock_unlock" class="top-unlock-icon" style="display: none;">
                        <i class="glyphicon glyphicon-pushpin"></i>
                        <%--<svg viewBox="64 64 896 896" data-icon="unlock" width="1em" height="1em" fill="currentColor" aria-hidden="true" focusable="false" class=""><path d="M832 464H332V240c0-30.9 25.1-56 56-56h248c30.9 0 56 25.1 56 56v68c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8v-68c0-70.7-57.3-128-128-128H388c-70.7 0-128 57.3-128 128v224h-68c-17.7 0-32 14.3-32 32v384c0 17.7 14.3 32 32 32h640c17.7 0 32-14.3 32-32V496c0-17.7-14.3-32-32-32zm-40 376H232V536h560v304zM484 701v53c0 4.4 3.6 8 8 8h40c4.4 0 8-3.6 8-8v-53a48.01 48.01 0 1 0-56 0z"></path>
                        </svg>--%>
                    </div>
                    <div id="top_lock_lock" class="top-lock-icon">
                        <i class="glyphicon glyphicon-pushpin"></i>
                        <%--<svg viewBox="64 64 896 896" data-icon="lock" width="1em" height="1em" fill="currentColor" aria-hidden="true" focusable="false" class=""><path d="M832 464h-68V240c0-70.7-57.3-128-128-128H388c-70.7 0-128 57.3-128 128v224h-68c-17.7 0-32 14.3-32 32v384c0 17.7 14.3 32 32 32h640c17.7 0 32-14.3 32-32V496c0-17.7-14.3-32-32-32zM332 240c0-30.9 25.1-56 56-56h248c30.9 0 56 25.1 56 56v224H332V240zm460 600H232V536h560v304zM484 701v53c0 4.4 3.6 8 8 8h40c4.4 0 8-3.6 8-8v-53a48.01 48.01 0 1 0-56 0z"></path>
                        </svg>--%>
                    </div>
                </a>
            </div>
        </div>
        <div id="navHeight" class="nav-height" <%=!type.equals("1") ? "style='display:none'" : ""%>>
            <div class="nav-seting">
                <div class="setting-btn"></div>
            </div>
            <div id="nav-wrap" class="nav-wrap">
                <ul class="clearfix">
                    <%
                        int i = 0;
                        for (BpmTabs bpmTab : bpmTabs) {
                            if (bpmTab.getDisplay().equals("1")) {
                                i++;
                            }
                    %>
                    <li id="<%=bpmTab.getCode()%>-nav" <%=!bpmTab.getDisplay().equals("1") ? "style='display:none'" : ""%>>
                        <a class="<%=i==1?"active":""%>"
                           href="#<%=bpmTab.getCode()%>"><%=bpmTab.getName()%>
                        </a></li>
                    <%}%>
                </ul>
            </div>
            <div class="nav-role">
                <p></p>
            </div>
        </div>
    </div>
    <div class="nav-body">
        <%for (BpmTabs bpmTab : bpmTabs) {%>
        <%if (bpmTab.getCode().equals("bpm_form_tab")) {%>
        <div id="bpm_form_tab"
             class="section-content" <%=!bpmTab.getDisplay().equals("1") ? "style='display:none'" : ""%>>
            <div class="section-title">文本内容</div>
            <div class="section-iframe" id="formTabParent">
            </div>
        </div>
        <%} else if (bpmTab.getCode().equals("bpm_idea_tab")) {%>
        <div id="bpm_idea_tab"
             class="section-content" <%=!bpmTab.getDisplay().equals("1") ? "style='display:none'" : ""%>>
            <div class="section-title">流程意见</div>
            <div class="section-iframe">
                <table class="pslist-table">
                    <colgroup>
                        <col width="30">
                        <col width="70">
                    </colgroup>
                    <tbody class="pslist-text pttable" id="ideaDiv">
                    </tbody>
                </table>
            </div>
        </div>
        <%} else if (bpmTab.getCode().equals("bpm_pic_tab")) {%>
        <div id="bpm_pic_tab"
             class="section-content" <%=!bpmTab.getDisplay().equals("1") ? "style='display:none'" : ""%>>
            <div class="section-title">流程跟踪</div>
            <div class="section-iframe">
                <div id="graph"></div>
            </div>
        </div>
        <%}%>
        <%}%>
        <div style="height: 600px;background: #eee;"></div>
    </div>
</div>

<div id="setting-panel" class="setting-panel">
    <div class="p-title">模块显示管理<span>拖动名称可排序</span></div>
    <div class="p-list-head">
        <table class="plist-table">
            <colgroup>
                <col width="50">
                <col width="100">
                <col width="50">
            </colgroup>
            <thead>
            <tr>
                <th>显示</th>
                <th>名称</th>
                <th>顺序</th>
            </tr>
            </thead>
        </table>
    </div>

    <div class="p-list">
        <table class="plist-table">
            <tbody id="drag-list-1" class="plist-text">

            <%
                int j = 1;
                for (BpmTabs bpmTab : bpmTabs) {
            %>
            <tr title="拖动排序">
                <td class="f">
                    <div class="l-radio <%=bpmTab.getDisplay().equals("1")||bpmTab.getCode().equals("bpm_form_tab")?"checked":""%> <%=bpmTab.getCode().equals("bpm_form_tab")?"disabled":""%>"
                         data-for="<%=bpmTab.getCode()%>"></div>
                </td>
                <td class="m"><%=bpmTab.getName()%>
                </td>
                <td class="l"><%=j%>
                </td>
            </tr>
            <%
                    j++;
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<div id="help-panel" class="help-panel">
</div>
