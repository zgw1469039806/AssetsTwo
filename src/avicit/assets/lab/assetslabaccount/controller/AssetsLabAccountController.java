package avicit.assets.lab.assetslabaccount.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.platform6.api.syslookup.dto.SysLookupSimpleVo;
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
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.api.application.SysApplicationAPI;
import avicit.platform6.commons.utils.ComUtil;

import avicit.assets.lab.assetslabaccount.dto.AssetsLabAccountDTO;
import avicit.assets.lab.assetslabaccount.service.AssetsLabAccountService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-21 16:08
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/lab/assetslabaccount/assetsLabAccountController")
public class AssetsLabAccountController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsLabAccountController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsLabAccountService assetsLabAccountService;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsLabAccountManage")
	public ModelAndView toAssetsLabAccountManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/lab/assetslabaccount/AssetsLabAccountManage");
		mav.addObject("url", "platform/assets/lab/assetslabaccount/assetsLabAccountController/operation/");
		return mav;
	}

	/**
	* 分页查询方法
	* @param pageParameter 查询条件
	* @param request 请求
	* @return Map<String,Object>
	*/
	@RequestMapping(value = "/operation/getAssetsLabAccountsByPage")
	@ResponseBody
	public Map<String, Object> togetAssetsLabAccountByPage(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<AssetsLabAccountDTO> queryReqBean = new QueryReqBean<AssetsLabAccountDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");//关键字
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");
		if (!StringUtils.isEmpty(keyWord)) {
			json = keyWord;
		}
		String orderBy = "";
		String cloumnName = "";
		if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
			cloumnName = ComUtil.getColumn(AssetsLabAccountDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsLabAccountDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsLabAccountDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsLabAccountDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsLabAccountDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsLabAccountDTO>() {
			});
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {//根据keyWord查询的通过or查询
				result = assetsLabAccountService.searchAssetsLabAccountByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsLabAccountService.searchAssetsLabAccountByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}
		int index = 0;//列表序号
		for (AssetsLabAccountDTO dto : result.getResult()) {
			index++;//列表序号遍历
			dto.setMajorCategory(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MAJOR_TYPE",
					dto.getMajorCategory(), sysApplicationAPI.getCurrentAppId()));
			dto.setManageDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getManageDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setManagerIdAlias(sysUserLoader.getSysUserNameById(dto.getManagerId()));
			result.getResult().get(index - 1).setAttribute01("" + index);//用备用字段attribute01赋值并传递到前台
		}
		map.put("records", result.getPageParameter().getTotalCount());//总记录数
		map.put("page", result.getPageParameter().getPage()); //当前页
		map.put("total", result.getPageParameter().getTotalPage()); //总页数
		map.put("rows", result.getResult()); //数据
		logger.info("成功获取AssetsLabAccountDTO分页数据");
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
			AssetsLabAccountDTO dto = assetsLabAccountService.queryAssetsLabAccountByPrimaryKey(id);
			dto.setManageDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getManageDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setManagerIdAlias(sysUserLoader.getSysUserNameById(dto.getManagerId()));
			mav.addObject("assetsLabAccountDTO", dto);
		}
		mav.setViewName("avicit/assets/lab/assetslabaccount/" + "AssetsLabAccount" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsLabAccountDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String returnId = "";
		try {
			AssetsLabAccountDTO assetsLabAccountDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<AssetsLabAccountDTO>() {
					});
			if (StringUtils.isEmpty(assetsLabAccountDTO.getId())) {//新增
				returnId = assetsLabAccountService.insertAssetsLabAccount(assetsLabAccountDTO);
			} else {//修改
				returnId = assetsLabAccountDTO.getId();
				assetsLabAccountService.updateAssetsLabAccountSensitive(assetsLabAccountDTO);
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
	public ModelAndView toDeleteAssetsLabAccountDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsLabAccountService.deleteAssetsLabAccountByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/**
	 * 根据id获取台账详情，改造AssetsLabAccountDTO并返回Map
	 *
	 * @return Map<String ,   Object>
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation/getLabAccountDetail", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> AssetsLabAccountDTO(@RequestBody Map<String, String> map) throws Exception {
		AssetsLabAccountDTO dto = new AssetsLabAccountDTO();
		Map<String, Object> assetsLabAccountDTOMap = new HashMap<String, Object>();
		if(map.get("id")==""||map.get("id").equals("")){
			return assetsLabAccountDTOMap;
		}
		//Alias字段赋值
		dto = assetsLabAccountService.queryAssetsLabAccountByPrimaryKey(map.get("id"));
		if(dto != null){
			dto.setManageDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getManageDept(),SessionHelper.getCurrentLanguageCode()));
			dto.setManagerIdAlias(sysUserLoader.getSysUserNameById(dto.getManagerId()));
		}

		//主表DTO数据
		assetsLabAccountDTOMap.put("assetsLabAccountDTO", dto);


		return assetsLabAccountDTOMap;
	}
}
