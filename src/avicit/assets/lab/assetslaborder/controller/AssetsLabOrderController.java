package avicit.assets.lab.assetslaborder.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.JsonObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang3.StringUtils;
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
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.lab.assetslaborder.dto.AssetsLabOrderDTO;
import avicit.assets.lab.assetslaborder.service.AssetsLabOrderService;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 15:34
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/lab/assetslaborder/assetsLabOrderController")
public class AssetsLabOrderController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsLabOrderController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsLabOrderService assetsLabOrderService;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsLabOrderManage")
	public ModelAndView toAssetsLabOrderManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/lab/assetslaborder/AssetsLabOrderManage");
		mav.addObject("url", "platform/assets/lab/assetslaborder/assetsLabOrderController/operation/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation/getAssetsLabOrdersByPage")
	@ResponseBody
	public Map<String, Object> togetAssetsLabOrderByPage(PageParameter pageParameter, HttpServletRequest request)
			throws Exception {
		QueryReqBean<AssetsLabOrderDTO> queryReqBean = new QueryReqBean<AssetsLabOrderDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");
		if (!StringUtils.isEmpty(keyWord)) {
			json = keyWord;
		}

		String orderBy = "";
		String cloumnName = "";
		if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
			cloumnName = ComUtil.getColumn(AssetsLabOrderDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsLabOrderDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsLabOrderDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}

		AssetsLabOrderDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsLabOrderDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsLabOrderDTO>() {
			});
		} else {
			param = new AssetsLabOrderDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);

		try {
			if (!"".equals(keyWord)) {//根据keyWord条件查询时走or
				result = assetsLabOrderService.searchAssetsLabOrderByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsLabOrderService.searchAssetsLabOrderByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsLabOrderDTO dto : result.getResult()) {

			dto.setApplyIdAlias(sysUserLoader.getSysUserNameById(dto.getApplyId()));

			dto.setApplyDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplyDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setTestType(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("TEST_TYPE", dto.getTestType(),
					sysApplicationAPI.getCurrentAppId()));

			dto.setTestNature(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("TEST_NATURE",
					dto.getTestNature(), sysApplicationAPI.getCurrentAppId()));

		}

		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsLabOrderDTO分页数据");
		return map;
	}

	/**
	* 根据id选择跳转到新建页还是编辑页
	* @param type 操作类型新建还是编辑
	* @param id 编辑数据的id
	* @param request 请求
	* @return ModelAndView
	* @throws Exception
	*/
	@RequestMapping(value = "/operation/{type}/{id}")
	public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String id, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
			//主表数据
			AssetsLabOrderDTO dto = assetsLabOrderService.queryAssetsLabOrderByPrimaryKey(id);

			dto.setApplyIdAlias(sysUserLoader.getSysUserNameById(dto.getApplyId()));
			dto.setApplyDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplyDept(),
					SessionHelper.getCurrentLanguageCode()));

			mav.addObject("assetsLabOrderDTO", dto);
			mav.addObject("id", id);
		}
		mav.setViewName("avicit/assets/lab/assetslaborder/" + "AssetsLabOrder" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsLabOrderDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		String returnId = "";
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		try {
			AssetsLabOrderDTO assetsLabOrderDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<AssetsLabOrderDTO>() {
					});
			if (StringUtils.isEmpty(assetsLabOrderDTO.getId())) {//新增
				returnId = assetsLabOrderService.insertAssetsLabOrder(assetsLabOrderDTO);
			} else {//修改
				returnId = assetsLabOrderDTO.getId();
				assetsLabOrderService.updateAssetsLabOrderSensitive(assetsLabOrderDTO);
			}
			mav.addObject("flag", OpResult.success);
			mav.addObject("id", returnId);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/**
	 * 按照id批量删除数据
	 * @param ids id数组
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
	public ModelAndView toDeleteAssetsLabOrderDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsLabOrderService.deleteAssetsLabOrderByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/**
	 * 新增并启动流程
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/saveAndStartProcess", method = RequestMethod.POST)
	public ModelAndView saveAndStartProcess(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		String processDefId = ServletRequestUtils.getStringParameter(request, "processDefId", "");
		String formCode = ServletRequestUtils.getStringParameter(request, "formCode", "");
		String jsonString = ServletRequestUtils.getStringParameter(request, "jsonString", "");
		String data = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			AssetsLabOrderDTO assetsLabOrder = JsonHelper.getInstance().readValue(data, dateFormat,
					new TypeReference<AssetsLabOrderDTO>() {
					});
			String userId = SessionHelper.getLoginSysUserId(request);
			String deptId = SessionHelper.getCurrentDeptId(request);
			/////////////////启动流程所需要的参数///////////////////
			Map<String, Object> parameter = new HashMap<String, Object>();
			parameter.put("processDefId", processDefId);
			parameter.put("formCode", formCode);
			parameter.put("jsonString", jsonString);
			parameter.put("userId", userId);
			parameter.put("deptId", deptId);
			StartResultBean result = assetsLabOrderService.insertAssetsLabOrderAndStartProcess(assetsLabOrder,
					parameter);

			mav.addObject("flag", OpResult.success);
			mav.addObject("startResult", result);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
		}
		return mav;
	}

	/**
	* 跳转detail页面
	* @param request 求情
	* @return ModelAndView
	* @throws Exception
	*/
	@RequestMapping("/toDetailJsp")
	public ModelAndView toDetailJsp(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		String id = request.getParameter("id");
		AssetsLabOrderDTO dto = assetsLabOrderService.queryAssetsLabOrderByPrimaryKey(id);

		dto.setApplyIdAlias(sysUserLoader.getSysUserNameById(dto.getApplyId()));

		dto.setApplyDeptAlias(
				sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplyDept(), SessionHelper.getCurrentLanguageCode()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("assetsLabOrderDTO", dto);
		return mav;
	}

	/**
	 * 生成指定设备预约流程的json数据
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation/getOrderList", method = RequestMethod.POST)
	@ResponseBody
	public String getOrderList(@RequestBody Map<String, String> map, HttpServletRequest request) throws Exception {
		String orderListJson = "";
		String labDeviceId = map.get("labDeviceId");
		if(labDeviceId==""|| labDeviceId.equals("") || labDeviceId == null){
			return orderListJson;
		}
		QueryReqBean<AssetsLabOrderDTO> queryReqBean = new QueryReqBean<AssetsLabOrderDTO>();
		PageParameter pageParameter = new PageParameter(1,999999);
		queryReqBean.setPageParameter(pageParameter);

		JSONObject jsonObj = new JSONObject();
		//筛选预约流程：条件为实验室设备id和预约流程状态
		jsonObj.put("labDeviceId", labDeviceId);
		jsonObj.put("businessstate_", "流转中");
		String json = jsonObj.toJSONString();

		AssetsLabOrderDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsLabOrderDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsLabOrderDTO>() {
			});
		} else {
			param = new AssetsLabOrderDTO();
		}

		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);

		try {
			result = assetsLabOrderService.searchAssetsLabOrderByPage(queryReqBean, "");
			JSONObject orderListJsonObj = new JSONObject();
			orderListJson += "[";
			for (int i = 0; i < result.getResult().size(); i++){
				AssetsLabOrderDTO dto = result.getResult().get(i);
				long diff = dto.getOrderFinishTime().getTime() - dto.getOrderStartTime().getTime();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String startTime = formatter.format(dto.getOrderStartTime());
				String finishTime = formatter.format(dto.getOrderFinishTime());

				orderListJsonObj.put("UID",dto.getId());//预约流程id
				orderListJsonObj.put("Name",dto.getOrderNumber());
				orderListJsonObj.put("Duration",diff/(1000 * 60 * 60 * 24));//天数
				orderListJsonObj.put("Start",startTime);
				orderListJsonObj.put("Finish",finishTime);
				orderListJsonObj.put("PercentComplete",0);
				orderListJsonObj.put("Summary",1);
				orderListJsonObj.put("Critical",0);
				orderListJsonObj.put("Milestone",0);
				//orderListJsonObj.put("PredecessorLink","[]");
				orderListJsonObj.put("ParentTaskUID","-1");
				orderListJsonObj.put("ActStart","2007-01-04T00:00:00");
				orderListJsonObj.put("ActFinish","2007-01-10T00:00:00");

				orderListJson += orderListJsonObj.toJSONString();
				if(i != result.getResult().size()-1){
					orderListJson += ",";
				}
			}
			orderListJson += "]";
		} catch (Exception ex) {
			return orderListJson;
		}
		return orderListJson;
	}

}
