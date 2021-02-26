<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程自定义选人demo</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<h3 style="text-align:center;margin-top:20px;">流程自定义选人demo</h3>
		<hr style="height:1px;border:none;border-top:1px solid #555555;" />
		<p style="font-size:14px;">
			<pre>
				package avicit.platform6study.bpmdemo.task;

				import java.util.ArrayList;
				import java.util.List;
				
				import avicit.platform6.bpm.api.identity.Actor;
				import avicit.platform6.bpm.api.identity.Actors;
				import avicit.platform6.bpm.api.identity.UserSelect;
				import avicit.platform6.bpm.pvm.internal.task.actor.DeptLevelPositonActor;
				import avicit.platform6.bpm.pvm.internal.task.actor.GroupActor;
				import avicit.platform6.bpm.pvm.internal.task.actor.PositionActor;
				import avicit.platform6.bpm.pvm.internal.task.actor.RoleActor;
				import avicit.platform6.bpm.pvm.internal.task.actor.UserActor;
				import avicit.platform6.commons.utils.ComUtil;
				
				/**
				 * 类说明：节点选人关系中的自定义函数
				 */
				public class UserDefineFunction extends UserSelect {
				
					@Override
					public Actors getActors(Long processInstanceId, String executionId, String activityName,String startFormId,String loginUserId) {
						List<Actor> actorlist = new ArrayList<Actor>();
						
						//以下示例可根据自身需求返回一个或多个类型的用户，同一类型也可以返回多个
						
						//返回用户[石学远]
						Actor actor = new UserActor();
						actor.setId("40288af938989073013898b81e77000c");//用户ID
						actor.setName("石学远");//用户
						actor.setType("user");//类别
						actorlist.add(actor);
						
						//返回部门[研发中心]
						actor = new DeptLevelPositonActor();
						actor.setId("40288af5382c969e01382c9b830c000c");//部门ID
						actor.setName("研发中心");//部门
						actor.setType("dept");//类别
						actorlist.add(actor);
				
						//返回角色[系统管理员]
						actor = new RoleActor();
						actor.setId("40288a46384feb2101384fee0bd60004");//角色ID
						actor.setName("系统管理员");//角色
						actor.setType("role");//类别
						actorlist.add(actor);
						
						//返回群组[系统管理]
						actor = new GroupActor();
						actor.setId("40288afb38c276fb0138c2d3ffa30010");//群组ID
						actor.setName("系统管理");//群组
						actor.setType("group");//类别
						actorlist.add(actor);
						
						//返回岗位[普通员工a]
						actor = new PositionActor();
						actor.setId("40288af9386fe46a0138703716690006");//岗位ID
						actor.setName("普通员工a");//岗位
						actor.setType("position");//类别
						actorlist.add(actor);
						
						Actors actors = new Actors();
						actors.setActorlist(actorlist);
						actors.setId(ComUtil.getId());
						return actors;
					}
				}

			</pre>
		</p>
	</div>
</body>
</html>