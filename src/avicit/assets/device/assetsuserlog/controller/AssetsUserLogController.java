package avicit.assets.device.assetsuserlog.controller;

import java.io.ByteArrayOutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.GenericType;

import avicit.platform6.api.application.dto.SysApplication;
import avicit.platform6.api.syslog.dto.SysLog;
import avicit.platform6.api.sysuser.SysUserDeptPositionAPI;
import avicit.platform6.core.excel.export.ServerExcelExport;
import avicit.platform6.core.excel.export.datasource.DefaultTypeReferenceDataSource;
import avicit.platform6.core.excel.export.entity.DataGridHeader;
import avicit.platform6.core.excel.export.headersource.JqExportDataGridHeaderSource;
import avicit.platform6.core.excel.export.inf.IFormatField;
import avicit.platform6.core.httpclient.HttpClient;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.rest.client.RestClient;
import avicit.platform6.core.rest.client.RestClientConfig;
import avicit.platform6.core.rest.msg.*;
import net.sf.ehcache.search.parser.MOrderBy;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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

import avicit.assets.device.assetsuserlog.dto.AssetsUserLogDTO;
import avicit.assets.device.assetsuserlog.service.AssetsUserLogService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-13 10:07
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsuserlog/assetsUserLogController")
public class AssetsUserLogController implements LoaderConstant {
	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsUserLogController.class);
	private Logger logger = LoggerFactory.getLogger(AssetsUserLogController.class);
	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsUserLogService assetsUserLogService;
	@Autowired
	private SysUserDeptPositionAPI sysUserDeptPositionAPI;
	@Autowired
	private SysApplicationAPI appAPI;

	private AssetsUserLogController.FormateAppId _formateApp = new AssetsUserLogController.FormateAppId();
	private AssetsUserLogController.Formate _formate = new AssetsUserLogController.Formate();
	private Object AssetsUserLogDTO;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsUserLogManage")
	public ModelAndView toAssetsUserLogManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/assetsuserlog/AssetsUserLogManage");
		mav.addObject("url", "platform/assets/device/assetsuserlog/assetsUserLogController/operation/");
		return mav;
	}

	@RequestMapping({"/getSysLogDataByPage/{appId}/{logTable}"})
	@ResponseBody
	public Map<String, Object> getSysLogList(PageParameter pageParameter, HttpServletRequest request, @PathVariable("appId") String appid, @PathVariable("logTable") String logTable, boolean isExport) throws Exception {
		QueryReqBean<AssetsUserLogDTO> queryReqBean = new QueryReqBean();
		queryReqBean.setPageParameter(pageParameter);
		String keyWord = ServletRequestUtils.getStringParameter(request, "param", "");
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");


		AssetsUserLogDTO param = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsUserLogDTO>() {
			});
			queryReqBean.setSearchParams(param);
		}
		HashMap map;
		if ("gg".equals(appid)) {
			map = new HashMap(2);
			map.put("total", 0);
			map.put("rows", new ArrayList());
			return map;
		} else {
			String baseUrl;
			QueryRespBean avicitResponseBody;
			map = new HashMap(2);
			if ("1".equals(appid)) {
				  //获取列表
				  QueryRespBean<AssetsUserLogDTO> list= assetsUserLogService.searchAssetsUserLogByPageOr(queryReqBean,null);
				  for (AssetsUserLogDTO dto : list.getResult()) {
					  if(dto.getUserid()==null||dto.getUserid().equals("")){
						  dto.setUserid(dto.getLastUpdatedBy());
						  dto.setUserName(sysUserLoader.getSysUserNameById(dto.getUserid()));
						  dto.setDeptid(sysUserDeptPositionAPI.getChiefDeptIdBySysUserId(dto.getUserid()));
						  dto.setDeptName(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDeptid(), SessionHelper.getCurrentLanguageCode()));

					  }else {
//			result.getResult().get().setUserName(request.);
                          try {
                              dto.setUserName(sysUserLoader.getSysUserNameById(dto.getUserid()));
                              dto.setDeptid(sysUserDeptPositionAPI.getChiefDeptIdBySysUserId(dto.getUserid()));
                              dto.setDeptName(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDeptid(), SessionHelper.getCurrentLanguageCode()));
                          }catch (Exception e){
                              dto.setUserName("该用户不存在");
                              dto.setDeptName("无效数据");
                          }
					  } }
				  if(list.getResult().size()>0){
					  map.put("records", list.getPageParameter().getTotalCount());
					  map.put("page", list.getPageParameter().getPage());
					  map.put("total",list.getPageParameter().getTotalPage());
					  map.put("rows", list.getResult());
				  }else{
					  map.put("total", 0);
					  map.put("rows", new ArrayList());
				  }
				  return map;
			} else {
				map = new HashMap(2);
				Map<String, String> data = new HashMap(2);
				data.put("page", String.valueOf(pageParameter.getPage()));
				data.put("rows", String.valueOf(pageParameter.getRows()));
//				data.put("param", param);
				data.put("userId", SessionHelper.getLoginSysUserId(request));
				data.put("logTable", logTable);
				data.put("appid", appid);
				data.put("orgIdentity", SessionHelper.getCurrentOrgIdentity(request));
				baseUrl = this.appAPI.getSysApplication(appid).getBasepath();
				if (StringUtils.isEmpty(baseUrl)) {
					pageParameter.setTotalCount(0L);
					map.put("total", 0);
					map.put("rows", new ArrayList());
					return map;
				} else {
					String url = baseUrl + "/platform/ws/syslog/getsyslog.json";
					avicitResponseBody = null;

					try {
						avicitResponseBody = (QueryRespBean)HttpClient.doPost(url, data, new TypeReference<QueryRespBean<AssetsUserLogDTO>>() {
						});
						if (!"".equals(data.get("param")) && ((String)data.get("param")).indexOf("%%") > 0 && avicitResponseBody.getResult().size() == 0) {
							String oldParam = (String)data.get("param");
							Map<String, String> queryParam = (Map)JsonHelper.getInstance().readValue(oldParam, new TypeReference<Map<String, String>>() {
							});
							queryParam.remove("type");
							queryParam.remove("syslogUsernameZh");
							String newParam = JsonHelper.getInstance().writeValueAsString(queryParam);
							data.put("param", newParam);
							avicitResponseBody = (QueryRespBean)HttpClient.doPost(url, data, new TypeReference<QueryRespBean<AssetsUserLogDTO>>() {
							});
						}
					} catch (Exception var16) {
						this.logger.error("查询应用id" + appid + "日志数据出错：", var16);
						pageParameter.setTotalCount(0L);
						map.put("total", 0);
						map.put("rows", new ArrayList());
						return map;
					}

					this.switchSysLog(avicitResponseBody.getResult());
					if (avicitResponseBody.getResult().size() > 0) {
						map.put("records", avicitResponseBody.getPageParameter().getTotalCount());
						map.put("page", avicitResponseBody.getPageParameter().getPage());
						map.put("total", avicitResponseBody.getPageParameter().getTotalPage());
						map.put("rows", avicitResponseBody.getResult());
					} else {
						pageParameter.setTotalCount(0L);
						map.put("total", 0);
						map.put("rows", new ArrayList());
					}

					Muti3Bean<String, QueryReqBean<AssetsUserLogDTO>, Boolean> mutiBean = new Muti3Bean();
//					mutiBean.setDto1(param);
					mutiBean.setDto2(queryReqBean);
					mutiBean.setDto3(isExport);
					String appName = this.appAPI.getAllSysApplicationNameById(appid);
					url = RestClientConfig.getRestHost("syslog") + "/api/platform6/syslog/SysLog/recordWSRequestLog/" + appName + "/v1";
					RestClient.doPost(url, mutiBean, new GenericType<ResponseMsg<Void>>() {
					});
					return map;
				}
			}
		}
	}

	private void switchSysLog(List<AssetsUserLogDTO> paging) {
		Iterator var2 = paging.iterator();

		while(var2.hasNext()) {
			AssetsUserLogDTO log = (AssetsUserLogDTO)var2.next();
			//log.convert();
		}

	}
	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getAssetsUserLogsByPage")
	@ResponseBody
	public Map<String, Object> togetAssetsUserLogByPage(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<AssetsUserLogDTO> queryReqBean = new QueryReqBean<AssetsUserLogDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");//字段查询条件
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");//排序方式
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");//排序字段
		if (!StringUtils.isEmpty(keyWord)) {
			json = keyWord;
		}
		String orderBy = "";
		String cloumnName = "";
		if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
			cloumnName = ComUtil.getColumn(AssetsUserLogDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsUserLogDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsUserLogDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsUserLogDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsUserLogDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsUserLogDTO>() {
			});
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsUserLogService.searchAssetsUserLogByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsUserLogService.searchAssetsUserLogByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsUserLogDTO dto : result.getResult()) {
			if(dto.getUserid()==null||dto.getUserid().equals("")){
				dto.setUserid(dto.getLastUpdatedBy());
				dto.setUserName(sysUserLoader.getSysUserNameById(dto.getUserid()));
				dto.setDeptid(sysUserDeptPositionAPI.getChiefDeptIdBySysUserId(dto.getUserid()));
				dto.setDeptName(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDeptid(), SessionHelper.getCurrentLanguageCode()));

			}else {
//			result.getResult().get().setUserName(request.);
				dto.setUserName(sysUserLoader.getSysUserNameById(dto.getUserid()));
				dto.setDeptid(sysUserDeptPositionAPI.getChiefDeptIdBySysUserId(dto.getUserid()));
				dto.setDeptName(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDeptid(), SessionHelper.getCurrentLanguageCode()));
			}
		}

		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		LOGGER.info("成功获取AssetsUserLogDTO分页数据");
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
			AssetsUserLogDTO dto = assetsUserLogService.queryAssetsUserLogByPrimaryKey(id);

			mav.addObject("assetsUserLogDTO", dto);
		}
		mav.setViewName("avicit/assets/device/assetsuserlog/" + "AssetsUserLog" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsUserLogDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			AssetsUserLogDTO assetsUserLogDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<AssetsUserLogDTO>() {
					});
			if (StringUtils.isEmpty(assetsUserLogDTO.getId())) {//新增
				assetsUserLogService.insertAssetsUserLog(assetsUserLogDTO);
			} else {//修改
				assetsUserLogService.updateAssetsUserLogSensitive(assetsUserLogDTO);
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
	public ModelAndView toDeleteAssetsUserLogDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsUserLogService.deleteAssetsUserLogByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	private class FormateAppId implements IFormatField {
		private List<SysApplication> appList;

		private FormateAppId() {
		}

		public void setAppList(List<SysApplication> appList) {
			this.appList = appList;
		}

		public Object formatField(DataGridHeader header, Map<String, Object> data, String field) {
			if ("syslogTime".equalsIgnoreCase(field)) {
				return data.get(field).toString();
			} else if ("sysApplicationId".equalsIgnoreCase(field)) {
				Iterator var4 = this.appList.iterator();

				SysApplication app;
				do {
					if (!var4.hasNext()) {
						return "没有系统应用名称";
					}

					app = (SysApplication)var4.next();
				} while(!app.getId().equals(data.get(field)));

				return app.getApplicationName();
			} else {
				return data.get(field);
			}
		}
	}

	private class Formate implements IFormatField {
		private final SimpleDateFormat sdf;
		private List<SysApplication> appList;

		private Formate() {
			this.sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		}

		public Object formatField(DataGridHeader header, Map<String, Object> data, String field) {
			if ("syslogTime".equalsIgnoreCase(field)) {
				return this.sdf.format(new Date(Long.parseLong(data.get(field).toString())));
			} else if ("sysApplicationId".equalsIgnoreCase(field)) {
				Iterator var4 = this.appList.iterator();

				SysApplication app;
				do {
					if (!var4.hasNext()) {
						return "没有系统应用名称";
					}

					app = (SysApplication)var4.next();
				} while(!app.getId().equals(data.get(field)));

				return app.getApplicationName();
			} else {
				return data.get(field);
			}
		}

		public void setAppList(List<SysApplication> appList) {
			this.appList = appList;
		}
	}

	@RequestMapping({"/exportServer"})
	public String toServerExport(HttpServletRequest request, ModelMap map) throws Exception {
		String fileName = ServletRequestUtils.getStringParameter(request, "fileName", "导出excel");
		String dataGridheaders = ServletRequestUtils.getStringParameter(request, "dataGridFields", "");
		boolean hasRowNum = ServletRequestUtils.getBooleanParameter(request, "hasRowNum", true);
		String unContainFields = ServletRequestUtils.getStringParameter(request, "unContainFields", "");
		String sheetName = ServletRequestUtils.getStringParameter(request, "sheetName", "sheet1");
		String appId = ServletRequestUtils.getStringParameter(request, "appid", "1");
		String logTable = ServletRequestUtils.getStringParameter(request, "logTable", "-1");
		String total = ServletRequestUtils.getStringParameter(request, "total", "65500");
		ServerExcelExport serverExp = new ServerExcelExport();
		serverExp.setFileName(fileName);
		serverExp.setSheetName(sheetName);
		JqExportDataGridHeaderSource header = new JqExportDataGridHeaderSource(dataGridheaders);
		header.setUnexportColumn(unContainFields);
		header.setHasRowNum(hasRowNum);
		serverExp.setUserDefinedGridHeader(header);
		int totalcount = Integer.parseInt(total);
		if (totalcount <= 65500) {
			PageParameter pp = new PageParameter(1, 65500);
			Map rst = null;

			try {
				rst = this.getSysLogList(pp, request, appId, logTable, true);
			} catch (Exception var27) {
				this.logger.error("数据查询异常:" + var27.getMessage(), var27);
				return "excel.down";
			}

			ArrayList<AssetsUserLogDTO> aa = (ArrayList)rst.get("rows");
			DefaultTypeReferenceDataSource<AssetsUserLogDTO> dt = new DefaultTypeReferenceDataSource();
			dt.setData(aa);
			serverExp.setExportDataSource(dt);
			serverExp.setFormatField(this._formateApp);
			this._formateApp.setAppList(this.appAPI.getAllSysApplicationList());
			map.addAttribute("export", serverExp);
			return "excel.down";
		} else {
			int size = 'ￜ';
			int page = totalcount / size;
			if (totalcount % size != 0) {
				++page;
			}

			ByteArrayOutputStream baps = new ByteArrayOutputStream();
			ZipOutputStream out = new ZipOutputStream(baps);

			for(int i = 1; i <= page; ++i) {
				int first;
				int end;
				if (i * size > totalcount) {
					first = (i - 1) * size + 1;
					end = totalcount;
				} else {
					first = (i - 1) * size + 1;
					end = i * size;
				}

				PageParameter pp = new PageParameter(i, size);
				Map rst = null;

				try {
					rst = this.getSysLogList(pp, request, appId, logTable, true);
				} catch (Exception var28) {
					this.logger.error("数据查询异常:" + var28.getMessage(), var28);
					return "excel.down";
				}

				ArrayList<AssetsUserLogDTO> aa = (ArrayList)rst.get("rows");
				DefaultTypeReferenceDataSource<AssetsUserLogDTO> dt = new DefaultTypeReferenceDataSource();
				dt.setData(aa);
				serverExp.setExportDataSource(dt);
				serverExp.setFormatField(this._formateApp);
				this._formateApp.setAppList(this.appAPI.getAllSysApplicationList());
				Workbook workbook = serverExp.exportData();
				ZipEntry entry = new ZipEntry("ExportSysLog-from[" + first + "]to[" + end + "].xls");
				out.putNextEntry(entry);
				workbook.write(out);
			}

			out.close();
			map.addAttribute("byte", baps.toByteArray());
			map.addAttribute("name", fileName + ".rar");
			return "byte.down";
		}
	}

}
