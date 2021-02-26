package avicit.assets.device.documentpackage.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.documentpackage.service.DocumentItemService;
import avicit.assets.device.usertablemodel.dto.UserTableModelDTO;
import avicit.assets.device.usertablemodel.service.UserTableModelService;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.modules.system.sysfileupload.domain.SysFileUpload;
import avicit.platform6.modules.system.sysfileupload.service.SwfUploadService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import avicit.platform6.api.session.SessionHelper;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.api.application.SysApplicationAPI;

import avicit.assets.device.documentpackage.service.DocumentPackageService;


import avicit.assets.device.documentpackage.dto.DocumentItemDTO;
import avicit.assets.device.documentpackage.dto.DocumentPackageDTO;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 20:01
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/documentpackage/documentPackageController")
public class DocumentPackageController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(DocumentPackageController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;

	@Autowired
	private DocumentPackageService documentPackageService;

	@Autowired

	private DocumentItemService documentItemServiceSub;

	@Autowired
	private SwfUploadService swfUploadService;

	@Autowired
	private UserTableModelService userTableModelService;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toDocumentPackageManage")
	public ModelAndView toDocumentPackageManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/documentpackage/DocumentPackageManage");
		mav.addObject("url", "platform/assets/device/documentpackage/documentPackageController/operation/");
		mav.addObject("surl", "platform/assets/device/documentpackage/documentPackageController/operation/sub/");

		/*用户视图、默认表头获取代码——开始*/
		SysUser user = SessionHelper.getLoginSysUser(request);	//获取当前登录用户
		List<String> viewList = new ArrayList<>();

		/*主表——获取视图列表和表头配置——开始*/
		try {
			//获取主表的视图列表
			viewList = userTableModelService.getUserViewList(user.getId(),"DocumentPackage");

			//获取主表的表头配置
			StringBuffer packageModelJson = new StringBuffer();
			packageModelJson.append("[");

			List<UserTableModelDTO> modelList = userTableModelService.searchUserTableModel(user.getId(),"DocumentPackage", viewList.get(0), "Y");
			if((modelList == null) || (modelList.size() == 0)){
				modelList = userTableModelService.searchUserTableModel("系统默认",  "DocumentPackage", "系统默认视图", "Y");
			}

			for(int i=0; i<modelList.size(); i++){
				if(i == 0){
					packageModelJson.append(modelList.get(i).getFieldModel());
				}
				else{
					packageModelJson.append("," + modelList.get(i).getFieldModel());
				}
			}
			packageModelJson.append("]");
			mav.addObject("packageModelJson", packageModelJson.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*主表——获取视图列表和表头配置——结束*/

		/*子表——获取视图列表和表头配置——开始*/
		try {
			//获取子表的视图列表
			viewList = userTableModelService.getUserViewList(user.getId(),"DocumentItem");
			mav.addObject("documentViewList", viewList);

			//获取子表的表头配置
			StringBuffer documentModelJson = new StringBuffer();
			documentModelJson.append("[");

			List<UserTableModelDTO> modelList = userTableModelService.searchUserTableModel(user.getId(),"DocumentItem", viewList.get(0), "Y");
			if((modelList == null) || (modelList.size() == 0)){
				modelList = userTableModelService.searchUserTableModel("系统默认",  "DocumentItem", "系统默认视图", "Y");
			}

			for(int i=0; i<modelList.size(); i++){
				if(i == 0){
					documentModelJson.append(modelList.get(i).getFieldModel());
				}
				else{
					documentModelJson.append("," + modelList.get(i).getFieldModel());
				}
			}
			documentModelJson.append("]");
			mav.addObject("documentModelJson", documentModelJson.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*子表——获取视图列表和表头配置——结束*/

		return mav;
	}

    /**
     * 跳转到关联技改项目页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toRelateTechDocument")
    public ModelAndView toRelateTechDocument(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/documentpackage/RelateDocument");
        mav.addObject("url", "platform/assets/device/documentpackage/documentPackageController/operation/");
        mav.addObject("surl", "platform/assets/device/documentpackage/documentPackageController/operation/sub/");

        /*用户视图、默认表头获取代码——开始*/
        SysUser user = SessionHelper.getLoginSysUser(request);	//获取当前登录用户
        List<String> viewList = new ArrayList<>();

        /*主表——获取视图列表和表头配置——开始*/
        try {
            //获取主表的视图列表
            viewList = userTableModelService.getUserViewList(user.getId(),"DocumentPackage");

            //获取主表的表头配置
            StringBuffer packageModelJson = new StringBuffer();
            packageModelJson.append("[");

            List<UserTableModelDTO> modelList = userTableModelService.searchUserTableModel(user.getId(),"DocumentPackage", viewList.get(0), "Y");
            if((modelList == null) || (modelList.size() == 0)){
                modelList = userTableModelService.searchUserTableModel("系统默认",  "DocumentPackage", "系统默认视图", "Y");
            }

            for(int i=0; i<modelList.size(); i++){
                if(i == 0){
                    packageModelJson.append(modelList.get(i).getFieldModel());
                }
                else{
                    packageModelJson.append("," + modelList.get(i).getFieldModel());
                }
            }
            packageModelJson.append("]");
            mav.addObject("packageModelJson", packageModelJson.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        /*主表——获取视图列表和表头配置——结束*/

        /*子表——获取视图列表和表头配置——开始*/
        try {
            //获取子表的视图列表
            viewList = userTableModelService.getUserViewList(user.getId(),"DocumentItem");
            mav.addObject("documentViewList", viewList);

            //获取子表的表头配置
            StringBuffer documentModelJson = new StringBuffer();
            documentModelJson.append("[");

            List<UserTableModelDTO> modelList = userTableModelService.searchUserTableModel(user.getId(),"DocumentItem", viewList.get(0), "Y");
            if((modelList == null) || (modelList.size() == 0)){
                modelList = userTableModelService.searchUserTableModel("系统默认",  "DocumentItem", "系统默认视图", "Y");
            }

            for(int i=0; i<modelList.size(); i++){
                if(i == 0){
                    documentModelJson.append(modelList.get(i).getFieldModel());
                }
                else{
                    documentModelJson.append("," + modelList.get(i).getFieldModel());
                }
            }
            documentModelJson.append("]");
            mav.addObject("documentModelJson", documentModelJson.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        /*子表——获取视图列表和表头配置——结束*/

        return mav;
    }

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getDocumentPackagesByPage")
	@ResponseBody
	public Map<String, Object> toGetDocumentPackageByPage(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<DocumentPackageDTO> queryReqBean = new QueryReqBean<DocumentPackageDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");
		if (!StringUtils.isEmpty(keyWord)) {
			json = keyWord;
		}
		String orderBy = "";
		String cloumnName = "";
		if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
			cloumnName = ComUtil.getColumn(DocumentPackageDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(DocumentPackageDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(DocumentPackageDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}

		DocumentPackageDTO param = null;
		QueryRespBean<DocumentPackageDTO> result = null;
		if (json != null && !"".equals(json)) {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<DocumentPackageDTO>() {
			});
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = documentPackageService.searchDocumentPackageByPageOr(queryReqBean, orderBy);
			} else {
				result = documentPackageService.searchDocumentPackageByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (DocumentPackageDTO dto : result.getResult()) {
			dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));
			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));
		}

		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取DocumentPackageDTO分页数据");
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
			DocumentPackageDTO dto = documentPackageService.queryDocumentPackageByPrimaryKey(id);
			mav.addObject("documentPackageDTO", dto);
		}
		mav.setViewName("avicit/assets/device/documentpackage/" + "DocumentPackage" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveDocumentPackageDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

			//主表数据
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			DocumentPackageDTO documentPackageDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<DocumentPackageDTO>() {});

			//子表数据
			String subJsonData = ServletRequestUtils.getStringParameter(request, "subdata", "");
			DocumentItemDTO documentItemDTO = JsonHelper.getInstance().readValue(subJsonData, dateFormat, new TypeReference<DocumentItemDTO>() {});

			if (StringUtils.isEmpty(documentPackageDTO.getId())) {//新增
				//保存主表数据
				String packageId = documentPackageService.insertDocumentPackage(documentPackageDTO);

				//保存子表数据
				documentItemDTO.setPackageId(packageId);

				//获取当前用户
				documentItemDTO.setCreatedByDept(documentPackageDTO.getCreatedByDept());

				String itemId = documentItemServiceSub.insertDocumentItem(documentItemDTO);
			}
			else {//修改
				documentPackageService.updateDocumentPackageSensitive(documentPackageDTO);
			}

			mav.addObject("flag", OpResult.success);
			mav.addObject("documentId", documentItemDTO.getId());
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
	public ModelAndView toDeleteDocumentPackageDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			documentPackageService.deleteDocumentPackageByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/****************************子表操作*****************************
	/**
	 * 按照pid查找子表数据
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/sub/getDocumentItem", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> toGetDocumentItemByPid(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<DocumentItemDTO> queryReqBean = new QueryReqBean<DocumentItemDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");

		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");
		if (!"".equals(keyWord)) {
			json = keyWord;
		}
		String orderBy = "";
		String cloumnName = "";
		if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
			cloumnName = ComUtil.getColumn(DocumentItemDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(DocumentItemDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(DocumentItemDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}

		DocumentItemDTO param = null;
		QueryRespBean<DocumentItemDTO> result = null;

		if (pid == null || "".equals(pid)) {
			pid = "-1";
		}
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, new TypeReference<DocumentItemDTO>() {
			});
			param.setPackageId(pid);
			queryReqBean.setSearchParams(param);
		} else {
			param = new DocumentItemDTO();
			param.setPackageId(pid);
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = documentItemServiceSub.searchDocumentItemByPageOr(queryReqBean, orderBy);
			} else {
				result = documentItemServiceSub.searchDocumentItemByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (DocumentItemDTO dto : result.getResult()) {
			dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));
			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));
			dto.setDocumentType(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_FILE_TYPE", dto.getDocumentType(), sysApplicationAPI.getCurrentAppId()));
			dto.setDocumentCategory(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_FILE_CATEGORY", dto.getDocumentCategory(), sysApplicationAPI.getCurrentAppId()));

			dto.setLifeStage(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_FILE_LIFE_STAGE", dto.getLifeStage(), sysApplicationAPI.getCurrentAppId()));
			dto.setDocumentAuthorAlias(sysUserLoader.getSysUserNameById(dto.getDocumentAuthor()));
			dto.setAuthorDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getAuthorDept(), SessionHelper.getCurrentLanguageCode()));
			dto.setDocumentState(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_FILE_STATE", dto.getDocumentState(), sysApplicationAPI.getCurrentAppId()));

			dto.setLanguageCategory(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_LANGUAGE_CATEGORY", dto.getLanguageCategory(), sysApplicationAPI.getCurrentAppId()));
			dto.setSecretLevel(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL", dto.getSecretLevel(), sysApplicationAPI.getCurrentAppId()));
			dto.setPersonLiableAlias(sysUserLoader.getSysUserNameById(dto.getPersonLiable()));
			dto.setParticipantsAlias(sysUserLoader.getSysUserNameById(dto.getParticipants()));

			dto.setDocumentUpdateByAlias(sysUserLoader.getSysUserNameById(dto.getDocumentUpdateBy()));
			dto.setKnowScopeAlias(sysGroupLoader.getSysGroupNameBySysGroupId(dto.getKnowScope(), SessionHelper.getCurrentLanguageCode()));

			List<SysFileUpload> fileList = swfUploadService.getFileListByFormId(dto.getId());
			if((fileList != null) && (fileList.size() > 0)){
				dto.setDocumentUrl(fileList.get(0).getId());
			}
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取DocumentItemDTO分页数据");
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
	@RequestMapping(value = "/operation/sub/{type}/{id}")
	public ModelAndView toOpertionSubPage(@PathVariable String type, @PathVariable String id, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
			//子表数据
			DocumentItemDTO dto = documentItemServiceSub.queryDocumentItemByPrimaryKey(id);

			dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));
			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));
			dto.setDocumentAuthorAlias(sysUserLoader.getSysUserNameById(dto.getDocumentAuthor()));
			dto.setAuthorDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getAuthorDept(), SessionHelper.getCurrentLanguageCode()));
			dto.setPersonLiableAlias(sysUserLoader.getSysUserNameById(dto.getPersonLiable()));
			dto.setParticipantsAlias(sysUserLoader.getSysUserNameById(dto.getParticipants()));
			dto.setDocumentUpdateByAlias(sysUserLoader.getSysUserNameById(dto.getDocumentUpdateBy()));
			dto.setKnowScopeAlias(sysGroupLoader.getSysGroupNameBySysGroupId(dto.getKnowScope(), SessionHelper.getCurrentLanguageCode()));

			List<SysFileUpload> fileList = swfUploadService.getFileListByFormId(dto.getId());
			if((fileList != null) && (fileList.size() > 0)){
				dto.setDocumentUrl(fileList.get(0).getId());
			}

			mav.addObject("documentItemDTO", dto);

			//主表数据
			DocumentPackageDTO documentPackageDTO = documentPackageService.queryDocumentPackageByPrimaryKey(dto.getPackageId());
			documentPackageDTO.setCreatedByAlias(sysUserLoader.getSysUserNameById(documentPackageDTO.getCreatedBy()));
			documentPackageDTO.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(documentPackageDTO.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));

			mav.addObject("documentPackageDTO", documentPackageDTO);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/device/documentpackage/documentitem/" + "DocumentItem" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
	public ModelAndView toSaveDocumentItemDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

		try {
			DocumentItemDTO documentItemDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<DocumentItemDTO>() {});

			if ("".equals(documentItemDTO.getId())) {//新增
				//获取当前用户
				SysUser user = SessionHelper.getLoginSysUser(request);
				documentItemDTO.setCreatedByDept(user.getDeptId());

				documentItemServiceSub.insertDocumentItem(documentItemDTO);
			}
			else {//修改
				documentItemServiceSub.updateDocumentItemSensitive(documentItemDTO);
			}
			mav.addObject("flag", OpResult.success);
			mav.addObject("documentId", documentItemDTO.getId());
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
	@RequestMapping(value = "/operation/sub/delete", method = RequestMethod.POST)
	public ModelAndView toDeleteDocumentItemDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			documentItemServiceSub.deleteDocumentItemByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

}
