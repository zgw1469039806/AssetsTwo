package avicit.platform6.eformclient.controller;

import avicit.platform6.api.syslookup.SysLookupAPI;
import avicit.platform6.api.syslookup.dto.SysLookupSimpleVo;
import avicit.platform6.api.sysuser.SysDeptAPI;
import avicit.platform6.api.sysuser.SysOrgAPI;
import avicit.platform6.api.sysuser.dto.SysDept;
import avicit.platform6.api.sysuser.dto.SysOrg;
import avicit.platform6.db.utils.DbControlUtil;
import avicit.platform6.db.dbtabletype.dto.DbTable;
import avicit.platform6.db.dbtablecol.dto.DbTableColDTO;
import avicit.platform6.eformbpms.utils.BpmsCacheUtils;
import avicit.platform6.eformbpms.utils.BpmsEditorUtils;
import avicit.platform6.eform.utils.ButtonUtil;
import avicit.platform6.eform.EformConstant;
import avicit.platform6.eform.EformConstant.ColProp;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.component.GrantMethod;
import avicit.platform6.core.dao.dynamicdatasource.Dbs;
import avicit.platform6.core.properties.PlatformConstant;
import avicit.platform6.core.redisCacheManager.CacheHelper;
import avicit.platform6.core.rest.client.RestClient;
import avicit.platform6.core.rest.client.RestClientConfig;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.msg.ResponseStatus;
import avicit.platform6.db.utils.DbExcutorUtil;
import avicit.platform6.eform.dto.EformDesignTemplate;
import avicit.platform6.eform.dto.EformTabColumnsDetail;
import avicit.platform6.eform.dto.EformTabForm;
import avicit.platform6.eform.dto.EformTableRelation;
import avicit.platform6.eformbpms.dto.EformFormInfo;
import avicit.platform6.eformclient.annotation.GrantEformCom;
import avicit.platform6.eformclient.vo.AjaxVO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.GenericType;
import java.util.*;

@GrantEformCom
@Controller
@RequestMapping(value="/eform/bpmsClient")
public class BpmsClientController {

	private static Logger logger=LoggerFactory.getLogger(BpmsClientController.class);



	@Autowired
	private BpmsEditorUtils bpmsEditorUtils;

	@Autowired
	private BpmsCacheUtils fcUtils;

	@Autowired
	private DbControlUtil dbContrlUtil;

	@Autowired
	private DbExcutorUtil dbExcutorUtil;

    @Autowired
    private ButtonUtil buttonUtil;

    @Autowired
	private SysLookupAPI sysLookupAPI;

	@Autowired
	private SysOrgAPI sysOrgAPI;

	@Autowired
	private SysDeptAPI sysDeptAPI;

	@RequestMapping(value="/topreview/{style}",method ={RequestMethod.GET})
	public ModelAndView toPreview(@PathVariable(value = "style") String style,HttpServletRequest request,@CookieValue(value=PlatformConstant.COOKIE_CURRENT_LANGUAGE_CODE,defaultValue=PlatformConstant.D_LANGUAGE) String langcode){
		ModelAndView mv = new ModelAndView();
		
		Map<String,Object> session = new HashMap<String,Object>();
		String orgIndentity = SessionHelper.getCurrentOrgIdentity(request);
		session.put("orgIndentity", orgIndentity);
		session.put("orgName", sysOrgAPI.getSysOrgNameBySysOrgId(orgIndentity,langcode));
		String userId = SessionHelper.getLoginSysUserId(request);
		session.put("userId", userId);
		String deptName = SessionHelper.getCurrentDeptName(request);
		session.put("deptName", deptName);
		String deptId = SessionHelper.getCurrentDeptId(request);
		session.put("deptId", deptId);
		SysUser loginuser = SessionHelper.getLoginSysUser(request);
		SysDept dept = SessionHelper.getCurrentDept(request);
		SysDept updept = getparentDept(dept,1);
		session.put("upDeptName", updept.getDeptName());
		session.put("upDeptId", updept.getId());
		SysDept upupdept = getparentDept(updept,1);
		session.put("upUpDeptName", upupdept.getDeptName());
		session.put("upUpDeptId", upupdept.getId());
		SysDept topdept = getparentDept(upupdept,-1);
		session.put("topDeptName", topdept.getDeptName());
		session.put("topDeptId", topdept.getId());
		session.put("user", loginuser);
		String userName = loginuser.getName();
		session.put("userName", userName);
		String loginName = loginuser.getLoginName();
		session.put("loginName", loginName);
		String appId = RestClientConfig.systemid;
		session.put("appId", appId);
		String sessionString = JsonHelper.getInstance().writeValueAsString(session);
		sessionString = sessionString.replaceAll("\\\\", "\\\\\\\\");  
        sessionString = sessionString.replaceAll("\"", "\\\\\"");  
        sessionString = sessionString.replaceAll("\'", "\\\\\'");
        mv.addObject("session",sessionString );
		if (style.equals(EformConstant.TempType.BOOTSTRAP)){
			mv.setViewName("avicit/platform6/eform/bpmsformdefine/bpmsbootstrapPreview");
		}else if(style.equals(EformConstant.TempType.EASYUI)){
			mv.setViewName("avicit/platform6/eform/bpmsformdefine/bpmsPreview");
		}
		return mv;
	}

	private SysDept getparentDept(SysDept dept,int count){
		Map<String,Object> deptInfo = new HashMap<String,Object>();
		for(int i = Math.abs(count);i>0;){
			SysDept parentDept = sysDeptAPI.getParentSysDeptBySysDeptId(dept.getId());
			if(parentDept!=null){
				dept = parentDept;
			}else{
				break;
			}
			i = count>0?--i:++i;
		}
		return dept;
	}

	@ResponseBody
	@RequestMapping(value="/getFormContent/{formId}",method ={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView getFormContent(@PathVariable(value = "formId")String formId)throws Exception{
		EformTabForm contentform = fcUtils.getRestEformTabForm(formId);
		String html = "";
		if (contentform != null){
			html = new String(contentform.getFormContent(), EformConstant.CHARSET);
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("content", html);
		return mv;
	}


	@GrantMethod
	@ResponseBody
	@RequestMapping(value="/preview",method ={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView preview(String tableContent,String forminfoId,String style,@CookieValue(value=PlatformConstant.COOKIE_CURRENT_LANGUAGE_CODE,defaultValue=PlatformConstant.D_LANGUAGE) String langcode) {
		String html="";
		String script = "";
		String subscript="";
		ModelAndView mv = new ModelAndView();
		try {
			Document doc = bpmsEditorUtils.StringToDocument(tableContent);
			Map<String, String> documentToEasyUI = bpmsEditorUtils.DocumentToLayout(doc, langcode, false, style, forminfoId, true);
			html = documentToEasyUI.get("dom");
			script = documentToEasyUI.get("script");
			subscript = documentToEasyUI.get("subTableScript");
			mv.addObject("flag","success");
			mv.addObject("layout", html);
			mv.addObject("script", script);
			mv.addObject("subscript", subscript);
		}catch (Exception e){
			mv.addObject("flag","error");
			mv.addObject("error",e.getMessage());
			logger.error(e.getMessage(),e);
		}
		return mv;
	}

	@GrantMethod
	@ResponseBody
	@RequestMapping(value="/getTemplateList",method ={RequestMethod.POST,RequestMethod.GET})
	public String list()throws Exception{
		List<EformDesignTemplate> result =new ArrayList<EformDesignTemplate>();
		ObjectMapper objectMapper=new ObjectMapper();
		String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
		String restURL = restHost + "/api/platform6/eform/designtemplate/list/v1";
		EformDesignTemplate temp=new EformDesignTemplate();
		List<EformDesignTemplate> resp=RestClient.doPost(restURL, temp, new GenericType<ResponseMsg<List<EformDesignTemplate>>>(){}).getResponseBody();
		for(EformDesignTemplate et:resp){
			if(et.getFormContent()!=null){
				//需要改成UTF-8
				et.setFormContentStr(new String(et.getFormContent(), EformConstant.CHARSET));
			}else{
				et.setFormContentStr("");
			}
			if(et.getFormLayout()!=null){
				et.setFormLayoutStr(new String(et.getFormLayout(), EformConstant.CHARSET));
			}else{
				et.setFormLayoutStr("");
			}
			result.add(et);
		}
		return objectMapper.writeValueAsString(new AjaxVO(true,objectMapper.writeValueAsString(result),""));
	}


	@ResponseBody
	@RequestMapping(value="/deleteTemplate",method ={RequestMethod.POST,RequestMethod.GET})
	public String deleteTemplate(String id)throws Exception{
		ObjectMapper objectMapper=new ObjectMapper();
		String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
		String restURL = restHost + "/api/platform6/eform/designtemplate/del/v1";
		int result=RestClient.doPost(restURL, id, new GenericType<ResponseMsg<Integer>>(){}).getResponseBody();
		if(result==1){
			return objectMapper.writeValueAsString(new AjaxVO(true,"",""));
		}else{
			return objectMapper.writeValueAsString(new AjaxVO(false,"",""));
		}
	}

	@ResponseBody
	@RequestMapping(value="/validateTemplateName",method ={RequestMethod.POST,RequestMethod.GET})
	public String validateTemplateName(String templateName)throws Exception{
		ObjectMapper objectMapper=new ObjectMapper();
		String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
		String restURL = restHost + "/api/platform6/eform/designtemplate/list/v1";
		EformDesignTemplate temp=new EformDesignTemplate();
		temp.setTemplateName(templateName);
		int size=RestClient.doPost(restURL, temp, new GenericType<ResponseMsg<List<EformDesignTemplate>>>(){}).getResponseBody().size();
		if(size==0){
			return objectMapper.writeValueAsString(new AjaxVO(true,"",""));
		}else{
			return objectMapper.writeValueAsString(new AjaxVO(false,"",""));
		}
	}

	@ResponseBody
	@RequestMapping(value="/createTemplate",method ={RequestMethod.POST,RequestMethod.GET})
	public String saveTemplate(String tableCss,String templateName,String templateType,String tableContent)throws Exception{
		ObjectMapper objectMapper=new ObjectMapper();
		String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
		String restURL = restHost + "/api/platform6/eform/designtemplate/save/v1";
		EformDesignTemplate temp=new EformDesignTemplate();
		temp.setTemplateName(templateName);
		temp.setTableCss(tableCss);
		temp.setFormContent(tableContent.getBytes(EformConstant.CHARSET));
		RestClient.doPost(restURL, temp, new GenericType<ResponseMsg<String>>(){});
		return objectMapper.writeValueAsString(new AjaxVO(true,"",""));
	}

    @ResponseBody
    @RequestMapping(value="/updateTemplate",method ={RequestMethod.POST,RequestMethod.GET})
    public String updateTemplate(String tableCss,String templateName,String templateType,String tableContent)throws Exception{
        ObjectMapper objectMapper=new ObjectMapper();
        String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
        String restURL = restHost + "/api/platform6/eform/designtemplate/update/v1";

        EformDesignTemplate temp=new EformDesignTemplate();
        temp.setTemplateName(templateName);
        temp.setTableCss(tableCss);
        temp.setFormContent(tableContent.getBytes(EformConstant.CHARSET));
        RestClient.doPost(restURL, temp, new GenericType<ResponseMsg<String>>(){});

        return objectMapper.writeValueAsString(new AjaxVO(true,"",""));
    }

	@ResponseBody
	@RequestMapping(value="/validateTableName",method ={RequestMethod.POST,RequestMethod.GET})
	public String validateTableName(String tableName)throws Exception{
		ObjectMapper objectMapper=new ObjectMapper();
		DbTable temp=new DbTable();
		temp.setTableName(tableName.trim().toUpperCase());

		int size=dbExcutorUtil.checkTableExist(tableName.trim().toUpperCase());
		if(size==0){
			return objectMapper.writeValueAsString(new AjaxVO(true,"",""));
		}else{
			return objectMapper.writeValueAsString(new AjaxVO(false,"",""));
		}
	}


	@ResponseBody
	@RequestMapping(value="/saveFormForUml",method ={RequestMethod.POST,RequestMethod.GET})
	public String saveFormForUml(HttpServletRequest request,String version, String eformFormInfoId,String tableName,String tableCss,String tableJs,String tableContent,@CookieValue(value=PlatformConstant.COOKIE_CURRENT_LANGUAGE_CODE,defaultValue=PlatformConstant.D_LANGUAGE) String langcode)throws Exception{
		ObjectMapper objectMapper=new ObjectMapper();
		try {
			EformFormInfo formInfo = fcUtils.getFormInfoByFormId(eformFormInfoId);
			EformTabForm eformTabForm = fcUtils.getRestEformTabForm(eformFormInfoId,version);
			if (eformTabForm == null) {
				saveForm(null, eformFormInfoId, tableCss, tableJs, tableContent, langcode, version, formInfo.getFormStyle());
			} else {
				eformTabForm.setFormContent(tableContent.getBytes(EformConstant.CHARSET));
				Map<String, String> domDefine = bpmsEditorUtils.DocumentToLayout(bpmsEditorUtils.StringToDocument(tableContent), langcode, false, formInfo.getFormStyle(), formInfo.getId(), false);
				String formstr = domDefine.get("dom");
				String formScript = domDefine.get("script");
				eformTabForm.setFormLayout(formstr.getBytes(EformConstant.CHARSET));
				eformTabForm.setFormScript(formScript.getBytes(EformConstant.CHARSET));
				eformTabForm.setTableCss(tableCss);
				eformTabForm.setTableJs(tableJs);

				String tableURL = RestClientConfig.getRestHost(RestClientConfig.eform) + "/api/platform6/eform/cbbtabform/update/v1";
				ResponseMsg<String> doPost3 = RestClient.doPost(tableURL, eformTabForm, new GenericType<ResponseMsg<String>>() {
				});
				if (doPost3.getRetCode().equals(ResponseStatus.HTTP_OK)) { //成功
					logger.debug("调用rest服务成功：" + tableURL);
				} else { //失败
					logger.info("调用rest服务出错：:" + tableURL + "," + doPost3.getRetCode() + "," + doPost3.getErrorDesc());
				}
				CacheHelper.getInstance().del("platform6:eform:formtabform:" + eformFormInfoId+":"+version);
			}
		}catch (Exception e){
			logger.error(e.getMessage(),e);
			return objectMapper.writeValueAsString(new AjaxVO(false,e.getMessage(),""));
		}
		return objectMapper.writeValueAsString(new AjaxVO(true,"",""));
	}


	/**
	 *
	 * @param request
	 * @param eformFormInfoId
	 * @param tableName
	 * @param tableCss
	 * @param tableJs
	 * @param tableContent
	 * @param langcode
	 * @return
	 * @throws Exception
	 */
	@GrantMethod
	@ResponseBody
	@RequestMapping(value="/saveNewVersion",method ={RequestMethod.POST,RequestMethod.GET})
	public String saveFormForNewVersion(HttpServletRequest request,String version, String eformFormInfoId,String tableName,String tableCss,String tableJs,String tableContent,@CookieValue(value=PlatformConstant.COOKIE_CURRENT_LANGUAGE_CODE,defaultValue=PlatformConstant.D_LANGUAGE) String langcode)throws Exception{
		ObjectMapper objectMapper=new ObjectMapper();
		String newVersion = "";
		try{
			EformFormInfo formInfo = fcUtils.getFormInfoByFormId(eformFormInfoId);

			EformTabForm tab = fcUtils.getRestEformTabForm(eformFormInfoId,version);

			//如果没有默认按钮，则添加默认表单按钮
			if (buttonUtil.getAllCustomButtonByTabFormId(tab.getId()).size() == 0) {
				buttonUtil.addDefaultFormButtons(eformFormInfoId,tab.getId());
			}
			//判断已有字段类型是否改变，如果改变则提示用户
			DbTable dbTable = fcUtils.getTablesBytableId(formInfo.getDataSourceId());
			Document doc=bpmsEditorUtils.StringToDocument(tableContent);
			Map<String,Object> list=bpmsEditorUtils.getTableCol(doc);
			List<Map<String,Object>> subList = bpmsEditorUtils.DocumentToSubtable(doc);


			List<EformTabForm> tabForms =  fcUtils.getEformTabFormList(eformFormInfoId);
			int versiontemp = 1;
			for (EformTabForm tabForm : tabForms){
				String[] split = tabForm.getAttribute08().split("V");
				int ver = Integer.parseInt(split[1]);
				if (ver > versiontemp) {
					versiontemp = ver;
				}
			}
			newVersion = "V"+Integer.toString(versiontemp+1);

			//新增eform_tab_form
			EformFormInfo formInfoByFormId = fcUtils.getFormInfoByFormId(eformFormInfoId);
			Map<String,String> map =updateToTableColumns(eformFormInfoId, formInfoByFormId.getDataSourceId(),tableCss,tableJs,tableContent,langcode,newVersion,formInfoByFormId.getFormStyle());
			//保存设计字段
			try {
				saveDesignColumn(request, dbTable, list, map.get("tabFormId"), true);
				fcUtils.updateVersion(eformFormInfoId,newVersion);
			}catch (Exception e){
				fcUtils.deleteEformTabFormById(map.get("tabFormId"));
				logger.error(e.getMessage(),e);
				return objectMapper.writeValueAsString(new AjaxVO(false,e.getMessage(),""));
			}
			SaveToSubTableColumns(request, map.get("tableId"),subList,map.get("tabFormId"), dbTable.getTableType(),"dataSource");

			buttonUtil.saveButtonForNewVersion(tab.getId(),map.get("tabFormId"));

		}catch(Exception e){
			logger.error(e.getMessage(),e);
			return objectMapper.writeValueAsString(new AjaxVO(false,e.getMessage(),""));
		}
		return objectMapper.writeValueAsString(new AjaxVO(true,"",newVersion));

	}




	@GrantMethod
	@ResponseBody
	@RequestMapping(value="/updateForm",method ={RequestMethod.POST,RequestMethod.GET})
	public String updateForm(HttpServletRequest request, String eformFormInfoId,String version,String tableName,String tableCss,String tableJs,String tableUrlCss,String tableContent,@CookieValue(value=PlatformConstant.COOKIE_CURRENT_LANGUAGE_CODE,defaultValue=PlatformConstant.D_LANGUAGE) String langcode)throws Exception{
		ObjectMapper objectMapper=new ObjectMapper();
		try{
			EformFormInfo formInfo = fcUtils.getFormInfoByFormId(eformFormInfoId);
	        EformTabForm eformTabForm = fcUtils.getRestEformTabForm(eformFormInfoId,version);

            
          //判断已有字段类型是否改变，如果改变则提示用户
            DbTable dbTable = fcUtils.getTablesBytableId(formInfo.getDataSourceId());
            Document doc=bpmsEditorUtils.StringToDocument(tableContent);
            Map<String,Object> list=bpmsEditorUtils.getTableCol(doc);
            List<Map<String,Object>> subList = bpmsEditorUtils.DocumentToSubtable(doc);
            String msg = "";

            //如果是绑定数据源反向生成的表单，则先保存
            if(eformTabForm == null) {


            	if (!StringUtils.isEmpty(msg) && !"1".equals(msg)){
            		return objectMapper.writeValueAsString(new AjaxVO(false,msg,""));
            	}
  
                //新增eform_tab_form
                Map<String,String> map =updateToTableColumns(eformFormInfoId, formInfo.getDataSourceId(),tableCss,tableJs,tableContent,langcode,version,formInfo.getFormStyle());
				//保存设计字段
				try {
					msg = saveDesignColumn(request, dbTable, list, map.get("tabFormId"), true);
					if (!StringUtils.isEmpty(msg) && !"1".equals(msg)){
						fcUtils.deleteEformTabFormById(map.get("tabFormId"));
						return objectMapper.writeValueAsString(new AjaxVO(false,msg,""));
					}
				}catch (Exception e){
					fcUtils.deleteEformTabFormById(map.get("tabFormId"));
					logger.error(e.getMessage(),e);
					return objectMapper.writeValueAsString(new AjaxVO(false,e.getMessage(),""));
				}
                SaveToSubTableColumns(request, map.get("tableId"),subList,map.get("tabFormId"), dbTable.getTableType(),"dataSource");

				//如果没有默认按钮，则添加默认表单按钮
				if (buttonUtil.getAllCustomButtonByTabFormId(map.get("tabFormId")).size() == 0) {
					buttonUtil.addDefaultFormButtons(eformFormInfoId,map.get("tabFormId"));
				}
            }
            else {
                //如果表单内容没有变化，则不处理
            	if(eformTabForm.getTableJs()==null) {
					eformTabForm.setTableJs("");
				}
				if(eformTabForm.getTableUrlCss()==null){
					eformTabForm.setTableUrlCss("");
				}
                if(tableContent.equals(new String(eformTabForm.getFormContent(), EformConstant.CHARSET)) && eformTabForm.getTableCss().equals(tableCss) && eformTabForm.getTableJs().equals(tableJs) && eformTabForm.getTableUrlCss().equals(tableUrlCss)) {
                    return objectMapper.writeValueAsString(new AjaxVO(true,"NO CHANGE",""));
                }
                //保存设计字段
                msg = saveDesignColumn(request, dbTable,list,eformTabForm.getId(),false);
                
                if (!StringUtils.isEmpty(msg) && !"1".equals(msg)){
            		return objectMapper.writeValueAsString(new AjaxVO(false,msg,""));
            	}

                //清空主子表关系数据
                
                EformTableRelation parm = new EformTableRelation();
                parm.setParentTableId(dbTable.getId());
                parm.setTargetId(eformTabForm.getId());
                List<EformTableRelation> eformTableRelationList = fcUtils.getEformTableRelation(parm);
                for (EformTableRelation eformTableRelation : eformTableRelationList) {
                    String url = RestClientConfig.getRestHost(RestClientConfig.eform) + "/api/platform6/eform/tablerelation/del/v1";
                    ResponseMsg<Integer> doPost2 = RestClient.doPost(url, eformTableRelation.getId(), new GenericType<ResponseMsg<Integer>>(){});
                    if(doPost2.getRetCode().equals(ResponseStatus.HTTP_OK)){ //成功
                        logger.debug("调用rest服务成功：" + url);
                    }else{ //失败
                        logger.info("调用rest服务出错：:" + url + "," + doPost2.getRetCode()+","+doPost2.getErrorDesc());
                    }
                }

                //更新eform_tab_form
                //0自定义子表添加后已经存在实体表，所以此处修改为1数据源
                eformTabForm.setFormContent(tableContent.replaceAll("\"subTableType\":\"0\"", "\"subTableType\":\"1\"").getBytes(EformConstant.CHARSET));
                Map<String,String> domDefine = bpmsEditorUtils.DocumentToLayout(bpmsEditorUtils.StringToDocument(tableContent), langcode, false,formInfo.getFormStyle(),formInfo.getId(),false);
                String formstr = domDefine.get("dom");
                String formScript = domDefine.get("script");
                eformTabForm.setFormLayout(formstr.getBytes(EformConstant.CHARSET));
                eformTabForm.setFormScript(formScript.getBytes(EformConstant.CHARSET));
                eformTabForm.setTableCss(tableCss);
                eformTabForm.setTableJs(tableJs);
				eformTabForm.setTableUrlCss(tableUrlCss);
				eformTabForm.setTableId(dbTable.getId());
				eformTabForm.setFormName(dbTable.getId());

                String tableURL = RestClientConfig.getRestHost(RestClientConfig.eform) + "/api/platform6/eform/cbbtabform/update/v1";
                ResponseMsg<String> doPost3 = RestClient.doPost(tableURL, eformTabForm, new GenericType<ResponseMsg<String>>(){});
                if(doPost3.getRetCode().equals(ResponseStatus.HTTP_OK)){ //成功
                    logger.debug("调用rest服务成功：" + tableURL);
                }else{ //失败
                    logger.info("调用rest服务出错：:" + tableURL + "," + doPost3.getRetCode()+","+doPost3.getErrorDesc());
                }
                CacheHelper.getInstance().del("platform6:eform:formtabform:"+eformFormInfoId+":"+version);

                SaveToSubTableColumns(request, dbTable.getId(),subList,eformTabForm.getId(), dbTable.getTableType(),"dataSource");

				//如果没有默认按钮，则添加默认表单按钮
				if (buttonUtil.getAllCustomButtonByTabFormId(eformTabForm.getId()).size() == 0) {
					buttonUtil.addDefaultFormButtons(eformFormInfoId,eformTabForm.getId());
				}
            }


		}catch(Exception e){
			logger.error(e.getMessage(),e);
			return objectMapper.writeValueAsString(new AjaxVO(false,e.getMessage(),""));
		}
		return objectMapper.writeValueAsString(new AjaxVO(true,"",""));

	}


	@GrantMethod
	@ResponseBody
	@RequestMapping(value="/createtable",method ={RequestMethod.POST,RequestMethod.GET})
	public String createtable(HttpServletRequest request,String version, String eformFormInfoId,String dbTypeId,String tableName,String tableLabel,String tableCss,String tableJs,String tableContent,@CookieValue(value=PlatformConstant.COOKIE_CURRENT_LANGUAGE_CODE,defaultValue=PlatformConstant.D_LANGUAGE) String langcode)throws Exception{
	    if(StringUtils.isBlank(tableLabel)) {
            tableLabel = tableName;
        }

		ObjectMapper objectMapper=new ObjectMapper();
		try{
			Document doc=bpmsEditorUtils.StringToDocument(tableContent);
			Map<String,Object> list=bpmsEditorUtils.getTableCol(doc);
			List<Map<String,Object>> subList = bpmsEditorUtils.DocumentToSubtable(doc);
			EformFormInfo formInfoByFormId = fcUtils.getFormInfoByFormId(eformFormInfoId);
			Map<String,String> map=SaveToTableColumns(request,eformFormInfoId, tableName.toUpperCase(),tableLabel,list,tableCss,tableJs,tableContent,langcode,version,formInfoByFormId.getFormStyle(), dbTypeId);
			if (!StringUtils.isEmpty(map.get("msg")) && !"1".equals(map.get("msg"))){//如果有不是“1”的msg，说明保存出错，返回报错信息
				return objectMapper.writeValueAsString(new AjaxVO(false,map.get("msg"),""));
			}
			SaveToSubTableColumns(request, map.get("tableId"),subList,map.get("tabFormId"), dbTypeId,"dataSource");

            formInfoByFormId.setDataSourceId(map.get("tableId"));
            try{
                String url = RestClientConfig.getRestHost(RestClientConfig.eform) + "/api/platform6/eform/manage/updateEformFormInfo/v1";
                ResponseMsg<Map<String, Object>> responseMsg = RestClient.doPost(url, formInfoByFormId, new GenericType<ResponseMsg<Map<String, Object>>>(){});
                if(responseMsg.getRetCode().equals(ResponseStatus.HTTP_OK)){
                }else{
                    throw new RuntimeException(responseMsg.getErrorDesc());
                }
            }catch(Exception e){
                logger.error(e.getMessage(),e);
            }
            CacheHelper.getInstance().del("platform6:eform:formInfo:"+eformFormInfoId);

            //如果没有默认按钮，则添加默认表单按钮
            if (buttonUtil.getAllCustomButtonByTabFormId(map.get("tabFormId")).size() == 0) {
                buttonUtil.addDefaultFormButtons(eformFormInfoId,map.get("tabFormId"));
            }
            
		}catch(Exception e){
			logger.error(e.getMessage(),e);
			return objectMapper.writeValueAsString(new AjaxVO(false,e.getMessage(),""));
		}
		return objectMapper.writeValueAsString(new AjaxVO(true,"",""));

	}

	public Map<String,String> SaveToTableColumns(HttpServletRequest request, String eformFormInfoId,String tableName,String tableLabel, Map<String,Object> list,String tableCss,String tableJs,String tableContent,String langcode,String version,String style, String dbTypeId) throws Exception {
		Map<String,String> map = new HashMap<String,String>();
		DbTable ct=SaveTable(tableName, tableLabel, dbTypeId,"dataSource");
		String tabFormId = "";
		try {
			tabFormId = saveForm(ct, eformFormInfoId, tableCss, tableJs, tableContent, langcode, version, style);
		}catch (Exception e){
			dbContrlUtil.deleteDbTableBytableName(tableName);
		}
		try {
			String msg = SaveColumns(request, ct, list, tabFormId);
			if (!StringUtils.isEmpty(msg) && !"1".equals(msg)){ //“1”代表成功，如果有不是“1”的信息说明保存出错，返回出错信息，并删除已经插入的表格
				map.put("msg",msg);
				dbContrlUtil.deleteDbTableBytableName(tableName);
				fcUtils.deleteEformTabFormById(tabFormId);
				return map;
			}
			createTable(ct, "");
		}catch (Exception e){
			dbContrlUtil.deleteDbTableBytableName(tableName);
			fcUtils.deleteEformTabFormById(tabFormId);
			throw new RuntimeException(e.getMessage());
		}
		map.put("tableId", ct.getId());
		map.put("tabFormId", tabFormId);
		return map;
	}

    public Map<String,String> updateToTableColumns(String eformFormInfoId,String tableId,String tableCss,String tableJs,String tableContent,String langcode,String version,String style) throws Exception {
        DbTable ct=fcUtils.getTablesBytableId(tableId);
        String tabFormId = saveForm(ct,eformFormInfoId,tableCss,tableJs,tableContent,langcode,version,style);
        Map<String,String> map = new HashMap<String,String>();
		map.put("tableId",ct.getId());
		map.put("tabFormId",tabFormId);
        return map;
    }

	public String SaveToSubTableColumns(HttpServletRequest request, String tableId,List<Map<String,Object>> list,String tabFormId, String dbTypeId,String datasourceId) throws Exception {
		ObjectMapper objectMapper=new ObjectMapper();
		String subTableName="";
		String fkColName = "";
		String json="";
		for(Map<String,Object> map:list){
			subTableName =(String)map.get("subTableName");
			fkColName = (String)map.get("fkColName");
			json=(String)map.get("colList");
			if(subTableName!=null&&json!=null){
                String subTableType = (String) map.get("subTableType");
				List<Map<String,Object>> columnList =objectMapper.readValue(json, new TypeReference<List<Map<String,Object>>>(){});
                //子表类型：0自定义、1数据源
                //只有自定义才新生成子表
                if(subTableType.equals("0")) {
                    try {
						DbTable ct=SaveTable(subTableName.toUpperCase(),subTableName.toUpperCase(), dbTypeId,datasourceId);
						SaveSubColumns(request, ct, columnList,tabFormId);
                        try {
							createTable(ct, datasourceId);
						}catch (Exception e){
							dbContrlUtil.deleteDbTable(ct.getId());
							e.printStackTrace();
						}
                        //插入主子关系表
                        EformTableRelation etr=new EformTableRelation();
                        etr.setChildTableId(ct.getId());
                        etr.setParentTableId(tableId);
                        etr.setFkColName(fkColName);
                        etr.setTargetId(tabFormId);
                        SaveTableRelation(etr);

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                //如果绑定数据源，则添加或更新外键
                else {
                    DbTable dbTable = fcUtils.getTableBytableName(subTableName);

                    EformTableRelation parm = new EformTableRelation();
                    parm.setChildTableId(dbTable.getId());
                    parm.setParentTableId(tableId);
                    parm.setTargetId(tabFormId);
                    List<EformTableRelation> result = fcUtils.getEformTableRelation(parm);


                    if(result.size() == 0) {
                        parm.setFkColName(fkColName);
                        SaveTableRelation(parm);
                    }
                    else {
                        EformTableRelation data = result.get(0);
                        data.setFkColName(fkColName);
                        String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
                        String restURL = restHost + "/api/platform6/eform/tablerelation/update/v1";
                        ResponseMsg<Integer> responseMsg2 = RestClient.doPost(restURL, data, new GenericType<ResponseMsg<Integer>>(){});
                        if(responseMsg2.getRetCode().equals(ResponseStatus.HTTP_OK)){ //成功
                            logger.debug("调用rest服务成功：" + restURL);
                        }else{ //失败
                            logger.info("调用rest服务出错：:" + restURL + "," + responseMsg2.getRetCode()+","+responseMsg2.getErrorDesc());
                        }
                    }

                    //添加新字段字段
					addSubTableColumns(request ,dbTable, columnList, tabFormId);
                }
			}
		}
		return "1";
	}

	/**
	 * 子表新加列
	 * @param request
	 * @param dbTable
	 * @param list
	 * @param tabFormId
	 */
	private void addSubTableColumns(HttpServletRequest request, DbTable dbTable, List<Map<String,Object>> list, String tabFormId){
		try{
			List<DbTableColDTO> dbTableCols = dbContrlUtil.getColunmsByTableId(dbTable.getId());
			for(Map<String, Object> item : list){
				Map<String, Object> m = new HashMap<String, Object>();
				if (item.containsKey(ColProp.colIsVir.getKey())){
					if ("Y".equals((String)item.get(ColProp.colIsVir.getKey()))){
						continue;
					}
				}
				for(DbTableColDTO dbTableCol : dbTableCols){
					String colName = dbTableCol.getColName();
					m.put(colName, dbTableCol);
				}
				ObjectMapper ObjectMapper=new ObjectMapper();
				String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
				String coldetailURL = restHost + "/api/platform6/eform/coldetail/save/v1";
				if(m.get(item.get("colName")) == null){
					//插入db_table_col



					if(item.get(ColProp.colName.getKey())!=null && !item.get(ColProp.colType.getKey()).equals("NOT_DB_COL_ELE")){
						DbTableColDTO entity = new  DbTableColDTO();

						entity.setTableId(dbTable.getId());
						entity.setColName(((String)item.get(ColProp.colName.getKey())).toUpperCase());
						entity.setColComments((String)item.get(ColProp.colLabel.getKey()));
						if(item.get(ColProp.colLength.getKey())!=null){
							entity.setColLength((String)item.get(ColProp.colLength.getKey()));
						}
						if(item.get(ColProp.attribute02.getKey())!=null){
							entity.setAttribute02((String)item.get(ColProp.attribute02.getKey()));
						}

						entity.setColIsUnique((String)item.get(ColProp.colIsUnique.getKey()));
						String colType=(String)item.get(ColProp.colType.getKey());
//						if (item.containsKey("selectModel")) {
//							if ("single".equals(item.get("selectModel"))){
//								colType = "VARCHAR2";
//							}
//						}
						entity.setColType(colType);
						entity.setColNullable("Y");
						entity.setSysApplicationId(RestClientConfig.systemid);
						entity.setColIsPk("N");
						entity.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
						String colId = dbContrlUtil.insertColunms(entity);


						//插入字段属性表
						EformTabColumnsDetail etcd=new EformTabColumnsDetail();
						etcd.setColumnId(colId);
						etcd.setTabFormId(tabFormId);
						etcd.setColumnDetail(ObjectMapper.writeValueAsBytes(item));
						RestClient.doPost(coldetailURL, etcd, new GenericType<ResponseMsg<String>>(){});

						//插入物理表
						dbExcutorUtil.addTableColumn(dbTable.getTableName(), entity);
					}
				}else{
					DbTableColDTO dbTableCol = (DbTableColDTO)m.get(item.get("colName"));
					//插入字段属性表
					EformTabColumnsDetail etcd=new EformTabColumnsDetail();
					etcd.setColumnId(dbTableCol.getId());
					etcd.setTabFormId(tabFormId);
					etcd.setColumnDetail(ObjectMapper.writeValueAsBytes(item));
					RestClient.doPost(coldetailURL, etcd, new GenericType<ResponseMsg<String>>(){});
				}
			}

		}catch (Exception e){
			e.printStackTrace();
		}
	}

	public String saveForm(DbTable ct,String eformFormInfoId, String tableCss,String tableJs,String tableContent,String langcode,String version,String style) throws Exception{
		EformTabForm entity=new EformTabForm();
		if (ct !=null) {
			entity.setFormName(ct.getId());
			entity.setTableId(ct.getId());
		}else{
			entity.setFormName("design");
			entity.setTableId("design");
		}
        //0自定义子表添加后已经存在实体表，所以此处修改为1数据源
        entity.setFormContent(tableContent.replaceAll("\"subTableType\":\"0\"", "\"subTableType\":\"1\"").getBytes(EformConstant.CHARSET));
		entity.setAttribute08(version);
		entity.setFormIsDefalt("Y");
		Map<String,String> domDefine = bpmsEditorUtils.DocumentToLayout(bpmsEditorUtils.StringToDocument(tableContent), langcode, false,style,eformFormInfoId,false);
		String formstr = domDefine.get("dom");
		String formScript = domDefine.get("script");
		entity.setFormLayout(formstr.getBytes(EformConstant.CHARSET));
		entity.setFormScript(formScript.getBytes(EformConstant.CHARSET));

        entity.setEformFormInfoId(eformFormInfoId);
        entity.setTableCss(tableCss);
        entity.setTableJs(tableJs);

		String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
		String tableURL = restHost + "/api/platform6/eform/cbbtabform/save/v1";
		ResponseMsg<String> doPost = RestClient.doPost(tableURL, entity, new GenericType<ResponseMsg<String>>(){});
		if(doPost.getRetCode().equals(ResponseStatus.HTTP_OK)){ //成功
			logger.debug("调用rest服务成功：" + tableURL);

		}else{ //失败
			logger.info("调用rest服务出错：:" + tableURL + "," + doPost.getRetCode()+","+doPost.getErrorDesc());
		}
		CacheHelper.getInstance().del("platform6:eform:formtabform:"+eformFormInfoId+":"+version);
		return doPost.getResponseBody();
	}

	public DbTable SaveTable(String tableName, String tableLabel, String dbTypeId,String datasourceId){
		DbTable rs = null;
		try{
			DbTable entity=new DbTable();
			entity.setTableType(dbTypeId);
			entity.setTableName(tableName);
			entity.setTableComments(tableLabel);
			entity.setTableIsCreated("Y");
			entity.setDataSourceId(datasourceId);
            entity.setDbType("1");//设置存储类型为表 modify 20190508

            Map<String, Object> insertDbTable = dbContrlUtil.insertDbTable(entity);
			String data = JsonHelper.getInstance().writeValueAsString(insertDbTable.get("data"));
			rs = JsonHelper.getInstance().readValue(data, DbTable.class) ;
		}catch(Exception e ){
			logger.error(e.getMessage());
			//dbContrlUtil.deleteDbTableBytableName(tableName);
		}
		return rs;
	}
	
	
	public void SaveSubColumns(HttpServletRequest request, DbTable ct, List<Map<String,Object>> list, String tabFormId){

		try{

			ObjectMapper ObjectMapper=new ObjectMapper();
			String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
			String coldetailURL = restHost + "/api/platform6/eform/coldetail/save/v1";

			for(Map<String,Object> item:list){

				if(item.get(ColProp.colName.getKey())!=null && !item.get(ColProp.colType.getKey()).equals("NOT_DB_COL_ELE")){
					DbTableColDTO entity = new  DbTableColDTO();
					if (item.containsKey(ColProp.colIsVir.getKey())){
						if ("Y".equals((String)item.get(ColProp.colIsVir.getKey()))){
							continue;
						}
					}
					entity.setTableId(ct.getId());
					entity.setColName(((String)item.get(ColProp.colName.getKey())).toUpperCase());
					entity.setColComments((String)item.get(ColProp.colLabel.getKey()));
					if(item.get(ColProp.colLength.getKey())!=null){
						entity.setColLength((String)item.get(ColProp.colLength.getKey()));
					}
					if(item.get(ColProp.attribute02.getKey())!=null){
						entity.setAttribute02((String)item.get(ColProp.attribute02.getKey()));
	                }

					entity.setColIsUnique((String)item.get(ColProp.colIsUnique.getKey()));
					String colType=(String)item.get(ColProp.colType.getKey());
//					if (item.containsKey("selectModel")) {
//						if ("single".equals(item.get("selectModel"))){
//							colType = "VARCHAR2";
//						}
//					}
					entity.setColType(colType);
					entity.setColNullable("Y");
					entity.setSysApplicationId(RestClientConfig.systemid);
					entity.setColIsPk("N");
					entity.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
					String colId = dbContrlUtil.insertColunms(entity);


					//插入字段属性表
					EformTabColumnsDetail etcd=new EformTabColumnsDetail();
					etcd.setColumnId(colId);
					etcd.setTabFormId(tabFormId);
					etcd.setColumnDetail(ObjectMapper.writeValueAsBytes(item));
					RestClient.doPost(coldetailURL, etcd, new GenericType<ResponseMsg<String>>(){});

			}
		}
			
			String key="platform6:eform:columnattr:"+ct.getId()+":"+tabFormId+":"+EformConstant.MAIN_DB;
			CacheHelper.getInstance().del(key);

	        List<DbTableColDTO> dbTableColDTOS = dbContrlUtil.setBaseCol(ct.getId(), SessionHelper.getCurrentOrgIdentity(request), true);
	        for (DbTableColDTO dbTableColDTO : dbTableColDTOS) {
	            dbContrlUtil.insertColunms(dbTableColDTO);
	        }

		}catch(Exception e){
			e.printStackTrace();
			deleteTable(ct.getId());
		}
	}
	
	public String SaveColumns(HttpServletRequest request, DbTable ct,
			Map<String, Object> map, String tabFormId) throws Exception{
			ObjectMapper ObjectMapper = new ObjectMapper();
			String restHost = RestClientConfig
					.getRestHost(RestClientConfig.eform);
			String coldetailURL = restHost + "/api/platform6/eform/coldetail/save/v1";
			for (Map.Entry<String, Object> entry : map.entrySet()) {
				//如果是主表字段

				Map<String, DbTableColDTO> columnsMap1 = new HashMap<String, DbTableColDTO>();

				if (entry.getKey().equals(EformConstant.MAIN_DB)){

					List<DbTableColDTO> dbTableColDTOS = dbContrlUtil.setBaseCol(
							ct.getId(),
							SessionHelper.getCurrentOrgIdentity(request), true);
					for (DbTableColDTO dbTableColDTO : dbTableColDTOS) {
						//dbContrlUtil.insertColunms(dbTableColDTO);
						columnsMap1.put(dbTableColDTO.getColName().toUpperCase(), dbTableColDTO);
					}

					List<Map<String, Object>> list = (List<Map<String, Object>>)entry.getValue();
					for (Map<String, Object> item : list) {
						if (item.get(ColProp.colName.getKey()) != null
								&& !item.get(ColProp.colType.getKey()).equals(
								"NOT_DB_COL_ELE")) {
							String colType = ((String) item.get(ColProp.colType.getKey())).toUpperCase();
							String colName = ((String) item.get(ColProp.colName.getKey())).toUpperCase();
							String allowType = "";
							if (item.containsKey("allowType")){
								allowType = ((String) item.get("allowType")).toUpperCase();
							}
							DbTableColDTO dbTableCol = columnsMap1.get(colName);

							if(dbTableCol !=null) { //已有字段（与默认字段重复）
								if (dbTableCol != null && !dbTableCol.getColType().toUpperCase().equals(colType)) {
									if (!allowType.contains(dbTableCol.getColType().toUpperCase())){ //字段类型不对
										return colName + "字段类型为" + dbTableCol.getColType().toUpperCase()+",而其所对应控件类型为"+colType+",两者不匹配";
									}
								}
								//更新重复的默认字段
								dbTableCol.setColName(((String)item.get(ColProp.colName.getKey())).toUpperCase());
								dbTableCol.setColComments((String)item.get(ColProp.colLabel.getKey()));
								if(item.get(ColProp.colLength.getKey())!=null){
									dbTableCol.setColLength((String)item.get(ColProp.colLength.getKey()));
								}
								if(item.get(ColProp.attribute02.getKey())!=null){
									dbTableCol.setAttribute02((String)item.get(ColProp.attribute02.getKey()));
								}
								dbTableCol.setColIsUnique((String)item.get(ColProp.colIsUnique.getKey()));
								dbTableCol.setSysApplicationId(RestClientConfig.systemid);
								dbTableCol.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));

							} else {//新字段
								DbTableColDTO entity = new DbTableColDTO();
								entity.setTableId(ct.getId());
								entity.setColName(((String) item.get(ColProp.colName
										.getKey())).toUpperCase());
								entity.setColComments((String) item
										.get(ColProp.colLabel.getKey()));
								if (item.get(ColProp.colLength.getKey()) != null) {
									entity.setColLength((String) item
											.get(ColProp.colLength.getKey()));
								}
								if (item.get(ColProp.attribute02.getKey()) != null) {
									entity.setAttribute02((String) item
											.get(ColProp.attribute02.getKey()));
								}

								entity.setColIsUnique((String) item
										.get(ColProp.colIsUnique.getKey()));
								String coltype = (String) item.get(ColProp.colType
										.getKey());
//								if (item.containsKey("selectModel")) {
//									if ("single".equals(item.get("selectModel"))){
//										coltype = "VARCHAR2";
//									}
//								}
								entity.setColType(coltype);
								entity.setColNullable("Y");
								entity.setSysApplicationId(RestClientConfig.systemid);
								entity.setColIsPk("N");
								entity.setOrgIdentity(SessionHelper
										.getCurrentOrgIdentity(request));
								String colId = dbContrlUtil.insertColunms(entity);

								// 插入字段属性表
								EformTabColumnsDetail etcd = new EformTabColumnsDetail();
								etcd.setColumnId(colId);
								etcd.setTabFormId(tabFormId);
								etcd.setColumnDetail(ObjectMapper
										.writeValueAsBytes(item));
								RestClient.doPost(coldetailURL, etcd,
										new GenericType<ResponseMsg<String>>() {
										});

							}
						}
					}
					String key="platform6:eform:columnattr:"+ct.getId()+":"+tabFormId+":"+EformConstant.MAIN_DB;
					CacheHelper.getInstance().del(key);

					//插入默认字段
					for (DbTableColDTO dbTableColDTO : dbTableColDTOS) {
						dbContrlUtil.insertColunms(dbTableColDTO);
					}
				}else{
					String tableId = entry.getKey();
					Map<String,Object> entryValue = (Map<String,Object>)entry.getValue();
					String dbid = (String)entryValue.get("dbid");
					List<DbTableColDTO> columnsBytableId = fcUtils.getColumnsBytableId(dbid);
			        Map<String, DbTableColDTO> columnsMap = new HashMap<String, DbTableColDTO>();
			        for (DbTableColDTO dbTableColDTO : columnsBytableId) {
			            columnsMap.put(dbTableColDTO.getColName().toUpperCase(), dbTableColDTO);
			        }
			        List<Map<String, Object>> list = (List<Map<String, Object>>)entryValue.get("domlist");
					for (Map<String, Object> item : list) {
						if (item.containsKey(ColProp.colName.getKey())&& item.get(ColProp.colName.getKey()) != null) {
							String colName = (String) item.get(ColProp.colName
									.getKey());
							// 插入字段属性表
							EformTabColumnsDetail etcd = new EformTabColumnsDetail();
							if (columnsMap.containsKey(colName)){
								etcd.setColumnId(columnsMap.get(colName).getId());
								etcd.setTabFormId(tabFormId);
								etcd.setColumnDetail(ObjectMapper
										.writeValueAsBytes(item));
								etcd.setLayoutTableId(tableId);
								RestClient.doPost(coldetailURL, etcd,
										new GenericType<ResponseMsg<String>>() {
										});
							}
						}
					}
					String key="platform6:eform:columnattr:"+dbid+":"+tabFormId+":"+tableId;
					CacheHelper.getInstance().del(key);
					
				}
				
			}
			return "1";

	}

	

	public void createTable(DbTable ct,String datasource){
		String id=ct.getId();
		try{
			List<DbTableColDTO> colunms = dbContrlUtil.getColunmsByTableId(id);
			Dbs.setDbType(datasource);
			dbExcutorUtil.createDbTable(ct.getTableName(), colunms);
			Dbs.clear();
		}catch(Exception e){
			dbContrlUtil.deleteDbTable(id);
			throw new RuntimeException(e.getMessage());
		}

	}


	public void SaveTableRelation(EformTableRelation entity){
		String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
		String restURL = restHost + "/api/platform6/eform/tablerelation/save/v1";
		ResponseMsg<Integer> responseMsg = RestClient.doPost(restURL, entity, new GenericType<ResponseMsg<Integer>>(){});
		if(responseMsg.getRetCode().equals(ResponseStatus.HTTP_OK)){ //成功
			logger.debug("调用rest服务成功：" + restURL);
		}else{ //失败
			logger.info("调用rest服务出错：:" + restURL + "," + responseMsg.getRetCode()+","+responseMsg.getErrorDesc());
		}
	}


	public void deleteTable(String id){
		String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
		String restURL = restHost + "/api/platform6/eform/tabledefine/delete/v1";
		ResponseMsg<Integer> responseMsg = RestClient.doPost(restURL, id, new GenericType<ResponseMsg<Integer>>(){});
		if(responseMsg.getRetCode().equals(ResponseStatus.HTTP_OK)){ //成功
				logger.debug("调用rest服务成功：" + restURL);
		}else{ //失败
				logger.info("调用rest服务出错：:" + restURL + "," + responseMsg.getRetCode()+","+responseMsg.getErrorDesc());
		}
	}

	
	private String saveDesignColumn(HttpServletRequest request, DbTable dbTable,Map<String,Object> map,String tabFormId,boolean isNew){
		//判断已有字段类型是否改变，如果改变则提示用户
		try{
			DbTable clone = new DbTable();
			fcUtils.deleteEformTabColumnsDetailByTabFormId(tabFormId);
			for (Map.Entry<String, Object> entry : map.entrySet()) {
				List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();//(List<Map<String,Object>>) entry.getValue();
				//html页面tableid
				String tableId = "";
				if (!entry.getKey().equals(EformConstant.MAIN_DB)){
					
					Map<String,Object> entryValue = (Map<String,Object>)entry.getValue();
					String dbid = (String)entryValue.get("dbid");
					clone = fcUtils.getTablesBytableId(dbid);
					list = (List<Map<String,Object>>)entryValue.get("domlist");
					tableId = entry.getKey();
				}else{
					clone = (DbTable)dbTable.clone();
					list = (List<Map<String,Object>>)entry.getValue();
				}
				String datasourceId = clone.getDataSourceId();
		        List<DbTableColDTO> columnsBytableId = fcUtils.getColumnsBytableId(clone.getId());
		        Map<String, DbTableColDTO> columnsMap = new HashMap<String, DbTableColDTO>();
		        for (DbTableColDTO dbTableColDTO : columnsBytableId) {
		            columnsMap.put(dbTableColDTO.getColName().toUpperCase(), dbTableColDTO);
		        }

				List<Map<String,Object>> redundanceList = new ArrayList<Map<String,Object>>();
		        for (Map<String, Object> stringObjectMap : list) {
		            //跳过子表控件
		            String subTableName = ((String) stringObjectMap.get("subTableName"));
		            if(subTableName != null) {
		                continue;
		            }
		
		            String colType = ((String) stringObjectMap.get(ColProp.colType.getKey())).toUpperCase();

		            if (colType.equals("NOT_DB_COL_ELE")) {
		                continue;
		            }
					String allowType = "";
					if (stringObjectMap.containsKey("allowType")){
						allowType = ((String) stringObjectMap.get("allowType")).toUpperCase();
					}
		            String colName = ((String) stringObjectMap.get(ColProp.colName.getKey())).toUpperCase();
		
		            DbTableColDTO dbTableCol = columnsMap.get(colName);
		            if (dbTableCol != null && !dbTableCol.getColType().toUpperCase().equals(colType)) {
		            	if (!allowType.contains(dbTableCol.getColType().toUpperCase())){
							return colName + "字段类型为" + dbTableCol.getColType().toUpperCase()+",而其所对应控件类型为"+colType+",两者不匹配";
						}
		            }

					if(stringObjectMap.get(ColProp.domType.getKey())!=null){
						//公共选择框冗余字段判断添加
						String colRuleName = ((String) stringObjectMap.get(ColProp.domType.getKey())).toUpperCase();
						if((String)stringObjectMap.get("redundance")!=null&&(("USER-BOX".equals(colRuleName)||"DEPT-BOX".equals(colRuleName)||"ORG-BOX".equals(colRuleName)||"ROLE-BOX".equals(colRuleName)||"GROUP-BOX".equals(colRuleName)||"POSITION-BOX".equals(colRuleName)))){
							if("Y".equals(((String) stringObjectMap.get("redundance")).toUpperCase())) {
								String redColName = ((String) stringObjectMap.get("redundanceColName")).toUpperCase();
								String redTableName = ((String) stringObjectMap.get("tableName")).toUpperCase();
								Map<String, Object> redMap = null;
								for (Map<String, Object> reStringObjectMap : list) {
									String reTableName = ((String) reStringObjectMap.get("tableName")).toUpperCase();
									String reColName = ((String) reStringObjectMap.get("colName")).toUpperCase();
									if(reTableName.equals(redTableName)&&reColName.equals(redColName)){
										redMap = reStringObjectMap;
										break;
									}
								}
								//冗余字段不为提交字段
								if (redMap == null) {
									DbTableColDTO reDbTableCol = columnsMap.get(redColName);
									//同时冗余字段不为已保存字段时添加新字段提交
									if (reDbTableCol == null) {
										redMap = new LinkedHashMap<String, Object>();
										redMap.putAll(stringObjectMap);
										redMap.put("colName", redColName);
										redMap.put("colLabel", redMap.get("colLabel") + "冗余");
										redundanceList.add(redMap);
									}
								}
							}
						}
					}
		        }
				list.addAll(redundanceList);

		        //维护db_table_col、eform_tab_columns_detail、db_table物理表
		        for (Map<String, Object> stringObjectMap : list) {
		            //跳过子表控件
		            String subTableName = ((String) stringObjectMap.get("subTableName"));
		            if(subTableName != null) {
		                continue;
		            }
		
		            String colType = ((String) stringObjectMap.get(ColProp.colType.getKey())).toUpperCase();
		            if (colType.equals("NOT_DB_COL_ELE")) {
		                continue;
		            }
		            String colName = ((String) stringObjectMap.get(ColProp.colName.getKey())).toUpperCase();
		
		            DbTableColDTO dbTableCol = columnsMap.get(colName);
		            String colId;
		            //已有字段
		            if (dbTableCol != null) {


						if (!isNew){//如果不是新建的设计
							//更新eform_tab_columns_detail
							ObjectMapper ObjectMapper=new ObjectMapper();
							String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
							EformTabColumnsDetail etcd = fcUtils.getColAttrByColIdAndTabFormId(dbTableCol.getId(), tabFormId,tableId);
							if (etcd == null) {
								String coldetailURL = restHost + "/api/platform6/eform/coldetail/save/v1";

								etcd = new EformTabColumnsDetail();
								etcd.setColumnId(dbTableCol.getId());
								etcd.setTabFormId(tabFormId);
								etcd.setLayoutTableId(tableId);
								etcd.setColumnDetail(ObjectMapper.writeValueAsBytes(stringObjectMap));
								RestClient.doPost(coldetailURL, etcd, new GenericType<ResponseMsg<String>>(){});
							}
							else {
								String coldetailURL = restHost + "/api/platform6/eform/coldetail/update/v1";

								etcd.setColumnDetail(ObjectMapper.writeValueAsBytes(stringObjectMap));
								RestClient.doPost(coldetailURL, etcd, new GenericType<ResponseMsg<String>>(){});
							}
						}

		            	if (!StringUtils.isEmpty(datasourceId) && !datasourceId.equals("dataSource")){
		            		continue;
		            	}
		                //更新db_table_col
		                DbTableColDTO dbTableCol_old = (DbTableColDTO) BeanUtils.cloneBean(dbTableCol);
						dbTableCol.setColName(((String)stringObjectMap.get(ColProp.colName.getKey())).toUpperCase());
		                dbTableCol.setColComments((String)stringObjectMap.get(ColProp.colLabel.getKey()));
		                if(stringObjectMap.get(ColProp.colLength.getKey())!=null){
		                    dbTableCol.setColLength((String)stringObjectMap.get(ColProp.colLength.getKey()));
		                }
		                if(stringObjectMap.get(ColProp.attribute02.getKey())!=null){
		                    dbTableCol.setAttribute02((String)stringObjectMap.get(ColProp.attribute02.getKey()));
		                }
		                dbTableCol.setColIsUnique((String)stringObjectMap.get(ColProp.colIsUnique.getKey()));
		                dbTableCol.setSysApplicationId(RestClientConfig.systemid);
		                dbTableCol.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
		                dbContrlUtil.updateColunms(dbTableCol);
		                colId = dbTableCol.getId();



		                try{
		                    //更新db_table物理表结构
		                	dbExcutorUtil.updateTableColumn(clone.getTableName(), dbTableCol_old, dbTableCol);
		                	
		                	
	/***动态数据源 可在外部库中修改字段 **/	  	              	
	//	                    if (!StringUtils.isEmpty(datasourceId) && !datasourceId.equals("dataSource")){
	//	                    	DataBase datasource = dataBaseService.getDataBase(datasourceId);
	//	                    	String driver = lookupAPI.getNameByLooupTypeCodeAndLooupCode("PLATFORM_DATASOURCE_DRIVER", datasource.getDriver());
	//	                    	if (StringUtils.isEmpty(driver)){
	//	                    		dbExcutorUtil.updateTableColumn(dbTable.getTableName(), dbTableCol_old, dbTableCol);
	//	                    	}else{
	//	                        	Dbs.setDbType(datasourceId);
	//	                        	dbExcutorUtil.updateTableColumn(dbTable.getTableName(), dbTableCol_old, dbTableCol,driver);
	//	                        	Dbs.clear();
	//	                    	}
	//	                    }else{
	//	                    	dbExcutorUtil.updateTableColumn(dbTable.getTableName(), dbTableCol_old, dbTableCol);
	//	                    }
		                }catch(Exception e){
		                	dbTableCol_old.setVersion(dbTableCol_old.getVersion()+1);
		                	dbContrlUtil.updateColunms(dbTableCol_old);
		                	logger.error(e.getMessage(),e);
		        			return "表单数据源不为数据库或连接失效，无法更新，详细错误："+e.getMessage();
		                }
		            }
		            //新增字段
		            else {
		            	
		            	
		            	
		                //新增db_table_col
		                ObjectMapper ObjectMapper=new ObjectMapper();
		
		                dbTableCol = new DbTableColDTO();
		                dbTableCol.setTableId(clone.getId());
						dbTableCol.setColName(((String)stringObjectMap.get(ColProp.colName.getKey())).toUpperCase());
		                
		                if (!StringUtils.isEmpty(datasourceId) && !datasourceId.equals("dataSource")){
		            		return "外部数据源无法增加字段"+dbTableCol.getColName();
		            	}
		                
		                dbTableCol.setColComments((String)stringObjectMap.get(ColProp.colLabel.getKey()));
		                if(stringObjectMap.get(ColProp.colLength.getKey())!=null){
		                    dbTableCol.setColLength((String)stringObjectMap.get(ColProp.colLength.getKey()));
		                }
		                if(stringObjectMap.get(ColProp.attribute02.getKey())!=null){
		                    dbTableCol.setAttribute02((String)stringObjectMap.get(ColProp.attribute02.getKey()));
		                }
		                dbTableCol.setColIsUnique((String)stringObjectMap.get(ColProp.colIsUnique.getKey()));
		                String coltype = (String)stringObjectMap.get(ColProp.colType.getKey());
//						if (stringObjectMap.containsKey("selectModel")) {
//							if ("single".equals(stringObjectMap.get("selectModel"))){
//								coltype = "VARCHAR2";
//							}
//						}
						dbTableCol.setColType(coltype);
		                dbTableCol.setColNullable("Y");
		                dbTableCol.setSysApplicationId(RestClientConfig.systemid);
		                dbTableCol.setColIsPk("N");
		                dbTableCol.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
		                colId = dbContrlUtil.insertColunms(dbTableCol);
		                if (!isNew){//如果不是新建的设计
			                //新增eform_tab_columns_detail
			                String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
			                String coldetailURL = restHost + "/api/platform6/eform/coldetail/save/v1";

			                EformTabColumnsDetail etcd=new EformTabColumnsDetail();
			                etcd.setColumnId(colId);
			                etcd.setLayoutTableId(tableId);
			                etcd.setTabFormId(tabFormId);
			                etcd.setColumnDetail(ObjectMapper.writeValueAsBytes(stringObjectMap));
			                RestClient.doPost(coldetailURL, etcd, new GenericType<ResponseMsg<String>>(){});
		                }
		              //新增db_table物理表结构
		                try{
		                    //更新db_table物理表结构
		                    String msg = "1";
		                    msg = dbExcutorUtil.addTableColumn(clone.getTableName(), dbTableCol);
	                    	if (!StringUtils.isEmpty(msg) && !"1".equals(msg)){
	                    		dbContrlUtil.deleteColunmsById(colId);
	                    		throw new RuntimeException(colName+"字段创建时发生错误："+msg);
	                    	}
		                    
	/***动态数据源 可在外部库中添加字段 **/	                    
	//	                    if (!StringUtils.isEmpty(datasourceId) && !datasourceId.equals("dataSource")){
	//	                    	DataBase datasource = dataBaseService.getDataBase(datasourceId);
	//	                    	String driver = lookupAPI.getNameByLooupTypeCodeAndLooupCode("PLATFORM_DATASOURCE_DRIVER", datasource.getDriver());
	//	                    	if (StringUtils.isEmpty(driver)){
	//	                    		dbExcutorUtil.addTableColumn(dbTable.getTableName(), dbTableCol);
	//	                    	}else{
	//	                        	Dbs.setDbType(datasourceId);
	//	                        	dbExcutorUtil.addTableColumn(dbTable.getTableName(), dbTableCol,driver);
	//	                        	Dbs.clear();
	//	                    	}
	//	                    }else{
	//	                    	msg = dbExcutorUtil.addTableColumn(dbTable.getTableName(), dbTableCol);
	//	                    	if (!StringUtils.isEmpty(msg) && !"1".equals(msg)){
	//	                    		dbContrlUtil.deleteColunmsById(colId);
	//	                    		throw new RuntimeException(colName+"字段创建时发生错误："+msg);
	//	                    	}
	//	                    }
		                }catch(Exception e){
		                	dbContrlUtil.deleteColunmsById(colId);
		                	logger.error(e.getMessage(),e);
		                	return "表单数据源不为数据库或连接失效，无法更新，详细错误："+e.getMessage();
		                }
		            }
		            if (isNew){
		            	//新增eform_tab_columns_detail
			            ObjectMapper ObjectMapper=new ObjectMapper();
			            String restHost = RestClientConfig.getRestHost(RestClientConfig.eform);
			            String coldetailURL = restHost + "/api/platform6/eform/coldetail/save/v1";
			
			            EformTabColumnsDetail etcd=new EformTabColumnsDetail();
			            etcd.setColumnId(colId);
			            etcd.setLayoutTableId(tableId);
			            etcd.setTabFormId(tabFormId);
			            etcd.setColumnDetail(ObjectMapper.writeValueAsBytes(stringObjectMap));
			            RestClient.doPost(coldetailURL, etcd, new GenericType<ResponseMsg<String>>(){});
		            }
		        }
		        if (StringUtils.isNotEmpty(tableId)){
			        String key="platform6:eform:columnattr:"+clone.getId()+":"+tabFormId+":"+tableId;
					CacheHelper.getInstance().del(key);
		        }else{
		        	String key="platform6:eform:columnattr:"+clone.getId()+":"+tabFormId+":"+EformConstant.MAIN_DB;
					CacheHelper.getInstance().del(key);
		        }
	        }
			
		}catch(Exception e){
			logger.error(e.getMessage(),e);
			return e.getMessage();
		}
        return "1";
	}


	@ResponseBody
	@RequestMapping(value="/getSysLookup",method ={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView getSysLookup(String lookupCode,@CookieValue(value=PlatformConstant.COOKIE_CURRENT_LANGUAGE_CODE,defaultValue=PlatformConstant.D_LANGUAGE) String langcode) throws Exception {
		ModelAndView mv = new ModelAndView();
		Collection<SysLookupSimpleVo> values = sysLookupAPI.getLookUpListByTypeByAppIdWithLg(lookupCode, RestClientConfig.systemid,langcode);
		mv.addObject("rows",values);
		return mv;
	}


	@ResponseBody
	@RequestMapping(value="/getOrgList",method ={RequestMethod.POST})
	public ModelAndView getOrgList(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<Map<String, String>> result = new ArrayList<Map<String, String>>();
		this.getOrgList(result);
		mv.addObject("data",result);
		return mv;
	}



	private void getOrgList(List<Map<String, String>> result) {
		List<SysOrg> allOrgs = sysOrgAPI.getAllSysOrgList();
		for (SysOrg org : allOrgs) {
			if (org.getValidFlag().equals("0")) {
				continue;
			}
			if ("Y".equals(org.getIsMulOrg())) {
				Map<String, String> torg = new HashMap<String, String>(2, 1);
				torg.put("id", org.getId());
				torg.put("name", sysOrgAPI.getSysOrgNameBySysOrgId(org.getId(), PlatformConstant.D_LANGUAGE));
				result.add(torg);
			}
		}
	}


}
