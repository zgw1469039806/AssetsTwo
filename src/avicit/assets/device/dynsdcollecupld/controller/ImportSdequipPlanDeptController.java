package avicit.assets.device.dynsdcollecupld.controller;

import avicit.assets.device.dynsdcollecmain.controller.DynSdCollecMainController;
import avicit.assets.device.dynsdcollecmain.dto.AssetsSdequipCollectCmDTO;
import avicit.assets.device.dynsdcollecmain.dto.AssetsSdequipCollectDTO;
import avicit.assets.device.dynsdcollecmain.service.AssetsSdequipCollectCmService;
import avicit.assets.device.dynsdcollecmain.service.AssetsSdequipCollectService;
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
@RequestMapping("assets/device/dynsdcollecupld/ImportSdequipPlanDeptController")
public class ImportSdequipPlanDeptController extends AbstractExcelImport {
    @Autowired
    private SysUserAPI sysUserAPI;
    private static final Logger logger = LoggerFactory.getLogger(DynSdCollecMainController.class);
    @Autowired
    private AssetsSdequipCollectService assetsSdequipCollectService;

    @RequestMapping({"importSdequipPlanDept"})
    @ResponseBody
    public Map<String,String> importSdequipPlan(HttpServletRequest request) throws Exception {
        Map<String, String> map = new HashMap(2);
        String datas = ServletRequestUtils.getStringParameter(request, "datas", "");
        final String extPara = ServletRequestUtils.getStringParameter(request, "extPara", "");
        final String extParaArray[] = extPara.split(";");

        Map<String, String> param = (Map)JsonHelper.getInstance().readValue(datas, new TypeReference<HashMap<String, String>>() {
        });
        SdequipPlanDeptExecuter sdequipPlanExecuter = new SdequipPlanDeptExecuter("年度设备计划导入");
        sdequipPlanExecuter.setImportOpt(new ImportOpt() {
            @Override
            public void import2Db(Map<String, Object> data) throws Exception {
                SysUserAPI sysUserLoader = (SysUserAPI)SpringFactory.getBean(SysUserAPI.class);
                SysDeptAPI sysDeptLoader = (SysDeptAPI)SpringFactory.getBean(SysDeptAPI.class);
                SysLookupAPI sysLookupLoader = (SysLookupAPI)SpringFactory.getBean(SysLookupAPI.class);
                SysUserDeptPositionAPI sysUserDeptPositionLoader = (SysUserDeptPositionAPI)SpringFactory.getBean(SysUserDeptPositionAPI.class);
                String wageNo = data.get("attribute02").toString();
                String userId = sysUserLoader.getSysUserByLoginName(wageNo).getId();
                String planBuyerName = sysUserLoader.getSysUserNameById(userId);
                String deptId = sysUserDeptPositionLoader.getChiefDeptIdBySysUserId(userId).toString();
                String deviceType = data.get("deviceType").toString();
                Collection<SysLookupSimpleVo> deviceCatCollect = sysLookupLoader.getLookUpListByType("DEVICE_TYPE");
                HashMap<String, String> deviceCatCollectMap = new LinkedHashMap<String, String>();
                for (SysLookupSimpleVo vo : deviceCatCollect) {
                   if(vo.getLookupName().equals(deviceType))
                   {
                       deviceType=vo.getLookupCode();
                       break;
                   }
                }
                data.put("xuhao", "");
                data.put("createdByPersion", userId);
                data.put("createdByDept", deptId);
                data.put("attribute02", data.get("attribute02").toString());
                data.put("deviceName", data.get("deviceName").toString());
                data.put("deviceType", deviceType);
                data.put("deviceSpec", data.get("deviceSpec").toString());
                data.put("deviceModel", data.get("deviceModel").toString());
                data.put("referencePlant", data.get("referencePlant").toString());
                data.put("deviceNum", data.get("deviceNum").toString());
                data.put("unitPrice", data.get("unitPrice").toString());
                data.put("totalPrice", data.get("totalPrice").toString());
                data.put("parentId", extParaArray[0]);
                data.put("attribute01", extParaArray[1]);
                String str = JsonHelper.getInstance().writeValueAsString(data);
                AssetsSdequipCollectDTO assetsSdequipCollectDTO =  (AssetsSdequipCollectDTO)JsonHelper.getInstance().readValue(str, AssetsSdequipCollectDTO.class);
                assetsSdequipCollectDTO.setId(ComUtil.getId());
                try {
                    assetsSdequipCollectService.insertAssetsSdequipCollect(assetsSdequipCollectDTO);
                }catch (Exception e){e.printStackTrace();}

            }
        });
        ExcelImport excelImport = new ExcelImport();
        excelImport.setExcutor(sdequipPlanExecuter);
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
