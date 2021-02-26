package avicit.assets.device.dynusdassetsntc.controller;
import avicit.assets.device.dynsdcollecmain.controller.DynSdCollecMainController;
import avicit.assets.device.dynusdassetsntc.dto.AssetsUstdCollectCmDTO;
import avicit.assets.device.dynusdassetsntc.service.AssetsUstdCollectCmService;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syslookup.SysLookupAPI;
import avicit.platform6.api.syslookup.dto.SysLookupSimpleVo;
import avicit.platform6.api.sysuser.SysDeptAPI;
import avicit.platform6.api.sysuser.SysUserAPI;
import avicit.platform6.api.sysuser.SysUserDeptPositionAPI;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.excel.imp.ExcelImport;
import avicit.platform6.core.excel.imp.inf.ImportOpt;
import avicit.platform6.core.spring.SpringFactory;
import avicit.platform6.modules.system.excelimport.orguser.AbstractExcelImport;
import com.fasterxml.jackson.core.type.TypeReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-28 18:57
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/dynusdassetsntc/controller/ImportUsdequipPlanController")
public class ImportUsdequipPlanController extends AbstractExcelImport {
    @Autowired
    private SysUserAPI sysUserAPI;
    private static final Logger logger = LoggerFactory.getLogger(DynSdCollecMainController.class);
    @Autowired
    private AssetsUstdCollectCmService assetsUstdCollectCmService;

    @RequestMapping({"importUsdequipPlan"})
    @ResponseBody
    public Map<String,String> importSdequipPlan(HttpServletRequest request) throws Exception {
        Map<String, String> map = new HashMap(2);
        String datas = ServletRequestUtils.getStringParameter(request, "datas", "");
        final String extPara = ServletRequestUtils.getStringParameter(request, "extPara", "");

        Map<String, String> param = (Map) JsonHelper.getInstance().readValue(datas, new TypeReference<HashMap<String, String>>() {
        });
        UsdequipPlanExecuter usdequipPlanExecuter = new UsdequipPlanExecuter("年度设备计划导入");
        usdequipPlanExecuter.setImportOpt(new ImportOpt() {
            @Override
            public void import2Db(Map<String, Object> data) throws Exception {
                System.err.println("%%%%%%%%%%%%%%%%%%%%%%%%%%111111111111%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                SysUserAPI sysUserLoader = (SysUserAPI) SpringFactory.getBean(SysUserAPI.class);
                SysDeptAPI sysDeptLoader = (SysDeptAPI) SpringFactory.getBean(SysDeptAPI.class);
                SysLookupAPI sysLookupLoader = (SysLookupAPI) SpringFactory.getBean(SysLookupAPI.class);
                SysUserDeptPositionAPI sysUserDeptPositionLoader = (SysUserDeptPositionAPI) SpringFactory.getBean(SysUserDeptPositionAPI.class);
                System.err.println("%%%%%%%%%%%%%%%%%%%%%%%%%%222222%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                String wageNo = data.get("attribute02").toString();

                String userId = sysUserLoader.getSysUserByLoginName(wageNo).getId();
                String deptId = sysUserDeptPositionLoader.getChiefDeptIdBySysUserId(userId).toString();

                String deviceCategory = data.get("deviceCategoryCm").toString();
                System.err.println("%%%%%%%%%%%%%%%%%%%%%%%%%%3333333%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                Collection<SysLookupSimpleVo> deviceCatCollect = sysLookupLoader.getLookUpListByType("DEVICE_CATEGORY");
                HashMap<String, String> deviceCatCollectMap = new LinkedHashMap<String, String>();

                for (SysLookupSimpleVo vo : deviceCatCollect) {
                    if (vo.getLookupName().equals(deviceCategory)) {
                        deviceCategory = vo.getLookupCode();
                        break;
                    }
                }
                System.err.println("%%%%%%%%%%%%%%%%%%%%%%%%%%"+data+"%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                String financialResourcesName = data.get("financialResourcesCm").toString();
                System.err.println("%%%%%%%%%%%%%%%%%%%%%%%%%%555555555%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                Collection<SysLookupSimpleVo> financialResourcesNameCol = sysLookupLoader.getLookUpListByType("FINANCIAL_RESOURCES");
                HashMap<String, String> financialResourcesNameMap = new LinkedHashMap<String, String>();
                for (SysLookupSimpleVo vo : financialResourcesNameCol) {
                    if (vo.getLookupName().equals(financialResourcesName)) {
                        financialResourcesName = vo.getLookupCode();
                        break;
                    }
                }

                data.put("xuhao", "");
                data.put("attribute05", userId);
                data.put("createdByDept", deptId);

                //data.put("createdByPersionAlias", data.get("createdByPersionAlias").toString());
                // data.put("createdByDeptAlias", data.get("createdByDeptAlias").toString());
                data.put("attribute02", data.get("attribute02").toString());
                data.put("deviceNameCm", data.get("deviceNameCm").toString());
                data.put("belongProjectCm", data.get("belongProjectCm").toString());
                data.put("financialEstimateCm", data.get("financialEstimateCm").toString());
                data.put("replyNameCm", data.get("replyNameCm").toString());
                data.put("approvalFormNumberCm", data.get("approvalFormNumberCm").toString());
                data.put("deviceCategoryCm", deviceCategory);
                data.put("financialResourcesCm", financialResourcesName);
                data.put("headerIdCm", extPara);
                String str = JsonHelper.getInstance().writeValueAsString(data);
                AssetsUstdCollectCmDTO assetsUstdCollectCmDTO = (AssetsUstdCollectCmDTO) JsonHelper.getInstance().readValue(str, AssetsUstdCollectCmDTO.class);
                assetsUstdCollectCmDTO.setId(ComUtil.getId());
                try {
                    assetsUstdCollectCmService.insertAssetsUstdCollectCm(assetsUstdCollectCmDTO);
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
        });
        ExcelImport excelImport = new ExcelImport();
        excelImport.setExcutor(usdequipPlanExecuter);
        excelImport.setInfo(param);
        long beginTIme = System.currentTimeMillis();
        excelImport.importExcel();
        super.generate2Db(excelImport.getResult(), SessionHelper.getApplicationId(), SessionHelper.getSystemDefaultLanguageCode(), SessionHelper.getLoginName(request));
        this.logger.info("导入Excel耗费时间:" + (System.currentTimeMillis() - beginTIme) + " ms");
        map.put("flag", "success");
        map.put("msg", excelImport.getResult().getMessage());
        return map;
    }


}
