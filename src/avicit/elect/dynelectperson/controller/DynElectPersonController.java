package avicit.elect.dynelectperson.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import avicit.elect.dynelectperson.dto.DynElectPersonDTO;
import avicit.elect.dynelectperson.service.DynElectPersonService;
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
@RequestMapping("avicit/elect/dynElectPerson/dynElectPersonController")
public class DynElectPersonController implements LoaderConstant {
	private static final Logger LOGGER = LoggerFactory.getLogger(DynElectPersonController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;

	@Autowired
	private DynElectPersonService dynElectPersonService;

	/**
	 * 跳转到列表页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toDynElectPersonManage")
	public ModelAndView toDynElectPersonManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/elect/dynelectperson/DynElectPersonManage");
		mav.addObject("url", "platform/avicit/elect/dynElectPerson/dynElectPersonController/operation/");
		return mav;
	}

	/**
	 * 列表页面分页查询
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getDynElectPersonsByPage")
	@ResponseBody
	public Map<String, Object> togetDynElectPersonByPage(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<DynElectPersonDTO> queryReqBean = new QueryReqBean<DynElectPersonDTO>();
		queryReqBean.setPageParameter(pageParameter);
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		//字段查询条件
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
		//关联查询条件
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
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
			cloumnName = ComUtil.getColumn(DynElectPersonDTO.class, sidx);
			if (cloumnName != null) {
				//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(DynElectPersonDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(DynElectPersonDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		DynElectPersonDTO param = new DynElectPersonDTO();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<DynElectPersonDTO> result = null;
		if(pid == null || "".equals(pid)){
			pid = "-1";
		}
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<DynElectPersonDTO>() {
			});
			queryReqBean.setSearchParams(param);
		}
		param.setElectId(pid);
		param.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
		queryReqBean.setSearchParams(param);
		try {
			result = dynElectPersonService.searchDynElectPersonByPage(queryReqBean,orderBy,keyWord);
		} catch (Exception ex) {
			return map;
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		LOGGER.info("成功获取DynElectPersonDTO分页数据");
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
	@RequestMapping(value = "/operation/{type}/{id}/{pid}")
	public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String id, @PathVariable String pid, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		if (!"Add".equals(type)) {
			//编辑或详细页
			DynElectPersonDTO dto = dynElectPersonService.queryDynElectPersonByPrimaryKey(id);
			mav.addObject("dynElectPersonDTO", dto);
		}else{
			mav.addObject("pid", pid);
		}
		mav.setViewName("avicit/elect/dynelectperson/DynElectPerson" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param id 主键id
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveDynElectPerson(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			DynElectPersonDTO dynElectPersonDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<DynElectPersonDTO>() {
					});
			if (StringUtils.isEmpty(dynElectPersonDTO.getId())) {
				//新增
				dynElectPersonDTO.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
				String id = dynElectPersonService.insertDynElectPerson(dynElectPersonDTO);
				mav.addObject("id", id);
			} else {
				//修改
				dynElectPersonService.updateDynElectPersonSensitive(dynElectPersonDTO);
				mav.addObject("id", dynElectPersonDTO.getId());
			}
			mav.addObject("flag", OpResult.success);
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
	public ModelAndView toDeleteDynElectPerson(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			dynElectPersonService.deleteDynElectPersonByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/**
	 * 通用代码  radio checkbox
	 * @param request请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/getLookUpCode")
	public ModelAndView getLookUpCode(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			String appId = sysApplicationAPI.getCurrentAppId();
    		mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
		}
    	return mav;
    }
}

