package avicit.assets.device.assetsdevicemetering.schedule;

import avicit.assets.device.assetsdeviceaccount.dao.AssetsDeviceAccountDao;
import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsdevicemetering.dto.AssetsDeviceMeteringDTO;
import avicit.assets.device.assetsdevicemetering.service.AssetsDeviceMeteringService;
import avicit.platform6.api.application.SysApplicationAPI;
import avicit.platform6.api.syslookup.SysLookupAPI;
import avicit.platform6.api.sysuser.SysDeptAPI;
import avicit.platform6.api.sysuser.SysUserAPI;
import avicit.platform6.api.sysuser.SysUserDeptPositionAPI;
import avicit.platform6.api.sysuser.dto.SysDept;
import avicit.platform6.bpmclient.bpm.service.BpmDisplayService;
import avicit.platform6.bpmclient.bpm.service.BpmOperateService;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.spring.SpringFactory;
import com.fasterxml.jackson.core.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;


public class MeteringTask {

    SysUserAPI sysUserLoader = (SysUserAPI)SpringFactory.getBean(SysUserAPI.class);
    SysUserDeptPositionAPI sysUserDeptPositionLoader = (SysUserDeptPositionAPI)SpringFactory.getBean(SysUserDeptPositionAPI.class);
    SysDeptAPI sysDeptLoader = (SysDeptAPI)SpringFactory.getBean(SysDeptAPI.class);
    BpmOperateService bpmOperateService = SpringFactory.getBean(BpmOperateService.class);
    AssetsDeviceMeteringService meteringService = SpringFactory.getBean("assetsDeviceMeteringService");

    private long getDateInterval(Date currentDate, Date nextMeteringDate) {
        long dateInterval = (nextMeteringDate.getTime() - currentDate.getTime()) / (60 * 60 * 24 * 1000);
        return dateInterval;
    }

    /* 计算 当前时间+计量提醒时间 = 计量提醒边界时间 */
    private Date calcDate(Date currentDate, int meteringRemindDay) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(currentDate);
        cal.add(Calendar.DATE, meteringRemindDay);

        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
        String TimeString = sdf.format(cal.getTime());
        System.out.println(TimeString);

        return cal.getTime();
    }

    public void forkMeteringTask(AssetsDeviceAccountDTO accountDTO) throws Exception {

        Map<String, Object> variables = new HashMap<String, Object>();
        String processDefId = ""; // 流程模板ID
        String formCode = "deviceMetering1"; //流程FORMCODE
        String userId = "";

        String meteringMode = accountDTO.getIsSceneMetering();
        if("1".equals(meteringMode)|| "2".equals(meteringMode)){ // 现场：直接派生给计量员
            processDefId = "402880f97471b9950174720a4b35203f-1";  // 计量流程: 计量员发起 模板ID
            userId = accountDTO.getMeterman(); // 获取台账中计量员ID
            if("".equals(userId) || userId == null){
                return;
            }
        }else if ("3".equals(meteringMode)|| "4".equals(meteringMode) || "5".equals(meteringMode)){ // 实验室,外送：派生给计量计划员
            processDefId = "4028808e745cd8f601745d0aace80dba-1"; // 计量流程: 计量计划员发起 模板ID
            userId = accountDTO.getPlanMeterman(); // 获取台账中计量计划员ID
            if("".equals(userId) || userId == null){
                return;
            }
        }else{
            return;
        }
        System.out.println("--->"+accountDTO.getUnifiedId()+"派生计量流程");

        SysDept sysDept = sysUserDeptPositionLoader.getChiefDeptBySysUserId(userId);

        AssetsDeviceMeteringDTO bean = new AssetsDeviceMeteringDTO();
        bean.setUnifiedId(accountDTO.getUnifiedId());  // 资产编号
        bean.setDeviceName(accountDTO.getDeviceName()); //资产名称
        bean.setDeviceCategory(accountDTO.getDeviceCategory()); //资产类别
        bean.setDeviceModel(accountDTO.getDeviceModel()); //资产型号
        bean.setDeviceSpec(accountDTO.getDeviceSpec()); //资产规格
        bean.setPositionId(accountDTO.getPositionId()); // 安装地点
        bean.setSecretLevel(accountDTO.getSecretLevel()); // 密集
        bean.setManufacturer(accountDTO.getMeteringDept()); // 生产厂家
        bean.setMeterMode(accountDTO.getIsSceneMetering()); // 计量方式
        bean.setMeterPlanPerson(accountDTO.getPlanMeterman()); // 计量计划员
        bean.setMeterPlanPersonAlias(accountDTO.getPlanMetermanAlias());
        bean.setMeterPersonAlias(accountDTO.getMetermanAlias());
        bean.setMeterPerson(accountDTO.getMeterman()); // 计量员
        bean.setLastMeteringDate(accountDTO.getLastMeteringDate());
        bean.setMeterCycle(accountDTO.getMeteringCycle());
        bean.setIsMetering(accountDTO.getIsMetering());
        bean.setOwnerId(accountDTO.getOwnerId());
        bean.setOwnerIdAlias(accountDTO.getOwnerIdAlias());
        bean.setOwnerDept(accountDTO.getOwnerDept());
        bean.setOwnerDeptAlias(accountDTO.getOwnerDeptAlias());

        bean.setApplicantId(userId);
        bean.setApplicantIdAlias(sysUserLoader.getSysUserNameById(userId));
        bean.setApplicantDepart(sysDept.getId());
        bean.setApplicantDepartAlias(sysDept.getDeptName());

        bean.setCreatedBy(userId);
        bean.setCreationDate(new Date());
        bean.setLastUpdateDate(new Date());
        bean.setLastUpdatedBy(userId);
        bean.setLastUpdateIp("127.0.0.1");
        bean.setVersion(Long.valueOf(0));

        bean.setIsDeliveryAllowed("N");
        bean.setMeterConclusion("4");
        bean.setIsDeriveOftName("N");
        bean.setFormCheckConclude("N");
        bean.setManagerConclude("N");

        meteringService.insertAssetsDeviceMetering(bean);

        //把表单对象转换成map,传递给流程变量
        Map<String, Object> pojoMap = (Map<String, Object>) PojoUtil.toMap(bean);
        variables.putAll(pojoMap);
        String processInstanceId = bpmOperateService.startProcessInstanceById(processDefId, formCode, userId, sysDept.getId(), variables);
    }


    public void checkAccountItem() {

        System.out.println("****timing task*****");


        /* 从通用代码中 */
        SysLookupAPI sysLookup = SpringFactory.getBean("sysLookupAPI");
        SysApplicationAPI sysApplicationAPI = SpringFactory.getBean("sysApplicationAPI");
        String dayStr = sysLookup.getNameByLooupTypeCodeAndLooupCodeByAppId("METERING_REMIND_INTERVAL", "day", sysApplicationAPI.getCurrentAppId());
        int remindInterval = Integer.parseInt(dayStr); // 获取通用代码中计量提醒时间
        String pageSizeStr = sysLookup.getNameByLooupTypeCodeAndLooupCodeByAppId("METERING_TIMING_TASK_PAGE_SIZE", "PageSize", sysApplicationAPI.getCurrentAppId());
        int pageSize = Integer.parseInt(pageSizeStr);
        System.out.println("通用代码中PageSize: " + pageSize);
        System.out.println("通用代码中remindInterval: " + remindInterval);

        QueryRespBean<AssetsDeviceAccountDTO> result = null;
        AssetsDeviceAccountService assetsDeviceAccountService = SpringFactory.getBean(AssetsDeviceAccountService.class);
        QueryReqBean<AssetsDeviceAccountDTO> queryReqBean = new QueryReqBean<AssetsDeviceAccountDTO>();
        PageParameter pageParameter = new PageParameter();
        AssetsDeviceAccountDTO searchParams = new AssetsDeviceAccountDTO();
        Date currentDate = new Date();   //当前日期

        searchParams.setIsMetering("Y"); // 只查询台账中是否计量字段为“是”
        //Date nextMeteringDate = calcDate(currentDate, remindInterval);
        //searchParams.setNextMeteringDateEnd(nextMeteringDate); // 查询台账中下次计量时间小于计量提醒边界时间

        pageParameter.setRows(pageSize); // 设置每页数据个数
        queryReqBean.setSearchParams(searchParams);
        Date nextMeteringDate = null;
        int currentPage = 1;

        while (true) {
            pageParameter.setPage(currentPage); // 设置当前页
            System.out.println("currentPage: " + currentPage);
            queryReqBean.setPageParameter(pageParameter);
            try {
                result = assetsDeviceAccountService.searchAssetsDeviceAccountByPage(queryReqBean, "");
                long totalPage = result.getPageParameter().getTotalPage(); // 获取总页数
                System.out.println("totalPage: " + totalPage);
                if (currentPage > totalPage) { // 如果当前页大于总页数，退出定时任务
                    break;
                }
                System.out.println("size of result: " + result.getResult().size());
                for (AssetsDeviceAccountDTO dto : result.getResult()) {
//                    String id = dto.getUnifiedId();
//                    System.out.println(id);
                    nextMeteringDate = dto.getNextMeteringDate();
                    if (nextMeteringDate != null) {
                        long dateInterval = (nextMeteringDate.getTime() - currentDate.getTime()) / (60 * 60 * 24 * 1000);
                        if (dateInterval == remindInterval) {
                            forkMeteringTask(dto);
                        }
                    }
                }
                currentPage++;
            } catch(Exception e){
                e.printStackTrace();
            }
        }
    }
}