package avicit.elect.dynelect.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.elect.dynelectperson.dto.DynElectPersonDTO;
import avicit.elect.dynelectperson.service.DynElectPersonService;
import avicit.elect.dynpersons.dto.DynPersonsDTO;
import avicit.elect.dynpersons.service.DynPersonsService;
import org.hibernate.validator.internal.util.logging.Log_$logger;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang.StringUtils;
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

import avicit.elect.dynelect.dto.DynElectDTO;
import avicit.elect.dynelect.service.DynElectService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：shiys
 * @邮箱：260289963@qq.com
 * @创建时间： 2021-02-05 00:18
 * @类说明：
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("avicit/elect/dynElect/dynElectController")
public class DynElectController implements LoaderConstant {
	private static final Logger LOGGER = LoggerFactory.getLogger(DynElectController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;

	@Autowired
	private DynElectService dynElectService;

	@Autowired
	private DynElectPersonService dynElectPersonService;

	@Autowired
	private DynPersonsService dynPersonsService;

	/**
	 * 跳转到列表页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toDynElectManage")
	public ModelAndView toDynElectManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/elect/dynelect/DynElectManage");
		mav.addObject("url", "platform/avicit/elect/dynElect/dynElectController/operation/");
		mav.addObject("dynElectPersonUrl", "platform/avicit/elect/dynElectPerson/dynElectPersonController/operation/");
		return mav;
	}

	/**
	 * 列表页面分页查询
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getDynElectsByPage")
	@ResponseBody
	public Map<String, Object> togetDynElectByPage(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<DynElectDTO> queryReqBean = new QueryReqBean<DynElectDTO>();
		queryReqBean.setPageParameter(pageParameter);
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		//字段查询条件
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
		//排序方式
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
		//排序字段
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");
		if (StringUtils.isNotEmpty(keyWord)) {
			json = keyWord;
		}
		String orderBy = "";
		String cloumnName = "";
		if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
			cloumnName = ComUtil.getColumn(DynElectDTO.class, sidx);
			if (cloumnName != null) {
				//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(DynElectDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(DynElectDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		DynElectDTO param = new DynElectDTO();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<DynElectDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<DynElectDTO>() {
			});
			queryReqBean.setSearchParams(param);
		}
		param.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
		try {
			result = dynElectService.searchDynElectByPage(queryReqBean,orderBy,keyWord);
		} catch (Exception ex) {
			return map;
		}
		for (DynElectDTO dto : result.getResult()) {
			dto.setStatusName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("elect_status", dto.getStatus(),sysApplicationAPI.getCurrentAppId()));
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		LOGGER.info("成功获取DynElectDTO分页数据");
		return map;
	}

	/**
	* 根据传入的的类型跳转到对应页面
	* @param type，包括三个值，分别是Add:新建；Edit：编辑；Detail：详情
	* @param id 数据的id
	* @param request 请求
	* @return ModelAndView
	* @throws Exception
	*/
	@RequestMapping(value = "/operation/{type}/{id}")
	public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String id, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		if (!"Add".equals(type)) {
			//编辑窗口或者详细页窗口
			DynElectDTO dto = dynElectService.queryDynElectByPrimaryKey(id);
			dto.setStatusName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("elect_status", dto.getStatus(),sysApplicationAPI.getCurrentAppId()));
			mav.addObject("dynElectDTO", dto);
		}
		mav.setViewName("avicit/elect/dynelect/DynElect" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveDynElect(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			DynElectDTO dynElectDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<DynElectDTO>() {
					});
			if (StringUtils.isEmpty(dynElectDTO.getId())) {
				//新增
				dynElectDTO.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
				String id = dynElectService.insertDynElect(dynElectDTO);
				mav.addObject("id", id);

				/*生成本轮选举的“选举—候选人”——开始*/
				//获取“候选”状态的候选人
				DynPersonsDTO searchParams = new DynPersonsDTO();
				searchParams.setStatus("0");	//候选状态

				List<DynPersonsDTO> personList = dynPersonsService.searchDynPersons(searchParams);

				//生成本轮选举的“选举—候选人”
				for(DynPersonsDTO dynPersonsDTO : personList){
					DynElectPersonDTO dynElectPersonDTO = new DynElectPersonDTO();

					dynElectPersonDTO.setOrgIdentity("ORG_ROOT");

					//设置选举信息
					dynElectPersonDTO.setElectId(dynElectDTO.getId());
					dynElectPersonDTO.setElectName(dynElectDTO.getName());
					dynElectPersonDTO.setRuleDesc(dynElectDTO.getRuleDesc());

					//设置选举人信息
					dynElectPersonDTO.setPersonId(dynPersonsDTO.getId());
					dynElectPersonDTO.setPersonName(dynPersonsDTO.getName());
					dynElectPersonDTO.setPersonDeptName(dynPersonsDTO.getDeptName());
					dynElectPersonDTO.setMajor(dynPersonsDTO.getMajor());
					dynElectPersonDTO.setIfMark(dynPersonsDTO.getIfMark());
					//dynElectPersonDTO.setAtt03(dynPersonsDTO.getNo());
					dynElectPersonDTO.setNo(dynPersonsDTO.getNo());

					//保存“选举—候选人”
					dynElectPersonService.insertDynElectPerson(dynElectPersonDTO);
				}
				/*生成本轮选举的“选举—候选人”——结束*/
			} else {
				//修改
				DynElectDTO oldFto = dynElectService.queryDynElectByPrimaryKey(dynElectDTO.getId());

				dynElectService.updateDynElectSensitive(dynElectDTO);
				mav.addObject("id", dynElectDTO.getId());

				/*更新本轮选举的“选举—候选人”——开始*/
				//if(!oldFto.getName().equals(dynElectDTO.getName()) || !oldFto.getRuleDesc().equals(dynElectDTO.getRuleDesc())){
				if(!oldFto.getName().equals(dynElectDTO.getName())){
					DynElectPersonDTO searchParams = new DynElectPersonDTO();
					searchParams.setElectId(dynElectDTO.getId());	//选举id

					List<DynElectPersonDTO> dynElectPersonDTOList = dynElectPersonService.searchDynElectPerson(searchParams);
					for(DynElectPersonDTO dynElectPersonDTO : dynElectPersonDTOList){
						//设置选举信息
						dynElectPersonDTO.setElectName(dynElectDTO.getName());
						dynElectPersonDTO.setRuleDesc(dynElectDTO.getRuleDesc());

						//更新“选举—候选人”
						dynElectPersonService.updateDynElectPersonSensitive(dynElectPersonDTO);
					}
				}
				/*更新本轮选举的“选举—候选人”——结束*/
			}
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			System.out.println(ex);
			LOGGER.error("异常信息：",ex);
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
	public ModelAndView toDeleteDynElect(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			dynElectService.deleteDynElectByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	@RequestMapping(value = "/operation/checkStatus", method = RequestMethod.GET)
	public ModelAndView checkStatus(){
		ModelAndView mav = new ModelAndView();
		List<DynElectDTO> list=new ArrayList<DynElectDTO>();
		try {
			list=dynElectService.searchDynElectByStatus();
			if (0==list.size()){
				mav.addObject("status", 0);
			}else {
				mav.addObject("status", 1);
			}
		}catch (Exception ex){
			mav.addObject("flag", OpResult.failure);
		}
		mav.addObject("flag", OpResult.success);
		return mav;
	}
}

