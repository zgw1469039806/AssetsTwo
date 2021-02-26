package avicit.assets.device.usertreejson.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.api.application.SysApplicationAPI;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;

import avicit.assets.device.usertreejson.dto.UserTreeJsonDTO;
import avicit.assets.device.usertreejson.service.UserTreeJsonService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com @创建时间： 2020-06-05 10:55
 * @类说明：请填写 @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/usertreejson/userTreeJsonController")
public class UserTreeJsonController implements LoaderConstant {
	private static final Logger LOGGER = LoggerFactory.getLogger(UserTreeJsonController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private UserTreeJsonService userTreeJsonService;

	/**
	 * 跳转到管理页面
	 * 
	 * @param request
	 *            请求
	 * @param reponse
	 *            响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toUserTreeJsonManage")
	public ModelAndView toUserTreeJsonManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/usertreejson/UserTreeJsonManage");
		request.setAttribute("url", "platform/assets/device/usertreejson/userTreeJsonController/operation/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * 
	 * @param pageParameter
	 *            查询条件
	 * @param request
	 *            请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getUserTreeJsonsByPage")
	@ResponseBody
	public Map<String, Object> togetUserTreeJsonByPage(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<UserTreeJsonDTO> queryReqBean = new QueryReqBean<UserTreeJsonDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");// 字段查询条件
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");// 排序方式
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");// 排序字段
		if (!"".equals(keyWord)) {
			json = keyWord;
		}
		String oderby = "";
		if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
			String cloumnName = ComUtil.getColumn(UserTreeJsonDTO.class, sidx);
			if (cloumnName != null) {
				oderby = " " + cloumnName + " " + sord;
			}
		}

		UserTreeJsonDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<UserTreeJsonDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<UserTreeJsonDTO>() {
			});
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = userTreeJsonService.searchUserTreeJsonByPageOr(queryReqBean, oderby);
			} else {
				result = userTreeJsonService.searchUserTreeJsonByPage(queryReqBean, oderby);
			}
		} catch (Exception ex) {
			return map;
		}

		for (UserTreeJsonDTO dto : result.getResult()) {

		}

		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		LOGGER.info("成功获取UserTreeJsonDTO分页数据");
		return map;
	}

	/**
	 * 根据id选择跳转到新建页还是编辑页
	 * 
	 * @param type
	 *            操作类型新建还是编辑
	 * @param id
	 *            编辑数据的id
	 * @param request
	 *            请求
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation/{type}/{id}")
	public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String id, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		if (!"null".equals(id)) {// 编辑窗口或者详细页窗口
			// 主表数据
			// LogBase logBase = LogBaseFactory.getLogBase(request);
			UserTreeJsonDTO dto = userTreeJsonService.queryUserTreeJsonByPrimaryKey(id);

			mav.addObject("userTreeJsonDTO", dto);
		}
		mav.setViewName("avicit/assets/device/usertreejson/" + "UserTreeJson" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * 
	 * @param id
	 *            主键id
	 * @param request
	 *            请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveUserTreeJsonDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			UserTreeJsonDTO userTreeJsonDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<UserTreeJsonDTO>() {
					});
			if ("".equals(userTreeJsonDTO.getId())) {// 新增
				userTreeJsonService.insertUserTreeJson(userTreeJsonDTO);
			} else {// 修改
				userTreeJsonService.updateUserTreeJsonSensitive(userTreeJsonDTO);
			}
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;

	}

	/**
	 * 按照id批量删除数据
	 * 
	 * @param ids
	 *            id数组
	 * @param request
	 *            请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
	public ModelAndView toDeleteUserTreeJsonDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			// LogBase logBase = LogBaseFactory.getLogBase( request);
			userTreeJsonService.deleteUserTreeJsonByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
}
